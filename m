Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793728304;
	b=JbMeTU5Bp8szcMOt8J6MYRWbOGXH/E6FUu136g4Myfd0gLHQ5kEyDYCuYWeMIFpUOLWm
	 oCg3fByVF1LngmzDXRuV5uUJ9Z2Ej9twUBNAE+eTEcDbwtEwdFrJlAEK/CnZnFQ19yMhr
	 Ce7edhp6JOhr+aKW32x3dnKo2MyEAeAwYN6ccaFAJy8VzEUN32NGYpfH1V3qAOZDavGfX
	 GNEA8rHvqJ9CwGW0/aH7WS+QTH0M3mnkXQErVpZBqfVniSwSc+DrWTQw0JSrVbKcjxWhJ
	 mgvUJKTgT8fazssI84DbUlDHRQF6NpdExrDdJgeeiNY6nVWiWKcsfqnDK9ReYaBNemg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793728304;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=4FUD7GsXyKNirMjwbLGDVe9rCaoYM+dciapenGK+OiY=;
	b=uxFQXkEtWezST9soZFb+HkJ2pIK4wqeT1ppK2q9TbDEW6byDKqlxF6ulTVYCsnx3tAgM
	 kVEvdK1UC5i4JTLnkf6iq3qKT+5g2fq/kr+wOSGv7luip4+xJzW6td9pQF8OoSm5treum
	 b6d3imCgLU4knrCHl6t//6QSdps2WufoeW7fM0g/0VC5QVDGunMyAJKgdRdLF/SLX+IBV
	 fRaGd8pNSkWoyNfIGkBv7Yi+Dvwb0s/BydJ2v4gCaEd3USnfdfdro1cMNR+s24SQ+DNRu
	 M0jGTbV6hvuUeNhTbRDhahn0mqWP0F4FeXZfpSOatdQRyawdb82oZCeGeiRem47bATg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bozPFQl8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEDE8606D802
	for <bpf@vger.kernel.org>; Tue,  3 Nov 2026 17:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bozPFQl8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FBD71F000C1;
	Tue,  3 Nov 2026 17:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793728303;
	bh=4FUD7GsXyKNirMjwbLGDVe9rCaoYM+dciapenGK+OiY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bozPFQl88uXEzRcYVbQfSnHHIKT3WVXXRW9JK+XNOb4T3zw2d8PM/zCRD47fBenzn
	 NWyjPAWwhUToDPpoHaVNW6VMOnn4IzbFjGXzuWzpdsxT29hOkFFP7A3KJ1k3KaQT+n
	 Xe1zCs5g7/dolQMTpF3BhajIME+hQNt5xk7e+DNISNMoV31xEhL438UfJ4uym25Is9
	 O+/ofgk9zAasBu4aQxTueR0ni2iy6v3mqPK9+IGftWkjtxtwotaCpvXEtX3K0p5bYs
	 mwWvFzxquNo2F9vOnHjF9NwEDZxEVFXsIpSAlF/P0hrACaXC8h4ExhyfRU5Borfty9
	 Ip7H6zYd3IS1A==
Message-ID: <sashiko-outbox-195794@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] bpf: net_sched: reject bpf_throw() in qdisc teardown
 callbacks
Reply-To: sashiko-reviews@lists.linux.dev
To: shaos <shawnq1@163.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <6AEA1AAD.2E7977.08739@m16.mail.163.com>
References: <6AEA1AAD.2E7977.08739@m16.mail.163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 17:51:43 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Low] bpf: net_sched: duplicated st_ops check and lookup in bpf_qdisc_kfu=
nc_filter()
- [Low] bpf: net_sched: raw bug-report boilerplate in commit message
--

commit 4987df9cdbc82b0c8a5dd77111f15b5660ca8808
Author: shaos <shawnq1@163.com>

bpf: net_sched: reject bpf_throw() in qdisc teardown callbacks

This commit updates bpf_qdisc_kfunc_filter() to reject calls to bpf_throw()
from BPF qdisc reset and destroy callbacks so that the generated watchdog
cancellation epilogue is not bypassed during qdisc teardown.

