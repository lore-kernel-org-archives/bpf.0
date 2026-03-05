Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B0B93E51C5
	for <bpf@vger.kernel.org>; Thu,  5 Mar 2026 19:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772740125; cv=none; b=iXELkd9dCarjhut58cSZMmJW3MnHF28K98ut/zKnoAmZhpUk8Mw/svLa2693McMahhbC7M+0xrU+eFfZfcAGa6h/DOZlcyNoL0MOj6j1absdGi7xvFU+TiWERj+6/KX8jir2inziKWRHqGqxr1LT6prRSQ5r4qpwWW+Fvvtb2w8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772740125; c=relaxed/simple;
	bh=n/bMdWhr7fzZdwK88ho1TFU6mNWQMq+qIm5yADpnoi4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tlNYh4FPFE1lmS+xXiiXQutCQHLYlsCKbzs8cRDoURzRHE8pDe6JvEPx6Rk4QnbdYDhl1qvBdKxPVdHkw25+Y7a0UCoai2hyR24BJeCf/iIcgzTszEB+4wUecHP0ISkZ9LdtYcRN7we9MC+7gWYjCsa+uCXU5xLc6KD3QObRr6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mzLRUj5K; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mzLRUj5K"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-5069b3e0c66so126535931cf.1
        for <bpf@vger.kernel.org>; Thu, 05 Mar 2026 11:48:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772740123; x=1773344923; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zKoqStTwXkQfzF+sOnp5j+iYBFEGEs/CXIPvhniI4fk=;
        b=mzLRUj5KQnsNJP9fygsSTl6C4iBN0RiT+xmOVMey1M2qUjBhvM0LfjIQMy6T1AJUXJ
         qIBVWL34SMecMwvOn7ejgnY8RiSPZfAshj3RDNE/LFJ7jmWElEkbCPF8iZPhIjLeS4fq
         ZVBJksnGi9De5QExPmL7BW4qIKqOnggnb2+raX4oDdrAIbSjj5yy1pqg2ZDlJHrW+3Zv
         eArPGu+Xui0BZZP0zTTdDkRnUyjXLnNZP6oSZf+qKfcjXZJFD7JXbQbbbs9nKWnp25O1
         n8ac69FI88Bs9ls+E6AC8L9zyZDc5KAXcThjFO6Zvmk+Mfi3wTpFyXrCEFWlPNXEug4e
         PS+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772740123; x=1773344923;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zKoqStTwXkQfzF+sOnp5j+iYBFEGEs/CXIPvhniI4fk=;
        b=DYeS4ZXs7/Obh8OW8XAH3cwFoTpmVlbxznrg776pnYOWSY38fm+/127cRJl5x7o/eI
         sKHpWeRf3lGhCsloFVCfZKwi27jAZ/4XRWxdXkrH+dPIr2MdH6Bd06EMGgZiaGcXXHZv
         czYsTfQsY9KbJczvD184Wv2c6I2BHkAvuynTDQDwRwrr0UseB2WSl/kGXR4Ht9yXCmbk
         rIf525NCUzFlF9U91YzMk8ecbM06v1A1bkoOGFpOmA4T5x3dzrR7or+ZTkx5DRTmDqQv
         YULkxma20y0IeUsDNMRPAT/9c62+9qbThUE38Yh5Ijkyys8w2/riY/Jh+BLaMCvCIetN
         hVJA==
X-Gm-Message-State: AOJu0Yy3cJhn8hygyKFMlyPpjSOkJHQsiDMMIsIhtvJeEklaYG3B7A3O
	cD1vQZI1JeotYeq3NTxxs8hmIH47lf/3/xdb++8unxOypzEok5VaE8KzKdvyMw==
X-Gm-Gg: ATEYQzz4FoUpXMeJKFVrcKTaZh1YsVvtWq3Gwou4upyd+E14t+5tk8+OK5C3m916noF
	RFr3FeB848xxldBFMyvEVnJ66VgHOQqXI3QkVrk1pUPkyeQOVnkzKP26e6F1oQoFdKhnF3hSWOf
	veMa2qmsp5lkuBedX4BkvsCP9fKP/fExliACOVJ1UCRrgmx7uKxyZatF6QOOhKJw8LnJbyxStYb
	K19lw2Jn+xuOpdqpIMaY/sm2+kw95IviE+YIZnBlj9z+O1g4jTxtvNUCAad8SX1jcWp+O4rK9tv
	qv1vuL4r4SRmM5+s+G4vthCJCt5RpSbifnmLrSSlm65TZNbdyZ9glda2EXrTEdIcDSCt6pXVwe0
	PJde4PRasKwni0T++LzhY1bT+hgoErnTV5xNpaTW3vB4XgQ95x6TSYsYtEp83N5N3E3VY5C8ZFA
	E4hf+VNXN1Ze3QTkArg6C5gYtLu1V+m0ApkMiZQ3kZ0sZnPNWpZbaZN7dAb2zKRmBvPCphUjHyE
	i/EaA==
