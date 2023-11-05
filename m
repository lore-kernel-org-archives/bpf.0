Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E44E8EAE7;
	Sun,  5 Nov 2023 21:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59BD7C433C7;
	Sun,  5 Nov 2023 21:28:57 +0000 (UTC)
Date: Sun, 5 Nov 2023 16:28:50 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Alexei Starovoitov
 <alexei.starovoitov@gmail.com>, Florent Revest <revest@chromium.org>,
 linux-trace-kernel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, bpf <bpf@vger.kernel.org>, Sven
 Schnelle <svens@linux.ibm.com>, Alexei Starovoitov <ast@kernel.org>, Jiri
 Olsa <jolsa@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Alan Maguire <alan.maguire@oracle.com>,
 Mark Rutland <mark.rutland@arm.com>, Thomas Gleixner <tglx@linutronix.de>,
 Guo Ren <guoren@kernel.org>
Subject: Re: [RFC PATCH 24/32] x86/ftrace: Enable HAVE_FUNCTION_GRAPH_FREGS
Message-ID: <20231105162850.4fb804a4@rorschach.local.home>
In-Reply-To: <20231105141130.6ef7d8bd@rorschach.local.home>
References: <169920038849.482486.15796387219966662967.stgit@devnote2>
	<169920068069.482486.6540417903833579700.stgit@devnote2>
	<20231105172536.GA7124@noisy.programming.kicks-ass.net>
	<20231105141130.6ef7d8bd@rorschach.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 5 Nov 2023 14:11:30 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> You even Acked the patch:

More specifically, you acked the series and stressed the ftrace_regs
wrapper part when doing so:

  https://lore.kernel.org/all/20201113080733.GZ2628@hirez.programming.kicks-ass.net/

> On Thu, Nov 12, 2020 at 09:01:42PM -0500, Steven Rostedt wrote:
> > Steven Rostedt (VMware) (3):
> >       ftrace: Have the callbacks receive a struct ftrace_regs instead of pt_regs
> >       ftrace/x86: Allow for arguments to be passed in to ftrace_regs by default
> >       livepatch: Use the default ftrace_ops instead of REGS when ARGS is available
> 
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

-- Steve
