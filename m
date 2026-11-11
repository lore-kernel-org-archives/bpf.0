Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794374031;
	b=Hdxu2OHLQVmpCgkYBVFNgRQNOFlpQGc1yRakObvav99qNLDLOe7Vf0b109TziHcmlN8C
	 ZeCGXdSE+LTWu/coiAVXTxlB6s/hyb9i8bRQ1pIrZrUsYLLJeZjsiJ5qeD0Kf0fP09cGK
	 j+O9Vw58+Qc1gC4/hSqLNcBr3Li9k3DLLzitoskqyofE4Tfm3lk0qXU9G1XRAJLltCMCF
	 lFP76x0An4lKhY4SuAc3040J26N0IH+6hoq8skGB+AfzbLYC/JytdwVQpamxhliVNVi/a
	 V84vrsNABl8d9gK2BxGtLUHjDMns9gQXjphsPRzee4XJFKxbjIiVOX+5PtV5Nh+yzmA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794374031;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=W+wFrqTn6TpSzq1GtCMNbpHfih/1qK8FVl9ONJGTXVY=;
	b=w3qyoJAgNisfRseE4hECfDwao4KmjPkPDr5Toxq3knh9CgYIDuks0JJ4l8xnrKc//HAL
	 +VhwDlOecuEbk5t5cl+6tpy5BYim7lV+KS0Udkos+M60p2Tyty8EKtolWXcTBUXzr+xjp
	 Xv2mqgEaworigyB9JDnMa+F74dsw6Fysom6DGDGQS5JETGUvWrGudIl/ojEtP91qYHU81
	 Ar2+Ldy9FlWrpJfKpkP73ilBCRNDNV08drYI3anwZC2ZEfUWPyJNGtUm2nnoD4jXWacFs
	 vTczkk29aN/GUTl9tM12a9Ut6Te7iAiza3ktoC/yyZeOhTGpXh+l46C9CkgxYVurcTg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="Y4K/N5xb";
	arc=none smtp.remote-ip=209.85.214.177
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6659E606A31C
	for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 05:13:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6659E606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Y4K/N5xb
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2ed1b9e8f43so11889775ad.1
        for <bpf@vger.kernel.org>; Tue, 10 Nov 2026 21:13:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794374031; x=1794978831; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=W+wFrqTn6TpSzq1GtCMNbpHfih/1qK8FVl9ONJGTXVY=;
        b=Y4K/N5xbFodrqUegieXyMTYNSGithYdyM8+6FsD+IomZWa6nY7GrQOOM8cU3MU3k2T
         119/bp3XwNY9qucMCHaoCeQYM9C3QzTDlb0HXRQcusvaqKsqQCiNXCMjN3l9mFAOmD4C
         lxQBO9WBubw2t0Z8HGr6jttVHrKW5VKgEv/CGbLuS6rDIEwKDgXqBzcJbmPzy8OHF+r1
         3R7h5A+tQeSqgQlkPHbPH5WMyl1DOjg8S/T6F1Awz+SqCSibag71OCRsHXAskqLOreNQ
         i891k+pggWNELrnFjB6pPo62bmwW16Rm2UI7b0125nmPLD20r/9G05NaUf+rPJE5nDcK
         1TwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794374031; x=1794978831;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=W+wFrqTn6TpSzq1GtCMNbpHfih/1qK8FVl9ONJGTXVY=;
        b=RZY0GrDB314DsOeu6igaAljDHlhSIUSbcGtD3z6qHmQfbWiYI4VsPHeoYSHTtK4Ar4
         zpRg5brNjeFAdUFMl3Oj9i8WA9kAa9NNU/68R0xt0g3HEqrxJVjExk3G/+9AEttr7mj2
         SUVb+UafsdYccUDUpYL3A4YxsPlsrzwQmpUdGzNWxYXa4/AVoWxoYKJDHbsMQ3V1IYds
         +BXXibEnUF/TMygT3A/2N1HVq41kfBMcMoxqyUy1rIVxYeSXpyu4K1ZOOvVqjDlrfllV
         rc+P5jv0cY52KcrXFgIsJi+gcGubDrO/j7xplf7ozVICExBR5PRpmBWCxvx2eIOk2DNx
         x1KA==
X-Gm-Message-State: APuU4Z/t+R5kqoeNqyAXD/v6bC6m/YX1G5uFa/DwmAChAhpfz4P6n2uq
	DJG1A9ABGXjctwbvVPf0qYHimYfIjVTasa4zbSi/ObykxqUOqrQffkGBxZw7Mw==
