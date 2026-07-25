Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50EBF2D94B5
	for <bpf@vger.kernel.org>; Sat, 25 Jul 2026 00:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784938444; cv=none; b=F6CewJLu3x85CeYGG5GSlAFS6Kg92TehJK5oWdJrUzoAhT27sfhl3SJ9Dk4T0qQpGLcibdnAsG26OZmvnURUdlfiA95ygEluC/R6TMCjdDlvrHM6fEukBSvJxbelg1vdsPz2EICr9C9aZ5Xb6KxFkTZazLZJx0/a74MrKdrZtfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784938444; c=relaxed/simple;
	bh=rrbH6GKBQ4OOox6cMRM4X2sVPFFLkMCrRwIGoGFfkHc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P1DzsDGwNw+WGCv2OZ8Gk9m+V3qBtCStAP6+mPb3+XlZx8xbr/CNBAsNT9FpaNkSjL+X4d0FKO7Jad5Y0DaPtGhYKGJG83rMJSjgSDKq/sEqVCzsEiA3HwYJXMa8kNpl531ssMbmrU9YKQklmgM5s/hfVzdZNecT4OE3hoMexFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FLlxKJEj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FLlxKJEj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C261C1F000E9
	for <bpf@vger.kernel.org>; Sat, 25 Jul 2026 00:14:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784938441;
	bh=c/IzNZDV3n5JvnwV6UiSPs5H7EW8rm/6iVaurEmVtvY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=FLlxKJEjbsQYCfwkTQSmkkSPbXIFncW8d2Gkx8GkccGifWS2MZ+livtolcBOVFlPP
	 q9Aw0klwFTokdBJnUPzk/3jD+U1D9Rpvgx56iIkeCUu8B/4wuzFQVXgEXydbjzwrwV
	 CjzqAq87o+63/9ax5cBeo8mnrZfXgndvkie8qaOzKNbvy0xG8P8V70aMllzedpafxn
	 6ELy26R3tF4ndTIISsrHOMf+xSudmCV3sXFknynb1Tb9n/GKC6MRNeLpSkzwzT2t5Q
	 cJjFf2RtxVEEpaQpfxtn7eGPB+hYCM4MBfT9++dm9UgNOdOUTqR/jMNECedP50LXGh
	 keDAjJ+HVE8dQ==
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-92e5c92c389so76566185a.3
        for <bpf@vger.kernel.org>; Fri, 24 Jul 2026 17:14:01 -0700 (PDT)
X-Gm-Message-State: AOJu0YyXwL3ORdgxzRpU5Ie3f+6KdRktm2dycbP6z/+aoqBBEnpcWytC
	rbxrvbH7gMvU9SNYdTPd8ES3SN4fYX3i7ZYnG3iLCOs1G9whYyyk293COUMbImo5CC5GDiyFJo8
	HRDjswf31ckGSmiI1DDSvkZm4SPe7nEU=
X-Received: by 2002:a05:620a:4622:b0:930:f306:8275 with SMTP id
 af79cd13be357-932df5ac872mr28955085a.9.1784938441043; Fri, 24 Jul 2026
 17:14:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260722065308.4116186-1-song@kernel.org> <20260722065308.4116186-3-song@kernel.org>
 <amJhnbom_expRgN2@krava> <CAPhsuW4NKdRmFxsmLoAYKV60NuKoRO-3NKqHAucaXPyFKk4BMw@mail.gmail.com>
 <amMoJnZUF5flJazb@krava>
In-Reply-To: <amMoJnZUF5flJazb@krava>
From: Song Liu <song@kernel.org>
Date: Fri, 24 Jul 2026 17:13:47 -0700
X-Gmail-Original-Message-ID: <CAPhsuW5bhv+CktsvnhEy97KA4oQY1dZfnGkzgKdAZTk77Pe90g@mail.gmail.com>
X-Gm-Features: AUfX_mwGZVIGG3Xku0U4OpQHpN5yFYmZwxxT-E2UGQGFtKZMz3mmBb-R4aV61bE
Message-ID: <CAPhsuW5bhv+CktsvnhEy97KA4oQY1dZfnGkzgKdAZTk77Pe90g@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Add mmap/munmap benchmark for
 array maps
To: Jiri Olsa <olsajiri@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 24, 2026 at 1:54=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wrot=
e:
[...]
> > If we add a read per page, which is the worst case:
> >
> > before:
> >         nr_threads: 1, map_size: 1048576
> > arraymap-mmap:       throughput: 0.032 =C2=B1 0.000 M ops/s, latency: 3=
1248.846 ns/op
> >
> >         nr_threads: 1, map_size: 8388608
> > arraymap-mmap:       throughput: 0.003 =C2=B1 0.000 M ops/s, latency:
> > 372565.622 ns/op
> >
> >         nr_threads: 1, map_size: 67108864
> > arraymap-mmap:       throughput: 0.000 =C2=B1 0.000 M ops/s, latency:
> > 2061083.005 ns/op
> >
> > after:
> >         nr_threads: 1, map_size: 1048576
> > arraymap-mmap:       throughput: 0.006 =C2=B1 0.000 M ops/s, latency:
> > 170794.193 ns/op
> >
> >         nr_threads: 1, map_size: 8388608
> > arraymap-mmap:       throughput: 0.001 =C2=B1 0.000 M ops/s, latency:
> > 1346389.229 ns/op
> >
> >         nr_threads: 1, map_size: 67108864
> > arraymap-mmap:       throughput: 0.000 =C2=B1 0.000 M ops/s, latency:
> > 10700389.105 ns/op
> >
> > So filling all the pages in the mmap is faster than faulting one page a=
t a time
> > in many page faults. IOW, there is a performance regression in this cas=
e.
>
> would it make sense to add new map flag for that?

If possible, I would avoid adding a new flag for this. I think the
regression is on a very special corner case. BPF arena has
similar behavior (fill in page table on fault). So it should be OK
to have array map do the same. WDYT?

Thanks,
Song
