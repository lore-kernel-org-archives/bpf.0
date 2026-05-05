Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A6F9275848
	for <bpf@vger.kernel.org>; Tue,  5 May 2026 02:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777946719; cv=pass; b=ilTYl3Y8vv6ScYxU6sMBrqB5KW7NG0Ux3XKVu4MjD7zY27V1FNoVsQN4xlvimz6je06YOkDbYIdE8kYtyWvQblHIpf0cQQS3SMjZ+1Xdmo3MrWzjCVc74qJfdT6IVmHR9s+xf54qxCWwtP7Yl4uaGsfRG+U2Uf14dwIMrgtNwjw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777946719; c=relaxed/simple;
	bh=gvTcP/QSZduWlO+YM2pkz7nb/ZWzyRFB9ciWkWgUHB4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EJn7nYZrYJcNmyBq+BCdtkrvPvZ6+biRTg/xDOUIdqUUP825HNGz5DB0K6xLRB/r7Ch866xjDiYmwojIXhzLaUNrpcmDV641Ng4TWxQoLsMQbGZtnzmpC8gqFGFm/fhCHx88oYxODcllapqlRw7fM3SiH0ZPUB9Dplye41PyD90=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Iu4pHGTE; arc=pass smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Iu4pHGTE"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-365212191f6so1578768a91.3
        for <bpf@vger.kernel.org>; Mon, 04 May 2026 19:05:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777946717; cv=none;
        d=google.com; s=arc-20240605;
        b=QpUoJTJDuh/9FaKWyKSsZU6o4D0zS3wpxA136BcfEf4i6CSVO40eSPYtlk9Q2f7qDe
         mMKO9/AwNEE0Fvp0OClEBMBuxXi9OvAjmkpbfusGKLYhBKPcPAAhROl1Ai+OLksnPH4q
         8z/MWJPoyVr/xWhKZEg+Poh3DmtTvZEqwPlXxaykp5oNdQ7z9BB1bikWcteCzDVPcN1E
         SlR6wq4vp3CuNAnJmJ/H+RbqlALWwZibpITWRDYlauPhXFBrC3uReNhvMoLyBgGQTS+6
         WCl0U02gPcQxIsq+10UV7tp9xeXGbpq8Ba8p4o8DsLjOxU54BLNLc/ZstNtdTPMDDjkQ
         rBAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ds8VPZ8XGFRCMSYoTIFK4J9AmphYV1vVpSWFXmoaOPI=;
        fh=hA6XRG1x7vxtZqkHtGmvwKxnprEvZG0dEI1L38iiEho=;
        b=DzbgA7e3wNWQShdr5BHmh+5hUio4oQxoHrzwD6FpQ9b7UA/zJw2ivCvdTdd8W19Mb4
         roSWRHDjxywLA+aHASciCn+UuZ2vhSJKs8oLCgRllZe3WCuNYdiZzQW8lqlUNlX4ymjk
         OjOsXpjrh8Cn1l22vAYiXs93CKviamn+iwxn93m0lTI147bXMuOuGMOpP8YI6+zjItFn
         MmdgaplcdfaXN+zRXEKS96xU3xjhl5APGrJdP+J9ux7hqeJPLUTpyyghRx5kR6hOSiGc
         sOIf9NB8FwT1UtpfmE4SqNfJEUow0EhW8V8KV9ZrQSvFqPZs5tKvIPBdvJtdNhYDKWY2
         rGXg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1777946717; x=1778551517; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ds8VPZ8XGFRCMSYoTIFK4J9AmphYV1vVpSWFXmoaOPI=;
        b=Iu4pHGTEUaOLJwNoK6YkG3q0ITunicSOQ9GLJSqAZshyOtEqzWrx20esi7hYXfWjLS
         Ku7ucBmg80OyUDoA4XpZjPwA2+U33YY71h0OKr1hkn0n0eWGJWPw7vRTo9pNEkeUUy32
         W87BEB2psIcxaVJNpzgC+PUsNMKSKZ56NTumpArcoKSPLlj5tzHG6FrLVoyHjP6Qzfim
         8e6LE7bCXySDpMs23fKlu6L3bUasxX0AhJCPo1b6EAyXhne/WRGl0RwqTGRm9wycbohN
         53MU5QDes5YHyYQSiwfbTdSd4gG0kf/iFWA8IWJXM1lrA4sUmSmmK5DDJHCi/4jXt/ya
         50Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777946717; x=1778551517;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ds8VPZ8XGFRCMSYoTIFK4J9AmphYV1vVpSWFXmoaOPI=;
        b=qG7dDxI/drg/d/e02fjzk5uFifYBba1dvowjY1LazSHpbJ7Iwfo9QGy7ezWeQVf0Tx
         YISYPtc+NfDiaYo1mqbsC+cC+O8Lg5qMaWRqvDb8zIOBEHbWI3cG0wTxiosLuSM74w1+
         Vqsg4QnOjwqfxEpEpKIaVCkUbqEfI4mk9mQAN6GdK7NxO2cIN0wtk677PwVKrw6+OQYG
         27iCwblTtmBofhAmqcSjCOKjKmWRo+idjV690uqw06qOkYzgLvuqZyCsLxXuherB4LwZ
         D91k9izqsSnXPNWk7Fm3w+wp6KItmC6/o07u8o/g9WnCQJcFNl6SD6MA8DxKpf389Er/
         NWEQ==
