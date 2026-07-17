Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 307482C11D9
	for <bpf@vger.kernel.org>; Fri, 17 Jul 2026 14:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784297964; cv=pass; b=TINMqo98Mwx1mDY3pgpec6mqoGFlrYI3EdhYVAncSCF0tjrtmZsrlQWrJgrlyU9d5NXXbI43Z9F10VZFBEV6M2jDtvbcWzi4BbWeqwkr5tKEST5oNMWcTRK+FaJ81fKV+dqG1hk/naD7SPvRGj7+aQ+0w71KsSNtHcAQskT5r+Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784297964; c=relaxed/simple;
	bh=QMUzfDxlV5VBa1O+fOuytOboEyY/EFAuNgGfCP5Hjr4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AN0hI1TSgLZwhzaeJ3sx6RkBYDCxrt8VzlmfILa6fGQhvyDCI67tlVhnZiMPU1H5rSxOEjZggibR5stL0SNNh+QMdHz3vS8wf57EMg7JNwDbeCA1wSDxiL7mBj2Ftp+wg8+5/aAKP+cOtEFGG5IIPG+POTEBcrnAOK+tQSpEFoo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BDH38kwJ; arc=pass smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BDH38kwJ"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c15cb6f5c12so1377928966b.0
        for <bpf@vger.kernel.org>; Fri, 17 Jul 2026 07:19:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784297961; cv=none;
        d=google.com; s=arc-20260327;
        b=cBxkUgGJLYepdHkg862y6w5JOmxV6MV20QuGeLweQz3lLslptLQi/1OT1xE2t+19yq
         ng8rWbrKd6zZ9HrMpjKUw+42jzgpPm4dQdHqLaet/OOhMP5/JITLuM1LY7CDuzAN4PcA
         CDKqPutTjq4yiRj9t3TpVZE3KWuq6D6y3tq+0QCndlxr7RvNipxnPXDUG1fC6AHwdJTe
         agCYz36Ep07jr6R22NhaqqqHmhFOroTIY5GEibwzLZi6GgjsSUtu89f2xftUtYWWjtRS
         ls03axKlNXsrLB7d23XICpOq0yZsXzMcCKGoiWWZkLB4bFcBd/IjXXP1ZNADNUyMLKt9
         rR0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ol1zLrOgh4HX8XU6H2RpV750DebuEeeWK3xP5LLAyHE=;
        fh=z7d8yaISeREwZF+P99U78KFTrwnbWYSlMju373c1WsM=;
        b=pAxlDbfdkyJf8WFYvKY9wztlvReVcVbPF1NFGq29DOtzPQXzzuPPFzL+o1Uw4x7QIj
         xajJhQ3ch3pmbSaf5G1GKmYPXp+4c76qddQJxs+ePCb9Omi3pgMeNmYcTzMAridCxhpF
         ex8ueWzu7ZRwIr3HEpfc/Ao4vPM9lRk68CQ8PTIcyGlwh1zGOo6h7lGq4Jg0RHrzS/nb
         7qvH+FonJA32oWPxFA5TaO4FW7hTpTRkrMwWj6XJebP18aq+1Mui/72jG5rnLF9xxGab
         BXhk3tMc/SRw4rT9EiZKycLZN9172w3w8P5vV3sD/8+aM/xyvpa98bhGxma0lMubp8LJ
         1HQQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784297961; x=1784902761; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ol1zLrOgh4HX8XU6H2RpV750DebuEeeWK3xP5LLAyHE=;
        b=BDH38kwJoH5jrtDvQGCEJASqYmkUp9xAavrj+WAgb0nL1n7DWEKofWHi680k/olpXg
         61LspBAWkowk8jTDlK2MrsqL/os7CRuOuifxOinS4bfrfipRSm+K4C2zF+peERLgN6fa
         ICWjwG6rhxyZJ9xVWlYVo8KKZwcfqYEkYn8r8bzVXarPiePiOuhGCemKTUSoViVCqXbF
         wjdp5jGFtYjg+uSHvJjupE/lQObWtERky6DGS8kjdKfAOAfFGL4oBUn1T+8aBYpMU9s0
         SgZyZQQeyOBFF+FLbDgfORYX3LppiFRJoOA18CR4NAlQkdRYnyIVsCbP3nOYbGOC+bvV
         YzqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784297961; x=1784902761;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ol1zLrOgh4HX8XU6H2RpV750DebuEeeWK3xP5LLAyHE=;
        b=q9xycs7L9mxaFHfw7ZnHNpg2VRouCo0EY8afgZRR3O/2715VYtLpHTwj+8sAcpaWO2
         wE5gzUO/4zNS6M9KuedWmCb2iVxrWri4SohyfI3d8/0o22KDo8yt/NdW8QTUkz75RKzZ
         ViedY5+MW0/6tQyy5uP4CeErha/VikM+8p0hnKMpiy865v/SCD5oslPDsCY1Y2sRLu+w
         IzF5bqiLZi5W7I4w4Ep8p5CSHe5kkNsymEi69QtnDhn+g6svOcckpD9TnPuaK7PkN8yU
         rOxGGR1Oq2QP1R0sDGHC2TGXTmCWv9OBSRB+lx2MKeHoP+vbULbKrL3Sr/0UdLCfWjFD
         1n+w==
X-Gm-Message-State: AOJu0YzZaivYsx7WWoqOKCVy1PHwJL/H7S0wX9SVhCV9rCB7c96B5gTh
	kK+uDoX6Bi7U+JuxmXIWeXfb02STozH4QQjXHV8NgXH8Cvu2PJu5GjVX24cBbB9yvvUbR8UFb2d
	aTdQ0iZVJwREaNrVyLw9dHWzshcg2DOCbhfpv
