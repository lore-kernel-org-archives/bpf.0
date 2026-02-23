Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC81736A037
	for <bpf@vger.kernel.org>; Mon, 23 Feb 2026 19:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771873687; cv=none; b=XH8upKKdwMWPimWsXDIbXLO8WVyoHyHEpV9if5NBV87ihnpFHgbMw6tq5aY8zXaEfUbrDVCI/hJJ7TVg3u1cMY3Nz7+X8K9PczZ7v2zJhcUvVAqV+Ft8txUZoHeOtqtVBrSyc+VB5bU7R7k/Z0E/xebWQtBYHsJuSiYaJ6NwM+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771873687; c=relaxed/simple;
	bh=a6HINtjSXQrvpKAVWLLy6PuIyYT9nya5BlVlrZH1A9E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WHLFyXwln7WFgXDbz5T4GWvduiTrESDhlpmOpgNmgDyXQ12adsgblIeFUhmnUjMJZauDok5rEpEAOm42bn6hhcJekWpvRVve8jXIUTobeVLzCYF6uxjJD8rBzZ7MQoHM1p7PeRo2x7PgZlqZHyE4ABKMnyTDKK4UX93F2WnspzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=oWoU7COU; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="oWoU7COU"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1771873684;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pbYroRv2vwXLKO8WfCFzIsl8nhanqAWqNNoAKIDihcQ=;
	b=oWoU7COUmvS2fohJNQgli2MnUXT/iO9s+aEeqfScAQGx75LrV7IVvG4zNzZe251pxg4OEp
	z/uss1slxq7/AhE8I3DoPTDbexm4sfTaEtPIuFC7Xfn47lkZRGJNjAyXNq3USenWlRYO2w
	BK/dfMX2e1BKfrn37KFWMgFYdLqcYJ4=
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Jiri Olsa <olsajiri@gmail.com>,
	Mykyta Yatsenko <yatsenko@meta.com>,
	=?UTF-8?q?Alexis=20Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Cc: Amery Hung <ameryhung@gmail.com>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH bpf v4 03/20] selftests/bpf: Replace strncpy() with strscpy()
Date: Mon, 23 Feb 2026 11:07:19 -0800
Message-ID: <20260223190736.649171-4-ihor.solodrai@linux.dev>
In-Reply-To: <20260223190736.649171-1-ihor.solodrai@linux.dev>
References: <20260223190736.649171-1-ihor.solodrai@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

strncpy() does not guarantee NULL-termination and is considered
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
index 5374b7e16d53..b82f572641b7 100644
--- a/tools/testing/selftests/bpf/network_helpers.c
+++ b/tools/testing/selftests/bpf/network_helpers.c
@@ -581,8 +581,7 @@ int open_tuntap(const char *dev_name, bool need_mac)
 		return -1;
 
 	ifr.ifr_flags = IFF_NO_PI | (need_mac ? IFF_TAP : IFF_TUN);
-	strncpy(ifr.ifr_name, dev_name, IFNAMSIZ - 1);
-	ifr.ifr_name[IFNAMSIZ - 1] = '\0';
+	strscpy(ifr.ifr_name, dev_name);
 
 	err = ioctl(fd, TUNSETIFF, &ifr);
 	if (!ASSERT_OK(err, "ioctl(TUNSETIFF)")) {
diff --git a/tools/testing/selftests/bpf/prog_tests/align.c b/tools/testing/selftests/bpf/prog_tests/align.c
index 24c509ce4e5b..841a166b8081 100644
--- a/tools/testing/selftests/bpf/prog_tests/align.c
+++ b/tools/testing/selftests/bpf/prog_tests/align.c
@@ -633,7 +633,7 @@ static int do_test_single(struct bpf_align_test *test)
 	} else {
 		ret = 0;
 		/* We make a local copy so that we can strtok() it */
-		strncpy(bpf_vlog_copy, bpf_vlog, sizeof(bpf_vlog_copy));
+		strscpy(bpf_vlog_copy, bpf_vlog);
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
index 08bae13248c4..fb4892681464 100644
--- a/tools/testing/selftests/bpf/prog_tests/flow_dissector.c
+++ b/tools/testing/selftests/bpf/prog_tests/flow_dissector.c
@@ -570,7 +570,7 @@ static int create_tap(const char *ifname)
 	};
 	int fd, ret;
 
-	strncpy(ifr.ifr_name, ifname, sizeof(ifr.ifr_name));
+	strscpy(ifr.ifr_name, ifname);
 
 	fd = open("/dev/net/tun", O_RDWR);
 	if (fd < 0)
@@ -599,7 +599,7 @@ static int ifup(const char *ifname)
 	struct ifreq ifr = {};
 	int sk, ret;
 
