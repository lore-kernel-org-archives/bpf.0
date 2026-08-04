Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C4093CC7CA
	for <bpf@vger.kernel.org>; Tue,  4 Aug 2026 00:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785804393; cv=none; b=YubFxDFTSz/OgCBuYNfklimrp69eT1MqIfEkIIcwN4c+JYs+DTD5XZV4/edPkdxhEGymxHsHiMiYpva73rEO/WrTKToZBGlphTELIBn+iMhh2HNsYuwYyuWZLMQkVX0AqzeSGyh7IpT7Ty2mz9hkgKMw8feo2PKSUViQkixJoMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785804393; c=relaxed/simple;
	bh=RWRHS36KeEJiqRL4YLd6aC3zt8PTtbZvgaYnhwMt+Aw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DiThU2MRUlmW5IB/C7es8ZMu/hFw8sNKwHnO2hQ9WpowLc+1XqNELp+AC3vJou57lWc3mEzTfJynq+OSDOJ0GjlDnbStJPzNr3Sj0pt6pe11T/7Xo5135VNn5bTYczqZ+Uk7t1AnGb397EwbKLIRlJCpiGP8/QepkMdWOmgdu0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MNuxVR8y; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MNuxVR8y"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-81ed073fed0so57892357b3.0
        for <bpf@vger.kernel.org>; Mon, 03 Aug 2026 17:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785804389; x=1786409189; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GmFmZi5ZvMOd2SmMr2nlPruvgr4hUQsK/4HjHeXJySg=;
        b=MNuxVR8yttQHHTktK2nl7Vh3rOCqouLQKCsS06nQ56lRvdB5gc7qW6QdHmrwzwR25v
         zGFesqgvUyN+7ulHGLoGX1Ccubph655o0DEJWMil7AgVf3EymRP4yeJN47YqKW9ZU/qu
         ExP7VnxUNvwlurw9VOoo7Iq+rQTY9mLqaSyP5IHpkNre/PGba6+OdsiBrGZVDndLMxnh
         oKkIxaoiFTzn5WUmcsXz77YomVQhsEgNiNhcPcH8F7/Tgad1/HfyCony5XDlckB0hsL1
         XTHgQ3N1wAlnOulnNZxiWKsYRcC/yB4BrpOwVCXb4g+TdKBRmA4ThuHHJIirZ8Um1PZx
         fDig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785804389; x=1786409189;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GmFmZi5ZvMOd2SmMr2nlPruvgr4hUQsK/4HjHeXJySg=;
        b=oWofpM5G1a/bfJwQipBn/2KsRruQuJdEpSSGdLKU2QB/1FVye7hFc/ORZhj9+DCYie
         SWktP7/jlSZarZlZApQDWp9VWchGqKUYFhiR+sK9mf3ls6GMi9MDWbzI105vbQNmsOZ6
         NdY+AaVRzNEeJIBcJiq8Vu0f/8roFA3WaFrbNfGNPRx+VAmxblWNVaOF8ZaOLh89m3Z0
         L2atTO7pBHL52WD0pxt27Ul6KO0CO1Bb1iN+7d7gD/zCbo2nSRq8I/QYjkztLmMXrdEy
         il244Dy52cqe2+NEPdsGiq5BCOGFOP1D5zeNCP8ohjcLGH0wPkz+MFpm+nUrubCZmrSN
         YVug==
X-Forwarded-Encrypted: i=1; AHgh+RrZ6PqRq3cN48DhRkxPg4tEysm42YeNaFGDsXni+HJjka1NOsGYoheF7ldcDxd+zfMwjQU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNgYmm5ZIH+5pvf0eGwtFrw1H4vuWamkE5kgzbx8nGtiD1ZsTU
	32nlQ8rROy1SeM/T5yo16yo0KYCbd/wzn2vj2ecGzIUFOBqYyLZYuVf9+mAaxiAX
X-Gm-Gg: AR+sD12fHI+dh0MHvQf56d5pV0NPzCxzJNoQ4eEwbcwAHgVv+4xP1g1YprKUnoqo+pm
	+NO7xvskLHoEaPAO7PZiN0UirEnyyIarcaNDs3uWstmNIjJxXn93mvcsolRWN7IliAkyHYmwyCC
	XEzwC/XBm3Rm5y8IRIn6kSZs5Ad2GuRC1X/6E3RkVwjo8pvBky2MSnVQ7qeK5scVOq7UKw9HSSX
	j4AGJj+9jW52UUJP7R8M9GPZiP97VYTQlSwHUWM8Rfn/8jgjCS+jX6bJ1k71GZWDWjAd3UZqWkM
	MZDFYFphYRNuh7xnTKxgAVDGVsCr2wNUZYuvqRtEX4A4BlwuMjmcSjCkEb0G7Aw1po5LBm1NSeW
	nOspqP4f34sManYk4nQFAYh878WA56dpCZx2cFoDmcwhEv9TBeri0buAOdNgxQKUwbcykmYzrHI
	3wT+cAKz3dfJU3IWrPiQpvgmu92+PUBhA4N/Zc1d3cniQI0MB81II1utcD/2S3nrI+LJEGKXRtJ
	+iWvLQpu0+J9mA9mjG46csuDnkEVyUC
