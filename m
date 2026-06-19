Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17EBC2D3739
	for <bpf@vger.kernel.org>; Fri, 19 Jun 2026 04:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781841719; cv=pass; b=jXymYZIIueQWOlphIMEisTpXTEiAZMlEeOUYek1pTgXQ6Hb9rl6wDy1mWVgaF52fyPU6+xD5WzfqrEPVIfkO6LxCYSJx6d8L7fQ50eOKz7OP3Vip1IO9oOzRFckSg8TAI5nw2a3RQDihGPv6qabJTsGH4VGzXxWUzLriVtQGDpo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781841719; c=relaxed/simple;
	bh=fwRsDnAc5niOGnTHzH2fn5ct9gcGK/QUAKeHI+tRGEA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kC/kbYlacNEC9zAiUUeNtkp3d4BNyaJn8e4MEGjEG+Les0hOPxMOtBahujsKNZ5Og63JYmyIl9VrWKLXLkxOUKmQEhK0TMD5TkO1W5zruUVWyNI0CEYTK8wqzPZNUITS/XHBE6gs8LyXNDOKPrmLVJ2Y6JXuWk8ftrAattqj64U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gDlmV8DI; arc=pass smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gDlmV8DI"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-490ace40f4bso16454085e9.3
        for <bpf@vger.kernel.org>; Thu, 18 Jun 2026 21:01:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781841715; cv=none;
        d=google.com; s=arc-20240605;
        b=JZiX1tD36KX0Rz6F1ATES7z5O+I1FAS0XT4tRFH09A5R0lNS9LbZkEbeFwEaZWOBOh
         DGdO2yq603DCMVs+6P5pnoEPZ0FO9Cki9UJmNkIeXciSSYEmVShGNF7aJGJK2vk04HAB
         zEgPNDXe4VTKAXirWVYFx9Ohh0gta5wjHe1AUDAXcz7bjm3NgiJ+FHmDILhKyNTpPROk
         ffi8UYms6jCJHxA3d7EbOGI3YzCmpj2ImJXeTNSAPyimsumRDWM+U3RGe7sF8Z+wkhuB
         belZv4zE0zHi14YG0IG2VW3vgYVfHoF3mq+Tzj8mcVrYl8vmd1BhzYQx6Q2Pwf2D7sYK
         HE5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Y0E2BGEi8Ous0arF7j4+EG1GblU6iI5FWJlzQFdx0Q0=;
        fh=Y4CJSGCXFb89dP2ImhCjlYeMDU0avR6AgGd4BgNZlO4=;
        b=ju49ybIIJxyv6bhJM9PUAfuq/Eqb4q7efjMvpFl2C2E9apO+SVndMUHsxNIr/d3XFN
         1UuuQrWunur+QdCikH0J1Hd9zYkVa3bdt3oWuXVrTuK+6DhM+iM1celC0Cv1kseXiHu+
         mcwwEnrnX3UgeP8AJ6txH3mu9aSUMpFBXRT3x7ypLz9qEs45Ya0NhJJkyaq+OqzjWM0p
         gHDg3P/Xzx7Vh2o1NXq6PVWTVWYUeJbNAawmFoxtMBsd8XDvIO+60sktHyDgkF3h+orJ
         w+ZYTj1tQ3IcYE5TrO/Bj4jf7zmwVFQvJRd0nfmq3jC09ltEUVHQtxQb0Vw9OEaMpRIm
         g7pg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781841715; x=1782446515; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y0E2BGEi8Ous0arF7j4+EG1GblU6iI5FWJlzQFdx0Q0=;
        b=gDlmV8DIUDZxS6VxTX3MJXH2NFv/i12aPGnyaHJvhMc4l3jHr4KVVltWAjHZ7T9KLr
         MlKnJWafMnvxNUYHHtfuZabsidIZNhfUtetQQ3jCPY7TVOUs2HKVt1QiOZlcb+Ai+VJ0
         ndZDmsJ4cgH9sr5anK+p3NEhiJCy7L92CT2v1tSVq442jLwd1Z2DjWtpoGz6mw2qIjdR
         FdWJ4efFVDs5BhyGQrYSvwSZPqQVvxrB6/epR+8bmbchQzC52Km3/g+yr033zkudpr1L
         KybuRD1HwZgtq7/tiYy6SPSX2hFg2QikoaeTwL18WdwQn8uZx8tgjiWow/ASHZvkLXKg
         3DUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781841715; x=1782446515;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Y0E2BGEi8Ous0arF7j4+EG1GblU6iI5FWJlzQFdx0Q0=;
        b=M2rChMca2bu9S23N7uPkzaMcIDzjo7lmeaP4RTCvdAlsaD0uM2oBzU08KbSsGtL1sz
         I/Ur39AIAWNK3pVal1QVycwLL+lFss6Tbb7O1tBRhCDQ+utD16tv5+OLpRE+XBftMZP3
         ehwrHk8ea0ISO4P41B2/J5JwIUjL0vZijL7yaTaJW2rHpPy+IbwH4qgSN6Fi9EZb4f4I
         RRk7QvxbnHjihn3eUYGHZ6tbl5aDW1oeVIA7fJ/ihwh2F337FLT4wPous6ez5+Nh/QF9
         MYGTvVUHD1fJQblav+VfrR9EKJRMCo6XNbqBblkaLPVeoHOPHvKkH+3BshPQu0tIcQZY
         dsmQ==
