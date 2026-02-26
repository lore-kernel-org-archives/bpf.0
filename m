Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15002313E33
	for <bpf@vger.kernel.org>; Thu, 26 Feb 2026 09:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772099344; cv=none; b=uc6TDyiW+eNx7vUXqdgWHVcPWCx3KPxtcPjd86tpA93Sa95aVhvpVZwx7GWfzP4CAZyDxnnmdW9Numey5i3vX9LnXpURPug4rzyGpCt/djcH4lBUvp+v6HZy2xz9qvAQpDtBFAVPLx/OwXo7G1zfXO7lS6pCr1huBjKeglSju88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772099344; c=relaxed/simple;
	bh=skKRUQ1Nwluvl21Zj9h3lM4FiNgAthVnA5mg5g0ITxc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s766j84dn/yqNoqN3nnkCaHGMuFARCazEPZzT5i8rMikDQY3+zESDHskOkTLpl5YK4JirI8CFGzFXCJYmRc4y295EdHPoD9TjK5fLikf0a6PTYVi/Zra9WzPx+GBczi7byJERwkBuUVGV1LXcMmWXtmncCOb8OzR/nPfQ9hdAxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dvockLN6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dvockLN6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1BD8C4AF09
	for <bpf@vger.kernel.org>; Thu, 26 Feb 2026 09:49:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772099343;
	bh=skKRUQ1Nwluvl21Zj9h3lM4FiNgAthVnA5mg5g0ITxc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=dvockLN6WMO3vCnNhgcRrYo7bLlykiPHPmE6W9LMGwKmucFPY09hLUFq6IdmLgISv
	 Rg2pOSrn4SseRoocESBL6NhEgPAN01xGLQtmbyaFY5YAIrq/aygPG6jfERi0zhlh0y
	 n12SZL7ce4LQEmWAwFMPIb3wev8hYfDv5KR8VLvfjsCKLSFEzo0L/x6fc38O7MKPJm
	 7tr01eL0/xkF66GFmLVIqVO0Z+iceKCTnfK543Q1UAYTyH7hs0a473xPCCgOj1XxYW
	 2LURKmDGH+hXk2tZ+9x3VbXfHjkYas1VyZPT5iUYKa0KRvii1oKKymHy570oXpyArj
	 5l0Itdxh9ra3A==
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-65f9a875eabso1351821a12.0
        for <bpf@vger.kernel.org>; Thu, 26 Feb 2026 01:49:03 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXT/kYLp87GvfST6MbdpwansbWNuTh6dcc1iLlGEYFY8UpXaweq8gbbCGTaEt/O3QeknsU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywuzvhkx30VISkn80O+Dw8vdr9KQBxxbLd+kfZqqPUn5dYwVACP
	tN/yeTM5aM2IIFO3uNnpZt1sIe8KANDOISU+MlfMZ+kfkAGdiONoXNF60iVYuSEUHFy+pl8dUeL
	+Led7rqDvM+k7131HDpwtOhzHOGnUJeA=
X-Received: by 2002:a05:6402:42ce:b0:65c:1f67:d8b1 with SMTP id
 4fb4d7f45d1cf-65ea4efb815mr10901685a12.25.1772099342040; Thu, 26 Feb 2026
 01:49:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260225141404.178823-2-xry111@xry111.site> <CAAhV-H7rF+XwXmp_wfcHFmAgaybQdtzSUDRinFneLrGJKaNQCw@mail.gmail.com>
 <7b5200ab6541cbee3b1a6ba0b7185596a78bed2c.camel@xry111.site>
In-Reply-To: <7b5200ab6541cbee3b1a6ba0b7185596a78bed2c.camel@xry111.site>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Thu, 26 Feb 2026 17:49:04 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6L55D9zmyT5i+janWVwb_2cs1QyNmmaQAoc1XTxApc8w@mail.gmail.com>
X-Gm-Features: AaiRm52AyoBskwuO3IX6qG3jQ1-Jt12eai46HlLkWncgPn-d0zTXH1mf33niP1M
Message-ID: <CAAhV-H6L55D9zmyT5i+janWVwb_2cs1QyNmmaQAoc1XTxApc8w@mail.gmail.com>
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

