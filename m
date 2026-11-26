Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.178
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795668789;
	b=D2LGKITgH3kX91ZjmCRpV3AMcb6HdHavcRp1kJo+nxqhs82863fb1rEejrq2NQ3knDm1
	 duHSFgw40+obtD0oqA74FE9ypIvo8gQiypxv0BGU4uwcBnR8KOssJV8KiJzvcyVWGb48O
	 tVK4kldmJ1Yio+NvGQlbuR3yFNEocJw7BqfwhnzlXpvTO/ofIEjtkyF8vrlgcDyG03tjR
	 y8j8O2rYwOpJ82NGJHvSFIZuAaVKpnJl+2Bk4ZGYSfmXzP5YE22neUsS+F8AYMlsBEbgO
	 8K+d1xkdl0fP1nCh6xqjCTC+g0rj3Iy89L2DZhL+htPtiD1z9p03g9kXnFQ18sAiblg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795668789;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=3Lt4WVagAGoPNQQ8sUuV+xbM6KmxoNVjHzW8jPpsfl4=;
	b=BRQAy3r9+NLfrUHE6Jrfqwauu0ddVAZchVq2BeTNaqhXi8wsqqQAaIjOLEOuBHwzXw3x
	 XkKxKRCsgS9vGutss20oVMPSR7+/u2N+64HPMfeP/nTRNMyFY8Ck6VqsMP0LrjXL7P9UQ
	 VgIN78qshJxfMAkmiC2PmEn4Exo0gQo253/BoIx6u8oEnN/QXms7ZSPrtuLr/f58PXvKz
	 BVEJ0tl+YczD+8yXoj7VbQXB/HxQB8chQ+UKhP4pojvNX+jhhoMqo3g41t4opi+aoMjBO
	 y2Ytq4S/QLlUeUK884DNBG6f3uq2bxq0kUuOGC2kPFtsquyNyKQQylNTxdRUdABPfiw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="Wt/H8uEX";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.178
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57AF1606A32A
	for <bpf@vger.kernel.org>; Thu, 26 Nov 2026 04:53:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 57AF1606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Wt/H8uEX
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-54492d8a988so1599641cf.0
        for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 20:53:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795668788; cv=none;
        d=google.com; s=arc-20260327;
        b=KGllxg5pIy+dcWvrDlk65pAHwZLnTT17nDuNjy4ST+0az7IU0InKxhrPwWMS9ZhIcl
         f8fsMzZLBs/qxJ0LuDkZ8qSJlANf/J2rpw3S3LsJ6o5CHdtI/V8IxVkwLTiBuHBixVJt
         t/V9ggH0gxIJWlEQfgFZf/N+jgs0scOLydYnTpZ/asXlanY4ZadwhYBIDxfva8biFI3L
         X81xDwRZIe2Lo+vGwbuPFRT4phEV97AwAx1XzY4nfMfgD+8ZUqqe6rPcJrRl3XDaTRqn
         6PB27Jxew5kp2M8UlN4+lg8IdOHl+iq/EBrSB7EaJo01hMmm+a8otKG77HqmnpZMXkbo
         riAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3Lt4WVagAGoPNQQ8sUuV+xbM6KmxoNVjHzW8jPpsfl4=;
        fh=ACNQwf0Q59afQ67vcCVCOh6Pm87Xho2q43CybMBQiQs=;
        b=QjBfTiooHr3+RH8SeB3F3uTqlDCxokVBbeT3EuB0pXmnmpgFAaJpIxueiBs/U/wWQa
         mJnkEeTra1E84DoF2/6/LTPVUID9l9y3I4FrB/fVtsci1RAP+3e7kjxRQD4cPZucsD4c
         FoT3f2QYDHBMGf4TsHNBTt+2lwo0MYpTNwKa/p+jM/ZtYoN/65B4TN0LDrSGdMe1WJmV
         4ule6zfdZYn2SnUAd2EeENbvOnmQCoMPBsYMpFmvaJLqx0wXHHbSTxanYwCRerI6a3SR
         PuQb8lmGAYLGZkDAKDS7eLDuuGwAro0e/9rDKwaXEXp8Ea2ty1V+A9+iHjhLO1wha/86
         4c5Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795668788; x=1796273588; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3Lt4WVagAGoPNQQ8sUuV+xbM6KmxoNVjHzW8jPpsfl4=;
        b=Wt/H8uEXeygfnRJXsnha4ogYR4WFdKKtucv0h74Hl9SvZ7ZVOZ8pyveIu/m+bbBuqU
         7pLEkyr5FS02oSIkkEdcPGP7aMYZHs2eR8ZbSslwbXiv4nig66Yw9zXIl5pT+EHlNoMU
         cQHBNyntCt6+GiY4hESZ00/HEKXKxMOneQnWVqwJdquEVsZ01fF3oKFb+IYLDHDd97P1
         5iwuBre8QUjJjwbIhiuIlmYLUamd902f2vsDR98ELoNLHrtAN91EmUr8k1YyhoPYh3J/
         v+aNlL3NNgtJeSDZE4JVJM46ZiSMrhfEMHEAp3euRyiB3I6N1f0aZKatBbawmZwgSrYV
         rmxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795668788; x=1796273588;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3Lt4WVagAGoPNQQ8sUuV+xbM6KmxoNVjHzW8jPpsfl4=;
        b=fFH5OioQw9mPAkrA92fiRsfaVVk8zHcZgtPJyU76p69R4/eHKzs23+XTm0q1APUIg6
         3KDzlkMNN4j4OFdqBF0eR+GvBs5mQTYPT4RDN0KPvuLGL59XPuw21xpuPMxso8cY1jl0
         3pUNPTE7lt4+qO25OrH+MFlDwpth9mAiEEStZjkGe2OfqdL2Pxo+2kZ63USaK9/ms3/4
         OkAAnvUXuuUr2ldV9oCqD/uhScbJtKaxnkRcwudruOEuTA7CTUel9ZMjBn3bHyGlE9jr
         dm4lh6+9s8cIJ87hPNoce1nMscViidLuR+8CvyB0ELMk3O8PDeb2/r6rlm6HC1bBGud+
         luiA==
