Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E281F2367CF
	for <bpf@vger.kernel.org>; Wed, 15 Apr 2026 02:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776220024; cv=none; b=ci1mAdPMI34k3ELHPvjJX63sKk/uSVk4UNbbxGdS/Q5kaL4DAiahkPBKoSxb/vRU08VlerSnJZ3uGWRAqYpR0RX7UigKrgfdzrOke9tiURlBJKufuv6PGeri1ESQw/wo9jJXtBjDlBmVzF6LOGIjI+Zsi7dA1SE0G7qHYhXDSMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776220024; c=relaxed/simple;
	bh=se/vKvsQL2DCtfKDUVWcw0v6I+7KYGglI/4Bflx1lI0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KL6wEaK/vzQbKWwf4KzBA3r9nn4HcDTVlTLs7rqrXwyqi2OBMiyyzFj4LbRIf7VIF/NSq0o4TK31ZXo4Yag5D9hsnDcWmt5gF+nCj3VsVfrYEKqTWyhMuLermxCisWNBeM6xThP5PUb+KHFROmDEQ/gFkq5nmuFfXBX/8fUQnBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h4E6fgUc; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h4E6fgUc"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-c70e27e2b74so2425621a12.0
        for <bpf@vger.kernel.org>; Tue, 14 Apr 2026 19:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776220022; x=1776824822; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IS60+FjovzFguj9ModkEOLa8EBlu6WeVu5VNYjZqwzI=;
        b=h4E6fgUcR3LZKLSmtkGZXPPp5IUI1VEbvwJkGWoUs+5qMrW7W9wsG/vcyVIb0oVIKQ
         862tixORmrB9AOtw4LOSc0fUsi8Pq6xKvSzEeJigAeR0K/RftafIplf6CjbZQgwVffcQ
         IBxDDsRzxewhyAvpT9v46cM6tg56FjqEoeGny52J/yzdpJynenJpatX4xYcCqHyM0+vQ
         otG4/4JEcmsvs6Na3bs1+UTMqA6Vd38vs3ngg8Ar7IJNhvEguJlMNDgbVEuPfCecuxUY
         OvUqoBDkgnW/er8NoWzxdqR30J5LYWdzI7lkNmrblxoWXKQGkYe4PD9yir5/tGiw/ksG
         FMJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776220022; x=1776824822;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IS60+FjovzFguj9ModkEOLa8EBlu6WeVu5VNYjZqwzI=;
        b=ZIPRIZo0JmccFRXf7eq2j0HSViiKzhYcfNgBwhgNZGOJQb4nWyFdWBTVSVrKRykJTX
         AqoUaQgMSfo0yhCfODYmSHvDGf6QLTiqlJzRSr5os9Z7xJ3Lp8HamQaJ7AgeFeIO3lOe
         QYoMDxHuWSRHhhDMX/0i2oATo8lZZmz3J9/CB0kBcRiPjTkSXhEmKPDGtnayVgDcSuJQ
         abMyxP/rD5QUs1w7ND1rEhpVO7NTDI0TPtjj1ew6oqhzqIQYmCLt1UkLTelTYy5elTgN
         BuknGtHWjlPPMXFyHVlxow9kVq4SU5OF6oY5zueiLK8uKDDFJvikZFr6ViKHtbw32ghx
         TAtg==
X-Forwarded-Encrypted: i=1; AFNElJ/dck4ysHx6NX9BYdSQbZF36Lpku9CD0ePSbYlxOZ0NzuD+0F97HYFTDFTjaP6+C8bKcWA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRpwC6TbOtlhAw+L3GzS0v45STA0QsJJg8hND/skjEA22PD0kU
	VLZuxJG3fMGg6AnhhEjPO43WcsPFct42Wi5y2Jgylum5m7N5x4bN7TCX
X-Gm-Gg: AeBDiesAdHPiBF7IMLT/rhvDVtVcf8xgdwDyLEJzz04QKiRdM3E8ma4l3uhvGIT8HpA
	cscS2vLfVs/Ssu+FBxepO5P9wBC+vhYdUIcxNJ5pvqMqtBV1uZjCuY7oL6wH7buLxthfdVBRwmL
	hRZVktZeO2czhdpF59polDWSqme/SCjpBIT54ChbzggtwKFUHD7r2ehAyBH4Hl/lD/Vu5wZs1zc
	p61ne/5s+nuVZn5TmYy/xMMumyHNMxpnCDQikX6hpEnl4zv+nmUFcBjDenEYdf78+a9sVHccU/1
	cOEhx/D56cvpdUYlcRDkp51EHVxh5f5fKQSJ2L+OuFb5lh/CP5zIi2FqMz7h38ElQ1/W3EcRofw
	E4vJlS5Un9JZZJobYvtv2MFx0OIFHLY+o4OoFkxTBeWSvl+OQLrWjbY4Wb3t2GlYEcEQH0C+YxL
	lXuIxXdC/8I6U0TXRqTTrZPseCur+Z5UZM0qcrkti9e2vfBX0BL62iJJA9to5bB7hww/tgds0ZX
	ZEq9pRx6EEYZDdIrUbs795uQ3szpss2UAgNjH4k2h6JP+ow4Cq+2SQ9rocopAM8qfbhUpXZbhJo
