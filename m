Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D46EF3101C0
	for <bpf@vger.kernel.org>; Fri, 17 Apr 2026 16:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776441691; cv=none; b=pWYfx2XIeUsAIn/TWBCM+N8D9tGg3S1iqDDQlnADiokWkCFW1S3OaCg53ivcBXF0Sq4Q1nbXnev8GHH0DzUsZVa/9DSKb+PHn1Jc07BkjDoXD5oHfEIPmGNuNYzBMklluZxXzhVjp2r1j6eD8fIkR1uaFFKONV3qMUlL1ETlRpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776441691; c=relaxed/simple;
	bh=MN9ukJ7sbOLNOd6kQgcy+yDM0fT1YKyxdtcXRjq2DYA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uiQRBmCC360zr3c5GiEh8MD06/MFZnOsVwKXnnXnFeG78idYPDwLrZE3h/Qc2U5LlRRBsgsvv0xKWYIIRbc2AcTNIm3pxdHxJ4GBm1U9toeb/x3oUB9pMsXHHoH4/G3NLI54enqpgVrXYA6nSUnO6PvT0fOP99PgdSGjLPA12G4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dHrdgBW9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dHrdgBW9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E00CC2BCF4
	for <bpf@vger.kernel.org>; Fri, 17 Apr 2026 16:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776441691;
	bh=MN9ukJ7sbOLNOd6kQgcy+yDM0fT1YKyxdtcXRjq2DYA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=dHrdgBW9Ui4yGV/tFWHkhsAmhn7p98/vopfYgyN1v/7bCv1K6KsiU3lSeN5O9zdXg
	 782jQsbgrIZ4BJ3Ouroz6cHDQ91bmJ3HWtbLV20lKvSP8gP6G4vjcwKX5APUm9UCWK
	 7zO/xMNa6/6nQmQAD1ohGhfB/Ov2PU9CJxf+73QekwQtaRUzE/rHheIoXA6yLIMVtF
	 tjcRLNyWbnNsv30cZMfRP/ExzeOVoTk9PVuxP1v+ehD5YPEU4wTzl6cFQJiELGBDmZ
	 CyF2tmN/rhKbcs8jbCv7U210sZm8mFAV3T/fGauNatoN0kLy5mzTQevK9CcXUmvSXQ
	 OGcXbv32b6pUA==
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-8d76492e51bso86135885a.0
        for <bpf@vger.kernel.org>; Fri, 17 Apr 2026 09:01:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9Wuiu3YQY90/oJybmRzrErq1bDPzk7pGEKxKzMYhtszsDQTA1L7robdVAfNJ3r7J2i0xw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdEJWMM5Oy/UlfCorwFh7NKI4IPlXs8LqfWT5mHPcyvbVaY/wn
	kPu07LwEP6Ix8P8g9Wk2oSoqQeLYjRLwTrIe9rm4JWHYe3f2E8MEKJFVnecG0XzMFuGSGlWbogX
	fRACqyZxEgAQXijLI9oR6Le1GNwRpOxw=
X-Received: by 2002:a05:6214:e4e:b0:89c:ac1f:8d86 with SMTP id
 6a1803df08f44-8b0281210b4mr51796826d6.19.1776441690675; Fri, 17 Apr 2026
 09:01:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260407200157.3874806-1-utilityemal77@gmail.com>
 <20260407200157.3874806-9-utilityemal77@gmail.com> <CAPhsuW7zzXXd6-d86B-rpGr-wfSzmEoCYNKhTMP_pXnybtA27A@mail.gmail.com>
 <aeFaQXkKNHFeE-oC@suesslenovo> <CAPhsuW648HdcCbXWMHaJ4uirPWq2WX3Ggx3AGMU6CGzhNYUREg@mail.gmail.com>
 <aeI_CXj6F-nI_DCL@suesslenovo>
In-Reply-To: <aeI_CXj6F-nI_DCL@suesslenovo>
From: Song Liu <song@kernel.org>
Date: Fri, 17 Apr 2026 09:01:17 -0700
X-Gmail-Original-Message-ID: <CAPhsuW5Dzf6-nX4t6Wq_+q6j=fHnpWTQCEY_NS-8d1Z0B+QeTg@mail.gmail.com>
X-Gm-Features: AQROBzBvGU9zbBLMBzHROKZ4Fu1wZJFg6S9v6mWviyTKM2qb_YceCdIYyWnmZg4
Message-ID: <CAPhsuW5Dzf6-nX4t6Wq_+q6j=fHnpWTQCEY_NS-8d1Z0B+QeTg@mail.gmail.com>
Subject: Re: [RFC PATCH 08/20] bpf: Add Landlock ruleset map type
To: Justin Suess <utilityemal77@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	kpsingh@kernel.org, paul@paul-moore.com, mic@digikod.net, 
	viro@zeniv.linux.org.uk, brauner@kernel.org, kees@kernel.org, 
	gnoack@google.com, jack@suse.cz, jmorris@namei.org, serge@hallyn.com, 
	yonghong.song@linux.dev, martin.lau@linux.dev, m@maowtm.org, 
	eddyz87@gmail.com, john.fastabend@gmail.com, sdf@fomichev.me, 
	skhan@linuxfoundation.org, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 17, 2026 at 7:09=E2=80=AFAM Justin Suess <utilityemal77@gmail.c=
om> wrote:
>
> On Thu, Apr 16, 2026 at 04:47:40PM -0700, Song Liu wrote:
> > On Thu, Apr 16, 2026 at 2:53=E2=80=AFPM Justin Suess <utilityemal77@gma=
il.com> wrote:
> > [...]
> > > I don't think we can pass the FD number via a map, since the FD is
> > > process specific. And it needs to be done in a way where we can looku=
p
> > > the specific ruleset the FD points to safely.
> > >
> > > So we'd need some other way to load the ruleset from a file descripto=
r,
> > > either through a new userspace side BPF call or similar mechanism.
> > >
> > > Is there some other common pattern for FDs --> kptr I can follow?
> >
> > I didn't find an exact example like this. There must be a way to achiev=
e
> > this. In the worst case, we can add a kfunc for this.
> >
>
> I think new kfunc is a doable approach. I could make a kfunc taking a str=
uct
> *task_struct and an FD that looks up a landlock ruleset within a given
> task that returns a trusted kptr.
>
> Something like:
>
> struct bpf_landlock_ruleset* bpf_landlock_get_ruleset_from_fd(struct
> task_struct* task, int fd)
>
> And tagging it with KF_ACQUIRE + KF_RET_NULL.
>
> Then keep the existing kfunc for putting the ruleset and enforcing it on
> a struct linux_binprm.
>
> The BPF program would need to get a reference to a task struct
> of the program creating the rulesets with bpf_task_from_pid for
> instance. Then they could use the task_struct with another plain integer
> map to store FD numbers and then use the rulesets or store them in a map
> of __kptr objects for later usage.
>
> Would this be more acceptable?

Maybe we don't need bpf_task_from_pid(), as we only need to work
with current task?

I will need to read landlock code more give a better recommendation
on this.

Thanks,
Song
