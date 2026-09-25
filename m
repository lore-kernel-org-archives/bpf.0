Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D6D41F942
	for <bpf@vger.kernel.org>; Fri, 25 Sep 2026 01:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790298308; cv=none; b=ukez91oeH/gw+MxtvxAHjsKrYCdZ9l7VxUHrBJgDvKXDCUmHLvdofCFvzye0mBDGGMaQPiiKiwOPNzp1JE12S6N5kZUTAT/3P8NWqX73gwHnSwBiyJClQyqCvBjdsWeTQmW5EtsV180tD0yLUwbbqErOA/J9DkxuzRDWLQ05kMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790298308; c=relaxed/simple;
	bh=We2DU+JRdGBYw3gCBPh2ch5eFDiIeIOmfq4SoFBDRbk=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=slDbXpSVmeFQXcw43JP1kPvqPoJrELanJULBV5ImZASG7gp8+QTjrMMQ1H4BD05vVyYdn2ZwRKV9aVBVt8W324QGoE0ICNeF4nLVpifHcWu1PQkKCpI0FWibDXQpLc27BexHg+yhPkDDadr7B4fRROQhta3LBeVme7cj75FESxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bvRnjO4d; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bvRnjO4d"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-396ccb1a98dso275377a91.0
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 18:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790298306; x=1790903106; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=HZmQErPA599NRUKe+vDXqecxiYG+2mzYZkrIrbPOKE8=;
        b=bvRnjO4dKcilljN6KkuelaQycXSnZwsGKPrF0KY8MaHGAj56E80Lthbi7bjQ+Lqiav
         PUoqBpRGXVvyVA0QXx3bMgOx2WnTih/vSzZNPdYrUvWHo3ZFd59GQ8t+HO4g3pvj3h2c
         lmWmUb6OEggiAhXks7Nf/vNjnVzE3ptViMF/7/XGTGdszogr19YXYPR1EmAzkeqf8aKO
         tlLbg74audYxbxG/ruybOM5yfmp9ZfDSBjhME2Rx2HmUbKmuDeUEt8FFX+Q7Ra6EQcgu
         Rw/PFu7Cm3hLappAt9nmHxiECBGX4+iJQ2qvnpr9oKVCiGCjC3hRrMyKTco8P+YaE7gB
         QVHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790298306; x=1790903106;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HZmQErPA599NRUKe+vDXqecxiYG+2mzYZkrIrbPOKE8=;
        b=Ar3KfV+IXoNnw0wQ+WMKOJrnHw7NPN/b0eGWdFt0NCeO381gHI55RlSQH2rJIB42zg
         m6GDSAfzje17R//3/ac/LLFya1M5DbZnaLWdmkYPtDSWHeH695K+YlucpdHGTyowzFOi
         L9OkkP5ywCQC2yIgTiAwlnCTQLZq6/Q4RVRVB8xkgX0n4BS25nrwZxB1iVi9XITKcWhC
         +z0nom6f1XhMHEIJ+kguoESAYPDSAha3Qj95nYkktk7qhXgG1hR/JLjZDAbGeUcHewU/
         YagDeBGzMSLHpIV6IIyH2vvWoG9+SqCvfjwIh3mM3RFxh4WJPNpEGqqbj8J79UYBGOT3
         islg==
X-Forwarded-Encrypted: i=1; AKwUvBwo6MVz3YqihxbgsQzEUMDWfmdbe9GPWf3UOEtSqHiMqlC0nb0Bilq0A9uA8SNSpo4LTX8=@vger.kernel.org
X-Gm-Message-State: AFuF++ka/FzShlNYzYJ+xoq58jeNYqnC3+7BMcuvkICwW8HF1UKojvMv
	ch3bbUKGcFa9rOxpTe+Cu85V7kPI03Kw47TPPXdl09HnvW5G50JMR1zj
X-Gm-Gg: AYBFou0Q1nZyrmN0OqYViyYo6U9tJmDR0fsTpcdl+i/x8ucFwZtL6s2CSA8VTlht5Is
	84M8RpZiTfU+0IHrdqS8nBHtuXinkuNCyEjvSMdCGScdlKLMFXlhlamIY5yd0v/AOqZQAgwLGEg
	RhQkEs1MAXYokJzv4QtO8IVFQ6ZyHS0AEQZURfp7Y+Gsl9SOJMZnR0DJuNdzn9nQFmoyKbKGWVy
	pY+FbxzHrVNeifTiUmxrpeDo4qNW3FbBrnUw6OB5zSKS1gyBbvaMMvU68Zn3eKcx2uTLSrbctLQ
	gLl1SAGjbjVX4tyc2ZLkRxOhNAB+YFa7NRXykGfCkSH5tas2P8gJ7NLS/3vbcwTWpI38wtycHJF
	PpQH63MKTANnqBAnrbS0cfQ3i9H2+mM2YaHQAl7scK4Il5XFZqN3Os5Sn8GIzjznecZOLvzRH+f
	MELYYYe1ezFfd04wEl6QB5pHDBPP2TxUn9DIStDw++DpHd4aNzPPHyCyxR6IS8GcSYd1lhTVtR+
	vPt82R4Vd6NWwMhPBN2k0ZmfwIYfdeijK3z/ACTCRbxoQDjSGcPXRbkTeULF/XxnKWADyq6TuLL
	Njkhr+n3HVXPezg=