-	strncpy(ifr.ifr_name, ifname, sizeof(ifr.ifr_name));
+	strscpy(ifr.ifr_name, ifname);
 
 	sk = socket(PF_INET, SOCK_DGRAM, 0);
 	if (sk < 0)
diff --git a/tools/testing/selftests/bpf/prog_tests/queue_stack_map.c b/tools/testing/selftests/bpf/prog_tests/queue_stack_map.c
index a043af9cd6d9..41441325e179 100644
--- a/tools/testing/selftests/bpf/prog_tests/queue_stack_map.c
+++ b/tools/testing/selftests/bpf/prog_tests/queue_stack_map.c
@@ -28,9 +28,9 @@ static void test_queue_stack_map_by_type(int type)
 		vals[i] = rand();
 
 	if (type == QUEUE)
-		strncpy(file, "./test_queue_map.bpf.o", sizeof(file));
+		strscpy(file, "./test_queue_map.bpf.o");
 	else if (type == STACK)
-		strncpy(file, "./test_stack_map.bpf.o", sizeof(file));
+		strscpy(file, "./test_stack_map.bpf.o");
 	else
 		return;
 
diff --git a/tools/testing/selftests/bpf/prog_tests/skc_to_unix_sock.c b/tools/testing/selftests/bpf/prog_tests/skc_to_unix_sock.c
index 3eefdfed1db9..657d897958b6 100644
--- a/tools/testing/selftests/bpf/prog_tests/skc_to_unix_sock.c
+++ b/tools/testing/selftests/bpf/prog_tests/skc_to_unix_sock.c
@@ -34,7 +34,7 @@ void test_skc_to_unix_sock(void)
 
 	memset(&sockaddr, 0, sizeof(sockaddr));
 	sockaddr.sun_family = AF_UNIX;
-	strncpy(sockaddr.sun_path, sock_path, strlen(sock_path));
+	strscpy(sockaddr.sun_path, sock_path);
 	sockaddr.sun_path[0] = '\0';
 
 	err = bind(sockfd, (struct sockaddr *)&sockaddr, sizeof(sockaddr));
diff --git a/tools/testing/selftests/bpf/prog_tests/task_local_data.h b/tools/testing/selftests/bpf/prog_tests/task_local_data.h
index 0f86b9275cf9..8342e2fe5260 100644
--- a/tools/testing/selftests/bpf/prog_tests/task_local_data.h
+++ b/tools/testing/selftests/bpf/prog_tests/task_local_data.h
@@ -262,7 +262,7 @@ static tld_key_t __tld_create_key(const char *name, size_t size, bool dyn_data)
 		if (!atomic_compare_exchange_strong(&tld_meta_p->cnt, &cnt, cnt + 1))
 			goto retry;
 
-		strncpy(tld_meta_p->metadata[i].name, name, TLD_NAME_LEN);
+		strscpy(tld_meta_p->metadata[i].name, name);
 		atomic_store(&tld_meta_p->metadata[i].size, size);
 		return (tld_key_t){(__s16)off};
 	}
diff --git a/tools/testing/selftests/bpf/prog_tests/tc_redirect.c b/tools/testing/selftests/bpf/prog_tests/tc_redirect.c
index 76d72a59365e..64fbda082309 100644
--- a/tools/testing/selftests/bpf/prog_tests/tc_redirect.c
+++ b/tools/testing/selftests/bpf/prog_tests/tc_redirect.c
@@ -1095,7 +1095,7 @@ static int tun_open(char *name)
 
 	ifr.ifr_flags = IFF_TUN | IFF_NO_PI;
 	if (*name)
-		strncpy(ifr.ifr_name, name, IFNAMSIZ);
+		strscpy(ifr.ifr_name, name);
 
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
index 3d8de0d4c96a..6db3b5555a22 100644
--- a/tools/testing/selftests/bpf/xdp_hw_metadata.c
+++ b/tools/testing/selftests/bpf/xdp_hw_metadata.c
@@ -550,7 +550,7 @@ static int rxq_num(const char *ifname)
 	struct ifreq ifr = {
 		.ifr_data = (void *)&ch,
 	};
-	strncpy(ifr.ifr_name, ifname, IF_NAMESIZE - 1);
+	strscpy(ifr.ifr_name, ifname);
 	int fd, ret;
 
 	fd = socket(AF_UNIX, SOCK_DGRAM, 0);
@@ -571,7 +571,7 @@ static void hwtstamp_ioctl(int op, const char *ifname, struct hwtstamp_config *c
 	struct ifreq ifr = {
 		.ifr_data = (void *)cfg,
 	};
-	strncpy(ifr.ifr_name, ifname, IF_NAMESIZE - 1);
+	strscpy(ifr.ifr_name, ifname);
 	int fd, ret;
 
 	fd = socket(AF_UNIX, SOCK_DGRAM, 0);
-- 
2.53.0

