Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADF1D37B02A
	for <bpf@vger.kernel.org>; Thu, 27 Aug 2026 22:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787870926; cv=none; b=tQyFzd2Ota9PmyuZQl0WkhhpDo15+p0wFuaLq/Lp0dQu+7SsesR263kKJ6jS0uEu11ncamUVCOwc6VoMS4kY1tAIsi1XiSrZLZEmU7vp+7kEfYZwid6vP6x7qT3QJ9cxlHIX16tb/nIWv2wWrLW8V1E/4a95UC313dpRgDfB/bI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787870926; c=relaxed/simple;
	bh=v1R0MN2zW5QroyRc9bYQ87UmJyvUO0tiLR41KgtS62Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Yip13iEgjcrHVymUzVgZx/2PLpMyQwGn1egkNko8pC78Q9g+xQO4cWaWSHc1tUZsIF5bvqp/WqKcDYBP6TXSJlHELunOaT/Wbbk24NZDFSw6UNptIebYarBRNrB2FqNCqrpY95RKsghndI5KMWZ2SaJg8C3s0IpUkRkwKofyWic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EC2uUT+e; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EC2uUT+e"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2cfbbdfa60bso4523565ad.3
        for <bpf@vger.kernel.org>; Thu, 27 Aug 2026 15:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787870925; x=1788475725; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=x1DiYniZa7WzM3xIMhCGI8o8zkf9iFI9f25d+J+lmXY=;
        b=EC2uUT+e7kuBCKUeVxPmT8gaqfPZgDCBvSm1ZP7hI/xUByCqLRBe3ffbyjlQgEINyA
         mamjouQoeaUJwjIQNV+o2GmnxwvzhAcxwoaJb435MPF58n8HJG8s7nh1HKSWnvFJcRot
         gB0cFTexr6s9kc+xt29s1Km07KYyF0sDuwtE9SwpcfIHj1NzheU5VTGzm0PXH1A3DrXp
         FJbvTe097eewKWp2dWND2B3DsNSl2Tup6XjZcPhMp70OZutmvhIE6CS085+PEQfTlwwV
         vNIg7UTOmZAzjQ/GXR+fvm/+pQKVms9xUue84UOGk50/HgkMHtixKXxbQ9I3xji7F6WQ
         vtxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787870925; x=1788475725;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=x1DiYniZa7WzM3xIMhCGI8o8zkf9iFI9f25d+J+lmXY=;
        b=qxrn77KGN5Y0WsLUabk/FZQW030F88FkabL6NEMJQIPwlW7vgGQUybB9P4q86bq8ye
         xpVJbH2Iw1ym/CLoXrf7P2qdjIbngtNWxUajNPhPRGhg/sfQx97VlfW+PqQq7sNljdTy
         pFfPDyio6rJUnurTXZpJ7Kt23Eunr/VJSQ++Q6chnGStDqLZxDrhus5GL6urG+cxK2AK
         GJL4LjW0xwm06iCaPHqQqhvv7nFy8ddi3qd1MuT+fqhVsCbqxlEJWxF4eX/136MQxz46
         KsFrN1HmJG9+d9yjlGMCJGFBrBJF+98Pwmw2ayTe/RF8dc93HWTBW1XKgAmsRGpFfZbd
         gBIA==
X-Gm-Message-State: AFuF++mEJGyF0aTd8d4+lwWcGKHByHMl4dSGknCkXQSkA7xayQWLJrVB
	UqQmv5nBvhBJD0Ea8PC1x+Ov4hhKtPBVoYJZgCp5s+yzCAnY9JxPHqriDMKRxPzTa4A=
