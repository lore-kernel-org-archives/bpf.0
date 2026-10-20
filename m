Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792491929;
	b=DDel+X7dWIHRUbDurHWqtbMqS185TYeivyS6FLBU/7m0iy9peGKjma7ea2KxlpI9qqjv
	 qoIz1eFvsJWaYBq+PfHwRes3yb7bLfvuHEVnNKQnKRXpZc+GHs5pyhxpJW/VIgVO5vazu
	 DuynygNF/sV6IXmddWP3ic6xyXh12FkH+okBH82gkZuDyJlxHj6wJ614F4EGQ+zXtrm5q
	 loQlHfoDff8T572YJ6pZGABvd1Hsujl59YNVoD/tzwngbxSZoKEDpyg8xKru2h/xdJBnS
	 tA0UkuDCRIHaeWbENkDGYZW06NCZoQhz6hnDhMASnVutP40AbxovIFXBbHmkHm/X2DA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792491929;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=56XU7hrsbm+r4VV0OyPWn2c5IYfi16ADafQPzRlPoU4=;
	b=pcoxRrKgDxKok8hadBpJ4M7Gy03LQPcFZIjgck41zmTAAsGyCZyoImkDDPRMRWo9PEnv
	 uLxQnuXmZo9a7A+/Kb0pJKmv8A3QxPZemLBBE96vkNandFMl2bD5KGuMss1sti3hqJUnx
	 kf3He10bTQoNM8pq0+e2DHw7W9U2Y0YGCyZ+5MRhue9hY57UNao4cD42Q6D/Jy8xz3fAq
	 Ay0JVQd8G9/bINr7kbL4bbo0fLodcHZAtM/QP/Rt8Enc2XWwJmEvlzFWcQY+0kk3brEwZ
	 KCHVZo1c6PI4k0LOcIAmEYUHcxLwipNVvJZ66kKbGuTmbKMYUDa3o+UqboVeFuK5YNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=k0p1AR0e;
	arc=none smtp.remote-ip=209.85.221.49
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70EB260A3808
	for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 10:25:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 70EB260A3808
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=k0p1AR0e
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-48dfaa3fa12so386563f8f.0
        for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 03:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792491928; x=1793096728; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=56XU7hrsbm+r4VV0OyPWn2c5IYfi16ADafQPzRlPoU4=;
        b=k0p1AR0enVTbjpRbMalpSdtLebrH8Xx1s0TQEgoxHoAELi2LlZuVJKOY8RJQJ9o1O4
         Ix+2ToBRowrEgZ4NeWthTg2oBScWpxnRRpJC1tQSM8aKuQYrCwyyKXRZkGNC6L9vcRec
         GVtAPOKdT63DY/mkXF9EZK0oAS57X2LV2XOUM1dvmvwbMOUwmIVifw8735tSAsbD+ppT
         om5vgeo9inGrSoxuqMf7vGO+KqX2Uu6jX9e+aCL4cEtFedB97Hsg8Z9orBMySB117AWN
         E33SSgdRoGGapIBJXEexMxnepKznG5M7pFpe8UmBv3xx9qCMZm1HNy/NqcwpyAHNX4xV
         wjOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792491928; x=1793096728;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=56XU7hrsbm+r4VV0OyPWn2c5IYfi16ADafQPzRlPoU4=;
        b=0l3/DTpcU3QJ/ZTNfq0DpUDraQnAPj0AvBDl/Ik24gpMQXdy0W3+bsr5iUoQPMiTJO
         LsbeSV2ypHT+nx90XzAxhOcmiOtb45tYuoFL05+RP9SljL75h9HYr91icDJzqWCcRlLq
         3mFk1MtjF32NlwzO7PIOGEPtIEJpY2dbKHVGsTeDAWbHJroQJYVg8vWA9egMs1kAzZV3
         OgyARyVyvSPCiWfLbZlcjxtCHiZyv4zLUI8EV91Q3NbKxXy872jf4MLu4ORGTK5uEt+B
         79b31PUyPLYZm4DfvHeudtRd34HnZ3zckV3mohIGQnS+/wMXYU2qNtoqfILv8CSJwXtK
         plpg==
