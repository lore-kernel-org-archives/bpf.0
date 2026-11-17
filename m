Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.215.171
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794956686;
	b=0bvbxOOZeEycVUUNuAZDW+6mFEfSeaC8gt33VwxxCuZ8zI2u7D0H/kfuJsHsfa46+vFu
	 ay9JZDh1yFLA2MbaOpzfgx+R5qMDxHYNIqod+yGQJVdQM7TlrSdLUwQZZ5dMikOvPYtcX
	 SyUAR7aOj03pCnnzKgg+930AFhJzu9c5NmBkle1LrcGqzkJQfKyHce3M2ZS6MLO/v3Jv7
	 Q/MwANfl51r7rzediveeNjJ/tmZgJ03YZiwi3HdcdvIXz2S3e8xEQ9Xm0p19BFsz3CRmo
	 jTKcwt+LY9HvfbJ9YRZ1R9bfxakomBYuH39nLsfQJJ7jM21HXUuoapvKSqwTVbKFkpQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794956686;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=MF/4k//GXIWfSvHONQUa2JD9KuKF6Feudyoe3NRA47U=;
	b=13wHw7UQCQFTqprCc+TX4bpra2Tadz35mmnW+rnSRUrD3CvrJQ8lodvQm0JIWsC7nhNz
	 6aH9Xa1JEmwQmWPQNWKvZQN3IWyRoyhfusLdw2xlbwgZcRBupL0WgNaQ7sJa5HlEkJ/Te
	 qZ5PRFqQIZ7wx8Dwmn3pQfuk7Fg3L9LzStOYIPkmTyxUa43XLIhXcDJYVNylnkjGfWLAU
	 zYNRdcic3Kniy4iK6qvHV8bz7FC2wMvGD7zQVKfMSez0p6DPQeePPir5HYFXGfNJuMWpo
	 +lO8k07VhpW7PNfPQvigzQiwU4h/yi0l90P3DmZu2+ls3k18Wqoqe0s+xdO7UbTCOQw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=paul-moore.com;
	spf=pass smtp.mailfrom=paul-moore.com;
	dkim=pass header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=Qe5+c2FS;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.215.171
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C6B2606A330
	for <bpf@vger.kernel.org>; Tue, 17 Nov 2026 23:04:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5C6B2606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=Qe5+c2FS
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-cddac941ed1so155181a12.2
        for <bpf@vger.kernel.org>; Tue, 17 Nov 2026 15:04:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794956686; cv=none;
        d=google.com; s=arc-20260327;
        b=kD9+TNKyF2ilG0SwSfVihCYm2Owq040Xe4ZVnp029aAh6YufYY8y36bFppSsIGh6ZR
         69ww6DvEnLLBmaj5tVrnKZSDwM2eCQ7eoNbKn67Oxr8hEZW2T9KxXmNJsPzMDaXjGNOk
         ZlH8c5NLCUeXISRiLAkH8YsPLVwD40aPiY7bL/BxRTGRcIzHqw1A1GrEeZ4iOIHsO7tH
         /mjy1FQ2pg1icV7X20pZQv6nJ3dsIg/QS9w8fje+VqLPkVpNSOjNhGhNaJ6neNCxR7Jc
         /u6EtdU3s3rm5pYzL3FaeLpAK7eKbGSZneTImKcXshhdA2rtg82I0PtXgchjoyPJqUng
         wAUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MF/4k//GXIWfSvHONQUa2JD9KuKF6Feudyoe3NRA47U=;
        fh=DSQUHpQdKEQW1in5sOk8AC2qcbItTLVt1mHSB/E/4CY=;
        b=hhpLti1Fp/XfWa4xauHOwBHguyN5R/y0MgYVgCPdNcHc5MdfKw5zEBCXOMrPYA07sm
         pybNTI0/rLoZ2tn894vBc4W+GPDQmmBrk8QBJScTz5oigpwbLupTmSNAzKWZF4JmhT45
         O261AN7Vk/eWNSgmrviOpQUS9R6We5ZQyev9r+py2IDQt4sjNTAxnSSjDRqlTGIK4bYP
         GZb8B/q4ILrjnHjuy3V03QFVvaym+qVIzbw40SOfj60WYpQb+mYlZ8aFnVeUrfr5Nxap
         zW4TE9G57JubZE5qklD+zg3nSsOQbBniG02ZV0ht2OXV84yIb1z2XKSEwbre1HhHmpc/
         q29w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1794956686; x=1795561486; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MF/4k//GXIWfSvHONQUa2JD9KuKF6Feudyoe3NRA47U=;
        b=Qe5+c2FSJotbj6ldw2lk/0EX2sA4jyvKDd7kSr8ybfRXP++RVUKrchJpRNNgGFhYEM
         zuX3j/KYi2VzWIw+tHJoCbjW3SaqetVEVC7PwIQuTU6aUC4H9dr1rcsmMRm5VnyaA17/
         +QkQgvoiDWgmV5ue/hmxGSStsQzTdyQusSzg7I7t4syqiD9BY8hpzveJcjYYNkcnWiYj
         ajj0pbf4jMCpr9sDqZqZZtM7aEc8KPkk7V8mv8NfIq9sIe4SgXE8w0rfKaQjGxsvPQiM
         tp1P1r4f5nYBZdjyiqzhm3saMAxPyvbIxaiwr0Clw+hKl4UNQfhUJSXdNHqd/fgKb5CH
         zsRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794956686; x=1795561486;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MF/4k//GXIWfSvHONQUa2JD9KuKF6Feudyoe3NRA47U=;
        b=X/JzFNhXxz01uNDlROZbUQqW7XnISt05Rf1yGP4rSANLAdFS9PO7sQfqGlwoieYQ9v
         5HeU8J0usrh9zNsudOvRnoN8Blmqe8l4+fl915b0UVMRkuORZkoZ1nMuF6nJJrXbB/+v
         pQ7wEED/oDnxCXnE4KhuXR6HcEuxQfCbtXMJBYoLqlp12jD06yhA2EJRcF1s15ZiAKsG
         gd3j62oyGiKz3y9plZZq8MnnpFF244aRAPWE9Eb/aJex/6tLaR157s6rUJc83gexwNmo
         xA930ynVIjftVbeyITqLOpXDskuNsGusZBbEOjXRo8YHuOLbLnDyW6hpisGcmHsdpoUp
         RGQQ==
