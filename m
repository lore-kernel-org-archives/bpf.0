Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A02B3C276B
	for <bpf@vger.kernel.org>; Fri,  4 Sep 2026 19:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788551504; cv=none; b=HaJtLlaKfbgFul9jJtMY8a0Q0l8hv+ym7pigjNe0CxHERBygPKhR+fko7nCCJiMEhFwxnnA2eG6c4MmoZY/Cv/gPbrFTJ2ALBIodovyMDx1LlHgY+sblMDFrIRdZAMo9T0EXZGT+MU3Uwh3N5fwqpk39iAUcbWXGmfocbOQk9lY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788551504; c=relaxed/simple;
	bh=UZbyG5HwV/ItMLroTmcQJXFCJWeN9RrzvXMhN72UKYY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TZkeHi//sr9Ah10UxGvFZulsCoMqvbYjqh/3J0Ptkw7slZQANFZCO363yx3PNIFBRKmuUa0xGxwR1/F0UPUzUv3eiD+adAv10kLrc7n62CqO2yaLYUPA22ZpeoRAHXDbblf0GTXkIjOb63KAuh5KgwR5GdXuRfJR6PXiUp19sGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FX/HLFgC; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FX/HLFgC"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-86265451beeso359382b3a.0
        for <bpf@vger.kernel.org>; Fri, 04 Sep 2026 12:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788551498; x=1789156298; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fvrsiIV2Lldx5aqamYQifBQ5Wmg+CQWdeLatZB+qlSs=;
        b=FX/HLFgCMiToRE175+b7mm9v9nxn3pFQpwk3UlQlj9Tm+x5l5QYw/wlPtWfwqJqFEO
         CNcEx7Fym091n4GXtRxY/j5p0bFc+wsJ6+bZymOi7dfsOz3hFB5qls9pa/6Dds9PVlgc
         YruqbwbIpxB1UILlQCQF3oUgtT0s1i73arEH1/inH5/EjH9mejNpQzchMwzW6YJpPJLh
         5nK86Fy5756tC3uFh23jTPE4zCaEkZxxl52jKv74oofFZgAf2F7Gratk7PDOdLWVyfJR
         ntseAgKMWAe+JE8cTW4jLxbikXERhSD96HwgrP8CCnhmON2ir+aV8+GcVCZXfQvZxd7f
         QGIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788551498; x=1789156298;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=fvrsiIV2Lldx5aqamYQifBQ5Wmg+CQWdeLatZB+qlSs=;
        b=e7+9FmFo5W/t0QKzSq76tALS0kBjRNDVX99gpZTIZXIk6RgU/ypKK5i9QhX+wN8ePl
         UVFATR+nDwoYPR/7ANclnDN7/hQaiBHTAptKyNCdw3QDn6cj+nhCgNlrfS2KKmzKnYDW
         LC1StQIv8pxKQstTJf2+M47SbvcSMV+XOn6UE9gMW+b3uOr0vufMPzGBP8/NVoKsRlvd
         EY51bcHFewIWH3rMkw+ODVcVMFS+f6nVB3U2819i8NGn+fp0YXalz/B+TQH2VFA1lxZu
         49wqm03IHAWCTHZ/Lze5TTi2Mb+Uhy+VtlY/v1mf1RHdfL14Wob1XujZBKun/PE/EHCx
         1d4Q==
X-Gm-Message-State: AFuF++lOlVKEdRqEPPuV8pM9WEv3T6xCrHXHcITA0IBAxV/+aYfpQj1i
	Op2uS+D0KzH5PyK88pFDw9iCpY+cMwQouMevtH1GTS9kPs0Je9yF+50bHAdLwg==
