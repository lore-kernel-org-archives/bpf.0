Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 159DC345EAE
	for <bpf@vger.kernel.org>; Fri,  9 Oct 2026 10:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791540589; cv=none; b=q7TRjpFkL8B4/e/mn1BtyRtQmU2WsxCoQHAYIM11BLvdimSoYgXkG0i05j+JWwNL+3btARZ2DLbFpO4GiOjU8jszAx5HEn5k1TsAZ0alMKH5T4XwNCjMPMgwDFQu5TpollVtUG6pRibrkhnJrv2kQtb2DSTKu9lMhV6GeJAJ9dY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791540589; c=relaxed/simple;
	bh=DIYzQ1EPfmvk0HXDvk5SB0xtF59iHApk08ybYe83kU0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mv3aAys/ZsUGx8jj0I+necHwRviLsR7lGNjXhjJwX57LTokjsl5IaZLf9aa3nmnbyeqoPEknuBQpVt/dJy7HvEXNx4AAA+XJwJYmsxCsCFyEKjiR3HaQ8JvrSnnpCSYAxHf8HDKkVsQ0Cfxd1ldWfqqvKGOb4fCK04FufSLOGCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H9NthN4w; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=mBoZwzHB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H9NthN4w";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="mBoZwzHB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791540587;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=DIYzQ1EPfmvk0HXDvk5SB0xtF59iHApk08ybYe83kU0=;
	b=H9NthN4wmnC9Pcmj0Ri57PImOnmfhPmePnxznpUcmwoZVm2r188H6KkSYx4d2+gdK7BaBV
	yqm9atwifhOTkuYDWecDUqB+rsNmT7jft6DDvhBvQow+2jCNuOv3NE1sos9Z7KfPcu+hXA
	hDuNVPVvhcBfe0M/CHPdj78CER/7L5A=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-215-gi1hwzzlMdCodUe97wdQ9w-1; Fri, 9 Oct 2026 10:09:45 +0000
X-MC-Unique: gi1hwzzlMdCodUe97wdQ9w-1
X-Mimecast-MFC-AGG-ID: gi1hwzzlMdCodUe97wdQ9w_1791540584
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-48b008137d8so1050210f8f.0
        for <bpf@vger.kernel.org>; Fri, 09 Oct 2026 03:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1791540584; x=1792145384; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=DIYzQ1EPfmvk0HXDvk5SB0xtF59iHApk08ybYe83kU0=;
        b=mBoZwzHB6t0JxVDnJjopLZDbV6IoUBq6h8m7CYGH6/Kxwj82pBQu5ImtPiNvo5jLMT
         DBSw4WtGX3bWMuztpqnyMLitxnHbOdArxAhb2j6Ae4zhD9CiONG7VOvKWn03Jka68Uex
         qnjuR7Bu/ce+zGNL+5RsjraTeuwYvzyDCSXXhcFQqF2PY4AxqcwB6v6ZvfdPSh+3VB/N
         PKWuSGQh4KuKkAtU1Wth2Dn4f+eRSvRjT76/as6/e4sL3CgSfPhWKW5frDTLWq/vj7WE
         u4IRzaz0D5NZ0SvEeoIj0nHbgqqmFNKLHV35CFjpnVj6qlPIRUXeLQAcM8cA4kmHb8Wm
         cySQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791540584; x=1792145384;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=DIYzQ1EPfmvk0HXDvk5SB0xtF59iHApk08ybYe83kU0=;
        b=WbsFY4EFVsaV/2khof4Mve3eSfezCa4yUcU+6IsEMjSHlOXEUaHiPE6w9blMhuxSsJ
         2iqQ1z3TI3G4QCoCqP5ob9yYS1k56NPvYzBKmYFcA9aW8SfwG+H2UGFafWaaumwU4zzB
         SzD/ATpX0i4EuyanBjIsumzr01wjqgrzL08+mntcVe2Oi7wSiF5SlAJP+Eg+HdQE15d9
         uGKBnHGZ5H0qVQ7wE0H7zPX3cbV6xY+FDY0JsdQaUhpI+uuoWIjJfrb6Br6WYAAQuLut
         4y9eoSYOhAprpjo3zIpgJz1/sjx2p6bqNq84iD8hjIGgFdxfMaFwBcZElIFQVD0guYi9
         qOqA==
X-Forwarded-Encrypted: i=1; AKwUvBw+4fQ3iDevnwcjOqve5eAjga+WGG8t41N+LN0Lh438CINCKrWt9xkJRJYzwfCGdk5pTLo=@vger.kernel.org
X-Gm-Message-State: AFq9FYKoZxu6pcFlkxFLq4izgiDNAKuvW/3nH+XlQI07Lq2YL50x3rgV
	lau7SbfkftTdtUXjlvznq2jRRrn9k4Kpq9lkra3yxABcb5F83nyE11kuH7Zi+PHzaxE4yC5wiNA
	X4JZjAXbdUbeGtjzUQBRA9B7bxaGrPfNMKlc6Fjd/JobXJEZLnSWt7qdjBJH66g==