X-Forwarded-Encrypted: i=1; AL+hErGm3rE8m7kvH9y5cPYu8QUvFgGiiOO1nzoyOYBKVusZ/3qhtmLA2a1fhXTurmajHG4SVxk=@vger.kernel.org
X-Gm-Message-State: APuU4Z9f9MVU7vsO5bKjZUJe2NAX3gHzNbgiqRKwvoK4XbiHQUsKwfKv
	rTSHQlgkKUKLBbhElfTLo88HzxLbwOZ1WX0Z3JFSdMApgt/ok2jn9RT46WgV81DedDuit8hxn/n
	x4oYfhmkgDQi71pZNCT6I84p7SesWH04P2icBMhTY
X-Gm-Gg: AZFdTZeF9W8hGEjcnhZ3BLJTVY/90snoPkMXXWrJeI5KrCiqX1uHqwLzgC7isRAuIR/
	B7DxKak2yetB8HGz0swaTR3iZGoQwfe5l0E1W4u7BUTy2T/YNlcALuW584y7BUW0nve7kRP4wsa
	OUNoinA/AOqxJMYmFv436foBUWGJ+2GpbWRrPu48nw62S1EvgVtN9mfc19cmiThTBh7GRxzYyZv
	GGeqRjvtLz3BxM9y3eDa+fYo9pS2EjMXjvYdI6518ZO0D9QutoYTD6tQgptydoRzFf/m9+XFl4t
	OACZ1oHKSvitd7crzGw3ZE69fe7KrT6Zv7vtmdAffTjwVL6qQM0TV7Vxn053BM5i+y9nMtO0S93
	Bi5sWefNL8gZdJQ6cOlGjZ7Rr9bT83aKCPbtwJtUbDxHzOcDZIHKlGFUpM4Un1W8Z3azJ
