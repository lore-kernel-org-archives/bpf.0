Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B99693BCD38
	for <bpf@vger.kernel.org>; Wed, 24 Jun 2026 14:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782311802; cv=none; b=onjYZ/CQgD8pYVihIQwj1eQ/guKDK2PXqJcjfIdup6sMJ8W4z3syIl69ib7HLBSdAf1J8S4Bhb+g5mNqfBmU4fEkxpovLXFMK9NzoKaCYoT7agjiHnlRYSb4hqFgg/ESqNZXWtr5B/Gqp08V79nWQleY/6SVaQh9g8Xqq2NUYAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782311802; c=relaxed/simple;
	bh=BLvwlESbQuCEDSXzS5tqvFwFYU3vidOruIhHVHNdGfA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h3O7TvCBTBz8MyUB1r/CK+KBSEeI2ZKAMbCfOGMdgr8HMMSEQ1m5OK2XQkTFeehAGXnb1vhizRXfAWyIGo3tnD4MTIVtyc5pmsS8Q3KX379GLl6Y2I9mskBtswxCoDX5NdlzIY50g7l3OTsOhMgRQZAlrvyrYr7VTeN02j/wIRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UmAd/CUC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UmAd/CUC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782311795;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tjzQ5iUZx4dqlG760rsAJ6ErKlvbzuwirIpLM5sBmLQ=;
	b=UmAd/CUCAYWI5M/wDlDsCe/xc5H0RU25wUu/FDmkpnWCZ+n6cOCbpbsIyXMzhudkQLnJfp
	Uh5KuaW+EohuvSNn12CwoKE43uKP7/LiqzqEhkylK+A10qUAmwJhzUjHt1fu6ke0yDY4WM
	JIjaX5ukespkvAmIwSr1OYmUqFskfB4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-678-fuOYshRCM3Ol80Tmq2a6-w-1; Wed,
 24 Jun 2026 10:36:29 -0400
X-MC-Unique: fuOYshRCM3Ol80Tmq2a6-w-1
X-Mimecast-MFC-AGG-ID: fuOYshRCM3Ol80Tmq2a6-w_1782311788
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 10C6D1955DD8;
	Wed, 24 Jun 2026 14:36:28 +0000 (UTC)
Received: from fedora (unknown [10.44.33.191])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 1BFD8180049F;
	Wed, 24 Jun 2026 14:36:24 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed, 24 Jun 2026 16:36:27 +0200 (CEST)
Date: Wed, 24 Jun 2026 16:36:23 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Jiri Olsa <jolsa@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCHv4 02/13] uprobes/x86: Remove struct uprobe_trampoline
 object
Message-ID: <ajvrZ_mMXnKrWf7h@redhat.com>
References: <20260526205840.173790-1-jolsa@kernel.org>
 <20260526205840.173790-3-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260526205840.173790-3-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

On 05/26, Jiri Olsa wrote:
>
> Removing struct uprobe_trampoline object and it's tracking code,
> because it's not needed. We can do same thing directly on top of
> struct vm_area_struct objects.
>
> This makes the code simpler and allows easy propagation of the
> trampoline vma object into child process in following change.
>
> Note the original code called destroy_uprobe_trampoline if the
> optimiation failed, but it only freed the struct uprobe_trampoline
> object, not the vma. The new vma leak is fixed in following change.
>
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>

Reviewed-by: Oleg Nesterov <oleg@redhat.com>

---------------------------------------------------------------------
Although I can't convince myself I fully understand this code with or
without this patch ;)

A couple of questions below...

> -static struct uprobe_trampoline *create_uprobe_trampoline(unsigned long vaddr)
> +static struct vm_area_struct *get_uprobe_trampoline(struct mm_struct *mm, unsigned long vaddr)
>  {
> -	struct pt_regs *regs = task_pt_regs(current);
> -	struct mm_struct *mm = current->mm;
> -	struct uprobe_trampoline *tramp;
> +	VMA_ITERATOR(vmi, mm, 0);
>  	struct vm_area_struct *vma;
>
> -	if (!user_64bit_mode(regs))
> -		return NULL;
> +	if (vaddr > TASK_SIZE || vaddr < PAGE_SIZE)
> +		return ERR_PTR(-EINVAL);

Do we really need this check? It looks a bit confusing to me...
vaddr is bp_vaddr from handle_swbp(), it should be valid?

> +
> +	for_each_vma(vmi, vma) {
> +		if (!vma_is_special_mapping(vma, &tramp_mapping))
> +			continue;
> +		if (is_reachable_by_call(vma->vm_start, vaddr))
> +			return vma;
> +	}

Perhaps we can later optimize this code a bit? I mean something like

	start_reachable = ...;
	end_reachable = ...;

	VMA_ITERATOR(vmi, mm, start_reachable);

	for_each_vma(vmi, vma) {
		if (!vma_is_special_mapping(...))
			continue;
		if (vma->vm_start > end_reachable)
			break;
		return vma;
	}

>  static int __arch_uprobe_optimize(struct arch_uprobe *auprobe, struct mm_struct *mm,
>  				  unsigned long vaddr)
>  {
> -	struct uprobe_trampoline *tramp;
> -	struct vm_area_struct *vma;
> -	bool new = false;
> -	int err = 0;
> +	struct pt_regs *regs = task_pt_regs(current);
> +	struct vm_area_struct *vma, *tramp;
>
> +	if (!user_64bit_mode(regs))
> +		return -EINVAL;
>  	vma = find_vma(mm, vaddr);
>  	if (!vma)
>  		return -EINVAL;

I guess find_vma() can't fail, the caller arch_uprobe_optimize() has called
copy_from_vaddr() under mmap_write_lock()... Nevermind.

Oleg.

