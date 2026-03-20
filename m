Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0F482EB0F;
	Fri, 20 Mar 2026 18:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774032492; cv=none; b=Hr2u6EUnVI2Z/va6KU1+2f6AUL0gAPz3usck9cvNSBM2HSTYSehwhdGnrIzSxE9rElo+oNSfoAmxXjoidx7lCpMi37ECluHMCYiXB3buEJFMvEujEyouQFkwfGtvlQ83o/w4Whrfty4rL9UENC0EbLDvHUQOXwZuZC8nqruiq/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774032492; c=relaxed/simple;
	bh=3SMy+fd824qCIdYNOZDyUPd/fIiFdFpTn33YJCdb6S8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pXEIpuirXbgUVgbsm5m3lGllUKuZBPy/Qooetg2bfI6cwLIpzOljA4Le8gEEKJlkcp8plcNhzH07fcLCfDSliRQTfLZq1womFP8hPm4Y/iRrCRc+iK5vulozEmErra13lCTmRYUgvbyPwgt8+nOW1fymggT/8fR4k6TMXfCiTdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf01.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id 9907F57ABB;
	Fri, 20 Mar 2026 18:48:03 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf01.hostedemail.com (Postfix) with ESMTPA id 436E26000F;
	Fri, 20 Mar 2026 18:48:01 +0000 (UTC)
Date: Fri, 20 Mar 2026 14:48:34 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Breno Leitao <leitao@debian.org>, Alexander Viro
 <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org,
 kernel-team@meta.com, Andrii Nakryiko <andrii@kernel.org>
Subject: Re: [PATCH] coredump: add tracepoint for coredump events
Message-ID: <20260320144834.079ba241@gandalf.local.home>
In-Reply-To: <20260320-erlitt-ergibt-255e86a66414@brauner>
References: <20260320-coredump_tracepoint-v1-1-34864746cbb3@debian.org>
	<20260320-erlitt-ergibt-255e86a66414@brauner>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 436E26000F
X-Rspamd-Server: rspamout06
X-Stat-Signature: chfesqnbaef7w77aa1fe88egwbjht8yc
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/t9oc6TpNdFVdvekaWbovUv14NMCMtHVY=
X-HE-Tag: 1774032481-254845
X-HE-Meta: U2FsdGVkX1+8IihC5ZZ9Zq/l9es3GNTMqK3dZT/nnqqlBcmocXnbF2763wz+IlNHg4ZkAD83A+rrsDbek8xy3pOEJnWyLMSkn/opCHvKTYaiBnbrVJXZEiTpCbhSpv1eUzf/lqkkcsSGnmpomuvMYlbjzx7Anvwohr0um8VidTTfBwjfmPg2Md3lkuP4x//K4WuFMSpuIS4HiyQjkpcvbH8cRicQPMxb5FZmc0ua6S2ZILm1T1+VI7SXb5vnMqOCd6sfk75DUSUCf+KxHD8AiUYnxsHAah/qzIYzzV10bGUXUOU5rNbwG29EvmaImEiS/oI90e3GoO7fWo/nMeS0Z9Yz5b3BXaMI

On Fri, 20 Mar 2026 14:21:23 +0100
Christian Brauner <brauner@kernel.org> wrote:

> > +TRACE_EVENT(coredump,
> > +
> > +	TP_PROTO(int sig),
> > +
> > +	TP_ARGS(sig),
> > +
> > +	TP_STRUCT__entry(
> > +		__field(int, sig)
> > +		__array(char, comm, TASK_COMM_LEN)
> > +		__field(pid_t, pid)
> > +	),
> > +
> > +	TP_fast_assign(
> > +		__entry->sig = sig;
> > +		memcpy(__entry->comm, current->comm, TASK_COMM_LEN);
> > +		__entry->pid = current->pid;  
> 
> That's the TID as seen in the global pid namespace.
> I assume this is what you want but worth noting.

Not to mention the pid is saved in all trace events and is available for
perf and bpf too. Even the change log showed it:

             sleep-634     [036] .....   145.222206: coredump: sig=11 comm=sleep pid=634

                   ^^^                                                               ^^^

So it should not be included. It's duplicate and only wastes space. Now if
you wanted to save the name space pid, that may be useful.

-- Steve
