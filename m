Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C923D37CD4D
	for <bpf@vger.kernel.org>; Sun, 12 Apr 2026 20:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776024825; cv=pass; b=cXyeUMUd/pspZDjNxzZjntN3LW5+l2J91k9UgcgpPrbDZgzEwcClqWOIMklbNihiVI7F55VX8Hq4oEA3liuY30I/JLB08Y1heQDwZ/mioU+giJxoQ+650/ddDzyTEatAt3TnVk65cKbObGlnbvZ3ZWrfauNIMt1ersvDH6fdPN8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776024825; c=relaxed/simple;
	bh=cEXTAXiBYHG6AEJFApdupMsOafzfx06RYOz1wYWWnQM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MCnGV1Zdvfkb4dHB5dRsQBO8Lkub/wWiaLllB1JfIKhAqBnlVG3kZPpCk2atxnZ+c+h1snpgrk/y8m6UsQ3PZl6o/aHISrS8VS7A3Td5SKMpWkBLIahtmaDKA2YyEU2x8qAQLqYexs4FDshaJ4oHXAp389Mtx2ISwwRQBFAQfN8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I5AkixvZ; arc=pass smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I5AkixvZ"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-43d03db7f87so2355172f8f.3
        for <bpf@vger.kernel.org>; Sun, 12 Apr 2026 13:13:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776024822; cv=none;
        d=google.com; s=arc-20240605;
        b=Q4XlGucGpeURNtJZ7Y9n8C37BlCrwLscmwduaX8a6HpI0O0IWLVsuO9hqvYsOIjjch
         wt+eLb+9HMAVJwYbQ8H283yqz+Uq3Gnuw6kKPIErUxtiPGpRrYP6cS+TWbKc+pOLhmfq
         fRSaBKbzssy5uYXv1MaqHliwk97yE+gD5uBOegw0yiVbURfvlSDnjefDcAf0+53L6Zq3
         xJdkD+dtx83eqzv17xXZ6bF3FfxrgOJ634zAQHtmzTjgHuWlTNFhXWdj6Kv6ArSNMLoE
         z06KDIqbZK5LfL2Yyj5zgzWESoN12XoLvbKlkvaROCxPOfU13EiNGeBSaxTH+ALabqDV
         3jsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2vUOsQiIgOa0rQSNFTS+uaLu8g7JFOOBKJpOaFFlncQ=;
        fh=ajbTnBrE2MIZMN2nfBm86SEQsUp/V+zj+LEvaX+J6bQ=;
        b=c46P/kKkWk+XBlsBOrmqfZ89ebqYDYADyOJLeiyPV1Kq+Kh82ZpT7n23eBjGdyUlIV
         3VAigv60A5aoS3SURhH5H7fSC5FQvV3qAUtzjnFfhOX7++re84hZQO6lRUgaMl2iFyW8
         jj1k+7qOD+wmuoSagTvUB+DZsnWsNVSaDBACJvUGnq5rvx00Qd9Z1q9mkl6Vfp2CNJTo
         5N+cXdcyQKG+DFqwr3hweq5gCFXO5OpucOenusjiLMRFUjzpKOyt0OBTQ50L0egiZBic
         0sHyOX8F8qkky82AdYz50z02g8m3e0hSJNISMCRvE3kFJrKPKgau4ueMaVVNGaVtEguo
         n7aQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776024822; x=1776629622; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2vUOsQiIgOa0rQSNFTS+uaLu8g7JFOOBKJpOaFFlncQ=;
        b=I5AkixvZBVaXNysvoh5ggAXJ7cMTPCRNW9kAvUcdD3gjtI9Q5LjFnJB6T2bdDBj72v
         WxtuIPPKQjJRzqOe9lrF9Yp4aCqKE4bOYUetFhYhlCN2m+C5XUZR3ggNG6MueyJvbKvK
         nTF9bdsl/YQKLyo1g+FkjNiEnAzOwOJYXJwMVDiNqhP64n7otPlTHhLW6xKyZ+d07INC
         JwMk3N7+ci9eczUlY4s+27n475L/7anSauqczl6F/J3ehN6OqyEQ2g7OwbYizim+9zb7
         IVxps9jT9IHBytnl8h46j9jm8XyO3mQZ5Z679A70X7EfMrvy/LkWY8c8RA/SNBjXnqkP
         RRbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776024822; x=1776629622;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2vUOsQiIgOa0rQSNFTS+uaLu8g7JFOOBKJpOaFFlncQ=;
        b=ENgMzaQjzYbaFy6fm5zYah4KDxNb5U8LUuxmRpvOPKemdubp8+cN/rlEy5c7RKXTrX
         C20hpeIMDw9Man1mZPoWG2DII1efzoF61mj+hy0cMFHRA66f7YjtPEkyq7gHBQpXRrbp
         0VidWa4xQ1R7MO1wDtUlkbYdkH8EcXe8WlEaN3NVxOI8Pk8J1Vv0ChhL3i5AqfCUpA2P
         cqGyYQeYI6M/TqWtmFfeYopFAZp+nkz11VBhJQXAYDdM+kS61UKthiQ+lWdY4QiVLZ8I
         j2CJW3LrR+6/lYahloRyO5mHN/7BuzYmGXBrlYMqJwhdX8bHv0sJWTqKVuH/sI/kYGcH
         x9vQ==
