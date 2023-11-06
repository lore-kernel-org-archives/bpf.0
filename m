Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF64119C;
	Mon,  6 Nov 2023 00:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ouh1MQfQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31413C433C7;
	Mon,  6 Nov 2023 00:38:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699231137;
	bh=sBDk+076fVKXychqjFadk7YAA7DfxlUCMnw+EafM8Xc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Ouh1MQfQTyssXSpmolQ9RLlVODSh05RIUQCcwxNhAwep/MAvyIsmg9rXKWDVIXf9Y
	 NpMnXU18AQrFZIizlEWBlcLVVYj8AzYoXPr5zQcFK63w7MhBfztM+JOml/Litu7Q/u
	 ykF6NMSoLkLhHHNbWOThcnzvuphl/LO51J2PqT8OFbRYZ7kJYuQwu1+yUnGMNDl0jp
	 Ge2pfOAnWojNLmUskxnFNc9+Y0sp8XJacjLM0vzn89DWubbOV4gaM+BvZQTsruSHin
	 54ipzRNGlP6KcaBFKvtlnfTMdywcnUwDdkrDnmpt9SZDgRt3z1UMbUALzcTUNiGTwR
	 o0sVd6VoyBm2A==
Date: Mon, 6 Nov 2023 09:38:50 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Peter Zijlstra <peterz@infradead.org>, "Masami Hiramatsu (Google)"
 <mhiramat@kernel.org>, Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Florent Revest <revest@chromium.org>, linux-trace-kernel@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, bpf <bpf@vger.kernel.org>, Sven Schnelle
 <svens@linux.ibm.com>, Alexei Starovoitov <ast@kernel.org>, Jiri Olsa
 <jolsa@kernel.org>, Arnaldo Carvalho de Melo <acme@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Alan Maguire <alan.maguire@oracle.com>,
 Mark Rutland <mark.rutland@arm.com>, Thomas Gleixner <tglx@linutronix.de>,
 Guo Ren <guoren@kernel.org>
Subject: Re: [RFC PATCH 24/32] x86/ftrace: Enable HAVE_FUNCTION_GRAPH_FREGS
Message-Id: <20231106093850.62702d5bf1779e30cdecf1eb@kernel.org>
In-Reply-To: <20231105183409.424bc368@rorschach.local.home>
References: <169920038849.482486.15796387219966662967.stgit@devnote2>
	<169920068069.482486.6540417903833579700.stgit@devnote2>
	<20231105172536.GA7124@noisy.programming.kicks-ass.net>
	<20231105141130.6ef7d8bd@rorschach.local.home>
	<20231105231734.GE3818@noisy.programming.kicks-ass.net>
	<20231105183301.38be5598@rorschach.local.home>
	<20231105183409.424bc368@rorschach.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 5 Nov 2023 18:34:09 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Sun, 5 Nov 2023 18:33:01 -0500
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > For x86_64, that would be:
> > 
> >   rdi, rsi, rdx, r8, r9, rsp
> 
> I missed rcx.

I would like to add rax to the list so that it can handle the return value too. :)

Thanks,

> 
> -- Steve


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
