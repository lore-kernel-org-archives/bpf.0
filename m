Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C4A7FBAE
	for <bpf@vger.kernel.org>; Wed,  6 Mar 2024 16:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709742078; cv=none; b=RHfWbfwvgv6AvaYRqYeyG1j3v7RELAJD/4k+/QB++Jpy97iJy9uZWm98VxBE6tQEQZgTE7aYPdqQQuv4dt88J2CyijbYA0RnCKArtRQSGaqbB5oHQlOBRUhr5e4M+sEgnaZdapjAl0ttt2oQAN8sHantoK2lJuHL8jF5osQfX9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709742078; c=relaxed/simple;
	bh=6ckO67eGISRujj/lGOm0lzpeisjfBFslDG+kvZLS6W4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ovRwBVXPkk21jlsCyP/K1tR0cULc2dqkRI0PoHpwoyC0uENPzAfpy6Tabm7xqXXiwwTCAWW3rSrEmwZCRd/ODaswCUHheu4QjMn/yU6Oj34C5f7U8hnw0Su46HL02gJj0Jz/YY530n+M/3sGnmTPlJFbZ9+4IIqeguXG66XlhNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JNu6kheq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JNu6kheq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85007C433C7;
	Wed,  6 Mar 2024 16:21:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709742077;
	bh=6ckO67eGISRujj/lGOm0lzpeisjfBFslDG+kvZLS6W4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=JNu6kheqe1GT6U9cQubnthfBNBS9kqhQuerryJN4Ll7JM3ITydjl8ew/b8/2ERDbd
	 0ZbNvKZpVc00AppoflyDkaPdGarS2AoJvJio5vKxKgFL1wQDPaBdfr3dSHCbbrAgSN
	 FB1Y1ifbY43+CIo3L+FKKbO+saZNRc/Fw4pEM2BA4+lpmmXmZ+d/chbbJ8Dn714yBa
	 tbAhx9qsrsApTUB1cf/+7bM6GvU962rmvnbV9HSTcsH+FsJj7oPaIxfL2QEBkIeeM8
	 NivOHO2gniC1zv+pfAzJxGgZ4EzMltKMmle36vQ7V1f1NvzVOhwkolOwbduS6K9sn+
	 42BaZuu9+N7Vw==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Shahab Vahedi <list+bpf@vahedi.org>
Cc: bpf@vger.kernel.org, linux-snps-arc@lists.infradead.org, Shahab Vahedi
 <list+bpf@vahedi.org>, Vineet Gupta <vgupta@kernel.org>
Subject: Re: [PATCH bpf-next v1] ARC: Add eBPF JIT support
In-Reply-To: <6e4cf7cc-6a2e-4396-b0d5-01ff10d6923a@vahedi.org>
References: <20240213131946.32068-1-list+bpf@vahedi.org>
 <87ttlnqlmv.fsf@all.your.base.are.belong.to.us>
 <6e4cf7cc-6a2e-4396-b0d5-01ff10d6923a@vahedi.org>
Date: Wed, 06 Mar 2024 17:21:14 +0100
Message-ID: <87sf13babp.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Shahab Vahedi <list+bpf@vahedi.org> writes:

> Hi Bj=C3=B6rn,
>
> Thank you very much for your inputs. Please find my remarks below.
>
> Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org> writes:
>
>> Shahab Vahedi <list+bpf@vahedi.org> writes:
>>=20
>> What's the easiest way to test test this w/o ARC HW? Is there a qemu
>> port avaiable?
>
> Yes, there is a (downstream) port available on GitHub [1]. If one is
> interested, there are also guides about building QEMU for ARC targets [2]
> and how to run eBPF tests for ARC Linux [3].
>
> [1] ARC QEMU port
> https://github.com/foss-for-synopsys-dwc-arc-processors/qemu
>
> [2] Building ARC QEMU
> https://foss-for-synopsys-dwc-arc-processors.github.io/experimental-docum=
entation/2023.09/simulators/qemu/
>
> [3] Runing eBPF tests for ARC Linux
> https://foss-for-synopsys-dwc-arc-processors.github.io/experimental-docum=
entation/2023.09/linux/ebpf/build/

Cool, TY.

