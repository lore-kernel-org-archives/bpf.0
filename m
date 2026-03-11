Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2976733F58D
	for <bpf@vger.kernel.org>; Wed, 11 Mar 2026 15:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773243907; cv=pass; b=l4JMDnsz3WbJGMQqvyoN7w84aivHnXoRUBz39D5izj1R8O7Qj3wXgjqzrMV03rJyfqwtTDJ3j/QW+68kmoQQmgZ8i14lj4/HgLGkvN+YuojDGmAAegjJLt/osWpYoABEyeSTlxpcRTouviCBnKZ086DffL4VPdwplWXmM64BXlU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773243907; c=relaxed/simple;
	bh=Cealpa4wizJ8480d9oSZXFOM7NEwmmWz1/9vguosSAc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jio0c0aKNT4E+UHYhgui0Rc22xB+QWuNrVOMrU7qPIuIpgcnQ8teb04Zdl9BD5aIpak5a8D34xFoMHXXRD0ktnfW+g5oikcTNLple7Yk9+QDbo7uOUL6FgkHflZ21uFT10Fm2fcSnrgZO+StRekGvWymWiK1BgcCi0VYLoemyY0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FbQCxJiR; arc=pass smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FbQCxJiR"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-483487335c2so120402025e9.2
        for <bpf@vger.kernel.org>; Wed, 11 Mar 2026 08:45:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773243904; cv=none;
        d=google.com; s=arc-20240605;
        b=ExrCLiHOKNmRxwwlFpZXMNAyDJOAJ/cUxAhL/hT9H6QVaAUJSVPjbZxeI5YrRvxAlv
         jUTpD4WgSkxuyb7FjOwHNV9qM6uDWabjxlSTHQGn5fmv3PvHj6/gFutwPwc9Dd+0hwtq
         uFObJT1NoiyhGDS5ibsdvdSock6U5Tr8z2G3UNIrmDaOXauOES9lRC1uMBndNt1IaqOq
         eX0/IQsmQUlnBUauUwRC6pR9yhbmR4TjVwAd8zBtgpUzo1IltK+FkTpPNFxAO1apZc2S
         oISbw1KWz4xax6c9pSMuC6R5JiSC6Z1VNuzQCThlNL08G3+b6IvIO10gzlNX54QXFZOs
         IG7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zNclYUuaTkVzzaj4bgQikoxLr3W671Eu3QPe4ldAxiY=;
        fh=lWWA6qSxUCVZBzTp2VYdR4SOD2l/9yZkHekluBuhDzM=;
        b=LNc/wXnvQ0stLJeYZZ3J6cs09814Lihw6cEdtSphPMoC2gPh60jEs+qD/DXFaGD90z
         6Q5zyEVc3eOx1iDiKpEsCyF9wythVMekBqrWKZLs0BMeu94T6d5rhf5BOamALipZ3Ck9
         /PglP8/Oocuu298gnZC+J8kVeqQ4FXtVBhhjnL+ybqSFYsCOTGoUm20LnFZNYIXIyNkS
         Jd5dneOtBxi00lkqU0Wuq+1q2ZrTQICkIe+cPJ0c702flRoADyNhT5eQ8tJwLgYnmPhy
         6alg0dryiZjFXEBKV/nCv8/pku2/w/x7i5qxZQcZy8ZwNOz1ErjfWYg3oVvrHmuTUaqT
         0vSA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773243904; x=1773848704; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zNclYUuaTkVzzaj4bgQikoxLr3W671Eu3QPe4ldAxiY=;
        b=FbQCxJiRxh0p6uVjU7Q2Ntc+AaW3L8DV9W2dfQ0XRv9gBXubLT7H7HG6yxUYoBPN5R
         yk3fkpIFgOTuJA0lf5NpDVjEDiqXW+g16YF30XydPl6i9bw0AcNH7nkZekB1oyrVPz1b
         Yo6GXYrqM8j1rJdYoX3cnbVl0O6k7SH9nlKv/sm+Q8c4F7c96j8VJdBot7EMF3yC9b5x
         azhNDcR9Ft2n22N699sYnbcf9yzF6pHxrrWWovBWr3tc3Olt6DLAA7ddf0lGPFXK6OPK
         lVAMDfnTU0mdFg78idbHZhnChIZoFVgy3uGhkzC24AoC1gBxG8Cc4hDOTVHYEQBsChxz
         XSBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773243904; x=1773848704;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zNclYUuaTkVzzaj4bgQikoxLr3W671Eu3QPe4ldAxiY=;
        b=tJQ73v3x0XoWZNzYKtcmgXf5dmNHrr2RmZzeCmmzFSalrCv+Av5vb7daV1kKoGL/ef
         7ZCoO3uenQRZB7XolDEKCL0kwiOCc9RizFbnzMKdnHG8BRUJzXvV4FurcknsIucoITfP
         HaAUxxe4OBmRos5gv7L6YPHGBAMNNHRVetMAlRKuWGlhBqC6c8JTnS//Tptjbfc6jxv/
         2P0P1gdIV2eaF2IoPOwZD74/sXb0EpDE8ei1FNbM7+UtQS8Dl1EiSmwUCcifzf04G2RJ
         eKAmYHKkuDzx4X9KSrkKilCgdu7v/du1zYA1SbcxAZw1ykLbU2cE7KHSKsKNDIZmijnb
         iWQA==
