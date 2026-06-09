Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 244F6279907
	for <bpf@vger.kernel.org>; Tue,  9 Jun 2026 01:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780966831; cv=none; b=DZPjCg02hxXhLg2uPSgVjqSLnCCGia9AYgdDqq0VNlF2iunH1nCAc7/TGIW/oPfupflPSjWeC2FRI4NrtY//yeXH+kPqcdwd3fLxuR+ZBFxdaGlL46u0cs+9t/puIGSph+QkIFb6YBebKNxbJhQdrPmYVjAV8ycg0vZJU5SaThU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780966831; c=relaxed/simple;
	bh=t5728f3Chfb/jjMBuAwjgeGcYpzLWw+39I0b3183X2c=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Y/txfBK4C0KWsZVrp2oJrjMwvSgmyyUmxLZFUzpIkpXymLS/4xyinn87WpyC28tDr0zqxIBH7Ls7IsRQQybDv6ri1ECfqKMetGCl4wAm6m+oUVrn72EZrV+rIeqkFi9tlfEd/pXomdqgyZ2w/yhVNyC7Sw57qXmBYsuJ4deaJNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k4rb1Ml8; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k4rb1Ml8"
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-304ddfcf72cso5102329eec.0
        for <bpf@vger.kernel.org>; Mon, 08 Jun 2026 18:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780966826; x=1781571626; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OQBrQS5EmHHWgpL0VJev95gvg3IajG0SEO/xcU/cGJM=;
        b=k4rb1Ml8mgyQYd+IGHYNz0FC6wdnUJ26uF/X3N60zajoMXg1fALupGWmRzN0ozmNOQ
         Jl4bmSV9k997l4CnsaDZSSXV0yPGShBCfdDiuMqIlyM00VTTsXmj6ECpMWk0e7u60fjz
         HcdEO/3lQRTBwId2Fm6dl8y/mSbyGGAO3IiYyF2AQxRcxjbPjWwxQHVBKWmBC+Y41njR
         C6Gmt3OeWQH1+hKMLxs3Pw9FOkpUYQ2C/FxaazRNwgwVpdBQ1BY8sbx3Zr9E95XTxwpd
         5eASxYfmT+3MjDL7MZ6+Eev4ml8OmlAlPY/PkNKFy/AjPLcsiJqpr3+6hg+FbYAcEfEn
         5RMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780966826; x=1781571626;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OQBrQS5EmHHWgpL0VJev95gvg3IajG0SEO/xcU/cGJM=;
        b=ksU59PA0ht6jK0BItA+uxS+XdlmpdcDrkw/X1NDrVCKKSJgMBVGrmAq7ix8aFXeka9
         HOG4v2BG/ze6IkGIF30qWM8G8PRjLhJM7oMYCM8uiCaiPdtuVMqrBE0n26jMBWbrO3fK
         SLriK2rzqtK0vBDrDX0ztCzEcKe9LwTPB4SDMIT5huRxrmnJUESDlSJ1BpwbqH5Xnaep
         FxHBt/1AxiP65jJ/rKkdOH+nqoav5y+LEBDyHLa0NCzLvwrF6v3v7bFUi601VIW3Eoi/
         kk6g3FyyRKUZMGu8PYziQ0qMOFB4G+FWYZ6vEXZPactB9Er49gCqUA5yaS+iB02agzry
         tjtQ==
X-Forwarded-Encrypted: i=1; AFNElJ/0q0n0C0izQXt3WFXhmRDpZ6SJJSoYPU6wfQ9pNfYzxmkOb37Jov3LNOPYuvF1XVtnX8s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtH9/wqnsSiFX2KRtImqu7t7xuV4Honlxnk7ksbEh8AYtcR00S
	ROhXRjHZGd7KGfcJeCSbHL7jWhKHsXQi0NuDIrKx6UDFCXsqqRAgR1s7
X-Gm-Gg: Acq92OH+SMa45STa7VlTlQmWSLvT70pWkXogFyVSWpxWUTeUKRJh1cO6RMW9wgyaVTy
	I3xTfpXdWQdCJsct2FX5kEPTnVITLEXOThZoPkL5kE6BKZgII1Nd9OnWKJV+tqBYjcN2vwzVvx5
	3rBdXLb9jhkG5JsYur5kqV3qVEMnGtUkbdRMYjkD1Fv5yzsMpMWwOyh3w2qzygtRWw5GFPaAaLk
	HjhfC5BBCOn+F5XhXW/tdcC91pcGvzb8P2znzsmx3GZcm1hf64WJtPR+Lb+u5zcKrc+zIhAHwvF
	9PqFCfex0wrBnoS7aiUyvqfpoDdomig7mYGC99qS5DPSSZBxSgLzW7uCK5qvfos4/vxsEFzKMUr
	qZx8HIjW7sfkvmboOUPHYVY52RiybbS3AqaCtt9IOqmWst7ZK8K8kfULjxO7bSlHxBFG0zNofQ8
	gR6bfAhvT8FGT5ctumArkkEUyhV3MFe4WO3oYK9sOvOLNw9Oz96WsIvlitVXi8Ub2fdpXkvuFg5
	Rg38L3zETqRt9mqRSA=
