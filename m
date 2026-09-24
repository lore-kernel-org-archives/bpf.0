Received: from mail-pj2-f16.google.com (mail-pj2-f16.google.com [74.125.227.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA6A54AA59A
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 18:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790274240; cv=none; b=cvuMc+FWKksf5eCf7xt31c78/zEHLZBJ+Sor1sZUVzuVilsYIMuopCbQvwyRCBOLGy6aYAbUd/r5hl/5ZOOH9v07uOqhdzrjnc1Tl5Dg+uDPM/LzWWr2h3DZAzkr98z3GVjrjyEetMFQVXaHK97RHVrMW6TRdFNk77WAv6yhJig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790274240; c=relaxed/simple;
	bh=fK/KX9/HDOcXouoXYq+v+2Go/LI/Jpv/VM1fjyeLiEE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PZmgYwVKIdobnw5rMxJ/IqkINrRXRKAkEbP0ejM7aLQz+oN7jiOGxp9MBYo1yCv3XC82sStMmydwshDwRwye45qhAHHL23VAAZPS999htJ5XMEX5MHMIcek7SvxzXj1qqtQ8kwBP4KQP9/o33KUaP+3UrvHlPZHdBqz5oeSFeaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lVjQqq9i; arc=none smtp.client-ip=74.125.227.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lVjQqq9i"
Received: by mail-pj2-f16.google.com with SMTP id 98e67ed59e1d1-396ccd78e6eso113013a91.0
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 11:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790274238; x=1790879038; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=5ViRqa65Td4s56psAG6Lg5Pd5+aF2UE4FQK3X0NH02k=;
        b=lVjQqq9irMTGnYRmuCXMn9VobLT9gfOptVErw1yLPzBTI26jjsbkHKRQItgRABc1WJ
         jzMi7BLpdeb27V4vkrbn4OQx89U1aFL9yHl0U/izssraZ3C6+VvCab1NQGf6ZsXZj76M
         8tg5pjiUdv5UMvnbBB6blkw0OkH1WEdGWsFNzTEfGMrbszMy/ajEDswonYbUif24jGbi
         TaGRcReXI9TIVz+oK+eN9b+kX/Efw83AF7QXDfxqTEZuF87rx9zdo4tG9MJf5IfmNLaK
         TSZGgVTN+bVyPQtuulIZNGI/3tymhojqvBJqqOe0HogTUdePKEmPB51SUoSaEyZg6q+C
         hc0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790274238; x=1790879038;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5ViRqa65Td4s56psAG6Lg5Pd5+aF2UE4FQK3X0NH02k=;
        b=bOCqIPWuyQKu6W6qn62dqKLxx55eF6pvUYP3IOENjdIJTQnhut8LQA6OLjEhiS8DvA
         Q54XEI9Mo/Ukmb3SVhs6QVOtm335Q1++822QmMYBUi1B1PSdtjM7/zEwYbNGiYsS+u6y
         hOABi3ojPeu4MJOYRDnjjLyln/SN1EOJHNLrVnFopRc9rAYPyx9tdPBtdCz43WHIVRFL
         3DXzwrNSBC2rb8E/WLANmDLiYkexA7Yy2y6eZT2WtEoL7D9SrWUCEmRa8tR6BoJ8/YHw
         OkP746+RjE9RO3WOB0JV5E+WHaEkjSw30ITO8kkT63yAqQt3GtYA4OpfXaKJCsMan4DS
         HlfA==
X-Gm-Message-State: AFuF++lN3550pGtvOtzy4EzBSaLJTbQEvHspjTMyIr3IDcY+e7nVHzmI
	mFyFLj9RhRlvdztBYMpBnxI2VeDvlE81tJuHGHojnLr+3cyqVFWpMa6nvvHhkw==
X-Gm-Gg: AYBFou1RxFWRFmQjgDsbEv9d02+xmTUGP8b686JzjWAFoQK/R5t7JsJ6XCQGtjYknVY
	fwpzYsJYrhbeFaWEsit/GdiWz71eAKBN0R1LF8j8qgV34e4St0pTMHW46R1KjBIOmBcLhFTEG3u
	f+dZcof3GyHHU6+SxyiuPDcCSrxmIuNZkg9KCUxm3acijmOyc38S4lE4Bbh4cVioRMU+ujHBoZg
	rYh1p9zf4LVBXHSAeNjuXqQWsge/1ucAjCRhptajjeui3ZUYPO8Wi2TPJXIlySy89X2iwQhFvzy
	9Jgec8g6oyfgURo0NVceWnFy34iIWFCef1kVWDllPXDfNviGyhCmykCt8T81g9JQyCJS2eCFht3
	+62XCLJUlvEQrdS9KfCR75XvWTQj/qYI1lSdB+z9hax5VYv9HIcBUknCauXDzD6tNeuTl5OXAHy
	5IvVIf9Cavm0ooVzUzuB2ZzGbK1vH9rckC3mQXAf8aXwO3q6NRobBx1NfNc/pVzBXnHyWF26+y3
	U1PbM/wEcjB3fOSp2RkELiWgKIhZute3H5q+JQ+SsoHeTjYrpGzEjS6N9PXeKV2CdAhdlyNig1c
	jvhDy9RRtgqCQkP/lMcDqMpbSpkmw/PO92KOurih/xhw
X-Received: by 2002:a17:90b:5343:b0:39e:6c68:fd8b with SMTP id 98e67ed59e1d1-3a098b235a8mr2126986a91.32.1790274236688;
        Thu, 24 Sep 2026 11:23:56 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.246])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a08136cda0sm4267484a91.4.2026.09.24.11.23.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 11:23:55 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf] bpf: Fix overflow of jump offset in constant blinding