X-Forwarded-Encrypted: i=1; AFNElJ+ICYYYiqXxUepj4htzE74SIO+5icmmNvUj+ccGf++ahgIrr+9HiTzCiTIpxpXxH0rkbWs=@vger.kernel.org
X-Gm-Message-State: AOJu0YypbqgJSnf9Cu0eccdfF3mXXDEk5NX++XftJLlMfctkOwRT63Sa
	QTU8eAfFuy8yJIrzeej55C7enUF9NSdu39isT+Au/Kplp5lIrxFstuZ2dPaqCygKOcXFj8rh414
	CRYeWw3bu3T4s56GYAH9KgGLF1oegIkQ=
X-Gm-Gg: AfdE7cl9JhmvxmvBVYYrJ9dp4GoIEHCzQFmJ6Pc1f77mEN7KAx4hY78nwHnsWLnvyOv
	J5F0Afd8Rq4CIMbH9dGIY6JYriXBajJ34mH5rWsYE497alfq40HK1yd3zWLPblvbS0D+ePAWVt0
	mFXcSaGXWgaH6hhIbruDykeCdOam5Vp6VhVC/ZFeZgXL+lz+Ejztl/DD4O4/qh1vgJFcCVWU247
	GNoX8hAcjQyoqmQygi0rsmA+v2gvdwjAQ+VILTkse44YtqKUjsgCpN9ft1DG8XHHKpP9wNg3qIC
	u5f/QRifs/ogejoTeyQ943Pu84HVzg==
X-Received: by 2002:a05:600c:3b15:b0:490:d38c:7836 with SMTP id
 5b1f17b1804b1-4923ef47e73mr44241975e9.3.1781841715135; Thu, 18 Jun 2026
 21:01:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1781194510.git.jt26wzz@gmail.com> <ajCB9jXBzPyaDNSQ@mail.gmail.com>
 <ajC3d44N4s0sdEBB@u94a>
In-Reply-To: <ajC3d44N4s0sdEBB@u94a>
From: Zhenzhong Wu <jt26wzz@gmail.com>
Date: Fri, 19 Jun 2026 12:01:42 +0800
X-Gm-Features: AVVi8Cf7iL51P--qp-3wZoU9QN6Amkhq8hfkalKnWfrpZqDvrmocLBrbsj5eS2E
Message-ID: <CALgi0XmiGcmgaRgRKeybV3Hn0nb+vL=bdTShGv+eVT=5e2tiAA@mail.gmail.com>
Subject: Re: [PATCH stable 6.6.y v3 0/4] bpf: linked scalar precision fixes
To: Shung-Hsi Yu <shung-hsi.yu@suse.com>
Cc: Sasha Levin <sashal@kernel.org>, Paul Chaignon <paul.chaignon@gmail.com>, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, john.fastabend@gmail.com, andrii@kernel.org, 
	martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev, 
	kpsingh@kernel.org, haoluo@google.com, jolsa@kernel.org, 
	menglong8.dong@gmail.com, eddyz87@gmail.com, stable@vger.kernel.org, 
	mykolal@fb.com, tamird@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Sorry for the late reply.

