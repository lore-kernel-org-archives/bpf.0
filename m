Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2C133DEAC9
	for <bpf@vger.kernel.org>; Thu, 16 Apr 2026 14:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776348943; cv=none; b=ZAbRqD8x9hQw0/pq+wKUU8ZeWE4wxgj7HyiDt7tX3VzbGvPfkYcz75fTr2dU8y4HTPw3Iy+IfeoTbDl0ztZ6wP1EreK2G/N68tkkymwl0G8tYc965+oei2y2wi9HAAgikeml7YtBU5Gwqr4GhF4D77twTueMasEbDMVYi56XkUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776348943; c=relaxed/simple;
	bh=H0AdrbRbLJxnehymYB3NKN/Zt28eIPVt2vIZTopE+bk=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=drL8JnYVxDa+VTVPwr3inhVs4o1Ok4/s6dGPSUdwHbHhe3Ovby8A61YvnsUeFDTXrXPF3e+vZnFq9t9P2lWcXuHeJC9LBaOCNzP/XImqx0h1IA6Ch3SFlOaaoyhYxIS0WVAY7bLezZ9ERp6APKbmzxpzwmQ62bpr+Tt3mefirFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PRqp9F8z; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PRqp9F8z"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-8296d553142so4185296b3a.3
        for <bpf@vger.kernel.org>; Thu, 16 Apr 2026 07:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776348941; x=1776953741; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H0AdrbRbLJxnehymYB3NKN/Zt28eIPVt2vIZTopE+bk=;
        b=PRqp9F8zbBVU9Rs29Bjt8QFUOZxkBobwQfNzggoCXIdRfHMo0o4MPlWeksLTN3Gds2
         Jg0U4LsioFUeRIcKd00rKHkSvGhm32RroT6R+mCZC97fwGCgZwWPMau0Lhhuvtotg+RQ
         SEMXWFgs/+UZuk81XCv3oGW5TTskThmBze8L2WAhcFTHPYlAbidKC3FdaAljjcqfowpP
         dLB3t66kS2O5xLGAmZHU/SEnd2xRBk+wF/X36ZdFaWX9ZBFI9InEvIBo4b2E1Y2PKj9Y
         yHnpbFw4wdh2HBXT2n4xah1+gg9/R3jYT3+ju2stlNX6EjH9MFoIbPbfNUAfxsSWpdk7
         2eVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776348941; x=1776953741;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H0AdrbRbLJxnehymYB3NKN/Zt28eIPVt2vIZTopE+bk=;
        b=VrV+wKBztJRowS6Nzv5dGnokVsBFLKjfAFGpi+BefIPrfcxn6AVke+DBVdu1d3yIIO
         F3OnFStf02J0IZyh/hYFRK2/8U+ctzvqvkScrJBob7axZdKC0VSokoYMg74Rc0qWRuzX
         Mnli+gifepGpjC88lZe1F7vx8MNY1gfNWE0EnQbeMpMuoY/f/1c78MJOCE9N3lQ7vQ0S
         JKAIxpQRVlnl936ynZq2gAO/sBirA98/9mob2U5dLvtfZdhc57lRwaFnljBMq/V7Y6qU
         ZXdYDuAToUZFQa2Dz3H+1sm4T0Yem6tEvE6VUa3sUg7dOxOSyQb38HU349ZiOuqcvNS8
         p8qw==
X-Forwarded-Encrypted: i=1; AFNElJ96Dsa8dstU5N3X+D76r4lZyQKkW13qLtjqGulpH5xF18WzDg0AqM4Zwn1NlYrZ68x+9SQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMVPzJS9IKYWV0ptmGt6x1MXbf/uzEokxa9S4JhaFry4xV4KYN
	fC4k3L7zPMCiVazd2fMyvGV++h4MA2ww8E5+7bJFzf8cYEl1YZXCX/Wp
X-Gm-Gg: AeBDievGDdvDDeV8YvZC5VFX+ELVqj29H+/+vekD+01Sj9DEXclKP/DmK+9mUFK/Z6n
	XZm55KCyViA+z0dGvzUbHpnnHzWzzGdivbky4TY+8lSkbSTg39solPHFvgtTvBl088LsDSqMsMR
	fjqSszHPMdBtj8L7LZZBmItERpbufeM31X3rIOlIWzC9S/HAiFvp2K9UP6SANQLrw4/xgirckdX
	8oz1q8HcY+jLWUAuh5AdgFYIZD68bVTYtYgItpDknChKErag/aDq4/vF4zjH/6PcG1HpiVrp0Tp
	E07Fw1UK6L164rjJ5WVI/TDt7dSDtIkMezZFlOrWK0U1yXDjNBqzByfq51CljX7AGbV+drw0jOG
	9CuV36euDaAPALUqSC2OobXRk9vYT4gSQ9XkspBPBj8vw5QEukmcf7mhlVXLA/Kj9tqA1jZWhmU
	I084piTg1EH4grhrM59dKu1R8/BqsocihEEgMwtGcGegh2WKz6uQvBtZphWuNpLruCR2xBBWHqe
	aTJC8MkcCc7r8UlgNTIyh9Z2mrXgi2QZMEn6GbjpSpjJbS04ppmDucvzIX3CSCRDRw=
