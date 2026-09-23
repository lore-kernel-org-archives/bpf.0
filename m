Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7964F443C0D
	for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 06:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790144186; cv=none; b=I7DLFV87zG/Bs2odp5m2jg9gOMgXuetRK0GK4RnSkLD4+SUcgtHKLb2LphohmhSXQvytzQUyCJ4KWAXXw4xz+f4m80zuqRA3ONJWz2Yp4CVYQ1y9FU0c6cO7jU/8qsRW6IGX0aoNH5Lu/lhEZ5dYaUNfrKetih6Dvv9CTn4yQWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790144186; c=relaxed/simple;
	bh=EVhN5JNz97D05FzcuyFmLkCRvLntfqmM1+860febK6A=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=i5yd85LqzPzH4Fb9u/6IyLtJV6UynCmuZPKWlWzd1wXfKhUy6pjvMAvb5qGwFlWA1Axv3N+HHcqEYJmsV1kmwV5TQF5KMnSOcDNp2CAZx/VMmh5YoaNcEua64vB54LVZm78TGqxVLFBBtUWmlraay3Sos9f8qtSIwM6bG4IW1VU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OYuLBIcg; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OYuLBIcg"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2dd53691be5so3424655ad.1
        for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 23:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790144185; x=1790748985; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Df9WfB0ZHNrSmV5oeY+sN/9eoXroE3/4M9vNBYD3Bog=;
        b=OYuLBIcgRSHkyyc1W9jxmKagh+m3/ABvVVTJnyEjspcs2EGQQJeT5BV7gXfBib5Q8u
         ISuxaD1U+/o3I9OrQAP6lGMJHau4Oae7lioedHrqaZUuplDym2M4SXii8/KNMPTwDuad
         MHupAk8w2efX75KcqgSOYx36ndooxt6EW6OzkYchFuAeQ+YjgJXHvT0R+tAar3fvx5te
         TAoqVF3BBo3qJM5dxVVAYzbrIbkEFl8UJZhQad9G2HdYPLqOcvMVP2SdxW0tFa/vDV0a
         y/5I9Qdfwg9U5lVk3McqIocrVnyGnH4J63mL1pcfuHWzi/jlhF4EXpDrEhMCtIpnGwsN
         xBGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790144185; x=1790748985;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Df9WfB0ZHNrSmV5oeY+sN/9eoXroE3/4M9vNBYD3Bog=;
        b=MU77eCVRspXVsaVVVEzNLSyUiiUAkfQohoqWX/n+VwS00s/lTE/pAtsNmNgHMo40Jq
         RdmChCSVBuqyoJKLepwEB7x0YP7G138Vxj0xxT9NvTi74P3SoRkO/RghVtOrvdDV9I2L
         ERHgSKXxVwZyWBwtFYeugOj4jPvc37MIKkfdURIBBgINLTajih1rC3v5aWL27fIG2ssf
         3+v364pB2610I42VcbURQ3EBNO/w/jnLkJIc7hjvD7hQbV0Ja5rN0qjC0hSwosqRmlUE
         fO8SJNcwDfy9NwfNOhx679UIIE4seF1v+IfXIsuR9qfryK5zNH/1LeSY3wgXxTO0mQSz
         GsAQ==
X-Forwarded-Encrypted: i=1; AKwUvBwgRrk67V53TezF7iE1SmmwxgANXc13bPp1X035M6SKltScotXtBPZ4HiF2+3+i2ZV0voM=@vger.kernel.org
X-Gm-Message-State: AFuF++noj8v6sO1/fIRLTo8FKk7U7nkrxbzXQZKyH1lmg9uiMRDASz28
	icZP48uSxvEM+f1P3Tp/Dh+rPZIM5R6DfWCrlHlikW5fss9BEzzfsc/D
X-Gm-Gg: AYBFou29MVA1lOUdb9VCGw6T6wlrsT5mIkOxJSCo87uuHnVxMQLZ8JbKO/DC2ysGnNh
	guzUi0GCqBODFhrb0bUjbf9T6uk9aWXGyYW6ss6SEavavyg1AeP6HQi9R+6jw/kropEsINHWN8+
	mlblkniaugfRHHlV/QaHQlOwUS8WvIMnJjx8KN6ASH5cVqAlIGeAEe1+i5lqKNZ5vs8WTB0c2Cu
	b1LrVTd28ibxSiEecyO2Yf9vqhttVItrFbmI6jNXAL1zVKyLJHFU6hjeh4g6p/NMmlZH8sX62Td
	GQ5S8lEuCTbQYzNePx9J8/lnjBgpdhN1c56+Bptkrf2zipiziiPUn6HtEb7kgwiNyjMgJ70Brwh
	jrU3JGIViJgwusFDQXvTEY5kl+MDPA9xmjkT0zwUBhOEI0WezDpA23otdbFXx/EtKGM2vWUUyp5
	H2zni0UNgJhOwAJgjbRRiqwznpoB62wZ7/LGXHQ2pKpS/8R8EotSrq+AaUGLbJQcXm9Y2pbfp+6
	vN8+9Fi1uNSMDlOnt3uWjt0ag==
X-Received: by 2002:a17:902:e80a:b0:2c6:90ec:f601 with SMTP id d9443c01a7336-2df69d33222mr13392215ad.8.1790144184570;
        Tue, 22 Sep 2026 23:16:24 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df6a60c741sm5342265ad.80.2026.09.22.23.16.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 23:16:24 -0700 (PDT)
