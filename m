Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF4F2E3397
	for <bpf@vger.kernel.org>; Fri, 20 Mar 2026 02:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773972317; cv=none; b=ju+dgUomh2xJuMRNFMOb/E8XATyZRYE0C9iGsUJkF/53foQT+CysIqeKB93EBhYImYKIEfLbpLuEpe8nVOLQZV5P8rHlUHY/4agmXgDJwI1YrNYtBjm1tXnk5UmykDzLMS5JNCnHn6xvznSM3TmeF+RFYKsTO2+U280+M2ackFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773972317; c=relaxed/simple;
	bh=XWg5CsmKsYQWUJpjwNp2BHTXKxRKAFJiDshrXDs7TKM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jleMvF3+7w05uaInUTwtBuSySRmIdafu1V7HaoIV+tPlpTZksMOW9ndVtndvlmrpLBgzV9TRWU8T+OU+ki0xX3aUvIAOaoPAUXyGU3e+hrPx9MjzxTHY6+7kdPIURb38uZS/V/lKuweLWC5hwwHLrn+S6wpwjHeQV3Mwx1Y1mOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=QdpMWkqH; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="QdpMWkqH"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4852b81c73aso922815e9.3
        for <bpf@vger.kernel.org>; Thu, 19 Mar 2026 19:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1773972309; x=1774577109; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HoYH+bYRf8uzbuAoVDkiQBQxTKCdXno8PRObyskaQJo=;
        b=QdpMWkqHyZX7XVF6hicMYvNGIubYo1SEVP+9qcrcx1Oa9p50uZhcYlo+LGeQJueL+K
         TGbQFBzoay7rxciaYySXV2z4ycyo7e5udfm3SeC4XwWRD/zDuHwfTRpk0cJU/3rPyZdX
         /FPr3pqF+So6uzXRozPGbfA8+jTBzTzdNi9nlufjYcl6Os0X4QJhQVcryKcjrUVjzT5K
         2xhBRKnlSuvJ2RRIiPmejYn8ksMxpE0zwokP7CvUyS23IEnF0C5Qthnqle8tHVm/b4n6
         D6er4TdTpoYNcDZWfECPSUtQt8d4bH49PcTtc0kdGuhvfsvMJr4haadNfTZlEBQ4yuVd
         8qLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773972309; x=1774577109;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HoYH+bYRf8uzbuAoVDkiQBQxTKCdXno8PRObyskaQJo=;
        b=UXnrnK1sIYMhKzlvyH7q9ehtnYxW3ld9FR8flHVO0t5T0ZdbqH4aUub51ImdCSUhS2
         KEcRZXoiefUTBJSGwjKzh1mAFSJEue+Rhg9MhrI1NZgyli+Yfw1Q323oII7JI2mf3S1k
         QgNi1tlfvJ6ULwt+SvmRR7myVMKg0uxBLHMYsFAsHrtZj8/8QYHpGPhiKxc+skFWigSi
         btcai+70otBVHrCITpn1QoYYtXUQSCWgp4dXpX2r0XV3CDZ7/qQWT8gXiUZSBKciSHq6
         9PDp9J5rk5H/IkDwn3XqNe/Zfhosv0DaClwEuc/FV2tQVn4cxcIFHbd3Nc/oUgIIJi11
         J9OA==
X-Forwarded-Encrypted: i=1; AJvYcCXhVlsfaj5qKVUTO1h8QIysQcU0cUJ9H1btUtHHxOcVXQzPuPeRAKUisaZsY1iRNGUe4ms=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaSsjBiE95hG2afqU1Em8+8NKiCxoOK+eNXl9NafREGK2dOtv4
	szMmj0sAqoglXjxF6FVKgITWbwkdHXLzX3eQTgQNfS1KNV2pGT8lAeKtO2nWziWRrB0=
