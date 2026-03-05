Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B05329C7F;
	Thu,  5 Mar 2026 20:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772741918; cv=none; b=U9LJ2Zavm1DlTPUFtVn2pRa0veykTUBJ1EgLS3rHSgsoCVZGn8u4xUAZ5WVa+clKeGMLvgHh1WhYUN51d3EO5x0nAp/Hsjq3/ymqjqR/avJfhyhj5eCcL/kseYEGadgN6cuxouxOcrhGvUFOlzyFZpXhq/DVG2mCQmVNbrNesec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772741918; c=relaxed/simple;
	bh=pRMj0I4HTIXwyDqWCrTrse1IQfhg7ecelu35rca7kIs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UvdoFmDqJfhUOX4Nq17XFGwzLwp6bOyvyDAFO+6XxzopXL3LQR9JebA5ty+NTaRP0qzzp+lJAclfvhnAtSY8UIOid21E0UMyaJ4qzEoglbpBKydRljAqfzurjzFu1P3nOEXtKeRsadjG2doK+8ns+1GIEuMOweulV2PXssTnKFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vKLw0hNA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vKLw0hNA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35EDEC116C6;
	Thu,  5 Mar 2026 20:18:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772741918;
	bh=pRMj0I4HTIXwyDqWCrTrse1IQfhg7ecelu35rca7kIs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=vKLw0hNAjuLQhzQvJvvbQW1Q3hpGvnzi2VqbhQm5VxpwHnRbNNyEovCyiH6lGIYns
	 9lA2zlTh1STudb1tZk+p+3ww1iyWqnEu7inxi08wv9ZCkZH9WVTxO3a2GdWJ9/5Lf8
	 tdRimsnbiqMhHQfYS5dotyWv53YHic27f+/57R5gNG0Eygg/LtjXMX/qeym2ksbPPe
	 xeAQZqCN0DDoMi79Mjypd22CojoPU58GbcdwdInB+p0F/Nap70VoFV/kOn512PXpkb
	 6Rutt00qOZLF8CEnCdcyYiAeMKnE4Sgo+heHMHlqFGU5c5rryt139jz4cu4ryHuR1b
	 BQAxripXHeWHw==
Date: Thu, 5 Mar 2026 15:18:32 -0500
From: Steven Rostedt <rostedt@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Jens Remus <jremus@linux.ibm.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org, x86@kernel.org,
 linux-mm@kvack.org, Josh Poimboeuf <jpoimboe@kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Jiri
 Olsa <jolsa@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Thomas
 Gleixner <tglx@linutronix.de>, Andrii Nakryiko <andrii@kernel.org>, Indu
 Bhagat <indu.bhagat@oracle.com>, "Jose E. Marchesi" <jemarch@gnu.org>, Beau
 Belgrave <beaub@linux.microsoft.com>, Linus Torvalds
 <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>,
 Florian Weimer <fweimer@redhat.com>, Kees Cook <kees@kernel.org>, Carlos
 O'Donell <codonell@redhat.com>, Sam James <sam@gentoo.org>, Dylan Hatch
 <dylanbhatch@google.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, David Hildenbrand <david@redhat.com>, "H.
 Peter Anvin" <hpa@zytor.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Michal Hocko
 <mhocko@suse.com>, Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan
 <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>, Heiko Carstens
 <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>
Subject: Re: [PATCH v13 00/18] unwind_deferred: Implement sframe handling
Message-ID: <20260305151832.5f4d2761@gandalf.local.home>
In-Reply-To: <aYvKqse1aXxGqFwR@google.com>
References: <20260127150554.2760964-1-jremus@linux.ibm.com>
	<aYTgwoyRl8kxQShT@google.com>
	<20260205135411.5fb22df2@gandalf.local.home>
	<113e4e4d-8b7a-437d-a3a2-de74acc9ecaa@linux.ibm.com>
	<aYvKqse1aXxGqFwR@google.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 10 Feb 2026 16:17:46 -0800
Namhyung Kim <namhyung@kernel.org> wrote:

> > 
> > Maybe it would make sense not to "overload" the perf record option
> > "--call-graph fp,defer" and use it for all deferred unwinding methods.
> > 
> > What about "--call-graph defer", "--call-graph any,defer", or
> > "--call-graph *,defer"?  
> 
> Sounds better.  But I think it cannot enforce "--call-graph fp,defer" to
> use frame pointers when SFrame is available.. Hmm.

Yeah, let's just call it --defer. The "fp" part isn't really something perf
has control over. It's an implementation detail. Perf should really just
care about getting a stack trace and not how the kernel goes about it.

The only difference is that it needs to know if it is deferred or not, as
perf needs to do things differently when it is.

-- Steve