X-Forwarded-Encrypted: i=1; AFNElJ/W5uB5juvCnOoZrt5cGLGI0LGjCULFmJKigmaSpjL2/TXjoEML9s3gF57XE4Ds/WyVMUo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrdCN8M/g7qkA6fYUxjFbWwBoVirj4JuBOBcUd0E/kZIJnOV5F
	eShUB90zu18a9QGOaUgcX9q5tYC0Ave709h5xyhBkMFqn50vv5PWe/LbA4p5SQ7YDJ7GI1EybsH
	c6+p/D0CpkBUX2pVHERm2RlAKVw/+v+0OjHErQIPQ
X-Gm-Gg: AeBDieu04jMPbw2CmX/e+uMIwG4GoNmW+5n7bsUn4MlRvsottvhhGYJvSkRiJ+VbAfT
	P5PoeyvcPr+EJTYS1wxax0vqkifRxbTYoJ4plUSKd9DdNHtpAXc5LK+AO6WwFkeMHmmwNIvWoq8
	UQoWfjtCo299F4jninwNSzzONP2+nfpAwoAgAr2fGG9/MaUJolVR+9K62RkWMFIwKJ48NnORt/A
	i/BmxtFJ9OIJvcpB8wXqiruD3UwBTtXMAtsCB6k5tZUZpkdNNdT6OpCr4pNfYRZs6MXVjkiZszg
	a2DH5+CBg5GcpkgutZ1xFV0ZTUZ5
X-Received: by 2002:a17:90b:578b:b0:35b:e51a:ec77 with SMTP id
 98e67ed59e1d1-3657747c6b0mr1240269a91.16.1777946717425; Mon, 04 May 2026
 19:05:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260503211835.16103-1-dwindsor@gmail.com> <20260503211835.16103-2-dwindsor@gmail.com>
 <CAHC9VhSy5K5nQTtFUE4BScy1Ur61v7eZW067vTcUYDQeJb13Bw@mail.gmail.com>
 <CAPhsuW6sy2cdC4B7Z48-5A-yVX6fmVWxS_fWVjQxiX95KeUguw@mail.gmail.com>
 <CAHC9VhQLN5NA_ZMMNyUdMCZVdwC3VM4PUnzka8xDK5rpR2a3sw@mail.gmail.com>
 <CAPhsuW5nDaLAV5UfAHeX6QPeF6bs-WDkFYOzYO7Q9_O6v=jEHA@mail.gmail.com> <CAHC9VhRx7L1WXYgQvWmGN0a7ssSaDKx4JPhup2E3W161sdp74A@mail.gmail.com>
