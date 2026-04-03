Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11BC02367DF
	for <bpf@vger.kernel.org>; Fri,  3 Apr 2026 07:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775202470; cv=none; b=E1WgJaZuJNWMzIn6bMJToqMjsnlbiwnD680eQ6x60g5r6BiBlZ3U26ZTqigp4rO9zd77fUe6LzjQnIZGOBYL2YuueIECI+IPj4tIjrmHmHqhxcYKg+xqtBzBpebm52lj2bK460a9S+tvZRnPMiV3NeF7qSU6Hm+hhEAcQq46kFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775202470; c=relaxed/simple;
	bh=j8IjS+s5k6Bn90LY33GRaPQ1M46jivi+UBPbhJkfdAo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gGqN62/mTVvtnQrWrWLZOWN5LFWUp0CeS9D+BkOQ2x2xM7GQhV9b2UA5zOXx4UlufXCUFTTRn/vm8Sp7NJhULIjDrd4+O6hVcVzTEiccQw2b64lZi1io/B9vCMTmANFRsFYZb9wpt+GLBHjw7r3VkLbnt6qC/HXqQrBOM6WxvsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CVaLC/H5; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CVaLC/H5"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-43b983bb07eso896869f8f.0
        for <bpf@vger.kernel.org>; Fri, 03 Apr 2026 00:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775202467; x=1775807267; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9qwPDzZ2XcalDLT3QkMLcJ7jK4pyWwYFLaEAKuJlyZw=;
        b=CVaLC/H5CayXyhN71FDzmAv2LACg835hv1OZrnL2Y6MN9kr57d7kvWyog6SB9gjPWI
         chzVtylZbhu98D8tr1jqbcmvrTjcd0x+RXwlJdpcHVwLaqkkkv04aV9v9uPQ4Jup8I+f
         7xLgKRuvh3SR61P1sJSzZZ1PFMXXpFDt/b9nKovOQ+fWd0rOv8wCP1n32eLd5eZxuoZW
         oZgmTRIDkNQfwwZQ1yald3xSVQBUyLZx+U4FnVvityMLRakB+sgAGiYooVC5cKzmc/r8
         1YtRu57rsthL41OvbnTSn/LrQTh8INQPRpT9ca2n04GsnFBByw6kRCUqti7jjv25k9PM
         2wYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775202467; x=1775807267;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9qwPDzZ2XcalDLT3QkMLcJ7jK4pyWwYFLaEAKuJlyZw=;
        b=L3oJryooHu+yDM4xvIG2Tp97kD+S4s3yg4Fjp4M7/3u4gem3/iIzNkWVwJuapZAXKg
         dCZIakJXSzbEkG6oQ89Bj7sFOXedrEi1WjLNnY59cevNduKOmKZ6SikMKjPskFbNJjUm
         JKR14QnrjE/6feTVfAmOt7LbpRo4dYPxiSF3kBcbxkkHXl5z/2lxWEgp1Za3Urzu7q55
         +H5WkrxtS3Mfg5i12RmsBLOuR9EUd+6rOp8MKbsCahQ6bnd/JM0lCzYg1CwqyzRToI+9
         ssBtVZtdjbWOjaUmaw1vjWUgbx67s5FHeZ55hB1fVzPj5IAUjZpBJJrD0F+xESUsnqX+
         cysQ==
X-Gm-Message-State: AOJu0YygngGGkl0znkQbq5P7hNFl7mvWTgKxZeC8jgv9FkUC9UiHL7RF
	tWIXMn0TmtujQFbQQxRCXa/p1meMKTiFtWM7D+R8NF6rmG4u8Y8tpRIT
X-Gm-Gg: AeBDies36YDMoGkFfG4GPTkS3jZegsE6M8Rj/8zGiXvUZl/y+JXV+pR5/UGlanodw9Z
	InHUc0gIgOwaB2ejXMRcLI4qB6o7dGHRAX9YPplQ+e1E4llZEGKm6ZA7v+/TJ7+5NFLiKD+TMtU
	K1a9q+vmOlQC1TpWZMeTeSBviGxAMSV+yTxsS32vzRUdF/Oxnv8ce+4ykwEkenVLg5dGFo7D238
	FgjB9xZkOpeRsp+lsd31P6TArG5UMTvncBdS+K9nece9pOldXijYR+nlHMVF0YL2Jzxiw8LZ1p7
	22yDNmUmS5UouDT6u03ZLARQjf65H3gvfK4pUdLm8I3obDvMh9B2xIc1yvGWCK4RJvCBpBMPdB2
	t6yaLbkkFZeMgdh7iRS3jz3FEcDoCTa92qpds1j59hyPEK08JAl3bkH7aRWxOvTxBYgHfZbJUF6
	5GiIDdo1dJLbdXZkfT7kQjc4EkkyEmDsoC