>     bpf: net_sched: reject bpf_throw() in qdisc teardown callbacks
>    =20
>     Hello,
>    =20
>     A BPF qdisc's generated reset/destroy epilogue cancels its watchdog
>     timer.  bpf_throw() unwinds directly to the exception callback and
>     skips that epilogue.  If the timer was armed, qdisc deletion frees the
>     qdisc while the embedded timer remains queued.  Later timer-queue
>     activity accesses the freed qdisc, producing a KASAN slab-use-after-f=
ree
>     and a kernel crash.
>    =20
>     The reproducer registers a BPF qdisc whose dequeue callback arms the
>     watchdog and whose reset/destroy callbacks throw.  Two fresh KASAN bo=
ots
>     reported use-after-free in rb_insert_color on an object allocated by
>     qdisc_alloc() and later freed by qdisc teardown.  An otherwise identi=
cal
>     no-throw control completed deletion cleanly.  The required BPF and
>     network-administration capabilities make this a privileged local kern=
el
>     crash; no privilege escalation or code execution is demonstrated.
>    =20
>     HEAD commit:    c03c1a14507dfaf8b856c2608f9ac216021fc222
>     Git tree:       30fd2ef82912c26cf3a58ad0ba6afc375fa851ac
>     Source version: Linux 7.3
>     Compiler:       gcc 11.4.0, GNU ld 2.38, clang 20 (BPF PoC)
>    =20
>     The console log, full KASAN kernel config, and BPF C reproducer are
>     available from one fixed-revision Gist:
>    =20
>     Console output:
>     https://gist.githubusercontent.com/shaos26/9908a8ddac69e303cb5dcc7099=
58537f/raw/3fa043e43683907bcccacdc80a71b150920049da/console-output.txt
>     Kernel config:
>     https://gist.githubusercontent.com/shaos26/9908a8ddac69e303cb5dcc7099=
58537f/raw/3fa043e43683907bcccacdc80a71b150920049da/kernel-config.txt
>     PoC source:
>     https://gist.githubusercontent.com/shaos26/9908a8ddac69e303cb5dcc7099=
58537f/raw/3fa043e43683907bcccacdc80a71b150920049da/poc.c
>    =20
>     Run this as root in a disposable VM booted with the target kernel,
>     CONFIG_DEBUG_INFO_BTF=3Dy, bpftool, iproute2, clang 20, and libbpf-de=
v.
>     Build each variant against that kernel's BTF; test them on separate
>     fresh boots.  With libbpf headers installed under /usr/include:
>    =20
>         bpftool btf dump file /sys/kernel/btf/vmlinux format c > vmlinux.h
>         CLANG=3D/usr/lib/llvm-20/bin/clang
>         LIBBPF_INC=3D/usr/include
>         "$CLANG" -target bpf -D__TARGET_ARCH_x86 -O2 -g -Wall -Werror \
>           -Wno-missing-declarations -I. -I"$LIBBPF_INC" \
>           -DVARIANT_THROW=3D1 -c poc.c -o qdisc-throw.bpf.o
>         "$CLANG" -target bpf -D__TARGET_ARCH_x86 -O2 -g -Wall -Werror \
>           -Wno-missing-declarations -I. -I"$LIBBPF_INC" \
>           -DVARIANT_THROW=3D0 -c poc.c -o qdisc-control.bpf.o
>    =20
>     Mount bpffs if it is not already mounted, register the matching objec=
t,
>     attach its qdisc to loopback, send one packet to arm the watchdog, and
>     delete the qdisc:
>    =20
>         mkdir -p /sys/fs/bpf
>         mount -t bpf bpffs /sys/fs/bpf 2>/dev/null || true
>         bpftool struct_ops register qdisc-throw.bpf.o /sys/fs/bpf
>         ip link set lo up
>         tc qdisc add dev lo root handle 1: agent31_uaf
>         ping -c 1 -W 1 127.0.0.1
>         tc qdisc del dev lo root
>         sleep 10
>    =20
>     For the separate control boot, register qdisc-control.bpf.o and use
>     qdisc kind agent31_ctl in the same sequence.
>    =20
>     On the vulnerable kernel, the two throw runs reproduced the KASAN UAF;
>     the no-throw control survived.  With the patch below, the verifier
>     rejects bpf_throw() from reset/destroy with -EACCES, before qdisc
>     registration.  The patched control object registered, attached, armed
>     and deleted normally, then survived the watchdog interval.
>    =20
>     Fixes: 7a2dafda950b ("bpf: net_sched: Add a qdisc watchdog timer")
>     Signed-off-by: shaos <shawnq1@163.com>

