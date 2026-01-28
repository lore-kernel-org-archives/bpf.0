Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0D3736165C;
	Wed, 28 Jan 2026 18:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769625896; cv=none; b=bDQip8W+iOpxd3Ft3paTd82wBC49UQeewsiSmUMZbU2AReKkUUZkc14AoTF2/zRJIV7Rew2fbiF/gp+L7nKrRg4UgZ4TVqmlOyHibVtwzHl20/e9aiNjP91qcFsrq71TDzZsSEtrzIOTk1U3PuyoqQLmH9q73MpHOzUkTymbaAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769625896; c=relaxed/simple;
	bh=eqaASQfjpfdbg1uxFpD+duGx9t5gwXmsUfRZIXypmbs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IYPtnuRJSjK+gee+D+jqfdR2WiyMzJbIB0fb7L7emo8BV6vozzzWZQO3Ucdy4KwRouchB82sfKvxycq3/vEVVSLiVnN9hxaNdp7ki64VnrbEMls8C1dBNnDhaEfNfjFD+CgTERm3tGmHv0uWNp+9TUBSOFartrjLQVS3L3pdDWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=sHuIpmYo; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="sHuIpmYo"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1769625892;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5y1bNb7lvbHRR7VjlpKpzTePa+b4b/b8DdQ3nC5MUWw=;
	b=sHuIpmYo9z7kkzEOrkG4PBrB9WkbJBfSf+hBFKQCQuLy735rFdhvO51Li+mrgo9MVbAjqk
	i5ianWzmsYMp2pgt1T9l33J1YPFHrFj4u8OwxCXJpBMsvs79rinw7lfyXdhUwSh2bOLsuC
	foIY8ZLyRYY1g9vga0xfuVYuzldFT+o=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Michal Hocko <mhocko@suse.com>
Cc: bpf@vger.kernel.org,  Alexei Starovoitov <ast@kernel.org>,  Matt
 Bobrowski <mattbobrowski@google.com>,  Shakeel Butt
 <shakeel.butt@linux.dev>,  JP Kobryn <inwardvessel@gmail.com>,
  linux-kernel@vger.kernel.org,  linux-mm@kvack.org,  Suren Baghdasaryan
 <surenb@google.com>,  Johannes Weiner <hannes@cmpxchg.org>,  Andrew Morton
 <akpm@linux-foundation.org>
Subject: Re: [PATCH bpf-next v3 07/17] mm: introduce BPF OOM struct ops
In-Reply-To: <aXnCLWYbQ8xZ2IyO@tiehlicka> (Michal Hocko's message of "Wed, 28
	Jan 2026 09:00:45 +0100")
References: <20260127024421.494929-1-roman.gushchin@linux.dev>
	<20260127024421.494929-8-roman.gushchin@linux.dev>
	<aXiHok-3SKqLncCf@tiehlicka> <7ia4tsw6hi93.fsf@castle.c.googlers.com>
	<aXnCLWYbQ8xZ2IyO@tiehlicka>
Date: Wed, 28 Jan 2026 10:44:46 -0800
Message-ID: <87ikcl1srl.fsf@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Michal Hocko <mhocko@suse.com> writes:

> On Tue 27-01-26 21:12:56, Roman Gushchin wrote:
>> Michal Hocko <mhocko@suse.com> writes:
>> 
>> > On Mon 26-01-26 18:44:10, Roman Gushchin wrote:
>> >> Introduce a bpf struct ops for implementing custom OOM handling
>> >> policies.
>> >> 
>> >> It's possible to load one bpf_oom_ops for the system and one
>> >> bpf_oom_ops for every memory cgroup. In case of a memcg OOM, the
>> >> cgroup tree is traversed from the OOM'ing memcg up to the root and
>> >> corresponding BPF OOM handlers are executed until some memory is
>> >> freed. If no memory is freed, the kernel OOM killer is invoked.
>> >> 
>> >> The struct ops provides the bpf_handle_out_of_memory() callback,
>> >> which expected to return 1 if it was able to free some memory and 0
>> >> otherwise. If 1 is returned, the kernel also checks the bpf_memory_freed
>> >> field of the oom_control structure, which is expected to be set by
>> >> kfuncs suitable for releasing memory (which will be introduced later
>> >> in the patch series). If both are set, OOM is considered handled,
>> >> otherwise the next OOM handler in the chain is executed: e.g. BPF OOM
>> >> attached to the parent cgroup or the kernel OOM killer.
>> >
>> > I still find this dual reporting a bit confusing. I can see your
>> > intention in having a pre-defined "releasers" of the memory to trust BPF
>> > handlers more but they do have access to oc->bpf_memory_freed so they
>> > can manipulate it. Therefore an additional level of protection is rather
>> > weak.
>> 
>> No, they can't. They have only a read-only access.
>
> Could you explain this a bit more. This must be some BPF magic because
> they are getting a standard pointer to oom_control.

Yes, but bpf programs (unlike kernel modules) are going through the
verifier when being loaded to the kernel. The verifier ensures that
programs are safe: e.g. they can't access memory outside of safe areas,
they can't can infinite loops, dereference a NULL pointer etc.

So even it looks like a normal argument, it's read only. And the program
can't even read the memory outside of the structure itself, e.g. a
program doing something like (oc + 1)->bpf_memory_freed won't be allowed
to load.

>> > It is also not really clear to me how this works while there is OOM
>> > victim on the way out. (i.e. tsk_is_oom_victim() -> abort case). This
>> > will result in no killing therefore no bpf_memory_freed, right? Handler
>> > itself should consider its work done. How exactly is this handled.
>> 
>> It's a good question, I see your point...
>> Basically we want to give a handler an option to exit with "I promise,
>> some memory will be freed soon" without doing anything destructive.
>> But keeping it save at the same time.
>
> Yes, something like OOM_BACKOFF, OOM_PROCESSED, OOM_FAILED.
>
>> I don't have a perfect answer out of my head, maybe some sort of a
>> rate-limiter/counter might work? E.g. a handler can promise this N times
>> before the kernel kicks in? Any ideas?
>
> Counters usually do not work very well for async operations. In this
> case there is oom_repaer and/or task exit to finish the oom operation.
> The former is bound and guaranteed to make a forward progress but there
> is no time frame to assume when that happens as it depends on how many
> tasks might be queued (usually a single one but this is not something to
> rely on because of concurrent ooms in memcgs and also multiple tasks
> could be killed at the same time).
> Another complication is that there are multiple levels of OOM to track
> (global, NUMA, memcg) so any watchdog would have to be aware of that as
> well.

Yeah, it has to be an atomic counter attached to the bpf oom "instance":
a policy attached to a specific cgroup or system-wide.

> I am really wondering whether we really need to be so careful with
> handlers. It is not like you would allow any random oom handler to be
> loaded, right? Would it make sense to start without this protection and
> converge to something as we see how this evolves? Maybe this will raise
> the bar for oom handlers as the price for bugs is going to be really
> high.

Right, bpf programs require CAP_SYSADMIN to be loaded.
I still would prefer to keep it 100% safe, but the more I think about it
the more I agree with you: likely limitations of the protection mechanism will
create more issues than the value of the protection itself.

>> > Also is there any way to handle the oom by increasing the memcg limit?
>> > I do not see a callback for that.
>> 
>> There is no kfunc yet, but it's a good idea (which we accidentally
>> discussed few days ago). I'll implement it.
>
> Cool!

Thank you!
