Received: from mail-wm2-f9.google.com (mail-wm2-f9.google.com [74.125.225.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D000846D541
	for <bpf@vger.kernel.org>; Mon, 14 Sep 2026 13:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789391832; cv=none; b=B6dFL6F+tMJsL0oPfATgPFozb4BaDBjnRlRES3o2s3AXJcJrdbmjRgyuapmeb+ydt2WJOSCZIHky2jPo4WFkNLqzFn7nw9AYq6BqqREXT4EseYs9Asbib6Z/3zHJde1pQ4Et7suPcQXrxIQ98IfG/NDf4YEmORKI/kqjPz+EShM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789391832; c=relaxed/simple;
	bh=kG2YHuvL1ypg8xg7R/3LfcxZgNoQJmzBHCRWeoYJ/cU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Fqcf+7Zo1Fr2vBXRZaiogPmtr1zYdytl08DpPKRFrZZvoCZiX0Aq6dKqkxAK7uy0vdgJjln9UygG+TitOYKSt265tJmy5EN2ktTfCCzqzqMQQ5FpwN+xSEhuJ8ZgPegDdu3czMRCFGQB9mxOitoRNdMoKCOgBY+mi2fpMuRUBY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FyflBToz; arc=none smtp.client-ip=74.125.225.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FyflBToz"
Received: by mail-wm2-f9.google.com with SMTP id 5b1f17b1804b1-49554457f71so1302985e9.1
        for <bpf@vger.kernel.org>; Mon, 14 Sep 2026 06:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789391829; x=1789996629; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hdI12Yv6cwOBUJEO+GMsgFnFVy6yrvKHWA9/INV7Nok=;
        b=FyflBToz/6SAfEadADuqvDLjCDTZMPbX7J9iiWJkDFkfuVodW9DvfmLjs+E6176zVI
         Gtzpj2RQG8GGekT0kNdTFjBz+Atj9BjH6SMupe6gDzBLkl1LrpxGEdf6YmrNWON8vjMH
         aNj2DVtWpT94DGlRIJYXVWZwxNOD9v+8gMdrhf88FbB8J0c+i6lCnHg0beuAC8SnzJDi
         F+lIXAhxVfHdSZ3w8/syZbMsxF041vYiu7TgsLr78t+Edkib/S8LdCgJpI8PimUDMcaV
         Vf0k22w9Ls+p4nBhOY/wYStUpnJUZBGPzL16wyyNHcvO3eUGoZDXrNWKV1QfC+3xiJKr
         LHLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789391829; x=1789996629;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=hdI12Yv6cwOBUJEO+GMsgFnFVy6yrvKHWA9/INV7Nok=;
        b=ieS5MWey1iRHmK3ClGHddDhm12XvCBW3tqRVIUtA0D5BvHhbEGnfXwVAB2tY4GWNUP
         WqHwwgz3nPLAr6KLoHAwpiNbPjlgL5Q+Tk+Vx2FNIHi98HqYaaMleVtM6qoIemBF6Z+8
         2QvoNTLtwu7WI2vL2HY5HELksaNiWxJQmGXN5N7zJCXepFzflKU4YaB3WYm7KVRyAiD6
         wLGenXrX9Paa9RtwmBQtSAv3rgqR3VmX0ak6YB61FqvyVD+AMEY+qDOPFKpNwco9oprb
         AGlcsx5h6HADG8GCRGrE2qHcqJYHAmmWQdS/z/6yBv9MGABlY66RoYoHBYmLHRNG8sgS
         C0fw==
X-Gm-Message-State: AFuF++mhaX0Bq3o2SWSfRWlf97vn2aHDBCKg6P3CqeTLer767gQAyCp3
	izaYzb3/V0X4Sb5JjIfSDXgzJyr4t4qnypWpfLJq9ZsltVxlg2GePfG/4LDmMvNN
X-Gm-Gg: AYBFou1+gR3iHzDPZ9TY8O+xXAd4mD+P9UEmt14+g60d5G7eNoulyOjCeYn/pl28QIw
	xkSj//lTD7NCoBhfljRB+MIeWXqL4nKA3rIHgY0qfFchlPv+4fKeXrRh08GpLBEhvXizFB0bjGW
	ScLo5nPonwawzq3/4o16QYtArEMkufMavS5G9iBJACRnuWJdCEW48vy608L3agfMFH5Gx/06KQS
	DKeD8eEv3BhYzCsy1OJvLRfS+mOxSW2k9ivV4jszGzsNDQlMdHN0OGwPD9eNwoZT/Du4N3ky3sV
	UFUt7YFXzyOz98GUY2dKDoV+xrsJxH7er6FPBBqYxWD6U36ZTnJ6D+FcS2/Gtw4ZAWpDMICDvB9
	SgKdqLXjkwRt38EDR19a8jqlLr4c0wuqUI8LpR3Yw+lwra86BjW+TDezDuPDNOvdmGSPVtXqJWC
	uTcBiyAmbXtMT1ZxEaWrS6VMRqrqv7udCJv7mi0FeCCYAmUXLLoxTGVzV2MKNhFB2ru1VZ+0pSe
	EED5ZmvODfxjYeYD4Uc1TFvOFioc8zNIPiCO9e6yLmKI4yxqx4y2InN749BFY38JwIYodDMePiC
	Hwc8r5EnBb5i7c0j+u9oE2LWz3+vO3sxQJfZJA==
X-Received: by 2002:a05:600c:3545:b0:49e:6ca6:d40f with SMTP id 5b1f17b1804b1-49e7a6787b6mr26259665e9.9.1789391828128;
        Mon, 14 Sep 2026 06:17:08 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49d26c1bfb5sm429093395e9.5.2026.09.14.06.17.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 06:17:07 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Nicholas Carlini <npc@anthropic.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf v3 3/7] selftests/bpf: Test packet pointer class displacement pruning
Date: Mon, 14 Sep 2026 15:16:53 +0200
Message-ID: <20260914131701.2529725-4-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260914131701.2529725-1-memxor@gmail.com>
References: <20260914131701.2529725-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2497; i=memxor@gmail.com; h=from:subject; bh=kG2YHuvL1ypg8xg7R/3LfcxZgNoQJmzBHCRWeoYJ/cU=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWv555ltN9/8YE2s/NR7z8G1NLnEgL+EW4Up/KS7ngx/8 pGwvYUdpSwMYlwMsmKKLCX/9zEZn6j8HWi7jBtmDisTyBAGLk4BmMikLob/mTWnJq9k6LatO381 +MGkys8cr+rlpAJb9D/7BrvOuLb6EcP/NH/egHc/PJesCbsa+atEJN48faPWNMaLjtX/ZplKLlT kBgA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Add two paths whose packet pointer ranges are individually compatible at
a join but whose members have different relative displacements. The first
path proves an eight-byte access through one member. On the second path,
the same guard only proves that the access starts before data_end.

An affected verifier prunes the second path and accepts the program. With
packet pointer class displacement preserved, it explores that path and
rejects the out-of-bounds access.

Read the unknown offset and branch selector directly from XDP context
fields, and force state checkpoints so the pruning attempt does not
depend on the verifier checkpoint heuristics.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../progs/verifier_xdp_direct_packet_access.c | 35 +++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_xdp_direct_packet_access.c b/tools/testing/selftests/bpf/progs/verifier_xdp_direct_packet_access.c
index 0b86d95a4133..9866bc154194 100644
--- a/tools/testing/selftests/bpf/progs/verifier_xdp_direct_packet_access.c
+++ b/tools/testing/selftests/bpf/progs/verifier_xdp_direct_packet_access.c
@@ -1719,4 +1719,39 @@ l0_%=:	r0 = 0;						\
 	: __clobber_all);
 }
 
