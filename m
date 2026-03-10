Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C96EF2D3220
	for <bpf@vger.kernel.org>; Tue, 10 Mar 2026 19:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773171942; cv=none; b=IWbSnOtiXUoIhwwxs6nVmeBUuJLaKO+ZiVEfdkJdODHEOcHYXO19IRx4pV2+1BDWG7xLeq8EP0LG0+19ApH9DCrvTtxXb5+iiG6uCnHZaAeMigsCzx1bG5nyeqfzHtLapjvu0xfOfrUAdZgKcrvEQFhl3koZxhUXBCTyNntzNiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773171942; c=relaxed/simple;
	bh=OJQi4MsEs+mAmIqoFPu7vOuOQKc8IyWrf/FQnLW1Hq0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=evYffVMYJ94F75BekeFkjmazP8S3bCRkAcBv1bhN6gTfGGkSuXAd7wJ4qEerxxbAiD6j48TWDGkGQm3B+05LgJWziA8ePC+zXwIAtW3C9xLhF3tfmHjdvw226Lo9+l382MAK2pfukaBQpekum3oQuSZFWx8z/lt+HIsJZ60Zj9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VEgSK5bD; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VEgSK5bD"
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-2be1d9c356cso8550255eec.0
        for <bpf@vger.kernel.org>; Tue, 10 Mar 2026 12:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773171941; x=1773776741; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cCENPbST3VuuO5CKhv0CGRvlJXK77jMkeSG5v3E6oU4=;
        b=VEgSK5bD0n4OzcOig/IT1RfwwmAebDc4Cm9C4BwnIkxJ1aSGGfIctPNx4TwS+F29mT
         qDke/5oJRWAQjvXAPeqGjfGZ7bCWy6FlRLLhDR0xKNQcaW+qXYMYt2H5EdhESO7IYTac
         1CVhrrGRK/vOSpkQz7QTCer43lM1QFlcJBiefa7X7chrAf2obR7jOEgxMJlDsPws/LZX
         wQmew/CDvM2mq4zwJBERE6SXa9f+fGCIu1OjDaxKoPTq5xIbC2Z6JYWx2Ri85w6P75sk
         okspak7vTfQ6IcYS2tdb8glSKgW89zvJusyI9JMLLyxnXgsj0FycU8qJnTpu/THaLYMI
         wppQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773171941; x=1773776741;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cCENPbST3VuuO5CKhv0CGRvlJXK77jMkeSG5v3E6oU4=;
        b=bMEJODUwhdRu47ou8ik3MX0TQ9umlkMJD99LxVt51SHxTSFJFXdQNl3SSN7QKw4vEF
         s1x/bfaxVEJ1pd02fBbUToxIDXoKBG2QPzQLvznsDGg+3RXmiyjokkLj0/r0wDqy3PMb
         8Ptv7YIcm9phrB0+y/DARkzjskc6x3EzG5zmA6kI9sUEzyTsamyIvjA/DxwOvrLINDCn
         h41D6jmo0Ayj1NoO5mfHAlogN9WW4X+3HO/eJYtJY2h92WirfRoztXbjdiJc3tDNG6Fa
         hDt4qF8KnoWYC7K59eblbl8/AWyuedhsI+G9cZiCto6ysJmh85TS+duFW0j2Wg4DafIR
         lUOQ==
X-Gm-Message-State: AOJu0YwuL7z1/xC4m+jCB1m6LiXx5Df+cq2TkjWF0C9tx0npR5uBE+1e
	+ON9+rPHg1V5ZZivrLi0rD+afH4/Yv+EBE0KSZ/uHujZ0N8L6p0JgDVE
