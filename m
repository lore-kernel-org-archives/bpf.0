Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF2BD280318
	for <bpf@vger.kernel.org>; Wed, 27 May 2026 09:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779875938; cv=none; b=Y9vagYPde/iUZaZ4grHyo2lzKlpMbFO9+aLWrZKfROQAqhuRds6dIWwQveLO82s0WZgDtg0xIyu7M4z+vW33AGCDmfuP/s0KljFFAkDeP2gb0Yc+xg4aaxVWFwzA7n35OJ1Luge1pKmqpCrhMT1HrDzV4gXyTkmBWy1sLgOKZZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779875938; c=relaxed/simple;
	bh=2XMHAg5sjyB20uLbt86ZiyXYi2ORDIHeeSjnHPzbmgU=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PcjavEFwKxI9oAYTSPpWf1ECdYiHPpuDOY8sGSgOfxFCIMiBEvRlkKNolOHf+oY0H7HnEp6kIl27dmRMQKNkqoryWd1iQrXem6EilM4O8hIFpeNkpwA0QjcW8jJjb84pTtt48PXE49jTgoT6ydrp9CuWEWmtbCwaAG1AXU0VkLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QQgWZcrb; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QQgWZcrb"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4905e190c71so36884045e9.3
        for <bpf@vger.kernel.org>; Wed, 27 May 2026 02:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779875935; x=1780480735; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mh7HLC3BlatP/45la4c42cY7HDmSSf3TZXrZ8ATTGlA=;
        b=QQgWZcrbHGUnFY4NxS5cm04VodFrzg2ipfGwxzIkPMrDaRf0DpW0GgPkla6oyE+xi+
         V13NOKg2C25hV5sAoo5apJjXLAxGoObHTctRE48wTbRBANfX7ioFA0eDVdFf14wfTkPD
         Ev0lZa4qzcXuG/vGZmmOHCJYWXv0DyxSRZcQUOapDqZWkVZVbyZoBKKR/sprgSseRmlV
         EWSr4/ejvY5pgmL18gCzE23IvHy4VK3sjmdcsDaQLar12pKl1UpddrUJ0ier2fGvm/HP
         twnArGvHfvynEXcZx6sS7imNNQlg4bMeTLmxGmH1Q7m4M+SQqABMxjMoFRXlW5VuM1O4
         4osA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779875935; x=1780480735;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mh7HLC3BlatP/45la4c42cY7HDmSSf3TZXrZ8ATTGlA=;
        b=M2BoucKT3zoN5fvYaXA8T7uhB239oyqPDJD+lZsng2x7vA2vhtH5HqrF5ayxIgUGyP
         zzxHtxKocX7TE5t63VNG1tRo7Za512bim1Lj294EwIka/gir/s49b95k/RKT/uLIhGFQ
         9+DcVCyCnOF/u/qr3HBbDnrCr6rlHbC+U/fQ8zBB0sROnzTNvy5yFkwJcvBwt0ElubxD
         Za3v8YWXfXJ/q/+ElRSVV51CcbYTLt90gOeaAZe1+KNJJkk/vdg/bZG125uIc91kfUnz
         Z7XYCiNJhRuCZEiGQwco5Akjk/ZYNr7qsWnj7vJSFhUyd0pFf3zsWevdrh4dq04Wc4N+
         DQPA==
X-Forwarded-Encrypted: i=1; AFNElJ8N8EUGoES+iSgrKYlXKYAMPstTWxce8Q1OHspw0LUp2/47PhENiRshQlHBFZ9+bIXMIBY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzA+rNTB8apGeT++uamQmAk4JkloZ4jf+erlqq4BWqcV9siFg64
	a+G6bQdXYM9PLINgoBjrIiW0N6M4YOj1NVpT/4dOPKyQx4ePBLr//xCa
X-Gm-Gg: Acq92OHwcKsKYwGWb73Dq1IYmUIJRwCtBb7IndJcHPF/BosMc2Zl27V8rrZe2B/tO6p
	j/+cvzVhUWNI4PCI9Wk8J2rdueLLOq9Lyrafg8allpsPMoNjRLGPS342cdixXPx2CslVsSb+xKI
	nncwnjbfAR0sYNy+GAww0nS/+loSBLhBZmSqH7FHzwm6E2bwtVmC9pOCEfyIwD4B0xqbkFuv9+W
	9CAznuN8mCrrjY1oeUkQdCVxspUyQWI7PwT9ShmR+LEGLWnpmAd9gjE0lZQG5nLyRhrn/UZ+Ini
	3Q/aBr8nwIIw2V2KAdbGvKhyxdQ/zdZ0LYdExi8jvMnWcbsCA4s1n8O6BEwswCWqCqcNMxiD0kB
	6VubLycFIHBrEzx5RXPjHqPJwheNqQpMweqPzrLDmIFjpfJ66Ge5cgftBn40B/zwD/ifdxBtSRC
	5EWFxcI3mif5Xgyds=
X-Received: by 2002:a05:600c:3106:b0:490:6889:1ff with SMTP id 5b1f17b1804b1-4906889025dmr169360455e9.28.1779875935115;
        Wed, 27 May 2026 02:58:55 -0700 (PDT)
