Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.50.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795191688;
	b=ZVqmUtOFG5Tjss7gt2s/Rcz4fi4GYeNCh90ldkKHl2/SFrp9RODE4uJw7MRKmooac4CP
	 oDyLipLMpXEDS6Hfrf/NZ8zOS0UrRNJL/4ncFthAfcG+GaMaH5mzYgcFBWYrMeghHKbvi
	 Z73ZlLC+MUlAolPef1gBxnWehsqmJvj3KFzbJrZeF6kNUfGeKvYaygvEcImgopJDOo0nO
	 8OONYrz/hJG+ybcFZWr89RxkDarj8RqpuGuCBZN3aPmMQ2yacEcnBgc7n6fHEtkcqyDaG
	 Y/MXvN12977g7PSqtdqjPJJutKDbEu1d5kipFRzmLFZL+FnBxsfRyxUC1r3ySp3K1Bw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795191688;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=HKukrA1kjAzflkPDlnKuOwVAtlMx2svX9Z2jpFZQYgY=;
	b=GFY3WA4d0okkIV9cypQJf2vJ4/wv2E+h3WZ5aajThNjgCRQlwRRsIE3LqTu9ure5ipq6
	 XtnCHHqqLTqNan5oGSGSPuV6dCYJ+pKdolqf5qvw3u0kVcF04M0raO9pPIxif10YTFtKl
	 HtLFJArl968pmRPg0Omc5u1SZVzXvbl/nh5FZF0nGgFDmiTjYexHqBa6+l4HJJqfKKIT+
	 yqRtmQHjaJv3N0GMJJwvxjNTcznbMGtiWIqFoKw8IFAdQ5N5XNq2lUqJXPfXIGZ9D8CIG
	 yVGYF5D4yRjc2oorIYm0OilmQM/flqdzOD4Jq5BvwRozlZPbuJrr7Z2K3vsjKqzs7Iw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=pass smtp.mailfrom=infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=u3X231A4;
	arc=none smtp.remote-ip=90.155.50.34
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 389AB606A325;
	Fri, 20 Nov 2026 16:21:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 389AB606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=u3X231A4
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=HKukrA1kjAzflkPDlnKuOwVAtlMx2svX9Z2jpFZQYgY=; b=u3X231A4KUeZGq4hvlYQYBqPhN
	sxdxe3Mrtjjr9bCPh7ceBF37Gi7+q22vIKAvt2dNvsF0LZD29Rlzw9evxDlAx5V2B9eLcOgBHwS6K
	AUot5Yo6xpccZ1AEtOhiIdW4RNDsYzegSNUg6jDtxRmg67ShFrQnwzge4m0JJTuDXapsvjlZe8Z9s
	DKpc3dT+uuqWZ4c+CSuz4EfXskeXsaPl7CsNuRdto9KBepJuajlLKo5YH5tX3wlA13VMzYFr2EhRj
	7YOBnFyvdpm3LD0WVbbaSawCZ4pdXfTisD5kEjGy1ySWtc3xkH3HAqJDxfzUrUuJshRjIuNEoGX58
	WzmoDX4g==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xURMa-00000007mOY-2Ed8;
	Fri, 20 Nov 2026 16:21:24 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id C42BE3008D6; Fri, 20 Nov 2026 17:21:23 +0100 (CET)
Date: Fri, 20 Nov 2026 17:21:23 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Tejun Heo <tj@kernel.org>
Cc: Tao Cui <cui.tao@linux.dev>, void@manifault.com, arighi@nvidia.com,
	changwoo@igalia.com, mingo@redhat.com, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	Tao Cui <cuitao@kylinos.cn>
Subject: Re: [PATCH 1/2] sched/core: Pass ENQUEUE_RQ_SELECTED on initial
 enqueue
Message-ID: <20261120162123.GS2668804@noisy.programming.kicks-ass.net>
References: <20261112144935.583937-1-cui.tao@linux.dev>
 <20261112144935.583937-2-cui.tao@linux.dev>
 <598bee2c48b23aee00c404d1183b581a@kernel.org>
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
In-Reply-To: <598bee2c48b23aee00c404d1183b581a@kernel.org>

On Sun, Nov 15, 2026 at 05:06:35AM -1000, Tejun Heo wrote:
> On Thu, Nov 12, 2026 at 10:49:34PM +0800, Tao Cui wrote:
> > select_task_rq() sets WF_RQ_SELECTED and ttwu_do_activate() maps it to
> > ENQUEUE_RQ_SELECTED so enqueue_task_scx() knows whether ops.select_cpu()
> > ran. wake_up_new_task() also calls select_task_rq() but activates the
> > new task without the flag, so on the fork path ops.enqueue() never sees
> > SCX_ENQ_CPU_SELECTED and SCX_EV_SELECT_CPU_FALLBACK never counts a
> > fork-path fallback: a misbehaving select_cpu() leaves no trace in the
> > counters, and schedulers testing SCX_ENQ_CPU_SELECTED run a redundant
> > select_cpu_dfl() on tasks select_cpu() already placed.
> >
> > Set ENQUEUE_RQ_SELECTED on the initial enqueue when select_task_rq() was
> > called, matching the wakeup path. Only sched_ext consumes the flag.
> >
> > Fixes: 9b671793c7d9 ("sched_ext, scx_qmap: Add and use SCX_ENQ_CPU_SELECTED")
> > Signed-off-by: Tao Cui <cuitao@kylinos.cn>
> 
> Acked-by: Tejun Heo <tj@kernel.org>
> 
> Peter, how do you want to route this? I can take it through sched_ext too
> given that the flag is only consumed by sched_ext.

Yeah, take it through sched_ext; I don't think I've got any conflicts
around there.

Thanks!
