Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795098508;
	b=buNNMzJHUG/LWs0q4vptHgBfXft5Tw2mbvFL35OMguOxhTQrN2wfFZHv5DXiA0z+ilcz
	 3qj0bzc+IPIeJKqMFzr277TbtUTgNo3auIk3yLvZMTno2anSKzgMx4h1Q5ajIts3YuVIy
	 BRkq96UE00BuE1vLS/rbk5VIQwtOI8Euj8WA0hlFlywJYVDQ7xWMpnoGOJIwA/EPfjdS3
	 6wa0lJWzCU7JqfXummK2n6VRA0IQfVi5SDx1n1GHNdl6NFtGYXtvyXQG20mC+E9yx52u/
	 fUqTZi8ebz5QKubqz8nfyvqKPPwmnQmSUTMUOBcBrFCzt/prqysVxnehowWuIpo2c0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795098508;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=qpMa5/a15UYwYP7bW4D536UF4YikkuYGy95BesA1PAk=;
	b=wVhUQSrMMiRP4BIMQdK6ZNASMLgZ4JN87sNRx/UdjVLHcnUiZSgi+OJPrCik5kcAwnN0
	 WDJ54UWrz2MQ7j1au7SURXjz8zQwknlPuXDjLEkhRW90fdqiOgZthXpMrYJhTtrCi8AYQ
	 vaPg4dYKOhqWls3GTJ25XXWy90mnJSEX2m6N+tpdMuLRwjlJM4XjLu6Op8yAYzenbFain
	 rnHmFR2wotZ2dEpzVzSgAOeKqn/8gyoeUjymwTWAIMl4bqjXoDjPSMCwyCj+4FbaZ9iNl
	 xArgUQknjA6VgH9UZPmaK2bZgWXwQTZoLM/i+YhdEYaErIONMzHWtk3EN0fsp91lmmQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=blackwall.org;
	spf=none smtp.mailfrom=blackwall.org;
	dkim=pass header.d=blackwall.org header.i=@blackwall.org header.a=rsa-sha256 header.s=google header.b=iN+9XKME;
	arc=none smtp.remote-ip=209.85.128.51
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E09D606A324
	for <bpf@vger.kernel.org>; Thu, 19 Nov 2026 14:28:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3E09D606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall.org header.i=@blackwall.org header.a=rsa-sha256 header.s=google header.b=iN+9XKME
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4bb70074ab2so24417875e9.0
        for <bpf@vger.kernel.org>; Thu, 19 Nov 2026 06:28:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall.org; s=google; t=1795098506; x=1795703306; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qpMa5/a15UYwYP7bW4D536UF4YikkuYGy95BesA1PAk=;
        b=iN+9XKMEJjeA0r89apshI05K9Fl06ZC8xsn6ksYs2ewLAwNCrfiL6pG46k6LI2x6De
         /uOG1yYEfiNo8H4oxxb6iinsTU5v9gavK27iY0jg1XB7zurE/wUmFj1f9Bkm8lax/zgM
         md3tVpSlQYM2cnEpHS4Dex4y4vtHwtEvDFQpSGm4ahQXEYYj8z+F47Ce/YuIX1BRRsOR
         /DsHQEdVqtE/9sPq7BPlSr5tatOhy/staslBnBoc5YZCzkLw6RPnb484NasLxHw4jMmj
         sHhMON9lSRUiqjbcUny1iENTJUE+AVAWqNcwYsfTWhLXQuhz1/8WuAmLs0Y0u8PnCLqN
         ceDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795098506; x=1795703306;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qpMa5/a15UYwYP7bW4D536UF4YikkuYGy95BesA1PAk=;
        b=wju1jVHNo3rhHRogSGtqrJjhVClkzqLcJ1327XL5BTov1bhn5Ju/wcObguAdGeQrIo
         YHz3hj/JWVdB4GAjO9rjzEkEmnUOIuU+Zt/mVuXf85KNSkXgVGSVO/Jchl0KUnRKki0V
         VcEt4IgJDxa8mw2SPj6t74JCw/AEV6j6k1fkHA6ammwK5z5UqetTBmhyRKw8JAST3SKd
         Fy+WZzYcL4fOBWjmo0xSllMgNRBw6U9HPg0erQQiaO4edEXyd5reKKYPszshtGgqLclO
         k1QOkY9R2U/ypasUHmm4z1AiILXxFO0hjbNlThB32ncTvAEoSZy1XYpaWXv+0GDwmoJq
         CFHA==
