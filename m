Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBA022DA75A
	for <bpf@vger.kernel.org>; Fri, 27 Mar 2026 03:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774582793; cv=none; b=GD+0iJrc1bLMNxsiq3K3qQpUDeoZp8aWiKjDlQsI9ojKOacdvnqXHs3xqXB3gAD7tsB77br7u9oHptOLzjuGme0jA8O5VWFZIQDrn4/UA9hSnDzAx5PO+sK9l+VH0zkWxxMuHduteAgm+PPn11AXFR/CrvhyPE+96DGiuG5XII8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774582793; c=relaxed/simple;
	bh=As7l+MkucgSQSUeu8o4HrUBHeuTVaeqbXJxudVfdyM0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gSo6HAyUiTdvjg1pMzpDqPR/GYKTSbeDTfIRvZ99GbpaSU8y3U+307GFfr+dZlBzFnKYTTCIyrtjYif44RfM66B6xe4qvRSjdPcGXQgLCkgZNLOFHRySRbqpUqa/RDyI3c5MBLaMH0eywkjpibFsTgcE84gbzCZGWAEjq+TTUuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=urLNBjsO; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="urLNBjsO"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=LbUMGNxtcsptfKyJ8umnsG3FmP2qeReOaBThJBj9pik=; b=urLNBjsOOGK5zZBA/me+vklaWl
	Ks87y4XHQnFlURVzrmqqb/zuZPPFcRxCgnpynTYQGmbFPPMTUEaora81MZwlt6uHkqE/OeFcWK2Wz
	lMm7cVCoE3/q6xgVAh+zMRXBi6nSmY0OZcNGUCB5kNHyCz7GfRA0DU18yiy1xkfeB1wac4/M/j2qP
	sz8I8rdmCedNO9FOYblol8R65gCMOj5LZ7nmdd2aTeeklqG5RUqJ3dTGND1A1qhzcqN53bF/1+Hic
	5Uqn27PH9zH09vQf0c09czBrzNnxnqIiwm0Me0eLtIX6fRA6oMKA8RNittQsb8u9X/AlOIx1v6BW5
	eaUm72SQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w5y2y-00000001CKR-2T3H;
	Fri, 27 Mar 2026 03:39:44 +0000
Date: Fri, 27 Mar 2026 03:39:44 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Tal Zussman <tz2294@columbia.edu>
Cc: lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org,
	bpf@vger.kernel.org, Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Josh Don <joshdon@google.com>, Greg Thelen <gthelen@google.com>,
	david@kernel.org
Subject: Re: [LSF/MM/BPF TOPIC] Upstreaming cache_ext: Custom Page Cache
 Eviction with eBPF
Message-ID: <acX8AL_aQlHtrVEe@casper.infradead.org>
References: <0b1293ca-7a1f-4358-bc20-15784452238d@columbia.edu>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0b1293ca-7a1f-4358-bc20-15784452238d@columbia.edu>

On Wed, Mar 25, 2026 at 05:15:37PM -0400, Tal Zussman wrote:
> Hi all,
> 
> This proposal is late, but I've been encouraged by a few people to submit
> it, so hopefully it's not *too* late...

Hi Tal,

I'd have strongly argued for an invite for you based on our discussion
at Plumbers.  Unfortunately, some people needed 60 days to apply for
a visa to visit Croatia, which meant we had to decide on our list of
attendees in early March.  We really don't have any extra invites left,
which sucks because I think you'd have been an invaluable contributor
to the discussion about reclaim we will inevitably have at LSFMM.

If anyone does drop out, I'll advocate for you to get an invite, but
I think that's unlikely to happen.

