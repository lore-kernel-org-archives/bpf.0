Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF8D8277CB8
	for <bpf@vger.kernel.org>; Tue,  3 Feb 2026 22:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770158209; cv=none; b=KsqRRuIOciOvZpCgtXphuZfwgGWx6rvynE3xnKi+kUUHUJKCG3MkqRrWpxIQPJHKiC3y57ANeSDVZsU2IihSRa+jaQR5m3I7QHsOqFgLYthUoA9BX/Ub2nZt8OIo6PA3r0pHMMiCDqyowUJ/ld4+bwTUBEUZ0ZPzUkIbqBegBlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770158209; c=relaxed/simple;
	bh=CDDXBDODhtjeVgsH3x1R2hu138QsWw+umWvoQbU1Y1k=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PfRNQyr7XDCB2RAZ4nXh6qg63dy2ZSmILuXxb5Q2W9FcNXjmzngydO7Pyx+xCcIHbP5kJpPT9+KDyRhyObQRU4rhzRrn0AtscYj5/2iprU7dGJUCTiJw5CCRHBwuurhMqUvQ+0z3yVFpULu/XzRXF+qoUqPB9WZIcUxCAmSQKwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HkPdRKIz; arc=none smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HkPdRKIz"
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-124899ee9d3so283502c88.0
        for <bpf@vger.kernel.org>; Tue, 03 Feb 2026 14:36:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770158208; x=1770763008; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yzQblUVB3dkKySqKOCPBoJym3FToYDznhTd/jhvjz6M=;
        b=HkPdRKIzVhYOKZq81D4DXekHbeWm2yB+OQU9eve6DZf3OH4XgqJ1qEdQ/vCcB2NLbH
         Gs50b97QvGEQL/33BntIC9W1zn+KegRugHGLnq2UWfFDjxikl9Kb5sTl9l2BxpRhT8wr
         atnhV7K+wHLS0vF4gO4cQlh9/ngx2+qF4uU53oL6oKWk3ttddhW80x+G30ghacttGTDv
         7z9UZBDjcl1dJgzonR/ZSFpruV39Lg+Nja9Yik/IPjGoTBt4WAOZgkeBqK6v+u1sPJpd
         9WWqYxoODMMCH4xpQQUVSVLwBb0626LCqbxFGqtg+LbgPs7usMlJlBo6RxJxTkhMo5dw
         2diA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770158208; x=1770763008;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yzQblUVB3dkKySqKOCPBoJym3FToYDznhTd/jhvjz6M=;
        b=h0yWhH6u2eHBmYQ13Pz7Ad4MjKqlB1z3UZ0Wp1TPXPxKCjru5fq1jPw77p4rvzYVTA
         24jM2wos9i8XaYd853ovb4cByzWaWNYnCvKoKtZMxirf3c+xhNg4MGE5lwUqI+Djs0hK
         SCTz5ntml0JFrVznkyilNZPMVYlDha5nf4rNDpZYSb8PdZFYd0MYTVzMTeXhwh3lyPh6
         9qPqgz1X1xr5NwX6CUEAXCn26ZsZIkaiy/GygCK1QWV0zFV6Uw40SIBGjLq+TKPj06A0
         sktJCWq8TiKU/votZfqKiEq50UsONsKAXKEtOVuzd90qYFnQ/iX8ZPV/9LD9Y8P51OLE
         Rwcg==
X-Forwarded-Encrypted: i=1; AJvYcCVSStQ+a2ny8AQ2USVUrVpXJrbt7xL9Px4gwhaQM3Af5MBtMyWg3cOoFiGrPP9tzpNRbGQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqfRIkqHJ0pgG51iRcVQyVCvBvDlP1P38bEizjqS+XGhwT/oKK
	730d2aptU/assqWwvnFRPhd2OCr4c9PguWeO6Bjy2xL/e7dkZXu3WvNI
