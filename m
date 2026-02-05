Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D59BE3033EF;
	Thu,  5 Feb 2026 18:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770317619; cv=none; b=CTImTYJrVLfy/+fOc7L8LVdrs3atNPWQHZ5hXjhknCnVdgCU42JCcJqqfyeiuamP8YF1ClstDZKKDjWzD6V6I4aXuojFFtvno0LVZe5HkvlbPBtz67Q4FInHDAEBjqMib5SrPYb9d8OzozwHBKEf2zbVNey846phJ3j6FHn5pmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770317619; c=relaxed/simple;
	bh=edmWN1Nh2COpchA+uRF1aIBilfR+WToPCXAOKu0zIog=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=foexaNgwMvKdZzftIxbtJcIxU/Z4FHzP7pt6PezTFBOkKhKpLyjUiwr6U3QS14/ZGtoTP4dGb+n8W4xJJr/YAn3Hpx7TKk/FrCCdX+U8OpGpE9KMA7G0k+knCvVUOVj2YhidnA6I7qY90ipCvecWhJHepPaiiHWSHiVNz0gVBm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QhkEJv+T; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QhkEJv+T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1152BC4CEF7;
	Thu,  5 Feb 2026 18:53:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770317619;
	bh=edmWN1Nh2COpchA+uRF1aIBilfR+WToPCXAOKu0zIog=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QhkEJv+TjVXn1Pm5yNL9fkiVmdPFmxW3fQRdGgRJq6/nyaxyxzMqWofu1h8GoeauN
	 PyhUSpGcy3tAKIVawRN7WW1e/lfudIpUhaDs0hTROLdYO4qugbMvLy4oAMFyAg4C5d
	 E9Z7IsprF+8905i8sLQ0fEwZYYGFv2uWkuJdEbw5hnxB1BefqZYj+gaDgBTwGIvkuI
	 eVq/9HfypqcYX+GeKbPIPPG0iGTq0McbGi5qWBxbAoGjAlL7dbvM5FHd+dvhMGev+R
	 HA+RZDGHwiEZmn5tTaI2S1w1t3GAtojhlPPJ4z5+6Ek3kqqKb+UNUdxsR3KIVDmZas
	 a3TAG3vt/ByUg==
Date: Thu, 5 Feb 2026 13:54:11 -0500
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
Message-ID: <20260205135411.5fb22df2@gandalf.local.home>
In-Reply-To: <aYTgwoyRl8kxQShT@google.com>
References: <20260127150554.2760964-1-jremus@linux.ibm.com>
	<aYTgwoyRl8kxQShT@google.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 5 Feb 2026 10:26:10 -0800
Namhyung Kim <namhyung@kernel.org> wrote:

> > Namhyung Kim's related perf tools deferred callchain support can be used
> > for testing ("perf record --call-graph fp,defer" and "perf report/script").  
> 
> Is it possible for users to choose the unwinder - frame pointer or
> SFrame at runtime?  I feel like the option should be
> "--call-graph sframe,defer" or just "--call-graph sframe" if it always
> uses deferred unwinding.

Currently no, and I'm not sure we want that do we? The idea is to use the
best option that is available. Why use frame pointers if sframe is
available and it's being called with defer?

If there's no defer, then sframes are not available, so it defaults to the
best option available (which will likely be frame pointers).

-- Steve
