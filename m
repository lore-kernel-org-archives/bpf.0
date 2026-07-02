Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A8AF38944E
	for <bpf@vger.kernel.org>; Thu,  2 Jul 2026 22:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783029931; cv=pass; b=XIzXr8Nrfk2U6nk5uThTdJO+vBwF571AiI29lZtL3k0vnArCXb12oez8TFrqEGX+ppsnVZym7Mu1TOjhSGwq0SNmTK1QhBSJQjlVikMR/Erg2LZErRlES77GWXyEmeYgFyPZqU7JgM7mIghvyg38KiVF8tFsVVYO2KGN+riijT4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783029931; c=relaxed/simple;
	bh=bXiGxNJabvOUzbO9jP373uIsGkgJEfxAsimA9dnMZUo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b/ywbfzUNTvbe1C/30z92AskAbUeLLk7uGbuwt/bGyWB8aaXVowq0/zOA8U8SK1de59h4l29R8Hdgt+hKPvav6REhh8gvvi11HyRSesQLYKZ0LYTPa8Q5dHER/YbrzGlhtCvhiZZVB69ca4uLX4ACDt1b+/61wGGMdkq9Ka6KbE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=DgmFRc5x; arc=pass smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="DgmFRc5x"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-8478cc93299so1924414b3a.2
        for <bpf@vger.kernel.org>; Thu, 02 Jul 2026 15:05:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783029929; cv=none;
        d=google.com; s=arc-20260327;
        b=eLru52fvweLr57O5qx4E+MapNQqC+VouGWQBwBYuiKAya9VrcUFndywXL9bNF9baYZ
         iGfr1qC9ZsvW6u/w9zNfmzVV1nEOV6D29oEH6O+A4SzOkLc3vaeIi4IdtQet/BId8q7b
         /KAZep43yKOrPLJu8a2GnoS5VPDVjzhdv8BY/ZEZb+DKKDUAgeOpBrs7S+8aREX6Np77
         fFmAn5OPgBoTKfUXkFqfb7wTZJfo8lXqm/+nYqx3vFwKXbPm2Be5dwrESELZY8eGOZmy
         VVrJfCEBSpQD3L/xIKZyUWip6KfO97pyTCYyYWS4z1uGoiPqFaHnyF9ymK/8782pe086
         OaXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/8BylbGalzGrE/aYiP0aFX/AZnbs5Ex8F/epNxq5uCo=;
        fh=v9TgVopmirtVxzBa1yLvcXVKn2txmPH3BNZXB0pAYqg=;
        b=LFnBXPidKlf9kMJrKmNvADXZ5pccDy38Cx3+ygL6xIkySZrNIL3DqqLioFNuCZElB+
         cyA81HCDcCxrfQQDnRS2XqtcKZFLqveVoPVwTCXnV3kAanwsX+cANfT3SMqG8Qjr0foF
         DlviW+R7mjcMfdgHgDT7dMWgrgaqa6f157zOAbG3j2OmvrWrd42oukgx+KnIGg6LlgHT
         n1EBY4y8qfoaQklkovXtBJeDALnX3pXs0A6r5+gudXAgJb4V5GOwA55k/RltoSzqtA+8
         tLBGdCmDZ7IqsNAUE9rhYxIof1yDpyM0onGDmJy29z7ZO3+/MSze6vUdziTOgMGkVZNi
         cA7g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1783029929; x=1783634729; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/8BylbGalzGrE/aYiP0aFX/AZnbs5Ex8F/epNxq5uCo=;
        b=DgmFRc5xHXpUgqHCsug2QPS5w4P80SUMvB3ZtgIaZSr+PzJRHfMt1nx2v2+hWwbCmo
         N2bLAmFKhQp86Lusr54deFffNpdxbhnpq391froiRrrGyhKFOZxQ63aeshTNmPPnN9GC
         eNsds/oxXv1S0DfxRBvpiLbMHUPvwLSYXBhP2+nI+pRY0EYCADiX2kn79n4A6I6KxgDZ
         7M2fVjmqeMu7SxHNXb6gQQ5/7eJaGpKT+v2Yf149I4Whxv/LNhaOAtjcr1Ps9EzVE9Bt
         YsHm7OMnOlI7YPVMHk7eireaNnIeWT+ybHsNK63SeuTv7yjTKMWd5sRQDerTyo5phIkK
         H+pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783029929; x=1783634729;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/8BylbGalzGrE/aYiP0aFX/AZnbs5Ex8F/epNxq5uCo=;
        b=FWXJLbIfFAliltRrPLjvrXD2xxMOuqQWVG1UYhGY/O0ScdPcLY+jc8jWq5g0Ajh9Ng
         UZEV0GsZbQvPrxqphvJvTeZXjY/ST3tBKFWYjEfcoTHkIQMgeWJUJ/eHKsVPaV68adWD
         OM+zlqqip/Eh6bd7la4GRN3vWk3BGVIr3jdMKN6tPueWBldH7tND4vrGYPACKRSS9U8T
         CMzdhdNnZ9WjB+tg7YIb3UA/VlK4PDrx22mttLIC3devLzmu9MokyDaLVfCZCGQ4nmMv
         25W6WK7DYuCs1w4ZLZZsc90PIdANJkrLkh5XazOAIGX1fobOSOPJMf/xMbarPi1jr9E7
         MYGw==
X-Forwarded-Encrypted: i=1; AFNElJ//FzpP0gfhH2MMrCT6eosUtsmdAPXjtCICQyY9Zx6oigwX6pvIGMFKl/cckxgBOnl6mhM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrcJrLDPZuo3LpVJigRaE9q5gwymu1VbLlf1koxEYJyw6k+rfe
	sp3jKs2FnyLPmrDOHKZ2WjzPf9S3oVYB9uq/OKOxTIfdqziMOgQ+C2IIVadWeMJCVQVRTKHEirp
	UrTwfkNk6wBrrLK+MAPe/RjvrrEOVycW7gQnqmlvZ
