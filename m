Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EDF335C193
	for <bpf@vger.kernel.org>; Mon, 24 Aug 2026 19:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787600100; cv=pass; b=iCUglOlydU4t5sgH7D2iByhJgvFibIkJ1StqSyEi9BdVmJIydWVoJkV0AJqldAZwavscdlBeg06Ejrb1bYWalmQayBrB0MnxSXQq0SM2G5bI3NwIEZli90aNOiaoVcPwnArrOHV8DTORNp9EY+2TYeFVjH6p2j14aIwMcQTG/lM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787600100; c=relaxed/simple;
	bh=9Ob5D2iEla/WzWMLhOuVgS8eWVhNAWjbdv+7Qu0T/bI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eTYp7QmKLmL4bwgAh3f+AwDK1FtB8JgyBIERTtWS1UQvxIpzp8RlnCtCr7WcCI3ziE/i7O7r38zJbE4PWhxSRF5KhZoFAEjfczwz5j6Z7Mwyv8KKqq2QoxI/S5W+Ld+nPfvcjD1LLgt4C8eODlwnvNA3POM5js4Noukw8csQUXo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xlpq0Dkz; arc=pass smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xlpq0Dkz"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-8518d5ddaabso2923866b3a.2
        for <bpf@vger.kernel.org>; Mon, 24 Aug 2026 12:34:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787600099; cv=none;
        d=google.com; s=arc-20260327;
        b=EkU2ZueSGnCz1g+O0guRnw/A7OIKCSq/hwTppP/g7xZIsEKILqvYCs0nSoBH4uf+in
         kPEk8cn1WTgHL7/JBFlAYKMzSWtTqP3ViLA0E4XrA+qHPKsb+b1TWHNcMlYJlWFrOEfT
         vfWg3dyudjnTWC2idWjziRSQ2GLIKk+Y+8gp1Y5jiDvFrKYq7nwrXQI7T8LgMzxEGvTx
         D0k12QjaT+Hylkubk/Mwh0oQ3zvwX8z8PCplvhAZ/Dfx23NujvPHGBWJ8n5lCGAt3sOe
         Utul+PAyuZSAi2UGFfXeE68Di52iBm6eZ8kYsai0Ju5CMMIVZQbW+EoibU7XaAnPR74Q
         FhNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=C6IftXwQOP58fhehm27O8FvB4wbByqFMOVBWMgljAn8=;
        fh=rX1o07B57S/QwEf5isB8gL9f4uKasDukC1cg4473AhY=;
        b=NJp1l/FGvPRlSUYuFcQCwRxFkO6HT9w2o23ki9DjBTUM1hIiUGdUIJn9LsXvsudTyE
         KY2/k3UbOQYNKhGdZJThSMjCUsbeaphCNpYrLXRr7/Bqh5MrJWnWRTBiceWeYi4j8qmT
         mNzVI4svekEV0hLPwcnbxQIajb7jq8DZULaFHtFbxudb1QgVM8PohHmu2nnDs+wOlYCN
         s+EjqWHSPH0wm1yhOsWOa4wBsx3nPJl7GLdk+PGc6dzo5Fho/0cEG5TfdYrhQJmmjh8I
         sNO71+zWeogHvv6tkqfdPAcaTcddKm2/sMVjqJZ8rhPGlAkwA0rF3U+N+xhWRdba84/3
         jCGw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787600099; x=1788204899; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=C6IftXwQOP58fhehm27O8FvB4wbByqFMOVBWMgljAn8=;
        b=Xlpq0DkzBD9F46hELm6B7711stXD4VMWyNT2tw8GSVbb9TDQ8fI1TQZwgK2Sgj11Pw
         CJq56wY58QPzznnU83nx0EgasHH551v0to19nf2SiV8iX8bQNDvQ3VRBH0hcdX/gKfk8
         uSzI00fzbcHuuYpz+sGvOK4QRS2T5bQTUYMoR9h6KSA4je7I9uk66xvsEW1li+xH8eof
         4rInRVI83sV4hbgVVsSNxzAewkAuyhL6O4NDYpYrhfDkgLWR1ZChn4IVou1B4TBcm7Zz
         /tXBy12pj1rS1DfWEHRS6ilBOkm944jjGiGMMvEU/tycqfbkE7mNh5S8Eb2Zh9+EmMpZ
         +q8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787600099; x=1788204899;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=C6IftXwQOP58fhehm27O8FvB4wbByqFMOVBWMgljAn8=;
        b=gvGKQ+7hTFXCH2dqFtrsLe+XKq9J6jp92Qm38bg2XjeFR5Gf7er8nDeE50VHI2xEmO
         poDHILS4wLrF26nJyrNKD0R7EoH3Am6w2ORHDVSO7ap0IpVFwJyfY9U1BX4jZ+pGHPZ9
         wVcIe+JE4YImKFUggXLzmRyUf0QNATtCJzJutQHvEY5HriNiU9gFdATojcAG6Z3nmtuU
         +n6Q9Td5bYiy3zxMkeRhvxkccCy3a+j+GZLbbHNpkB9BCD5eqFt/ITrDo74yffClhTjW
         2azxwzOnquenwJNMU762GzzHgeNU/+dqTGGw0jJvN5fCR+TN42CHxSDje+qV/tuhO20Z
         RyXg==
