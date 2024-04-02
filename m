Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 290A818021
	for <bpf@vger.kernel.org>; Tue,  2 Apr 2024 04:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712033852; cv=none; b=DhNsr6pn08vQx8Qbab59yJYCa8eX0dFj/Hv4HDccf/9IamwVvBdFFV+QI8aCj1xiAuLZ8H/gSH9CkkeQ0weDYAysQoGbUqltiEYhsGuh6yiXzxFT9n4vEx2HUCpcMUPrSQXtV88owZjaS8yua9tD5ndDjpuClrs+GjGFjQjeQAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712033852; c=relaxed/simple;
	bh=MH/JapCE7hgj6IxwesmnwQkOpOqgz2W0/+jZorl8nIk=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=mRG7wpHulUzJxsdcszsGLDvmYuHgCZX+cVXBW6mp+QtZWWCSOH2CWXYVUSlDBPXNQ/BsoXx3oERgqegjDam4ovJ2S6p8Al7CAkLur9+ottCWPOvIO49MC7ruc8gx124MQDGAj12EwGQlHJdteMipshj8hT9dDQyp1AkZXyTscgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JhTw6CPe; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JhTw6CPe"
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-6e50e8dcc72so2421504a34.3
        for <bpf@vger.kernel.org>; Mon, 01 Apr 2024 21:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712033850; x=1712638650; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MahhkHSLxHEz7Lrhd2Pq2ygNcLhn/TtYI1KbPYPCYG8=;
        b=JhTw6CPeO7HJoByScKmosDEMda8OnsKVibKh5kd+BVb/2m2wBC71SvluPbX9V7JoZC
         1hZRfrQpYy7GAveME298o1eeAomcTyQfZZmu6XHCX4Oy5uK84sSS55nQVDiqmSOUC5UL
         UnYA0jp2KR0xQkcIKsHd6ettlZjVPp6VW+F6oZ9p8rE9pP9vVSjYjvy96gPK8Wv5qA10
         TTUunmIj71wwC1P5nIVdI8cYT0hMxtPv7UpUYxKSN9ef3Kx0U6RORSfrRQ2n1S1c5BZp
         wTugWu+ObAW9jLoDc1zyPysENK4/1E2pqNJFHQkHRnD+XijBHWwtQCZc8aAyiBctx6vD
         C9kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712033850; x=1712638650;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MahhkHSLxHEz7Lrhd2Pq2ygNcLhn/TtYI1KbPYPCYG8=;
        b=C51W6WtvFbvpPv/a/YQwXb9DyBpWg7q5ptMemnuVfXOo3CpnxkNwK7bjkApuFWGhCe
         +BuWI9b5gQTfOEmIgF0G1ZRMPoDA8BWm0Y3WZYfOHCHHuBQ12Emi4F5al04Jl60viDfU
         f4ikZkY3UWhnz7x31fmnOCtNZT09+xm+qHQgWh7Ne7t0arDhc+t7XK7WC5PdFeYO6syH
         4gp9eyxRcdxg1SjWx9IwuA5RGZEx4Zw80NvRqTOCdp2tX3mgY2S8irGiSB61vZeq2Lk8
         Ijh610LIVyoaL/fW4vTWqYHNrKYWuAKxp4Bqz4SFTdZCXNqpCeCGcEu2Mk3bwVsKTyYF
         lM6w==
X-Forwarded-Encrypted: i=1; AJvYcCWxMkWya2YAqtJuBhtUwjLLobM+zg8moqWGa8t1umAdNo7ZdehZ+NpdjtFpl9Q+4mEiIq+d9Xp1kBXnyD4jGZvEs8X+
X-Gm-Message-State: AOJu0YwVosFFSclCGgDKIW/z5GAs+Qi5nCudS+Zv6OlpBX8tUWUiLKZE
	gL+i0fplpS7nBW0l1Z7f+iJfyrdo0htipUY6l9MUr7rDPi+0jy+fe+O0Erfh
X-Google-Smtp-Source: AGHT+IHYLyxh0objDOzT5FQYvmNy6OdGnBG7ivDPyEOl3obbxgoOHhMHRyRcG4aq2hHMa7IndUabuw==
X-Received: by 2002:a05:6830:18f1:b0:6e6:b120:e758 with SMTP id d17-20020a05683018f100b006e6b120e758mr11398202otf.25.1712033850029;
        Mon, 01 Apr 2024 21:57:30 -0700 (PDT)
Received: from localhost ([98.97.36.54])
        by smtp.gmail.com with ESMTPSA id u23-20020a63df17000000b005e857bba96csm8689063pgg.10.2024.04.01.21.57.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Apr 2024 21:57:29 -0700 (PDT)
Date: Mon, 01 Apr 2024 21:57:28 -0700
From: John Fastabend <john.fastabend@gmail.com>
To: Andrii Nakryiko <andrii@kernel.org>, 
 bpf@vger.kernel.org, 
 ast@kernel.org, 
 daniel@iogearbox.net, 
 martin.lau@kernel.org
