Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF18339023F
	for <bpf@vger.kernel.org>; Fri,  4 Sep 2026 19:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788551502; cv=none; b=tgFRrP6ACNoAS/u1OPzsua5RCkHAn63OmbPrMApsdgz8w0JauWQgXbUBX51wPk9gc7BMshQHeqD+4F72p13w1yo1fTBLiY2rW8mujr2nwiuOnGvJZFu/J5m9o81a+0xJentlbAQNHdwyqDiFDwXJkvS8qJpMnbZR5Oq1TSNHrFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788551502; c=relaxed/simple;
	bh=dI1AE9WdbQKr87RUO/gc2ngcTAh4FhPd4AAMBS/OIu4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gyI3U/+b8ADXvO7MjOtE7DD346zBXkQWrqYfljDlrw4uJTFwVKEWcCaOwfsHi8O1pHEn55bE8jb/9DU1BWaYRR+3+EwPScQI/d2+Orn5QSsSsAxsbE8gcrrsvpI3kXfPo6h43F8K3uUdwKXxNk18IqEKoyBsZOgNU6yJ4UuXnn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nsVEQ/Oy; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nsVEQ/Oy"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-85377c8bc96so1278657b3a.3
        for <bpf@vger.kernel.org>; Fri, 04 Sep 2026 12:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788551496; x=1789156296; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Tq4f0YItm8Nzb37FYEFxDW+SOlv8AsSzRVHLQA1+cF4=;
        b=nsVEQ/OyBxO1uyW7OhZsJ/d//WgQi1NJTAUbmBvgGN+5s189oajK+Yq8B2a/G8bVXz
         nva2vnfFv4LfxelPwnv7AKuyPsJIsUzuzhPEbdkFexx5/7tRIlsW+JfqH3IXz/H56KVA
         Z/1Ofm3gYezZloZWyeWXTFo4cDvaOh7lCGKf4hh5sBDDqLHdmrK2l5YjwlmgCHzu7ZJo
         rc1D8Ce3pdqQQUC4IW41ygsFORayW1WqDMdAQ31vTQ/Bb328tCYBWX43Zy5AEXsjjiYU
         iFraTT096SalYC/1zEn7B9u9A/H1dsAkaEwCWlgfsidUHaIkUgpjv39fnLhhRPvwi1m+
         glzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788551496; x=1789156296;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Tq4f0YItm8Nzb37FYEFxDW+SOlv8AsSzRVHLQA1+cF4=;
        b=dFVe36ISX1DOroYofIGCq5cY5SCw0MJbSe5Q1SttTE0Zfq95ilgPBGiiDWIWOw74kd
         Dn7hDTa8l3rsVftKrpVBA9Nkaqe6ovtCESDTWDmwVPK24vkdbhrAIT7J93eF+7bIOxFE
         O//4zmn38f4NOZbe9BJRb2JV1sSsEKDhh0F6iq5a0WTP4tpIqfCGEyyqExWFrDc68/64
         DTbB11xvlZrKLwZ/+jMPpcXTdng7PnTLTSjQHmOx2op3p5TgLdb0VKCd5ZIsIYvH3IFd
         aWUfNi6E6oswnXwcbCvvxKrL6s3ncFaHGpUbc0LySwuKwrEiDXDgH9hOvm0Oh8BpbBqU
         u3eg==
X-Gm-Message-State: AFuF++kPSWUJq7M9g2H7Hv0dO1hwwa92yIFwtANfOoPiNoVF8BXhpWwq
	CgvTcpvFvqel6St8LUGWTbR/W7yfqyM2q1R81uRfvC1qdCsbJPoHWEykxou0nQ==
X-Gm-Gg: AYBFou1Rwv/8dHXcgePO9hFoPa4PViLXue1CQx1hUfDbM+TjE6tn3i2y1dolhVKSfIX
	2YCFX0NQwx3/Q7EA3hoWzBsarDlaYOU11EsOuDNzt9eLTYyvzUD62JDj7ShAGghbiiIHBWVjawj
	jaTHGWl+4d+AMoyRqCi60zzW7fTpbglB18reXRQ79bTIV0PeL6Q91Ry/JtUHOqBQpjp0dJsGZ7r
	/0LcIgJtJhuhYoclbCE8u1prhFBIvvZINrio6j4Mj1n6lYJVAY1PyRuVoPA2zQrPhtSeuMJZq/o
	SotMXY16SsxjbgZHuK/wTo2hdRfj1J3UHRVLJb4Kb0VLgZnNaChJMCyKRPjscIV0qNFZEZj9mFj
	Y6104bKmRIWnx5Og6vJdW0KS0L6SlcoTNhSfSkpJhsmzt0mXDalor+wby5fEsC19n9TVmKUMIMp
	86vyOxL+wz/lu93M8luMaY8aesrU1bThFJwDlQiSOgvlknhdmXNAiBVzwqz2LGCR4dI1vOWyuJH
	uTsm+bw9eYuRiLfMqdSsR405+ijyfrQXsOQx9ESnPR3xDFMFSm8FhuEe5cJog5JulzJWNViWgO7
	y4xSHAnKuZZmd59QOTu8vPSUfVNRMVDp+FfzkwJbLe1AGuWKMLaT7YqyQVO+Pu+NdJu7sFbukHk
	=
