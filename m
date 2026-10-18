Received: from mail-pj2-f9.google.com (mail-pj2-f9.google.com [74.125.227.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA163FF1AC
	for <bpf@vger.kernel.org>; Sun, 18 Oct 2026 04:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792297325; cv=none; b=X6P84wPs/1c+x/6d30YF1OeQRZ5diDhqTLmikS80BxZkI8CMmrag0Kr7sIc2bXyfdt36nEcGXH4//jpexuZDKNFs7V0XsDvy5QTtFKCzqs8HO/RnX4uOqYOyAXYTKKvaxll0CTXlSrrlv3+4a+4XET8n6SOG/QBcGeibCurSnnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792297325; c=relaxed/simple;
	bh=T0D0pjcsyGvxTyK5PT/aORMTl8tn98rPVPonnB4jtB8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jM1DWhtGgDYqBf9y/6vpChyu/TAksRHTVAsJ3RRmzizxj26TZl3wOPN3a+5k+QH3/+Rv69yowSV8Sa75wI1F1/XyuiDuuR1kVUsuIxG1qp2aLccI8jfakEWHCQeE9MRAzbuuoOfFvfCLGx/DwC28GsA+7fJyXvGfz5ou54SulGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V05+gcCi; arc=none smtp.client-ip=74.125.227.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V05+gcCi"
Received: by mail-pj2-f9.google.com with SMTP id d9443c01a7336-2e97ddaf3c4so3610125ad.1
        for <bpf@vger.kernel.org>; Sat, 17 Oct 2026 21:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792297323; x=1792902123; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=U1BjCtlAaE26RncqrvBMm6eqB5Nsd5pySOKKBL8HRGg=;
        b=V05+gcCicJ8LKyYxDfFRUCCm2P7lmZG1PpzjJ31tPM9oZ0/8ZqFVEbN4eO1NH23WBR
         7SNc6Bu58R3alxYIz+z/k8YW+Y36plYhOhoeLLOPmSgQGHAt2H8mxuJawrTIwePxHxAs
         /0vBf14jPhMs4/mUcokr67qmUUB/zR2nprMOdaw9D4rws4VSGGvDnGYA0B+MEh2xWXLp
         bAEjJHIdj910tBUT9tuF5otnMIHPe0xl4Y67VQ5mGD7q1l1MagOBOYBnBQua2Q+/V/S4
         v4NovjGhvzFaGBVPSdkpyCGVjiKKV6yqNsUIv1c591yRjkwH2yPG3NUqJwmb9jHIVgGA
         1KMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792297323; x=1792902123;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=U1BjCtlAaE26RncqrvBMm6eqB5Nsd5pySOKKBL8HRGg=;
        b=QQNjn9V2pLV9rnwXf11rWQ1dZb7sRMoS26FuxKXUGKHp9OPI/1kQ+v+J07T8Toy6IH
         OFNOKLGLtw6K7wbQkk0xYCoe/v5kLtiPosxTy/oFxxekof6hWlGHtfWiDUvu/T4gVLax
         /sM1RpWpYqFunt/c9rbJkChzQCbk3qLwX0sbXEKLKPj26M50qYWGzMA/taxM9dldXyRx
         IyYbbPV3ZDyXEWJdySoug579efySuOqCNg50oA6LRtdcD8kdQvPv2tkKQiZPHrPvx+xq
         7et39m+GaArnqkv4fuaRI9A3EdLaXcC5LfrD659lnObs+p8r65AoLvFCkfmrpIp26hWp
         2eHQ==
X-Gm-Message-State: AFq9FYJzpdPnMy6xYmUSSnXk7+VMhMo4CPf+51PHpi+dFsc9KoHug2mG
	tyBKpGgevcDi2316dgQAsCfB5/A09pW4an7ZEiL1GGg3xcWetoYLug67
X-Gm-Gg: AYBFou0Be/wicd5HnoR76gbcl+J91MbRLtuDtr3l+6Or6BjqZdMo0FGTxsPdBuJFsun
	wLhgaH/ueMku6wXndlKxPdl5HdkD3eeP74DDc2qIbt2UuNTmWst1lGNZX1FlbWDvBqoQk3v2icQ
	ssrLyXt+FDfaGK1yNTrK2SZSfJ3lkKD5Bxa2Qh0m8PAhfZACr3bT51PmIRvNuvDe3SChurQvFyi
	p/ZODhxBA1rwB9LcdTcNy+Xfgp6atkMjATJtfX7iQGniPqVGjhqxkwaU3xkoAeWhJ1ALYGAGUot
	CO8SQJ7Hc7DuIqdsww9EOsF6KmRrglQH+e0MzINY55xFXufGfGH22otf3kpLZCPV1CMbp+stTGr
	VkpjIndiFfEbNc+zWAOi4iNNW4oGel3ntZBxhLF+6sWOhypXczKLCVTc7dygn63fF/cKd3rYhy2
	z+iClUjAAAw88Ghb3+MhY1OgSjIdm0vW0HT+KWLCKPyryM7go8hbq8vN+U44VKNTKq0cBA0h0I
X-Received: by 2002:a17:903:124a:b0:2e9:8b24:8dca with SMTP id d9443c01a7336-2e9a6d367aemr36866455ad.54.1792297323127;
        Sat, 17 Oct 2026 21:22:03 -0700 (PDT)
Received: from [127.0.1.1] ([123.109.188.177])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e97e8758efsm24799195ad.55.2026.10.17.21.22.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 21:22:02 -0700 (PDT)
From: Woojin Ji <random6.xyz@gmail.com>
Date: Sun, 18 Oct 2026 13:21:41 +0900
Subject: [PATCH bpf v2 1/2] bpf: Zero-extend the index in inlined
 bpf_get_func_arg()
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261018-get-func-arg-v2-1-048848b3eddf@gmail.com>
References: <20261018-get-func-arg-v2-0-048848b3eddf@gmail.com>
In-Reply-To: <20261018-get-func-arg-v2-0-048848b3eddf@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>, Shuah Khan <shuah@kernel.org>, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Woojin Ji <random6.xyz@gmail.com>
X-Mailer: b4 0.14.2

bpf_get_func_arg() takes a u32 index, but the inlined expansion compared
only the low 32 bits of R2 with the argument count and then shifted the
full 64-bit register to compute the context address. R2 is ARG_ANYTHING,
so nothing guarantees that its upper bits are zero: an index of
1ULL << 32 passes the bounds check as index zero while the load is
performed at ctx + (1ULL << 35).

Shift the index as a 32-bit value. When the 32-bit bounds check passes,
the low 32 bits of R2 are below R0, and R0 is at most 255: the trampoline
arm masks the argument count with 0xFF and the raw_tp arm uses the BTF
argument count minus one, which the verifier caps at MAX_BPF_FUNC_ARGS.
The 3-bit shift therefore cannot overflow and it clears the upper bits of
the register. Widening the comparison instead would reject indices whose
low 32 bits are valid. The check itself is unchanged, so this cannot
change which programs are accepted, only the address that is computed.

Fixes: f92c1e183604 ("bpf: Add get_func_[arg|ret|arg_cnt] helpers")
Assisted-by: LLM
Signed-off-by: Woojin Ji <random6.xyz@gmail.com>
---
 kernel/bpf/fixups.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
index d6f83521fc78e6c6a82d1969662f1eb52f64f4c3..ec62df6811e0b0b9da11405cf189c0f0419a4496 100644
--- a/kernel/bpf/fixups.c
+++ b/kernel/bpf/fixups.c
@@ -2256,7 +2256,7 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env)
 				cnt = 2;
 			}
 			insn_buf[cnt++] = BPF_JMP32_REG(BPF_JGE, BPF_REG_2, BPF_REG_0, 6);
-			insn_buf[cnt++] = BPF_ALU64_IMM(BPF_LSH, BPF_REG_2, 3);
+			insn_buf[cnt++] = BPF_ALU32_IMM(BPF_LSH, BPF_REG_2, 3);
 			insn_buf[cnt++] = BPF_ALU64_REG(BPF_ADD, BPF_REG_2, BPF_REG_1);
 			insn_buf[cnt++] = BPF_LDX_MEM(BPF_DW, BPF_REG_0, BPF_REG_2, 0);
 			insn_buf[cnt++] = BPF_STX_MEM(BPF_DW, BPF_REG_3, BPF_REG_0, 0);

-- 
2.47.3

