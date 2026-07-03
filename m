Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA51A3BA253;
	Fri,  3 Jul 2026 10:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783076345; cv=none; b=CATzGz5ZHXcJpTA3gKTq2WR7e4FKHuJvoSP3hQLOk484bjMJ20DB0qI/OjXdleOq23yCw+IJowmnmNVWLmEpKae+tRM+OxV4G8eew6NE7x0bU7a4nIyEBVo5+SGG3ZKpB3k6iAZwaidCi3NxJZUcE4XNr2XT8hWr/dRRyic6IH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783076345; c=relaxed/simple;
	bh=HPf57kZWKP5aG+CCEzNG66wp/LBnKqH/SbYsEr+Hiw4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uFuwZz0svjM3jH6vXzcFVS5oARIUTIbJlUynfxBABi4ph8lXgRCkEFPVz4w3lj5Yy5fcV/BHdRsdG5/9Z4WcqW2raq9oMQOuqDMxqo5HxxM8+0qy0k9zT3CxJCB3vgnvFwl/COfkGFeRTCHpLequW5SMfC3faF0fJIBwmA5UdPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=CrVcpKGf; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CrVcpKGf"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=nr5l6b4Yqe+7voRCZfV6ADc4VDQFMFng9cyt4wXHdkM=; b=CrVcpKGfnB1UEqRWyp7DDwepNZ
	lgQrgqo32rjTDVBJqGoqav3GR/r1R0f8MfmR9QzoPFM25/0IZADrhXBe12kdMYqM+nqkcxtgBGX6N
	xRxyalaNqJ3LnFNpDmWj01GpACmeYxFg6FknOTSEzl/ZsLHRbA/cS0Y/uAPtoIkPfJBMQcarDDz7p
	2fNbKHCIlEuNIzlI6ffS8f8hI7C4AoGcFfG2FdlhyHWZXZs+lSW9QKnHbUSp1IONa5VjJ/nZAYCVQ
	Lb2UW0EPtmJymlFPendvBfhn6f2UtEh/GMX8SaxviCbcFG1u6ER4XepMQKdxMTWuwvukQ5uC8CI3G
	sY1DgUMw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wfbbo-0000000AByh-1RBg;
	Fri, 03 Jul 2026 10:59:00 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 94AD930035C; Fri, 03 Jul 2026 12:58:59 +0200 (CEST)
Date: Fri, 3 Jul 2026 12:58:59 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, Oleg Nesterov <oleg@redhat.com>,
	Ingo Molnar <mingo@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCHv5 00/13] uprobes/x86: Fix red zone issue for optimized
 uprobes
Message-ID: <20260703105859.GD651302@noisy.programming.kicks-ass.net>
References: <20260701111337.53943-1-jolsa@kernel.org>
 <CAEf4BzYiPeLTbgeVEDKqU45oHBFJgU6ULgK=3i1J7dbzKS2+yg@mail.gmail.com>
 <akZJZth3-fVUhADl@krava>
 <CAEf4BzaDwwW1ebPO+4r5rhmdyXk+XddWTDBzN4iOaCU8qEPZRw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzaDwwW1ebPO+4r5rhmdyXk+XddWTDBzN4iOaCU8qEPZRw@mail.gmail.com>

On Thu, Jul 02, 2026 at 09:20:25AM -0700, Andrii Nakryiko wrote:

> > I failed to release link in test_uprobe_fork_optimized, fix is below
> > I can send new version or separate fix
> 
> yeah, please fix the test, adjust comments as pointed out by AI and
> send v6. Seems like Peter wants to pick it up through tip, I don't
> mind.

So I should wait for v6, and not munge the below delta in?
