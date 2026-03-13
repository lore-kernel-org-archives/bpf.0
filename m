Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC8533E0C59
	for <bpf@vger.kernel.org>; Fri, 13 Mar 2026 19:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773430608; cv=pass; b=CyMHdI7Kg7jxVgfd4uKx81j0EhVxfUERnj931uxOQLqB9w4zUNZDFv5AEZzOgaR0XG6WWakS9Hzqh1AQtjZp2HFAPbTdZEybOcWhYMR3VnrI18JYVbE8rb87K1qwjBE4fkIIxGjnSwmawVwTBH98TJNkkkBsQxTx04628EIevFY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773430608; c=relaxed/simple;
	bh=ezLX4GQ2UZd5Q26qdT5MGScrIcB8+Te5OvetRMpXoXo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WAKvUjQCvGTaUWWJZFdBfU/og1V0NsKyu0qOSkYIBKhxtw/i+oKr2LNbMPvoVVibt+TtB/fjH/1zD7Rl8FNogqkXY0sIRnEzsKh+JOaCqcf6f2+iwwWRTZNOoNWVGh6sojyuH/U3sJdojXr2gDrf0dt6oerw5Y5JjVW1JUFIQSw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=P3jkVOxO; arc=pass smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="P3jkVOxO"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-82735a41920so1046160b3a.2
        for <bpf@vger.kernel.org>; Fri, 13 Mar 2026 12:36:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773430600; cv=none;
        d=google.com; s=arc-20240605;
        b=BtsNRuDrL2DmsDsDOxIbV4lmtyzeKwGXE8bgLxwMFBsftWhMEME2K3toet0UyWdEXR
         tJcgYRFVK8375Un9/8FKIA0Si6HSoYhCn0LUPbNidspqLO3jMO2+qsf3PQFKofD4JTKL
         3NsaGRg9czkeMsQlYVueTUA+7GkMYFZImx+epmrkXNufCtUF+InIEs/pQfmwn2vmj1Rp
         7G16KZ3EEjt7aYUlXG3LBAPDEwslh7vSPID8WBawGcK7/3uJCag+krDNnm/rKZA3BF5t
         0mseuWjO8F+4zR6/57JBMZLzH45d9JQYmBk12x79dpzUFsF+zTax0x30x57uYdter/oP
         4DwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=7SZBQxP659/1Vz18iP/TaSiFqht3yaJrXilwyHpy4Uc=;
        fh=Ax7t6h4Dn1dG9z6jdFCQReg2/PLjLNZkbZI+5cxZOQk=;
        b=cH3CeEoSubLD3xkiBreCTYcpdNZRQdpIBgs1WgpE0zjErubonX8/tjIziDgOqL+BrX
         9rn5WAb7sGP0B1APBMiR8v4a8mUjEAkQrHN8408XLq5z5BxFZu5oEwCwOefdO7PMVand
         5akWpZGrxlA5KmroOgPXuZTJOmJAx1qC0uDdUJz7XSxA/RzjisYafElj3qAsLdzJg0zX
         /jW4tfxpqE+lUfXcQYvjvevfFnpf6AQ4sKWR0kHPGkkfK2GaBqWF+droKWqPVIPpAwT5
         e2UoCbU0tvkOz7p9ZN69RYCWg0cu+hPzFBzWqpLwECVmUFv1gYVSobnh+JvhRjEyWUn3
         TcZQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1773430600; x=1774035400; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7SZBQxP659/1Vz18iP/TaSiFqht3yaJrXilwyHpy4Uc=;
        b=P3jkVOxOHslCjq5kN5VLSwGw2DsvprYjkFPWKc9GB2Cr7X7BqL9v9zwu9axnixiuXF
         nBu8Rx+Y4gg6u5AC4Cfro3uP4Pg89ZUvORouBk3mFbS7NLCkea83iBbINvVQJSIbj5ao
         PaxDGc7bkYNuh49t+GrSWih8t1zWmHcPWPQUlI7g2emwxhUa9TqStNe3XemN3TF3zRED
         SICbQ4lLYiR1gblEZx1iiuJ7ruo6PPZqDC/hVYjjlZGRTSbS3SFgusr5+zNlKPj4X46Q
         oLmylLduhQpQue5yTynvtMsIs3y2z7MN/sV0jL6qaKg3hUH8n7QxOfPWxqWS6yHHeTBJ
         2XZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773430600; x=1774035400;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7SZBQxP659/1Vz18iP/TaSiFqht3yaJrXilwyHpy4Uc=;
        b=oEzZCFUvsdUAhoARyLC8bwFUII0B/r1DiWFNWZ54HIxWjaRTncUmGuij+VRsbPAEYi
         YE6lEnUjC8yLs2gsKkJqEzZ+zWTX6g+wTq8wyuT4p1CUZULb4c612jmN0+m5Zi3suzMB
         dKiDomEe+1KQ7LeXde09BrKYtyhldMo5LeK3HbwOtRjaB3urowgM52Nf3TZWvdCxVnEH
         TDRdKboJXuIoVR6GsJtOycit/7joM0BBXLITeg+u5ZPOLDoJ6mCckwM8m2x3rmgC/N8p
         ygmygNYu2KTc+Y3oMmbNYz09e52PO/cg4JiBg5FcDuqoRSOh5+SKQ9nJ+5taGbUXTt+H
         QDrQ==
