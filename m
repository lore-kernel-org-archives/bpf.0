Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6399331EBC
	for <bpf@vger.kernel.org>; Wed, 24 Jun 2026 18:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782326558; cv=pass; b=thF5RN/Mqcm9zlw51CtJIqF4PRxCEYTDDaiMG/Yn3Dgy7MbG1Xv3jWdDRkg5p0HpN5mffzAa4fzTXkBJ/+B68HHKCQJj5OnC7a2biy5LuN4UrciYjscY749RU/OrWkBjfn0Fdrje4416AKjKw90DqNA04/Jz+kRX25jNKEbxC4w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782326558; c=relaxed/simple;
	bh=PsUg4uC/wyz5+OzrTgGXCpBTf91PDcDV1VUDtXNnlKM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RGHbNqVUEfXM5wb71QQagSq5ubU3VqoY4NchZYVMqho4VvHBUPhlYBWKGSiQZGOOJXaoPRtLYnEmp/ywZqwjv13f54aw6+2mLBRRh6TgnAYaclJ59s+FkzTrX4YkVExm3z1rsS5f3GYshOTX728byPFqi3nCJ1UxwZgyAf1/qJ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=gjN365O6; arc=pass smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="gjN365O6"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-37ce68a54f8so1131079a91.0
        for <bpf@vger.kernel.org>; Wed, 24 Jun 2026 11:42:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782326556; cv=none;
        d=google.com; s=arc-20240605;
        b=M9URz36K9XY4y07z2KnWXexsOzM6l4FQQq5tdHkvWSGQfQtQ3MCpqdKMPwsuBaStS4
         f7sZAD0uC8lzZizy0knBy9wdIolAJqKFBPvO4vGm0xxMf7AvwfcAzePl2h2GvPI5B6aO
         LoWoKWiNvXR3U0/CG/w2qirT+yu+rJ9lJ5uAy0bo0EuavvjsaaHA2UMYFBqbKqbk8Z2C
         CRvEKNiQf8CmiBOTDnBxE8Mk5RhEW3ZLJ6SAy9Vq0o+goNBqiQWwpRa87iSa2VnvNrY8
         Oct2bO4W4AEnkeNtHxtRuTBMIPX5/vq9NE2uhjQ7E7yMpC1DHt1ZPacSL5gLUiR5kAMv
         TChw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EhtPGe1fQIj+dTbS/uj+ZYpI6PapyTZIuf9fBO08h7M=;
        fh=JwkXji8OyGduU+Sp/SZ41psjg+oG00wcK/oqwhoNOdc=;
        b=boH35+cOr2ha+nWEnNyO8MKv2e7RaleDHkS9+Fx6Zqoyzs/G3oLcIa84ui6oiCpGrP
         KHVnO8ywdC+Qpum+WGjtAeJchsZKubIQzfdiPaApwD4LAFJ4oIx+WFIlN1pg7k1OD+5x
         gVkYfqrQqgsH/KxRXGj9Mwb3WY5C5gjVJQ3q6DGaONs44eJXt/I1tvmWMRpAYXIKtH2Z
         /NkwUYeMjgEItm6xLUdgzK/vk8fxdO3v88O3Hrmdh3KSJzyKqrkiFa7fI3/veXq287dS
         n8HinAXkNNSHsEXe1/5stlHt6zBkuZ31NVpZuJxH0+CaUOdIzDRkmOx7hi41NqCuJCcp
         Cu4w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1782326556; x=1782931356; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EhtPGe1fQIj+dTbS/uj+ZYpI6PapyTZIuf9fBO08h7M=;
        b=gjN365O6j3CiZczrHvrN/KUaOdlnAJYGKXUr2oHmsNYpJFtW1ZefusKsvu0+K0GLhP
         JaVsBEPMSl9fB31TUdRKbmBUHGytqTlAT3C6NWERFOlqvHQZVttQTOgdYM5IWst/FvLE
         5uwjYf3Ca53GhyjQm8HezQG5TlpQDf9brdT5BN7iW9OPRnYDZALb+RCIiF5Yqt7NbHSA
         p+Oxt9TKd94T4zQF13KSO07rm6sRwWf8wFnyeqQlMFR9xU2gxy1qLFkR+2IcQmLCiqiM
         p5iZm0yPMrjSBgRr50vZRqgn8l+b67K8k1bEOPmailsXujs9/gyH4FZdglrnoCoStTeD
         HiYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782326556; x=1782931356;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EhtPGe1fQIj+dTbS/uj+ZYpI6PapyTZIuf9fBO08h7M=;
        b=rjWMvtQdZvd6p+MsL/uCD7tqnQBncDJTUyjLXgHix0qmju7V3eXMmStPNk3lFOgPf6
         FNMfOMmyBiMY4Kph57NvS1A8l4Y9tX62Q0McgzqU0TEa9W6DLFdRpAdbRD6LQiXh+c96
         HJxA38xLlUqnm/DbgXq7dg/8b4fjKWbrIHIB5yudahscx+mpzNi3tvDFJNTbQgNY6k0O
         /H9Q6AXd1uvxDsYtF9hF00G4ABU5WN1xzQ4ubmSsBZdwnvVVaM7t1+eUc9SmTQ5Yt1yl
         WGSsW5cpPfMeZ3jbTT66rzmBA3kGdDtzJgWjFS19f7CUOFvTJ0asCfkzGa6etNqleKkB
         NHUA==
