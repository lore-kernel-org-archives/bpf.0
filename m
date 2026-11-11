Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794395852;
	b=rLLQiFrz30FexYqJ1qdlXpxG62B4HzGAKPCeoEzF8lcIWMgMmgAU9BlyTDc3hhnCO3SZ
	 /dkNkhMnBaC67wub6C0g158dTjPp+A3Ld/NoF2Sc81AgEb3XuPGLHXF5LYI7VXpZ9ZQa1
	 5idpsnFCefDlDFTo3jHM3RNszhw2l0YR9kIhyvH+0BliEHmoaosbdE5xU3+qMaqU05wT8
	 Fv6noxO1Vb5fJo+GN1sIk8L7Qx/kl3aPduiA88Cm3bhA2qRLDrDmWrjK9Ex7lPuTMoaOO
	 aHeg3UdXl6Maq04ZkpyccHmCn/c/Jsv8Rg6joujPNj1pjYyWyuRPYPlmK/X6dNlo+Iw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794395852;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=ozSf+hL1jldFALEH5fXM+3KXfDAEgs0BjajLN8xbzFA=;
	b=GL2GImhw8x/LqiKy7X5PR+YElV1X5vQ2ama2W/if6ZQ3N3BE5F6ng8kbifzRXhOkp8IA
	 gef0nmyec9ad0t1arjgjlLuNoBXkZDxtyLuJJiAbrCC09imlgltsuB3ICWjsI/GInB373
	 59qmoVrzs4pme9W+wx7UtDygN2ofHLV4I3H9dx0a2aT2L58nd0vemWcO2nxYZbnnhTU7u
	 /ch3+LfNJDhyx0c2IeFN/4kH+/zXvsmWOpXQG2rOp/GAYXYfMQ16HH/U448QrntBjMMeZ
	 B38LhQuAcR1gdovhZGLH8gtXC0Ojg3bUirxnhyK5cs9OwtKHoeIX8yQajZU5g05eVow==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uGeU3Xvv;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.43
Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C47606A337
	for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 11:17:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 55C47606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uGeU3Xvv
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-67be6030c9fso2665962d50.3
        for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 03:17:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794395851; cv=none;
        d=google.com; s=arc-20260327;
        b=aTBxw6OTCF649mB3jf1c0EA10lG7EzU+54OOVmdvaBcS2eah0np90n6wOGX7cglDOl
         NzfQWU49bLc6T/dnvZWsvO1JMz+WEvD1mPS2npvjr4jgwaNNznYTzzKE88ybCJ0bjEfF
         9ebpA9invrwDpTJ5wRySgNrIqp21RmsHMYF9VMSdsrrvod6ljWev+omPPA9M3O7Tl9aI
         NPLWKyEjaXopON/0siGuMTIU0oPWj6b3WRL7MsnUPQRYdyDnOXMNCfrrdkkCtLe2jkSh
         ffaqqFQpq9/NUrtvedYHiotpezsQJWeSDABbA/zQkvHWq8Zg42bxsk3UCviqPcbjHv4o
         dWDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ozSf+hL1jldFALEH5fXM+3KXfDAEgs0BjajLN8xbzFA=;
        fh=tRUSOu27Hngvyia7A3IHP96wnof3ai/n5Q0wTAT/+tA=;
        b=GIAx3lvyMsHcbu48cIBBQ0+feIUBHy8RlPZggWfXkOxQ18Tzi6zmFeDf4RvPcRvzgL
         SW0vyzYrHbMWZHUcg6mptl7jiGww/4gT6VyCMjS1DXwYBCdOecHKKXPeS9J22sSDn74+
         oPJVNJqv0APHhhA2bddBwNmN7MvAmvFTSgMP0VOpYvX2FIor5WVZmVBIQ1FA2uzqW5WQ
         HGSVkY1rduu6WILcKIGpU0pc8YXcf/j87nTd31bPp98CwsclIbqJqfnhXGragHBbWh4C
         TLQKYSchz2g5zQEQdYe0/v89qCKUbT6dvD2oeEF3ftNeqN6ZteR7TFg0RrmSLsqapfHW
         TWnw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794395851; x=1795000651; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ozSf+hL1jldFALEH5fXM+3KXfDAEgs0BjajLN8xbzFA=;
        b=uGeU3Xvv/E7K4BHv6EBIagPuXvkh/1ouclHKAD7X+55xw3flHGdEAvIEZ1+liX+9Ct
         OK3eR6JiKmvu/bTADMu/L094pqKMP3JlFDrFkmeEuQL/qbs98nXqNAayfOE6SlLGBy/i
         5rWPVAMT2vjGduqRBzvKbha2e/14GMcDKrPOPrIZfuUrCLCPxtESkzNMGRAcSRTHGS3g
         tVxjimEidLB2HovXkax5tEhnhMNl9pI7hJ676R4QBJyp8VcJr6yuwZqzvj7KXnCZnpcr
         +UsUqY+lE3FVkkVFk8cYp4y/FHG6VlpsAD6kKqVhuqC7Ol1B80XgziGLdVWXkSJReizL
         HJvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794395851; x=1795000651;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ozSf+hL1jldFALEH5fXM+3KXfDAEgs0BjajLN8xbzFA=;
        b=0SmmntfDRoQpQfKcKvQHp6sHSytKXQ/GC/5bCDfXmc+78Bvz3Ss0cDAhhwjPu4/s1X
         1/ZO4QwDUxFgmtaiMrNcRsLWwWWWOZ9/uNU3Cy/nyoUkcXl81xhn8yeUEIHcZhfMWNGB
         9BH45+PwHAazsR6CdIP6qoF/9BDk+hEhlych+oIV3kVGGUTl8sKcH3YK6w572aERFk1d
         weqAiPy6HTPFQ94FdCcTI5IpZtS0cO5cFYOiOP6GfLc2rkiX+AxFebiG6QJKgasCjfQt
         DMWHfzAf2kip1p94vHldt/hLndJFL0DmWRDBUs2w4PwBFpATHg6s0S78hQ8IaBoVkmXB
         WnEQ==
