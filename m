Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E6AC346E55
	for <bpf@vger.kernel.org>; Fri, 17 Jul 2026 08:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784275518; cv=pass; b=MicFsG2ZFXzvG/8wyMp9XfTydqrW0yo7z9s8NWTIGM9pfTrYPTWqZrYhESmH2i3G/XEUaVfo0JyvUoaNC4Wr3MF8Kk90zf+P5I6FXhA6YiixJO/wq9JQ23A37gWAlaOvtlahflJWaoBik+6gg1SFTH12AASewBgwB6amJlaCAIs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784275518; c=relaxed/simple;
	bh=ixqGazb5x/YDz9G5klc3k021+W+6ZzDKKpfBaXTjqVo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kPAuC28aJLSTZlkxFAr9YGBwbbnq2dJ5RUduusavIMbtcHSladcif8XitiU0xHKvtiHJlBsqlNYfshhxsV3heA9EQE2KW4A0tmVlYwUaVlnNr8oy1EzTkJhzRVSKMhoTsyPod0AopmV58A2sJkfMbgFDf5VJiSaEWc/mzeHuE0Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=feTxq3LU; arc=pass smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="feTxq3LU"
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7e9fc3de7ceso2740735a34.1
        for <bpf@vger.kernel.org>; Fri, 17 Jul 2026 01:05:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784275516; cv=none;
        d=google.com; s=arc-20260327;
        b=ny/fP+u9NyGs5+BMbDA/xaGQHemoPjoZWwgMrja1FcmeCOoaahzYjo367Ib3IwXk6i
         pxElOksderf7yYeIf44LGCB/ho7AvrVYkwb6pvuyWCJcK63vzH/9e4Vs1coP2oKQxABu
         cJUBdx79qYObyDFlqoCBDprnkyFiDDIev8fKXM+o91zqqyYVizeaug0ZfUAfb5NPLqUy
         MQVlsQLthBpp4IhjfwNgMNdRakKJ8kf4ucphDaFd35LgeY6FLLprlsQkvoXKcz88T/JX
         IkNPYLCwz9AGkjybfHZwVgJdkm0avwTILUEsA4uRmpbWkDBwDk1lwAJu+IQbmqwVBfR+
         kOzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=NfXrXQw1fobjJb9xBIDk+12kYWCVjSmiwbD+2PDbQ3Q=;
        fh=T/yyLwTYu2V8yB5WZSf2o3mzecsfcq/+A7U7H9TC+wI=;
        b=FtlWx076sRt+ffPr1olf0ZP8DuIbBE5vIAtwx81nWBBZ2+Bmu4Rln7qRZrcidlJHZn
         LNVqSoBp9zKqZKynDsqCx/h+KhxES7ILyx8gz4O0bt5e/psVSeVktROe4Gx5bCcFX36J
         wDC2K3UvK//3N7LYpvIgOuEmaoJP+7SNK46eY7sWQe405K1/EWc0C5nl0uI3QBeK3dhR
         Etw46gUMcVblMoZmFnUNTzT+XH1ZRdxyRuDI5/99PSzX/ZfrC/BywfLnmLKWync1JinJ
         ZBC8aE9JB4YlKt3JyIWTjfpo8S8WYbuPLrbtEYYBl06EQHTFbQjKoCG3CwmlptX+lQM4
         YMTQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784275516; x=1784880316; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NfXrXQw1fobjJb9xBIDk+12kYWCVjSmiwbD+2PDbQ3Q=;
        b=feTxq3LUxvSa+dKZg1GD7sr11cQlxKKFQrqOkX9bCoU6fCxP9OEYNWi0ITdMVxleuM
         xPUd1nRruPiP3bfB91bzQCbtygBVHY0fu/mMdr3vKbuRQP8XWCaNvCuIHqisfoFTajNF
         Y2eWpg274tLv1mO6+dXOEYXOna7zPL1dQxIpeUxefEUx3sAV84H/dlOconObkTaPsoN7
         MuCmTvobWBcCZcILVEZvezqV/WwiH1vxW0CJDsF15GwnU9/Sao3Gla0ww/2TcicpEu6W
         L5qcXSTFKwKKmY5358XMXIVX3tWW4+t9IUC03jxdz2VhpzDFyywNxtTd4+QSmThvy14Z
         mlnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784275516; x=1784880316;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=NfXrXQw1fobjJb9xBIDk+12kYWCVjSmiwbD+2PDbQ3Q=;
        b=A9/wy+uqm8TQMcrGiCehBsFDlSv+F/Z94LNO4Tc8pArktpbfS12+YSe27xPC1wznEr
         NMVZDnd5IvJOp5DLuNRLBZXRsqwWl/g7adGMEOTylSttuKDu10K4ZWmEzk8J9/cHRudm
         p19oKZ1LWmm1zYHUCp7klrHCQJ1/VFDnwx5QtIA0SI86JtzJPyz8Lm8SZsUlMnh1G/2l
         zhrsfEt09ez3vDEFtV2B8MgrFYxHgsBl9kOW5DyLab5j2FACHdNN6iiRSv+Q/SZvMBHt
         hNJ14ERi6snfFN6aNHELeX6PjAHB82oQYgknlak9QFU5b9HY8o8fYO/O4NMymntTkdUV
         jqXg==
