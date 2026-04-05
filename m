Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B222DCC05
	for <bpf@vger.kernel.org>; Sun,  5 Apr 2026 18:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775412953; cv=none; b=aYWdcsf0N9n1qqy/bj52IoF7inTGZFb7zhds620huo2SUtQ6ZOB6Oqz90iXXHZORS7r6GQRvJLSP6YIK0VpDzsllWncYq7nomHVWz8CwlRQiVrqgkoHTbhv2K835VF+xtLT1VSMTmppQm8YkvGv2wW9gvkvQvosKh2vxn9F7fWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775412953; c=relaxed/simple;
	bh=daPaPqNUpta4Y37FCyzAQIb5thsUfz5tmMxENQuxMQg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bQwVUnIlg7ciBesd+Q3RDEteAouH2YYnvYa2USIQ8wiqSLTD1VOUuzoEdMjnKxMli/vBoV+NO8g8GJr03WjKpssmVUvHPg02fv0uAMucGkrMZhV8nx3aI6BbgO1ChupWdfwtkqD7CVXRcGfeFRE4NrOz2SKVo8SqSD+AJwx0AXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oVzypw+n; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oVzypw+n"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4888244e9f9so30353895e9.0
        for <bpf@vger.kernel.org>; Sun, 05 Apr 2026 11:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775412949; x=1776017749; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1BqCUPJk37vpaNHyGU+o45BpKaON0Cq4jW8fw5E5QNY=;
        b=oVzypw+njb35NJZu1RQr6sf/81Xd5EjLRZkGZGsIpoZ4vDz9P7OjYIi2Y9El9KKxPd
         O30N3+h0EDuahyKky7xUvO/NCP/AH4IZYfOR8/X9qfqFxgqx5TkjXh6p4tg4Ww7mxiM8
         E6FAC+wkRS1a1wtXIPOKC9CUMowFM2peDq+C6FD0OteIIyf0uS0p9cxSyR/HeTn+GJZR
         67oMlSpYzarLPMkeysjLYQZp3qnvzNfeVbJOb+ZYQFfxqAKu7hgrOPuPujSDGWH4FDDv
         V/lEmq6+BmCveRImR/qX1KNratKoXQihLH4sgQKPd4txHsmKX8HHgBhvNrH8fJkq6fBs
         MIOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775412949; x=1776017749;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1BqCUPJk37vpaNHyGU+o45BpKaON0Cq4jW8fw5E5QNY=;
        b=cAYkmeXcdvuYsZjSVE+xjPwroxaTt1GN0UxSeQP9QCXzdPRjp+3PFxExAQUE/wLpYY
         6r8rK7pp8N8HYMgh6Y2Swdv8hb3QKmQY0WPb9qulK90vFUsj37sY8pD3ZIWTiFiRuQcF
         bxlkVH4BmBTUqkh5/XFA8bs0du5SAJSM7tGdQnZQ4NFfow7phkD5Lz3wNKbu6ri5wJSG
         zPxKdTIxob/g0v36rC2yJgFU9qP+oyO2SPu0FlovCzidl9ST1UsB+xWu6GntwYwzkSk4
         S4Hxg1suErBpAFa7Paa/BIDENvbSqS/bkKN5F0aLtihBGS4bRbI6Urr+ZV4liZD/MBdm
         8xew==
X-Gm-Message-State: AOJu0Yz0sOoTwWQmhks2BV4kDumwNc+0uC8aLgyddR6tn3fK72CyxK9Y
	oe+ECZaM5ZC/6ztNYp74Eg+QmNg+q1vipUeM75B5ALm0nQaqcDWhEJ2c