>> I don't know much about ARC -- Is v2 compatible with v3?
>
> No, they're not. For what it's worth, ARCv3 comes in {32,64}-bit
> flavours which are not compatible with each other either.
>
>> I'm curious about the missing support; tailcall/atomic/division/extable
>> support. Would it require a lot of work to add that support in the
>> initial change set?
>
> If you're asking whether it is possible that I add those features now,
> my answer unfortunately would be "no". However, the way that things
> are implemented, it will be a straightforward addition.

Ok! Did you try building the kselftest/bpf suite? Would be interesting
to see the pass/fail rate of test_progs.

>> There are a lot of checkpatch/kernel style issues. Run, e.g.,
>> "checkpatch --strict -g HEAD" and you'll get a bunch of issues. Most of
>> them are just basic style issues. Please try to fix most of them for the
>> next rev.
>
> I did run the "checkpatch" before submitting. I've fixed all the "errors"
> and most of the "warnings". But now that you brought it up, I will try to
> fix as many "warnings"/"checks" as make sense.

Ok. I noticed a lot non-kernel style in your patch (checking against
NULL e.g.)

>> You should add yourself to the MAINTAINERS file.
>
> I will. Thanks!
>
>> Please try to avoid static inline in the C-files. The compiler usually
>> knows better.
>
> I will replace them with "static" then.
>
>> > +/* Sane initial values for the globals */
>> > +bool emit =3D true;
>> > +bool zext_thyself =3D true;
>>=20
>> Hmm, this is racy. Can we move this into the jit context? Also, is
>> zext_thyself even used?
>
> I will get rid of those. For the record, "zext_thyself" is used by
> calling "zext()" after handling "BPF_ALU" operations.

Ah, indeed!

>> > +#define CHECK_RET(cmd)			\
>> > +	do {				\
>> > +		ret =3D (cmd);		\
>> > +		if (ret < 0)		\
>> > +			return ret;	\
>> > +	} while (0)
>> > +
>>=20
>> Nit/personal taste, but I prefer not having these kind of macros. I
>> think it makes it harder to read the code.
>
> At some point, I found myself distracted from seeing the bigger picture
> while the code was interspersed by the menial "return checking"s. If
> you don't mind, I'd rather keep it as is, unless you feel strong about
> it or Vineet also agrees with you.
>
>> Care to elaborate a bit more on ARC_BPF_JIT_DEBUG. This smells of
>> duplicated funtionality with bpf_jit_dump(), and the BUG()s are scary.
>
> ARC_BPF_JIT_DEBUG is supposed to be enabled for development purposes.
> It enables:
>
> 1. A set of assert-like condition checking which makes the code
> slow and can lead to ungraceful terminations.
>
> 2. Use of a custom version of hex dumps. The most important difference
> with bpf_jit_dump() is that bpf_jit_dump() cannot be used for dumping
> the input BPF byte stream. Rest, I can live with. An example follows:
>
> Using only "bpf_jit_dump" (ARC_BPF_JIT_DEBUG is not defined)
>
>   flen=3D2 proglen=3D20 pass=3D1 image=3D2e8c6fb9 from=3Dhello pid=3D127
>   JIT code: 00000000: 8a 20 00 10 8a 21 00 10 0a 20 00 02 0a 21 40 02
>   JIT code: 00000010: e0 20 c0 07
>
> vs.
>
> Using the custom version (ARC_BPF_JIT_DEBUG is defined)
>   -----------------[  VM   ]-----------------
>   0xb7, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
>   0x95, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
>   -----------------[ JIT:1 ]-----------------
>   0x8a, 0x20, 0x00, 0x10, 0x8a, 0x21, 0x00, 0x10
>   0x0a, 0x20, 0x00, 0x02, 0x0a, 0x21, 0x40, 0x02
>   0xe0, 0x20, 0xc0, 0x07
>
>> > +static int jit_ctx_init(struct jit_context *ctx, struct bpf_prog *pro=
g)
>> > +{
>> > +   ...
>>=20
>> I'd just make sure that ctx is zeroed, and init the non-zero members her=
e.
>
> Very good point! I will implement it that way.
>
> If you have read this far, I'd like to thank you again for spending time
> on reviewing this patch. It is much appreciated.

Looking forward for the next revision!


Bj=C3=B6rn
