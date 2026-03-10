Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA22128371
	for <bpf@vger.kernel.org>; Tue, 10 Mar 2026 22:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773182904; cv=pass; b=fbfHrf2lxjYdsG9m8Qy60p94DCcFsDb30CcEpCEYOrbQVksND80h5koSpdSlJjPdu+7tyfbo/ujM3szqieeD8UjdP5FqzPPXysyaCcmbbKMJsV/cpPy1JmiRQSSYaVbbTQE/oqjcDCtWLfkA71eNGW9VqR4wh6wwv/J2UD32vIQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773182904; c=relaxed/simple;
	bh=WwtdAwQ7gqWFLmOPUk2WCnuC7PyBz9HhCSLXNljii10=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HHbW+EwVdDBoCFlBgXeRf1lch10PuMkCHZOxjrssIpOSZ3Co50Ot9mgipTY/kkAEurTiiH5rXsG6AL+mU2SsHiWHRjqVKm/S5Xc2fOAKOaq9g9xAm+NHwTJRw2cM5UpPIQ6uanQoMhkaM5z2TUek1U843xrf/UnZHidUq2xoWMo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bJj0B8o7; arc=pass smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bJj0B8o7"
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-485345e1013so2814315e9.1
        for <bpf@vger.kernel.org>; Tue, 10 Mar 2026 15:48:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773182901; cv=none;
        d=google.com; s=arc-20240605;
        b=FAVpXBcIZtkf4ixZTv5aTic5yiQ6mNJ3EfhsG05VqzSORKi6xpD1ZYqbK7lguNJgGF
         1tou3B1dAJ4PsLvbm4eEaz1O2XQJ96zLZJ52Sndtd0k7R9AkFgkWeBCwpQgGexBb1pST
         GEQC2df1nmKwNox2anXh2rSSBNpwv7LTrwkmJKZVuukWWnxLUXX7wWWpP2DD27hmJzgj
         Qlg/b8K53P1z4sL4ZhkHILdzWEMdKkX0ZGiE9/P1OLDM7DbcocLNb6IuR8PvcJSm/m0I
         RMfWeTkyneeZ5712GSZrZpOxtvQyhKnn2WgnBgPejFef3Lxiq/9jTQ5jfKvtCJQGpFsm
         57VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HATsBqTWzcxHFOSfOFEmRyZEc14mPmH0WWHY0ngJMrM=;
        fh=Etk1pA/dKDkoa/euC9An6NfcaLM8x+njq5t1S48lmrU=;
        b=XYwXm/MUwxkQVu0l+l89iCCS8gIm0puLm2+pB4V3gyyKsYeIskbhzuNFbUWB5uVS5e
         2uA/BqKMY21rSYC1di7Fv7jXr98US4S0XURkbJeBRUVlFL1mD3aW+RHeit6msKft6Ne5
         u1fqgcT1ETseEgHSJoiYjyTKuqpHq4TuNK8A9q27bZIVilMlngcxDK6fD0Rgpkygani1
         QCa/CfAxpEGDC8URnOLBnSJoPnXLu+nS2xN6cNounn60rU54sH2VG2cEcZkP8Z8GLWf1
         ZEz03F6iDIFUC/XAdFPFMwDoFRyzK0BXbihlhBBlk5xNIKY50WxzYG3IhUoerFTR+Dgv
         hiZA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773182901; x=1773787701; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HATsBqTWzcxHFOSfOFEmRyZEc14mPmH0WWHY0ngJMrM=;
        b=bJj0B8o7h9KRGPHSue2EKzSJXdFjy0uqxmbUP9FEo1ytW+ttX4lp00QsZJwWieKbmF
         dtMlm13ZGwwymiaQcNC0+zrugMzUYVi2dXk19kJMvfE5Hx64PcisRq0FQl1gGQZQ8D8n
         bL1P7KrjN5OvmZxCJFiVMNxuE/gB8kA9gJsVyX1FNZQV5PC293CJRRuDWB2wc01cb60/
         2bNY3WhG0rzHd9I0NCiE90ehbJEuipusvPBIoRMwx35SpW/B/hxB3bWIxZZB1fb6FPG6
         1OCHnHl42+xhdLzyjb5MFa6OwRPZtdvYo5gU6P3wE/ys9HcjtQK/Tnmd0p6pn2MiCPsb
         ffjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773182901; x=1773787701;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HATsBqTWzcxHFOSfOFEmRyZEc14mPmH0WWHY0ngJMrM=;
        b=Y4WfchwrT3Kokil9vhdO3PicCBXRs0GGJw4E7/+HxMRrRkxZne6GhwUGEEU6go+yf9
         41wMmZarJWM5PYrCOdwEKyw4TCswwrxuNxSdfbaJ7WGTBERLBeUmq8j8mcE402VhvwAq
         tzyk3jtUA523rcSo3+TI2O65JH40/Rj+ajsGqdVugj1Nlm9uL+YxpZBW5k7eJv5BBK3k
         yGdIS+VmIh0HKjdN1GyD+YreAHgzIrpFNIdnvCXu7Gcoauqmiyir26gtM3JtZHXyzzm7
         8ZKZWCN+ws1bATyCsF05iLp8edyHmEvAcacToNqx8MyD92/CPFeUWM2Nh3bf2ehhMKCV
         dnew==
