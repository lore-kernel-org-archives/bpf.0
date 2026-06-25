Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC263002B3
	for <bpf@vger.kernel.org>; Thu, 25 Jun 2026 11:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782385417; cv=none; b=N2FmDmLEtLAgW0vnUrmVPlxZE1MjJ5m5Xbp1pTsFDL8GvU+RrhTkbjcNs03UKOdhEGa7RBJVD0wevBqRPqJBlbB5Yh/jK/GsdoF+ueYOp6Mp8k/QydDKhX7BDeIGdyZeFN9FSqQNCrsMirqO0aeSMaUvewq3wtWZtwtb8GFRLVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782385417; c=relaxed/simple;
	bh=3apo50H6MD+67sS62kyBBDqnarN0kbECnERY7Wfj4nk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=L2gsLN7aq2drUt9U+SbnDktZRrpmkyXJq5DnO9+QmHUF/K7klVgS/0vT7w/Y7Fd/sM8GR50Z5kmIDmXYi3VvxF2iMdA1mFvDNxbzeZ2rGbagNwSHgNNRdQX9N/ib6QwaK98YqKy9xwqbwZzmeBfB3Fgwt63e62Ogx0J0eNCFhv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XqDxyAQE; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XqDxyAQE"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-4631679f204so433647f8f.0
        for <bpf@vger.kernel.org>; Thu, 25 Jun 2026 04:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782385411; x=1782990211; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+9sX1JGZkJHDeEjSfUGdSrnN2laXL1fB9Eoj82w+fvM=;
        b=XqDxyAQElJWHqgxV05dspKEHZdXY+yqOo6CPsarEncEvSmvScYVqMamu6je0EGHv7q
         63jIKp6Oo1o8PnWPE21VkVLALSkEtJDIjSb8/ICOUjs7ts8x8fpf/6LRILVAq+p3sJgv
         6mbX7T92n/IcCDJLyS9RBFHR4BaNL6gwy5t4dbyMHkKe/reAlqRX7qpG77S0XRKBugjs
         yZqf05XsROOxN1bUKTWd2IhraGWYCaKYdKAJd93Vr+dOVNrqB6TATuFQTvVfC/XBavGo
         4wVnX2B0+xmdGi8rcTW+lvb1UYqiBLU/Tn+Y9HQMZo8m5HOAp1CUpO0Z89WJt0Py4lkJ
         KdVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782385411; x=1782990211;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+9sX1JGZkJHDeEjSfUGdSrnN2laXL1fB9Eoj82w+fvM=;
        b=rVDwMT9bBxoE+3DFRlWk73fBWD7q60iFU5/+spLjExvGUwC5dhpdjVToeWnVZZTMGD
         ny5ZgTP3E453c/PP35QEWjXzTwKMQLH+Ww0OCIRxCJov84Fvt3BUTbNHXkFjCuYg61bU
         pHt7Gi7ZTvyTeGcfhqVBR9XWqVAZRZY2gL5mi+ry67ah2yBX8JUMpHi5DNhNzlEetSdC
         p8QF1Ve6hHBBGg/EWUvMOqGV2gSKpa3bOTMZv//5pUG3yywh5+lvbryoJWW1YOzLGkpW
         dFWHUTPX03/TsYSJhYLjk7Q0Ulr1Wi09EJRQAAZU8ppKBh7ZgkFB0UcGDyQHtHRjcfuX
         uLJw==
X-Gm-Message-State: AOJu0YxaByzI9/k2PBzB4nxa2e0RM42BLHhm29mgCp9W/r7u9OZux+hK
	ffOqrNK1VqHpIY3WpP4WRLSTIh430xsOB4W7UNU74dTC8XItnMTphTQ1I6PgbpCOnkg=