X-Gm-Gg: AZuq6aKC63ipyCX7y4/TmlRcBKsA1svIaAPPJs5/1bnq1I183DbIflMWjsMD6HOIkNi
	HaHDZm+MDZGhXg1HABHgg253N+QdbFUD6xKhandXxcMOHas5+I1ymYvaYCdz0NWxg2OFcMBaU6T
	AOrXKvPc81K1S6xpbBqnpUZ3xB7ogHogWIfoPhgRE7U+dThu46xuRD5K5TO7lmO2RUED4SUKZqc
	B2aDrZO20TDF/TW1qnMAT5/dsWhWa3XETruc8mBkARzlArEHLJ5LJAL+l463vMwqAPImHSxDOo1
	lpFyQnXZBV4291IuEnAEoq3DgVsbqBjMk60rqdOnQ+DuGuc3ythnoRlFQZKP8PCHJ41kRqW93Is
	T2U0/TCn/JZWCbABdZzyGTRlW3Luo0K1OFnr3EL46ust0B8AYQhFQLp8OgbGQQYBBHzFmaSWFV+
	nvQymv7wkUCnh4jNlAbUIoPhm18ZFp8oSMli6xo9Vntw0c2FAU4prLKEwIGduo7QefeA==
X-Received: by 2002:a05:7022:606:b0:11f:19f9:c5f9 with SMTP id a92af1059eb24-126f47dc565mr364453c88.12.1770158207639;
        Tue, 03 Feb 2026 14:36:47 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:60e8:c921:e408:133f? ([2620:10d:c090:500::9470])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-126f4e107b4sm579351c88.7.2026.02.03.14.36.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 14:36:47 -0800 (PST)
Message-ID: <390ea771d41c8cf53de64025036bf1435c5dac5e.camel@gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: Add bitwise tracking for BPF_END
From: Eduard Zingerman <eddyz87@gmail.com>
To: Tianci Cao <ziye@zju.edu.cn>
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
 daniel@iogearbox.net, 	haoluo@google.com, john.fastabend@gmail.com,
 jolsa@kernel.org, kpsingh@kernel.org, 	martin.lau@linux.dev,
 sdf@fomichev.me, shenghaoyuan0928@163.com, song@kernel.org, 
	tangyazhou518@outlook.com, yonghong.song@linux.dev
Date: Tue, 03 Feb 2026 14:36:45 -0800
In-Reply-To: <20260203101736.4975-1-ziye@zju.edu.cn>
References: <e62c874af12c74ec4442df6e098c6d5000f9540e.camel@gmail.com>
	 <20260203101736.4975-1-ziye@zju.edu.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-02-03 at 18:17 +0800, Tianci Cao wrote:
> Hi Eduard,
>=20
> Thank you for the review and the ack.
>=20
> On 2/3/26 4:03 AM, Eduard Zingerman wrote:
> > > -	/* ALU32 ops are zero extended into 64bit register */
> > > -	if (alu32)
> > > +	/*
> > > +	 * ALU32 ops are zero extended into 64bit register.
> > > +	 * BPF_END is already handled inside the helper (truncation),
> > > +	 * so skip zext here.
> > > +	 */
> > > +	if (alu32 && opcode !=3D BPF_END)
> >=20
> > Nit: zext after scalar_byte_swap() won't change anything, right?
> >      If so, I'd just avoid the special case and skip 'opcode !=3D BPF_E=
ND'.
>=20
> Actually, for BPF_END, the alu32 flag may mislead regarding the actual da=
ta width being processed.
> The operand size for BPF_END is determined by insn->imm , not by the opco=
de class.=20
> So if we simply rely on if (alu32) to perform zext_32_to_64(), we might e=
ncounter an unsound state=20
> in the following cases:
>=20
> * le64 : opcode=3D0xd4 (BPF_END | BPF_ALU | BPF_TO_LE)
> * be64 : opcode=3D0xdc (BPF_END | BPF_ALU | BPF_TO_BE)
>=20
> These instructions belong to BPF_ALU, so alu32 is true. However, it is a =
64-bit operation. If we=20
> perform zext_32_to_64() after scalar_byte_swap(), the verifier would inco=
rrectly zero-out the=20
> upper 32 bits of a 64-bit result, which is incorrect and unsound.
>=20
> Since scalar_byte_swap() already handles truncation and zero-extension in=
ternally based on the=20
> precise ' insn->imm ', it's safer to skip the generic alu32 zext for BPF_=
END altogether.
>=20
> If you have any more questions, please feel free to reach out.

Hm, makes sense, thank you for explaining.