X-Received: by 2002:a05:6a21:3286:b0:398:7e11:ad6 with SMTP id adf61e73a8af0-39fe373c516mr20699334637.0.1776220022218;
        Tue, 14 Apr 2026 19:27:02 -0700 (PDT)
Received: from MacBook-Pro-49.local ([2601:600:837f:c470:1879:8422:922b:e5d3])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c79581a3015sm187924a12.16.2026.04.14.19.27.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 19:27:01 -0700 (PDT)
Date: Tue, 14 Apr 2026 19:27:00 -0700
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: Slava Imameev <slava.imameev@crowdstrike.com>
Cc: ameryhung@gmail.com, andrii@kernel.org, ast@kernel.org, 
	bot+bpf-ci@kernel.org, bpf@vger.kernel.org, clm@meta.com, daniel@iogearbox.net, 
	eddyz87@gmail.com, ihor.solodrai@linux.dev, kernel-team@meta.com, 
	martin.lau@kernel.org, memxor@gmail.com, netdev@vger.kernel.org, 
	yonghong.song@linux.dev, linux-open-source@crowdstrike.com
Subject: Re: [PATCH bpf-next v2 2/3] bpf: Use kmalloc_nolock() universally in
 local storage
Message-ID: <ydbdk5fj3mbjoninyt5lcg5czcrcgghk6ownothijy667zn6h3@eczgskgj43iw>
References: <CAADnVQKeFF--bgnZZSU12UY0muuwYA=7EdzLyOi837oZs+bXTA@mail.gmail.com>
 <20260413034829.39307-1-slava.imameev@crowdstrike.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260413034829.39307-1-slava.imameev@crowdstrike.com>

On Mon, Apr 13, 2026 at 01:48:29PM +1000, Slava Imameev wrote:
> On Fri, 10 Apr 2026 21:39:00 -0700 Alexei Starovoitov wrote:
> > >
> > >
> > > This allows value sizes up to ~65KB. Before this patch, socket and
> > > inode storage used bpf_map_kzalloc() (backed by regular kmalloc)
> > > which could handle those large sizes. After this patch, any
> > > elem_size above KMALLOC_MAX_CACHE_SIZE will silently fail: the map
> > > creation succeeds via bpf_local_storage_map_alloc_check() but every
> > > element allocation returns NULL.
> > >
> > > Should BPF_LOCAL_STORAGE_MAX_VALUE_SIZE be updated to use
> > > KMALLOC_MAX_CACHE_SIZE instead of KMALLOC_MAX_SIZE now that all
> > > storage types go through kmalloc_nolock()?
> > >
> > > Slava Imameev raised the same concern for task storage in
> > > https://lore.kernel.org/bpf/20260410014341.47043-1-slava.imameev@crowdstrike.com/
> > 
> > Right. Let's update it, but I don't think it's a regression.
> > On a loaded system kmalloc_large() rarely succeeds for order 2+.
> > That's why kmalloc_nolock() doesn't attempt to bridge that gap.
> > One or two contiguous physical pages is the best one can expect.
> > In early bpf days we picked KMALLOC_MAX_SIZE assuming that
> > it's a realistic max for kmalloc().
> > It turned out to be wishful thinking.
> > kmalloc_large concept should really be removed.
> > It deceives users into thinking that it's usable.
> 
> In defense of supporting 8KB-64KB allocations for local
> storage, we can consider BPF_MAP_TYPE_HASH with BPF_F_NO_PREALLOC
> as providing similar functionality to replace the missing 8KB-64KB
> local storage allocation support. However, these map entry
> allocations can also fail with similar probability since they
> depend on the same underlying allocator.

I really hope that 64kb task local storage is not your production code.
Severs easily have 50k threads. Sometimes more.
64k * 50k = 3 Gbytes of memory wasted.
You need to redesign it from ground up.
