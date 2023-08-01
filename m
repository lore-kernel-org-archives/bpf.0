Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FACA7E
	for <bpf@vger.kernel.org>; Tue,  1 Aug 2023 01:15:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7079AC433C7;
	Tue,  1 Aug 2023 01:15:29 +0000 (UTC)
Date: Mon, 31 Jul 2023 21:15:27 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
 linux-trace-kernel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, bpf <bpf@vger.kernel.org>, Sven
 Schnelle <svens@linux.ibm.com>, Alexei Starovoitov <ast@kernel.org>, Linus
 Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v4 3/9] bpf/btf: Add a function to search a member of a
 struct/union
Message-ID: <20230731211527.3bde484d@gandalf.local.home>
In-Reply-To: <CAADnVQ+C64_C1w1kqScZ6C5tr6_juaWFaQdAp9Mt3uzaQp2KOw@mail.gmail.com>
References: <169078860386.173706.3091034523220945605.stgit@devnote2>
	<169078863449.173706.2322042687021909241.stgit@devnote2>
	<CAADnVQ+C64_C1w1kqScZ6C5tr6_juaWFaQdAp9Mt3uzaQp2KOw@mail.gmail.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 31 Jul 2023 14:59:47 -0700
Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:

> Assuming that is addressed. How do we merge the series?
> The first 3 patches have serious conflicts with bpf trees.
> 
> Maybe send the first 3 with extra selftest for above recursion
> targeting bpf-next then we can have a merge commit that Steven can pull
> into tracing?

Would it be possible to do this by basing it off of one of Linus's tags,
and doing the merge and conflict resolution in your tree before it gets to
Linus?

That way we can pull in that clean branch without having to pull in
anything else from BPF. I believe Linus prefers this over having tracing
having extra changes from BPF that are not yet in his tree. We only need
these particular changes, we shouldn't be pulling in anything specific for
BPF, as I believe that will cause issues on Linus's side.

-- Steve


> 
> Or if we can have acks for patches 4-9 we can pull the whole set into bpf-next.
