Received: from mail-wm2-f5.google.com (mail-wm2-f5.google.com [74.125.225.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F564BD0F2
	for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 11:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789643515; cv=none; b=Z0kwx2k79sdNkb3OzWk35caLy40ZwUKiEmGrAlzd+7TskScbUrc2VsjhTMhXpSWBzhKIrSqALLwZRoiZeleNmkS833Kn/xjsGKsetcC9Cmrr0y5i1KzMlFFBAjznYxkzmx0MmTGQaq8WXnBlYWzmnCkX1Lu92r47IJU2sDDDRfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789643515; c=relaxed/simple;
	bh=kG2YHuvL1ypg8xg7R/3LfcxZgNoQJmzBHCRWeoYJ/cU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nty/PGztwch2+mkBzGct5gz1wUW9lZBw1uI9aX/WTAoVZgsCcefYn3uUW7nYzaYx8LEnxfBZ+db1lr4i+3uVjeEbJw0ZhhNOW8Qha5Y6uA8DJG6ArVuVi5DAFwKEeoBJ3+SXUoOnCDy6mgE17sHRC3as4XMgtK5wYBpwvY5lS/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=adbri/wV; arc=none smtp.client-ip=74.125.225.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="adbri/wV"
Received: by mail-wm2-f5.google.com with SMTP id 5b1f17b1804b1-49e667e3c45so1029645e9.1
        for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 04:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789643493; x=1790248293; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hdI12Yv6cwOBUJEO+GMsgFnFVy6yrvKHWA9/INV7Nok=;
        b=adbri/wVf68Wp0nlY0c3rePkWc/9R1sUUnmkjHFjt+NOVSeMCdfujkzyLu8wv/rMmi
         5KebkGolSX4zT5g/+XlxjFvBFnQSh0xcmwXzWRRSH5omtFkYxw+LRmVVbFvR5gTkSwKa
         oO0dOE0KTaSzl4k+Pn7CwM2zbuhvadwHeVJZqq5iG4pH55mSjMj82q9l5d4+PX5HXGzI
         7gfq9RsXntMf/xBnDDrkSgMz7xkafGTCpchaGyuVo0jlEPp+dOYQidtqjB32Mi1eWZy1
         N7RjDTjAGe/8B+x06GHQNWLG8qvHaQF9zZjhVuPqI5nEoR7ZHAfFtLLR26ss8yYe0SyM
         3JNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789643493; x=1790248293;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=hdI12Yv6cwOBUJEO+GMsgFnFVy6yrvKHWA9/INV7Nok=;
        b=LUbWpi0dJJgjqz1HSQdp+77va8yJRvUhqJcMC+PntgM2Mps3GgZi9gXii4zpWuT9lE
         54APWlBO9emmNoc98BRSiIXjDXw/jRD1MqG1BFLMS3Bld2XIkN2R3I8hE2B1Hs7LlmtE
         Q2td5yR+qA00+CjgkFFPTBrwwJihOMjH/HAjdkzp3Iugxc3++BeKyc3jOYioBeV+s5SH
         LnldIQtQMCAlzWVWDkU1PGgVvbkhVm/UTFrRvp3MHem+E9Epcod/WBkR/YOtjidHziLb
         obGdO4dISKGi67b4T/o3j534j3BEclQMua2zNFHuiPWNeLPKOc6AKYWnzCkbOpS77XjU
         gHUA==
X-Gm-Message-State: AFuF++n1oQzHAOHkFXCapdXBlzhDGWtKxx07W6eTuc335VqfG4ppiDk8
	LGhmLdb0pdtYqntAUmfHKLIiOCXfyJ6xVouD6ZIw48l0K1w1EwAOHiBW30yImT8R
X-Gm-Gg: AYBFou1IowsVX9lwlHvI3gDDgy9W89uwHen/3bNs7uPpYQzjYbPPTy0skJPURLbBPVI
	iKnL+Ma1CDc6ll3l3OsCDLYQNQagK4MpbjU1s/8O9TwQWRWtu1juPh75pacrxuBG51ZzXaJk7ZP
	OKmhPYcxMP7MZGIJ08MIgaDCaIkv+7cGrOiTBTHwKi8SW1d541SjPQNRKKfjqecz3H5JF7PVV6Y
	Xv02O3QuZPNjN3XkU7OhRPoQJudO2c0B1Cu2pCHFHSDzUpvnI5vj/4qRawbdMwyt8g6Ibccfr8y
	uikZRHen30eRTBs9GcHtPb3zoXxwsGwB8gHMMb1w2WkRU2KheN46LwSgb3LY560vlpbSPam35Vc
	CYkiSf7+/JgzEzaPffkGfLOqylEjIBdXKSm9nngeQPrZIHxEVxQbX/W022o8XehBvF8lSW9GMqY
	7E6LgTRnVQSYCqHFTjruU+yYQiqJGLQjGpK23JAt5X48Bn3IHdR1GhY9U+OVhShy6Jqeydbfwhu
	5To5pFTLXtqcA/aoFUn8Qz/Qj1dHFY/L/3LUoMf46T2wNOZSaJPGsu/a0RPtSvao8ZMb3QHk/zm
	guOlIr/HAUvfZVMeL2Av4k/TRhrbc8mD25PCXQ==
X-Received: by 2002:a05:600c:6216:b0:49f:c18a:61c8 with SMTP id 5b1f17b1804b1-49fc18a61d4mr9269495e9.29.1789643493396;
        Thu, 17 Sep 2026 04:11:33 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fbbcf5277sm82190375e9.3.2026.09.17.04.11.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 04:11:32 -0700 (PDT)
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
Subject: [PATCH bpf v6 03/10] selftests/bpf: Test packet pointer class displacement pruning
Date: Thu, 17 Sep 2026 13:11:15 +0200
Message-ID: <20260917111127.3780880-4-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917111127.3780880-1-memxor@gmail.com>
References: <20260917111127.3780880-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2497; i=memxor@gmail.com; h=from:subject; bh=kG2YHuvL1ypg8xg7R/3LfcxZgNoQJmzBHCRWeoYJ/cU=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWv1qaS2m29+sCZWfuq95+BamlxiwF/CrcIUftJdT4Y/+ UjY3sKOUhYGMS4GWTFFlpL/+5iMT1T+DrRdxg0zh5UJZAgDF6cATGQOK8P/tAiNu2yL4rNVz73R 3Mx8/l5+zp/nXc/5JBdskYk///2DAyPDclW9SVvZ3eT3i/XPnCT8UlnsU/GCv407PmbP/3ksXD6 NAwA=
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