X-Gm-Message-State: APuU4Z8aoWtUZ4kgE/Qnyu3uWdswghuH8tvQWzT23V+5givBUUTUuJMh
	nKc55AjvecIgyYyrzwvAhVaY2edbmIEr8z4d1+CRl3Inl1KnfzuDEMbZAimmN1+gwpvDjQEASXl
	La1fxx/5uaYGq
X-Gm-Gg: AYBFou30milSTEOuqRJlXQQ73zs3647XCleKr3/Rwjs5X/ah0R/IHBqnXZOfeksC/k3
	7N7GEmNYCVeixHdjqFy7OTFcH3mVucIj2pdKZPJj/KecLiIBMknscpODn4Rtnp3fT7gi2nMIEZK
	gSZmS1HxKJ0joiz2V/nXUq1pfqdP+VdsyS7J17Bw8E08uNQ00eWgrbG00pWcejQVFc3wFUJ9SPu
	x/X6Bszl/B+ogsPrR336ngT6LKL00ETCt4gyBuuondIZAtc7KrhCaHB04ZzqeScQrMHAWYlIaVQ
	TzuwZC5nspxtZ5L3Bo+chS8Z+9yl0hoeygsasumtDAMpT3o4ndgoQSVzjt1mpueMUl8XxLTj8tH
	6EFpLPtVqN7otOlMhEQtGIsVIiTTLFL2dBNEHwU9I7CY9GjsXlEQJdE/ysWRLP0YbQ3RerWcJJc
	aZSDXRR5NW+ofkS1WU4g3mEElieWWKGgPrDGjiOHWTPWv3rxyuJZqltCQxHgMRkgeQT8+k8ruSg
	oIpxpBwkdI3cZQoyuZALqh8oA8uPHPbaWJ31IIunBrStYfVuPHpzkos1xPblxCZ0b3nCFE/FxNI
	NQl+l9lVwxsu3B+CvnI/KM4Jc/NlWSDxe6yoFpgDwblUN+nmPubfhH+tLPhwXGbuBRIlZbGl
X-Received: by 2002:a05:600c:b86:b0:4bb:6a5a:7824 with SMTP id 5b1f17b1804b1-4bb7da3da19mr116201265e9.30.1795098506451;
        Thu, 19 Nov 2026 06:28:26 -0800 (PST)
Received: from localhost (78-154-14-127.ip.btc-net.bg. [78.154.14.127])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4bb853368d3sm41971915e9.1.2026.11.19.06.28.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 06:28:25 -0800 (PST)
From: Nikolay Aleksandrov <razor@blackwall.org>
To: bpf@vger.kernel.org
Cc: Nikolay Aleksandrov <razor@blackwall.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Paul Chaignon <paul@isovalent.com>,
	Alasdair McWilliam <alasdair.mcwilliam@isovalent.com>
Subject: [PATCH bpf-next 6/8] selftests/bpf: Cover egress socket assignment with reuseport
Date: Thu, 19 Nov 2026 16:22:28 +0200
Message-ID: <20261119142231.2612515-7-razor@blackwall.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261119142231.2612515-1-razor@blackwall.org>
References: <20261119142231.2612515-1-razor@blackwall.org>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Cover IPv4/IPv6 TCP and UDP assignment on TC egress with reuseport accept
and drop verdicts, selecting the original or another socket.

