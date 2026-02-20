Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4234F366553
	for <bpf@vger.kernel.org>; Fri, 20 Feb 2026 18:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771611637; cv=none; b=tqY8GvsilVBUwlPwm/IbAzOvl+ba+8/zpUk0VEcw/H5zUOkzK/jOqqVXtzhnnj3qPXPcjRVCBaPrC718+dbON/r1374hEKBBC8kQ+wkjSndpoPk048AiB6c9lUIwxz3hBz776lxmlkZYe1nLfG9BoRerw7pm/O8vEAfb0Oe/QT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771611637; c=relaxed/simple;
	bh=rOkYQyeTp9C2B/H3fq0Y5U90qTgsVE1nysYk2iavar4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oSs7dthqQuPmfPzO+XyafHMTl0/YKIVXFanE/EKw+u3upWLOP4u0yUQ5C9bpeXYAEMR92JpgR2j068yRIxm7jYHLkH1BdbyRnBxCtA9PGubqjGyd8TI8JvxtkP7D2Qy8i/CyeIkVCEEa8AGh1jtJQW1o3IC0XENW8i6qD8yMKXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WE5EzMzj; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WE5EzMzj"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1771611634;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WekUd+xrCB+1XCjrrsvI/+QNkM6JaxitZ3Psn1wFge0=;
	b=WE5EzMzjh/lL/ObpjLG7JHTEkjw516wHVXpp3zSvJ1yxvrpbHSa/EGUwp28Q97AkDWoyoD
	K9hqka2lMrugrAW5JqkPdt9ViZzGaxwW9YfPVsnSPQacE9itZuGSstr0Z53B9GGlwKjy6x
	9n0FRE7BgsWKCWh9u/PekcrRsD5xHB8=
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH bpf v1 4/7] selftests/bpf: Replace strncpy() with strscpy()
Date: Fri, 20 Feb 2026 10:20:08 -0800
Message-ID: <20260220182011.802116-5-ihor.solodrai@linux.dev>
In-Reply-To: <20260220182011.802116-1-ihor.solodrai@linux.dev>
References: <20260220182011.802116-1-ihor.solodrai@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

strncpy() does not guarantee NUL-termination and is considered
deprecated [1]. Replace strncpy() calls with strscpy().

[1] https://docs.kernel.org/process/deprecated.html#strncpy-on-nul-terminated-strings

Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 tools/testing/selftests/bpf/network_helpers.c             | 3 +--
 tools/testing/selftests/bpf/prog_tests/align.c            | 2 +-
 tools/testing/selftests/bpf/prog_tests/bpf_iter.c         | 3 +--
 tools/testing/selftests/bpf/prog_tests/flow_dissector.c   | 4 ++--
 tools/testing/selftests/bpf/prog_tests/queue_stack_map.c  | 4 ++--
 tools/testing/selftests/bpf/prog_tests/skc_to_unix_sock.c | 2 +-
 tools/testing/selftests/bpf/prog_tests/task_local_data.h  | 2 +-
 tools/testing/selftests/bpf/prog_tests/tc_redirect.c      | 2 +-
 tools/testing/selftests/bpf/test_progs.c                  | 2 +-
 tools/testing/selftests/bpf/xdp_hw_metadata.c             | 4 ++--
 10 files changed, 13 insertions(+), 15 deletions(-)

diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testing/selftests/bpf/network_helpers.c
index 5374b7e16d53..e169c6ece524 100644
--- a/tools/testing/selftests/bpf/network_helpers.c
+++ b/tools/testing/selftests/bpf/network_helpers.c
@@ -581,8 +581,7 @@ int open_tuntap(const char *dev_name, bool need_mac)
 		return -1;
 
 	ifr.ifr_flags = IFF_NO_PI | (need_mac ? IFF_TAP : IFF_TUN);