[Severity: Low]
This isn't a bug, but the commit message includes a conversational greeting
("Hello,"), bug-report metadata headers (HEAD commit, Git tree, Source
version, Compiler), external Gist URLs, and VM build/run shell instructions.

Could the commit message be trimmed to a self-contained description of the
problem and the fix without the bug-report boilerplate and external links?

> diff --git a/net/sched/bpf_qdisc.c b/net/sched/bpf_qdisc.c
> index 5691c13781a8b..20c0b892d2cb1 100644
> --- a/net/sched/bpf_qdisc.c
> +++ b/net/sched/bpf_qdisc.c
> @@ -12,6 +12,7 @@
>  #define QDISC_MOFF_IDX(moff)	(moff / sizeof(void (*)(void)))
> =20
>  static struct bpf_struct_ops bpf_Qdisc_ops;
> +static const struct bpf_verifier_ops bpf_qdisc_verifier_ops;
> =20
>  struct bpf_sched_data {
>  	struct qdisc_watchdog watchdog;

[ ... ]

> @@ -305,20 +307,31 @@ enum qdisc_ops_kf_flags {
>  	QDISC_OPS_KF_COMMON		=3D 0,
>  	QDISC_OPS_KF_ENQUEUE		=3D 1 << 0,
>  	QDISC_OPS_KF_DEQUEUE		=3D 1 << 1,
> +	QDISC_OPS_KF_TEARDOWN		=3D 1 << 2,
>  };
> =20
>  static const u32 qdisc_ops_context_flags[] =3D {
>  	[QDISC_OP_IDX(enqueue)]		=3D QDISC_OPS_KF_ENQUEUE,
>  	[QDISC_OP_IDX(dequeue)]		=3D QDISC_OPS_KF_DEQUEUE,
>  	[QDISC_OP_IDX(init)]		=3D QDISC_OPS_KF_COMMON,
> -	[QDISC_OP_IDX(reset)]		=3D QDISC_OPS_KF_COMMON,
> -	[QDISC_OP_IDX(destroy)]		=3D QDISC_OPS_KF_COMMON,
> +	[QDISC_OP_IDX(reset)]		=3D QDISC_OPS_KF_TEARDOWN,
> +	[QDISC_OP_IDX(destroy)]		=3D QDISC_OPS_KF_TEARDOWN,
>  };
> =20
>  static int bpf_qdisc_kfunc_filter(const struct bpf_prog *prog, u32 kfunc=
_id)
>  {
>  	u32 moff, flags;
> =20
> +	/* bpf_throw() bypasses the generated watchdog-cancellation epilogue. */
> +	if (kfunc_id =3D=3D bpf_qdisc_throw_ids[0] &&
> +	    prog->aux->st_ops &&
> +	    prog->aux->st_ops->verifier_ops =3D=3D &bpf_qdisc_verifier_ops) {
> +		moff =3D prog->aux->attach_st_ops_member_off;
> +		flags =3D qdisc_ops_context_flags[QDISC_MOFF_IDX(moff)];
> +		if (flags & QDISC_OPS_KF_TEARDOWN)
> +			return -EACCES;
> +	}

[Severity: Low]
This isn't a bug, but bpf_Qdisc_ops is already forward-declared in
net/sched/bpf_qdisc.c, and the existing code right below in
bpf_qdisc_kfunc_filter() already checks prog->aux->st_ops against
&bpf_Qdisc_ops and computes moff and flags:

	if (!btf_id_set8_contains(&qdisc_kfunc_ids, kfunc_id))
		return 0;

	if (prog->aux->st_ops !=3D &bpf_Qdisc_ops)
		return -EACCES;

	moff =3D prog->aux->attach_st_ops_member_off;
	flags =3D qdisc_ops_context_flags[QDISC_MOFF_IDX(moff)];

Could bpf_qdisc_kfunc_filter() check prog->aux->st_ops =3D=3D &bpf_Qdisc_ops
instead of adding a forward declaration for bpf_qdisc_verifier_ops, and sha=
re
the moff and flags lookup rather than duplicating it?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/6AEA1AAD.2E7977.087=
39@m16.mail.163.com?part=3D1
