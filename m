Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83D60391E58;
	Thu,  2 Jul 2026 07:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782977428; cv=none; b=L1tFNSM2op4H8MhoQgWKtZtUTHkA9c9TdB7FsB7kqrTtKla+m2EyclaJE6bMUkRoru4wuOzbNA4hgjQHDf8yRm5+OhHMF7IOgVMkPxvXzEbHNGAPJ/lyMiobVD//IV5CD/0DB68L3aQ5JvFORPZkISls03eoi7fs10X2cV++YYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782977428; c=relaxed/simple;
	bh=Ebo1HHx2sjMgTXVERC2o7FHxdG394UaMqGtb9jJ6pnY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k+Gss5miUUa27Zr3hSTKxmhxr307jd35Qg7s184uC/fUJuah6EsoHJPlM3zAVmSSiFdtD/APKvvVhR87H5ATCfuEYB5K8v8+sLL5NQlOvErswPjStF4+7UQ5Wthe1KJiSD3JrlfG56zForYtlPc9odhlyGeEQuR0YIUFKf7KoYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=OH6+V1h/; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OH6+V1h/"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=cqm9I5O4RFSXg7unUN2Zsj9l3ibq5Z8fUHQyhc1fLDg=; b=OH6+V1h/NXlzgHAQxCPnw7na//
	5N8lTSnUA1KmF6eYL36w20/ao80SjDmXlfvKx2B3zovOGPZesBC276c85nD+4lW6MTJdoEOpS2HMI
	lrw8puNjdzPSvzs5/5d3KKLn4MdiyqPIsMDve3vECMPoeUE2PcpLuuIx+XrXz6wVNZ8mxglx99YYC
	kFKlGzF2pNH/4Y9aTU39yxjNT3yjeH6ExKW3bu0b4OKINEQnGf2/hry2KhpAXdxwwWEJvuDDF409q
	QBVmBDZLhP8cgM0+w1eoOde8uhWAWblJROWo5BVCsbV2S48oIUtLzuodunq1dZdq7ThAGSl6tyhvy
	fdzm2h6A==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.99.2 #2 (Red Hat Linux))
	id 1wfBsG-00000003VSK-43nz;
	Thu, 02 Jul 2026 07:30:17 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 3E32530035C; Thu, 02 Jul 2026 09:30:16 +0200 (CEST)
Date: Thu, 2 Jul 2026 09:30:16 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, Ingo Molnar <mingo@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCHv4 00/13] uprobes/x86: Fix red zone issue for optimized
 uprobes
Message-ID: <20260702073016.GJ49529@noisy.programming.kicks-ass.net>
References: <20260526205840.173790-1-jolsa@kernel.org>
 <aiEiP54zktDqAZpG@krava>
 <CAEf4Bzbrd8xs5sSwEPR336=7z2FGcdXVtV-aVZ4W1zSjHkwwcg@mail.gmail.com>
 <CAEf4BzYmgj55UnBX2fRoKwtc-97vc7Sf1opWcAXzSKKLr_Ei6A@mail.gmail.com>
 <20260702072004.GA49951@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260702072004.GA49951@noisy.programming.kicks-ass.net>

On Thu, Jul 02, 2026 at 09:20:04AM +0200, Peter Zijlstra wrote:

> > I'll assume that no one has any objections to route this through
> > bpf-next. We got reviews from Oleg, so that's great. Jiri, seems like
> > you will do small adjustments and send v5, please do, and then unless
> > meanwhile no one raises any issues, this will go through bpf-next.
> > Thanks!
> 
> Is it already applied? If not, I can stick it in tip/perf/core (and the
> first in /urgent).

Oh, I see v5. I'll go grab that then.