Date: Thu, 24 Sep 2026 18:23:53 +0000
Message-ID: <20260924182353.277516-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

bpf_jit_blind_insn() rewrites 'if rX op imm goto off' into:

  AX = imm ^ rnd
  AX ^= rnd
  if rX op AX goto off

and subtracts 2 from off when the jump is backward. off is s16, so
-32767 and -32768 wrap and the jump goes 32767 insns forward, past the
end of the prog. The jump is inside the patch, hence bpf_adj_branches()
doesn't check it. The kernel crashes when such prog runs with
bpf_jit_harden=2.

Return -ERANGE in such case. bpf_jit_blind_constants() fails the same
way when blinding of other insns moves a jump out of range.

Fixes: 4f3446bb809f ("bpf: add generic constant blinding for use in jits")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/core.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 273f74068068..4a3d66ae1afb 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -1361,7 +1361,7 @@ static int bpf_jit_blind_insn(const struct bpf_insn *from,
 {
 	struct bpf_insn *to = to_buff;
 	u32 imm_rnd = get_random_u32();
-	s16 off;
+	int off;
 
 	BUILD_BUG_ON(BPF_REG_PARAMS + 2 != MAX_BPF_JIT_REG);
 	BUILD_BUG_ON(BPF_REG_AX + 1 != MAX_BPF_JIT_REG);
@@ -1437,6 +1437,8 @@ static int bpf_jit_blind_insn(const struct bpf_insn *from,
 		off = from->off;
 		if (off < 0)
 			off -= 2;
+		if (off < S16_MIN)
+			return -ERANGE;
 		*to++ = BPF_ALU64_IMM(BPF_MOV, BPF_REG_AX, imm_rnd ^ from->imm);
 		*to++ = BPF_ALU64_IMM(BPF_XOR, BPF_REG_AX, imm_rnd);
 		*to++ = BPF_JMP_REG(from->code, from->dst_reg, BPF_REG_AX, off);
@@ -1457,6 +1459,8 @@ static int bpf_jit_blind_insn(const struct bpf_insn *from,
 		off = from->off;
 		if (off < 0)
 			off -= 2;
+		if (off < S16_MIN)
+			return -ERANGE;
 		*to++ = BPF_ALU32_IMM(BPF_MOV, BPF_REG_AX, imm_rnd ^ from->imm);
 		*to++ = BPF_ALU32_IMM(BPF_XOR, BPF_REG_AX, imm_rnd);
 		*to++ = BPF_JMP32_REG(from->code, from->dst_reg, BPF_REG_AX,
@@ -1605,7 +1609,9 @@ struct bpf_prog *bpf_jit_blind_constants(struct bpf_verifier_env *env, struct bp
 		if (!rewritten)
 			continue;
 
-		if (env)
+		if (rewritten < 0)
+			tmp = ERR_PTR(rewritten);
+		else if (env)
 			tmp = bpf_patch_insn_data(env, i, insn_buff, rewritten);
 		else
 			tmp = bpf_patch_insn_single(clone, i, insn_buff, rewritten);
-- 
2.55.0

