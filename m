Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7592830F7EF
	for <bpf@vger.kernel.org>; Fri,  3 Apr 2026 18:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775239294; cv=none; b=YpQCTs5XaZDjBgLmrrsSxIH4XZd75+OaTPwqJtxnUsyj6s7NoId4GnMk1KgS1sinnEzIZ72FvG277+rQ+uJkNNtpeNsDoReWJQSqEfh9S0rfeqgZMJKe5JJxD+l4DwXOfG5z1oToyf6PpE5mXZ61lAUCnLfzMFE9C2lFrmlpvdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775239294; c=relaxed/simple;
	bh=CgqdO3MoEdV6h1XvZvnp3xzwPDu9ksHhUwKVUiC110I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ElMXlVGKC4TYLoBcphKpIT9Ss0o16UKFT2acRMfnvd7cuENWaj+68i0NbNNwAy/6vcXSeWloDij9x2cfA1+xUUD3qBoAslM7NlBUvrV4qv5Wyu1tGayjKpDVA/N/gRfTpVLB3Tyl+5hgpWCJyrx6LTDifPDQMrtLmNJAE6MTdFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=heXE3Toz; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="heXE3Toz"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4852b81c73aso18898425e9.3
        for <bpf@vger.kernel.org>; Fri, 03 Apr 2026 11:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775239292; x=1775844092; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TJrBEs7DvDXPMf6HvY06bHlVrPZogp4C0m0gvlF+Db0=;
        b=heXE3TozFwSB8EqMTkhp2Z9STgW0iuudN4CiLxcyuitcBFBMGpmU1bmwEP/DSuxjeb
         7z8ehHTiT4kygFkHKbYU6OweMpKYEO2kM2b2kGMtx27IIF3qU1KOdkoJM7WOA1fC8l3l
         FEGYqFcQbx988Rg5HtPhFcMcC6HZFigAF6drUHuBHn66vk88IkFdJvxfVetUnf4j9TAE
         yxql+TO1gAWXfs0WwpRkq5DWnZz518v6gqE/leB4mRdF/yMskPVlyMQWWRiSqfroidyE
         40Vfm5ZjE9U1hSalbc5Mqc+JPzdA418K5nZYPpAjsD9iDaCiPf0uqfur/Ztc8pa0Bmnp
         7Ppw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775239292; x=1775844092;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TJrBEs7DvDXPMf6HvY06bHlVrPZogp4C0m0gvlF+Db0=;
        b=Ho6+Fx1zBXqZTo8624Jl2/kV1QuGLF+MONg5Ut+kFuu9Y/foVo7c0MpkVlZmSCS49G
         0ZGBuOHcoLjZEbgQ1ITzq9k5zAgGwMMQFpZjEie20cTs1cXeCTe5JiHHMdUXwxSs2quD
         FkXxYJmCGAskiMDMwt4DQ97H1jexZMVaiYOQQRsYIJesvdaoJUeU6GlkLcK0GtLK1Z+u
         H/xnYzIX9i0poK5aUfdKmipXPHu14d0gLZLJzGW1EVtAFw1sSwn/vBNvjssGEWVc9EZE
         VVKp60QM7MPoQc6D7f8FHfam7H3Vac/KIcy9KOrfVZSfj6SDAHFiTXJJUtaE2yQOncU7
         ubaw==
X-Gm-Message-State: AOJu0YzxItqc+jciO638pinZCgBwipQhubuqMJApYIwgZKbjakExRVY9
	WziEo0crdEunKpIsYuoWoicRzekK7Sdk0I7ZKKn+6Fv8MpKiJN8mNqrV
X-Gm-Gg: ATEYQzzIGnEecPWG30tTo4LsIBVEUbWHHFYDBGwtU3x9iMWYRWk38aTIt69PJyvL06v
	UORQEeqqdptogIJ0Tb9JaZwZL83Piygn8CNhzFKPJiV4/yilnepLmZFKfqWdRsBOK1gLik9h/57
	UA7kBcoYzHCkAuEHJxVC7Kkh/uj4ObMOcKRVhCsGzdfh84CgYdI/NET9a00vh8oVeI9C8LRAi1l
	jmRB7IbdD+zbkvpom9w0Zv/3Ibic9eynEPR+L0Oi2iihYM+RXQbzFfemg/E1ir6HFYvhYXFVHxx
	vv8DY52VFWgvNHp/dTJkYWkFeYVN7AHQPuTetY1GXs2IoMiV9g2ufqR5NgQ8i/SjFi7tmctvQRA
	hFa8//PLzrzdzACLaAryyV/Zymfpo2kSSQhPKN4ylnworoBy1MJJq/n+NiuT/cuS8Lurxg9NW+S
	mKhwvSG8bCgHdDlJjbNTsL3x3+pLeNC4WC
X-Received: by 2002:a05:600c:138f:b0:486:fbf6:abd4 with SMTP id 5b1f17b1804b1-488996f250dmr56537265e9.9.1775239291317;
        Fri, 03 Apr 2026 11:01:31 -0700 (PDT)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4888a626100sm266056245e9.1.2026.04.03.11.01.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 11:01:30 -0700 (PDT)
Date: Fri, 3 Apr 2026 18:10:12 +0000
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Jiyong Yang <ksur673@gmail.com>,
	Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Subject: Re: [PATCH v2 bpf-next 1/2] bpf: Do not ignore offsets for loads
 from insn_arrays
