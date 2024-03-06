Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EDDA1B7EB
	for <bpf@vger.kernel.org>; Wed,  6 Mar 2024 22:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709763189; cv=none; b=gEWnMJnRfJucPmHFSucxazV6124ip6A4Da4sZm6n2Ln3JNAXkuaaHCaiZecpc9dk5R4Pf0Gd45ioh4dpqNO+Te5KNU5FblbaPWt+bYJOfe7oDSzXhYGPKppf5GVbOzRduswTL/glogdrFPAf3DmaYo0um6F2q50d7c0DmOM+pZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709763189; c=relaxed/simple;
	bh=0co437MWlwiDr7sdvNxT0czQBG4oFsy/9/ksjHplhkY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EJsBrfuMdMnE6PdNSCDQrYE6XZD7bN74GOIiLblS+CgN08CT9TFjMgjrr+lWBYAJEW3Dt8nffzjdEaZbuOci105U+xigpfLyDPtSt6fanUQxQCNt9UklPYnDArmaSRCDMAXH62iZa3oIYmBMdPgwAGsdwUM9b6ljwjtsgBRBAmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DMtz6wpC; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DMtz6wpC"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-412eddd165eso2295085e9.1
        for <bpf@vger.kernel.org>; Wed, 06 Mar 2024 14:13:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709763186; x=1710367986; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0co437MWlwiDr7sdvNxT0czQBG4oFsy/9/ksjHplhkY=;
        b=DMtz6wpC+pAUDD2rTImsJL/IQWuSaBetw3YZ7Rh+gP1h2h/+26DGosj3jV7YDeX7Yu
         gWPEmMwLWVMD6+yBjeWE75tSjX+zmAKm2SCbkXeYFkoRxzDz3F7v+pxcJbQ0Qt6vj9y5
         6u5oBbEADiV/9tWjd/PEp2WnjfPY6G19rWFrKa0TQsP8kcub9p3HZ4VGV4IgAR64HKyf
         XWNK/sgYDB83qnIkHeRgTPUqq+uNBVNBJ1uFK3CBM7HUpNMw4STXnxHzwao5kKKnHzye
         kJyLEpvrwJ4j7wLi82l7srKOEFzg8CtHR2mmLAktz11DKo+wWggwRZpIRYCNL3gGRFee
         Aauw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709763186; x=1710367986;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0co437MWlwiDr7sdvNxT0czQBG4oFsy/9/ksjHplhkY=;
        b=fJczv0VX//ZKh7Anjd+IAT+KtAJwpQjbXCQ+9tDMNQLBKMK4/ugKwddt34btC7WyfO
         hqz3k1rWbZDqaxVP9HU1mfaXkJuVzKGR8gQLluYX1apVFlpYuJfU/2yAWoYdwa00oFvr
         4wCNm2TkQN48bPjaqqbZbWNMTNTcepu1Ip9PtY9xhXA0PeMsgkoGU3tvoh8M2O2eC/Sq
         AlaPbWm+XdCm0pj2lWiXKc/P57TbzJ0Y9uMAfzz+opZcnObQEiFXcjKe+zS4mCPY5bRb
         H211Yn8VWIQ6X4FyRMLoD34ZcEtC0xjv1BacddJ/SgOWHg8sZ/nOWzr9mxBMHR6PSWC3
         4THg==
X-Gm-Message-State: AOJu0YzPrClPJ/qHQQfaIJspJyusRIZLyM7F+IRib5v1tKNkoyVlRBVp
	OBkCThTqhFOtRf1kFKMLvcHBTx9MN5mIyIeUgnNZaUhx/RDWdl0rgp7KXIRHfLWIkUQK2qvz2sB
	/Ie0ZtXuxBW8OasevdpSlTX5oiOc=
