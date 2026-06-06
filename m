Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CED1731194C
	for <bpf@vger.kernel.org>; Sat,  6 Jun 2026 20:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780778063; cv=none; b=L/Jrwl0B7bKiRgjJFwuoM7nUFnLvgLycGp7fOpPSkAw9rNvUFBhVeWXIuB744SXeuEXJk0hhaag1GnLwSlxx+A5i1rcR2mIefejKjOhqmPqDXDKxmRcT3lG+9P6cvlBhxJAdnVV7b1V9MmMWdIqEiOR8KSu2a5k3Isi1OWxIlJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780778063; c=relaxed/simple;
	bh=BnWRu81zM0qbnsw2zv0pp5nf8QxwugmmRPI9Onn6C10=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=h6gqL9TCW9Ld5z8X1go6HIjdFQ6D5CTrJt4jTCxWi2nB7pd/pdmjhys7VRapfpE4aLXSuXVNhpOvy+ITqKnBUQksPLZqHnI6YbK8jlH3JgzZpISSchTETZLbdFGZMTK0o0HQpSpNOsLYwjusML0qVg5qJ9s6z0x7Y4MBoM3JGnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UL3BtY95; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UL3BtY95"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-36ba285e98bso3021241a91.2
        for <bpf@vger.kernel.org>; Sat, 06 Jun 2026 13:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780778062; x=1781382862; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BnWRu81zM0qbnsw2zv0pp5nf8QxwugmmRPI9Onn6C10=;
        b=UL3BtY95p5HXO2pzP50Q3eK5X/09Dgd0hQKFaoASwu55+qXPRTu5ONMOlUJQM9EsVN
         rMih08x+ZXvEaKkG2Vqt2omDSWPGpAf2QNREQC/cRj/Tzlb7vIrLMU46f8Ak+Aj+gQPf
         9AVJZsFN9k8pHwp7vtMq4x3ncoc+VzirgC4TKDA7O2GHZYRinXhyraHlrBYZ2SVml6ko
         ZvzSrFAs2W3tJlFskVCtj4Zx45QkahlcgC1MX/R83LE2cK53OM2kzLpZC5nIau567l4p
         AoJn4hxBnIpQ0kBwn2jkBoObLFfW+3JS3H/SdH0V0h+sKd5SEP9R0+hVgNMnXDbZazkv
         I/2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780778062; x=1781382862;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BnWRu81zM0qbnsw2zv0pp5nf8QxwugmmRPI9Onn6C10=;
        b=l2KWnPfq5Zu7p3cRVGN3hs9gmFR7zZtVleuHmhqXzN9j3XprUKM77mYLpzA0MUgV1T
         +TXiJdy+uUeQ1POB3B8z5slC9iVaRJdEy9WH8rwu8QeVxIDDua85Buz0JMpBjwayVTVn
         Pxm1/HU0XsWLaOZYu4WHa9Gy6ZBi1JEzqtVFDFdJD8wcA5GZ5m6A3Inc/mUhKzogvI3h
         7MAxnYl/HWfRMAaG73PBeMWMlLAMQj6wFYHG9nwDdWe1RJKvKh66eVyrLQJKil5Nj1OH
         958HuJETf3H7EXcpdyoW+SJVKVig9S4m4pgS3JQtTYwW3gf6f3ffrbk+/3/GBjOo9wwh
         kFFA==
X-Forwarded-Encrypted: i=1; AFNElJ8l3WmWm3eZ35QCc0ATxg1HBnXl+9p8AGy7PV7+3VUtjrRD9EOpTdByqXi2rEc8ZyXuG18=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIKMsJy1+4ZVEMeGV6u7NH4lVbVccWGmWuWJQBVpMk7EBol28t
	sMKk81V0KsqNNjt4Mu1JH/33S/IitA4E0KScBsDDuuvjiyItVuddoTvZ
X-Gm-Gg: Acq92OFCbLifSeINhY38wIA/6crp/KxPEBAViNUDOyPnJMkClLy3TND6OUAYb0DPhC/
	v6gxiGLdJzMti5hfQn5YZ3D/LI0iMdwCROQcG+fUJMP/S8KskudrrCzZAYBjJqY7ESEcxJT7iyw
	ItGavfYAbdBUYFabD8QNOzKz6MfGHG/gVh1WRyWmKczaEnGWijiY8iwiHRIGeKSl8eDuxK3aYEa
	Qqhz8vHcVw4OAaAlBwJ2pN72XN16NJ3F64tgo3wcJaiDEEe19OyUzWEEWdDxfCaU0Z1DbJttsvU
	1hefVMF0Aq67hNpzW29ZYb7i5PiDmoHSOpI454zQNcu8eK1bDXOtPK+djBgdDkFcuQn0XZCWOFj
	qmN24kh1agHlspWBUlgbAjEcvNmku4NLrh3KwBz8IIBo8YjCmjRsb77RzXJe4uD2U4jIZiLES3c
	xUyqRofj4ihQ/Sam6Hirb5Mk6BDQZ0MDs99KTg6ppUurxKMdOVe8im+osxq0Vi0A==
X-Received: by 2002:a17:90b:558b:b0:369:de03:29c8 with SMTP id 98e67ed59e1d1-370f122c744mr12490424a91.23.1780778062093;
        Sat, 06 Jun 2026 13:34:22 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36f6bf82fecsm10869882a91.3.2026.06.06.13.34.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jun 2026 13:34:21 -0700 (PDT)
Message-ID: <bec638245094a11480b852c4e7f7712d2f00b229.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 2/2] selftests/bpf: add tests for
 PTR_TO_FLOW_KEYS offset bounds
From: Eduard Zingerman <eddyz87@gmail.com>
To: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>, Alexei Starovoitov
 <ast@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>
Cc: John Fastabend <john.fastabend@gmail.com>, Kumar Kartikeya Dwivedi
	 <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu
	 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa
	 <jolsa@kernel.org>, Emil Tsalapatis <emil@etsalapatis.com>, Shuah Khan
	 <shuah@kernel.org>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Date: Sat, 06 Jun 2026 13:34:18 -0700
In-Reply-To: <20260606-c3-01-v3-v3-2-97c51f592f15@mails.tsinghua.edu.cn>
References: <20260606-c3-01-v3-v3-0-97c51f592f15@mails.tsinghua.edu.cn>
	 <20260606-c3-01-v3-v3-2-97c51f592f15@mails.tsinghua.edu.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-9 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, 2026-06-06 at 18:50 +0800, Nuoqi Gui wrote:
> Add verifier tests covering pointer arithmetic on a PTR_TO_FLOW_KEYS
> register. This covers the bpf-next regression where an out-of-bounds
> constant offset introduced as flow_keys +=3D K and then dereferenced at
> insn->off 0 was accepted, while the equivalent flow_keys + K direct offse=
t
> was rejected.
>=20
> The tests check that in-bounds constant arithmetic on the keys pointer is
> still accepted, out-of-bounds constant arithmetic is rejected for both re=
ad
> and write, and a truly varying offset from bpf_get_prandom_u32() remains
> rejected by the existing PTR_TO_FLOW_KEYS pointer arithmetic rules.
>=20
> Signed-off-by: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]
