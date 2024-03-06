Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCEB91BC2A
	for <bpf@vger.kernel.org>; Wed,  6 Mar 2024 22:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709765836; cv=none; b=T9NPJtdUe2/TCRLi7eO4qe2awAWRo938PFCfW68QeF8sFp/HnCeSxO7XiC/o63Kq8rED36nsSpKW3BxV8+DmdlhnPKd6khObHTeerVt0JxnB9kLcgPF/ruBtv9yZz1QkRd9MmoepaXuKPGGJGOC7ErRwP3bG2+RMiZAL/VWAz+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709765836; c=relaxed/simple;
	bh=6iUCa3ZAy4HxLHoNsz5AtOtDL0RMmBwSGGpm9rktyrk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZIoSb6B0dTQA28ovPYPRiYjouiq6rrsNr3vWlQFijssiAsvs9SkRnrGA/XH7sjfAikNne+jdNcUBA5z3pvCzWe4Oc8aTkWzhBDWSw++4uENULRBpEXUEpy2cQJGHktFBYJb8jypUCM9yy4+0St4T07y0Qqm42n0E5ws3mvcLTG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=H1pCBg8B; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="H1pCBg8B"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-6096ab005c0so3168757b3.1
        for <bpf@vger.kernel.org>; Wed, 06 Mar 2024 14:57:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1709765834; x=1710370634; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b4Nw3ruzCEh/6x6lraL5DkvfsiMjEFZksiQV2YYXotE=;
        b=H1pCBg8BJfRS87QKeWmBoxRdPN6INvJr/bB3ZFs5BRqkun3nPNeLJ1AX6fHdj/ZoQ1
         PU3mVkEM4u+aHnmmNYyp27FeiQlRKSjAQNncbdJ7JnrnTtOFHcMrCs1FgP0r6bHV7y1n
         PdnLU9uLsCjE6fLoyT4diaLB+kmUKsIFsu3+DemBYB7F+wcN+giu5ieB5OP7hRkt61S9
         qciZsxN1O8lHk2pGO/jdrPBBqqJqyipiKTxR5rp71gBJ6A0Dk4T5E7IglsmQbtbE/3t3
         z/TotiI+hpGavfvELCN9HHe0PMOv6xGYl6lV5rIAaSs9GjPH131v9w1q5tJFWFjwAY84
         Yljw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709765834; x=1710370634;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b4Nw3ruzCEh/6x6lraL5DkvfsiMjEFZksiQV2YYXotE=;
        b=r6SiIW5x7jq6U/uvTFEl/JMwgu7swyeH0Msw4a4EC53qaa1B6EHg56Gdfa1qA0nNjN
         AXJHQo1NuAsxYYfZSPLXAVsQY6LQTo2Sok7FieQcLKgjumQtRLP642UUVy9HOG5tD5SQ
         r7nfS0sKrcLeUDIyVSwAATh03AaDq9FRs/qCpvP9YcyYU55oRypQB9ctwrdFc33tG+V6
         /+fapoGsvEVCcEbpWZ6KrLkXt0S8NCi27FF8L7GRMkGGcdbfVyoLYk0NtcZSEx924ds/
         NRCTnIXhv22zvBKD3JYu/Hz8qc06ryvZPiGiOYnQfjSOyMxq76BZVSizjH/TT+am/d/j
         T93A==
X-Gm-Message-State: AOJu0YxkV6EAkkwVzao1iNhJqD0KENBJc2mPo2EUv2H/pGxrl7jfZTRP
	6iBwRQmIIXnUVF+2TSIDOSMG3K5aH13p4jpf3FH1NJXxPP7bGupiqj2S8dMCkm5ax0FgGZX3atL
	vDTX42U4MO2ZvyGoPyEvkdZDZGfdA8QwCiASYqQ==
