Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ACFF2EC0A4
	for <bpf@vger.kernel.org>; Tue, 15 Sep 2026 13:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789480154; cv=pass; b=b2/TXDBFGXORvREFZ28ajeCu0whQchs0PAvYPy+hd9aaTVxzKgvLObaOM2YlMciK92UT41jd5cvtu4NJQeiMVy8t5WwL1S8NTneLbkc+RpTQEi6LZ2kfW979Abz6WjUBHeFFroy2DV3i7W8SXfYKGeRMlZdsvVhCP/v/DaDRRuk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789480154; c=relaxed/simple;
	bh=p/bm6QL+GjFW9OLC8hTQZX5y3ubnpWDY/+48cQOWXNY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WxKmcou3u6LrAbIwSljsljKj847MkVU6m/DEuUSa/iWhB1BBRYlZ6EYvTYsRbSa0rwdJ5VLora5ijBB8ox5u2rCMMtcLKyVZ3CIhtFQLyXmLDHvgth+Su4x0FeYxAMQbmVX2yyWEWC6uqfjJtEXBQupr7RP/vUfQDkbQpzr4hK4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=SQQctn5L; arc=pass smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="SQQctn5L"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2d747ed6d6eso25032635ad.2
        for <bpf@vger.kernel.org>; Tue, 15 Sep 2026 06:49:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789480153; cv=none;
        d=google.com; s=arc-20260327;
        b=mDb8RTdokWuq2boxlRtFivU7DGuyHL/72VSV8/TvTTnuXwqPzqNTvI0Jmu3Dr91S2J
         8MbF3gqG3OYVYBPOKyel3Jj/WKxfJ2tUQFZw7oUn48nfkO/UXYPvjFCYuhedOy4PpT75
         AvEI9apkVmnV8WxT3rbHYVZdmzJFtCz7gOE4nWHLs/IFbE4FYpimx9ntObFWnOSRu7qp
         kGu0UJ1iBK+9l0JNcpjNNfrR5bh7x5d4mTbzk9YtUOBp98qyy5cDe2COOLKEvIKeKZQD
         lGTF6n3TgKJAvSqR0fVZj6hfkz0HafPjUmZj4rXFXn4lTwKfxqF9chZ2HZxVqntm+Ruc
         6muQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hfjv+aIw8i3wro2/p0OoyFtuhvMOB8Aw+vPjdiNRKoA=;
        fh=8yA1w9ePkcGv5zufe0913udmArROAx83BwLwG7vkP8A=;
        b=RexXY6Rr+SLY3GnYykk7RCREzv3go6jFOdvmOFmX7DAcDUv92jWdPAOnD4BvnW71ky
         caMOQ8WpgBw7yEvMUQ9Tiz2NCeaUNDDHJ2GpMXaP9y4tNUXVAa9Dl7TlWAT+L7DcMGh7
         2xnU3Ir5wTHJgaC8vGOqVUl/qrOd3zetfK8HbJxwqzm/g5MMTwktMjKHkYo1IaF/oabH
         Y/Q5GLt6Ol0006Vhk51TI4dMZnuQGld9YITEUDP2ONy7peSX6JhM48SMwuM7u2FjpjxJ
         VPvGLbQ+tGzKhplozmDnddWtj76Cb8Aliv7nkl2wUHBCLR78APvUouddUX0rWeVrJ6DG
         IjhA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1789480153; x=1790084953; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hfjv+aIw8i3wro2/p0OoyFtuhvMOB8Aw+vPjdiNRKoA=;
        b=SQQctn5L6A1olhxSub+cxIKavtukgkv4AY12XKsknkAkyvYIDtzwhyDrdZEgngfVhv
         yik3uXCE0roCyH0Apn1fIzgehh5aRTuL4S6MpwmF7z4yZ81klRbUcEYY14dvm9sZCROk
         p07UV2Cuyp8Fm/E8yHmOFVl2NNfEdLskWCr/q0RdHg7LWfmIrDxRYsPA7L8tIs6oRLpR
         FUCJ/rowCH6I5IMh3euuLPxOTICihRuW7WvXtc5r/r7Fj3e1chnWM5DyWKT63Y4TRxMs
         Rhqnmso9F81H2DNZdjB1XT/4m4M5bPRqji/oAKWKp1F4eXxeF8kykhq5qI490et5LrrJ
         jlVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789480153; x=1790084953;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hfjv+aIw8i3wro2/p0OoyFtuhvMOB8Aw+vPjdiNRKoA=;
        b=XJ2yil/oHCUN+7WMMRAi+aOFKi4GL/lpCGqxUKYJsx4p/emm8/6oEtrEpE2jbrFC/c
         4rIV+9prqtz1mCaLAT77KbcmMoU+iEww1DrRmJ3qeOXKSQA/p3TB0oKMAa6zLInPag0F
         VvPlsY9uKE+mDJ2x/EQ3Bj/B/tnanFD62FHPSYcN6irsuSsL1p3wVJyoX86tM/Cauz3L
         QzQqV9zWHa5NZrOF0SL6MPSRO+AnJnJCeRxb8aOenIUu9LZm2GOwPSGVGCRGRYDlwIy+
         +8EGVJHoDa1w+eW9TLZ7vLvKiVflWu1JYalzVEoy7o6jk3BAAtDBKrs4iX+VNRc2wiOT
         fgTQ==
