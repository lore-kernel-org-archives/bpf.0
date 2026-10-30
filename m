Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793361209;
	b=HVOcoaXb84EcUYaA67NslVBIAZ0/W4G/EHeCBGIzJUTw0C3LICmwCeDoVxnqNAf1PpQq
	 rzchzpjyd6fEqhRxEdmfZAV/TpVOgMouLREOCCFD4KQS3XPNFweu7tTv9Owb7lrYq/98P
	 +WiAYKRFkmf9VjSqRO1mif585njTtgXhHaSegbOaZ4S6sQiDQsT27sU9la6tu7ltwyO9J
	 V+ugsXFA4IUFNsO0YKlGSMnSWvfa6aWfuOVN9MNfbI9wcJc9qYlpU9BjKtTspgwliMNZP
	 ccLjBG2E+BG0mE++mQBF/v0ok12DKdAxTtNKoExUK0xiHtqMNE1O8EAOkrqigYE/gPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793361209;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer;
	bh=ImbpprCFEyoijQ75uuo0GW8l3GlSH6RYOKA6RChEUIE=;
	b=P33KxJfEGwk4syIZc0vp43FU5e13+uQKeSJ2frYKfo6dZGqF1ueVtx14E4wXbNXDtIwP
	 QRrclw/qmh8IluAo7Ne3F7WvlnjXVxr6eMOK1M2WmucyRDYkt1Wzxgbl1Wq0dvxwA5jP4
	 sCWE8CCQzkDbf9E6rKG3e4LQmI8A/1k5cTAGjuY6kwNRJw/OghndlGoIhOvsPyyH0DyBy
	 u55fjQc4+dBFf+InpKDciFNqpD1mPN0P3G8SFFKE3C2MwUiqGZOwegU6etiJZaww1Y5xN
	 MXLnNLUjOrzQvNYOICdRc5/AJrYBG9vDU+sbbQpxON5aUc0p6F7NYoXgvK59t4iVm1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wmUR3kly;
	arc=none smtp.remote-ip=74.125.82.53
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC85660A6F41
	for <bpf@vger.kernel.org>; Fri, 30 Oct 2026 11:53:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CC85660A6F41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wmUR3kly
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-18cdcfc05ffso751670c88.1
        for <bpf@vger.kernel.org>; Fri, 30 Oct 2026 04:53:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793361208; x=1793966008; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ImbpprCFEyoijQ75uuo0GW8l3GlSH6RYOKA6RChEUIE=;
        b=wmUR3klyhzb1XPg0nMuo6sRWmgGlZ4fRGAxobA/Wrndvct1C2T3susNVI5Lk9c2gtW
         5S/urGHJfV81mvCkQQY0RsoAo/yzF4I5xRFS3ZYeUfcKXmh/gwcru6mzFsPIuBvrDe0r
         3Pcs8QZEYu7TYSJWL/lW84Hr6ncGOnAuLFIAbasF/AxYgcTKOJkD9JKtr+w2UnBQLSmr
         iwMDfqQz8xEDi1jMTp1PRJv7pVY+Botw+Us7igxl+3MDl4ZnFwF1Vl2QvIFx0JotRfPy
         CdXF6C+embJlB3+ZH4kG9jAUflS2T+1+jmnDUC1CHNvfNVBslkN5XrmVcfUzxA8v7Yj7
         qwDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793361208; x=1793966008;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ImbpprCFEyoijQ75uuo0GW8l3GlSH6RYOKA6RChEUIE=;
        b=AWmi9lLqywHG7oEN8r2n6CuSpr9TU3sWrIvB/YdVAxf5agqaUGofi0Fd2xZfrAjWRw
         wshxjqkLA5J4TZPdaB54p9rDZPArWPHrOcprDqdAMvlI/EyovOHV2utUB4WO8eFOyUyG
         M8raNNcinXme2WwY4GJqQAe9cI+T9jweIZ482eTrYjrm9tTPvBlDzzoXKuQ/qLHEjx8D
         /jGwwzS5nH24sUk7tv0jKCBRqmKQYDC1ovR65XpoEVVuO31aTRK06MVQtZrnhHM0Wv84
         eqj5B6R/eLXMDjChBtuJbttmunq28WCAX/ydU4vkSC4+nLhORigFJfvv/QI22G5+Imli
         1R6w==
