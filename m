Received: from mail-pj2-f41.google.com (mail-pj2-f41.google.com [74.125.227.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B27A45A2B2
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 23:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790292705; cv=none; b=PU0xf7/xO0ViUZLwmEbUtEKwWolFat6vh0cfUUlJsi/kgptoCv8tVhLzPGx+3VG0/cMlKj3N0Do5eTqE79fha8ske0xyVALUt+1t7vaHOQE2cpJGuMKChTP1gHopeU0a7QRbHFm2cebONLQWhZUZFQFZ5XzdJZgLMirnBsMOX38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790292705; c=relaxed/simple;
	bh=bvIP38J/GB6R5pRzVCSen9UzBhMM8VW4LT392CwwKyk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rqXVoX0QUG+2xkR6nHYMdrNN3VaU+buaItsF3mFvawH/QlP7VREgsN9NsCekuMP6qwhHiTY9qqOyo71PyggmOst9csgSMcR4Ak0VLHf3mGZFwSdf5FOQzkOYfdM+M/IIYbkZ5zhsHsNFORHetr801CF97Oe4IW9SOAQZBFeHqfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F6od+8Of; arc=none smtp.client-ip=74.125.227.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F6od+8Of"
Received: by mail-pj2-f41.google.com with SMTP id 98e67ed59e1d1-3a0b18f811cso289062a91.0
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 16:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790292704; x=1790897504; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=x/ZY2fU0GJ119Gd4ic6YPu0NVWRtTskSJDtEgoXL+4o=;
        b=F6od+8OfmD4ectXqjUwvAQJPZNtXKJGUGXLEGkdMnA6YVtkngyKw7Rkn8WBQjlAtgI
         ztSRJJW8QT1H2jvLBA+NkvBxfZ/NbLvBA1L+rOplVSPap3VnrgvRWYx6irUkkacUXxmc
         ZFwNrEagioivxGtD87TZHQj985Du5aNJss/RiLQ49KTqgelq5pGyphJqe4e9X0K4W+kl
         Bf1vTjaovz3CyDyZWWWcU5g3WDQHMeQrO8YsHc+leb2qY0Elpf3GiDv4NP/lPiwx7yfV
         9OAAoyrkxk+l+8qbna+Cj5BBwgl0tVOqqqyRpwMfWZrg069d2Ldio+3GrcKjBt0ozlnM
         zxyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790292704; x=1790897504;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=x/ZY2fU0GJ119Gd4ic6YPu0NVWRtTskSJDtEgoXL+4o=;
        b=pLcXdPnmlE4n/jxO3jZxV8HH3wYTa/NwCia1MdYE1untjVxZCfhwKBqkr8zKeKRV+n
         nzXUGsiIjLNxCwhRuGhA9FukdxIHdFx3SBZKv7mkZJC941rL2lDcYEwtSdLAXmPYI4Ro
         ROa5DbqZdHUv5KMn9Kl7abWpXmB4iga/JW96IYE3bgXFcHziD6v+lYbhaTlO/2rhD6/J
         67KbRYN2yFmT4I7a9gRIhNpF4smsc4hzeo3JpAWbmeZrfsr86fIO0mopOOryE2eRGzXS
         t0aP6hzIdZQzLlEJlnGW+DXObHaZzRE7HVmj+LsBpEMCrQwaWirnkaHs3/pyVabtgF/R
         KT5g==
X-Gm-Message-State: AFuF++mCnmjQFEv8BHFuazco1shkJ6/Z0korlqie+bDC1Tn0TkqaB58f
	OfaNKXA5U4Nl1qwkxUwFbDlMEkj6NfocUCpcRY8fvmGLH1osf/YvxsfY7twK2Q==
X-Gm-Gg: AYBFou1IxTblVHD4FGhZEW4FcM6WSnx3AZukVsd5Iw86cfT26Uh4lZKi/P5t5kGuU4L
	3kMvWNncjHY/KCEvdvezRld2gWWa6u3Ad2YQNJwH3btMIBiabr8vj2RyCo+RRbEWyWnFtBNE4PK
	HnmsovYSiHJ1A7tqrY8EwswTmDVviRFM8A9Jm0tKnMrQTB0iZTil7gIu94vZqiSGfqui5KjE3bJ
	swlrdXNqxpKa2TAuCnaKY6/HnKIUk5MAxIUyXG3ciNdjDW3qG3x8Ag2ObB6gRAbCnkCOa4HJfkc
	molrnmQLMSI6jGZYxvEHaOUommx91+P+iSbkGdnr3mGoZCyN27hKVNHQ7QxEN2UukoKiAXhErxV
	ppc5Aesv3AfFJnYlb+BCBtvyxw/PpIQErU4myDCNtTTAhFimzqXWPV7uzR8kG8AVwLDQ/Vb1lRG
	MlsB6YKfME3uuGhy6s9NXWv11y1ALvl4M9MlO/1aC3SYBbBkHNnJUTEVNfxJNawk3JHrf1uS7LU
	YjVbjyZyqYucUhd4/8XJPl9Eita7NrHw94gT/3SLitri1b7SdpSga3XRQwLGBKJ7p/b3yb4Z1gF
	AJifwz4FzhLBoYkxUgulzfOpspot06X0d/8Fhosw8yE=
X-Received: by 2002:a17:90a:e7c4:b0:3a0:809b:1972 with SMTP id 98e67ed59e1d1-3a098ce5e08mr3609818a91.26.1790292703731;
        Thu, 24 Sep 2026 16:31:43 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.240])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0b9589bbfsm885514a91.9.2026.09.24.16.31.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 16:31:42 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 3/8] bpf: Adjust pc-relative insn copied into its own patch