X-Gm-Gg: AeBDiesddZ7A/T/tVlHuj/ArHKYNtdIpG0Ia4IwBAeTYjOls3qT35DXvh57SPEqggyL
	xtQfOChpVngGlWD2WguGncQecTW58qgycrjMqY9LH6NcirhnUdUu2hehwNpRolBYVWY1Vot7s3F
	ZiTYO6CULcAHqndezDqZCvjDIh8qdxkEMkfq9EVwCXAnpqt6rR97eVDXpqQp6+RQoEAwGFtIWri
	swfafWOejWAj5I9fZcLej1Lvq/XxX3QWKnyM+0xlKCp7Gs1RrFcPyQhpmfF/VRi/xl5RdUExSts
	K8wHJF8sdhzWvHSZ8hu+TDLqY0Z/Iic+xDj0lRXmQGTQKyOr8xA7bwAf1qKJhyG4t2owkkaGPH1
	70jVBKeIpRS3W32T0I60YHSOhWJk/kBEV78Ly0YlybJae6LhH5Z7aojyzRk0RvqpOsPT4rAGO3O
	m5fp9Z9JvO2VKmH/doGYX4LDksyrDSNh08
X-Received: by 2002:a05:600c:64cd:b0:487:1fbf:e0bb with SMTP id 5b1f17b1804b1-488996a1c9dmr159093185e9.6.1775412948988;
        Sun, 05 Apr 2026 11:15:48 -0700 (PDT)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488ab6bfc86sm23624425e9.11.2026.04.05.11.15.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Apr 2026 11:15:48 -0700 (PDT)
Date: Sun, 5 Apr 2026 18:24:25 +0000
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
Message-ID: <adKo2W5+uaRYFII0@mail.gmail.com>
References: <20260402184647.988132-1-a.s.protopopov@gmail.com>
 <20260402184647.988132-2-a.s.protopopov@gmail.com>
 <CAADnVQKUJYsPJa8HP9E-pguQeuShXfuaEs4Z_zJAVYWeEUvHBg@mail.gmail.com>
 <ac7XSg6AsJq99WvT@mail.gmail.com>
 <CAADnVQJ_e2fyODknJyMPRw4Z7ztu3-0ZrVM8jXpoO1g7bH52jA@mail.gmail.com>
 <ac9yriPJX9RXa5tr@mail.gmail.com>
 <CAADnVQK0mEAdZ3PEHv=wvbPUrEA7EPmU7w928JOd=143vt+kJA@mail.gmail.com>
 <adAChK9+GVACl8ci@mail.gmail.com>
 <CAADnVQLq9X6K3_vwcsMEy_5AEk+y_gWbUHSibn5uGqbpdejirQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQLq9X6K3_vwcsMEy_5AEk+y_gWbUHSibn5uGqbpdejirQ@mail.gmail.com>