X-Gm-Message-State: AFq9FYKLsNDr49O/o3itMdLiVvvlV1NW9O8mW8mHm8GqlYja36J1OjgF
	iYy5cHDQUOI+BY1O4lo4cG5CFtJ9OO8ssnoJFSWJRQ8zEnecW+KgS4hH
X-Gm-Gg: AYBFou3Gm03Ydx/LGyqb1rEIFxr5W9eM0htu/+h4Wq7KFcNXXHEOvTuVPcZ6f00ImcY
	Jz3kNJZi2Zzh8iis1TkZoK6V360lzYqJsKT4Uam+ajmpz82Wxno+grD5eDR4Opz+wwFtgf5KkzP
	87OQ/TX+0GPwdTIYbkopQswmBhyaRf0AcbQaZh0d+Gui6oQ7yyHZybCzYDYnoyb/hrHDZMqp2Bk
	gexps4fZEmdC8TdRuiWGbtvvh6oo1nkrFS/mY+vPnvn5ixhtKGMJfioxJD2+nO1iX02nTmqLPoJ
	cutxu+7+DNQSlUQ1W2CITglUyWHWw+K0icEIBeV2k448Ov6rKi1jtSWV+hehKiLDlcGnyQjOebh
	BX1rC7KOwP/EJXaFKs4Al6rMraB6BOqNmwwpnVuMPa90NgTg6RtJtX+8P0fpo/wsMSTpQRVxgoo
	o/QD3SEckAG5aVHyLBZb/mh00OzPwdCd6vLEHloH1++zXG+Gv3zgItZd/Hi8TYSHTEwe/cNLWVl
	B7O6XP+OJ8oMtoRiSrokCDCRv6A7KCqwhGXfDPAIIzbW2MICQU59sjK1JK64JaKuqkVVzvKVv/B
	v9kdPQhZEeVVoh7HCet0I2qX
X-Received: by 2002:a05:701b:2091:20b0:148:bc4a:8356 with SMTP id a92af1059eb24-1ac5d5aae1fmr2851794c88.28.1793361207760;
        Fri, 30 Oct 2026 04:53:27 -0700 (PDT)
Received: from [127.0.1.1] ([23.254.208.9])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac1abcd6f1sm6437304c88.20.2026.10.30.04.53.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 04:53:27 -0700 (PDT)
From: Qiliang Yuan <odys.yuan@gmail.com>
Date: Fri, 30 Oct 2026 07:52:00 -0400
Subject: [PATCH bpf-next v2 15/22] bpf: Insert the may_goto counter setup
 through the patch list
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261030-bpf-verifier-patch-batch-v2-15-55cd43439f7c@gmail.com>
References: <20261030-bpf-verifier-patch-batch-v2-0-55cd43439f7c@gmail.com>
In-Reply-To: <20261030-bpf-verifier-patch-batch-v2-0-55cd43439f7c@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>, Shuah Khan <shuah@kernel.org>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Qiliang Yuan <odys.yuan@gmail.com>
X-Mailer: b4 0.13.0

bpf_do_misc_fixups() sets up the counter of may_goto in front of each
subprog that needs one.

It patches the program for each of these subprogs, and then walks all
jumps again with adjust_jmp_off() to move the ones to the first
instruction of the subprog past the setup.

Insert the setup with bpf_patch_list_insert(), which leaves the jumps
to the instruction it inserts in front of on that instruction, and
commit once. adjust_jmp_off() has no users left, remove it.

Signed-off-by: Qiliang Yuan <odys.yuan@gmail.com>
---
 kernel/bpf/fixups.c | 73 ++++++++---------------------------------------------
 1 file changed, 10 insertions(+), 63 deletions(-)

diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
index 08c89f2baffb6..f55ac904b4e78 100644
--- a/kernel/bpf/fixups.c
+++ b/kernel/bpf/fixups.c
@@ -723,44 +723,6 @@ static int bpf_adj_moved_insn(struct bpf_insn *insn, u32 delta)
 	return 0;
 }
 
