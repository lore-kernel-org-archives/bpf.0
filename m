Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D43F7473C61
	for <bpf@vger.kernel.org>; Tue, 28 Jul 2026 20:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785269524; cv=none; b=OThTeXKIItvX/EX9p3t3/w4nPMP1/FV3pUD/qo5XVSk7vNkGBZSoAucZb5hQegyPFchBidaMYqFXIxLw7WDliiocYqUDBIreBkI9b5Pk/P0aqKdsv/IrtkecgOPKlSmTFL0kt3lZBwvS81y7/MQ+HkG3s7UsdbZ+O7D5W1XW/D8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785269524; c=relaxed/simple;
	bh=JGPMku14d8UHGNDuZEiyLWbazsXonkKLrxGjX5uDXpA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PNg+YjzQlJKug/8VskKDPYbHnzVmgUdjHQFdpWkhpyBGDFxuYnTGg+sddMvUPPBD9qjDOzWhAMRZEgCRta4V269nXh2X5MW1EyKekaiOugIU/XKC78968vFBMk3NDBc7vlRQiEmp36b8L5JiAU6NoDUSke+EtKN0RZRNUI8Kho4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JkHph20n; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JkHph20n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 692561F00ACA
	for <bpf@vger.kernel.org>; Tue, 28 Jul 2026 20:12:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785269522;
	bh=xffc0BJb83oP9DV5CH3C1WgleK7Bxd044XFdP5DI6DY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=JkHph20n48NldP5N6d3/RA0TbYLt5kAP3y0g9ffi3fTuKDcHjDEtqEIZZR59UOh5n
	 MYX6FO9KVD4YckLmDFGvIO+AVS2J12mEOlqFBt7q41ZuD0QAV//WRBh1I552XCJ7br
	 m0Mqk2Th7mfw6pa/X4kwkF1OaOs9E0RHCN1hJypYdabZHiPpUPtZxl/eIKTo56qJ+P
	 oIXXCJDRb7PUeRX4KZhQIHIbiYX8luXX3mn2Lexs0rmx/+3P8aRRy1Ar+owo/o3nRz
	 60rpAnx/HvsK988pGOA4kCCtHXbgjapXeDY2pkHnQWKZLTote3lxdiDVkW51eSeplX
	 1YJuTE94TQIXw==
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-9305a2121a1so20107585a.2
        for <bpf@vger.kernel.org>; Tue, 28 Jul 2026 13:12:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RpSFmn3MNmmMFjsDc3/G7/zcIu3Uqd7ffzoZKSH0lnmf8BOj7D3RcEfDksCJMbtF69kPVU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGZmij7X9q0XSEl1ZDv/vCBzYOEmJS+Gty+uBVLlpZdQjxnqDh
	V4NdLontHcik+IfyDkn3dAcyz0OjAgRe+8VAy3AnnvoTRtDYUyG0oD1LDXOnOcz4pK19GSkpJWg
	l7s5coTnkcRM0j4MxYFnKOR7/ZAIuhYw=
X-Received: by 2002:a05:620a:318c:b0:92e:c118:18af with SMTP id
 af79cd13be357-93302726c78mr385880585a.78.1785269521486; Tue, 28 Jul 2026
 13:12:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260722065308.4116186-1-song@kernel.org> <20260722065308.4116186-3-song@kernel.org>
 <amJhnbom_expRgN2@krava> <CAPhsuW4NKdRmFxsmLoAYKV60NuKoRO-3NKqHAucaXPyFKk4BMw@mail.gmail.com>
 <amMoJnZUF5flJazb@krava> <CAPhsuW5bhv+CktsvnhEy97KA4oQY1dZfnGkzgKdAZTk77Pe90g@mail.gmail.com>
 <DK79S0WM9AYK.162USUO6EB2ZA@gmail.com> <CAPhsuW5Zf7ufT2iiyQWBdG_7JOuJMJqwf+jHbumMRVPqFGn7pQ@mail.gmail.com>
In-Reply-To: <CAPhsuW5Zf7ufT2iiyQWBdG_7JOuJMJqwf+jHbumMRVPqFGn7pQ@mail.gmail.com>
From: Song Liu <song@kernel.org>
Date: Tue, 28 Jul 2026 13:11:49 -0700
X-Gmail-Original-Message-ID: <CAPhsuW5RC9JkLwfc2V-iO0pw5ggsrrwamJGRL_haN5fs8KRLkQ@mail.gmail.com>
X-Gm-Features: AUfX_mzdjX0UdwxQsM2U63dp_p-dRI5rCIdgTCGD9MnjjJ38xVItz9jWmJo6vts
Message-ID: <CAPhsuW5RC9JkLwfc2V-iO0pw5ggsrrwamJGRL_haN5fs8KRLkQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Add mmap/munmap benchmark for
 array maps
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 27, 2026 at 5:19=E2=80=AFPM Song Liu <song@kernel.org> wrote:
[...]
> > I think it would make sense to compare cumulative cost of mmap+read-eve=
ry-page.
> > I am sure it would also be lower before this change, due to the added c=
ontext
> > switches for fault on every page access that would be amortized before =
this, but
> > may give a better picture about the difference.
> >
> > I do feel like it's a corner case realistically, and after the first fa=
ult the
> > page remains mapped (and users who care about pages being present can g=
o the
> > route of passing MAP_POPULATE). I am assuming passing that before was a=
 noop, so
> > it can be added to code in a backwards compatible fashion if someone re=
ally
> > depends on this?
>
> Given there is MAP_POPULATE flag, yes, the user can preserve the old
> behavior with this flag. While this requires users to make changes for
> this corner case, I think it is still cleaner than adding a BPF map flag
> for this. If there are no strong objections, I will keep this behavior in=
 v3.

This turns out to be a little more complicated:

1. Bad news: MAP_POPULATE is not a noop for old kernels. The pre
   fault mechanism still adds some overhead (for almost no gain). For
   8MiB mmap, MAP_POPULATE addes about 80us (raw data below).

2. Good news: We can further improve MAP_POPULATE with a batch
   pre fault (vm_operations_struct->map_pages). With batch pre fault,
   mmap then accessing 8MiB is about 34us slower than the best
   option before the set:
   (before: no MAP_POPULATE =3D> access all pages: 252us;
   after: MAP_POPULATE =3D> access all pages: 286us).

Note that, all the above are worst cases: we need to access all pages
and fill the page table one way or another. If we don't need to access
all pages, the change saves a lot (220us =3D> 1.2us) for the mmap.

Overall, I think this is a net win for most use cases.

Thanks,
Song

Raw data:

All of the following are for 8MiB, access times are in microseconds (us).

Before:
no MAP_POPULATE (do not access pages) 220us
no MAP_POPULATE =3D> access all pages: 252us
MAP_POPULATE (do not access pages) 304us
MAP_POPULATE =3D> access all pages: 334us

After:
no MAP_POPULATE (do not access pages): 1.2us
no MAP_POPULATE =3D> access all pages: 543us
MAP_POPULATE (do not access pages): 262us
MAP_POPULATE =3D> access all pages: 286us
