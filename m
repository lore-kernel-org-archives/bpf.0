Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF0A33DA7D1
	for <bpf@vger.kernel.org>; Fri,  3 Jul 2026 13:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783086713; cv=none; b=bTqMVHvo+Y6Ryh50KE1OKMaKmN+1mSHqStLyKgYcvoSj6JD7ldADgDTv6Byk6MNVi7xaIeRBylgfX8kSWNb56oHLblApoiP6dN+IH5GiW3jzkvMXTtSdPAZCxLg7snWdkBHBqyuVOCtspNolh77WqTOirF/LFZy9g+9mDKz/8i8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783086713; c=relaxed/simple;
	bh=Fya/r2i9Q1HCXdJ+hbuDimOhJPBx0X6DKHGMg0lMhFc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dDI3p7KCIH7MV/oaECzZ4oXFQkj1oOBQgiOw5sSV6FjWAVkEb3AVsnCe3Ki4vpVgQgUReQd+0B38m0bP2msvtyPrm4P9N7pmo694E5NDeVCFXc42b9WFew7mK1U53QblXL0GeBZJRDeGkd0MrHElPE8zY/IbLHSyrwNKku83HjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ssBSZmQD; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ssBSZmQD"
Message-ID: <4a0ac2692d2a76ab0479c2bf20dbf26a17636d67.camel@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783086698;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=auCIWg3o17nnR2QLCs22R/XUDmzBkX9qbvWaBSNT648=;
	b=ssBSZmQDdBdrfuieBmqYoH387xvy4NeoiJpVuwii2c6lYLFgMNbvUDK+ws1NaAJBLlYkIN
	3iS4OXublRXUYqV1+IX2PRJZVwih5F5TAO/jRULJT2YMLR6vnWkaMHGB1oBfo2eBM+v2r6
	qKrvpZ/oD6rDRFupCDarV4AJC5SYTA0=
Subject: Re: [PATCH bpf-next v7 1/2] bpf: Introduce jit_required flag and
 refactor kfunc path
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: KaFai Wan <kafai.wan@linux.dev>
To: Tiezhu Yang <yangtiezhu@loongson.cn>, sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>
Date: Fri, 03 Jul 2026 21:51:29 +0800
In-Reply-To: <7cce1695-eaa2-816b-2877-9cb2f117aa27@loongson.cn>
References: <20260702143656.28845-1-yangtiezhu@loongson.cn>
	 <20260702143656.28845-2-yangtiezhu@loongson.cn>
	 <20260702145855.07C6B1F000E9@smtp.kernel.org>
	 <7cce1695-eaa2-816b-2877-9cb2f117aa27@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Migadu-Flow: FLOW_OUT

