Received: from mail-oo2-f40.google.com (mail-oo2-f40.google.com [74.125.231.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0BD743F4A6
	for <bpf@vger.kernel.org>; Mon,  5 Oct 2026 22:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.231.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791240671; cv=pass; b=iTZVSp3///SMfPzAE+D7dUGjjY9U44Fp7Q2YJPvj2o2aXkEh6APEyYmam1gcdX+QKchXZebSds+801TdTG2ETyMCr9Pj4egJUunsch1Zcm6t9QiTRgxiGD2wpWMsN2VfYuP55XSOkJLnIjFoNk1nJPlmPO3nfUfbk1yrcVcVW3c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791240671; c=relaxed/simple;
	bh=JQp79QdXMBa8gKuR5AX2akv+YN6nx4DC8+zM8t67W/s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Cr4Ni/HgyfE/Tm5dIb8WFkdvaHmObXOKLe7mhdzcXDFsIs9tUvkIagl/Zq8uVgdXt2/s5sNMU8OhKp8OOQS0ru3Lv3rXniPZjf1i5hEEJCDD6z+aDo0fJ18XlrB1VA/9Qc9AJnE07ZIPofwCjLbJQt8fMVstJ2K9FeQjslXQb2o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WxoN9861; arc=pass smtp.client-ip=74.125.231.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WxoN9861"
Received: by mail-oo2-f40.google.com with SMTP id 46e09a7af769-8231c185333so1491928a34.3
        for <bpf@vger.kernel.org>; Mon, 05 Oct 2026 15:51:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791240667; cv=none;
        d=google.com; s=arc-20260327;
        b=dPw8tkb2j6JN92uwfdTUg8ffnsbehH2yDGqBfAAMexedhlqrque/CQjmwT4QH/ih5p
         GRsr6abTT//5gKCcKfQP9ebC9Aj79p7VsBPjCL1OqKC9ypeFFi3S+8IASFN5PZy65U2z
         UQ1W+6zgUVdKJgN7b50+arTW5WYhI/RYVLC6VbeyES3U/40rb0xzwrQz1qyS5lbhhuCj
         dqhp62C+lwEeysHwmNTRN6fcF1gzH7pF3vQgvw9LWw3XYd8Xa3zRbCcGMfgRCb/Z91O0
         fJv9sYsqVDsR1of7hg7ipso794mEEShv6pei0TCSnH6ii20oymGQ7JlEBtY3z6SgpnwM
         1cug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ecuq0kzHluDJrU005ZlX/7dg+ri9ToBEBr09r3eRnfg=;
        fh=T73KA2KHseb8KQhKVk7RJG55SRu0GSI4/6fM2QQVPD4=;
        b=czmhwOIb+If36TTLzI8UK9nuesPk9TmjZ5jf/PA1H6gaGiFXthgqBcx4+dhCLmFSYl
         XF9i5P7DIxnedkefVudwTURiqHOPZa414RaLch8xUvgVHJ1ha1ayQlPaRT0msoa3rjoa
         4A330JKwna8qGFSXU7zDCH3wC1uxpESTuOktOZfg0KhwW7Elw+NUw2UNJwS0/VBl+ZlF
         1IVaVYdORHQHOK4RWyG36CpL88LRe/8IpIvwvJCKbSGXMPvfCWc0D8Ikm70PO2smR4x0
         sdkbFqIn4SX95SFs42Q6aGyfG5+1uLWEjCksV43Pe/cGPxhSX07/abBdhiEv+jcvt5Iz
         9sbQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791240667; x=1791845467; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ecuq0kzHluDJrU005ZlX/7dg+ri9ToBEBr09r3eRnfg=;
        b=WxoN9861sK8lRXrTKSIipQ4Ujp+mWI9aJQSGfeL4lYo0TjcFIZi/jOitbum/62TJYH
         JWDATsefbqlZcTI/X49puzfBbRk76q6Gxb7lDT+miF3DOBHHilh5vJKtwTDdBDdb6x7C
         bUDCfzWXhbanaLC3QbzGiPJ/sYwjJ2N3u6Ldilq+bA2f01DDuEm7Wh0RvoFXQIkKiyqR
         d5ylju8fevUyhMR1wZ9DR+v0aF9iEd0J28JdaQLXLHF5+oqCUa6OKnIV0uAzx4RX9Ayu
         qIDzMQt0je3lpYYuF8dodOHgfqWHuH2uU93+MdAYMy2ikwFnmpq6TNmDguT95xhCj6RR
         f/Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791240667; x=1791845467;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ecuq0kzHluDJrU005ZlX/7dg+ri9ToBEBr09r3eRnfg=;
        b=2iR5Q7CNzDdfqwFxyxvWmEgtDZLXuNw2Ky1jg0WqKDp255ZxKSg6d/Kudi5fALfGl7
         GzBKV0XK/DUvTUwgmwNOCwnb1aY5OHyh1+YI3mRu4A1+Q50+f07624sOaRuMasYm14ze
         AdrbmfJKtOOOKkhgxI/2AemQG7ksqvJr8cTTn5CILpCcIDrKVOQ3GRRbXCsE6ShWGKOM
         pP2PddpgLdPQydn+ekE8bGuRu6VCqIZV+SyxLztymkW9QV+8stz7XCgFzTJFx5+6YZNZ
         FGItnReiER8gon/9GNBoCDtl6041b8XBo836tOLOf+mQXiHnWN8WEFC2yYfW4RWV8s+n
         H1PA==
X-Forwarded-Encrypted: i=1; AKwUvBycMAg4Uqv/GsdcIlRDk/6+Hox2S01mje2188FDGj2vKJE1dInVcZi1tBggWmjaeVRd8Pk=@vger.kernel.org
X-Gm-Message-State: AFuF++mcUkqZWkyMljwEsWYP0towV2f4hXtdvFRw4w/cke2pxJ2e0hxR
	bEjfqK1zpPwHaKKM26OzHYopP/GLvq2mUrQRILHJiNu1ROLk3q5t/Sdn3JOU95YlqW38fCEvKcp
	M135S+JhAM8SwpVw4FYCH32nDR64A/fE=
X-Gm-Gg: AYBFou3i/0wlVS+Af0Vky0tL7PcEs9fSzH8+a1HvIpmqxi6swekdOXGJQrJGWTw0DzS
	VIJPrrPgNtSLej9G8L3LHyUCEx3Nus+aNMA8gxKB3dPAJpF3xW7myzLviyLCCc0cx7VcijGsrAS
	oawbaqy/lH/ww6zMrbNkASuvdVVifauV0NnP9bYKUBgOQ0Y9BYoD7VYqfaZd2r2IulIUDP7PGzc
	Ycf8NfZ/X1WCLPEFS0az421H0J4NJiePlF9yO33n85tZ2AnUCF8tEVFYeZ4hMvUAR3MzwUaNHUk
	G0ZyVtCxWK8BgWhJt9s/c1/7wVV0yY3fMR6cpeH+jIFABLt9TA2tKnSewGWS1x4=
X-Received: by 2002:a05:6808:508e:b0:4f9:595:b80e with SMTP id
 5614622812f47-4f905960b1cmr4500444b6e.34.1791240667582; Mon, 05 Oct 2026
 15:51:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261005-a3-arg-trusted-v4-v1-0-50ee0268fd39@mails.tsinghua.edu.cn>
 <20261005-a3-arg-trusted-v4-v1-1-50ee0268fd39@mails.tsinghua.edu.cn>
In-Reply-To: <20261005-a3-arg-trusted-v4-v1-1-50ee0268fd39@mails.tsinghua.edu.cn>
From: Amery Hung <ameryhung@gmail.com>
Date: Mon, 5 Oct 2026 15:50:54 -0700
X-Gm-Features: AclHuK8zBX-mtp_yJj-5sCOyT12IpJXdXhLg7yENqiCJALP4ywh6Sl7KbDFCwoo
Message-ID: <CAMB2axNnY5wxkTrd3_tHyXBzXYyjJUkqRb1uNbUquwTJ_FLVMg@mail.gmail.com>
Subject: Re: [PATCH bpf 1/2] bpf: Require referenced or trusted pointer for
 __arg_trusted arg
To: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>
Cc: Eduard Zingerman <eddyz87@gmail.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Yonghong Song <yonghong.song@linux.dev>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, Shuah Khan <shuah@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
	John Fastabend <john.fastabend@gmail.com>, Emil Tsalapatis <emil@etsalapatis.com>, bpf@vger.kernel.org, 
	Song Liu <song@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 5, 2026 at 8:23=E2=80=AFAM Yiyang Chen
<chenyy23@mails.tsinghua.edu.cn> wrote:
>
> A global subprogram parameter tagged __arg_trusted is documented to
> accept only the PTR_TRUSTED flavor of PTR_TO_BTF_ID, but the call-site
> check also accepts a bare PTR_TO_BTF_ID and an MEM_RCU one.
>
> check_reg_type() resolves the accepted set from the base argument type
> alone and compares only MEM_RDONLY and PTR_MAYBE_NULL, so the PTR_TRUSTED
> bit of arg_type is never consulted. The trusted/RCU enforcement in
> check_func_arg() is gated on is_kfunc(meta), which is false for a
> subprogram call, so that block is skipped for __arg_trusted arguments.
>
> The callee is then validated with PTR_TRUSTED set on the register while
> the caller passed a pointer that is neither referenced nor trusted.
> bpf_may_fault_on_deref() is false for PTR_TRUSTED, so the dereference
> becomes a raw load instead of a BPF_PROBE_MEM probe, is_trusted_reg()
> kfuncs accept the pointer, and the callee can pass it on to a kfunc that
> would have rejected it at the original call site.
>
> Reject a PTR_TO_BTF_ID that is neither referenced nor trusted when the
> argument is marked PTR_TRUSTED. A referenced register is accepted, as in
> is_trusted_reg(). PTR_MAYBE_NULL is not counted as an unsafe modifier
> when __arg_nullable declares it, so trusted-and-nullable arguments keep
> working. The kfunc path is unchanged.
>
> Fixes: e2b3c4ff5d183da6d1863c2321413406a2752e7a ("bpf: add __arg_trusted =
global func arg tag")
> Signed-off-by: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>
> ---
>  kernel/bpf/verifier.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index fd3c0206bd67d..fe5edbef85a16 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -9597,6 +9597,27 @@ static int check_func_arg(struct bpf_verifier_env =
*env, u32 arg, u32 slot, u32 p
>                         }
>                 }
>
> +               /* A __arg_trusted argument requires a referenced or trus=
ted
> +                * pointer. btf_ptr_types also matches a bare PTR_TO_BTF_=
ID and
> +                * an MEM_RCU one, but neither is referenced or trusted, =
so the
> +                * callee would be verified with PTR_TRUSTED while the ca=
ller
> +                * passed something that is not. PTR_MAYBE_NULL is not co=
unted
> +                * as unsafe when __arg_nullable declares it, because
> +                * bpf_type_has_unsafe_modifiers() treats that flag as un=
safe.
> +                */
> +               if ((arg_type & PTR_TRUSTED) && base_type(reg->type) =3D=
=3D PTR_TO_BTF_ID &&
> +                   !reg_is_referenced(env, reg)) {
> +                       u32 flags =3D type_flag(reg->type);
> +
> +                       if (!(flags & BPF_REG_TRUSTED_MODIFIERS) ||
> +                           (flags & ~(BPF_REG_TRUSTED_MODIFIERS |
> +                                      (arg_type & PTR_MAYBE_NULL)))) {
> +                               verbose(env, "%s must be referenced or tr=
usted\n",
> +                                       reg_arg_name(env, argno));
> +                               return -EINVAL;
> +                       }
> +               }
> +

Could we avoid adding a second provenance check and make the existing
kfunc check contract-driven instead?

Kfunc ARG_PTR_TO_BTF_ID arguments implicitly require trusted or
referenced provenance through the is_kfunc(meta) condition. Global
subprogs express the same requirement explicitly with PTR_TRUSTED.
Likewise, __nullable and __arg_nullable permit PTR_MAYBE_NULL,
which should not by itself make the provenance invalid.

First, encode the kfunc requirement in its generated prototype:

if (base_type(arg_type) =3D=3D ARG_PTR_TO_BTF_ID) {
        arg_type |=3D PTR_TRUSTED;

        /* MEM_RCU denotes an accepted alternative provenance. */
        if (is_kfunc_rcu(meta))
                arg_type |=3D MEM_RCU;
}

The common check can then be driven entirely by the argument contract:

reg_type =3D reg->type & ~(arg_type & PTR_MAYBE_NULL);

if ((arg_type & PTR_TRUSTED) &&
    (!is_trusted_reg_type(env, reg, reg_type) ||
     bpf_type_has_unsafe_modifiers(reg_type))) {
        if (!(arg_type & MEM_RCU)) {
                /* must be referenced or trusted */
                return -EINVAL;
        }
        if (!is_rcu_reg(reg)) {
                /* must be an RCU pointer */
                return -EINVAL;
        }
}

is_trusted_reg_type() would contain the existing
is_trusted_reg() logic, but use the supplied normalized type for its
type and modifier checks while still using the original register ID for
reference lookup.

resolve_func_arg_type() should continue dropping PTR_TRUSTED when
it changes ARG_PTR_TO_BTF_ID into ARG_PTR_TO_MEM; that is a
different, fixed-size memory-buffer contract.

This also lets a kfunc __nullable argument accept
PTR_TRUSTED | PTR_MAYBE_NULL, as its existing contract specifies.
Please add corresponding kfunc coverage and adjust the claim that the
kfunc path is unchanged.

>                 if (is_kfunc(meta) && (!is_trusted_reg(env, reg) ||
>                                        bpf_type_has_unsafe_modifiers(reg-=
>type))) {
>                         if (!(arg_type & MEM_RCU)) {
>
> --
> 2.43.0
>
>
