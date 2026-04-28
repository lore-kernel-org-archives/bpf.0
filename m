Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FF1E33D4EC
	for <bpf@vger.kernel.org>; Tue, 28 Apr 2026 16:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777395556; cv=pass; b=UbWhF6LJWVX0BJ0dIR1RZMOP9omHLeJzj9KM2AuCtI+xOPngrbAozeK5frO7VxDSxWyidzXQKkmljygKQNTNE+Cx30RvV1Ths1+DuyZZTnhrBiVXZq5XSVGCz3KAd6BTAj57wM9uOCI/L49L9A0YmVjlmeUcF5zSbwqX1skCrz0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777395556; c=relaxed/simple;
	bh=etazECzktFD5luO5FCpZbqDqLccDsjg+sso+8AqETyg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NKr2moA4trgUTIKgZwEidhLo3fhUagRNsca1TNdyj4Fvp50RMwVmBCXRChcIQ9VN/w6SjLNB8tAFnyD8mOwN9d7/uulPJxVl22PepfCtn+IykxPjkdCT8M82ysjJ1+qrjV7Pj3TJ9FotTt9sTMeD6WRELjviusZIixyWgXm45kU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NR63C3k0; arc=pass smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NR63C3k0"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-43d76dd4ee8so10348934f8f.2
        for <bpf@vger.kernel.org>; Tue, 28 Apr 2026 09:59:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777395554; cv=none;
        d=google.com; s=arc-20240605;
        b=Cf4/nj8uSgcDWnlngtXSBCzvE4OBfoSqSibQtfwFuJJtb5HbHQYh2+YatFU4zRXdwH
         OI/Yf0zjpQ+0oqh/u2xA6ZeWQ+bZBcdAWk5xBRXTJm9G4PZ1Y+Z5iRbiiuMiLDE8LA3H
         wXBFs8YIL39sXDmoE0qOPg3djH20IcR805bvWs8hiuKwPTdBncGnURj2iMR4xxkEzGUo
         GcPoFYdkv63HdYIfVwiGjB9qMDcRqMx2h7XsTU9ym6gDehXQH4BxyNbQrBWbD4wgwClV
         y4qMbfznG9l4wA3Jztu0BzrBlquE1vY6GXSV2ctVHgj+/DjC+44PMawQhzr0+52AmXVM
         nNNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VK5ahICXkL0MctIkCl6eavo2XIzw7vhC4fPYDrQjJ7M=;
        fh=3w3SGRfYD0SCENNxvIiGNNuOSB+U8SrOV2m/ZcFH2zE=;
        b=Bl/WIn9LKj4IZoYUxI+I26pJIvzSBUyKm/Xw2xbRxjSHVsHTu1uMhj0xov2QtsUmM9
         UqIh/lPFgXX8P6ChBcXns7Mowm4QlBtxywaJra/ecSuF5cfFwszqIyn1sq1CQVneMbWN
         1wj24uaZRrOrhfYyc/O1c3P3ZryLd38HrZwv49QkoNZQRyNx5Ef/W7bNTOdFFQbI6KYG
         CbfsfRF4FZyB9Hc8LnZSKnhRnK5pIOHVkb1K9Ctx4NAkxU4a7K5yjXN1UkJPDKISV1Kz
         GlUEef7saSWcC+Fs1GrR96EP/1OOVFKRtoaRhoVdHCX5d34HX1cja0hZrLsziZKXwBF4
         3YXw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777395554; x=1778000354; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VK5ahICXkL0MctIkCl6eavo2XIzw7vhC4fPYDrQjJ7M=;
        b=NR63C3k0dnxoxNsJa4VClxVF1Izthi1pl2XT2yJDFICyZw26/NisinGK7WPiQMbcWW
         SdRwGGcXbZ0xiPhPK4GzYmOcT8cFcWSO11Lw2MObIVCnd1treqZNTb3wO0L52F3nO1AD
         0qFC39PGEpwy3w/ch+ORR3XCGE8sj+9k9zIQD7NeFRIWsVhZcUgiLiRhLJSSJislhrao
         vWnL+xckgJFQ1ykFnDgaSzWPlIoEsnPY+x5OkOs/4elsKQGhjs0jjk5k5nPenW+WPjOI
         dHHzwYEEpwpuUXjBsAVH1h4BWO9f5Zg788QGDvvYFo5K0rFCROGFVFLmZfJ4cWU0tHll
         ljTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777395554; x=1778000354;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VK5ahICXkL0MctIkCl6eavo2XIzw7vhC4fPYDrQjJ7M=;
        b=azILO86RMGJxvwvNOy9N5ly2hZN82TTsIfuwp9vTRogu6NZgo7yUwWuy51Mq1TNjAO
         1Rd5ySsQb2qiOuinmiZTtpxPR/cg8WcN+Vd7wHvmTcnv4SXGjjHVHrBSD7ZmrzyBgM0q
         EravsHEn45wl7XYgY+p13b910TUPvasdVz9NOS8wknkNWKdBKoSZ9BpHw6k5+jheRLzE
         GWhWEVFsaa66d7u8eWj2dXz9c8eYCpv94U3HHUqC1AO7FDrKs5DHDLpAwBGcatfSWfVO
         +aW7prOTBxbcLV0LMPd2vLkVQIbjc32oNNlB/INN57dDuA7e90jjQ6Ux4KDB6UfDCNlK
         jLwA==