X-Received: by 2002:aa7:88c2:0:b0:861:1acf:6915 with SMTP id d2e1a72fcca58-861676aa87cmr9593446b3a.11.1788551496447;
        Fri, 04 Sep 2026 12:51:36 -0700 (PDT)
Received: from sid-dev-env.cgrhrlrrq2nuffriizdlnb1x4b.xx.internal.cloudapp.net ([4.155.54.158])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8615404876fsm1497684b3a.59.2026.09.04.12.51.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 12:51:36 -0700 (PDT)
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
Subject: [PATCH bpf-next v1 1/7] bpf: Fix timed may_goto stack pointer for private stacks
Date: Fri,  4 Sep 2026 19:51:26 +0000
Message-ID: <20260904195132.141068-2-sidchintamaneni@gmail.com>
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

timed may_goto passes a stack offset to the architecture trampoline,
which reconstructs the counter pointer from its BPF frame pointer. This
breaks when the JIT uses a private stack with a different frame pointer.

Resolve the counter pointer in the fixup using BPF_REG_FP and pass the
pointer through BPF_REG_AX. Account for the extra instruction in the
internal branch offsets.

Fixes: e723608bf428 ("bpf: Add verifier support for timed may_goto")
Reported-by: Jeremy Jean <jeremy.jean@oss.cyber.gouv.fr>
Link: https://lore.kernel.org/all/20260824213158.3755932-2-Jeremy.Jean@oss.cyber.gouv.fr/
Signed-off-by: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
---
 kernel/bpf/fixups.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
index 65b441e4a351..dc59501a32bb 100644
--- a/kernel/bpf/fixups.c
+++ b/kernel/bpf/fixups.c
@@ -1797,20 +1797,20 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env)
 			stack_depth_extra = 16;
 			insn_buf[0] = BPF_LDX_MEM(BPF_DW, BPF_REG_AX, BPF_REG_10, stack_off_cnt);
 			if (insn->off >= 0)
-				insn_buf[1] = BPF_JMP_IMM(BPF_JEQ, BPF_REG_AX, 0, insn->off + 5);
+				insn_buf[1] = BPF_JMP_IMM(BPF_JEQ, BPF_REG_AX, 0, insn->off + 6);
 			else
 				insn_buf[1] = BPF_JMP_IMM(BPF_JEQ, BPF_REG_AX, 0, insn->off - 1);
 			insn_buf[2] = BPF_ALU64_IMM(BPF_SUB, BPF_REG_AX, 1);
-			insn_buf[3] = BPF_JMP_IMM(BPF_JNE, BPF_REG_AX, 0, 2);
+			insn_buf[3] = BPF_JMP_IMM(BPF_JNE, BPF_REG_AX, 0, 3);
 			/*
-			 * AX is used as an argument to pass in stack_off_cnt
-			 * (to add to r10/fp), and also as the return value of
-			 * the call to arch_bpf_timed_may_goto.
+			 * AX is used to pass FP + stack_off_cnt as the argument to
+			 * arch_bpf_timed_may_goto(), and also holds its return value.
 			 */
-			insn_buf[4] = BPF_MOV64_IMM(BPF_REG_AX, stack_off_cnt);
-			insn_buf[5] = BPF_EMIT_CALL(arch_bpf_timed_may_goto);
-			insn_buf[6] = BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_AX, stack_off_cnt);
-			cnt = 7;
+			insn_buf[4] = BPF_MOV64_REG(BPF_REG_AX, BPF_REG_FP);
+			insn_buf[5] = BPF_ALU64_IMM(BPF_ADD, BPF_REG_AX, stack_off_cnt);
+			insn_buf[6] = BPF_EMIT_CALL(arch_bpf_timed_may_goto);
+			insn_buf[7] = BPF_STX_MEM(BPF_DW, BPF_REG_10, BPF_REG_AX, stack_off_cnt);
+			cnt = 8;
 
 			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
 			if (!new_prog)
@@ -2661,4 +2661,3 @@ int bpf_remove_fastcall_spills_fills(struct bpf_verifier_env *env)
 
 	return 0;
 }
-
-- 
2.43.0
