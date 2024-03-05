Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E44127B4A
	for <bpf@vger.kernel.org>; Tue,  5 Mar 2024 15:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709652193; cv=none; b=e8F7fn1uDxgd6eMHGetMyx02qL577In9F0dUXkFW4M59eB1Kd1iguG4sHEX3Va5WkpkW5b9ZQ9xVFmo4xuaoHOfEwyqN4f8GG6RudOG9jGDY3EMqrDd9KZhn8vChDxPkkKloCM0/PRjVY9ABHt+4mDYvZ6sU9NNibFX/WORfycg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709652193; c=relaxed/simple;
	bh=p3hGpTjqSBNSUbgAYqrLgi23lxEARPBl57o/KtA6x3U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Kyj3nX6LDbpqM6KHZhHkOviyiLbcv0y7ZfQSofWWqzIIphJ1DEkYvHkC/RRyvUCq7qo6IxitY3HbcmATxgcoqqunyQEg7t5TRSjELEKW4YjTL35vXblqndKOaukWtlarTkob/i0sAa/oPC2Ph1Ypwn5JOCBTu6Eu0vU1POoPKt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vahedi.org; spf=pass smtp.mailfrom=vahedi.org; dkim=pass (2048-bit key) header.d=vahedi.org header.i=@vahedi.org header.b=DY3irVRl; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vahedi.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vahedi.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vahedi.org header.i=@vahedi.org header.b="DY3irVRl"
Message-ID: <6e4cf7cc-6a2e-4396-b0d5-01ff10d6923a@vahedi.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vahedi.org; s=key1;
	t=1709652184;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IhJfKoroaIk49x7q064rqPyouK8pXJKorErLZG4KbU0=;
	b=DY3irVRliVu4roXRXLoyLsNXxsyZkRYgFHF4555aErIqR2hX6YkvCUo1XCkWixFM747KtS
	4X2ugxNRC7xw/uyglx4iy/dJ5/vavemapaMdhd4ftYzgoxzCJwCS1k4X19f8dznvD5xjJJ
	fZ/GCDdjshIF+D4CSKL6SURKxG459IN3cIZQZ51zvaZ2w7rR1Oq7UVY0R1AlQwAS7NFFbz
	zlq7/OEJnHuYxYxvh6AHrWaqzRazhmCHwg3u6m5uVl7bxI+C+OJ++IX5WqLmqLxTQXY76k
	J9L0EaYX476cxEMWzXzQJGJJl0AHb0YB3MHhDP+vxMt7LH3Wl2QZ2FBVGFUJSg==
Date: Tue, 5 Mar 2024 16:22:58 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v1] ARC: Add eBPF JIT support
To: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
Cc: bpf@vger.kernel.org, linux-snps-arc@lists.infradead.org,
 Shahab Vahedi <list+bpf@vahedi.org>, Vineet Gupta <vgupta@kernel.org>
References: <20240213131946.32068-1-list+bpf@vahedi.org>
 <87ttlnqlmv.fsf@all.your.base.are.belong.to.us>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shahab Vahedi <list+bpf@vahedi.org>
In-Reply-To: <87ttlnqlmv.fsf@all.your.base.are.belong.to.us>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Hi Björn,

Thank you very much for your inputs. Please find my remarks below.

Björn Töpel <bjorn@kernel.org> writes:

> Shahab Vahedi <list+bpf@vahedi.org> writes:
> 
> What's the easiest way to test test this w/o ARC HW? Is there a qemu
> port avaiable?

Yes, there is a (downstream) port available on GitHub [1]. If one is
interested, there are also guides about building QEMU for ARC targets [2]
and how to run eBPF tests for ARC Linux [3].

[1] ARC QEMU port
https://github.com/foss-for-synopsys-dwc-arc-processors/qemu

[2] Building ARC QEMU
https://foss-for-synopsys-dwc-arc-processors.github.io/experimental-documentation/2023.09/simulators/qemu/