X-Received: by 2002:a17:90b:3f88:b0:3b1:3e7a:6d8e with SMTP id
 98e67ed59e1d1-3b3d0763251mr719188a91.10.1794956685614; Tue, 17 Nov 2026
 15:04:45 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <d85ece6e-27f9-4d9f-83af-4101bc76fef6@app.fastmail.com>
 <356db94e-f5d6-4fb2-839a-b97aef72256b@app.fastmail.com> <CAHC9VhR9sjunJRnM9gy-BkBZkapQTrr8a8FtmaK7JkAmUqTrLA@mail.gmail.com>
 <CAEf4BzZKmn6g0SK8OddjKFj_vAmZFvpZv32Hs_S+GHgT7VNfrg@mail.gmail.com>
 <9d6bdc31-e57c-4187-be78-29d82471f710@app.fastmail.com> <CAEf4Bzb+oYDqO20v4YbJ45wdtcGgJT3xVse822P+=oA7fpFAOA@mail.gmail.com>
 <CAHC9VhRcT3rmdpeadwi2avhwvr7aEZYStZ3bbEEx1hm=wtBGhQ@mail.gmail.com>
 <CAEf4BzZ120age2-M-a_TJ07xohb7-s=xn3e1W_-V0kopnATq6A@mail.gmail.com>
 <CAHC9VhThV9xiXr8j5_+W__CBKn0JqUiZ-RGZpF4Nz-i_RZprAQ@mail.gmail.com> <CAEf4Bzb5Y5TUbN3kLBJNPn5Ae+_nbc7YhJice_wUzqdvpjFr_A@mail.gmail.com>
In-Reply-To: <CAEf4Bzb5Y5TUbN3kLBJNPn5Ae+_nbc7YhJice_wUzqdvpjFr_A@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 17 Nov 2026 18:04:32 -0500
X-Gm-Features: Aa3M54qoHQOE3oB857KKbkDUHADETGjWV_M0UNRiQstMuTOvLZrm0nW0htwepiY
Message-ID: <CAHC9VhRRe8xOmSAdmEWOwHiEDrZ96ZamH_stLPAvw6jYny7Gww@mail.gmail.com>
Subject: Re: [BUG] bpf, lsm: new first argument in 7.4 inode hooks silently
 breaks BPF LSMs
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: roblabla <linux@roblab.la>, Daan De Meyer <daan@amutable.com>, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, paul.mabileau@harfanglab.fr, 
	linux-kernel@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>, 
	Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 17, 2026 at 4:44=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
> On Tue, Nov 17, 2026 at 11:30=E2=80=AFAM Paul Moore <paul@paul-moore.com>=
 wrote:
> > On Tue, Nov 17, 2026 at 11:51=E2=80=AFAM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> > > On Thu, Nov 12, 2026 at 6:41=E2=80=AFPM Paul Moore <paul@paul-moore.c=
om> wrote:
> > > > On Thu, Nov 12, 2026 at 6:00=E2=80=AFPM Andrii Nakryiko
> > > > <andrii.nakryiko@gmail.com> wrote:
> > > > > On Mon, Nov 9, 2026 at 7:08=E2=80=AFAM roblabla <linux@roblab.la>=
 wrote:
> > > > > >
> > > > > > Hi,
> > > > > >
> > > > > > Thanks for the replies!
> > > > > >
> > > > > > > LSMs that need to provide a stable API must provide an abstra=
ction
> > > > > > > layer between the LSM hook callbacks and their stable API.  T=
he LSM
> > > > > > > framework is not responsible for the stability of individual =
LSM APIs.
> > > > > >
> > > > > > Understood, that lines up with my expectations. I think the big=
gest
> > > > > > thing here would not necessarily be stability guarantees, but r=
ather to
> > > > > > make sure that the eBPFs fail to load when the compatibility is=
 broken.
> > > > > > But that's probably a problem for the eBPF side, and not LSM, I=
 assume.
