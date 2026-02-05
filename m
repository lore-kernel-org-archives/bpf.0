Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28EDF13957E
	for <bpf@vger.kernel.org>; Thu,  5 Feb 2026 01:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770253470; cv=none; b=KxycOzifFe/oIJtBYxvjnVI4fM1EDKEV199bGpgv2nlQMzYIEki90C88Ztri5nMO8Ax4QPgLgViqahFlXVxr6I2aiEewUNe5j2f2a+W+HcDcWXjMQwW2O6ooDYJN5Mug8tgvau7G0uHkEj/6EcQST+A3K1k5iyuC4UhriUbw+HA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770253470; c=relaxed/simple;
	bh=at6h9d4/1Bmd5c5iM7sQee3tI4utA79cbmPqS66E/I8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r/hVs3T5/s0qX1g7ldG66KKsziVS6g4XwKFEYKxgL/p/lMg1AxTmEGh8nIJTdvFFQ3Yk2nrAui2GMWh6mAVUmi99X8uDv0Igj5mKAtXmUpg2RPzhBesHgrg2ln8mZETU+kCBcR9nsus9mFq5YrC6GBdERu/wpxDt093dMahRg5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MVDVBSPk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MVDVBSPk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A703AC16AAE
	for <bpf@vger.kernel.org>; Thu,  5 Feb 2026 01:04:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770253469;
	bh=at6h9d4/1Bmd5c5iM7sQee3tI4utA79cbmPqS66E/I8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=MVDVBSPkPvVxGyjX2JUD4tCeyo4Kj7PNMCPKhidcYWCmDiE7NTjmyt7P0pHCWvXwx
	 lFIFOt88f2iICav54LNI0UtYQdaTQJOaH01O7tMD2L/cXSb+3HV/LPoROvpcO0CsHS
	 L/QqZ9X70741xFIFRkPlw68ki5J0D5hgsIrAUPncDInbaCC3ALwwY1dgDoDJBcmNDA
	 l4nq57qa6U51qnAV2MruAUu3lKvkGuJzHZuWDRbktdOCJyAkotNXk8A+R4k0JZUriJ
	 iVtOCDL58p9CaMq7DCsggUhSYD30+XLbIrM8lT6HHN7gvsP0Ld+yjD9shTuBSv/juA
	 z/RVLHSTCww8Q==
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-64c893f3a94so2349635a12.0
        for <bpf@vger.kernel.org>; Wed, 04 Feb 2026 17:04:29 -0800 (PST)
X-Gm-Message-State: AOJu0YwzA5CnCmHIiZN1OhpTAm/SUFSumSLFduCEbKzX1QkBqhEjiRrU
	/3m475gKaRI/V6sswYKOPcdOAzh94cxigEbA0Bw83j3Y1qEulzlbTk1+GZ1jSxJcdHvS1LYsWo5
	sr3GxdcPN9y/ylu8Z72/cBbVCHagFSYs=
X-Received: by 2002:a17:907:968a:b0:b87:8c1:1ea8 with SMTP id
 a640c23a62f3a-b8ebae904d1mr69961566b.7.1770253468199; Wed, 04 Feb 2026
 17:04:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260205002508.808963-1-puranjay@kernel.org> <724c37abf5249d48701e337fca1571de1eee4b18.camel@gmail.com>
