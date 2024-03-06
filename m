Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB1361B7F6
	for <bpf@vger.kernel.org>; Wed,  6 Mar 2024 21:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709761605; cv=none; b=THXnS5U1fpAUMK2y4r5TqcUKPBtnzfQsq+rX8PDpk3mT/iplrzqZHN9SQrZ+B7itYOYiZ9tZyksFODzMbE2OGIs7aPyWSqeXqg+Zo9d44lacPWidywGeCX12vzH9SX384l4cxXm6BrrIgd4lqfHqMzro7sa/JXH/KzyCHDAr6EE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709761605; c=relaxed/simple;
	bh=sqaAoKPOgm/rSWCI7eBbS/kktgGPF2ytcO0T40EpJ3Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aa6wdCwK6P6U+BVBLNiMSY+7O+aAKpoBCYDfZPmlaaOPpkWMAGe6aJ7UfgM9wGa4pRD6psPB4HnqQekdcgCpA3n2UpDanDrknumP9/oFQKYbjGiySKKinNBMfDXkI2QMa2Pw8E9m+y7GtewQzYJgLxj+gdnlsCOmb+FWzGDIysk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=fOB38IQ8; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="fOB38IQ8"
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-42a029c8e62so1224651cf.1
        for <bpf@vger.kernel.org>; Wed, 06 Mar 2024 13:46:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1709761602; x=1710366402; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sqaAoKPOgm/rSWCI7eBbS/kktgGPF2ytcO0T40EpJ3Q=;
        b=fOB38IQ83RHWSeI0wdxqrBCGw1VcPGNdi7ukW+2i2o68cEabTuJiWdW+caWLKi5gFA
         UhzYDhImPuqHaJGL9/9uuL1p5qYmkXdRTJlybTSfeXWr9ag1GrV2iUyNbGO21ugRK/NU
         CGt+JAAVZzM5S+91TrCFb7JBVtEy2ku6yRXXowQxnUG13FTCLLkSfRA5DTtVfDuIUEJj
         chZDRdJmWajP5Drp5s0g+A1LkjvOpK+i/Yc7o/AqFgPugSkkuqag92p2GhApBBRzxZZE
         jQsquq2OzohFuyJV8yy8iWYyYAf6hWeIM0Atw9OsdASR08obq0PqCoDu0MdDvFs8W2E+
         bnaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709761602; x=1710366402;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sqaAoKPOgm/rSWCI7eBbS/kktgGPF2ytcO0T40EpJ3Q=;
        b=r8pjQjqfuck4BrEEqaT8oPFhQ1BH3JAOG463ezqruYpAuXzkspfJhNGcYHnjGXfWyc
         mB2TpsIOU9AeJGdcyQH/Ht6G3Bm0sP99HneZVw1P2D8vunEhYXGLosi1nLVLOMbS/bN9
         SsRXrTQ86hV5TsI62DwD4U8KDqV07diaGWVc0lH5wOWQMjy5E9+XJrKtHoHN47Xm4cEO
         OkFf3vHdIqMBpZfk+9qb9xmsol5FxvblJtcGJpLT5Qmx+NBEp5R39v6vtAsjJSnmSJsS
         LaEPN13ir7UvpBL2mEY8Ze6bRnUDuP1kD3opdzZj7aoes38QqrFZknIKQFBE8H3P9Nbl
         kkyA==
X-Gm-Message-State: AOJu0YzEE4ggVdvUBePRlxQqW1feOZliJmj89xHdvxAcKyicY1xfBHy3
	RmxY75UccqDmR2clp1orvX7pjkeZm9eaVdJ8oExKAFguENHe97VmXEJ+gAJrsASpM32tBBU5jd8
	ssolOBY4pHBa5vmlE3XHjRzQ1gCFftR1RqJI2tA==
X-Google-Smtp-Source: AGHT+IFM2e6KeyuiMDLqxycUojt02VdH+rm+iHu3K+tnBqw9pzAEUVRf5SsdUcF0xgYDCB5n+exrwO1T+sS2NaqjfMM=
X-Received: by 2002:ac8:7e86:0:b0:42e:f7cf:ff98 with SMTP id
 w6-20020ac87e86000000b0042ef7cfff98mr7140911qtj.16.1709761602628; Wed, 06 Mar
 2024 13:46:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240305030516.41519-1-alexei.starovoitov@gmail.com>
 <20240305030516.41519-3-alexei.starovoitov@gmail.com> <CA+CK2bDCgpYR2-gHv-H3vDXDqcoA16vMNr55BZ6nouZNdwGufQ@mail.gmail.com>
 <CAADnVQ+pxrRRvyLXG+opUuPuYZc+XTBLksK0rERrS1BY9ayQpQ@mail.gmail.com>
In-Reply-To: <CAADnVQ+pxrRRvyLXG+opUuPuYZc+XTBLksK0rERrS1BY9ayQpQ@mail.gmail.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Wed, 6 Mar 2024 16:46:05 -0500
Message-ID: <CA+CK2bAhWgSSotKjiGA4oTbH0XaCAtiWe+5p5u9OAf0ykBekwg@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 2/2] mm: Introduce VM_SPARSE kind and vm_area_[un]map_pages().
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Barret Rhoden <brho@google.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Lorenzo Stoakes <lstoakes@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Uladzislau Rezki <urezki@gmail.com>, Christoph Hellwig <hch@infradead.org>, Mike Rapoport <rppt@kernel.org>, 
	Boris Ostrovsky <boris.ostrovsky@oracle.com>, sstabellini@kernel.org, 
	Juergen Gross <jgross@suse.com>, linux-mm <linux-mm@kvack.org>, xen-devel@lists.xenproject.org, 
	Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"

> > This interface and in general VM_SPARSE would be useful for
> > dynamically grown kernel stacks [1]. However, the might_sleep() here
> > would be a problem. We would need to be able to handle
> > vm_area_map_pages() from interrupt disabled context therefore no
> > sleeping. The caller would need to guarantee that the page tables are
> > pre-allocated before the mapping.
>
> Sounds like we'd need to differentiate two kinds of sparse regions.
> One that is really sparse where page tables are not populated (bpf use case)
> and another where only the pte level might be empty.
> Only the latter one will be usable for such auto-grow stacks.
>
> Months back I played with this idea:
> https://git.kernel.org/pub/scm/linux/kernel/git/ast/bpf.git/commit/?&id=ce63949a879f2f26c1c1834303e6dfbfb79d1fbd
> that
> "Make vmap_pages_range() allocate page tables down to the last (PTE) level."
> Essentially pass NULL instead of 'pages' into vmap_pages_range()
> and it will populate all levels except the last.

Yes, this is what is needed, however, it can be a little simpler with
kernel stacks:
given that the first page in the vm_area is mapped when stack is first
allocated, and that the VA range is aligned to 16K, we actually are
guaranteed to have all page table levels down to pte pre-allocated
during that initial mapping. Therefore, we do not need to worry about
allocating them later during PFs.

> Then the page fault handler can service a fault in auto-growing stack
> area if it has a page stashed in some per-cpu free list.
> I suspect this is something you might need for
> "16k stack that is populated on fault",
> plus a free list of 3 pages per-cpu,
> and set_pte_at() in pf handler.

Yes, what you described is exactly what I am working on: using 3-pages
per-cpu to handle kstack page faults. The only thing that is missing
is that I would like to have the ability to call a non-sleeping
version of vm_area_map_pages().

Pasha
