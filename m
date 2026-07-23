Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6082F353A8B
	for <bpf@vger.kernel.org>; Thu, 23 Jul 2026 21:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784843942; cv=none; b=j4Ym5vPki0wYC3eXOuOH1eF8z/aGfU4R3XM5iG0QboUNf40skcagIo3ODFlP7hzNoNxPkE4M8GkAS8IEjSHGohA/299zweHiyo0jdTJMUwBpqwvNiEiC6I4YMS8lscKtpIrv2JYDQGLMN1GqZ3YThjJtYtHKkmjP9p6h7hb5cRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784843942; c=relaxed/simple;
	bh=S92BHmzhmzJJfpiajOTJ9THXi/yV2/8OcPnP9pvuLhI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Cf6TQM0l2BDoVEjUoApylslhRKxZT6YP3IKqt52l7P3vPoBU4ECTU1MrpGcE6EIZLjTj81FU8Z4Rd3CCW4L+1xnBIq1vOzzmRmq29ySqwCFCyXlCdSfWzgOF8ipOXKPFpdJQkRui9raEwbAaOhGp/d007GxSAKa+Te6lLGnixxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S+UGsFDA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S+UGsFDA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A1731F00AC4
	for <bpf@vger.kernel.org>; Thu, 23 Jul 2026 21:58:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784843938;
	bh=cB/4Q6ws9Dp5HezRBNTBRNZglzjoQdmli5hTtPFTcpg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=S+UGsFDAJkhDmT8RoAvCPBYMg5p9hT6lvDwkKRSD1YZsf2VXhQbdiUOG62SqDM4Is
	 zauIVbG2GWJJ8tLHtROIi5LHEQZx+abeeytYn27MRt892t7pjpQ8qr/yH66LkuADGN
	 sjonSMy0PDAd33OSUFDWWrrv1NcHLadwmqy+/1O1IXht/Kf8gbTeE3uqIlfpyZsi7n
	 UMFzkcP1xu4kDjIDP3h8LQJTupRg2tKMbfKJgFCZ9uip27DA4R9plBYisOl5Nh1/bC
	 7Lj4z6ps3F4RSfCy9HsWQHI2YK0g51RQmh4H4+LE9Wy6SRK/KtTANvqMTJ8L45D1z/
	 9r3l9HLseHeaA==
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-92e5d50b0dbso91667085a.1
        for <bpf@vger.kernel.org>; Thu, 23 Jul 2026 14:58:58 -0700 (PDT)
X-Gm-Message-State: AOJu0YyshG/DixLIFgMNSdY5RP7ZFqAztNHua9g20BOfldGIjzo69ur/
	qODDdxfzZ0uvXSlLe8KVOJ3k+NAato6M32EArprqo4DsTJNXqseKh/VRWirBFxM1o1jZ/eSmECt
	ik9nRP/+2hEe7aMZLGatdqnNnHAKtz9E=
X-Received: by 2002:a05:620a:4546:b0:92e:7ef3:213f with SMTP id
 af79cd13be357-93103846066mr499060085a.23.1784843937420; Thu, 23 Jul 2026
 14:58:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260722065308.4116186-1-song@kernel.org> <20260722065308.4116186-3-song@kernel.org>
 <amJhnbom_expRgN2@krava>
In-Reply-To: <amJhnbom_expRgN2@krava>
From: Song Liu <song@kernel.org>
Date: Thu, 23 Jul 2026 14:58:45 -0700
X-Gmail-Original-Message-ID: <CAPhsuW4NKdRmFxsmLoAYKV60NuKoRO-3NKqHAucaXPyFKk4BMw@mail.gmail.com>
X-Gm-Features: AUfX_myHDuVQQKTUjZ1pJoVBzf2CSnpEApeHbSEbCdAlgFACH5UUJ8ndvSVMiOM
Message-ID: <CAPhsuW4NKdRmFxsmLoAYKV60NuKoRO-3NKqHAucaXPyFKk4BMw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Add mmap/munmap benchmark for
 array maps
To: Jiri Olsa <olsajiri@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 23, 2026 at 11:46=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wro=
te:
[...]
> > +static void *producer(void *input)
> > +{
> > +     while (true) {
> > +             void *addr;
> > +
> > +             addr =3D mmap(NULL, ctx.mmap_sz, PROT_READ | PROT_WRITE,
> > +                         MAP_SHARED, ctx.map_fd, 0);
> > +             if (addr =3D=3D MAP_FAILED) {
> > +                     fprintf(stderr, "mmap failed: %d\n", -errno);
> > +                     exit(1);
> > +             }
>
> hi,
> so now pages are populated only when accessed, benchmark shows
> this nicely:
>
> before:
>                 nr_threads: 1, map_size: 1048576
>         arraymap-mmap:       throughput: 0.006 =C4=85 0.000 M ops/s, late=
ncy: 172703.437 ns/op
>
> after:
>                 nr_threads: 1, map_size: 1048576
>         arraymap-mmap:       throughput: 0.082 =C4=85 0.002 M ops/s, late=
ncy: 12212.778 ns/op
>
>
> would it make sense to add some map access in here (each page I guess)
> enabled by new option and measure the impact for accessed map ?
> I assume latency should be equal in such case.

If we add a read per page, which is the worst case:

before:
        nr_threads: 1, map_size: 1048576
arraymap-mmap:       throughput: 0.032 =C2=B1 0.000 M ops/s, latency: 31248=
.846 ns/op

        nr_threads: 1, map_size: 8388608
arraymap-mmap:       throughput: 0.003 =C2=B1 0.000 M ops/s, latency:
372565.622 ns/op

        nr_threads: 1, map_size: 67108864
arraymap-mmap:       throughput: 0.000 =C2=B1 0.000 M ops/s, latency:
2061083.005 ns/op

after:
        nr_threads: 1, map_size: 1048576
arraymap-mmap:       throughput: 0.006 =C2=B1 0.000 M ops/s, latency:
170794.193 ns/op

        nr_threads: 1, map_size: 8388608
arraymap-mmap:       throughput: 0.001 =C2=B1 0.000 M ops/s, latency:
1346389.229 ns/op

        nr_threads: 1, map_size: 67108864
arraymap-mmap:       throughput: 0.000 =C2=B1 0.000 M ops/s, latency:
10700389.105 ns/op

So filling all the pages in the mmap is faster than faulting one page at a =
time
in many page faults. IOW, there is a performance regression in this case.

Thanks,
Song