X-Forwarded-Encrypted: i=1; AL+hErHSgLorez/m2mpSMtVvnGFvrFz7YZiiFlde7ltm/0esiwpbiVA0sbEeGDz0loKa4bEEZrM=@vger.kernel.org
X-Gm-Message-State: APuU4Z+L6w92wSHlVJAIssWn2/13OshZ7o/wUM3BYoQ/RPGAWwcI5FkL
	N1Ux9D3l+5HChp2n1gVC2t0zvp4FDjES8stflODnNCxy3kkoakDPcTL4L0m/aJeM1anliubPSyZ
	uqID+suIDKdaM/kzpDuXZvFLR8Vm2KHg=
X-Gm-Gg: AYBFou2++ZTQWRhGGWEXVe3b/f3gFmIFL91t8J8nYVYstAMl5FPxpzpapvuXCyjBo5O
	r7k1dAFCS870umEvigtJf3aHMSTgD3VfTkSb77tgJFtWp1xDB2Z09FXdkTxGdHE4Qvw2XdKkVMQ
	IQC8Cl4Gp4g+1Bb4stLhvcmWOGRO9/prC1Xl38olOD+t1SN28M5idHApUpCehci1hIFVEdzayas
	5M9fqCvOyEocjrq81pMHAnx944fJbNrK6hcV87KO4iIw4L13HIc69N5v4Rei2dwC1PyWmc/zdwC
	vDg1+9gu5CNOvr2AqLnJ5YJ0SeA3hSCuzorq+ahjJRrIg3AtH1Lxe740EZgNAFijfBYKZiJxscQ
	vSoNHpXs1N9ICbcGWB4yD6A8EyBD20l0XPCSSTQ==
