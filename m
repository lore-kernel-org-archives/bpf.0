Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B97FA38B7B0
	for <bpf@vger.kernel.org>; Thu, 14 May 2026 20:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778791702; cv=none; b=bGhsnkXHCm3Qz7l13rqdLW5HiuA8rEW8HDiShdY1/oKQ0HEIyoy9Xp0DMfvmVK80pALLi+9VAuX5J3IJJettBUVSIwiAvJDvkpvfac5M7loIMNeiTXc+eA2SmdVqSZP4EJw4A2AX2SMvX6z9y7LHw8kmM9TYuSC5shAt3lQ2BCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778791702; c=relaxed/simple;
	bh=GbI/HilT3/TE2hgnXD77YehXroaGkd4zT9OenCM2N4c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=slW+5c1wmxat/vEg5kybxLPKGU5tJ3p1vTeupGN4wQfRkPdOn4wcZFe+uFLCRuw2svbz47ILpv44N3O0SdWxyE3j8HotsC9pjy7dZPlG6nPqpLdoPv6LL9gwEbA229SxtRdOfWaTDP2p/4NTE1VIPzSFs1LmiAWBcVb7uMLZxXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VUZQ5Gd3; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VUZQ5Gd3"
Date: Thu, 14 May 2026 13:47:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778791688;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Bpbz1P5iYvLVjsXAG5YnXFlWjXOyOYaznXeZkwC9pOw=;
	b=VUZQ5Gd3sn4YMGXTelqn4KD8K1R3xdyruCIO8sTa1IMhkuhj8h+dPn5NqgX03eyUDUkDpH
	2c94L1iJhyRmrhTh1ib4LSKa15K8JL1/z8gFhC0Bexm3U6LtlY4TlV/ThfKC+IBzelV57Z
	okvyVGht+Xym3+Rz1YrPaYKn16tNOQs=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Puranjay Mohan <puranjay@kernel.org>, Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH bpf v4 2/3] bpf: Avoid faultable build ID reads under mm
 locks
Message-ID: <agYzuDIJszA_7rp3@linux.dev>
References: <20260514184727.1067141-1-ihor.solodrai@linux.dev>
 <20260514184727.1067141-3-ihor.solodrai@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260514184727.1067141-3-ihor.solodrai@linux.dev>
X-Migadu-Flow: FLOW_OUT

On Thu, May 14, 2026 at 11:47:26AM -0700, Ihor Solodrai wrote:
> Sleepable build ID parsing can block in __kernel_read() [1], so the
> stackmap sleepable path must not call it while holding mmap_lock or a
> per-VMA read lock.
> 
> The issue and the fix are conceptually similar to a recent procfs
> patch [2].
> 
> Resolve each covered VMA with a stable read-side reference, preferring
> lock_vma_under_rcu() and falling back to mmap_read_trylock()

Why trylock()? Why not just reuse the mechanism introduced in [2]? That is
abstract out the mechanism introduced in [2] in mm core and reuse it.


> only long
> enough to acquire the VMA read lock. Take a reference to the backing
> file, drop the VMA lock, and then parse the build ID through
> (sleepable) build_id_parse_file().
> 
> [1]: https://lore.kernel.org/all/20251218005818.614819-1-shakeel.butt@linux.dev/
> [2]: https://lore.kernel.org/all/20260128183232.2854138-1-andrii@kernel.org/
> 