X-Received: by 2002:a17:90b:1643:b0:3a0:345a:3646 with SMTP id 98e67ed59e1d1-3a0bb62f2d3mr575272a91.45.1790298306331;
        Thu, 24 Sep 2026 18:05:06 -0700 (PDT)
Received: from localhost ([153.61.198.248])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc787966286sm430165a12.31.2026.09.24.18.05.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Sep 2026 18:05:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 25 Sep 2026 01:05:05 +0000
Message-Id: <DLNZS7DWLRGE.TPVKX87N0IL9@gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: Support bpf_rcu_head in hash and LRU
 hash maps
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Puranjay Mohan" <puranjay@kernel.org>, <bpf@vger.kernel.org>
Cc: "Alexei Starovoitov" <ast@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Andrii Nakryiko" <andrii@kernel.org>, "Martin
 KaFai Lau" <martin.lau@linux.dev>, "Eduard Zingerman" <eddyz87@gmail.com>,
 "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, "Song Liu" <song@kernel.org>,
 "Yonghong Song" <yonghong.song@linux.dev>, <tj@kernel.org>
X-Mailer: aerc 0.20.1-349-gb940a4174a3e-dirty
References: <20260924162858.2435106-1-puranjay@kernel.org>
 <20260924162858.2435106-2-puranjay@kernel.org>
In-Reply-To: <20260924162858.2435106-2-puranjay@kernel.org>

On Thu Sep 24, 2026 at 4:28 PM UTC, Puranjay Mohan wrote:
> bpf_call_rcu() is restricted to arrays because an array element is never
> freed while the map is alive. Hash elements are recycled, and an RCU
> callback cannot be cancelled, so a delete racing a queued callback would
> hand the element back to the allocator underneath it.
>
> Keep the element alive until the callback has run. Before releasing an
> element the map calls bpf_rcu_head_claim(), which marks the head dead and
> reports whether a callback is queued or running. If one is, the element i=
s
> unlinked but not returned to the allocator; the callback does that throug=
h
> a new map_release_elem(), since only the map knows whether that is a
> freelist push or bpf_mem_cache_free(). The dead bit stops it being armed
> again, so there is a definite last callback. Timers and friends in the
> same value are still cancelled on delete.
>
> The head and the element are busy for different spans: RCU dequeues a hea=
d
> before invoking it, so it can be re-armed from inside the callback, while
> the element has to live until the callback returns. ARMED covers the head=
,
> RUNNING the element, and whoever clears the last of the two releases a de=
ad
> element. RUNNING is dropped under the read locks, so only one callback ru=
ns
> on a head at a time.
>
> The dead bit lives in the element, so alloc_htab_elem() and
> prealloc_lru_pop() reset the head when they hand one out.
>
> A preallocated htab stashes the old element in a per-CPU spare on update
> rather than freeing it, which cannot be done to one with a queued callbac=
k,
> so maps carrying a head take the freelist path instead.
>
> For LRU the eviction path asks bpf_rcu_head_busy() and declines, leaving
> the element in the map.
>
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
> ---
>  include/linux/bpf.h  |   5 ++
>  kernel/bpf/hashtab.c | 104 +++++++++++++++++++++++++++++++++-----
>  kernel/bpf/helpers.c | 117 ++++++++++++++++++++++++++++++++++++++-----
>  kernel/bpf/syscall.c |  14 +++++-
>  4 files changed, 214 insertions(+), 26 deletions(-)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 1e1ce2afe2ed8..91eee1d066a32 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -111,6 +111,8 @@ struct bpf_map_ops {
>  	void *(*map_lookup_elem)(struct bpf_map *map, void *key);
>  	long (*map_update_elem)(struct bpf_map *map, void *key, void *value, u6=
4 flags);
>  	long (*map_delete_elem)(struct bpf_map *map, void *key);
> +	/* Release an element a bpf_rcu_head callback was holding. */
> +	void (*map_release_elem)(struct bpf_map *map, void *value);

This is quite heavy. As you can see both bots poked plenty of holes.
I feel this will be nightmarish to support moving forward.

I'd like to hear from Tejun whether he thinks that call_rcu_only_in_array_m=
ap
is a limitation for what he wanted to do or not.

Instead of supporting in hash map we can support them in bpf_mem_alloced
objects instead. Same flexibility. A lot less pain.

pw-bot: cr
