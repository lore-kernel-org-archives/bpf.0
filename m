Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB6D2C11DF
	for <bpf@vger.kernel.org>; Wed, 15 Apr 2026 19:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776280711; cv=none; b=ZpFbUOa776jdbXUkVeqedkcgHdp75zzy82tH/tqOQl9ke7/KqgZvqvp/COXn9J8qmf5Pg6WKZ1qAarmQfZV9BN65tXf3AP+F9qTVPUqS9OZwhYiHbDZ5Hy24JEg9lGs9+Y+pkXQKPqMfXukj7yDhDy1wgXaLDSEgk/AZZb+IwWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776280711; c=relaxed/simple;
	bh=+VX3ABiykZiwTZsTXbzNW63rp3WUJp+pT8vXDr8C47M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vDDVOdq1+O/0SWFUqQezqxBoWw/Abu82mFXgyeXvQmXrlgS7HdYOVtKG/GFOJSac1TovdkV/G0sxLrBju1C6QLQAfgIiPhGH9Yc4LenlrGzRdLWaWCTJomdnUnPaEObup/yycOvQxLX/i4SGtfZU8wmFESj20Zn1OYo/HL+ap3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=aSxW9qEa; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="aSxW9qEa"
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1wD5kf-001EoH-K7
	for bpf@vger.kernel.org; Wed, 15 Apr 2026 21:18:17 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID;
	bh=Tz66gcL7rAtrZjxGipTgik00gcJfhUMJtuyhDCIFDAw=; b=aSxW9qEa/99pLj7p42Ib9c+TJS
	tQfdldKY+1aLolpshJNKTbuUBDT05tWHOqvDQAutG3pfkNN4sYP7uZ/EcQyTJxY8B29xfI5TeN5Lo
	HhBGEo21txsE/NTbz9D79/7SX2N0iyNTYYDM2SmqQ/GFqqZBNd4BDap1mS8bqxVdAsF+V8/gBOO6I
	avtwbATzWXC51+2PZMIGe/WUq1j2hn2zet7qwojgvrlWHkvI2OrZU/l8VizgaS4ao2DlzwUI8mT7h
	4JHXVggDWjguKKIsdPnhrjpUVskoYWtROinRFqWuQG6TUGzOYDCgZzAtSMJ3Q7jXXYcRxKN7xotrr
	WKfoV/Mg==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1wD5kf-0006P7-9g; Wed, 15 Apr 2026 21:18:17 +0200
Received: by submission02.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1wD5kP-00H78r-8t; Wed, 15 Apr 2026 21:18:01 +0200
Message-ID: <6ee6f51b-6e28-498c-b702-eba6c42767b7@rbox.co>
Date: Wed, 15 Apr 2026 21:18:00 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf v4 5/5] bpf, sockmap: Take state lock for af_unix iter
To: sashiko@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260414-unix-proto-update-null-ptr-deref-v4-5-2af6fe97918e@rbox.co>
 <20260414213057.61CEDC19425@smtp.kernel.org>
Content-Language: pl-PL, en-GB
From: Michal Luczaj <mhal@rbox.co>
In-Reply-To: <20260414213057.61CEDC19425@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/14/26 23:30, sashiko-bot@kernel.org wrote:
>> @@ -3737,6 +3737,7 @@ static int bpf_iter_unix_seq_show(struct seq_file *seq, void *v)
>>  		return 0;
>>  
>>  	lock_sock(sk);
>> +	unix_state_lock(sk);
> 
> [ ... ]
> 
>> @@ -3748,6 +3749,7 @@ static int bpf_iter_unix_seq_show(struct seq_file *seq, void *v)
>>  	prog = bpf_iter_get_info(&meta, false);
>>  	ret = unix_prog_seq_show(prog, &meta, v, uid);
> 
> Does holding a spinlock during bpf program execution introduce
> sleep-in-atomic or lock inversion issues?
> 
> If the bpf iterator program is loaded with BPF_F_SLEEPABLE,
> bpf_iter_run_prog() explicitly calls might_fault(). Calling might_fault()
> while holding a spinlock (which disables preemption) triggers a sleep in
> atomic context bug.

See bpf_iter_link_attach(): BPF_F_SLEEPABLE is only allowed for
resched-able iterators (BPF_ITER_RESCHED). This excludes unix iter.

> Also, could this introduce a lock inversion risk? The bpf programs can
> interact with maps or other sockets, acquiring locks like map->lock or
> bh_lock_sock. Taking unix_state_lock before these locks might create an
> unnatural lock hierarchy, potentially leading to deadlocks if other kernel
> paths acquire these locks in the standard order.

Nothing I can think of. Any specific lock inversion scenario to consider?

> Additionally, does this fully resolve the use-after-free in
> unix_stream_bpf_update_proto()?
> 
> Since unix_stream_bpf_update_proto() is the underlying callback used
> whenever an af_unix socket is inserted into a sockmap, can it be reached
> independently of this iterator?
> 
> For example, could it be reached via the bpf(BPF_MAP_UPDATE_ELEM) syscall,
> or when a bpf program updates the map using a different af_unix socket than
> the one being iterated? In those cases, unix_state_lock(sk) would not be
> held, leaving the use-after-free unresolved.

No, I don't think it can race the bpf() syscall. Both
bpf_iter_unix_seq_show() (see patch 2/5) and sock_map_update_elem_sys()
take the lock_sock. The latter via sock_map_sk_acquire().

Yes, bpf updating sockmap using a different unix sock than the one being
iterated is possible:
a) iter prog accessing another sock (e.g. peer) by pointer chasing. To my
understanding that's something the bpf validator is expected to reject[1].
b) iter prog looking up another sock in a sockmap. That sounds like a
(safe) scenario 2.2.1 described in patch 4/5 commit message.

And yes, as pointed out by Martin[2], there's still the issue of
sock_map_update_elem() missing sock_owned_by_user() check.

[1]:
https://lore.kernel.org/bpf/CAADnVQK_93g_KkNFYXSr8ZvA1fYh4hoFRJCJFPS-zs4ox0HhAA@mail.gmail.com/
[2]:
https://lore.kernel.org/bpf/a2f2c260-38e8-4ba3-8655-cffbee046259@linux.dev/

> Should the lock be acquired directly inside unix_stream_bpf_update_proto()
> instead?

unix_stream_bpf_update_proto() is called in both process (e.g. syscall) and
softirq (e.g. TC prog) contexts. Taking spinlock there would lead to
context violation.

