Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A46BD224B05
	for <bpf@vger.kernel.org>; Sat, 12 Sep 2026 03:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789184248; cv=none; b=lEkcAJSP6VrIk3hbXsKYsNWWbp/xzVclkxFnQrTN4LbGgWyC90CAVlybCoKgJgWpZ8iLf+hBgHaKAMHvEYBMzD3cF3TEKqMwvYl5EuYdhWGKYLAQ0GNPGeEk7oGIYB7oqwKrhBfjz+i0V0SZlu2BWLYfH05gR4zb25oNFaYfUKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789184248; c=relaxed/simple;
	bh=FAr9tReetHGiitE150pNp7pPIhm3hZefJKyWwDq8/JI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=aQMPNNMpu8jPP52t0Nu8XY8MIYc0oHac7XUADJniU0mxbdbcnKxAgvTn2TWfqNs9NsCoX41dno+u/kSG+dMxOoN9o0bvNDFQuUcxl4XXURXgThIKzX6yCpqzP58kPu8oETiHja6VRpToj2N8QVYx1x7Y6jn8hpcB6BrDOuyomts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R7zubTUV; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R7zubTUV"
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-46ac530b9ebso1129428fac.0
        for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 20:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789184245; x=1789789045; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=WmrWSnWNyTTCpi7ZqrIB5/x7yhuTuUn6rcorAMZT4zU=;
        b=R7zubTUVdyC4D3UkHl5hK/3v8ofG/SuEdRJVCoHWQK9YL7PpNIc6Pn2gXIUX58dOip
         oiBG3AlwYZCSMC6Os1E6PfwR0GqLVhRg6vvqxyk0eTx+TKKacyBP0WjQvht7sXdE74cv
         XbBV1estltTApxw1eU53LoZMGbVztlFv7eS2chE/alDEA4D3ePaNvm5nDzn54mHaGDwt
         v1NSCrI4lZeey83QqwL9HDqcQIwLXkz+aQM2YINixBsYhXmQJgzd58lrkFvPo7AwocBn
         NJI9AfGBA38M30UqolHMmSLQKRPa60138Hp+t4UCq+PZanbdDUDHLPydS/T2AU2f/x8T
         H4aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789184245; x=1789789045;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WmrWSnWNyTTCpi7ZqrIB5/x7yhuTuUn6rcorAMZT4zU=;
        b=RF5qhITQix8ZROk8ol/PTjj/8tS7NmIZXVwCdsTlhXBvTCSNeLQfhR8lL2hfZr6FXt
         2877Uad6BD12bZu5CQwKtdvVnNHVV3iQdKlcP7zg0HRNEIvUg+6b8qPaWND540SM2TgP
         cSdca/lXjXh9sToMV96577rQrvdbpH5b+5anFiK+IGV7pgWyUSrHBqWOny6pIZHZq4PZ
         5JijpBPSIQHeq6Z/aEgzJ5sKeDuSGimWquej2HdcG7QX0ir04Sd7R7/3SzZTW/meHUWV
         Qybc6Jq2HTu0fL/kxIWSymOapZdKjFRZfyMMoz8po7fIwClh0xota+35KBRGm4TgZsrW
         ABXQ==
X-Forwarded-Encrypted: i=1; AKwUvBw/vIAZLNZSoW9xUeuao2H4qrB+qitxBeb8aPHa6Jnct1tC7TdRznUE0oKT0DFLw5m2aOo=@vger.kernel.org
X-Gm-Message-State: AFuF++mOdgg66mQMkbKSYex9YcukUtQpEWEtZ53xj2zuz3QYWP2WRhtR
	sV+HuIAMy6gZMQDnh/FvlIfn8p0n5RHt5c3qMqojzIn1y5KS4hoqtjPz
