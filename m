Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F9F175A99
	for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 00:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786579824; cv=none; b=eKLNBKLGB4VVJcpQ9HHuUw+ogcFl9PL4LLtQZcmYTvN5tLX13IhZFDpQ9vFaBxozcSPS8XtO/2f5mqAeEZhmKhdL+cwdXfgIP0zK2Ih6f1LddS0pAO26nxq/YL/r6A9oeXqHQpGJqQSaIun1Hw0UkTx+RHpLYmTPHv9BW/4sJbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786579824; c=relaxed/simple;
	bh=8bJy2WbD/KbeUKi3eCiP8kXg8CD1DEWjNiEeOlOPJdU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lQfk2prv60x45krU9yrurnv1uC7X3UsxOWrHvBIGfNvgkCJ9WU6W0gjnh2bRu0NyckOxQ1/pKDjn0dCo/evcbqozj7FVNYDhIifgPv8EOkxXAUlU/6/WWp2L1Ma2/8gSxNpgHfUvivxLCd9UVRkvpNKwQLg0GPOjEWMjG9/fpQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JAHfeyvc; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JAHfeyvc"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2cad8076b01so17329135ad.2
        for <bpf@vger.kernel.org>; Wed, 12 Aug 2026 17:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786579823; x=1787184623; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=8bJy2WbD/KbeUKi3eCiP8kXg8CD1DEWjNiEeOlOPJdU=;
        b=JAHfeyvc8RkvrS0IlrE/rswxt+NeCK6WSvY7y8eRbvPenuaYwMnSAFk9PODdTLfVcj
         X0F8LAIq5EHJI20Biob2yhXn8UsFb2rnY9t0hZpJ0etdVlfN6fxFUDDcmUCU9jM4+tqI
         EKVv0g630SV1p9HVRsZ5rWXnIbjlxVwnIGpnigqApIvSUQhcSQa0TbFSSi+Z2VUg0PKP
         DFdSQH7WnPYq2t8Kn/YpMA6KpcCYe9TznCsHvUEYb9/rFeiVH6GmU5Rgj1DBVGZzfFbO
         j2UHKsqdLpJl7Tl/L2Xq1CCfNosaFU/2t/Dkoc8OZKKNjLVMORdj1xkCHBzacHq/OEI5
         AUSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786579823; x=1787184623;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8bJy2WbD/KbeUKi3eCiP8kXg8CD1DEWjNiEeOlOPJdU=;
        b=E3WqMlSUwYt4NRU9tlHycUKaFWOz2mnYj2jknF+59HXSTgdiBJbuIlPAmnE9E5o3Xf
         Q8UELUGAOQwr3+eDuOPWBdsnzYdL6BIhWBCmVatSJ9vT3pGOQ53yPtXC72VcHvC+sLm2
         p02QHL0HopBcibwbe/WY3UTROXxuYG/91/NGDzhOogYGECXojh7VDZIHd2GlTJQBJH8F
         89+7NJPJsB9fC7kKh+9RkIkqUKBQFb9uypSenfb+wFXc6GKvgeNafJ4oy276yR4I7H2w
         DC3SXwjb4JhryIGJUmANsbWCo1EdzT0XbcT/ggJBKBU5XqBmfOoq5wHEfUEHtd+q7ZvL
         wPsQ==
X-Forwarded-Encrypted: i=1; AHgh+Rq6WBbLr/ox/HsOo+yzxUIjCRrk0W8spqK/CJK01rqKgY6YysreMDc//Mr+cFDDaOnal4g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6qmfmFVfvA611rdOqLSBg0ibSoiO4F8rP4qo/Jm8noe58QxRW
	2/trfd7KavvlnNM2TH7LtlFUgUH5LkWnlIEbvWFLVe1s3nm2errykgMegKN/qw==
