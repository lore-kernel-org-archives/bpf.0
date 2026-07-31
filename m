Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722072C15A5;
	Fri, 31 Jul 2026 18:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785521291; cv=none; b=DAqptrUS9NRMbcGnBXJn/CqDh05sMrsb8DL8cVZwHwhA819eqopNU6mM5CoQGBVWLk+WiEZ7XYbqgOwm3/YGZSXkOI70tYU3xUoxcJj0mIA9vpMeX7pncj4aUCGYU+xEV3yrPZKGUdvcr6iCjwfaQXSXvZlOY/9/2Fjh0YEIaqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785521291; c=relaxed/simple;
	bh=n59jyJb7dWrpo6FsBxETFUM0P3EoIJOg0a6uUqAVQrc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iLsuYcCNuOOhgs5rGg1TsHKDgTEDUPfhnG1NViqEROryAe3bxA8wDjH7Hxluby2SLqrNfc9zK2g9VzNNjZ1+PEX+i5EUrLYQRD2c05DjGt3fRiF+HNTCtWFfZBoI4LZDs9/QzyOh9x5OnEczy92kjrB36SCuEp+nkhzhDqM+cAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=P31RC6J7; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="P31RC6J7"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=PSu7HlraTrtCjx5JsJFL6p1xgqkSTFzQNybrZjtENdc=; b=P31RC6J7kHO3GR0UKFbGSYsbUI
	KoU5Kjp6bTger6m+z79NQzGE4X+mbYGwyU3REKwoV6LYeM4ud4wLJYZQ1q19g4S5+8m6GAbRjaRVp
	o+PGXI4XbT9ydbNe1fk9+Wl04OJ8orkrYxfAWJJTrMCAQQ2+TfeNEcleEQlUJOCe7ph2F6loRNfgD
	/ct9qRrj40vo/9p0eBkrr9KZwvYqtRL1jLFi3B8O3ASt9WnUS0cHF4DRAX07Ya8EErl0XUdUoiAsa
	uUkniItM9pHsGIUlCetCMzDCcwcWN0L5xtTwdOEoNhef8TAmQdyFESmIEoT00Lt9ov/9DzZ5flr+Z
	fM+Wkk4g==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wpre9-00ACx0-0B;
	Fri, 31 Jul 2026 18:07:49 +0000
Date: Fri, 31 Jul 2026 11:07:44 -0700
From: Breno Leitao <leitao@debian.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: rostedt@goodmis.org, pjaroszynski@nvidia.com, 
	Andrew Morton <akpm@linux-foundation.org>, Catalin Marinas <catalin.marinas@arm.com>, puranjay@kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	kernel-team@meta.com, dcostantino@meta.com
Subject: Re: [PATCH] mm/kmemleak: report RCU-tasks quiescent states during
 the scan
Message-ID: <amzjjjZrseO-jMJL@gmail.com>
References: <20260720-kmemleak_rcu_task-v1-1-5b460ade777d@debian.org>
 <20260720153917.2e428e489cd0873ac6d4e6da@linux-foundation.org>
 <5b83b0a0-708a-458a-bdbd-41c6d4610349@paulmck-laptop>
 <amCT9QEgJRsLIb_y@gmail.com>
 <ffa5d8d2-1157-4a30-995c-ddae3566e3a4@paulmck-laptop>
 <amM1xUOhcpGpqIpe@gmail.com>
 <39c90e82-f785-4b47-9571-dd4b1339d685@paulmck-laptop>
 <amdWVTs0WKOxguxP@gmail.com>
 <amtZNwxZ3gpOsPER@gmail.com>
 <743bf971-b4aa-416b-b72b-88b538be727a@paulmck-laptop>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <743bf971-b4aa-416b-b72b-88b538be727a@paulmck-laptop>
X-Debian-User: leitao

On Thu, Jul 30, 2026 at 07:57:22AM -0700, Paul E. McKenney wrote:
> > I suppose we want two things:
> > 
> > 1) change cond_resched() with cond_resched_tasks_rcu_qs()
> > 2) Avoiding holding the ftrace lock while calling
> >    synchronize_rcu_tasks()? It can take up to 10 minutes on a healthy
> >    system to be releasd, right?
> 
> I do very much like both of those options.  ;-)
> 
> If #2 is impossible, would it make sense to have a mutex_lock_idle() or
> similar in order to sanctify the lock synchronize_rcu_tasks() latencies?

How would mutex_lock_idle() differ from a regular mutex_lock() when
sanctifying synchronize_rcu_tasks() latencies?
