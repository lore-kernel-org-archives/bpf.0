Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACEC041C72
	for <bpf@vger.kernel.org>; Sat,  8 Aug 2026 09:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786183095; cv=none; b=dnx6rYgAhHqlyowPmVQhTvqzZO+1nAHN1OswLKR1L+yvKc87Gl8n73BttapSt2Qi45lZKbAEOP1kIGa6VK/9BPOorZy64eDGEAyVjD+hz2TUNSGEiP64YVFaUstQsADgdDGisrPzI0+mH6DJdharuXCZtKOPtSxL/UhGVxv1Qek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786183095; c=relaxed/simple;
	bh=nYQs7qGm4ib9BkGabbgpKzxlxm+Dadk7Bl6fDFcF1MQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gjXx00sK5SU2BQbn1fMgBeSf5t3zsQj95k56x0VeG0l/aUStvd+a8dBcV7cOY7W8Fu2kpja4mIbvmnEOdvKFg0XyvmRgQrBctmr26Ooj2vETHfoXdiGaW35BK1UeHJHrE+YA30FeQj7d6DdqXKo0+yBrypYbdszGBEmW2zxxAIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FY5aDznv; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FY5aDznv"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2d004f135b1so4350805ad.3
        for <bpf@vger.kernel.org>; Sat, 08 Aug 2026 02:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786183094; x=1786787894; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=nYQs7qGm4ib9BkGabbgpKzxlxm+Dadk7Bl6fDFcF1MQ=;
        b=FY5aDznvIvai4DO69BKWKhln8Hbf72QJJacAy6nMYCEY7sswq0jI9qYWmEHGvTMmi3
         dFSSf0hrDxsXYp2BY/XdKpkek2xKpfYFj73RkX0l0TBhW9gbtxK4dOmHvwbZzlgNvzfn
         HTIj+THGFRwwYSrNqS04Pnp73nFpyXcgCW0PC88C5NX8w2b3sqISlcbNyhJ1nKp0zoW1
         S08OksxWPWZJECzJqzVvKG7FqVs+8l0pqm1j1ASSOVl8dq3onTis7C6Ey3sErV5PnBja
         C/al+HWyTfw1drVRWB3d9MqNgOVB2baLZT/2cfrG4brgOEbMyswwZviC+SksRfqWl8aQ
         NR4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786183094; x=1786787894;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nYQs7qGm4ib9BkGabbgpKzxlxm+Dadk7Bl6fDFcF1MQ=;
        b=aEPducQ+/wqNomdZd7dZdpnaLPnBp1C54b7r99nxRlKXvJeVHfFuS70JvLCtBKB+tG
         AuEOF1MFAWsl7srLDP8X3555bPKihDK9KEYX4XsNOQThAZP+tNsgzRAaBJJlMTDGNyZU
         5EnoQTuCjNRdo9xiby99ygBt3OxtlFgQ4EZTSxb3oU2IQRrnhW01yEp9NzxvSKGfS0Ig
         eaoBOmXNKx7mmai2Msgfj4RmzpFYaFoTTHnNZwV7aqZ55l67iuaUm7W9tmGd9bnRL2Q1
         1vr4/1lXdo7//LPQaiT6FtIHduLPdwNYhyXYL1cXeehNt2Iqdd/7jptd0Cje0uY1s0MT
         nyiA==
X-Forwarded-Encrypted: i=1; AHgh+Rr3HeRXPHkZ8ojqxlDVZ9si/pSpiOZk7cA9z/skA1p44vTlpCmQE6JiGNsmC/zXqQpVODM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDNMDJRkepgkcM9EN3IAzlCG545OSQQg/djiVBdVi41+GIJ1f3
	mpzXymtwg6sVosaEUqsOFVLBqzjHB8jzaBpmsNnF5++KYy1FX8eUQ+cF
X-Gm-Gg: AR+sD12rJKDy7JrspfGXeqxGdad5XmpCiPw0iQQRDfhSZv4uIm4cny/N6YDqMjpdMCW
	Lv3Xb/aaz6YHKn2LiBhNRIhC+E23HfPF76IJv49p6inNx2t+bgKovVzuJSqildHSAPyZPMybO+F
	FmoKevPhh/t38xKosAi5CRe6vgsMX6CvHAnJXAZSre0MZJKycI9frlKZ3mI03ZvpevkdlEwEOyS
	h0ZYdZkt0PE6ILS4AlcRLrAqzJB6EDco42DS9kxhJtgBZzbsiuphbJXx4T1a56b7lch7EZxuWTV
	PXC7v17j6bidMVJw5YJ73M8nq/dg5vuGmmO5/JWm19WPalSCqD/xXPHGdIJFBYIo95KOwDJlybC
	rgIsUY0zO0nfbVJBZje4Yjct5tMYJGo8hVg1Pkh2AjxY0crG0yID05pbyFs5Zc/MlzwGo59sHoH
	8eVpsum4szKsQCJbCqP9dkAxfxsYPxyF9+qgmE74oJ0jw6QvD5L4s/dmxzKojk/GphdN6nKFL3c
	AkuGY69I/imgtrm
X-Received: by 2002:a17:903:184c:b0:2c6:a772:7e43 with SMTP id d9443c01a7336-2d0caa040e3mr377912205ad.18.1786183093895;
        Sat, 08 Aug 2026 02:58:13 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d14ccdb26bsm17740485ad.22.2026.08.08.02.58.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Aug 2026 02:58:13 -0700 (PDT)
Message-ID: <4e669fbb0b98ab5c74f8eb7ddb7da254be54db74.camel@gmail.com>
Subject: Re: [PATCH bpf-next v5 14/14] selftests/bpf: Test attach rejection
 for struct_ops arena programs
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Emil
 Tsalapatis <emil@etsalapatis.com>, Tejun Heo <tj@kernel.org>, 
	kkd@meta.com, kernel-team@meta.com
Date: Sat, 08 Aug 2026 02:58:10 -0700
In-Reply-To: <20260808003938.3486067-15-memxor@gmail.com>
References: <20260808003938.3486067-1-memxor@gmail.com>
	 <20260808003938.3486067-15-memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2026-08-08 at 02:39 +0200, Kumar Kartikeya Dwivedi wrote:
> Exercise fentry, fexit, and freplace programs that target a struct_ops
> callback with an arena context argument. Verify each load is rejected wit=
h
> -EOPNOTSUPP and the arena-specific verifier diagnostic.
>=20
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
