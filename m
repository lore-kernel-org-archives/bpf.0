Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 206193876A9
	for <bpf@vger.kernel.org>; Thu,  9 Jul 2026 14:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783608559; cv=none; b=mrfK9WfGtYltbZ++KSJwQtrxRv+EGi1OlZlltBiQVlnI7y/886PZPhaixBdObDuPLM0E3a5IURvV7wco30tAAzhUGHL74f+4rXN+pfJTUccrAuFCzGSPC5w1PTE1Jn/8XDIoMMksLD0Xe6hqyty0RS/29xiJk/3HAb5L/euggqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783608559; c=relaxed/simple;
	bh=3apo50H6MD+67sS62kyBBDqnarN0kbECnERY7Wfj4nk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lqPn62XKHj5lDhkklpWLHCDt6ZD6fXYIWkDUu22wHFB0Z90EGh06rclZ6k80GtaMwqm3bsCR0zEdF2+RSaeVX2lQmld3Ow3EQ26uc1I9ks9T0BMnrk9kdCHfkrGq5tNGRaD63Kvoyezru/aISMU1YFaOP9oc7Jr5EEffuGUm1IU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fEf/7d0C; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fEf/7d0C"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-493e4ccccc2so8022085e9.2
        for <bpf@vger.kernel.org>; Thu, 09 Jul 2026 07:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783608555; x=1784213355; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+9sX1JGZkJHDeEjSfUGdSrnN2laXL1fB9Eoj82w+fvM=;
        b=fEf/7d0CTi4CTiVzkgQEgfQ8GLAko6ZthXiwz7gA2oq1tzl/DGSnZlceTjO4sSG4oM
         hpwFQwQzsg9lmAABz90OMFd4FnA7CX+cLIz8YtzcoMUekbeehE8h1Sd+4xjIBq3tqXET
         ZFlOmseDyVEn/oJDQGR8qZdsrC6GNrssKKKQLzChtn+JphV3O8xp2TZ3PAYmopmeLJQ/
         eP44uTUjwHJJF8VADdp0hzLYTB9Fb1hwjNNFxWL4GQ+ev/VEM/WqFIh/T6NIoBd4Pqum
         ADpQcKOINXxmgvU5CbSK0nXfL92DjnbJo0RDW0LWuK3CptELfSz60Bw/O/2QFW40qSaI
         EEhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783608555; x=1784213355;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+9sX1JGZkJHDeEjSfUGdSrnN2laXL1fB9Eoj82w+fvM=;
        b=e9IX1g+IQ4xGshRJDczrFa695qmaauR/YRDUrezWtFC16LNwFt+ilcaWSPaboYwp54
         q7qRHxipMz9KI7Dz4LJ+ehwWt/YvWaPJns4GohBomnapfNXsTUnUay3EnrVKRMssU9eV
         hAxPgfy9PaxvYo5o64YaRicJfTJgYBXmCPQWSaWNNm9B0pvB29DDXS5oIIJ0lKsX3+yf
         Wx0OV9o+RQYD9P8cpjmHU604QSMX2vJMbHHP3aJ1XgV+fDalN62RSI3oH+G3IyqwErcI
         IrBpNWLMrt55U4lQ/rezdZ9164qs80RffeUkXYr8sP3WDhPzrRbKoaeKxY9ejJ3r8ekR
         5grw==
X-Gm-Message-State: AOJu0Yx5VH8YegPiIV/QMEzuwCsfrXOArCDgEuAA0hG/DVMGo/dLqYWn
	tQr5xWI7y/CUMPrVF7sDTvK8uQNTvKamW7xeZAysyy2y32zlfYQqvHlde0Dg544cDuw=
X-Gm-Gg: AfdE7cnH9vz3xT80e1O5WCtMsLa/h1XeypvswAn1vr51PPXFV6vldkFQ7GSguhkwoKL
	vexXA5AM5ivdyBzyx46lkebGKnmV62qdnAXBrqKjt/FBq/A0AJzWVzu7zcDn9jnvkfKPss/mrOL
	VibIxozzZN9x9hbx+FpYnzDEC9BKB8xDLQ6MKqt346/nLqgu61k5wwdr2fCJh3D82bswjptc6aM
	u78Xtgd0rHn4kv41Wrw2iKtRiuu8Lucp15x+tPbCUFOpEryFV9rz9VQt/pHQTkzJREajmT7KXP6
	NCC1irMtxra5SWR+2YGX23TFBhnO9KrTmUKooKOtuKt0jae55P7BzEvIzz49TYbya/70UC6DMGZ
	ku6yY9LkXpaRcpXeZpJwNZTqTpANkm8GEhWijL8M3zQK7EB1mLfDvofVt9l+npnuavTZ2FOtMD+
	EJ5lJiOvdaHpYvrBZMJA7s+W0gvd+U/ZC516cZgYkt6++UXolWgBrAvFgR9g==
X-Received: by 2002:a05:600d:8496:20b0:493:ae5d:8c40 with SMTP id 5b1f17b1804b1-493e68e9ff7mr52614245e9.27.1783608555285;
        Thu, 09 Jul 2026 07:49:15 -0700 (PDT)
Received: from mtardy-friendly-lvh-runner.europe-west1-c.c.cilium-dev.internal ([2600:1900:4010:1a8::])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-493eb6d53absm64357595e9.6.2026.07.09.07.49.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 07:49:14 -0700 (PDT)
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
	sdf.kernel@gmail.com,
	Mahe Tardy <mahe.tardy@gmail.com>
Subject: [PATCH bpf-next v11 4/5] selftests/bpf: add bpf_icmp_send recursion test
Date: Thu,  9 Jul 2026 14:48:59 +0000
Message-Id: <20260709144900.245904-5-mahe.tardy@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260709144900.245904-1-mahe.tardy@gmail.com>
References: <20260709144900.245904-1-mahe.tardy@gmail.com>
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

