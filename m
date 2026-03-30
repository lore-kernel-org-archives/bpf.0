Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C85F382362
	for <bpf@vger.kernel.org>; Mon, 30 Mar 2026 10:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774864850; cv=none; b=NXj/rpuE97x5Nlu5x8wpfGrMTeMniJObrEWjw0ZjOlsGs6JCRpeJjRQ1FV2me8+2IQxhaoSt9rqIEi2IxiAR8uxM2ErOIcNSxbgecOvUE+7Do4Co942CY8irVNBBzoGrDP80fXMBaKV6h5wTZPayoxNJmr5UxqVxWJXmfXe8Tzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774864850; c=relaxed/simple;
	bh=l4Khes16rRhLcVO7SqgNYlLLWmWqWCMMuQrRt/U/upA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kCFnsBLziVFqHFdF+EaMBouA+aEGFXAb8JSZ6zg5/RMmzvmD07xnZ4ne13oz/zxqfBtfQjSJwiavlgKFFXb2axDZICvCNwTqj+foFWrJNRg9U3onGt6lu1x/WA6ZkIMoYqQn5p080YsvE9/I3sbxli+4kdc6vVwquRbCOuF1Rho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HSp/Ky4i; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HSp/Ky4i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B051C4CEF7;
	Mon, 30 Mar 2026 10:00:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774864849;
	bh=l4Khes16rRhLcVO7SqgNYlLLWmWqWCMMuQrRt/U/upA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=HSp/Ky4iSJdKs2f+9zZURLSS4Nasj4MSm9H9ms2n2uV6CH9DtBwXpVeEayfjikXxy
	 OskRx91BtltcLcax68iOqp78rKDnzwhRf36NYZYiEzUVu5PP4KYzqIhnNOdFonnCh9
	 IavlDSx7Tq0Z/LXEJE0qdM+MSdE2kYNMrf25dQVWXAJelpjyHT1VfLD6cyzkf8Wt9S
	 e91acmXCEd/ePMGcM0fPLyqeOIv6AKUL0GutaWjzm0GICbqd2hwHSY3n+eLNJGUQZJ
	 qu4Taxjh3i/kS0T/uOaDA1LPGooYyZ1336FKVxNr8lnPrzTCrTstUkkde/xFpErxen
	 jqpWm1Atqbhgw==
From: Puranjay Mohan <puranjay@kernel.org>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai
 Lau <martin.lau@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, "Paul
 E. McKenney" <paulmck@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 kkd@meta.com, kernel-team@meta.com
Subject: Re: [PATCH bpf v1 1/2] bpf: Fix grace period wait for tracepoint
 bpf_link
In-Reply-To: <CAP01T77HcqyBKZRzRbLbHuZeskJ7XJ+FU2GQpZX-WXTCPMyikw@mail.gmail.com>
References: <20260330032124.3141001-1-memxor@gmail.com>
 <20260330032124.3141001-2-memxor@gmail.com>
 <CAP01T77HcqyBKZRzRbLbHuZeskJ7XJ+FU2GQpZX-WXTCPMyikw@mail.gmail.com>
Date: Mon, 30 Mar 2026 11:00:45 +0100
Message-ID: <m25x6d1vsi.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Kumar Kartikeya Dwivedi <memxor@gmail.com> writes:

> On Mon, 30 Mar 2026 at 05:21, Kumar Kartikeya Dwivedi <memxor@gmail.com> wrote:
>>
>> Recently, tracepoints were switched from using disabled preemption
>> (which acts as RCU read section) to SRCU-fast when they are not
>> faultable. This means that to do a proper grace period wait for programs
>> running in such tracepoints, we must use SRCU's grace period wait.
>> This is only for non-faultable tracepoints, faultable ones continue
>> using RCU Tasks Trace.
>>
>> However, bpf_link_free() currently does call_rcu() for all cases when
>> the link is non-sleepable (hence, for tracepoints, non-faultable). Fix
>> this by doing a call_srcu() grace period wait.
>>
>> As far RCU Tasks Trace gp -> RCU gp chaining is concerned, it is deemed
>> unnecessary for tracepoint programs. The link and program are either
>> accessed under RCU Tasks Trace protection, or SRCU-fast protection now.
>>
>> The earlier logic of chaining both RCU Tasks Trace and RCU gp waits was
>> to generalize the logic, even if it conceded an extra RCU gp wait,
>> however that is unnecessary for tracepoints even before this change.
>> In practice no cost was paid since rcu_trace_implies_rcu_gp() was always
>> true.
>>
>> Hence we need not chain any SRCU gp waits after RCU Tasks Trace.
>
> ... or chaining RCP gp after SRCU gp, rather, the commit log should
> probably say that instead. The above might be confusing.
> But more eyes on this would be great, I went back and read a few
> discussions on why we were chaining RCU gp after RCU-tt gp and
> couldn't convince myself it was necessary for the tracepoint path.

Yeah the commit message is a bit hard to follow, let me try to lay out
why chaining isn't needed for either case, let me know if you agree with
this analysis:

For non-faultable tracepoints (the call_srcu path):

The tracepoint dispatch macro in __DECLARE_TRACE does:

        guard(srcu_fast_notrace)(&tracepoint_srcu);
        __DO_TRACE_CALL(name, args);

which calls into __bpf_trace_##call, which calls bpf_trace_runN, and
that ends up in __bpf_trace_run() where we have:

        struct bpf_prog *prog = link->link.prog;
        ...
        rcu_read_lock_dont_migrate();
        ...
        run_ctx.bpf_cookie = link->cookie;
        bpf_prog_run(prog, args);
        ...
        rcu_read_unlock_migrate();

Both the link dereference (link->link.prog) and the
rcu_read_lock_dont_migrate() happen inside the SRCU-fast read section
from the tracepoint macro. So classic RCU is nested inside SRCU-fast
here. When the SRCU grace period completes, all in-flight SRCU-fast
readers have finished, which means all their nested classic RCU read
sections have also finished. No need to chain a classic RCU GP after
the SRCU GP.

For faultable tracepoints (the call_rcu_tasks_trace path):

__DECLARE_TRACE_SYSCALL uses guard(rcu_tasks_trace)() instead of
SRCU-fast, so SRCU isn't involved at all on this path. The link and
program are accessed exclusively under RCU Tasks Trace protection.
A tasks trace GP is sufficient on its own, and since tasks trace GP
implies classic RCU GP, there's nothing to chain.

So in both cases, the outermost protection (SRCU-fast or tasks trace)
is what we wait for in bpf_link_free(), and the inner
rcu_read_lock_dont_migrate() in __bpf_trace_run() is subsumed by that
outer GP wait.

Am I missing something?

Thanks,
Puranjay
