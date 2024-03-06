Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEFDD1B945
	for <bpf@vger.kernel.org>; Wed,  6 Mar 2024 22:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709765876; cv=none; b=idtojKqANuPSvm0kdhS2i07pnlcCIF7I7CM96ziNaQG3L0j26b10qx1t4AIse9u5n/pu+ed7H3DPLsBjtK1jztOa+KKIEF3V+OvRV/tkUQ3DfDXq80REyJ0C9jGZ9p7c/K+gRtu2mRfUD3gyf6l4umC8kdZCwdiqtD7ANZPBnwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709765876; c=relaxed/simple;
	bh=ME5eerA8hiC3qLAN/TJxCvNK5L2z/RnW96seJ3aXlH0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TKj+VKEyVir6uMfQjmtXD6H0+wIBXdEGHSVbBkYAVQAv1mH8EfwWQyfcB0l4K0ZLpAOi8mFiaWkYcIckwt8I6zYAV3ysqv2KLJqdXd7xQC4a1ncjJbI1TUGtHguy5QID+GGAaZMyH7O7K/Mj6JWX7gOVUYhaqqLD41zgtYze8M4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=MM+zkSa8; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="MM+zkSa8"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-609eb2cbeccso2939517b3.2
        for <bpf@vger.kernel.org>; Wed, 06 Mar 2024 14:57:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1709765874; x=1710370674; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T30BbYOoDoqevyGB85war3bXduSTpLM1AIfsEUvxyFs=;
        b=MM+zkSa8aFt4segQsJ0sY7rbb+fSXRYPuSu2HxDuvTpkfaxA89bewsqSDzFiBFy4vc
         Sw19IG/D/5Qza1QV+S5aEl6j/KWu8gss15HcVgtBLzZQEyr1hwoR3W51r1ad5LgEqpwP
         x/qc/nmV51KIOTgZ+oYag4ZIPhsh21z8ebGp+Y1h5QbBIC9crpH73vZrUY0E+4mKdX91
         fafVEptY+x1u9HzpYE7lART0n9zUeQuT9HlxEWpClHoC8MiFaEbZGmdfgbIVlezPEOJv
         DiIFVom83Is97jFwRQPbJ2zXr84ZZAxSxGNQs9o1IuED3H9jSSra3Sd7YGKPIKRllffh
         tSuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709765874; x=1710370674;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T30BbYOoDoqevyGB85war3bXduSTpLM1AIfsEUvxyFs=;
        b=Py5V+ADcJ0h7ASZd4a18V4OiS+qtY/taKz3+Uq2KPeCoetFbyIcnx2N9UALPzCt6KN
         tkdQnC8RbWFaqkKcN/UvzpXAklnZA8pQK/t7spoFq+Ki6j0UQoOvZrkYQ5YiupRq9Df4
         ftbX5GLJgW0IZeM31doNFfqeYjjkairUnEd/YvwnaK4hkhuqTAlpWCVjNV+gh2qF/C7o
         vhg5qFgP9howXDLeF/iTyOOLRzHilGhvOXQQADg0SnkGrtL9sq1sZBWRoNEAYv0xWAmp
         opkVMKmfgD6Dmaw0kyA/Kqg5r7LAHKpwMKfAS4ZEmFjv2w5ftTtRLT0QsxijhHza+D8h
         ljHw==
X-Gm-Message-State: AOJu0Yx7q4cSKwkmEoYMOACojKenFwT63UTV2LSdyXABlhbkQwNRo/r6
	cKysPx86Hv0jgI5Xk41eW0/o1VRGxqPE1UIAFm4cJ+nl5dfp3PB3m8LCfXcsAdLuatQTd6dPlqH
	2gdEkHqjPXirtnj+nJDxFHil1JvyhO6BNO/Lr5w==
X-Google-Smtp-Source: AGHT+IH63s+eoFax9fdsbS9trqEfT/NfZeSwMdLE8iVC9tCXSyx9a+v6pqCiDdrSLUuvOaDIefTbxnfswQ7+lbT1/Qw=
X-Received: by 2002:a0d:ddc7:0:b0:608:e844:4117 with SMTP id
 g190-20020a0dddc7000000b00608e8444117mr13169519ywe.33.1709765873400; Wed, 06
 Mar 2024 14:57:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240305030516.41519-1-alexei.starovoitov@gmail.com> <20240305030516.41519-3-alexei.starovoitov@gmail.com>
In-Reply-To: <20240305030516.41519-3-alexei.starovoitov@gmail.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Wed, 6 Mar 2024 17:57:16 -0500
Message-ID: <CA+CK2bAVTRiDoLo8_Vzksg_utg9QHL3cRbQ=uyf_i4Qp-_xg+w@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 2/2] mm: Introduce VM_SPARSE kind and vm_area_[un]map_pages().
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	torvalds@linux-foundation.org, brho@google.com, hannes@cmpxchg.org, 
	lstoakes@gmail.com, akpm@linux-foundation.org, urezki@gmail.com, 
	hch@infradead.org, rppt@kernel.org, boris.ostrovsky@oracle.com, 
	sstabellini@kernel.org, jgross@suse.com, linux-mm@kvack.org, 
	xen-devel@lists.xenproject.org, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 4, 2024 at 10:05=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> From: Alexei Starovoitov <ast@kernel.org>
>
> vmap/vmalloc APIs are used to map a set of pages into contiguous kernel
> virtual space.
>
> get_vm_area() with appropriate flag is used to request an area of kernel
> address range. It's used for vmalloc, vmap, ioremap, xen use cases.
> - vmalloc use case dominates the usage. Such vm areas have VM_ALLOC flag.
> - the areas created by vmap() function should be tagged with VM_MAP.
> - ioremap areas are tagged with VM_IOREMAP.
>
> BPF would like to extend the vmap API to implement a lazily-populated
> sparse, yet contiguous kernel virtual space. Introduce VM_SPARSE flag
> and vm_area_map_pages(area, start_addr, count, pages) API to map a set
> of pages within a given area.
> It has the same sanity checks as vmap() does.
> It also checks that get_vm_area() was created with VM_SPARSE flag
> which identifies such areas in /proc/vmallocinfo
> and returns zero pages on read through /proc/kcore.
>
> The next commits will introduce bpf_arena which is a sparsely populated
> shared memory region between bpf program and user space process. It will
> map privately-managed pages into a sparse vm area with the following step=
s:
>
>   // request virtual memory region during bpf prog verification
>   area =3D get_vm_area(area_size, VM_SPARSE);
>
>   // on demand
>   vm_area_map_pages(area, kaddr, kend, pages);
>   vm_area_unmap_pages(area, kaddr, kend);
>
>   // after bpf program is detached and unloaded
>   free_vm_area(area);
>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>

Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
