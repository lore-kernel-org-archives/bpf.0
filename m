Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58E313242AB
	for <bpf@vger.kernel.org>; Fri, 21 Aug 2026 17:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787334893; cv=pass; b=IcZYw1zsuev2s//2UTkY67NwNJFWJGP13xQMm6VLvcdzo37dhsYXJAHQT0cxq9CZCwAkzSeUmLksJkq7ppw9oi4hKcfcyUgfXqpj32WtDWtdhdUOD8/6NwLIi3AiqZbt1kZmBXPrDadkop9MOetU8gnT2DGWcauOcJdpKQn0YPo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787334893; c=relaxed/simple;
	bh=Wb10cQV0GNCQAmtrfdzlv1vAKN+Okzc2W2wJsiC8/3w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RqQIAYgBcGdARi37DqQJJUmkn2rGwMKtpSfoh2RWoUqsPpCW9xTcYcPB+IGHtBluqzrgXSHU/tDhDUYLkgXw8sL4vnPh0AHLx77KfgS/KmeqjfpXB6iiqC9wbXRRVy90wBb8dYVkR5B3kF04DFbAj5JxBxnYTxIffHwXplCibUc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LdGUxZ3J; arc=pass smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LdGUxZ3J"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-84faf0fa17eso1239873b3a.2
        for <bpf@vger.kernel.org>; Fri, 21 Aug 2026 10:54:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787334892; cv=none;
        d=google.com; s=arc-20260327;
        b=pbqfdVihrOc0y7oae3YvKe2aPNngwO2hcJB7H5d7DZP2xbfdthHZiTDbNlGnuUzfoU
         wg9FtO1Cl6YIj6hwRNamlSPHPDWw6Bl1Wtp8wR6Hcqbs5qfu1WSdGVrclzMjtQzEOvLT
         pRNrTaOi8oXDgtO+Qseg+qwWm4gX7Zby2OaP4jlF36e88cGFCvQ+pjbgtjO+CATlB7/C
         Nn7YsZVZBJtDukAc/LJKnsRxB8huSHGLP1sTvsaEMP56kxfcntqQfUUj5EOASGKWCpyr
         4IZYRFeM50XIbl1idmhJTVELBU3NkNkYtjjvA2tvXv+Q9ABAjFQmzsSzIm1dNdRCMSje
         b5Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/l7e8SO5Ery+TpChjjrJ8KvNw8N8LmHU/7SuIDOmo/U=;
        fh=rX1o07B57S/QwEf5isB8gL9f4uKasDukC1cg4473AhY=;
        b=d84qixU8kygCHthtePEE5HYLCsRHSqzkA5I0ikGzm4kZnbM41CSWfWzpDlhEetuhcb
         iJy4tBu+VS8li7dyzre2BynYDQbXuqN32ycT+NdEHqVEMYawhtKQe30jABBtOT6/wOJi
         5i8J5Gh+ktddum9Cs5ibnoJHdqWWA6abWO2ahmw1jI43UfnXmmWgtQ7L+hjH7TVlrrtH
         FawqEru1SYwoGsTSKTEZy3cWGSVl8uDI2rXuhtAr7fH1/wj/yS5IQE62cah2jAdDSX/v
         Npu3vFtmh/LRSOGj3VYyvMZGT5p2onnMQc3fxcoE2OttbaM+72gaZ07pgkFfXQa4ONGm
         Wx2w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787334892; x=1787939692; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/l7e8SO5Ery+TpChjjrJ8KvNw8N8LmHU/7SuIDOmo/U=;
        b=LdGUxZ3J4dw1x/9/8dlcl54Ca1uvjbxApxI9oE4OGe25v6/ia5AGok9Aj2yuASETi+
         vKtF5zkh749zuMbPitVldCWxGyzoHGQWGYRQSbB8QNTjUGD6FP8J+Hj4CTv30pyYyEMa
         zueVZNXuFtNorPMHnZWGOpSscJzYHLnepMqCRLSfgvptetLAXgDQMk04NftD9g2gQfL3
         hlFM9kdXgly7cqyCAO/ryggrqQ7UMT1PRJ2TxMCnI5EIdxrcQJkp+wDFQtJe5vi9Xum1
         hUGpXMF7k+BZrGYP95l72+HOv36+taG42eg588Phpe+1OKCQE662ftu3hKfJaqickjqH
         Owaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787334892; x=1787939692;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/l7e8SO5Ery+TpChjjrJ8KvNw8N8LmHU/7SuIDOmo/U=;
        b=EPAyQtvo307waOwWjrNc6jaELtxLd/JOI/i8dEe6NVQGUZ+pyk0FaCT1mB9Zhy+j4e
         GDteO13JLSzrU8QB83n9VShJux2nfkjqBYBSdz6V7b+pSe6AwyG19QCjEvDMbsrL6yLt
         Go5EI3PrZV1fnkeHeM4fB6CoQYNUfxkxnKqMJxBCQXIhzVwhoJN8WbEU8frD/T2mkkgz
         vYrDGy/sQ3tuYpt4Ypo4pMWPADCVrVxWreMfduF9jhmWtkDsm1Y+4gzkiekjNHsTGkYP
         w25/OwIruPpMurtC0qqXXaGMYQK5DF05xzNRRQPAe4jTVmG/PnWJfBlCgS2IKrRziYZy
         yG+Q==
