Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.92.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794472038;
	b=xzp4NO5wd4ZsYWfUzMcgHN2dae366c/f7GMKsiH5+1w50gdMl9daqC9BnAtk0Xg8CcK+
	 A7+m/tUabvJHqcF1mAZRQlVgZMs3d3N4NhlBe9BmJ3WgzSK6QQI+EBzreXaDc8VzptUqo
	 uHZSl/v5xvNNaWRoW+DmADw4aAPx71DZgiGWeL1Re5KGo07cndHDK7YhU0h+bmH/KY1ph
	 m7dcSPhj/sKHirK6hH4QsQ/28rRxhjlx4c3ycd6iEBxQGU2egHA1spdUeJyrQ8FyFponN
	 qe+qS33tb0+y85KabIPt/1MydpRnCbC00UxKpbvysTae07E4t2cmb28wUpCSX3bgOEA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794472038;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=sMpeZvvFIjF13I11zU+PpvUQU6tPIoWaekL8/3Omix0=;
	b=kWchfkDyyoXg5CD70q6jmbRIZkmN7W0kUYUPAUnEsPbG1+G3RoWz/g51fpQ0aSQlAqw8
	 5wFVOp77ew2gt47P3+vPzAcvdrz0bwqled+w3p07iFohzc0ReRG2X0OV9v+mYOb3lQMVi
	 M6ZnGhk8warGjal2r6rIl1PEn2LFkHc+3eOb6cGpsaXUX9osYv6GoB+f4tHtxXcrpHUc/
	 fyx8TlpEzz6bZ1eOzGEZ0GW0x7WByNPsGMV5M7Sz7qltLHzwUPZ0+8s0/kScF7rC03/BH
	 kYIksV4oPDxnlwtzdbfIVgEkyGP+DKrQYuda7206lkhjiIab9Ab2Kkk8sEIQgVQIZHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=pass smtp.mailfrom=infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=GiiYOOIv;
	arc=none smtp.remote-ip=90.155.92.199
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3944606A31C;
	Thu, 12 Nov 2026 08:27:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D3944606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=GiiYOOIv
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=sMpeZvvFIjF13I11zU+PpvUQU6tPIoWaekL8/3Omix0=; b=GiiYOOIvCr8zIA3QXmJOXc6wQr
	7MTcX5OoqcscNQQIUmvVEdi03Fk+VMqquyrK/X3dnjtDBRoJzIwwFtRKKyIdqUAyDYO//D05eGyzr
	wlp15syJGKZuZxTiYwaccggk/R+jB4YA73RDdetQY83NJBIWL7O3Ys4rsN+aMWNPxZ2dum7xqTXRc
	Uctslm5woKsWfBv/CC1oP6qm6ZP1pOYm3hCn25CovBgK/W03TvHLfPVxY5zXMw7OJQJBdWgDc4qcd
	F4gucRcm3qAWyPJVR+rHeasa5c4puer2vvsWr8ZftV6udaO3USsr6YGh+89ZuWeEgHuubawQJwS3n
	ydaspvYg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRQ9G-0000000A31e-29G6;
	Thu, 12 Nov 2026 08:27:10 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 64C46300400; Thu, 12 Nov 2026 09:27:09 +0100 (CET)
Date: Thu, 12 Nov 2026 09:27:09 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Jiri Olsa <jolsa@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Naveen N Rao <naveen@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Jason Baron <jbaron@akamai.com>, Alice Ryhl <aliceryhl@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ard Biesheuvel <ardb@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Alan Maguire <almagui@kernel.org>,
	x86@kernel.org, linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH 01/13] static_call: Index code text reservation lookups
Message-ID: <20261112082709.GC2668804@noisy.programming.kicks-ass.net>
References: <20261109194916.1089703-1-jolsa@kernel.org>
 <20261109194916.1089703-2-jolsa@kernel.org>
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
In-Reply-To: <20261109194916.1089703-2-jolsa@kernel.org>

On Mon, Nov 09, 2026 at 08:49:04PM +0100, Jiri Olsa wrote:
> Text reservation checks scan every static call site. Build an address-sorted
> index for core text sites and use binary search to find the starting point
> near the requested range.
> 
> Module indexing is intentionally unsupported. Module reservation checks
> continue to use a linear scan, avoiding per-module index allocation and
> teardown complexity.

So this changelog leaves me wondering why, and at what cost. Why do I
want to have this extra array in my kernel and such.
