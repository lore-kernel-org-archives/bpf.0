Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C62863126AF;
	Thu, 26 Feb 2026 09:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772098334; cv=none; b=dgBDK7oRI7OPbMCA3Y77UtJXkwuLVJGaidC+iAuOCQxUoUJyZJEspzJ3HjSRiXHzJu14AItsOPMLI3OeZgEpO9IrXflb8CH0G/Nw2quIfKru8LOQrN02/xiRf4FVAbUOfrLzLrJI1BrKo9tr2X+my0OvlyagmjS8igsgskqP/zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772098334; c=relaxed/simple;
	bh=m5mtnbJ2X65BR6QuQDkTsPW41IRAVxN/CnC2fL/G7yk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PK4q74Xi+KrLSAsySMCyCO6j8DSPOoQXxfgDmBIGDcd92Htz6b2DMHoHEjLoHgBSDiRVRmsyq7AoDgmvnbl1IrVGjL0ct7EnTD8mtmTDiP3yDnM5AEoIG2qzCTEfnc3n7iX1dQyTTAMmnKprRSQXxkFjuY+G0O7tZNDoIrByjHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=KcC+UUjf; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="KcC+UUjf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xry111.site;
	s=default; t=1772098326;
	bh=m5mtnbJ2X65BR6QuQDkTsPW41IRAVxN/CnC2fL/G7yk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=KcC+UUjfmnPjkrNyweyw2BIqXep1KooO91X6GA60CVkh2gZpo2SoaOXVip3hDirzg
	 dWE6fTPqEMwoszcrx9WwRCofQp+uJ6AYydnCTAldZoi2ucfHZn3copcwY9jCAG1tTg
	 LPkD1N0FbJLZmskqY5/q8obsxYz3OxyrEYtdfp5Q=
Received: from [127.0.0.1] (2607-8700-5500-e873-0000-0000-0000-1001.16clouds.com [IPv6:2607:8700:5500:e873::1001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (secp384r1) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id 289561A44C2;
	Thu, 26 Feb 2026 04:32:00 -0500 (EST)
Message-ID: <7b5200ab6541cbee3b1a6ba0b7185596a78bed2c.camel@xry111.site>
Subject: Re: [PATCH] LoongArch: Fix calling smp_processor_id() in
 preemptible code
From: Xi Ruoyao <xry111@xry111.site>
To: Huacai Chen <chenhuacai@kernel.org>
Cc: WANG Xuerui <kernel@xen0n.name>, Hengqi Chen <hengqi.chen@gmail.com>, 
 Mingcong Bai <jeffbai@aosc.io>, Zixing Liu <liushuyu@aosc.io>, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau	
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu	
 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, John Fastabend	
 <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev	 <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>,  Tiezhu Yang <yangtiezhu@loongson.cn>, George Guo
 <guodongtai@kylinos.cn>, Chenghao Duan	 <duanchenghao@kylinos.cn>,
 loongarch@lists.linux.dev, 	linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org
Date: Thu, 26 Feb 2026 17:31:58 +0800
In-Reply-To: <CAAhV-H7rF+XwXmp_wfcHFmAgaybQdtzSUDRinFneLrGJKaNQCw@mail.gmail.com>
References: <20260225141404.178823-2-xry111@xry111.site>
	 <CAAhV-H7rF+XwXmp_wfcHFmAgaybQdtzSUDRinFneLrGJKaNQCw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-02-26 at 17:08 +0800, Huacai Chen wrote:
> Hi, Ruoyao,
>=20
> On Wed, Feb 25, 2026 at 10:15=E2=80=AFPM Xi Ruoyao <xry111@xry111.site> w=
rote:
> >=20
> > Fix the warning recently exploited by commit 4ab17e762b34 ("LoongArch:
> > BPF: Use BPF prog pack allocator"):
> >=20
> > =C2=A0=C2=A0=C2=A0 BUG: using smp_processor_id() in preemptible [000000=
00] code: systemd/1
> > =C2=A0=C2=A0=C2=A0 caller is larch_insn_text_copy+0x40/0xf0
> >=20
> > Simply changing it to raw_smp_processor_id() is not enough: if preempt
> > and CPU hotplug happens after raw_smp_processor_id() but before
> > stop_machine(), the CPU where raw_smp_processor_id() has run may be
> > offline when stop_machine() and no CPU will run copy_to_kernel_nofault(=
)
> > in text_copy_cb().=C2=A0 Thus guard the larch_insn_text_copy() calls wi=
th
> > cpus_read_lock() and change stop_machine() to stop_machine_cpuslocked()
> > to prevent this.
> >=20
> > Fixes: 9fbd18cf4c69 ("LoongArch: BPF: Add dynamic code modification sup=
port")
> > Signed-off-by: Xi Ruoyao <xry111@xry111.site>
> > ---
> >=20
> > P.S. I've considered moving the locks inside larch_insn_text_copy() but
> > doing so seems not an easy hack.=C2=A0 In bpf_arch_text_poke() obviousl=
y the
> > memcpy() call must be guarded by text_mutex, so we have to leave the
> > acquire of text_mutex out of larch_insn_text_copy.=C2=A0 But in the ent=
ire
> > kernel the acquire of mutexes is always after cpus_read_lock(), so we
> > cannot put cpus_read_lock() into larch_insn_text_copy() while leaving
> > the text_mutex acquire out (or we risk a deadlock due to inconsistent
> > lock acquire order).=C2=A0 So I'd just submit this as-is to fix the bug=
 and
> > leave the posssible refactor for others.
> >=20
> > =C2=A0arch/loongarch/kernel/inst.c | 4 ++--
> > =C2=A0arch/loongarch/net/bpf_jit.c | 6 ++++++
> > =C2=A02 files changed, 8 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/arch/loongarch/kernel/inst.c b/arch/loongarch/kernel/inst.=
c
> > index bf037f0c6b26..db236e2b34a7 100644
> > --- a/arch/loongarch/kernel/inst.c
> > +++ b/arch/loongarch/kernel/inst.c
> > @@ -263,14 +263,14 @@ int larch_insn_text_copy(void *dst, void *src, si=
ze_t len)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 .dst =3D dst,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 .src =3D src,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 .len =3D len,
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 .cpu =3D smp_processor_id(),
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 .cpu =3D raw_smp_processor_id(),
> I think we should keep the old function here, because it can help
> others to catch new bugs if the code is refactored in future.

Hmm, IIUC using smp_processor_id will still trigger the warning as we've
only acquired the cpu hotplug lock, instead of disabling the preemption
completely.

How about adding a lockdep_assert_cpus_held() in this function with an
explanatory comment?
>=20

--=20
Xi Ruoyao <xry111@xry111.site>
