Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.176
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793140676;
	b=PEZy/o66RHMrqlaI5EPWemlW4i3gQI8Oz5kcCTAVvmvJWR22bZfYd+iQJtq1ZPmDqjtL
	 3fY+LAj+PLG5Gh4sfedmIUPd7SK53aKizK3KX0gXhkudItDCs/DEmIjGCtXCez7arD6Os
	 hHp/NgrWV4kOL5X8mSOSWKWd762VEvDRTg3lJ3ASsFQh1tO4OAKY8wMrV9BKnc9hw5rwx
	 ZTl+9GguOA8lE25a0QIIzUG4GenAYolbpA3Mfx1uORuqQBs8TFYfyxHgGNTvfbjiK42yo
	 5SkzkM9lWmH2Ob0Pg9BIRfE510zns7tuLzYRFajJo7K3rW5ROHsyULVzjsE82eioq0w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793140676;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=t5xhlGartaiIZUAGJb1P17Ap9eQ10+LChVLHP/V0nA0=;
	b=4Sje58YArqjzQBDJ+m4e4x2B+bPDFjUiP3J4166KEXVQ08Tp8oJlcGvhs7iARFFXhDKy
	 7MO0sgnxSyvm5CScWFw211CED8ph4ZYQMQT7acpJrSdMcTFfaO+HqVsCViCBXM/9ajCD7
	 IhqFMrIog1EYwFrcgK659MyBXzLouHrKxFUx0B+EQZ2VC83of/zsdkc+fSFLD5or/KGw2
	 +Xgfsw1Ecs/JSbj5ecb7r9+SxyskSxVEOJfgaWfqNk3WRBl4SaLLycp9/bR1Mns98+h4s
	 TN0JL2b/3BuRl8l7BY2BwZdmZkBueCirG5TJ3Ge+RKEW/GwhtxUlM7osfjuwg8ddSqA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=paul-moore.com;
	spf=pass smtp.mailfrom=paul-moore.com;
	dkim=pass header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=CmmfcGZ7;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.176
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44FAB606A320
	for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 22:37:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 44FAB606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=CmmfcGZ7
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-8a06b44bd01so222542b3a.0
        for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 15:37:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793140675; cv=none;
        d=google.com; s=arc-20260327;
        b=dRlp4KeusqTqaJdcZ/zk2Tjvdc2f4PDNIb6yraeS26FoqCIFc4JOh0F+xVLG53RfU4
         3lH3EJHj7s+29fIyXKZSUIVX4sdktXsszKxZdvD9D1TwkYMPPfIAoJAjZpMtSWIC6R8D
         6wIWdEefzWbDRpMmA7Sx7G6ngiF982F7tz8HPBq7CDqMS1sV2LyieHjORVP7+kjm2QVD
         reITxsmY40OsYvGCJWYDdzytEL3DZlxBrnx8LWo8tpk2g4uPbQhghhpx5dbnusWtcRT2
         ClQx/TSSXUIX+QvqHylaKDp3w6JLTwqv+JNlF3TNviNwHDDSwF3TtwC266dyJwL2r3Ap
         4q+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=t5xhlGartaiIZUAGJb1P17Ap9eQ10+LChVLHP/V0nA0=;
        fh=LPsiihktDOU+ne3dyfwaiAhyMl/7Yk5lMJe9XAxQyjk=;
        b=l1CizfbEa0xlHcKhJWWZJPbvhQTXsywIX6ygOVPi/84jlkrfSbJyeDHCNLRN9AVR77
         MtYUOwqjdD2Nbpl9ySP8j2otHEEdowVVAGH6H72CEOxkDxiLuXQc7yuspk6keiPH5ku0
         NL/Vd/pZoyfOspNZ1gselUBRnoP5lEXZpottfK0/qDWRr3EBE5fHEuPwpT+NHqGDH2fH
         U/pAaRXPhbR4sF50LRVx+Jy7Mx4tOWWFXY0ed12gC0fTl60btv08NDZxaJ/u4Es832e7
         lHIsfQpwkv08pkFoSAGM6ujSIo2VNYW1M9gieFgz+pE0wRMQ7Y3AYfrWe36fNU7uN+5U
         C80g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1793140675; x=1793745475; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=t5xhlGartaiIZUAGJb1P17Ap9eQ10+LChVLHP/V0nA0=;
        b=CmmfcGZ7nENUuOJDqfOA+U+yawbLWPNguEYYehiaT86nUJPExK4LIUr0b+k1BDuc26
         I6hx3Xfzp7YLAMCi0JlAztaJL1LJ07peoMRn4mvEVYQV9ao935CKi7xkqxxr8DV6Yock
         rxkAlWa6dKfZUDSA/ldivMN/wB1R2F6oZJ/Z+KQbMx5hox/gtEbE+yCicUOTZpRrKE4P
         T+53go7ZXNYLqMuC/UuR39tYwAuemgUaV9GLdZTVfA4cl0AKkhPeDhUFFxNVxK9mTwol
         FatP7g9VML/VQBnIOClMGPtwnF6f1eMMmXa3sADMNe6RaLLPzr5XUkxKolK7HPzqhrTk
         WZQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793140675; x=1793745475;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=t5xhlGartaiIZUAGJb1P17Ap9eQ10+LChVLHP/V0nA0=;
        b=KuLe0S5Zu9ViZ1pShQoKLNFl/AfG14StQEmtTn0ZBygX5BwBKFW/H92pt4FeTReaNH
         c9daqURxsoSEDk6VGbx0kmwReFHr5Y1QhlTO4C8RVF9TPZYWRnSjJPx2m3EIHA7d1bly
         c2okeyfYFQwbhj6lZ9lHjgzOLxQpE0KwPKFAEiLapfSaL0Dtpf9nEcJTCmhd5IrmPztZ
         k3ExmT0GrK3ToYnGEkk3V5hvI1wyH5k634ncbg6TPYvIHhTwEB6iVg2BXkpDFZ5HyHdV
         pjuY5SdQTJQDBcgdDQ7WamJ2wdGXJwJkLOvwSEkujrUBlT8DEjs8Zxl8VS0MdJLfFjfk
         ZjQQ==
X-Forwarded-Encrypted: i=1; AKwUvBwTrnHNuZlPJLYud7YuBmvun+UbRSaU7N230J5hqjyQfRbjPcgD/jmUTgncLVIx+Xjt4uc=@vger.kernel.org
X-Gm-Message-State: AFq9FYIfruLWM8Jrow0IqQjS+covrtUYbTJZYDKopohsek7gVUKzvOe8
	8K3Pz7VFPWrsHJXnwDsaVLu2KUqqwTDhghp/IcMV1gUhkK3dzqpCHMafDO+/w1jKoTrJxgz2TA8
	8fdsxBam656gHEICSNW2vFyTj5WyV+3qabzSe8ujY
X-Gm-Gg: AYBFou0ULuWPsPNkrfenipKLAM7QHhc8UpUrlEfc1bZIxqliYPAUstxs7jauPZ1a7jw
	DPp6CO83nd5wCwrb6uUhpY9gZU/hhnrXXlJqu6oaY+zV2yXHutetFbQcvcyqXU/UrKakX1gtTIO
	IcptHS6NixV6eMKhtyPWGAOumSSCAyu0PECiEglTdDYctuoVQCSeHPomkUDLjf40EHwTUqmXH03
	TLhb5lUxTmMOtnVi0XR7ohzJ/MhBvjV6WGW7IJ4TGYXQAOtl2Lys4vqtaMcenIeY3c4RsKb4LmZ
	8EtjN/Q47kReTJTOE1q/5LlLzs8aHCuJYjk+Bi+lkuWIdwwWoottw6TubFhTKItErt3tVB0lXDy
	yh6sNbjPP+6lbo6n/GB8vVxIGusrG17Ea2ARg04l9Kk6jtO9xqK0rsgf8V+byrJ/yDJw+
X-Received: by 2002:a05:6a00:909d:b0:8a0:3ed7:93a1 with SMTP id
 d2e1a72fcca58-8a6e7ccf00cmr440746b3a.50.1793140675521; Tue, 27 Oct 2026
 15:37:55 -0700 (PDT)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261026-work-security-namespace_free-v1-0-ffa3ebbf71bd@kernel.org>
 <CAHC9VhR4rMydWiD-RFv-ABiYSG_txJuyrtdaowEXPY=CHEvFXA@mail.gmail.com> <20261027-heckklappe-halbmarathon-vorsorgen-849ffdc42aac@brauner>
In-Reply-To: <20261027-heckklappe-halbmarathon-vorsorgen-849ffdc42aac@brauner>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 27 Oct 2026 18:37:43 -0400
X-Gm-Features: AclHuK_35bukQeeBWCt3UKqoCps6Vj2Zz_3Ju5zoX-GW6fl3dw3mrid-lC1zJpA
Message-ID: <CAHC9VhSJMPOY4X78ENEkAiNeVTCpvP76PgVDqTQfwaYfwnYwAQ@mail.gmail.com>
Subject: Re: [PATCH 0/8] ns: fixes for the namespace LSM hooks
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, linux-fsdevel@vger.kernel.org, 
	bpf@vger.kernel.org, linux-security-module@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	=?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	KP Singh <kpsingh@kernel.org>, Matt Bobrowski <matt@bobrowski.net>, netdev@vger.kernel.org, 
	stable@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 27, 2026 at 5:24=E2=80=AFAM Christian Brauner <brauner@kernel.o=
