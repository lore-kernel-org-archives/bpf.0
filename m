Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 739083AD513
	for <bpf@vger.kernel.org>; Thu, 25 Jun 2026 11:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782385417; cv=none; b=ZmijLr/2YtbzH4Vl490gDeXm57X8tn3DJM1ybzgHkccCne/4XCsbDN4mr6Vh2FR7ZWK9NDx4ldhnMhctlSI65GhSeeAyVpaPd9507b8oN1SEEgRByCdyD+YDKCRyjVSkycvu+q2Z0+kYjPZdkFCMLka0qBnIhRTXUYjWZx2IZPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782385417; c=relaxed/simple;
	bh=XR/ijwy0to/QQCsRBXOhFG6fO5xl62JdfB0L68hbzMg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fbFgZ8qbHDdbqgJ+xFAp+9KoaTGOCVpTq/om7xpe4xtHqARPTb/lkBQq3bAKests4XQWrUQ2qjuZClk54kOSZTFx3oh5yjEpysaFzyGgb5Fg2wmxGyj9b7JHPE3MUiCz6hW3Ama45Z2TZVNE79kSaSPoilznSZsRm+ODkcMN3cE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oWUf3G4W; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oWUf3G4W"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-490c0c92cffso14981475e9.2
        for <bpf@vger.kernel.org>; Thu, 25 Jun 2026 04:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782385411; x=1782990211; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K9oeqTdNCxWtKvJYP8ZQP5Nn9aXr1LaBKmN17AtVy/U=;
        b=oWUf3G4WH6Q+TkVShDNqUDZq2bjU/NEilOHzRoNd1EYevm50e06mbU/IcO2Rcyw8gG
         CpZRGCDcZ7ffWY2iGZxPA3fssXpyVYiicTITabzHo0TeiEcatsG8+lF+WivYEAINAu+0
         81wy2wf0Uv3mg92ckmL2kcH5yT2SeU73SN2bHj48pao5x0fQD+vKmJCDbjMNCvaRTJFy
         JvNQvc+yUGtd69pQ3Ms5mp2HT0zuaZrseJjlZcjpFHpIUEgdASmeIpPXILzN/Gh9+/8b
         hWBjB+hgUobX1j7WgrAI74ayEYu0fRufxYnWdp8HaC2OQW57SiKiwo5ZbggX65ULVnfS
         aHrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782385411; x=1782990211;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=K9oeqTdNCxWtKvJYP8ZQP5Nn9aXr1LaBKmN17AtVy/U=;
        b=D4xR4cKNqgiLHW2UqaObvwMX1V0RxPN6GYmxTu/EGOfBs93REMir5Gjdh2tqnc7ezb
         A/qaKg4J+J1PvrlWcR4ETyWx65YWK6iHHWkR1kCI2zGHrOupS7JLid9B7MbQp6oIswbO
         b7Kj+Ym4xqAARp1xOjZqpRF7hTsj2x40rKpS5zPlW8RonIy3Sx19W8FzwDUlwpgvmMFi
         SnBc9wUlDP7iVPY9TyvEBioIQc+z4DYf0xPNyAM4KXtoIVBhVeTEKDxYQH5Q3JbRJnNR
         WkaULR8Mcpn8lhbSA1FNBHJbb0pdebWcW1Jyx/DicT43TdkMsjQu1PrkIFO8RJa/neMa
         gO2g==
X-Gm-Message-State: AOJu0Yz6DVTea04U2J5NI+MbOlFG2QOUM/qnnno4yrAgDaSBY7Co5Rm+
	hLMadmY9wpwQnZC2kpuT5DaI9j3ogB2PFVnJj//EWkO/Km8BFJT3HQrtUyTrog5lSgI=