X-Gm-Message-State: AFuF++nFEz+1N6RuRg0r8uwWYpVXvHhN8YJFWzQkImTIU7zlaKCc5J6b
	62ztQa0M5cQCvYb0M08bMsJmh7T4hAJOiO40EvQERJj+KrfWruOQDkFQhVXbq1LmAuSIRqXb5X1
	dLqXo0sZVSj99wgPkID0D+cF0Q4WWSs4=
X-Gm-Gg: AR+sD116LIUezhbX7FhapboiF2usLGajXqsRzbZiRd53n/5MZgshj6FQesJCydh2liQ
	P9WXGi8v9yoJD3k/udXuMn8b2bQBs8IP8Lf6hFcoTih2Iky4VReCfrG8zwSbvHsxIToEfVfBZ1h
	6LXAt+ecaNghQZemIfgPpzxY2zRkUE4hspP3zaR+6/QoyrsPxIp7DblmzIiGiVP92hIRmQ8FGUG
	hghg4SwHuIY6b1PgONykqlyYDUxSpeSKNzPsJ2Q/q2jbJpuu5Ku7a/vZcAbt1haT03U7qeD12kW
	0lGCGM3eGTnf5k1kMQIx59EclEIk8xYFaRaW+66iyXuZjTubqI8qfx+qXhwyUzBOqWxqAude1SD
	b3pVvom/Lm1r1bU9MZjriVw/Lwg==
X-Received: by 2002:aa7:88d5:0:b0:84f:3f5e:f072 with SMTP id
 d2e1a72fcca58-8520be6fd83mr505752b3a.10.1787334891506; Fri, 21 Aug 2026
 10:54:51 -0700 (PDT)
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
 <CAOu3gNggJbiDO+_2tq8W9mAY=BtP+wnpn314sJaq2e-y=vcpbg@mail.gmail.com> <CAOu3gNhc3NHdMkvvd=RvWyhBB4s4O5g2K==kcLvuUoR81zoJvw@mail.gmail.com>
In-Reply-To: <CAOu3gNhc3NHdMkvvd=RvWyhBB4s4O5g2K==kcLvuUoR81zoJvw@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 21 Aug 2026 10:54:39 -0700
X-Gm-Features: AcwNN1WS5PeTdBJaYWy8mWhhfBktUfvKs7HSlhsmJFToF6tBam-yzLCI0UAulgs
Message-ID: <CAEf4BzZKy5Wv_TxtEqsbzW+v-tO28kgY=9RhXrnbPhOZcVbOSA@mail.gmail.com>
Subject: Re: [External] [PATCH bpf-next v2 1/2] libbpf: Introduce bpf_program__clone()
To: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>
Cc: bpf@vger.kernel.org, 
	DL Linux Open Source Team <linux-open-source@crowdstrike.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 17, 2026 at 8:32=E2=80=AFAM Andrey Grodzovsky