Message-ID: <16a889ab8ae491155ca962bf2e14e83e1f921cf3.camel@gmail.com>
Subject: Re: [PATCH bpf-next v4 00/20] bpf: Run exception cleanup landing
 pads when bpf_throw() unwinds
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Kumar Kartikeya
 Dwivedi <memxor@gmail.com>
Cc: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org, Alexei
 Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, 	kernel-team@fb.com
Date: Tue, 22 Sep 2026 23:16:21 -0700
In-Reply-To: <DLMFEI43TYVI.1KNMAQLNWT2JC@gmail.com>
References: <20260921210033.1715000-1-yonghong.song@linux.dev>
	 <7e7076ce94e803403bcee003569d4b2ac7bc4e2c.camel@gmail.com>
	 <DLLHFJDS6G5L.2B273FIKF9A09@gmail.com>
	 <DLLHQDZBGDUO.2TT8UBHIMZEFK@gmail.com>
	 <DLM696EA5JAQ.3DBNX7Z6DB7N3@gmail.com>
	 <CAP01T76JZUzzyr50dk0NzGv73p12v8E17Lbgy1_yZVqg3Qju0g@mail.gmail.com>
	 <DLMFEI43TYVI.1KNMAQLNWT2JC@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10+b1 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-09-23 at 04:54 +0000, Alexei Starovoitov wrote:
> On Wed Sep 23, 2026 at 4:36 AM UTC, Kumar Kartikeya Dwivedi wrote:
> >=20
> > You can obviously insert aborts at any point in the program, provided
> > such a primitive works, even when the compiler doesn't see it. It is
> > just a way to halt program execution along a given path, and has
> > plenty of precedents (assert(false), std::terminate(), panic!() =3D
> > abort). That property can be used for several purposes, including
> > proving a condition true on the other path that does not abort, and
> > retaining that path condition throughout the rest of the program. That
> > is basically the gist of Eduard's suggestion.
>=20
> That's only true for user space.
> For bpf progs there is no such primitive. bpf_throw() is not it.
> We cannot make it work from arbitrary places without introducing
> massive verifier debt for automatic creation of exception tables
> or via equally massive runtime penalty to remember all things to cleanup.

I'm not sure that automatic exception tables would be all that more
complex, current implementation is not that trivial either.
Plus you mention LLMs-the-almighty yourself.

But speaking of runtime costs.
For a program like this:

  main:
    a()
  a:
    b()
  b:
    throw()

The series currently generates push r6-r9 at entry to each function.
This is needed to recover r6-r9 for the landing pads.
See the program and disassembly below.
Do we want to address this somehow, or is the idea that for complex
subprograms the sequence would amortize away?
On x86 the information about registers location at throw/landing-pad-entry
is stored in .eh_frame section, as far as I understand.

BPF:

  jit_probe_b:
	r1 =3D 32;
  1:	call bpf_throw;
  2:	r0 =3D 0;
	exit;
  3:	call bpf_unwind_resume;
	exit;
	CLEANUP_REC(1b, 2b, 3b)

  jit_probe_a:
	r6 =3D 0x1234;
  1:	call jit_probe_b;
  2:	r0 =3D 0;
	exit;
  3:	r1 =3D r6;
	call bpf_unwind_resume;
	exit;
	CLEANUP_REC(1b, 2b, 3b)

  jit_probe_main:
	jit_probe_a();
	return 0;

x86:

  jit_probe_main:
    0:	endbr64
    4:	nopl	(%rax,%rax)
    9:	nopl	(%rax)
    c:	pushq	%rbp
    d:	movq	%rsp, %rbp
    10:	endbr64
    14:	pushq	%r12
    16:	pushq	%rbx
    17:	pushq	%r13
    19:	pushq	%r14
    1b:	pushq	%r15
    1d:	callq	0x30
 =20
  jit_probe_a:
    0:	endbr64
    4:	nopl	(%rax,%rax)
    9:	nopl	(%rax)
    c:	pushq	%rbp
    d:	movq	%rsp, %rbp
    10:	endbr64
    14:	pushq	%r12
    16:	pushq	%rbx
    17:	pushq	%r13
    19:	pushq	%r14
    1b:	pushq	%r15
    1d:	movl	$0x1234, %ebx
    22:	callq	0x9c
    27:	endbr64
    2b:	movq	%rbx, %rdi
    2e:	retq
   =20
  jit_probe_b:
    0:	endbr64
    4:	nopl	(%rax,%rax)
    9:	nopl	(%rax)
    c:	pushq	%rbp
    d:	movq	%rsp, %rbp
    10:	endbr64
    14:	subq	$0x28, %rsp
    1b:	pushq	%r12
    1d:	pushq	%rbx
    1e:	pushq	%r13
    20:	pushq	%r14
    22:	pushq	%r15
    24:	movl	$0x20, %edi
    29:	movq	%r15, -0x28(%rbp)
    2d:	movq	%r14, -0x20(%rbp)
    31:	movq	%r13, -0x18(%rbp)
    35:	movq	%rbx, -0x10(%rbp)
    39:	movq	%r12, -0x8(%rbp)
    3d:	callq	0xffffffffe18c5c5c
    42:	endbr64
    46:	retq

...
