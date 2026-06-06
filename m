Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CA8D2836E
	for <bpf@vger.kernel.org>; Sat,  6 Jun 2026 03:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780716660; cv=pass; b=tGvc6FdojpgsP9A7AnuNuh76dW+Uwu/2pE1h5J+oY5kkOQYatleU8y21xW/QoAlatbOVCNOhGNkQ/1cwHlZBx/myAt67ZJJaQGLVlhfUN6Ls/hYiu5/Cy67FG78tUoBWdJwjBd1xtzyXKSIjGYedfWjf4JfIeMvdtHZ5kEbQAKQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780716660; c=relaxed/simple;
	bh=YyIgWl13zTS1sEVhUsDFiP7mMkBQiYK8+TD60O410To=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OUh41pIowL46CYxH8fp10YqkP7JUyXMQPaVpf1ETqojq/UngRGfhhudh6xozwaJdflCnHm8LKOpMH1UsVmhbVrZivnUL6hot43Lvbb12x3D65E1FfRJONV8t2yznS5J8hJcwQ/oLzmo6VxtUUFKIrUNIF2wm88bVKPxjJo/Ol6M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MSR6XyTc; arc=pass smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MSR6XyTc"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-7dc67a5e102so27199247b3.1
        for <bpf@vger.kernel.org>; Fri, 05 Jun 2026 20:30:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780716657; cv=none;
        d=google.com; s=arc-20240605;
        b=NoBEYwytsW1ACOjKuhY5XhtOzCC84yGXTrQvnLzcIwmz1QAtHw5ZsHO4XsL4Gk7Tdj
         qpDoI+V1eH+3SERVWhQk9baYQEw+lVyGYc7EZBFQNnGK0zKVaCLpcdAKOOgd1L/ZhzMW
         8nYZA3w0LKCS49UNArWV/uIDDG2pZ3gtpcDkCl4oiqGs0x9XTdL5os968/giHg5e+V9n
         JZSIcnU7SSpNNwuaoDlQf7/zgngCURj6Fh+EEF6vPlIWGEUZHWekQaaUTdxDEcehTjRO
         5Ci4BoI1mi6erHBlLO64GBD7CKYTHgOZNFI3W3irowIZLerZI9vHYS34M5pCj5MYgsdl
         qDPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vg57guE2GpeD1iW+TOAV8yCEaLvMfoS/usWAjWfJDkg=;
        fh=P8UFmARgo6E1SJEgDzHgEs+Hm7Vn5pqqElJJoO2TKVw=;
        b=b9O2mza8caj80H46HQwWP5yJy0V4HHO4jGJz4RZy92lFVoTDtdw4GnZLv4o2OunMVN
         77vE0r9Yo6QMNWXkBZJKs1fBc6x3jSF4DFpu99Wh5DS4+v5gYc7A5Pw9FOiMgXnQOmL8
         6OCDgJc7G9lWZFfKLeWknWy74JxBCaTeZUXWe3GbnGjSUgvyxeAB6JYBk2qCpFxo2Kb4
         d/MFO5bZbi4slTUX1CeTuxCBi15ILeeWxQpJC2m/DvjjzPPDp0PEDRe3gtMTiabZek35
         +jyiCPFRO4iKP39wFIeCW0wKdPryDWGrVfIsxwI1VS6rVt+ZhAM7hTP6rLjZlG2iN7jz
         Lqmw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780716657; x=1781321457; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vg57guE2GpeD1iW+TOAV8yCEaLvMfoS/usWAjWfJDkg=;
        b=MSR6XyTcVtRHDyewZhDxrgX2dbM/NWm1CGqtDn+aLP/LOl32cLJpFLDPyjCFmuyYN3
         /i/EQqwikviQRHQRqYR8wMkUFIz8tdmKHoEXlf25WcNYx3qxAOByEXoPP7Ltrs2tlU02
         d8zi5bl8TImSlw+0j7NIK8BmNahvrOoHWKSV8Jgtrs5hrs4KtBy7N7RPf6bkJDcAnpUc
         qv2jWT3aSp8rCbUCZ+Z+2C6QyC5D5WsGSp+Nz3c2n62OndrskVC5mauEEtdnPBNEbaUV
         yu1S0EgZ+Axmv3b1FGEG9bC9vEjWzvYBVVlTXMKqQJJP2oFfybauL2AZNuLRbjNqCqDN
         N1CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780716657; x=1781321457;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vg57guE2GpeD1iW+TOAV8yCEaLvMfoS/usWAjWfJDkg=;
        b=SoAT8hdNi7WuNEPwo3Z+g2Y5dT7CzbnSBB719Lf5J5cM4DxDy5atmm7DNqM8i6YpCJ
         BwHlbeKI5xE+ZhZ7V9XHC6bLjCMQa9UV3OJ3rnrrcRGTL+t8C5gKGfMMHPaXBwd7zLFo
         g8G9e90i64JjRx2ub+8vp4Rf/JjlKrv4bXoFDOBPoNVRfAcnQ8ZfpZVsEDfJiC9rKY4t
         smIwNAw92K3CZBOcpwckndpf9ewkyrWcS6CqDNgXSnVz+X5cSwM/qK77Du1WXm8E4BBi
         ShtF/pAhl4y/Plsmz8Q+h38xFtdgRnZvZsZ4IN+KenizQQrc95+PxPDZzHEOcI6qWF0k
         bqog==
