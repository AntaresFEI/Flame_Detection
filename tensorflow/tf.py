import tensorflow as tf
import numpy as np
from tensorflow.examples.tutorials.mnist import input_data


# mnist = input_data.read_data_sets('MNIST_data', one_hot=True)


def weight_variable(shape):
    initial = tf.truncated_normal(shape, stddev=0.1)
    return tf.Variable(initial)


def bias_variable(shape):
    initial = tf.constant(0.1, shape=shape)
    return tf.Variable(initial)


def conv2d(x, W):
    return tf.nn.conv2d(x, W, strides=[1, 1, 1, 1], padding='VALID')  # padding='VALID'/'SAME'


def max_pool_2x2(x):
    return tf.nn.max_pool(x, ksize=[1, 2, 2, 1],
                          strides=[1, 2, 2, 1], padding='SAME')  # padding='VALID'/'SAME'


x = tf.placeholder("float", shape=[None, 48 * 48])
y_ = tf.placeholder("float", shape=[None, 2])

W = tf.Variable(tf.zeros([48 * 48, 2]))
b = tf.Variable(tf.zeros([2]))

x_image = tf.reshape(x, [-1, 48, 48, 1])

W_conv1 = weight_variable([5, 5, 1, 8])
b_conv1 = bias_variable([8])

h_conv1 = tf.nn.relu(conv2d(x_image, W_conv1) + b_conv1)
h_pool1 = max_pool_2x2(h_conv1)

W_conv2 = weight_variable([5, 5, 8, 16])
b_conv2 = bias_variable([16])

h_conv2 = tf.nn.relu(conv2d(h_pool1, W_conv2) + b_conv2)
h_pool2 = max_pool_2x2(h_conv2)

W_fc1 = weight_variable([9 * 9 * 16, 128])
b_fc1 = bias_variable([128])

h_pool2_flat = tf.reshape(h_pool2, [-1, 9 * 9 * 16])
h_fc1 = tf.nn.relu(tf.matmul(h_pool2_flat, W_fc1) + b_fc1)

keep_prob = tf.placeholder("float")
h_fc1_drop = tf.nn.dropout(h_fc1, keep_prob)

W_fc2 = weight_variable([128, 2])
b_fc2 = bias_variable([2])

y_conv = tf.nn.softmax(tf.matmul(h_fc1_drop, W_fc2) + b_fc2)

cross_entropy = -tf.reduce_sum(y_ * tf.log(y_conv))
train_step = tf.train.AdamOptimizer(1e-3).minimize(cross_entropy)
correct_prediction = tf.equal(tf.argmax(y_conv, 1), tf.argmax(y_, 1))
accuracy = tf.reduce_mean(tf.cast(correct_prediction, "float"))
# train_x = mnist.train.images
# train_y = mnist.train.labels
# test_x = mnist.test.images
# test_y = mnist.test.labels
train_x = np.loadtxt('train_x.txt')
train_y = np.loadtxt('train_y.txt')
test_x = np.loadtxt('test_x.txt')
test_y = np.loadtxt('test_y.txt')
with tf.Session() as sess:
    sess.run(tf.initialize_all_variables())
    for epoch in range(51):
        # for batch in range(n_batch):
        #     batch_xs, batch_ys = mnist.train.next_batch(n_batch)
        #     sess.run(train_step, feed_dict={x: batch_xs, y_: batch_ys, keep_prob: 0.7})
        sess.run(train_step, feed_dict={x: train_x, y_: train_y, keep_prob: 0.7})
        acc = sess.run(accuracy, feed_dict={x: test_x, y_: test_y, keep_prob: 1.0})
        print("epoch " + str(epoch) + ": " + str(acc))