For v3, I only ran the targeted test_progs coverage and missed the legacy
test_verifier coverage, so I did not catch the expectation mismatch in
precise.c. Thanks for the detailed analysis. I have rechecked this and will
send v4 shortly with the precise.c fix included.




On Tue, Jun 16, 2026 at 1:22=E2=80=AFPM Shung-Hsi Yu <shung-hsi.yu@suse.com=
> wrote:
>
> On Tue, Jun 16, 2026 at 12:51:34AM +0200, Paul Chaignon wrote:
> > On Mon, Jun 15, 2026 at 12:58:37AM +0800, Zhenzhong Wu wrote:
> > > Hi,
> > >
> > > This v3 targets 6.6.y and changes the backport strategy based on revi=
ew
> > > feedback on v2.
> >
> > [...]
> >
> > > Relevant QEMU selftest results on 6.6.y with this backport:
> > >
> > >   verifier_scalar_ids passed all 18 subtests, including the newly
> > >   backported linked-scalar precision tests and the related
> > >   check_ids_in_regsafe tests.
> >
> > The first patch in this backport series is actually breaking the
> > "precise: test 1" selftest from test_verifier. You can see the full
> > error at [1]. I haven't yet checked if it's the test or the backport
> > that needs to be adjusted.
>
> I had a quick look, and believe it was that test that needs to be
> adjusted to include r9 into the precise register set.
>
> So unless Sasha have other preference, I suggest Zhenzhong send a v4,
> with changes to tools/testing/selftests/bpf/verifier/precise.c
> (including "r9" the the expected verifier output) merged into "bpf:
> Track equal scalars history on per-instruction level".
>
> ---
>
> The program under test is:
>
>   00: BPF_MOV64_IMM(BPF_REG_0, 1),
>   01: BPF_LD_MAP_FD(BPF_REG_6, 0),
>   03: BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
>   04: BPF_MOV64_REG(BPF_REG_2, BPF_REG_FP),
>   05: BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
>   06: BPF_ST_MEM(BPF_DW, BPF_REG_FP, -8, 0),
>   07: BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
>   08: BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
>   09: BPF_EXIT_INSN(),
>
>   10: BPF_MOV64_REG(BPF_REG_9, BPF_REG_0),
>
>   11: BPF_MOV64_REG(BPF_REG_1, BPF_REG_6),
>   12: BPF_MOV64_REG(BPF_REG_2, BPF_REG_FP),
>   13: BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, -8),
>   14: BPF_EMIT_CALL(BPF_FUNC_map_lookup_elem),
>   15: BPF_JMP_IMM(BPF_JNE, BPF_REG_0, 0, 1),
>   16: BPF_EXIT_INSN(),
>
>   17: BPF_MOV64_REG(BPF_REG_8, BPF_REG_0),
>
>   18: BPF_ALU64_REG(BPF_SUB, BPF_REG_9, BPF_REG_8), /* map_value_ptr -=3D=
 map_value_ptr */