X-Forwarded-Encrypted: i=1; AL+hErHa+p0RIfugopYfLKMPcRd40EnCLBRYn1O/ReqcR+nfHfhMHPPsmRQtgaDAt+soxpcUh5w=@vger.kernel.org
X-Gm-Message-State: APuU4Z+SGEA3fuJrWtNhkQewbZ2GQ/eioCANFYdVRZ+E2vZ9snOeIFpg
	tNAuyboqHk8rdK2i08/yapXtdcV0vD28MoJFgeJgd4O589Z50uGhMTRfX6rGIc1uesQYE9FAqou
	WWz6WaMPdtQg8FyxSmwygxn1iJhqxBM8qJUBUgopo
X-Gm-Gg: AZFdTZeWF/cpLbPo1CgOdiLtwcRaQ9dwOl/t6Wa9MTyxTd0zHqUt01PUkVHrIxGphnA
	1hpmcMIfXbt22WlY1Ed9MHwo2pgMlL5SAHgLyqAy8/JYAh9iUOPVysLKrqXppLVNMxsL5qCvGcQ
	gU/XuoNdq7sOrSyluPaE1fCZv9cJ3mSzyUPMiInx0GBq2EGUPlclgHmSIU5iYifNNhfbLr46I88
	QMBfjp5jxesCNYD0ddt7yc9l76kg6+8sJOZnW/O823zM9TfMQ0BoxgCVfGsjXn0vi5p1CVhqobe
	tSGRPfvw8qwnMP86Lnsuu2ePX6pSrea46tbEFlE8dJDJcSoQT7cQOzK5ZgvdpdVJazvPBQKPkHO
	tmiyz6WBuOcDgAdtMfXOzfffNgQA/eIcSnSgBW620luIw/1Qy/nGdqA0iGg==
X-Received: by 2002:a05:622a:1e86:b0:536:3ee4:81cd with SMTP id
 d75a77b69052e-55d88127bafmr101738501cf.4.1795668787640; Wed, 25 Nov 2026
 20:53:07 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261125061523.1540234-1-irogers@google.com> <DN4FM3TBOJ9T.2QOOL77P5HETO@garyguo.net>
 <20261125132225.00254c37@gandalf.local.home>
In-Reply-To: <20261125132225.00254c37@gandalf.local.home>
From: Ian Rogers <irogers@google.com>
Date: Wed, 25 Nov 2026 20:52:56 -0800
X-Gm-Features: Aa3M54pMQmXw5Cgtc0EakW9NOiIZs8STgUuBigJfJMSZlzejGTE6XZMetCnzc-8
Message-ID: <CAP-5=fWkUW787c4dGx9rccucqD67dfRgwBB_SoCxFnfZXtXP-w@mail.gmail.com>
Subject: Re: [RFC PATCH v2 00/30] unwind: Minimal DWARF CFI unwinding for user
 and kernel space
To: Steven Rostedt <rostedt@goodmis.org>, Gary Guo <gary@garyguo.net>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-arch@vger.kernel.org, jpoimboe@kernel.org, peterz@infradead.org, 
	mingo@redhat.com, tglx@kernel.org, bp@alien8.de, dave.hansen@linux.intel.com, 
	x86@kernel.org, catalin.marinas@arm.com, will@kernel.org, 
	mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org, pjw@kernel.org, 
	palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, 
	linux-riscv@lists.infradead.org, acme@kernel.org, namhyung@kernel.org, 
	linux-perf-users@vger.kernel.org, mhiramat@kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, bpf@vger.kernel.org, 
	nathan@kernel.org, llvm@lists.linux.dev, nsc@kernel.org, 
	linux-kbuild@vger.kernel.org, ojeda@kernel.org, 
	rust-for-linux@vger.kernel.org, ardb@kernel.org, linux-efi@vger.kernel.org, 
	maz@kernel.org, oupton@kernel.org, kvmarm@lists.linux.dev, shuah@kernel.org, 
	linux-kselftest@vger.kernel.org, indu.bhagat@oracle.com, jremus@linux.ibm.com, 
	wnliu@google.com, dylanbhatch@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 25, 2026 at 10:22=E2=80=AFAM Steven Rostedt <rostedt@goodmis.or=
g> wrote:
>
> On Wed, 25 Nov 2026 16:28:02 +0000
> "Gary Guo" <gary@garyguo.net> wrote:
>
> > A quick question: how do you plan to get this working on 32-bit ARM whi=
ch has
> > its own EHABI?
>
> Do we care? Isn't ARM 32 mostly deprecated at this moment? Or at least no=
t
> adding new features.

There has been recent work on both MIPS and Alpha for perf events, so
supporting ARM32 EHABI doesn't seem unreasonable. Devices like the
Raspberry Pi Zero W/WH, which use a 32-bit CPU are end-of-life in 2030
(according to https://endoflife.date/raspberry-pi ). It is
out-of-scope here, but extending the kernel and verification
infrastructure shouldn't be hard.

Thanks,
Ian

> -- Steve
