Received: from mta0.migadu.com (out-29.mta0.migadu.com [91.218.175.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A906F379C34
	for <bpf@vger.kernel.org>; Thu, 20 Aug 2026 16:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787242762; cv=none; b=YbLOX/OS22aOU/aBGgPG8bXBsbBNnaAaXdAk+gv8Yju3gx0KqKQTKTYQtKdzrYD/LPS05HdnLhncQ9pVXPLnLlgBDwwKAuFNjkxZz2DFbXcduv3eftunLGr+gZQQIkvv5fW8QkrH3rBJkSijt/421FAzQ5eDBTlfcQYhrR08KiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787242762; c=relaxed/simple;
	bh=Ta87nboAeEmGET4Gro48v5LHulO2aDf6wsPbjIeZYB8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pQNVlpZiXW9llS9z3iPYGcfm5Romb/Ubx1zOb6Q7KbLWE+2Fw9jzMi3JmCkAW1IQTft9lMK3FXiROXpZL4OYSi47o9H3RD24kr4PRFEXqtSirb6urrV+FBdsxs5SO/uh9BucHqKKzLRq9R3cny2GOFZERL++/dS8gRi3zs2/JiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hJ4wKT69; arc=none smtp.client-ip=91.218.175.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hJ4wKT69"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=Ta87nboAeEmGET4Gro48v5LHulO2aDf6wsPbjIeZYB8=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787242758; v=1; x=1787847558;
 b=hJ4wKT69KJRyrm/2B/YhN3cbE0NCSyjRiXwyvJEQrr2YpV5nzxgQ8wGte4XdkrJB4ZDoveNR
 1+vFam3UxlGgTgjLX96HTm3ZvAaXdXP0uMoZSm95Q3MzPgxlc+hJgPuDJqkDQs7HshPY/ieMakI
 QUgUqOBaG0qwoY8IxpkJBoZ4=
X-Envelope-To: bpf@vger.kernel.org
Received: from [172.20.10.7] (117.20.148.45)
	by smtp.migadu.com with ESMTPS id ba81c413798945b9;
	Thu, 20 Aug 2026 16:19:18 +0000
X-Mizu-Trace-ID: ba81c413798945b9
X-Migadu-Flow: FLOW_OUT
Message-ID: <c145f1ec-a4fc-42e4-a267-0667775bf5f8@linux.dev>
Date: Fri, 21 Aug 2026 00:19:08 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf] bpf: Keep progs alive until the trampoline image
 calling them is freed
To: "Florent Revest (Anthropic)" <florent.revest@linux.dev>,
 bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 Jiri Olsa <jolsa@kernel.org>, KP Singh <kpsingh@kernel.org>,
 Emil Tsalapatis <emil@etsalapatis.com>,
 John Fastabend <john.fastabend@gmail.com>,
 "Paul E. McKenney" <paulmck@kernel.org>,
 Jose Fernandez <jose.fernandez@linux.dev>, linux-kernel@vger.kernel.org
References: <20260819122252.1782790-1-florent.revest@linux.dev>
Content-Language: en-US
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <20260819122252.1782790-1-florent.revest@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026/8/19 20:22, Florent Revest (Anthropic) wrote:
> bpf_tramp_image_put() makes sure a trampoline image is not freed while
> a task may still be running in it (call_rcu_tasks() + im->pcref), but
> nothing similar is done for the progs called by that image. Since
> commit e21aa341785c ("bpf: Fix fexit trampoline."), detach patches the
> return path so that a task still in the original function skips the
> fexit progs when it comes back, and counts on the prog's own RCU flavor
> to cover a task that is inside a prog. On that basis the last prog
> reference is dropped right away and the prog is freed after a single
> RCU / RCU tasks trace grace period.
> 
> That leaves out a task in the trampoline glue itself: between two
> progs, or already past the patched jump but not yet in the first fexit
> prog's enter helper. On !PREEMPT kernels this is a few instructions
> that cannot be preempted, so it did not matter. With CONFIG_PREEMPTION
> a task can sit there, in no RCU read section of any flavor and holding
> only im->pcref, for longer than it takes to free the prog it is about
> to call:
> 
>   CPU 0                               CPU 1
>   in image I, orig_call() returned
>   [preempted before lsm.s prog A]
>                                       bpf_tracing_link_release()
>                                        -> bpf_tramp_image_put(I)
>                                       bpf_link_dealloc()
>                                        bpf_prog_put(A), last ref
>                                       tasks trace GP, A's text freed
>   __bpf_prog_enter_sleepable(A)
>   call A->bpf_func
> 
> On x86 this is an int3 in poisoned bpf_prog_pack memory:
> 
>   Oops: int3: 0000 [#1] SMP NOPTI
>   CPU: 18 UID: 0 PID: 94573 Comm: x169 Not tainted 6.18.44 #1 PREEMPT(lazy)
>   RIP: 0010:0xffffffffc0601d8d
>   Call Trace:
>    <TASK>
>    ? bpf_trampoline_6442515411+0x1a4/0x21b
>    bpf_lsm_bprm_committed_creds+0x5/0x10
>    security_bprm_committed_creds+0x5f/0x70
>    begin_new_exec+0x2d6/0x410
>    ...
> 
> We hit this in production on preemptible kernels when progs attached
> through trampolines got detached while their hooks were busy. Adding
> grace periods before the prog free would not help with sleepable progs:
> neither RCU tasks nor RCU tasks trace waits for a task that slept in a
> prog and then got preempted in the gap after it.
> 
> Fix it by having the image take a reference on every prog it calls, in
> bpf_tramp_image_alloc(), and drop them in bpf_tramp_image_free(). A
> detached prog now stays loaded until the old image is gone, which
> reverts a deliberate choice of commit e21aa341785c ("bpf: Fix fexit
> trampoline."). Detached fexit progs still stop being called right away
> since the return path is patched.
> 
> Fixes: e21aa341785c ("bpf: Fix fexit trampoline.")
> Assisted-by: Claude:unspecified
> Signed-off-by: Florent Revest (Anthropic) <florent.revest@linux.dev>

lgtm,

Acked-by: Leon Hwang <leon.hwang@linux.dev>

> [...]