Track exchanges by distinct source ports so delayed SYNs retain their
selection and accounting. After detaching TC, wait for counted reuseport
completions and check every exchange. Publish completion with a fetching
64-bit atomic so arm64 observes prior result updates.

Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
---
CC: Alexei Starovoitov <ast@kernel.org>
CC: Daniel Borkmann <daniel@iogearbox.net>
CC: Andrii Nakryiko <andrii@kernel.org>
CC: Eduard Zingerman <eddyz87@gmail.com>
CC: Kumar Kartikeya Dwivedi <memxor@gmail.com>
CC: Martin KaFai Lau <martin.lau@linux.dev>
CC: Song Liu <song@kernel.org>
CC: Yonghong Song <yonghong.song@linux.dev>
CC: Jiri Olsa <jolsa@kernel.org>
CC: Emil Tsalapatis <emil@etsalapatis.com>
CC: Ihor Solodrai <ihor.solodrai@linux.dev>
CC: Paul Chaignon <paul@isovalent.com>
CC: Alasdair McWilliam <alasdair.mcwilliam@isovalent.com>

 .../selftests/bpf/prog_tests/assign_reuse.c   | 266 ++++++++++++++++--
 .../selftests/bpf/progs/test_assign_reuse.c   | 129 ++++++++-
 2 files changed, 366 insertions(+), 29 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/assign_reuse.c b/tools/testing/selftests/bpf/prog_tests/assign_reuse.c
index 23ed1290957b..7b19193ed3d7 100644
--- a/tools/testing/selftests/bpf/prog_tests/assign_reuse.c
+++ b/tools/testing/selftests/bpf/prog_tests/assign_reuse.c
@@ -2,6 +2,7 @@
 /* Copyright (c) 2023 Isovalent */
 #include <uapi/linux/if_link.h>
 #include <test_progs.h>
+#include <stdint.h>
 
 #include <netinet/tcp.h>
 #include <netinet/udp.h>
@@ -12,6 +13,38 @@
 #define NS_TEST "assign_reuse"
 #define LOOPBACK 1
 #define PORT 4443
+#define CLIENT_PORT_MIN 32768
+#define TEST_ITERATIONS 8
+#define IO_TIMEOUT_MS 100
+#define POLL_RETRIES 5000
+#define POLL_INTERVAL_US 1000
+#define NR_EXCHANGES \
+	ARRAY_SIZE(((struct test_assign_reuse__bss *)0)->exchanges)
+
+struct reuse_client {
+	struct test_assign_reuse *skel;
+	__u32 slot;
+	int held_fd;
+};
+
+static bool setup_family(int family)
+{
+	int fd, ret;
+
+	fd = socket(family, SOCK_DGRAM, 0);
+	if (fd < 0 && errno == EAFNOSUPPORT) {
+		printf("SKIP: address family %d is unavailable\n", family);
+		test__skip();
+		return false;
+	}
+	if (!ASSERT_GE(fd, 0, "family_probe"))
+		return false;
+	close(fd);
+	if (family != AF_INET6)
+		return true;
+	ret = write_sysctl("/proc/sys/net/ipv6/conf/all/disable_ipv6", "0");
+	return ASSERT_OK(ret, "enable_ipv6");
+}
 
 static int attach_reuseport(int sock_fd, int prog_fd)
 {
@@ -32,14 +65,15 @@ static __u64 cookie(int fd)
 	return cookie;
 }
 
-static int echo_test_udp(int fd_sv)
+static int echo_test_udp_opts(int fd_sv,
+			      const struct network_helper_opts *opts)
 {
 	struct sockaddr_storage addr = {};
 	socklen_t len = sizeof(addr);
-	char buff[1] = {};
 	int fd_cl = -1, ret;
+	char buff[1] = {};
 
-	fd_cl = connect_to_fd(fd_sv, 100);
+	fd_cl = connect_to_fd_opts(fd_sv, opts);
 	ASSERT_GT(fd_cl, 0, "create_client");
 	ASSERT_EQ(getsockname(fd_cl, (void *)&addr, &len), 0, "getsockname");
 
@@ -58,12 +92,20 @@ static int echo_test_udp(int fd_sv)
 	return 0;
 }
 
-static int echo_test_tcp(int fd_sv)
+static int echo_test_udp(int fd_sv)
+{
+	struct network_helper_opts opts = { .timeout_ms = IO_TIMEOUT_MS };
+
+	return echo_test_udp_opts(fd_sv, &opts);
+}
+
+static int echo_test_tcp_opts(int fd_sv,
+			      const struct network_helper_opts *opts)
 {
-	char buff[1] = {};
 	int fd_cl = -1, fd_sv_cl = -1;
+	char buff[1] = {};
 
-	fd_cl = connect_to_fd(fd_sv, 100);
+	fd_cl = connect_to_fd_opts(fd_sv, opts);
 	if (fd_cl < 0)
 		return errno;
 
@@ -79,8 +121,124 @@ static int echo_test_tcp(int fd_sv)
 	return 0;
 }
 