In-Reply-To: <724c37abf5249d48701e337fca1571de1eee4b18.camel@gmail.com>
From: Puranjay Mohan <puranjay@kernel.org>
Date: Thu, 5 Feb 2026 01:04:14 +0000
X-Gmail-Original-Message-ID: <CANk7y0hoCGExyyiAGCUfV-5L6Vo_bRV5aBWvUBZBsfj1qFU4qQ@mail.gmail.com>
X-Gm-Features: AZwV_QiQCFt9YdSoNdrJyNU-GgOFoebfNG3EJfHAUMfxbGQ9pU3SaAa90kqqN1Y
Message-ID: <CANk7y0hoCGExyyiAGCUfV-5L6Vo_bRV5aBWvUBZBsfj1qFU4qQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: Remove unnecessary volatile and barrier_var()
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 5, 2026 at 12:33=E2=80=AFAM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Wed, 2026-02-04 at 16:24 -0800, Puranjay Mohan wrote:
>
> [...]
>
> > diff --git a/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf3.c b/to=
ols/testing/selftests/bpf/progs/tailcall_bpf2bpf3.c
> > index 99c8d1d8a187..b50dc92b2126 100644
> > --- a/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf3.c
> > +++ b/tools/testing/selftests/bpf/progs/tailcall_bpf2bpf3.c
> > @@ -14,7 +14,7 @@ struct {
> >  __noinline
> >  int subprog_tail2(struct __sk_buff *skb)
> >  {
> > -     volatile char arr[64] =3D {};
> > +     char arr[64] =3D {};
> >
> >       if (load_word(skb, 0) || load_half(skb, 0))
> >               bpf_tail_call_static(skb, &jmp_table, 10);
>
> I think 'volatile' is used here to force specific function stack size.
> W/o 'volatile' compiler will throw the variable away.
> With 'volatile' one should check what's happening.
> Could you please double check?
>
> [...]

without volatile:

Disassembly of section .text:

0000000000000000 <subprog_tail2>:
; {
       0:       bf 16 00 00 00 00 00 00 r6 =3D r1
       1:       b7 01 00 00 00 00 00 00 r1 =3D 0x0
;       char arr[64] =3D {};
       2:       7b 1a f8 ff 00 00 00 00 *(u64 *)(r10 - 0x8) =3D r1
       3:       7b 1a f0 ff 00 00 00 00 *(u64 *)(r10 - 0x10) =3D r1
       4:       7b 1a e8 ff 00 00 00 00 *(u64 *)(r10 - 0x18) =3D r1
       5:       7b 1a e0 ff 00 00 00 00 *(u64 *)(r10 - 0x20) =3D r1
       6:       7b 1a d8 ff 00 00 00 00 *(u64 *)(r10 - 0x28) =3D r1
       7:       7b 1a d0 ff 00 00 00 00 *(u64 *)(r10 - 0x30) =3D r1
       8:       7b 1a c8 ff 00 00 00 00 *(u64 *)(r10 - 0x38) =3D r1
       9:       7b 1a c0 ff 00 00 00 00 *(u64 *)(r10 - 0x40) =3D r1

with volatile (bpf-next/master)

0000000000000000 <subprog_tail2>:
; {
       0:       bf 16 00 00 00 00 00 00 r6 =3D r1
       1:       b7 01 00 00 00 00 00 00 r1 =3D 0x0
;       volatile char arr[64] =3D {};
       2:       7b 1a f8 ff 00 00 00 00 *(u64 *)(r10 - 0x8) =3D r1
       3:       7b 1a f0 ff 00 00 00 00 *(u64 *)(r10 - 0x10) =3D r1
       4:       7b 1a e8 ff 00 00 00 00 *(u64 *)(r10 - 0x18) =3D r1
       5:       7b 1a e0 ff 00 00 00 00 *(u64 *)(r10 - 0x20) =3D r1
       6:       7b 1a d8 ff 00 00 00 00 *(u64 *)(r10 - 0x28) =3D r1
       7:       7b 1a d0 ff 00 00 00 00 *(u64 *)(r10 - 0x30) =3D r1
       8:       7b 1a c8 ff 00 00 00 00 *(u64 *)(r10 - 0x38) =3D r1
       9:       7b 1a c0 ff 00 00 00 00 *(u64 *)(r10 - 0x40) =3D r1


I see that the commit c8ed66859397 ("selftests/bpf: fix lots of silly
mistakes pointed out by compiler")
added the __sink(arr[sizeof(arr) - 1]);

and after that even without volatile, compiler will not remove it.