X-Gm-Gg: AR+sD11YoGMzCLrLlAXW5HuVoKVIQ8czfIPoQ+fBuv8bBkgnAy+UlT9HyJLxSd+VPtI
	VocunJOUJUlfvhSzpgN640LUFncwdyZYUUqvFKfH7V+L2r0Vy8IE/yx3XKqvnWUqhlLMcoNqHBt
	S260JGad8cuP9VcXXqLZIYr4PYY08cPL4LwVitYEJ52S+mGeitAgwfWNR1CMsiw7OdFqbkOaKQg
	n1xyicZ4PuIAFo4ObCfpA0XLF0rwk7d7PDhbGQW3LhQBgKt0agScvXffj5JpxWaZTBeT9NE0XoU
	H5jV/336oFhjQzo5BsJ9+nM5Vh+lLXt5jWb4n17mHDMmFCts354ZgBjkvulyjc2vf6Orpk9s/hU
	Q1gYGFUTv9f3iEJufAa57f+cxCQk/0r7ZPhzC+zef0yTOybQAsMsk9X2+feygBy41IpPkbDfWed
	zff/gZdUpk3WXe1WtBrfM6ImFjj5t/o/BTUMhRR+YfK7f/vELKRYtxszMb1AZCRcZkaqGOfQqzm
	oZqoj7pyeJ5T2zbH3v6SYb50Rx+JkTeTaifRndh4OTB
X-Received: by 2002:a17:902:ebcb:b0:2c9:e846:a57e with SMTP id d9443c01a7336-2d74cfcdb1emr54106455ad.0.1787870924760;
        Thu, 27 Aug 2026 15:48:44 -0700 (PDT)
Received: from ezingerman-fedora-PF4V722J.thefacebook.com ([2620:10d:c090:500::6:e049])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3283d7303a2sm22504228eec.10.2026.08.27.15.48.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 15:48:44 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	eddyz87@gmail.com,
	memxor@gmail.com,
	npc@anthropic.com
Subject: [PATCH bpf 2/2] selftests/bpf: half-dead scalar zero stack spill test
Date: Thu, 27 Aug 2026 15:48:24 -0700
Message-ID: <20260827-bug-011-cleanfunc-stack-zero-simple-v1-v1-2-c0e996589a52@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260827-bug-011-cleanfunc-stack-zero-simple-v1-v1-1-c0e996589a52@gmail.com>
References: <20260827-bug-011-cleanfunc-stack-zero-simple-v1-v1-1-c0e996589a52@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

A test case demonstrating unsafe pruning when spill of a scalar zero
spilled on a first pass in replaced by STACK_ZERO in the
__clean_func_state().

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../selftests/bpf/progs/verifier_spill_fill.c      | 40 ++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_spill_fill.c b/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
index 8b166c42c4e0..39a1766dae3f 100644
--- a/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
+++ b/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
@@ -1403,6 +1403,46 @@ __naked void partial_fill_from_cleaned_pointer_spill(void)
 		      ::: __clobber_all);
 }
 
+SEC("raw_tp")
+__failure
+__msg("access may be outside object bounds")
+__flag(BPF_F_TEST_STATE_FREQ)
+__naked void imprecise_scalar_spill_half_dead(void)
+{
+	asm volatile (
+	/*
+	 * Fork two paths: the one explored first spills an imprecise zero,
+	 * the one explored second, an imprecise non-zero scalar.
+	 */
+	"call %[bpf_get_prandom_u32];"
+	"if r0 > 42 goto 1f;"
+	"r6 = 0;"
+	"goto 2f;"
+"1:"
+	/* causes out of bounds access on a second path. */
+	"r6 = 100500;"
+"2:"
+	/* Force a checkpoint before the spill. */
+	"goto +0;"
+	"*(u64 *)(r10 - 8) = r6;"
+	/*
+	 * Force stack cleanup, only the low half of the spill is alive,
+	 * so the dead high half is degraded to raw stack bytes.
+	 * Buggy verifier converted it to STACK_ZERO w/o proper precision propagation.
+	 */
+	"goto +0;"
+	"r7 = *(u32 *)(r10 - 4);"
+	/* Use r7 as an offset into a one-byte buffer. */
+	"r1 = %[single_byte_buf] ll;"
+	"r1 += r7;"
+	"r0 = *(u8 *)(r1 + 0);"
+	"exit;"
+:
+: __imm(bpf_get_prandom_u32),
+  __imm_addr(single_byte_buf)
+: __clobber_all);
+}
+
 /* check valid spill/fill, ptr to tp buffer */
 SEC("raw_tracepoint.w")
 __success

-- 
2.55.0
