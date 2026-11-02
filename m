Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.225.64
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793662542;
	b=AvuV0wQthMYa0MLLv1g9oxSg+NbTHJ9het44yUwU/M60I/c7R5e90wcv+2awulmaVc2n
	 g0LUi2ca6P9zZmMIjJthuKh+SXZu6WHaEawLDTJzYIlz5vYacoP19mjjko8NTsrfIz9hb
	 K7Txccsr42Xp5oGWRBWSGyfK+lJ5yk7Z5cyard4OXOZfac/e5/wG0INMtTjXoB2Kyd4tp
	 2jRZ9N0yZMsHVeXUquTipaTeG+YoMPgVZvXnCvLN846J7BGtdWrezYU7YArfhgsQPyBwA
	 Gvn9zuX27i/8wMyHT4na8KJCoJX0B+3aDbwPpCyfddLXSCmaIV8TZeLwsGxOyP/xe+w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793662542;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=TV80sOzz/vcy1+/AApdEAozOHLfPItRWRfNS1VF4Pzg=;
	b=j6JvrNKL8qz+nx41fV+GRSFaspULBipXEcJ/rKTZLCETxI426yqWlYeoqA2rgucirl18
	 ZqFOYvmwEKXxbTDiuqv9kv/j3zRRSXGVHM+fjrudWEUC4dSoOSNzyMjlz1bZ32zFThlMY
	 r3ZDtgxstiw35KgKRUJio2+V1vxTSP6IlSjcq7K5KmC1evnByTfkA6vno8XnXe8JSkboa
	 DB91uzxnNga3RORWa0x3YIQ6et8/ILF6QRYH6r3r+ZIneJJrjoUvGoPFZ6VZQosEXSz2j
	 6AmLKhkBI63wL5qqxM+wRoz/6mnEbCKKT3Y6KO4VOZ7cPeMQrU1ZSgFshzKTDmeZbRw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qsYfyFUr;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.225.64
Received: from mail-wr2-f0.google.com (mail-wr2-f0.google.com [74.125.225.64])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36EA6606A335
	for <bpf@vger.kernel.org>; Mon,  2 Nov 2026 23:35:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 36EA6606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qsYfyFUr
