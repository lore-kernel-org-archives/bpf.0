Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B7F424676D
	for <bpf@vger.kernel.org>; Fri,  9 Oct 2026 03:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791515012; cv=none; b=iOUn5I7CyYLLTOZTPXMfZNUsu25hs9GlpHvDpOYNhpZ0RBWNV+d08SrWEbzgZT+tLZV4lR2raabIYga5Emd+ovpXEXdVNLxdKhUZG5cOGRp/FwygxLXlpvMa3t7nUq5skAYMR02iMdiWyxPPveBGTzAo5mYd0ArmOFvTQ3e45eU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791515012; c=relaxed/simple;
	bh=LQsE0qgA8mJ8do1o+uk2Fw/AXz7xSGNHWmAPo+Any2k=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=Xc1CKrqk79M9DvXaKeRVnKUSr7v6TRnFmbd2YDcnJpV0/gmRlXotLT7Nfns+85afADUQOmIJ8qhI+n82UM5sNIJLPd5/6jBqzQd0mDu3DVSPek0/1d7RgB4J7U7Ncl/rVREkPwmFKBTKzWCQAL5RbYFJqWnIzWdk3++MJ5SiOjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gLS3Am4i; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gLS3Am4i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D31B11F000FF;
	Fri,  9 Oct 2026 03:03:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791515011;
	bh=5BsGMJBQvQPLnXSlxYTIB1gL3gYZB10TN7LDP6A1SUA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gLS3Am4icR6J76g1AdZ+ADhxAJ7quPmrLALb15GsrPQIbnTlLYMd2vN0eqTOullbZ
	 yQ0BeqN4uovi9Xr+gD8d1rwO/SU+2DgLJv2Ufzqrqp0gnEn2/0xuphCLEkf1JOLC27
	 0ZZRwJgRTELi0qp4HkhKTnvQgz5Nku73/aSr1669TOzvz0vqgQoVd04863cYrZ0mrT
	 XNvlAYMc4ExwwQMFyEEVUOZ9/3jcH7+ELk1+AvMaQkGLeCswokcuLXIY2vhW/sN70O
	 QiPhU2PlBe7ofJYFL7r8N0BV0UeE5kpoQ4ExOfnHepBV2HuvgDtOTUk1umeCLpbsum
	 kxamTy8pB4ujw==
Message-ID: <sashiko-outbox-164740@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v1 1/3] x86/mm: Resolve BPF exception fixups
 for user address faults under SMAP
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261009024925.3169077-2-memxor@gmail.com>
References: <20261009024925.3169077-1-memxor@gmail.com>
 <20261009024925.3169077-2-memxor@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 03:03:30 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] bpf: PROBE_MEM oops during RCU grace period due to early kallsyms =
removal
--

commit 9e4e375ce4c3205ad3741d292c6701b8a1d5a5c3
Author: Kumar Kartikeya Dwivedi <memxor@gmail.com>

x86/mm: Resolve BPF exception fixups for user address faults under SMAP

This commit allows the x86 page fault handler to resolve BPF PROBE_MEM
exception table entries for user address faults when SMAP is enabled, avoid=
ing
an immediate oops. It paves the way for dropping the JIT-emitted address
range checks.

> diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
> index aa88370ce7394..2060e5f35d77a 100644
> --- a/arch/x86/mm/fault.c
> +++ b/arch/x86/mm/fault.c

[ ... ]

> @@ -1262,6 +1263,16 @@ void do_user_addr_fault(struct pt_regs *regs,
>  	if (unlikely(cpu_feature_enabled(X86_FEATURE_SMAP) &&
>  		     !(error_code & X86_PF_USER) &&
>  		     !(regs->flags & X86_EFLAGS_AC))) {
> +		/*
> +		 * JITed BPF programs dereference untrusted pointers with loads
> +		 * that carry an exception table entry (PROBE_MEM). SMAP makes
> +		 * sure such a load cannot read user memory, so resolve the
> +		 * fault through the exception table, as for an unmapped kernel
> +		 * address, instead of oopsing.
> +		 */
> +		if (is_bpf_text_address(regs->ip) &&
> +		    fixup_exception(regs, X86_TRAP_PF, error_code, address))
> +			return;

[Severity: High]
Does this introduce a race condition during BPF program destruction?

If a BPF program with PROBE_MEM loads has its reference count drop to zero,
__bpf_prog_put_noref() synchronously removes it from the global bpf_tree via
bpf_prog_kallsyms_del_all() before waiting for the RCU grace period:

kernel/bpf/syscall.c:__bpf_prog_put_noref() {
    ...
    bpf_prog_kallsyms_del_all(prog);
    ...
    if (deferred) {
        ...
        call_rcu(&prog->aux->rcu, __bpf_prog_put_rcu);
    ...
}

If a CPU is still executing this program inside an RCU read-side critical
section and hits a PROBE_MEM fault, could the page fault handler fail to fi=
nd
the actively executing program?

The handler calls is_bpf_text_address() and then fixup_exception(), which
eventually searches for the program using bpf_prog_ksym_find():

kernel/bpf/core.c:search_bpf_extables() {
    rcu_read_lock();
    prog =3D bpf_prog_ksym_find(addr);
    if (!prog)
        goto out;
    ...
}

Because the program was already cleared from bpf_tree, is_bpf_text_address()
and fixup_exception() will fail to resolve the exception, causing the kerne=
l to
incorrectly fall through to page_fault_oops() instead.

>  		/*
>  		 * No extable entry here.  This was a kernel access to an
>  		 * invalid pointer.  get_kernel_nofault() will not get here.
>  		 */
>  		page_fault_oops(regs, error_code, address);
>  		return;
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009024925.3169=
077-1-memxor@gmail.com?part=3D1
