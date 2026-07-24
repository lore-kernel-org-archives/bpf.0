Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAD713CF1F0
	for <bpf@vger.kernel.org>; Fri, 24 Jul 2026 08:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784880947; cv=none; b=Roab4cj22256KOS8dr8GdGNg8bbI5hAf6h2yXTDahtvGAO3V97Ra7XgGb3XeTI7ilfbqQYWL0JKDUGChrV7272QtYQvWxtYP6MFrwn97q+aZs4TjgVu6qLsYrLr+Kwc3rhOtgs16bmpRIdCPe3nM179fQ7jTpA59Z0db6zCH92c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784880947; c=relaxed/simple;
	bh=dFS3SwniN56yN953lBsYRwJV4Ml4pZslzmVnQcgYyiw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oFuTFcTHmRsZ5u/iyd0hOR8zpbg1udbdyA0QpfgrQeAsnRvKEayCXfKFMwN1qyhZ40xyn8HTY/YMe9z+P5jny9x011npzVP8Ze38iTATkjWLtZGI78WCbVnh8vdV44ksKVOKxSlERQxvDlEd0nesN6LahmtY0zbLqXeMcvOc1mE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CXDMnSPR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CXDMnSPR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70FA41F0155A
	for <bpf@vger.kernel.org>; Fri, 24 Jul 2026 08:15:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784880930;
	bh=9XXBW7U+B1ikb/dzSlj+P+GEinyJBTwSTBEBBDOINL4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=CXDMnSPRMBG/Jea/TZwLnSr3TFArZis60Y7Oal7c7NUuCCruPRDTCz92QaZUxYmM2
	 rgx2CCx/q6VXsv1rLl7R6yoeuSlRG9JUXNJDV4hRTvAzcbdq7ZmLSH5UGSkH6jYa/p
	 tVjC4Ax8lftOhAF/tTus42oRsO7cF+93vBqg5ZUVEAgWX8debmOjCgJo1mtWEiHiEC
	 iJeLIvUdQgpD68y5Aan4cTJKEsUtGDZm9s0984YkEtgpDQ0HKWT/AXpC/E8fw3VHRb
	 GsBSNCchI2yY9dEUMVjqRTJ1g5tbMZ11gBWdSYAEn8s+ozy1udcN7waJ5dY03kIPyg
	 mFpJM6MsvQXTw==
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-69c20ba892eso1902758a12.1
        for <bpf@vger.kernel.org>; Fri, 24 Jul 2026 01:15:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RrVKl6PBcxnMz7Fy/ak4Eg181a/xOSJs6YvedxCulci/Zp1CDzF3FzsmtPSZ+2XyF5OG3M=@vger.kernel.org
X-Gm-Message-State: AOJu0YycNFv8644kbEEMaBohQUgzXSsFOHxzaJvU1JhyFD0TSE3cSNx1
	LpINfjKM/0LK5h5eNxzLx2VVbr8b8TQX336XzZBgiQXACix1MsNa0Eq74tsa+lkh288OsKq/9CJ
	mdkWpRZ7YeqTmjE8Gzvu8E5Ac5IWelTg=
X-Received: by 2002:a17:907:70a:b0:c15:c323:36e5 with SMTP id
 a640c23a62f3a-c1c536b9134mr271178666b.10.1784880928984; Fri, 24 Jul 2026
 01:15:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260722112754.1615201-1-pulehui@huaweicloud.com>
 <20260722112754.1615201-3-pulehui@huaweicloud.com> <d856fb28-273e-99ec-f1dd-426ea087ea24@loongson.cn>
In-Reply-To: <d856fb28-273e-99ec-f1dd-426ea087ea24@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Fri, 24 Jul 2026 16:15:55 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7CQVz45B0jFQpyo-A1-DHR+3pQ2-aRcquQ4Ak=y_+kKA@mail.gmail.com>
X-Gm-Features: AUfX_mzqiUuV55_MiU1_fajGusPeXXKUGeSkSaSNeO6ISe29gAe7Gb7ZDog0mPQ
Message-ID: <CAAhV-H7CQVz45B0jFQpyo-A1-DHR+3pQ2-aRcquQ4Ak=y_+kKA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/4] LoongArch: BPF: Fix memory leak in bpf_jit_free
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: Pu Lehui <pulehui@huaweicloud.com>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Yonghong Song <yonghong.song@linux.dev>, 
	Song Liu <song@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	Puranjay Mohan <puranjay@kernel.org>, Xu Kuohai <xukuohai@huaweicloud.com>, 
	Hengqi Chen <hengqi.chen@gmail.com>, Pu Lehui <pulehui@huawei.com>, loongarch@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 24, 2026 at 4:05=E2=80=AFPM Tiezhu Yang <yangtiezhu@loongson.cn=
> wrote:
>
> Cc: Huacai Chen <chenhuacai@kernel.org> loongarch@lists.linux.dev
>
> On 2026/7/22 =E4=B8=8B=E5=8D=887:27, Pu Lehui wrote:
> > From: Pu Lehui <pulehui@huawei.com>
> >
> > When bpf_int_jit_compile() is called for subprograms, it returns early
> > during the first pass (!prog->is_func || extra_pass is false), keeping
> > ctx->offset alive for the subsequent extra pass.
> >
> > If JIT compilation fails for a later subprogram, the BPF core aborts an=
d
> > calls bpf_jit_free() to clean up the first subprogram. However,
> > bpf_jit_free() fails to free jit_data->ctx.offset, which causes a memor=
y
> > leak of the JIT context offsets array.
> >
> > Fix this by adding the missing kvfree(jit_data->ctx.offset) in
> > bpf_jit_free().
> >
> > Fixes: 4ab17e762b34 ("LoongArch: BPF: Use BPF prog pack allocator")
> > Reported-by: Sashiko <sashiko-bot@kernel.org>
> > Signed-off-by: Pu Lehui <pulehui@huawei.com>
> > ---
> >   arch/loongarch/net/bpf_jit.c | 1 +
> >   1 file changed, 1 insertion(+)
> >
> > diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.=
c
> > index 2738b4db1165..3d3ed1677d01 100644
> > --- a/arch/loongarch/net/bpf_jit.c
> > +++ b/arch/loongarch/net/bpf_jit.c
> > @@ -2361,6 +2361,7 @@ void bpf_jit_free(struct bpf_prog *prog)
> >                */
> >               if (jit_data) {
> >                       bpf_jit_binary_pack_finalize(jit_data->ro_header,=
 jit_data->header);
> > +                     kvfree(jit_data->ctx.offset);
> >                       kfree(jit_data);
> >               }
> >               hdr =3D bpf_jit_binary_pack_hdr(prog);
> >
>
> Here is the link:
> https://lore.kernel.org/bpf/20260722112754.1615201-3-pulehui@huaweicloud.=
com/
>
> Acked-by: Tiezhu Yang <yangtiezhu@loongson.cn>
Applied, thanks.

Huacai
>
> Thanks,
> Tiezhu
>
>