X-Gm-Gg: AYBFou1wax2fmWO2ys8WrfLxAj+Ed9p5Q2yjBjVtvjkC4lEZcKWwuuqaOZK0rxlR3YZ
	N1+V9l3nJGxfFoXsQqAc3B51NOIS1ZdXxD106cbapcgJlCMLS+S8cvQwPCVOirYGWmRUGJEnBCj
	CFwrj9Gwelkz7s1klDXR6GdbjL/42qoh99hUCxDS8qXw0ofOoFT5J63qoZRLKAUgRcuu8ApGcX+
	S6frYWGXfi6STPPnwG3Laa+88GEuOhzEUchaY5aNTquj6+llE3MV8IAMqS2dt7Ptn8WWpg3LRDJ
	CZ7Ki+4+pFnXkIgzrdiiqN4ejxxSZnZuU0HN8zYNm3MvohQezo2VnCgl+tX+EXxYiT+N4YT4PPq
	3KoJPAC9JGi0N/wr+/2/XMOWtRuxz+NJm5Nz3Pcv3mTMS8bAxCtSn+AayNZCJgpna4uj1kvc4oW
	bzPv0dhIY+OQ7mC9atQw+4Yp0FlaqAlOmhtiPu5EMw44ZqBNhf7rmvoinRE6RlXlbXycxitE/N6
	Dr3ZzpMwviUTOV3bPwfmhHATI5FLeT1T4M5bT+r7Ci7WfQriUxevEsj24xQIPr54goxrGpq6urq
	88rnr17b5i3skkvO2gvXOtlolEmtIIGQBzI5YbnWFrl1XOzxrydn1Tz84ss5Tkbwo9u15I1+KLY
	=
X-Received: by 2002:a05:6a00:1151:b0:85d:84a5:b7bb with SMTP id d2e1a72fcca58-86168d8c2fdmr11042192b3a.18.1788551498348;
        Fri, 04 Sep 2026 12:51:38 -0700 (PDT)
Received: from sid-dev-env.cgrhrlrrq2nuffriizdlnb1x4b.xx.internal.cloudapp.net ([4.155.54.158])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8615404876fsm1497684b3a.59.2026.09.04.12.51.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 12:51:37 -0700 (PDT)
From: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
To: bpf@vger.kernel.org
Cc: Siddharth Chintamaneni <sidchintamaneni@gmail.com>,
	Jeremy Jean <jeremy.jean@oss.cyber.gouv.fr>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Anton Protopopov <a.s.protopopov@gmail.com>,
	Puranjay Mohan <puranjay@kernel.org>,
	linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	rlmenge@gmail.com,
	hargar@linux.microsoft.com,
	apais@microsoft.com
Subject: [PATCH bpf-next v1 3/7] bpf, arm64: Use resolved pointer for timed may_goto
Date: Fri,  4 Sep 2026 19:51:28 +0000
Message-ID: <20260904195132.141068-4-sidchintamaneni@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260904195132.141068-1-sidchintamaneni@gmail.com>
References: <20260904195132.141068-1-sidchintamaneni@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The timed may_goto fixup now passes the resolved counter pointer through
BPF_REG_AX instead of a stack offset.

Copy the pointer directly into the first argument register rather than
adding it to the BPF frame pointer again.

Fixes: 16175375da36 ("bpf, arm64: Add JIT support for timed may_goto")
Reported-by: Jeremy Jean <jeremy.jean@oss.cyber.gouv.fr>
Link: https://lore.kernel.org/all/20260824213158.3755932-2-Jeremy.Jean@oss.cyber.gouv.fr/
Assisted-by: Copilot:gpt-5.6-sol
Signed-off-by: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
---
 arch/arm64/net/bpf_timed_may_goto.S | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/net/bpf_timed_may_goto.S b/arch/arm64/net/bpf_timed_may_goto.S
index a9a802711a7f..53148c9a1c58 100644
--- a/arch/arm64/net/bpf_timed_may_goto.S
+++ b/arch/arm64/net/bpf_timed_may_goto.S
@@ -14,16 +14,10 @@ SYM_FUNC_START(arch_bpf_timed_may_goto)
 	stp	x3, x4, [sp, #48]
 
 	/*
-	 * Stack depth was passed in BPF_REG_AX (x9), add it to the BPF_FP
-	 * (x25) to get the pointer to count and timestamp and pass it as the
-	 * first argument in x0.
-	 *
-	 * Before generating the call to arch_bpf_timed_may_goto, the verifier
-	 * generates a load instruction using FP, i.e. REG_AX = *(u64 *)(FP -
-	 * stack_off_cnt), so BPF_REG_FP (x25) is always set up by the arm64
-	 * jit in this case.
+	 * BPF_REG_AX (x9) contains the count and timestamp pointer; pass it as
+	 * the first argument in x0.
 	 */
-	add	x0, x9, x25
+	mov	x0, x9
 	bl	bpf_check_timed_may_goto
 	/* BPF_REG_AX(x9) will be stored into count, so move return value to it. */
 	mov	x9, x0
-- 
2.43.0
