Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 830A73E63AE
	for <bpf@vger.kernel.org>; Wed, 27 May 2026 09:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779875834; cv=none; b=E4BeGqBD/VripAwI5ivZKqEWnSJyiNi45WayvwKGPwbmm1YIYdxcwmZjDD6zYvNpbLXRIkziU1rd8BVUmzqXllBGiVaI1sCTO+n02Uy0+5m/UWnAtxGD/ErD2GO2srPYLjgmByxALxHoR8YSQucHVAHdd1/O/jcBSysKkgrbCO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779875834; c=relaxed/simple;
	bh=Tuai1Axfjkxum1GztuUcohIb7OIi67bbFU7uLGV2pY8=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jwWtFC//jos9lqHWzRuf/65oErfEoZgMdlgFyv5bzA9P4wfGR2QZ2i1T8UORWHCxAS9blIzAdUztt2aF9jA3l2hCvrjro6jsXfVoVRG+AtspyWk9UTSixdegr1xNTWLcryMbbg9p5ceixY8kycXaxNHSev6tQbmjVh5935bCLeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kTjMV1y1; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kTjMV1y1"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4904127c32cso33425865e9.2
        for <bpf@vger.kernel.org>; Wed, 27 May 2026 02:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779875831; x=1780480631; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XuaoXI5CN/vWA5ZvTeay7KhFRspk+qd3be2g4mt/zXc=;
        b=kTjMV1y1zqPnyl6QajXeHnlLCnLph+IccY66NKXzp9VWpwtkabUzQA5sbthZHTE/T4
         exsAxdpphFY1OOn7qaNH5tYADUKlYO7YkvMg2Pe6XyhuwCivGyv66QPcBR5mhXEvJjyD
         Snug2jFR6E/cCSPsKMiKQkAxIipfwVc40D1rUmHekng9kytALn+p+IZwv4LOboYKeH1Z
         xq4MB9x68YJe9RhqOsZsOSCnxrQeNdq9kSTUTmhHdfzULRlZmpS2sWm42XP5Z9xgXfNn
         nPmgUIZ2ua8rlf9lH6xHpUrlf2P/TdcdWVjdk6cQYk+jDg2ETwzDXOeFJZ4sSy1qLh/8
         rZ3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779875831; x=1780480631;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XuaoXI5CN/vWA5ZvTeay7KhFRspk+qd3be2g4mt/zXc=;
        b=nLWQCNjmeO0AHJ00WbNKq5znZs9vyWge+BlIWkRnD73mGr/MLyizfO5hvgL8/jNtM7
         MhZl5xhC38DNypEVGvWw/Wkv3Vp0YM3Vid9V1NVf4DnHJGyCu3HZ8x88p1twygnfj+bo
         PnQsoWxUVXesM/ABHM0wusW9QILdBLV5yIkZS13uKPcDEEudPmU1UlrLHr4huGCIi8gh
         dyyRdwcwbOseAsKgTGWqqlLfXT46JhTbrQASdwuazdrfvn8L4OVhXiUpAcWl4JiLAYIt
         M494ucYaEQGgdoeu3wkioh9GNr23OWNx/Evf+G00qSX2/gmWoS5nDWKuyC8rhBsYTQk8
         abQA==
X-Forwarded-Encrypted: i=1; AFNElJ/HzOlYfY8rSyzr245JK+ulIOu/iTC+EWaSNJHlvPbpdwnBQuDbohnFPL74f7P8KjGxjz8=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywi+wgE4H1AcrlraCHmVaIyMBjZrTIVxKJF9ClYHx0M1y6X5KO5
	J1uaGt6sj5821z9OWPs7oLQszOD/+YJKFEOSwyJWgre8rdoJI101Wemy
X-Gm-Gg: Acq92OE3GnohpDzgiFiFpp+lEmjL561ddezXKC1LPi3hgwP70GBecHjoTjKRltSJf5N
	iKzcvj8Shlvg0JaQygp0V++WEa/WSHHvCyYgOAD8CWAQACcm1tGp4K6ULo8Rexl3hRtiwVi6jjv
	9VTe7GzYECubwoPFgse9aFE6bpUhkg6oghmctF9pVx3jyUicwROoRAEzDGRVvYVM1sQQnZwikkz
	lIkSDM5Kos7fZ3a2TkxIPIldJUDsqreP9cAe3lzDprHt9SlCUObNeI+0ZLk7zWixL1EtjuIp+nT
	5l3qzqO30xz8kBgs43dQlx4SllFDZW5+699Iew34+nIA8dQ++Mdq+Q1IWNnr+cFQdUZnxTO8xL5
	EtVOZjV3tMNvkqrukz5Bspa3JgJFc+KmiKJvS4v7c3HukXJ2NE2uHgVSx17MmeQ0G1ex5/17QEd
	ik2RG9gzMZgVymDUCZVF/QE6bFQw==
