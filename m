Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FFA51C5D5E;
	Wed, 11 Feb 2026 00:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770769069; cv=none; b=NQ34veoB0g86gC4DSTEDCVXbulbSPdurY756szbhjNgJCTqO0yqrvfEy/Rkgttc6z2ch/3zufaTINl4Qjy9nzzvxIzDRlHU6Dn63hHKezd+6EeSPzR+ofi1WAxSfIyBvg+IoQE7lq5AmKj93IZ5ihMUYKGMucYZzzyGF2Gd+QM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770769069; c=relaxed/simple;
	bh=X/PX6FbL34s4xBDSZ/RSuiPyyQFzkoB8wVlhJlcXfNE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MwdpotgUwQ5agP2sbFNXf3mDLV/5LExJVY5rcg1//OomBZdip2yltr9UKD8nFLOlZMeHVb9Eh4QtMlUjRNJWKExWUrcgZz2/B13/Xn/GDcWNKKJB17sIC0IBXQgUJecC94D9NFcVpicDb//vztuNFF53Ql524YynJBIok99EMow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d3fBm5Gv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d3fBm5Gv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D7E0C116C6;
	Wed, 11 Feb 2026 00:17:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770769069;
	bh=X/PX6FbL34s4xBDSZ/RSuiPyyQFzkoB8wVlhJlcXfNE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d3fBm5GvY71c46Z3yyUGu+knRQsYtlO5acDvD8eb13R8BszofgVIMcbhTiBqShC9j
	 MGZNauvOVF56+3fYEW97TuWq+7OD0vYBzw8f1POL47D7+I2V0YVc5x1d2Vc8UdDxIq
	 tHatD8oxuZOMW5QfnIogRP4pCr7LrJjCX8mimi5Ji3h5y4t5IiEvaAhE+0A7AWl4zq
	 gPPWSULN9qiU0gGtb21aSxTUtSy+/2BYMPSB8AV+P2VH8qNy9DhFUw/v9B/2XBaPY9
	 cr9cVvNq/TqEtAOygG4DS0oTDFY6qUdQbfiMwzLkhTEGk3GXQMae5eh8Uy9n9TGtxB
	 3T+LQYaWYipBw==
Date: Tue, 10 Feb 2026 16:17:46 -0800
From: Namhyung Kim <namhyung@kernel.org>
To: Jens Remus <jremus@linux.ibm.com>
Cc: Steven Rostedt <rostedt@kernel.org>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org,
	x86@kernel.org, linux-mm@kvack.org,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andrii Nakryiko <andrii@kernel.org>,
	Indu Bhagat <indu.bhagat@oracle.com>,
	"Jose E. Marchesi" <jemarch@gnu.org>,
	Beau Belgrave <beaub@linux.microsoft.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Florian Weimer <fweimer@redhat.com>, Kees Cook <kees@kernel.org>,
	Carlos O'Donell <codonell@redhat.com>, Sam James <sam@gentoo.org>,
	Dylan Hatch <dylanbhatch@google.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	David Hildenbrand <david@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Michal Hocko <mhocko@suse.com>, Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>
Subject: Re: [PATCH v13 00/18] unwind_deferred: Implement sframe handling
Message-ID: <aYvKqse1aXxGqFwR@google.com>
References: <20260127150554.2760964-1-jremus@linux.ibm.com>
 <aYTgwoyRl8kxQShT@google.com>
 <20260205135411.5fb22df2@gandalf.local.home>
 <113e4e4d-8b7a-437d-a3a2-de74acc9ecaa@linux.ibm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <113e4e4d-8b7a-437d-a3a2-de74acc9ecaa@linux.ibm.com>

Hello,

On Mon, Feb 09, 2026 at 06:07:59PM +0100, Jens Remus wrote:
> On 2/5/2026 7:54 PM, Steven Rostedt wrote:
> > On Thu, 5 Feb 2026 10:26:10 -0800
> > Namhyung Kim <namhyung@kernel.org> wrote:
> > 
> >>> Namhyung Kim's related perf tools deferred callchain support can be used
> >>> for testing ("perf record --call-graph fp,defer" and "perf report/script").  
> >>
> >> Is it possible for users to choose the unwinder - frame pointer or
> >> SFrame at runtime?  I feel like the option should be
> >> "--call-graph sframe,defer" or just "--call-graph sframe" if it always
> >> uses deferred unwinding.
> > 
> > Currently no, and I'm not sure we want that do we? The idea is to use the
> > best option that is available. Why use frame pointers if sframe is
> > available and it's being called with defer?
> > 
> > If there's no defer, then sframes are not available, so it defaults to the
> > best option available (which will likely be frame pointers).

Users (me, at least) may want to compare stacktraces from FP and SFrame?

> 
> Maybe it would make sense not to "overload" the perf record option
> "--call-graph fp,defer" and use it for all deferred unwinding methods.
> 
> What about "--call-graph defer", "--call-graph any,defer", or
> "--call-graph *,defer"?

Sounds better.  But I think it cannot enforce "--call-graph fp,defer" to
use frame pointers when SFrame is available.. Hmm.

Thanks,
Namhyung

