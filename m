Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD68146A60B
	for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 22:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790203376; cv=none; b=QmoHljPclMG4ktJFcD5fcEyHk/ku0SIpmNQvR2kvAMds51UHrZjrjyL/Tav9O2JAh24U2HPtzP4FfOfhhBqeCk3MFF+bqMOWgIKzTco0f3F1FjI8EK6ueW8HoYUWDaR/oMHhW596sisEaUjZO+MHt3zcpiiDtTmBkbCJ3lzHLvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790203376; c=relaxed/simple;
	bh=x//7ZBQO9/2I0nfL2Ah1ibXE5HOcutsX56627Ynz+0Q=;
	h=Content-Type:Date:Message-Id:To:Cc:Subject:From:In-Reply-To:
	 References:MIME-Version; b=s/Ms7mpHfJdvDAHdLOs9l81p6oOaw/CYfaySZ76+xvpDdCihj1vW0xj4JPO46X18H7aLSLarIYIf5G0QZoXrB7kE0kqyr0k6TIYHFncuHQfBq+8r6OIdlEePqcxB3MNdqDiT4sfnDAfPf/ioq83FUT6DOGcuqftTH5p5WhaELSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XWKeFCHH; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XWKeFCHH"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396ccb1a990so1112977a91.3
        for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 15:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790203374; x=1790808174; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:from
         :subject:cc:to:message-id:date:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=35GkgCay4AoRYfYncDwMRqbsdbEhuL4q29/udGj0ugs=;
        b=XWKeFCHHALLoV4liWC1bYAwE7Hh4uFUENkKU9kUqUxe5+MQTwSzDK3jeQafglWXWrk
         9LbcUIny0KLaHMXEdwLjejAIAOTkLz2vYiLRuFHep9A7JqwyROmi79QAJObnekh3KdVO
         UObXD3J0ulljobRVaaojDlPSJiokJvZvB7tPStQfc9bEiJPTWayAPBDSGeLtzgUQkmNN
         y/t+yJEwhJxO1UEFK6cor7tnFVwxkoo00FYiUBzEIA6iYnAxRkSBzEh5T8Ua+YMEZ/Aw
         6Dt0cIvHqd6OiX2/PeMnHONntwArFQBoVK3GdFZxtpRbTuID+Ik+oYGFPL0ziqyICNEG
         cS+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790203374; x=1790808174;
        h=mime-version:content-transfer-encoding:references:in-reply-to:from
         :subject:cc:to:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=35GkgCay4AoRYfYncDwMRqbsdbEhuL4q29/udGj0ugs=;
        b=SrUdvPYgWhC7vWwaAk/bsr1fFY/966udvOJLbDEKgRO8HuiMZTbGqU2CRTn3uO60Yy
         aii9ue/jq25omgHdC7ztsgmUcz6sBMh4gNe30Kw0LkxJ6Atn0e4ty02XSTwNpe02MKs3
         L+JFGlNo7tQ/gFasIjelNR96RWKfNjf+vWo5DAtEbEuAwFkOVJhypjR9pV/AhoTk0mYc
         twqJ6w5sKNkv0ryujZJl1QwvpTFnnwGnMFB2zE+nBseD0Oz7rlBzbJ1jP6iO84qo7LeK
         /GraACIySLEU+A4Bf/5dsHdXoXglEYZI2ec5LPK9ypqDKMNyEKCWLLYEMvSmyCweg98M
         LG/g==
X-Forwarded-Encrypted: i=1; AKwUvBwIjTKwgGNcIhTUc/5ewSRSghKDyuCPqAouZE3tk7yQoRs6rHgbdOjJzr9lvtRnAoCfH0s=@vger.kernel.org
X-Gm-Message-State: AFuF++lwZJT+uDvr/eSDSJzVqK3/egdVydXCMKxIJeei1NfrTeELmrKl
	KOregwvLJxZbZAA/2bu//BUInyOrCE/5OZE1ZC5Vo2RjUWdMQWRpeomD