-void run_assign_reuse(int family, int sotype, const char *ip, __u16 port)
+static int echo_test_tcp(int fd_sv)
 {
+	struct network_helper_opts opts = { .timeout_ms = IO_TIMEOUT_MS };
+
+	return echo_test_tcp_opts(fd_sv, &opts);
+}
+
+static int prepare_reuse_client(int fd, void *arg)
+{
+	struct sockaddr_storage addr = {};
+	struct reuse_client *client = arg;
+	socklen_t len = sizeof(addr);
+	int port, ret, i;
+
+	if (getsockname(fd, (void *)&addr, &len))
+		return -1;
+	ret = make_sockaddr(addr.ss_family, addr.ss_family == AF_INET ?
+			    "127.0.0.1" : "::1", 0, &addr, &len);
+	if (ret)
+		return -1;
+	for (port = CLIENT_PORT_MIN; port <= UINT16_MAX; port++) {
+		for (i = 0; i < client->slot; i++) {
+			if (client->skel->bss->exchanges[i].source_port ==
+			    htons(port))
+				break;
+		}
+		if (i < client->slot)
+			continue;
+		if (addr.ss_family == AF_INET)
+			((struct sockaddr_in *)&addr)->sin_port = htons(port);
+		else
+			((struct sockaddr_in6 *)&addr)->sin6_port = htons(port);
+		ret = bind(fd, (void *)&addr, len);
+		if (!ret)
+			break;
+		if (errno != EADDRINUSE)
+			return -1;
+	}
+	if (port > UINT16_MAX)
+		return -1;
+	client->held_fd = dup(fd);
+	if (client->held_fd < 0)
+		return -1;
+	__atomic_store_n(&client->skel->bss->exchanges[client->slot].source_port,
+			 htons(port), __ATOMIC_RELEASE);
+	return 0;
+}
+
+static bool run_reuse_exchange(struct test_assign_reuse *skel, int fd,
+			       int sotype, __u32 index, bool drop,
+			       struct reuse_client *client, __u32 slot,
+			       __u64 expected_cookie)
+{
+	struct network_helper_opts opts = {
+		.timeout_ms = IO_TIMEOUT_MS,
+		.post_socket_cb = prepare_reuse_client,
+		.cb_opts = client,
+	};
+	int expected, ret;
+
+	client->skel = skel;
+	client->slot = slot;
+	skel->bss->exchanges[slot].expected_cookie = expected_cookie;
+	skel->bss->exchanges[slot].index = index;
+	skel->bss->exchanges[slot].drop = drop;
+	if (sotype == SOCK_STREAM) {
+		expected = drop ? ECONNREFUSED : 0;
+		ret = echo_test_tcp_opts(fd, &opts);
+	} else {
+		expected = drop ? EAGAIN : 0;
+		ret = echo_test_udp_opts(fd, &opts);
+	}
+	return ASSERT_EQ(ret, expected, "exchange_result");
+}
+
+static void check_reuse_exchanges(struct test_assign_reuse *skel)
+{
+	typeof(skel->bss->exchanges[0]) *exchange;
+	bool complete = false;
+	int i, j;
+
+	for (i = 0; i < POLL_RETRIES; i++) {
+		complete = true;
+		for (j = 0; j < ARRAY_SIZE(skel->bss->exchanges); j++) {
+			exchange = &skel->bss->exchanges[j];
+			if (!exchange->source_port)
+				continue;
+			if (__atomic_load_n(&exchange->reuse_calls,
+					    __ATOMIC_ACQUIRE) !=
+			    exchange->assign_calls - exchange->assign_errors)
+				complete = false;
+		}
+		if (complete)
+			break;
+		usleep(POLL_INTERVAL_US);
+	}
+	ASSERT_TRUE(complete, "reuseport_drained");
+	for (i = 0; i < ARRAY_SIZE(skel->bss->exchanges); i++) {
+		exchange = &skel->bss->exchanges[i];
+		if (!exchange->source_port)
+			continue;
+		ASSERT_GT(exchange->assign_calls, 0, "final_assign_calls");
+		ASSERT_EQ(exchange->reuse_calls, exchange->assign_calls,
+			  "final_reuse_calls");
+		ASSERT_EQ(exchange->assign_errors, 0, "final_assign_errors");
+		ASSERT_EQ(exchange->select_errors, 0, "final_select_errors");
+		ASSERT_EQ(exchange->cookie_errors, 0, "final_cookie_errors");
+		ASSERT_EQ(exchange->sk_cookie, exchange->expected_cookie,
+			  "final_assigned_socket_cookie");
+	}
+}
+
+static void run_assign_reuse(int family, int sotype, const char *ip, __u16 port,
+			     bool egress)
+{
+	bool hook_created = false, tc_attached = false;
+	int ret, fd_tc, fd_accept, fd_drop, fd_map;
+	struct reuse_client clients[NR_EXCHANGES];
 	DECLARE_LIBBPF_OPTS(bpf_tc_hook, tc_hook,
 		.ifindex = LOOPBACK,
 		.attach_point = BPF_TC_INGRESS,
@@ -89,18 +247,40 @@ void run_assign_reuse(int family, int sotype, const char *ip, __u16 port)
 		.handle = 1,
 		.priority = 1,
 	);
-	bool hook_created = false, tc_attached = false;
-	int ret, fd_tc, fd_accept, fd_drop, fd_map;
+	struct test_assign_reuse *skel = NULL;
+	int nr_listens = egress ? 2 : 1;
+	const int zero = 0;
 	int *fd_sv = NULL;
+	__u32 slot = 0;
 	__u64 fd_val;
-	struct test_assign_reuse *skel;
-	const int zero = 0;
+	int i, j;
 
+	for (i = 0; i < ARRAY_SIZE(clients); i++)
+		clients[i].held_fd = -1;
+	if (!setup_family(family))
+		goto cleanup;
 	skel = test_assign_reuse__open();
 	if (!ASSERT_OK_PTR(skel, "skel_open"))
 		goto cleanup;
 
 	skel->rodata->dest_port = port;
+	skel->rodata->select_sock = egress;
+	if (egress) {
+		ret = kern_sync_rcu();
+		if (ret && (errno == ENOSYS || errno == EINVAL)) {
+			printf("SKIP: RCU synchronization is unavailable\n");
+			test__skip();
+			goto cleanup;
+		}
+		if (!ASSERT_OK(ret, "sync_rcu_probe"))
+			goto cleanup;
+		tc_hook.attach_point = BPF_TC_EGRESS;
+		if (!ASSERT_OK(write_sysctl("/proc/sys/net/ipv4/conf/lo/accept_local", "1"),
+			       "accept_local") ||
+		    !ASSERT_OK(write_sysctl("/proc/sys/net/ipv4/conf/lo/route_localnet", "1"),
+			       "route_localnet"))
+			goto cleanup;
+	}
 
 	ret = test_assign_reuse__load(skel);
 	if (!ASSERT_OK(ret, "skel_load"))
@@ -113,7 +293,8 @@ void run_assign_reuse(int family, int sotype, const char *ip, __u16 port)
 	fd_drop = bpf_program__fd(skel->progs.reuse_drop);
 	fd_map = bpf_map__fd(skel->maps.sk_map);
 
-	fd_sv = start_reuseport_server(family, sotype, ip, port, 100, 1);
+	fd_sv = start_reuseport_server(family, sotype, ip, port, IO_TIMEOUT_MS,
+				       nr_listens);
 	if (!ASSERT_NEQ(fd_sv, NULL, "start_reuseport_server"))
 		goto cleanup;
 
@@ -125,6 +306,12 @@ void run_assign_reuse(int family, int sotype, const char *ip, __u16 port)
 	ret = bpf_map_update_elem(fd_map, &zero, &fd_val, BPF_NOEXIST);
 	if (!ASSERT_OK(ret, "bpf_sk_map"))
 		goto cleanup;
+	for (i = 1; i < nr_listens; i++) {
+		fd_val = fd_sv[i];
+		ret = bpf_map_update_elem(fd_map, &i, &fd_val, BPF_NOEXIST);
+		if (!ASSERT_OK(ret, "sk_map_update"))
+			goto cleanup;
+	}
 
 	ret = bpf_tc_hook_create(&tc_hook);
 	if (ret == 0)
@@ -139,11 +326,37 @@ void run_assign_reuse(int family, int sotype, const char *ip, __u16 port)
 		goto cleanup;
 	tc_attached = true;
 
+	if (egress) {
+		if (!run_reuse_exchange(skel, fd_sv[0], sotype, 0, true,
+					&clients[slot], slot, cookie(fd_sv[0])))
+			goto cleanup;
+		slot++;
+		if (!ASSERT_OK(attach_reuseport(*fd_sv, fd_accept),
+			       "attach_reuseport(accept)"))
+			goto cleanup;
+		if (!run_reuse_exchange(skel, fd_sv[0], sotype, 0, false,
+					&clients[slot], slot, cookie(fd_sv[0])))
+			goto cleanup;
+		slot++;
+		for (i = 0; i < nr_listens; i++) {
+			for (j = 0; j < TEST_ITERATIONS; j++) {
+				if (!run_reuse_exchange(skel, fd_sv[i], sotype,
+							i, false, &clients[slot],
+							slot, cookie(fd_sv[0])))
+					goto cleanup;
+				slot++;
+			}
+		}
+		goto cleanup;
+	}
+
 	if (sotype == SOCK_STREAM)
 		ASSERT_EQ(echo_test_tcp(*fd_sv), ECONNREFUSED, "drop_tcp");
 	else
 		ASSERT_EQ(echo_test_udp(*fd_sv), EAGAIN, "drop_udp");
 	ASSERT_EQ(skel->bss->reuseport_executed, 1, "program executed once");
+	ASSERT_EQ(skel->bss->assign_calls, 1, "drop_assign_calls");
+	ASSERT_EQ(skel->bss->assign_errors, 0, "drop_assign_errors");
 
 	skel->bss->sk_cookie_seen = 0;
 	skel->bss->reuseport_executed = 0;
@@ -157,18 +370,25 @@ void run_assign_reuse(int family, int sotype, const char *ip, __u16 port)
 	ASSERT_EQ(skel->bss->sk_cookie_seen, cookie(*fd_sv),
 		  "cookie_mismatch");
 	ASSERT_EQ(skel->bss->reuseport_executed, 1, "program executed once");
+
 cleanup:
+	for (i = 0; i < ARRAY_SIZE(clients); i++) {
+		if (clients[i].held_fd >= 0)
+			close(clients[i].held_fd);
+	}
 	if (tc_attached) {
 		tc_opts.flags = tc_opts.prog_fd = tc_opts.prog_id = 0;
 		ret = bpf_tc_detach(&tc_hook, &tc_opts);
-		ASSERT_OK(ret, "bpf_tc_detach");
+		if (ASSERT_OK(ret, "bpf_tc_detach") && egress &&
+		    ASSERT_OK(kern_sync_rcu(), "sync_assignments"))
+			check_reuse_exchanges(skel);
 	}
 	if (hook_created) {
 		tc_hook.attach_point = BPF_TC_INGRESS | BPF_TC_EGRESS;
 		bpf_tc_hook_destroy(&tc_hook);
 	}
 	test_assign_reuse__destroy(skel);
-	free_fds(fd_sv, 1);
+	free_fds(fd_sv, nr_listens);
 }
 
 void test_assign_reuse(void)