X-Forwarded-Encrypted: i=1; AKwUvBwbseKf6z1N1YPsM6zUuG4aR4M+dXoLQCphiToIJWjkP+EFmNx+TRiHjrGOohu1a8Wit44=@vger.kernel.org
X-Gm-Message-State: AFuF++nRq0RqY3NP6Rcq7wOzxsiK6FCTx/KDlfHX/CWHY/5iU3uYGLmr
	fXF7LhKVm1YQZnkWFgAefKhjVoFFKiSQn2aPHM6Mz5kJ9pw9ajPDOkbWrlV/041ghtjMEXHdfr/
	ihqD7sm7rLqlS4K/9h1Cg/Lt+52KB2RAWt2bygRjF
X-Gm-Gg: AYBFou1wMiNre2WGHiyQrVszdS0UhXEm8kPDd0WoQRrcfuNQ/8OvP5ShuMtMbSngsNv
	NIYQEMZk8o1usjrzmYzKuIu0w5iOmdT8VW+o5yTNXV0N0NZIFM0Qmud9GhPlCexKU34xwcIJI4C
	bEvHci92bvIiopMqSTVfzdalop+t028gyC0eoIytteXNV84sTtYXaRIaW6zvOTMdnBQ3J9LLzGz
	Wi0Zs0Zb6aQXbD5rQM393YmdOdgXapGMwOniT1Bxtt306Lw4QWneTvW2qRnl37JHKMupbtqyH+U
	iwtgE1f6/MTlJQoQVN90E0sZQVGSCu0gKHy9mms/ParL1StIbzwo215TzPpoRT29ymTQzUVDti5
	qRDfsEb+b8gY=
X-Received: by 2002:a17:902:e544:b0:2db:63cb:1b17 with SMTP id
 d9443c01a7336-2dd6c7a7986mr146446375ad.18.1789480151741; Tue, 15 Sep 2026
 06:49:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHC9VhQHZ+ngFdzKqmnzBh341CGEg-jexu+QYU8=1qXK=u-x-Q@mail.gmail.com>
 <aqHUw6k0Mf83CGFT@zenbox> <CAHC9VhTM7emi9vxs+5Za8Hrc_e9dg7fZx+Z6BGUc4VQ1qhEAUA@mail.gmail.com>
 <DLD0VQ3D8CYC.3V5ZT8HDMY4IH@gmail.com> <aqTZdCz6JaoK16Fp@zenbox>
 <DLDL7KK3FZKU.17ADLLWJVXB5F@gmail.com> <CAHC9VhS0JckwfomqLTUJkZZkDSgeRXYOjMmPQYErgYynQYqMKQ@mail.gmail.com>
 <CAADnVQJCJjy9Eiwn6-88c0iOk4LfgPU6KBv+w0JZdBzmXBMUCw@mail.gmail.com>
 <CAHC9VhTh446SkpPF-hUiLYOHipuurzkgju_nH9LsRGdERSAL1w@mail.gmail.com>
 <CAADnVQLZscKkCxvK5puuOE1aN8nW6PnaS+_dx_zBQjjP2T-DFg@mail.gmail.com> <20260915-laken-ferngeblieben-verflachen-bafe1f296b02@brauner>
In-Reply-To: <20260915-laken-ferngeblieben-verflachen-bafe1f296b02@brauner>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 15 Sep 2026 09:48:59 -0400
X-Gm-Features: AcwNN1X1VBqKl5wb2opR2SZklPVGLAG3iamTS5-uRRzujO-KJnfUrMjsThqzpGQ
Message-ID: <CAHC9VhTC5YvALs5K76qDBP9bDRpZPc_V-U8DPZ8qhNsCsXyLnQ@mail.gmail.com>
Subject: Re: LSM boundaries. Was: [PATCH bpf-next v3 04/15] lsm: Add the
 bpf_lsm_policy_release kfunc and policy object destructor
