Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D745638A701
	for <bpf@vger.kernel.org>; Thu, 16 Apr 2026 07:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776324092; cv=pass; b=I7Or7fiFQDTxkKfOpZzYLl6qFN9AEWohC7siMVukFkpKFHoXorIw0ayuMQKPfsGExPJ5VXGNtg+VG+oCFPjUZGFMS3w/855Vjd95OnKil5HzITzIsecQ/bPAWBCqYD8X22ed7ZgAqLTSxxiYMchkyYn/VKq4Lmh7qtFrE0ne07M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776324092; c=relaxed/simple;
	bh=fP6j1XtUXSckzJBc7NURdhAC7IQvfqutJknLh8SHloI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lr8oUnpseWV5P6Z6SYKYWpApr9jc7yt4l8VhyGi85G0OUqeYKZxONuGa+rRe+cb+MSV58UttGOI3GRTAQPkAtFnJ0SuuMkVRA+Lknj4YB2/a0a479BZ6mZRiHQUgxXS62YqwNau1wg/ZLWkB3Jwp8VaS0+WV7oBWci2CHbCo3Sg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g16tiO03; arc=pass smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g16tiO03"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-794719afcd4so82658007b3.1
        for <bpf@vger.kernel.org>; Thu, 16 Apr 2026 00:21:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776324088; cv=none;
        d=google.com; s=arc-20240605;
        b=FkEGeMqcHQrLGDFROQ+4FtEECFyNyiH0AENkaOoIv8gcDqrbyYcS4RmO+4axrQyiwX
         ZFFyhtAUcSnnccDiyEsv07kzQttKn3fjY6mCm5pPmVeYxSg9w9ljs4zgW487hRnyrfsO
         Ev7XapBWGdJMA3NUhGxY//Is7HvtGOa9fumPv5cfPE1h9AalXVluqzxdbtfnbG9NQpfE
         Trc9sFNmqumwLoSu0gfk1lWnRYaEJh+iIgw/PTijZmpiSsBzLQb0LGH8ChuqpIi0C0pC
         3KauUztGlU8pAmKgThh4Atzw5SazK2ZqYqvI4uwxZx6WmfJCXne7CiNJe8wvxXy74yX0
         vx1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SgJI+wn/rzi6w3jAE8cI3cBqDzSXn/0LiK900Y3n82o=;
        fh=Emqdds5EqNOJ+YSWcFSc3ksYF3iDQplIEffyrGItPt4=;
        b=c7mSKlCelhb5wgtbgqR1nasfWSAVbvewGSXoWZaXu4rdRIYNsA7NBI/LZ3ALBZJOh9
         YsepHBjFvtv+EcZRyob2a/xpDBR3yQcOLyvjrtH8IHhBTbDhf1bUYWcOjAbIKlDBkIUt
         p+jLsvU61Hj5E1Rs/sd5UaUu68Wc+7sfhAzv0ggbJwEbXHgA6hg3QBK3beg92TzhOMt4
         cKgumSIJ4F7BPFCJMhot+GxMmBZ8gWb55mI+yajryZHq9Dlm1PnjfIRY7R30HfY3sX4m
         dmDGbpGXGhaongFT4QmMG4Wq4zqEAgZOQbi7hSVOhGBtXyCCoANktVVLulokX0ia3+Dq
         s4MA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776324088; x=1776928888; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SgJI+wn/rzi6w3jAE8cI3cBqDzSXn/0LiK900Y3n82o=;
        b=g16tiO03KM1Bg3Sh6N9u8UT5o7l0XptMBnZuyOmLjJKRCekIKjy1XTwyDsb5TGPQRe
         WwvP8BqLjxFsIGwsXpNsdvinRUPGM4vqK7VV9O+8TEQOiBI1OK1iGmAJY9rmjxNRvn42
         z63kmPYVV71e94u6SxinjRw9VuRCM8AVs6PfNVycXgrMYUEyihhWmfb4ZEVDyn9GKXY9
         MajP30HVaUGdBKtjy5kTa8saToh974XAIUkK4RRzJReNLDxhbPny17HKM/nhtcrG5ds+
         Hg3RM+wAKqaAmCwUFGjGQu7k8WsutOfPZ9+OC1l1RJ5zu547Vvu37FxF3seu8WMYfZHM
         J6fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776324088; x=1776928888;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SgJI+wn/rzi6w3jAE8cI3cBqDzSXn/0LiK900Y3n82o=;
        b=GqQkQ9Z0KssQFMqNV54KxQ5/NWsJJl6N2ZVmo+TH9eSjW5XXG00KVXX0xYVQvTFEgs
         SiDYBk0AA68TQW7y4vn8kAzQHi1taKt9XtlU1/XMs1TakMIETqYa6WX8YMY/IaRrsrHz
         Z9KXArPk5/udmm5O2mDGQkRbolITmkQk1DMwwB0nk+yskxETEPblflMokTAeUIqql447
         y5ghpmNYayVKZBtObyf3ibr3vC+jZuSyKVbwCK/vSnvx4T+Rht4OEVfKVt+VfYEtvW7u
         AMnrLRYltNNIFFo9/StmPlWWj+hwRa0k/1kL8j/9PZptiyPV7Ndl5fK8jzmrelQXTlfd
         06Bg==
