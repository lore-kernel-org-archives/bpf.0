Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFA0437755A
	for <bpf@vger.kernel.org>; Mon, 18 May 2026 02:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779071627; cv=pass; b=Gu8vgSxhmhQYs7B7+6GxeLRQf3V6C/G+NP7X8Zjb80FCgsalt4l/2wrH4REFj2PU04oZviL9UCzWL1Jeo5u2hEqVMwXoZ4oCm7/sCj8Rprzw5PFiXCcJHorqsQHQQ1rkt1KG67a9AjgF5jkMB8woXN5y7zT2k3CHTDDCTHhA8vk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779071627; c=relaxed/simple;
	bh=GRfJM5PQjpTrzvgSOa0uhL71TgDCLDRCggiOFgtBxWM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pi4qPkKDwrIndd7Oy15IrbgweJrk0d4TEF6EH9xfNm0R//+x94W2KN/yCzjkArfEqIBKQCsjXF1T1J3tTditKSUOs7QYaIKHqfGtu8bY36Rlit5aKMyPmJ3bI7LPnx81cGNE8ymXjAqiyXDj3E8jZYGBWz2GeIydf3Qag5KwquM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iuiqvcsO; arc=pass smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iuiqvcsO"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2ba3b9bcf69so395ad.0
        for <bpf@vger.kernel.org>; Sun, 17 May 2026 19:33:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779071625; cv=none;
        d=google.com; s=arc-20240605;
        b=Um/QdHMTONok/ObIoBe6isNM6GIPdbqurPyJV2JC9VaNKU+BDHeP1EKoixmnJefgPx
         hXOZ0Tpd3XctpcMFO//0jh9Ltka6XjIeKyklNH7kIDiOAadWPVsIYEbh5OTvJa1Rwv3n
         yPgiPXO2eIVhMozjWzOm7qkReVfaROm+1vKGYQErbr1+zRvZPWlDKkqjb2ygMjr4bSEE
         qdmdBB5UfN0iUkKLcTg+Z7u1OZowAGeOUDaFJdTO9izgc3JV0KhBumXHZ32b3Zr6d/zU
         d4smPLmx9OaIPr8Qs5Sdza2pcLahMj7RjwjcykyfElJio7AmCU4SITUN+STa2v8S6L4+
         4kmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KfwKCx1/f4e0pdku/kXDPetDvANMNpQiE7tYMYwLs8s=;
        fh=I8GTOxc7bd+UH+7rpfkCb24dKX6uI8Ymdqvi7o85NEc=;
        b=haQzZjZLm6Jy8zXrI+TogAaBGIwEaRvi7qhbkIECesW6Ooh7oRCUxTWHHBFmlJIhz5
         1i+Zsn9VhGXiDKxQL7xmtFdM/Y8bb4TC+uagMJjMohbD6YgXmAk1Gvy+LVLvFzSoV6X/
         Qam7Lpp0rokMIPXfCYkWoUx/v9O7qocCCnIa/77h58jUsUBRDLnOezcEBIzI5qfSJAJw
         aypN8RsGX6srHYrx76e3ox7Pf4Vlz0Sfzvur9CZhqMCeep4rzosHF7KqR7G1PfL/GCRF
         NpzdPWCGdjWQGk/RKKmW3+Pg4Kjof8Gw8BfVe7G/J4glP3EgXiywSeV3rnT7h6jPYRfw
         S1QQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779071625; x=1779676425; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KfwKCx1/f4e0pdku/kXDPetDvANMNpQiE7tYMYwLs8s=;
        b=iuiqvcsOySnoE4a6JG2ZkDlg9tRf0cPkXtPQtUMYjFuwIqVT8PlGB76raidfx1Wryx
         wgKxxIRANER+GfU7GnydKpH+MKwjnT3hPfdjUKO9igwdcumi8cuTgQUjMdpzBsPFgiAD
         hiYvMwn+2f435+Ti9aLluOZ0PzBgUonNN6y1/2HF1x1YoQMCHVR4Zb9lqQYh88jrH09T
         Y92ccir33wmPVQnqzOhMSfMxgn66nf/SHDqz4rMfAq72tUKUZQJQJNA2AhiRHsUO0Pgs
         mzisjqON//QGRbRafE87ZmPRjB19JK4g65wUFwWbuykGYzWcKtAoQXJaRT86iTsn87k6
         ExVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779071625; x=1779676425;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KfwKCx1/f4e0pdku/kXDPetDvANMNpQiE7tYMYwLs8s=;
        b=ij5VJB0bzr++k5nNiVBfWyeO+GNBBFQoAMsFL3+Ks+rKPhizelrBFGbKOXpAVl0rr0
         1/VY3H3W2/Vzwu8h72aRVtZmPzTVX1cx9HhTjn7A+NxPnHoLEpiCv5oSjGxigEzUWxL2
         Xp+R8skg/4RR2nQA8HDRfbHUc8M/+ZqDPo1qDXwr3OBVfe4eCYLR5D+hMC7qyEIZQgpF
         lXhv+vEH7DogUgQZebtNoPFJShQUN67zQ93ouKIFku9WqCyQ9b29Atpg48mDqA0+hSQZ
         /P7sd7kd2GFngROXhL/FTIEbQGVoOJS/4T99CQ/hmA+adxOwoHz0TocvjS2BXFh3P3T9
         N58w==
X-Forwarded-Encrypted: i=1; AFNElJ/3XAPfsE2nMhriLE47p/bGNGg9g16+1AV2FJ4mdWqN+RB5X2IWvQk81bstcCeqZ63tfA0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEFkkbq+WZiLpfIlYMEILBLqxlE6lQrBA3zzf8JND0ue7NjcVZ
	xC7MjX3Q1BikYSnXEXT2MljL2KTEJ5jwaCGdP51Iaj0oeGcAtQdpkmMQS1OJUWuihO779bwMK26
	5so1nXRb8DE+CBdrQY1m+FuL2Zxeh9mMHVt8x9KNj
