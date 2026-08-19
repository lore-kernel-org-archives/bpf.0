Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0290B4078CE
	for <bpf@vger.kernel.org>; Wed, 19 Aug 2026 19:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787166695; cv=none; b=NUR10SMS/mRSNe/iUXpH5cRr/VK6aA/gtwiV4gJpWMz0foKiNmXaxf+nt6+l5zwjs7lbSDOtqXu1F+XSDrI2LH5MoGZQw9dsyrBk8ULKHD79hheKw6HtLGUKCjisPMJZ72e+bMt3pOFVrPhlir8/LrUKutcma2soXhKf7his3PA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787166695; c=relaxed/simple;
	bh=LZH4Ig8rdsa+22GNL8Pma7P6dkGY16eM0dMSUGfgm4E=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=L/+zp6pZPwoMiaiizqK8exZj9iBocBU8iPQqWn0gz2o9LeoZarZOvTTUASIs3mYZ7zdrj1gCVKMJVIsWtpPc6SkRolIGmGWKdmfbewm//qRDl1r7wKj/ZokuNnp4zi683SSbPEP3aFl+wYY2X4i5Mv0b2nYvep6E7lifGG1r5D4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=U40JsDZU; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="U40JsDZU"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2d560775ca2so11103815ad.1
        for <bpf@vger.kernel.org>; Wed, 19 Aug 2026 12:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1787166693; x=1787771493; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=iuJxNDnPI30koRC+wulDPOVDN1bFgNOxk8BAwV2kNWY=;
        b=U40JsDZU6aEphzkDQJwnSW3GTgGFVj3cBv7vgTaGgS+hbDxOtvP4xKSc9YuspgVZJd
         W3M80kQ1uWKCLxPiQ4+fLhN98mWNCts5BKiEdIpDxedzUSgONezR2UKSldZNg6IuL9uN
         9xoriOldbRGchR7yPvT48MVxa3Wm9so+F5idduv4t6jNL+owZwTOZIWsljaeEAGAGV5Q
         f25zwOv42rI3VKzLFg+LBOqoPdimE3/BGf9FcRVjlBhWEAd6lzv/cWLonuaw2yXXxbuN
         LOCm/lPussorKKWLPaQX3z061y7UfKmY4dil1F/jq7m2NRKL49Jjs9QpN1fx6vzu3Yr0
         6Sug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787166693; x=1787771493;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iuJxNDnPI30koRC+wulDPOVDN1bFgNOxk8BAwV2kNWY=;
        b=VQ0vbKktnDE3ab5spcFUiLKJ11Ctqthjw4tKER/ijGU9whuOzkcPVPZEger1rQzEVO
         710uKMgg8V4hGaZ0Kgb1kwz3oRElMODBEWq7x/RAEr79jVb2zWVGo8vNVr1zLZrzoLlT
         ieiZXOgDKGnysmTgHvxvmnRVU5LvI54VJSQUSp+4SOczxlAotOkEFryXcB8W+FHDMXgD
         31FBiK+V48qmkx+/zzlyZIA2QE6QcLr3oMicmQmQ+fVQBvb6hCzq1A2bL7S6lvyf0j21
         sOfKMVcmxMlknY6KcuWYZkWqTSlPygqxUxAj0BThdieAccH0bAGfz40IzLxB5Hr30Ndm
         NPbQ==
X-Gm-Message-State: AFuF++kcLC3rriVoao+UNbG1Rj4iMmEc/kv+B/QcIWwXakzl8HgLwQN7
	TjsuBhJvzDXn9T7mIxWhQ9xMH0Gq6R0+kCgm3Lkt4iTgaO23v/GmfHaAbNiBTUHCyb8=
X-Gm-Gg: AR+sD12aPXXSonCMFceqRrAbfrOMZWdXZbqR/zGeMA1EB6L87AMTuYpVktVwMEtlXgl
	jUsOe/0vUDSFwToNTs1q3FXa7+uI7vFztQKnT4UvDRAlx0SdGNKu0lgdLKhK7CnlZvU9IwoLHIV
	EqkY1KYCGYQkANXVjUwjnOFpjEsTWgxXrKVCBB0wOJzS1TidVCt4SE+34go5iZ9MxAUczP82VaG
	rJrAU92thZvTfiaSRDZ265rV+5yYMlt7OVUt7F2EL2PxP0n5QBziYeo5EIw2CvOAYvHP/TdxoUd
	+xF9LWHGMbqj5CmhVWF0l/YQv/ImwOFobZy9rwoulp1ADOJvBSHFPrAeF3TlfUIMmz27J+dcATy
	SfSVXS0EPzxqOsVVTxg8URwTDhRcyq7t/YxIRAjTBelmNwb7vxbQpE3F81xqkesELl1g/HXcG8M
	BUmunLg3H1FmWkg0s4dvqQqEsGfxTth+kUHs3ViQTEzBc/4Byg2VJhZDYYWbS1ptF9L7HnPwWt2
	/NgXlNDwZ88zZYqPffz4nAKsC2GJ/qce97Q33yg
X-Received: by 2002:a17:902:d2d0:b0:2c7:ebfb:618f with SMTP id d9443c01a7336-2d601985763mr103968165ad.14.1787166693067;
        Wed, 19 Aug 2026 12:11:33 -0700 (PDT)