Date: Thu, 24 Sep 2026 23:31:25 +0000
Message-ID: <20260924233130.1213812-4-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260924233130.1213812-1-alexei.starovoitov@gmail.com>
References: <20260924233130.1213812-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

bpf_do_misc_fixups() inits may_goto count by patching the first insn
of a subprog with [ST, ST, first insn]. bpf_convert_ctx_accesses()
patches insn that needs a barrier with [nospec, insn].
bpf_adj_branches() doesn't adjust insns inside the patch, so when
the copy is a call, ld_imm64 of a func or a jump that points backward
its target is off by the number of insns in front of it:

  static int A(void)  { return 1; }
  static int A2(void) { return 2; }
  static int B(void)
  {
          int i, ret = A();

          for (i = 0; i < 10 && can_loop; i++)
                  ...
          return ret;
  }

When A is placed in front of B and may_goto is timed 'call A' becomes
call of A + 2. B returns 2 when A + 2 is the start of A2. Otherwise
the prog is rejected with "verifier bug: No program to jit at insn".

Add bpf_adj_moved_insn() and use it for both copies.

Fixes: 011832b97b31 ("bpf: Introduce may_goto instruction")
Fixes: d6f1c85f2253 ("bpf: Fall back to nospec for Spectre v1")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/fixups.c | 55 +++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 53 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
index a5d335a47d26..ae9713d292df 100644
--- a/kernel/bpf/fixups.c
+++ b/kernel/bpf/fixups.c
@@ -383,6 +383,44 @@ struct bpf_prog *bpf_patch_insn_data(struct bpf_verifier_env *env, u32 off,
 	return new_prog;
 }
 
+/*
+ * insn was moved down by delta insns inside its own patch. Operands relative
+ * to the pc that point in front of the old position did not move with it.
+ */
+static int bpf_adj_moved_insn(struct bpf_insn *insn, u32 delta)
+{
+	u8 class = BPF_CLASS(insn->code), op = BPF_OP(insn->code);
+	s64 off = insn->imm, off_min = S32_MIN;
+	bool is_imm = true;
+
+	if (bpf_pseudo_func(insn) || bpf_pseudo_call(insn)) {
+		/* subprog that started at the old position starts with the patch */
+		if (off >= 0)
+			return 0;
+	} else if ((class == BPF_JMP || class == BPF_JMP32) &&
+		   op != BPF_CALL && op != BPF_EXIT) {
+		if (insn->code != (BPF_JMP32 | BPF_JA)) {
+			off = insn->off;
+			off_min = S16_MIN;
+			is_imm = false;
+		}
+		/* jump to itself stays */
+		if (off >= -1)
+			return 0;
+	} else {
+		return 0;
+	}
+
+	off -= delta;
+	if (off < off_min)
+		return -ERANGE;
+	if (is_imm)
+		insn->imm = off;
+	else
+		insn->off = off;
+	return 0;
+}
+
 /*
  * For all jmp insns in a given 'prog' that point to 'tgt_idx' insn adjust the
  * jump offset by 'delta'.
@@ -905,7 +943,13 @@ int bpf_convert_ctx_accesses(struct bpf_verifier_env *env)
 			struct bpf_insn *patch = insn_buf;
 
 			*patch++ = BPF_ST_NOSPEC();
-			*patch++ = *insn;
+			*patch = *insn;
+			ret = bpf_adj_moved_insn(patch++, 1);
+			if (ret) {
+				verbose(env, "insn %d cannot be patched due to 16-bit range\n",
+					env->insn_aux_data[i + delta].orig_idx);
+				return ret;
+			}
 			cnt = patch - insn_buf;
 			new_prog = bpf_patch_insn_data(env, i + delta, insn_buf, cnt);
 			if (!new_prog)
@@ -2597,7 +2641,14 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env)
 						     BPF_MAX_LOOPS);
 		}
 		/* Copy first actual insn to preserve it */
-		insn_buf[cnt++] = env->prog->insnsi[subprog_start];
+		insn_buf[cnt] = env->prog->insnsi[subprog_start];
+		ret = bpf_adj_moved_insn(&insn_buf[cnt], cnt);
+		if (ret) {
+			verbose(env, "insn %d cannot be patched due to 16-bit range\n",
+				env->insn_aux_data[subprog_start].orig_idx);
+			return ret;
+		}
+		cnt++;
 
 		new_prog = bpf_patch_insn_data(env, subprog_start, insn_buf, cnt);
 		if (!new_prog)
-- 
2.55.0

