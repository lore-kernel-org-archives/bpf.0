Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E09643D7D69
	for <bpf@vger.kernel.org>; Wed, 24 Jun 2026 15:12:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782313949; cv=pass; b=MMhHQg6CWxPMClsezEIm1xFN+njeOOTE8yGdbrlsgENcjTeOWQZ2+nmW8DLkgk2nvBPEIP1geHPTjtoA4sxRLm9mYq7rbcMCZsmmCcNxr6qX7raVQB29aFo9FVek9m+ltGJ0mVkYPL4SK5CyypKqPrLC7I86+mmefPhAJXXQnKE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782313949; c=relaxed/simple;
	bh=Vp8keKnwuVU25gbS2Lo25BsNMlW82wWYUgV18JLLcBU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pEaAihf7BjE7GEmK3yfXOnGV6nj98OwRUt5CaH/0Obs2PU3w5tYcW15wP5QwbHoR6gqkS7uHDbfg2gIuPZ/sRzLHR4pOTbF0GycYwgiq7J1udMHkiYL7EV6QGFuq/iPkkgi3Fil4p4yQmN55lciRjrXkARI7Nfw1CmI63oL4+yM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=alFZs241; arc=pass smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="alFZs241"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-37de8c6a2b6so407290a91.0
        for <bpf@vger.kernel.org>; Wed, 24 Jun 2026 08:12:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782313947; cv=none;
        d=google.com; s=arc-20240605;
        b=K6jjKNGyDrZqjHCcp36KXuMowSyw/7kioTykAL2Ns2fDWru5+BYXuXyscQyBdLzFaH
         /wmBwdflq7TrcHPxOwyotl4trS+SmfVnu43ohnngq/B67kPE2r3/8H3o7VLokMdh/UxO
         p/wrQe5nuw4GgMoqZieW9KGmIH3o6BNUSi66vcZCfLcH9npZMAgU6SzWa336NHtrrR+D
         b/wO0RLUwXlZgDfHK1gmywMUOsyyFrRiLFoq3Z0ubmCq5rC/ncBAmL50avab+RQfktEG
         gkMVz43xZt8H3hk5lyre1YSYH8Nu0Vu+yK8nX5FiOhkNFKzRpCaie0fKv4IB34t6ZxF5
         WcoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=s3Rqo1v6hR+TdyWW7XUj7JPG85R7AE1P0AsDsVJK07E=;
        fh=BxzEDJ4wdLNXJrLj75dQRooNTzYAdbfEsu+lv4p/b+U=;
        b=bUahjL4PbTGLNulnM1CbXkKyw3wUTwO5EqFkg5iN/e1M4p5TPqM2809mkK5qd3qLcb
         34esWcT3TSTxVdoUNoicFJplLWkMfD5X1xf1TneQO+p+hqr7qxU4kazHGPqlLw+7yfcR
         t3jvwpCLS7gTt6G6e6vRy2YeA8lbIoJr+scaTlgLIlq80O7UVkJ++ul8Dz1CIA+bzkLU
         VF7gxOe1zc1tBQSIuGvP3xAgkFzMxloSzb1db10147afnshebaO4bxwsfn+vanmWXi/t
         tFsDIs48W4IDQDI7LVZRPvfphbV3ooSVEqxTa6ST+nziQ8rswG0GrByjS5NHkvn2Kl3s
         nxlw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1782313947; x=1782918747; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s3Rqo1v6hR+TdyWW7XUj7JPG85R7AE1P0AsDsVJK07E=;
        b=alFZs241whxcYE7zxCK7VJi5vgnIIyadeWg43vc0V1eTlcOHIpQ7gEXY51vVlYONFV
         BQ2UDYu8sOS3Xl2YESDkFuUQ6SyQHOyB/XSfHxAfugCW78AxxHYaRbRS77b1VDEaayJ9
         vVk2dpHOm0D1RVO9sRkzaS75iH8Ruq6eOa2wNxNHMpUtgU5G4NO0SWlWRb5WNGPZpW6v
         owx+SCl+7KnT69uw6ykSZq5Y+CF+HZGSbqIm3oBIEw5fldIIOy1qbbhOvYK+gUTJUXep
         Mk0FYXE5dZnUVQjIFrm9pJ8cR3ofrrQKpaJlQMPS+pVRFnmcaXFg5yrqXgW+cDevryiv
         15Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782313947; x=1782918747;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=s3Rqo1v6hR+TdyWW7XUj7JPG85R7AE1P0AsDsVJK07E=;
        b=dtR4BzE3FCm6tpNkwal/S9+V5fQfZcc3tP8YistjDyr1Qf3POZzgZirni7ZrNRClhw
         06t+zSJCkTTPbEeDcq1mJ4PwaBjmq019hB0vLM+gGXx274is5x/jctbvMxHpS/U0Y7WT
         +Q7UtISOlHnK4bcXHAVCwRhSzOvziAclvjkB7lupniax4OLwyWtmZN2Vb21OxL7rGzdR
         n16nWfG+Iwhmra1M2FxVOdEhB/3eF+jnXM/CZmhMTMNCKwE1vGByQvMy1M5sa7TMng3H
         SGSzHenneys6055w7C7XmC6JXnQiYL8DNGAM+PjeGTUoR9d+umyBzeEdnltA04mFXlBf
         9IDA==
