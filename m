Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAE26BA45
	for <bpf@vger.kernel.org>; Sun, 22 Mar 2026 20:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774212487; cv=none; b=lZhDqiNj5OtF7NUA+wETQlZFjtIhBuwZ3b1nJO9W3Et+lYeDJzFGtn29A1y0c6kTvjP1uQWad2VqMk6GDBqPFSQ8mD4oBJO16WoxqJUDoRA0AZ6WFWiFPbvowlS+u/k6RsO300I2jauBdArc5Cvd2AIAwjJglqEiKxjBhWyJii0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774212487; c=relaxed/simple;
	bh=/7UI/IV+pjr/LE9yHZGHid1IfJvwA2LmWAcQ+CXtDDY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=E/eF4cyCLAqOelOQPhA1EhqTScHS3uLylknx2RqhOijLFccr7CAv0IEvIE+erN4nhyuY+sXGLoaJeo2WJyqItD8OIJ+kcIYYRvH5BHcDVgNkKRl27/tFN8b1s0ajP8m+ve8JOABGmf7w5yB/DJSw+8qBH0iEaQRYjgLS2+x5qRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PVKKWvG/; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PVKKWvG/"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2a7a9b8ed69so45155385ad.2
        for <bpf@vger.kernel.org>; Sun, 22 Mar 2026 13:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774212485; x=1774817285; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oXecQQbnSy+QJzdL0ooJsCPBFQ1mm8juok1pSaE3uRg=;
        b=PVKKWvG/yR3Xf7wCFIRyEyiB1YHNohEUOnGVu3+Qtu3DmkLMW4sRZuji/wedA66Y20
         EPXQaBlDRtd0vtmIUvo5nJ2f0Atsumr49JLg8KOIn4bh7JiEkREKY4J65UgigzDN/vGy
         MnfbB6IQUHvWSuyujLRLHF2iuOsDOvSwE64GZlmxKtkQjsKmw3tUenZ1oin96pJRSmHZ
         FrNTNC3iHL/J/LuTYz4d1QF4olXd/AK8/Cw6T5G5IHFovqOFV/pCtOzWz37PAHDKPPJW
         HGksXe7Tu2yrs72FpRg0nbqO3fCh9+VegHvtILGFeDvJk4GIZBAOc8a8GKnQ8ei/v7Ox
         93tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774212485; x=1774817285;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oXecQQbnSy+QJzdL0ooJsCPBFQ1mm8juok1pSaE3uRg=;
        b=DuZK/h2vBCzRJJOTwLJmWPlXFKGskSDKq9qvqxCVnwk2B/4fHhKMzKc0MyySR0+txa
         29u13dRx7+4u3eK1fh3BNx+91rZNcgfbLE/NEuxVg+dsaa5zT6YmhE+2xocz/4Ws7r8V
         weS175qdOhyfNQRnXI4m9pkNXuh3HnDXP54fkFwaORAvn4U62YfTaTx2OW6rKHBeV2el
         TIb0n+eWKQmdZiVITHYrXOmzpdA67Q4l2oQtTjrak0XKPH1DN3fnBvZ92kRsRi+8L1ui
         xvd58ST0WjPvXmDHIrhjxzfKct415m3utCl2YoIxDKl+HDSUkaQCnq9gtEVQ6+1GCAyl
         FHBw==
X-Forwarded-Encrypted: i=1; AJvYcCUWemA+ELEi9K9Uot7NFkuqGgdyuCncAActrl0krEkmDljF6Si4XRJ9YI5//1Whxx5Y9/8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxr0K//JB2exXUiRdMJRMgv41MmvTMDkKHcPoNec8g3EnEibLpq
	OYiGfDYMfSPMOuN9t6XFHEuWwryXjagkw6ENBaJYDmLCmR9mYRMaKsit
X-Gm-Gg: ATEYQzxM+9o5jRYV5LjrxD6LKpZ254t2w7SwRIO+tW0aeaqbGrgUhNqccZULBMjeeJg
	dkSd9v4xkrwUylnrva1zrh8Je6a04rITC9GiOVjreU7oZ3x3mluWpFxaCnFvbNGQY0FJuAvHF8j
	Gfhjyw8R2ot4RYCDIVfW2hiGDTnOAh/rqFYfli/oadxPvjOzr0FeXfcs9Wekch58Qp6Pg5DUbro
	ZuiTKo3HdT0zJtkpUVlVcL/YZPlMyE82ASTbUoIBbb6v0Vc2V4sGCNgIymP2DQgLjEirXpWlQe1
	5UNb55hyoFn7ARu3vrXTniDHXpUua8xUcZ/NMjqhb/bm58Vori+7NyHJpDchuvblV/LW7PPWxrY
	qgG8PjXgFaW3gt2BMY0kNiCY9cf2mh5zcBWtgMo5+R7QzCqGHgPMRxwf4t2DlaWf3sys81rrM3q
	GXz+I3XslrTDbDKCTDr3c4FHiXY6K/X597tI9xCqN2VMEf/YwBBiSxBgkucZWnJa9mPK6K