X-Forwarded-Encrypted: i=1; AJvYcCUeLV6B00NhLgZ2Jh106pC5tC/aSHatqJbQpVuVlfZ9BF3aBKkBbQ8mWPcTFFwbJ3hD0MY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxI3e0kaHczDN/hZFYdkn36dsQ6tNPwF9bPY1KH7Z+RpHlUmKXI
	wCCJkWW1Szm95zw2o85xjaq+WlJU/aFjduzJca7/mub+Z6H7S23B7HLvKE/RZGAw85z0FFPGwsG
	UpG4P+wBiA7EbTsXvgEZo9df4BzeFl1c=
X-Gm-Gg: ATEYQzynynPH9mI+1lT3Tf0t/Juu5WCl08m213y7eqyU4QMUjchEzbqx84Im+jTxrr5
	YSiy5EYmodLw2TWYXikzdgb/hEXTVN/9yrvpuxxjXrhcxE+ckclNyiJNfoOY9QlpPCSatwkSQkH
	WvY7Nbt5OyXOfZUp23To4nc9Tls19M3dJZEz+JOipRIh83mnwLzZosOVw8HymenAX0RjHrfeOve
	mvU82+weCKHcxHCb6Dt4j+C1YMVNG592OB9ChQE3OY+ugyNdjkf9Xy9bu2/fJvzPgbZu+12n+JB
	9r1+3FlEBlYpW4gqYzD1WD9G2s28YSiS4N34yzWrFh7i0+A2PDngS5ZPlZwg
X-Received: by 2002:a05:6000:2405:b0:439:b69b:3c8d with SMTP id
 ffacd0b85a97d-439f8be1725mr712117f8f.13.1773182900931; Tue, 10 Mar 2026
 15:48:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1773170190.git.grbell@redhat.com> <a46d40ac2b56f96b3b6e953847ad4719694d68eb.1773170190.git.grbell@redhat.com>
 <CAP01T75MFfp8oBrogRvm+BRh7=fvm9pP0vTvNm=RW3r3=WDB7g@mail.gmail.com> <CAMB2axPT8L60FGN5wben-pa73toOwLcD8cuGqbNUg6AB57ePYg@mail.gmail.com>
In-Reply-To: <CAMB2axPT8L60FGN5wben-pa73toOwLcD8cuGqbNUg6AB57ePYg@mail.gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Tue, 10 Mar 2026 23:47:44 +0100
X-Gm-Features: AaiRm52ZgrlcpP4TxCGkbPR6r-HWn1UhEHcrQybJ-jsnivE5Z4DCvrhJm6Xnvds
Message-ID: <CAP01T76cPcToNwu_NMFU6QDO8qZB+n9WA0_qxSzrasZV-=G-Qw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/1] bpf: Fix BTF module cleanup race condition
 in struct_ops
To: Amery Hung <ameryhung@gmail.com>
Cc: Gregory Bell <grbell@redhat.com>, bpf@vger.kernel.org, martin.lau@linux.dev, 
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, 
	song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 10 Mar 2026 at 23:38, Amery Hung <ameryhung@gmail.com> wrote:
>
> On Tue, Mar 10, 2026 at 2:41=E2=80=AFPM Kumar Kartikeya Dwivedi
> <memxor@gmail.com> wrote:
> >
> > On Tue, 10 Mar 2026 at 21:21, Gregory Bell <grbell@redhat.com> wrote:
> > >
> > > When running BPF struct_ops tests consecutively, the second test fail=
s
> > > because BTF object references take longer to be released while their
> > > associated module is removed from btf_modules list immediately
> > > during module unload. This creates a race condition where the second
> > > test retrieves the cached BTF object but cannot find valid module
> > > information, causing btf_try_get_module() to return NULL.
> > >
> > > Fix this by modifying MODULE_STATE_GOING handling to wait for
> > > active BTF references to be released before completing module
> > > cleanup. This ensures BTF objects are properly cleaned up from the
> > > cache before their module metadata is removed, eliminating the timing
> > > window that caused the race condition.
> > >
> > > Signed-off-by: Gregory Bell <grbell@redhat.com>
> > > ---
> > >  kernel/bpf/btf.c | 7 ++++++-
> > >  1 file changed, 6 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> > > index 09fcbb125155..81c9f46a7bb7 100644
> > > --- a/kernel/bpf/btf.c
> > > +++ b/kernel/bpf/btf.c
> > > @@ -8382,7 +8382,12 @@ static int btf_module_notify(struct notifier_b=
lock *nb, unsigned long op,
> > >                 list_for_each_entry_safe(btf_mod, tmp, &btf_modules, =
list) {
> > >                         if (btf_mod->module !=3D module)
> > >                                 continue;
> > > -
> > > +                       unsigned int timeout =3D 1000;
> > > +                       while (refcount_read(&btf_mod->btf->refcnt) >=
 1
> > > +                       && timeout > 0 ) {
> > > +                               msleep(1);
> > > +                               timeout--;
> > > +                       }
> >
> > This isn't the right way to address such issues. Your diagnosis is
> > correct but fix is just papering over real problems.
>
> Second that the fix is not right.
>
> >
> > The better way would be to block the discovery of such BTFs once the
> > module is unloaded.
> > I.e. once we return to userspace after module unload, subsequent calls
> > to obtain an fd for such BTFs should not succeed.
> > If someone is racing to look it up while the unload happens, so be it,
> > they will fail anyway.
> >
> > I would use a bool flag in struct btf, set it inside the critical
> > section at this point with WRITE_ONCE, then test it early in
> > bpf_find_btf_id and bpf_core_find_cands with || in !btf_is_module
> > condition.
> > Using READ_ONCE of course.
> > Also, we need to add it to btf_get_fd_by_id, so that once conversions
> > from stale IDs to FDs don't succeed.
> > Looking at load_module_btfs(), it already handles the ENOENT case when
> > id lookup succeeds, but fd lookup fails.
> > So for stale ids it should just skip over their errors if we return
> > the same ENOENT as the refcount_inc_not_zero case.
> > We will still report stale ids, but not allow their conversion.
> > We could filter id lookup too but it will penalize the common code and
> > we need extra radix tree lookup just for BTF case.
> >
> > For me locally, these changes seem to address the problem. I could
> > send the fix, but if you would like to take a stab at the above
> > change, please go ahead.
> >
>
> I guess this is worth a fix because it makes btf_get_fd_by_id() less
> likely to return to stale id. However, there is still a small window
> between btf_get_fd_by_id() and btf_try_get_module() so struct_ops map
> creation can still fail.

That's fine, it means that module unload is happening in parallel, so
it's racy and non-deterministic anyway.
When the user controls the module unload though, they should not be
getting stale BTF fds once module unload has returned to user space.
At that point all associated artifacts shouldn't be discoverable.

>
> As for the solution, there already is btf_mod->flags. So maybe instead
> of adding a bool, just test the flag?

You mean struct btf instead of btf_mod? I don't see the flags field there.
The btf_mod->flags won't work, it's already deleted and freed by this
time, and requires us to go first from the BTF to the btf_mod.
So it has to be in struct btf.


>
> >
> >
> > >                         list_del(&btf_mod->list);
> > >                         if (btf_mod->sysfs_attr)
> > >                                 sysfs_remove_bin_file(btf_kobj, btf_m=
od->sysfs_attr);
> > > --
> > > 2.52.0
> > >
> > >
> >