X-Forwarded-Encrypted: i=1; AFNElJ9Y21PFSTSJ60ZhpfQhWKwXG2xQsUJJN55sx42Qp90vRzlj2dWVF+IzXedYkUZphf1QMCw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzF3Uu6Euy3QPebSmcLfO2ZSRnpQm16jTnYia47dYGgMRpl+fKM
	hoP77pZcOd3tGFhbFI/C5ETyoX1tVKy4F9BTwbceQ3KKgmkK9d/sR/B1eK22yxkoVdiIqYRTU/g
	XauqKmnY9JDdt7CU+Jm7bNtviNMhJ78o=
X-Gm-Gg: Acq92OF9cHZgH79Q60REYfIDLPFejZzJj1XSxh1M4cEyMlrC9gxF63We6meEhjumeZm
	u3SaaXmhsd7hykGUuSxI0DxMIoqnsYgQutJ4ECmUPUJSdHT/GERQPkDemPrgKvqObO9gJXqiX1W
	n8Jvg1vah/0OC8DWEXayteB0GlySjv6VrtJnSKoFxpUqX9nWmMWPVj9/KeajbC9HOaACHLC2qIt
	FkrEndOW2JXgb5BaYtCihfivJrl1TQQy65im52JRf9syFYpY9GGIjdYohZG7srObFXCK+9hNCJm
	kbIsI9jzPxQKzB5NevHUPwu7Bx/d
X-Received: by 2002:a05:690c:e3ca:b0:7bd:5c77:1aa9 with SMTP id
 00721157ae682-7ed09935207mr67725927b3.0.1780716657494; Fri, 05 Jun 2026
 20:30:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260606024540.47362-1-ethantidmore06@gmail.com> <86b976f32a179141dbeb3eed5fa106f18f2e46b5c6849ca2c800484847d1deb7@mail.kernel.org>