X-Gm-Message-State: AOJu0YwobG33zghLDvAlE6gF+Jq0eLT0ZT1FCdKw+RGE+ei7Qs/7Pyp3
	/53DwQNWwtpeCqft1ZDOOO5w/Y/cVUVGbZ5hl7H2lcKq+dpIHdCrFCa099iLnvlHAv8K/fPy1Or
	ZgGRSotMXETWkUdDiLVjeeuyq17I+Qqo=
X-Gm-Gg: AeBDietkWTwqojxv1zvXmJsiyHiZo4sq38C+7ck4ocMcVIt1Ybq0kcNauJkEgzim0H7
	t6AMMRkbSUjOL6fuNPXw2YLhcGzjP/o4PIGomwQyXrwX45CRh/wke37klo+Ggs8Oni73zR/sPi9
	9s8gi/M0xn9gOdVrOnvXLFs5P/gGNiV6bHMpSDcscXu8C1BpWXIXIM/je7uUpRX9PCe4n6+ysX0
	0Rj2d6U9PCZPTKVdEWuZvgadPEPjV86U57rkL0TRuTx4L8hMGCO0mKbCcHtGKzVD2Yu80yb5kDJ
	Ve5yDEM3PYN/KSUaQ/B132eYEy4iJGZB+VvSoCiSGF0OAqGXMWZc7AZ23cAbIxBiXpN54X/9cDQ
	5a17h2Qt+ieSmOkY7xuCDs0VlcA==
X-Received: by 2002:a05:6000:2407:b0:43d:70de:1c5e with SMTP id
 ffacd0b85a97d-43d70de1f62mr5121009f8f.46.1776024821977; Sun, 12 Apr 2026
 13:13:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260412170334.716778-1-tangyazhou@zju.edu.cn> <20260412170334.716778-2-tangyazhou@zju.edu.cn>
In-Reply-To: <20260412170334.716778-2-tangyazhou@zju.edu.cn>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sun, 12 Apr 2026 13:13:30 -0700
X-Gm-Features: AQROBzAIAdEfuZyHP8OIQZbQwnwczIh54dfbLxf23yGKU8TB_vhp4r5EqArac2A
Message-ID: <CAADnVQ+m2pFaPbRi=A+tsROKP2CPPkny_LXUKR3vUgH2+u1jRg@mail.gmail.com>
Subject: Re: [PATCH bpf v6 1/2] bpf: Fix s16 truncation for large bpf-to-bpf
 call offsets
