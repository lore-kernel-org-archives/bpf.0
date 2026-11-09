Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794210333;
	b=QHo/djOL4NjMxr4Aor26DTegZBnK3TlmnNMafazETnFAF7D7oUnaOqFfWn7dLyt3cX1O
	 wZWnigRnFPo/vLYsZcK/XROWAoWWl2eQdbw9GelIca5Z132Jx+2J8hlUVlWP1xsb0LZZ0
	 LlGBKko2wekxnGcOJqdWrOpc1za5FNwTEWtULeuAD04L/2RAIOLJqNoBSvvMZxCYzC3H0
	 h+OVx5PiuDAswbWPBkHseybhVr6lQNKabla65oE+0F/iFznfMD87+z6ltkSiWcdTb8Zmw
	 Oq0MvRfLrdf0M6fcv+2hQgjdqjVOnXnGZQ1TZLLYBGlO55y8OmfehCo49VlHeOCl1xg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794210333;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=u4Z2LXzuCyuzyR/xK6Pc8Xy3RlKyEJiqw9JzQLPjKJg=;
	b=p8cmRoh1NPW8Ldrj8Fp3aEf4A5KD9TEaA5ep2keK1CQdMbnV2P4Ndo10Dio25C6xy/i4
	 tkk499DxOp2w1P/Cb3WMR27Eq76wXPlloeZD13/MeYnYEts2Z1B4vQDEVLoVfm0HGqIc8
	 UUZHBYHFUuRIQcJUTJfCuEz1a7VcKzPtKJaGZT9nX8n7HmnUzIElq9TqBzqx2TnhwwZGV
	 CioRvM/fdhfkoxNR/+9SUikSIqDpKWlO04TgLflphNJaIaJPNSfk0i2DLs1TpxXOQzBTg
	 MGq5Jgg3XRL7O2gL9yKd1BcY/e3+5dwuIj2rjCENUEwGaRCbrGSn3fciyA5cWVhGJhA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eeKd7Tpj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EA99606A31C
	for <bpf@vger.kernel.org>; Mon,  9 Nov 2026 07:45:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eeKd7Tpj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 627711F008A1;
	Mon,  9 Nov 2026 07:45:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794210332;
	bh=u4Z2LXzuCyuzyR/xK6Pc8Xy3RlKyEJiqw9JzQLPjKJg=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=eeKd7TpjyeNsCPUQ2umYO2NflIv17oX5dkl0W9bh0bSwlCI2uaqtfmBK5pdVvlvdd
	 IyHNLe0rjmOcmNdJbTrEbQJ/iVio9g/RpdOiRsJYZZ2VZ10/GuTkVOg6CNKv9taU7H
	 spJB+Y/BqEOb+dJKIhncl7KZ8dWkUBO2H21A5MMs4GNJ1PpfdMgnSdQWD3igMbsurh
	 n/OvncGwx06/3hvALgoJ3QPJF8VkoYtj3jvLeEWILNg6/wC/Z02dwZdNGARWJlO6Hw
	 inr5GeULPb6plry/RGZmCwhBTblIPrGNGZYiEBecUOQO58JKK18kZgHQ6K0bdrD0Q/
	 xadWSFUjlkmMg==
Content-Type: multipart/mixed; boundary="===============3972863191089283906=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <ca9e91234e5433236dd09abd76c3a02152b5fc5cf4b02b645786d91080dc752f@mail.kernel.org>
In-Reply-To: <20261109064715.2382452-7-alexei.starovoitov@gmail.com>
References: <20261109064715.2382452-7-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf-next 06/26] bpf: Give SSA names to the values that scalar evolution does not track
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Mon,  9 Nov 2026 07:45:32 +0000 (UTC)

--===============3972863191089283906==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Give SSA names to the values that scalar evolution does not track

TL;DR: Contrary to "no verdict changes", new per-load SSA defs may keep join
expressions distinct, so mk_any() can overflow and lose linear-register info,
possibly causing extra verifier state exploration.

> diff --git a/kernel/bpf/scev.c b/kernel/bpf/scev.c
> --- a/kernel/bpf/scev.c
> +++ b/kernel/bpf/scev.c