On Fri, 2026-07-03 at 10:57 +0800, Tiezhu Yang wrote:
> On 2026/7/2 =E4=B8=8B=E5=8D=8810:58, sashiko-bot@kernel.org=C2=A0wrote:
> > Thank you for your contribution! Sashiko AI review found 1 potential is=
sue(s) to consider:
> > - [Medium] The `bpf_fixup_call_args()` function and `bpf_prog_has_kfunc=
_call()` macro were not
> > updated to use the new `jit_required` flag, leading to inconsistent int=
erpreter fallback
> > behavior for pruned kfuncs.
> > --
> >=20
> > commit 5a3f8861c2b6916fe194f97a407cb7265f545fd0
> > Author: Tiezhu Yang <yangtiezhu@loongson.cn>
> >=20
> > bpf: Introduce jit_required flag and refactor kfunc path
> >=20
> > Introduce a 'jit_required' bitfield flag at the end of the
> > flags group in struct bpf_prog. This bit tracks whether a
> > program strictly requires the JIT compiler.
> >=20
> > > diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> > > index 649cce41e13f3..5fcd19ccb41a9 100644
> > > --- a/kernel/bpf/core.c
> > > +++ b/kernel/bpf/core.c
> > > @@ -2619,8 +2619,7 @@ struct bpf_prog *__bpf_prog_select_runtime(stru=
ct bpf_verifier_env *env,
> > > struct
> > > =C2=A0=C2=A0	if (fp->bpf_func)
> > > =C2=A0=C2=A0		goto finalize;
> > > =C2=A0=20
> > > -	if (IS_ENABLED(CONFIG_BPF_JIT_ALWAYS_ON) ||
> > > -	=C2=A0=C2=A0=C2=A0 bpf_prog_has_kfunc_call(fp))
> > > +	if (IS_ENABLED(CONFIG_BPF_JIT_ALWAYS_ON) || fp->jit_required)
> > > =C2=A0=C2=A0		jit_needed =3D true;
> > > =C2=A0=20
> > > =C2=A0=C2=A0	if (!bpf_prog_select_interpreter(fp))
> >=20
> > [Severity: Medium]
> > Since bpf_prog_has_kfunc_call() was replaced here with fp->jit_required=
,
> > should bpf_fixup_call_args() in kernel/bpf/fixups.c also be updated to =
use
> > the new flag?
> >=20
> > Currently, bpf_fixup_call_args() still calls bpf_prog_has_kfunc_call().=
 If
> > a program has a pruned kfunc (allocating kfunc_tab but leaving
> > jit_required=3D0) and JIT falls back to the interpreter, wouldn't
> > bpf_fixup_call_args() incorrectly reject the program with -EINVAL?
> >=20
> > kernel/bpf/fixups.c:bpf_fixup_call_args() {
> > =C2=A0=C2=A0=C2=A0=C2=A0 ...
> > 	bool has_kfunc_call =3D bpf_prog_has_kfunc_call(prog);
> > =C2=A0=C2=A0=C2=A0=C2=A0 ...
> > 	if (has_kfunc_call) {
> > 		verbose(env, "calling kernel functions are not allowed in non-JITed
> > programs\n");
> > 		return -EINVAL;
> > 	}
> > =C2=A0=C2=A0=C2=A0=C2=A0 ...
> > }
> >=20
> > Should bpf_prog_has_kfunc_call() in kernel/bpf/verifier.c be updated to
> > check prog->jit_required, or removed entirely in favor of checking the =
flag
> > directly?
>=20
> I think it is wrong to remove bpf_prog_has_kfunc_call() entirely,

I think it is ok to remove bpf_prog_has_kfunc_call() but with some changes.=
 see below.

> because using prog->jit_required directly in bpf_fixup_call_args()
> would cause false positives.
>=20
> I tested the following changes:
>=20
> ```
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 4e2b059d71f3..3a2fc194e2bb 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -3171,7 +3171,6 @@ const struct bpf_func_proto=20
> *bpf_base_func_proto(enum bpf_func_id func_id,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 co=
nst struct bpf_prog=20
> *prog);
> =C2=A0 void bpf_task_storage_free(struct task_struct *task);
> =C2=A0 void bpf_cgrp_storage_free(struct cgroup *cgroup);
> -bool bpf_prog_has_kfunc_call(const struct bpf_prog *prog);
> =C2=A0 const struct btf_func_model *
> =C2=A0 bpf_jit_find_kfunc_model(const struct bpf_prog *prog,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 const struct bpf_insn *insn);
> @@ -3510,11 +3509,6 @@ static inline void bpf_task_storage_free(struct=
=20
> task_struct *task)
> =C2=A0 {
> =C2=A0 }
>=20
> -static inline bool bpf_prog_has_kfunc_call(const struct bpf_prog *prog)
> -{
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return false;
> -}
> -
> =C2=A0 static inline const struct btf_func_model *
> =C2=A0 bpf_jit_find_kfunc_model(const struct bpf_prog *prog,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 const struct bpf_insn *insn)
> diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
> index 94e0457a0aa3..7fb92b5fa415 100644
> --- a/kernel/bpf/fixups.c
> +++ b/kernel/bpf/fixups.c
> @@ -1378,7 +1378,6 @@ int bpf_fixup_call_args(struct bpf_verifier_env *en=
v)
> =C2=A0 #ifndef CONFIG_BPF_JIT_ALWAYS_ON
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct bpf_prog *prog =
=3D env->prog;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct bpf_insn *insn =
=3D prog->insnsi;
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool has_kfunc_call =3D bpf_prog_ha=
s_kfunc_call(prog);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int depth;
> =C2=A0 #endif
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int i, err =3D 0;
> @@ -1404,7 +1403,7 @@ int bpf_fixup_call_args(struct bpf_verifier_env *en=
v)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 re=
turn err;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> =C2=A0 #ifndef CONFIG_BPF_JIT_ALWAYS_ON
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (has_kfunc_call) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (prog->jit_required) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 verbose(env, "calling kernel functions are not all=
owed=20
> in non-JITed programs\n");

we can change the log for general purpose. patch #2 and future case will hi=
t this too.

> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 return -EINVAL;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index f496b45b9da4..3dbed3047254 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -2770,11 +2770,6 @@ int bpf_add_kfunc_call(struct bpf_verifier_env=20
> *env, u32 func_id, u16 offset)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
> =C2=A0 }
>=20
> -bool bpf_prog_has_kfunc_call(const struct bpf_prog *prog)
> -{
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return !!prog->aux->kfunc_tab;
> -}
> -
> =C2=A0 static int add_subprog_and_kfunc(struct bpf_verifier_env *env)
> =C2=A0 {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct bpf_subprog_info =
*subprog =3D env->subprog_info;
> ```
>=20
> Here is the local test log:
>=20
> ```
> fedora@linux:~$ cat test_panic.c
> =C2=A0=C2=A0 #include <linux/bpf.h>
> =C2=A0=C2=A0 #include <bpf/bpf_helpers.h>
>=20
> =C2=A0=C2=A0 SEC("kprobe/sys_getpid")
> =C2=A0=C2=A0 int test_panic(void *ctx)
> =C2=A0=C2=A0 {
> =C2=A0=C2=A0=C2=A0	struct task_struct *task;
>=20
> =C2=A0=C2=A0=C2=A0	task =3D (struct task_struct *)bpf_get_current_task();
> =C2=A0=C2=A0=C2=A0	if (task)
> =C2=A0=C2=A0=C2=A0		bpf_printk("Task address: %p\n", task);
>=20
> =C2=A0=C2=A0=C2=A0	return 0;
> =C2=A0=C2=A0 }
>=20
> =C2=A0=C2=A0 char LICENSE[] SEC("license") =3D "GPL";
> fedora@linux:~$ clang -target bpf -O2 -g -c test_panic.c -o test_panic.o
> fedora@linux:~$ sudo sysctl -w net.core.bpf_jit_enable=3D0
> [sudo] password for fedora:
> net.core.bpf_jit_enable =3D 0
> fedora@linux:~$ sudo bpftool prog load test_panic.o=20
> /sys/fs/bpf/test_panic autoattach
> libbpf: prog 'test_panic': BPF program load failed: Invalid argument
> libbpf: prog 'test_panic': -- BEGIN PROG LOAD LOG --
> calling kernel functions are not allowed in non-JITed programs
> processed 10 insns (limit 1000000) max_states_per_insn 0 total_states 1=
=20
> peak_states 1 mark_read 0
> -- END PROG LOAD LOG --
> libbpf: prog 'test_panic': failed to load: -22
> libbpf: failed to load object 'test_panic.o'
> Error: failed to load object file
> ```
>=20
> This change incorrectly rejects programs that only contain normal
> inlined helper calls with -EINVAL.

Was it tested after compiling together with patch #2? seems patch #2 works.

>=20
> Instead, I think bpf_prog_has_kfunc_call() should be updated to check
> prog->jit_required, like so:
>=20
> ```
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index f496b45b9da4..1f5824c1c691 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -2772,7 +2772,7 @@ int bpf_add_kfunc_call(struct bpf_verifier_env=20
> *env, u32 func_id, u16 offset)
>=20
> =C2=A0 bool bpf_prog_has_kfunc_call(const struct bpf_prog *prog)
> =C2=A0 {
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return !!prog->aux->kfunc_tab;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return prog->jit_required && !!prog=
->aux->kfunc_tab;

bpf_get_current_task() is a helper, not kfunc. test_panic has no kfunc, pro=
g->aux->kfunc_tab
is=C2=A0null.=C2=A0so we get -ENOTSUPP(-524)

> =C2=A0 }
>=20
> =C2=A0 static int add_subprog_and_kfunc(struct bpf_verifier_env *env)
> ```
>=20
> Here is the local test log:
>=20
> ```
> fedora@linux:~$ cat test_panic.c
> =C2=A0=C2=A0 #include <linux/bpf.h>
> =C2=A0=C2=A0 #include <bpf/bpf_helpers.h>
>=20
> =C2=A0=C2=A0 SEC("kprobe/sys_getpid")
> =C2=A0=C2=A0 int test_panic(void *ctx)
> =C2=A0=C2=A0 {
> =C2=A0=C2=A0=C2=A0	struct task_struct *task;
>=20
> =C2=A0=C2=A0=C2=A0	task =3D (struct task_struct *)bpf_get_current_task();
> =C2=A0=C2=A0=C2=A0	if (task)
> =C2=A0=C2=A0=C2=A0		bpf_printk("Task address: %p\n", task);
>=20
> =C2=A0=C2=A0=C2=A0	return 0;
> =C2=A0=C2=A0 }
>=20
> =C2=A0=C2=A0 char LICENSE[] SEC("license") =3D "GPL";
> fedora@linux:~$ clang -target bpf -O2 -g -c test_panic.c -o test_panic.o
> fedora@linux:~$ sudo sysctl -w net.core.bpf_jit_enable=3D0
> [sudo] password for fedora:
> net.core.bpf_jit_enable =3D 0
> fedora@linux:~$ sudo bpftool prog load test_panic.o=20
> /sys/fs/bpf/test_panic autoattach
> libbpf: prog 'test_panic': BPF program load failed: unknown error (-524)
> libbpf: prog 'test_panic': -- BEGIN PROG LOAD LOG --
> processed 10 insns (limit 1000000) max_states_per_insn 0 total_states 1=
=20
> peak_states 1 mark_read 0
> -- END PROG LOAD LOG --
> libbpf: prog 'test_panic': failed to load: -524
> libbpf: failed to load object 'test_panic.o'
> Error: failed to load object file
> ```
>=20
> This ensures that pruned kfuncs (allocating kfunc_tab but leaving
> jit_required=3D0)=C2=A0safely return false,=C2=A0at the same time, this c=
heck
> perfectly isolates normal inlined helper paths.

pruned kfuncs well handled in patch [1], see details in check_kfunc_call() =
and fixup_kfunc_call().

[1] https://lore.kernel.org/bpf/20211002011757.311265-3-memxor@gmail.com/
>=20
> Let me wait for more review comments and will send v8 next week.
>=20
> Thanks,
> Tiezhu
>=20

--=20
Thanks,
KaFai