X-Received: by 2002:a05:600c:4688:b0:490:4224:e0a2 with SMTP id 5b1f17b1804b1-49042ae265bmr385107545e9.33.1779875830564;
        Wed, 27 May 2026 02:57:10 -0700 (PDT)
Received: from krava ([2a02:8308:a00c:e200:b655:ff13:e355:16a3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45edb54a6cdsm4845867f8f.2.2026.05.27.02.57.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 02:57:10 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 27 May 2026 11:57:08 +0200
To: bot+bpf-ci@kernel.org
Cc: oleg@redhat.com, peterz@infradead.org, mingo@kernel.org,
	mhiramat@kernel.org, andrii@kernel.org, bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, ast@kernel.org,
	daniel@iogearbox.net, martin.lau@kernel.org, eddyz87@gmail.com,
	yonghong.song@linux.dev, clm@meta.com, ihor.solodrai@linux.dev
Subject: Re: [PATCHv4 04/13] uprobes/x86: Unmap trampoline vma object in case
 it's unused
Message-ID: <aha_9GF7AYzVRSsm@krava>
References: <20260526205840.173790-5-jolsa@kernel.org>
 <addf3472e04583c864492a9343420c1e0356b324b4a84a71145dd759d8ec367d@mail.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <addf3472e04583c864492a9343420c1e0356b324b4a84a71145dd759d8ec367d@mail.kernel.org>

On Tue, May 26, 2026 at 09:46:49PM +0000, bot+bpf-ci@kernel.org wrote:
> > commit 68883203f0583fb1a8d79536f5c8945542974abd
> > Author: Jiri Olsa <jolsa@kernel.org>
> > Date:   Tue May 26 22:58:31 2026 +0200
> >
> >     uprobes/x86: Unmap trampoline vma object in case it's unused
> >
> >     In case the optimization fails, we leak new-ly created trampoline
> >     vma mapping (in case we just created it), let's unmap it.
> >
> >     Fixes: ba2bfc97b462 ("uprobes/x86: Add support to optimize uprobes")
> >     Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> 
> Should this Fixes: tag point to a9fe6f54968c instead? The vma leak bug
> was actually introduced by commit a9fe6f54968c ("uprobes/x86: Remove
> struct uprobe_trampoline object"), not ba2bfc97b462. Commit a9fe6f54968c
> removed the destroy_uprobe_trampoline() cleanup call, and its commit
> message explicitly states: "The new vma leak is fixed in following
> change."

there's no a9fe6f54968c hash yet

> 
> Suggested: Fixes: a9fe6f54968c ("uprobes/x86: Remove struct
> uprobe_trampoline object")
> 
> > diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
> > index c8af41ed681a..af5af7d67999 100644
> > --- a/arch/x86/kernel/uprobes.c
> > +++ b/arch/x86/kernel/uprobes.c
> > @@ -677,11 +677,14 @@ static unsigned long find_nearest_trampoline(unsigned long vaddr)
> >  	return high_tramp;
> >  }
> >
> > -static struct vm_area_struct *get_uprobe_trampoline(struct mm_struct *mm, unsigned long vaddr)
> > +static struct vm_area_struct *get_uprobe_trampoline(struct mm_struct *mm, unsigned long vaddr,
> > +						    bool *new_mapping)
> >  {
> >  	VMA_ITERATOR(vmi, mm, 0);
> >  	struct vm_area_struct *vma;
> >
> > +	*new_mapping = false;
> > +
> >  	if (vaddr > TASK_SIZE || vaddr < PAGE_SIZE)
> >  		return ERR_PTR(-EINVAL);
> >
> 
> Does this fix address the VMA leak scenario across fork chains? In v2,
> sashiko-bot raised a concern about inherited-but-not-tracked VMAs:
> 
> https://lore.kernel.org/bpf/20260518114208.CE128C2BCF6@smtp.kernel.org/
> 
> When VM_DONTCOPY is removed, child processes inherit trampoline VMAs
> but their tracking list (mm->uprobes_state.head_tramps) is empty. When
> the child executes a uprobe, get_uprobe_trampoline() fails to find the
> inherited VMA and creates a duplicate trampoline.
> 
> Child fork:
>   dup_mmap()
>     copies trampoline VMA to child
>   mm_init_uprobes_state()
>     initializes head_tramps as empty (parent's state not copied)
> 
> Child executes uprobe:
>   arch_uprobe_optimize()
>     get_uprobe_trampoline()
>       head_tramps is empty, fails to find inherited VMA
>       create_uprobe_trampoline()
>         find_nearest_trampoline() finds new unmapped area
>         installs second duplicate trampoline VMA
> 
> In a deep fork chain, each generation inherits all previous VMAs, has an
> empty head_tramps list, and creates a new VMA. Can this cause linear
> accumulation of redundant VMAs, eventually exhausting vm.max_map_count?
> 
> While this patch addresses unmapping failed optimization attempts, it
> does not prevent the inherited-but-not-tracked VMA leak scenario in fork
> chains.

there's not head_tramps list anymore, was removed by earlier:
      uprobes/x86: Remove struct uprobe_trampoline object

jirka
