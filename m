Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com [209.85.221.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A234418EC
	for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 06:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790145904; cv=none; b=X47Ee2b0RO/tUw+mpwz4BL/ninPNMfEzhN6PsQPz0I+LL+vpAas5ualaFeCIrU7fHS7hLQt5QijpMGQkpXAWMPHxAlTAhQdB0PqK6m7bK+ebsnQIxkSAIrk2Iu0ktB/ZvVQx8A5w4HK57zMbpZ0ASASgrU5BGoPsyADZbFgFc60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790145904; c=relaxed/simple;
	bh=1294r34xTc1bW7Bz7mgtVPp9Nhyz2aDNnMbKdaxaj6g=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=n9zgEXG3GRFlUpYHu1JzqBymYsFWwztALxygVdSQ/4oeY7D1lc/cbR8F0I1eTVxDouRm8rLXKJhWL0z7dp7TIY8yIQ5I9qJ5KypJhjwEMqCJwbaVct+8WwOCL7W1MO2dSbOwvqKvHNRWOmBsB2+WABM9I+CIMt8LfQgj15XBP08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZZXNJiY/; arc=none smtp.client-ip=209.85.221.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZZXNJiY/"
Received: by mail-wr1-f65.google.com with SMTP id ffacd0b85a97d-488615e6cfcso714978f8f.0
        for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 23:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790145898; x=1790750698; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Iuwszkn0aQaPLUZ6WX3hy2i6Ad8mCKcVtyvt0xKMgMs=;
        b=ZZXNJiY/OICst1ILLXMv7dlf9yORRFWQavTicogRtVLBhqnQ7h0zjZvUOw1qXzws/B
         l249bIkZe7neVkFofQ7ql4y+J+yz5UhRaqxE9CuATajr9850U3p3T1LJOXsJFFTVMtMX
         U7AWHoYUeLfVKEq44b59TGsGw/W66a4hq+TycfUQU+GxJqvO3/HSZx0SRXQAqNGqsML+
         v1vsQNjWjsXmu/A68/6lwhlpZkp1ljf9iPCY4qkXy8rDQ+zKLPvStad5HNtdhHOewpVX
         B7g9+M6n2Q62EH5hNBVhmvoLQkYGaSM923gNUdn6QV+2ngHh4XfmK7PgX6Tpc5GukEI2
         ZjSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790145898; x=1790750698;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Iuwszkn0aQaPLUZ6WX3hy2i6Ad8mCKcVtyvt0xKMgMs=;
        b=yED19Fd2de62pvJk9fkHnxTcuQB2g5dMBoWDPq1hYnOuZwbOQ/gf5cpcegx0s9fGKI
         PYSS49dZuhzI3ZxVmpCr9KWjhr/WS/SboWxlJMMQDA540WppTAV7VKQZpgkrNlCq79Vh
         B8WfQnBUXS4N2YR9mdBe8ZobhzN6Mk5b8jJ3y/3eUfB7+QzXAql0IMoWxYSWs/hqValb
         TJs2ErCM2T1ynuJIaCimfYljxeLftLaGIiV6TYyfYAZpm3rO82CrOYXcVH7mDBKMH1W4
         ptFVthDGxtKuVgkuNBHv7KpEp18JFYkY8v6LeZGUnlDYq9YCgKnqrpK4zEexUrNdzO/x
         MZ6A==
X-Forwarded-Encrypted: i=1; AKwUvBzM7/qpqW3IDeDMbVog4fwYCyIl+EEbKCuvm3lswjfkyC5Ph4Bxxlm1FbPv8eDGH0yhnlM=@vger.kernel.org
X-Gm-Message-State: AFuF++knQUwrd80Fj2wVMR3oUtN1e05BHXcrgXdP86kBBR7gANdaOPBX
	Unrn50foII8Lna0WS5/Bg6sJap+75ICj99QRx2R+Z2ExWWuOabey9gou
X-Gm-Gg: AYBFou1N7amzRlku7w7Px0YB/KEX+Oo+5b94JyD9P6V8khTbI/+lT0hx/p830FGHviN
	SWfJokV0LsO4DgQ4XZGbqYbZsQSTJKiuSpHz7ipt9HR0s+TtKyUiftMtAFjYLdIok0vUyVNBgz7
	YPvOmHXpi3TKY3j6Dj4IJsE8Gh/tXG8eoy4A4PjiYElLFoDftc8Hs4qSTuTlV/Gtz3NRr9CAhPk
	s60vvAQSs4NIXuDRpQl5xonmpplD+9WELlyVgksFeX4ERzbZX2fqwo1AhNGJa7F6k1uUpExgxJO
	y+TAJBDW8sqaBT2h3jthxGdvXILF56uZYMRf78lkkvKny0/IfanmXQAzyD2O4amS482DBFJACuf
	Z5jWdBNXsHhHhpJVf7S4XtdYlIYGkzEzDv7iRg20KPoVRuMxhHC8xxe/xr1KC1yCdSXZfxnZCuf
	2iq2nMQ17GjG3rY0qdbgpgBHKVbRik9KionXIXcfSAIAd0D+o+5NIddDeAY91anoi0/trRgcgcH
	mr+BKHEy6spaM2gY9kaTRG4BxUeJDWPLc/1a3i2QXuxe5GLJpw1qQeCbhyIYeMxil2olPgFJqba
	ysCDnTEF7PWeX5CRsPWvL5p12aHXh37Dcs+OTQ==
X-Received: by 2002:a05:600c:6d8e:b0:49c:ff66:7d88 with SMTP id 5b1f17b1804b1-49fd883cd5emr57599765e9.7.1790145898261;
        Tue, 22 Sep 2026 23:44:58 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-488682668dcsm4857404f8f.1.2026.09.22.23.44.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Sep 2026 23:44:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 23 Sep 2026 08:44:57 +0200
Message-Id: <DLMHRC6161TE.14EBFU123T4PK@gmail.com>
Cc: "Yonghong Song" <yonghong.song@linux.dev>, <bpf@vger.kernel.org>,
 "Alexei Starovoitov" <ast@kernel.org>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>,
 <kernel-team@fb.com>
Subject: Re: [PATCH bpf-next v4 00/20] bpf: Run exception cleanup landing
 pads when bpf_throw() unwinds
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: "Eduard Zingerman" <eddyz87@gmail.com>, "Alexei Starovoitov"
 <alexei.starovoitov@gmail.com>
X-Mailer: aerc 0.21.0
References: <20260921210033.1715000-1-yonghong.song@linux.dev>
 <7e7076ce94e803403bcee003569d4b2ac7bc4e2c.camel@gmail.com>
 <DLLHFJDS6G5L.2B273FIKF9A09@gmail.com>
 <DLLHQDZBGDUO.2TT8UBHIMZEFK@gmail.com>
 <DLM696EA5JAQ.3DBNX7Z6DB7N3@gmail.com>
 <CAP01T76JZUzzyr50dk0NzGv73p12v8E17Lbgy1_yZVqg3Qju0g@mail.gmail.com>
 <DLMFEI43TYVI.1KNMAQLNWT2JC@gmail.com>
 <16a889ab8ae491155ca962bf2e14e83e1f921cf3.camel@gmail.com>
In-Reply-To: <16a889ab8ae491155ca962bf2e14e83e1f921cf3.camel@gmail.com>

On Wed Sep 23, 2026 at 8:16 AM CEST, Eduard Zingerman wrote:
> On Wed, 2026-09-23 at 04:54 +0000, Alexei Starovoitov wrote:
>> On Wed Sep 23, 2026 at 4:36 AM UTC, Kumar Kartikeya Dwivedi wrote:
>> >
>> > You can obviously insert aborts at any point in the program, provided
>> > such a primitive works, even when the compiler doesn't see it. It is
>> > just a way to halt program execution along a given path, and has
>> > plenty of precedents (assert(false), std::terminate(), panic!() =3D
>> > abort). That property can be used for several purposes, including
>> > proving a condition true on the other path that does not abort, and
>> > retaining that path condition throughout the rest of the program. That
>> > is basically the gist of Eduard's suggestion.
>>
>> That's only true for user space.
>> For bpf progs there is no such primitive. bpf_throw() is not it.
>> We cannot make it work from arbitrary places without introducing
>> massive verifier debt for automatic creation of exception tables
>> or via equally massive runtime penalty to remember all things to cleanup=
.
>
> I'm not sure that automatic exception tables would be all that more
> complex, current implementation is not that trivial either.
> Plus you mention LLMs-the-almighty yourself.
>
> But speaking of runtime costs.
> For a program like this:
>
>   main:
>     a()
>   a:
>     b()
>   b:
>     throw()
>
> The series currently generates push r6-r9 at entry to each function.
> This is needed to recover r6-r9 for the landing pads.
> See the program and disassembly below.
> Do we want to address this somehow, or is the idea that for complex
> subprograms the sequence would amortize away?
> On x86 the information about registers location at throw/landing-pad-entr=
y
> is stored in .eh_frame section, as far as I understand.
>
> BPF:
>
>   jit_probe_b:
> 	r1 =3D 32;
>   1:	call bpf_throw;
>   2:	r0 =3D 0;
> 	exit;
>   3:	call bpf_unwind_resume;
> 	exit;
> 	CLEANUP_REC(1b, 2b, 3b)
>
>   jit_probe_a:
> 	r6 =3D 0x1234;
>   1:	call jit_probe_b;
>   2:	r0 =3D 0;
> 	exit;
>   3:	r1 =3D r6;
> 	call bpf_unwind_resume;
> 	exit;
> 	CLEANUP_REC(1b, 2b, 3b)
>
>   jit_probe_main:
> 	jit_probe_a();
> 	return 0;
>
> x86:
>
>   jit_probe_main:
>     0:	endbr64
>     4:	nopl	(%rax,%rax)
>     9:	nopl	(%rax)
>     c:	pushq	%rbp
>     d:	movq	%rsp, %rbp
>     10:	endbr64
>     14:	pushq	%r12
>     16:	pushq	%rbx
>     17:	pushq	%r13
>     19:	pushq	%r14
>     1b:	pushq	%r15
>     1d:	callq	0x30
>
>   jit_probe_a:
>     0:	endbr64
>     4:	nopl	(%rax,%rax)
>     9:	nopl	(%rax)
>     c:	pushq	%rbp
>     d:	movq	%rsp, %rbp
>     10:	endbr64
>     14:	pushq	%r12
>     16:	pushq	%rbx
>     17:	pushq	%r13
>     19:	pushq	%r14
>     1b:	pushq	%r15
>     1d:	movl	$0x1234, %ebx
>     22:	callq	0x9c
>     27:	endbr64
>     2b:	movq	%rbx, %rdi
>     2e:	retq
>
>   jit_probe_b:
>     0:	endbr64
>     4:	nopl	(%rax,%rax)
>     9:	nopl	(%rax)
>     c:	pushq	%rbp
>     d:	movq	%rsp, %rbp
>     10:	endbr64
>     14:	subq	$0x28, %rsp
>     1b:	pushq	%r12
>     1d:	pushq	%rbx
>     1e:	pushq	%r13
>     20:	pushq	%r14
>     22:	pushq	%r15
>     24:	movl	$0x20, %edi
>     29:	movq	%r15, -0x28(%rbp)
>     2d:	movq	%r14, -0x20(%rbp)
>     31:	movq	%r13, -0x18(%rbp)
>     35:	movq	%rbx, -0x10(%rbp)
>     39:	movq	%r12, -0x8(%rbp)
>     3d:	callq	0xffffffffe18c5c5c
>     42:	endbr64
>     46:	retq
>

That is really bad codegen. There might be a way to argue it's slightly ok =
for
x86 in terms of cost in prologue, but it looks really bad for arm64. I thin=
k we
need to find a better way of handling this...

Basically on entry to a subprog on arm64 we spill 80 bytes worth of registe=
rs,
ignoring spills around throw site which might be less problematic.

> ...
