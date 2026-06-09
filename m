Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35BBE29B77E
	for <bpf@vger.kernel.org>; Tue,  9 Jun 2026 16:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781023174; cv=none; b=BjFKSdaqIbe0QDAgRNo0x17hY7Wqg3XTkqlqmm8RdfZmnMmRN10ko/q1d9xIfjGRuimm20mPRxAu4t1+xnvlfddfHmEewdd1TK1/aeSzH1iUJMXFjn7WFvYFaVBstUxujGK+7lRZ18RGpNPc9F27jAcx/xgqYKRs/pAq9ytw5Uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781023174; c=relaxed/simple;
	bh=LQACEq2UOT31OkUElwT7WD22QhTB9SWN5/MhVo3nCGk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CVJEaP4Sa/s/qr69EaVIdwEBZQvbTgnSyTsLKgYIkC/FAZyIYnxrjYRJyiUNnHViVi3wROZwyxTh2Dckeznk24B2q+f9jwvrkLdsTMpwIEF4TAaDbFEYm/FzbwelLXB/c0TlW9Ee0jxsVFF+LkaYyVp6F64ZcHPeqziNdPV4q4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IShlxb6n; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IShlxb6n"
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-304d7f31215so5101512eec.1
        for <bpf@vger.kernel.org>; Tue, 09 Jun 2026 09:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781023172; x=1781627972; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VFJG2uxSMG7F0K/WXML4SmD0jp20hFrSyvhDPKqltno=;
        b=IShlxb6nX0TM6ZnSSKONtc+3rBWCzm575lZv1Berr+LQYznnqSPtDXBChG07TAwrxd
         xlqKLKz8KH6yfsllFMglDnLVbSqEfcbNPod4uDPLE8CkZOCiUOdOKJss6mQOJY3l/91i
         XdMltmDUG+rAmwvwep0f2xOUAo3XSO4FCQcsU/oDe4s8rLRy9YgfOHW0iHc041E/T2LW
         he6+fdYh+h4x15bpNaPwhZ8x9lcbaqhr/GdAB3MaVa8lLK13RyHOULJ98BhC/GH0Nofd
         50KKisjjxjGliUfpWK4bxsh+c1kaKirNQiLSnFEEJ+YGfFe01iB5S9WZZVDt1mHvmlkQ
         ONCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781023172; x=1781627972;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VFJG2uxSMG7F0K/WXML4SmD0jp20hFrSyvhDPKqltno=;
        b=od3UAxbFuYuNavVo+6G/dDwaquVxf/PIIx4u7aYUyC3LDIGP3DteCPymbzIaMPKJlh
         7Lj6Dw2YNyGLmLxQP5PmFeGFQPv8EzFC2+/IBK3y7ZxRpO3W1RZvqnE5LJAxxkCsY+SP
         2sCCVR34ryS3BjaFO06j1axC9DUSRZs577ACvPTluKblol9C1EzsB36Aen2iEd39286n
         uEIj8jGG5jHgf/22ivtV9zlMExRhqEpGm0v9U9zDTJBu/sEeLtjZJxlIkbl4wWLwKlOk
         wQdcQWu9Rvf09JIZPSFeskR22tagW4mweLmb/mXffLCLMaEDGIT9tLJROnWThUQNME53
         Aihw==
X-Forwarded-Encrypted: i=1; AFNElJ+ZROJ4DpL7G4rD1lBG0rkoq/G7wZk96jN4R8R+1lnT84INhjRue9fm9OcUQGojpDWeO1w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxf9/yR++TSG0SLV8jQbRwGEYoz0XsLwONG/YIXTvjdBmhiTJ4f
	Oi7MUsgKYtVmOSCDreyFjttI/ZvNbp+dPTDDszEdcFgE3ielawZ3hhS9
X-Gm-Gg: Acq92OEw/Y8Y341cgKnpIenW3ahnMnJ1cTj4uxPlOlC8ZfiK9irtNsZ0Ep8QgYPYag+
	sPFw5ql0UkpVGAntSxen0ncLryEAJEF7IwvcrRQYZSVZtykExlyVdGWa1/eFBUvog+xv/rVXJZF
	6Q1d+/qBVDpDNaaF675sm1PCPf6Y/3VwZgNuD9UuVlhW8fIGi+lLQPjK/FWpnQvlPc3sUXf7+HQ
	fkvd4EzAmDUMHp3L56EsSEOXNWzp6+NNv8HZYBrH67UgDME9PWyFY5UaUx7Ft11448DP/fUjSI/
	j0QuwwU7bR0/kwlX4YRHe99m06zBW6GCSkhZfAKUAqinYMAQV9dbEJIM1H+N7Gkn3MspIf/z7Ki
	HQJDHTKFax0jsa7DQw55mvimugXv7YZn36JN/A4izMedzHET9rInUUqrWrI7bfZx7VCX4T2Ukkq
	VZyfiDuxNC1esQCOk3TIHwCyYx1A4MJZr3wrQyK6AHYPwZLAEtHqYZcAOYDV6opJbAuqjXYNF5R
	OnobuB2HiubQvNhleI=
