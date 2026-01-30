Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09D7B280A29;
	Fri, 30 Jan 2026 00:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769733238; cv=none; b=TbLu/xBkIFcyVfwJ8AP107MNQHreopTfxqx3EzUW5MBGFgK2Y0qWcgZTD0KNKjL171tV8aL6ZT8KTg0MLQXK7StnCoUw+EuSChSser1QmdIY/22J/+fZDhefLG3D4cY7UIEBZHpLJ/Wv/VR6R0gRi67KGl08z6HdIllM10oHxq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769733238; c=relaxed/simple;
	bh=d6IMeyNM4unHSukipAFZgIfHBD3mlNa9hzhm/Sgtiz0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Lv6Lj1IhwBsiucqhKPATtt+Ftrm2gc0GGCVdO3HNlvMNVCQdhZAtr08fXVbsURLNWhfHIY3Ll0Cw94Sz7Z4jQDkBddx/TqcgYSvpvd9yavX/XirG9omMFP1qpzMK9gq0eQvktqAyGngwgsAjQk1t0jAoyQUzmHkmvtGRFxgXCww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf09.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id 06F52C17B8;
	Fri, 30 Jan 2026 00:33:48 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf09.hostedemail.com (Postfix) with ESMTPA id DA42720028;
	Fri, 30 Jan 2026 00:33:46 +0000 (UTC)
Date: Thu, 29 Jan 2026 19:33:59 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 bpf@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, Alexei Starovoitov <ast@kernel.org>
Subject: Re: [PATCH v6 0/3] tracing: Guard __DECLARE_TRACE() use of
 __DO_TRACE_CALL() with SRCU-fast
Message-ID: <20260129193359.08230ac0@gandalf.local.home>
In-Reply-To: <581f0711-9115-44e8-a616-06cd13563f8c@paulmck-laptop>
References: <20260126231145.728172709@kernel.org>
	<20260126213922.0a91bfac@robin>
	<581f0711-9115-44e8-a616-06cd13563f8c@paulmck-laptop>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 7kqirdwd8d89xo84hp4c5wzx6wzwro91
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: DA42720028
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+FsuGFyUUlC2dJYOoKWqKPfYMAAxZKTqM=
X-HE-Tag: 1769733226-202996
X-HE-Meta: U2FsdGVkX1/VqSkVw2yT/Pyuj+9KTmxqYLJwn/LMBdsPU+U4+g2+xJ+cdBU0by0A18XTqUjxyiwl1y8rx2b98K8+1HOKhRKtlKX9/N1KuL/Xy3Bit1z8CYSWpzLQslaoE+mgisznbGFE6/VWjuXgIfk3G1nNiuwlvawAdHVeIBIxtw8s7L2ytuuAi7W/YWQJaVngylLuivA41PeU7bN3V95X6zN0OIWPNht1294aEgaRlM4ig+ENiDUC+5oyXy4N+PCU1EfFMYloHBGyLHUmMuAaB618DLQR+q2osf8c07C9hfjRb3PDMyVWkYbDYfhVZdkSUduwAGuAVUWCanEKYwa9ObOPA6xUFNR3CYvuuv9ZxJety0ouSS95OJB6Aade1kUdy6LkXZnrtVNXhv4N6Q==

On Tue, 27 Jan 2026 15:18:05 -0800
"Paul E. McKenney" <paulmck@kernel.org> wrote:

> Ah, I get it.  I think.  NMIs, right?
> 
> In your source tree, line 792 of kernel/rcu/srcutree.c is this line of
> code, correct?
> 
> 	WARN_ON_ONCE((read_flavor != SRCU_READ_FLAVOR_NMI) && in_nmi());
> 
> If so, could you please try this test with the patch shown at the end
> of this email?
> 

> 
> diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> index c469c708fdd6a..66ba6a2f83d3a 100644
> --- a/kernel/rcu/srcutree.c
> +++ b/kernel/rcu/srcutree.c
> @@ -789,7 +789,8 @@ void __srcu_check_read_flavor(struct srcu_struct *ssp, int read_flavor)
>  	struct srcu_data *sdp;
>  
>  	/* NMI-unsafe use in NMI is a bad sign, as is multi-bit read_flavor values. */
> -	WARN_ON_ONCE((read_flavor != SRCU_READ_FLAVOR_NMI) && in_nmi());
> +	WARN_ON_ONCE(read_flavor != SRCU_READ_FLAVOR_NMI &&
> +		     read_flavor != SRCU_READ_FLAVOR_FAST && in_nmi());
>  	WARN_ON_ONCE(read_flavor & (read_flavor - 1));
>  
>  	sdp = raw_cpu_ptr(ssp->sda);

It appears to fix the issue.

Tested-by: Steven Rostedt (Google) <rostedt@goodmis.org>

Care to send a formal patch, and I'll add it before the patch that causes
issues.

Thanks,

-- Steve