X-Gm-Gg: Acq92OFUHCTNgDAvq2Y1PhksNu3df9Ld5jMfhMsPmL+ixdXTUsBUmS8VGBhoojnSeGN
	89p7QOxpBdmRDX9eGiQ/TxatUvcqZNuzBymrdHVny+L0mxV4Eiibv5sL1flZf7zt6Y2nl1vxgzX
	IYygQZZG3UXj/D0UrBkVT2U4ygXS6SalPNm/h1hWGjv9DfGRlE8M8qL/8232FK1Du5JE7YlJrcR
	HxT1w/tdex33ljGqG958qFnnFViSHrKXp69terjzE5WW3As27xRt3hKX+m5A97RWEoiXOmEheda
	BYZ1IYWLD/kPMvIhwJQ=
X-Received: by 2002:a17:902:c950:b0:2b2:70ba:305c with SMTP id
 d9443c01a7336-2bdb03a2cf7mr1481185ad.8.1779071624450; Sun, 17 May 2026
 19:33:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAP-5=fWfrGMV4EafqkwQO-R33c_szXcxVLgH0c4k2zt3zj4HdQ@mail.gmail.com>
 <20260515173852.1378571-1-irogers@google.com> <20260515173852.1378571-12-irogers@google.com>
 <agd2-MgXgs---InR@google.com> <CAP-5=fXSLgN6hXtQattTp9gqxBkO1gi97EWRF45_0ZKQcK0Z+A@mail.gmail.com>
 <agpi522tGtMWwvld@z2>
In-Reply-To: <agpi522tGtMWwvld@z2>
From: Ian Rogers <irogers@google.com>
Date: Sun, 17 May 2026 19:33:32 -0700
X-Gm-Features: AVHnY4IFZjnockrPWbcy8Dn3abkT6Rc1-0dHFVIPM7KmDbOMaVeLkTDBICdVaI4
Message-ID: <CAP-5=fXJhx6enPranMaTsDcbf86bJMx7kvHeRGSFkA_+8mRB6g@mail.gmail.com>
Subject: Re: [PATCH v4 11/14] perf pmu-events: Parallelize JSON and metric
 pre-computation in jevents.py
To: Namhyung Kim <namhyung@kernel.org>
Cc: acme@kernel.org, james.clark@linaro.org, 9erthalion6@gmail.com, 
	adrian.hunter@intel.com, alex@ghiti.fr, alexandre.chartre@oracle.com, 
	andrii@kernel.org, ankur.a.arora@oracle.com, aou@eecs.berkeley.edu, 
	bpf@vger.kernel.org, collin.funk1@gmail.com, costa.shul@redhat.com, 
	daniel@iogearbox.net, dapeng1.mi@linux.intel.com, dsterba@suse.com, 
	eddyz87@gmail.com, howardchu95@gmail.com, jolsa@kernel.org, leo.yan@arm.com, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	martin.lau@linux.dev, memxor@gmail.com, mingo@redhat.com, mmayer@broadcom.com, 
	nathan@kernel.org, palmer@dabbelt.com, peterz@infradead.org, pjw@kernel.org, 
	qmo@kernel.org, ricky.ringler@proton.me, song@kernel.org, 
	swapnil.sapkal@amd.com, terrelln@fb.com, tglozar@redhat.com, 
	thomas.falcon@intel.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 17, 2026 at 5:52=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Fri, May 15, 2026 at 04:05:40PM -0700, Ian Rogers wrote:
> > On Fri, May 15, 2026 at 12:41=E2=80=AFPM Namhyung Kim <namhyung@kernel.=
org> wrote:
> > >
> > > On Fri, May 15, 2026 at 10:38:48AM -0700, Ian Rogers wrote:
> > > > Currently, jevents.py parses hundreds of JSON event and metric file=
s
> > > > sequentially across all CPU architectures during Kbuild startup, ta=
king
> > > > ~3.3 seconds of pure single-core execution time.
> > >
> > > I'm curious about this.  Does it really need to parse all architectur=
es?
> > > Oh... is it for perf stat record/report?
> >
> > So it is controlled by JEVENTS_ARCH and JEVENTS_MODEL:
> > https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-nex=
t.git/tree/tools/perf/pmu-events/Build?h=3Dperf-tools-next#n24
> > The default for JEVENTS_ARCH is SRCARCH (e.g. x86) while JEVENTS_MODEL
> > defaults to "all". We have a build test for JEVENTS_ARCH is "all":
> > https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-nex=
t.git/tree/tools/perf/tests/make?h=3Dperf-tools-next#n74
> > So saying "all CPU architectures" is a bit over the top, but not
> > wholly inaccurate.
>
> Ok, so it's all x86 models.  I think it's ok to have "all" for build
> tests.
>
> >
> > Fwiw, I created a script to convert CPUIDs into models:
> > https://web.git.kernel.org/pub/scm/linux/kernel/git/perf/perf-tools-nex=
t.git/tree/tools/perf/pmu-events/models.py?h=3Dperf-tools-next
> > which maybe could be used to reduce the perf binary size by building
> > only the native CPU's JSON. It is a useful script for debugging :-)
>
> Sounds like it should be used by default to pick the current model.

Having a build of perf tied to a particular model like Skylake,
doesn't seem very good for distributions. I think the default should
try to match what we hope the distributions will do, so an x86 binary
should run on all x86 models.

Thanks,
Ian

> Thanks,
> Namhyung
>