X-Forwarded-Encrypted: i=1; AHgh+RothXG0lviXPLkXUa1q2Rax5A0imFfD/TP8oIGwXTtB9ropEKkBIxINNOp+gtQs1T8ZnnU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfWloZbGYx36ThtfxlEdR48gi/egkonhiZGHZ8482QCqsa8Gua
	7R6tCVX+IcqPWNIuFkuraL3fjQx2v9MDpRn72pi3FVwJfZ6A88Za+m1SLx19cxyyJaC3A1YTHyc
	H49CmblBRoJioLPpFS+SbtZKmj4LB/WmPyoDA1zsu
X-Gm-Gg: AfdE7cmxUwaL/ahJ3YtUqyD+8kbOUN2kbN1Q+vCYoByCVGor2EbVjZRwhzLNwWCZ4Bb
	xoW8BMk++IJ3xNGi7JXN7s/c1uUOJToVX2VdVqztXmHIBRGWEgCuRZpd7z2xoA6shjNFCxhnLRN
	oesdefCTJy7D3xB/BvQj+2wi5V0PzartowWan24YAkrj+DreIQVxHj4ANmi6N6Hitu7dAqSqGyq
	TDUWOnoYo2Axdi7LP8edWOZzMu3pd8qahf37faKVlpxmn1zx0zl8dvsDT5pRuAuOg2vi/FE
X-Received: by 2002:a17:90b:1807:b0:35b:9894:f6f9 with SMTP id
 98e67ed59e1d1-37dd0dd1110mr10343576a91.18.1782326555869; Wed, 24 Jun 2026
 11:42:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260624140301.93421-1-daniel@iogearbox.net> <20260624140301.93421-2-daniel@iogearbox.net>
 <CAHC9VhRar1x7kyjhgdmJ=Mfz4Msarv=wQ1821v723CaVdk1uTA@mail.gmail.com> <603d0f6f-bf02-48ec-af90-f16a239bad85@iogearbox.net>
In-Reply-To: <603d0f6f-bf02-48ec-af90-f16a239bad85@iogearbox.net>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 24 Jun 2026 14:42:23 -0400
X-Gm-Features: AVVi8CfjPQkADRUQ0uU9dicbj-tSuGC4ZlBnhMVmSksuabP2UbQh_BF41ZPMx94
Message-ID: <CAHC9VhTF6_VaSm0uOjW1eV05CvsaaL+2jimVuPTXHeLGEQcMPg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/5] bpf: Verify signed loader metadata at
 load time
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: ast@kernel.org, kpsingh@kernel.org, James.Bottomley@hansenpartnership.com, 
	bboscaccy@linux.microsoft.com, memxor@gmail.com, 
	torvalds@linux-foundation.org, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 24, 2026 at 11:37=E2=80=AFAM Daniel Borkmann <daniel@iogearbox.=