To: Christian Brauner <brauner@kernel.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Justin Suess <utilityemal77@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, KP Singh <kpsingh@kernel.org>, 
	Matt Bobrowski <matt@bobrowski.net>, =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Kees Cook <kees@kernel.org>, 
	Casey Schaufler <casey@schaufler-ca.com>, =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	Jan Kara <jack@suse.cz>, Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	Eduard <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Jiri Olsa <jolsa@kernel.org>, 
	Tingmao Wang <m@maowtm.org>, bpf <bpf@vger.kernel.org>, 
	LSM List <linux-security-module@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 15, 2026 at 9:00=E2=80=AFAM Christian Brauner <brauner@kernel.o=
rg> wrote:
> On Sun, Sep 13, 2026 at 07:24:14PM -0700, Alexei Starovoitov wrote:
> > On Sun, Sep 13, 2026 at 5:10=E2=80=AFPM Paul Moore <paul@paul-moore.com=
> wrote:
> > >
> > > On Sun, Sep 13, 2026 at 7:25=E2=80=AFPM Alexei Starovoitov
> > > <alexei.starovoitov@gmail.com> wrote:
> > > > On Sun, Sep 13, 2026 at 12:41=E2=80=AFPM Paul Moore <paul@paul-moor=
e.com> wrote:
> > > > > On Sat, Sep 12, 2026 at 3:33=E2=80=AFPM Alexei Starovoitov
> > > > > <alexei.starovoitov@gmail.com> wrote:
> > > > > > On Fri Sep 11, 2026 at 10:26 PM PDT, Justin Suess wrote:
> > > > > > >
> > > > > > > If fs/, mm/, drivers/, net/, are permitted to have kfuncs, th=
en why not
> > > > > > > security/? kfuncs.rst doesn't seem to forbid this.
> > > > > >
> > > > > > because fs, mm, net see the value in bpf. bpf helps these subsy=
tems
> > > > > > to focus on their core technologies and moves policy decisions =
out of
> > > > > > kernel and into bpf.
> > > > > > while lsm people treat bpf as arch-enemy.
> > > > >
> > > > > It's amusing to read this when just this week we merged a patchse=
t
> > > > > into the LSM tree for the benefit of those writing BPF LSMs.  If =
you
> > > > > look at the discussion around patch 2/2 you will even see a reaso=
nable
> > > > > exchange between Matt Bobrowski, a BPF LSM maintainer, and me abo=
ut
> > > > > the patch.  Alexei is obviously welcome to his own opinion, but I
> > > > > would encourage those reading this thread to look beyond his comm=
ents.
> > > > >
> > > > > https://lore.kernel.org/linux-security-module/20260904-lsm-mount-=
idmaps-v3-0-920a1963675d@amutable.com/
> > > >
> > > > And that's an example of unacceptable land grab by LSM folks
> > > > that I'm concerned about.
> > >
> > > I made sure that patchset was ACK'd or Reviewed-by'd a VFS maintainer=
,
> > > a BPF LSM maintainer, and the Smack maintainer before merging (I
> > > covered the LSM and SELinux parts).  You might want to double check
> > > your definition of "land grab".
> >
> > You're still missing the point.
> > Christian could have landed it via vfs tree with your ack for security/=
*.
> > You have no power over lsm hook changes within vfs.
>
> Which tbf is generally how I like to handle thing especially since we
> usually have a lot of changes. But I'm open to shared branches as well.
>
> So I think we naturally have to modify existing LSM hooks. But it's
> shared pain. Since we use BPF LSM heavily in systemd we generally have
> to absorb such growing pains as well.

I have no problem with topic branches that various trees can pull, but
I do have an issue with the VFS tree merging patchsets that haven't
been properly ACK'd as well as the VFS tree creating topic branches
for patchsets that aren't primarily VFS changes.  See below:

https://lore.kernel.org/linux-security-module/CAHC9VhTE82bRRSXSUuMOdrfoMh=
=3DxOb5hDvqiKWzBKD1urab3hA@mail.gmail.com/

Christian, if you want us to move forward with topic branches in the
LSM tree for LSM changes that touch fs/ code I'm happy to do that, but
I need an acknowledgement from you that the behaviors mentioned above
will be cleaned up in the future.

--=20
paul-moore.com
