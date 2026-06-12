Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C66573016EE
	for <bpf@vger.kernel.org>; Fri, 12 Jun 2026 01:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781226924; cv=none; b=FskUR+loGbyfbuSdlMsGrUNXwjx1hOSbLDXHhBTa88gyfV2dWpBg9/Qc6Jp4MtqtyaNyTU8e0r0vKJdKif4ZLuF+JZZu5GDCEiOuGAoqQBcej7m7YqI4Ous5Z3EWSZEYx82DARR5X/L88pzDvpjDJjUvuh1v7fkgaNe6QuBO/Bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781226924; c=relaxed/simple;
	bh=oaBfO3K+ZJ8s5V8OQ2o6xH7AxFaOCGtC9XINJ5gRcLw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cmyQaKTaFXwrQxcUZPhtq5ZMJr1k7Oz+AFVfgyrf4plgUJU1torcqSvoBN9/nOnHbMA/uaz7HYm39QGpCfKZQDty2IiLUYoxJrarqbcokQLbwVl1AKSN4+MfCGRcB1b5tcmy4hJcy6d7AUX6Ctin2iwtnQn/M5psxoTYNu0YOLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kzqkRmgY; arc=none smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kzqkRmgY"
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-1370417c01cso531476c88.1
        for <bpf@vger.kernel.org>; Thu, 11 Jun 2026 18:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781226922; x=1781831722; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qt90eA0uj1dpnA038RPJBctS/XyV3l3vqMVH4k+Tb2I=;
        b=kzqkRmgY7k1dui6LsfSF7sxxqwLqC3GT1wxAEIpAwWPR6b2zgrFRVSTlQ8KseVThks
         1zpf4sp+5yLKuhGtMzkOw8Bvwd5VbmBb64DyGchjmCrw85HK9a0q+KIdjYQobZC21mkH
         PFDKfaKjaiChb7y+eLRMm+IzDUNgCn2oqey/thlkAc1qC0JvUe3INmZ7clWqJmaqpghk
         aSUfuY4lQHFtCU3hnrMo8DRJuPyv/wb6BfEAQym/dvzQrvXIrh/P9BeGEl6F+vPg6zEA
         OgA3GjbAEdThPmcQ1ChN6dHekwPlHhws0asCqBHPdyXWz3diPo0EoKkYj2t6WdeX1TGU
         wGmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781226922; x=1781831722;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Qt90eA0uj1dpnA038RPJBctS/XyV3l3vqMVH4k+Tb2I=;
        b=Q5vNkdAlVd2hy73d9DPu9EY+U2JVL/O+T6TkE3s9GJFxqo2tVmYdAgWPAcBTSABuqQ
         aFlpg9H+y0bsRIMo0hf67ke71hAjzeZ/F42VxF9cP9DNcIQc/qQLzQDZ9Y6f2GCA7+CS
         0WdHbICrijz/+fLM539UNtqV39zHhIto5Sot+mJLjjdmx8tWhXA6CJ2eJd+xZv2T53dT
         rFOamZu+n/8QU1dSSm6Ne/wC0NJdnph8MqrWAKULQwoFUz6CvXVboiZMY2sbAiIZNbyT
         neO9Y/Mte6JIyRArdPGAU6QKybQtaDxI1B2Qyujxb7gQZ384iD9zQtrWEnwNUq2MfLg/
         QbjA==
X-Gm-Message-State: AOJu0Yy73RRauUOvWkVb524lXgJdpq238tKnkwBcwcupDsyJ5asDwQ2C
	YkIZVvnfkdikVGjahiGfvF7c8BCA2TpiEGd2S4ELnlRAvQJ1BoxB/nZP
X-Gm-Gg: Acq92OHkGWMG+ZrAXmcq1KqSq1zjTsC5UrBcN1XdzjXQVR3duWJrnoQC3EauPcjbvC8
	n+U8hjiDtAxsg7Hr3FtdjzBlK0Ivf2KKBw0ESO9JLzP711LfLajWGpJb1d/nBsN0aMqmOM4G3Og
	/4aYukdPNijOexSf88ZhZ3GD8ScYPkUB1mybpaTk7pvBPM5BxEEuhE3UvYd2hqbZUwoQLpadyMl
	qKCl9vIR7/DStdVM8ePDtVMKFUBzse6vla706f2c1DT4Bs75O7VP9PPzN1Cor1ZYTuHKA3oJK1H
	g2946jRUcL+8cipCSuYlaizVO5PS+GoDVJTfOoVe0QmqHn9i19nJd4rY/GXqIzrptz9zxo7Pvhe
	jTWUZXgZRzrO/f7uWNvLtKIl6eNiWjEzn1pmqKS0W+czGEu8bkN805+GF6g6gej1CAJYuPvgq2L
	qgHZNZOtbqWkywwA612tv+eudlW/yghQ6g0Zk3YNdjXyoXGm9k6ADCMDFQQQaFx9L4rg==
X-Received: by 2002:a05:7022:6888:b0:138:3e8:cee1 with SMTP id a92af1059eb24-1384bbb6c0fmr308421c88.23.1781226921767;
        Thu, 11 Jun 2026 18:15:21 -0700 (PDT)
Received: from pop-os.scu.edu ([129.210.115.107])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1384b975e55sm596257c88.13.2026.06.11.18.15.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 18:15:21 -0700 (PDT)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	John Fastabend <john.fastabend@gmail.com>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	hemanthmalla@gmail.com,
	zijianzhang@bytedance.com,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Cong Wang <cwang@multikernel.io>