Received: from localhost (107-190-31-17.cpe.teksavvy.com. [107.190.31.17])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d5c1e543besm28951195ad.41.2026.08.19.12.11.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Aug 2026 12:11:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 19 Aug 2026 15:11:31 -0400
Message-Id: <DKT5PVZDPTZX.38GSKZBE4TPYR@etsalapatis.com>
Cc: <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next v3 3/3] bpf, arena: check range_tree_set return
 in arena_free_pages and arena_free_worker
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: <sashiko-reviews@lists.linux.dev>, <chenyuan_fl@163.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260810134800.2875487-1-chenyuan_fl@163.com>
 <20260810134800.2875487-4-chenyuan_fl@163.com>
 <20260810140850.4214E1F000E9@smtp.kernel.org>
In-Reply-To: <20260810140850.4214E1F000E9@smtp.kernel.org>

On Mon Aug 10, 2026 at 10:08 AM EDT, sashiko-bot wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [High] Physical memory leak in the BPF arena allocation rollback and de=
ferred free paths when `range_tree_set()` fails.
> --
>
> --- Patch [3]: [PATCH bpf-next v3 3/3] bpf, arena: check range_tree_set r=
eturn in arena_free_pages and arena_free_worker ---
> commit 2ed41c8c8f7aaa211a3d44f83cea88768b2f5819
> Author: Yuan Chen <chenyuan@kylinos.cn>
>
> bpf, arena: check range_tree_set return in arena_free_pages and arena_fre=
e_worker
>
> This commit adds error checking for range_tree_set() in the BPF arena
> allocation rollback and free paths. If the tree update fails, it aborts
> the page free operation or skips clearing PTEs to prevent untracked pages=
.
>
>> diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
>> index 7b6847200b431..1e519c3c229ca 100644
>> --- a/kernel/bpf/arena.c
>> +++ b/kernel/bpf/arena.c
>
> [ ... ]
>
>> @@ -881,7 +883,12 @@ static void arena_free_pages(struct bpf_arena *aren=
a, long uaddr, long page_cnt,
>>  	if (ret)
>>  		goto defer;
>> =20
>> -	range_tree_set(&arena->rt, pgoff, page_cnt);
>> +	ret =3D range_tree_set(&arena->rt, pgoff, page_cnt);
>> +	if (ret) {
>> +		raw_res_spin_unlock_irqrestore(&arena->spinlock, flags);
>> +		bpf_map_memcg_exit(old_memcg, new_memcg);
>> +		return;
>> +	}
>
> [Severity: High]
> Does this early return cause a physical memory leak bounded by the lifeti=
me
> of the BPF map?
>
> If arena_alloc_pages() fails midway due to memory limits, it attempts to
> roll back the partially allocated physical pages by calling
> arena_free_pages(). Under memory pressure, the range_tree_set() call is
> highly likely to fail due to its internal kmalloc_nolock() allocation.
>
> Aborting here leaves the physical pages mapped in the kernel VMA and
> completely orphaned. Exchanging a virtual address space leak for a physic=
al
> memory leak on an error path under OOM conditions worsens memory pressure=
.
>
> The pre-patch behavior of freeing pages and clearing PTEs appeared safe,
> since bpf_arena_fault_handler() handles unmapped PTEs by mapping the
> scratch_page.
>

Imo this is debatable. If we are at the point where we can't allocate
entries in the range tree, we are close to an OOM anyway and so it is
better to keep the range tree and actual mappings consistent.

>>  	init_llist_head(&free_pages);
>>  	cdata.arena =3D arena;
>
> [ ... ]
>
>> @@ -1004,11 +1011,18 @@ static void arena_free_worker(struct work_struct=
 *work)
>>  		kaddr =3D arena_vm_start + s->uaddr;
>>  		pgoff =3D compute_pgoff(arena, s->uaddr);
>> =20
>> +		/*
>> +		 * Mark the range as free before clearing PTEs so that
>> +		 * if the range tree update fails we leave the PTEs
>> +		 * intact, avoiding an unrecoverable state where pages
>> +		 * are freed but the arena free tree does not track them.
>> +		 */
>> +		if (range_tree_set(&arena->rt, pgoff, page_cnt))
>> +			continue;
>> +
>
> [Severity: High]
> Can this continue statement permanently leak the physical pages from the
> free system?
>
> When this skips PTE clearing and page collection, the subsequent loop in
> arena_free_worker():
>
> arena_free_worker() {
>     ...
>     llist_for_each_safe(pos, t, list) {
>         s =3D llist_entry(pos, struct arena_free_span, node);
>         ...
>         kfree_nolock(s);
>     }
>     ...
> }
>
> unconditionally destroys the tracking span 's'. This abandons the pages,
> leaving them orphaned rather than avoiding an unrecoverable state.


This, however, seems valid. You can make it so that we do not free
ranges for which we haven't called apply_range_clear_cb.

pw-bot: cr

>
>>  		/* clear ptes and collect pages in free_pages llist */
>>  		apply_to_existing_page_range(&init_mm, kaddr, page_cnt << PAGE_SHIFT,
>>  					     apply_range_clear_cb, &cdata);
>> -
>> -		range_tree_set(&arena->rt, pgoff, page_cnt);
>>  	}
>>  	raw_res_spin_unlock_irqrestore(&arena->spinlock, flags);

