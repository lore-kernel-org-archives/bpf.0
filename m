Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6872B37105A
	for <bpf@vger.kernel.org>; Mon, 23 Mar 2026 08:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774253507; cv=none; b=nk9vkmdSZz2MErOpvQ2NDmU2xVFMcnWqjuaVhXSwQKe5yb0o/4J0m2iL0P6o6firSQSgoC7FIKHk1rsoozOEOf5kCaNvU/aDakHqZp6RXHVZ0OavCe1I0Pa6mZ3IAmrLvmdnBZK2h16Ru7K3Gpgfy3xg2HQ4PaPyLD5Hy9XZBNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774253507; c=relaxed/simple;
	bh=QCcx0mWfxf206RMD402o1TdWNM/pgkL5fTz86YYT1ro=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k8I7FCf+aMu1/NkdlJD9p8hdvdF127fckSDv/YVh28kzcytuWwVutUd/E0f5dZU9uTaNR2CRmfhWIoXxjuDNlBsThnyX3T3WnfvvwSyji33Nk+qyY54zE7WreqJBBMEPV0t9ESESABNmddi6qJnK7kpmmpyNr+mR6iw0xCeR2T8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OQPlepZH; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OQPlepZH"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2adbfab4501so10457335ad.2
        for <bpf@vger.kernel.org>; Mon, 23 Mar 2026 01:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774253503; x=1774858303; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DxHPHyoR51G79qvreYsm93yoJDzWSPCM9EjDZLWw5Qc=;
        b=OQPlepZHyefaeQcbiD7eQSRQP3u8eWA/hkgKvf4W5KloYO94QY+yBQ2MBqdH5ZnK4o
         13f39USj6ewdQC2oPBa/qTEHmhIDUPz169yh+9n1Oazk7dxc31MZ1O5CRQk+qU3NLLdg
         RA7EgA3RvPto41HlBgzkCvXPQytftjarosWf/8OdKRzx3YbMNkMvJ9Pq9rbkn9fq4IYb
         Xmt7sY3YX+jYElF5wOglcCGyTSnmxygTYqUTwHKzxE7Ennvxl0gVyXTzGYCbfb/8LGRJ
         0jrlgPoiGCjcWXk3ec4EmKoojfFYpy49lv/r4zvRNlL49BYnWAQZ1abArVZJxDIBQgHu
         WlCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774253503; x=1774858303;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DxHPHyoR51G79qvreYsm93yoJDzWSPCM9EjDZLWw5Qc=;
        b=c0IG+tjt28JKRFuANEdF0EsTz28rKlbK4efH/KAfpievscCIlkR/soyGQ4rLSnNUkb
         fLL+cdlNyGiXaR6sldtPPINe+wXXsAxSanC0ZPpzNDAo7wWjSEtZ6ouPe+OQyPxEClXc
         eCdtQ9aGiOF3l+gwQjnaGS/KVptDnqlUXSywMvYbQ5/DyM+VRGozMwMSZbAsRyYjqQ4U
         r6KvSRbbJDxTsRjoLzM0BKRvXaVT75k07oFdt0hQ+3fuv2hoqsUESkUVIUyOSnmyrVyO
         y8l801ErEJVHQT0P139jO/rdZQQUO7fDlfd6nZDH8WO7h6DdJKVOitUJOAEjdRk7gVyQ
         fHMw==
X-Forwarded-Encrypted: i=1; AJvYcCWX8UFtR9CCpH+io4BiN2ZT+20D61W5SrT4lfkDSzk5PLAoR1l/RflbJ2517rOlH/vQQlA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNuYju7ZQP98cX+3YG4I29dJsEYE9heUV2bWExxehcC4H5IK25
	t2+ahyF3nAwRB6chicCx/q2qSEQCkqMmdop4w03+8nWWIgS0KAgOO9oM
