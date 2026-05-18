Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A8C937BE72
	for <bpf@vger.kernel.org>; Mon, 18 May 2026 02:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779072652; cv=pass; b=Z0+wBk6+tp2Jw4jAxX02OEL+HQmIA4WZHaplKBeCGlCQsBXBIuwRnWdlVWSML+RJK/XjIAH5SJDFABYTGaBXegBcjhUiIpHQAP9ZfqOnM+fsmwC0amPkXJypZaxO9Xa/UMardqO02nXoYFs0SCu4gY4niJfYxmWSQrl+fHN4vBw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779072652; c=relaxed/simple;
	bh=Ooa7cW2D1IYd9NZSoSPSMtct3nfjHy2qVBuFonf3asI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VrJSY7Cpo0IZIyYd4Dxm8VkI0/6NhQ0ICsUMtbQrLXFnFC9yOwyHL8EHpy3NaJZQG+lAvCy6P2JXyyyNIQF/YMxy1AxKQ4JMhVKdWrih0bjYBpCPUtlR1V8NsEk2v/MM6Fg0lXcWWVuWehiGh10mWuvpmSe/ac8mbhBf6aZ6mF8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eqX8YKKP; arc=pass smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eqX8YKKP"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2b46da8c48eso465ad.1
        for <bpf@vger.kernel.org>; Sun, 17 May 2026 19:50:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779072650; cv=none;
        d=google.com; s=arc-20240605;
        b=QY5k6pNWwgre67wq5d6Zgs5+rYo8j7MT1xEEAraHDj59s9bcZLqyxAh0T95f2sPPFj
         PAoSWrToP8eRWKfDGbpK6GUvbY4tZWyYzV4d9QcqstQZ9XV6YNC1ll9ywHQIUVTUileh
         sxNq2d2KbvHJD6yxpmevPBynROtuJyXbAgBQEBqhGddyrny/fZSPkc1JNvk1Ise1uVRI
         V6t495FdFq1hgHs4w+wnSqiCQvzdJp6MRDeCXN6/h+ami6K2i97g/NRgetXIxmxEtkio
         AEo65+Hbz/OH93dGtHlRhmfjLcvxZ45TfwE7y9Vvja5ASNAb1CROFo+tdpfKSljaq5zA
         y2UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GlQ9sX2+ndV8BDI+ZX/9maNZGwPG1ORF3D1rWw5qgqs=;
        fh=C6bP1IyyYeZlD51LcTDuO7GfXZTXhHaHhel3kaNYt4Y=;
        b=GwLpyWy5W1J+SDowKDaAxQcAmERtenhVlAyiztR2wzHMDXHWpPBSYZzyTGynQcs5ZU
         erxIryJLwWJmI5EWYkBeo5uBb8jJEYIiwSA0LWrfCKy7dsrbSqmorxbFMSIcyvsahhu4
         j5ZUQbkmAwDIxyJtj6KOTLofkSygQCXVz6dOT/Ze4XCiXvC42MXhJmGoypyrKi8IO6Gx
         xtjHT03L3eLn1fiKsqXWTpCktdjqj+EW8q5ZMCOKzPE1FL8AYzY3lKfAGGMKoq4aY2RH
         EwWQlMP0YIg0Bq+BzHGVK/uVBPQkIz/wmKEw7jvhxuB765AuTv3LTpqriSr133orksJi
         DdhA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779072650; x=1779677450; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GlQ9sX2+ndV8BDI+ZX/9maNZGwPG1ORF3D1rWw5qgqs=;
        b=eqX8YKKPAZutACG7bJnDmEJeuLy85BIWejOspQAD9ZKhLyxro09bV8lqVqsfQBmJpU
         loBFNMtDMhl/mxbtfB6DvFlXogCJYq5Ehh9OuFEl3JvPIKz/rwgX0v4wBIu/lxGIfnDi
         r/5ZTKGCgJPYUGi0ngQrvBpVTDAPwBzNIplGcvEBgh03ccLtt+n0JnbiNd1banNilank
         KSpdAlENB2EbpM+vHC+HGa+NoUtey469xo/stGmHoe00q+MDu/ME0Iq2QC0CFxvx92nJ
         e8fOcrnMO4DuCKGkSETAO40t8U6ZCgl/77+sa0qQfUWGmSnuQx0d2VzX+OWpU/f1gg6B
         xrYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779072650; x=1779677450;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GlQ9sX2+ndV8BDI+ZX/9maNZGwPG1ORF3D1rWw5qgqs=;
        b=TjG3XDWv/DwU5C7E67fqiu+LpbZvqKzNcnHPAP0TB18a1xZmC8mHfKw2Qy63PYxwa3
         wt2aK8BY1gPIaiH0Vs8g3wptJUZ6bMpPkAq+6bR60slk0MBul7pZYTvdxbQbhx6xHqpc
         bdbqJ9gJwRbiMIaJKtzt3dLktw/T7nv2DXm9G97EMSiEfJq3Rqz9tU8oxNDHVLX4TpM2
         3+CcCJonJUGsKtMAW7s2NJYrmBow4oR/O1iNKIoQgkttdR23pynvmtNsRKtMMlYCTgwU
         hPtGSREo2SRDBFVnYDEGmJfFLTG2918DLUvJxHFcgbNqynFW/gjKiLYpOCjbV7iVkKyC
         k+wg==
