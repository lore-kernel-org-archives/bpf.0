Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E6B4CDA2B
	for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 13:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792157612; cv=none; b=LrrXVnUs8eE6Qz91B2ed/kaysLtfnuN/JfxUG3fMlzvslEthRMhYg+BQFpMuAb/OjKo393poas/a5nJEaINf64iCnKO4+XmUSxv/UPwpqNwrx3TfLjAgRHWjIVCnzGcXayIAqMKpB4EshRZbQAb7omAEhbxzkk741Y+rjWEMX3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792157612; c=relaxed/simple;
	bh=4Y6SYs9MEcs53fXFPlQhL8v/q3rgFtQd5UUjEJH0C5E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ipGlTbm/EZe45kVmxTA8ShWz6YMRlOCvGZezBPOrdU8pcClF/37nX45DUf49mkoNSgLhGikG+O2rHAr6zDRjMchsdszhGCWy0vDJ1PcEWrgVFQhN8T/3o3/newPb7sNzGUaaqO2bzt5uRJP4Z6vclhhfIGoQ6inNmaV3YtvM0S8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dK+l06q6; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dK+l06q6"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4980fe6b3beso6413265e9.0
        for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 06:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792157609; x=1792762409; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=K+TfspIsgszCaheztkekodTGIJdI6RSSRUdKsSKbZVM=;
        b=dK+l06q6x//RnTwPrQ6XKQZ7VfTrt1SpGpP8rawWbvXZL6xzVJqiK8WXRQDw1vMlid
         a9L40bq/vC1gBrctXLKJbbVHRj5H3ALASQma9giN2pkV7pm/LaO/gpYNceMuzYP1netp
         +82IvNQ5VusqEKQz/P+r6Uk4aj08Q40lzlsPr4+rQ0TUqr5dwcTuQYhgHjQJTRZeksLc
         iBDX/P2z3JFUA9Lh3rBFMHPa6+vytsWKautGAvQw10eNaP8RvSAz18GWD+eqTfFL5qbX
         h2jgTg2nO3R56xEsvoOOacyaat1d7oUB8a7W0+07Q5CkcUaMcUUcqYobQBzG4kKbDq/9
         gUJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792157609; x=1792762409;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=K+TfspIsgszCaheztkekodTGIJdI6RSSRUdKsSKbZVM=;
        b=CM/6Gy3XXjvyPHPRmvbg4+5ADuxjqGnDJjE1J/xOI3ZlbPpScHXQg6vti2gibpTqbC
         YOWUXKjCFZ47RpPw7r562uC0TgqfGUjeNB7+2icV1GPsh/f/Y8/87wo2xN+XAY/MyvmE
         h5HGlwv7osSCPQEdJUyNwM1Q7bDeq2QphIjxP4AgtWufrHE1SRbvHOS7h1ZjifFDrZ3u
         WQWROOCpFl2z/wgqRfg/eKwArRxJvXjUBHtOw+mk2Wx0YRV9ocV7uGy448aMKdLAoN12
         ooLfGOSnmoOpZwgb8mXIShxjCXfksWzkPa629tSMordTbSV0CVPoLQK/StS3/ANghk+o
         ZuWw==
X-Gm-Message-State: AFq9FYJxwkvJo2vRL52ebfi1LQUUd40apWGoGO2CGAzVYN2e558E827W
	rQkLVD0+9oVZ9Z9uuVIjTvx82EXAvrLDDQQYsQJy6FpPpe7akprV1IzinSPo8IU8FYc=
X-Gm-Gg: AYBFou2WRwAplnqkJmrmRniAfiPVOcpDEEnxjVv7kIxho2vFWEDXmJkGPILbgR2JVSJ
	oB5F6Pzvu7+xhSG2lJRYAkdpYGa1FEexbcUz0Uq7GXQQeNqi+U/tzcGUMgDmHDYUtD9jfAwCfWC
	OuPeLWROI5ANSMbnvENnCcKCEy8kCmGabYVDZlYp4o3mL/bOmQneBmqyCOxSBqFaKO+bmjaPrF9
	PCisZkUIVvIL36IvDFxLUQ8sogZ3MjURWnYEBLz6OQGFNy51cdeK5ztdFJjqjME8rTeo7+qbxOt
	08wo79vvv/FS4ZQbkO6pQzfvyCMmN2n0JjOcsXbQlR0Gypu+oSgyOxkdCX5y1MrS0VoztgOTT0v
	letWaFSTsWP3+4NomwC4wI0NdHJpUZXDHqF5u+1tUom4DdLBxk3jpvAopw9zmAFZYKAe719Ifru
	69uUMceKRJsuK/U0Pdnmnz/A1aHyXiDTeBY4ol0l7j898kHoyyf6MbZ56lpScNQyxZai7ayxnEn
	e4sesMMGV6ThEYRxsxuTA/35A/mDDrwUm2sU7NfrdnwNA==
