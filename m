Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 095253783A0
	for <bpf@vger.kernel.org>; Tue, 26 May 2026 15:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779809854; cv=none; b=W6sLUWfoZExB+fpUTXK7sJ1r/VQJSFn37nlfVKwpu0c8xCiusiGBuDYNaMxtMi6Y/0g1QgXwyMoP0i0wG6U2w9FTk1/hubE9ksfzRr4cyDm6yPMOfGa+wu9VOGwD6jVUnvWs3fb3zeVcH24TBKaBFe6UDcu4lAQ9bNCwQ+ozNmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779809854; c=relaxed/simple;
	bh=aHiP5iPDgTnfx2MlFNZtRtLLl24SwK+8MfSYE5ZAVhE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=a9ON3HPh8btlnWmnXeViYcrwISiaTpiWfSYvjnR4FWa/dtnJkVyS7dkq56BEqY2nyT99qnCfvjwIEwIBXrcUYbmryk2506YTQtV+C3Tl5nsxMcmmDq/emXmYuReuaolRlgqFmlrLn2+1caNWFPgi+y0TMEXh6Iq5GVWNllkxu9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O4qqI6iA; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O4qqI6iA"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4906238c62eso22078285e9.3
        for <bpf@vger.kernel.org>; Tue, 26 May 2026 08:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779809851; x=1780414651; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X9PBIjlRM30LWt9CU8BNuDCg7sgYuhWgWgktG0ZmDLI=;
        b=O4qqI6iAhdOgkB4aYzm3DT3o7HJiI+uzEE+cr1mN0076ylsVg0bBBftDtX4OBWihpd
         D4GueLSK62FXwTHox+B0W0jOFf9//4c459AlDHrv15iPy1HoNR0DgSwVtd5kGdNHZa7N
         56BRqnFL9XSFYsiOtcD4Yv+52kq1gH99gB25F1Ddw+7ksI3UczURRfHAxOBJqNM0274z
         DixwogMr5ddkngvpVgTkK/sLUtjziu1S9cbs4uB4zjLFarMbhNtw+jRfOZk5tvkTyfQ7
         Bx2gWBLRn2NLpI46eponPmoQvJF+gLMR/vVRaQiW4JRRFzdg4xaWcOVg/H/NDPWzAyEK
         UrsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779809851; x=1780414651;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=X9PBIjlRM30LWt9CU8BNuDCg7sgYuhWgWgktG0ZmDLI=;
        b=OpgWqIO0xBYXEnjuc2OrJUVjxx+2z9b+8AHlzHXqvuQNmc7ZSJiiFQogQE/33f4pzo
         SWWzzLFoPWv8XGMfg3MpZuyMMynMVZeiv5bKTPindvtjXCNIOJvth2cZB/a41Sy8xgd+
         7Ylays5Y7W5sWOeZ984SMzWqt2hAdkYoPuGKJ1IQeYKZFTGNlAjrP3oavtf4AePSsGgP
         Dod+p6K8HfhHFdz2o1drYyM8QYKkE//KEbXU3cvMQruX9prLlY8hmiQmV2MYLiIGKhff
         lLjuZVp/lNSMZAAYL0WNQ+Xafrjyk9RNxRINM24Sw6BV02D/BPDL+kUZvYRsvkJI9PRe
         lA1w==
X-Gm-Message-State: AOJu0YxcwmxTn0Mk8klCRZy5PAKeCr2dPk0wjMYeHKp7SoawNME+WIfn
	Vek03Cv4fTIgqU/qNFksyDsHefydqzFG9ImRJp6hWbLP3WlCu61/dvPO1zTAzMl1p60=
X-Gm-Gg: Acq92OE+U/z5bNhVjjfaeEFjqjYlHDIHFZGZ8Opc0yOqAq27rpyBRre8/dlkXdXT6va
	zm+wUIGWkiC1i38cVP9LVLiASjO1nefwcT6EE4kA48LVpbaGRg6QiUBy9xHXlwv61AQ8XbFFJXj
	0VOcuhCSkJ8YGaNgbYpdyoFyVuTLTAjfZpU1LRtY9fmpgASZrHUfbhBrrtzxfHJmqRDSoVkvaow
	vdVt8d2hRGfP4790R0nrCjYqKD22NNsbRG/6eHWLG3/9J6SA/W7ib0fc8EWwxqTtVJK4knDx4rJ
	1I+Pe2ZSMjQfgvy2ZbWX+BU3P1Ro2lFLsPehr0fqYDn1GItT3q6T2lp6RekwbIoO50LaHBSfJvV
	qy2ZxjWVw9w85ADjUUQdrhhkFvAyJSarprOjC784WOOBqkH1zdo5cqSolY2nAjeW1du61uTjB14
	OKIZoQrmxVzWOfOE7O9fEorPxAcPw=