<andrey.grodzovsky@crowdstrike.com> wrote:
>
> > > > Hey Andrii, getting back to this important topic -
> > > >
> > > > I reviewed the proposed solution and the code . An object-wide
> > > > bpf_object_open_opts flag that means "all programs must be
> > > > considered loadable, but maybe later" collapses two things that nee=
d
> > > > to stay separate: a program that is not currently loaded but may lo=
ad
> > > > later (feature gated, config-driven), and a program that is
> > > > permanently not going to load on this object instance (e.g. it
> > > > targets a kernel symbol/struct field that doesn't exist on the runn=
ing
> > > > kernel, or it lost out to an equivalent alternative implementation =
and
> > > > will never be used). Today those are distinguished by the autoload
> > > > bool: false + never load =3D the second case. If the semantics of "=
not
> > > > autoloaded" change object-wide to "loadable later," we lose the
> > > > ability to express the second case at all -- every non-autoloaded
> > > > program in the object now implicitly carries the cost and risk of
> > > > being treated as eventually loadable, even the ones that never will
> > > > be. So, every non-autoloaded program is implicitly pulled into
> > > > relocation resolution and map creation, since nothing can rule out
> > > > that it might load. For a program that  never will, that's
> > > > wasted preprocessing, and if its relocations fail against this
> > > > kernel's BTF, that failure is no longer isolated to just that progr=
am.
> > > >
> > > > Given this I wonder if it's reasonable to re-evaluate the approach =
of
> > > > per-program enum from the original patch series we prosposed , rath=
er than a
> > > > boolean plus an object-wide opt-in flag. Keeping disabled as its ow=
n
> > > > per-program state (excluded from relocation and map-creation, failu=
res
> > > > isolated) alongside auto and the new dynamic case state gets us
> > > > the capabilities we want without forcing every already-
> > > > disabled program in an object to be reclassified as "maybe loadable=
.
> > > >
> > >
> > > Goodness, 4 month since that discussion... I don't remember all the
> > > details, we can start a new conversation and go over details, but I'm
> > > just about to leave for vacation and Mykyta is still out on vacation,
> > > so I'd suggest to restart this conversation with all the details anew
> > > in about a month of so, if that's ok?
> >
> > Defenetly! So just to clarify, per your advice from earlier in this thr=
ead,
> > we don't plan to rely on the cloned sessions concept anymore and sugges=
t
> > instead to review again the approach we proposed initially [1].
> >
> > >
> > > Explicit tri-state per program vs implicit tri-state (if not
> > > explicitly disabled -> maybe enabled, if per-object setting is set) i=
s
> > > probably not the most blocking part of this. But again, let's come
> > > back to this with fresh heads :)
> >
> > We will gladly review it again and adapt it so that it is acceptable
> > to the community and can be
> > beneficial to all users of libbpf.
> >
> > I will reach out again in the second half of August.
> >
> > Thans,
> > Andrey
> >
> > [1] -https://lore.kernel.org/all/20250122215206.59859-1-slava.imameev@c=
rowdstrike.com/t/#m93ec917b3dfe3115be2a4b6439e2c649c791686d
>
> Hi Andrii,
>
> Following up as promised from our discussion last month regarding
> dynamic program loading.
>
> I reviewed our initial patchset and the subsequent mailing list
> thread. It seems the conversation previously veered into unrelated
> topics, such as concurrent programs loading and dynamic map loading,
> which are beyond the scope of the dynamic program loading capability
> we are trying to introduce.
>
> To recap our main point from July, using a global object-wide flag
> collapses two distinct states: programs that are genuinely disabled
> (e.g., due to missing kernel symbols, where we want failure isolation)
> and programs intended for late, dynamic loading. If we use a
> per-object setting, every non-autoloaded program is forced into
> relocation resolution, potentially causing load failure and wasting
> preprocessing time.
>
> If that is ok with you, I would like to resend the original two-patch
> series as an RFC with a cover letter, rebased and retested against the
> latest bpf-next branch. This way we can review and discuss the
> approach from a clean slate.
>

yes, let's start with resending patches (you can drop RFC, otherwise
CI testing story is worse) and let's go from there.

I'm actually wondering, if we are going to introduce a their auto-load
state from current true/false, whether we should also have a new SEC()
naming convention for such programs so that one can declaratively
specify that this program *might* be loaded after object load, and as
such should go through a proper relocation and other manipulations.
I.e., we have SEC("raw_tp/...") for eager load, SEC("?raw_tp/...") for
default no-load, perhaps we have to add SEC("!raw_tp/...") (or some
other appropriate prefix) for lazy-load programs?

And actually (I won't erase the above, but it just occurred to me)
nowadays perhaps decl_tag is the better way to go. Can you experiment
with this? We can bikeshed on naming later ;)

For bpf_program__set_autoload() API, I *think* we can manage backwards
compatibility by converting bool argument to enum with zero matching
to "don't load", 1 matching to "eagerly load" and 2 will be "lazy load
maybe later if user ask for it".

> Thanks,
> Andrey
> >
> >
> >
> > >
> > >
> > > > Thanks!
> > > > Andrey
> > > > >
> > > > >
> > >
> > > [...]
