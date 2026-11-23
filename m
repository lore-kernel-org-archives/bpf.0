Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795414199;
	b=ufpO/RZ0IOdauksPoMW2qdYb9duvaJOnxNgn2EHBcF3nlD3fV2ZCMP2a3zXnnvyXs4If
	 9LTS+c6I2ar9nASSKYp66u3TObc+gcSSvCMHQZKjTJvoQQNfM3JafKyuv1VUajWyJfLDD
	 Ox82pogb3f+z8sKw5EtwUYZN7GwEsrOdSgz4Hf1tpX/rLIZhrussjH6BIi0Aao8tL/woi
	 yZwIyq7D880zMXMUC+oGzbawE5QrAZRi8Uzz1XASZoZ9KMq8qoFyEnbEZK9RRMn0l8WZZ
	 pdFzuOIn2WN6L9HJP2KsUKLgXKu622d5L2IcG8DK+dpWXZrluC4y74aRk2LFuLxVi2A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795414199;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=P8RRyZhk8rIek4WEiqooBRQ8cP2rdzavBcflq+IZSTg=;
	b=uMou0MXnT91VGx1nkGSIW3+uxrHlTz5pbVLE0HZC0TbUHGfF4vg1D6P/3jn6dE2p7vRU
	 2qL8U8NNXYpLH36gzUUQCTps0KkWlhkVp0MYdySUuR3JPIWgQbvjnvCfyUpGRtt0P8qYV
	 gfEPY9h3oX6h2d0zo/mPmoaTU9ftx5uP9hS26ftu0iZtDmSXDUqRfbvqWgDMKmJ/Jtwkj
	 3ow5hjvBvC/s//ZLkyl+ttJFpisGvQ7FIaRIwbk6WpnG0xjLgIs1L3qawiMLy1kJloIKF
	 NiyKO+pkdfKGbclVrbcc1L2Rm5I2PRGO9+atIWWPPyRSKOtre9Awe+qsqTRomRdnKxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O6fOD0kC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA322606A321
	for <bpf@vger.kernel.org>; Mon, 23 Nov 2026 06:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O6fOD0kC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FFFB1F000C4;
	Mon, 23 Nov 2026 06:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795414199;
	bh=P8RRyZhk8rIek4WEiqooBRQ8cP2rdzavBcflq+IZSTg=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=O6fOD0kCY5pQAxBG8/CMOEspOsZHXFSlzqu/SlSogpYOY9obMSuePTyrDJSa1UUaH
	 FOW22GzknRRSrRDgJjhYLHMaHESWKFA0lpxMpOU5ha5GeKYaQq17eTVmWFGsv8Xy/U
	 s9gtNtLq/X0ZOiw5O7ZwKoOAPG022RLVLFbSnzZAR1EUgXkMV1LTVlefzzIf6BY8Lg
	 4gY0XSNGiwsEhc19fBjvcIvgCRan5xOnn0tomDMSojoklNFPM1i2DKNdjmC/P5oQR3
	 EpPgUgqwVPRergTalZDNfNXHVyOJYBcwbfh4Oo1+/BkKKB9Lb2xXgGJykIFFIQRaEE
	 /Yw2GRx3uXwjw==
Message-ID: <sashiko-outbox-228754@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v7 1/2] bpf: Fix kfunc implicit arg inject type
 detection to prevent invalid pointer deref
Reply-To: sashiko-reviews@lists.linux.dev
To: chenyuan_fl@163.com, bpf@vger.kernel.org
In-Reply-To: <20261123055708.684107-2-chenyuan_fl@163.com>
References: <20261123055708.684107-1-chenyuan_fl@163.com>
 <20261123055708.684107-2-chenyuan_fl@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 23 Nov 2026 06:09:58 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] bpf: Fixes trailer cites 64e1360524b9 instead of d457072576a6
--

commit 0ffc110d551c0af77ec8ac4f1f05079285023fc5
Author: Yuan Chen <chenyuan@kylinos.cn>