X-Received: by 2002:a05:600c:1992:b0:48a:9428:5522 with SMTP id 5b1f17b1804b1-490426bc7dcmr316962155e9.16.1779809851296;
        Tue, 26 May 2026 08:37:31 -0700 (PDT)
Received: from mtardy-friendly-lvh-runner.local ([2600:1900:4010:1a8::])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4907df9edeasm1083655e9.9.2026.05.26.08.37.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 08:37:30 -0700 (PDT)
From: Mahe Tardy <mahe.tardy@gmail.com>
To: bpf@vger.kernel.org
Cc: martin.lau@linux.dev,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	ast@kernel.org,
	andrii@kernel.org,
	yonghong.song@linux.dev,
	jordan@jrife.io,
	netdev@vger.kernel.org,
	netfilter-devel@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Mahe Tardy <mahe.tardy@gmail.com>
Subject: [PATCH bpf-next v7 7/7] selftests/bpf: add bpf_icmp_send recursion test
Date: Tue, 26 May 2026 15:37:08 +0000
Message-Id: <20260526153708.279717-8-mahe.tardy@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260526153708.279717-1-mahe.tardy@gmail.com>
References: <20260526153708.279717-1-mahe.tardy@gmail.com>
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
by the kfunc re-triggers the BPF program. Since it's attached only for
this recursion test, it should not disrupt the whole network.

Signed-off-by: Mahe Tardy <mahe.tardy@gmail.com>
---
 .../bpf/prog_tests/icmp_send_kfunc.c          | 42 +++++++++++++++++-
 tools/testing/selftests/bpf/progs/icmp_send.c | 44 +++++++++++++++++++
 2 files changed, 85 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/icmp_send_kfunc.c b/tools/testing/selftests/bpf/prog_tests/icmp_send_kfunc.c
index 51f809ea6896..f48e1d41e3ed 100644
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
@@ -193,7 +195,6 @@ void test_icmp_send_unreach_tc(void)

 	if (test__start_subtest("ipv4"))
 		run_icmp_test(skel, AF_INET, "127.0.0.1", NR_ICMP_UNREACH);
-
 	if (test__start_subtest("ipv6"))
 		run_icmp_test(skel, AF_INET6, "::1", ICMPV6_REJECT_ROUTE);

@@ -201,3 +202,42 @@ void test_icmp_send_unreach_tc(void)
 	bpf_link__destroy(link);
 	icmp_send__destroy(skel);
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
+	trigger_prog_read_icmp_errqueue(skel, ICMP_HOST_UNREACH, AF_INET,
+					"127.0.0.1");
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
index 5fa5467bdb70..c899fb7b28d2 100644
--- a/tools/testing/selftests/bpf/progs/icmp_send.c
+++ b/tools/testing/selftests/bpf/progs/icmp_send.c
@@ -14,6 +14,9 @@ int unreach_type = 0;
 int unreach_code = 0;
 int kfunc_ret = -1;

+unsigned int rec_count = 0;
+int rec_kfunc_rets[] = { -1, -1 };
+
 SEC("cgroup_skb/egress")
 int egress(struct __sk_buff *skb)
 {
@@ -125,4 +128,45 @@ int tc_egress(struct __sk_buff *skb)
 	return TCX_DROP;
 }

+SEC("cgroup_skb/egress")
+int recursion(struct __sk_buff *skb)
+{
+	void *data = (void *)(long)skb->data;
+	void *data_end = (void *)(long)skb->data_end;
+	struct tcphdr *tcph;
+	struct iphdr *iph;
+	int ret;
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
+	} else if (iph->protocol != IPPROTO_ICMP) {
+		return SK_PASS;
+	}
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

