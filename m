Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BCEB242D67
	for <bpf@vger.kernel.org>; Wed, 24 Jun 2026 18:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782327382; cv=none; b=qcYWYqUhJniIYzKAvp1kLXq790suIAvLDfJUUzpBHXU+ovWNI7LB4U3ro06Yl29tGxj/QdT8TKtOz7G4hVlI0AMsmpGFVLxd+787le7WnpPFyBOY9BS/SXdpk9zcouqHzbh/kzi3PxbVme4E+NYXwGXB7pKD46tK+UnSolkqpUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782327382; c=relaxed/simple;
	bh=hlj8PiM5pkGEcBIS2pYY+hYogeC8kXJATC5DML9mPtk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ueNboXcAkU0bwJnZi+LMkpnUQRnohxRrx6amAwb4y/2TFBYuyD52wQED9QkAR/KlaEBz3d/FnrDBZ4CHyEHiOMVhG1IjBdUORuiBOQvDnXFwHWYaUUGjNuHGHrkJrdn2EugYJKRS0amRSHVt/zLDHk2FBxuS5paJxDcofW6a11o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hXR4npvB; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hXR4npvB"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-49222b6e871so8978625e9.3
        for <bpf@vger.kernel.org>; Wed, 24 Jun 2026 11:56:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782327380; x=1782932180; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kdm9ayg3BPbc0HR2LuoEl7wkgf2+r6mSdVeEFCnCBDg=;
        b=hXR4npvB1y6Awa2s+cBs/7opYm2e4AoHNBCWx2fZbFNZdqT7wBp17MJD5gOPDRolNx
         qOBGq1EUeHc8fT6I04skxYCwKdGzdGLXVLn8vBbJlLbCr/ZSVhDzmmMyNU6Upgrwy+wg
         IEPQlRHR0avr6usBNYRDLwm/dE6RVpBjTWG4BM+031FHtsa1hb1qNc1N+U8fWNskEfQ5
         aIWLA8c/9gmIfdqg6bqstIh0hzeL4d1MixRrxSgOJzv6dyipWh9GERJvABz490u+fHWh
         Fp6O96wV8S9eUYG+7ishVzFKrqQOVHTek1u3ozpnIuP47OnoTNYD6wG8UKxm3+T93Ehj
         q3Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782327380; x=1782932180;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Kdm9ayg3BPbc0HR2LuoEl7wkgf2+r6mSdVeEFCnCBDg=;
        b=aCxV4xBm24g5pPuiO/+U21H0LtGYqqz8+J4LvX1vLaO6uHO2l0exs18ns6lIzjytmO
         QcpKYH1lLaUOMRtJ3PoIvIB1nMk1d3neBwHIJ+5Gej7+j2AjcBn2FImEO/hMB1PJ4BJM
         ILIg+F7u20QRle0VzOX4wtdG9AMlDoyaCDt+hwArWVvL/wOnA/WqBSk1T2259tdTA6Hy
         DHu+UPWmMRLGOBbDx96xBfGDrdaNaQXhM0YoyD327zTCq7u3VJfYEn8aP4lvIyhzJwCT
         8Fqiehhh/qCLO2NvC+hR15a/xbYannearOQ8FF9o+YloQ6/CN+8LD4mvcpRomsvgV6v/
         aD0A==
X-Gm-Message-State: AOJu0Yztx1MRTShCP2dEfpPO46fy+QWFMwfUJxO20uwMFPPDQzeqjoLx
	a5uznDS1AEPi5QlTmndQnJauPn2kWyiuPfEkpOOhn7zkEOQ2JkaD8ZaCfTaaknQzvTk=
X-Gm-Gg: AfdE7cm+k55ZZHVzLZNvR/kXrVvuMWb2xDdSQ+TZnCKN2Swpx6ARr+/UDlbTA8QCUyj
	cSSmI3n+E0TaBZ2s4oUCDMsWDTt9vxITXpRlJeBOavW2OQ2t2dZe6f7p/qzGOWVwaGbNmZzgkFA
	T0/JnaYPfuHDLdlNDwV+u2jdlBoKYwZuxwVleWenkmdZ1yHoRsOQ/9ooju3wZvMug7S8aQC48Ld
	oL7/mgCzXUn7a9uXmXDVui5iYaQrWbuD8h1Zh5jEqo29lNDlxpLNEMJ5AkTvyq+3M2lhRnuEi2G
	TNI8ZAmPY3HxpBwLxpSThYp94VoocWxbvQRyGTV43qzwX6iy3Qz9H2jGRfrSu80+99IQJMqLO+G
	lNeg6AstAKXFr1eqM2EiIRQ2qe06Fh6tcwi+sOpb/FGhh1Cpy1dQA6tnpEDhDXEb40CKytbM7qM
	0fYX1Zgkp2yMOProCd
X-Received: by 2002:a05:600c:4453:b0:490:d32b:39d6 with SMTP id 5b1f17b1804b1-4925b37973bmr132834715e9.19.1782327379623;
        Wed, 24 Jun 2026 11:56:19 -0700 (PDT)
Received: from mtardy-friendly-lvh-runner.local ([2600:1900:4010:1a8::])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4926417f0c7sm9847805e9.14.2026.06.24.11.56.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 11:56:19 -0700 (PDT)
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
Subject: [PATCH bpf-next v9 5/5] selftests/bpf: add bpf_icmp_send no route test
Date: Wed, 24 Jun 2026 18:55:54 +0000
Message-Id: <20260624185554.362555-6-mahe.tardy@gmail.com>
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

For normal live cgroup_skb paths, the skb should already be routed. The
exception is for test run via BPF_PROG_TEST_RUN with packets created
via bpf_prog_test_run_skb. Those lack dst route and thus the icmp_send
would quietly fail by returning early.

This test exercises this and makes sure the kfunc returns -ENETUNREACH.

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