X-Gm-Message-State: AFuF++kKRp8BVv5sEUu739RFTKsrzSG38BgwL8xv99VG2T2VOrUB04rg
	QBzl5JDokmOZsML4FXECFsirqNQMIztYMVZKJSgg/0wskttcfjtsqYM5DCcQq026Tn+CDfIyRwc
	1DV7rGWBVn2iRXEUtrbJhm2ISNzJCoiPyjA==
X-Gm-Gg: AR+sD13cFOsu5F6cHahEA/Xsig8jODBmStCm5hVk5Cpt4dgomGIcYaXRjZV8sgFlpZA
	/hG82fJVFBZVAN7cIyUvKVzLAZcFgSvucVkBYMH013YO6yqqJ05foNoZqdJpxSvSz47xc4MOgFi
	siaCsqsiAye6iGQsOqcRy8CZmEwRhpTKs7x3LKSJdNTdNxS3y1CLi0cFCfnq15bMrDj+mTGcRTO
	k/pGUw1DM0q7LxERtRAbhklMsKRb9IN0rx3qO/WEP8+OyVw74muzPVme88idrQ8Uoq+K1sXXVaN
	SA1rUQFCC34nmlIBJeLGfkFlJCAs2d8cw9/Y7IcKGxs1+I/kq/Vpp0U3jh0gjci9zitZWbUruvm
	3b4rokPPTOghk2Hx7YcabRw+ngMAZkMapPXuzB7fToA==
X-Received: by 2002:a05:6a00:2ea0:b0:847:99bb:b6d0 with SMTP id
 d2e1a72fcca58-8523c9474b5mr1567954b3a.15.1787600098542; Mon, 24 Aug 2026
 12:34:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260220-veristat_prepare-v2-0-15bff49022a7@meta.com>
 <20260220-veristat_prepare-v2-1-15bff49022a7@meta.com> <CAOu3gNgW9+C7bOPkt0CGs8d_ad_TNyQ0AKv7_Jfg4=F5PET4ow@mail.gmail.com>
 <CAEf4BzYbUhpwP3nq=M4Ph12LwRYO+mYSQB8SJjsw0AzZAFqyVQ@mail.gmail.com>
 <CAOu3gNgv_nJ6tjZOZ-FnJNYntbnpKn+nRnO4G6j0fkBmeeu=GQ@mail.gmail.com>
 <CAOu3gNjg5vQ=t0C5UmStNpK8zutFC7kcYTrKt9aiR8Gia+rdNw@mail.gmail.com>
 <CAEf4BzY2ucQUsNbbaKcOyLhXNbMBS4ouoJknAqNJ6CN8rPG92Q@mail.gmail.com>
 <CAOu3gNggJbiDO+_2tq8W9mAY=BtP+wnpn314sJaq2e-y=vcpbg@mail.gmail.com>
 <CAOu3gNhc3NHdMkvvd=RvWyhBB4s4O5g2K==kcLvuUoR81zoJvw@mail.gmail.com>
 <CAEf4BzZKy5Wv_TxtEqsbzW+v-tO28kgY=9RhXrnbPhOZcVbOSA@mail.gmail.com> <CAOu3gNj25-wRO0fSK2FRPyBFo767ksqso2TkBy6yRbbiwhEAzg@mail.gmail.com>