X-Gm-Message-State: AFq9FYIQDzd6Xhl70+j0EgKPblrEHjEQi3ZSDbiLuWC7VfL4NTBsARl6
	PIUCmrYOuCFEr9AAV6wGWKCzIp0N1FHzeLDqtEZZFRmt3SBobt0/g8mQVy3T26a014vJrQ==
X-Gm-Gg: AYBFou2+KlGSHCbHb1b5xh1TzgjZjeQHOK3qQTwfyht3iZbgth9L26coRFnbg7qzdC1
	dLb9VkjiaMUdr6LdpByTHDVrcXJl7119+tlBbczYwYQ2gshDhCmNw+6R9Ke3UDlu9rDb6jI3VJ8
	YoQAIRgIZ32WwhyPQ+SOZl11xROE3N/3r6M7svnEZcpTRxkrf1th780bZzp/MjjbGSBzZ/Aj3wD
	zstyz+LvhwTqDFx8UGlyypQeQRAf5OSmC4aQQlS9J800QlhqKnWS4wnXa/1M6uT3PNQkfur/OsJ
	bDNP/z2vRMOoP9TP2wz+wKooiTdgvj+Yxkk/SOSEvm3d4+eTx0xuqzXIv+vAbpwcGEcKbv164aw
	pQ2ZptGF/J4SA6WUxkmS+RLwC1b4EmZKJfVEhjghsFPOa+RoTiecJPzu1OhAbl+OdLj3K2czLp1
	KYuNGyswxxWyZfLpoxSt64RmWR+WVyrmpqgl/6OmlraGSY0FXPBIopaZuUh/2huEEX29lqc4ddW
	hObEiHKC5SErYN5eaqKU0OIS6OZlFltKalg4pOKvPb5jQ==
X-Received: by 2002:a05:600c:5250:b0:4a1:88df:8a2a with SMTP id 5b1f17b1804b1-4a1f4f7fcd3mr31653675e9.13.1792491927715;
        Tue, 20 Oct 2026 03:25:27 -0700 (PDT)
Received: from mtardy-friendly-lvh-runner.europe-west1-c.c.cilium-dev.internal ([2600:1900:4010:1a8::])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4a1f69d9b1esm37544825e9.7.2026.10.20.03.25.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 03:25:27 -0700 (PDT)
From: Mahe Tardy <mahe.tardy@gmail.com>
To: bpf@vger.kernel.org
Cc: andrii@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	davem@davemloft.net,
	willemb@google.com,
	eddyz87@gmail.com,
	edumazet@google.com,
	john.fastabend@gmail.com,
	kuba@kernel.org,
	horms@kernel.org,
	liamwisehart@meta.com,
	martin.lau@linux.dev,
	pabeni@redhat.com,
	song@kernel.org,
	netdev@vger.kernel.org,
	sdf.kernel@gmail.com,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	kuniyu@google.com,
	memxor@gmail.com,
	emil@etsalapatis.com,
	almagui@kernel.org,
	Mahe Tardy <mahe.tardy@gmail.com>
Subject: [PATCH bpf-next 8/8] selftests/bpf: Test ksock sendto()
Date: Tue, 20 Oct 2026 10:25:12 +0000
Message-ID: <20261020102512.518479-9-mahe.tardy@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261020102512.518479-1-mahe.tardy@gmail.com>
References: <20261020102512.518479-1-mahe.tardy@gmail.com>
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

These tests are covering that:
1. sendto() on a unconnected UDP socket works (and that the socket stays
   unconnected, i.e. send() on it fails with -EDESTADDRREQ).
2. sendto() on a connected UDP socket with a NULL address is equivalent
   to send().
3. sendto() on a connected socket with an explicit address doesn't
   change the peer of the socket (send() after sendto() still sends to
   the original connected address).