X-Gm-Gg: AfdE7ckgf1Re91sjU7l5PgPSP3motrm0kGddd+BNygujz0IDWcDotcVpsno2rIF5Qct
	Ww3+Gy1mDQ7mdSzUUywq9X1FjIGugYK0t/acbKbVhqcaB7F/DpeID9pTDr8SD7+I16vIWsvSVRa
	qS97cXm0QGdQSv2qdBUFlAkeg0QFH7Fry8uaTB/pmQVJuMbszPkeia1dXXpVr7bF0sbtO0/804Q
	QHyvMCAVmr04jC6zxqjMWZ34CQm/gsrg271URt5lRXaRZRg9dvd8RLlok2aLhDaNe2hq4Y13vPe
	7ZMV5yQJggVQcPw5KmYo8PVIRId+FDbgOR9lzcK1JUEo2DPpQW/8pLRmpVMSxv6EVJi4W4xhzFA
	ei2BHJIDxMphrcM0KADldWFioeKhc5gCGESmtEGyIAtRFDZxlmjFP6YPrIeN0srPYVJ8M8oHvz3
	DG+uH/kQeoWRN6unry
X-Received: by 2002:a5d:453a:0:b0:468:15a8:e061 with SMTP id ffacd0b85a97d-46a806bc914mr13223518f8f.18.1782385410572;
        Thu, 25 Jun 2026 04:03:30 -0700 (PDT)
Received: from mtardy-friendly-lvh-runner.local ([2600:1900:4010:1a8::])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-46c9ed7491esm11071917f8f.37.2026.06.25.04.03.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jun 2026 04:03:30 -0700 (PDT)
From: Mahe Tardy <mahe.tardy@gmail.com>
To: bpf@vger.kernel.org
Cc: andrii@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	jordan@jrife.io,
	martin.lau@linux.dev,
	yonghong.song@linux.dev,
	emil@etsalapatis.com,
	netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	horms@kernel.org,
	Mahe Tardy <mahe.tardy@gmail.com>
Subject: [PATCH bpf-next v10 4/5] selftests/bpf: add bpf_icmp_send recursion test
Date: Thu, 25 Jun 2026 11:03:20 +0000
Message-Id: <20260625110321.28236-5-mahe.tardy@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260625110321.28236-1-mahe.tardy@gmail.com>
References: <20260625110321.28236-1-mahe.tardy@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This test is similar to test_icmp_send_unreach_cgroup but checks that,
in case of recursion, meaning that the BPF program calling the kfunc was
re-triggered by the icmp_send done by the kfunc, the kfunc will stop
early and return -EBUSY.

The test attaches to the root cgroup to ensure the ICMP packet generated
by the kfunc re-triggers the BPF program.

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
Reviewed-by: Jordan Rife <jordan@jrife.io>
Signed-off-by: Mahe Tardy <mahe.tardy@gmail.com>
---
 .../bpf/prog_tests/icmp_send_kfunc.c          | 46 ++++++++++++++++
 tools/testing/selftests/bpf/progs/icmp_send.c | 55 +++++++++++++++++++
 2 files changed, 101 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/icmp_send_kfunc.c b/tools/testing/selftests/bpf/prog_tests/icmp_send_kfunc.c
index bbb3c3d4509c..bb532aa0d158 100644
--- a/tools/testing/selftests/bpf/prog_tests/icmp_send_kfunc.c
+++ b/tools/testing/selftests/bpf/prog_tests/icmp_send_kfunc.c
@@ -1,8 +1,10 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <test_progs.h>
 #include <network_helpers.h>
+#include <cgroup_helpers.h>
 #include <linux/errqueue.h>
 #include <poll.h>
+#include <unistd.h>
 #include "icmp_send.skel.h"

 #define TIMEOUT_MS 1000
@@ -10,6 +12,7 @@
 #define ICMP_DEST_UNREACH 3
 #define ICMPV6_DEST_UNREACH 1

+#define ICMP_HOST_UNREACH 1
 #define ICMP_FRAG_NEEDED 4
 #define NR_ICMP_UNREACH 15
 #define ICMPV6_REJECT_ROUTE 6
@@ -195,3 +198,46 @@ void test_icmp_send_unreach_cgroup(void)
 	if (cgroup_fd >= 0)
 		close(cgroup_fd);
 }