@@ -179,17 +399,25 @@ void test_assign_reuse(void)
 	SYS(cleanup, "ip -net %s link set dev lo up", NS_TEST);
 
 	tok = open_netns(NS_TEST);
-	if (!ASSERT_OK_PTR(tok, "netns token"))
+	if (!ASSERT_NEQ(tok, NULL, "netns token"))
 		goto cleanup;
 
 	if (test__start_subtest("tcpv4"))
-		run_assign_reuse(AF_INET, SOCK_STREAM, "127.0.0.1", PORT);
+		run_assign_reuse(AF_INET, SOCK_STREAM, "127.0.0.1", PORT, false);
 	if (test__start_subtest("tcpv6"))
-		run_assign_reuse(AF_INET6, SOCK_STREAM, "::1", PORT);
+		run_assign_reuse(AF_INET6, SOCK_STREAM, "::1", PORT, false);
 	if (test__start_subtest("udpv4"))
-		run_assign_reuse(AF_INET, SOCK_DGRAM, "127.0.0.1", PORT);
+		run_assign_reuse(AF_INET, SOCK_DGRAM, "127.0.0.1", PORT, false);
 	if (test__start_subtest("udpv6"))
-		run_assign_reuse(AF_INET6, SOCK_DGRAM, "::1", PORT);
+		run_assign_reuse(AF_INET6, SOCK_DGRAM, "::1", PORT, false);
+	if (test__start_subtest("tcpv4_egress"))
+		run_assign_reuse(AF_INET, SOCK_STREAM, "127.0.0.1", PORT, true);
+	if (test__start_subtest("tcpv6_egress"))
+		run_assign_reuse(AF_INET6, SOCK_STREAM, "::1", PORT, true);
+	if (test__start_subtest("udpv4_egress"))
+		run_assign_reuse(AF_INET, SOCK_DGRAM, "127.0.0.1", PORT, true);
+	if (test__start_subtest("udpv6_egress"))
+		run_assign_reuse(AF_INET6, SOCK_DGRAM, "::1", PORT, true);
 
 cleanup:
 	close_netns(tok);