X-Received: by 2002:a53:b852:0:b0:677:dee1:5238 with SMTP id
 956f58d0204a3-67c6800672fmr1304770d50.88.1794395851255; Wed, 11 Nov 2026
 03:17:31 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261110164046.454431-14-a.s.protopopov@gmail.com> <c4f98afcae91b54b30f5e9fdab98125cdccf00b1c7a71afff1b16e931798c314@mail.kernel.org>
In-Reply-To: <c4f98afcae91b54b30f5e9fdab98125cdccf00b1c7a71afff1b16e931798c314@mail.kernel.org>
From: Anton Protopopov <a.s.protopopov@gmail.com>
Date: Wed, 11 Nov 2026 12:17:19 +0100
X-Gm-Features: AclHuK-dO1SKaAz8hkch1ydpFF2M6TtEYCVoI-_FOK3-FQcq1UUZ0nYxEBIVVmg
Message-ID: <CAGn_itydZuGfTHvNMo5VvmvAnXGp60J7MLXDWxBo5rj=aVh+5A@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 13/18] bpf: Check the return values of
 fmod_ret programs on found targets
To: bot+bpf-ci@kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, 
	memxor@gmail.com, almagui@kernel.org, john.fastabend@gmail.com, 
	qmo@kernel.org, brauner@kernel.org, kpsingh@kernel.org, 
	yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com, 
	ihor.solodrai@linux.dev, sashal@kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, martin.lau@kernel.org, mason@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 11, 2026 at 9:21=E2=80=AFAM <bot+bpf-ci@kernel.org> wrote:
>
> > bpf: Check the return values of fmod_ret programs on found targets
>
> TL;DR: Possible wrong behaviour: fmod_ret programs on 64-bit found target=
s
> don't require the JIT, so in the interpreter -14 may reach callers as
> 4294967282; a later commit fixes this, leaving a narrow gap here.

This won't apply anymore (see jit-related commit before)

>
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
>
> [ ... ]
>
> > +static int fmodret_retval_init(struct bpf_verifier_env *env, u32 btf_i=
d,
> > +                            unsigned long addr, const char *tname)
> > +{
>
> [ ... ]
>
> > +     if (!cnt)
> > +             goto invalid;
> > +
> > +     aux->fmodret_retvals =3D retvals;
> > +     aux->fmodret_retval_cnt =3D cnt;
> > +     return 0;
>
> For a found target that returns a 64-bit integer (size =3D=3D 8),
> check_fmodret_retval() accepts the full 64-bit R0, so "r0 =3D -14" is
> accepted as the s64 value -14.  Nothing here makes such a program require
> the JIT.
>
> If the program runs in the interpreter, prog->bpf_func is
> __bpf_prog_runN(), which is declared in kernel/bpf/core.c as:
>
>   static unsigned int PROG_NAME(stack_size)(const void *ctx,
>                                             const struct bpf_insn *insn)
>
> so only the low 32 bits of R0 come back.  The x86 trampoline handles
> interpreted programs, stores all of RAX and returns it to the caller of
> the traced function, so the caller of a long-returning found target would
> see 4294967282 instead of -14.
>
> That value is non-zero, so the function body is skipped, but it is not an
> error value either.  Callers would treat the skipped call as a success
> that returned a large positive value, which is the case the commit messag=
e
> says the check is meant to prevent ("Returning such a value instead of
> calling the function looks to the callers like a real failure").
>
> Should fmodret_retval_init() set env->prog->jit_required =3D 1 when
> size =3D=3D 8?  A later commit in this series, c4a7eee0c4d7 ("bpf: Requir=
e the
> JIT for fmod_ret programs on found 64-bit targets"), adds
> "if (size =3D=3D 8) env->prog->jit_required =3D 1;" right after these
> assignments.  No found target carries the tag until 8659bd72073c
> ("resolve_btfids: Tag fmod_ret candidates as targets"), which comes after
> that fix, so the window is narrow, but it is still a gap in this commit's
> own logic.
>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READM=
E.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/429818=
85558