X-Gm-Gg: AYBFou0OPOPSl5ckK7Ts5HzaLwZXKOMIT3E8NjlcTQgFJpak8cSuQA9N1ZcTsM1vS4v
	Rhtb1Ee8fD1yspFA1uMvsqExs5dIUw3DOiLey5V20PXp+VAGJpO/AjiaX8ra4BgvPBjvzRl4P6r
	GwziKR86XGjHcAE6/fCIy3QwyL8a5yX+yM7FYq7ILk1hVleJ6wpsu8t58W4hciP2u4EpeGcISrL
	xhQJAonW3YGJPtJDLa1nFbb5XL7MEdGT7cGAEdOGp5rhhi8kEbUKKtnL0X79Dyzmaj72fD6b2Yf
	aKh1BssTCbL5gZa8x6rNTDFep3j1itCaTE56Zjntshe59VbIraabm+MZUUxY/ySxgqT/I4fVB6J
	fInqzH4GZ6mHzC97NejDZSrtfIPM=
X-Received: by 2002:a05:6000:4683:b0:487:146f:7c88 with SMTP id ffacd0b85a97d-48dba9e6381mr1934016f8f.4.1791540584333;
        Fri, 09 Oct 2026 03:09:44 -0700 (PDT)
X-Received: by 2002:a05:6000:4683:b0:487:146f:7c88 with SMTP id ffacd0b85a97d-48dba9e6381mr1933990f8f.4.1791540584008;
        Fri, 09 Oct 2026 03:09:44 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.168.96.228])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48db9ada3edsm3163180f8f.53.2026.10.09.03.09.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 03:09:43 -0700 (PDT)
Message-ID: <76753c2dd66792ec6eb94d00741e61366df426cb.camel@redhat.com>
Subject: Re: [PATCH v2 09/15] tools/rv: Copy stripped bpf_atomic.h from
 libarena
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org, Steven Rostedt
	 <rostedt@goodmis.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Wen Yang
	 <wen.yang@linux.dev>, Tobias Schaffner <tobias.schaffner@siemens.com>, 
 Viktor Malik <vmalik@redhat.com>
Date: Fri, 09 Oct 2026 12:09:42 +0200
In-Reply-To: <87fqygl9we.fsf@yellow.woof>
References: <20261001152042.124445-1-gmonaco@redhat.com>
	 <20261001152042.124445-10-gmonaco@redhat.com> <87ld89wtrx.fsf@yellow.woof>
	 <4F009BB7-58C2-4AB1-8FEF-61FA4B5281A2@redhat.com>
	 <87fqygl9we.fsf@yellow.woof>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0BrZXJuZWwub3JnPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmjKX2MCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfIQuAD+JulczTN6l7oJjyroySU55Fbjdvo52xiYYlMjPG7dCTsBAMFI7dSL5zg98I+8
 cXY1J7kyNsY6/dcipqBM4RMaxXsOtCRHYWJyaWVsZSBNb25hY28gPGdtb25hY29AcmVkaGF0LmNvb
 T6InAQTFgoARAIbAwUJBaOagAULCQgHAgIiAgYVCgkICwIEFgIDAQIeBwIXgBYhBMrKEfgLgd0WcK
 eo9u9KbElYeE3yBQJoymCyAhkBAAoJEO9KbElYeE3yjX4BAJ/ETNnlHn8OjZPT77xGmal9kbT1bC1
 7DfrYVISWV2Y1AP9HdAMhWNAvtCtN2S1beYjNybuK6IzWYcFfeOV+OBWRDQ==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-2.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-10-08 at 13:16 +0200, Nam Cao wrote:
> Gabriele Monaco <gmonaco@redhat.com> writes:
> > Mmh, I'm not too familiar with them, but they wouldn't be drop-in
> > replacements as far as I understand. I'd need to use C11 atomic types
> > and that would diverge further from the kernel implementation.
>=20
> I am thinking we should migrate to BPF entirely. Keeping both in-kernel
> and BPF will be a bit painful.

Yeah that's a valid point, though I'm considering it more like a longer ter=
m
goal. I'd rather avoid rushing the migration until we're sure BPF is perfec=
tly
capable to handle absolutely everything and we can cover every usecase.

There's a common belief considering BPF a prototyping playground, where "re=
al"
things should eventually end up in the kernel.
Now, I don't agree with it (look at the many sched_ext policies used in
production), but I'd want to assess if dropping kernel support could drive =
users
away (e.g. industry/automotive which keeps popping out) and understand the
various not purely technical reasons.

Gabriele