X-Gm-Gg: AYBFou3lNRCQIAUhhpfTBm5xgEKpGI4f417ANeKz0CJFIJE8tC+cbf9j/4CCcOnz0+T
	6ATSXuuAU3RkiElKZXI+am2qQ1ZSZgnSmH4sZJqupdXAn2p9hcO/3nYMOEH/yu3gwqQrcWOdWKi
	hohZvuBiiIrwSeGJoma240QmaIV+cVTxvPezEiLCHXXIiS0sdjrZoqqXEFzQzfIWmJA+rhKggK7
	8pLs1ZF+b8pw0KryW+0PK7VhuX10q5k5eHsbwTpwFaoluiJZgR+ivuZevcecSJv+MkLY5gCA3HL
	cxofGrXmMqfQXOhTbsiL2PtZuW9hU2NHIndjslb8Rj+7vYhL+Q8PfhEVjYu87D0DETSxRj8hZiO
	euQBL3XjSaC9yOiRy23Bmql4m/DObag7U38vrq4V7Cpi4BMs9LxeR9z+QcRJZYe5YTWHQUN8QXA
	qW3xyLizCdwp+IukKzzcKCyr390RmgbEOcYlembVy8mrxooyT+zaHWorJt/x+Yki7UyVdXvHxK8
	UKJXPw9TQuf68p3F/RwkkFM0BmkPA53fC2nFn7kOWBZQwN3MEMKKXIV5W4T/MaQcA==
X-Received: by 2002:a05:6870:5d95:b0:467:e082:b93c with SMTP id 586e51a60fabf-47c970414cemr6741625fac.2.1789184245328;
        Fri, 11 Sep 2026 20:37:25 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:42::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-47df8bd0278sm3471827fac.7.2026.09.11.20.37.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Sep 2026 20:37:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 11 Sep 2026 20:37:22 -0700
Message-Id: <DLD0VQ3D8CYC.3V5ZT8HDMY4IH@gmail.com>
Cc: <ast@kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
 <kpsingh@kernel.org>, <matt@bobrowski.net>, <mic@digikod.net>,
 <viro@zeniv.linux.org.uk>, <brauner@kernel.org>, <kees@kernel.org>,
 <casey@schaufler-ca.com>, <gnoack@google.com>, <jack@suse.cz>,
 <song@kernel.org>, <yonghong.song@linux.dev>, <martin.lau@linux.dev>,
 <eddyz87@gmail.com>, <memxor@gmail.com>, <jolsa@kernel.org>,
 <m@maowtm.org>, <bpf@vger.kernel.org>,
 <linux-security-module@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next v3 04/15] lsm: Add the bpf_lsm_policy_release
 kfunc and policy object destructor
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Paul Moore" <paul@paul-moore.com>, "Justin Suess"
 <utilityemal77@gmail.com>
X-Mailer: aerc
References: <20260909193719.518517-1-utilityemal77@gmail.com>
 <20260909193719.518517-5-utilityemal77@gmail.com>
 <CAHC9VhQHZ+ngFdzKqmnzBh341CGEg-jexu+QYU8=1qXK=u-x-Q@mail.gmail.com>
 <aqHUw6k0Mf83CGFT@zenbox>
 <CAHC9VhTM7emi9vxs+5Za8Hrc_e9dg7fZx+Z6BGUc4VQ1qhEAUA@mail.gmail.com>
In-Reply-To: <CAHC9VhTM7emi9vxs+5Za8Hrc_e9dg7fZx+Z6BGUc4VQ1qhEAUA@mail.gmail.com>