X-Received: by 2002:aa7:9e83:0:b0:82f:2d48:f906 with SMTP id d2e1a72fcca58-82f2d49169amr13133723b3a.12.1776348940723;
        Thu, 16 Apr 2026 07:15:40 -0700 (PDT)
Received: from localhost ([2601:600:837f:c470:1879:8422:922b:e5d3])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f6744e193sm5684163b3a.57.2026.04.16.07.15.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Apr 2026 07:15:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 16 Apr 2026 07:15:38 -0700
Message-Id: <DHUN58WZBKWO.PDU8NW80LH0M@gmail.com>
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Alan Maguire" <alan.maguire@oracle.com>, "Mykyta Yatsenko"
 <mykyta.yatsenko5@gmail.com>, <ast@kernel.org>, <daniel@iogearbox.net>,
 <andrii@kernel.org>
Cc: <martin.lau@linux.dev>, <eddyz87@gmail.com>, <memxor@gmail.com>,
 <song@kernel.org>, <yonghong.song@linux.dev>, <jolsa@kernel.org>,
 <qmo@kernel.org>, <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next 3/6] libbpf: Add feature for kernel extended
 vlen/kind support
X-Mailer: aerc 0.21.0
References: <20260414195019.684531-1-alan.maguire@oracle.com>
 <20260414195019.684531-4-alan.maguire@oracle.com>
 <ba42c4f7-0bce-4aa9-be90-e102ea04336f@gmail.com>
 <2d08ed60-9180-4804-8339-7d0e56640183@oracle.com>
In-Reply-To: <2d08ed60-9180-4804-8339-7d0e56640183@oracle.com>

On Thu Apr 16, 2026 at 1:57 AM PDT, Alan Maguire wrote:
> On 15/04/2026 16:57, Mykyta Yatsenko wrote:
>>=20
>>=20
>> On 4/14/26 8:50 PM, Alan Maguire wrote:
>>> Add feature check for kernel extended vlen/kind support, and reject
>>> BTF that uses extended vlens/kinds if the kernel does not support
>>> it.=C2=A0 There is no reasonable path to generally sanitize such BTF.
>>>
>>> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
>>> ---
>>> =C2=A0 tools/lib/bpf/features.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | 39 +++++++++++++++++++++++++++++++++
>>> =C2=A0 tools/lib/bpf/libbpf.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 | 17 +++++++++++++-
>>> =C2=A0 tools/lib/bpf/libbpf_internal.h |=C2=A0 2 ++
>>> =C2=A0 3 files changed, 57 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/tools/lib/bpf/features.c b/tools/lib/bpf/features.c
>>> index 4f19a0d79b0c..4a75d6717bbb 100644
>>> --- a/tools/lib/bpf/features.c
>>> +++ b/tools/lib/bpf/features.c
>>> @@ -615,6 +615,42 @@ static int probe_kern_btf_layout(int token_fd)
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 (char *)layout, token_fd));
>>> =C2=A0 }
>>> =C2=A0 +static int probe_kern_btf_vlen_kind_extended(int token_fd)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 struct btf *btf;
>>> +=C2=A0=C2=A0=C2=A0 int ret =3D 0;
>>> +=C2=A0=C2=A0=C2=A0 __s32 id;
>>> +=C2=A0=C2=A0=C2=A0 int err;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 btf =3D btf__load_vmlinux_btf();
>>> +=C2=A0=C2=A0=C2=A0 err =3D libbpf_get_error(btf);
>>> +=C2=A0=C2=A0=C2=A0 if (err)
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return err;
>>> +=C2=A0=C2=A0=C2=A0 id =3D btf__find_by_name_kind(btf, "btf_max", BTF_K=
IND_ENUM);
>>=20
>> Looks like if id > 0 then extended vlen and kinds are available, so ther=
e is no point to continue processing the enum and checking value of the BTF=
_MAX_VLEN. Or is there a scenario, where BTF_MAX_VLEN goes back to 0xffff?
>>=20
>
> True, the enum presence is enough here. However another point the
> bots made here needs to be addressed; other BTF kernel probes rely
> on the bpf syscall, loading BTF into the kernel to check for feature
> support. We're better off using that approach here too since it will
> work even in container envs which don't have /sys/kernel/btf availability=
.

If containers cannot access vmlinux BTF than they will fail loading
all progs that need CO-RE. So I don't think we really need syscall
based feature detection. If it's easy enough, sure, we can have it too.
But enum is enough. The verifier exposes its features via BPF_FEAT* enum on=
ly.
See enum bpf_features.

