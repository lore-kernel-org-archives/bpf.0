Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A18B3A1E82
	for <bpf@vger.kernel.org>; Thu, 26 Feb 2026 10:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772100983; cv=none; b=ZG2OFlecan0lDKZktBwoc8flT/RJclvLWnSqsiugYnkY9MKzvy95rASwXrK4WzYxgkddYkAKJQcpGejWjEXpP/MdcTbl4n4fpKfjw1S/Ozr8Z2gxtsbobS4dYAztmWw+d5hI6PKKj/8PWeYwtLdgrSzQaZ5w2wL4slat8oHgm/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772100983; c=relaxed/simple;
	bh=iOeOJt2NQsTaNjoh2BjmPE4TjjXDoIl8154gtvq6orc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AGvNCQAiC5edXulv2PUQw6RvkBbYP1DHeTw6e0ItgldW9LC2jKxVMBdtCnQ6LHtXijskit+bVaYuJ4KX2IfvZAH0ivpMYk+5hVaDxZztX91UtY7bM6umG5A9IuukntETqdQ/R05pcRXxNd1rvQO8KiyF0kq9bUOD9GjwZ4JLx0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HR3jx3P3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HR3jx3P3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1B22C4AF0B
	for <bpf@vger.kernel.org>; Thu, 26 Feb 2026 10:16:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772100983;
	bh=iOeOJt2NQsTaNjoh2BjmPE4TjjXDoIl8154gtvq6orc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=HR3jx3P3MtO5tzrUibpdt0LQP+oDL5ip8LVnUF8EfpUmFwdoVkC8I37i2XiuFV0AI
	 BZ10PKrYQsSl5rBf2YCvjqoTgzdr69Ep8ceDX6V+28L/ajOcNNo/PZpY3vEyoOK7eD
	 pLOC8bZhOlqMovI9rPekEBx5Jjt0C6BgpW96mXA+qr7jxkGv+zkozgmC6fchX1DSq+
	 C1bl8LtxMDJCjvf3sa4PhHYojq8+WSdigxvOsCEyuJl1sBPgL9tHm7a6J/oyOFFbRG
	 lmLi2zTaEBjiiAysGp4pShybl7354vJNcSDbxuEB0N56FDAKLSVRkRGq307xc2S1aL
	 ZSRUwTDYaoKeQ==
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-65f71ed7c6cso1314847a12.0
        for <bpf@vger.kernel.org>; Thu, 26 Feb 2026 02:16:22 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVgl6m5eHcsn6esGv3Ug3HTkFHzoYg+PwHUvK0JF5C2+9BMwzN35nQYyqXi5ZDEsFXHPII=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7gDlDHgouD0x6Lyy69S16DvpY1OC1Mm9hq/Gk1HQBALawpUak
	xfBIZ217hTDUK907btp1pLlOE1I9jdxAUjUZ3Ko+ub5EbbdE88/tg7BMJjg3dYy3S+Df2CkvH22
	8qGufAJsRpYJQnoO9Xr6nkQcdQ1BAG0w=
X-Received: by 2002:a05:6402:34d0:b0:65c:3361:5339 with SMTP id
 4fb4d7f45d1cf-65fa47af514mr2402038a12.18.1772100981294; Thu, 26 Feb 2026
 02:16:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260225141404.178823-2-xry111@xry111.site> <CAAhV-H7rF+XwXmp_wfcHFmAgaybQdtzSUDRinFneLrGJKaNQCw@mail.gmail.com>
 <7b5200ab6541cbee3b1a6ba0b7185596a78bed2c.camel@xry111.site>
 <CAAhV-H6L55D9zmyT5i+janWVwb_2cs1QyNmmaQAoc1XTxApc8w@mail.gmail.com> <a3d44d4fcbf3b2c1232169bac23a20db4d89d4c0.camel@xry111.site>
In-Reply-To: <a3d44d4fcbf3b2c1232169bac23a20db4d89d4c0.camel@xry111.site>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Thu, 26 Feb 2026 18:16:23 +0800
X-Gmail-Original-Message-ID: <CAAhV-H5k435VV31F1BBjJ_9tVY_0JdEnUVwJC-cD6Y6rrztsEw@mail.gmail.com>
X-Gm-Features: AaiRm5103TTTPP_x4NXC06z_6J6yG_Ap11mI4Yd1De17uCyWBy-cowZ3p-ntKCg
Message-ID: <CAAhV-H5k435VV31F1BBjJ_9tVY_0JdEnUVwJC-cD6Y6rrztsEw@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: Fix calling smp_processor_id() in preemptible code
To: Xi Ruoyao <xry111@xry111.site>
Cc: WANG Xuerui <kernel@xen0n.name>, Hengqi Chen <hengqi.chen@gmail.com>, 
	Mingcong Bai <jeffbai@aosc.io>, Zixing Liu <liushuyu@aosc.io>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Tiezhu Yang <yangtiezhu@loongson.cn>, 
	George Guo <guodongtai@kylinos.cn>, Chenghao Duan <duanchenghao@kylinos.cn>, 
	loongarch@lists.linux.dev, linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 26, 2026 at 6:05=E2=80=AFPM Xi Ruoyao <xry111@xry111.site> wrot=
