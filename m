Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F9B332614
	for <bpf@vger.kernel.org>; Wed, 24 Jun 2026 18:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782327382; cv=none; b=oJlWpKh1Zz+50/N6W909y4REGsPagALv7dxz0o/8L/idHX5C5oJs7u6uzrIiwXkpbfxl4+EDtaqTtvVhdo2eI/e6IBlDhmbPu1dpXoUFO7BqaC1it3j5yRBbNJgYGKwuPzXhBeM+PcSP97AQUYEwRJAruV+06jXldD4S7ulEt78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782327382; c=relaxed/simple;
	bh=rtacrkfckdTreyVq7wSWNIET8rnylDUoKdi2wT3LMv8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CJQ22SZFH74foAh5bgH6XlLp+BVgsE8F5VFWJrir7ZiQVbWQ59fiuVTGXvv+IRdWxIOFzV1VSvBg35aLDgl2J8uyy5YWjfO2P8+TbFo/frdoFxk3UfHzcd9tWSr50kQy+zZFr3I0hFEjfPD6J8Os4ShAkD6diOjBYktDgx3iB/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=afTPFULn; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="afTPFULn"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-461edb387ddso1598684f8f.3
        for <bpf@vger.kernel.org>; Wed, 24 Jun 2026 11:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782327379; x=1782932179; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uJejxLjgvSOfmGvwul8ifmb1JrNOh8hyxoPi3s5/05k=;
        b=afTPFULnObGryeVTwYYBqPVXBua2hBbFmqNp05ZZnTX1VU9+2c8MHvJmwFFLZJIiEg
         77CPk4r4ApvWkHFCmwpc0eyKHRm1z+5dMXwsmqWn8sLUKj+WGqNMvBAja0yKhsVdpXdW
         iMEoRFhfBKmeHslZ7B54mWVXDKPtFa22YWzS1CcI8lZVhaOEDV8WgyIhSpWbBUbHWZlC
         Q7opnqIJYlpmSwDxU7RxdvxXDjUJ3iLzxRj+EkEbBgxvsNGt2fht+e+YB//SxtXKi75c
         tXFzYhHfp0GQuWn6oHFHQsB1j4hzwuE8lFMVW2IW/jZDe5oN483FKpi65ZaLxfeYOzAj
         HQKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782327379; x=1782932179;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uJejxLjgvSOfmGvwul8ifmb1JrNOh8hyxoPi3s5/05k=;
        b=fwhV1DMPLl3SOkBrPAecmCr9xuhsc+2jzHAFHI8tmVrrjx+CFwqQRQQLWpaLGwA7qI
         LLftlx0DxFRIQAl/E9UL12yMkr97dpEXZ51G5t7V7Frt8SnSEThiXwiAUijlWlzuM0CA
         nOQuLB3wLIoH1CtccN6DiF0+V5YjJyhCoQaK1FcOUL0jFbfqD0nH46iaLHCdhjfOaFrd
         QHP0GdrCbpeRvTmgPz+BK7QTKYg47/dRXt3lwFA6xPQPkN4eq1zyV14HcjkE5dULJebe
         I8rpQIHit4vkt8yk/6eeiY0zXKruXRvHRoZJ4W/5ifCb4I6qTkLqMqRCgvsm3KNc9qTD
         UkkA==
X-Gm-Message-State: AOJu0YxN5ZgbceCzPDvjqLZrosz3v8LjNgL4UHnTp9L7zMFhs/SFPI9Q
	IoIFJFQY7WIxPV0L8KdWn4CO8Le0ohEHlORFuVQa02++OnXCszX/e5aFkdAfJp1pRpE=
X-Gm-Gg: AfdE7ckEJcBI9biE4e1YwC7+dFiuWwwQeV5tYJJUi4CaV4p0ra+TP4lq+sRsdu1UjI+
	wHT4QuowSj+pLHTTxcW5MNovPOSZk65jYDvBNk6oL6UAKrN4Mo2sibveNXjeWJjsRIFhY1GsUG5
	wm4CFMwBDsCLeK44XIcXByeU0CTb/yo8H1penJ26vEHmcCVesNhJ/ZfH3/msbhTYVIOakm8asZx
	+k8wxbwBGfxAysFekaa9OwpG/RX5HtuG+CU1FXC3i9fQf5e5ejaU60s6rGaiL16pg7zv9/K8OE/
	Cu4t0s1w276r5GM0Jl/yA79VxQi3AdehsrbkmIMaBg7sI4qhs6xSrOmADo0NTKcMiqcVFbc5gIW
	uNjRqdaMa+RY8FBtw/ps43bPXCCow6pvCaGgAGIgqcNa4GXVfrxvDHVMszoeylOSZg9bZSggwaq
	MuaSjpmFv+304hyoWq
X-Received: by 2002:a05:600c:4fd1:b0:490:be41:87c6 with SMTP id 5b1f17b1804b1-49260852febmr62687275e9.10.1782327379014;
        Wed, 24 Jun 2026 11:56:19 -0700 (PDT)
Received: from mtardy-friendly-lvh-runner.local ([2600:1900:4010:1a8::])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4926417f0c7sm9847805e9.14.2026.06.24.11.56.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 11:56:18 -0700 (PDT)
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
	Mahe Tardy <mahe.tardy@gmail.com>
Subject: [PATCH bpf-next v9 4/5] selftests/bpf: add bpf_icmp_send recursion test
Date: Wed, 24 Jun 2026 18:55:53 +0000
Message-Id: <20260624185554.362555-5-mahe.tardy@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260624185554.362555-1-mahe.tardy@gmail.com>
References: <20260624185554.362555-1-mahe.tardy@gmail.com>
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