Signed-off-by: Mahe Tardy <mahe.tardy@gmail.com>
---
 .../selftests/bpf/prog_tests/ksock_sendto.c   | 108 ++++++++++++++++++
 .../selftests/bpf/progs/ksock_common.h        |   2 +
 .../selftests/bpf/progs/ksock_sendto.c        |  59 ++++++++++
 3 files changed, 169 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/ksock_sendto.c
 create mode 100644 tools/testing/selftests/bpf/progs/ksock_sendto.c

diff --git a/tools/testing/selftests/bpf/prog_tests/ksock_sendto.c b/tools/testing/selftests/bpf/prog_tests/ksock_sendto.c
new file mode 100644
index 000000000000..498f0e1be6ee
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/ksock_sendto.c
@@ -0,0 +1,108 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Isovalent */
+
+#include "test_progs.h"
+#include "network_helpers.h"
+#include "ksock_sendto.skel.h"
+
+struct sendto_test_case {
+	const char *name;
+	bool connected;
+	bool use_sendto_addr;
+};
+
+static bool recv_payload(int fd, const void *expected, size_t len)
+{
+	char buf[64];
+	ssize_t n;
+
+	n = recv(fd, buf, sizeof(buf), MSG_TRUNC);
+	if (!ASSERT_EQ(n, len, "recv length"))
+		return false;
+	return ASSERT_MEMEQ(buf, expected, len, "recv payload");
+}
+
+static void test_sendto_case(const struct sendto_test_case *test)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, opts);
+	struct ksock_sendto *skel;
+	int receivers[2] = { -1, -1 };
+	int err, i, port, sendto_fd;
+	char buf[64];
+	ssize_t n;
+
+	skel = ksock_sendto__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "ksock_sendto open and load"))
+		return;
+
+	/* Use separate receivers for the default peer and explicit destination. */
+	for (i = 0; i < ARRAY_SIZE(receivers); i++) {
+		receivers[i] = start_server(AF_INET, SOCK_DGRAM, "127.0.0.1", 0, 1000);
+		if (!ASSERT_OK_FD(receivers[i], "receiver socket"))
+			goto out;
+	}
+
+	port = get_socket_local_port(receivers[0]);
+	if (!ASSERT_GE(port, 0, "connected port"))
+		goto out;
+	skel->bss->connected_port = port;
+	port = get_socket_local_port(receivers[1]);
+	if (!ASSERT_GE(port, 0, "sendto port"))
+		goto out;
+	skel->bss->sendto_port = port;
+	skel->bss->connected = test->connected;
+	skel->bss->use_sendto_addr = test->use_sendto_addr;
+
+	err = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.test_sendto), &opts);
+	if (!ASSERT_OK(err, "run test_sendto") || !ASSERT_OK(opts.retval, "test_sendto retval"))
+		goto out;
+
+	/* Check sendto() outcome */
+	if (!ASSERT_EQ(skel->data->sendto_ret, sizeof(skel->data->sendto_data), "sendto bytes"))
+		goto out;
+	sendto_fd = receivers[test->use_sendto_addr ? 1 : 0];
+	if (!recv_payload(sendto_fd, skel->data->sendto_data, sizeof(skel->data->sendto_data)))
+		goto out;
+
+	/* Check send() outcome */
+	if (test->connected) {
+		if (!ASSERT_EQ(skel->data->send_ret, sizeof(skel->data->send_data), "send bytes"))
+			goto out;
+		if (!recv_payload(receivers[0], skel->data->send_data,
+				  sizeof(skel->data->send_data)))
+			goto out;
+	} else if (!ASSERT_EQ(skel->data->send_ret, -EDESTADDRREQ,
+			      "send after sendto remains unconnected")) {
+		goto out;
+	}
+
+	/* Catch unexpected deliveries to either destination. */
+	for (i = 0; i < ARRAY_SIZE(receivers); i++) {
+		n = recv(receivers[i], buf, sizeof(buf), MSG_DONTWAIT);
+		if (!ASSERT_EQ(n, -1, "no extra datagram") ||
+		    !ASSERT_EQ(errno, EAGAIN, "recv errno"))
+			goto out;
+	}
+
+out:
+	for (i = 0; i < ARRAY_SIZE(receivers); i++) {
+		if (receivers[i] >= 0)
+			close(receivers[i]);
+	}
+	ksock_sendto__destroy(skel);
+}
+
+void test_ksock_sendto(void)
+{
+	static const struct sendto_test_case tests[] = {
+		{ .name = "unconnected", .use_sendto_addr = true },
+		{ .name = "connected_null_addr", .connected = true },
+		{ .name = "connected_explicit_addr", .connected = true, .use_sendto_addr = true },
+	};
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(tests); i++) {
+		if (test__start_subtest(tests[i].name))
+			test_sendto_case(&tests[i]);
+	}
+}
diff --git a/tools/testing/selftests/bpf/progs/ksock_common.h b/tools/testing/selftests/bpf/progs/ksock_common.h
index 01edaeb9fdd4..2a32cff2fbe9 100644
--- a/tools/testing/selftests/bpf/progs/ksock_common.h
+++ b/tools/testing/selftests/bpf/progs/ksock_common.h
@@ -16,6 +16,8 @@ int bpf_ksock_connect(struct bpf_ksock *ks, const union bpf_ksock_addr *addr,
 struct bpf_ksock *bpf_ksock_acquire(struct bpf_ksock *ks) __ksym;
 void bpf_ksock_release(struct bpf_ksock *ks) __ksym;
 int bpf_ksock_send(struct bpf_ksock *ks, const void *data, u32 data__sz) __ksym;
+int bpf_ksock_sendto(struct bpf_ksock *ks, const void *data, u32 data__sz,
+		     const union bpf_ksock_addr *addr__nullable, u32 addr__sz) __ksym;
 void bpf_rcu_read_lock(void) __ksym;
 void bpf_rcu_read_unlock(void) __ksym;

diff --git a/tools/testing/selftests/bpf/progs/ksock_sendto.c b/tools/testing/selftests/bpf/progs/ksock_sendto.c
new file mode 100644
index 000000000000..b6eacf277fcb
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/ksock_sendto.c
@@ -0,0 +1,59 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026 Isovalent */
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_endian.h>
+#include "bpf_tracing_net.h"
+#include "ksock_common.h"
+
+char sendto_data[] = "hello from bpf sendto";
+char send_data[] = "hello from bpf send";
+
+__be16 connected_port;
+__be16 sendto_port;
+bool connected;
+bool use_sendto_addr;
+int sendto_ret = -1;
+int send_ret = -1;
+
+SEC("syscall")
+int test_sendto(void *ctx)
+{
+	struct bpf_ksock_create_opts opts = {
+		.family = AF_INET,
+		.type = SOCK_DGRAM,
+		.protocol = IPPROTO_UDP,
+	};
+	union bpf_ksock_addr addr = {};
+	struct bpf_ksock *ks;
+	int err = 0;
+
+	ks = bpf_ksock_create(&opts, sizeof(opts), &err);
+	if (!ks)
+		return err;
+
+	addr.sin.sin_family = AF_INET;
+	addr.sin.sin_addr.s_addr = bpf_htonl(0x7f000001);
+	if (connected) {
+		addr.sin.sin_port = connected_port;
+		err = bpf_ksock_connect(ks, &addr, sizeof(addr));
+		if (err)
+			goto out;
+	}
+
+	addr.sin.sin_port = sendto_port;
+	if (use_sendto_addr)
+		sendto_ret = bpf_ksock_sendto(ks, sendto_data, sizeof(sendto_data),
+					      &addr, sizeof(addr));
+	else
+		sendto_ret = bpf_ksock_sendto(ks, sendto_data, sizeof(sendto_data), NULL, 0);
+
+	/* sendto() must neither connect the socket nor change its default peer. */
+	send_ret = bpf_ksock_send(ks, send_data, sizeof(send_data));
+out:
+	bpf_ksock_release(ks);
+	return err;
+}
+
+char __license[] SEC("license") = "GPL";
--
2.43.0

