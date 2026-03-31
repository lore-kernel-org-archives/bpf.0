Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26160453486
	for <bpf@vger.kernel.org>; Tue, 31 Mar 2026 21:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774992250; cv=none; b=AdLl//F8FuiMgRT+SHdq7j/U43f0GJYYKDlQ+/+wf6ZPaGEcVyDZAQViopLl3Jo1bO+c0OuqmXvtIlh2r1hHHL6J47kBxSXlVJitXMFnYC3zMwSKQgvpW/VDjQcjlWbDzHZzXHlukFCnV1KReM9O7dxZ0Bttoj8P0TjBmBP1L/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774992250; c=relaxed/simple;
	bh=oI12tvnlm1mx0WilenuSzqGDFwjcJCBjb3kR2aQ+aQw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uR416wzraw1hMTPqONC2BQd4vhfuJOTj7VSwx8YbFnk5y6WQjuuW0XzM6pHiAwVA8uCGX4fIQfGI97bKo6lLJ9/bU7J4qlKKoe+/T2yc3N3buuxUOKLj9eiY8r40sUS6mGGvFdFJwHztPRfGb0KtTvQlCWYJLY8z1AGloo3N4wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XybGe79S; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XybGe79S"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2adff872068so26007665ad.1
        for <bpf@vger.kernel.org>; Tue, 31 Mar 2026 14:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774992248; x=1775597048; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oI12tvnlm1mx0WilenuSzqGDFwjcJCBjb3kR2aQ+aQw=;
        b=XybGe79STFg4KGNloClMIAtnOa279rr2MfvTZpPEtKM9u6OgrLHFE14mmMBNq7wGP0
         MMmsy2seSfO7ByPuvzyjCoCIHKP/G7oG/fnMrr1b+MF1vuq9cXXPPAsEnPgcvl4gR3gi
         IRMtGTpP8iC+eK4mle4U4NBwJ4A7YmIC2GUt/eO57lhE+7kv/ou8lqCppXG5iV9Us3Yz
         f3prANgUzxwtjd1WdEuqkjEGZfrv2k59vkuga9EzSwnINBB8g6+ExSDwqnwdey7pK1QH
         Zw6D9yzIgH5xusYbBMZJu9xz254ZetWQ4f28WuwvraTGAyTHAuRbFE91+IqZSO6Qg90d
         YuDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774992248; x=1775597048;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oI12tvnlm1mx0WilenuSzqGDFwjcJCBjb3kR2aQ+aQw=;
        b=ER63SkWF/uYHFRIyJX+pdm3pXxLNVnRsvP4mG0PHo68D6Ub3zGYkAeMqjPSzdbHiMF
         NKnvjC+KGPNaDzYUp/typa8HZOX2ITYc7lLHaB7Xm8pgNMvObZcDnI6CK2OIgQQr2kL0
         6FYmv6rocv+w4Dp5HPeRNYYyYMy2HrpxUV85NVa1Foqia8D2NEKNMHTOZCPcLV2oM5ng
         qM98HqCkGZBEfkD6g6llVH6cyG9RssscJNMRRQP4WClN2jQfAYVzbnwlCxm7K1F9FSVN
         Ihhp7F5OD/1bEDold1LhPAIdhZHakynNXOUuRJ8P8/crlszgcbB1BXAx8yrqHXdeg767
         8k/Q==
X-Forwarded-Encrypted: i=1; AJvYcCVxnlAZ39dRzoYGhVREmFj87kl+FeFToBVCYeL/vBohXZ0Hl5wuNpicHQvVVpgL/vgo5Rk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuyYaH1ve9Jplqr6hdbDzuDLW0Cb3uvjlOwJoW0Ngw6Fb+Kqnc
	4xaqw8Lej7TWTxJ7snM7MOHyPsnmjGrVf/OT/a2AcegSJPT4qe0/CTDl
X-Gm-Gg: ATEYQzxnUtMM8F2VJZRoLf2Xpqe7PAIXQNIW++xIR8RMG+nhKtsYlQy7C5YZ107+MLp
	0B81KJ0ZPheBOkuYIF8FzOUCyaAX88lvuMn1dciw0+81RGbdgVtvA7HlrdTYfhiCFqZpBXvAeu3
	9ewrgFRpoZZY2E5TIdJQ+zzl8KTq0yyT4C62fEg8IHGFr30n9+CKvLqtdijUMn6b8/PpUPKsNSq
	kwYj9n4OstUWEw76vcWH/nQSAuRzGcNC0d/z/vszdYz3HffvZ2LfMkQepvctwCumdmVYK82w4IG
	DOqFVpStHnTs3LNVR5ihDUPzIRkXUCJUyeBJ1ci44xyf9ErKRECQlD3Fq69ZTYcV9DAuNCOMCLk
	M+/OKax8kfHBoxwqGjgRYoUfZtQykc6hN7cTLomwm2slr+kaoZQZSH0rDfuUAPEH4zQlNPRQxqr
	gt/ts5WSpz9nLw2iTtCjiF+YeNFOUdzLllWPxhXLfkYDWnLyxgUmO2
X-Received: by 2002:a17:903:32cc:b0:2b0:5cb4:d89d with SMTP id d9443c01a7336-2b269c7c402mr6627185ad.29.1774992248485;
        Tue, 31 Mar 2026 14:24:08 -0700 (PDT)
Received: from [192.168.0.226] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b242676e13sm126381775ad.28.2026.03.31.14.24.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 14:24:08 -0700 (PDT)
Message-ID: <836d55be42874adb0583de3d9e96cb2eb884ebc9.camel@gmail.com>
Subject: Re: [PATCH bpf] bpf: Fix regsafe() for pointers to packet
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
Cc: daniel@iogearbox.net, andrii@kernel.org, martin.lau@kernel.org, 
	memxor@gmail.com
Date: Tue, 31 Mar 2026 14:24:05 -0700
In-Reply-To: <20260331204228.26726-1-alexei.starovoitov@gmail.com>
References: <20260331204228.26726-1-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-03-31 at 13:42 -0700, Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
>=20
> In case rold->reg->range =3D=3D BEYOND_PKT_END && rcur->reg->range =3D=3D=
 N
> regsafe() may return true which may lead to current state with
> valid packet range not being explored. Fix the bug.
>=20
> Fixes: 6d94e741a8ff ("bpf: Support for pointers beyond pkt_end.")
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]