X-Gm-Gg: AR+sD12LUrtyT1QidZzYthBM86bstWFN6g92+JqUDwYeDUobeXI/HwusHf/1ssV6XFV
	VgtFuSOEWI6f8chZl8fmkyqrvX/OknYM3+cj4lNM+l5pr0ptlS4I8/EhAin8W0HgP6moskhnnQ3
	oCjAIzA7vNTjUGCl6Y/BztG9e3hKud5KUtMDOyIGJnVHyjMTmBCNsAPr0xPV53oCYDT9ujpbD8T
	3WzZv5NsuYi4N5k74LNNoveTUyPi6Ea5KIKGj98hfiMhq9u6aJuUmDt9bM5UDIjsangiR8Q9GKn
	d8TWHO+UPbnQ23LQc7ABL3cCewzNrkeB/5qTBf7FIf7b0AzDlA+n3aCikSQrVg5VC4Behm+tLB6
	LTIdZJ9B6tmgyb2RtMOqeWcDnIcaQmR2H5vASQfvJO7id3kwkN3KVoliHcMQiAxZj1Ed29NBVrF
	z0LWE7B9HdbM0LJzg0vt+GPQI8myf5e6dQ34NLygWPYLBR/koZ/h7gKsOAp6Gj1mLF50BSnQe+I
	Ul1aM82Fya9CmSG
X-Received: by 2002:a17:90b:1b0c:b0:38e:542:6485 with SMTP id 98e67ed59e1d1-3931e2069c3mr1781324a91.12.1786579822802;
        Wed, 12 Aug 2026 17:10:22 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3931cecbf08sm1123156a91.12.2026.08.12.17.10.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 17:10:22 -0700 (PDT)
Message-ID: <04dcc1dd9b0eb24707a83c2bf7a9755af1477953.camel@gmail.com>
Subject: Re: [PATCH bpf-next v4 12/13] selftests/bpf: Add tests for
 callbacks returning more than 8 bytes
From: Eduard Zingerman <eddyz87@gmail.com>
To: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>,
 kernel-team@fb.com
Date: Wed, 12 Aug 2026 17:10:19 -0700
In-Reply-To: <20260811001013.2385213-1-yonghong.song@linux.dev>
References: <20260811000911.2378679-1-yonghong.song@linux.dev>
	 <20260811001013.2385213-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-08-10 at 17:10 -0700, Yonghong Song wrote:
> Add two __failure tests covering the callback return-size checks:
>=20
> =C2=A0- timer_ret_pair_fail: a bpf_timer callback declared to return more=
 than
> =C2=A0=C2=A0 8 bytes, rejected by check_ld_imm() where the callback's PTR=
_TO_FUNC is
> =C2=A0=C2=A0 created, with "callback function with >8-byte return value i=
s not
> =C2=A0=C2=A0 supported".
>=20
> =C2=A0- exceptions_ret_pair_fail: an exception callback declared to retur=
n more
> =C2=A0=C2=A0 than 8 bytes, rejected by do_check_common() when the callbac=
k
> =C2=A0=C2=A0 subprogram is verified, with "exception cb cannot return val=
ue larger
> =C2=A0=C2=A0 than 8 bytes".
>=20
> Both callback bodies are written in inline asm so that the tests do not
> depend on LLVM 23 R0:R2 codegen and run on any compiler. The verifier rea=
ds
> the return type from BTF rather than from the instructions, so the >8 byt=
e
> return prototype is supplied through __btf_func_path(), pointing at a
> companion btf__*.c program that exists only to carry that BTF.
>=20
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---
> =C2=A0.../selftests/bpf/prog_tests/exceptions.c=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0 2 +
> =C2=A0.../testing/selftests/bpf/prog_tests/timer.c=C2=A0 |=C2=A0 2 +
> =C2=A0.../bpf/progs/btf__exceptions_ret_pair_fail.c | 10 ++++
> =C2=A0.../bpf/progs/btf__timer_ret_pair_fail.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | 10 ++++
> =C2=A0.../bpf/progs/exceptions_ret_pair_fail.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | 30 ++++++++++++
> =C2=A0.../selftests/bpf/progs/timer_ret_pair_fail.c | 49 ++++++++++++++++=
+++
> =C2=A06 files changed, 103 insertions(+)

Dropping callback checks avoids adding all this code.

...