In-Reply-To: <CAOu3gNj25-wRO0fSK2FRPyBFo767ksqso2TkBy6yRbbiwhEAzg@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 24 Aug 2026 12:34:43 -0700
X-Gm-Features: AcwNN1ULbqc9m6NTWNc8PEerIdLZHoF7uBzhEOZeiI3BduEK6K_34QPiIaZu7YM
Message-ID: <CAEf4BzZ+Y7ZOzv82py0xvtuVE=GeTkHQGzwy8kfnoyuEzxQfDw@mail.gmail.com>
Subject: Re: [External] [PATCH bpf-next v2 1/2] libbpf: Introduce bpf_program__clone()
To: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
Cc: bpf@vger.kernel.org, 
	DL Linux Open Source Team <linux-open-source@crowdstrike.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 24, 2026 at 12:14=E2=80=AFPM Andrey Grodzovsky
<andrey.grodzovsky@crowdstrike.com> wrote:
>
> On Fri, Aug 21, 2026 at 1:54=E2=80=AFPM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Mon, Aug 17, 2026 at 8:32=E2=80=AFAM Andrey Grodzovsky
> > <andrey.grodzovsky@crowdstrike.com> wrote:
> > >
> > > > > > Hey Andrii, getting back to this important topic -
> > > > > >
> > > > > > I reviewed the proposed solution and the code . An object-wide
> > > > > > bpf_object_open_opts flag that means "all programs must be
> > > > > > considered loadable, but maybe later" collapses two things that=
 need
> > > > > > to stay separate: a program that is not currently loaded but ma=
y load
> > > > > > later (feature gated, config-driven), and a program that is
> > > > > > permanently not going to load on this object instance (e.g. it
> > > > > > targets a kernel symbol/struct field that doesn't exist on the =
running
> > > > > > kernel, or it lost out to an equivalent alternative implementat=
ion and
> > > > > > will never be used). Today those are distinguished by the autol=
oad
> > > > > > bool: false + never load =3D the second case. If the semantics =
of "not
> > > > > > autoloaded" change object-wide to "loadable later," we lose the
> > > > > > ability to express the second case at all -- every non-autoload=
ed
> > > > > > program in the object now implicitly carries the cost and risk =
of
> > > > > > being treated as eventually loadable, even the ones that never =
will
> > > > > > be. So, every non-autoloaded program is implicitly pulled into
> > > > > > relocation resolution and map creation, since nothing can rule =
out
> > > > > > that it might load. For a program that  never will, that's
> > > > > > wasted preprocessing, and if its relocations fail against this
> > > > > > kernel's BTF, that failure is no longer isolated to just that p=
rogram.
> > > > > >
> > > > > > Given this I wonder if it's reasonable to re-evaluate the appro=
ach of
> > > > > > per-program enum from the original patch series we prosposed , =
rather than a
> > > > > > boolean plus an object-wide opt-in flag. Keeping disabled as it=
s own
> > > > > > per-program state (excluded from relocation and map-creation, f=
ailures
> > > > > > isolated) alongside auto and the new dynamic case state gets us
> > > > > > the capabilities we want without forcing every already-
> > > > > > disabled program in an object to be reclassified as "maybe load=
able.
> > > > > >
> > > > >
> > > > > Goodness, 4 month since that discussion... I don't remember all t=
he
> > > > > details, we can start a new conversation and go over details, but=
 I'm
> > > > > just about to leave for vacation and Mykyta is still out on vacat=
ion,
> > > > > so I'd suggest to restart this conversation with all the details =
anew
> > > > > in about a month of so, if that's ok?
> > > >
> > > > Defenetly! So just to clarify, per your advice from earlier in this=
 thread,