On Wed Sep 9, 2026 at 4:08 PM PDT, Paul Moore wrote:
> On Wed, Sep 9, 2026 at 6:21=E2=80=AFPM Justin Suess <utilityemal77@gmail.=
com> wrote:
>> On Wed, Sep 09, 2026 at 05:34:31PM -0400, Paul Moore wrote:
>> > On Wed, Sep 9, 2026 at 3:37=E2=80=AFPM Justin Suess <utilityemal77@gma=
il.com> wrote:
>> > >
>> > > Add security/bpf_lsm_kfuncs.c, the home of the kfuncs exposing LSM
>> > > policy objects to BPF programs, with the first of them:
>> > >
>> > >   bpf_lsm_policy_release(object)                KF_RELEASE
>> > >
>> > > The kfuncs are the LSM framework's own BPF interface: there is no
>> > > per-LSM kfunc and no intermediate security_*() layer.  Each kfunc
>> > > walks the matching hook's implementation list and calls the one
>> > > registered by the LSM whose lsmid the policy object carries.  Callin=
g
>> > > a kfunc for an LSM that is not active or has no policy object suppor=
t
>> > > fails at runtime rather than hiding the kfunc at verification time,
>> > > so BPF program loading is independent of the boot-time LSM
>> > > configuration.
>> > >
>> > > A policy object reference is meant to be handed over through a map
>> > > kptr field, so also register a destructor for struct
>> > > lsm_policy_object: map-held references are dropped on map teardown,
>> > > possibly from a context that cannot sleep, which the
>> > > policy_object_put() hook contract accounts for.  For the same reason
>> > > the kfunc is not KF_SLEEPABLE, and the filter adds no per-kfunc rule=
:
>> > > releasing a reference must be allowed wherever one can be held.  The
>> > > filter itself is needed because BPF_PROG_TYPE_LSM and
>> > > BPF_PROG_TYPE_SYSCALL, the two registered program types, share their
>> > > kfunc lookup buckets with other program types.
>> > >
>> > > Cc: Paul Moore <paul@paul-moore.com>
>> > > Cc: KP Singh <kpsingh@kernel.org>
>> > > Signed-off-by: Justin Suess <utilityemal77@gmail.com>
>> > > ---
>> > >
>> > > Notes:
>> > >     v2->v3:
>> > >         - No change.
>> > >
>> > >  MAINTAINERS               |  1 +
>> > >  security/Makefile         |  2 +-
>> > >  security/bpf_lsm_kfuncs.c | 98 ++++++++++++++++++++++++++++++++++++=
+++
>> > >  3 files changed, 100 insertions(+), 1 deletion(-)
>> > >  create mode 100644 security/bpf_lsm_kfuncs.c
>> >
>> > While not a new concern, it has been a few months so I want to mention
>> > it again to see where things stand with the BPF crowd: are the BPF
>> > folks still opposed to BPF kfuncs in security/bpf_lsm_kfuncs.c,
>> > similar to fs/bpf_fs_kfuncs.c?
>> >
>> > If the answer remains yes, the BPF devs are not able to tolerate
>> > kfuncs under security/, then I'm afraid this patchset is stuck.
>> > However, if the BPF devs are willing to ACK kfuncs in
>> > security/bpf_lsm_kfuncs.c, I'll add this patchset to the review queue
>> > for the LSM tree.
>> >
>> To avocate for the current placement:
>>
>> Placing these kfuncs outside where it is in security/ would
>> be very awkward, the kfuncs use lsm internal APIs
>> (lsm_for_each_hook, active static keys, lsm dispatch table) that
>> have no buisness outside the LSM framework.
>>
>> And logically, the kfuncs operate entirely on in-tree lsm objects.
>>
>> > > diff --git a/MAINTAINERS b/MAINTAINERS
>> > > index 6215fcb07770..ba816d7ee127 100644
>> > > --- a/MAINTAINERS
>> > > +++ b/MAINTAINERS
>> > > @@ -5081,6 +5081,7 @@ F:        kernel/bpf/bpf_lsm.c
>> > >  F:     kernel/bpf/bpf_lsm_proto.c
>> > >  F:     kernel/trace/bpf_trace.c
>> > >  F:     security/bpf/
>> > > +F:     security/bpf_lsm_kfuncs.c
>> >
>> > We would need the maintenence of security/bpf_lsm_kfuncs.c to fall to
>> > the LSM framework, just as the maintenence of bpf_fs_funcs.c falls to
>> > the VFS.
>>
>> Agreed.
>>
>> I intend that any security/ kfuncs go through both LSM and BPF
>> review at a minimum. As a bug in any of these kfuncs or their permitted
>> calling context / signatures could cause regressions in either subsystem=
.
>
> While some other subsystems are lax on this, it's general practice in
> the LSM space to *really* try to get ACK's from other affected
> subsystems before merging.  Sometimes we move forward anyway, e.g.
> patches being ignored for almost a year, but those are exceptions
> rather than the rule.
>
> I only bring this up because the MAINTAINERS entry was pointed at the
> BPF devs, not the LSM devs.  I would expect that patches going into
> security/bpf_lsm_kfuncs.c would need to be ACK'd both the LSM
> framework and BPF LSM maintainers.

There is will be no kfuncs under security/.
Period.

