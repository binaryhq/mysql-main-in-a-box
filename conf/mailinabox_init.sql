--
-- Table structure for table `aliases`
--

CREATE TABLE `aliases` (
  `id` int(11) NOT NULL,
  `source` varchar(100) NOT NULL,
  `destination` varchar(100) NOT NULL,
  `permitted_senders` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Table structure for table `anyone_shares`
--

CREATE TABLE `anyone_shares` (
  `id` int(11) NOT NULL,
  `from_user` varchar(100) NOT NULL,
  `dummy` char(1) DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


--
-- Table structure for table `auto_aliases`
--

CREATE TABLE `auto_aliases` (
  `id` int(11) NOT NULL,
  `source` text NOT NULL,
  `destination` text NOT NULL,
  `permitted_senders` text
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


--
-- Table structure for table `mfa`
--

CREATE TABLE `mfa` (
  `id` int(11) NOT NULL,
  `user_id` int(64) NOT NULL,
  `type` text NOT NULL,
  `secret` text NOT NULL,
  `mru_token` text NOT NULL,
  `label` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;


--
-- Table structure for table `shared_mailbox`
--

CREATE TABLE `shared_mailbox` (
  `id` int(11) NOT NULL,
  `from_user` varchar(255) NOT NULL,
  `to_user` varchar(255) NOT NULL,
  `dummy` int(1) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `password` varchar(255) NOT NULL,
  `email` varchar(100) NOT NULL,
  `extra` varchar(50) DEFAULT NULL,
  `privileges` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


--
-- Indexes for table `aliases`
--
ALTER TABLE `aliases`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `source` (`source`);

--
-- Indexes for table `anyone_shares`
--
ALTER TABLE `anyone_shares`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `from_user` (`from_user`,`dummy`);

--
-- Indexes for table `auto_aliases`
--
ALTER TABLE `auto_aliases`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `mfa`
--
ALTER TABLE `mfa`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `shared_mailbox`
--
ALTER TABLE `shared_mailbox`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `from_user` (`from_user`,`to_user`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `aliases`
--
ALTER TABLE `aliases`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT for table `anyone_shares`
--
ALTER TABLE `anyone_shares`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `auto_aliases`
--
ALTER TABLE `auto_aliases`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `mfa`
--
ALTER TABLE `mfa`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `shared_mailbox`
--
ALTER TABLE `shared_mailbox`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