Cc: andrii@kernel.org, 
 kernel-team@meta.com
Message-ID: <660b9038bde52_1af77208d3@john.notmuch>
In-Reply-To: <20240402021307.1012571-1-andrii@kernel.org>
References: <20240402021307.1012571-1-andrii@kernel.org>
Subject: RE: [PATCH v2 bpf-next 0/4] Add internal-only BPF per-CPU instruction
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Andrii Nakryiko wrote:
> Add a new BPF instruction for resolving per-CPU memory addresses.
> =

> New instruction is a special form of BPF_ALU64 | BPF_MOV | BPF_DW, with=

> insns->off set to BPF_ADDR_PERCPU (=3D=3D -1). It resolves provided per=
-CPU offset
> to an absolute address where per-CPU data resides for "this" CPU.
> =

> This patch set implements support for it in x86-64 BPF JIT only.
> =

> Using the new instruction, we also implement inlining for three cases:
>   - bpf_get_smp_processor_id(), which allows to avoid unnecessary trivi=
al
>     function call, saving a bit of performance and also not polluting L=
BR
>     records with unnecessary function call/return records;
>   - PERCPU_ARRAY's bpf_map_lookup_elem() is completely inlined, bringin=
g its
>     performance to implementing per-CPU data structures using global va=
riables
>     in BPF (which is an awesome improvement, see benchmarks below);
>   - PERCPU_HASH's bpf_map_lookup_elem() is partially inlined, just like=
 the
>     same for non-PERCPU HASH map; this still saves a bit of overhead.
> =

> To validate performance benefits, I hacked together a tiny benchmark do=
ing
> only bpf_map_lookup_elem() and incrementing the value by 1 for PERCPU_A=
RRAY
> (arr-inc benchmark below) and PERCPU_HASH (hash-inc benchmark below) ma=
ps. To
> establish a baseline, I also implemented logic similar to PERCPU_ARRAY =
based
> on global variable array using bpf_get_smp_processor_id() to index arra=
y for
> current CPU (glob-arr-inc benchmark below).
> =

> BEFORE
> =3D=3D=3D=3D=3D=3D
> glob-arr-inc   :  163.685 =C2=B1 0.092M/s
> arr-inc        :  138.096 =C2=B1 0.160M/s
> hash-inc       :   66.855 =C2=B1 0.123M/s
> =

> AFTER
> =3D=3D=3D=3D=3D
> glob-arr-inc   :  173.921 =C2=B1 0.039M/s (+6%)
> arr-inc        :  170.729 =C2=B1 0.210M/s (+23.7%)
> hash-inc       :   68.673 =C2=B1 0.070M/s (+2.7%)
> =

> As can be seen, PERCPU_HASH gets a modest +2.7% improvement, while glob=
al
> array-based gets a nice +6% due to inlining of bpf_get_smp_processor_id=
().
> =

> But what's really important is that arr-inc benchmark basically catches=
 up
> with glob-arr-inc, resulting in +23.7% improvement. This means that in
> practice it won't be necessary to avoid PERCPU_ARRAY anymore if perform=
ance is
> critical (e.g., high-frequent stats collection, which is often a practi=
cal use
> for PERCPU_ARRAY today).

Out of curiousity did we consider exposing this instruction outside inter=
nal
inlining? It seems it would help compiler some to not believe its doing a=

function call.

We could do some runtime rewrites to find the address for global vars for=

example.

FWIW I don't think one should block this necessarily perhaps as follow up=
?
Or at least worth considering if I didn't miss some reason its not
plausible.

> =

> v1->v2:
>   - use BPF_ALU64 | BPF_MOV instruction instead of LDX (Alexei);
>   - dropped the direct per-CPU memory read instruction, it can always b=
e added
>     back, if necessary;
>   - guarded bpf_get_smp_processor_id() behind x86-64 check (Alexei);
>   - switched all per-cpu addr casts to (unsigned long) to avoid sparse
>     warnings.
> =

> Andrii Nakryiko (4):
>   bpf: add special internal-only MOV instruction to resolve per-CPU
>     addrs
>   bpf: inline bpf_get_smp_processor_id() helper
>   bpf: inline bpf_map_lookup_elem() for PERCPU_ARRAY maps
>   bpf: inline bpf_map_lookup_elem() helper for PERCPU_HASH map
> =

>  arch/x86/net/bpf_jit_comp.c | 16 ++++++++++++++++
>  include/linux/filter.h      | 20 ++++++++++++++++++++
>  kernel/bpf/arraymap.c       | 33 +++++++++++++++++++++++++++++++++
>  kernel/bpf/core.c           |  5 +++++
>  kernel/bpf/disasm.c         | 14 ++++++++++++++
>  kernel/bpf/hashtab.c        | 21 +++++++++++++++++++++
>  kernel/bpf/verifier.c       | 24 ++++++++++++++++++++++++
>  7 files changed, 133 insertions(+)
> =

> -- =

> 2.43.0
> =

> =



