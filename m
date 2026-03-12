Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7073936B061
	for <bpf@vger.kernel.org>; Thu, 12 Mar 2026 18:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773338527; cv=none; b=ttAetmOUt2CLk9qCMjblMIOw9sMzcYZO1tArsojeAefeeo6GVW1FALzXxjjV/RrulqgrfOZSluVy/huLQNLNI4xZW1wmdfejgNi9DxXtoON0OMkfiA1r7s1ZryiodVCcUTMS9Alg3gzrEoSZOb7x7SuNxiSN3B7s2vT77oEaiqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773338527; c=relaxed/simple;
	bh=xlB+u1r2QX0LI5Rj8fDdMtpNUBGNzQ4jyUCs2t92IiA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iMj82tqZl+wvGbhdVDyjeLRp+l9kEhjRA5x9t4xH37jevAMg0WxDHVqJMKUlRnVkZXwuMZxO0CrGgDI2DTcJxOLK+FuFqvy6OfWZRrS2a47hY98OK1iITfpNUxqOzWe5jExBUTFHg82bGiSQHrpdvcNAcRkZKF7BtM2IBcHyWAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M4+SXywf; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M4+SXywf"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4853510b4f3so17074795e9.0
        for <bpf@vger.kernel.org>; Thu, 12 Mar 2026 11:02:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773338524; x=1773943324; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JBA5MyXByYLA3zXXjx3wMlp0Yon7kVfdTygyQg8Lb4A=;
        b=M4+SXywf+vlZ+0aZtr3Al0rGtNmhFFpmk+cjClwXF1ntrUYltANA2XJP7OeQUqCvIx
         oqafJiyQttJE7/4TCcjQAyZysTbyp1EO7woZaDZzTFCzfowgVi6+dvkZQwklwrLDBazH
         1nDwii6eJQTvlUEX+0qzbW0DQFi5aqZDm9699kpJRXybO3e0bUu8asuChnTlFScTYNwI
         YE3beDYUXRA3dhl/YmsnyA0fdvPgoUUerzKd5sDEu2BSW98av6ffJ6/oV74/NF5FG4LE
         j70KlQ9ibCBBMOTYADdnpczfXLY36zvOROyF0z6KaZuzfwyHaomDdIjcZxHSm0FFUMk0
         i+kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773338524; x=1773943324;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JBA5MyXByYLA3zXXjx3wMlp0Yon7kVfdTygyQg8Lb4A=;
        b=EJqBiMWClYdku/CCo3yqPtJubuOig6VXc+DsXZLUEcDanOYTk0JQqtI6g6yLOklVRl
         fd0PsXnuWbDt6Xe4J9vfLrmtT9uTd0/stKYE2XeZtm/6Tkbii6dZscC/OMpzeI10PoW+
         8DJT9SXr16oddsGqEYOvvCgkxpSr8unhAbmx6ZNOYTiW8nuvatIduk5cjXNrr0i7dBD/
         0lgVAKDFJKmAOH3g/kDDR2AmLgInUlP1lwt/ZKWLRF3aobezUiKYiHIiRapNJ7YqUtZF
         PSC22noasGYLadhx7/TS1WmFHGdbiem0AWBqwsBZZqvMmuBYnEnQxSTVjdsk3fBZDckH
         Pzxw==
X-Forwarded-Encrypted: i=1; AJvYcCXNspFTs4L0Nj7k1iWeKQCYwOgJEfvo39gFknnpnVTzPFUyj0hlGxMWPP+TCL5yL0ad4W8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpgI7PdW6qvZfQbV6AKoe9NvsKx72d42wB1tMWmsx8BPYYEcuq
	tIUhaK3X3RfGo0ZoT3Shv8kV47c915PSYsC/McFi4klPAj4MxQy2/ucu
