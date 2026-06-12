Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C2B2BE7D1
	for <bpf@vger.kernel.org>; Fri, 12 Jun 2026 16:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781280544; cv=none; b=eg6bOou/liJuDjVlmKMT2FET5DTlmn+l/InssnvAHdWhwLC0TDDnRPm0TyVL0tXEsA0A/7MX1ib0XLfYmKOrJ2Pkxwu6l9M7ofDgiGuAvdMXrEf6yENWr498lE2+MAzICLWKSt9jL28ckZ2FI1obTiSw7dr/snlMuE+yNWtxWgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781280544; c=relaxed/simple;
	bh=U1lRkll2oz5K3pVNqBq5FE4g7ax9tYc5BRLvPHoA+EI=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=eOe5E5npastvZBmG7lCyWn7Gc6TfAyIEi57MrKYZJajtZvKwIoeHBSFsnnnWvVhgHfw++BzVf6i3v+M10W83wqgjDobun5HnolFrfn6/3M3uIW6q7r1/h5xMH9NqAVhTGbIycMHigSyCIt0+0LPj7bSof307XLByeitcNwhAKS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i4UuHK/q; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i4UuHK/q"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-7f811da1eedso4756007b3.2
        for <bpf@vger.kernel.org>; Fri, 12 Jun 2026 09:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781280542; x=1781885342; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kKkZ3cbvIq+p1hLvOachp17H2BDqTQp7OAr6BDxrA6M=;
        b=i4UuHK/qQ40FgpXoPnhoRm38lpLRiC1hG+qdw+UdRixj8xCCkBkmoVhxnua5pFydBG
         h/ehFoWtlh2fhfnhXXPSdwr+APfSUJLrXtJ53aDC47GFRNL5qGpp7SgC2aLYN5toepGJ
         rCyECNgR1+exWZCNs++pMsB/YI6l1HWnaK8PM2pYkLT5CgeegpjdilK9vpO0/bPFFrgo
         Hh3eiMBFA76NsSXSRg6TL9bdok9C9Q2roukX8MLc+gtxxuQK8djODGbYum54lE9FWfG2
         azXNIWG0Dj3k0/nGnVBfYmE43tsWKPRh0qomEYqgPM7+pXvfv3hecZ7X2SmZ9VUQxBCB
         ENzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781280542; x=1781885342;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kKkZ3cbvIq+p1hLvOachp17H2BDqTQp7OAr6BDxrA6M=;
        b=aeMI44CTTjM4903sadSveilLX81wlHaaA6JXLy8LRrsDhpglZEiV+T6tMJSeuzNwho
         jbi28XUJXieNr/fUQYml3lPGq5D15zOt8yWpWHlXvzH7Bsj6apIrHjQuZ0/s22YPmanZ
         6AxgC0DBBNjKHMtmnWnnzh5Mb2x+dBfs+Wbdsvr+rvj7q9H1rD2Urgu5AZumVP3fuXD4
         dIOxovANEV2gLeObKEUATjI1Hby6X0KtaSDw3JY0n35q86g7uPo2V8Ko2lg4tWzzXFBo
         gxSTgQSVd7ux4G4sQ2YbeQizpTGMklYF1c4Dl0/guL5AxJ5fdVAHbgs/7mcclwsOGt0C
         aTiw==
X-Forwarded-Encrypted: i=1; AFNElJ9PTxCs0MgljcUTbqVp2h8vIKmpBshrLks549zZQhby0xHeYmyQVpILZyTkrFlF8J2ZS0c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXX4DVQS7iJcO7vd2Xo/F+tv1eOevYPMFA0pHXv+pszfH3WeGt
	sVFKkKU5UShKJr8NOJUMc/FwcW4yc61yDiGguI7QP9jzGKLi+w7IYA8q
