Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E9FA386C00
	for <bpf@vger.kernel.org>; Tue,  3 Mar 2026 20:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772570962; cv=pass; b=CLr+4waXF9i8iIp9cOou+JS2lpJScOr5RR1KoDl0HttWo7yWp1sNokCWc5eoe+iQYJQRVkKwwHww4Br9ZNU4tibQdEEg2yoLNX5nbop3bCPtSgmMNB+S6B0wHRNss7lqcIBNVrSIJsK1htAvi2ssowU4cB7ZE201mdGF/mFw2Nc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772570962; c=relaxed/simple;
	bh=z5K9TC0MkEO8By22h3GqX8xxcKLeF0UtxgZ/D1gjfh8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NiIuPw3zUoke6J3Xl7J/AoLZozKk0IyKbnnhBmEPflj0o/2Yv4zbTLguPXYI4oV9qZYcg++17E2Kgr73MjN5ZDlzk/ghQvm4yPIqkeIVfaTTT6exXMKFAQ5fTtNZz9PFsLmVdw3WeB/h+5J3ED9H8G6gSMxn3C2U/nKAFab9uQk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MC/6UvpH; arc=pass smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MC/6UvpH"
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-2bd801b40dbso477019eec.0
        for <bpf@vger.kernel.org>; Tue, 03 Mar 2026 12:49:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772570960; cv=none;
        d=google.com; s=arc-20240605;
        b=MELoONaRe5rwUdKzmvHTc3kLXW2JzqAdBDcjcDg9q9CapTXWKu6RbWlYm2vFjVSvPJ
         Gg3oiehNsJOQPnxSXNi9FIF/vZnOoSFsHklGdApMzApJG4BgJsD166E+c++F3g9lQfkx
         mMV6R4wVc74Wfgl5b6TFdeI0xGgHZH1bXfVnnBBSdScYoCHPFutL6NKF31JoIIG8D28l
         x0MnJ+5xKrMJotq5Hr9SuDU3jBlLNQggbQGpWR7DYoesA8MikQ3rdyKtf2pQopA1vfch
         LUzg2XLDe+kVLwVPrFKw7jqko+Kd+X1UzFJgzussY6CL9najjKXCCddWP4NbNPxACOeH
         Gebw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=z5K9TC0MkEO8By22h3GqX8xxcKLeF0UtxgZ/D1gjfh8=;
        fh=FQF0bW80EXxD6OBjvQDkXqmwGWBbPQ6TJra5C9R6iA0=;
        b=PVBCK3qXWEZsbfnGObnPEROWqhrO2FVTYs0UyAid0JSkwuA+cEVLilMM2a5LAqZ3PV
         UlKSCbTIA/86uijRFMF4UKEKbCj5tBexbXZC8+hFAKgpymv6nUWC/iO6mKFTvPXjytYK
         1LuQy0dN1BjgVnJslZZ313pNWfK0cHINE12bLF4Fe1zPRP5yABxCTNe3WgRLJqQK7Kfe
         ztvLlFwGyL2CHl2iJLDop+If5aqiZnBKvu9feCZIkJqgbFQAra5exU/ExmEJL+GTnSUY
         o7UPImAHSPePs2jFfMceWbeRB+4irGmUL73Nb7JnKY6EZ21JWugI9Y0Y4LB8dEriJOjs
         yw1Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772570960; x=1773175760; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z5K9TC0MkEO8By22h3GqX8xxcKLeF0UtxgZ/D1gjfh8=;
        b=MC/6UvpHT4SEnjb/NMu4nCD7Y/CgFLGhB10BzWPvEDjKvZA2lZ9okaGCUCGB3IbeLy
         cGgqGyj71FN7/CioLy93vdYXiKOMJe3vR+j+biXyjvWiP1VvwY0SpZuEnET7WI0E0PLq
         BBf1WqOSwDjAumUHPBfJGMcqZXc4B6Yuz6rp/ed69z6jmhyN3Yhj3DTtzwNIYZQmx/SF
         jhT5DwBvS3xmxNKPvfei0LpqgbJOmZuKLyUK2wYyCE/Tg1IJjSJ0URjLr+TYYhp768vW
         OGrdSbrtyYfSf/xo+vB+w4pxsweRRJyYX/6uv1dcXSw8p0Wob8DVrGmxbm0/OVwZigJr
         6Z+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772570960; x=1773175760;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=z5K9TC0MkEO8By22h3GqX8xxcKLeF0UtxgZ/D1gjfh8=;
        b=rXJJrJRIkbxIuKsD3OTdcXStmVZftSPM7aQY2N5h+iA+QAiBr4E/PSRuJXXAjfLl2s
         eDMvV1zrChF4jC+RdTL3NyXIi3ehYlEoxkOwnp5m2xoOXA9IsmqhHxzYUGP69PcLs/0Y
         xlv3HYjt4bK90ZkWL7obFKQxY4GbZeHFPzjzgAjZYdpVkiF8a8XnvmDAlPMbk9SjLppS
         Xm57kfy8hrHKwQYo8hEZ9f2jQLqdrOkuqvqmkOeAxdXLfhui6nVpZfTr3uOXO4y5R7Ds
         YJVVZ3b15k5N+nCGtJ0Yll3gbDx2PiyCH5glLgPacQi30zFgw0/3/pRskT/YIMgjjM8h
         21NQ==
