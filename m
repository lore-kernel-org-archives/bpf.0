Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B07C39D6EB
	for <bpf@vger.kernel.org>; Mon, 20 Apr 2026 10:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776682717; cv=none; b=hUxbPH8uE1sup5Lopm5ddFw8Z9wjknpU4MzPkofTss+TIYmHJs9f/sK00V5dszq388T2Ls60mHsh/zcfKM4UCBjuwg0EdTxhvPDDp4XgyrNuXeQoD7NlK5U3fzxhYay8MmP8F3ix47Ze7i/CJmkzsOOIiOOD0+ThlG3SmzFWLks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776682717; c=relaxed/simple;
	bh=oDrClojuOmoFQWD8kdi7OYjx+xfYmqROcI/D6DoFoI0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mT/hchKQbqafkLYmLEJ4kIm7Glcr+XEiT+kIhretwdqE717JjOAEkAlAKIBnRwtcFw6ERnqXqWL59QakKSyoVtndTqggv5eJzlljc1Gqw/3MVos+ZY6vaLB9eHQCoDe5JcWrF1iTI3xhbIZQgcRgT7ODfblE8ZBNaTNvESg+bGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AMGOhbbb; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AMGOhbbb"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-488a8ca4aadso39743285e9.3
        for <bpf@vger.kernel.org>; Mon, 20 Apr 2026 03:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776682714; x=1777287514; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xJxI2HSQPAxVmr77kvDE3un+rWp4GINOCWCL47TtY40=;
        b=AMGOhbbbPawejQreqA6zT8b5PPyCdN1n01uciSzHdG4MjndS+/mvJUJ5OeaasEiINm
         MyLOAXF9Ja72hTlG1bQ8QfIsVVC6jyrh/KtQyQShuSpVHN71HyXxui+pVrPeCt8niRI2
         86JnBAaCpWcXdXr4tskcyD//sHQIrD9FU0bra+imVlpcNFYBE/j/mAxzURltT6/8Mu3p
         gNsb642EcDthOSUEwDuu86HSlrOER5p53j+0YePNNNDm/i9dWF4nZR0d5mLC1a6GeKrW
         eTfDLar7l59+McnZkOy2uQJVCsuFfS4e1x+ln1ubCKKTPpnF6eOCBRJpYBlBhLm2qqbP
         ivkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776682714; x=1777287514;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xJxI2HSQPAxVmr77kvDE3un+rWp4GINOCWCL47TtY40=;
        b=lQEKcVtVP/Qm9efHUvaj39v3i0lzJJI+HFQNADhaVq0XDSZ/I5ZtTGtINAapvGafFY
         aUrXgm5WoS7lHeWFxZzBQ1rxB+Tu2xC9IwFiIWnaS8EyplaI18P+x7lHHUcoe0bHrOg0
         MM47JOWDQeWQnqjYb906dy82mubB7CuKlaSR8poJzcndQqZ9HKQkeE96eNETDtmT1vOm
         eq0Fy/XwKNz/iKjLCBWIicePElNhdIrMomL/XOKUAHVspbN1jy1L5X1MAAOqvqvmQeLG
         L8eOYAbql7UmiP38qu7Y3XJ4PaBllxXmjn+twAWv1CEJDJDbSWsUu8ppKMbkHJBP8pCl
         083w==
X-Forwarded-Encrypted: i=1; AFNElJ97WvNGPGffOJSdjVg0bVKm3zMYzD4vLFeMWfxnFbp4JuJENgQ5BLmIKG2+EtAv0zJDSUE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/HWktWg5KMNDNNZRYNADkFKprHeLg1k8fLP1Hn6uqrcwg0GYz
	PI5RZGO/tB82+8KxLyYzepyVwFBa3MtGKOU8iaSwgBlS5P8iyrBayaxj
X-Gm-Gg: AeBDiesrcYqiKtFoC4e+avGmX7fIWzlE2Wcv4IStkrirnnpCFh97Jk9uQZYyu6y4IKd
	VCiPAA+MTClehPkZHFNflVl5iLuEuwR4x1+gK/CK9Di6wozaMnMssa7uLgIE7dpexbwlwC47cQI
	bJYz9zzPAPio2H6bYHiPf0fiNzRmtwnHVBH/8dJtX51jnQ3LsWs4g2ugUkBg7J5kpkJfGWCu9if
	6HmgkaoBRm3LlpchKlVmUsekUfxm/rhJkvEiQcjOYbqC3o/pVS71AlYlsMzrqj4aix6E6hLypJQ
	ELm00Mp9g4Oktf+Wfw1+IR5HpELyhAt0VRWeJEC5noxOUIP63/cVj/KocA4c9PNHKvh0peHF91v
	prSUDtgKn1PE3CvmJtsNvXMPpC+Cr8/yyAcyfiJvqqTVhwCwqLRdz3jkn2eg2lq4ZznWRTvEdvL
	PUfahvoXLHZtiaQL5eIpAIvvVQC+9aRn2lKeRYJg==
X-Received: by 2002:a05:600c:1da1:b0:488:f453:b976 with SMTP id 5b1f17b1804b1-488fb7844c5mr207471835e9.27.1776682713605;
        Mon, 20 Apr 2026 03:58:33 -0700 (PDT)