Subject: [RFC PATCH bpf-next 2/5] tcp_bpf: busy-poll the splice ring before parking the receiver
Date: Thu, 11 Jun 2026 18:14:49 -0700
Message-ID: <20260612011452.134466-3-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260612011452.134466-1-xiyou.wangcong@gmail.com>
References: <20260612011452.134466-1-xiyou.wangcong@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a paired-splice receiver finds the ring empty it parks on the
socket waitqueue. For latency-bound synchronous-RPC workloads that is
a wakeup per request-response cycle, which dominates the per-cycle
cost.

Add an optional bounded busy-poll of the ring before parking, reusing
the socket's SO_BUSY_POLL budget (sk_ll_usec) via sk_can_busy_loop()
and sk_busy_loop_timeout(). The default budget of 0 leaves
sk_can_busy_loop() false, so this is a no-op unless the application
(or net.core.busy_read) opted in.

Unlike sk_busy_loop() / napi_busy_loop(), splice_busy_loop() spins on
the in-kernel ring directly rather than polling a NAPI instance, so it
is effective on loopback - which delivers via the per-CPU backlog and
exposes no pollable napi_id. Keeping the receiver hot lets a
synchronous sender's small writes accumulate in the ring without a
wakeup per message; this is what turns the latency-bound TCP_RR case
into a large win once enabled.

A BPF program enables the budget by setting SO_BUSY_POLL via
bpf_setsockopt() (see the following patch). netperf, pinned CPUs,
3x10s, 50 us budget, baseline TCP vs splice + busy-poll:

  TCP_RR (loopback)    1 B    111.9k -> 1113.8k tps  (9.96x)
                       64 B   111.7k -> 1073.3k tps  (9.61x)
                       1 KB   106.1k ->  713.0k tps  (6.72x)
                       16 KB   40.3k ->  123.7k tps  (3.07x)
                       64 KB   17.8k ->   40.5k tps  (2.28x)

  TCP_RR (container)   1 B    105.6k -> 1103.7k tps  (10.45x)
                       64 B   105.5k -> 1103.9k tps  (10.46x)
                       1 KB   100.4k ->  704.9k tps  (7.02x)
                       16 KB   45.1k ->  114.8k tps  (2.54x)
                       64 KB   18.2k ->   38.8k tps  (2.13x)

Busy polling contributes ~4.2x of the 1 B loopback win (splice without
it is 267.0k tps; see the splice patch). Baseline TCP is unchanged by
busy_read on both loopback and default (non-XDP) veth: both deliver via
the per-CPU backlog, which has no pollable napi_id, so SO_BUSY_POLL is a
no-op for them (the container baseline TCP_RR measures the same at
busy_read 0 and 50). The gain therefore comes from the splice ring spin,
not from busy_read itself.

Assisted-by: Claude:claude-opus-4.8
Signed-off-by: Cong Wang <cwang@multikernel.io>
---
 net/ipv4/tcp_bpf.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
index 549f37077244..9c4421a74225 100644
--- a/net/ipv4/tcp_bpf.c
+++ b/net/ipv4/tcp_bpf.c
@@ -13,6 +13,7 @@
 #include <linux/util_macros.h>
 #include <linux/percpu-refcount.h>
 
+#include <net/busy_poll.h>
 #include <net/inet_common.h>
 #include <net/inet_sock.h>
 #include <net/tls.h>
@@ -1255,6 +1256,33 @@ static long splice_recv_wait(struct sock *sk, struct sk_psock_splice *s,
 					splice_recv_ready(sk, s), timeo);
 }
 
+/* Bounded busy-poll on the ring before parking the receiver. Reuses the
+ * socket's SO_BUSY_POLL budget (sk_ll_usec) via sk_can_busy_loop() and
+ * sk_busy_loop_timeout(); the default budget of 0 makes sk_can_busy_loop()
+ * false so this is a no-op unless the application (or net.core.busy_read)
+ * opted in.
+ *
+ * Unlike sk_busy_loop() / napi_busy_loop(), this spins on the in-kernel
+ * ring directly rather than polling a NAPI instance, so it is effective on
+ * loopback - which delivers via the per-CPU backlog and exposes no
+ * pollable napi_id. Keeping the receiver hot lets a synchronous sender's
+ * small writes accumulate in the ring without a wakeup per message.
+ */
+static void splice_busy_loop(struct sock *sk, struct sk_psock_splice *s)
+{
+	unsigned long start;
+
+	if (!sk_can_busy_loop(sk))
+		return;
+
+	start = busy_loop_current_time();
+	do {
+		cpu_relax();
+		if (splice_recv_ready(sk, s) || signal_pending(current))
+			return;
+	} while (!sk_busy_loop_timeout(sk, start));
+}
+
 /* prot->sock_is_readable for paired-splice sockets. tcp_stream_is_readable()
  * (via tcp_poll() / select() / epoll) consults this to mark POLLIN when
  * sk_receive_queue is empty - we must also report data sitting in the
@@ -1349,6 +1377,16 @@ static int tcp_bpf_splice_recvmsg(struct sock *sk,
 			return 0;
 		}
 
+		/* Spin on the ring for the SO_BUSY_POLL budget before
+		 * sleeping. If the spin observes data, re-read from the
+		 * loop head; otherwise (budget expired or a terminal
+		 * condition) proceed to park - splice_recv_wait() returns
+		 * immediately for terminal conditions.
+		 */
+		splice_busy_loop(sk, s);
+		if (splice_ring_has_data(s))
+			continue;
+
 		timeo = splice_recv_wait(sk, s, timeo);
 	}
 }
-- 
2.43.0