X-Gm-Message-State: AOJu0YyOf4P58Jn8kSOfH9VHWlfd3WqdzkCyw2+sf1+NCJXHmrMxYoGI
	PTE3rVY7jilbRgCmEych4q7+pp5T9qcEjpxvOUGJwWFdbho65Xm7SKC9VL4hNMZWeaOyFOq0uKk
	KzAdbpDurL8yj6pfrqvNNQf8ECnikBu8=
X-Gm-Gg: AeBDieuPmv5S8ibTUpjfniavyzdsDxVDldsnXCkArWey8C0sBQ2AVodtLoNMtR9+opp
	yw0BEe3WFT5I08TC6PW+tzJYoTt5HSGpDrIqeUKJN+UXBWCNfr45IFtMTYPr1mBLdkal+V5VH/q
	BGijxWFn2B1BKRIUGTgxaxzmRbBnQpih/+4HcCgJ00F4y8O7iLYq/00VvbC+KfEYHn795xdaGOw
	RFOwDhty/Fg9cDZZo9lpEBsB/pkzNF2XYx2SDVE09JGQYY0ZQykrf8I6ekbZ7e6RnQcs2y3AzrR
	VANKrS57ZQd3JHInuB9rx0LxgwjdTmoOkH4DD5Gr
X-Received: by 2002:a05:690c:112:b0:7b2:dad2:5dfc with SMTP id
 00721157ae682-7b2dad260f2mr156752577b3.6.1776324088473; Thu, 16 Apr 2026
 00:21:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260408175217.1011024-1-song@kernel.org> <CALOAHbBpK7YBz2Y8YWL0=0dLz5DLUa003y4b8SMgB+BVjePeOw@mail.gmail.com>
 <CAPhsuW6-YEkJYKiC7M_jBsJWRT38B0AN0Y8x+yWKn9cHoVu=Uw@mail.gmail.com>
 <CALOAHbC1K=3y-U327GtrJO93f1ra2jxg3mh865DSuEG+VFbMSA@mail.gmail.com> <CAPhsuW53pymgmFsHSkSwDvEAJ=+Rp2T102JYe4i9kgdePpR=6Q@mail.gmail.com>
In-Reply-To: <CAPhsuW53pymgmFsHSkSwDvEAJ=+Rp2T102JYe4i9kgdePpR=6Q@mail.gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Thu, 16 Apr 2026 15:20:51 +0800
X-Gm-Features: AQROBzDOGkEdLUiHQlF_BQow4xtYT1blagLbEEkgjBV9oRu8e8ZESAI02iBDgNI
Message-ID: <CALOAHbDiGmi6yAKoy+sPB+QUCRJO-gizyr3sV2s7XnGW1zSyCA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: Add BPF struct_ops + livepatch
 integration test
To: Song Liu <song@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, memxor@gmail.com, 
	yonghong.song@linux.dev, jolsa@kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 15, 2026 at 6:17=E2=80=AFAM Song Liu <song@kernel.org> wrote:
>
> On Mon, Apr 13, 2026 at 11:56=E2=80=AFPM Yafang Shao <laoar.shao@gmail.co=
m> wrote:
> >
> > On Tue, Apr 14, 2026 at 5:42=E2=80=AFAM Song Liu <song@kernel.org> wrot=
e:
> > >
> > > On Sun, Apr 12, 2026 at 1:44=E2=80=AFAM Yafang Shao <laoar.shao@gmail=
.com> wrote:
> > > [...]
> > > > > +
> > > > > +/* --- Module init/exit --- */
> > > > > +
> > > > > +static int __init test_klp_bpf_init(void)
> > > > > +{
> > > > > +       int ret;
> > > > > +
> > > > > +       ret =3D register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OP=
S,
> > > > > +                                       &klp_bpf_kfunc_set);
> > > > > +       ret =3D ret ?: register_bpf_struct_ops(&bpf_klp_bpf_cmdli=
ne_ops,
> > > > > +                                            klp_bpf_cmdline_ops)=
;
> > > >
> > > > Is it possible to integrate this BTF registration directly into
> > > > klp-build? It appears we might need to extend scripts/livepatch/ini=
t.c
> > > > to provide the necessary support.
> > >
> > > Can you try the attached patch and see whether it works?
> >
> > While your klp-build.patch generates the necessary BTF for the
> > livepatch, it doesn't actually handle the registration of specific
> > struct_ops like klp_bpf_cmdline_ops, does it?
> >
> > Consequently, this struct_ops approach seems to require a hand-written
> > kernel module rather than a patch-generated one, as we can't trigger
> > register_bpf_struct_ops() from a .patch file without modifying
> > scripts/livepatch/init.c.
> >
> > The primary motivation for staying with the .patch workflow is the
> > scope: a standard kernel module is restricted to exported symbols,
> > whereas a patch-generated module grants us access to non-exported
> > functions. Am I missing any alternative workarounds?
>
> There are other ways to access non-exported symbols. :) But I agree
> that binary diff based solutions (klp-build, kpatch-build) have their
> advantages.
>
> 0001-objtool-klp-Build-proper-BTF-for-the-livepatch-modul.patch
> (attached) seems to work for this. It is not very clean though.
>
> I tested it with 0001-test-klp-build-btf.patch (also attached) as:
>
> ./scripts/livepatch/klp-build -e scripts/livepatch/test_klp_bpf_ops.c
> 0001-test-klp-build-btf.patch

I tested the case you provided, and it performed as expected.

>
> Does this work for your use cases?

I haven't tested this with my specific use case yet, but I expect it
will work as intended. I=E2=80=99ll set aside some time to verify it shortl=
y.

Could you please submit an official patch?

--
Regards
Yafang
