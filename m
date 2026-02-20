Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B36E634F479;
	Fri, 20 Feb 2026 18:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771612110; cv=none; b=rBfjmdUAipeeLc05SwpMsR2kDOR5iZoBL+adYDeIwVvCzFtPxNFT0iby+rhOROMdyE7UPrNcBHI7We91+icxVxWp4+j7RO2qprSsiKZBWDjhynh5zXHXOek2L3Ifl2dYV4lR3HjC+iQDF63ehIxBuHndAxeFtRT/kDTJGpjS+ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771612110; c=relaxed/simple;
	bh=m1B7IjwHd7P9eeRDkclzvbQ/s9rpmimty+kSqSIM/KU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KUTJTKy1fEZht4+SPTNDKWJMAr5uECRIpe+MZ4z2i2KWmOlSx91m4bdoM34/MHjcXWJWbAl8R7ID9HBb2uMNAoPm06Q4wDX4zw4/yhw2JEB/Hwf7GRWOTPRCgA9E4p+fceTdxrcTjr4n12g5fTsVJMbhwcj/RHxusRtFnNf7Utw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=QYwbcF1G; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QYwbcF1G"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=uyk3xwbgiSeXZHnGDF/a11B1FWH7ZQom9dewwH1g4Yw=; b=QYwbcF1Gd8uJrgk8pSTyDDMWWm
	tZxueje393rPDTGR4wEQo4lzl5youjcXmiax2gus034QwwF1jOtk5AoDE8SWoIm17S87J5av6wk2g
	nt24ffAHIgEQSU0bR8HHzAEH1lW6kHS0lnOeKB9j8/6dwUc3FYoY2xt72muOqPD4pCsDMDA8T4Xug
	Mvjh3GN4hALONMnhejm3m1jKSTOymg6EL4bWXz81lK7fc8ig2rWiYWThmarDL0kZvuuzt4qgh5VAL
	BFRTJ8lubPzop4JTrEhCy/mjnQbvfjTw7nTgQwsY2Q1GJwli4l2Ivwbv681iYQwzNiJaztG7AermF
	DmAwaKyg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vtVEm-0000000FS2u-2XYZ;
	Fri, 20 Feb 2026 18:28:24 +0000
Date: Fri, 20 Feb 2026 10:28:24 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org,
	KP Singh <kpsingh@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] bpf: classify block device hooks appropriately
Message-ID: <aZinyCqhKYSFLj43@infradead.org>
References: <20260220-work-bpf-bdev-v1-0-c53e852c4702@kernel.org>
 <20260220-work-bpf-bdev-v1-1-c53e852c4702@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260220-work-bpf-bdev-v1-1-c53e852c4702@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Feb 20, 2026 at 06:48:48PM +0100, Christian Brauner wrote:
> A bunch of new hooks for managing block devices were added a while ago
> but they weren't actually appropriately classified.

> 
> * bpf_lsm_bdev_alloc() is called when the inode for the block
>   device is allocated. This happens from a sleepable context so mark the
>   function as sleepable. When this function is called the memory for the
>   block device storage embedded into the inode is zeroed. That block
>   device cannot be meaningfully reference or interacted with at this
>   point. So mark it as untrusted for now.
> 
> * bpf_lsm_bdev_free() is called when the inode for the block
>   device is freed. A bunch of memory associated with the block device
>   has already been freed and there's dangling pointers in there. So mark
>   it as untrusted. It cannot be meaningfully referenced or interacted
>   with anymore. It is also called from sb->s_op->free_inode:: which
>   means it runs in rcu context (most of the times). So leave it as
>   non-sleepable.

How did this even get added?  None of this should be of any business
to LSM hooks :(