X-Gm-Gg: ATEYQzzfbHgT0xo+zWVFrnsYaq3HHGCN5los72bDXgYj0/thPp7bisBOJYIk26/TqoS
	DT8W8SdKX9vrJ5tQ7n/dZyR69RKwmtLz4dEL+0yUPXsYs+mt7B611aVAgElbu4Ms4lZge/7hUG4
	WkpMaOQpf+OJMs1ZyzqFBgzqbUt2letoFNQI1QULy3UBUQPvB3TjXzq+tiZGLXVjCnHbX+TviSo
	gru5xKufsApjLU8sh8tGC82NJjqTpdO6mnNdknCDtHbucSfpTBsb+5U2vFJ+PhkXlbqeVa1+X56
	Qb4pGUTjhBUYB3byLbAZehVZD3ccMViu6sqaIpiluc4hxdTSK6lPnl6p2FFwNANlk2DsnlP2PBq
	5fNbjdwniXDZa0mEIlTbdvRU7iGmg5NlpjyqJF0z9G2vzzd8+yk6+P1dr4YPn8OwljgNgSF8Y+e
	qHWL6ScikSH19SxsVNspKF0M6pcIa68Xh8PEoYWsUaBSKcXWN8M2CF2SR8pQdYN2oolEHoK6Lvk
	lV3NKS1wiwY8ZeiEhn/i8aTjjSgAxLRQz5Ty8YkhAsyn8ZsR9DPEgPwCi/XzKN1wzTkDg+qrSxY
	nMe5SwunuOY=
X-Received: by 2002:a05:600c:548a:b0:485:4100:1eee with SMTP id 5b1f17b1804b1-4855670e7f9mr4553495e9.24.1773338523328;
        Thu, 12 Mar 2026 11:02:03 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e00e621310b96d0fd4d.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:e621:310b:96d0:fd4d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48541acea11sm277041675e9.7.2026.03.12.11.02.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 11:02:02 -0700 (PDT)
Date: Thu, 12 Mar 2026 19:02:00 +0100
From: Paul Chaignon <paul.chaignon@gmail.com>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: xulang <xulang@uniontech.com>, bpf@vger.kernel.org,
	martin.lau@linux.dev, ast@kernel.org, daniel@iogearbox.net,
	andrii@kernel.org, eddyz87@gmail.com, song@kernel.org,
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
	haoluo@google.com, jolsa@kernel.org, kaiyanm@hust.edu.cn,
	huyinhao@hust.edu.cn, dzm91@hust.edu.cn, kernel@uniontech.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf v1] bpf: Fix OOB in bpf_obj_memcpy for cgroup storage
Message-ID: <abL_mMQcDyh8pLDL@mail.gmail.com>
References: <204030CBF30066BE+20260312052525.1254217-1-xulang@uniontech.com>
 <abKo0HZ3R_oY1BUa@mail.gmail.com>
 <a9e91c79-70f6-4f7e-a98a-12f2ef834c3a@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a9e91c79-70f6-4f7e-a98a-12f2ef834c3a@linux.dev>