In-Reply-To: <CAHC9VhRx7L1WXYgQvWmGN0a7ssSaDKx4JPhup2E3W161sdp74A@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 4 May 2026 22:05:04 -0400
X-Gm-Features: AVHnY4IXddbw6Xna7rtOXW0Z3iNQtqb02aaSWmZldIVvVUPK0DOCzTg7J5JMJqs
Message-ID: <CAHC9VhSkBsUDKoQArjyPLTgSfc4GVinphyJmNv=-UwnQp97qCg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] bpf: add bpf_init_inode_xattr kfunc for atomic
 inode labeling
To: Song Liu <song@kernel.org>
Cc: David Windsor <dwindsor@gmail.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Matt Bobrowski <mattbobrowski@google.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Mimi Zohar <zohar@linux.ibm.com>, 
	Roberto Sassu <roberto.sassu@huawei.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Casey Schaufler <casey@schaufler-ca.com>, 
	Jan Kara <jack@suse.cz>, John Fastabend <john.fastabend@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Yonghong Song <yonghong.song@linux.dev>, 
	Jiri Olsa <jolsa@kernel.org>, Eric Snowberg <eric.snowberg@oracle.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org, 
	selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 4, 2026 at 10:02=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
> On Mon, May 4, 2026 at 7:09=E2=80=AFPM Song Liu <song@kernel.org> wrote:
> > On Tue, May 5, 2026 at 12:42=E2=80=AFAM Paul Moore <paul@paul-moore.com=
> wrote:
> > [...]
> > > > > Perhaps I'm simply not seeing it, but is there a check to ensure =
that
> > > > > there is only one BPF LSM calling into security_inode_init_securi=
ty()
> > > > > at any given time?  With the BPF LSM only reserving a single xatt=
r
> > > > > slot, multiple loaded BPF LSM programs providing
> > > > > security_inode_init_security() callbacks will be a problem.
> > > >
> > > > I don't think there is such a check. Also, a single BPF LSM functio=
n
> > > > may call the kfunc multiple times, which is also problematic.
> > > >
> > > > I think we will need to make the default bigger, and also introduce
> > > > some realloc mechanism for the worst case scenario. This should
> > > > work, but the code might be a bit messy.
> > >
> > > Thanks for the clarification, that is what I was afraid of when
> > > looking at the code, but I was hoping I was just missing it.
> > >
> > > Increasing the default is an option, but I don't think we want to
> > > support a dynamic reallocation scheme for the xattr slots, that will
> > > likely get extremely messy with synchronization between the LSM
> > > framework and BPF LSM hook registrations as well as special code to
> > > handle inodes with lifetimes that are disjoint from the BPF LSM
> > > programs ... I suppose there may be a way to do it, but it will surel=
y
> > > be ugly and come at a cost.
> >
> > BPF trampoline already handles all the synchronizations, such as
> > add hook, remove hook, etc. properly. So this is not that hard.
>
> How do you plan to handle the issue of disjoint lifetimes?
>
> > All we really need is to allocate a new array, copy pointers, and free
> > the old array. And we only really need this in the worst case
> > scenarios.
>
> Oh, is that all? :D
>
> Keep in mind that the code must also handle arbitrary ordering of
> LSMs; in other words, you must handle a BPF LSM that isn't at the end
> of the LSM order.  While a BPF LSM at the end of the LSM list is the
> most common, and recommended ordering for the vast majority of users,
> we've been working to make the ordering as generalized as possible.

I just realized I probably wasn't as clear as I should have been ... I
really don't like telling people not to go experiment with things and
play with the code as that feels wrong for many reasons, but I do want
to warn you that if the code to handle this ends up looking like I
think it will, I'm not going to want to support it in the LSM
framework.

--=20
paul-moore.com