-/*
- * For all jmp insns in a given 'prog' that point to 'tgt_idx' insn adjust the
- * jump offset by 'delta'.
- */
-static int adjust_jmp_off(struct bpf_prog *prog, u32 tgt_idx, u32 delta)
-{
-	struct bpf_insn *insn = prog->insnsi;
-	u32 insn_cnt = prog->len, i;
-	s32 imm;
-	s16 off;
-
-	for (i = 0; i < insn_cnt; i++, insn++) {
-		u8 code = insn->code;
-
-		if (tgt_idx <= i && i < tgt_idx + delta)
-			continue;
-
-		if ((BPF_CLASS(code) != BPF_JMP && BPF_CLASS(code) != BPF_JMP32) ||
-		    BPF_OP(code) == BPF_CALL || BPF_OP(code) == BPF_EXIT)
-			continue;
-
-		if (insn->code == (BPF_JMP32 | BPF_JA)) {
-			if (i + 1 + insn->imm != tgt_idx)
-				continue;
-			if (check_add_overflow(insn->imm, delta, &imm))
-				return -ERANGE;
-			insn->imm = imm;
-		} else {
-			if (i + 1 + insn->off != tgt_idx)
-				continue;
-			if (check_add_overflow(insn->off, delta, &off))
-				return -ERANGE;
-			insn->off = off;
-		}
-	}
-	return 0;
-}
-
 /* Clean up dynamically allocated fields of aux data for instructions [start, ...] */
 void bpf_clear_insn_aux_data(struct bpf_verifier_env *env, int start, int len)
 {
@@ -1988,7 +1950,6 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env)
 	const struct bpf_map_ops *ops;
 	struct bpf_insn_aux_data *aux;
 	struct bpf_insn *insn_buf = env->insn_buf;
-	struct bpf_prog *new_prog;
 	struct bpf_map *map_ptr;
 	int i, ret, cnt, cur_subprog = 0;
 	struct bpf_subprog_info *subprogs = env->subprog_info;
@@ -2828,10 +2789,8 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env)
 
 	env->prog->aux->stack_depth = subprogs[0].stack_depth;
 	for (i = 0; i < env->subprog_cnt; i++) {
-		int delta = bpf_jit_supports_timed_may_goto() ? 2 : 1;
-		int subprog_start = subprogs[i].start;
+		int slots = bpf_jit_supports_timed_may_goto() ? 2 : 1;
 		int stack_slots = subprogs[i].stack_extra / 8;
-		int slots = delta, cnt = 0;
 
 		if (!stack_slots)
 			continue;
@@ -2841,6 +2800,7 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env)
 			return -EFAULT;
 		}
 
+		cnt = 0;
 		stack_depth = subprogs[i].stack_depth;
 		if (bpf_jit_supports_timed_may_goto()) {
 			insn_buf[cnt++] = BPF_ST_MEM(BPF_DW, BPF_REG_FP, -stack_depth,
@@ -2851,30 +2811,17 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *env)
 			insn_buf[cnt++] = BPF_ST_MEM(BPF_DW, BPF_REG_FP, -stack_depth,
 						     BPF_MAX_LOOPS);
 		}
-		/* Copy first actual insn to preserve it */
-		insn_buf[cnt] = env->prog->insnsi[subprog_start];
-		ret = bpf_adj_moved_insn(&insn_buf[cnt], cnt);
-		if (ret) {
-			verbose(env, "insn %d cannot be patched due to 16-bit range\n",
-				env->insn_aux_data[subprog_start].orig_idx);
+		/* jumps to the first insn of the subprog skip the setup */
+		ret = bpf_patch_list_insert(env, subprogs[i].start, insn_buf, cnt);
+		if (ret)
 			return ret;
-		}
-		cnt++;
-
-		new_prog = __bpf_patch_insn_data(env, subprog_start, insn_buf, cnt,
-						 BPF_PATCH_MOVE_TARGET);
-		if (!new_prog)
-			return -ENOMEM;
-		env->prog = prog = new_prog;
-		/*
-		 * If may_goto is a first insn of a prog there could be a jmp
-		 * insn that points to it, hence adjust all such jmps to point
-		 * to insn after BPF_ST that inits may_goto count.
-		 * Adjustment will succeed because bpf_patch_insn_data() didn't fail.
-		 */
-		WARN_ON(adjust_jmp_off(env->prog, subprog_start, delta));
 	}
 
+	ret = bpf_patch_list_commit(env);
+	if (ret)
+		return ret;
+	prog = env->prog;
+
 	/* Since poke tab is now finalized, publish aux to tracker. */
 	for (i = 0; i < prog->aux->size_poke_tab; i++) {
 		map_ptr = prog->aux->poke_tab[i].tail_call.map;

-- 
2.43.0