-	strncpy(ifr.ifr_name, dev_name, IFNAMSIZ - 1);
-	ifr.ifr_name[IFNAMSIZ - 1] = '\0';
+	strscpy(ifr.ifr_name, dev_name, sizeof(ifr.ifr_name));
 
 	err = ioctl(fd, TUNSETIFF, &ifr);
 	if (!ASSERT_OK(err, "ioctl(TUNSETIFF)")) {
diff --git a/tools/testing/selftests/bpf/prog_tests/align.c b/tools/testing/selftests/bpf/prog_tests/align.c
index 24c509ce4e5b..7b6e530a586c 100644
--- a/tools/testing/selftests/bpf/prog_tests/align.c
+++ b/tools/testing/selftests/bpf/prog_tests/align.c
@@ -633,7 +633,7 @@ static int do_test_single(struct bpf_align_test *test)
 	} else {
 		ret = 0;
 		/* We make a local copy so that we can strtok() it */
-		strncpy(bpf_vlog_copy, bpf_vlog, sizeof(bpf_vlog_copy));
+		strscpy(bpf_vlog_copy, bpf_vlog, sizeof(bpf_vlog_copy));
 		start = strstr(bpf_vlog_copy, main_pass_start);
 		if (!start) {
 			ret = 1;
diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c b/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
index 5225d69bf79b..c69080ca14f5 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
@@ -346,8 +346,7 @@ static void test_task_sleepable(void)
 		close(finish_pipe[1]);
 
 		test_data = malloc(sizeof(char) * 10);
-		strncpy(test_data, "test_data", 10);
-		test_data[9] = '\0';
+		strscpy(test_data, "test_data", 10);
 
 		test_data_long = malloc(sizeof(char) * 5000);
 		for (int i = 0; i < 5000; ++i) {
diff --git a/tools/testing/selftests/bpf/prog_tests/flow_dissector.c b/tools/testing/selftests/bpf/prog_tests/flow_dissector.c
index 08bae13248c4..22dbd13cf592 100644
--- a/tools/testing/selftests/bpf/prog_tests/flow_dissector.c
+++ b/tools/testing/selftests/bpf/prog_tests/flow_dissector.c
@@ -570,7 +570,7 @@ static int create_tap(const char *ifname)
 	};
 	int fd, ret;
 
-	strncpy(ifr.ifr_name, ifname, sizeof(ifr.ifr_name));
+	strscpy(ifr.ifr_name, ifname, sizeof(ifr.ifr_name));
 
 	fd = open("/dev/net/tun", O_RDWR);
 	if (fd < 0)
@@ -599,7 +599,7 @@ static int ifup(const char *ifname)
 	struct ifreq ifr = {};
 	int sk, ret;
 
-	strncpy(ifr.ifr_name, ifname, sizeof(ifr.ifr_name));
+	strscpy(ifr.ifr_name, ifname, sizeof(ifr.ifr_name));
 
 	sk = socket(PF_INET, SOCK_DGRAM, 0);
 	if (sk < 0)
diff --git a/tools/testing/selftests/bpf/prog_tests/queue_stack_map.c b/tools/testing/selftests/bpf/prog_tests/queue_stack_map.c
index a043af9cd6d9..a3c6acc33d5d 100644
--- a/tools/testing/selftests/bpf/prog_tests/queue_stack_map.c
+++ b/tools/testing/selftests/bpf/prog_tests/queue_stack_map.c
@@ -28,9 +28,9 @@ static void test_queue_stack_map_by_type(int type)
 		vals[i] = rand();
 
 	if (type == QUEUE)
-		strncpy(file, "./test_queue_map.bpf.o", sizeof(file));
+		strscpy(file, "./test_queue_map.bpf.o", sizeof(file));
 	else if (type == STACK)
-		strncpy(file, "./test_stack_map.bpf.o", sizeof(file));
+		strscpy(file, "./test_stack_map.bpf.o", sizeof(file));
 	else
 		return;
 
diff --git a/tools/testing/selftests/bpf/prog_tests/skc_to_unix_sock.c b/tools/testing/selftests/bpf/prog_tests/skc_to_unix_sock.c
index 3eefdfed1db9..74f6d7404d1b 100644
--- a/tools/testing/selftests/bpf/prog_tests/skc_to_unix_sock.c
+++ b/tools/testing/selftests/bpf/prog_tests/skc_to_unix_sock.c
@@ -34,7 +34,7 @@ void test_skc_to_unix_sock(void)
 
 	memset(&sockaddr, 0, sizeof(sockaddr));
 	sockaddr.sun_family = AF_UNIX;
-	strncpy(sockaddr.sun_path, sock_path, strlen(sock_path));
+	strscpy(sockaddr.sun_path, sock_path, sizeof(sockaddr.sun_path));
 	sockaddr.sun_path[0] = '\0';
 
 	err = bind(sockfd, (struct sockaddr *)&sockaddr, sizeof(sockaddr));
diff --git a/tools/testing/selftests/bpf/prog_tests/task_local_data.h b/tools/testing/selftests/bpf/prog_tests/task_local_data.h
index 0f86b9275cf9..26e6218a2dd6 100644
--- a/tools/testing/selftests/bpf/prog_tests/task_local_data.h
+++ b/tools/testing/selftests/bpf/prog_tests/task_local_data.h
@@ -262,7 +262,7 @@ static tld_key_t __tld_create_key(const char *name, size_t size, bool dyn_data)
 		if (!atomic_compare_exchange_strong(&tld_meta_p->cnt, &cnt, cnt + 1))
 			goto retry;
 
-		strncpy(tld_meta_p->metadata[i].name, name, TLD_NAME_LEN);
+		strscpy(tld_meta_p->metadata[i].name, name, TLD_NAME_LEN);
 		atomic_store(&tld_meta_p->metadata[i].size, size);
 		return (tld_key_t){(__s16)off};
 	}
diff --git a/tools/testing/selftests/bpf/prog_tests/tc_redirect.c b/tools/testing/selftests/bpf/prog_tests/tc_redirect.c
index 76d72a59365e..bd0010e5364f 100644
--- a/tools/testing/selftests/bpf/prog_tests/tc_redirect.c
+++ b/tools/testing/selftests/bpf/prog_tests/tc_redirect.c
@@ -1095,7 +1095,7 @@ static int tun_open(char *name)
 
 	ifr.ifr_flags = IFF_TUN | IFF_NO_PI;
 	if (*name)
-		strncpy(ifr.ifr_name, name, IFNAMSIZ);
+		strscpy(ifr.ifr_name, name, IFNAMSIZ);
 
 	err = ioctl(fd, TUNSETIFF, &ifr);
 	if (!ASSERT_OK(err, "ioctl TUNSETIFF"))
diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/selftests/bpf/test_progs.c
index 02a85dda30e6..d1418ec1f351 100644
--- a/tools/testing/selftests/bpf/test_progs.c
+++ b/tools/testing/selftests/bpf/test_progs.c
@@ -1799,7 +1799,7 @@ static int worker_main_send_subtests(int sock, struct test_state *state)
 
 		msg.subtest_done.num = i;
 
-		strncpy(msg.subtest_done.name, subtest_state->name, MAX_SUBTEST_NAME);
+		strscpy(msg.subtest_done.name, subtest_state->name, MAX_SUBTEST_NAME);
 
 		msg.subtest_done.error_cnt = subtest_state->error_cnt;
 		msg.subtest_done.skipped = subtest_state->skipped;
diff --git a/tools/testing/selftests/bpf/xdp_hw_metadata.c b/tools/testing/selftests/bpf/xdp_hw_metadata.c
index 3d8de0d4c96a..1de1bcdb2c9a 100644
--- a/tools/testing/selftests/bpf/xdp_hw_metadata.c
+++ b/tools/testing/selftests/bpf/xdp_hw_metadata.c
@@ -550,7 +550,7 @@ static int rxq_num(const char *ifname)
 	struct ifreq ifr = {
 		.ifr_data = (void *)&ch,
 	};
-	strncpy(ifr.ifr_name, ifname, IF_NAMESIZE - 1);
+	strscpy(ifr.ifr_name, ifname, sizeof(ifr.ifr_name));
 	int fd, ret;
 
 	fd = socket(AF_UNIX, SOCK_DGRAM, 0);
@@ -571,7 +571,7 @@ static void hwtstamp_ioctl(int op, const char *ifname, struct hwtstamp_config *c
 	struct ifreq ifr = {
 		.ifr_data = (void *)cfg,
 	};
-	strncpy(ifr.ifr_name, ifname, IF_NAMESIZE - 1);
+	strscpy(ifr.ifr_name, ifname, sizeof(ifr.ifr_name));
 	int fd, ret;
 
 	fd = socket(AF_UNIX, SOCK_DGRAM, 0);
-- 
2.53.0