X-Received: by 2002:a05:6000:2885:b0:43b:3e34:7fe with SMTP id ffacd0b85a97d-43d292a8a4fmr2931482f8f.21.1775202467221;
        Fri, 03 Apr 2026 00:47:47 -0700 (PDT)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e4e1c27sm13085420f8f.26.2026.04.03.00.47.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 00:47:46 -0700 (PDT)
Date: Fri, 3 Apr 2026 07:56:30 +0000
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
Message-ID: <ac9yriPJX9RXa5tr@mail.gmail.com>
References: <20260402184647.988132-1-a.s.protopopov@gmail.com>
 <20260402184647.988132-2-a.s.protopopov@gmail.com>
 <CAADnVQKUJYsPJa8HP9E-pguQeuShXfuaEs4Z_zJAVYWeEUvHBg@mail.gmail.com>
 <ac7XSg6AsJq99WvT@mail.gmail.com>
 <CAADnVQJ_e2fyODknJyMPRw4Z7ztu3-0ZrVM8jXpoO1g7bH52jA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQJ_e2fyODknJyMPRw4Z7ztu3-0ZrVM8jXpoO1g7bH52jA@mail.gmail.com>

On 26/04/02 02:32PM, Alexei Starovoitov wrote:
> On Thu, Apr 2, 2026 at 1:44 PM Anton Protopopov
> <a.s.protopopov@gmail.com> wrote:
> >
> > On 26/04/02 12:00PM, Alexei Starovoitov wrote:
> > > On Thu, Apr 2, 2026 at 11:38 AM Anton Protopopov
> > > <a.s.protopopov@gmail.com> wrote:
> > > >
> > > > When a pointer to PTR_TO_INSN is dereferenced it is possible to
> > > > specify an offset inside the load instruction. This is a bug,
> > > > because while the verifier ignores the field, JITs are not.
> > > > So, patch the verifier to not ignore this field.
> > >
> > > This is too terse to understand.
> > > In 2nd patch you're saying:
> > >
> > >    r1 = &map + offset1
> > >    r1 += offset2
> > >    r1 = *(r1 + offset3)
> > >    gotox r1
> > >
> > > Here offset3 is, normally, equal to zero; but this is not guaranteed.
> > >
> > > What is this 'offset3'? Where did it come from?
> >
> > The offset3 is the .off field of the BPF_LDX_MEM instruction.
> > The BPF assembler will correctly work with non-zero offsets:
> >
> >     r1 = &map;
> >     r1 = *(r1 + offset)
> >
> > > What do you mean JIT handles it?
> >
> > JIT will issue a memory load with this offset,
> > but verifier will ignore it (before this patch).
> >
> > > can llvm ever generate such code?
> > > if not, reject it early ?
> >
> > LLVM can generate code with non-zero offset in BPF_LDX_MEM,
> > say, if one jumps to a structure field, like in `goto *p->j`
> 
> sorry, I still don't get it. What kind of syntax is that?
> Could you share the godbolt link where llvm actually generates
> such code? If the verifier will reject it anyway it's fine.
> I just want to make sure we're fixing real problem.

I am not aware of any real-life code, only can construct
some artificial examples:

        SEC("syscall")
        int test(unsigned int n)
        {
                struct {
                        int i;
                        void *j[3];
                } x = {
                        .i = n,
                        .j = { &&l1, &&l2, &&l3 },
                };

                if (n < 3)
                        goto *x.j[n];

                return 0;
        l1:
                return 1;
        l2:
                return 3;
        l3:
                return 5;
        }

It will compile into

        <test>:
        ;               .j = { &&l1, &&l2, &&l3 },
             160:       18 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 r2 = 0x0 ll
                        0000000000000500:  R_BPF_64_64  BPF.JT.4.0
             162:       79 23 10 00 00 00 00 00 r3 = *(u64 *)(r2 + 0x10)
                                                                   ^ offet != 0
             163:       7b 3a f8 ff 00 00 00 00 *(u64 *)(r10 - 0x8) = r3
             164:       79 23 08 00 00 00 00 00 r3 = *(u64 *)(r2 + 0x8)
             165:       7b 3a f0 ff 00 00 00 00 *(u64 *)(r10 - 0x10) = r3
             ...