On Thu, Feb 26, 2026 at 5:32=E2=80=AFPM Xi Ruoyao <xry111@xry111.site> wrot=
e:
>
> On Thu, 2026-02-26 at 17:08 +0800, Huacai Chen wrote:
> > Hi, Ruoyao,
> >
> > On Wed, Feb 25, 2026 at 10:15=E2=80=AFPM Xi Ruoyao <xry111@xry111.site>=
 wrote:
> > >
> > > Fix the warning recently exploited by commit 4ab17e762b34 ("LoongArch=
:
> > > BPF: Use BPF prog pack allocator"):
> > >
> > >     BUG: using smp_processor_id() in preemptible [00000000] code: sys=
temd/1
> > >     caller is larch_insn_text_copy+0x40/0xf0
> > >
> > > Simply changing it to raw_smp_processor_id() is not enough: if preemp=
t
> > > and CPU hotplug happens after raw_smp_processor_id() but before
> > > stop_machine(), the CPU where raw_smp_processor_id() has run may be
> > > offline when stop_machine() and no CPU will run copy_to_kernel_nofaul=
t()
> > > in text_copy_cb().  Thus guard the larch_insn_text_copy() calls with
> > > cpus_read_lock() and change stop_machine() to stop_machine_cpuslocked=
()
> > > to prevent this.
> > >
> > > Fixes: 9fbd18cf4c69 ("LoongArch: BPF: Add dynamic code modification s=
upport")
> > > Signed-off-by: Xi Ruoyao <xry111@xry111.site>
> > > ---
> > >
> > > P.S. I've considered moving the locks inside larch_insn_text_copy() b=
ut
> > > doing so seems not an easy hack.  In bpf_arch_text_poke() obviously t=
he
> > > memcpy() call must be guarded by text_mutex, so we have to leave the
> > > acquire of text_mutex out of larch_insn_text_copy.  But in the entire
> > > kernel the acquire of mutexes is always after cpus_read_lock(), so we
> > > cannot put cpus_read_lock() into larch_insn_text_copy() while leaving
> > > the text_mutex acquire out (or we risk a deadlock due to inconsistent
> > > lock acquire order).  So I'd just submit this as-is to fix the bug an=
d
> > > leave the posssible refactor for others.
> > >
> > >  arch/loongarch/kernel/inst.c | 4 ++--
> > >  arch/loongarch/net/bpf_jit.c | 6 ++++++
> > >  2 files changed, 8 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/arch/loongarch/kernel/inst.c b/arch/loongarch/kernel/ins=
t.c
> > > index bf037f0c6b26..db236e2b34a7 100644
> > > --- a/arch/loongarch/kernel/inst.c
> > > +++ b/arch/loongarch/kernel/inst.c
> > > @@ -263,14 +263,14 @@ int larch_insn_text_copy(void *dst, void *src, =
size_t len)
> > >                 .dst =3D dst,
> > >                 .src =3D src,
> > >                 .len =3D len,
> > > -               .cpu =3D smp_processor_id(),
> > > +               .cpu =3D raw_smp_processor_id(),
> > I think we should keep the old function here, because it can help
> > others to catch new bugs if the code is refactored in future.
>
> Hmm, IIUC using smp_processor_id will still trigger the warning as we've
> only acquired the cpu hotplug lock, instead of disabling the preemption
> completely.
>
> How about adding a lockdep_assert_cpus_held() in this function with an
> explanatory comment?
Does this context really need preemption disabled? Why
lockdep_assert_cpus_held() can silence the warning?

Huacai

> >
>
> --
> Xi Ruoyao <xry111@xry111.site>
>