X-Forwarded-Encrypted: i=1; AHgh+RpZN5sZ2U3CJQrMyWA1oj4p/iwv470uTD8pzXQ6/lsn84Y/ypXfmWyjruI7UPhKWNveoGw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGG7EFipQQ8e3BaUfdIscSTpdNikykw4tggP6evO3f+fcvXPdK
	iXLfwXVHXbzeyEtzi0+1bDoO0ZjaFSXqJZNC2hf83ccuO4rKazufa2bjRu7veRjSpKW8wAsM9cI
	w1TwFdFvo39EPz1iDP1fkE3O3lhaqGvmtFZcVNxWg
X-Gm-Gg: AfdE7ckURu+SZZribLRuha5A0eU7efiGKdgi+vFOijEsA+cmYpmgeMbuzzCoQitoMtu
	pZDux2D/xEHAHeBpXpZSg2ZjoG3PiNB2IbxNK7DiMGmTVHlKMC96l82E1g24BMvrCFMeYhlX4eK
	5PK9DbIcxqJLysELwa51SoXV3kkvA1ex+xo2KtPTmy7rmNTGayfqHUHke5v91ah8f0BZvbExp8N
	NSvcZjvWbKTWuQUUu9tWwSFanG/q767ldLKvymY2EcDSPg7dbs2UMdJbxdpQP4fNvI2aUIO
X-Received: by 2002:a17:90b:5343:b0:368:b724:6d53 with SMTP id
 98e67ed59e1d1-37de429f69bmr3852431a91.4.1782313946844; Wed, 24 Jun 2026
 08:12:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260624140301.93421-1-daniel@iogearbox.net> <20260624140301.93421-2-daniel@iogearbox.net>
In-Reply-To: <20260624140301.93421-2-daniel@iogearbox.net>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 24 Jun 2026 11:12:15 -0400
X-Gm-Features: AVVi8CcBJpd-Njskh1XOODL-o6qJSUPZuS3j9bS26ldP6j8TVq--D1Lg4wJzJqU
Message-ID: <CAHC9VhRar1x7kyjhgdmJ=Mfz4Msarv=wQ1821v723CaVdk1uTA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/5] bpf: Verify signed loader metadata at
 load time
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: ast@kernel.org, kpsingh@kernel.org, James.Bottomley@hansenpartnership.com, 
	bboscaccy@linux.microsoft.com, memxor@gmail.com, 
	torvalds@linux-foundation.org, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 24, 2026 at 10:03=E2=80=AFAM Daniel Borkmann <daniel@iogearbox.=
