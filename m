Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A3E73F86F3
	for <bpf@vger.kernel.org>; Tue, 15 Sep 2026 21:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789509042; cv=none; b=aTAC6ibjehbQ8PARfJPdNci2/04/YklXT+P5Qswwq3X/z5MHHs/sLVvujIQA2E7vLQNV9w685nslFKg8Kn8oGW0NP3mtmdjnKmMBn93sTtxHCGhlwQ+Av1I+yR36AtQkNUHPYeIBykb9B6WtXY1iIngZeSigggWaQGis3SmDvxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789509042; c=relaxed/simple;
	bh=AsFvnPiEI4hoktzSDE+YxskYQoeQcCquOAQl0eZZ2bU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oGMiHNlFgfbtxFwlRemP7U7FlHP0Q6G6ortss0ZH3j28I5A9MX0rFfx+z7R+wYurL4aQWpviuK9bFAMdANFLz0SOXJAAVNWokEZPssbIMj8bvt5LwcM/Jv5nGBBqSUP17ZYusc/+QVI4q5nN1VL4P3xjPSGWXSX+89dQmkjw7Lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gp6m48Bl; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gp6m48Bl"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2db425c9050so16445ad.0
        for <bpf@vger.kernel.org>; Tue, 15 Sep 2026 14:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789509039; x=1790113839; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=tI17L7xSTrsApSfRoy8c9Azix9/YhE00k0p3SqEz6us=;
        b=gp6m48BlmwRjmbSm6Ml85gR0xlMaoJo5RCJdbsJwK1kJlOZDpsXe7/tJoZ4f8Nxn6h
         hm9ilgTnI7bmSHn2mWCdi5bSyiVzGi5gIjGz2ugS6RlceEhvy5DyL3WniFEyhVpXTuge
         lzZszXP03BZ49jasqeSZrtgs92Ycv4UybsqVwei48c73CgmVJyVgvLIXz5kcEhJfUeK9
         AHbAeEzYMAD3LANH7f/wHTOsLc4eov5C7nAX+b0AK1N1axfvagO7ql4oAbUJrxEgUpjI
         LwX4xBuMZLk2bWYDPFOqodryjhHQzRMA5Oj2rlolqHLeg8JlO/NmZGPLke6J3FOqrMiK
         eqYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789509039; x=1790113839;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=tI17L7xSTrsApSfRoy8c9Azix9/YhE00k0p3SqEz6us=;
        b=zPdJrYoggjyUqH4ExbMra9wx3U0lhy6JvY3kp25GMH2V8AyRfhIMc2ww99/Q0eeNbC
         nGz0lB/S8rt9vlIzo2e34D8a1PCeBupbpOSdrCl48p5IutlHR2OFCBZ5fuWcwKOPrCxz
         WqTIJa0/BymQy8LBPwzEZ48SCbhWfR5mxoXBf2Z12q63NJwES3VtmXzRq4hop0fix96d
         eVXyY5AS/uE7deqhElpQ5uAgiDZMVVnurd0MrmBqHZMJtJ217yssRpyV5PjkNkWkIxHm
         uE6j478fk2Hj9Ap7vrXe7bByFXkyL6jT3S3ZWdULSTPm1qo2gAEIN9JnH6fVDdM0GERA
         4Avw==
X-Forwarded-Encrypted: i=1; AKwUvByWZX8AcwoPg+w0CGLPFpEtmYOTS7U1aQ5CVOPDnKtl8I2kxZrChlszX6eCHfwi1dJkF2s=@vger.kernel.org
X-Gm-Message-State: AFuF++nMr+IV3OoSexk+shrW8pVhFTwv/QvQzVvlZCM2qEVeGqjmsXR7
	rVBpQRBQ8O+F4yNC8yboWjhCMWlGZcx/kL6xKWaxGo0MYlcsbnmg1dXxOBVoh1R/lw==