X-Forwarded-Encrypted: i=1; AFNElJ/zz7SkOjvEhJWmsDCpu9npLCh+m/+MQklON9MAfleILfBtrER36buhiP9oEvwgaT+m4Vk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVOb1ufmv1rnZcADvrVrDo/Mrr+nD51mWZzOxAxii57cfd/Vrf
	oYgkArOnpzmCGgNwUMvi2dPXT10owr4HS1DRsqooB0OQDxqlW1VPu+pTe8lzzPaZoDHjsjTM67C
	Tia9A3O00W+wBnLSxzY6IJP31HIcYNvE=
X-Gm-Gg: AeBDievSvfQOXVFHqvwF/WcKqNFA9Eg8TzUEmOUWYO1ZoqnfloAdSXQRUU/rQJ8+byd
	9Na6s+i9IedMYsrEGGLtrd9/NenKnVzMJWXJexLYKBAdWAxtfegtDSdFYcJNqHPtVTyL5jaquCW
	Fd6lVs/rD8TYB4U95LuAOP4hT7wnCiqeg/4reRlLI42gWPFvHlngVmVu+7w68CQcSIGw4U43Sv/
	g5OMJE/RBzB5d01SuwAwYXeEk9/jOsJo0axU1//kaKLLVYMtL4Zw4vMgDUXZCPCeQ3S/9gO6tCD
	CjCwsoFDldwEDZivrywoCf94x03gJFM9gAubxxnDttVemVOiifzwOCvbVzn24Zm3Wx1CqtHWCfN
	6olKKp6Vw9N2cVwQiSVo=
X-Received: by 2002:a05:6000:40e0:b0:43d:7b23:bc99 with SMTP id
 ffacd0b85a97d-446489636b5mr6955778f8f.15.1777395553547; Tue, 28 Apr 2026
 09:59:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260427-page_mapped-v1-0-e89c3592c74c@kernel.org>
 <20260427-page_mapped-v1-2-e89c3592c74c@kernel.org> <20260427051758.e1b714a4b567917971920eaa@linux-foundation.org>
 <CAADnVQJ9JXrtAnFgE8UFK=W1GDeT6T6Wi5zB7g0AfRjU8M4=bQ@mail.gmail.com> <2b2eecf0-72f9-4959-9663-c80e3cd0c517@kernel.org>
In-Reply-To: <2b2eecf0-72f9-4959-9663-c80e3cd0c517@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 28 Apr 2026 17:58:59 +0100
X-Gm-Features: AVHnY4I0TqqC4RFs8UKqyAoce0ZbMMM6zkhJo0hxpAv6LX8MTNNEkUpX04aH9bk
Message-ID: <CAADnVQJp30BhhB6N3-GxtYmMpaMTaYvGcK9R5=8PxWD6qEXJhA@mail.gmail.com>
Subject: Re: [PATCH 2/3] bpf: arena: use page_ref_count() instead of
 page_mapped() in arena_free_pages()
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Yoshinori Sato <ysato@users.sourceforge.jp>, 
	Rich Felker <dalias@libc.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Rik van Riel <riel@surriel.com>, 
	Harry Yoo <harry@kernel.org>, Jann Horn <jannh@google.com>, 
	Matthew Wilcox <willy@infradead.org>, "Liam R. Howlett" <liam@infradead.org>, linux-sh@vger.kernel.org, 
	LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	linux-mm <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 28, 2026 at 9:16=E2=80=AFAM David Hildenbrand (Arm)
<david@kernel.org> wrote:
>
> >>>
> >>> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> >>> ---
> >>>  kernel/bpf/arena.c | 2 +-
> >>
> >> BPF maintainers will probably want to carry this in the BPF tree.
> >> That's fine - please go ahead and add it.  I'll carry a duplicate in
> >> mm.git so it compiles.
> >
> > We cannot carry the same patch in 2 trees.
> > Sooner or later it will create problems for linux-next
> > and issues during merge window if more changes
> > are done in the same area.
> > The only way to share a patch between trees is to
> > create a stable branch and pull it into 2 trees
> > then sha will be the same,
>
> As lack of stable trees was raised a couple of times in the past, once we=
're
> done with a transition to a fully git-based mm-next workflow [1], we shou=
ld be
> able to provide stable trees.
>
> [1]
> https://lore.kernel.org/r/20260421094216.8dfe14a8c62f2420fa5aace1@linux-f=
oundation.org

Ohh. Thanks for the link. Full git sounds great to me.
Reading the thread it sounds like you guys want to explore
your own way of managing the tree.
If there is interest we can share during lsfmm
how net and bpf trees are maintained from git pov.