X-Forwarded-Encrypted: i=1; AFNElJ+2N1fYN3/3mPo46x4v8+n7sxoN4mkqHyVaArgitSZ2xGw0nZntUI4dKxzVZf2wA2uHs7A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0d+cqnO0Bysl4a9FpqC+XXhSWARBKuQnxDUdj2hl4BbgR9FFc
	0P+V5kF+eM28tYnB7mfzpCXvNrwIjGjJh8J/kXbwwwG9SqrMjxljHZuHxiggRz13GPoSWavoqud
	SkiSr/7KWgm6rqzkNeRsk/eLS/kprytHVfmnyFxZB
X-Gm-Gg: Acq92OGtV9xfnVGA3nTyS6ex78hwy6NFtttGeVRlAqLu0wnWFYBIrlFVY0gE5YAEszr
	1dWJLHlX1d4D5UMJ272TqPTC6MXRU+rAkqAuD9AGIpAInUzIxS84+T8W6SD6JRSavRpR4ZK/Pyl
	lSpsJdcq28sa3974D+7jNrVchqPySXknV5MnDKuZhG8JfgU7mxgvXOyhqOXR3FDG2aghUW7BwLB
	/+xCb1IwLboEEHPEZ1QkJymsXMlbp2vWJPg4LqlBRZF/oAtvSG2o0BkGwbzXZPKSBLdwib2iCP6
	sNDDFDc+gSv5B/O1Cko=
X-Received: by 2002:a17:902:ebc2:b0:2ba:73c3:49b0 with SMTP id
 d9443c01a7336-2bdb03acb3dmr1784335ad.14.1779072649647; Sun, 17 May 2026
 19:50:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260515193314.1593560-11-irogers@google.com> <20260515195854.1A3C0C2BCB0@smtp.kernel.org>
 <CAP-5=fXM_bGY8uiVa-U9SiFrwY+Dxkrt=s66dfoL9YR7=14Edg@mail.gmail.com> <agpuOvZvo_HNnYsr@z2>
In-Reply-To: <agpuOvZvo_HNnYsr@z2>
From: Ian Rogers <irogers@google.com>
Date: Sun, 17 May 2026 19:50:37 -0700
X-Gm-Features: AVHnY4Jksalie_5MKvIzN7MMZ2hXiEY_ggE5_dwHwA_XCUpwR3bvH9_CRgzrGBs
Message-ID: <CAP-5=fUfUzKVsrOLUZ7d0FsMcWc=vp5hfmL7Yymnj7Zd9L2tWw@mail.gmail.com>
Subject: Re: [PATCH v5 10/14] perf pmu-events: Split big_c_string storage into
 standalone compilation unit
