Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D3721731E;
	Mon, 25 Mar 2024 02:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711334333; cv=none; b=gzfz+VT92LTFu81gAZxX7xm0UI6C//46nG4PqN0bR8YxiuYi5QsczCnZr1mniWry3xU6x5/lt0jnd7uyZTXbpEiz0t7Sret1qiL9Yji++S1xAV+nNgl4yjFfRBRyNvX9lNjmnIlmuZNep8QOXsFz8D9wo9hMM/xlRu84juMP5bY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711334333; c=relaxed/simple;
	bh=UgCPJWVbknxnbOwMB0GxlItOzfBhhnK7IMc5CyNfZRU=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=oNEYXYJ/ihD1r6+puXsR2gkIrENMj8qfhyJW5195hOqIGopVi/bHJKXnGO2NzMHHu2fHAFqu7mPTD2iOIw10xAzyApyZ69bK8DctYlwmwNdQDFA1WgOypTTreQD5aZWxIlpa+2YKsrIhnt+lI5Eh00yOy1yFV4F8qmJH016mEOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HkixlZ5T; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HkixlZ5T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E468C433F1;
	Mon, 25 Mar 2024 02:38:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711334332;
	bh=UgCPJWVbknxnbOwMB0GxlItOzfBhhnK7IMc5CyNfZRU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HkixlZ5TCqRl3FacN6QiF7oO4ztx+VPMvaUHv4x048gFu8z5e+SrSCQ0ucGx+J8VO
	 g3LLRJg7GMV2jKi6aeoX/H5WDtnRgED+2pSyc1uU9e5/l8c5LHqNWkgM2w0tbymop0
	 0R3eLJJQpgMwkq4R7Ahr4EMJRB5d8297ct+8uoBCmB+ctbsfXp3SdrmnHy+N4B83fr
	 /npTfROdwlDe4jih8OcLx3w4MJJQrVxAdDwKrtKVKi4Zv8Rt6VWa2b14GiMChEgKI/
	 L5nqGinITze0Gl/Wj8pDRZ3lue0V1Fd0NtoLCkMCEaO0cAjdEKL2e9PU04ZiWn9xaE
	 vkMuXyU86n9pA==
Date: Mon, 25 Mar 2024 11:38:48 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, rostedt@goodmis.org,
 bpf@vger.kernel.org, jolsa@kernel.org, "Paul E . McKenney"
 <paulmck@kernel.org>
Subject: Re: [PATCH] ftrace: make extra rcu_is_watching() validation check
 optional
Message-Id: <20240325113848.32a70948d1cdb0fa76225690@kernel.org>
In-Reply-To: <20240322160323.2463329-1-andrii@kernel.org>
References: <20240322160323.2463329-1-andrii@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 22 Mar 2024 09:03:23 -0700
Andrii Nakryiko <andrii@kernel.org> wrote:

> Introduce CONFIG_FTRACE_VALIDATE_RCU_IS_WATCHING config option to
> control whether ftrace low-level code performs additional
> rcu_is_watching()-based validation logic in an attempt to catch noinstr
> violations.
> 
> This check is expected to never be true in practice and would be best
> controlled with extra config to let users decide if they are willing to
> pay the price.

Hmm, for me, it sounds like "WARN_ON(something) never be true in practice
so disable it by default". I think CONFIG_FTRACE_VALIDATE_RCU_IS_WATCHING
is OK, but tht should be set to Y by default. If you have already verified
that your system never make it true and you want to optimize your ftrace
path, you can manually set it to N at your own risk.

> 
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Masami Hiramatsu <mhiramat@kernel.org>
> Cc: Paul E. McKenney <paulmck@kernel.org>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  include/linux/trace_recursion.h |  2 +-
>  kernel/trace/Kconfig            | 13 +++++++++++++
>  2 files changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/trace_recursion.h b/include/linux/trace_recursion.h
> index d48cd92d2364..24ea8ac049b4 100644
> --- a/include/linux/trace_recursion.h
> +++ b/include/linux/trace_recursion.h
> @@ -135,7 +135,7 @@ extern void ftrace_record_recursion(unsigned long ip, unsigned long parent_ip);
>  # define do_ftrace_record_recursion(ip, pip)	do { } while (0)
>  #endif
>  
> -#ifdef CONFIG_ARCH_WANTS_NO_INSTR
> +#ifdef CONFIG_FTRACE_VALIDATE_RCU_IS_WATCHING
>  # define trace_warn_on_no_rcu(ip)					\
>  	({								\
>  		bool __ret = !rcu_is_watching();			\

BTW, maybe we can add "unlikely" in the next "if" line?

> diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
> index 61c541c36596..19bce4e217d6 100644
> --- a/kernel/trace/Kconfig
> +++ b/kernel/trace/Kconfig
> @@ -974,6 +974,19 @@ config FTRACE_RECORD_RECURSION_SIZE
>  	  This file can be reset, but the limit can not change in
>  	  size at runtime.
>  
> +config FTRACE_VALIDATE_RCU_IS_WATCHING
> +	bool "Validate RCU is on during ftrace recursion check"
> +	depends on FUNCTION_TRACER
> +	depends on ARCH_WANTS_NO_INSTR

	default y

> +	help
> +	  All callbacks that attach to the function tracing have some sort
> +	  of protection against recursion. This option performs additional
> +	  checks to make sure RCU is on when ftrace callbacks recurse.
> +
> +	  This will add more overhead to all ftrace-based invocations.

	... invocations, but keep it safe.

> +
> +	  If unsure, say N

	If unsure, say Y

Thank you,

> +
>  config RING_BUFFER_RECORD_RECURSION
>  	bool "Record functions that recurse in the ring buffer"
>  	depends on FTRACE_RECORD_RECURSION
> -- 
> 2.43.0
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