rg> wrote:
> On Mon, Oct 26, 2026 at 04:31:25PM -0400, Paul Moore wrote:
> > From what I'm reading the LSM framework patches don't meet the typical
> > LSM criteria for stable/RC fixes: there is no serious bug/panic, and
> > there is no functional regression from a previous release.
> > This looks like one of those unfortunate circumstances where a new use
> > case wasn't tested thoroughly enough before the merge window, so it
> > can wait for the next one.
>
> My original patchset had a selftest that excercised the BPF LSM usability
> extensively. The hooks are new this cycle and broken for the main use-cas=
e I
> wrote the patchset for.

The hooks were merged into the LSM tree on August 31st, and due to
timing I'm guessing they appeared in linux-next the next day,
September 1st.  Considering the merge window opened on October
18th/19th, that's conservatively a month and a half during which
testing could have uncovered this issue and the behavior of the hook
could have been changed to accommodate your use-case.  I know the
Landlock folks were testing the hooks for their usage, but I've gone
back through my inbox and I don't see any reports of BPF LSM failures
using these new hooks in v7.4 until you posted this patchset during
the merge window.

> Curiously, your pull request told Linus "I expect that BPF LSM developers=
 will
> also be making use of the namespace hooks, if they haven't already". So i=
t
> seems very strange to claim this as a new use-case.

The LSM namespace hooks are new to Linux v7.4, they did not exist in
Linus' tree prior to this merge window which is why I consider both
the BPF LSM and Landlock usage of these hooks to be "new".

> >From my perspective the timeline looks like this - I'm sure yours differ=
s:
>
>   I wrote an implementation for the BPF LSM to use a set of new hooks in =
a
>   subsystem I maintain months ago.
>
>   You rejected the hooks because BPF LSM programs cannot serve as justifi=
cation
>   to introduce new hooks. Only in-tree LSM (selinux, apparmor, landlock, =
etc) can.
>
>   I cannot fulfill this requirement because I neither have the expertise =
nor
>   the use-case for any in-tree LSMs.
>
>   Landlock wants to make use of this by pure chance. So the maintainer of=
fers
>   to take over the patchset. He does.
>
> End result after more than two kernel releases: The patchset that ends up
> merged into upstream doesn't work with the original motivating use-case b=
ecause
> all the BPF LSM bits got dropped. So far, no problem. That may happen as =
long
> as we can the fix it rapidly.

As mentioned previously, I'm pretty consistent about what goes up to
Linus once the merge window opens: there is the initial pull-request
with the changes from the last development cycle and then after that
I'm pretty strict about only serious bugs/panics and regressions.  In
this case there is no existing LSM support for namespace controls in
any of the tagged releases from Linus so there are no regressions, and
by all accounts there are no panics related to these new hooks as-is.

Holding this change for Linux v7.5 will give you and others a chance
to fully test the new LSM hooks from a BPF LSM perspective, something
that evidently didn't happen during the Linux v7.4 development cycle.
Disabling the BPF LSM support for the new hooks in Linux v7.4 should
be relatively easy, much simpler than this patchset, and eliminate any
claimed harm.

Also, as the ongoing friction between the LSM and BPF developers was
brought up, I want to point out that SELinux support for the new LSM
namespace hooks was delayed to Linux v7.5 due to issues uncovered with
these new hooks during the Linux v7.4 development cycle (well before
the merge window opened).

> Then I take the time to send this series of fixes to actually restore the
> original use-case so we don't release a kernel with a new api that doesn'=
t work
> for the main use-case I developed this for.
>
> Once again, I get told no. This time because the functionality isn't brok=
en the
> right way to justify a merge-window follow-up. Instead, we'll release
> half-working functionality.

I told you "next merge window", which is far from "no".  Considering
no one tested the BPF LSM support for these new hooks during the v7.4
development cycle, that seems pretty reasonable to me.

> I'm really on the fringes of this endless debacle but this seems to be an=
other
> iteration of "BPF people don't get along with LSM people" therefore they =
make
> each other's lifes and that of innocent bystanders that just want to get =
work
> done difficult.

First, please read what I wrote above about SELinux being in a similar
situation.  If a LSM which identified an issue with the hooks well
before the merge window is being pushed to Linux v7.5, I'm not going
to make an exception and rush a functional change for a LSM that
didn't identify an issue until *after* the merge window opened when it
could have been easily identified with testing during the Linux v7.4
dev cycle.

I'm not going to argue that there isn't ongoing friction between the
BPF and LSM devs, and I'll admit to finding it odd that you seem to
keep inserting yourself into that friction point, but my approach here
is the same as what I would have taken with any other LSM (and have in
this particular case).

--=20
paul-moore.com