e:
>
> On Thu, 2026-02-26 at 17:49 +0800, Huacai Chen wrote:
> > On Thu, Feb 26, 2026 at 5:32=E2=80=AFPM Xi Ruoyao <xry111@xry111.site> =
wrote:
> > >
> > > On Thu, 2026-02-26 at 17:08 +0800, Huacai Chen wrote:
> > > > Hi, Ruoyao,
> > > >
> > > > On Wed, Feb 25, 2026 at 10:15=E2=80=AFPM Xi Ruoyao <xry111@xry111.s=
ite> wrote:
> > > > >
> > > > > Fix the warning recently exploited by commit 4ab17e762b34 ("Loong=
Arch:
> > > > > BPF: Use BPF prog pack allocator"):
> > > > >
> > > > >     BUG: using smp_processor_id() in preemptible [00000000] code:=
 systemd/1
> > > > >     caller is larch_insn_text_copy+0x40/0xf0
> > > > >
> > > > > Simply changing it to raw_smp_processor_id() is not enough: if pr=
eempt
> > > > > and CPU hotplug happens after raw_smp_processor_id() but before
> > > > > stop_machine(), the CPU where raw_smp_processor_id() has run may =
be
> > > > > offline when stop_machine() and no CPU will run copy_to_kernel_no=
fault()
> > > > > in text_copy_cb().  Thus guard the larch_insn_text_copy() calls w=
ith
> > > > > cpus_read_lock() and change stop_machine() to stop_machine_cpuslo=
cked()
> > > > > to prevent this.
> > > > >
> > > > > Fixes: 9fbd18cf4c69 ("LoongArch: BPF: Add dynamic code modificati=
on support")
> > > > > Signed-off-by: Xi Ruoyao <xry111@xry111.site>
> > > > > ---
> > > > >
> > > > > P.S. I've considered moving the locks inside larch_insn_text_copy=
() but
> > > > > doing so seems not an easy hack.  In bpf_arch_text_poke() obvious=
ly the
> > > > > memcpy() call must be guarded by text_mutex, so we have to leave =
the
> > > > > acquire of text_mutex out of larch_insn_text_copy.  But in the en=
tire
> > > > > kernel the acquire of mutexes is always after cpus_read_lock(), s=
o we
> > > > > cannot put cpus_read_lock() into larch_insn_text_copy() while lea=
ving
> > > > > the text_mutex acquire out (or we risk a deadlock due to inconsis=
tent
> > > > > lock acquire order).  So I'd just submit this as-is to fix the bu=
g and
> > > > > leave the posssible refactor for others.
> > > > >
> > > > >  arch/loongarch/kernel/inst.c | 4 ++--
> > > > >  arch/loongarch/net/bpf_jit.c | 6 ++++++
> > > > >  2 files changed, 8 insertions(+), 2 deletions(-)
> > > > >
> > > > > diff --git a/arch/loongarch/kernel/inst.c b/arch/loongarch/kernel=
/inst.c
> > > > > index bf037f0c6b26..db236e2b34a7 100644
> > > > > --- a/arch/loongarch/kernel/inst.c
> > > > > +++ b/arch/loongarch/kernel/inst.c
> > > > > @@ -263,14 +263,14 @@ int larch_insn_text_copy(void *dst, void *s=
rc, size_t len)
> > > > >                 .dst =3D dst,
> > > > >                 .src =3D src,
> > > > >                 .len =3D len,
> > > > > -               .cpu =3D smp_processor_id(),
> > > > > +               .cpu =3D raw_smp_processor_id(),
> > > > I think we should keep the old function here, because it can help
> > > > others to catch new bugs if the code is refactored in future.
> > >
> > > Hmm, IIUC using smp_processor_id will still trigger the warning as we=
've
> > > only acquired the cpu hotplug lock, instead of disabling the preempti=
on
> > > completely.
> > >
> > > How about adding a lockdep_assert_cpus_held() in this function with a=
n
> > > explanatory comment?
> > Does this context really need preemption disabled?
>
> I don't think we really need to disable preemption here.  If a
> preemption happens here we'll just invoke stop_machine from a different
> cpu, and it will still work as long as copy.cpu doesn't get hot removed
> (this is guaranteed by the cpus read lock).
Yes, I think so.

>
> If my understanding is incorrect maybe we'll need to use a lottery
> algorithm like RISC-V.  I think invoking stop_machine with preemption
> disabled will immediately cause a deadlock?
I don't like the RISC-V version, it is hard to understand.

>
> > Why lockdep_assert_cpus_held() can silence the warning?
>
> It cannot, we still need to use raw_smp_processor_id.  It just indicates
> this function needs to hold the cpus read lock so people don't add new
> bugs.
OK, then please add a lockdep_assert_cpus_held().

Huacai

> >
>
> --
> Xi Ruoyao <xry111@xry111.site>