> > > > > >
> > > > > > > So, in short, would it be possible to send a follow up to Daa=
n's
> > > > > > > commit and move `struct mnt_idmap *idmap` to the end of LSM a=
rgument
> > > > > > > list?
> > > > > >
> > > > > > If this is possible, that'd be nice so that we avoid this break=
age in
> > > > > > the short term, since the change isn't in a released kernel yet=
.
> > > > >
> > > > > can you please send a patch proposing that and we can continue
> > > > > discussion there? please cc me so I can follow along
> > > >
> > > > Considering the original patch was submitted, reviewed, and merged
> > > > with the BPF LSM being the only user (none of the existing in-tree
> > > > LSMs use the idmap parameter at present), I'm a little surprised th=
is
> > > > wasn't brought up earlier.
> > >
> > > Yeah, unfortunately this was missed. Not sure it's surprising that it
> > > wasn't detected immediately, though, because unlikely someone tested
> > > an unreleased kernel in production. Luckily, this was still detected
> > > early enough before the final release and this gives us a chance to
> > > fix a mistake.
> >
> > I've been surprised lately by apparently how little the BPF LSM
> > program interface is tested with real BPF programs before landing in
> > Linus' tree.  I know the BPF folks have a pretty good set of CI tests,
> > bots, etc. but there do seem to be gaps relating to real world usage.
>
> I think it's a hard problem, yes. BPF selftests test latest kernel, so
> this issue we are discussing here just won't come up there. Then,
> e.g., for Meta, we do have internal tests that validate existing BPF
> LSM programs across different kernel versions, but unless our internal
> BPF LSM programs utilize specific LSMs, this won't be caught either.
>
> >
> > > > Beyond that, from a style perspective, I think I prefer the idmap a=
t
> > > > the front of the parameter list in most (all?) of the hooks where i=
t
> > > > was added.  I'm not interested in moving it at this point in time.
> > >
> > > So on one hand we have a real user pain which is easily fixable
> > > without burdening kernel and LSM subsystem in particular, right?
> >
> > Arguably changes that negatively impact code style and readability do
> > affect developers and maintainers.
>
> I agree, but argument order is not that big of an issue

It can be for me, and in this case it is.

> > > On
> > > the other hand there is a minor issue of argument ordering with
> > > mnt_idmap preferably as a first argument. I get the preference, but I
> > > think fixing an unnecessary (but easily fixable!) user pain should
> > > come first, don't you agree?
> > >
> > > Can you please reconsider?
> >
> > The user pain exists because there is no abstraction layer between the
> > LSM hook callbacks and what the BPF LSM makes available to BPF
> > programs.  That's a choice made by the BPF LSM devs, and while it's a
> > valid choice, it does have drawbacks like we are seeing here.  Changes
> > to the callback arguments and/or the semantic behavior of the LSM
> > hooks are going to continue to happen regardless of what we do here.
>
> Yes, just like it will for tracepoints, kprobes, etc. Sometimes it's
> inevitable and BPF ecosystem does have tools to deal with. It's still
> a friction and pain and burden to do this, so if it's avoidable at low
> cost to the kernel, we should try to minimize unnecessary pain.
>
> That's really what I'm asking about here. We did do that with
> scheduling tracepoints, I think it's reasonable to do this here as
> well.
>
> > It's better if the BPF LSM figures out how to deal with problems like
> > these rather than relying on a set of bandaids at the LSM framework
> > layer.  If the decision is to push the pain up to the user to keep the
> > BPF program interface thin and flexible, that is their choice.
>
> Yes, thin (and thus performant) and flexible is the design choice and
> I think it's fine. That's not really the crux of the problem here. As
> I mentioned, users have tools to work around changing unstable kernel
> interfaces that BPF programs rely on.
>
> But in this case we are discussing reordering a few arguments *before
> they even get into final release* just to avoid unnecessary pain and
> workaround. *Unnecessary* is the key here.
>
> I really don't think that's too much to ask in this situation.

As I said previously, the current ordering makes much more sense to me
than moving it to the end of the list.  I'm not interested in moving
the parameter.

--=20
paul-moore.com