X-Forwarded-Encrypted: i=1; AHgh+RozIGpZEeOhU1Yw8aqw+kowcAOSPBEEXhrgOpmbwTmd3a1sSxvzVx2k3bHEzlo64foqgUI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxrD5o7Zw2oayh6RaxF8puPesOPyt/oZskSdHcptKwIGeh2fdfL
	pEpffKgmvN3EKjG3hf6QAMRlxRZvFy0Eygvj7qpfLSxZ3mAPlnO4tcnZriT3WGOVLfZw83PY9yp
	ka06EkFzLFnKWjhqErDb+yzZWEFpk6R8=
X-Gm-Gg: AfdE7cktfs4AcNJVvy06capRrKU/ixu/gEoe0w497af4YkkEDiXZY2O3o9iN0WFHPYa
	GmuQYgh9JG+yhB2UP8SD/tjgnBdtQ9UGZzoH6bupJ37d1OToKBDdiNeBvmKHn+XFTTT266smtZe
	aNgCf+O/MUnJRe5qhzW9xTKhiDscBwClSAb7uh4KlVpBqp+1WWCDtMv7s6eevyk33igVAX1niVl
	rXDQoAHy52sL3at1K3bTdB95S6ghSPYJSoDATJFfJGjws0XgU8fotkWgGZn+CsY6IuLzwtXBXTv
	LRq+dIXidcQnS4pw
X-Received: by 2002:a05:6808:19a6:b0:496:2b3:4a85 with SMTP id
 5614622812f47-4a4d054c616mr657577b6e.22.1784275515528; Fri, 17 Jul 2026
 01:05:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260716-series-vmap-race-fix-v4-0-8c108c4317df@kernel.org>
 <20260716-series-vmap-race-fix-v4-2-8c108c4317df@kernel.org>
 <CA+XhMqzUO49FiC-Oa6VYUt7Wm9RZLH30DhUH2kVn_PBodyZ6dg@mail.gmail.com> <alnLFGkfJdWIV42P@lucifer>
In-Reply-To: <alnLFGkfJdWIV42P@lucifer>
From: David CARLIER <devnexen@gmail.com>
Date: Fri, 17 Jul 2026 09:05:04 +0100
X-Gm-Features: AUfX_my2AxRQQJXhZAU1yLMsSU3AGuvi1Pc5chSlMdx5pvK9SEJVQNRbJvskW6c
Message-ID: <CA+XhMqygWOnYuxR26x-cjwWQNXGxzh4Za9Fb1570LMKXWzpMyA@mail.gmail.com>
Subject: Re: [PATCH mm-hotfixes v4 2/4] x86/mm/pat: acquire init_mm write lock
 to avoid UAF
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Suren Baghdasaryan <surenb@google.com>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>, David Hildenbrand <david@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Michal Hocko <mhocko@suse.com>, Uladzislau Rezki <urezki@gmail.com>, 
	Toshi Kani <toshi.kani@hpe.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Kiryl Shutsemau <kas@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Dev Jain <dev.jain@arm.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	"Denis V. Lunev" <den@virtuozzo.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Yes I used AI to agglomerate my otherwise disparate thoughts :)