X-Received: by 2002:a05:600c:2154:b0:4a1:ac66:604b with SMTP id 5b1f17b1804b1-4a1c6635d20mr51037185e9.1.1792157608917;
        Fri, 16 Oct 2026 06:33:28 -0700 (PDT)
Received: from mtardy-friendly-lvh-runner.europe-west1-c.c.cilium-dev.internal ([2600:1900:4010:1a8::])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4a1cf05009csm42169885e9.10.2026.10.16.06.33.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 06:33:28 -0700 (PDT)
From: Mahe Tardy <mahe.tardy@gmail.com>
To: bpf@vger.kernel.org
Cc: andrii@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	davem@davemloft.net,
	eddyz87@gmail.com,
	edumazet@google.com,
	john.fastabend@gmail.com,
	kuba@kernel.org,
	liamwisehart@meta.com,
	martin.lau@linux.dev,
	pabeni@redhat.com,
	song@kernel.org,
	netdev@vger.kernel.org,
	sdf.kernel@gmail.com,
	ameryhung@gmail.com,
	kuniyu@google.com,
	memxor@gmail.com,
	jiayuan.chen@linux.dev,
	almagui@kernel.org,
	Mahe Tardy <mahe.tardy@gmail.com>
Subject: [PATCH bpf-next v7 2/2] selftests/bpf: Test ksock connect/send calls from wq
Date: Fri, 16 Oct 2026 13:33:18 +0000
Message-ID: <20261016133318.33999-2-mahe.tardy@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261016133318.33999-1-mahe.tardy@gmail.com>
References: <20261016133318.33999-1-mahe.tardy@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extend test_ksock_wq() added in 'c93cbdb13f99 ("selftests/bpf: Add ksock
test for async callback guard")' to test that the bpf_ksock_connect()
and bpf_ksock_send() kfuncs are now allowed and work when called from
workqueues.

Tested-by: Alan Maguire (Oracle) <almagui@kernel.org>
Signed-off-by: Mahe Tardy <mahe.tardy@gmail.com>
---
 .../selftests/bpf/prog_tests/ksock_wq.c       | 29 +++++--
 tools/testing/selftests/bpf/progs/ksock_wq.c  | 80 ++++++++++++++++---
 2 files changed, 95 insertions(+), 14 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/ksock_wq.c b/tools/testing/selftests/bpf/prog_tests/ksock_wq.c
index d6dc20b8f95b..12c2275e8177 100644
--- a/tools/testing/selftests/bpf/prog_tests/ksock_wq.c
+++ b/tools/testing/selftests/bpf/prog_tests/ksock_wq.c
@@ -4,6 +4,7 @@
 #include <unistd.h>

 #include "test_progs.h"
+#include "network_helpers.h"
 #include "ksock_wq.skel.h"

 #define CALLBACK_WAIT_RETRIES 1000
@@ -13,13 +14,22 @@ void test_ksock_wq(void)
 {
 	LIBBPF_OPTS(bpf_test_run_opts, opts);
 	struct ksock_wq *skel;
+	char recv_data[sizeof(skel->data->send_data)];
 	u32 callback_done;
-	int err, i;
+	int err, i, port, rfd;

 	skel = ksock_wq__open_and_load();
 	if (!ASSERT_OK_PTR(skel, "ksock_wq open and load"))
 		return;

+	rfd = start_server(AF_INET, SOCK_DGRAM, "127.0.0.1", 0, 1000);
+	if (!ASSERT_OK_FD(rfd, "receiver socket"))
+		goto out;
+	port = get_socket_local_port(rfd);
+	if (!ASSERT_GE(port, 0, "receiver port"))
+		goto out;
+	skel->bss->remote_port = port;
+
 	err = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.ksock_wq_start),
 				     &opts);
 	if (!ASSERT_OK(err, "run ksock_wq_start"))
@@ -28,18 +38,27 @@ void test_ksock_wq(void)
 		goto out;

 	for (i = 0; i < CALLBACK_WAIT_RETRIES; i++) {
-		if (__atomic_load_n(&skel->bss->callback_done, __ATOMIC_ACQUIRE))
+		if (__atomic_load_n(&skel->bss->callback_done, __ATOMIC_ACQUIRE) == 2)
 			break;
 		usleep(CALLBACK_WAIT_US);
 	}
 	callback_done = __atomic_load_n(&skel->bss->callback_done,
 					__ATOMIC_ACQUIRE);
-	if (!ASSERT_EQ(callback_done, 1, "workqueue callback completed"))
+	if (!ASSERT_EQ(callback_done, 2, "workqueue callbacks completed"))
 		goto out;