To: Namhyung Kim <namhyung@kernel.org>
Cc: sashiko-reviews@lists.linux.dev, linux-perf-users@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 17, 2026 at 6:41=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> On Fri, May 15, 2026 at 04:25:29PM -0700, Ian Rogers wrote:
> > On Fri, May 15, 2026 at 12:58=E2=80=AFPM <sashiko-bot@kernel.org> wrote=
:
> > >
> > > Thank you for your contribution! Sashiko AI review found 1 potential =
issue(s) to consider:
> > > - [Medium] Incremental build breakage and partial clean failure due t=
o Makefile dependency chaining and Python file closing order.
> > > --
> > >
> > > commit 6c014984ddc9092cbb7ef975a3904baefa427ed5
> > > Author: Ian Rogers <irogers@google.com>
> > >
> > > perf pmu-events: Split big_c_string storage into standalone compilati=
on unit
> > >
> > > This commit splits the large big_c_string literal into a dedicated
> > > pmu-events-string.c file to allow parallel compilation during Kbuild.
> > > It updates jevents.py to output both files and adjusts the Makefile
> > > dependencies to ensure jevents.py is only executed once.
> > >
> > > > In jevents.py, defer closing output_string_file until
> > > > the absolute tail of main() to guarantee identical modification tim=
estamps
> > > > with output_file, preventing redundant rebuilds during incremental =
runs.
> > >
> > > Is this guarantee accurate? Since output_file is never explicitly clo=
sed
> > > in main(), it gets flushed and closed automatically during Python
> > > interpreter shutdown, strictly after main() returns.
> > >
> > > Will this result in pmu-events.c having a slightly newer modification
> > > timestamp than pmu-events-string.c on filesystems with nanosecond
> > > resolution?
> >
> > So previously we were worried about the opposite scenario. Using &:
> > for a group of generated files solves the problem but Linux builds
> > only require GNU make 4.0 not 4.3, which added this group construct.
> > We may need to drop this change as I don't see a way to satisfy
> > Sashiko.
>
> Isn't the message at the end a proposed solution by Sashiko to satisfy
> the problem?  See below ...
>
>
> > > > diff --git a/tools/perf/pmu-events/Build b/tools/perf/pmu-events/Bu=
ild
> > > > --- a/tools/perf/pmu-events/Build
> > > > +++ b/tools/perf/pmu-events/Build
> > >
> > > [ ... ]
> > >
> > > > @@ -224,6 +234,10 @@ endif
> > > >  # and inputs are dependencies.
> > > >  $(PMU_EVENTS_C): $(JEVENTS_DEPS)
> > > >       $(call rule_mkdir)
> > > > -     $(Q)$(call echo-cmd,gen)$(PYTHON) $(JEVENTS_PY) $(JEVENTS_ARC=
H) $(JEVENTS_MODEL) $(OUT_DIR) $@
> > > > +     $(Q)$(call echo-cmd,gen)$(PYTHON) $(JEVENTS_PY) $(JEVENTS_ARC=
H) $(JEVENTS_MODEL) \
> > > > +            $(OUT_DIR) $(PMU_EVENTS_C) $(PMU_EVENTS_STRING_C)
> > > > +
> > > > +$(PMU_EVENTS_STRING_C): $(PMU_EVENTS_C)
> > > > +     @:
> > >
> > > If pmu-events.c consistently ends up newer than pmu-events-string.c
> > > due to the Python teardown order, won't Make permanently see
> > > pmu-events-string.c as out-of-date?
> > >
> > > Could this silently trigger redundant recompilations of pmu-events-st=
ring.o
> > > and relinking of perf on every incremental build?
> > >
> > > Additionally, if pmu-events-string.c is deleted while pmu-events.c
> > > remains up-to-date, Make will execute this dummy recipe and then atte=
mpt
> > > to compile a missing file. Does this pattern handle partial cleanups
> > > gracefully without creating a build regression?
> > >
> > > > diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-even=
ts/jevents.py
> > > > --- a/tools/perf/pmu-events/jevents.py
> > > > +++ b/tools/perf/pmu-events/jevents.py
> > >
> > > [ ... ]
> > >
> > > > @@ -1476,6 +1488,8 @@ struct pmu_table_entry {
> > > >    print_mapping_table(archs)
> > > >    print_system_mapping_table()
> > > >    print_metricgroups()
> > > > +  if _args.output_string_file:
> > > > +    _args.output_string_file.close()
> > > >
> > > >  if __name__ =3D=3D '__main__':
> > > >    main()
> > >
> > > Should _args.output_file.close() be added here alongside
> > > output_string_file.close() to ensure their final filesystem writes ha=
ppen
> > > simultaneously before interpreter shutdown?
>
> ... here.  Or, maybe you can call os.utime().

Let's give it a try.

Thanks,
Ian

> Thanks,
> Namhyung
>