To: Yazhou Tang <tangyazhou@zju.edu.cn>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, Eduard <eddyz87@gmail.com>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Puranjay Mohan <puranjay@kernel.org>, 
	Xu Kuohai <xukuohai@huaweicloud.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Yazhou Tang <tangyazhou518@outlook.com>, Shenghao Yuan <shenghaoyuan0928@163.com>, 
	Tianci Cao <ziye@zju.edu.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 12, 2026 at 10:04=E2=80=AFAM Yazhou Tang <tangyazhou@zju.edu.cn=
> wrote:
>
> From: Yazhou Tang <tangyazhou518@outlook.com>
>
> Currently, the BPF instruction set allows bpf-to-bpf calls (or internal c=
alls,
> pseudo calls) to use a 32-bit imm field to represent the relative jump of=
fset.
>
> However, when JIT is disabled or falls back to the interpreter, the verif=
ier
> invokes bpf_patch_call_args() to rewrite the call instruction. In this
> function, the 32-bit imm is downcast to s16 and stored in the off field.
>
>     void bpf_patch_call_args(struct bpf_insn *insn, u32 stack_depth)
>     {
>         stack_depth =3D max_t(u32, stack_depth, 1);
>         insn->off =3D (s16) insn->imm;
>         insn->imm =3D interpreters_args[(round_up(stack_depth, 32) / 32) =
- 1] -
>             __bpf_call_base_args;
>         insn->code =3D BPF_JMP | BPF_CALL_ARGS;
>     }
>
> If the original imm exceeds the s16 range (i.e., jump offset > 32KB),
> this downcast silently truncates the offset, resulting in an incorrect
> call target.
>
> Fix this by:
> 1. In bpf_patch_call_args(), keeping the imm field unchanged and using th=
e off
>    field to store the index of the interpreter function.
> 2. In ___bpf_prog_run() for the JMP_CALL_ARGS case, retrieving the interp=
reter
>    function pointer from the interpreters_args array using the off field =
as
>    the index, and passing the original imm to calculate the last argument=
 of