X-Gm-Gg: AYBFou3yeb2U4DdRpTXoNIZbJ+Zmn3GJRSf74X4wcCnKfWPoCdjmUZxmuUMCZWBNOkK
	TZ8QJMuTEHmwmweuXgh24QY9xl2lz+VZhtfhmXwfpsq6iiQXIiJXpfLzZd6mkQzdC5NLM0oPe2/
	lb8V1Ysd9C8/IaCV+hFhzvQGLRfdLbRujxdehTShgrAY/jCpP0hrO0LMxVNbxUt/tcTBW4VU5qA
	cmyJCjRYMdBKzs2tUqH8mz/iGN4cnU6F3y8t8BLstHTkwclSDf06O6Qv3y9CY3NAm88sMmxw+PH
	8S3t6rUZOJW+8nc/H6giw1qnLQbqXslgsgvT6q7Y3EnUhhnqFQFdeyg9VFfvOs/P3+7wD/oDEC9
	5OxoO9LxbFSG2HKJdNECClW+Kv2YKGVNouCqmmHUVuErFqt+CAwh8GvrHqN+trgrhvC3e/EbTvR
	KpM91qpmUnkyJLCIcKUWRfbSd4mmEgxviINXREH0kwHgSeN5RX0EqCDYvLbSUYl00D8uexujyKm
	DNz5RMpl4s+ztpWU99r1YH+4cqOQcT4qrPAK6gCb1vQXQKVQs/jPepJa1+mLW/6f2F6zfPBQnfu
	v4w=
X-Received: by 2002:a17:90b:57c4:b0:39d:f2a1:3a with SMTP id 98e67ed59e1d1-3a0985b696emr446895a91.15.1790203374151;
        Wed, 23 Sep 2026 15:42:54 -0700 (PDT)
Received: from localhost ([153.61.198.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0974ec5d0sm1148660a91.4.2026.09.23.15.42.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Sep 2026 15:42:53 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Wed, 23 Sep 2026 22:42:53 +0000
Message-Id: <DLN24SAAXQ6F.2PI38BMR6WTRO@gmail.com>
To: "Emil Tsalapatis" <emil@etsalapatis.com>, <bpf@vger.kernel.org>
Cc: <andrii@kernel.org>, <eddyz87@gmail.com>, <memxor@gmail.com>,
 <daniel@iogearbox.net>
Subject: Re: [PATCH bpf-next v3 5/6] bpf: Atomically update PTE and range
 tree in arena VM fault handler
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
In-Reply-To: <20260923191125.5311-6-emil@etsalapatis.com>
References: <20260923191125.5311-1-emil@etsalapatis.com> <20260923191125.5311-6-emil@etsalapatis.com>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, Sep 23, 2026 at 07:11 PM Emil Tsalapatis <emil@etsalapatis.com> wrote:
> There is no way to protect the PTE installation and the range tree
> modification simultaneously, because we cannot nest the synchronization
> primitives for their respective critical sections. PTE allocation
> may require allocations due to PTE reclamation, and its spinlock
> becomes sleepable under PREEMPT_RT. Thus we cannot do this operation
> while holding the range tree spinlock. There is no public API for
> manually taking this spinlock, so we nest the range tree operation
> inside it.

__do_fault() locks the page returned by ->fault() before finish_fault()
installs the pte. That's how filemap_fault() is synchronized with
truncate.
can arena_vm_fault() lock the page, recheck vmalloc_to_page() and
return VM_FAULT_LOCKED, and the free path do
lock_page(); unlock_page(); before zap_pages() ?

[...]
>  out:
> -	page_ref_add(page, 1);
> +	/* Reserve the page while installing its user PTE without the arena lock. */
> +	bpf_map_memcg_enter(&arena->map, &old_memcg, &new_memcg);
> +	unavail_node = range_tree_set_unavail(&arena->rt, vmf->pgoff, 1);
> +	bpf_map_memcg_exit(old_memcg, new_memcg);
>  	raw_res_spin_unlock_irqrestore(&arena->spinlock, flags);
> -	if (new_page)
> +
> +	if (new_page) {
>  		free_pages_nolock(new_page, 0);
> -	vmf->page = page;
> -	return 0;
> +		new_page = NULL;
> +	}
> +
> +	/* If we couldn't mark the page unavailable, retry. */
> +	if (IS_ERR(unavail_node)) {
> +		ret = PTR_ERR(unavail_node);
> +		if (ret == -EAGAIN)
> +			goto retry;
> +		return VM_FAULT_SIGBUS;
> +	}

The race needs user space to access the page while bpf prog is
freeing it.
With this patch every user fault, including the one on a page that
bpf prog already allocated, does kmalloc_nolock() of a range node.
It cannot reclaim, so at memory.max the process gets SIGBUS on
a valid page. That's what commit c7cd8be3d72f fixed.
Two threads touching the same page for the first time: the 2nd one
gets -EAGAIN and spins in VM_FAULT_RETRY until the 1st is done.
