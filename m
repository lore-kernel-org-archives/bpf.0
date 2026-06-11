Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F9463B636A
	for <bpf@vger.kernel.org>; Thu, 11 Jun 2026 07:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781162069; cv=pass; b=VHnVQkwirx6HuMLiPLxHTsgq3q++IL7cCKU+ynn7teUxcS0RwPTfjhioDk0SkolpGI37utVpENO2E7MX+pnyBh7qOiQsknK6LKVCL7WPG8huA/jvSZmg1CzsHBT43Wa+0ExthjtOO+tQckNLwWjU4M34UTnUYUPBbj2XM8TeRGM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781162069; c=relaxed/simple;
	bh=LaLu0ei2yC0WN2S4l4Sm1HIA5UTS3G0Rf2gbgD78kYM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U0OYrN7N4sxR59p3mHU+54RfsxEK39nBlwb/ULnWdIaB5ojesZSgkiODXylJhf8JQCKXISmdwqf2jE37Flrx8oxwaMhrDdPqKSDwA6I39lK/lFDqCjVnMQ6EkaUe7bQ2rR9O8/Cot7ScARUHGQefoiZRTbeDzb8V11p1/eqRaf8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Esfhz6vA; arc=pass smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Esfhz6vA"
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-66077e888b2so7636805d50.3
        for <bpf@vger.kernel.org>; Thu, 11 Jun 2026 00:14:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781162067; cv=none;
        d=google.com; s=arc-20240605;
        b=MamLb/31hM9YUNGU/+uxXcwWSHTuqQblfCV5H4xZignK+wYeEYDRZDKH6Ju7YugCyX
         Nr1snFf6xaQObewav9UNenYKwqMDNr8nSzfSGXjwTKe2KtLr7Z9688ZYnyAUUkw5qraw
         QCP47jduBCueluAS/XO08bimDkGc/Ozz98VspzVw/fk0lKZn8KNu+etihUUQ0u0/hCox
         NXuzmLc1p9buCpm3gAa9+FzC0BXcyvV5Mxtw7vnmFgtr1HPLrsibUaFkEDbhr9XYZpii
         rRZMQmekzAjSkNIoBdB8tXgvoqIx2zQSkdYzZQzbnMNKbGhpS1IThrtm4SgkDbGSrz3k
         rgWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GjwvHah3OGukX9xzSqK99XscYrnIt8dls7UMLocE7GE=;
        fh=uA360uvxR9S0K/Y4Lovo7aIaGlBwzVBnnb2BKWupr/4=;
        b=AuUUZveS/E6/z1hDr6ovHbGjLVC9Awmr92ITH25TywdILB1uuJ6blDKXsQJTUWY69s
         Hz8nKan2EE3eyCgWgJpQWEAD9TA+vfEivBPuQ41Fh4FtfkuG+okz/AsGo3uBmQUPv0+a
         Tp8m+dad8wtDnS8p+sDM5L2/sjhZPiIwi+rQqxM7r5lv84mmWetPxRgiCyQYb7Xp0Zb+
         ssX56m/OqjmL/WLXKFvD4aSrh6nGDSZlc71FbQkLPkFikW6qsiFHsh3bAEPuhA0ERr/8
         JuHOxKKO6ohuL3HAdd5ffi4BvnnX7LvKu2xGwfjRyGrj3Sp6OWowpT8l253KzvIApqjU
         VONg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781162067; x=1781766867; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GjwvHah3OGukX9xzSqK99XscYrnIt8dls7UMLocE7GE=;
        b=Esfhz6vARHDXkTn7hu/xbEsya0KZ7j1ZlGCJyDqK+yYNBtwKChbfpvu0DgQuYjCN/x
         BypfmSI99AMQq6ljEGypOtft+T58JG4RDD1cEHgnbdCUbP8YUWcgko260/FdjLk+Ljx1
         2+++gqIB6Kd8wDP9rmLOSu0B5wqdg8O/TpQG9Pftoa4KVCXQYK8QRGnfuoE2Id6a4ISU
         rGpyFDolFO/bUn/plmUTgJJfLWUWywpk63dNDKIxy+QI2BMMy/iDhcCkJLPGC6/va3yf
         rMdfyAGBafUqmu5FYhrY1u7GudrcAqDE6azO1YRMHxiGSrcE4NawIWcZnB/FlLrRCdda
         ZZ9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781162067; x=1781766867;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GjwvHah3OGukX9xzSqK99XscYrnIt8dls7UMLocE7GE=;
        b=W4oFkxxs1+bwXM6Ait6TPX2qOitPSdbWs8pVNWLpqSd2bgVD+B+sz/xD/3q4oz4d/n
         o/lO118KMGVHeqw+ZbDsaV98pkyDlSd65o1T77gdiELVtex/W/i5CpuhBoGuaEfn0+AB
         Ay0UDSHfhWSGGPHWJQseFMHmsh1BkWXe+t/a13xw3ZYfSAlSiO2iFDaYyXJNtVZfIN34
         r7hqXtSWb95xmzaMmvLwjlAlUROVrZPMvd0TRN9NdQbG7f4iUK484g3QPt6u/xDLhddU
         BKS0UEG9LmDc+do291bvXYLSENCrKj2Mk5JLX4eOsRdj75b+yoyjSSDnniKPzZSpEa/s
         Wuow==
X-Gm-Message-State: AOJu0Yyn6DTZ+6LP0GPRnbQgcoTFtD0Fyk9UWY52rMUsD/bad0zy/3H5
	IEwqhWQqlECav3MyIV1CxwgmaxZpVUefmyQpcR2KukSbYf+jaIJuUVkx77isXizKqTXe5ozyl/3
	+zDVKC3+sylVPA1/oW7M3OyUdjFRSlBQ=