X-Received: by 2002:a05:690c:6c06:b0:81f:d3e6:82ea with SMTP id 00721157ae682-81fd49f27dcmr151792717b3.5.1785804388052;
        Mon, 03 Aug 2026 17:46:28 -0700 (PDT)
Received: from zenbox ([2600:1700:18fb:6011:6253:b407:801c:a745])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81fccd799b5sm64078017b3.0.2026.08.03.17.46.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 17:46:27 -0700 (PDT)
Date: Mon, 3 Aug 2026 20:46:26 -0400
From: Justin Suess <utilityemal77@gmail.com>
To: quanyemostima@gmail.com
Cc: Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Song Liu <song@kernel.org>, Jiri Olsa <jolsa@kernel.org>, KP Singh <kpsingh@kernel.org>, 
	Matt Bobrowski <mattbobrowski@google.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Yonghong Song <yonghong.song@linux.dev>, 
	Emil Tsalapatis <emil@etsalapatis.com>, "David S. Miller" <davem@davemloft.net>, 
	NeilBrown <neilb@suse.com>, linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, syzbot+ef8d17bae14efb960935@syzkaller.appspotmail.com
Subject: Re: [PATCH] bpf: disable lockdep while running BPF on lock_release
Message-ID: <anEuaSqiCVsQ6I4P@zenbox>
References: <20260803-fix-lock-tracepoint-bpf-lockdep-v1-1-91fb7afb526a@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260803-fix-lock-tracepoint-bpf-lockdep-v1-1-91fb7afb526a@gmail.com>

On Mon, Aug 03, 2026 at 06:37:45PM +0800, quanyeyang via B4 Relay wrote:
> From: quanyeyang <quanyemostima@gmail.com>
> 
> trace_lock_release() runs before __lock_release(), so the lock is
> still on the held stack when attached BPF programs execute.  If those
> programs take another lock of the same class, lockdep reports a false
> recursive locking warning.
> 
> Mark lock_release with TRACE_EVENT_FL_BPF_NO_LOCKDEP and temporarily
> disable lockdep around bpf_prog_run_array() for that event.
> 
> Fixes: 149212f07856 ("rhashtable: add lockdep tracking to bucket bit-spin-locks.")
> Reported-by: syzbot+ef8d17bae14efb960935@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=ef8d17bae14efb960935
> Assisted-by: Cursor:GPT-5.6 Sol
> Signed-off-by: quanyeyang <quanyemostima@gmail.com>
> ---
> Hi,
> 
> Small RFC to align on the approach before widening scope. This is the
> alternative to the rhashtable per-init-site lock-class patch [1], taking
> the direction NeilBrown floated in that thread [2].
> 
> The problem: trace_lock_release() runs before __lock_release(), so the
> lock is still on lockdep's held stack when an attached BPF program runs.
> If that program takes another lock whose class collides with a held
> lock, lockdep reports a false "possible recursive locking".
> 
> syzbot hits this via pidfs + a BPF hash map, because all rhashtable
> bucket locks share one lock_class:
> 
>   copy_process -> alloc_pid -> pidfs_add_pid   [pidfs bucket bitlock held]
>     lock_release tracepoint
>       trace_call_bpf -> bpf_prog_run_array
>         rhtab_map_delete_elem -> rhashtable_remove_fast -> rht_lock
>           [same "rhashtable_bucket" class -> false recursion]
> 
> Why I pivoted from the per-class rhashtable fix: NeilBrown argued (a)
> sharing one lock_class across instances is common practice (d_lock,
> bd_holder_lock, kobject list_lock), and (b) BPF on lock_release() can
> perturb lockdep for *any* lock the program takes, not only rhashtable
> [2]. Disabling lockdep around the BPF handler addresses that broader
> surface, not just rhashtable.
> 
> On the concern that this hides real lock-order bugs: BPF programs are
> user-supplied, sandboxed code; their internal lock ordering is not part
> of the kernel's lock contract, and lockdep cannot validate it

BPF programs are not sandboxed. If a BPF program is able to break the
kernels locking semantics and trigger a true, non-recoverable deadlock
like this, that's a bug in the kernel.

> meaningfully -- here it only produces a false positive.
>
This doesn't seem like the correct fix. And I'd argue it's a true
positive.

What happens if the cpu gets interrupted while lockdep is disabled?

Then we become blind to any other locking issues happening in whatever
NMI context we got plopped into because we disabled lockdep here.

It seems more prudent to fix this in rhashtable.

Like what 20b6cc34ea74 ("bpf: Avoid hashtab deadlock with map_locked") did
for hashtab and the subsequent move to rqspinlock did. Basically make
the implementation tolerant to temporary recursive deadlocks like this
by detecting it and returning an error.

Which is going to be a bit more of an endevour than is done in this
patch.