net> wrote:
> On 6/24/26 5:12 PM, Paul Moore wrote:
> > On Wed, Jun 24, 2026 at 10:03=E2=80=AFAM Daniel Borkmann <daniel@iogear=
box.net> wrote:
> [...]
> >>   include/linux/bpf_verifier.h |   1 +
> >>   kernel/bpf/syscall.c         |  76 +---------------
> >>   kernel/bpf/verifier.c        | 163 +++++++++++++++++++++++++++++++++=
+-
> >>   3 files changed, 165 insertions(+), 75 deletions(-)
> >
> > ...
> >
> >> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> >> index b44106c8ea75..026b61d78bdb 100644
> >> --- a/kernel/bpf/syscall.c
> >> +++ b/kernel/bpf/syscall.c
> >> @@ -3189,10 +3121,6 @@ static int bpf_prog_load(union bpf_attr *attr, =
bpfptr_t uattr, struct bpf_log_at
> >>          if (err < 0)
> >>                  goto free_prog;
> >>
> >> -       err =3D security_bpf_prog_load(prog, attr, token, uattr.is_ker=
nel);
> >> -       if (err)
> >> -               goto free_prog;
> >> -
> >>          /* run eBPF verifier */
> >>          err =3D bpf_check(&prog, attr, uattr, attr_log);
> >>          if (err < 0)
> >
> > We must preserve the existing location of the call into the
> > security_bpf_prog_load() hook as some users rely on this hook being
> > called *before* the verifier runs.
>
> Keep in mind that the verifier /at this point/ of the new location did
> _not_ verify anything. So there is no heavy-duty work happening yet at
> security_bpf_prog_load. The work that is done before security_bpf_prog_lo=
ad
> is basically setting up the env, initializing the verifier log, and doing
> the process_fd_array which is resolving the map/BTF objects. But it did
> not walk any instructions etc, so semantics of the security_bpf_prog_load
> hook did not change from a user PoV.

There is still a reasonable amount of work between the existing and
new call sites, and the existing location outside of bpf_check()
offers an additional robustness benefit that future verifier changes
are less likely to impact the hook.  If I'm completely honest, I also
need to consider the events of the past year and a half; I'm now much
less inclined to support LSM hook changes in the BPF subsystem because
I'm very concerned about our ability to revert/modify those changes in
the future if needed.  That doesn't mean I won't support LSM hook
changes in BPF, but such changes are going to need to have a *very*
strong advantage from a LSM perspective to offset the risk associated
with the current BPF subsystem.

Based on what I see in this patchset, the security_bpf_prog_load()
call should remain in the current location.  If you need an additional
hook after the bpf_prog_verify_signature() call I'm happy to work with
you on that.

I also have to bring up the same question I asked back in your v1
posting: have you discussed this signature approach with Alexei?  Your
patches abandon and remove KP's signature scheme in favor of what is
effectively Blaise's signature scheme from last fall; Alexei argued
very strongly against these changes in the past.  I'd hate to spend a
lot more time reviewing and discussing patches that Alexei is simply
going to NACK once again.

> >> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> >> index 2abc79dbf281..9cd2b62da380 100644
> >> --- a/kernel/bpf/verifier.c
> >> +++ b/kernel/bpf/verifier.c
> >> @@ -19758,11 +19895,28 @@ int bpf_check(struct bpf_prog **prog, union =
bpf_attr *attr, bpfptr_t uattr,
> >>          ret =3D bpf_vlog_init(&env->log, attr_log->level, attr_log->u=
buf, attr_log->size);
> >>          if (ret)
> >>                  goto err_unlock;
> >> +       if (env->check_signature) {
> >> +               ret =3D bpf_prog_calc_tag(env->prog);
> >> +               if (ret < 0)
> >> +                       goto skip_full_check;
> >> +       }
> >>
> >>          ret =3D process_fd_array(env, attr, uattr);
> >>          if (ret)
> >>                  goto skip_full_check;
> >>
> >> +       if (env->check_signature) {
> >> +               ret =3D bpf_prog_verify_signature(env, attr, uattr.is_=
kernel);
> >> +               if (ret)
> >> +                       goto skip_full_check;
> >> +               signed_map_cnt =3D env->used_map_cnt;
> >> +       }
> >> +
> >> +       ret =3D security_bpf_prog_load(env->prog, attr, env->prog->aux=
->token,
> >> +                                    uattr.is_kernel);
> >> +       if (ret)
> >> +               goto skip_full_check;
> >
> > We can always create a new LSM hook for this call site, e.g.
> > security_bpf_prog_verify_signature(...).
> >
> >>          mark_verifier_state_clean(env);
> >>
> >>          if (IS_ERR(btf_vmlinux)) {

--=20
paul-moore.com
