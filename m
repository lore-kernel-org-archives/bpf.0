Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.182
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792781652;
	b=0BVJm52SNQwWBEWAMkRNONJB4n7ll5dqmn9Ot4SxHHzfweXd4ijchstT64nqorcwON0Y
	 YYpgbNjF0h8He+qv7ZMuk7MLEPgiAfMtl9mVQCBWcKnoB7km2X2dSE+ILoi8pj9xN5mTo
	 MMeQuxxnlZSWxzPCPTVnTc52qT2WrWdGwtYIvvPDtJ/KujztI++il9cte63QzogKU/8Iu
	 MMGrw/PpmN5I4zIyasSWGAtuOmOrdJQ1+pem8aIwp5HghqdtzDjjONNoHLymYwBe55pj8
	 52z4HanBmKFJQIITc9P7vy/KmcLgrHA9+JoVqECLi5QFos2xhE0qBt5pfryAhrmelgQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792781652;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=rU1MJkNETayS5var2MLHM73zlvbHQxyivwE/jbKWRfI=;
	b=PuB/mJRKfDRsi/j9PAm05MHuvTCfqkulJbBkYllxMZYoc7H15JqqOONrvwepHnKAPE6+
	 p24eU5Ye6lo0TEFGqzmAlEfBWKEXYzPSMgqhcfbFsOJUqS89csIt06qwcV4cEw722phc/
	 6x+f4xuYqjbjdwVeH3ncvrTcx5w+0xCAP6Fj7oMbdqamTdCYZiuDMNUAwRD4IhwKqs0kW
	 JLPLZrbRIvGaXxDqlagBSAw9X6Af7e7tsd5yTce3RDKsveI2SFCtNYuOcYWDGTbJsEA5e
	 vIcXDszr/EcH0hbQSTzljtEAKo/Rct2x3e0UDYQkmYKFHw3akz1c964nlTeA3gPtGVA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=tH2PzqGf;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.182
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 258D4606A31A
	for <bpf@vger.kernel.org>; Fri, 23 Oct 2026 18:54:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 258D4606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=tH2PzqGf
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2e5fb79ce82so6921095ad.0
        for <bpf@vger.kernel.org>; Fri, 23 Oct 2026 11:54:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792781651; cv=none;
        d=google.com; s=arc-20260327;
        b=SY2v76uXWL9Sk4jYntOYI3/WDdzGPWzv+nNdX0os73griGXYHDaKu087BWUq8lIhUK
         Sp7RZ9mRZcawGnv6uUr/R1LiLk7Gdbr3ze0L+eDhRwhpAuLgYPNQIkLv8TQBnbvEBrsZ
         a8LoQPKs8840AD4VW85z5PHhOS6NxCRMM/K4Ci2sXU0QsCAQphpQWkjd6JVy9kfKUm61
         dNEGWHPXex9xbfaiYnyLWy+CwKvUHCCopw+8RpYkJOtP5DdeopRSFaULS7MIgG597ecG
         qwIHw5L0KrZJhH7Kpll4EKfYCkCkW8xZZ5t4AFg4dWsLCJudupWqGZ/SGUNYUszHTZ0y
         XmNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rU1MJkNETayS5var2MLHM73zlvbHQxyivwE/jbKWRfI=;
        fh=ocnwoB3DOfw+DYWxoh8pphj1tJkPfMujaIgQSfhZNj4=;
        b=NpIvHq6LxRIxh44jFIGRQEUET4KGpPl4buEB3DDByZf+Z8q3LWRe6FFIoNyv6jTHmA
         cILFvjTI52sdaDs9KtBBNpZinwo2kDOjTVe1xk3qkCOe85gwm7aWiCziHzvx4R3YDTp6
         Zkj0BNIqAyRemQuUNBKCSjCH4lRikSAjHOyru4Wg58uYg+1bnYPzxSlM7gSOT7UhvNG+
         YpgM53a3Ve2X3WRtyzOYd8TAoHt2UW1JOIwBshCzjkprQueHU9hmEJR2F//ySeOqG67X
         k0KERdviujEnRAhU2S4z2y9pgmV571aRTZnWWocUES3r66KJGTwrBRFawoTQMUGUNf02
         5H/g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792781651; x=1793386451; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rU1MJkNETayS5var2MLHM73zlvbHQxyivwE/jbKWRfI=;
        b=tH2PzqGfBFXUmYs+U0jgxOiwBUXW3Sw78Br9mxWPzz5zt2F/svzbOMPh7lEjoo0ZZF
         j4GnojgKAHeLSLFGyEgfvcNDViTPG1998Y3gip182ruBL9vYQn2kZhwzRfOeE9Uesj/R
         vdFD5yriZ0SkT4bVJF06piBN3APb0Kw5Mm83EkuGYOwakhTMz9WbsK3KFfPGnF3mozS2
         yClmI9XRaHQq6aP5NTLJiyg+MsU4X2lC8YHiDGHaePt3mfBVrlpQLArFbSkgnitcTgY9
         S7fliGBzS+AFcqouePcT12CLNclcTaRsKMMIchljQFSpeFzidMIwVg/2q+9HutAJZWLk
         I9pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792781651; x=1793386451;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rU1MJkNETayS5var2MLHM73zlvbHQxyivwE/jbKWRfI=;
        b=jD2FZhSDH6S8RyxwsTviv1gia1ZhQlHWpdg1p5FYYqa75dBdo/f5A4BR8i5g2GGe73
         tRo3hhQwvtNBh8k8StdMSttE51m4vjotesjYULa+ycQtP4XdHx1HUQh9k8ZbB6Pxwd7D
         YSdIGa4YxGu1L9n8IUsr9by5jVufcCP914xHwdmvixrbqpM4gx97P0oETrxAhyHlgsU6
         2i3evAyNU4NYp2g8ic8YmFI+WOyHGCjQ4FmCF+kRb0szFrkzs6g+Ya65/uvRuMWmofuk
         3NlEUZLF6rys/kVutf7cYLIJ4SzNb8g2BX4WalF0REPquvHZ2sGmfUypMbPD8B/MAr/9
         rLNQ==
