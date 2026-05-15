Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65ABC317148
	for <bpf@vger.kernel.org>; Fri, 15 May 2026 19:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778874488; cv=none; b=a5pY1NL+aXSj1Eq8Nms3dOou4oO2klAJhe8K5tfEfQyaEkExMF0hgjgZ5lCTSP8IQM1HZnwr0RiPOmIYWA3QO/sD+LQpk2gd80K/416yzTu2kK/vRGIzHuYxgXbDeIzv/zVM6ItSuRl+1A8AMdOZEs/c4piWW3W4inNlaY8MPbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778874488; c=relaxed/simple;
	bh=z33ye0i60PX9vlEBXYxh37EExgolSno5MHUulMoYBlg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nTnH05V98sBvH6h+S8xR3OUso7UTXTf5pD+PEgkMjIZ29oMVbBjkD+eHohTJeoPHqTmBHzUBntPW0chzMD6trLrDTjFgMJ47vzb/GT5Z8M2pyLyedkERRYhT6ZbqHwWiy64OhHZFZklcYAf0QpyFHuiCCIJ8aUw/7TI077exleg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TGjsgp//; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TGjsgp//"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4893940bb5eso962525e9.3
        for <bpf@vger.kernel.org>; Fri, 15 May 2026 12:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778874480; x=1779479280; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RuYsOAP7fZ35afAp66D3ijIkrCX23Bql1j3yo75QlAE=;
        b=TGjsgp//FaacfDoxQRxtj9HiIC+Vw/r4jGAWhwgTJl8xACnU94kI3puAX7WI8donCk
         ew75He1vTb9a4H8tGZXWwAyHfe4kUrEjkINrZMbJQleP71ul55jzk0cP4c+pq8DgLeY3
         HjpALIGmuaGra9AbvwSKXXy0jI5jQET+uz6fXVpfrtmK+2ZcQ1ANLPgeREzbR+qEn0jp
         27YjRpDpE9qGKqANEDBzfwOuqhwX2xmPZhU+YeO3fzfudB1XikXMr4tKXXSVDv/b086/
         gcYOgEMk6IiuNtB+kCfJA21gyLa+n1T3Zf0SKltoZ+KhIo1lSalmHKF2NlqHvt0eBBgm
         ZHcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778874480; x=1779479280;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RuYsOAP7fZ35afAp66D3ijIkrCX23Bql1j3yo75QlAE=;
        b=ePFMDVN257n2hfmaeyoQUnIenZY+k379am2qAAjKqtGAcfRPGe8Jmw6Khsu1sh+ole
         iVscbScYgkcaWWIASJUo9uz54stPAqIbSOBcjO463WgYRbCndH1bqADQVk4dGJxFlPUG
         ZP5FONwPf8DVbO9B9U48D9VOJp/vj4SBxRN2zwdHCOTK7Ymm+S0hXLgUZAJIEEyIUAvb
         uR3boUrWJNRcp9M0pfj3ghkAohIDsWkwqHL6qR4K3OE3+kTM0zJNqwyLp5GdiU/2a93d
         DkmPVqJ16pm/wlSnXtw4MVHxk5gZMZBMWYGAfwWvx8Wa9SLSSia8c6xCRZKSy9Ly5zlg
         PmXg==
X-Gm-Message-State: AOJu0YxP9w0Lh7kUMpJNbZLHD7WlDn4Cxb5VRu51dikN7LYjqeudi1ki
	lIeB2XuKcG1lmEcRi+RCaAggA3rcrp8TmSzR00zlk13vtiJXgQifN56lM9ZPWshTYjY=
X-Gm-Gg: Acq92OHQFDQw8Kn6GAgbxKeQdWjAYpK4xqWlwONGnDWGz49N5YbXVDdQiVt8Kf9RWC7
	gEkCG5dfFngxerwyev0sgjEX76wVTSVpZEQtHMswIqm0CJn4yhFkizxbLIpbSdZn5gA7kOAXPMB
	IsaVpvQqH5ywW+oI0vsl7js6NsYSfqKeRKRaye+9qMeUehMS8kQOcUegkk6QsDvhQc8tcfkJhL+
	8cjRMQaSoB1eJUuEBXpJ835qnIavhzF2I5LrerBcDiJGquAYYOlR9UF0WGltnXjkFgGzDDdhfBK
	Tcg5lRkYUGsPMBL4nZsU3xQTspSThivXv+s+fcw/csbRc/gKDK0EZVlOEhWPl9l5rPh9zc1oAPO
	QM0rvi2Dv6IeYGPStG6b1GbruRlyA+Y1pY1q6R0MY2L6kuvBI9DQTc0Yquf6vA1r4CM3vi5A7qt
	bCx82NOyIy845bO7Y0bcjt0tH5HO0mnO5kiRP3VQ==
X-Received: by 2002:a05:600c:310f:b0:48f:d346:e646 with SMTP id 5b1f17b1804b1-48fe60d5693mr71155115e9.10.1778874480427;
        Fri, 15 May 2026 12:48:00 -0700 (PDT)
Received: from mtardy-friendly-lvh-runner.local ([2600:1900:4010:1a8::])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-48fe4c833fcsm77509945e9.2.2026.05.15.12.47.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 12:48:00 -0700 (PDT)
From: Mahe Tardy <mahe.tardy@gmail.com>
To: bpf@vger.kernel.org
Cc: martin.lau@linux.dev,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	ast@kernel.org,
	andrii@kernel.org,
	yonghong.song@linux.dev,
	jordan@jrife.io,
	Mahe Tardy <mahe.tardy@gmail.com>