X-Google-Smtp-Source: AGHT+IHwPxKVjGasXZN3AkdEcSPiwiOeknvDH42CBz2GEXFk4GNpppovu9J9FQrbuAW73ifV1XqA6uY12hiEUCXFYQw=
X-Received: by 2002:a25:5186:0:b0:dcc:99b6:830b with SMTP id
 f128-20020a255186000000b00dcc99b6830bmr13006393ybb.19.1709765833765; Wed, 06
 Mar 2024 14:57:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240305030516.41519-1-alexei.starovoitov@gmail.com>
 <20240305030516.41519-3-alexei.starovoitov@gmail.com> <CA+CK2bDCgpYR2-gHv-H3vDXDqcoA16vMNr55BZ6nouZNdwGufQ@mail.gmail.com>
 <CAADnVQ+pxrRRvyLXG+opUuPuYZc+XTBLksK0rERrS1BY9ayQpQ@mail.gmail.com>
 <CA+CK2bAhWgSSotKjiGA4oTbH0XaCAtiWe+5p5u9OAf0ykBekwg@mail.gmail.com> <CAADnVQL9h7R0zYyr=P4jm9AFvK27Vx+rrUuPjTuw4QpubNngpw@mail.gmail.com>
In-Reply-To: <CAADnVQL9h7R0zYyr=P4jm9AFvK27Vx+rrUuPjTuw4QpubNngpw@mail.gmail.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Wed, 6 Mar 2024 17:56:37 -0500
Message-ID: <CA+CK2bDUA0zes3Qk5JPPurKc_8fTCbuz8VFYVc9wa7gjUbHHvA@mail.gmail.com>
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
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 6, 2024 at 5:13=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Wed, Mar 6, 2024 at 1:46=E2=80=AFPM Pasha Tatashin <pasha.tatashin@sol=
een.com> wrote:
> >
> > > > This interface and in general VM_SPARSE would be useful for
> > > > dynamically grown kernel stacks [1]. However, the might_sleep() her=
e
> > > > would be a problem. We would need to be able to handle
> > > > vm_area_map_pages() from interrupt disabled context therefore no
> > > > sleeping. The caller would need to guarantee that the page tables a=
re
> > > > pre-allocated before the mapping.
> > >
> > > Sounds like we'd need to differentiate two kinds of sparse regions.
> > > One that is really sparse where page tables are not populated (bpf us=
e case)
> > > and another where only the pte level might be empty.
> > > Only the latter one will be usable for such auto-grow stacks.
> > >
> > > Months back I played with this idea:
> > > https://git.kernel.org/pub/scm/linux/kernel/git/ast/bpf.git/commit/?&=
id=3Dce63949a879f2f26c1c1834303e6dfbfb79d1fbd
> > > that
> > > "Make vmap_pages_range() allocate page tables down to the last (PTE) =
level."
> > > Essentially pass NULL instead of 'pages' into vmap_pages_range()
> > > and it will populate all levels except the last.
> >
> > Yes, this is what is needed, however, it can be a little simpler with
> > kernel stacks:
> > given that the first page in the vm_area is mapped when stack is first
> > allocated, and that the VA range is aligned to 16K, we actually are
> > guaranteed to have all page table levels down to pte pre-allocated
> > during that initial mapping. Therefore, we do not need to worry about
> > allocating them later during PFs.
>
> Ahh. Found:
> stack =3D __vmalloc_node_range(THREAD_SIZE, THREAD_ALIGN, ...
>
> > > Then the page fault handler can service a fault in auto-growing stack
> > > area if it has a page stashed in some per-cpu free list.
> > > I suspect this is something you might need for
> > > "16k stack that is populated on fault",
> > > plus a free list of 3 pages per-cpu,
> > > and set_pte_at() in pf handler.
> >
> > Yes, what you described is exactly what I am working on: using 3-pages
> > per-cpu to handle kstack page faults. The only thing that is missing
> > is that I would like to have the ability to call a non-sleeping
> > version of vm_area_map_pages().
>
> vm_area_map_pages() cannot be non-sleepable, since the [start, end)
> range will dictate whether mid level allocs and locks are needed.
>
> Instead in alloc_thread_stack_node() you'd need a flavor
> of get_vm_area() that can align the range to THREAD_ALIGN.
> Then immediately call _sleepable_ vm_area_map_pages() to populate
> the first page and later set_pte_at() the other pages on demand
> from the fault handler.

We still need to get to PTE level to use set_pte_at(). So, either
store it in task_struct for faster PF handling, or add another
non-sleeping vmap function that will do something like this:

vm_area_set_page_at(addr, page)
{
   pgd =3D pgd_offset_k(addr)
   p4d =3D vunmap_p4d_range(pgd, addr)
   pud =3D pud_offset(p4d, addr)
   pmd =3D pmd_offset(pud, addr)
   pte =3D pte_offset_kernel(pmd, addr)

  set_pte_at(init_mm, addr, pte, mk_pte(page...));
}

Pasha
