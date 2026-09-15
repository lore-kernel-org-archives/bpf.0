Received: from mail-oo2-f42.google.com (mail-oo2-f42.google.com [74.125.231.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6938379EE0
	for <bpf@vger.kernel.org>; Tue, 15 Sep 2026 22:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.231.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789511569; cv=pass; b=LQgHpUHvp1NiPx57oDBoBhFkIJrHq7KjLIQwVbO0DucnXp7ZV3gJUUTET4JYQBxv3BGf4g6bg03L2E2xcxchA+qvN3b3iZrZd2DQOkdpoQ2twgNskYtHd5+Z3HtEyWtPnuD7ZqE2oePhBnLsp8uglo2jSmyOjtALiyMZchS8S3A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789511569; c=relaxed/simple;
	bh=lq1jEWNt/n5Qy/SzVCBrmS2Rd3kPStEZmdmxTeU1Cjo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sXg2Ci/E6qqleZd+lItOtHBWBsXnEa/sqm+k0N6i00BW1eNzWKIbcG1HgYWwBFEIHqTAi8QhW3wT4Xg8vIPkO1dOLCFqP5Ei25C0OeNgONXFhfXxT/GYvl/xs8i9GgqjXbGTYmK1u34MOKcBiijYajCfNkuuvMiZ397UVOZ1ukM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GROmno6f; arc=pass smtp.client-ip=74.125.231.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GROmno6f"
Received: by mail-oo2-f42.google.com with SMTP id 46e09a7af769-804ef461aedso158866a34.0
        for <bpf@vger.kernel.org>; Tue, 15 Sep 2026 15:32:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789511566; cv=none;
        d=google.com; s=arc-20260327;
        b=s+6ekoboPxF0HRkv/9RhlVXda1TtBOFLC/SkZEzo9n3/Q9IEq1h02VT7i+T/Qk29Q5
         CJplYcsH5iys3j8ssr/2aef2mYPldXEP15hkOjbnCLnsajVUidRFkMrNG3oa7sttcYrT
         4tVYr9sUI5N+UaUmPlYTkNkNILycrivNDPlC2Ctp6lU5H308U5LohyeBQsXTgxtens7x
         M022obg7gAWEqB/4FdVgcN05wmB5ZThQIGL/7JptIGrtCv3JwZa3GPo+Vh+nmAFiI9cq
         bXXxWim8BLGQayF2/pruiw2g1sp6IIERliFyRgDG+H+EIkVg4I46pTJrnPdcvVtw23KP
         S4YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=043e4j6xvnLvXB9EcyfoGhkhem3s0uOnXWL92QwnUpk=;
        fh=PVF5hOV3lFVkYzH+em3TPzA8DUX1nPTQFNVMrTIZklE=;
        b=ab7fV8pAtw1EB/fcu/XZxBwROMJbwU1jqlIWfZDdCr3RpbrxOvj7DmbLYirsyafe7R
         v8eUq6eJlzAgn7Ayd4ob1eC1FvtApVM/k3NysR1I1lojL1ncXTosDuyPEroDRi1XsMpn
         iY0u9a8bYiX4XFtdBFo39GItCIAfLTOLXpURkzEzDpYg+6lSONKa2Ln4ZOG6VeJSgsrW
         i+Wlgo7l7ZICLAV2KLBRDVLZvy2Ws+IJzjGv3TbLbMJqfnCATrakpQNZtPCOMCDt+vA+
         TTfLiUgSxNsDyEUH1mXMaH4N+An1iYDUmAu9opjlzuJYOfaZox7xOPq5zVDy8zbJfZz8
         D+hQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789511566; x=1790116366; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=043e4j6xvnLvXB9EcyfoGhkhem3s0uOnXWL92QwnUpk=;
        b=GROmno6fT8o8FylIC1izkPACzlzlUCGmoRiv3tkbjniuV8cSiyfcN1OQJuT1VY9jX/
         lXzSSQ1BssheV5hz9vRrU8E2oljQsSXzEEVqAJZnzsf51IJX5DbgK9OwuEZRxbFhgeWc
         w5jDHRIasRwsI6RDmVY9lsrjG3c1xmoOS6W+Imnc+1K7/vvMQbwN6mZ0JxpbrDyKGgIK
         AK353OTHi1geRaaOxsiy8dVZEXNCMv+EfyfjRP6fcH1vnEKBY58FLI36emgNmvX2Uv51
         4jzmwJekEGCxXRxRKw2hdY11HviYkwr6Sr9UiBv9Rj5ECzniJKIDtw2uvTbGJSsCwMV4
         rQdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789511566; x=1790116366;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=043e4j6xvnLvXB9EcyfoGhkhem3s0uOnXWL92QwnUpk=;
        b=qCsORC6gQ/39ndOrWpBPVmpZUvUn4JFwgfqkfgm+Xldnw4e4FerXwPX/KMGlxQHNNC
         l9HFMsh6yS25qVzJe2y+T1ZrZg7mIyMwapvnR0IxZTk8B5Td1aUCDeJlVL+r8N+b3xmI
         WHf3wRmKBLC0aqld5oqqI73eSAGeVq0QJGsij9Jn8v188CDRRS4di0WiUhj7TBnH+Djd
         9mfHykZSYKr4EWO7lj6wB+9Su9H5EM++DkhJisq0zOiVFLRpxYKFP11JjVmpxD/ZgOFC
         JLTs890OjYFKj6pSxc23KSbKICTdvqyO72iw0v9tlZVwlqvnp65IrikXNldASb2aYwNI
         2TYQ==
X-Gm-Message-State: AFuF++kQPe6ccfZzcfWYrkiKuuxUqU31yY3J8Fjb666PfFc7Cg8detC7
	Z+N6ytAJimT97i29lie7Amakho96ZaIBN0UX5JfbNUhuFH1PDrYPJPc+fIMaQQ5UHgWhF/O2B+u
	KhRzujKua7Cg/NxBkGe/pUZQytZ7kdCs=
X-Gm-Gg: AYBFou3BCgnzjewkbw6gh7Wq2oBX0m0wx8K/H1yrJM9yPD6InT1ziCW3+X1jSs3/l77
	qtgdWjE/yPG8nJky898yjx6d0oyXbsrGW1CmhSt8G2uPCGyVjn+z71yZrKnzErxuXnlRTsRhmFy
	6o80KsAwL8oL4P36dNsUCXRJkI95mDpdA8FOyFNziqdCrOhjMF2nGi+15WldPJt9B5jDf30gF2b
	zefCgI4/u9nkpjkjAyb8/fKDfJpRdbySyleuy642amxL+9QcLCgkJnM3YKNgaTwOoSA1/jNhSNg
	OE+qWP2SCLsZbTD+VDCGrhZi5rajD+g8CAbqnppb63xXhmR0IfFt79zdguDgtcpUazNq5xI=
X-Received: by 2002:a05:6808:1784:b0:4c5:238e:b163 with SMTP id
 5614622812f47-4ca4c2933aamr499237b6e.29.1789511566382; Tue, 15 Sep 2026
 15:32:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260911220415.1396439-1-ameryhung@gmail.com> <20260911220415.1396439-20-ameryhung@gmail.com>
 <aqkhifLvyAhw66jg@gmail.com>
In-Reply-To: <aqkhifLvyAhw66jg@gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Tue, 15 Sep 2026 15:32:33 -0700
X-Gm-Features: AcwNN1X5sjOQAAUCCkPj0z4fuNIDiJi6zwYLTDtESd10KxDMDFfL9fHaG7CFqYo
Message-ID: <CAMB2axNCx-+HJVuOmS9hXAidXc0yQgv_+zAfzSkNdDXOZtFP5Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 19/23] bpf: Consolidate function call
 pkt_access validation
To: Mahe Tardy <mahe.tardy@gmail.com>
Cc: bpf@vger.kernel.org, alexei.starovoitov@gmail.com, andrii@kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, memxor@gmail.com, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 15, 2026 at 3:44=E2=80=AFAM Mahe Tardy <mahe.tardy@gmail.com> w=
rote:
>
> On Fri, Sep 11, 2026 at 03:04:11PM -0700, Amery Hung wrote:
> > check_func_arg() checks whether a helper permits packet pointers before
> > dispatching argument-specific memory validation. check_kfunc_args() has
> > no equivalent check, even though kfunc memory arguments may be backed b=
y
> > packet data.
> >
> > Move packet-access validation to check_helper_mem_access(), where the
> > access direction is known and helper, kfunc, and global-subprogram memo=
ry
> > arguments converge. Pass call metadata there so helpers continue to
> > require bpf_func_proto::pkt_access, while writes through kfunc and glob=
al
> > subprogram arguments use the program-type policy and set
> > env->seen_direct_write.
> >
> > Keep call metadata when variable-size memory disables raw mode by
> > clearing arg_raw_mem.regno instead, and pass it through the map-key pat=
h
> > as well.
> >
> > This also makes kfunc and global-subprogram packet writes request the
> > required writable-packet prologue and rejects them for program types
> > that only support direct packet reads.
>
> Hello, sorry I don't have the full context on this patch series but it
> looks like this commit broke one of our programs on bpf-next, we have a
> global function with the following signature in a cgroup_skb program:

Sorry for the surprise. Although this was not the patch=E2=80=99s original
intent, it closes a verifier bug. The verifier does not currently
track whether a global subprogram=E2=80=99s ARG_PTR_TO_MEM argument is
read-only, so the callee is verified with a mutable PTR_TO_MEM. The
call site must therefore require both read and write access. Since
cgroup_skb packet data is read-only, rejecting this call is correct.

Supporting this use case safely will require an explicit read-only
argument contract.

>
>         __attribute__((noinline)) int
>         parse_something(struct __sk_buff *skb, __u16 off, char *data_star=
t, ...)
>
> that we call with data_start being skb->data + some_offset and now it
> fails passing the verifier with:
>
>         ; ret =3D parse_something(skb, offset_start, data, ...); @ parser=
.h:131
>         199: (bf) r2 =3D r8                     ; R2=3Dscalar(id=3D5) R8=
=3Dscalar(id=3D5)
>         200: (57) r2 &=3D 65535                 ; R2=3Dscalar(smin=3Dsmin=
32=3D0,smax=3Dumax=3Dsmax32=3Dumax32=3D0xffff,var_off=3D(0x0; 0xffff))
>         201: (79) r1 =3D *(u64 *)(r10 -40)      ; R1=3Dctx() R10=3Dfp0 fp=
-40=3Dctx()
>         202: (bf) r3 =3D r7                     ; R3=3Dpkt(r=3D1247,imm=
=3D1244) R7=3Dpkt(r=3D1247,imm=3D1244)
>         203: (b7) r4 =3D 0                      ; R4=3D0
>         204: (85) call pc+776
>         function access to the packet is not allowed
>         Caller passes invalid args into func#3 ('parse_something')
>
> And this is read-only access given it's cgroup_skb prog.
>
> We can work around this by just passing the integer offset and re-doing
> the whole skb->data + offset dance in the global function (we've been
> already doing it in some other spots for function by function
> verification) but I was wondering if this actually a regression or
> expected, thanks.
>
> >
> > Signed-off-by: Amery Hung <ameryhung@gmail.com>
> > ---
> >  kernel/bpf/verifier.c                         | 24 +++++++++----------
> >  .../bpf/progs/verifier_helper_packet_access.c |  4 ++--
> >  2 files changed, 13 insertions(+), 15 deletions(-)
>
> [...]
>