>    the interpreter function.
>
> After these changes, the truncation issue is resolved, and __bpf_call_bas=
e_args
> is also no longer needed and can be removed, which makes the code cleaner=
.
>
> Performance: In ___bpf_prog_run() for the JMP_CALL_ARGS case, changing th=
e
> retrieval of the interpreter function pointer from pointer addition to di=
rect
> array indexing improves performance. The possible reason is that the latt=
er
> has better instruction-level parallelism. See the v5 discussion [1] for m=
ore
> details.
>
> [1] https://lore.kernel.org/bpf/f120c3c4-6999-414a-b514-518bb64b4758@zju.=
edu.cn/
>
> The related dumper code is also updated to adapt to the verifier changes.
> Specifically, the usages of insn->imm and insn->off are swapped:
> 1. When JIT is enabled, use insn->imm as the call offset, and insn->off
>    as the subprog id.
> 2. When JIT is disabled, print insn->imm as the call offset.
>
> Consequently, the workaround introduced in tools/testing/selftests/bpf/di=
sasm_helpers.c
> by commit 203e6aba7692 ("selftests/bpf: print correct offset for pseudo c=
alls in disasm_insn()")
> is no longer needed. Since the verifier now correctly exposes the offset
> in the imm field, we can safely remove the custom print_call_cb() and
> allow the selftests to rely on the native BPF disassembler.
>
> Fixes: 1ea47e01ad6e ("bpf: add support for bpf_call to interpreter")
> Fixes: 7105e828c087 ("bpf: allow for correlation of maps and helpers in d=
ump")
> Suggested-by: Xu Kuohai <xukuohai@huaweicloud.com>
> Suggested-by: Puranjay Mohan <puranjay@kernel.org>
> Co-developed-by: Tianci Cao <ziye@zju.edu.cn>
> Signed-off-by: Tianci Cao <ziye@zju.edu.cn>
> Co-developed-by: Shenghao Yuan <shenghaoyuan0928@163.com>
> Signed-off-by: Shenghao Yuan <shenghaoyuan0928@163.com>
> Signed-off-by: Yazhou Tang <tangyazhou518@outlook.com>
> ---
> To Emil and Puranjay: The v6 of the patch is quite different from v1-v5,
> so I removed your "Reviewed-by" tags. Please take another look at v6. Tha=
nks!
>  include/linux/filter.h                       |  3 ---
>  kernel/bpf/core.c                            | 10 +++++-----
>  kernel/bpf/verifier.c                        |  6 +++---
>  tools/bpf/bpftool/xlated_dumper.c            | 10 +++++-----
>  tools/testing/selftests/bpf/disasm_helpers.c | 18 ------------------
>  5 files changed, 13 insertions(+), 34 deletions(-)
>
> diff --git a/include/linux/filter.h b/include/linux/filter.h
> index 44d7ae95ddbc..559ddbc4fdfc 100644
> --- a/include/linux/filter.h
> +++ b/include/linux/filter.h
> @@ -1149,9 +1149,6 @@ bool sk_filter_charge(struct sock *sk, struct sk_fi=
lter *fp);
>  void sk_filter_uncharge(struct sock *sk, struct sk_filter *fp);
>
>  u64 __bpf_call_base(u64 r1, u64 r2, u64 r3, u64 r4, u64 r5);
> -#define __bpf_call_base_args \
> -       ((u64 (*)(u64, u64, u64, u64, u64, const struct bpf_insn *)) \
> -        (void *)__bpf_call_base)
>
>  struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog);
>  void bpf_jit_compile(struct bpf_prog *prog);
> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index 9de5e69607c6..a35413c668c9 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -1763,6 +1763,8 @@ static u32 abs_s32(s32 x)
>         return x >=3D 0 ? (u32)x : -(u32)x;
>  }
>
> +static u64 (*interpreters_args[])(u64 r1, u64 r2, u64 r3, u64 r4, u64 r5=
,
> +                                 const struct bpf_insn *insn);
>  /**
>   *     ___bpf_prog_run - run eBPF program on a given context
>   *     @regs: is the array of MAX_BPF_EXT_REG eBPF pseudo-registers
> @@ -2069,10 +2071,10 @@ static u64 ___bpf_prog_run(u64 *regs, const struc=
t bpf_insn *insn)
>                 CONT;
>
>         JMP_CALL_ARGS:
> -               BPF_R0 =3D (__bpf_call_base_args + insn->imm)(BPF_R1, BPF=
_R2,
> +               BPF_R0 =3D (interpreters_args[insn->off])(BPF_R1, BPF_R2,
>                                                             BPF_R3, BPF_R=
4,
>                                                             BPF_R5,
> -                                                           insn + insn->=
off + 1);
> +                                                           insn + insn->=
imm + 1);
>                 CONT;
>
>         JMP_TAIL_CALL: {
> @@ -2405,9 +2407,7 @@ EVAL4(PROG_NAME_LIST, 416, 448, 480, 512)
>  void bpf_patch_call_args(struct bpf_insn *insn, u32 stack_depth)
>  {
>         stack_depth =3D max_t(u32, stack_depth, 1);
> -       insn->off =3D (s16) insn->imm;
> -       insn->imm =3D interpreters_args[(round_up(stack_depth, 32) / 32) =
- 1] -
> -               __bpf_call_base_args;
> +       insn->off =3D (round_up(stack_depth, 32) / 32) - 1;
>         insn->code =3D BPF_JMP | BPF_CALL_ARGS;
>  }
>  #endif
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index e3814152b52f..1015b08d130e 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -23054,9 +23054,9 @@ static int jit_subprogs(struct bpf_verifier_env *=
env)
>                 }
>                 if (!bpf_pseudo_call(insn))
>                         continue;
> -               insn->off =3D env->insn_aux_data[i].call_imm;
> -               subprog =3D find_subprog(env, i + insn->off + 1);
> -               insn->imm =3D subprog;
> +               insn->imm =3D env->insn_aux_data[i].call_imm;
> +               subprog =3D find_subprog(env, i + insn->imm + 1);
> +               insn->off =3D subprog;
>         }

The patch doesn't apply anymore. This function was moved.

Also see sashiko review. It flagged a real issue.

pw-bot: cr
