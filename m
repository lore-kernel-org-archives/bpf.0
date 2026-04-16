Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5A073E51D7
	for <bpf@vger.kernel.org>; Thu, 16 Apr 2026 19:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776368841; cv=none; b=SphbgJTUpaqeCKW+MaEraNgcNmyFUpXcZqvZzoQ5ATH3wmx7IEFF4q5MydLwLTEPZAQM/uTZbjhQHzI7kMJ4H2P2hb4i0WBDVFP61v2IICRtq7E4NL8ObKGr1UZEyVwnj+kyG1vDGzg0+UfySk/1eG2y3f7d8bwyG/2NVVIZ9o8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776368841; c=relaxed/simple;
	bh=f3+qt1txvTkg9XrEAuNKQRAvO9o/8YpnyJwI/xx0vhw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=twuV8yBfhqtU5GqTqgVF5Lf750xmR+oYVTLSqbTmabJ7Z/IwNzruTjlbSk2ck7twpYwxvErErxSSu4PzArhu9Fe7kYIcS8dL8ihk1InQ1kGTTruNG1LVQOgaH7mUSa9uYUlJGSOIaLVtFuB+wI+Fia2xU2+bvnZn2dPyGnfvkdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=m+xhAVHw; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="m+xhAVHw"
Date: Thu, 16 Apr 2026 12:46:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776368830;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5LbHBaCSDyn+Yz5UnrvDE54o8/wYVbDFXXOhA0QDEwA=;
	b=m+xhAVHwsoicVxK88+IDKxfPzESYJEL5g6DJgeEBRWzz9GaMAbfAQEln4k2AnTzaFgPuA+
	9z8KQQWbUGUSPiIVeiMUVJM1Ql8lsvmZLnMuUTqb/BEgL9E6fv07CTkKaqshUp6jbP++Mg
	zRwvLyoXnzixG3/KvnbgwCZhqjKjE28=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
To: Nick Hudson <nhudson@akamai.com>, sashiko@lists.linux.dev
Cc: bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next v4 6/6] selftests/bpf: tc_tunnel validate decap
 GSO state
Message-ID: <2026416193859.IJ9_.martin.lau@linux.dev>
References: <20260416075514.927101-7-nhudson@akamai.com>
 <20260416124324.B0CE6C2BCAF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260416124324.B0CE6C2BCAF@smtp.kernel.org>
X-Migadu-Flow: FLOW_OUT

On Thu, Apr 16, 2026 at 12:43:24PM +0000, sashiko-bot@kernel.org wrote:
> Sashiko AI review found 3 potential issue(s):

> - [Low] Invalid pointer arithmetic (`kskb->head + kskb->end`) causes a compilation failure on 32-bit architectures.

> > @@ -655,6 +684,35 @@ static int decap_internal(struct __sk_buff *skb, int off, int len, char proto)
> >  	if (bpf_skb_adjust_room(skb, -olen, BPF_ADJ_ROOM_MAC, flags))
> >  		return TC_ACT_SHOT;
> >  
> > +	kskb = bpf_cast_to_kern_ctx(skb);
> > +	shinfo = bpf_core_cast(kskb->head + kskb->end, struct skb_shared_info);
> 
> Will this cause a compilation failure on 32-bit architectures?
> 
> On 32-bit architectures without NET_SKBUFF_DATA_USES_OFFSET, sk_buff::end
> is defined as a pointer (unsigned char *) rather than an offset. Adding two
> pointers is an invalid operation in C and will result in a build error.

Other tests have been using it to get shinfo already. I would leave it as is.
If it really would be needed to run and compile on 32-bit in the future,
it could use bpf_core_field_size(kskb->end) and then do things differently.
