Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32B7D4534A7
	for <bpf@vger.kernel.org>; Tue, 31 Mar 2026 21:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774992144; cv=none; b=J0TChQCLEdHuGDyzFNfBuWhaBDfx0SpUYNQcqVO98oiqqQX9ecoyqKJESoZeHlf8Iqy8NbNpyDaN/FGkYyS0BaWDXPbkbI9mLPXi85zR9UowUcWvjtbRUmhHheJsLYjXujR4KIpCwaCpnCUou6wNiAXAlIzFZubbg8Sbrh5fGsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774992144; c=relaxed/simple;
	bh=EZ7tPFFANhVnKv4dmklpztXjIblw3xLvgaaNWmfIM8M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Pns6prh37pKk9idztTYbNaRMryKhQKQelYTMJ9fId9F5f06dtwkUpWK94i8LnREhOwuTNZegPqYWx2gdM+6TGj6SCC/6baJX5AMKDhVK1sIsCkcstSehhD3A7liAR7auP2HtSr4wxhvCa6QvrTJPYudkxCFpDPRG5A9aBR8RHik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf01.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id 42F0713AB1A;
	Tue, 31 Mar 2026 21:22:21 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf01.hostedemail.com (Postfix) with ESMTPA id ADCF960010;
	Tue, 31 Mar 2026 21:22:18 +0000 (UTC)
Date: Tue, 31 Mar 2026 17:23:17 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, Sun Jian <sun.jian.kdev@gmail.com>, Puranjay Mohan
 <puranjay@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Martin KaFai Lau <martin.lau@kernel.org>, Eduard Zingerman
 <eddyz87@gmail.com>, "Paul E. McKenney" <paulmck@kernel.org>, kkd@meta.com,
 kernel-team@meta.com
Subject: Re: [PATCH bpf v4 1/1] bpf: Fix grace period wait for tracepoint
 bpf_link
Message-ID: <20260331172317.227da913@gandalf.local.home>
In-Reply-To: <20260331211021.1632902-2-memxor@gmail.com>
References: <20260331211021.1632902-1-memxor@gmail.com>
	<20260331211021.1632902-2-memxor@gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: ry19w97h7z5a5edbhy7wq9b493dzemys
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: ADCF960010
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/C3iChBZNa3LQ+bmHl7Av1HHyge1/G6Zk=
X-HE-Tag: 1774992138-534293
X-HE-Meta: U2FsdGVkX19rXonYyQg8vbYdzdgR9vURdQiObPdLAaPG5TCPe4s5DzhpdF+U4RhwY6FW9jsxDacfvSog0ZUUX4cbN1nz8rGhdWHpXhuwwpFymsAWtKcMOKt1KXB8ILbdNQbvUT9MM2iFQaVHXG5MlXwTEotHvoAaVLAFq7lq3sdJXlIGlQXwbN60NcfRiWj7PVBDoHKETWJFfoMbNyujTVFfXrHWZiPHcnzruHNGdRyHGHJprzUHKwctK7jFMNzKQyazOx2OODDJNNOoUUXCUIKS4NrHOtLQyH8cPwMWHkCKskb95jZdlXe3qPq16b/UmqfgUv1x94q4JzWMLIv8DkCWV2wlMKq6+ztR0mr+M6QVGKNPqOyEgteu+TJtPLg8cA4FgVDN+lCFRoxIBvg3VA==

On Tue, 31 Mar 2026 23:10:20 +0200
Kumar Kartikeya Dwivedi <memxor@gmail.com> wrote:

> diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
> index 22ca1c8b54f3..1d7f29f5e901 100644
> --- a/include/linux/tracepoint.h
> +++ b/include/linux/tracepoint.h
> @@ -122,6 +122,22 @@ static inline bool tracepoint_is_faultable(struct tracepoint *tp)
>  {
>  	return tp->ext && tp->ext->faultable;
>  }
> +/*
> + * Run RCU callback with the appropriate grace period wait for non-faultable
> + * tracepoints, e.g., those used in atomic context.
> + */
> +static inline void call_tracepoint_unregister_atomic(struct rcu_head *rcu, rcu_callback_t func)
> +{
> +	call_srcu(&tracepoint_srcu, rcu, func);
> +}
> +/*
> + * Run RCU callback with the appropriate grace period wait for faultable
> + * tracepoints, e.g., those used in syscall context.
> + */
> +static inline void call_tracepoint_unregister_syscall(struct rcu_head *rcu, rcu_callback_t func)
> +{
> +	call_rcu_tasks_trace(rcu, func);
> +}
>  #else
>  static inline void tracepoint_synchronize_unregister(void)
>  { }
> @@ -129,6 +145,10 @@ static inline bool tracepoint_is_faultable(struct tracepoint *tp)
>  {
>  	return false;
>  }
> +static inline void call_tracepoint_unregister_atomic(struct rcu_head *rcu, rcu_callback_t func)
> +{  }
> +static inline void call_tracepoint_unregister_syscall(struct rcu_head *rcu, rcu_callback_t func)
> +{  }
>  #endif
>  

Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve
