Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89805330650
	for <bpf@vger.kernel.org>; Tue, 28 Jul 2026 15:45:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785253537; cv=none; b=R6zpI+sQ/JvKUS4BPDvvc3EhlFNEJhPtWgk/soNUP2KkgiQxptsYOVS3v9PkE8FPY4t3qS3bWT1fTkxQakqjuO1P2Z0rE64RgWxWA6yWvYHS4s/LlZTl+ymTo3Aaka64gV8GlhfNfwfm2bnaMZYICcBR///6vmKY0MEbV+32GTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785253537; c=relaxed/simple;
	bh=aeevXiBMeC8WIa6hvjYFLMDWc2jl+8t2Ie28BCG/9Zo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UIBCJn2LpQ/zsSIU6T1JrwetmScQ+ASsWzDNwGsOdSu/7c7OylDoMBxJVSaCBlguLZ8mP3jmrEFBZSleDPlSmIlqbxl4kFFkUIrNLYi6lWLcPCCd48ZWUtePmZd0DINRnEcS2J4r9anrUT/B/mcr1a2RQQirzML6RCkH/uWABho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf01.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay08.hostedemail.com (Postfix) with ESMTP id 1869E1403E1;
	Tue, 28 Jul 2026 15:45:33 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf01.hostedemail.com (Postfix) with ESMTPA id 2BA2F60016;
	Tue, 28 Jul 2026 15:45:31 +0000 (UTC)
Date: Tue, 28 Jul 2026 11:46:02 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Leon Hwang <leon.hwang@linux.dev>
Cc: sashiko-reviews@lists.linux.dev, Masami Hiramatsu <mhiramat@kernel.org>,
 bpf@vger.kernel.org
Subject: Re: [PATCH 1/2] arm64: ftrace: enable single ftrace_ops for direct
 calls
Message-ID: <20260728114602.62e8852a@gandalf.local.home>
In-Reply-To: <be7399e2-06ac-4e6f-bea7-8c51738a1e4d@linux.dev>
References: <20260727142844.21212-1-leon.hwang@linux.dev>
	<20260727142844.21212-2-leon.hwang@linux.dev>
	<20260727145217.72B9C1F000E9@smtp.kernel.org>
	<be7399e2-06ac-4e6f-bea7-8c51738a1e4d@linux.dev>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: 2BA2F60016
X-Stat-Signature: 638p81r581sz1155df7rjn8hdf9dcu4s
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+Q+nKj12gojI6uVFWkFSB1lAuQjmhlldM=
X-HE-Tag: 1785253531-255322
X-HE-Meta: U2FsdGVkX18wlo8Eap7yn7Ua9xkLk0ZijGeFSEOH51vwXfJDm/QHZunQlMoVY6pUZ5GPn+utHUcKOnJLUWjYSjo+r8JF1Nr6Ct5gwxg3p6wSx6sl1zLYTp4/Mddftl4G/lc0rKGuuQdQPxQr9oL29HZuehyZZprZXlApEK1Qa1R/iwHtSTtWde0Iw5Jwb9GliHN1cGUdi1TLvBMCHe7GHKNpYF4Ahyff6q+A5n1X1+fzBQAnr/aGSGAZ8Smp1X1r/5GUs/VlvtjileymYkGyYCrmlaJkW/I0L3EhZPzr8iM5T5mk0kdnD9MWGSxFT6fmSYtiED5i/hsK8d7e+hTnvFeUcXJqiGNF

On Tue, 28 Jul 2026 10:19:22 +0800
Leon Hwang <leon.hwang@linux.dev> wrote:

> On 27/7/26 22:52, sashiko-bot@kernel.org wrote:
> > Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> > 
> > Pre-existing issues:
> > - [High] Missing RCU read barrier (`rcu_dereference()`) when accessing `direct_functions`.
> > --
> > 
> > --- Patch [1]: [PATCH 1/2] arm64: ftrace: enable single ftrace_ops for direct calls ---
> > commit 738274783fa707248af104af5e45da296f7e4d84
> > Author: Leon Hwang <leon.hwang@linux.dev>
> > 
> > arm64: ftrace: enable single ftrace_ops for direct calls
> > 
> > The BPF tracing multi link updates several direct-call sites through one
> > ftrace_ops. This commit selects HAVE_SINGLE_FTRACE_DIRECT_OPS on arm64 when
> > DYNAMIC_FTRACE_WITH_DIRECT_CALLS is enabled. It also generalizes the
> > unreachable-trampoline comment.
> >   
> >> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> >> index 39eba438dad43..94fa6e72c2867 100644
> >> --- a/arch/arm64/Kconfig
> >> +++ b/arch/arm64/Kconfig
> >> @@ -188,6 +188,8 @@ config ARM64
> >>  		    CLANG_SUPPORTS_DYNAMIC_FTRACE_WITH_ARGS)
> >>  	select HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS \
> >>  		if DYNAMIC_FTRACE_WITH_ARGS
> >> +	select HAVE_SINGLE_FTRACE_DIRECT_OPS \
> >> +		if DYNAMIC_FTRACE_WITH_DIRECT_CALLS  
> > 
> > [Severity: High]
> > This is a pre-existing issue, but by enabling HAVE_SINGLE_FTRACE_DIRECT_OPS
> > on arm64, does this expose the architecture to a missing RCU read barrier
> > in the ftrace code?
> > 
> > When HAVE_SINGLE_FTRACE_DIRECT_OPS is selected, call_direct_funcs() switches
> > from using READ_ONCE(ops->direct_call) to using ftrace_find_rec_direct():
> > 
> > kernel/trace/ftrace.c:call_direct_funcs() {
> > ...
> > #ifdef CONFIG_HAVE_SINGLE_FTRACE_DIRECT_OPS
> > 	addr = ftrace_find_rec_direct(ip);
> > #else
> > ...
> > }
> > 
> > Looking at ftrace_find_rec_direct(), it accesses the __rcu pointer
> > direct_functions directly without an rcu_dereference():
> > 
> > kernel/trace/ftrace.c:ftrace_find_rec_direct() {
> > 	struct ftrace_func_entry *entry;
> > 
> > 	entry = __ftrace_lookup_ip(direct_functions, ip);
> > ...
> > }
> > 
> > Without the READ_ONCE() provided by rcu_dereference(), the compiler might
> > reload the pointer between computing the hash key and accessing the bucket
> > array inside __ftrace_lookup_ip().
> > 
> > If a concurrent writer substitutes a new hash table with a different size
> > between these reloads, could the computed key exceed the new bucket array
> > bounds and lead to an out-of-bounds dereference?
> >   
> 
> 
> Hi Steve, Masami,
> 
> Could you take a look at this issue? The issue looks legitimate.

Yeah, it's possible (but unlikely) for the compiler to do that. But there's
nothing harming the code to do:

( Untested and not even compiled )

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index f93e34dd2328..5ec494790312 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -2639,7 +2639,8 @@ unsigned long ftrace_find_rec_direct(unsigned long ip)
 {
 	struct ftrace_func_entry *entry;
 
-	entry = __ftrace_lookup_ip(direct_functions, ip);
+	guard(preempt_notrace)();
+	entry = __ftrace_lookup_ip(rcu_dereference_sched(direct_functions), ip);
 	if (!entry)
 		return 0;
 

-- Steve