>   19: BPF_MOV64_REG(BPF_REG_2, BPF_REG_9),
>   20: BPF_JMP_IMM(BPF_JLT, BPF_REG_2, 8, 1),
>   21: BPF_EXIT_INSN(),
>
>   22: BPF_ALU64_IMM(BPF_ADD, BPF_REG_2, 1), /* R2=3Dscalar(umin=3D1, umax=
=3D8) */
>   23: BPF_MOV64_REG(BPF_REG_1, BPF_REG_FP),
>   24: BPF_ALU64_IMM(BPF_ADD, BPF_REG_1, -8),
>   25: BPF_MOV64_IMM(BPF_REG_3, 0),
>   26: BPF_EMIT_CALL(BPF_FUNC_probe_read_kernel),
>   27: BPF_EXIT_INSN(),
>
> The test was expecting the following line in the verifier log that was
> shown during the backtracking start at instruction 26 (call
> bpf_probe_read_kernel#113)
>
>   mark_precise: frame0: regs=3Dr2 stack=3D before 20: (a5) if r2 < 0x8 go=
to pc+1
>   mark_precise: frame0: parent state regs=3Dr2 stack=3D: ...
>   mark_precise: frame0: last_idx 19 first_idx 10 ...
>
> But after applying the patchset, we now got an additional register r9 in
> the precise set:
>
>   mark_precise: frame0: regs=3Dr2 stack=3D before 20: (a5) if r2 < 0x8 go=
to pc+1
>   mark_precise: frame0: parent state regs=3Dr2,r9 stack=3D: ....
>   mark_precise: frame0: last_idx 19 first_idx 10 ...
>
> The additional r9 in the precise set seems actually correct, this is
> because r2 and r9 share the same scalar ID at instruction 20 (before the
> link got broken in instruction 21), and hence at that point, both
> register should be marked as precise.
>
> ---
>
> In upstream the test already has the expected verifier log to include
> r9, and hence no failure, but it simply comes from the fact that r2 and
> r9 maintain a link even after instruction 22 (r2 +=3D 1).
>
>   commit 98d7ca374ba4b39e7535613d40e159f09ca14da2
>   Author: Alexei Starovoitov <ast@kernel.org>
>   Date:   Wed Jun 12 18:38:13 2024 -0700
>
>       bpf: Track delta between "linked" registers.
>   ...
>   --- a/tools/testing/selftests/bpf/verifier/precise.c
>   +++ b/tools/testing/selftests/bpf/verifier/precise.c
>   @@ -39,12 +39,12 @@
>         .result =3D VERBOSE_ACCEPT,
>         .errstr =3D
>         "mark_precise: frame0: last_idx 26 first_idx 20\
>   -     mark_precise: frame0: regs=3Dr2 stack=3D before 25\
>   -     mark_precise: frame0: regs=3Dr2 stack=3D before 24\
>   -     mark_precise: frame0: regs=3Dr2 stack=3D before 23\
>   -     mark_precise: frame0: regs=3Dr2 stack=3D before 22\
>   -     mark_precise: frame0: regs=3Dr2 stack=3D before 20\
>   -     mark_precise: frame0: parent state regs=3Dr2 stack=3D:\
>   +     mark_precise: frame0: regs=3Dr2,r9 stack=3D before 25\
>   +     mark_precise: frame0: regs=3Dr2,r9 stack=3D before 24\
>   +     mark_precise: frame0: regs=3Dr2,r9 stack=3D before 23\
>   +     mark_precise: frame0: regs=3Dr2,r9 stack=3D before 22\
>   +     mark_precise: frame0: regs=3Dr2,r9 stack=3D before 20\
>   +     mark_precise: frame0: parent state regs=3Dr2,r9 stack=3D:\
>         mark_precise: frame0: last_idx 19 first_idx 10\
>         mark_precise: frame0: regs=3Dr2,r9 stack=3D before 19\
>         mark_precise: frame0: regs=3Dr9 stack=3D before 18\
>   ...
>
> ---
>
> Full test log below
>
>   #492/p precise: test 1 FAIL
>   Unexpected verifier log!
>   EXP: mark_precise: frame0: parent state regs=3Dr2 stack=3D:
>   RES:
>   func#0 @0
>   0: R1=3Dctx(off=3D0,imm=3D0) R10=3Dfp0
>   0: (b7) r0 =3D 1                        ; R0_w=3D1
>   1: (18) r6 =3D 0xffff9eb644619000       ; R6_w=3Dmap_ptr(off=3D0,ks=3D4=
,vs=3D48,imm=3D0)
>   3: (bf) r1 =3D r6                       ; R1_w=3Dmap_ptr(off=3D0,ks=3D4=
,vs=3D48,imm=3D0) R6_w=3Dmap_ptr(off=3D0,ks=3D4,vs=3D48,imm=3D0)
>   4: (bf) r2 =3D r10                      ; R2_w=3Dfp0 R10=3Dfp0
>   5: (07) r2 +=3D -8                      ; R2_w=3Dfp-8
>   6: (7a) *(u64 *)(r10 -8) =3D 0          ; R10=3Dfp0 fp-8_w=3D00000000
>   7: (85) call bpf_map_lookup_elem#1    ; R0_w=3Dmap_value_or_null(id=3D1=
,off=3D0,ks=3D4,vs=3D48,imm=3D0)
>   8: (55) if r0 !=3D 0x0 goto pc+1        ; R0_w=3D0
>   9: (95) exit
>
>   from 8 to 10: R0=3Dmap_value(off=3D0,ks=3D4,vs=3D48,imm=3D0) R6=3Dmap_p=
tr(off=3D0,ks=3D4,vs=3D48,imm=3D0) R10=3Dfp0 fp-8=3D0000mmmm
>   10: R0=3Dmap_value(off=3D0,ks=3D4,vs=3D48,imm=3D0) R6=3Dmap_ptr(off=3D0=
,ks=3D4,vs=3D48,imm=3D0) R10=3Dfp0 fp-8=3D0000mmmm
>   10: (bf) r9 =3D r0                      ; R0=3Dmap_value(off=3D0,ks=3D4=
,vs=3D48,imm=3D0) R9_w=3Dmap_value(off=3D0,ks=3D4,vs=3D48,imm=3D0)
>   11: (bf) r1 =3D r6                      ; R1_w=3Dmap_ptr(off=3D0,ks=3D4=
,vs=3D48,imm=3D0) R6=3Dmap_ptr(off=3D0,ks=3D4,vs=3D48,imm=3D0)
>   12: (bf) r2 =3D r10                     ; R2_w=3Dfp0 R10=3Dfp0
>   13: (07) r2 +=3D -8                     ; R2_w=3Dfp-8
>   14: (85) call bpf_map_lookup_elem#1   ; R0_w=3Dmap_value_or_null(id=3D2=
,off=3D0,ks=3D4,vs=3D48,imm=3D0)
>   15: (55) if r0 !=3D 0x0 goto pc+1       ; R0_w=3D0
>   16: (95) exit
>
>   from 15 to 17: R0_w=3Dmap_value(off=3D0,ks=3D4,vs=3D48,imm=3D0) R6=3Dma=
p_ptr(off=3D0,ks=3D4,vs=3D48,imm=3D0) R9_w=3Dmap_value(off=3D0,ks=3D4,vs=3D=
48,imm=3D0) R10=3Dfp0 fp-8=3D0000mmmm
>   17: R0_w=3Dmap_value(off=3D0,ks=3D4,vs=3D48,imm=3D0) R6=3Dmap_ptr(off=
=3D0,ks=3D4,vs=3D48,imm=3D0) R9_w=3Dmap_value(off=3D0,ks=3D4,vs=3D48,imm=3D=
0) R10=3Dfp0 fp-8=3D0000mmmm
>   17: (bf) r8 =3D r0                      ; R0_w=3Dmap_value(off=3D0,ks=
=3D4,vs=3D48,imm=3D0) R8_w=3Dmap_value(off=3D0,ks=3D4,vs=3D48,imm=3D0)
>   18: (1f) r9 -=3D r8                     ; R8_w=3Dmap_value(off=3D0,ks=
=3D4,vs=3D48,imm=3D0) R9_w=3Dscalar()
>   19: (bf) r2 =3D r9                      ; R2=3Dscalar(id=3D3) R9=3Dscal=
ar(id=3D3)
>   20: (a5) if r2 < 0x8 goto pc+1        ; R2=3Dscalar(id=3D3,umin=3D8)
>   21: (95) exit
>
>   from 20 to 22: R0=3Dmap_value(off=3D0,ks=3D4,vs=3D48,imm=3D0) R2=3Dscal=
ar(id=3D3,umax=3D7,var_off=3D(0x0; 0x7)) R6=3Dmap_ptr(off=3D0,ks=3D4,vs=3D4=
8,imm=3D0) R8=3Dmap_value(off=3D0,ks=3D4,vs=3D48,imm=3D0) R9=3Dscalar(id=3D=
3,umax=3D7,var_off=3D(0x0; 0x7)) R10=3Dfp0 fp-8=3D0000mmmm
>   22: R0=3Dmap_value(off=3D0,ks=3D4,vs=3D48,imm=3D0) R2=3Dscalar(id=3D3,u=
max=3D7,var_off=3D(0x0; 0x7)) R6=3Dmap_ptr(off=3D0,ks=3D4,vs=3D48,imm=3D0) =
R8=3Dmap_value(off=3D0,ks=3D4,vs=3D48,imm=3D0) R9=3Dscalar(id=3D3,umax=3D7,=
var_off=3D(0x0; 0x7)) R10=3Dfp0 fp-8=3D0000mmmm
>   22: (07) r2 +=3D 1                      ; R2_w=3Dscalar(umin=3D1,umax=
=3D8,var_off=3D(0x0; 0xf))
>   23: (bf) r1 =3D r10                     ; R1_w=3Dfp0 R10=3Dfp0
>   24: (07) r1 +=3D -8                     ; R1_w=3Dfp-8
>   25: (b7) r3 =3D 0                       ; R3_w=3D0
>   26: (85) call bpf_probe_read_kernel#113
>   mark_precise: frame0: last_idx 26 first_idx 20 subseq_idx -1
>   mark_precise: frame0: regs=3Dr2 stack=3D before 25: (b7) r3 =3D 0
>   mark_precise: frame0: regs=3Dr2 stack=3D before 24: (07) r1 +=3D -8
>   mark_precise: frame0: regs=3Dr2 stack=3D before 23: (bf) r1 =3D r10
>   mark_precise: frame0: regs=3Dr2 stack=3D before 22: (07) r2 +=3D 1
>   mark_precise: frame0: regs=3Dr2 stack=3D before 20: (a5) if r2 < 0x8 go=
to pc+1
>   mark_precise: frame0: parent state regs=3Dr2,r9 stack=3D:  R0_rw=3Dmap_=
value(off=3D0,ks=3D4,vs=3D48,imm=3D0) R2_rw=3DPscalar(id=3D3) R6=3Dmap_ptr(=
off=3D0,ks=3D4,vs=3D48,imm=3D0) R8_w=3Dmap_value(off=3D0,ks=3D4,vs=3D48,imm=
=3D0) R9_w=3DPscalar(id=3D3) R10=3Dfp0 fp-8_r=3D0000mmmm
>   mark_precise: frame0: last_idx 19 first_idx 10 subseq_idx 20
>   mark_precise: frame0: regs=3Dr2,r9 stack=3D before 19: (bf) r2 =3D r9
>   mark_precise: frame0: regs=3Dr9 stack=3D before 18: (1f) r9 -=3D r8
>   mark_precise: frame0: regs=3Dr8,r9 stack=3D before 17: (bf) r8 =3D r0
>   mark_precise: frame0: regs=3Dr0,r9 stack=3D before 15: (55) if r0 !=3D =
0x0 goto pc+1
>   mark_precise: frame0: regs=3Dr0,r9 stack=3D before 14: (85) call bpf_ma=
p_lookup_elem#1
>   mark_precise: frame0: regs=3Dr9 stack=3D before 13: (07) r2 +=3D -8
>   mark_precise: frame0: regs=3Dr9 stack=3D before 12: (bf) r2 =3D r10
>   mark_precise: frame0: regs=3Dr9 stack=3D before 11: (bf) r1 =3D r6
>   mark_precise: frame0: regs=3Dr9 stack=3D before 10: (bf) r9 =3D r0
>   mark_precise: frame0: parent state regs=3D stack=3D:  R0_rw=3Dmap_value=
(off=3D0,ks=3D4,vs=3D48,imm=3D0) R6_rw=3Dmap_ptr(off=3D0,ks=3D4,vs=3D48,imm=
=3D0) R10=3Dfp0 fp-8_rw=3D0000mmmm
>   27: R0_w=3Dscalar()
>   27: (95) exit
>   processed 27 insns (limit 1000000) max_states_per_insn 0 total_states 2=
 peak_states 2 mark_read 1
>
> [...]