X-Forwarded-Encrypted: i=1; AKwUvBzUipZ9WjnOj8B2iUj6hylPr9srHKQYRI2BXBvOSfyEZbXOr8FCfD38v9qsOR3aqyTPk9E=@vger.kernel.org
X-Gm-Message-State: AFq9FYJUSNF5Z/zRC+/+ej+ixiM+HTtyM7zLDET3iSMbmaojKzM8ytay
	wseyJyuem2LTr6NBrWzsWF+XW/eYGtZKl7xBec6tMtycbFgBkaZekIx5cviM9EVZFnDtgIXqJPf
	dhZFv2BazBU7b3OqzHClX5CA4jjqvKrU=
X-Gm-Gg: AYBFou36iErirJ6CwFgb1SWTZUPGV43aUFqGHEUIZ5kl+a3EXATt6Iu6MsFGcfqXsq9
	BGpfkZGfBtpGgP5+sK3jEFEdsNU7CpksBw5KEpIwBUbOZP5DEisL3DZrvGo/X84Ju4EFqzQvPII
	o0jvqtkxBgsvzBid0frQrHoqKHmJQRk17UCUHXbm1v8mmtm6IQThsQVBJgwnj8UXu/Uax1rbTkH
	nUws1alj/sOCeTx3w194kvvvZNdjcxFdF3SCAt+acEw5EWtMQIb+H/uXXhVXjEqn/N19DwIN+cx
	9zUStYCxg5S0euYChjzJisTLN1P5W0bMh5KgbQ5Ti3INtnmh18Tfwqa3SZj+UolOtbM+TbJdazv
	EFhf48S/rWcEDHMfZg7ovxMHHXN11OaQ4h9yYhNu7ReQT5MZ2IgFtO76PLE5qeDqBSxo3XVI4Vy
	1glCytY+fP2ag37OHe7b0Rxp9+PKMAey1CmzYSzOcEp+Fjhd+YRmg=
X-Received: by 2002:a17:902:e88d:b0:2e2:fc90:11a4 with SMTP id
 d9443c01a7336-2ea7c1a473dmr29006745ad.48.1792781651387; Fri, 23 Oct 2026
 11:54:11 -0700 (PDT)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261021155629.68813-1-phx0fer@gmail.com> <20261022054811.35008-1-phx0fer@gmail.com>
 <DMBHB0TQOV1L.38MECMYFGUS5B@gmail.com> <871p9g6ym1.fsf@cloudflare.com>
In-Reply-To: <871p9g6ym1.fsf@cloudflare.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 23 Oct 2026 11:53:59 -0700
X-Gm-Features: AclHuK9Z1e1uuin3xKQj50QTuiC83gSWuOAbPYUtr_-0P4Nt2Rm5eucO2azxltI
Message-ID: <CAADnVQLTe611mm0iJEf5gJi2GtW42kxNHH3sUPevD039FvzL7g@mail.gmail.com>
Subject: Re: [PATCH bpf v2] bpf, sockmap: annotate the psock teardown data races
To: Jakub Sitnicki <jakub@cloudflare.com>
Cc: Dudu Lu <phx0fer@gmail.com>, John Fastabend <john.fastabend@gmail.com>, 
	Jiayuan Chen <jiayuan.chen@linux.dev>, Network Development <netdev@vger.kernel.org>, 
	bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 23, 2026 at 11:49=E2=80=AFAM Jakub Sitnicki <jakub@cloudflare.c=
om> wrote:
>
> >
> >  static bool sock_map_sk_state_allowed(const struct sock *sk)
>
> Code LGTM

Jakub,
Could you commandeer it ?
Dudu is clearly a bot and doesn't care.