diff --git a/tools/testing/selftests/bpf/progs/test_assign_reuse.c b/tools/testing/selftests/bpf/progs/test_assign_reuse.c
index 4f2e2321ea06..9098fe4707ff 100644
--- a/tools/testing/selftests/bpf/progs/test_assign_reuse.c
+++ b/tools/testing/selftests/bpf/progs/test_assign_reuse.c
@@ -11,6 +11,9 @@
 #include <bpf/bpf_endian.h>
 #include <bpf/bpf_helpers.h>
 #include <linux/pkt_cls.h>
+#include "bpf_misc.h"
+
+#define NR_EXCHANGES 18
 
 char LICENSE[] SEC("license") = "GPL";
 
@@ -22,17 +25,92 @@ union {
 } headers;
 
 const volatile __u16 dest_port;
+const volatile bool select_sock;
+__u64 assign_calls;
+__u64 assign_errors;
+
+struct {
+	__u64 expected_cookie;
+	__u64 sk_cookie;
+	__u64 reuse_calls;
+	__u32 assign_calls;
+	__u32 assign_errors;
+	__u32 select_errors;
+	__u32 cookie_errors;
+	__u32 index;
+	__u32 drop;
+	__u16 source_port;
+} exchanges[NR_EXCHANGES];
 
 struct {
 	__uint(type, BPF_MAP_TYPE_SOCKMAP);
-	__uint(max_entries, 1);
+	__uint(max_entries, 2);
 	__type(key, __u32);
 	__type(value, __u64);
 } sk_map SEC(".maps");
 
