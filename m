Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CFC51EDA2C;
	Wed, 21 Jan 2026 12:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768998560; cv=none; b=pElS/XoUf0tcvGqQ32AcLkhT3PEDZJM/wMyLiIrwyAM8Xp++AqHCentv9vPpzAapRZmespVfX+xjpuBhF3dw8MvHPzfSol6NQlI34xrHOnMnmnjjcX4tqmB+hOQuyCFPNcvEwSd3erZjtYE3wlPijnlTFR66tflXppquYtxoMfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768998560; c=relaxed/simple;
	bh=pMDfjEDhmURcJmLeyaBvdymXuNwkKDP+uzM8U7RaGyU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q7Y/dcdLyJ73OtiC6PieC/wcbwXRSPGRfr/9bjbWoD6UDtM8MrlImRwYTO8Lmh2Rvl4D+4cTq43oBJW4LeGUMwX74iziSXawflO2I9SX6xxI+9rl9UH6fLG72wZi+xX+mwZYT4uwxJIG6LqwNFarifd1XoF+08Vm4Vv56Ib+lEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=rXmThANn; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rXmThANn"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=kPvk1auDK3KdJksZdaBNMPhOXxNqXJrd/E762x4avQc=; b=rXmThANnDVFJSp4fXd5hBtx6Fc
	VvQh5LbUNxvZ5CrdUhftDpL8NOPH3ZmCQQ6iOkhRmPK8+x5FKf0egMb03DujEyWJmBPDNBIGJTctq
	zLxOGQ9RYnLtmewi47zIxl6GM/3RUTXvQFsZJcU48KW9OZnosFxveZB6/7JI1CARc4Uxe+gZ9LGAm
	jp8bsh6dvw6WPkzlmo/bdX1DMjWj7M8MZ9/XWlmXTaRY/K4D/oROOms6jvz6Q8kvgvPvjM7qgKsVq
	7xkFy4E9LRPFb/wudnPIP3eM78/bgf3Ggo5og1/W/wKGZxR5W0otkGRW68m+LWi1drPVu/LJQqpI+
	ZRGFb2bA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1viXKY-0000000GLK2-0tyD;
	Wed, 21 Jan 2026 12:29:02 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 1768E3003C4; Wed, 21 Jan 2026 13:29:01 +0100 (CET)
Date: Wed, 21 Jan 2026 13:29:01 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Joel Fernandes <joelagnelf@nvidia.com>, Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>, Shuah Khan <shuah@kernel.org>,
	sched-ext@lists.linux.dev, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Christian Loehle <christian.loehle@arm.com>
Subject: Re: [PATCH 4/7] sched_ext: Add a DL server for sched_ext tasks
Message-ID: <20260121122901.GA166857@noisy.programming.kicks-ass.net>
References: <20260120215808.188032-1-arighi@nvidia.com>
 <20260120215808.188032-5-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260120215808.188032-5-arighi@nvidia.com>

On Tue, Jan 20, 2026 at 10:50:35PM +0100, Andrea Righi wrote:

> @@ -1813,6 +1813,7 @@ void dl_server_stop(struct sched_dl_entity *dl_se)
>  	hrtimer_try_to_cancel(&dl_se->dl_timer);
>  	dl_se->dl_defer_armed = 0;
>  	dl_se->dl_throttled = 0;
> +	dl_se->dl_defer_running = 0;
>  	dl_se->dl_defer_idle = 0;
>  	dl_se->dl_server_active = 0;
>  }

This should definitely not be in this patch. Why was this added? Were
you trying to do the same as:

  ca1e8eede4fc ("sched/deadline: Fix server stopping with runnable tasks")