X-Gm-Gg: ATEYQzyRANnNg6VU87zKwTarBVEE+7w9ZZFoRHwLKb39qdt7l9T+iXY+4otBoUzgtYy
	MpjeGHVC/gSIuHhJwOregDB3yQJbS55xQXXJsTeiYHgCO8Xx7XjQ5QAcKXzdp6dxEbuIsr9G7fJ
	Ti6vNoJ9V4srX6bCLVTOzb0MKBRHm3pSA3QdExL+chyVEaJwSGaEGx5vI8aJp7KZLAJhJAYRtTO
	Aw4PrzQlPskpSeCXJcZGbtmmX9cT9KIYy/PEJZMSNQbG35AHXzb0He6fmYX3d1nIm/LS9CAGcWw
	433PBOCUPnIhqg4kxKPKCl3/qY4LwDBZ3VWXF6O5l+4QU7WNs+SOXCibUu4PTCMa+Lq7YBtpFyK
	J0ujSZxdwB7tFx0X4BE3HfMMcLYpDH9JfwQd/USRgk9UncqEOR0ERRTIJZn7gWY3cc4Z6G1tj+u
	NEaIVG4IJIoUzYEdsTxTr4BPm1nBv/7B/2QMlVA4xfQX7YP6olYNbTmWprm8QpF4hAQOJV
X-Received: by 2002:a17:903:38cf:b0:2ae:47c9:68c4 with SMTP id d9443c01a7336-2b0827f7629mr112157275ad.50.1774253503274;
        Mon, 23 Mar 2026 01:11:43 -0700 (PDT)
