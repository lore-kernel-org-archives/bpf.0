Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B42852D3ECF;
	Mon, 27 Jul 2026 13:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785157506; cv=none; b=G15BOKQhpTvawtlb5nnrhNz97nyBYYQirVKkipqCF02+Daymmxp/Ia77vG7njghPj5lkJsbIWUi6Nollo1TB+oFzQPoSCAVT/+uujbGnCNS3L86jgtIndFLHCWS1pmUfuWbdxoJSIXOrJNFCIGWXSYRoWxp28XbljjvQFprg1Ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785157506; c=relaxed/simple;
	bh=TbXEodD4bBw0Du7sllvZPgf10XkwARfXOFSrxeJ3mEc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PBraLQJAwlpHQi+6cdIKuMYk8nRLe4Xh7Usg+VPweQssKbUrSKNnCmbMcXU7F69gcx4vZ+aJA8RWg//88xXgehcizI26G7Owb/smO6kxt88Kg1UlT0rpzsJbf/QDoOJf3WEqn3i2pTHRFUGkq0n2nipl9t5V+JJh/JVZcktOHxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=Ht5Jap5i; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="Ht5Jap5i"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Reply-To:Content-ID:Content-Description;
	bh=s9wWiDjCW477tgZIUjVpQbdu88BE7PfzDyOZG1n0onM=; b=Ht5Jap5i77PnqRGHRJ802tXx0a
	O0b3rd4TWLwB3x2XgwTlCrpDZzrM3Gf42i30XVOZSnCwrLQZ4gw0i1L2uUovANqFW+cBIAAaXPiRb
	AgpskSy8py7EGSxkV6eY5FdnBBugHkPHuBrTJr1YM2AwJ6BAd9edCnoGgFgL6rItqvEbnG6ITkQhQ
	IzIZiaCsuq645/RTDjOLOahDvGWOwkAr69MGaU8C3l0BBRsvikl5Sgj0ZgwOlnN6iDqz1t0UgOgC/
	nuVCcppC1qxuGmCx4LnFJ7Hv8zNrUkW+7YKO3YgPhhQ8WzRUPhhtN26m65ldg+BGawqO3anAQQmLo
	8uTm1X/Q==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1woL0r-006utr-0Y;
	Mon, 27 Jul 2026 13:04:57 +0000
Date: Mon, 27 Jul 2026 06:04:37 -0700
From: Breno Leitao <leitao@debian.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, puranjay@kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH] mm/kmemleak: report RCU-tasks quiescent states during
 the scan
Message-ID: <amdWVTs0WKOxguxP@gmail.com>
References: <20260720-kmemleak_rcu_task-v1-1-5b460ade777d@debian.org>
 <20260720153917.2e428e489cd0873ac6d4e6da@linux-foundation.org>
 <5b83b0a0-708a-458a-bdbd-41c6d4610349@paulmck-laptop>
 <amCT9QEgJRsLIb_y@gmail.com>
 <ffa5d8d2-1157-4a30-995c-ddae3566e3a4@paulmck-laptop>
 <amM1xUOhcpGpqIpe@gmail.com>
 <39c90e82-f785-4b47-9571-dd4b1339d685@paulmck-laptop>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <39c90e82-f785-4b47-9571-dd4b1339d685@paulmck-laptop>
X-Debian-User: leitao

> > The document was not a waste of time. it helped people like me to
> > understand what the issue is, and what are the decisions we have ahead
> > of us.
> > 
> > Back to what is the best decision/design, I honestly don't have an
> > opinion, but I am happy to get more data about Meta production servers
> > to help with the decision.
> 
> Looking forward to seeing what you come up with!

I found 3 different cases on Meta fleet, where rcu task stalls show up:

1) kmemleak -> This patch solves it
2) KVM / kcompactd
  * Holdout: kcompactd0 (pid 1216), state:R, nvcsw frozen at
     716336/716336 across three reports 10 min apart (stuck ≥20 min in
     one compaction pass)
  * This is coming from: migrate_pages ->
    kvm_mmu_notifier_invalidate_range_start ->
	   tdp_mmu_next_root -> tdp_mmu_zap_leafs

3) Nvidia driver
  * stuck in nv_procfs_read_lock_params

Given we can't do much about 3) and 1) is now closed, I will spend some
time geting more data and possible a fix for 2.