X-Received: by 2002:a05:7301:fa08:b0:2f3:986d:2d01 with SMTP id 5a478bee46e88-3077b595238mr12255574eec.19.1781023172134;
        Tue, 09 Jun 2026 09:39:32 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:bc91:a683:c279:a106? ([2620:10d:c090:500::3:1322])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3074dcb98aasm21321182eec.12.2026.06.09.09.39.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 09:39:31 -0700 (PDT)
Message-ID: <9a66a9e8ac66192e9bd2b938c893e6cffa4aa10f.camel@gmail.com>
Subject: Re: [PATCH bpf v6 1/2] bpf: Fix kfunc implicit arg inject type
 detection to prevent invalid pointer deref
From: Eduard Zingerman <eddyz87@gmail.com>
To: chenyuan_fl@163.com
Cc: andrii@kernel.org, ast@kernel.org, bot+bpf-ci@kernel.org,
 bpf@vger.kernel.org, 	chenyuan@kylinos.cn, clm@meta.com,
 daniel@iogearbox.net, ihor.solodrai@linux.dev, 	jolsa@kernel.org,
 linux-kernel@vger.kernel.org, martin.lau@kernel.org, 	martin.lau@linux.dev,
 memxor@gmail.com, song@kernel.org, yonghong.song@linux.dev
Date: Tue, 09 Jun 2026 09:39:29 -0700
In-Reply-To: <20260609125214.3096351-2-chenyuan_fl@163.com>
References: <20260608142618.3064380-1-chenyuan_fl@163.com>
	 <20260609125214.3096351-1-chenyuan_fl@163.com>
	 <20260609125214.3096351-2-chenyuan_fl@163.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-06-09 at 20:52 +0800, chenyuan_fl@163.com wrote:
> From: Yuan Chen <chenyuan@kylinos.cn>
>=20
> When a module kfunc declares an implicit struct bpf_prog_aux * argument,
> the verifier must identify it so the kernel injects env->prog->aux into
> the correct register at runtime.  The original check used
> is_kfunc_arg_prog_aux() which calls btf_types_are_same() to compare the
> module BTF type against vmlinux.
>=20
> Root Cause
>=20
> This issue was triggered by pahole 1.30 generating module BTF with
> incorrect type information, which caused the kernel's distilled base
> BTF deduplication for modules to fail.  As a result, the module retained
> its own copy of struct bpf_prog_aux with a different BTF ID than
> vmlinux's definition.  While pahole 1.31 fixed the BTF generation issue,
> the kernel must be robust against such inconsistencies: a BTF mismatch
> should result in a clean rejection, not a kernel crash or information
> disclosure.
>=20
> When the distilled base dedup fails and btf_types_are_same() cannot
> match the module's bpf_prog_aux type against vmlinux's,
> is_kfunc_arg_prog_aux() returned false and the code fell through
> silently without setting arg_prog.  The kfunc then received whatever
> value was in the argument register and dereferenced it as a
> bpf_prog_aux pointer, leading to:
>=20
>   BUG: kernel invalid pointer dereference, address: 00000000000009e2
>   RIP: bpf_prog_get_assoc_struct_ops+0xa/0xc0
>   RDI: 0x000000000000046d (stale register value)
>=20
> In the observed crash the stale value was the process PID, causing a
> dereference within the unmapped NULL page.  However, an attacker able
> to control the register value -- for example by writing a BPF program
> that explicitly sets R2 before calling a KF_IMPLICIT_ARGS kfunc --
> could redirect the dereference to arbitrary kernel memory, turning
> this into an information disclosure.  The fix ensures the verifier
> either validates and injects the correct bpf_prog_aux pointer, or
> rejects the program outright -- no silent fallthrough that could
> be exploited.
>=20
> Crash Stack Trace
>=20
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
>=20
> Fix
>=20
> Split the combined is_kfunc_arg_ignore() || is_kfunc_arg_implicit()
> check in check_kfunc_args() so that an implicit argument reaching
> is_kfunc_arg_implicit() without being handled by a prior handler is
> rejected with -EFAULT, instead of silently skipped.  Existing implicit
>       args in bpf_fixup_kfunc_call() (obj_new, percpu_obj_new, obj_drop,
>       percpu_obj_drop, refcount_acquire, list_push, rbtree_add) are
>       explicitly allowed.
>=20
> Suggested-by: Eduard Zingerman <eddyz87@gmail.com>
> Fixes: 64e1360524b9 ("bpf: Verifier support for KF_IMPLICIT_ARGS")
> Signed-off-by: Yuan Chen <chenyuan@kylinos.cn>
> ---

Please do not drop acks.
Also, wdyt about this:
https://lore.kernel.org/bpf/20260602093836.2632714-1-chenyuan_fl@163.com/T/=
#m736b14f7e8b0a117bf0791ce79fc0896df8ca0f2
?

[...]
