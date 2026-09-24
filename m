Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 026614D0A05;
	Thu, 24 Sep 2026 20:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790282728; cv=none; b=SujVNZYfT/m6gCsU4phSZgKun9EnWmi2bk+GHl+EZHrA54U4f1JzTV8T+/8PXfFWvPG/Jd6WuMYrl6rhaMZDmvXzkxBNeOKxmxusFtRRKxgSLyqJxKqHNPyMZOnxH0lgEr6kycxPoVymPwrPy/6nS+BSyioXgpntIBxn6v7mv2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790282728; c=relaxed/simple;
	bh=38fYqY6dAGRKIr9/5pdl5Yw6DqLgAW+T6nJMcP1jCKk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V3fqcot3RS1fs2Op/1JHnJNg08zhk57PINgrxHuPnmIkRKOwY3E6507zZmtkMm7qRMq8OgyiDnXyVu3+4XVewwmJeXbwQbtnNhtUM404v9zRSL7EAmW+60k3EbRekT/krhycw/Bkf/kmXu0xJ6XOXkes014RC3KXoo2F+lQt2lY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=2pwNg6DB; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="2pwNg6DB"
Received: from omf05.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id 0FEBD80417;
	Thu, 24 Sep 2026 20:45:18 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf05.hostedemail.com (Postfix) with ESMTPA id EC9D220010;
	Thu, 24 Sep 2026 20:45:14 +0000 (UTC)
Date: Thu, 24 Sep 2026 16:45:12 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Vineet Gupta <vineet.gupta@linux.dev>
Cc: mhiramat@kernel.org, mark.rutland@arm.com,
 mathieu.desnoyers@efficios.com, andrii@kernel.org, peterz@infradead.org,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH 0/2] tracing: fgraph: cut the cost of the shadow stack
 retry loop
Message-ID: <20260924164512.451a5d97@fedora>
In-Reply-To: <20260922225526.1554758-1-vineet.gupta@linux.dev>
References: <20260922225526.1554758-1-vineet.gupta@linux.dev>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: EC9D220010
X-Stat-Signature: z3dpyr39jfertp6jo1cu5i5gn4i8w35g
X-Rspamd-Server: rspamout03
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19OzpODMiPSvn327AaP8E0RNzT+Ikvn4OY=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=2Be5KpNzTZXgWlIVsbFsXMkY5/cT+uszS93jLVbttxw=; b=2pwNg6DBAIJuFWO+o9oz4nmzunEkt9Q71HxtoxIr5tmRdatq4N1t8Pp83g8njtQVAZy/xNk6ONIE7w/5N5ay3b9MwJvrSxqX9ZDlJxTS5JXUwlLIxiIwjWJJkNn5S3ulMwsZpZLjdUCpyAWS8W7Fzz2S52z9YWpOcZ5+eYDt2R0=
X-HE-Tag: 1790282714-384105
X-HE-Meta: U2FsdGVkX19lZMdW2su9jmPvONBBEJ9KImB270qGajn37ZOKgDzrRGX0Z2G9VfofM5EvanKoDIie9FK3rkJ8RFEpEjpbMCoq41Gl+ryQoKPyt+S7Us4zsRsD/b3kVyWohfkzoFzzJrdPP0o5M6J+Dqhzbpzonk3nnlOQX4msSxRbaMQ7KpODrV+jU7i75iMKGfEXsMLDcK3pjvSOcT9tlyicuNs5AZBj3G9GlNSfc6O3LQV5eleSF2vSfbjB1rrvmHqpN+5rWrMjTxLdUW4TNvJRdzAF52EWkRdxs2zQNxE10YWmM29O3vv3fewTLy+3Z5UHjg0nraPt4Zp/TLremwspSrliXGJN


Just an FYI. My wife flew into Europe today and I'll be touring Europe
with her until Oct 3rd. I may get time to look at patches, but it will
be very limited. And then LPC starts and who knows when I'll get a
chance.

Thus I may not be very responsive for the next couple of weeks.

-- Steve


On Tue, 22 Sep 2026 15:55:24 -0700
Vineet Gupta <vineet.gupta@linux.dev> wrote:

> Turning on function-graph tracing, or attaching a kprobe_multi return
> probe, hands every thread a shadow stack. alloc_retstack_tasklist()
> does that 32 tasks at a time, and since for_each_process_thread() has
> no cursor, every sweep restarts from init_task and re-walks the tasks
> already served. Total work is quadratic O(N^2) on thread count.
> 
> On a 60-core Sapphire Rapids machine with 400000 idle threads the 0 -> 1
> transition takes 227 s, inside a single bpf() syscall for the kprobe_multi
> case. On Meta fleet this showed up as RCU stalls and softlockup panics.
> 
> Patch 1 raises the batch to 1024, dividing the sweeps by 32:
> 227 s -> 7.2 s at 400000 threads. It helps on every preemption model.
> 
> Patch 2 adds a cond_resched() between sweeps. It is supplementary and
> separable: a no-op on current x86 and arm64, but on !CONFIG_PREEMPTION
> builds it takes soft lockups from 3-of-3 runs to 0-of-3. Dropping it
> leaves patch 1 intact.
> 
> Neither changes the O(N^2) shape; a cursor-based walk would, but
> task_struct lifetime makes that considerably more involved.
> 
> Vineet Gupta (2):
>   tracing: fgraph: Raise FTRACE_RETSTACK_ALLOC_SIZE to 1024
>   tracing: fgraph: Add a cond_resched() to the shadow stack retry loop
> 
>  include/linux/ftrace.h | 7 ++++++-
>  kernel/trace/fgraph.c  | 8 ++++++++
>  2 files changed, 14 insertions(+), 1 deletion(-)
> 