+
+void test_icmp_send_unreach_recursion(void)
+{
+	struct icmp_send *skel;
+	int cgroup_fd = -1;
+	int err;
+
+	err = setup_cgroup_environment();
+	if (!ASSERT_OK(err, "setup_cgroup_environment"))
+		return;
+
+	skel = icmp_send__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "skel_open"))
+		goto cleanup;
+
+	cgroup_fd = get_root_cgroup();
+	if (!ASSERT_OK_FD(cgroup_fd, "get_root_cgroup"))
+		goto cleanup;
+
+	skel->data->target_pid = getpid();
+	skel->links.recursion =
+		bpf_program__attach_cgroup(skel->progs.recursion, cgroup_fd);
+	if (!ASSERT_OK_PTR(skel->links.recursion, "prog_attach_cgroup"))
+		goto cleanup;
+
+	trigger_prog_read_icmp_errqueue(skel, ICMP_HOST_UNREACH, AF_INET,
+					"127.0.0.1");
+
+	/*
+	 * Because there's recursion involved, the first call will return at
+	 * index 1 since it will return the second, and the second call will
+	 * return at index 0 since it will return the first.
+	 */
+	ASSERT_EQ(skel->bss->rec_count, 2, "rec_count");
+	ASSERT_EQ(skel->data->rec_kfunc_rets[0], -EBUSY, "kfunc_rets[0]");
+	ASSERT_EQ(skel->data->rec_kfunc_rets[1], 0, "kfunc_rets[1]");
+
+cleanup:
+	icmp_send__destroy(skel);
+	if (cgroup_fd >= 0)
+		close(cgroup_fd);
+	cleanup_cgroup_environment();
+}
diff --git a/tools/testing/selftests/bpf/progs/icmp_send.c b/tools/testing/selftests/bpf/progs/icmp_send.c
index 6e1ba539eeb0..c642ccdf9fd5 100644
--- a/tools/testing/selftests/bpf/progs/icmp_send.c
+++ b/tools/testing/selftests/bpf/progs/icmp_send.c
@@ -12,6 +12,10 @@ __u16 server_port = 0;
 int unreach_type = 0;
 int unreach_code = 0;
 int kfunc_ret = -1;
+int target_pid = -1;
+
+unsigned int rec_count = 0;
+int rec_kfunc_rets[] = { -1, -1 };

 SEC("cgroup_skb/egress")
 int egress(struct __sk_buff *skb)
@@ -65,4 +69,55 @@ int egress(struct __sk_buff *skb)
 	return SK_DROP;
 }

+SEC("cgroup_skb/egress")
+int recursion(struct __sk_buff *skb)
+{
+	void *data = (void *)(long)skb->data;
+	void *data_end = (void *)(long)skb->data_end;
+	struct icmphdr *icmph;
+	struct tcphdr *tcph;
+	struct iphdr *iph;
+	int ret;
+
+	if ((bpf_get_current_pid_tgid() >> 32) != target_pid)
+		return SK_PASS;
+
+	iph = data;
+	if ((void *)(iph + 1) > data_end || iph->version != 4)
+		return SK_PASS;
+
+	if (iph->daddr != bpf_htonl(SERVER_IP))
+		return SK_PASS;
+
+	if (iph->protocol == IPPROTO_TCP) {
+		tcph = (void *)iph + iph->ihl * 4;
+		if ((void *)(tcph + 1) > data_end ||
+		    tcph->dest != bpf_htons(server_port))
+			return SK_PASS;
+	} else if (iph->protocol == IPPROTO_ICMP) {
+		icmph = (void *)iph + iph->ihl * 4;
+		if ((void *)(icmph + 1) > data_end ||
+		    icmph->type != unreach_type || icmph->code != unreach_code)
+			return SK_PASS;
+	} else {
+		return SK_PASS;
+	}
+
+	/*
+	 * This call will provoke a recursion: the ICMP packet generated by the
+	 * kfunc will re-trigger this program since we are in the root cgroup in
+	 * which the kernel ICMP socket belongs. However when re-entering the
+	 * kfunc, it should return EBUSY.
+	 */
+	ret = bpf_icmp_send(skb, unreach_type, unreach_code);
+	rec_kfunc_rets[rec_count & 1] = ret;
+	__sync_fetch_and_add(&rec_count, 1);
+
+	/* Let the first ICMP error message pass */
+	if (iph->protocol == IPPROTO_ICMP)
+		return SK_PASS;
+
+	return SK_DROP;
+}
+
 char LICENSE[] SEC("license") = "Dual BSD/GPL";
--
2.34.1