X-Received: by 2002:a05:622a:c1:b0:4ee:1dd0:5a50 with SMTP id d75a77b69052e-508e68adf01mr40682441cf.17.1772740122829;
        Thu, 05 Mar 2026 11:48:42 -0800 (PST)
Received: from ezingerman-fedora-PF4V722J ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-507449874b7sm178755661cf.9.2026.03.05.11.48.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 11:48:42 -0800 (PST)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com,
	emil@etsalapatis.com,
	arighi@nvidia.com,
	shung-hsi.yu@suse.com
Subject: [PATCH bpf v2 2/2] selftests/bpf: test refining u32/s32 bounds when ranges cross min/max boundary
Date: Thu,  5 Mar 2026 11:48:23 -0800
Message-ID: <20260305-bpf-32-bit-range-overflow-v2-2-7169206a3041@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260305-bpf-32-bit-range-overflow-v2-0-7169206a3041@gmail.com>
References: <20260305-bpf-32-bit-range-overflow-v2-0-7169206a3041@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Two test cases for signed/unsigned 32-bit bounds refinement
when s32 range crosses the sign boundary:
- s32 range [S32_MIN..1] overlapping with u32 range [3..U32_MAX],
  s32 range tail before sign boundary overlaps with u32 range.
- s32 range [-3..5] overlapping with u32 range [0..S32_MIN+3],
  s32 range head after the sign boundary overlaps with u32 range.

This covers both branches added in the __reg32_deduce_bounds().

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../testing/selftests/bpf/progs/verifier_bounds.c  | 37 ++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_bounds.c b/tools/testing/selftests/bpf/progs/verifier_bounds.c
index 97065a26cf70603c3e4b8d43d3a04248828398fc..60ef976959153d25c19ba08c3c2f265d8d83b33e 100644
--- a/tools/testing/selftests/bpf/progs/verifier_bounds.c
+++ b/tools/testing/selftests/bpf/progs/verifier_bounds.c
@@ -2000,4 +2000,41 @@ __naked void bounds_refinement_multiple_overlaps(void *ctx)
 	: __clobber_all);
 }
 
+SEC("socket")
+__success
+__flag(BPF_F_TEST_REG_INVARIANTS)
+__naked void signed_unsigned_intersection32_case1(void *ctx)
+{
+	asm volatile("									\
+	call %[bpf_get_prandom_u32];							\
+	w0 &= 0xffffffff;								\
+	if w0 < 0x3 goto 1f;		/* on fall-through u32 range [3..U32_MAX]  */	\
+	if w0 s> 0x1 goto 1f;		/* on fall-through s32 range [S32_MIN..1]  */	\
+	if w0 s< 0x0 goto 1f;		/* range can be narrowed to  [S32_MIN..-1] */	\
+	r10 = 0;			/* thus predicting the jump. */			\
+1:	exit;										\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+SEC("socket")
+__success
+__flag(BPF_F_TEST_REG_INVARIANTS)
+__naked void signed_unsigned_intersection32_case2(void *ctx)
+{
+	asm volatile("									\
+	call %[bpf_get_prandom_u32];							\
+	w0 &= 0xffffffff;								\
+	if w0 > 0x80000003 goto 1f;	/* on fall-through u32 range [0..S32_MIN+3] */	\
+	if w0 s< -3 goto 1f;		/* on fall-through s32 range [-3..S32_MAX] */	\
+	if w0 s> 5 goto 1f;		/* on fall-through s32 range [-3..5] */		\
+	if w0 <= 5 goto 1f;		/* range can be narrowed to  [0..5] */		\
+	r10 = 0;			/* thus predicting the jump */			\
+1:	exit;										\
+"	:
+	: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
 char _license[] SEC("license") = "GPL";

-- 
2.53.0