X-Forwarded-Encrypted: i=1; AJvYcCW6IAa4PPzBz5z6ohf9tlzbbuBz6cshsQcH5zZZCS1mFvP0vWb9zl8he8PvOv7Um4T3olU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyb/IoXluZpQ9LHN+12nbD0vgj5Xk1hJ9/W4Ku7ch17otJ2n2a5
	rR2q11TCnpGStJOEmyo2MJNIXnuuQ3B1Vc2ivOBmtuGKyOH4npUlJfzFYUgIwyL26c4iNgfahWN
	nuqOPcWE2IrzlE/TSLq4Wdgb7aTqefrk=
X-Gm-Gg: ATEYQzwUZG6wBy1Ppzirf4xGs1cP2f/EmmJqc7h4FnymmiPH7PG5Vh4gkGOqJBsR+R5
	iCQjGxC+ttHT610Uh0Pf/qBkFrk5fzJzkKVd2BNiHIbfS55y1KvEoJt/jvubaWSxMK/JKZnVCJj
	aCi2rRkHXTd+6hJVv6D9UGGaDnSTVUwxsAxFa3uQjyegbK7ec73VHoafgfuXVL1adLt62JOdHvg
	fH8KzBEG29I3zrF0V+JZ/zqC+4tcQZeeXAQud1ihcTG7mls0ZoTPz7dYDn8j8EQ5L6mJdGGWMxd
	zNpmldSJz0LvkfJPj1HvMrdXGM4z/XOHsIy3zjH5r1Kd8JfVlvy3XvMwGHEfohjimDfDIHQ4nJW
	A3tKvPdPCLfYxkjxhtLslh4OV
X-Received: by 2002:a05:7300:231e:b0:2b7:103a:7697 with SMTP id
 5a478bee46e88-2bde1d4bc79mr3350396eec.5.1772570960234; Tue, 03 Mar 2026
 12:49:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260227200848.114019-1-david@kernel.org> <20260227200848.114019-3-david@kernel.org>
 <aaLh2BxSgC9Jl5iS@google.com> <8a27e9ac-2025-4724-a46d-0a7c90894ba7@kernel.org>
 <aaVf5gv4XjV6Ddt-@google.com> <f2f3a8a1-3dbf-4ef9-a89a-a6ec20791d1c@kernel.org>
 <aaVnifbdxKhBddQp@google.com> <5f8dcb7f-9e4f-4484-b160-3a9ce541d63c@kernel.org>
 <aaWvtn48X8UizaaN@google.com>
In-Reply-To: <aaWvtn48X8UizaaN@google.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 3 Mar 2026 21:49:06 +0100
X-Gm-Features: AaiRm50lUTXkxHRxiLsKpWNGF1HIgeoo2SkrDpQfQSxM22wzlSiellk8rvn7q80
Message-ID: <CANiq72nK8P1rUYw=y3fMzWZR3f_mW2v0_LSLWR1i0dQTtOqu2w@mail.gmail.com>
Subject: Re: [PATCH v1 02/16] mm/memory: remove "zap_details" parameter from zap_page_range_single()
To: Alice Ryhl <aliceryhl@google.com>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>, linux-kernel@vger.kernel.org, 
	"linux-mm @ kvack . org" <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, Jann Horn <jannh@google.com>, 
	Pedro Falcato <pfalcato@suse.de>, David Rientjes <rientjes@google.com>, 
	Shakeel Butt <shakeel.butt@linux.dev>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, 
	Claudio Imbrenda <imbrenda@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, Jarkko Sakkinen <jarkko@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>, 
	Todd Kjos <tkjos@android.com>, Christian Brauner <brauner@kernel.org>, 
	Carlos Llamas <cmllamas@google.com>, Ian Abbott <abbotti@mev.co.uk>, 
	H Hartley Sweeten <hsweeten@visionengravers.com>, Jani Nikula <jani.nikula@linux.intel.com>, 
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Tvrtko Ursulin <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, 
	Dimitri Sivanich <dimitri.sivanich@hpe.com>, Arnd Bergmann <arnd@arndb.de>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Andy Lutomirski <luto@kernel.org>, 
	Vincenzo Frascino <vincenzo.frascino@arm.com>, Eric Dumazet <edumazet@google.com>, 
	Neal Cardwell <ncardwell@google.com>, "David S. Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Miguel Ojeda <ojeda@kernel.org>, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, 
	linux-s390@vger.kernel.org, linux-sgx@vger.kernel.org, 
	intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-rdma@vger.kernel.org, bpf@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 2, 2026 at 4:41=E2=80=AFPM Alice Ryhl <aliceryhl@google.com> wr=
ote:
>
> It's not relevant in this patch, but another thing that may be useful is
> to add CLIPPY=3D1 to the make invocation when building normally. This
> causes additional warnings to be checked using a tool called clippy.

Yes, please do use `CLIPPY=3D1` -- the build should be Clippy clean
modulo exceptional cases that may slip through (and soon linux-next
will probably start reporting those warnings too).

Thanks!

Cheers,
Miguel