X-Gm-Gg: AYBFou1+P1fvsLS/YhlfQWjQQd480uLz+5OzAEIMe+Mc1GgRUOEmEVeq4S1++izTld5
	2PZA/1Dq9ildSepQCOs3CF4bAioi615u48gaAJzcdcrPRY10g+igASVhWxjTpAif0VF7DIjyggp
	2yChDUpNwQgY9MtSq+tVishx6IVPXNr4/Y7+SRzLZ4+qsPDXi3+vew0e1zVnk6wmvqwgagfSH4A
	SlmrGgBVTHr5Fa41D/dG4k/7iCNfHJkhaH0puoB3fuDCT7x2WIaW6CuBMK7GbHJDnKCfKJVjTfK
	g+w6JKufdZS8GyVAC5UIIVb7/yz6mh3Y0fX4jkPQuY4aLP15NYtb6PS9U52qwaXh0vK4EB24giD
	xhlSOgQNOMbzMgFbIdRMFCMrsaPgMP07xPM2Hiu/G7cRgDPv7Zj9LR4c8aQfIGjhGkgLTmVbiME
	3s5WGwIDyIf1REFhqT9ZRAsLmAIyYEC1xrqQId05fzhz3moBwWJwJPrQx2Gyhua67jvb1D3+wLD
	uA3X+lc2nxxlz7BreNDPjp0hsGVyeB5nwcpD7coEK35EpIVJXQfOY+xZ1ckoiaQMUYSidiKYzcQ
	UPrErv2Vzru7jE9iBewas7l8VVwjt4RmB1B3AX7zta8O+6ebTpAomKzz9rBFu0WM4gpFMQSgtRP
	A2uvaUiWEbpnld7e4zmi7y/4lJ701T1ZqWJOli9X88YMJDaUGhlMs20GZmMkUiBtdSVweVG+pEd
	4=
X-Received: by 2002:a17:903:1b44:b0:2ed:34e2:a997 with SMTP id d9443c01a7336-2edd7a6d8e7mr16521865ad.50.1794374030594;
        Tue, 10 Nov 2026 21:13:50 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.254])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2edb6d4d773sm16044905ad.20.2026.11.10.21.13.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 21:13:50 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v2 01/29] bpf: Keep the 32-bit range across a no-op sign extension
Date: Wed, 11 Nov 2026 05:13:12 +0000
Message-ID: <20261111051341.2800252-2-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261111051341.2800252-1-alexei.starovoitov@gmail.com>
References: <20261111051341.2800252-1-alexei.starovoitov@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Vineet Gupta <vineet.gupta@linux.dev>

A fix of precision in the main pass. It stands alone in this series. Its
tests come with the tests of sign extensions of linked registers.

	1: w0 &= 63
	2: w0 -= 63
	3: w0 = (s8)w0
	4: if w0 s< 0xffffffc1 goto pc+2
	..
	7: w0 /= 0
	div by zero

w0 is in [-63, 0] before 3. Every value of that range fits in s8, so the
sign extension is a no-op. The verifier drops the range all the same:
after 3 w0 is in [-128, 127], is_branch_taken() cannot tell at 4, and 7 is
verified though that branch is dead.

coerce_subreg_to_size_sx() keeps a range if both bounds have the same bits
above the low 8 or 16 bits. In a range that crosses 0 they differ: all ones
in -63, all zeros in 0. The check before that one is on umax, which is huge
when the range has a negative value.

Return early if the 32-bit range fits in s8 or s16. A register that passed
the check of umax has such a range, so that check goes.
coerce_reg_to_size_sx() does the same in 64 bits since
commit 0892ef2a7ef3 ("bpf: Representation for intervals with steps").

No verdict of the selftests changes.

Fixes: 8100928c8814 ("bpf: Support new sign-extension mov insns")
Signed-off-by: Vineet Gupta <vineet.gupta@linux.dev>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/verifier.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 20b1b9ff574c..5bffc1e288f6 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -6441,14 +6441,28 @@ static void set_sext32_default_val(struct bpf_reg_state *reg, int size)
 static void coerce_subreg_to_size_sx(struct bpf_reg_state *reg, int size)
 {
 	s32 init_s32_max, init_s32_min, s32_max, s32_min, u32_val;
+	s32 field_smin, field_smax;
 	u32 top_smax_value, top_smin_value;
 	u32 num_bits = size * 8;
 
+	if (size == 1) {
+		field_smin = S8_MIN;
+		field_smax = S8_MAX;
+	} else {
+		/* size == 2 */
+		field_smin = S16_MIN;
+		field_smax = S16_MAX;
+	}
+
 	/*
-	 * If value fits the non-negative half of the signed N-bit range,
-	 * sign extension is a noop.
+	 * The range already fits the signed N-bit range, so (sN)v == v for every
+	 * value of the low 32 bits and the sign extension is a no-op.
+	 *
+	 * This has to precede reg_step_reset() below: the base/step line stays.
+	 * It is about all 64 bits: zext_32_to_64() in the caller discards it
+	 * if the upper 32 bits are not zero.
 	 */
-	if (reg_umax(reg) < (1ULL << (num_bits - 1)))
+	if (reg_s32_min(reg) >= field_smin && reg_s32_max(reg) <= field_smax)
 		return;
 
 	/* See comment at reg_step_check_unsigned(). */
-- 
2.55.0