Received: by mail-wr2-f0.google.com with SMTP id ffacd0b85a97d-48db76d98a1so1327719f8f.1
        for <bpf@vger.kernel.org>; Mon, 02 Nov 2026 15:35:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793662540; cv=none;
        d=google.com; s=arc-20260327;
        b=jJGQd9pq+oLy8bgf4OJQdKjoYwma5vG3Yz3UhPz0IKb6ZHswPB/1KPdNPotHO3kdVD
         QgzP0sBnE1+lv4mPaUE3PMrNLOAxjYsRNAGatlJHnjM5gSZNGyb/9neAsH7h6eQOaf53
         1am5TiaAM0yJA6ExCzMOPAqDkNFM/wpeZ0xYrcfoEhSBqsX7p0PbBG3mq7zLIk+9wbbf
         Ab1hCHYGyr0pBYyBkoB2ndOh2SUx27z4Ryq+Rt9KPHWoUZ29wp0hY0CsrFI7kqvEkEmm
         XbLWoDg8oOknsAF7WjKLlx5vbcl104XSPp3suxss8PCyiliJ5ypSJ+dysa6f9MqkMA0E
         9sKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=TV80sOzz/vcy1+/AApdEAozOHLfPItRWRfNS1VF4Pzg=;
        fh=1ZmuRNejLyfXvsdotytC6h7ytTSE8CjkQ8+1kqUuyyU=;
        b=bq4jHZRTlG0wV4INl8411YSVTxz0jRCsC4wuJt5CLVKNl7UggZvGzhQIC4Ei7mVj0E
         RnKTaLhizRjydt/ATkkF3giNuerqE7guDhCY14uDF7qtSeIRksYuaErJjkDP+BiYHYM2
         wfuxvcfNj9DseOL9I9iVDV9jdfy5/u1+/XBm9XKKCEMfQCk8mNBUskbuBT0ggDSr44Bg
         pFzhQyOLERUH7pM5IfuJYNcYtuCV7pcqv3LHhJHq7atEgLYJ9vLkDIG6D7aNSyv8/2iS
         dWkBtcHxlUab723rYJn9gstT+SMLTgY2ODCauda1IHyQpSmtoTD3voMLM0hFAui5ZuwY
         y8tg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793662540; x=1794267340; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TV80sOzz/vcy1+/AApdEAozOHLfPItRWRfNS1VF4Pzg=;
        b=qsYfyFUr9sVYKW5DXIJEgpK+RsXIwXj7j6Fia1AHrQ5joFU3SKoTKzWV8vse1Vuo5L
         LjGKKSB2v3GSPmBUjIMHvX/tHx5+DylVjNk15hGNhSeYC/5NTp5pMZF8L58VCvuAL/z3
         8DXHxqRQ46xwHuAsUtRQiN6ASCW6DafLZNg/E+jLBDE2Fr2nyLo3KUiHrCDe37SYLsRx
         e9SuGqWkyp/+F3qQzITombLHlOuye9ZsO+OcjVVmpjB92yWvtY5onw0wNGIrj/dNYRCA
         IU12QEW4Nj6vfO3IC1y8cOxyu08GfubUYH23ZWNcb/yhE51AZcUuOPg25HD+gsWJd3Mm
         nLUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793662540; x=1794267340;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=TV80sOzz/vcy1+/AApdEAozOHLfPItRWRfNS1VF4Pzg=;
        b=DzYl6cxh4Vop9Rw/XzwD6Jxi5N0kcaDPhuKXqvXJs2FUaYp1uL+vcRrjrJe2K94iDB
         Yw5tAVDdnGpMLn37ca1D5YVFdZN0CwpkYyecwwv7tiYsYFM5vb6eEZ3+6u7sp/737tq2
         jkARJg2oFyl0O+sh2FrFqDgxIZJomIN4Q+ESJjaXXOLHirV/9lctyJLDs6eb7ovKBu+y
         ndv8ZGCvF+pRMD0/9LgZwO+Ilws6KPkohKeg3VF5fVNsfpOG1vB02r6+MmNcWyLXKHsr
         WCKna8ITRyQfA0TVsCF/01DMmyG8hQPukw0u+Dt7qKN5GMTgv9xw+0neHM9fFehSS/+y
         /c9Q==
X-Forwarded-Encrypted: i=1; AKwUvByzJoTEMoSCuPioJgCtdyJtvsCwHJEeAzvgIBi+8gQBGgUg5mFBqML9W/QdEzWnZ+WZjsI=@vger.kernel.org
X-Gm-Message-State: APuU4Z/AyD/JUkcoTGwYangAB+xpE/JNHcEgimF0yzEyPDBE179Uz0jT
	Eiw2dXLXsFPHp2J10AU9IJc/v9pl0bFvNTSaYKgY74bEqtT00R+mBk7ubbeTSqwkqe0e9aUxE1j
	TKSMr0DSSvLWUps9CoVnAIjixKDQ7EKk=
X-Gm-Gg: AYBFou0IuG17ygzRs0VjQJ7QWNFeqXZ0GzGoPLsnTG4Qh+5iuBafgMEIWKIiYhUKCMx
	G5OmLLl4KrkassWLhAu9y71czq2pGfjH5taobdQlrnStojVMRK3gQ0usp4x50Gvme7owHySfXH7
	pEie2tPwSLHMWzcX9bWXYl1eH5UsXzXWIm9bOJIhp25xZjSKyrYcuiafLOF4d0LzZ44Ubb6uI95
	ly0WcfrN470COdtdUe3MK4FDeVDEsYzEE4YM7ZuVSvuFKcY/EvOTK16lK7G5qCnjFVqglSu+ymf
	L+oxKGeRPwB0wjcDSj4hqP/LWr/pYI2mTqut3PjyDBLNQ29oidDcz2r7iqQKfOTXI3VL9oUX9k3
	xQGYe8CC0J8n39sW9fhfO8n+Kr0DLyxJrmdKf8DwAYv6Q1oAxlQCbNCuUWPE3kbpTXy13pSLj3X
	9zdR/5RSqiIBVqlQ/FHm3EsYXYPPmnthqDCmHqkXu7IFB1DXSzge2T7YKraL1LLFGGKun6OW/Ri
	o2/hAOiqUSUn7yV