X-Gm-Gg: AfdE7cm+ExmoCbwlcoj1HUCtLnr9owBe8ukLOABCMm5+qePp81QpVmYXTmd2qGQ8g+V
	fwL8o6qvD/vr7oo3r73xwvqQ3UwoGxQjr/QbMBVeOiUZTayYZoKRUv/TINkoYEIpd9Rbn3T8szJ
	Bq6GDZLG9FEcX74tkJJUAF3Cz7dQ+0w62gK4YJJ0G+pf8NOCjLjXI0DgRZq6WkI4oYuN8B4vVI9
	chPO9GCv9XqTVHZVA0MjQymu+mI+4UkRiJbHcMz1IKq+C3Dsieaf9C2oYoZc9hQ0o/SKoIJ
X-Received: by 2002:a05:6300:2211:b0:3bf:ba2a:6a8e with SMTP id
 adf61e73a8af0-3bfed1f7000mr8977414637.21.1783029929236; Thu, 02 Jul 2026
 15:05:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260702143605.252797-1-daniel@iogearbox.net> <20260702143605.252797-3-daniel@iogearbox.net>
In-Reply-To: <20260702143605.252797-3-daniel@iogearbox.net>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 2 Jul 2026 18:05:17 -0400
X-Gm-Features: AVVi8CcgHlbLJBJKhpshKVmWNVeIUgi3gl9hCKKqGwCDey9KQz69ULWdnY7SM0E
Message-ID: <CAHC9VhQD4RHsGiTMVCCTN+eB71-Ueopke8XghExpNJ2PSNa_jQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 2/6] bpf: Verify signed loader metadata at
 load time
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: ast@kernel.org, kpsingh@kernel.org, James.Bottomley@hansenpartnership.com, 
	bboscaccy@linux.microsoft.com, memxor@gmail.com, 
	torvalds@linux-foundation.org, a.s.protopopov@gmail.com, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 2, 2026 at 10:36=E2=80=AFAM Daniel Borkmann <daniel@iogearbox.n=
et> wrote:
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

While you've documented some of the objections from the LSM side,
you've missed the largest objection to the existing BPF signing
scheme: KP's scheme runs the PKCS7 signature over the lskel loader,
while the scheme that Blaise proposed (in multiple forms, not just
Hornet), runs the PKCS7 signature over both the lskel loader and the
associated maps, just as you are doing in this patchset.  Moving
towards a scheme where the PKCS7 signature encompasses both the lskel
loader and the maps is a good thing, I'm happy to see that.  However,
I do have other issues with this patch that I've mentioned previously
(more below).

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
>  kernel/bpf/syscall.c         |  76 +--------------
>  kernel/bpf/verifier.c        | 175 +++++++++++++++++++++++++++++++++++
>  3 files changed, 178 insertions(+), 74 deletions(-)

...

> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 6db306d23b47..e898fad01aaf 100644
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

As I mentioned previously, the security_bpf_prog_load() hook should
not be moved.  Its placement was deliberate, and moving it as you've
done in this patch creates a security regression.  Without this patch,
for processes where SELinux is preventing BPF programs from being
loaded, it is able to do so before the process allocates a potentially
very large chunk of kernel memory, up to one million BPF instructions.
With this patch, even in cases where SELinux will prevent the BPF
program load operation, it is not able to do so before the process
triggers a potential sizable memory allocation, opening the door for a
local DoS attack.

In an effort to work with you on this, I did bring up two alternative
solutions: a new LSM hook for the signature verification, or the use
of the existing security_bpf_prog() hook.  The latter option is
conceptually less clean than the former, but it should still work to
control access to the BPF program based on the signature results.
You've mentioned that you are not in favor of adding a new hook, but
you have ignored the other potential solution of using the
security_bpf_prog() hook.

You can (re)read my earlier comments at the lore link below:
https://lore.kernel.org/linux-security-module/CAHC9VhTtaT_8AXSfNKiq4cGq7T=
=3D6Dh=3DhuM8niBCwOP8kj+ugjQ@mail.gmail.com/

While I don't like to do this, you haven't given me much of a choice;
the security regression can not be ignored:

 Nacked-by: Paul Moore (don't move bpf_prog_load LSM hook) <paul@paul-moore=
.com>

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 44bb6ce17a1c..1609053a0eeb 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -19901,11 +20060,27 @@ int bpf_check(struct bpf_prog **prog, union bpf=
_attr *attr, bpfptr_t uattr,
>         ret =3D bpf_vlog_init(&env->log, attr_log->level, attr_log->ubuf,=
 attr_log->size);
>         if (ret)
>                 goto err_unlock;
> +       if (env->signature) {
> +               ret =3D bpf_prog_calc_tag(env->prog);
> +               if (ret < 0)
> +                       goto skip_full_check;
> +       }
>
>         ret =3D process_fd_array(env, attr, uattr);
>         if (ret)
>                 goto skip_full_check;
>
> +       if (env->signature) {
> +               ret =3D bpf_prog_verify_signature(env, attr, uattr.is_ker=
nel);
> +               if (ret)
> +                       goto skip_full_check;
> +       }
> +
> +       ret =3D security_bpf_prog_load(env->prog, attr, env->prog->aux->t=
oken,
> +                                    uattr.is_kernel);
> +       if (ret)
> +               goto skip_full_check;
> +
>         mark_verifier_state_clean(env);
>
>         if (IS_ERR(btf_vmlinux)) {
> --
> 2.43.0

--=20
paul-moore.com