X-Gm-Gg: AYBFou0p9pG0RvuUuBmpEUSsQnwrMH7A8s3TN0DXWdU5hHqbBRVtli0qYYqznhM0mn5
	S5V/H4D/yts30DmuuyfFBRQ8a3zQ0SwPrF3YgJd9ZqqzqXDZQlep8cSp6hu5xXpjWCiiSVuRfXo
	bva/2QoMy5mCrMdkVkIbksyGipVzM50pe70KbnEw6hSKkNCFtZkUhN77LeWVL/0hPlB6aggmRO9
	raC+h4PUtgySxsfLRcCaFRn6zrBuYzROVM8FWlKAvNhsIQRs7RGr9A8eo8YaVViAxC7na5YIf1y
	WuS2QXfsgtLXn1LXYEOdp7geDX58zcbeueDDIrQnrUq43UNlkI95NXzMNq7H6OG2rTXjb1g8gcr
	lDkcyBgq3i+MYh6zGD6iG4nrrtu9opePZSocBfjlKuH3ycn/BUmx8nIJtiUj+itjBsbAEpX/msK
	u5ko1O65HlpTJTkmRd8WUTozR5L3SODchiPRii9UHBKRsZpIN48sykVcvWZesx1IIcvdgRfbh6M
	H6OaYjmMtA9PKJqoyyMS+tsVash/1w5r8GhI0s3cnDVv5I+wEE=
X-Received: by 2002:a17:902:f693:b0:2d0:1aaf:daec with SMTP id d9443c01a7336-2dd8be54ab9mr842285ad.9.1789509038186;
        Tue, 15 Sep 2026 14:50:38 -0700 (PDT)
Received: from google.com ([2a00:79e0:2e51:8:8352:5e93:3fd9:766d])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33bf5af4f0bsm2082822eec.24.2026.09.15.14.50.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 14:50:37 -0700 (PDT)
Date: Tue, 15 Sep 2026 14:50:31 -0700
From: Isaac Manjarres <isaacmanjarres@google.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: =?utf-8?B?6auY57+U?= <gaoxiang17@xiaomi.com>,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	Xiang Gao <gxxa03070307@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	=?utf-8?B?5Y2w6Zev?= <yinchuang1@xiaomi.com>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Lorenzo Stoakes (Arm)" <ljs@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [External Mail]Re: [RFC] bpf: account ring buffer backing pages
 separately from Lost RAM
Message-ID: <aqm9p1uW7ls65_S-@google.com>
References: <20260815091819.3651099-1-gaoxiang17@xiaomi.com>
 <04f3ce2f-67f5-4829-9551-a69b9df29854@kernel.org>
 <CAEf4BzbwZkoacX-iP1j4+p8YNbWsq0pc3eTermh2uT5ir66zbw@mail.gmail.com>
 <8d2e20842c24460296e4c83e6dc0dde3@xiaomi.com>
 <CAEf4BzYQvhSVN=Hggg5FHzFdkRr4UNBD6yXaBsOaAwbsRpXpsw@mail.gmail.com>
 <aqSNkbhIuaB5D0H0@google.com>
 <CAEf4BzbAOgwQqsRQnY4yxvubLtioQNL_BBHer4ExvNF7Rvvu4w@mail.gmail.com>
 <aqhZEuQTu394hYB6@google.com>
 <aqh17GTlWiDVJ-N1@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aqh17GTlWiDVJ-N1@google.com>