On Thu, Mar 12, 2026 at 09:41:40AM -0700, Yonghong Song wrote:
> 
> 
> On 3/12/26 4:51 AM, Paul Chaignon wrote:
> > On Thu, Mar 12, 2026 at 01:25:25PM +0800, xulang wrote:
> > > From: Lang Xu <xulang@uniontech.com>
> > > 
> > > An out-of-bounds read occurs when copying element from a
> > > BPF_MAP_TYPE_CGROUP_STORAGE map to another map type with the same
> > > value_size that is not 8-byte aligned.
> > > 
> > > The issue happens when:
> > > 1. A CGROUP_STORAGE map is created with value_size not aligned to
> > >     8 bytes (e.g., 4 bytes)
> > > 2. A HASH map is created with the same value_size (e.g., 4 bytes)
> > > 3. Update element in 2 with data in 1
> > > 
> > > In the kernel, map elements are typically aligned to 8 bytes. However,
> > > bpf_cgroup_storage_calculate_size() allocates storage based on the exact
> > > value_size without alignment. When copy_map_value_long() is called, it
> > > assumes all map values are 8-byte aligned and rounds up the copy size,
> > > leading to a 4-byte out-of-bounds read from the cgroup storage buffer.
> > > 
> > > This patch fixes the issue by ensuring cgroup storage allocates 8-byte
> > > aligned buffers, matching the assumptions in copy_map_value_long().
> > I don't think this bug is specific to the CGROUP_STORAGE maps. Wouldn't
> > it affect any copy from a non-percpu map into a percpu hashmap? The
> > reproducer in [1] copies from a BPF_MAP_TYPE_CGROUP_STORAGE map to a
> > BPF_MAP_TYPE_LRU_PERCPU_HASH map, but I suspect you'd hit the same bug
> > if copying from BPF_MAP_TYPE_HASH into BPF_MAP_TYPE_PERCPU_HASH because
> > for BPF_MAP_TYPE_HASH the value size is also not rounded up to a
> > multiple of 8.
> 
> The BPF_MAP_TYPE_HASH table have value size rounds up to 8. See:
> 
>         if (percpu)
>                 htab->elem_size += sizeof(void *);
>         else
>                 htab->elem_size += round_up(htab->map.value_size, 8);
> 
> The same for array size.

My bad, I looked at the _alloc_check and assumed any round_up would be
reflected there :/ Given that:

Acked-by: Paul Chaignon <paul.chaignon@gmail.com>

I also had a look at other map types and they all seem to round up to 8
or to not be susceptible to the oob copy (ex., queue & stack). The one
for which I'm unsure is BPF_MAP_TYPE_*_CGROUP_STORAGE. It doesn't seem
to round up to 8, but I'm unsure it could be used to reproduce the copy.

On a related note, this is the sort of reproducer that would be good to
add in https://github.com/google/syzkaller/tree/master/sys/linux/test
because syzbot can easily learn from it and reach potentially similar
bugs.

> 
> > 
> > 1 - https://lore.kernel.org/all/14e6c70c.6c121.19c0399d948.Coremail.kaiyanm@hust.edu.cn/
> > 
> > > Fixes: b741f1630346 ("bpf: introduce per-cpu cgroup local storage")
> > > Reported-by: Kaiyan Mei <kaiyanm@hust.edu.cn>
> > > Closes: https://lore.kernel.org/all/14e6c70c.6c121.19c0399d948.Coremail.kaiyanm@hust.edu.cn/
> > > Signed-off-by: Lang Xu <xulang@uniontech.com>
> > > ---
> > >   kernel/bpf/local_storage.c | 7 +++----
> > >   1 file changed, 3 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/kernel/bpf/local_storage.c b/kernel/bpf/local_storage.c
> > > index 8fca0c64f7b1..54b32ba19194 100644
> > > --- a/kernel/bpf/local_storage.c
> > > +++ b/kernel/bpf/local_storage.c
> > > @@ -487,14 +487,13 @@ static size_t bpf_cgroup_storage_calculate_size(struct bpf_map *map, u32 *pages)
> > >   {
> > >   	size_t size;
> > > +	size = round_up(map->value_size, 8);
> > >   	if (cgroup_storage_type(map) == BPF_CGROUP_STORAGE_SHARED) {
> > > -		size = sizeof(struct bpf_storage_buffer) + map->value_size;
> > > +		size += sizeof(struct bpf_storage_buffer);
> > >   		*pages = round_up(sizeof(struct bpf_cgroup_storage) + size,
> > >   				  PAGE_SIZE) >> PAGE_SHIFT;
> > >   	} else {
> > > -		size = map->value_size;
> > > -		*pages = round_up(round_up(size, 8) * num_possible_cpus(),
> > > -				  PAGE_SIZE) >> PAGE_SHIFT;
> > > +		*pages = round_up(size * num_possible_cpus(), PAGE_SIZE) >> PAGE_SHIFT;
> > >   	}
> > >   	return size;
> > > -- 
> > > 2.51.0
> > > 
> > > 
> 