+static __always_inline typeof(exchanges[0]) *find_exchange(__u16 source)
+{
+	int i;
+
+#pragma unroll
+	for (i = 0; i < ARRAY_SIZE(exchanges); i++) {
+		if (source && exchanges[i].source_port == source)
+			return &exchanges[i];
+	}
+	return NULL;
+}
+
+static __always_inline int select_exchange(struct sk_reuseport_md *ctx)
+{
+	void *data_end = (void *)(long)ctx->data_end;
+	void *data = (void *)(long)ctx->data;
+	typeof(exchanges[0]) *exchange;
+	struct tcphdr *th = data;
+	struct udphdr *uh = data;
+	__u64 increment = 1;
+	int ret = SK_DROP;
+	__u16 source;
+	__u64 cookie;
+	__u32 index;
+
+	if (ctx->ip_protocol == IPPROTO_TCP) {
+		if ((void *)(th + 1) > data_end || !th->syn || th->ack ||
+		    th->dest != bpf_htons(dest_port))
+			return SK_DROP;
+		source = th->source;
+	} else if (ctx->ip_protocol == IPPROTO_UDP) {
+		if ((void *)(uh + 1) > data_end ||
+		    uh->dest != bpf_htons(dest_port))
+			return SK_DROP;
+		source = uh->source;
+	} else {
+		return SK_DROP;
+	}
+	exchange = find_exchange(source);
+	if (!exchange)
+		return SK_DROP;
+	cookie = bpf_get_socket_cookie(ctx->sk);
+	exchange->sk_cookie = cookie;
+	if (cookie != exchange->expected_cookie)
+		__sync_fetch_and_add(&exchange->cookie_errors, 1);
+	if (!exchange->drop) {
+		index = exchange->index;
+		if (bpf_sk_select_reuseport(ctx, &sk_map, &index, 0))
+			__sync_fetch_and_add(&exchange->select_errors, 1);
+		else
+			ret = SK_PASS;
+	}
+	asm volatile("%0 = atomic_fetch_add((u64 *)(%1 + 0), %0);"
+		     : "+r"(increment) : "r"(&exchange->reuse_calls) : "memory");
+	return ret;
+}
+
 SEC("sk_reuseport")
 int reuse_accept(struct sk_reuseport_md *ctx)
 {
+	if (select_sock)
+		return select_exchange(ctx);
 	reuseport_executed++;
 
 	if (ctx->ip_protocol == IPPROTO_TCP) {
@@ -58,49 +136,80 @@ int reuse_accept(struct sk_reuseport_md *ctx)
 SEC("sk_reuseport")
 int reuse_drop(struct sk_reuseport_md *ctx)
 {
+	if (select_sock)
+		return select_exchange(ctx);
 	reuseport_executed++;
 	sk_cookie_seen = 0;
 	return SK_DROP;
 }
 
 static int
-assign_sk(struct __sk_buff *skb)
+assign_sk(struct __sk_buff *skb, typeof(exchanges[0]) *exchange)
 {
-	int zero = 0, ret = 0;
 	struct bpf_sock *sk;
+	int zero = 0, ret;
 
 	sk = bpf_map_lookup_elem(&sk_map, &zero);
 	if (!sk)
 		return TC_ACT_SHOT;
 	ret = bpf_sk_assign(skb, sk, 0);
+	if (select_sock) {
+		__sync_fetch_and_add(&exchange->assign_calls, 1);
+		if (ret)
+			__sync_fetch_and_add(&exchange->assign_errors, 1);
+	} else {
+		__sync_fetch_and_add(&assign_calls, 1);
+		if (ret)
+			__sync_fetch_and_add(&assign_errors, 1);
+	}
 	bpf_sk_release(sk);
-	return ret ? TC_ACT_SHOT : TC_ACT_OK;
+	if (ret)
+		return TC_ACT_SHOT;
+	if (select_sock)
+		return bpf_redirect(skb->ifindex, BPF_F_INGRESS);
+	return TC_ACT_OK;
 }
 
-static bool
+static int
 maybe_assign_tcp(struct __sk_buff *skb, struct tcphdr *th)
 {
+	typeof(exchanges[0]) *exchange = NULL;
+
 	if (th + 1 > (void *)(long)(skb->data_end))
 		return TC_ACT_SHOT;
 
 	if (!th->syn || th->ack || th->dest != bpf_htons(dest_port))
 		return TC_ACT_OK;
 
-	__builtin_memcpy(&headers.tcp, th, sizeof(headers.tcp));
-	return assign_sk(skb);
+	if (select_sock) {
+		exchange = find_exchange(th->source);
+		if (!exchange)
+			return TC_ACT_OK;
+	} else {
+		__builtin_memcpy(&headers.tcp, th, sizeof(headers.tcp));
+	}
+	return assign_sk(skb, exchange);
 }
 
-static bool
+static int
 maybe_assign_udp(struct __sk_buff *skb, struct udphdr *uh)
 {
+	typeof(exchanges[0]) *exchange = NULL;
+
 	if (uh + 1 > (void *)(long)(skb->data_end))
 		return TC_ACT_SHOT;
 
 	if (uh->dest != bpf_htons(dest_port))
 		return TC_ACT_OK;
 
-	__builtin_memcpy(&headers.udp, uh, sizeof(headers.udp));
-	return assign_sk(skb);
+	if (select_sock) {
+		exchange = find_exchange(uh->source);
+		if (!exchange)
+			return TC_ACT_OK;
+	} else {
+		__builtin_memcpy(&headers.udp, uh, sizeof(headers.udp));
+	}
+	return assign_sk(skb, exchange);
 }
 
 SEC("tc")
-- 
2.47.3