Received: from mtardy-friendly-lvh-runner.local ([2600:1900:4010:1a8::])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-488fc1cfbf2sm290929495e9.15.2026.04.20.03.58.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 03:58:33 -0700 (PDT)
From: Mahe Tardy <mahe.tardy@gmail.com>
To: mahe.tardy@gmail.com
Cc: alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	coreteam@netfilter.org,
	daniel@iogearbox.net,
	fw@strlen.de,
	john.fastabend@gmail.com,
	lkp@intel.com,
	martin.lau@linux.dev,
	netdev@vger.kernel.org,
	netfilter-devel@vger.kernel.org,
	oe-kbuild-all@lists.linux.dev,
	pablo@netfilter.org
Subject: [PATCH bpf-next v4 6/6] selftests/bpf: add icmp_send_unreach_recursion test
Date: Mon, 20 Apr 2026 10:58:16 +0000
Message-Id: <20260420105816.72168-7-mahe.tardy@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260420105816.72168-1-mahe.tardy@gmail.com>
References: <aI0MkNvWlE4FXMV8@gmail.com>
 <20260420105816.72168-1-mahe.tardy@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This test is similar to icmp_send_unreach_kfunc but checks that, in case
of recursion, meaning that the BPF program calling the kfunc was
re-triggered by the icmp_send done by the kfunc, the kfunc will stop
early and return -EBUSY.

Signed-off-by: Mahe Tardy <mahe.tardy@gmail.com>
---
 .../bpf/prog_tests/icmp_send_unreach_kfunc.c  | 43 +++++++++++++++++++
 .../selftests/bpf/progs/icmp_send_unreach.c   | 30 +++++++++++++
 2 files changed, 73 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/icmp_send_unreach_kfunc.c b/tools/testing/selftests/bpf/prog_tests/icmp_send_unreach_kfunc.c
index 047bfd4d80f7..a4f4324b2b99 100644
--- a/tools/testing/selftests/bpf/prog_tests/icmp_send_unreach_kfunc.c
+++ b/tools/testing/selftests/bpf/prog_tests/icmp_send_unreach_kfunc.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <test_progs.h>
 #include <network_helpers.h>
+#include <cgroup_helpers.h>
 #include <linux/errqueue.h>
 #include "icmp_send_unreach.skel.h"

@@ -10,6 +11,7 @@
 #define ICMP_DEST_UNREACH 3
 #define ICMPV6_DEST_UNREACH 1

+#define ICMP_HOST_UNREACH 1
 #define ICMP_FRAG_NEEDED 4
 #define NR_ICMP_UNREACH 15
 #define NR_ICMPV6_UNREACH 6
@@ -157,3 +159,44 @@ void test_icmp_send_unreach_kfunc(void)
 	icmp_send_unreach__destroy(skel);
 	close(cgroup_fd);
 }
+
+void test_icmp_send_unreach_recursion(void)
+{
+	struct icmp_send_unreach *skel;
+	int cgroup_fd = -1;
+	int *code;
+
+	skel = icmp_send_unreach__open_and_load();
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
+	code = &skel->bss->unreach_code;
+	*code = ICMP_HOST_UNREACH;
+
+	trigger_prog_read_icmp_errqueue(code, AF_INET, "127.0.0.1");
+
+	/* Because there's recursion involved, the first call will return at
+	 * index 1 since it will return the second, and the second call will
+	 * return at index 0 since it will return the first.
+	 */
+	ASSERT_EQ(skel->data->rec_kfunc_rets[1], 0, "kfunc_rets[1]");
+	ASSERT_EQ(skel->data->rec_kfunc_rets[0], -EBUSY, "kfunc_rets[0]");
+
+cleanup:
+	icmp_send_unreach__destroy(skel);
+	close(cgroup_fd);
+}
diff --git a/tools/testing/selftests/bpf/progs/icmp_send_unreach.c b/tools/testing/selftests/bpf/progs/icmp_send_unreach.c
index 112b9cbfab6f..9aca7c0b12e1 100644
--- a/tools/testing/selftests/bpf/progs/icmp_send_unreach.c
+++ b/tools/testing/selftests/bpf/progs/icmp_send_unreach.c
@@ -15,6 +15,9 @@
 int unreach_code = 0;
 int kfunc_ret = -1;

+uint rec_count = 0;
+int rec_kfunc_rets[] = { -1, -1 };
+
 SEC("cgroup_skb/egress")
 int egress(struct __sk_buff *skb)
 {
@@ -67,4 +70,31 @@ int egress(struct __sk_buff *skb)
 	return SK_DROP;
 }

+SEC("cgroup_skb/egress")
+int recursion(struct __sk_buff *skb)
+{
+	void *data = (void *)(long)skb->data;
+	void *data_end = (void *)(long)skb->data_end;
+	struct iphdr *iph;
+
+	iph = data;
+	if ((void *)(iph + 1) > data_end || iph->version != 4)
+		return SK_PASS;
+
+	/* This call will provoke a recursion: the ICMP package generated by the
+	 * kfunc will re-trigger this program since we are in the root cgroup in
+	 * which the kernel ICMP socket belongs. However when re-entering the
+	 * kfunc, it should return EBUSY.
+	 */
+	rec_kfunc_rets[rec_count & 1] =
+		bpf_icmp_send_unreach(skb, unreach_code);
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