X-Received: by 2002:a17:902:ef52:b0:2b0:663f:6b4b with SMTP id d9443c01a7336-2b0827054d4mr88071225ad.18.1774212485129;
        Sun, 22 Mar 2026 13:48:05 -0700 (PDT)
Received: from computer.goose-salary.ts.net ([2a09:bac5:40b2:1aaa::2a8:1f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b0836b15fbsm109202725ad.81.2026.03.22.13.47.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Mar 2026 13:48:04 -0700 (PDT)
From: Varun R Mallya <varunrmallya@gmail.com>
To: jiayuan.chen@linux.dev,
	yonghong.song@linux.dev,
	bpf@vger.kernel.org
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
Subject: [PATCH bpf-next v2] selftests/bpf: Improve connect_force_port test reliability
Date: Mon, 23 Mar 2026 02:17:55 +0530
Message-ID: <20260322204755.39783-1-varunrmallya@gmail.com>
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
---
This patch implements the approach suggested by Yonghong Song in his
review of Jiayuan's v1 patch [2]: fix only the hardcoded port issue
while keeping the existing bpf_object__*() loading model, skipping
the optional skeleton refactor.

[2] https://lore.kernel.org/bpf/6555dc32-b651-4c45-adaf-e3aecb013904@linux.dev/

 .../bpf/prog_tests/connect_force_port.c       | 19 +++++++++++++++----
 .../selftests/bpf/progs/connect_force_port4.c | 10 ++++++----
 .../selftests/bpf/progs/connect_force_port6.c | 10 ++++++----
 3 files changed, 27 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/connect_force_port.c b/tools/testing/selftests/bpf/prog_tests/connect_force_port.c
index 24d553109f8d..f2729211147f 100644
--- a/tools/testing/selftests/bpf/prog_tests/connect_force_port.c
+++ b/tools/testing/selftests/bpf/prog_tests/connect_force_port.c
@@ -53,6 +53,9 @@ static int run_test(int cgroup_fd, int server_fd, int family, int type)
 	__u16 expected_peer_port = 60000;
 	struct bpf_program *prog;
 	struct bpf_object *obj;
+	struct bpf_map *map;
+	unsigned short *port_ptr;
+	size_t port_size;
 	const char *obj_file = v4 ? "connect_force_port4.bpf.o" : "connect_force_port6.bpf.o";
 	int fd, err;
 	__u32 duration = 0;
@@ -61,6 +64,14 @@ static int run_test(int cgroup_fd, int server_fd, int family, int type)
 	if (!ASSERT_OK_PTR(obj, "bpf_obj_open"))
 		return -1;
 
+	/* Auto assigns the port according to availability */
+	map = bpf_object__find_map_by_name(obj, ".bss");
+	if (ASSERT_OK_PTR(map, "find bss map")) {
+		port_ptr = bpf_map__initial_value(map, &port_size);
+		if (ASSERT_OK_PTR(port_ptr, "get bss initial value"))
+			*port_ptr = ntohs(get_socket_local_port(server_fd));
+	}
+
 	err = bpf_object__load(obj);
 	if (!ASSERT_OK(err, "bpf_obj_load")) {
 		err = -EIO;
@@ -138,25 +149,25 @@ void test_connect_force_port(void)
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
index 27a632dd382e..d2beff466902 100644
--- a/tools/testing/selftests/bpf/progs/connect_force_port4.c
+++ b/tools/testing/selftests/bpf/progs/connect_force_port4.c
@@ -14,6 +14,8 @@
 
 char _license[] SEC("license") = "GPL";
 
+unsigned short port = 0;
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
index 19cad93e612f..7b5f3c6040cc 100644
--- a/tools/testing/selftests/bpf/progs/connect_force_port6.c
+++ b/tools/testing/selftests/bpf/progs/connect_force_port6.c
@@ -13,6 +13,8 @@
 
 char _license[] SEC("license") = "GPL";
 
+unsigned short port = 0;
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