X-Google-Smtp-Source: AGHT+IHM5WAdyGr/B7hLl36s77xYo/gy7yzLMW3COR6pSamXxzxHTbpB4M1O/zLuG0Dc6UyW1yEJEoYoydHCAh4AHuk=
X-Received: by 2002:a05:6000:1cd2:b0:33d:82c1:f9d3 with SMTP id
 bf18-20020a0560001cd200b0033d82c1f9d3mr11649861wrb.4.1709763185840; Wed, 06
 Mar 2024 14:13:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240305030516.41519-1-alexei.starovoitov@gmail.com>
 <20240305030516.41519-3-alexei.starovoitov@gmail.com> <CA+CK2bDCgpYR2-gHv-H3vDXDqcoA16vMNr55BZ6nouZNdwGufQ@mail.gmail.com>
 <CAADnVQ+pxrRRvyLXG+opUuPuYZc+XTBLksK0rERrS1BY9ayQpQ@mail.gmail.com> <CA+CK2bAhWgSSotKjiGA4oTbH0XaCAtiWe+5p5u9OAf0ykBekwg@mail.gmail.com>
In-Reply-To: <CA+CK2bAhWgSSotKjiGA4oTbH0XaCAtiWe+5p5u9OAf0ykBekwg@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 6 Mar 2024 14:12:54 -0800
Message-ID: <CAADnVQL9h7R0zYyr=P4jm9AFvK27Vx+rrUuPjTuw4QpubNngpw@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 2/2] mm: Introduce VM_SPARSE kind and vm_area_[un]map_pages().
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: bpf <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Barret Rhoden <brho@google.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Lorenzo Stoakes <lstoakes@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Uladzislau Rezki <urezki@gmail.com>, Christoph Hellwig <hch@infradead.org>, Mike Rapoport <rppt@kernel.org>, 
	Boris Ostrovsky <boris.ostrovsky@oracle.com>, sstabellini@kernel.org, 
	Juergen Gross <jgross@suse.com>, linux-mm <linux-mm@kvack.org>, xen-devel@lists.xenproject.org, 
	Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 6, 2024 at 1:46=E2=80=AFPM Pasha Tatashin <pasha.tatashin@solee=
n.com> wrote:
>
> > > This interface and in general VM_SPARSE would be useful for
> > > dynamically grown kernel stacks [1]. However, the might_sleep() here
> > > would be a problem. We would need to be able to handle
> > > vm_area_map_pages() from interrupt disabled context therefore no
> > > sleeping. The caller would need to guarantee that the page tables are
> > > pre-allocated before the mapping.
> >
> > Sounds like we'd need to differentiate two kinds of sparse regions.
> > One that is really sparse where page tables are not populated (bpf use =
case)
> > and another where only the pte level might be empty.
> > Only the latter one will be usable for such auto-grow stacks.
> >
> > Months back I played with this idea:
> > https://git.kernel.org/pub/scm/linux/kernel/git/ast/bpf.git/commit/?&id=
=3Dce63949a879f2f26c1c1834303e6dfbfb79d1fbd
> > that
> > "Make vmap_pages_range() allocate page tables down to the last (PTE) le=
vel."
> > Essentially pass NULL instead of 'pages' into vmap_pages_range()
> > and it will populate all levels except the last.
>
> Yes, this is what is needed, however, it can be a little simpler with
> kernel stacks:
> given that the first page in the vm_area is mapped when stack is first
> allocated, and that the VA range is aligned to 16K, we actually are
> guaranteed to have all page table levels down to pte pre-allocated
> during that initial mapping. Therefore, we do not need to worry about
> allocating them later during PFs.

Ahh. Found:
stack =3D __vmalloc_node_range(THREAD_SIZE, THREAD_ALIGN, ...

> > Then the page fault handler can service a fault in auto-growing stack
> > area if it has a page stashed in some per-cpu free list.
> > I suspect this is something you might need for
> > "16k stack that is populated on fault",
> > plus a free list of 3 pages per-cpu,
> > and set_pte_at() in pf handler.
>
> Yes, what you described is exactly what I am working on: using 3-pages
> per-cpu to handle kstack page faults. The only thing that is missing
> is that I would like to have the ability to call a non-sleeping
> version of vm_area_map_pages().

vm_area_map_pages() cannot be non-sleepable, since the [start, end)
range will dictate whether mid level allocs and locks are needed.

Instead in alloc_thread_stack_node() you'd need a flavor
of get_vm_area() that can align the range to THREAD_ALIGN.
Then immediately call _sleepable_ vm_area_map_pages() to populate
the first page and later set_pte_at() the other pages on demand
from the fault handler.
