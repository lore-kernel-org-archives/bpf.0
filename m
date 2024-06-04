Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6784266A7;
	Tue,  4 Jun 2024 18:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717527465; cv=none; b=DW+r+/MM5kIZ5OZLn2CsHODUEtqyqVqbAq7B17thCMJxJwPjk+5akqQLWjP5/WNuNUa78UCN+/Uue8CoIPmUErTUKD88Aop+do1Vp09qZSeWKO4Jp4cyACnXV1r03Vku1eY9P5S9H4w9fq2++mLd/g0LCm755DQ1kHbpTMHoCvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717527465; c=relaxed/simple;
	bh=0NuMZA+WVFtyutWRLVlJhs7dCTyIUhAUZXdDsCOc6Tk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MFlEX1RZvRk4Vc9pXsEp738gJV60D5pAm8OvTShTq9xEmFi1BbgQ85NB6+PEFVEAh7r84cgGG34laPMOL/fEjeGZ/a/Zeqrd4dLPzujNPi+8YqzeBHp8selh+veDrFb+gosIHxXwdKmhW2qVJrag9bH+kGKiPm9MPQDA/KrgPF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DF52C2BBFC;
	Tue,  4 Jun 2024 18:57:43 +0000 (UTC)
Date: Tue, 4 Jun 2024 14:57:42 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Alexei Starovoitov
 <alexei.starovoitov@gmail.com>, Florent Revest <revest@chromium.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, bpf <bpf@vger.kernel.org>, Sven
 Schnelle <svens@linux.ibm.com>, Alexei Starovoitov <ast@kernel.org>, Jiri
 Olsa <jolsa@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Alan Maguire <alan.maguire@oracle.com>,
 Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner
 <tglx@linutronix.de>, Guo Ren <guoren@kernel.org>
Subject: Re: [PATCH v3 00/27] function_graph: Allow multiple users for
 function graph tracing
Message-ID: <20240604145742.5703d074@gandalf.local.home>
In-Reply-To: <Zl9JFnzKGuUM10X2@J2N7QTR9R3>
References: <20240603190704.663840775@goodmis.org>
	<20240604081850.59267aa9@rorschach.local.home>
	<Zl8oWNhkEPleJ3B_@J2N7QTR9R3>
	<20240604123124.456d19cf@gandalf.local.home>
	<Zl9JFnzKGuUM10X2@J2N7QTR9R3>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 4 Jun 2024 18:04:22 +0100
Mark Rutland <mark.rutland@arm.com> wrote:

> > There may have been something arch specific that I'm unaware about. I'll
> > look at that deeper.  
> 
> It looks like e are lines in the trace that it doesn't expect:
> 
> 	+ cat trace
> 	+ grep -v ^#
> 	+ grep 970
> 	+ wc -l
> 	+ count_pid=0
> 	+ cat trace
> 	+ grep -v ^#
> 	+ grep -v 970
> 	+ wc -l
> 	+ count_other=3
> 	+ [ 0 -eq 0 -o 3 -ne 0 ]
> 	+ fail PID filtering not working?
> 
> ... where we expect that count_other to be 0.
> 
> I hacked in a 'cat trace' just before the 'fail' and that shows:
> 
> 	+ cat trace
> 	# tracer: function_graph
> 	#
> 	# CPU  DURATION                  FUNCTION CALLS
> 	# |     |   |                     |   |   |   |
> 	 3) ! 143.685 us  |  kernel_clone();
> 	 3) ! 127.055 us  |  kernel_clone();
> 	 1) ! 127.170 us  |  kernel_clone();
> 	 3) ! 126.840 us  |  kernel_clone();
> 
> I'm not sure if that's legitimate output the test is failing to account
> for or if that indicates a kernel-side issue.

Bah, I just ran the test.d/ftrace/func-filter-pid.tc and it fails too. This
did pass my other tests that do run ftracetests. Hmm, I just ran it on my
test box that does the tests and it passes there. I wonder if there's some
config option that makes it fail :-/

Well, now that I see it fail, I can investigate.

-- Steve