On Mon, Sep 14, 2026 at 03:32:12PM -0700, Isaac Manjarres wrote:
> On Mon, Sep 14, 2026 at 01:29:06PM -0700, Isaac Manjarres wrote:
> > On Fri, Sep 11, 2026 at 05:04:55PM -0700, Andrii Nakryiko wrote:
> > > On Fri, Sep 11, 2026 at 4:24 PM Isaac Manjarres
> > > <isaacmanjarres@google.com> wrote:
> > > >
> > > > On Wed, Aug 19, 2026 at 10:24:28AM -0700, Andrii Nakryiko wrote:
> > > > > On Tue, Aug 18, 2026 at 6:46 AM 高翔 <gaoxiang17@xiaomi.com> wrote:
> > > > > >
> > > > > > Thanks for the pointer. Understood — no new NR_* counter or
> > > > > > /proc/meminfo entry.
> > > > > >
> > > > > >
> > > > > > The remaining question is on the consumer side: Android's Lost RAM
> > > > > > accounting would need to enumerate all live BPF ringbuf maps
> > > > > > (BPF_MAP_GET_NEXT_ID) and read each map's fdinfo memlock to sum them.
> > > > > >
> > > > >
> > > > > For BPF ringbufs specifically, you should be fine just iterating all
> > > > > map with BPF_MAP_GET_NEXT_ID, getting its FD with
> > > > > BPF_BTF_GET_FD_BY_ID, and then passing that fd to
> > > > > BPF_OBJ_GET_INFO_BY_FD to get map's size.
> > > > >
> > > > Hi Andrii,
> > > >
> > > > Thanks for the suggestion on this! I did want to express a couple of
> > > > concerns with this:
> > > >
> > > > Scalability
> > > >
> > > > I counted the number of maps on one of our devices, and there are 112
> > > > maps, meaning that there will be between 224-336 syscalls with this
> > > > approach. eBPF is becoming more popular, so I'm concerned about how well
> > > > this will scale, if we have to invoke 2-3 syscalls per map.
> > > >
> > > > I had a test program that implemented your suggestion, and it took about
> > > > 2 ms to identify 39/112 ringbufs. As the number of maps in the system
> > > > grows, I'm concerned that the latency associated with computing the
> > > > memory usage from ringbufs will become even more expensive. This is
> > > > something we had an issue with before on Android, where we had to
> > > > iterate through various sysfs files to gather wakeupsource metrics [1].
> > > >
> > > > To improve on this, I was wondering if we could expose the ringbuf
> > > > memory usage and potentially other bpf stats through bpffs
> > > > (/sys/fs/bpf/stats)? This counter could be a lightweight counter that is
> > > > incremented/decremented on ringbuf allocation/freeing so that when it is
> > > > read, there aren't any expensive computations.
> > > >
> > > > For this specific metric, we could just use a counter to track how much
> > > > memory is being used by ringbufs and have userspace read that. That also
> > > > brings me to my next point.
> > > >
> > > 
> > > I just don't see a good enough reason to single out ringbuf maps
> > > specifically. other map types also use memory, why would they be
> > > excluded?
> > 
> > I was looking at ringbuf maps specifically because they allocate memory
> > for the ringbuf via alloc_pages() and aren't attributed to any counter
> > that is exposed to userspace. The other maps use either the slab
> > allocator or vmalloc() to allocate memory, and those entries are visible
> > via /proc/meminfo.
> > 
> > > If you are worried about too many syscalls, look into map iterator
> > > program types (grep for SEC("iter/bpf_map") in selftests). That will
> > > be super fast and way more generic than what you propose. You can ping
> > > such program in bpffs and that will be you custom /sys/fs/bpf/stats
> > > implementation that you have full control and customizability of
> > > 
> > 
> > Thanks for the suggestion; I'll look into this and let you know if I
> > have any questions!
> > 
> I looked into this, and this works in reducing the overhead from number
> of syscalls, but the other part about correctness isn't handled by this.
> 
> For ringbuf maps we would have access to max_entries, but that just gives
> us the amount of memory consumed by the data portion of the ringbuf, but
> it doesn't include the 3 metadata (kernel structures, consumer idx page,
> and producer idx page). I don't see how to derive this value--rather
> than hardcoding it.
> 
> I did see that fdinfo for the maps does give the total memory usage
> via bpf_map_memory_usage(). However, that value includes structures that
> are allocated through the slab allocator and vmalloc, so using that
> value would double count the memory usage in the system. Userspace
> doesn't have the information required to break that value up to extract
> just the part that is allocated through alloc_pages() directly.
> 
> I think it's worthwhile accounting this data correctly, as on our setup
> there are 39 ringbufs. This can lead to 468 kB -- 1872 kB of unaccounted
> memory depending on the page size.
> 
> --Isaac
>
Please disregard my previous email. A colleague pointed out that I can
use bpf_core_type_size() to compute the size of the metadata that I was
referring to and that worked.

Thanks for all the help!
--Isaac