> bpf: Fix kfunc implicit arg inject type detection to prevent invalid poin=
ter deref
>
> When a module kfunc declares an implicit struct bpf_prog_aux * argument,
> the verifier must identify it so the kernel injects env->prog->aux into
> the correct register at runtime.  The original check used
> is_kfunc_arg_prog_aux() which calls btf_types_are_same() to compare the
> module BTF type against vmlinux.
>
> Root Cause
>
> This issue was triggered by pahole 1.30 generating module BTF with
> incorrect type information, which caused the kernel's distilled base BTF
> deduplication for modules to fail.  As a result, the module retained its
> own copy of struct bpf_prog_aux with a different BTF ID than vmlinux's
> definition.  While pahole 1.31 fixed the BTF generation issue, the kernel
> must be robust against such inconsistencies: a BTF mismatch should result
> in a clean rejection, not a kernel crash or information disclosure.
>
> When the distilled base dedup fails and btf_types_are_same() cannot match
> the module's bpf_prog_aux type against vmlinux's, is_kfunc_arg_prog_aux()
> returned false and the code fell through silently without setting
> arg_prog.  The kfunc then received whatever value was in the argument
> register and dereferenced it as a bpf_prog_aux pointer, leading to:
>
>   BUG: kernel invalid pointer dereference, address: 00000000000009e2
>   RIP: bpf_prog_get_assoc_struct_ops+0xa/0xc0
>   RDI: 0x000000000000046d (stale register value)
>
> In the observed crash the stale value was the process PID, causing a
> dereference within the unmapped NULL page.  However, an attacker able to
> control the register value -- for example by writing a BPF program that
> explicitly sets the argument register before calling a KF_IMPLICIT_ARGS
> kfunc -- could redirect the dereference to arbitrary kernel memory,
> turning this into an information disclosure.  The fix ensures the
> verifier either validates and injects the correct bpf_prog_aux pointer,
> or rejects the program outright -- no silent fallthrough that could be
> exploited.
>
> Crash Stack Trace
>
>   PID: 1133     TASK: ffff8881057d3900  CPU: 3    COMMAND: "test_progs"
>    #0 machine_kexec at ffffffff812f6e26
>    #1 __crash_kexec at ffffffff8145a788
>    #2 crash_kexec at ffffffff8145ac24
>    #3 oops_end at ffffffff812bb67c
>    #4 page_fault_oops at ffffffff813053a1
>    #5 exc_page_fault at ffffffff828e60a1
>    #6 asm_exc_page_fault at ffffffff810012a6
>       [exception RIP: bpf_prog_get_assoc_struct_ops+10]
>       RIP: ffffffff815c024a  RSP: ffffc90001b57e48  RFLAGS: 00010283
>       RAX: ffff8881057d3900  RBX: ffffc90001b57e68  RCX: ffff8881057d3900
>       RDX: 0000607d4d1768b8  RSI: 000000000000046d  RDI: 000000000000046d
>    #7 bpf_kfunc_multi_st_ops_test_1_assoc at ffffffffc0013a85 [bpf_testmo=
d]
>    #8 bpf_trace_run2 at ffffffff814f8332
>    #9 __traceiter_sys_enter at ffffffff81415f45
>   #10 trace_syscall_enter at ffffffff81416735
>   #11 do_syscall_64 at ffffffff828e06a1
>
> Fix
>
> Split the combined is_kfunc_arg_ignore() || is_kfunc_arg_implicit() check
> in get_kfunc_arg_type() so that an implicit argument that was not
> recognized by is_kfunc_arg_prog_aux() is rejected with -EFAULT instead of
> silently skipped.  The non-bpf_prog_aux implicit arguments handled by
> bpf_fixup_kfunc_call() (obj_new, percpu_obj_new, obj_drop,
> percpu_obj_drop, refcount_acquire, list_push, rbtree_add) are explicitly
> allowed.
>
> All other KF_IMPLICIT_ARGS kfuncs take a struct bpf_prog_aux * argument,
> which is matched by the preceding is_kfunc_arg_prog_aux() check and
> injected through insn_aux_data.arg_prog, so they never reach the new
> rejection path.
>
> Suggested-by: Eduard Zingerman <eddyz87@gmail.com>
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
> Fixes: 64e1360524b9 ("bpf: Verifier support for KF_IMPLICIT_ARGS")
> Signed-off-by: Yuan Chen <chenyuan@kylinos.cn>

[Severity: Low]
Should the Fixes tag reference d457072576a6 ("bpf: Support struct
btf_struct_meta via KF_IMPLICIT_ARGS") instead?

In 64e1360524b9 ("bpf: Verifier support for KF_IMPLICIT_ARGS"),
is_kfunc_arg_implicit() did not exist and an unmatched bpf_prog_aux
argument fell through to normal BTF pointer validation and was rejected.
d457072576a6 ("bpf: Support struct btf_struct_meta via KF_IMPLICIT_ARGS")
added is_kfunc_arg_implicit() and the check that silently skipped any
unrecognized implicit argument.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261123055708.6841=
07-1-chenyuan_fl@163.com?part=3D1