On Fri, 17 Jul 2026 at 08:47, Lorenzo Stoakes (ARM) <ljs@kernel.org> wrote:
>
> On Fri, Jul 17, 2026 at 04:46:42AM +0100, David CARLIER wrote:
> > On Thu, 16 Jul 2026 at 22:31, Lorenzo Stoakes (ARM) <ljs@kernel.org> wrote:
> > >
> > > x86 implements page attribute modification using its Change Page
> > > Attributes (CPA) mechanism.
> > >
> > > This tracks properties of ranges such as cache mode through x86 page
> > > attributes, and as part of that logic manipulates kernel page tables.
> > >
> > > Since commit 41d88484c71c ("x86/mm/pat: restore large ROX pages after
> > > fragmentation") ranges of kernel page table entries can be collapsed into
> > > huge page table entries as part of this logic.
> > >
> > > As part of this collapse, it frees the page tables which the collapsed
> > > entries previously pointed to, and it does so without any relevant locks
> > > being held to preclude concurrent kernel page table walkers.
> > >
> > > The only way this code can be reached is if CPA_COLLAPSE is specified, and
> > > this is only set in set_memory_rox() via:
> > >
> > > set_memory_rox()
> > > -> change_page_attr_set_clr()
> > > -> cpa_flush()
> > > -> cpa_collapse_large_pages()
> > >
> > > Notable users of this are execmem and bpf when manipulating executable
> > > mappings.
> > >
> > > However, this is problematic for ptdump as it walks ranges it does not own
> > > and thus runs the risk of a use-after-free on page tables freed underneath
> > > it.
> > >
> > > In addition, concurrent CPA collapse operations are possible which can also
> > > cause races.
> > >
> > > Resolve the issue by acquiring the mmap write lock on init_mm across the
> > > whole operation.
> > >
> > > It is safe to acquire a sleeping lock as all the callers invoke
> > > set_memory_rox() from process context and in any case,
> > > change_page_attr_set_clr() calls vm_unmap_alias() which ultimately takes a
> > > mutex, disallowing atomic context here.
> > >
> > > Fixes: 41d88484c71c ("x86/mm/pat: restore large ROX pages after fragmentation")
> > > Cc: stable@vger.kernel.org
> > > Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> > > Reviewed-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
> > > Reviewed-by: David Hildenbrand (Arm) <david@kernel.org>
> > > Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
> > > Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> > > ---
> > >  arch/x86/mm/pat/set_memory.c | 15 ++++++++++++++-
> > >  include/linux/mmap_lock.h    |  2 ++
> > >  2 files changed, 16 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
> > > index d023a40a1e03..d1e63f7d267f 100644
> > > --- a/arch/x86/mm/pat/set_memory.c
> > > +++ b/arch/x86/mm/pat/set_memory.c
> > > @@ -22,6 +22,7 @@
> > >  #include <linux/cc_platform.h>
> > >  #include <linux/set_memory.h>
> > >  #include <linux/memregion.h>
> > > +#include <linux/cleanup.h>
> > >
> > >  #include <asm/e820/api.h>
> > >  #include <asm/processor.h>
> > > @@ -410,7 +411,7 @@ static void __cpa_flush_tlb(void *data)
> > >
> > >  static int collapse_large_pages(unsigned long addr, struct list_head *pgtables);
> > >
> > > -static void cpa_collapse_large_pages(struct cpa_data *cpa)
> > > +static void __cpa_collapse_large_pages(struct cpa_data *cpa)
> > >  {
> > >         unsigned long start, addr, end;
> > >         struct ptdesc *ptdesc, *tmp;
> > > @@ -442,6 +443,18 @@ static void cpa_collapse_large_pages(struct cpa_data *cpa)
> > >         }
> > >  }
> > >
> > > +static void cpa_collapse_large_pages(struct cpa_data *cpa)
> > > +{
> > > +       /*
> > > +        * Take the mmap write lock on init_mm to:
> > > +        * - Avoid a use-after-free if raced by ptdump (which takes its own
> > > +        *   write lock on init_mm).
> > > +        * - Serialise concurrent CPA walkers.
> > > +        */
> > > +       scoped_guard(mmap_write_lock, &init_mm)
> > > +               __cpa_collapse_large_pages(cpa);
> > > +}
> > > +
> > >  static void cpa_flush(struct cpa_data *cpa, int cache)
> > >  {
> > >         unsigned int i;
> > > diff --git a/include/linux/mmap_lock.h b/include/linux/mmap_lock.h
> > > index 6b5c2390cc30..047f5f5e2c34 100644
> > > --- a/include/linux/mmap_lock.h
> > > +++ b/include/linux/mmap_lock.h
> > > @@ -621,6 +621,8 @@ static inline void mmap_read_unlock(struct mm_struct *mm)
> > >
> > >  DEFINE_GUARD(mmap_read_lock, struct mm_struct *,
> > >              mmap_read_lock(_T), mmap_read_unlock(_T))
> > > +DEFINE_GUARD(mmap_write_lock, struct mm_struct *,
> > > +            mmap_write_lock(_T), mmap_write_unlock(_T))
> > >  DEFINE_GUARD_COND(mmap_read_lock, _try, mmap_read_trylock(_T))
> > >
> > >  static inline void mmap_read_unlock_non_owner(struct mm_struct *mm)
> > >
> > > --
> > > 2.55.0
> > >
> >
> > Hi,
> >
> > This bullet confuses me. __change_page_attr() and friends are serialised by
>
> Which bullet? You're quoting the whole mail?
>
> Presumably "- Serialise concurrent CPA walkers".
>
> > cpa_lock/pgd_lock and never take init_mm's mmap lock, so this doesn't
> > exclude them.
> >
> > Collapse vs collapse looks covered already: collapse_large_pages() holds
>
> cpa_collapse_large_pages() has 3 stages:
>
> - walk + gather
> - flush tlb
> - free page tables
>
> Holding a lock then releasing it across stages doesn't serialise the whole
> operation.
>
> Thus concurrent collapse can occur.
>
> > pgd_lock across the walk and both collapse_pmd_page()/collapse_pud_page()
> > calls, and the pmd_leaf()/pud_leaf() early-outs stop a second CPU
> > re-queueing a collapsed table. I couldn't build the interleaving behind the
> > cover letter's "could result in memory corruption". Can you spell it out?
>
> "Build the interleaving" is an odd turn of phrase :)
>
> >
> > If the reason is really Will's v3 point - collapse rounds up to PMD/PUD and
> > frees tables outside its caller's range, so it has to exclude
> > walk_kernel_page_table_range() walkers holding the read lock - then say
> > that. It's a UAF independent of ptdump, and it's why v3's read lock wasn't
> > enough.
>
> "Then say that" could be rephrased into something a little more polite :)
>

