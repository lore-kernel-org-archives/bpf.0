Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF9F926A08F
	for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 15:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776786377; cv=none; b=U+jF1JApKId8iUdwhhHRAMg2J3AMVswA7EmqXEEc9wR17YIdK1onYuP0a9JZyNQEz0445Gf6wy2EYXxAyvG+1h3BzgMUOJtdYrOCrWlxDe9YObQ16FoQybDHS49bqO1B9f0agPU4kARxxrTjF8+JeCYawH7Rfm5PNODcXIV78wM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776786377; c=relaxed/simple;
	bh=fwm8O7fO3NFhQaUriCmhWV7ohqm4cnZTfrgqa2DuRs0=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=POqvJn1eg7yud4XG6/uN1XhNhQ1IzDr07QT0mlwqIDJPyb9S3h7NtZco1lEmKLMcaSxUWan52j1pqZqBVmN8iy/2TDOKKanR3KMwREtXGDKWJzNYbRoxDzGFaQkhhERxGWXyB9WQScEFsYADcXVs+2RxuyOMtsy9mKYzu33zydY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XnC9Jspb; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XnC9Jspb"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7dcdca9dd6cso567391a34.3
        for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 08:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776786373; x=1777391173; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tMOfOMru40MWOZI1yWY91Y8nlbljDzDRYHEsnCEWZxA=;
        b=XnC9JspbOeKkaNLZIsRRCpRtZAAVAg9zSeXmcY3EeY76y+OqPEfghWncEeQrq69TLq
         P4JlHbpUPto63x9bjTgPNNmUYzVqr/gFY5s/z+atqECI3yboSGoFGQvj1qPfCWc6rvNU
         iZMmxUG7VVNyUu9XcII+hfCajRsS0Un8CEjveR+IEERfG2O5qmMewjpT2666aLQL/lwY
         UnG0mR8s+Oq1D+4EM3LuujkWfwzZLpMMTFCpRcNSEuDRX+oCdMYnk5yMjhMzEZH8djvu
         +9oW08ksw0TlPe0xhHxpck5kT7DcK6tw904Pnu1PuqkoUhtlAFkPRaEGt6Lv/UsX+MPf
         WZ/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776786373; x=1777391173;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tMOfOMru40MWOZI1yWY91Y8nlbljDzDRYHEsnCEWZxA=;
        b=pfxc9mum8ICvJ7u2jKZfcAEvXuRl2OA+oBlAdXsKoeHN/ULaK9Ax4MP2WpnUa5bnpe
         mnUaqG32u13M6Q9SKSEW3SDj7pnc2bBCo3HwOmjzwWHL0Q1AIoIf3j0/61rgebAINHle
         OGDdfnIlgJNAxd4HTJ8RnnkE99LKKkSkp9LAUJJRAzvdOxmRltJgbevpYnCYsU/bNuRi
         11i+RP/XwTRpWs1p794TxU4V0jfCpAa4xTryCPsSq0r5X8lrYI4XQDAGRAnvJ2I0ZfDr
         iZA+Y0IwhoBH8PuTcHqoEsPLPKS7dHO4QwxOGrW5rlBjDcJF+jWX1/8hC7SII2Jq6UCl
         PLGw==
X-Gm-Message-State: AOJu0Yyuepuaa2QnkIy4OaXfpNSYGVrAwRutAfI9lAaKFCnlC/y7xTae
	xu+UtYGGtiRqY3aUNsTNDqyjd5BuLcyG/GjwoqLo8CMrTM2F1XGL24AH
X-Gm-Gg: AeBDiesoSRcvtiOswBxNPF4GPTFcNBsUQu81KpVgqfRUd4q7aa5foRw7dBRVOANKof/
	rn6aDQJ+0D44fKJEv6G8ZLj7avXN6AZrgpYA4IgdwlbaJNYKI0CavGhJYTAYunTVrgHnyD8VRll
	C8nYZuKZ/9iO2EGoEP6OM9JZV57fcHKnMf0/N4K3VGi44q+P9dWv46flMyBdK19ua4vs2yTNqBl
	G93i74hM1kUuMLD82WEjsfA8NBuT42vePWPRI4RUmx/p+PM2LUVCcakEtO9s9U/Dly3kTSN9jpr
	i0xTd8W7Ahu9cGybskvpHvWUMM/vHDFmWS64ipt11u8iXbSjBunmD5A7Xy/gPSahJkFZjgjqyqc
	+2A6lmpy/rHsu6tkxc2+a7zmbNGX1Wbzz+jW3P64VHimCzrU5lg+XVTv9FDg5t6bdk53DqUtpo0
	pDAKgjkRjCAwjyGZ+Jb9LIWSI1Sd8tmSOVt03z41s0L6+c4blWw8jkBBPLAZ9eFMUZjQAJF1ILE
	4ykwj3iXfmO8nnsdXr4JHQ47WAF
X-Received: by 2002:a05:6830:67f6:b0:7d7:5559:3d1c with SMTP id 46e09a7af769-7dc94f961d0mr11803157a34.1.1776786372850;
        Tue, 21 Apr 2026 08:46:12 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:5f::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7dc975033acsm11418725a34.1.2026.04.21.08.46.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Apr 2026 08:46:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 21 Apr 2026 08:46:11 -0700
Message-Id: <DHYY7AN4MZGJ.3FU2NLXWT7NX@gmail.com>
Cc: "bpf" <bpf@vger.kernel.org>, "Alexei Starovoitov" <ast@kernel.org>,
 "Andrii Nakryiko" <andrii@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Jose E . Marchesi" <jose.marchesi@oracle.com>,
 "Kernel Team" <kernel-team@fb.com>, "Martin KaFai Lau"
 <martin.lau@kernel.org>
Subject: Re: [PATCH bpf-next v6 04/17] bpf: Prepare verifier logs for
 upcoming kfunc stack arguments
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Yonghong Song" <yonghong.song@linux.dev>
X-Mailer: aerc
References: <20260419163316.731019-1-yonghong.song@linux.dev>
 <20260419163336.733654-1-yonghong.song@linux.dev>
 <DHYE574ZW4D7.2RNZPHN9QHT8@gmail.com>
 <2259b511-ca71-46a5-a416-8ea6ff0785b6@linux.dev>
 <CAADnVQ+fb4mY4ermo5GBtz1jx7kB4xsDGE23m2G8qEQa261VNg@mail.gmail.com>
 <cba1d567-84db-4597-8e7a-a2203f1209d6@linux.dev>
In-Reply-To: <cba1d567-84db-4597-8e7a-a2203f1209d6@linux.dev>

On Tue Apr 21, 2026 at 8:41 AM PDT, Yonghong Song wrote:
>>
>> it does:
>>
>> +static u32 make_argno(u32 arg_idx)
>> +{
>> +    if (arg_idx < MAX_BPF_FUNC_REG_ARGS)
>> +            return BPF_REG_1 + arg_idx;
>>
>> so for argno =3D=3D 0 it returns 1 and that's my objection.
>> Make argno starting at 1.
>
> Okay. Will do.

To move things forward please resend the first 6 patches only.
So we can make sure that they're in a good shape and land them first.