X-Gm-Gg: ATEYQzwBV4F6UnE8KCDqaY2sm4E0us0CE9JcWqW+a6YA/O00zIo41Gha8uJnVyLySN/
	d1L8xzOu+qFkjQE6Yfz3ZdAkpIt5M8s2SvgXB03BQBypXywOEJXurwlb7QHeqlmyAHPZryOFYyL
	bV8d0Kx/ISL3nbHn65bY0lG+tiOSaaygutyFuhfuL/Psb9YLkGE9bG7nP7lzBg1JhUkTxj/sDVC
	9Vjv+7lMS+/Bmy2KB/SJnpGIjs9wMv5HorwLkhquTOZO8UFH65WWBvoksZYZKbnvz2e82qOqi0w
	oOziEIhs9y+F7cDd5ad9ZkgFnN+ZcnzgU9nWgO3zuR2AHwGYAfZABnNvh/fVQbSmKY4fVe/r12j
	WOKN716V+wFUenMld21ZuNKvCZSTUz8Z2oz9O5FE8xcHWw7lOZPTGEKNF5pmChDbr6+AFErOWEo
	CKeLAM89ExrkQpd+RLIw==
X-Received: by 2002:a05:600c:3b07:b0:485:419c:4eab with SMTP id 5b1f17b1804b1-486fedab40emr16095735e9.6.1773972309228;
        Thu, 19 Mar 2026 19:05:09 -0700 (PDT)
Received: from u94a ([2401:e180:8dfc:66a:a219:10d5:f609:370a])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b083516ae1sm5227305ad.13.2026.03.19.19.05.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 19:05:08 -0700 (PDT)
Date: Fri, 20 Mar 2026 10:04:55 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Hao Sun <sunhao.th@gmail.com>
Cc: Paul Chaignon <paul.chaignon@gmail.com>, 
	Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>, bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, eddyz87@gmail.com, john.fastabend@gmail.com, 
	martin.lau@linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bpf: Simplify tnum_step()
Message-ID: <q7i6qgoth3735r5duljfnrg2tvh4kuz3fdsjxdlxdkkeanpmgk@egmiv35lh4p6>
References: <20260318171906.53174-1-hao.sun@inf.ethz.ch>
 <atwy3evusj7cjafp3fnrzgimj3dimcyuxasohegjc2enplb3cb@4l7i5hoe2ify>
 <CACkBjsbcv4woDZZ0_BA4idBwfLPXNTX7BzJMXTH54zq_8F0BuA@mail.gmail.com>
 <abvDSjl633b_Hb1O@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abvDSjl633b_Hb1O@mail.gmail.com>

On Thu, Mar 19, 2026 at 10:35:06AM +0100, Paul Chaignon wrote:
> On Thu, Mar 19, 2026 at 10:01:31AM +0100, Hao Sun wrote:
...
> > > > +     carry_mask = (1ULL << fls64(d & ~t.mask)) - 1;
> > > > +     inc = ((d | carry_mask | ~t.mask) + 1) & t.mask;
> > >
> > > Maybe break out the calculation of inc, give it a name (next_submask?),
> > 
> > Maybe we can break this down as:
> > 
> > d = z - t.value;
> > carry_mask = (1ULL << fls64(d & ~t.mask)) - 1;
> > filled = d | carry_mask | ~t.mask;
> > inc = (filled + 1) & t.mask;
> > 
> > `next_submask` is not precise, as we ored `~t.mask` into it.

I was thinking of something like this: 

	static inline u64 refactored(u64 mask, u64 d)
	{
		u64 carry_mask;
	
		carry_mask = (1ULL << fls64(d & ~mask)) - 1;
		return ((d | carry_mask | ~mask) + 1) & mask;
	}

	u64 tnum_step(struct tnum t, u64 z)
	{
		...
		d = z - t.value;
		inc = refactored(t.mask, d);
		return t.value | inc;
	}

For me I find having to grapple 1) new way to calculate tnum_step and 2)
finding a submask of tmask > d, both at the same time rather difficult.
Hence the suggestion for separation.

> > It's always hard to name the intermediate result :)

Indeed, and let me not even try to name the function here.

> > > and have it as preceding patch? It seems generic enough that I thought
> > > would have been implemented already, but bitmap_scatter() was the
> > > closest I could find.
> > >
> > > Perhaps could be submitted to include/linux/bitops.h in the future.
> > 
> > The calculation above is direct, adding a bitmap helper intros an indirection.
> > For me, it means I would have to check out the meaning of the helper
> > and then get back to understanding the algorithm.
> 
> I think I agree with Hao in this case. If we can reuse existing helpers,
> great, but otherwise it's short enough that it's probably easier to keep
> inlined here.

Okay, I can now slightly see that it does introducing indirection, make
sense to keep as-is.

Acked-by: Shung-Hsi Yu <shung-hsi.yu@suse.com>