[ ... ]

> @@ -1016,14 +1174,23 @@ static int mk_any(struct scev *scev, int a, int b)
>  			if (expr->op == ANY) {
>  				if (!expr_stack_push(scev, expr->params[1]) ||
>  				    !expr_stack_push(scev, expr->params[0]))
> -					return UNKNOWN_EXPR_ID;
> +					return expr_with_def(scev, UNKNOWN_EXPR_ID, def);
>  			} else {
>  				for (j = 0; j < ids_buf_sz; j++) {
>  					if (same_exprs(scev, scev->ids_buf[j], id))
>  						goto next;
> +					/* two defs of one shape: the shape without a def */
> +					other = &scev->exprs[scev->ids_buf[j]];
> +					if (other->op != expr->op || other->imm != expr->imm)
> +						continue;
> +					id = expr_with_def(scev, id, no_def);
> +					if (id < 0)
> +						return id;
> +					scev->ids_buf[j] = id;
> +					goto next;
>  				}
>  				if (ids_buf_sz == ARRAY_SIZE(scev->ids_buf))
> -					return UNKNOWN_EXPR_ID;
> +					return expr_with_def(scev, UNKNOWN_EXPR_ID, def);
>  				scev->ids_buf[ids_buf_sz++] = id;
>  			}

The commit message says "Op and operands stay, so the code that analyzes
loops matches what it matched" and "no verdict changes".  Is that true for a
join whose incoming values are composite expressions that differ only in the
defs of their leaves?

Before this patch every non-FP load was OPAQUE_EXPR_ID.  maybe_load_fp() now
gives each load its own def via forget_reg(..., OPAQUE_EXPR_ID, idx).  So
(+ r6 _) built on two paths used to be one id and join() skipped it because
same_exprs() was true.  Now it is two ids, (+ r6 %r2.a) and (+ r6 %r2.b).

The new "two defs of one shape" check in mk_any() compares only the top-level
op and imm.  For (+ r6 %r2.a) against (+ r6 %r2.b) the params differ, so
both are kept as separate ANY operands.  Only bare leaves (_ or ?) are folded
back.

Consider a counted loop with a 9-way branch in the body:

  H:  if r7 >= 100 goto out
      if r9 == 1 goto C1 ... if r9 == 8 goto C8; goto C9
  Ck: r2 = *(u64 *)(r8 + 8*k)   ; maybe_load_fp -> %r2.idx_k
      r6 += r2                  ; (+ r6 %r2.idx_k)
      goto J
  J:  r7 += 1; goto H

With r6 live at J, joins 2 to 8 build an ANY with up to 8 distinct operands.
At the 9th join ids_buf is full, so mk_any() returns
expr_with_def(scev, UNKNOWN_EXPR_ID, phi_def(J, r6)), which is '?'.  The old
code kept (+ r6 _) at J and at the header.

scev_compute_linear_regs() then calls expr_is_sum() on
header_env->reg2expr[r6].  It used to get (+ r6 _) and return true, setting
r6 in loop->linear_regs.  Now it gets an UNKNOWN op and returns false, so the
bit is not set.  join_place_is_linear() passes that bit to
bpf_reg_widen_range().  With linear == 64 the range was forgotten at once;
with 0 it now climbs through S32_MAX, U32_MAX and S64_MAX, which takes extra
rounds of state exploration.

A smaller form of the same effect: each two-operand phi of such values adds
one ANY level that was not there before.  That uses up the depth budget of
expr_is_sum(), expr_is_fresh() and expr_loses_bits_only() (EXPR_STACK_DEPTH /
depth > 8) sooner.  Five consecutive if/else blocks of the form
'if (c) sum += a[i]; else sum += b[i];' that the compiler does not merge
could be enough to run out of depth where the old expression did not.

Should the duplicate check compare the expressions with their defs stripped
all the way down, or should a phi that overflows fall back to the def-less
expression the old code would have built, so that existing loop analysis
keeps its results?  The same mk_any() code is unchanged at the end of the
series (a2b3b75fc03a).


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/42577197491
--===============3972863191089283906==--
