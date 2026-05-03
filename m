Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55DAE2F6910;
	Sun,  3 May 2026 04:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777783477; cv=none; b=Vyb8KziDNGgNwiiOLqh4lRVzQGEuFCIFe7Y3fu2azIOlMw5g/o4RCWKrm/liPDSLlevahkPyzKToO/6I+9Q+Kqh4WuRtyPfctlxb5EgAnhrhu+GgC2XF4dxUQQBhqz6u0hY10M22jAYyUvI2xfgyGhGI8AFwvI84mU7ADPiqNp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777783477; c=relaxed/simple;
	bh=dKmK/ZfhSBkn8VavIHSvGP3QKvCYu5CkwD7oJuSZFZQ=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=X0BTOU9vArvDq+75IQ2LZ2cKlZYnVCP4zCaQLk58gHjblWnxpEttjbYuonMFp2k+RmDTVc2awQoESlQJOcq8gveilgxj54i7UUl2DjJHNVlwN3OS67SeqWCe95n5vDWBP2V9qWxP3IW5hnpLbpQnaaOQdiP0IXV2ezt5oH6DLZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XUcrUm8C; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XUcrUm8C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 781C8C2BCB4;
	Sun,  3 May 2026 04:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777783477;
	bh=dKmK/ZfhSBkn8VavIHSvGP3QKvCYu5CkwD7oJuSZFZQ=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=XUcrUm8C0yuMK2SPuSVAQXs/ubRzJX6m155v9oA0sluWdtRFPmw+l66xdnLYmG16L
	 xN6+jPe4hQDpSlXt4BEptnHrdWsOlA9MimC2L+czKXbUiNPvkGhBBalvi4G0hOO4Ci
	 Tj+Dm+qnRXA8y7FjErgiSaFsqQ5QwqZ7VppuF2gXMQwcisdcNmFI5Ttz5kFRDauwa5
	 Nf3ZkGTJ0hgMKZE8aTQUIwKkhHyV0Ntn3zoPaiGsmNLP67vII+jJwfKPXvzb4b7gs8
	 z1hAg9z16LMJU+f2OsJyxzE3cBZdrDsvL8LRs27M5FgM+Jwrka6gTn049qNegPLYgb
	 tbp4wp3Vh7qBw==
Content-Type: multipart/mixed; boundary="===============5097665930913841911=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <78ecdb5fbbc2bba3e5d0d001c499c9011ac2e5d7dca29f60b0736c4f70c29d9f@mail.kernel.org>
In-Reply-To: <20260503035220.520479-1-atomlin@atomlin.com>
References: <20260503035220.520479-1-atomlin@atomlin.com>
Subject: Re: [RFC PATCH] bpf: introduce TAINT_UNSAFE_BPF for mutating helpers
From: bot+bpf-ci@kernel.org
To: atomlin@atomlin.com,corbet@lwn.net,song@kernel.org,kpsingh@kernel.org,mattbobrowski@google.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,rostedt@goodmis.org,mhiramat@kernel.org
Cc: skhan@linuxfoundation.org,jolsa@kernel.org,martin.lau@linux.dev,yonghong.song@linux.dev,mathieu.desnoyers@efficios.com,atomlin@atomlin.com,neelx@suse.com,sean@ashe.io,chjohnst@gmail.com,steve@abita.co,mproche@gmail.com,nick.lange@gmail.com,linux-doc@vger.kernel.org,linux-kernel@vger.kernel.org,bpf@vger.kernel.org,linux-trace-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sun,  3 May 2026 04:44:33 +0000 (UTC)

--===============5097665930913841911==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/Documentation/admin-guide/tainted-kernels.rst b/Documentation/admin-guide/tainted-kernels.rst
> index 9ead927a37c0..630f24996e7b 100644
> --- a/Documentation/admin-guide/tainted-kernels.rst
> +++ b/Documentation/admin-guide/tainted-kernels.rst
> @@ -79,30 +79,31 @@ which bits are set::
>  Table for decoding tainted state
>  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> -===  ===  ======  ========================================================
> -Bit  Log  Number  Reason that got the kernel tainted
> -===  ===  ======  ========================================================

[ ... ]

> + 19  _/J   524288  userspace used a mutating debug operation in fwctl
> + 20  _/V  1048576  an unsafe eBPF program (mutating helper) was loaded
> +===  ===  =======  ========================================================

This isn't a bug, but the bottom border has 7 equals signs (=======) for
the Number column while the top and header borders have 6 (======). Will
this cause a Sphinx 'Malformed table' warning when rendering the
documentation?

Earlier in the same file, around line 77, there's a shell command example
for checking taint bits. With the addition of bit 20, shouldn't that
command be updated from 'seq 20' to 'seq 21' so it checks all 21 bits
(0-20)?