X-Forwarded-Encrypted: i=1; AJvYcCXgJUVI+/hMcTTOqyGGEejSe+61SvT3YmSo0dILZB7IvdlJYpCw9aigCem40bSEd7oJ+Gg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjkxLcyP7LVpWwaMyVbWD1g6AehHEpjkEgf7DGDz1ywye/0dvl
	811LqWtSTx2PXg3AG4LsJYRsTY78wauM6Nk3s0h0fbQU5ayZos6gkcjhXhCdGp032fxhCrWO22p
	vtEnME/ZfPp0newSPB+vfOMunPy2wjug=
X-Gm-Gg: ATEYQzxxxqbO8fSrxT5bplJWoq0YwFWzQKDHAQF8fEx1H6p8zPJ9G0z00Cy+3dEjAMz
	V9kym0puRrqZ2FdMY305EHCq4+4uE3W22NIUIGerj56Jt3NecqqVMYduESXibOT9QHcRpYs7QZc
	rW5pVpTyP39h9DqEmb101PnhUpbArqMXGZEHBA4idqfaFOPf+4xsIa4AUofeEob14duFMb8BnyO
	Q9PGM881/AjoM8pzO1Wqwp3z9oY8zlf2QO646EkWQ3xaXyByQ7H3Gr7yYjIYA8OCZaMwQ8z7CD6
	IuV6KpPbAvsHPV5PyrSvxkSdEMVvueaE+QWbLzd5xN+Z7Jx5jNKUG5auMATjjqAxREM+37GxfE1
	JsRcg/ZIlzvLaBuNAkMLpPHWgOQ==
X-Received: by 2002:a05:600c:64cc:b0:485:3d3e:1675 with SMTP id
 5b1f17b1804b1-4854b0b97fdmr48721955e9.8.1773243904237; Wed, 11 Mar 2026
 08:45:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260303150639.85007-4-leon.hwang@linux.dev> <47fbcb9aa941b07054bfef30b802d488688fafdf6df889e78b38313a614b98c1@mail.kernel.org>
 <CAP01T74sqmUAL7=PuzFPNbghX+6N_OzrsZiOHcMEMtg01CuL4A@mail.gmail.com>
 <94cfdbdc-833a-4838-af84-e0989e988418@linux.dev> <CAP01T74w4KVMn9bEwpQXrk+bqcUxzb6VW1SQ_QvNy0A4EY-9Jg@mail.gmail.com>
In-Reply-To: <CAP01T74w4KVMn9bEwpQXrk+bqcUxzb6VW1SQ_QvNy0A4EY-9Jg@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 11 Mar 2026 08:44:52 -0700
X-Gm-Features: AaiRm53SchNpZb8YhY7jsacq3OKB-1k2FHbNE7n6phLF0ekD6dALQr59DCuF8EI
Message-ID: <CAADnVQJ=NGUydRq9SghNgoo2a3JZqz4498Sk81t4CfdHm0vSHA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 3/6] bpf: Disallow !kprobe_write_ctx progs
 tail-calling kprobe_write_ctx progs
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Leon Hwang <leon.hwang@linux.dev>, bot+bpf-ci@kernel.org, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, Feng Yang <yangfeng@kylinos.cn>, 
	Menglong Dong <menglong8.dong@gmail.com>, Puranjay Mohan <puranjay@kernel.org>, 
	=?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	Pu Lehui <pulehui@huawei.com>, LKML <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>, kernel-patches-bot@fb.com, 
	Martin KaFai Lau <martin.lau@kernel.org>, Chris Mason <clm@meta.com>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 11, 2026 at 2:22=E2=80=AFAM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> On Wed, 11 Mar 2026 at 07:08, Leon Hwang <leon.hwang@linux.dev> wrote:
> >
> > On 11/3/26 01:23, Kumar Kartikeya Dwivedi wrote:
> > > On Tue, 3 Mar 2026 at 17:04, <bot+bpf-ci@kernel.org> wrote:
> > >>
> > >>> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> > >>> --- a/kernel/bpf/core.c
> > >>> +++ b/kernel/bpf/core.c
> > >>
> > >> [ ... ]
> > >>
> > >>> +     switch (match) {
> > >>> +     case BPF_MAP_OWNER_MATCH_FOR_INIT:
> > >>> +             if (owner->kprobe_write_ctx !=3D aux->kprobe_write_ct=
x)
> > >>> +                     return false;
> > >>> +             break;
> > >>> +
> > >>> +     case BPF_MAP_OWNER_MATCH_FOR_UPDATE:
> > >>> +             if (!owner->kprobe_write_ctx && aux->kprobe_write_ctx=
)
> > >>> +                     return false;
> > >>> +             break;
> > >>> +     }
> > >>
> > >> In the v1 review, Alexei Starovoitov asked for strict conformance
> > >> both ways rather than one-directional validation:
> > >>
> > >>     "Don't be fancy. Require strict conformance both ways
> > >>     in *all* patches."
> > >>
> > >> https://lore.kernel.org/bpf/CAADnVQ+-V0-1i8_+CYpK7G0CnV-2n8e9Szv43yM=
3Az197eL_0A@mail.gmail.com/
> > >>
> > >> The BPF_MAP_OWNER_MATCH_FOR_UPDATE case still uses one-directional
> > >> matching, rejecting only !owner->kprobe_write_ctx && aux->kprobe_wri=
te_ctx
> > >> but allowing the reverse.  Was this an intentional design choice, an=
d
> > >> if so, should the changelog note the disagreement?
> > >>
> > >
> > > Let's follow the approach Alexei outlined, while the changes look ok
> > > to me, let's remove the one way check and just do
> > > owner->kprobe_write_ctx !=3D aux->kprobe_write_ctx, same for the othe=
r
> > > two checks. With this we can also get rid of this INIT vs UPDATE
> > > distinction.
> > >
> > > Other than that I think patches are good, please also test both
> > > directions in the selftest in next respin.
> > >
> >
> > Hi Kumar,
> >
> > Thanks for your review.
> >
> > I agreed that both-ways check could simplify the code. But, the UX coul=
d
> > not be great.
> >
> > Let me explain it with an example.
> >
> > struct {
> >         __uint(type, BPF_MAP_TYPE_PROG_ARRAY);
> >         __uint(max_entries, 1);
> >         __uint(key_size, sizeof(__u32));
> >         __uint(value_size, sizeof(__u32));
> > } jmp_table SEC(".maps");
> >
> > SEC("?kprobe")
> > int prog_a(struct pt_regs *regs)
> > {
> >         regs->ax =3D 0;
> >         bpf_tail_call_static(regs, &jmp_table, 0);
> >         return 0;
> > }
> >
> > SEC("?kprobe")
> > int prog_b(struct pt_regs *regs)
> > {
> >         return 0;
> > }
> >
> > prog_a is kprobe_write_ctx.
> > prog_b is !kprobe_write_ctx. And, it will be added to jmp_table.
> >
> > With both-ways check, prog_b is required to modify regs. I think it's
> > too restrictive for users to use prog_b as tail callee.
> >
> > With one-way-check of this patch, prog_b can be used as tail callee to
> > keep regs as-is.
> >
> > This was what I was concerned about, and the reason why I did not follo=
w
> > Alexei's approach.
>
> I agree but the main question is whether such a case is realistic, are
> we going to have write_ctx programs tail calling this way?
> Tail calls are already pretty rare, thinking more about it extension
> programs are probably also broken wrt checks in this set.
> bpf_check_attach_target is doing none of these things for
> prog_extension =3D true. Nobody reported a problem, so I doubt anyone is
> hitting this.
> It probably also needs to be fixed.
> Since you noticed it, we should close the gap conservatively for now,
> and wait for a real use case to pop up before enabling this one-way.

+1
tail_calls in general hopefully will be deprecated soon.
As soon as we have support for indirect calls there won't be any reason
for tail calls to exist. (other than not breaking current users).
We definitely don't want to open it up further.
So the simplest fix.