X-Forwarded-Encrypted: i=1; AJvYcCWYJdYiEI4EYGLkDsjPpITT8csRIFFmb0wu7q3Y/5MIfW0Sj2IDFbGupApff3/iJxPMPdQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAZGRD5T4QB1IMXux4DFKkFNdo3dQq4E+lPeTZ53Seak4fMKfc
	62oYCSnIxzOZZteEX9moXApWiAyzAMUNBcVRDF6A4/gwGMQ+IML176MlDFeauAvNBNLJy61Dqds
	jflwwcB4uBVZvJiILryXzAK5UyMfbujN+5Nu5Y0hL
X-Gm-Gg: ATEYQzyOFyR8WSnxJXzmJ16lOwDJLZJfmrDJdEoiC2IiyaXb1QJnkjZ3gNvCivjjiM1
	g31nr9g5ogNwxmJJ1iqr4ybc52tpbsl+Znu2wgvP/cdG2B4QGFGeDSqEitEmtlAiSvjZQwt0pUS
	7AWrydJOfdQsbbclYv0RD8suV6t9uY0XS69YN9mP/7Xxzu+71m0VgPnRX3DuNT2krYu2yj1BdkR
	CfsPgHrZruyZc3T5+kk9fquEVuPB2ret4subblQrxSqfGaxsDWDxkyQ05HobzTemgVBamisSKk5
	J++wqmHrFsOpEQ4=
X-Received: by 2002:a05:6a00:1388:b0:829:7ee0:1a44 with SMTP id
 d2e1a72fcca58-82a197046dfmr4186054b3a.4.1773430599837; Fri, 13 Mar 2026
 12:36:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260307212058.169511-1-jhs@mojatatu.com> <20260310184713.7e810431@kernel.org>
 <CAM0EoM=TAAfwZc3q1=RKWPrS778R_B8uM18ev_jYYz8oj4YiBA@mail.gmail.com>
 <20260311175249.54abe1b6@kernel.org> <CAM0EoMnv14pSaJWW3ZQuegkbQEqqye0zp0-_tCaOEWEg=C3xCQ@mail.gmail.com>
 <20260312165113.773a5f44@kernel.org> <CAM0EoMm0dMRKJyfCH80G=q4PnnTzzKVRvSrAU204FFKMn9NOtQ@mail.gmail.com>
In-Reply-To: <CAM0EoMm0dMRKJyfCH80G=q4PnnTzzKVRvSrAU204FFKMn9NOtQ@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Fri, 13 Mar 2026 15:36:28 -0400
X-Gm-Features: AaiRm51FzVPEj5x8-7UQwBJ_H90URykuqOW7BBLFDfVKu8idWAvLsU3tRRb1ky8
Message-ID: <CAM0EoM=KinOanha9nKJ=GyT2FU_o3Hg-tY5fWDfFO+PBuQfXpA@mail.gmail.com>
Subject: Re: [PATCH net] net/sched: Mark qdisc for deletion if graft cannot delete
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, horms@kernel.org, jiri@resnulli.us, toke@toke.dk, 
	vinicius.gomes@intel.com, stephen@networkplumber.org, vladbu@nvidia.com, 
	cake@lists.bufferbloat.net, bpf@vger.kernel.org, ghandatmanas@gmail.com, 
	km.kim1503@gmail.com, security@kernel.org, 
	Victor Nogueira <victor@mojatatu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 13, 2026 at 11:56=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu.com=
> wrote:
>
> On Thu, Mar 12, 2026 at 7:51=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> =
wrote:
> >
> > On Thu, 12 Mar 2026 16:36:48 -0400 Jamal Hadi Salim wrote:
> > > > > Two of the several (I think 4!) patches we had took a similar pat=
h. I
> > > > > am trying to remember at least one variant was bad for performanc=
e and
> > > > > the other was unstable. Let's see if we can revive it and take a
> > > > > closer look. BTW - none were pretty, it was maybe half the lines =
of
> > > > > code but touched many things.
> > > >
> > > > FWIW / of course, we have to apply similar change to all(?) callers=
 of
