Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DBAA2F7AD2
	for <bpf@vger.kernel.org>; Sun,  3 May 2026 04:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777780810; cv=none; b=Q3P9y4JdiduHoByShnceKZpoNozLlvGjN3JylC0tEZOYbQdhldHndqyM47bPbyY4K+AEcl/aXlGBc79ETM5WDcKqa3GE5Ak5GFCqJvnZmrE++5Gg5tfC9aIFF/m8K7BSffY/mg3BgM1y9rZz0wyogClR1k1BZu2kKtwyOBVuIVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777780810; c=relaxed/simple;
	bh=FFpZ1yT4y9PsCI4Zi+rXNRmo8jy2y28LlfQeCXca5bs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Z4lxIRWyblxN/7eoPpi1gHzestC2zmen1pOlz4GJzh4ke2AlSekmfouBigT3zBRRTUut8/Beqqifw6bT9pZV3nazaMmH+gZQttujXeugoZVbLqSUPWm2mHzL2MbN8fpzglJoewJLbfKYvqtJSK2P2Fg3a1fZTXOp+CLGkym5VjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hawBfIyD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hawBfIyD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97BC3C2BCB4;
	Sun,  3 May 2026 04:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777780809;
	bh=FFpZ1yT4y9PsCI4Zi+rXNRmo8jy2y28LlfQeCXca5bs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=hawBfIyD5BouoKDUgr6QcgQZeOhwJppmBcUh+4nDPevlU4T1q32/YyR3fOK2Mqm57
	 xfmjSCKdiBvmj+XsF0PZFzC5/u19IqpOfrmqWrQsgnU/tBua1+5Wr0mexDRs7wTgCn
	 gXfd6+stkwsWNhBnILEPzaYGWEKbRl2Q2FNZenIfjoUBW15x0jzTmFNogaOkTv5iL6
	 ihWrumullEp+2OVKLs7n2SMKPcfskFaXhRMVsLPByEiTvtCIkqt1xzhcwFBMP9cMZS
	 9zdyyo/LJvl6Yi5ih2h9/TGIkPWji8pgveSmkznczatKnO+FArA3CIx+ro96sBbRUL
	 6xDarzWQDiSng==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH] bpf: introduce TAINT_UNSAFE_BPF for mutating
 helpers
Reply-To: sashiko@lists.linux.dev
To: "Aaron Tomlin" <atomlin@atomlin.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260503035220.520479-1-atomlin@atomlin.com>
References: <20260503035220.520479-1-atomlin@atomlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 03 May 2026 04:00:08 +0000
Message-Id: <20260503040009.97BC3C2BCB4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] add_taint() is called unconditionally in hot eBPF helper execution=
 paths, causing severe cache-line bouncing and a logic mismatch.
- [Low] Malformed simple table syntax in reStructuredText documentation.
--

commit 212777c34ad78febee399b801b573989a50d8cca
Author: Aaron Tomlin <atomlin@atomlin.com>

bpf: introduce TAINT_UNSAFE_BPF for mutating helpers

This commit introduces a new kernel taint flag, TAINT_UNSAFE_BPF ("V"),
which indicates that an eBPF program utilizing unsafe or mutating
helpers has been loaded.

> diff --git a/Documentation/admin-guide/tainted-kernels.rst b/Documentatio=
n/admin-guide/tainted-kernels.rst
> index 9ead927a37c0..630f24996e7b 100644
> --- a/Documentation/admin-guide/tainted-kernels.rst
> +++ b/Documentation/admin-guide/tainted-kernels.rst
> @@ -79,30 +79,31 @@ which bits are set::
>  Table for decoding tainted state
>  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> =20
> -=3D=3D=3D  =3D=3D=3D  =3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> -Bit  Log  Number  Reason that got the kernel tainted
> -=3D=3D=3D  =3D=3D=3D  =3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[ ... ]
> +=3D=3D=3D  =3D=3D=3D   =3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +Bit  Log   Number  Reason that got the kernel tainted
> +=3D=3D=3D  =3D=3D=3D   =3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[ ... ]
> + 19  _/J   524288  userspace used a mutating debug operation in fwctl
> + 20  _/V  1048576  an unsafe eBPF program (mutating helper) was loaded
> +=3D=3D=3D  =3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

This isn't a bug, but the bottom border has 7 characters (=3D=3D=3D=3D=3D=
=3D=3D) for the
Number column while the top and header borders have 6 (=3D=3D=3D=3D=3D=3D).=
 Will this
cause a Sphinx 'Malformed table' warning when rendering the documentation?

> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index af7079aa0f36..4e7e5bf76dcb 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -155,6 +155,7 @@ unsigned int trace_call_bpf(struct trace_event_call *=
call, void *ctx)
>  #ifdef CONFIG_BPF_KPROBE_OVERRIDE
>  BPF_CALL_2(bpf_override_return, struct pt_regs *, regs, unsigned long, r=
c)
>  {
> +	add_taint(TAINT_UNSAFE_BPF, LOCKDEP_STILL_OK);
>  	regs_set_return_value(regs, rc);
>  	override_function_with_return(regs);

Since bpf_override_return is a helper invoked at runtime and can execute
frequently on hot kprobes, will calling add_taint() here cause severe cache
line bouncing?

Looking at add_taint(), it unconditionally calls set_bit() on the global
tainted_mask:

kernel/panic.c:add_taint() {
    ...
    set_bit(flag, &tainted_mask);
    ...
}

Also, the commit message and documentation mention the system is tainted wh=
en
an unsafe eBPF program "was loaded". By applying the taint here during
execution instead of at program load time (e.g., in the verifier), could th=
is
allow an unsafe BPF program to remain dormant and avoid detection until a
specific trigger occurs?

[ ... ]

> @@ -344,6 +345,8 @@ BPF_CALL_3(bpf_probe_write_user, void __user *, unsaf=
e_ptr, const void *, src,
>  	if (unlikely(!nmi_uaccess_okay()))
>  		return -EPERM;
> =20
> +	add_taint(TAINT_UNSAFE_BPF, LOCKDEP_STILL_OK);
> +
>  	return copy_to_user_nofault(unsafe_ptr, src, size);
>  }

Similarly here, will invoking add_taint() on every execution of
bpf_probe_write_user() cause significant performance degradation when
executed concurrently across multiple CPUs?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260503035220.5204=
79-1-atomlin@atomlin.com?part=3D1