On 26/04/03 11:22AM, Alexei Starovoitov wrote:
> On Fri, Apr 3, 2026 at 11:01 AM Anton Protopopov
> <a.s.protopopov@gmail.com> wrote:
> >
> > O 26/04/03 08:10AM, Alexei Starovoitov wrote:
> > > On Fri, Apr 3, 2026 at 12:47 AM Anton Protopopov
> > > <a.s.protopopov@gmail.com> wrote:
> > > >
> > > > On 26/04/02 02:32PM, Alexei Starovoitov wrote:
> > > > > On Thu, Apr 2, 2026 at 1:44 PM Anton Protopopov
> > > > > <a.s.protopopov@gmail.com> wrote:
> > > > > >
> > > > > > On 26/04/02 12:00PM, Alexei Starovoitov wrote:
> > > > > > > On Thu, Apr 2, 2026 at 11:38 AM Anton Protopopov
> > > > > > > <a.s.protopopov@gmail.com> wrote:
> > > > > > > >
> > > > > > > > When a pointer to PTR_TO_INSN is dereferenced it is possible to
> > > > > > > > specify an offset inside the load instruction. This is a bug,
> > > > > > > > because while the verifier ignores the field, JITs are not.
> > > > > > > > So, patch the verifier to not ignore this field.
> > > > > > >
> > > > > > > This is too terse to understand.
> > > > > > > In 2nd patch you're saying:
> > > > > > >
> > > > > > >    r1 = &map + offset1
> > > > > > >    r1 += offset2
> > > > > > >    r1 = *(r1 + offset3)
> > > > > > >    gotox r1
> > > > > > >
> > > > > > > Here offset3 is, normally, equal to zero; but this is not guaranteed.
> > > > > > >
> > > > > > > What is this 'offset3'? Where did it come from?
> > > > > >
> > > > > > The offset3 is the .off field of the BPF_LDX_MEM instruction.
> > > > > > The BPF assembler will correctly work with non-zero offsets:
> > > > > >
> > > > > >     r1 = &map;
> > > > > >     r1 = *(r1 + offset)
> > > > > >
> > > > > > > What do you mean JIT handles it?
> > > > > >
> > > > > > JIT will issue a memory load with this offset,
> > > > > > but verifier will ignore it (before this patch).
> > > > > >
> > > > > > > can llvm ever generate such code?
> > > > > > > if not, reject it early ?
> > > > > >
> > > > > > LLVM can generate code with non-zero offset in BPF_LDX_MEM,
> > > > > > say, if one jumps to a structure field, like in `goto *p->j`
> > > > >
> > > > > sorry, I still don't get it. What kind of syntax is that?
> > > > > Could you share the godbolt link where llvm actually generates
> > > > > such code? If the verifier will reject it anyway it's fine.
> > > > > I just want to make sure we're fixing real problem.
> > > >
> > > > I am not aware of any real-life code, only can construct
> > > > some artificial examples:
> > > >
> > > >         SEC("syscall")
> > > >         int test(unsigned int n)
> > > >         {
> > > >                 struct {
> > > >                         int i;
> > > >                         void *j[3];
> > > >                 } x = {
> > > >                         .i = n,
> > > >                         .j = { &&l1, &&l2, &&l3 },
> > > >                 };
> > > >
> > > >                 if (n < 3)
> > > >                         goto *x.j[n];
> > > >
> > > >                 return 0;
> > > >         l1:
> > > >                 return 1;
> > > >         l2:
> > > >                 return 3;
> > > >         l3:
> > > >                 return 5;
> > > >         }
> > > >
> > > > It will compile into
> > > >
> > > >         <test>:
> > > >         ;               .j = { &&l1, &&l2, &&l3 },
> > > >              160:       18 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 r2 = 0x0 ll
> > > >                         0000000000000500:  R_BPF_64_64  BPF.JT.4.0
> > > >              162:       79 23 10 00 00 00 00 00 r3 = *(u64 *)(r2 + 0x10)
> > > >                                                                    ^ offet != 0
> > > >              163:       7b 3a f8 ff 00 00 00 00 *(u64 *)(r10 - 0x8) = r3
> > > >              164:       79 23 08 00 00 00 00 00 r3 = *(u64 *)(r2 + 0x8)
> > > >              165:       7b 3a f0 ff 00 00 00 00 *(u64 *)(r10 - 0x10) = r3
> > >
> > > Great, but where is an actual gotox that is using that r3?
> > > Looks like it's spilled into stack at 163 ?
> > > Does it pass the verifier?
> > > Would be great to add it as C selftest.
> >
> > No, this one doesn't pass the verifier (it is spilled to stack, and when
> > it is loaded back the error is "invalid unbounded variable-offset
> > read from stack R2", because it is loaded back from stack as
> > "scalar", not "insn"). All "normal" use cases from [C-level] selftests
> > (a switch or a 'goto *j[i]') compile into code which accumulate
> > offset into previous instructions.
> >
> > Do you want me to work on this example above to pass the verifier?
> > Or, for now, the best thing is to just reject non-zero offsets?
> > (The latter has the benefit that the patch will be auto-backportable
> > to stable trees.)
> 
> I wouldn't worry about backports. Size of the patch doesn't matter much.
> 
> Is spill issue just a matter of adding one line to is_spillable_regtype ?
> If so, let's do that and have a test in C (in addition to asm) that
> actually using the offset.

Ok, looks I've found a simple selftest which compiles to
a non-zero offload from realistic C code (and triggers a NULL
deref without this patch). So I will send the next version with
that selftest added, and with a better commit description.