X-Gm-Gg: Acq92OF7SdKN/nBN8YUWaeyerMoS4vKYVg15+2kAoN8/MUxKrdn98OYjk5fS4x5RsME
	Qa5GtWFPJeu+IS0vlyKQEZ3f9DDYY9jQ/FKflRxi6e7Ptit2TxO3ixdDOiHIjDnmTd6bDPuJaeM
	Rp1/I8Dkk55pzR1Up9cYh+2EyRATgz68g9YFs6174A9B+l63pjPWex4LufFbMk+ZjrHnT+Q3+ak
	q0XzPwYTrsUeeHLlJodywJBO4naWO+aJTqi49R2ruuwetKrXIW+m5K5C7yPyqjn7depnkZbh3bt
	If0rx0Bzofu0OZZ8kQU5QMiC4H21Nj7mJP8dZyQkPY10y8J7XQ6y+CMzbfWk4jc87o8D/4wFi2S
	/rUIGtreOYKzIyPRgNRPVcL5PKQzIKUXXiwifxXWom+IWa+Wo9PFBxq363ip5ci2g5SUuD2HZ7X
	E5jBR685puAvOW3T9XOXPe8+kh6kYlgAyZNR8P+J2MepWXl2C0yMch/v87bZYy9liKi17EQuj+v
	QBkdmGXYAXSYeaFiA==
X-Received: by 2002:a05:690c:6e13:b0:7bd:6114:4002 with SMTP id 00721157ae682-7f7b901a3ccmr32849557b3.40.1781280542330;
        Fri, 12 Jun 2026 09:09:02 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:72::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7f7712f3c11sm12244747b3.41.2026.06.12.09.09.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Jun 2026 09:09:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 12 Jun 2026 09:09:00 -0700
Message-Id: <DJ7793EEL4P5.1HFCXFENJM2VT@gmail.com>
To: "Tianci Cao" <ziye@zju.edu.cn>, <bpf@vger.kernel.org>
Cc: <ast@kernel.org>, <daniel@iogearbox.net>, <john.fastabend@gmail.com>,
 <andrii@kernel.org>, <martin.lau@linux.dev>, <eddyz87@gmail.com>,
 <song@kernel.org>, <yonghong.song@linux.dev>, <kpsingh@kernel.org>,
 <sdf@fomichev.me>, <haoluo@google.com>, <jolsa@kernel.org>,
 <tangyazhou518@outlook.com>, <shenghaoyuan0928@163.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: support shift operations with
 non-const src operand
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
X-Mailer: aerc
References: <20260612093818.18609-1-ziye@zju.edu.cn>
 <20260612093818.18609-2-ziye@zju.edu.cn>
In-Reply-To: <20260612093818.18609-2-ziye@zju.edu.cn>

On Fri Jun 12, 2026 at 2:38 AM PDT, Tianci Cao wrote:
> Currently, the BPF verifier only allows shift operations when the shift
> amount is a known constant. This is overly restrictive for cases where
> the shift amount is bounded but not fully determined at verification time=
.
> For example, the following code is rejected by the verifier even though
> the shift amount is bounded to [1, 4]:
>
>     u32 shift =3D bpf_get_prandom_u32();
>     shift &=3D 3;    // shift is in range [0, 3]
>     shift +=3D 1;    // shift is in range [1, 4]
>     r1 <<=3D shift;  // non-const but bounded shift amount

Rejected? I don't believe so. The verifier accepts it, but falls
back to conservative.

> Modify the shift helper functions (scalar_min_max_lsh,
> scalar32_min_max_lsh, scalar_min_max_rsh, scalar32_min_max_rsh,
> scalar_min_max_arsh, scalar32_min_max_arsh) to handle non-const
> but bounded shift amounts.
>
> Update is_safe_to_compute_dst_reg_range() to remove the src_is_const
> check for shift operations. This approach ensures the verifier
> remains sound while allowing more programs to pass verification.
>
> Also modify the comment on is_safe_to_compute_dst_reg_range.
> Shifts by more than insn bitness are legal in the BPF ISA; they are
> currently implementation-defined behaviour of the underlying architecture=
,
> rather than UB, and have been made legal for performance reasons.
> See: https://lore.kernel.org/bpf/20210706112502.2064236-47-sashal@kernel.=
org

What this is for?
Do you see such code generated by compiler in real programs?
Does it cause issues with accepting such _real_ programs ?

If not, sorry, we should not complicate the verifier for theoretical case.

pw-bot: cr
