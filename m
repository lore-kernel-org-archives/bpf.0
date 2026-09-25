Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E673449B24;
	Fri, 25 Sep 2026 07:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790321363; cv=none; b=nzsWs/bfivOSaGbc7txOA4AXi4nx4SwntACjyiU6PeFlpR6SOVE9OMHWw63N20dNhg2zp/tL65hIBjCgafYm/52EYRD9bpH4pK9tY8zBsMsZ/JKzAoFofE9NIFOdieRUni+p8ju+UHrLEqL4K8h/SLbu/kyCnxG0fdoEd96NvIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790321363; c=relaxed/simple;
	bh=Jy0t0oie/GWyBaf/N3g2nOLwsuUuXeJQOCiKnvp+SD0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dilue/3dh7MZOm62H7Cf908UitY7MHUUpfWIQoJcvnF3clvxeaq/wM1LidQlb3yAA0TD50OObXuxOeaHZgZAUU3ShwZHubQYSKTsO9+78hFjPThaC9ngcntzDTrmiHM2XUjnkkluOzsjSnoBhkIrU5UAzKKRA8yKmhQppR9xl2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TPsZEIc/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TPsZEIc/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30DE71F000FF;
	Fri, 25 Sep 2026 07:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790321362;
	bh=Mfnb3GXAJ6qEATTIM7j+kMnju+C9c/oq/1MBEZFo2sk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=TPsZEIc/WsipxGDE8RhpcTcM1O2qXwgqnk+1A1yxgE0s67tJ2P0+FzqsPD5j/ra8N
	 3IC54JRZw5rnypO/kwU2ObM8PWWqJ7ENRm1hUrNo5hKBX5/nf++KIQPKKmhfUB9vcy
	 VWZy5xWZ8BMPsmBycV8uzg2vT+k4tTAzRjnUmas9eIsRaxdC9ajviKZ3X7nnghOGE1
	 zYJ9D3pUxZPwORZDZOoxo9kJzt6hmhcpxd8fKJCRRsdtjKmeX70z2pdMoXJHcqDEWN
	 QLp7HIA1+Z0ZIQ90pHRtsdxQN37aVNzYYd43+8HqfkVpxsMRrCxKhXysQoJV99TxVI
	 8sjVtYyX7LgXg==
Message-ID: <c2f8eb01-7a10-4ccb-92f1-eece29c06cd4@kernel.org>
Date: Fri, 25 Sep 2026 09:29:16 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] mm: restrict can_spin_trylock() to preemptible
 context on PREEMPT_RT
Content-Language: en-US
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Karl Mehltretter <kmehltretter@gmail.com>
Cc: Harry Yoo <harry@kernel.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Andrew Morton <akpm@linux-foundation.org>, Hao Li <hao.li@linux.dev>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Amery Hung <ameryhung@gmail.com>,
 Swaraj Gaikwad <swarajgaikwad1925@gmail.com>,
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 linux-mm@kvack.org, bpf@vger.kernel.org, linux-rt-devel@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20260919171443.90512-1-kmehltretter@gmail.com>
 <DLJHZEZMLW0F.27OPPS218CX9Q@gmail.com> <arIY0wMQjCCsqidI@gmail.com>
 <DLO3RV3IQUOV.21BNLF4QS9T4W@gmail.com>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Autocrypt: addr=vbabka@kernel.org; keydata=
 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
In-Reply-To: <DLO3RV3IQUOV.21BNLF4QS9T4W@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/25/26 06:12, Alexei Starovoitov wrote:
> On Tue, Sep 22, 2026 at 08:04 AM Karl Mehltretter <kmehltretter@gmail.com> wrote:
>> a) Change MM so _nolock() allocation remains safe and can still succeed
>>    while pi_lock or an rq lock is held. Existing BPF behavior would
>>    remain unchanged. Is this feasible, or would it require substantial
>>    allocator changes?
> 
> I don't think it's feasible. On RT the sheaves lock, n->list_lock and
> zone->lock are all rtmutex based. When trylock succeeded and a waiter
> showed up rt_spin_unlock() has to wake it.
> 
>> b) Restore BPF local storage's dedicated allocator, and document, with
>>    debug checks if possible, that _nolock() must not be used in those
>>    scheduler-lock contexts.
> 
> No. Local storage is not the only one. bpf_arena_alloc_pages(),
> bpf_stream_vprintk(), bpf_task_work_schedule_*() call kmalloc_nolock()
> as well and the same sched_waking prog can call them.
> bpf_mem_alloc was removed from local storage, because it wastes memory
> on preallocation. Same answer for d).
> 
>> c) Have MM detect those contexts and return NULL. This prevents the
>>    deadlock while preserving ordinary raw-lock callers such as arena,
>>    but task-storage creation from scheduler tracepoints then fails
>>    deterministically.
> 
> This one.

Yeah, but how exactly to do that detection :)

> bpf_task_storage_get() with F_CREATE can return NULL and the progs
> have to check for it anyway.

e) Introduce raw_local_trylock_t...

>> Are these the right alternatives? In particular, what behavior is
>> intended from the _nolock() API in these scheduler-lock contexts?
> 
> It can be called from any context and it can return NULL.
> That's what it does from NMI and hardirq on RT already.

