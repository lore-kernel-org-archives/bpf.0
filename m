Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2ED03947A6;
	Wed,  4 Mar 2026 09:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772614985; cv=none; b=fjMeOUXZ68v+bDwBJzUxajrD+mVSxrPtmto0juNdYH2G9llRN6pdyykN0dTuPvAVdcfQHJzyE1FpcuanJFSNV5ayAq26pEWO/mh1NI37vWokY+NJeJgroU19M9zScLqYC46XhqsuxI+X6+U0yinNmRAjnNyTvGpAoWYi7qXXim4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772614985; c=relaxed/simple;
	bh=yj+jUZNT7cASBsqhvAOM40VL/I4ioUX/XHkRcdszmSI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BslWRyhBfjZG4Lzf9eHDFYBaew+dq31ehzLNwgQzONm41jyp5e+3fQMLczZ8wCCrrIWxKgnSr4jK9g0ttOeal2jVTqgYV+G/09cmJcKTSyNAR3b8cRYAa5CAzoaLHGYBS/F7T0QARC7HJJyLK4GFXN9LGM/UrK4UNelk5DjQgfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=RhrRCtX4; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RhrRCtX4"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=yj+jUZNT7cASBsqhvAOM40VL/I4ioUX/XHkRcdszmSI=; b=RhrRCtX4O9mHG3fMN3lkWlGeF3
	loSEPHAYuUf1zeRGYeYM0kzuQQ6q5vDCtESnNgeDSEVvcLalMsr0kr44vz/SraDKokPNEfS0Rm+mv
	ZxWUEBwQ9ZM9cJ1PY9A6xyAvDARsxMaVAEZiYGwRLAT6csYVcVINmkpWoo6RNx7Ak0UggbN7OcyUe
	AVAhnlL03iIPNHA/4uZ80J8QuM59A/rqsKt08jwe6AFty8zJdymuN4bB+abtOiPjQUCYvUJRRkCvB
	FBWGUJ0CigwMM9bFytYR4btifnrNzhrBNTrEaD2U+X3FZ1o2rHsLzooRGo9KE/0MVzxeCOiVYFaC4
	O3dDqMfw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vxi87-0000000D0xT-1dF9;
	Wed, 04 Mar 2026 09:02:55 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 1E358300B40; Wed, 04 Mar 2026 10:02:49 +0100 (CET)
Date: Wed, 4 Mar 2026 10:02:49 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: mingo@redhat.com, will@kernel.org, boqun@kernel.org, longman@redhat.com,
	rostedt@goodmis.org, mhiramat@kernel.org, mark.rutland@arm.com,
	mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [RFC PATCH 1/2] locking: add mutex_lock_nospin()
Message-ID: <20260304090249.GN606826@noisy.programming.kicks-ass.net>
References: <20260304074650.58165-1-laoar.shao@gmail.com>
 <20260304074650.58165-2-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260304074650.58165-2-laoar.shao@gmail.com>

On Wed, Mar 04, 2026 at 03:46:49PM +0800, Yafang Shao wrote:
> Introduce mutex_lock_nospin(), a helper that disables optimistic spinning
> on the owner for specific heavy locks. This prevents long spinning times
> that can lead to latency spikes for other tasks on the same runqueue.

This makes no sense; spinning stops on need_resched().