Sorry I did not mean that tone originally

> >
> > Also: patch 1 justifies the trylock fallback on ptdump being rare, but this
> > takes the write lock on every set_memory_rox() (BPF JIT, module load,
> > execmem), even when nothing collapsed. vmap_try_huge_*() then loses the
>
> Locks work by excluding the critical section.
>
> > trylock and quietly falls back to PTEs on every BPF load. No counter, no
>
> Entirely false. You don't have concurrent writers on every load.
>
> > trace. Not a blocker and I've no better idea, but fa93b45fd397 was about
> > getting vmalloc-huge on by default, so it's worth calling out.
>
> I have no idea why you're referencing Dev's arm64 fix?
>
> Anyway as to the 'costly' stuff - you're doing costly operations on this code
> path anyway.
>
> BPF JIT, module load + execmem allocation are not hot path operations nor do
> they seem likely to be problematic in terms of lock contention.
>
> >
> > Rest looks right. 4/4 restores pud_free_pmd_page() exactly as it was before
> > fa93b45fd397, and 3/4 builds the same walk init_mm got via
> > walk_kernel_page_table_range_lockless().
>
> ??? I didn't change any of those in this revision? Let's keep review of a
> specific patch to review of a specific patch, please :)
>
> >
> > Reviewed-by: David Carlier <devnexen@gmail.com>
>
> Thanks.
>
> >
> > Cheers !
>
> This reply reads like it was... assisted shall we say. Let me gently push back
> on doing that please ;)
>
> I don't think there are actually any other readers that could be problematic
> here, so this a bit of a half-fix, really we need to do the same thing or take a
> read lock on the split path too.
>
> Let me think about it some more.
>
> Thanks, Lorenzo
>
> Assisted-by: Caffeine (Vimto energy with real fruit juice)