X-Gm-Gg: AfdE7clDxySdRNJ8xVYUk6AAYFjXTsC9W+dIf5F3wYMegecZIHsZaMkbNQg+CjlDuK9
	4EJ786aksOUxb6cTz3aJKswafs1vJfxNI7Lm5Ry1xrKuxNBf/PofvJrUUemymMuQ/I6wgrNxkRw
	E69f4RjOjY3eIJPiiFXz15dA69nVXDJ1gbqFLhcn/q8jqthQhM2Dv6KWcwhbljXufqWnjdHuChb
	KBI9nBS5kGl/G8irhzUTHamXAfXqWSjMjea3V1pocCoFj8F/BPdIOlaahS1QURrK0/tN4ssieBz
	KapIHGSDP655
X-Received: by 2002:a17:907:1ca6:b0:c15:bed9:f492 with SMTP id
 a640c23a62f3a-c16b46b6f3cmr121719966b.10.1784297961220; Fri, 17 Jul 2026
 07:19:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260717141737.4090962-1-puranjay@kernel.org>
In-Reply-To: <20260717141737.4090962-1-puranjay@kernel.org>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Fri, 17 Jul 2026 15:19:08 +0100
X-Gm-Features: AUfX_myG9P_Ty1ruiD_fzoekpZcuD5j_8gmqlED344CBRzO_QqSBFkvScXXV-A8
Message-ID: <CANk7y0h88FwnXfzSbk3z_HQ7dd427P+fiMGT0KTVv_GSGs-3Yg@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpf, arm64: Fix stack-passed arguments for
 indirect trampolines
To: bpf@vger.kernel.org, Xu Kuohai <xukuohai@huawei.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

+cc Xu

On Fri, Jul 17, 2026 at 3:17=E2=80=AFPM Puranjay Mohan <puranjay@kernel.org=
> wrote:
>
> save_args() reads stack-passed arguments relative to FP assuming the
> trampoline is entered through the fentry call from a traced function, in
> which case both the parent frame (FP/x9) and the traced function frame
> (FP/LR) are saved before FP is set, so the arguments start at FP + 32.
>
> An indirect trampoline for a struct_ops callback is entered through a
> function pointer (blr), so only the FP/LR frame is pushed and the
> arguments start at FP + 16, not FP + 32. Every stack-passed argument of
> a struct_ops callback with more than eight argument slots is read two
> slots off.
>
> This has gone unnoticed because no in-tree struct_ops member passes
> arguments on the stack. Pass is_struct_ops into save_args() and pick the
> offset accordingly, mirroring the x86 fix.
>
> Fixes: 9014cf56f13d ("bpf, arm64: Support up to 12 function arguments")
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> ---
>  arch/arm64/net/bpf_jit_comp.c | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.=
c
> index c6756b964c843..4fe235f7ce894 100644
> --- a/arch/arm64/net/bpf_jit_comp.c
> +++ b/arch/arm64/net/bpf_jit_comp.c
> @@ -2506,7 +2506,7 @@ static void clear_garbage(struct jit_ctx *ctx, int =
reg, int effective_bytes)
>  static void save_args(struct jit_ctx *ctx, int bargs_off, int oargs_off,
>                       const struct btf_func_model *m,
>                       const struct arg_aux *a,
> -                     bool for_call_origin)
> +                     bool for_call_origin, bool is_struct_ops)
>  {
>         int i;
>         int reg;
> @@ -2526,7 +2526,15 @@ static void save_args(struct jit_ctx *ctx, int bar=
gs_off, int oargs_off,
>                 bargs_off +=3D 8;
>         }
>
> -       soff =3D 32; /* on stack arguments start from FP + 32 */
> +       /*
> +        * On-stack arguments start above the frame(s) pushed by the
> +        * trampoline prologue. A traced function is entered through the
> +        * fentry call, so both the parent (FP/x9) and the traced functio=
n
> +        * (FP/LR) frames are saved and the arguments start at FP + 32. A
> +        * struct_ops callback is called indirectly, so only the FP/LR fr=
ame
> +        * is saved and the arguments start at FP + 16.
> +        */
> +       soff =3D is_struct_ops ? 16 : 32;
>         doff =3D (for_call_origin ? oargs_off : bargs_off);
>
>         /* save on stack arguments */
> @@ -2722,7 +2730,7 @@ static int prepare_trampoline(struct jit_ctx *ctx, =
struct bpf_tramp_image *im,
>         store_func_meta(ctx, func_meta, func_meta_off);
>
>         /* save args for bpf */
> -       save_args(ctx, bargs_off, oargs_off, m, a, false);
> +       save_args(ctx, bargs_off, oargs_off, m, a, false, is_struct_ops);
>
>         /* save callee saved registers */
>         emit(A64_STR64I(A64_R(19), A64_SP, regs_off), ctx);
> @@ -2771,7 +2779,7 @@ static int prepare_trampoline(struct jit_ctx *ctx, =
struct bpf_tramp_image *im,
>
>         if (flags & BPF_TRAMP_F_CALL_ORIG) {
>                 /* save args for original func */
> -               save_args(ctx, bargs_off, oargs_off, m, a, true);
> +               save_args(ctx, bargs_off, oargs_off, m, a, true, is_struc=
t_ops);
>                 /* call original func */
>                 emit(A64_LDR64I(A64_R(10), A64_SP, retaddr_off), ctx);
>                 emit(A64_ADR(A64_LR, AARCH64_INSN_SIZE * 2), ctx);
>
> base-commit: 1d91ea01185656ac3ee63c5f9f6f8bde3c746b3d
> --
> 2.53.0-Meta
>