-	ASSERT_EQ(skel->bss->create_err, -EOPNOTSUPP,
-		  "workqueue create rejected");
+	ASSERT_EQ(skel->bss->create_ret, -EOPNOTSUPP, "workqueue create rejected");
+
+	if (!ASSERT_EQ(skel->bss->connect_send_ret, sizeof(recv_data),
+		       "workqueue send bytes"))
+		goto out;
+	err = recv(rfd, recv_data, sizeof(recv_data), 0);
+	if (ASSERT_EQ(err, sizeof(recv_data), "recv len"))
+		ASSERT_MEMEQ(recv_data, skel->data->send_data, sizeof(recv_data),
+			     "payload match");

 out:
+	if (rfd >= 0)
+		close(rfd);
 	ksock_wq__destroy(skel);
 }
diff --git a/tools/testing/selftests/bpf/progs/ksock_wq.c b/tools/testing/selftests/bpf/progs/ksock_wq.c
index 16a1873d132e..fab356252d53 100644
--- a/tools/testing/selftests/bpf/progs/ksock_wq.c
+++ b/tools/testing/selftests/bpf/progs/ksock_wq.c
@@ -2,6 +2,7 @@
 /* Copyright (c) 2026 Isovalent */

 #include "vmlinux.h"
+#include <bpf/bpf_endian.h>
 #include <bpf/bpf_helpers.h>
 #include "bpf_experimental.h"
 #include "bpf_tracing_net.h"
@@ -14,15 +15,19 @@ struct ksock_wq_value {

 struct {
 	__uint(type, BPF_MAP_TYPE_ARRAY);
-	__uint(max_entries, 1);
+	__uint(max_entries, 2);
 	__type(key, u32);
 	__type(value, struct ksock_wq_value);
 } work_map SEC(".maps");

-int create_err;
+char send_data[] = "hello from bpf workqueue";
+
+__be16 remote_port;
+int connect_send_ret;
+int create_ret;
 u32 callback_done;

-static int ksock_wq_callback(void *map, int *key, void *value)
+static int ksock_wq_create_cb(void *map, int *key, void *value)
 {
 	struct bpf_ksock_create_opts opts = {
 		.family = AF_INET,
@@ -35,28 +40,85 @@ static int ksock_wq_callback(void *map, int *key, void *value)
 	ks = bpf_ksock_create(&opts, sizeof(opts), &err);
 	if (ks)
 		bpf_ksock_release(ks);
-	create_err = err;
+	create_ret = err;
 	__sync_fetch_and_add(&callback_done, 1);
 	return 0;
 }

-SEC("syscall")
-int ksock_wq_start(void *ctx)
+static int ksock_wq_connect_send_cb(void *map, int *key, void *value)
+{
+	union bpf_ksock_addr addr = {
+		.sin = {
+			.sin_family = AF_INET,
+			.sin_port = remote_port,
+			.sin_addr.s_addr = bpf_htonl(0x7f000001),
+		},
+	};
+	struct bpf_ksock *ks;
+	int err = -ENOENT;
+
+	ks = ksock_ctx_get();
+	if (!ks)
+		goto out;
+	err = bpf_ksock_connect(ks, &addr, sizeof(addr));
+	if (!err)
+		err = bpf_ksock_send(ks, send_data, sizeof(send_data));
+	bpf_ksock_release(ks);
+out:
+	connect_send_ret = err;
+	__sync_fetch_and_add(&callback_done, 1);
+	return 0;
+}
+
+static int wq_set_callback_start(int (*callback_fn)(void *, int *, void *), u32 key)
 {
 	struct ksock_wq_value *value;
-	u32 key = 0;
 	int err;

 	value = bpf_map_lookup_elem(&work_map, &key);
 	if (!value)
 		return -ENOENT;
+
 	err = bpf_wq_init(&value->work, &work_map, 0);
 	if (err)
 		return err;
-	err = bpf_wq_set_callback(&value->work, ksock_wq_callback, 0);
+	err = bpf_wq_set_callback(&value->work, callback_fn, 0);
+	if (err)
+		return err;
+	err = bpf_wq_start(&value->work, 0);
 	if (err)
 		return err;
-	return bpf_wq_start(&value->work, 0);
+
+	return 0;
+}
+
+SEC("syscall")
+int ksock_wq_start(void *ctx)
+{
+	struct bpf_ksock_create_opts opts = {
+		.family = AF_INET,
+		.type = SOCK_DGRAM,
+		.protocol = IPPROTO_UDP,
+	};
+	struct bpf_ksock *ks;
+	int err = 0;
+
+	ks = bpf_ksock_create(&opts, sizeof(opts), &err);
+	if (!ks)
+		return err;
+	err = ksock_ctx_insert(ks);
+	if (err)
+		return err;
+
+	err = wq_set_callback_start(ksock_wq_connect_send_cb, 0);
+	if (err)
+		return err;
+
+	err = wq_set_callback_start(ksock_wq_create_cb, 1);
+	if (err)
+		return err;
+
+	return 0;
 }

 char __license[] SEC("license") = "GPL";
--
2.43.0