Message-ID: <adAChK9+GVACl8ci@mail.gmail.com>
References: <20260402184647.988132-1-a.s.protopopov@gmail.com>
 <20260402184647.988132-2-a.s.protopopov@gmail.com>
 <CAADnVQKUJYsPJa8HP9E-pguQeuShXfuaEs4Z_zJAVYWeEUvHBg@mail.gmail.com>
 <ac7XSg6AsJq99WvT@mail.gmail.com>
 <CAADnVQJ_e2fyODknJyMPRw4Z7ztu3-0ZrVM8jXpoO1g7bH52jA@mail.gmail.com>
 <ac9yriPJX9RXa5tr@mail.gmail.com>
 <CAADnVQK0mEAdZ3PEHv=wvbPUrEA7EPmU7w928JOd=143vt+kJA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQK0mEAdZ3PEHv=wvbPUrEA7EPmU7w928JOd=143vt+kJA@mail.gmail.com>

O 26/04/03 08:10AM, Alexei Starovoitov wrote:
> On Fri, Apr 3, 2026 at 12:47 AM Anton Protopopov
> <a.s.protopopov@gmail.com> wrote:
> >
> > On 26/04/02 02:32PM, Alexei Starovoitov wrote:
> > > On Thu, Apr 2, 2026 at 1:44 PM Anton Protopopov
> > > <a.s.protopopov@gmail.com> wrote:
> > > >
> > > > On 26/04/02 12:00PM, Alexei Starovoitov wrote:
> > > > > On Thu, Apr 2, 2026 at 11:38 AM Anton Protopopov
> > > > > <a.s.protopopov@gmail.com> wrote:
> > > > > >
> > > > > > When a pointer to PTR_TO_INSN is dereferenced it is possible to
> > > > > > specify an offset inside the load instruction. This is a bug,
> > > > > > because while the verifier ignores the field, JITs are not.
> > > > > > So, patch the verifier to not ignore this field.
> > > > >
> > > > > This is too terse to understand.
> > > > > In 2nd patch you're saying:
> > > > >
> > > > >    r1 = &map + offset1
> > > > >    r1 += offset2
> > > > >    r1 = *(r1 + offset3)
> > > > >    gotox r1
> > > > >
> > > > > Here offset3 is, normally, equal to zero; but this is not guaranteed.
> > > > >
> > > > > What is this 'offset3'? Where did it come from?
> > > >
> > > > The offset3 is the .off field of the BPF_LDX_MEM instruction.
> > > > The BPF assembler will correctly work with non-zero offsets:
> > > >
> > > >     r1 = &map;
> > > >     r1 = *(r1 + offset)
> > > >
> > > > > What do you mean JIT handles it?
> > > >
> > > > JIT will issue a memory load with this offset,
> > > > but verifier will ignore it (before this patch).
> > > >
> > > > > can llvm ever generate such code?
> > > > > if not, reject it early ?
> > > >
> > > > LLVM can generate code with non-zero offset in BPF_LDX_MEM,
> > > > say, if one jumps to a structure field, like in `goto *p->j`
> > >
> > > sorry, I still don't get it. What kind of syntax is that?
> > > Could you share the godbolt link where llvm actually generates
> > > such code? If the verifier will reject it anyway it's fine.
> > > I just want to make sure we're fixing real problem.
> >
> > I am not aware of any real-life code, only can construct
> > some artificial examples:
> >
> >         SEC("syscall")
> >         int test(unsigned int n)
> >         {
> >                 struct {
> >                         int i;
> >                         void *j[3];
> >                 } x = {
> >                         .i = n,
> >                         .j = { &&l1, &&l2, &&l3 },
> >                 };
> >
> >                 if (n < 3)
> >                         goto *x.j[n];
> >
> >                 return 0;
> >         l1:
> >                 return 1;
> >         l2:
> >                 return 3;
> >         l3:
> >                 return 5;
> >         }
> >
> > It will compile into
> >
> >         <test>:
> >         ;               .j = { &&l1, &&l2, &&l3 },
> >              160:       18 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 r2 = 0x0 ll
> >                         0000000000000500:  R_BPF_64_64  BPF.JT.4.0
> >              162:       79 23 10 00 00 00 00 00 r3 = *(u64 *)(r2 + 0x10)
> >                                                                    ^ offet != 0
> >              163:       7b 3a f8 ff 00 00 00 00 *(u64 *)(r10 - 0x8) = r3
> >              164:       79 23 08 00 00 00 00 00 r3 = *(u64 *)(r2 + 0x8)
> >              165:       7b 3a f0 ff 00 00 00 00 *(u64 *)(r10 - 0x10) = r3
> 
> Great, but where is an actual gotox that is using that r3?
> Looks like it's spilled into stack at 163 ?
> Does it pass the verifier?
> Would be great to add it as C selftest.

No, this one doesn't pass the verifier (it is spilled to stack, and when
it is loaded back the error is "invalid unbounded variable-offset
read from stack R2", because it is loaded back from stack as
"scalar", not "insn"). All "normal" use cases from [C-level] selftests
(a switch or a 'goto *j[i]') compile into code which accumulate
offset into previous instructions.

Do you want me to work on this example above to pass the verifier?
Or, for now, the best thing is to just reject non-zero offsets?
(The latter has the benefit that the patch will be auto-backportable
to stable trees.)