Subject: [PATCH bpf-next v5 4/4] selftests/bpf: add bpf_icmp_send recursion test
Date: Fri, 15 May 2026 19:47:46 +0000
Message-Id: <20260515194746.50920-5-mahe.tardy@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260515194746.50920-1-mahe.tardy@gmail.com>
References: <20260515194746.50920-1-mahe.tardy@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This test is similar to test_icmp_send_unreach but checks that, in case
of recursion, meaning that the BPF program calling the kfunc was
re-triggered by the icmp_send done by the kfunc, the kfunc will stop
early and return -EBUSY.

The test attaches to the root cgroup to ensure the ICMP packet generated
by the kfunc re-triggers the BPF program. All traffic is allowed to pass
to avoid disrupting unrelated network activity.

Signed-off-by: Mahe Tardy <mahe.tardy@gmail.com>
---
 .../bpf/prog_tests/icmp_send_kfunc.c          | 40 +++++++++++++++++++
 tools/testing/selftests/bpf/progs/icmp_send.c | 31 ++++++++++++++
 2 files changed, 71 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/icmp_send_kfunc.c b/tools/testing/selftests/bpf/prog_tests/icmp_send_kfunc.c
index d9badfc6e620..2363b1c7c711 100644
--- a/tools/testing/selftests/bpf/prog_tests/icmp_send_kfunc.c
+++ b/tools/testing/selftests/bpf/prog_tests/icmp_send_kfunc.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <test_progs.h>
 #include <network_helpers.h>
+#include <cgroup_helpers.h>
 #include <linux/errqueue.h>
 #include <poll.h>
 #include "icmp_send.skel.h"
@@ -10,6 +11,7 @@
 #define ICMP_DEST_UNREACH 3
 #define ICMPV6_DEST_UNREACH 1

+#define ICMP_HOST_UNREACH 1
 #define ICMP_FRAG_NEEDED 4
 #define NR_ICMP_UNREACH 15
 #define ICMPV6_REJECT_ROUTE 6
@@ -173,3 +175,41 @@ void test_icmp_send_unreach(void)
 	icmp_send__destroy(skel);
 	close(cgroup_fd);
 }
+
+void test_icmp_send_unreach_recursion(void)
+{
+	struct icmp_send *skel;
+	int cgroup_fd = -1;
+
+	skel = icmp_send__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel_open"))
+		goto cleanup;
+
+	if (setup_cgroup_environment()) {
+		fprintf(stderr, "Failed to setup cgroup environment\n");
+		goto cleanup;
+	}
+
+	cgroup_fd = get_root_cgroup();
+	if (!ASSERT_GE(cgroup_fd, 0, "get_root_cgroup"))
+		goto cleanup;
+
+	skel->links.recursion =
+		bpf_program__attach_cgroup(skel->progs.recursion, cgroup_fd);
+	if (!ASSERT_OK_PTR(skel->links.recursion, "prog_attach_cgroup"))
+		goto cleanup;
+
+	trigger_prog_read_icmp_errqueue(skel, ICMP_HOST_UNREACH, AF_INET, "127.0.0.1");
+
+	/* Because there's recursion involved, the first call will return at
+	 * index 1 since it will return the second, and the second call will
+	 * return at index 0 since it will return the first.
+	 */
+	ASSERT_EQ(skel->data->rec_kfunc_rets[0], -EBUSY, "kfunc_rets[0]");
+	ASSERT_EQ(skel->data->rec_kfunc_rets[1], 0, "kfunc_rets[1]");
+
+cleanup:
+	cleanup_cgroup_environment();
+	icmp_send__destroy(skel);
+	close(cgroup_fd);
+}
diff --git a/tools/testing/selftests/bpf/progs/icmp_send.c b/tools/testing/selftests/bpf/progs/icmp_send.c
index 6e1ba539eeb0..a2ef6a02c2cb 100644
--- a/tools/testing/selftests/bpf/progs/icmp_send.c
+++ b/tools/testing/selftests/bpf/progs/icmp_send.c
@@ -13,6 +13,9 @@ int unreach_type = 0;
 int unreach_code = 0;
 int kfunc_ret = -1;

+unsigned int rec_count = 0;
+int rec_kfunc_rets[] = { -1, -1 };
+
 SEC("cgroup_skb/egress")
 int egress(struct __sk_buff *skb)
 {
@@ -65,4 +68,32 @@ int egress(struct __sk_buff *skb)
 	return SK_DROP;
 }

+SEC("cgroup_skb/egress")
+int recursion(struct __sk_buff *skb)
+{
+	void *data = (void *)(long)skb->data;
+	void *data_end = (void *)(long)skb->data_end;
+	struct iphdr *iph;
+	int ret;
+
+	iph = data;
+	if ((void *)(iph + 1) > data_end || iph->version != 4)
+		return SK_PASS;
+
+	/* This call will provoke a recursion: the ICMP packet generated by the
+	 * kfunc will re-trigger this program since we are in the root cgroup in
+	 * which the kernel ICMP socket belongs. However when re-entering the
+	 * kfunc, it should return EBUSY.
+	 */
+	ret = bpf_icmp_send(skb, unreach_type, unreach_code);
+	rec_kfunc_rets[rec_count & 1] = ret;
+	__sync_fetch_and_add(&rec_count, 1);
+
+	/* Because we attach the root cgroup, let all traffic pass to avoid
+	 * disrupting unrelated network activity. Otherwise we could just let the
+	 * first ICMP error message pass to trigger recursion and drop the rest.
+	 */
+	return SK_PASS;
+}
+
 char LICENSE[] SEC("license") = "Dual BSD/GPL";
--
2.34.1