X-Gm-Gg: Acq92OGa8msC4EfvawfHeKJY+jCKB5aQyeO5N27M6AALDWmBViIFKspZ0WATxOv7MD0
	F7RGPPVpSf97oCJ7WUjCqbGNCtY+jcY/YC/K/seiWOHx9LaR7eDOYhRTxDbSbmZCvTEjd96F6Yo
	g5TwNb1IezVwm0aNbwARCFMU3XEkNPSJAo52RDcO7oCbrzGkAzAjXY01laZmPn4IRSc4PqHGnWQ
	uOOWOsmEjgurB6plh1Wo0NzFIS4aH0mh07tBusXvLItgeECiOf+xOj1r45HwT9/5YOh9j3RyJ0U
	QD82WrssycHpkt3PIDEXHJpu7twCUTjMfZv3lunm0fqxp846XxQvp5dwbvQ1+K+YGr4lfL1ja0p
	lYBs6
X-Received: by 2002:a05:690e:480c:b0:65e:20b1:e963 with SMTP id
 956f58d0204a3-6626986c14amr839447d50.34.1781162067120; Thu, 11 Jun 2026
 00:14:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260611043317.512843-3-sun.jian.kdev@gmail.com> <20260611044722.174351F00893@smtp.kernel.org>
In-Reply-To: <20260611044722.174351F00893@smtp.kernel.org>
From: sun jian <sun.jian.kdev@gmail.com>
Date: Thu, 11 Jun 2026 15:14:16 +0800
X-Gm-Features: AVVi8CdTMjhN_TbxNVF-V5AimCd7-pfZXPvv7Jc7KtCcCcWlkevfdchOdbxr8so
Message-ID: <CABFUUZFGa205D7hAQiOK6h=Y6iLaiDvBU=8TjQObtcqhf0=Lig@mail.gmail.com>
Subject: Re: [PATCH bpf v3 2/2] selftests/bpf: Cover generic devmap egress
 last-dst rewrite
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 11, 2026 at 12:47=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
>
> Pre-existing issues:
> - [High] Uninitialized `net_config` is passed to `cleanup_network()` on e=
arly error paths, causing arbitrary shell commands to be executed via `syst=
em()`.
> --
>
> commit 60bbc3bd1e74368d2d682d8956f86b733750dfd9
> Author: Sun Jian <sun.jian.kdev@gmail.com>
> selftests/bpf: Cover generic devmap egress last-dst rewrite
>
> This patch strengthens xdp_veth_egress to check that destinations observe
> the correct MAC address for their own egress ifindex. It also adds a new
> generic XDP last-destination test to cover cases where earlier destinatio=
ns
> do not have a devmap egress program.
>
> > diff --git a/tools/testing/selftests/bpf/prog_tests/test_xdp_veth.c b/t=
ools/testing/selftests/bpf/prog_tests/test_xdp_veth.c
> > index 3e98a16659362..681415cacb75c 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/test_xdp_veth.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/test_xdp_veth.c
> [ ... ]
> > +static void xdp_veth_egress_last_dst(u32 flags)
> > +{
> [ ... ]
> > +     struct net_configuration net_config;
> > +     int mac_map, egress_map, res_map;
> > +     struct nstoken *nstoken =3D NULL;
> > +     struct xdp_dummy *xdp_dummy;
> > +     __be64 last_mac =3D 0;
> > +     bool found =3D false;
> > +     int err;
> > +     int i;
> > +
> > +     xdp_dummy =3D xdp_dummy__open_and_load();
> > +     if (!ASSERT_OK_PTR(xdp_dummy, "xdp_dummy__open_and_load"))
> > +             return;
> > +
> > +     xdp_redirect_multi_kern =3D xdp_redirect_multi_kern__open_and_loa=
d();
> > +     if (!ASSERT_OK_PTR(xdp_redirect_multi_kern, "xdp_redirect_multi_k=
ern__open_and_load"))
> > +             goto destroy_xdp_dummy;
> > +
> > +     xdp_redirect_map =3D xdp_redirect_map__open_and_load();
> > +     if (!ASSERT_OK_PTR(xdp_redirect_map, "xdp_redirect_map__open_and_=
load"))
> > +             goto destroy_xdp_redirect_multi_kern;
> > +
> > +     if (!ASSERT_OK(create_network(&net_config), "create network"))
> > +             goto destroy_xdp_redirect_map;
> [ ... ]
> > +destroy_xdp_redirect_map:
> > +     close_netns(nstoken);
> > +     xdp_redirect_map__destroy(xdp_redirect_map);
> > +destroy_xdp_redirect_multi_kern:
> > +     xdp_redirect_multi_kern__destroy(xdp_redirect_multi_kern);
> > +destroy_xdp_dummy:
> > +     xdp_dummy__destroy(xdp_dummy);
> > +
> > +     cleanup_network(&net_config);
>
> [Severity: High]
> This isn't a bug introduced by this patch, but does this early error
> handling path pass uninitialized stack memory to cleanup_network()?
>
> If xdp_redirect_multi_kern__open_and_load() or
> xdp_redirect_map__open_and_load() fail before create_network() is called,
> the goto labels eventually reach cleanup_network(&net_config).
>
> Since cleanup_network() passes net_config fields like ns0_name to SYS_NOF=
AIL
> which executes system commands, could passing uninitialized stack garbage
> here lead to unpredictable shell command execution as root?
>
> Would it be safer to zero-initialize net_config with `=3D {}` when declar=
ing it?
>
> > +}
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260611043317.51=
2843-1-sun.jian.kdev@gmail.com?part=3D2

Thanks for the review.

I will zero-initialize net_config in the new test in v4, so the cleanup
path is safe even if an earlier setup step fails before create_network()
initializes it.

Thanks,
Jian