Received: from krava ([2a02:8308:a00c:e200:b655:ff13:e355:16a3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49044f2bad3sm417695375e9.0.2026.05.27.02.58.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 02:58:54 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 27 May 2026 11:58:52 +0200
To: bot+bpf-ci@kernel.org
Cc: oleg@redhat.com, peterz@infradead.org, mingo@kernel.org,
	mhiramat@kernel.org, andrii@kernel.org, bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, ast@kernel.org,
	daniel@iogearbox.net, martin.lau@kernel.org, eddyz87@gmail.com,
	yonghong.song@linux.dev, clm@meta.com, ihor.solodrai@linux.dev
Subject: Re: [PATCHv4 02/13] uprobes/x86: Remove struct uprobe_trampoline
 object
Message-ID: <ahbAXMH-R9Sk5N_3@krava>
References: <20260526205840.173790-3-jolsa@kernel.org>
 <22e6111c3aa950ec8eaa29c776670e6f834f82249190a652b2afa9a9cb551d76@mail.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <22e6111c3aa950ec8eaa29c776670e6f834f82249190a652b2afa9a9cb551d76@mail.kernel.org>

On Tue, May 26, 2026 at 09:46:44PM +0000, bot+bpf-ci@kernel.org wrote:
> > diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
> > index 2be6707e3320..733655bc610e 100644
> > --- a/arch/x86/kernel/uprobes.c
> > +++ b/arch/x86/kernel/uprobes.c
> 
> [ ... ]
> 
> > @@ -1111,21 +1051,18 @@ int set_orig_insn(struct arch_uprobe *auprobe, struct vm_area_struct *vma,
> >  static int __arch_uprobe_optimize(struct arch_uprobe *auprobe, struct mm_struct *mm,
> >  				  unsigned long vaddr)
> >  {
> > -	struct uprobe_trampoline *tramp;
> > -	struct vm_area_struct *vma;
> > -	bool new = false;
> > -	int err = 0;
> > +	struct pt_regs *regs = task_pt_regs(current);
> > +	struct vm_area_struct *vma, *tramp;
> >
> > +	if (!user_64bit_mode(regs))
> > +		return -EINVAL;
> >  	vma = find_vma(mm, vaddr);
> >  	if (!vma)
> >  		return -EINVAL;
> > -	tramp = get_uprobe_trampoline(vaddr, &new);
> > -	if (!tramp)
> > -		return -EINVAL;
> > -	err = swbp_optimize(auprobe, vma, vaddr, tramp->vaddr);
> > -	if (WARN_ON_ONCE(err) && new)
> > -		destroy_uprobe_trampoline(tramp);
> > -	return err;
> > +	tramp = get_uprobe_trampoline(mm, vaddr);
> > +	if (IS_ERR(tramp))
> > +		return PTR_ERR(tramp);
> > +	return WARN_ON_ONCE(swbp_optimize(auprobe, vma, vaddr, tramp->vm_start));
> >  }
> 
> When swbp_optimize() fails in __arch_uprobe_optimize() and the preceding
> get_uprobe_trampoline() call created a new trampoline VMA via
> _install_special_mapping(), does the new VMA leak in the process address
> space?
> 
> The pre-patch code tracked whether the trampoline was newly created and
> called destroy_uprobe_trampoline() on the failure path:
> 
>   err = swbp_optimize(auprobe, vma, vaddr, tramp->vaddr);
>   if (WARN_ON_ONCE(err) && new)
>       destroy_uprobe_trampoline(tramp);
>   return err;
> 
> The new code drops that cleanup entirely:
> 
>   return WARN_ON_ONCE(swbp_optimize(auprobe, vma, vaddr, tramp->vm_start));
> 
> Although the old destroy_uprobe_trampoline only freed the struct (not the
> underlying VMA), the new code appears to introduce a VMA leak: the freshly
> mapped PAGE_SIZE special mapping in the user's address space stays mapped
> even though optimization failed. arch_uprobe_optimize() then sets
> ARCH_UPROBE_FLAG_OPTIMIZE_FAIL so subsequent calls won't retry, leaving the
> orphan trampoline mapping in the address space until exit_mmap() reaps it at
> process teardown.
> 
> The commit message mentions: "Note the original code called
> destroy_uprobe_trampoline if the optimiation failed, but it only freed the
> struct uprobe_trampoline object, not the vma. The new vma leak is fixed in
> following change."
> 
> Is the VMA leak addressed in the subsequent commit in this series?

yes, in:

      [1] uprobes/x86: Unmap trampoline vma object in case it's unused

> 
> A secondary behaviour change is that 'return WARN_ON_ONCE(swbp_optimize(...))'
> now returns the boolean truth value of the error (0 or 1) instead of the
> original errno. While the current caller (arch_uprobe_optimize) only treats
> the value as boolean, could this surprise a future caller that propagates the
> return code?

ah ok, this is actualy 'fixed' in [1] above, but yea we should
fix that directly in this change, will do

> 
> Commit message:
> 
> >     uprobes/x86: Remove struct uprobe_trampoline object
> >
> >     Removing struct uprobe_trampoline object and it's tracking code,
> >     because it's not needed. We can do same thing directly on top of
> >     struct vm_area_struct objects.
> >
> >     This makes the code simpler and allows easy propagation of the
> >     trampoline vma object into child process in following change.
> >
> >     Note the original code called destroy_uprobe_trampoline if the
> >     optimiation failed, but it only freed the struct uprobe_trampoline
> >     object, not the vma. The new vma leak is fixed in following change.
> >
> >     Acked-by: Andrii Nakryiko <andrii@kernel.org>
> >     Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> 
> CI bot suggested adding a Fixes tag in v3: 'Fixes: ba2bfc97b462
> ("uprobes/x86: Add support to optimize uprobes")' because the commit message
> notes a VMA resource leak in the original code.
> 
> Reference: https://lore.kernel.org/bpf/8861cc7af8e0dfff2674ca4ae6381ea2d82c242dec115774e8e11048bde358c4@mail.kernel.org/
> 
> The author responded that 'the logic stays' and a separate fix is needed, but
> did not explain why the Fixes tag should not be included. If this patch is
> documenting a pre-existing bug (even if the full fix comes later), should it
> include a Fixes tag for backporting purposes?

there's not functional change in this patch, the vma leak fix is in [1]

jirka