In-Reply-To: <86b976f32a179141dbeb3eed5fa106f18f2e46b5c6849ca2c800484847d1deb7@mail.kernel.org>
From: Amery Hung <ameryhung@gmail.com>
Date: Fri, 5 Jun 2026 20:30:45 -0700
X-Gm-Features: AVHnY4JWpDzmyUaTLEPcbCovJb73DDHBDqAJXpddWD5r0RPgfKYkO_cHYbOTL5Y
Message-ID: <CAMB2axM+pLHdXYtEe0i+LTMRzB8ZWaZqCisRcOsrGeP9ToZzCQ@mail.gmail.com>
Subject: Re: [PATCH] bpf: Fix signedness bug
To: bot+bpf-ci@kernel.org
Cc: ethantidmore06@gmail.com, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, john.fastabend@gmail.com, martin.lau@linux.dev, 
	song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org, 
	martin.lau@kernel.org, clm@meta.com, ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 5, 2026 at 8:25=E2=80=AFPM <bot+bpf-ci@kernel.org> wrote:
>
> > commit cc27f12c12ff54b8eace339c3e130317bf205277
> > Author:     Ethan Tidmore <ethantidmore06@gmail.com>
> >
> >     bpf: Fix signedness bug
> >
> >     The function acquire_reference() returns negative error codes and '=
id'
> >     is an unsigned integer, so the check (id < 0) is always impossible.
>
> Is this commit message accurate? Looking at check_kfunc_call() in
> kernel/bpf/verifier.c, the variable 'id' is declared as a signed int:
>
>     const struct btf_param *args;
>     u32 i, nargs, ptr_type_id;
>     struct btf *desc_btf;
>     int id;

Hi,

As pointed out by the bot, the fix to the issue has been merged as
part of the following patchset.
https://lore.kernel.org/bpf/20260605202056.1780352-1-ameryhung@gmail.com/

Thanks,
Amery

>
> Since acquire_reference() can return negative error codes like -ENOMEM,
> wouldn't the original check (id < 0) work correctly?
>
> The three other call sites of acquire_reference() in the verifier all use
> the same signed-int pattern without issue:
>
>     verifier.c:mark_stack_slots_dynptr():
>         id =3D acquire_reference(env, insn_idx, dynptr_id);
>         if (id < 0)
>             return id;
>
>     verifier.c:mark_stack_slots_iter():
>         id =3D acquire_reference(env, insn_idx, ITER_TYPE_TO_ID(iter_type=
));
>         if (id < 0)
>             return id;
>
>     verifier.c:check_helper_call():
>         id =3D acquire_reference(env, insn_idx, fn->arg_type[arg_num]);
>         if (id < 0)
>             return id;
>
> It looks like the Smatch warning might be a false positive, and the origi=
nal
> code was already handling the error properly.
>
> >
> >     Detected by Smatch:
> >     kernel/bpf/verifier.c:13115 check_kfunc_call()
> >     warn: unsigned 'id' is never less than zero.
> >
> >     Fixes: 308c7a0ae8859 ("bpf: Refactor object relationship tracking a=
nd fix dynptr UAF bug")
> >     Signed-off-by: Ethan Tidmore <ethantidmore06@gmail.com>
> >
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 935595138aa0..be528a0be13c 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -13167,9 +13167,11 @@ static int check_kfunc_call(struct bpf_verifie=
r_env *env, struct bpf_insn *insn,
> >               }
> >               mark_btf_func_reg_size(env, BPF_REG_0, sizeof(void *));
> >               if (is_kfunc_acquire(&meta)) {
> > -                     id =3D acquire_reference(env, insn_idx, 0);
> > -                     if (id < 0)
> > -                             return id;
> > +                     err =3D acquire_reference(env, insn_idx, 0);
> > +                     if (err < 0)
> > +                             return err;
> > +                     id =3D err;
> > +
> >                       regs[BPF_REG_0].id =3D id;
> >               } else if (is_rbtree_node_type(ptr_type) || is_list_node_=
type(ptr_type)) {
> >                       ref_set_non_owning(env, &regs[BPF_REG_0]);
>
> The code change itself is behavior-equivalent since 'err' is also a signe=
d
> int, so the patch doesn't introduce a runtime regression. But if the prem=
ise
> that 'id' is unsigned is wrong, should the commit message be corrected?
>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READM=
E.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/270507=
96130