X-Received: by 2002:a05:6000:2209:b0:48d:ee0d:8b3d with SMTP id
 ffacd0b85a97d-48e6e2f6d6fmr27571822f8f.28.1793662540382; Mon, 02 Nov 2026
 15:35:40 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261028015141.10710-1-emil@etsalapatis.com> <20261028015141.10710-2-emil@etsalapatis.com>
 <DML3ICCA0NOI.3NTJHPQB0ZF29@gmail.com>
In-Reply-To: <DML3ICCA0NOI.3NTJHPQB0ZF29@gmail.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Tue, 3 Nov 2026 00:35:01 +0100
X-Gm-Features: AclHuK9ZmbObJ-6ZtsKw7y39OCXBk7Qo_3-J3wBhsiDlfHjHfz6KevkRXb3t3qc
Message-ID: <CAP01T77fBRqfCM=VVjq0Vo8zFYzBLL9Adw5Wr8ar-fb862L1RA@mail.gmail.com>
Subject: Re: [PATCH bpf 1/2] bpf: recover page faults across all arenas
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Emil Tsalapatis <emil@etsalapatis.com>, bpf@vger.kernel.org, ast@kernel.org, 
	andrii@kernel.org, eddyz87@gmail.com, daniel@iogearbox.net, 
	Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 2 Nov 2026 at 23:58, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Wed Oct 28, 2026 at 1:51 AM UTC, Emil Tsalapatis wrote:
> > The current arena fault handling code accounts for
> > misbehaving BPF programs that free arena memory
> > while it is being accessed by a kfunc as part of
> > another BPF program's execution. This scenario
> > triggers a kernel page fault that is intercepted
> > by BPF arena-specific code. The code confirms
> > that the fault is within the BPF program's arena,
> > installs a scratch page, and marks the fault as
> > handled. This is necessary to prevent BPF programs
> > from being able to trigger an oops.
> >
> > However, the protection against misbehaving BPF programs
> > is currently incomplete: Arena memory is accessed by
> > kernel code not just as part of a kfunc, but also from
> > non-BPF paths. This is the case with sched-ext that
> > includes non-BPF code paths that access arena pointers.
> > These paths do not have an arena associated with them,
> > and a fault there causes an oops. Such a fault can be
> > triggered by a misbehaving BPF program by unmapping the
> > pages nominally owned by the genpool allocator used for
> > cid management.
> >
> > Extend the kernel arena fault handling to consider all
> > arenas in the system. The handler now scans a global
> > arena list till it finds an arena that includes the address,
> > and fixes up the address. Retain the stream-based reporting
> > code for when the faulting call stack includes the BPF
> > program that owns the arena.
> >
> > Fixes: 9eca087deb0b ("sched_ext: Sub-allocator over kernel-claimed BPF arena pages")
> > Cc: Tejun Heo <tj@kernel.org>
> > Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
> > ---
> >  kernel/bpf/arena.c | 54 ++++++++++++++++++++++++++++++----------------
> >  1 file changed, 35 insertions(+), 19 deletions(-)
> >
> > diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
> > index 868589f07330..992a0b123449 100644
> > --- a/kernel/bpf/arena.c
> > +++ b/kernel/bpf/arena.c
> > @@ -10,6 +10,7 @@
> >  #include <linux/btf_ids.h>
> >  #include <linux/vmalloc.h>
> >  #include <linux/pagemap.h>
> > +#include <linux/rculist.h>
> >  #include <asm/tlbflush.h>
> >  #include "range_tree.h"
> >
> > @@ -46,10 +47,14 @@
> >  #define GUARD_SZ round_up(1ull << sizeof_field(struct bpf_insn, off) * 8, PAGE_SIZE << 1)
> >  #define KERN_VM_SZ (SZ_4G + GUARD_SZ)
> >
> > +static LIST_HEAD(arena_list);
> > +static DEFINE_SPINLOCK(arena_list_lock);
> > +
> >  static void arena_free_pages(struct bpf_arena *arena, long uaddr, long page_cnt, bool sleepable);
> >
> >  struct bpf_arena {
> >       struct bpf_map map;
> > +     struct list_head list;
> >       u64 user_vm_start;
> >       u64 user_vm_end;
> >       struct vm_struct *kern_vm;
> > @@ -332,6 +337,10 @@ static struct bpf_map *arena_map_alloc(union bpf_attr *attr)
> >       if (err)
> >               goto err_destroy_rt;
> >
> > +     spin_lock(&arena_list_lock);
> > +     list_add_tail_rcu(&arena->list, &arena_list);
> > +     spin_unlock(&arena_list_lock);
> > +
> >       return &arena->map;
> >
> >  err_destroy_rt:
> > @@ -385,6 +394,12 @@ static void arena_map_free(struct bpf_map *map)
> >       if (WARN_ON_ONCE(!list_empty(&arena->vma_list)))
> >               return;
> >
> > +     spin_lock(&arena_list_lock);
> > +     list_del_rcu(&arena->list);
> > +     spin_unlock(&arena_list_lock);
> > +
> > +     synchronize_rcu();
>
> we tried to avoid sync_rcu() as much as possible.
> Find a way to do it differently.
>
> > +
> >       /* Ensure no pending deferred frees */
> >       irq_work_sync(&arena->free_irq);
> >       flush_work(&arena->free_work);
> > @@ -1207,31 +1222,32 @@ bool bpf_arena_handle_page_fault(unsigned long addr, bool is_write, unsigned lon
> >       struct bpf_prog *prog;
> >       unsigned long kbase;
> >       unsigned long page_addr = addr & PAGE_MASK;
> > -
> > -     prog = bpf_prog_find_from_stack();
>
> This has to stay. If there are thousands arena. Above should still be a fast path.
> Only for sched-ext arena access it should search link link.

We cannot rely on this, there might be a different program in the call
stack. That's why there is an equality check on the arena when
actually reporting, to make sure it's going to the right program.

The better way to address the scalability problem is to use a
different data structure. I presume that replacing the list with a
rbtree_latch should work. Updates will be infrequent compared to walk,
so RCU+seqlock should suffice for consistent look ups. That's ~10
steps for a 1000, ~20 for a million, so it should suffice.


>
> > -     if (!prog)
> > -             return false;
> > -
> > -     arena = prog->aux->arena;
> > -     /* a prog not using arena may be on stack, so arena can be NULL */
> > -     if (!arena)
> > -             return false;
> > -
> > -     kbase = bpf_arena_get_kern_vm_start(arena);
> > +     bool handled = false;
> >
> >       /*
> >        * Recovery covers the 4 GiB mappable band plus the upper half-guard.
> >        * Lower guard is unreachable from kfuncs; an address there indicates
> >        * a different bug class - leave it to the regular kernel oops path.
> >        */
> > -     if (page_addr < kbase || page_addr >= kbase + SZ_4G + GUARD_SZ / 2)
> > -             return false;
> > -
> > -     apply_to_page_range(&init_mm, page_addr, PAGE_SIZE,
> > -                         apply_range_set_scratch_cb, arena->scratch_page);
> > -     flush_vmap_cache(page_addr, PAGE_SIZE);
> > -     __bpf_prog_report_arena_violation(prog, is_write, page_addr - kbase, fault_ip);
> > -     return true;
> > +     rcu_read_lock();
> > +     list_for_each_entry_rcu(arena, &arena_list, list) {
> > +             kbase = bpf_arena_get_kern_vm_start(arena);
> > +             if (page_addr < kbase || page_addr >= kbase + SZ_4G + GUARD_SZ / 2)
> > +                     continue;
> > +
> > +             apply_to_page_range(&init_mm, page_addr, PAGE_SIZE,
> > +                                 apply_range_set_scratch_cb, arena->scratch_page);
> > +             flush_vmap_cache(page_addr, PAGE_SIZE);
> > +
> > +             prog = bpf_prog_find_from_stack();
> > +             if (prog && prog->aux->arena == arena)
> > +                     __bpf_prog_report_arena_violation(prog, is_write,
> > +                                                       page_addr - kbase, fault_ip);
>
> There has to be reporting mechanism for sched-ext faults too.
> Just silence is not an option.
>
> pw-bot: cr