Received: from computer.goose-salary.ts.net ([2a09:bac5:40b2:1aaa::2a8:1f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b0836a3370sm101044155ad.78.2026.03.23.01.11.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 01:11:42 -0700 (PDT)
From: Varun R Mallya <varunrmallya@gmail.com>
To: jiayuan.chen@linux.dev,
	yonghong.song@linux.dev,
	bpf@vger.kernel.org,
	sun.jian.kdev@gmail.com
Cc: varunrmallya@gmail.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org
Subject: [PATCH bpf-next v3] selftests/bpf: Improve connect_force_port test reliability
Date: Mon, 23 Mar 2026 13:41:31 +0530
Message-ID: <20260323081131.65604-1-varunrmallya@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The connect_force_port test fails intermittently in CI because the
hardcoded server ports (60123/60124) may already be in use by other
tests or processes [1].

Fix this by passing port 0 to start_server(), letting the kernel assign
a free port dynamically. The actual assigned port is then propagated to
the BPF programs by writing it into the .bss map's initial value (via
bpf_map__initial_value()) before loading, so the BPF programs use the
correct backend port at runtime.

[1] https://github.com/kernel-patches/bpf/actions/runs/22697676317/job/65808536038

Suggested-by: Jiayuan Chen <jiayuan.chen@linux.dev>
Signed-off-by: Varun R Mallya <varunrmallya@gmail.com>
Reviewed-by: Sun Jian <sun.jian.kdev@gmail.com>
---
This patch implements the approach suggested by Yonghong Song in his
review of Jiayuan's v1 patch [2]: fix only the hardcoded port issue
while keeping the existing bpf_object__*() loading model, skipping
the optional skeleton refactor.

[2] https://lore.kernel.org/bpf/6555dc32-b651-4c45-adaf-e3aecb013904@linux.dev/

Changes v2->v3: Changed port type from unsigned short to __u16 and
ASSERT_OK_PTR failures now directly jump to close_bpf_object

 .../bpf/prog_tests/connect_force_port.c       | 26 ++++++++++++++++---
 .../selftests/bpf/progs/connect_force_port4.c | 10 ++++---
 .../selftests/bpf/progs/connect_force_port6.c | 10 ++++---
 3 files changed, 34 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/connect_force_port.c b/tools/testing/selftests/bpf/prog_tests/connect_force_port.c
index 24d553109f8d..dfb7f6cf3ee1 100644
--- a/tools/testing/selftests/bpf/prog_tests/connect_force_port.c
+++ b/tools/testing/selftests/bpf/prog_tests/connect_force_port.c
@@ -53,6 +53,9 @@ static int run_test(int cgroup_fd, int server_fd, int family, int type)
 	__u16 expected_peer_port = 60000;
 	struct bpf_program *prog;
 	struct bpf_object *obj;
+	struct bpf_map *map;
+	__u16 *port_ptr;
+	size_t port_size;
 	const char *obj_file = v4 ? "connect_force_port4.bpf.o" : "connect_force_port6.bpf.o";
 	int fd, err;
 	__u32 duration = 0;
@@ -61,6 +64,21 @@ static int run_test(int cgroup_fd, int server_fd, int family, int type)
 	if (!ASSERT_OK_PTR(obj, "bpf_obj_open"))
 		return -1;
 
+	map = bpf_object__find_map_by_name(obj, ".bss");
+	if (!ASSERT_OK_PTR(map, "find bss map")) {
+		err = -EIO;
+		goto close_bpf_object;
+	}
+
+	port_ptr = bpf_map__initial_value(map, &port_size);
+	if (!ASSERT_OK_PTR(port_ptr, "get bss initial value")) {
+		err = -EIO;
+		goto close_bpf_object;
+	}
+
+	/* Auto assigns the port according to availability */
+	*port_ptr = ntohs(get_socket_local_port(server_fd));
+
 	err = bpf_object__load(obj);
 	if (!ASSERT_OK(err, "bpf_obj_load")) {
 		err = -EIO;
@@ -138,25 +156,25 @@ void test_connect_force_port(void)
 	if (CHECK_FAIL(cgroup_fd < 0))
 		return;
 
-	server_fd = start_server(AF_INET, SOCK_STREAM, NULL, 60123, 0);
+	server_fd = start_server(AF_INET, SOCK_STREAM, NULL, 0, 0);
 	if (CHECK_FAIL(server_fd < 0))
 		goto close_cgroup_fd;
 	CHECK_FAIL(run_test(cgroup_fd, server_fd, AF_INET, SOCK_STREAM));
 	close(server_fd);
 
-	server_fd = start_server(AF_INET6, SOCK_STREAM, NULL, 60124, 0);
+	server_fd = start_server(AF_INET6, SOCK_STREAM, NULL, 0, 0);
 	if (CHECK_FAIL(server_fd < 0))
 		goto close_cgroup_fd;
 	CHECK_FAIL(run_test(cgroup_fd, server_fd, AF_INET6, SOCK_STREAM));
 	close(server_fd);
 
-	server_fd = start_server(AF_INET, SOCK_DGRAM, NULL, 60123, 0);
+	server_fd = start_server(AF_INET, SOCK_DGRAM, NULL, 0, 0);
 	if (CHECK_FAIL(server_fd < 0))
 		goto close_cgroup_fd;
 	CHECK_FAIL(run_test(cgroup_fd, server_fd, AF_INET, SOCK_DGRAM));
 	close(server_fd);
 
-	server_fd = start_server(AF_INET6, SOCK_DGRAM, NULL, 60124, 0);
+	server_fd = start_server(AF_INET6, SOCK_DGRAM, NULL, 0, 0);
 	if (CHECK_FAIL(server_fd < 0))
 		goto close_cgroup_fd;
 	CHECK_FAIL(run_test(cgroup_fd, server_fd, AF_INET6, SOCK_DGRAM));
diff --git a/tools/testing/selftests/bpf/progs/connect_force_port4.c b/tools/testing/selftests/bpf/progs/connect_force_port4.c
index 27a632dd382e..d5be6a559d6a 100644
--- a/tools/testing/selftests/bpf/progs/connect_force_port4.c
+++ b/tools/testing/selftests/bpf/progs/connect_force_port4.c
@@ -14,6 +14,8 @@
 
 char _license[] SEC("license") = "GPL";
 
+__u16 port = 0;
+
 struct svc_addr {
 	__be32 addr;
 	__be16 port;
@@ -40,7 +42,7 @@ int connect4(struct bpf_sock_addr *ctx)
 	if (bpf_bind(ctx, (struct sockaddr *)&sa, sizeof(sa)) != 0)
 		return 0;
 
-	/* Rewire service 1.2.3.4:60000 to backend 127.0.0.1:60123. */
+	/* Rewire service 1.2.3.4:60000 to backend 127.0.0.1:port. */
 	if (ctx->user_port == bpf_htons(60000)) {
 		orig = bpf_sk_storage_get(&service_mapping, ctx->sk, 0,
 					  BPF_SK_STORAGE_GET_F_CREATE);
@@ -51,7 +53,7 @@ int connect4(struct bpf_sock_addr *ctx)
 		orig->port = ctx->user_port;
 
 		ctx->user_ip4 = bpf_htonl(0x7f000001);
-		ctx->user_port = bpf_htons(60123);
+		ctx->user_port = bpf_htons(port);
 	}
 	return 1;
 }
@@ -63,7 +65,7 @@ int getsockname4(struct bpf_sock_addr *ctx)
 		return 1;
 
 	/* Expose local server as 1.2.3.4:60000 to client. */
-	if (ctx->user_port == bpf_htons(60123)) {
+	if (ctx->user_port == bpf_htons(port)) {
 		ctx->user_ip4 = bpf_htonl(0x01020304);
 		ctx->user_port = bpf_htons(60000);
 	}
@@ -79,7 +81,7 @@ int getpeername4(struct bpf_sock_addr *ctx)
 		return 1;
 
 	/* Expose service 1.2.3.4:60000 as peer instead of backend. */
-	if (ctx->user_port == bpf_htons(60123)) {
+	if (ctx->user_port == bpf_htons(port)) {
 		orig = bpf_sk_storage_get(&service_mapping, ctx->sk, 0, 0);
 		if (orig) {
 			ctx->user_ip4 = orig->addr;
diff --git a/tools/testing/selftests/bpf/progs/connect_force_port6.c b/tools/testing/selftests/bpf/progs/connect_force_port6.c
index 19cad93e612f..a1a671b39083 100644
--- a/tools/testing/selftests/bpf/progs/connect_force_port6.c
+++ b/tools/testing/selftests/bpf/progs/connect_force_port6.c
@@ -13,6 +13,8 @@
 
 char _license[] SEC("license") = "GPL";
 
+__u16 port = 0;
+
 struct svc_addr {
 	__be32 addr[4];
 	__be16 port;
@@ -39,7 +41,7 @@ int connect6(struct bpf_sock_addr *ctx)
 	if (bpf_bind(ctx, (struct sockaddr *)&sa, sizeof(sa)) != 0)
 		return 0;
 
-	/* Rewire service [fc00::1]:60000 to backend [::1]:60124. */
+	/* Rewire service [fc00::1]:60000 to backend [::1]:port. */
 	if (ctx->user_port == bpf_htons(60000)) {
 		orig = bpf_sk_storage_get(&service_mapping, ctx->sk, 0,
 					  BPF_SK_STORAGE_GET_F_CREATE);
@@ -56,7 +58,7 @@ int connect6(struct bpf_sock_addr *ctx)
 		ctx->user_ip6[1] = 0;
 		ctx->user_ip6[2] = 0;
 		ctx->user_ip6[3] = bpf_htonl(1);
-		ctx->user_port = bpf_htons(60124);
+		ctx->user_port = bpf_htons(port);
 	}
 	return 1;
 }
@@ -68,7 +70,7 @@ int getsockname6(struct bpf_sock_addr *ctx)
 		return 1;
 
 	/* Expose local server as [fc00::1]:60000 to client. */
-	if (ctx->user_port == bpf_htons(60124)) {
+	if (ctx->user_port == bpf_htons(port)) {
 		ctx->user_ip6[0] = bpf_htonl(0xfc000000);
 		ctx->user_ip6[1] = 0;
 		ctx->user_ip6[2] = 0;
@@ -87,7 +89,7 @@ int getpeername6(struct bpf_sock_addr *ctx)
 		return 1;
 
 	/* Expose service [fc00::1]:60000 as peer instead of backend. */
-	if (ctx->user_port == bpf_htons(60124)) {
+	if (ctx->user_port == bpf_htons(port)) {
 		orig = bpf_sk_storage_get(&service_mapping, ctx->sk, 0, 0);
 		if (orig) {
 			ctx->user_ip6[0] = orig->addr[0];
-- 
2.53.0

