Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA37B442B3F
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 09:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790241213; cv=none; b=Kj6tReJjWI2Ui3kVmUmP4FZ+r6ubBes+1B2t6DnMuxep/w+aH8IesOXj/eQMnIGwZrMlbMCgi8v39jtYsOQpKMtJFVy0BrPljmsZGfK4lNWIfPKxo5BR3gz7gvisYMlu2H6gizG5SoAwkBa4TIdWavpkqQYkdjVen88mKAEkOx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790241213; c=relaxed/simple;
	bh=EuruMAkqzsYPw4yHWWG1d0EbtgWx0OtfM3AnKrza01Q=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=JjIXX0l/yofAibMviRIS82hxY9VL9mZkQgSj1hZYDA5z7Fi/ViiBJGSxDpsou47swXmN58sYpMIh95H6kWwiL0+oZiIscivXBw1hL+X6ThLlMGgc0lV4+eShExOd8s2i2OVPrJW1AUytWH6wDCfWteP7wInrHgmHvKwyigC+2/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wwz7Z1Ri; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wwz7Z1Ri"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3F6B1F000FF;
	Thu, 24 Sep 2026 09:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790241211;
	bh=eEYAO/oHUxXw6t2240zzoZkU+i1Mz6RoyP/e+56UrZw=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=Wwz7Z1RigAojg2KgXDdwjQSsJNy/8Ug19+eNkBAoE3bBk8TvEhNlCEEKNLL+IAK40
	 wz2WvOIQBQ75wOEor2iloOwh2X/PBijZGzFbzgqMC+55MrOfBKwHwSXfyUqgsMgVjY
	 8fKH9qsgu9CW5cR8Qv4rkpfxmn3gu7eNhNGXdjlrMKo2QhPTOMHiB3S2FDymMP7NrR
	 +Yspcc+fIAGaIByGHAEHQZE9n2gVyZORQN7l986dtW5VktO33uIspCp8Ntl5BbYIv3
	 V78SIilayhv6oJvZvhwnnTITL/8dPGFIdWxEmNflH3M4QrW/mSj9UJwi1NrPm900aS
	 uqgbyL8tcugfg==
Content-Type: multipart/mixed; boundary="===============5325565195457656736=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <61fbaeed4b3968122da9da2b7ac83e193a0058de88466d6f79fe0a446853d500@mail.kernel.org>
In-Reply-To: <20260924082607.2695649-17-memxor@gmail.com>
References: <20260924082607.2695649-17-memxor@gmail.com>
Subject: Re: [PATCH bpf-next v2 16/18] bpf, x86: Allow programs 2 KiB of stack
From: bot+bpf-ci@kernel.org
To: memxor@gmail.com,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,emil@etsalapatis.com,tj@kernel.org,kkd@meta.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Thu, 24 Sep 2026 09:13:29 +0000 (UTC)

--===============5325565195457656736==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/Documentation/bpf/bpf_design_QA.rst b/Documentation/bpf/bpf_design_QA.rst
> index eb19c945f4d5..be5fc4ac00d6 100644
> --- a/Documentation/bpf/bpf_design_QA.rst
> +++ b/Documentation/bpf/bpf_design_QA.rst

[ ... ]

> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index 9fbef7504e51..e2e531dd1e0b 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -4520,6 +4520,18 @@ bool bpf_jit_supports_subprog_tailcalls(void)
>  	return true;
>  }
>
> +/*
> + * Frame sizes are 32-bit immediates in the prologue, epilogue and tail call
> + * sequences, a tail call pops the caller's frame and lands in the target's
> + * prologue before the target allocates its own, and private stacks are
> + * allocated from the program's own depth, so MAX_BPF_STACK_JIT frames need
> + * nothing special.
> + */
> +bool bpf_jit_supports_large_stack(void)
> +{
> +	return true;
> +}
> +

Can a sched_cls or lwt_xmit program overflow the kernel stack through
bpf_clone_redirect() recursion?

A TC egress program on device X that calls bpf_clone_redirect(skb,
X_ifindex, 0) redirects the packet back to itself. The redirect happens
while the calling program's frame is on the stack:

  bpf_clone_redirect()
    __bpf_redirect()
      __bpf_redirect_common()
        __bpf_tx_skb()
          dev_queue_xmit()
            __dev_queue_xmit()
              sch_handle_egress()
                tcx_run()
                  bpf_prog_run() -> (same or another tc egress program)

The guard in __bpf_tx_skb() (net/core/filter.c) only fails when the
counter exceeds XMIT_RECURSION_LIMIT (8):

  if (dev_xmit_recursion()) {
      net_crit_ratelimited("bpf: recursion limit reached on datapath, buggy bpf program?\n");
      kfree_skb(skb);
      return -ENETDOWN;
  }

So dev_xmit_recursion() allows values 0 through 8 before it fails, which
means the program runs at nesting levels 0 through 9. That puts ten of
its frames on the stack at once.

sched_cls programs never get a private stack:

  kernel/bpf/verifier.c:bpf_enable_priv_stack() returns NO_PRIV_STACK
  for them

so their frames live on the task or IRQ stack. On x86-64 without KASAN
that stack is 16 KiB (THREAD_SIZE_ORDER = IRQ_STACK_ORDER = 2).

With this patch, a single 2048-byte frame is accepted. The BPF frames
alone then take 10 x 2048 = 20 KiB, before any kernel frames in each
round. That exceeds 16 KiB, so the stack overflows.

Before this patch the same program was capped at 10 x 512 = 5 KiB of BPF
frames, which fit. The recursion limit was meant to stop a buggy program
from crashing the kernel.

The commit message says nested programs "are not accounted against each
other before or after this change; each level of nesting may now add up
to 1.5 KiB more." It does not bound how many levels there can be. Here
the kernel allows up to 10, which adds about 15 KiB compared to before.

The same construction works through lwt_xmit programs, which also get
bpf_clone_redirect(). Triggering the overflow needs CAP_BPF and
CAP_NET_ADMIN to attach.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/35976322553
--===============5325565195457656736==--
