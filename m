Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F00C6472780;
	Mon, 12 Oct 2026 11:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791805787; cv=none; b=JKihxBwhNVAbYJmhbEga7AehueGjLx/TGOuP8PONchzhkU1wAcrGaV3x9ZH+8XPv1fPT7ZgJNdL11c8UMWSZnTgPkWjxAVp+fWZ+cNr38D30hmJ3DlNTzI9ceLi5U5TBW3cqQsN2U15bOotslbLjo2ogBDpKSCEs/YhVCNQ123U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791805787; c=relaxed/simple;
	bh=UnJeEcukkt3E0pcZqNIuzayutrVBN6kK0wgCwBVpLKA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UxqI+IMte07zbDbeKQ1Rehdv6G46oCFkk/laKc0JB0PyLSEHzsx/IGe6rHnypcwncmxBhbrY8XZFaciJaBsC3AT7scvmYuFwIzVatxKFpL3cd3iAMY+iaxf8Qs2ZfNceganMwmUZsdEup/OmEKxw9N2B2lTppys7uzMdg4VUcv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=bKVHF4/5; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bKVHF4/5"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=cqTMVyMHMbYHsvHq2JJ+pRjJi6N8Ibu/y0j1ZV6Yd4A=; b=bKVHF4/5FmXXx/sv9nmBdAeNWG
	mvTWUM6gSOvavI9MrLDBO2n6OG34juk+vhokQ2BkAQYsAYpR8GHV3mgqY7fw03Dbq9qk4Xk7My9n/
	5VRDUvTKPJKhLr6PBGotrpC+oFYTQWAbb1kgO3p8b7fkZ13egD3d8H6RLRDnnJ9H3dy47LqvwEDu6
	29ZrHohJlAcHPpJQ5t8a5b0ILqxP1t60RzJic5BgS5+UoGhAyDzeqTITmOsaxALMTyYRqRGASQl4d
	Fx4Y8sq3wuJb3sUv6YqefzIcPmLucfcPamcWWAbqlDbv/ALe8Z4if96S5SjSn303bA6t89hPg8Kjz
	jSChzNlw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGEX9-00000004g8d-0hTb;
	Mon, 12 Oct 2026 11:49:35 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 9E20F30063F; Mon, 12 Oct 2026 13:49:34 +0200 (CEST)
Date: Mon, 12 Oct 2026 13:49:34 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Gabriele Monaco <gmonaco@redhat.com>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Nam Cao <namcao@linutronix.de>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Wen Yang <wen.yang@linux.dev>,
	Tobias Schaffner <tobias.schaffner@siemens.com>,
	Viktor Malik <vmalik@redhat.com>
Subject: Re: [PATCH v2 01/15] sched: Add task enqueue/dequeue trace points
Message-ID: <20261012114934.GC2823843@noisy.programming.kicks-ass.net>
References: <20261001152042.124445-1-gmonaco@redhat.com>
 <20261001152042.124445-2-gmonaco@redhat.com>
 <20261001154934.GT88198@noisy.programming.kicks-ass.net>
 <d75888885e2c94c1bc717faa864f609c43db874f.camel@redhat.com>
 <20261002102939.GB2823843@noisy.programming.kicks-ass.net>
 <20261004034515.3592947c@fedora>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261004034515.3592947c@fedora>

On Sun, Oct 04, 2026 at 03:45:15AM -0400, Steven Rostedt wrote:
> On Fri, 2 Oct 2026 12:29:39 +0200
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > ...insert rant on what a piece of shit rst is here...
> 
> Rant from grumpy old guy that doesn't like the new stuff ;-)

Absolutely. But very much also that the new stuff isn't actually making
my life better. While at the same time it *IS* making it worse.

I'm not hating on this just because things change, but because the
change is getting in the way of things.
