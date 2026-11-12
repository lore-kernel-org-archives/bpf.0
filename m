Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.234
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794507790;
	b=Bg9JZyOzzoKzcNklrfOOL4EH+NvZ2Dr5zW/+q77tU5NBlTH+3L8IZDe6LWmlBuR89Bx1
	 z5X0qH40+ABAUOT9/QyVUp7+lwJfu6ZjWQ6uP+RPXSWjEbX1CI29EZWcsP8/QgS65ECE5
	 x0q/dkgafT2JxVRxekQ51/WPnJwrPg2VMexlu644k87+8HrZE0XMoEdlyOM0qo3BeZOv+
	 RaTWrCTY4GCAxvUZfniIpRlWxwayPWnkggpjclgk+TcjQ86Yuv0+aflQx8U7mSRIVl0AL
	 Yxim5dIAk0/bPUv2yIvihsgOvu72AZGzS/8gsSm8Gw76ocyChOizT/HaLNrEoulnjGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794507790;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=37g18HIt+4q8l/uSb99DhUWkEswcluGqVCtxPLxOe4g=;
	b=wHy0l+DkLKgE3J102O8biw2ym5u6RdCY96Xc4RNEeF4mYLJobjW57lr5eD0LZHju0UFa
	 UloDvjbwaHht2VVjpvvJUa4G3C+5T7jomd1/bs1XyNfSYh7WpRNaBKZvJSjcVBCgxtH+x
	 wAXVkBAuXvt1djGK90SkNWNvY2ys1B/ymuH/TBGEu6rwEc3X2k4yl9igOuZW6MD8AzaDS
	 l66oEczoQaYjKu+Zg2HTfYWCPIwWU+5baFRjhuWiJNuVW28+0+G3rZ6MB0NsuRbZP3I/3
	 5bxgoinFIDG8x/qYrCD05yNZ+QYHJmOtokB2Aqo1q35n9X0j66+5VtW4j1HpEuTBAgQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=oYZYJ11P;
	arc=none smtp.remote-ip=91.218.175.234
Received: from mta0.migadu.com (out-234.mta0.migadu.com [91.218.175.234])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3036606A321
	for <bpf@vger.kernel.org>; Thu, 12 Nov 2026 18:23:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F3036606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=oYZYJ11P
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=7ZMvZrC6WW80QsW15QUoMF+I+fNGAUUIs8Md51Ez5T0=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794507787; v=1; x=1795112587;
 b=oYZYJ11P6Ug2bOwZQt6zlbEhhDdI7cHijEOTlvjDGwwqQIB5MlqvOVNmfe9AN90UJ2DiU4cx
 aB0VvCIyZMG20jJ59x6We8+D/TTOCznalfIm8/B+Bv/eUordbVZNkme8rxws1dc2/5TXI2J3N7Z
 m787X5NKAzGFczx9KkBfY5c0=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id b3e96c6073110e8e;
	Thu, 12 Nov 2026 18:23:06 +0000
X-Mizu-Trace-ID: b3e96c6073110e8e
X-Migadu-Flow: FLOW_OUT
Date: Thu, 12 Nov 2026 10:23:05 -0800
From: Shakeel Butt <shakeel.butt@linux.dev>
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org, tj@kernel.org, hannes@cmpxchg.org, 
	mkoutny@suse.com
Subject: Re: [PATCH bpf-next 3/3] bpf, cgroup: Protect cgroup_bpf state with
 its own mutex
Message-ID: <avYD5SOXPBQiey5v@linux.dev>
References: <20261112172721.440275-1-shakeel.butt@linux.dev>
 <20261112172721.440275-4-shakeel.butt@linux.dev>
 <sashiko-outbox-211618@kernel.org>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <sashiko-outbox-211618@kernel.org>

On Thu, Nov 12, 2026 at 05:41:57PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found no new issues
> in this patch, but noticed 1 related pre-existing issue it does not
> introduce:
> - [Medium] bpf: lost error codes in __cgroup_bpf_query() [1]
> --
> 
> commit 20190389f8922442abed742617dfa9e59bf26340
> Author: Shakeel Butt <shakeel.butt@linux.dev>
> 
> bpf, cgroup: Protect cgroup_bpf state with its own mutex
> 
> This commit introduces a dedicated cgroup_bpf_mutex to protect cgroup BPF
> state so that operations not modifying the hierarchy do not have to contend
> on cgroup_mutex.
> 
> > diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
> > index 334237096759f..ae082ac86130b 100644
> > --- a/kernel/bpf/cgroup.c
> > +++ b/kernel/bpf/cgroup.c
> 
> [ ... ]
> 
> > @@ -1518,7 +1565,7 @@ static int __cgroup_bpf_query(struct cgroup *cgrp, const union bpf_attr *attr,
> >  	for (atype = from_atype; atype <= to_atype && total_cnt; atype++) {
> >  		if (effective_query) {
> >  			effective = rcu_dereference_protected(cgrp->bpf.effective[atype],
> > -							      lockdep_is_held(&cgroup_mutex));
> > +							      cgroup_bpf_held());
> >  			cnt = min_t(int, bpf_cgroup_array_length(effective, atype), total_cnt);
> >  			ret = bpf_cgroup_array_copy_to_user(effective, prog_ids, cnt, atype);
> >  		} else {
> 
> [Severity: Medium]
> This problem wasn't introduced by this patch, but can assigning ret from
> bpf_cgroup_array_copy_to_user() drop an earlier -ENOSPC or -EFAULT error
> [1]?
> 
> Before the loop, __cgroup_bpf_query() sets ret = -ENOSPC when
> attr->query.prog_cnt < total_cnt:
> 
> kernel/bpf/cgroup.c:__cgroup_bpf_query() {
> 	...
> 	if (attr->query.prog_cnt < total_cnt) {
> 		total_cnt = attr->query.prog_cnt;
> 		ret = -ENOSPC;
> 	}
> 
> 	for (atype = from_atype; atype <= to_atype && total_cnt; atype++) {
> 		if (effective_query) {
> 			...
> 			ret = bpf_cgroup_array_copy_to_user(effective, prog_ids, cnt, atype);
> 	...
> }
> 
> When effective_query is set, bpf_cgroup_array_copy_to_user() overwrites
> ret with 0 when the truncated slice fits in the array, or a later
> iteration (for BPF_LSM_CGROUP) can overwrite an earlier -EFAULT, causing
> __cgroup_bpf_query() to return 0 on truncated or faulted queries.
> 
> [1] https://sashiko.dev/#/bug/linux-20442c38-bcc8-440c-9711-1977ea6cd04b

Seems like an independent bug. I will send the fix separately.