X-Gm-Gg: AfdE7cnY1dgmlV9TB5VYOnk9rt4OZu4RdTWhhVkaTh/Qjh/9ZF9yAakWyxgCKXmg+fj
	8SSXi/HvfqQO9J13xHRbQWbl2LomtIUhUJRTWIrMwongNELS4Yan8O82VucvNZo/AgszJcyD++7
	osMv5VdMDJUJVdnHzc7mmnyVgwxOPgDJtlWOP4ismgy509U0/SfU4hkPD7t8TFM9Kr6mvLRhd+k
	PRkJDWHZAb1ewBr+Fzvspc9JmvOKJHzCFycDjM81tPyRWxaOklru2Uq8UrEXhpCxJmPd+XGl1vy
	tlR5uKgXQQYFFvM1VKw4107mZdrYr1j4TF0/emEGGt/0ehLebBaPE3a8LB5ILax8xF61NHKAEUd
	Ek3AUKt7dY3PJZskty5gl+G0fTJ/rdC7MWrsuxkyVchM/VUFJyhaYNgS71fc+CYDb1zmjX/8I4D
	Gn5LfXpyOG5Dyf8/Ux
X-Received: by 2002:a05:600c:820d:b0:490:bcc1:4edb with SMTP id 5b1f17b1804b1-49266884b7emr26370405e9.27.1782385411129;
        Thu, 25 Jun 2026 04:03:31 -0700 (PDT)
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
Subject: [PATCH bpf-next v10 5/5] selftests/bpf: add bpf_icmp_send no route test
Date: Thu, 25 Jun 2026 11:03:21 +0000
Message-Id: <20260625110321.28236-6-mahe.tardy@gmail.com>
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

For normal live cgroup_skb paths, the skb should already be routed. The
exception is for test run via BPF_PROG_TEST_RUN with packets created
via bpf_prog_test_run_skb. Those lack dst route and thus the icmp_send
would quietly fail by returning early.

This test exercises this and makes sure the kfunc returns -ENETUNREACH.

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
Reviewed-by: Jordan Rife <jordan@jrife.io>
Signed-off-by: Mahe Tardy <mahe.tardy@gmail.com>
---
 .../bpf/prog_tests/icmp_send_kfunc.c          | 26 +++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/icmp_send_kfunc.c b/tools/testing/selftests/bpf/prog_tests/icmp_send_kfunc.c
index bb532aa0d158..ffaf0fe1880b 100644
--- a/tools/testing/selftests/bpf/prog_tests/icmp_send_kfunc.c
+++ b/tools/testing/selftests/bpf/prog_tests/icmp_send_kfunc.c
@@ -169,6 +169,29 @@ static void run_icmp_test(struct icmp_send *skel, int af, const char *ip,
 	}
 }

+static void run_icmp_no_route_test(struct icmp_send *skel)
+{
+	struct ipv4_packet pkt = pkt_v4;
+	LIBBPF_OPTS(bpf_test_run_opts, opts,
+		.data_in = &pkt,
+		.data_size_in = sizeof(pkt),
+	);
+	int err;
+
+	pkt.iph.version = 4;
+	pkt.iph.daddr = inet_addr("127.0.0.1");
+	pkt.tcp.dest = htons(80);
+	skel->bss->server_port = 80;
+	skel->bss->unreach_type = ICMP_DEST_UNREACH;
+	skel->bss->unreach_code = ICMP_HOST_UNREACH;
+	skel->data->kfunc_ret = KFUNC_RET_UNSET;
+
+	err = bpf_prog_test_run_opts(bpf_program__fd(skel->progs.egress), &opts);
+	if (!ASSERT_OK(err, "test_run"))
+		return;
+	ASSERT_EQ(skel->data->kfunc_ret, -ENETUNREACH, "kfunc_ret_no_route");
+}
+
 void test_icmp_send_unreach_cgroup(void)
 {
 	struct icmp_send *skel;
@@ -193,6 +216,9 @@ void test_icmp_send_unreach_cgroup(void)
 	if (test__start_subtest("ipv6"))
 		run_icmp_test(skel, AF_INET6, "::1", ICMPV6_REJECT_ROUTE);

+	if (test__start_subtest("no_route"))
+		run_icmp_no_route_test(skel);
+
 cleanup:
 	icmp_send__destroy(skel);
 	if (cgroup_fd >= 0)
--
2.34.1

