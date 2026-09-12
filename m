Received: from mail-oa2-f12.google.com (mail-oa2-f12.google.com [74.125.231.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47BD0224B05
	for <bpf@vger.kernel.org>; Sat, 12 Sep 2026 03:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789184428; cv=none; b=Xdbeqrx5WEbOBNL8K3x3TDMP1ptzNTuh75ddokcwq8USjPu+sbW3iolrsWEaf9vOn6BtHPaOLETerGLrEXeWKtGQv7q2kYxPdR1MgL7b3WemQGA7w/VCCNsMeWSfeh88Yx9KCMv5ORdUMnKzk0ym/4lzH3Lp2qWbxb0PzfAVXLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789184428; c=relaxed/simple;
	bh=eF3Gy+Lsphr1WsOIcmLkqvY2bLEQeHUUT7hY/kCxbhU=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=aPWpDX7Fzg4W70cqAACIkm1B9ATrzAqgvkqHKFscRbFI+X6cyrdgXyQK2wbyTSBHEpu+zNBI0RcKudPvdmwHwplBpMBbDqLR6zBCDdx2uaZs5JBEuqJNvh4WlKKTF8UxLYng/bSPR6dtZLxmIVGxo+dk3WrS7a0Dc2753rHc51Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aJ+AtIFc; arc=none smtp.client-ip=74.125.231.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aJ+AtIFc"
Received: by mail-oa2-f12.google.com with SMTP id 586e51a60fabf-466ccdd77e2so92737fac.3
        for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 20:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789184425; x=1789789225; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ls9A85qgn2n1bUqUhJgiKWwU66NsW1Izo7ULsZD7w7s=;
        b=aJ+AtIFc75pszR5EedICJs/vLWh7agqLHZzpcCSB8S58VhbWJEKtprVOEOxHKs5onb
         fmOS1pev57SXUYNwzKHzeRmkgYe/YwCuOapOFpiV8NGauZsuAmb527HJ64fZOPsdTiHg
         tgRbxt44KLmaRbIP23D64daxb4TjCusYvzMApVYkQ+X5KOGg+sn7dNPtwKaSU2M/zSna
         rQX0NGx6OSEqEOf/EVMO+6mcByYl/VYaNNqQOOEEDXB4oNLoTyq5lOGWPPDI3LZNGaLf
         Okb6hqRz9utmgbX/1dA1fHVTGCR1VCiJVMrAgPqDQSJFRXRkXtRWNXClD4l9SNMaf8D5
         GwUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789184425; x=1789789225;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ls9A85qgn2n1bUqUhJgiKWwU66NsW1Izo7ULsZD7w7s=;
        b=F+sGo+b+yeuhGSJIgYncAZWjI9mX0Et2EuFGs8tcmPBUaDNt681BVkQvtjgNiOMxE7
         tK/z9KIhwvvD3Vu5A5t/NGDBs8mYBj4js6CLEVl/rFjDDZlrKo5KgUJd+UUOMYu2lu+Y
         FTGni9RuHc0uh8ZXYvMcTDFL/2H/aLtnxEYh0bGMZB8ZNj9QtPLroZEwRL8k6omZ/PIy
         tsqPsoqsc9o1J4fcnMUZ4wGfxA7192lrw/e4IOPqiAI1xpJ6HfNESFtwGPkkXEEkUQcu
         bISQChWfpImq43fMQXfiwHAQi+BllXJiHqT0VyyRZhQWA5RAdAlo9Cjc0JZmjKI2LkOO
         +bTQ==
X-Forwarded-Encrypted: i=1; AKwUvBwoZsXXu2GM7/8sdH1pDjG8ef2vQg3wOVu8HCXZoO24gzc4gJzdwSZFye/UgP4Ay7k0aoY=@vger.kernel.org
X-Gm-Message-State: AFuF++kErb3tkubjVHPhIfHKfWlAlYRcUVZfW9NRpNfG9iRHHZDYI3x5
	aBRfuUC0qPk/saGnrOc2IXuJGj6DEg7Qwr+f2YKwIxlCkjvrwItEwY+i
X-Gm-Gg: AYBFou1/qBHL09KJZLmRg3+GRFWeK2GRQq4iphL+1pIhjzQEG6EnDITgUJWljMmQnAX
	5ofiUI64F2ebGrpNI2lNYOFTZvIYdOQFy9US3R4iXk9BqTAm2HvDDdF4DpSYz0akTHIkF0S2l3l
	x1ZI1vJrwvpybvAQ+oM8bkh1kf8m0s8CHiydneNMcEQndOifsrdZmIr5T4pKL7yQOM+b6XlQfs+
	dVO7+aunMR8YtRmVztKER5ONxLXZ/zJmMj4To0BhsXB+vuQeftIy5bfoz/emCwBJ5KABsarWaCh
	KLMIOBt3RLtXQcXc6/jEtNls4amYv5ntcPrzlKS6MU/VrcNBD0h0Jr2cTU2ppTMbfYdbcsobLJi
	mbzXAcIeUoKt12ikuZY2J9uUW/yuOIeknWGtc45T6+OcZM53qvXM9Uh9HD207aR5EtSdTDZxCCv
	rS96oo8GKm69q1IpOHeKp7A1/JnjmQXdH/LXINlF65HGHuv9/OT76bFx5MxcliGGP4b+IUVW/jk
	dBJSMYO/Atacg6/GTKKZK7HlSKTQaRe6gtYJ7Ce6z+zQD8UKexSFpfFlXf8il3vfWpi4S2v8UmU
X-Received: by 2002:a05:6870:1692:b0:475:a112:1270 with SMTP id 586e51a60fabf-47f59b8537cmr897239fac.29.1789184424990;
        Fri, 11 Sep 2026 20:40:24 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:24::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-47df90fb975sm3563679fac.13.2026.09.11.20.40.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Sep 2026 20:40:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 11 Sep 2026 20:40:21 -0700
Message-Id: <DLD0Y0CFA97S.3RC5RTORRYY9N@gmail.com>
To: "Yazhou Tang" <tangyazhou@zju.edu.cn>, <bpf@vger.kernel.org>,
 <ast@kernel.org>, <eddyz87@gmail.com>
Cc: <daniel@iogearbox.net>, <john.fastabend@gmail.com>, <andrii@kernel.org>,
 <martin.lau@linux.dev>, <song@kernel.org>, <yonghong.song@linux.dev>,
 <kpsingh@kernel.org>, <sdf@fomichev.me>, <haoluo@google.com>,
 <jolsa@kernel.org>, <tangyazhou518@outlook.com>,
 <shenghaoyuan0928@163.com>, <ziye@zju.edu.cn>
Subject: Re: [RFC PATCH bpf-next 1/6] bpf: Add UHMUL and SHMUL instructions
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
X-Mailer: aerc
References: <20260902070534.2141812-1-tangyazhou@zju.edu.cn>
 <20260902070534.2141812-2-tangyazhou@zju.edu.cn>
 <DL9CGP0NFZ37.25Y31VZH6PKPQ@gmail.com>
 <94eba3a8-6bca-432b-859b-d14e608d34f2@zju.edu.cn>
In-Reply-To: <94eba3a8-6bca-432b-859b-d14e608d34f2@zju.edu.cn>

On Tue Sep 8, 2026 at 1:30 AM PDT, Yazhou Tang wrote:
>
>
> On 9/8/26 3:51 AM, Alexei Starovoitov wrote:
>> On Wed Sep 2, 2026 at 12:05 AM PDT, Yazhou Tang wrote:
>>> From: Tianci Cao <ziye@zju.edu.cn>
>>>
>>> Define UHMUL and SHMUL as BPF_ALU64 BPF_MUL variants selected by insn->=
off.
>>> UHMUL returns the high 64 bits of an unsigned 64-by-64-bit product, whi=
le
>>> SHMUL returns the high 64 bits of a signed product. Keep off =3D=3D 0 a=
s the
>>> existing low-half multiplication, and assign off =3D=3D 1 and off =3D=
=3D 2 to
>>> UHMUL and SHMUL, respectively.
>>>
>>> These operations are inspired by the UHMUL and SHMUL instructions
>>> introduced as part of the PQR instruction class in Solana sBPF[1].
>>>
>>> The encoding and immediate semantics differ from current sBPF.
>>>
>>> 1. Solana sBPF assigns these operations dedicated opcodes in the BPF_PQ=
R
>>>     class, whereas this implementation selects them through the offset
>>>     field of BPF_MUL.
>>>
>>> 2. Solana sBPF initially sign-extended the immediate operand of UHMUL,
>>>     but later changed unsigned PQR immediates, including UHMUL, to be
>>>     zero-extended[2].
>>=20
>> Why did you switch to zero-extend ?
>> Sounds odd to do zero extend just for these ops.
>
> Sorry, I wasn't clear. This patch does not zero-extend the UHMUL immediat=
e.
>
> Both UHMUL and SHMUL follow the existing BPF_ALU64 convention and
> sign-extend the 32-bit immediate to 64 bits first. The zero-extension
> I mentioned refers only to current Solana sBPF behavior. I'll clarify
> this in the respin.

My question was "why in Solana you switched to zero-extend?"