net> wrote:
>
> A signed gen_loader program carries the programs, maps and relocations it
> installs in a metadata array map. The loader instructions are covered by
> the PKCS#7 signature, but the metadata map is not: Today the loader
> compares the map contents from within BPF against a hash baked into its
> (signed) instructions, using the kernel-cached map hash. The kernel itsel=
f
> never actually attests that the metadata the loader installs is the
> metadata that was signed.
>
> This split is the core of the long-standing objection to the BPF signing
> scheme from the LSM / integrity side: the integrity check of a light
> skeleton only completes once the loader program runs, that is, after the
> security_bpf_prog_load() hook, so at admission time an LSM observes a
> program whose payload has not yet been verified [0]. Auditing the chain
> link is also not a purely cryptographic operation: whoever signs or revie=
ws
> an lskel has to disassemble the loader's preamble to convince themselves
> that the embedded hash check is present and correct [1][2]. Two acceptabl=
e
> fixes were identified in those threads: Complete the integrity check
> before the admission hook fires, or add a second hook that collects the
> verification result after the loader ran [3]. Let's implement the former,
> without growing the UAPI.
>
> A signed loader binds its metadata map(s) through the existing fd_array,
> and an exclusive map is already bound to a program digest (excl_prog_hash=
).
> So when a signature is present, collect the exclusive maps from fd_array
> and append their frozen contents to the instructions before verification:
> the signature now covers insns || metadata_0 || metadata_1 || [...] in th=
e
> fd_array order, and verification completes in bpf_check(), once the
> fd_array maps are resolved into used_maps, before the LSM admission hook
> and the rest of verification.
>
> A program is either BPF_SIG_UNSIGNED or BPF_SIG_VERIFIED, with nothing in
> between. While folding the fd_array maps, a non-exclusive map bound to
> a signed program is rejected, so every map folded into the signature is
> exclusive. A signed loader that fails to cover its metadata thus does not
> load, and BPF_SIG_VERIFIED always means the instructions and every
> exclusive map are authentic.
>
> The maps must be frozen so the hashed bytes cannot change before the
> loader runs; the map <-> program digest binding is enforced by the
> verifier for every used map. Binding maps through fd_array_cnt makes the
> verifier resolve and excl-check them (excl_prog_sha vs prog->digest)
> before it would otherwise compute the digest, so compute prog->digest
> up front in bpf_check(), over the unmodified instructions the
> signature covers, for a load that folds metadata.
>
> Unsigned programs are not affected. Note, signed loaders generated by
> older libbpf/bpftool versions need to be regenerated; some of the recent
> fixes we've had on the signed loader side require the latter already to
> close gaps.
>
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> Link: https://lore.kernel.org/bpf/CAHC9VhSDkwGgPfrBUh7EgBKEJj_JjnY68c0YAm=
uuLT_i--GskQ@mail.gmail.com [0]
> Link: https://lore.kernel.org/bpf/2f71d6c03698eb17d51f7247efde777627ee578=
a.camel@HansenPartnership.com [1]
> Link: https://lore.kernel.org/lkml/ecf0521ed302db672672ebfbc670ecfba36a6e=
00.camel@HansenPartnership.com [2]
> Link: https://lore.kernel.org/bpf/88703f00d5b7a779728451008626efa45e42db3=
d.camel@HansenPartnership.com [3]
> ---
>  include/linux/bpf_verifier.h |   1 +
>  kernel/bpf/syscall.c         |  76 +---------------
>  kernel/bpf/verifier.c        | 163 ++++++++++++++++++++++++++++++++++-
>  3 files changed, 165 insertions(+), 75 deletions(-)

...

> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index b44106c8ea75..026b61d78bdb 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -3189,10 +3121,6 @@ static int bpf_prog_load(union bpf_attr *attr, bpf=
ptr_t uattr, struct bpf_log_at
>         if (err < 0)
>                 goto free_prog;
>
> -       err =3D security_bpf_prog_load(prog, attr, token, uattr.is_kernel=
);
> -       if (err)
> -               goto free_prog;
> -
>         /* run eBPF verifier */
>         err =3D bpf_check(&prog, attr, uattr, attr_log);
>         if (err < 0)

We must preserve the existing location of the call into the
security_bpf_prog_load() hook as some users rely on this hook being
called *before* the verifier runs.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 2abc79dbf281..9cd2b62da380 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -19758,11 +19895,28 @@ int bpf_check(struct bpf_prog **prog, union bpf=
_attr *attr, bpfptr_t uattr,
>         ret =3D bpf_vlog_init(&env->log, attr_log->level, attr_log->ubuf,=
 attr_log->size);
>         if (ret)
>                 goto err_unlock;
> +       if (env->check_signature) {
> +               ret =3D bpf_prog_calc_tag(env->prog);
> +               if (ret < 0)
> +                       goto skip_full_check;
> +       }
>
>         ret =3D process_fd_array(env, attr, uattr);
>         if (ret)
>                 goto skip_full_check;
>
> +       if (env->check_signature) {
> +               ret =3D bpf_prog_verify_signature(env, attr, uattr.is_ker=
nel);
> +               if (ret)
> +                       goto skip_full_check;
> +               signed_map_cnt =3D env->used_map_cnt;
> +       }
> +
> +       ret =3D security_bpf_prog_load(env->prog, attr, env->prog->aux->t=
oken,
> +                                    uattr.is_kernel);
> +       if (ret)
> +               goto skip_full_check;

We can always create a new LSM hook for this call site, e.g.
security_bpf_prog_verify_signature(...).

>         mark_verifier_state_clean(env);
>
>         if (IS_ERR(btf_vmlinux)) {

--=20
paul-moore.com