X-Gm-Gg: ATEYQzxDYlbjxePs5r43S8Z5esmTGTO5n2QMkgZRyseTolH/qAiaodoQC8J+RGbZeI8
	Trgbmywfvh9pmJXg12jB8SS9JnEMW1MxjLheqk6QxuX1iAQYIffkafDB/yloPu9ESJO1JnFELV4
	L2zR9gHXokSNwJ4p6NrAh7jueMXdpXo+Swk45ATMj2Jclht6WgNoekpFWp+ZNNdaNPM1yTdO42H
	ODWWhfglYwkVkslssMseV1++LbuWcKhaRoPO5lvvUq9qA0fH5lm2ZTt30YAHImG0Mg8H9pNAAD5
	kTDMSGLumNquRnJEAcAMRCku46knUZl0bx8rJLvEfPaYSF8UDlh9MCddc0XdRrnbgDrJAzSLM4q
	EX5OJWdJHOkfr576KW+/9h/By7ZWQyluLqzhTQ+E5rVtrNz4V7VdJ8/c7Y8Ku5BlNeR88ZpTl0Z
	V5Yiwo8StQpnQjsKsl5JpVe7VIAktAiIEdU9hJr6MsLh6F9RIzcKBvUwFUinx6TjJ0s+geu8Ip3
	cy2XjL5
X-Received: by 2002:a05:7300:e619:b0:2bd:d157:6786 with SMTP id 5a478bee46e88-2be4e03ab3emr7328023eec.25.1773171940818;
        Tue, 10 Mar 2026 12:45:40 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:9dd5:5c94:8add:da1f? ([2620:10d:c090:500::1:641b])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2be6f83cd12sm9344269eec.10.2026.03.10.12.45.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 12:45:40 -0700 (PDT)
Message-ID: <cc228139101e28d2bc76beb371a2c3f89eed75f3.camel@gmail.com>
Subject: Re: [PATCH v2 bpf-next 1/2] bpf: Avoid one round of bounds deduction
From: Eduard Zingerman <eddyz87@gmail.com>
To: Shung-Hsi Yu <shung-hsi.yu@suse.com>, Paul Chaignon
	 <paul.chaignon@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann	 <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>
Date: Tue, 10 Mar 2026 12:45:39 -0700
In-Reply-To: <xec3lnz6smkki57civu5z6hlr5vl6kqnec7f7zxza4vifs2qf7@g4o6gxqmcnlz>
References: 
	<5b8fed05cc97cd3730bbdfbb452699b7edd16963.1772840030.git.paul.chaignon@gmail.com>
	 <621f8a301a3a29af041ea8384ab09498e3f20322.camel@gmail.com>
	 <d4f6ebe35ff98cf3aeabe132027d7a05ae4dda4f.camel@gmail.com>
	 <d6ed91eb3fc9783811ae9981728a5db57decbfe4.camel@gmail.com>
	 <xec3lnz6smkki57civu5z6hlr5vl6kqnec7f7zxza4vifs2qf7@g4o6gxqmcnlz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-03-10 at 15:56 +0800, Shung-Hsi Yu wrote:

[...]

> Agree that perhaps we still need to keep 3 rounds of deduction after
> poking at this further.
>=20
> I tried to run an updated cbmc script[a], manually editing the file to
> change the number of __reg_deduce_bounds calls made, and check whether
> an extra call would further change reg_state. For
> __reg_deduce_bounds_old, it needs 3 calls to pass verification, and for
> __reg_deduce_bounds_new, it still needs 3.

Using the same logic I played with orderings a bit:
- For new ordering 3 and 4 deduction rounds are proven to be identical.
- For ordering in [1] 2 and 3 deduction rounds are proven to be identical,
  1 round is not enough.

So, I think [2] is the way to go:

static void __reg_deduce_bounds(struct bpf_reg_state *reg)
{
        deduce_bounds_64_from_64(reg);
        deduce_bounds_32_from_64(reg);
        deduce_bounds_32_from_32(reg);
        deduce_bounds_64_from_32(reg);
}

With __reg_deduce_bounds() done 2 times.

[1] https://github.com/eddyz87/deduce-bounds-verif/blob/76755f763f9282b74ca=
4e2251f83767502a98e5e/deduce_bounds_new.c#L321
[2] https://github.com/eddyz87/bpf/tree/deduce-bounds-reshuffle

[...]
