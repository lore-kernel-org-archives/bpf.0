Received: from mta0.migadu.com (out-191.mta0.migadu.com [91.218.175.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19DC743B6EB
	for <bpf@vger.kernel.org>; Tue, 15 Sep 2026 17:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789495190; cv=none; b=ZUNZpFsQguEnhu6O+oeJCQTc/uf6dzS4Jd9eaRCwGXOczSlNeirneXAw0duepXRR+CgDzh/PpbtUYxmax10oQevynzy6EEceUinkAkqH8CHk5KM184k0uWgKGfAaHDI7OayJHLRJSA6vBXFyCa+aUxg8vMDqnkgsCAXpQBgiHSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789495190; c=relaxed/simple;
	bh=9p/X4aoRUra8MraWL6s4pj6WsjoEJdwlooOV4k5QPdA=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=ueybQxEBMJ+wiOXPPxx6kscqg0mr2R4W0Q3aqAN2v0hUqzAsDiZLrZLa4VKyg28uIgL4ZfCn0g4fs3M7DmlBfYK6xWxpPrUqSsHqeyu/Y8QXtGNJrsVC5kcDcNwbEE5IsPsHFC01qSChNYnU1PZ590gDHlkifnXeE8SBx/eB6HA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=h8qM+l7U; arc=none smtp.client-ip=91.218.175.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="h8qM+l7U"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=9p/X4aoRUra8MraWL6s4pj6WsjoEJdwlooOV4k5QPdA=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789495185; v=1; x=1790099985;
 b=h8qM+l7UmjdfsCJBp9SaOLcqqF78DzFT8Tz57BwVtxZSVpG5vpUtCHTwVdkouH5sinIddH6P
 yyiqPEWFiQ8l8vrw2kKVfBy7fMvNzNN9/UT/xI+iqY8tRivSn138gPtjgc16cD/owCnPbRJNjes
 8SKu5oP87OYXRQGFxcPtF7Vg=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id e8ba2cc259a500bd;
	Tue, 15 Sep 2026 17:59:35 +0000
X-Mizu-Trace-ID: e8ba2cc259a500bd
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 15 Sep 2026 17:59:31 +0000
Message-Id: <DLG33GLTJ1P7.3EVXOHZPN8XLU@linux.dev>
Cc: <bpf@vger.kernel.org>, "Alexei Starovoitov" <ast@kernel.org>, "Daniel
 Borkmann" <daniel@iogearbox.net>, "Andrii Nakryiko" <andrii@kernel.org>,
 "Martin KaFai Lau" <martin.lau@linux.dev>, "Eduard Zingerman"
 <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, "Song
 Liu" <song@kernel.org>, "Yonghong Song" <yonghong.song@linux.dev>, "Jiri
 Olsa" <jolsa@kernel.org>, "KP Singh" <kpsingh@kernel.org>, "John Fastabend"
 <john.fastabend@gmail.com>, "Leon Hwang" <leon.hwang@linux.dev>, "Sechang
 Lim" <rhkrqnwk98@gmail.com>, "Puranjay Mohan" <puranjay@kernel.org>, "Xu
 Kuohai" <xukuohai@huaweicloud.com>, "Ilya Leoshkevich" <iii@linux.ibm.com>,
 "Hari Bathini" <hbathini@linux.ibm.com>, "Christophe Leroy"
 <chleroy@kernel.org>, "Naveen N Rao" <naveen@kernel.org>,
 =?utf-8?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn@kernel.org>, "Pu Lehui"
 <pulehui@huawei.com>, "Tiezhu Yang" <yangtiezhu@loongson.cn>, "Hengqi Chen"
 <hengqi.chen@gmail.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf v2 1/2] bpf: Skip detached progs in trampoline
 images that are still in use
From: "Florent Revest" <florent.revest@linux.dev>
To: "Junseo Lim" <zirajs7@gmail.com>
X-Mailer: aerc 0.17.0
References: <20260912095924.866254-1-florent.revest@linux.dev>
 <20260912095924.866254-2-florent.revest@linux.dev>
 <aqdrwVpanH3WGurX@omen-arch>
In-Reply-To: <aqdrwVpanH3WGurX@omen-arch>

On Mon Sep 14, 2026 at 4:13 AM UTC, Junseo Lim wrote:
> I think there's still a correctness gap here.
>
> > > diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_c=
omp.c
> > > index c18e005a41dbe..9c166bdfbc6a6 100644
> > > --- a/arch/arm64/net/bpf_jit_comp.c
> > > +++ b/arch/arm64/net/bpf_jit_comp.c
> > > @@ -2429,6 +2430,10 @@ static void invoke_bpf_prog(struct jit_ctx *ct=
x, struct bpf_tramp_node *node,
> > >  	enter_prog =3D (u64)bpf_trampoline_enter(p);
> > >  	exit_prog =3D (u64)bpf_trampoline_exit(p);
> > > =20
> > > +	/* nop, patched to skip this prog when it is detached */
> > > +	skip =3D ctx->ro_image + ctx->idx;
> > > +	emit(A64_NOP, ctx);
> > > +
> > >  	if (node->cookie =3D=3D 0) {
> > >  		/* if cookie is zero, one instruction is enough to store it */
> > >  		emit(A64_STR64I(A64_ZR, A64_SP, run_ctx_off + cookie_off), ctx);
> >=20
> > [Severity: High]
> > This is a pre-existing issue, but does this still leave a use-after-fre=
e
> > window between the newly added skip NOP and the __bpf_prog_enter() call=
 in
> > invoke_bpf_prog()?=20
> >=20
> > If a task on a preemptible kernel executes this NOP but is involuntaril=
y
> > preempted before calling __bpf_prog_enter() (where rcu_read_lock or=20
> > rcu_read_lock_trace would be acquired), it hasn't blocked the RCU grace=
=20
> > periods yet.=20
> >=20
> > If another CPU detaches the program, patches the NOP, and drops the pro=
gram=20
> > reference during this preemption, the program could be freed. When the
> > preempted task resumes, could it load the now-freed program pointer and=
 call
> > __bpf_prog_enter(p) on freed memory?
>
> I reproduced the scenario Sashiko pointed out in our environment:
>
>      =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>      BUG: KASAN: vmalloc-out-of-bounds in __bpf_prog_enter_recur+0x3a5/0x=
3f0
>      Read of size 8 at addr ffffc90000055040 by task candidate/110
>
>      CPU: 1 UID: 0 PID: 110 Comm: candidate Not tainted 7.3.0-rc2-00014-g=
15071f2a1263-dirty #2 PREEMPT(full)
>      Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Arch Lin=
ux 1.17.0-2-2 04/01/2014
>      Call Trace:
>       <TASK>
>       dump_stack_lvl+0xb0/0x110
>       print_report+0x14b/0x4a4
>       kasan_report+0x108/0x130
>       ? __bpf_prog_enter_recur+0x3a5/0x3f0
>       ? __bpf_prog_enter_recur+0x3a5/0x3f0
>       __bpf_prog_enter_recur+0x3a5/0x3f0
>       bpf_trampoline_6442509193+0x37/0xf1
>       __x64_sys_futex+0x9/0x410
>       do_syscall_64+0xb0/0x530
>       ? srso_alias_return_thunk+0x5/0xfbef5
>       entry_SYSCALL_64_after_hwframe+0x76/0x7e
>      RIP: 0033:0x42a21d
>      Code: d5 48 8d 3c 0a eb 91 66 0f 1f 44 00 00 f3 0f 1e fa 48 89 f8 48=
 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 =
f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
>      RSP: 002b:00007f1befda9128 EFLAGS: 00000246 ORIG_RAX: 00000000000000=
ca
>      RAX: ffffffffffffffda RBX: 00007f1befda9ce4 RCX: 000000000042a21d
>      RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
>      RBP: 00007f1befda92b0 R08: 0000000000000000 R09: 0000000000000000
>      R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000021
>      R13: 00007ffd400508a0 R14: 0000000000000010 R15: 00007ffd40050997
>       </TASK>
>
>      The buggy address belongs to a vmalloc virtual mapping
>      Memory state around the buggy address:
>       ffffc90000054f00: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
>       ffffc90000054f80: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
>      >ffffc90000055000: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
>                                                 ^
>       ffffc90000055080: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
>       ffffc90000055100: f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8
>      =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> I used SCHED_DEADLINE to increase the likelihood of preemption.
> This seems consistent with the preemption window described above.

Thanks for reproducing! :)

I could make v3 also wait for an RCU tasks grace period before freeing prog=
s.
IIUC, this would wait for those preempted tasks without waiting for sleepin=
g
tasks so this would avoid the issue Alexei saw in v1.