X-Received: by 2002:a05:693c:6390:10b0:304:db3a:3919 with SMTP id 5a478bee46e88-3077af0e961mr5388593eec.6.1780966821204;
        Mon, 08 Jun 2026 18:00:21 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:cde6:fb53:a1a3:a385? ([2620:10d:c090:500::3:b685])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3078c1ac378sm11412698eec.1.2026.06.08.18.00.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 18:00:20 -0700 (PDT)
Message-ID: <49c36dc0f52bd05d0f8c055e3d3e96992ae716a6.camel@gmail.com>
Subject: Re: [PATCH bpf v5 1/2] bpf: Fix kfunc implicit arg inject type
 detection to prevent invalid pointer deref
From: Eduard Zingerman <eddyz87@gmail.com>
To: Ihor Solodrai <ihor.solodrai@linux.dev>, chenyuan_fl@163.com
Cc: andrii@kernel.org, ast@kernel.org, bot+bpf-ci@kernel.org,
 bpf@vger.kernel.org, 	chenyuan@kylinos.cn, clm@meta.com,
 daniel@iogearbox.net, jolsa@kernel.org, 	linux-kernel@vger.kernel.org,
 martin.lau@kernel.org, martin.lau@linux.dev, 	memxor@gmail.com,
 song@kernel.org, yonghong.song@linux.dev
Date: Mon, 08 Jun 2026 18:00:18 -0700
In-Reply-To: <eab4e479-2023-49b8-9915-1c8ef2356837@linux.dev>
References: <20260602093836.2632714-1-chenyuan_fl@163.com>
	 <20260608142618.3064380-1-chenyuan_fl@163.com>
	 <20260608142618.3064380-2-chenyuan_fl@163.com>
	 <eab4e479-2023-49b8-9915-1c8ef2356837@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-06-08 at 17:54 -0700, Ihor Solodrai wrote:
> On 6/8/26 7:26 AM, chenyuan_fl@163.com wrote:
> > From: Yuan Chen <chenyuan@kylinos.cn>
> >=20
> > When a module kfunc declares an implicit struct bpf_prog_aux * argument=
,
> > the verifier must identify it so the kernel injects env->prog->aux into
> > the correct register at runtime.  The original check used
> > is_kfunc_arg_prog_aux() which calls btf_types_are_same() to compare the
> > module BTF type against vmlinux.
> >=20
> > Root Cause
> >=20
> > This issue was triggered by pahole 1.30 generating module BTF with
> > incorrect type information, which caused the kernel's distilled base
> > BTF deduplication for modules to fail.  As a result, the module retaine=
d
> > its own copy of struct bpf_prog_aux with a different BTF ID than
> > vmlinux's definition.  While pahole 1.31 fixed the BTF generation issue=
,
> > the kernel must be robust against such inconsistencies: a BTF mismatch
> > should result in a clean rejection, not a kernel crash or information
> > disclosure.
> >=20
> > When the distilled base dedup fails and btf_types_are_same() cannot
> > match the module's bpf_prog_aux type against vmlinux's,
> > is_kfunc_arg_prog_aux() returned false and the code fell through
> > silently without setting arg_prog.  The kfunc then received whatever
> > value was in the argument register and dereferenced it as a
> > bpf_prog_aux pointer, leading to:
> >=20
> >   BUG: kernel invalid pointer dereference, address: 00000000000009e2
> >   RIP: bpf_prog_get_assoc_struct_ops+0xa/0xc0
> >   RDI: 0x000000000000046d (stale register value)
> >=20
> > In the observed crash the stale value was the process PID, causing a
> > dereference within the unmapped NULL page.  However, an attacker able
> > to control the register value -- for example by writing a BPF program
> > that explicitly sets R2 before calling a KF_IMPLICIT_ARGS kfunc --
> > could redirect the dereference to arbitrary kernel memory, turning
> > this into an information disclosure.  The fix ensures the verifier
> > either validates and injects the correct bpf_prog_aux pointer, or
> > rejects the program outright -- no silent fallthrough that could
> > be exploited.
> >=20
> > Crash Stack Trace
> >=20
> >   PID: 1133     TASK: ffff8881057d3900  CPU: 3    COMMAND: "test_progs"
> >    #0 machine_kexec at ffffffff812f6e26
> >    #1 __crash_kexec at ffffffff8145a788
> >    #2 crash_kexec at ffffffff8145ac24
> >    #3 oops_end at ffffffff812bb67c
> >    #4 page_fault_oops at ffffffff813053a1
> >    #5 exc_page_fault at ffffffff828e60a1
> >    #6 asm_exc_page_fault at ffffffff810012a6
> >       [exception RIP: bpf_prog_get_assoc_struct_ops+10]
> >       RIP: ffffffff815c024a  RSP: ffffc90001b57e48  RFLAGS: 00010283
> >       RAX: ffff8881057d3900  RBX: ffffc90001b57e68  RCX: ffff8881057d39=
00
> >       RDX: 0000607d4d1768b8  RSI: 000000000000046d  RDI: 00000000000004=
6d
> >    #7 bpf_kfunc_multi_st_ops_test_1_assoc at ffffffffc0013a85 [bpf_test=
mod]
> >    #8 bpf_trace_run2 at ffffffff814f8332
> >    #9 __traceiter_sys_enter at ffffffff81415f45
> >   #10 trace_syscall_enter at ffffffff81416735
> >   #11 do_syscall_64 at ffffffff828e06a1
> >=20
> > Fix
> >=20
> > Split the combined is_kfunc_arg_ignore() || is_kfunc_arg_implicit()
> > check in check_kfunc_args() so that an implicit argument reaching
> > is_kfunc_arg_implicit() without being handled by a prior handler is
> > rejected with -EFAULT, instead of silently skipped.  Existing implicit
> >       args in bpf_fixup_kfunc_call() (obj_new, percpu_obj_new, obj_drop=
,
> >       percpu_obj_drop, refcount_acquire, list_push, rbtree_add) are
> >       explicitly allowed.
> >=20
> > Suggested-by: Eduard Zingerman <eddyz87@gmail.com>
> > Fixes: 64e1360524b9 ("bpf: Verifier support for KF_IMPLICIT_ARGS")
> > Signed-off-by: Yuan Chen <chenyuan@kylinos.cn>
> > ---
> >  kernel/bpf/verifier.c | 20 +++++++++++++++++++-
> >  1 file changed, 19 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 8ed484cb1a8a..91aaed7a5eeb 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -11885,9 +11885,27 @@ static int check_kfunc_args(struct bpf_verifie=
r_env *env, struct bpf_kfunc_call_
> >  			continue;
> >  		}
> > =20
> > -		if (is_kfunc_arg_ignore(btf, &args[i]) || is_kfunc_arg_implicit(meta=
, i))
> > +		if (is_kfunc_arg_ignore(btf, &args[i]))
> >  			continue;
> > =20
> > +		if (is_kfunc_arg_implicit(meta, i)) {
> > +			/* kfuncs with implicit args (e.g. 'off' parameter)
> > +			 * handled during verification in bpf_fixup_kfunc_call():
> > +			 * obj_new, percpu_obj_new, obj_drop, percpu_obj_drop,
> > +			 * refcount_acquire, list_push, rbtree_add. Don't flag them. */
> > +			if (is_bpf_obj_new_kfunc(meta->func_id) ||
> > +			    is_bpf_percpu_obj_new_kfunc(meta->func_id) ||
> > +			    is_bpf_obj_drop_kfunc(meta->func_id) ||
> > +			    is_bpf_percpu_obj_drop_kfunc(meta->func_id) ||
> > +			    is_bpf_refcount_acquire_kfunc(meta->func_id) ||
> > +			    is_bpf_list_push_kfunc(meta->func_id) ||
> > +			    is_bpf_rbtree_add_kfunc(meta->func_id))
>=20
> Is the goal here to have a nice error message?
>=20
> I think this will fail for other functions like bpf_wq_set_callback().
> For a proper check, the list must include every single kfunc with KF_IMPL=
ICIT_ARGS, no?
>=20
> If we go this route, then the list of flagged kfuncs can be collected aut=
omatically.
> I'm not sure we actually want to do this.

The calls to functions with implicit arguments are patched by
bpf_fixup_kfunc_call(). As far as I understand, this function:
- handles functions with implicit bpf_prog_aux generically
- handles the functions listed above on a case-by-case basis.

The goal is not to have a nice error message, but to prevent runtime
from reading garbage from a register.

>=20
> > +				continue;
> > +			verbose(env, "%s unrecognized implicit argument, possible BTF misma=
tch\n",
> > +				reg_arg_name(env, argno));
> > +			return -EFAULT;
> > +		}
> > +
> >  		t =3D btf_type_skip_modifiers(btf, args[i].type, NULL);
> > =20
> >  		if (btf_type_is_scalar(t)) {
