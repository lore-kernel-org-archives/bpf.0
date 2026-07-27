Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A19C3D8908;
	Mon, 27 Jul 2026 16:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785168149; cv=none; b=mEM4vZGy6Hew3q662s4QU0lXIG0/eUaCQRDQdQTsH9uBDc912lki2H3kUZMfzgaXZX70ZTk1vlRktRv3Zq4MDZ38bazpOlAXLHSZs9VgrG6Fi09nzfj0vjLHSWZtjFeMsIzQbCP4lslfy9V4eMUvN+ndXHNZjV37J/Yrpbiy82g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785168149; c=relaxed/simple;
	bh=fKutNB/ReIKRl5C2DKRdcyfr9oXV+T1VuXHm1qBWY94=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pqVAL6RqL1Maf13EK1ry6BJAmv3TRtE1rAXPmT91XZ40MScGmn3CZ939BpFjp2DhTefhqSWol+63s6Hx08KddBVvkbOnsSBSTampQf9uB5wK5/HYBRdVCATK/TglH+MhMRAFmB83nVeG4nnOIOLuFuV5jv4h5YlsDz9bDmcVTTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=C5Ez8iUU; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="C5Ez8iUU"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Reply-To:Content-ID:Content-Description;
	bh=YA64e0u3ORB/T3g3HJitepVs+M4RrVR8jCHTxIeqSbE=; b=C5Ez8iUUw4drynAwsF7B/DB9WJ
	i+WQJYNS6dc+RjSQTkH6SzUiANBlfOu9pstP0UwdeyrufXjqdfuIo/V4B426PEivn/gnHqG4vkOC9
	dkeZkGnU57g1jQ+mIFpsRcZRLMRQu1K4+d1vMcTSQMDBhpPvDsyp4xxRZCHPYB8HbUROUpeujWgYn
	4F+FYAQwRv94jl0aqGI70SXEnLGfEhgN280kY8vBdtXt2bRNeoTfbiCbJFFvzcaVTlZ8H8N8q88br
	AMzX+ac8EriOPduOd9IFaPP7x9NcQ/76m/10t55bsDk0f4HBvbfHxI7O/HQj9Y4ZXOg+DsV8vsCw9
	XAriO73w==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1woNmU-0070nm-1C;
	Mon, 27 Jul 2026 16:02:18 +0000
Date: Mon, 27 Jul 2026 09:02:12 -0700
From: Breno Leitao <leitao@debian.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, puranjay@kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH] mm/kmemleak: report RCU-tasks quiescent states during
 the scan
Message-ID: <ameA03TahRgsWoz5@gmail.com>
References: <20260720-kmemleak_rcu_task-v1-1-5b460ade777d@debian.org>
 <20260720153917.2e428e489cd0873ac6d4e6da@linux-foundation.org>
 <5b83b0a0-708a-458a-bdbd-41c6d4610349@paulmck-laptop>
 <amCT9QEgJRsLIb_y@gmail.com>
 <ffa5d8d2-1157-4a30-995c-ddae3566e3a4@paulmck-laptop>
 <amM1xUOhcpGpqIpe@gmail.com>
 <39c90e82-f785-4b47-9571-dd4b1339d685@paulmck-laptop>
 <amdWVTs0WKOxguxP@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <amdWVTs0WKOxguxP@gmail.com>
X-Debian-User: leitao

On Mon, Jul 27, 2026 at 06:04:37AM -0700, Breno Leitao wrote:
> > > The document was not a waste of time. it helped people like me to
> > > understand what the issue is, and what are the decisions we have ahead
> > > of us.
> > > 
> > > Back to what is the best decision/design, I honestly don't have an
> > > opinion, but I am happy to get more data about Meta production servers
> > > to help with the decision.
> > 
> > Looking forward to seeing what you come up with!
> 
> I found 3 different cases on Meta fleet, where rcu task stalls show up:
> 
> 1) kmemleak -> This patch solves it
> 2) KVM / kcompactd
>   * Holdout: kcompactd0 (pid 1216), state:R, nvcsw frozen at
>      716336/716336 across three reports 10 min apart (stuck ≥20 min in
>      one compaction pass)
>   * This is coming from: migrate_pages ->
>     kvm_mmu_notifier_invalidate_range_start ->
> 	   tdp_mmu_next_root -> tdp_mmu_zap_leafs
> 
> 3) Nvidia driver
>   * stuck in nv_procfs_read_lock_params
> 
> Given we can't do much about 3) and 1) is now closed, I will spend some
> time geting more data and possible a fix for 2.

Quick update about item number 2), I've investigated and found that
migrate_pages_batch() unmaps each folio before moving it, and every
unmap runs the mmu_notifier invalidate callbacks.  On KVM hosts
try_to_migrate() ends up in kvm_mmu_notifier_invalidate_range_start() ->
tdp_mmu_zap_leafs(), which is expensive. Patch at:

https://lore.kernel.org/all/20260727-kcompact-v1-1-bdfefddd6874@debian.org/
