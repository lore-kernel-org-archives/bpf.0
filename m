Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C0C022F177;
	Mon, 23 Feb 2026 13:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771854152; cv=none; b=ewNe+kHy/tHmscoSOQOCEkcEalbXwmLuzR2F/5wuh/pKP8VWQ6Ie7guV1v9BhKj+HakKl5PC7wNNhgQfhGNnTgMLGBoRbXds7DqsMFch/XK+R+N6+1YqqQBEvCuNS77F9qGjdLpnukP2fNakd6k3kXb0d0UWH/1wtynXxQdoTQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771854152; c=relaxed/simple;
	bh=FeGFrz+P3/u/+kz2HdUD5oz1nyGnKJRt0Glwhe+BCUw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WXF1/XjNieUAXKRM0E3Vy9vnsJQEN9vyoNNr6UGcG778fizw5MMiQGoyvDwcp41Q5jXQkb2kBBzIjlhzQeKQf7ogS86AavhKZmGHeF0JEk8RsNo3+yKVd47hDqivUfMXZVcnApas2rwqSilDcGF4WHTNezhR8xte3YaQNLDnLsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hqnYphIE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hqnYphIE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35034C116C6;
	Mon, 23 Feb 2026 13:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771854152;
	bh=FeGFrz+P3/u/+kz2HdUD5oz1nyGnKJRt0Glwhe+BCUw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hqnYphIEO870dd81/fzqMrs9j+imMlc/g/egsk7hBfyBaQjY49ERtDIfkHL6HzwsE
	 rSE6VZ0HPOoaH+In4j75lh4Z5OgrNMLcuO7szw0NammutqPcEEt36yJ8Df3RGM3XeQ
	 m5iYaO1TJatmiyGBwWsW6HkBaI6BQKH0GYZECcnwkjBF4iteViveAWXlLPpqG7P523
	 R4rotGt1o2IjiAWex0lORmFurCgC4d5fB1Bv2lhp3XknWcdnlUqRQxVVfu5LhykHKY
	 NQgGJa08nDdIGNx43EvupOTvCJCS29VlmB1fJyD+fANVuQ0UdgqhFhO9HohGxmUdz1
	 eeXtksI+E965w==
Date: Mon, 23 Feb 2026 14:42:27 +0100
From: Christian Brauner <brauner@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org, KP Singh <kpsingh@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] bpf: classify block device hooks appropriately
Message-ID: <20260223-verlegen-reagieren-ab46dc9460ba@brauner>
References: <20260220-work-bpf-bdev-v1-0-c53e852c4702@kernel.org>
 <20260220-work-bpf-bdev-v1-1-c53e852c4702@kernel.org>
 <aZinyCqhKYSFLj43@infradead.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aZinyCqhKYSFLj43@infradead.org>

On Fri, Feb 20, 2026 at 10:28:24AM -0800, Christoph Hellwig wrote:
> On Fri, Feb 20, 2026 at 06:48:48PM +0100, Christian Brauner wrote:
> > A bunch of new hooks for managing block devices were added a while ago
> > but they weren't actually appropriately classified.
> 
> > 
> > * bpf_lsm_bdev_alloc() is called when the inode for the block
> >   device is allocated. This happens from a sleepable context so mark the
> >   function as sleepable. When this function is called the memory for the
> >   block device storage embedded into the inode is zeroed. That block
> >   device cannot be meaningfully reference or interacted with at this
> >   point. So mark it as untrusted for now.
> > 
> > * bpf_lsm_bdev_free() is called when the inode for the block
> >   device is freed. A bunch of memory associated with the block device
> >   has already been freed and there's dangling pointers in there. So mark
> >   it as untrusted. It cannot be meaningfully referenced or interacted
> >   with anymore. It is also called from sb->s_op->free_inode:: which
> >   means it runs in rcu context (most of the times). So leave it as
> >   non-sleepable.
> 
> How did this even get added?  None of this should be of any business
> to LSM hooks :(

Fyi, it had nothing to do with bpf. That came as part of IPE about 2
years ago and gives that particular LSM the ability to track the
dm-verity status via the underlying block device so binary execution is
restricted to binaries from non-writable and dm-verity protected
filesystems (ignoring scripts for a second...).

This just appropriately classifies the hook for the verifier. It's the
same mechanism as security_alloc_*(). The fun part is though that while
the traditional LSM needs a pointer in struct block_device to allocate
storage for it a bpf lsm doesn't need that at all. It only needs the
hook itself and a hashmap. Or to say it more directly: this could've
always been a bpf lsm only without any additional in-kernel code for
this. But anyway, I'm using it.