> > > > __tcf_qdisc_find in cls_api. So LOC-wise it may end up also pretty =
long.
> > > > And it's not going to help the already spaghetti-looking locking. B=
ut
> > > > even if it's more LoC I quite like the idea of containing the poopy
> > > > code to where problems originate which is the lockless filter handl=
ing.
> > > > Fingers crossed..
> > >
> > > Something like attached.
> > > Unfortunately after running it for a few hours it reproduced.
> > > The action code path (entered by virtue of filter code path execution=
)
> > > releases the rtnl when attempting to load an action module. A paralle=
l
> > > qdisc operation waiting for the lock then grabs it and we hit the sam=
e
> > > issue...
> > >
> > > So now we have to be more invasive and start coordinating the action
> > > code etc, which is not appealing. Thoughts?
> >
> > I see. Doesn't seem entirely crazy to let tcf_proto_lookup_ops()
> > return -EAGAIN without actually loading the module, and have it's
> > call path (of which there are only 2?) do the module loading once
> > all the locks are released. The call paths handle the EAGAIN and
> > retry already they just assume tcf_proto_lookup_ops() has loaded
> > the module so they don't have to.
>
> I might not be entirely following what you are saying. The core issue
> is not module loading perse. We can avoid module loading in
> tcf_proto_lookup_ops while the rtnl lock is released and the qdisc
> refcnt is greater than 1 (which is what the patch i sent attempted).
> The new quark is when we have actions associated with the filter.
>
> I will send you a much lengthier description of the issue in an hour
> or two  to get us on the same page.

Note, i am going to describe the scenario we saw with the action quark
where "filter add" enters before "qdisc del"; the one described in the
commit is the reverse order. We see the issue in both scenarios.

Sorry, this is a lot of text ;->

Let me explain the "expected" behavior
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

time x:   On cpu1: "filter add" enters increments refcnt to 2 after
          finding the root qdisc (see __tcf_qdisc_find)
time x+1: On cpu1: "filter add" in the action code releases the rtnl_lock
          before calling request_module.
time x+1: On cpu2: "qdisc del" enters for root qdisc, holding rtnl
          (example refcnt =3D 1), see tc_get_qdisc().
time x+2: On cpu2: "qdisc del" calls graft which calls qdisc_put() which
          decrements refcnt to 1 and cant delete qdisc because refcnt is no=
t 0;
          "qdisc del" exits
          ***We are in an inconsistent state at this point - IOW, the qdisc
          needs to be deleted but cant because of the refcnt !=3D0.
time x+3: On cpu1: "filter add" acquires the rtnl_lock again in the action
          code (see time x+1).
time x+4: On cpu1: "filter add" eventually completes; see tcf_block_release=
()
          invocation in tc_new_tfilter() which eventually calls qdisc_put()
          which manages to decrement refcnt to 0. Qdisc is deleted..

To reproduce the issue requires 3 threads - which is what the repro does.
Note: sequence time x to x+2 is the same as "expected" flow above.
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

time x:   On cpu1: "filter add" enters increments refcnt to 2 after
          finding the root qdisc (see __tcf_qdisc_find)
time x+1: On cpu1: "filter add" in the action code releases the rtnl_lock
          before calling request_module. Note: the action code path will be
          momentarily rescheduled because of request_module call.
time x+1: On cpu2: "qdisc del" enters for root qdisc, holding rtnl
          (example refcnt =3D 1), see tc_get_qdisc().
time x+2: On cpu2: "qdisc del" calls graft which calls qdisc_put() which
          decrements refcnt to 1 and cant delete qdisc because refcnt is no=
t 0;
          "qdisc del" exits
          ***We are in an inconsistent state at this point- IOW, the qdisc
          needs to be deleted but cant because of the refcnt !=3D0.
time x+3: On cpu3: "qdisc add" comes in and finds the deleted qdisc still
          on the qdisc hash table since it hasnt been deleted (see inconsit=
ent
          state in time x+2). And then shit hits the fan (as described in t=
he
          commit, qdisc_tree_reduce_backlog() etc).

In this specific example, the issue is that the classifier code path
can't release the rtnl_lock while the qdisc's refcnt is bigger than 1.

Does this make more sense?
The reason we went with the "mark for delete" approach is at time x+3
the "qdisc add" wont be able to find this qdisc. This is the common
observed pattern - for example described in the commit message where
we get have a slightly different flow with "qdisc del" before "filter
add".

cheers,
jamal