The current command only checks bits 0-19:

    $ for i in $(seq 20); do echo $(($i-1)) $(($(cat /proc/sys/kernel/tainted)>>($i-1)&1));done

Since 'seq 20' produces 1..20, and the expression uses $(($i-1)), it only
computes bit positions 0..19, missing the newly added bit 20.

> @@ -189,3 +190,8 @@ More detailed explanation for tainting
>   19) ``J`` if userspace opened /dev/fwctl/* and performed a FWTCL_RPC_DEBUG_WRITE
>       to use the devices debugging features. Device debugging features could
>       cause the device to malfunction in undefined ways.
> +
> + 20) ``V`` if an eBPF program utilising unsafe, mutating helpers (such as
> +     bpf_probe_write_user() or bpf_override_return()) was loaded. These helpers
> +     bypass standard eBPF safety guarantees and can alter execution flow or
> +     corrupt memory.
> diff --git a/include/linux/panic.h b/include/linux/panic.h
> index f1dd417e54b2..8622c02c2c24 100644
> --- a/include/linux/panic.h
> +++ b/include/linux/panic.h
> @@ -88,7 +88,8 @@ static inline void set_arch_panic_timeout(int timeout, int arch_default_timeout)
>  #define TAINT_RANDSTRUCT		17
>  #define TAINT_TEST			18
>  #define TAINT_FWCTL			19
> -#define TAINT_FLAGS_COUNT		20
> +#define TAINT_UNSAFE_BPF		20
> +#define TAINT_FLAGS_COUNT		21
>  #define TAINT_FLAGS_MAX			((1UL << TAINT_FLAGS_COUNT) - 1)
>
>  struct taint_flag {
> diff --git a/kernel/panic.c b/kernel/panic.c
> index 20feada5319d..1ae19bd8fc1d 100644
> --- a/kernel/panic.c
> +++ b/kernel/panic.c
> @@ -825,6 +825,7 @@ const struct taint_flag taint_flags[TAINT_FLAGS_COUNT] = {
>  	TAINT_FLAG(RANDSTRUCT,			'T', ' '),
>  	TAINT_FLAG(TEST,			'N', ' '),
>  	TAINT_FLAG(FWCTL,			'J', ' '),
> +	TAINT_FLAG(UNSAFE_BPF,			'V', ' '),
>  };
>
>  #undef TAINT_FLAG

There's a comment earlier in this file that explicitly states: "if you
modify the taint_flags or TAINT_FLAGS_COUNT, please also modify
tools/debugging/kernel-chktaint and
Documentation/admin-guide/tainted-kernels.rst".

While the Documentation was updated, was tools/debugging/kernel-chktaint
also updated? The script currently processes flags 0-19 and ends with the
J flag check. Without adding a section to check bit 20, the script won't
decode the 'V' character in the taint string output when
TAINT_UNSAFE_BPF is set.

The script would need something like:

    T=`expr $T / 2`
    if [ `expr $T % 2` -eq 0 ]; then
        addout " "
    else
        addout "V"
        echo " * an unsafe eBPF program (mutating helper) was loaded (#20)"
    fi

> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index a822c589c9bd..3f893d9ea764 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -183,6 +183,7 @@ unsigned int trace_call_bpf_faultable(struct trace_event_call *call, void *ctx)
>  #ifdef CONFIG_BPF_KPROBE_OVERRIDE
>  BPF_CALL_2(bpf_override_return, struct pt_regs *, regs, unsigned long, rc)
>  {
> +	add_taint(TAINT_UNSAFE_BPF, LOCKDEP_STILL_OK);
>  	regs_set_return_value(regs, rc);
>  	override_function_with_return(regs);
>  	return 0;

Since bpf_override_return is a helper invoked at runtime and can execute
frequently on hot kprobes, will calling add_taint() here cause severe
cache line bouncing?

Looking at add_taint(), it unconditionally calls set_bit() on the global
tainted_mask.

Also, the commit message and documentation mention the system is tainted
when an unsafe eBPF program 'was loaded'. By applying the taint here
during execution instead of at program load time (e.g., in the verifier),
could this allow an unsafe BPF program to remain dormant and avoid
detection until a specific trigger occurs?

> @@ -372,6 +373,8 @@ BPF_CALL_3(bpf_probe_write_user, void __user *, unsafe_ptr, const void *, src,
>  	if (unlikely(!nmi_uaccess_okay()))
>  		return -EPERM;
>
> +	add_taint(TAINT_UNSAFE_BPF, LOCKDEP_STILL_OK);
> +
>  	return copy_to_user_nofault(unsafe_ptr, src, size);
>  }

Similarly here, will invoking add_taint() on every execution of
bpf_probe_write_user() cause significant performance degradation when
executed concurrently across multiple CPUs?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/25269516443
--===============5097665930913841911==--