[3] Runing eBPF tests for ARC Linux
https://foss-for-synopsys-dwc-arc-processors.github.io/experimental-documentation/2023.09/linux/ebpf/build/

> I don't know much about ARC -- Is v2 compatible with v3?

No, they're not. For what it's worth, ARCv3 comes in {32,64}-bit
flavours which are not compatible with each other either.

> I'm curious about the missing support; tailcall/atomic/division/extable
> support. Would it require a lot of work to add that support in the
> initial change set?

If you're asking whether it is possible that I add those features now,
my answer unfortunately would be "no". However, the way that things
are implemented, it will be a straightforward addition.

> There are a lot of checkpatch/kernel style issues. Run, e.g.,
> "checkpatch --strict -g HEAD" and you'll get a bunch of issues. Most of
> them are just basic style issues. Please try to fix most of them for the
> next rev.

I did run the "checkpatch" before submitting. I've fixed all the "errors"
and most of the "warnings". But now that you brought it up, I will try to
fix as many "warnings"/"checks" as make sense.

> You should add yourself to the MAINTAINERS file.

I will. Thanks!

> Please try to avoid static inline in the C-files. The compiler usually
> knows better.

I will replace them with "static" then.

> > +/* Sane initial values for the globals */
> > +bool emit = true;
> > +bool zext_thyself = true;
> 
> Hmm, this is racy. Can we move this into the jit context? Also, is
> zext_thyself even used?

I will get rid of those. For the record, "zext_thyself" is used by
calling "zext()" after handling "BPF_ALU" operations.

> > +#define CHECK_RET(cmd)			\
> > +	do {				\
> > +		ret = (cmd);		\
> > +		if (ret < 0)		\
> > +			return ret;	\
> > +	} while (0)
> > +
> 
> Nit/personal taste, but I prefer not having these kind of macros. I
> think it makes it harder to read the code.

At some point, I found myself distracted from seeing the bigger picture
while the code was interspersed by the menial "return checking"s. If
you don't mind, I'd rather keep it as is, unless you feel strong about
it or Vineet also agrees with you.

> Care to elaborate a bit more on ARC_BPF_JIT_DEBUG. This smells of
> duplicated funtionality with bpf_jit_dump(), and the BUG()s are scary.

ARC_BPF_JIT_DEBUG is supposed to be enabled for development purposes.
It enables:

1. A set of assert-like condition checking which makes the code
slow and can lead to ungraceful terminations.

2. Use of a custom version of hex dumps. The most important difference
with bpf_jit_dump() is that bpf_jit_dump() cannot be used for dumping
the input BPF byte stream. Rest, I can live with. An example follows:

Using only "bpf_jit_dump" (ARC_BPF_JIT_DEBUG is not defined)

  flen=2 proglen=20 pass=1 image=2e8c6fb9 from=hello pid=127
  JIT code: 00000000: 8a 20 00 10 8a 21 00 10 0a 20 00 02 0a 21 40 02
  JIT code: 00000010: e0 20 c0 07

vs.

Using the custom version (ARC_BPF_JIT_DEBUG is defined)
  -----------------[  VM   ]-----------------
  0xb7, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
  0x95, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
  -----------------[ JIT:1 ]-----------------
  0x8a, 0x20, 0x00, 0x10, 0x8a, 0x21, 0x00, 0x10
  0x0a, 0x20, 0x00, 0x02, 0x0a, 0x21, 0x40, 0x02
  0xe0, 0x20, 0xc0, 0x07

> > +static int jit_ctx_init(struct jit_context *ctx, struct bpf_prog *prog)
> > +{
> > +   ...
> 
> I'd just make sure that ctx is zeroed, and init the non-zero members here.

Very good point! I will implement it that way.

If you have read this far, I'd like to thank you again for spending time
on reviewing this patch. It is much appreciated.


Cheers,
Shahab