Justin
> Scope of this patch (deliberately minimal):
>   - only lock_release is tagged;
>   - only the perf-event attach path (trace_call_bpf) is covered.
> 
> Open questions I'd like to align on before doing more:
>   - lock_acquire can produce a (different, ABBA-shaped) false positive
>     by the same mechanism -- tag it too?
>   - raw_tracepoint attaches go through __bpf_trace_run and are not
>     covered -- extend there too?
>   - flag vs always-off: should trace_call_bpf disable lockdep for all
>     BPF programs? The flag keeps blast radius small, but the rationale
>     applies generally.
> 
> This fixes the reported syzbot path (perf-event attach to lock_release).
> 
> [1]  https://lore.kernel.org/all/20260801-fix-rhashtable-bucket-lockdep-v1-1-15a0f8ae094c@gmail.com/
> [2]  https://lore.kernel.org/r/178572243204.3252194.4367547703856027885@noble.neil.brown.name
> ---
>  include/linux/trace_events.h | 3 +++
>  include/trace/events/lock.h  | 2 ++
>  kernel/trace/bpf_trace.c     | 6 ++++++
>  3 files changed, 11 insertions(+)
> 
> diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
> index 308c76b57d13..6f67b5e9e38d 100644
> --- a/include/linux/trace_events.h
> +++ b/include/linux/trace_events.h
> @@ -330,6 +330,7 @@ enum {
>  	TRACE_EVENT_FL_FPROBE_BIT,
>  	TRACE_EVENT_FL_CUSTOM_BIT,
>  	TRACE_EVENT_FL_TEST_STR_BIT,
> +	TRACE_EVENT_FL_BPF_NO_LOCKDEP_BIT,
>  };
>  
>  /*
> @@ -347,6 +348,7 @@ enum {
>   *                   This is set when the custom event has not been attached
>   *                   to a tracepoint yet, then it is cleared when it is.
>   *  TEST_STR      - The event has a "%s" that points to a string outside the event
> + *  BPF_NO_LOCKDEP - Disable lockdep while running attached BPF programs
>   */
>  enum {
>  	TRACE_EVENT_FL_CAP_ANY		= (1 << TRACE_EVENT_FL_CAP_ANY_BIT),
> @@ -360,6 +362,7 @@ enum {
>  	TRACE_EVENT_FL_FPROBE		= (1 << TRACE_EVENT_FL_FPROBE_BIT),
>  	TRACE_EVENT_FL_CUSTOM		= (1 << TRACE_EVENT_FL_CUSTOM_BIT),
>  	TRACE_EVENT_FL_TEST_STR		= (1 << TRACE_EVENT_FL_TEST_STR_BIT),
> +	TRACE_EVENT_FL_BPF_NO_LOCKDEP	= (1 << TRACE_EVENT_FL_BPF_NO_LOCKDEP_BIT),
>  };
>  
>  #define TRACE_EVENT_FL_UKPROBE (TRACE_EVENT_FL_KPROBE | TRACE_EVENT_FL_UPROBE)
> diff --git a/include/trace/events/lock.h b/include/trace/events/lock.h
> index 1ded869cd619..5ccf5c54e3d2 100644
> --- a/include/trace/events/lock.h
> +++ b/include/trace/events/lock.h
> @@ -72,6 +72,8 @@ DEFINE_EVENT(lock, lock_release,
>  	TP_ARGS(lock, ip)
>  );
>  
> +TRACE_EVENT_FLAGS(lock_release, TRACE_EVENT_FL_BPF_NO_LOCKDEP);
> +
>  #ifdef CONFIG_LOCK_STAT
>  
>  DEFINE_EVENT(lock, lock_contended,
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 75495a5c3507..f2460f3c860e 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -24,6 +24,7 @@
>  #include <linux/key.h>
>  #include <linux/namei.h>
>  #include <linux/file.h>
> +#include <linux/lockdep.h>
>  
>  #include <net/bpf_sk_storage.h>
>  
> @@ -110,6 +111,7 @@ static u64 bpf_uprobe_multi_entry_ip(struct bpf_run_ctx *ctx);
>   */
>  unsigned int trace_call_bpf(struct trace_event_call *call, void *ctx)
>  {
> +	bool no_lockdep = call->flags & TRACE_EVENT_FL_BPF_NO_LOCKDEP;
>  	unsigned int ret;
>  
>  	cant_sleep();
> @@ -144,8 +146,12 @@ unsigned int trace_call_bpf(struct trace_event_call *call, void *ctx)
>  	 * rcu_dereference() which is accepted risk.
>  	 */
>  	rcu_read_lock();
> +	if (no_lockdep)
> +		lockdep_off();
>  	ret = bpf_prog_run_array(rcu_dereference(call->prog_array),
>  				 ctx, bpf_prog_run);
> +	if (no_lockdep)
> +		lockdep_on();
>  	rcu_read_unlock();
>  
>   out:
> 
> ---
> base-commit: 075b74841bd0065a3bda3440873c747938e69b68
> change-id: 20260803-fix-lock-tracepoint-bpf-lockdep-f93e32ea6346
> 
> Best regards,
> --  
> quanyeyang <quanyemostima@gmail.com>
> 
> 
