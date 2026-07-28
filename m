Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025F111CAF
	for <bpf@vger.kernel.org>; Tue, 28 Jul 2026 00:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785197968; cv=none; b=ZoTUvCOQCHVCq2/zIxcDxIdXR+yOdfZ3U+vgompxwlhUP/cFlUbysyfRka0y6mQuKSaE73tWoaSQgrfAxQrQZm+IBsu4s+KK9LLtEKmXWlipLRqQoFAlmRtpothkaOph57WZ0Zo/yBmm2MF6f24+8XoxHg6xkd9ZFWtQDk0ztZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785197968; c=relaxed/simple;
	bh=qyEXwFI4gcKK6jW9Za99H/FNFPDYPuYWj9DOEKLJSmA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=azt668KPYAxv5hE1tSrNno7Uih1ZxNcSLU0LTMmyaf/S3tUw14SXMikn99CwSSk6WSgEbE7Kk0hD05bljjHONwlR2nnhF0ruuwE7T/Hl3dtcy6GJ+l/ao7/9IETQ6Q805ilH3q+E/fB/1qgc7qylAXhw6Jf8aNFsjlqU41p0lCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kTHMqoxA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kTHMqoxA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76AEF1F00A3A
	for <bpf@vger.kernel.org>; Tue, 28 Jul 2026 00:19:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785197966;
	bh=qMOdn+I1/gZ8oLSmo4cehJXjB+C0akcp+HdheIDNmYE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=kTHMqoxANv0veYNgyAM8UJchiiZW8EmfXVTWImUcEkNCm0tnhbGTB4AQrg5/ktqv+
	 hbL4l/qN/5aYJCJgIYWR6PbjjHOscROlTbpMRF/Mz0GlGEjdwjg8PNLZhMumIt1N8N
	 7tp4v54gUb0v4jkKMF9UrvHCb8Bf2voSSAiSo6TNUDpo2k+1r3YLbI+iuoZZJDfjOW
	 7fbf5Yu9ugsQLFK/SyUC75kLhHmuSTmcyssaSGicFRrLM/AQh6/q6AooDtX8OMgiHl
	 HdRmWHE9BSTnmaP8Wm10wFercAdpEi1bOTqTmSfXqa2cqGxhChoMdLJ7XZ/5W0WP9d
	 GDXj0mD6PYVCg==
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-92edb12cdf2so212001285a.3
        for <bpf@vger.kernel.org>; Mon, 27 Jul 2026 17:19:26 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RqzqBtAkqzQY/kwU1rjxswDFOXV6hWmGc7dqbPvB8f4hZNDawChSGYOKalsDfg3rDlFLcE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDg35k5KP/h2J1VVDxVUqoTC2yv8COwTu1n4kVvK7tuWQIJeiv
	lH23177Cf8+zVhZRoMvpgcrDcig4AjQ8RqG9viaLsAMehVa7AdWJj7CXnuKuVsm3Zjpyocvh1m6
	6qfzFODnlKvrV5UkB0DiVhe/9DkpE5lM=
X-Received: by 2002:a05:620a:6cc1:b0:92a:1b20:fe0c with SMTP id
 af79cd13be357-93302640d80mr12977085a.17.1785197965665; Mon, 27 Jul 2026
 17:19:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260722065308.4116186-1-song@kernel.org> <20260722065308.4116186-3-song@kernel.org>
 <amJhnbom_expRgN2@krava> <CAPhsuW4NKdRmFxsmLoAYKV60NuKoRO-3NKqHAucaXPyFKk4BMw@mail.gmail.com>
 <amMoJnZUF5flJazb@krava> <CAPhsuW5bhv+CktsvnhEy97KA4oQY1dZfnGkzgKdAZTk77Pe90g@mail.gmail.com>
 <DK79S0WM9AYK.162USUO6EB2ZA@gmail.com>
In-Reply-To: <DK79S0WM9AYK.162USUO6EB2ZA@gmail.com>
From: Song Liu <song@kernel.org>
Date: Mon, 27 Jul 2026 17:19:13 -0700
X-Gmail-Original-Message-ID: <CAPhsuW5Zf7ufT2iiyQWBdG_7JOuJMJqwf+jHbumMRVPqFGn7pQ@mail.gmail.com>
X-Gm-Features: AUfX_mwxB-28nxMPs6VKF-hr1qlebpNCBPgapHBKNbaiQ70Q6cf5SkJ8LK2mqVc
Message-ID: <CAPhsuW5Zf7ufT2iiyQWBdG_7JOuJMJqwf+jHbumMRVPqFGn7pQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Add mmap/munmap benchmark for
 array maps
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 24, 2026 at 6:43=E2=80=AFPM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> On Sat Jul 25, 2026 at 2:13 AM CEST, Song Liu wrote:
> > On Fri, Jul 24, 2026 at 1:54=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> =
wrote:
> > [...]
> >> > If we add a read per page, which is the worst case:
> >> >
> >> > before:
> >> >         nr_threads: 1, map_size: 1048576
> >> > arraymap-mmap:       throughput: 0.032 =C2=B1 0.000 M ops/s, latency=
: 31248.846 ns/op
> >> >
> >> >         nr_threads: 1, map_size: 8388608
> >> > arraymap-mmap:       throughput: 0.003 =C2=B1 0.000 M ops/s, latency=
:
> >> > 372565.622 ns/op
> >> >
> >> >         nr_threads: 1, map_size: 67108864
> >> > arraymap-mmap:       throughput: 0.000 =C2=B1 0.000 M ops/s, latency=
:
> >> > 2061083.005 ns/op
> >> >
> >> > after:
> >> >         nr_threads: 1, map_size: 1048576
> >> > arraymap-mmap:       throughput: 0.006 =C2=B1 0.000 M ops/s, latency=
:
> >> > 170794.193 ns/op
> >> >
> >> >         nr_threads: 1, map_size: 8388608
> >> > arraymap-mmap:       throughput: 0.001 =C2=B1 0.000 M ops/s, latency=
:
> >> > 1346389.229 ns/op
> >> >
> >> >         nr_threads: 1, map_size: 67108864
> >> > arraymap-mmap:       throughput: 0.000 =C2=B1 0.000 M ops/s, latency=
:
> >> > 10700389.105 ns/op
> >> >
> >> > So filling all the pages in the mmap is faster than faulting one pag=
e at a time
> >> > in many page faults. IOW, there is a performance regression in this =
case.
> >>
> >> would it make sense to add new map flag for that?
> >
> > If possible, I would avoid adding a new flag for this. I think the
> > regression is on a very special corner case. BPF arena has
> > similar behavior (fill in page table on fault). So it should be OK
> > to have array map do the same. WDYT?
> >
>
> I think it would make sense to compare cumulative cost of mmap+read-every=
-page.
> I am sure it would also be lower before this change, due to the added con=
text
> switches for fault on every page access that would be amortized before th=
is, but
> may give a better picture about the difference.
>
> I do feel like it's a corner case realistically, and after the first faul=
t the
> page remains mapped (and users who care about pages being present can go =
the
> route of passing MAP_POPULATE). I am assuming passing that before was a n=
oop, so
> it can be added to code in a backwards compatible fashion if someone real=
ly
> depends on this?

Given there is MAP_POPULATE flag, yes, the user can preserve the old
behavior with this flag. While this requires users to make changes for
this corner case, I think it is still cleaner than adding a BPF map flag
for this. If there are no strong objections, I will keep this behavior in v=
3.

Thanks,
Song