+SEC("xdp")
+__description("XDP pkt regsafe preserves packet pointer class displacement")
+__failure __msg("R2 min value is outside of the allowed memory range")
+__flag(BPF_F_ANY_ALIGNMENT) __flag(BPF_F_TEST_STATE_FREQ)
+__naked void pkt_regsafe_class_displacement(void)
+{
+	asm volatile ("					\
+	r8 = *(u32 *)(r1 + %[xdp_md_data_end]);		\
+	r9 = *(u32 *)(r1 + %[xdp_md_data]);		\
+	r4 = *(u32 *)(r1 + %[xdp_md_rx_queue_index]);	\
+	r4 &= 15;					\
+	r0 = *(u32 *)(r1 + %[xdp_md_ingress_ifindex]);	\
+	if r0 != 0 goto l0_%=;				\
+	r2 = r9;					\
+	r2 += r4;					\
+	r3 = r2;					\
+	r3 += 8;					\
+	goto l1_%=;					\
+l0_%=:	r4 &= 3;					\
+	r4 += 8;					\
+	r2 = r9;					\
+	r2 += r4;					\
+	r3 = r2;					\
+l1_%=:	if r3 > r8 goto l2_%=;				\
+	r0 = *(u64 *)(r2 + 0);				\
+l2_%=:	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm_const(xdp_md_data, offsetof(struct xdp_md, data)),
+	  __imm_const(xdp_md_data_end, offsetof(struct xdp_md, data_end)),
+	  __imm_const(xdp_md_rx_queue_index, offsetof(struct xdp_md, rx_queue_index)),
+	  __imm_const(xdp_md_ingress_ifindex, offsetof(struct xdp_md, ingress_ifindex))
+	: __clobber_all);
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.53.0