> > > > we don't plan to rely on the cloned sessions concept anymore and su=
ggest
> > > > instead to review again the approach we proposed initially [1].
> > > >
> > > > >
> > > > > Explicit tri-state per program vs implicit tri-state (if not
> > > > > explicitly disabled -> maybe enabled, if per-object setting is se=
t) is
> > > > > probably not the most blocking part of this. But again, let's com=
e
> > > > > back to this with fresh heads :)
> > > >
> > > > We will gladly review it again and adapt it so that it is acceptabl=
e
> > > > to the community and can be
> > > > beneficial to all users of libbpf.
> > > >
> > > > I will reach out again in the second half of August.
> > > >
> > > > Thans,
> > > > Andrey
> > > >
> > > > [1] -https://urldefense.com/v3/__https://lore.kernel.org/all/202501=
22215206.59859-1-slava.imameev@crowdstrike.com/t/*m93ec917b3dfe3115be2a4b64=
39e2c649c791686d__;Iw!!BmdzS3_lV9HdKG8!zLLCzrdLf22D2nAvCY9zolVFNQrG3_TnvtoR=
Ivm-HpwGPt9OIpIoC7q0ZWjijb396RLVMFi29c1j_DDBPPtC79aACUXBshO-eDCGtA$
> > >
> > > Hi Andrii,
> > >
> > > Following up as promised from our discussion last month regarding
> > > dynamic program loading.
> > >
> > > I reviewed our initial patchset and the subsequent mailing list
> > > thread. It seems the conversation previously veered into unrelated
> > > topics, such as concurrent programs loading and dynamic map loading,
> > > which are beyond the scope of the dynamic program loading capability
> > > we are trying to introduce.
> > >
> > > To recap our main point from July, using a global object-wide flag
> > > collapses two distinct states: programs that are genuinely disabled
> > > (e.g., due to missing kernel symbols, where we want failure isolation=
)
> > > and programs intended for late, dynamic loading. If we use a
> > > per-object setting, every non-autoloaded program is forced into
> > > relocation resolution, potentially causing load failure and wasting
> > > preprocessing time.
> > >
> > > If that is ok with you, I would like to resend the original two-patch
> > > series as an RFC with a cover letter, rebased and retested against th=
e
> > > latest bpf-next branch. This way we can review and discuss the
> > > approach from a clean slate.
> > >
> >
> > yes, let's start with resending patches (you can drop RFC, otherwise
> > CI testing story is worse) and let's go from there.
> >
> > I'm actually wondering, if we are going to introduce a their auto-load
> > state from current true/false, whether we should also have a new SEC()
> > naming convention for such programs so that one can declaratively
> > specify that this program *might* be loaded after object load, and as
> > such should go through a proper relocation and other manipulations.
> > I.e., we have SEC("raw_tp/...") for eager load, SEC("?raw_tp/...") for
> > default no-load, perhaps we have to add SEC("!raw_tp/...") (or some
> > other appropriate prefix) for lazy-load programs?
> >
> > And actually (I won't erase the above, but it just occurred to me)
> > nowadays perhaps decl_tag is the better way to go. Can you experiment
> > with this? We can bikeshed on naming later ;)
>
> Hi,
>
> Please disregard my previous empty email; I accidentally pressed send
> before finishing.
> Regarding the tags, I realized while working on the implementation
> that processing all of them and matching a tag to a program would be
> extra O(BTF types) itration per program. This looks like it could
> cause a performance hit during load.
> If we go with the SEC() prefix approach you initially mentioned, we
> could piggyback off the bpf_object_init_progs iteration for each
> program and avoid the extra O(BTF types) iteration for each, which
> seems  more efficient.
>
> Let me know what you think.

we already process tags for some global program args, so if that's
slow, we'll need to optimize it

The reason I'm suggesting tags is because tags are more obvious in
source code and are more documentable. If we had tags when BPF was
just getting started, I presume we'd never use the SEC() approach and
instead have tags for entry-program.

So let's see how it looks with these lazily loaded programs.

>
> Thanks,
> Andrey
>
> >
> > For bpf_program__set_autoload() API, I *think* we can manage backwards
> > compatibility by converting bool argument to enum with zero matching
> > to "don't load", 1 matching to "eagerly load" and 2 will be "lazy load
> > maybe later if user ask for it".
> >
> > > Thanks,
> > > Andrey
> > > >
> > > >
> > > >
> > > > >
> > > > >
> > > > > > Thanks!
> > > > > > Andrey
> > > > > > >
> > > > > > >
> > > > >
> > > > > [...]
