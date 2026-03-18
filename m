Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 471713101CE
	for <bpf@vger.kernel.org>; Wed, 18 Mar 2026 22:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773872790; cv=pass; b=Gkyr67Q+1JmW7rXgzKSsFN74eFO1kFCJTb82i1x70Sl7OOHuvWtmrf5eNeWN8QSJ9pPBHFh94vs7C0tpgdVMvXgA5WDetVWpBF5Le4MOZiAoFdDvUUQEl08k18VEk0kJADXlF0n+Aq6Bi05G6WZNNQYdb8Kz4wgQ2R5yF+ur4Og=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773872790; c=relaxed/simple;
	bh=suQTpWTTx3bA3mnhRwpTskx2qGCvkyjGTxowuVPQcLk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SNjHBh1wezgRBQVM/eLDH12+rOevJeRr3KSflcKvmt2gWPV7R35CSZDeJTCp8jf4xOpmliLBU+q84RA+0h1I6pk4sxSwIaYSpUZC4x4/HlFbG2WPPtdslfLTMWXbVmQ/cXc3ysfYBVSJukuZdCcn1evJHMRe31iXSwm9VA2pZMk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RlmWt1/6; arc=pass smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RlmWt1/6"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-439b2965d4bso222927f8f.2
        for <bpf@vger.kernel.org>; Wed, 18 Mar 2026 15:26:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773872787; cv=none;
        d=google.com; s=arc-20240605;
        b=IzHRL+hN/ZM5hViT/ESljLGzIzsXB8HfhsrQLJfveaUlD2Wy7rislfE0aOztyCIs7D
         HmZequzMjACPuJ+8zbiuMZ4DSdWs1yEXwNEyue9/e2tZfZEv6VKnvYLtxGvMppUZFMQ5
         bGzW691EmNOlWdRc+EIJ/2pjjq/6Tfwtusck6EbUUa74wm653V4IxWU2I+K5+QHnnyaR
         X5Wjsod07PaoYmP2Wh9RsgFsmcLrvv70cNsCAWbOQyZHYdR/nYbkeoss3Wh8K35WdtAu
         USsHMkTKRoBcitEhOv5Tb8jQE0Xi6siOyskDhDtL7Q03sD+2di11vaJdMH2AG+z95yRM
         1bCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=C9ZzSBrsH3W/m31DN9Em6I/8Jqq+tMTlIc2L4V7PUOM=;
        fh=94KxJqWFPPSgTfnVxQ+THvPkJG+3iCtqoEb0JwMnFaM=;
        b=CgXKZxA0B7uK72snlJqzTUwr7SbuTq7n1GBSwKj0h1RLTS6f7/lKd8T7uV0Ro4w9GT
         cmnYp9jYX5Org91BFSB1FVC2C6X8BLJsDxszm/ALYzZ/v4GLdlsRQIUMwAQHS5ol93My
         mH0CEBQiusCVxR9KGwYU3RbAMMQYJY6hkXCmMYKMY5bpTdxrqeO7Asy7r1epXwlV3pie
         dfRUrKWkLOkUTl5WzC4LzWtddJw40KyxaiX/xt/ZJwbg1ZNxt6Yws0Pzuxu8dpy49XMP
         LzqPnTLJ1bfjMxS8zGaaOz26sp/V8/Ix3++X807IjXW3fJ7KLZZtC8uL/lu4t92DBU6a
         shFQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773872787; x=1774477587; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C9ZzSBrsH3W/m31DN9Em6I/8Jqq+tMTlIc2L4V7PUOM=;
        b=RlmWt1/6Ut5peWmERbO7171CdgmtrC3IcF+Be1vH8RMDA74PYibOa09AGw51WEz2dK
         LlLxLlXUM7NHRBrj0qTdjdXbIC9CM8hN6plf0SsOFnlDItCfCzIHr68aJm2ysnLuqu0i
         5Cvp0XY0PJlq/LSMU+8MGvGN1RrVn3cNXq2XmwUPuqfLM9CaBBcUmh9MQrlu1AWd1eB/
         KmVR4lHBzzoJ7f1QBbXGhG4C3w6ygpKnLzjLJTB8SD72IC6CF1bBB6rXsnNwJJm7DYjL
         DKdD3n8R9v/hj8CHoSPeetiWfXLV0cNnXrkugXhyxEFlXi6Op5vzKstDUMfEXVlK4179
         Z4AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773872787; x=1774477587;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=C9ZzSBrsH3W/m31DN9Em6I/8Jqq+tMTlIc2L4V7PUOM=;
        b=jq2XU5ROJY87gOjMxHnlCX+DWdM9MSLa9Yt/OdGvyDjerv+mhwpRr9EkBcnnP9lZXd
         JK2jOSdqGxfhBNGFhrimDPSSpy2GplUtldK8a3pxLCHexD+EAi3NFZ9p8upcxDa1b375
         vnL2YN93A8DobUe/rjJK1RnVdjU2EcRs0RbGNVmPgAEGun4loy/P8G+DtKhA58JUbAPW
         REG5zy6hOWAECvDpPdL/WZu7ALmg+AQUMxgx2hVh3INxbfB0Snyj5/bDNp7mQ9xxcn90
         gpXB4bwJ1jknT9yD2r+i9mYhRYeEzOJUjD7QPtM7+nbpXxA2Y2n/Ov4aUq18nw3taUWT
         17MA==
X-Forwarded-Encrypted: i=1; AJvYcCUZacuPWwH1+6ss377cfoSprtl4sn9mxDBOh0S27bDc8t+YnJNSIiDDddl2EO/e28QcskI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTlgbBbd6VHg1wPwqrRjXca2ddxuZ+pY6GLjeL1H/mUdiExPeq
	SsGMCFQGqLlGRhsVPV53CRZzfwRyxYpSG9Mwh3mCi4XJ/+XeAgpaKoxRjgBFmiUB0U4A33ns6f+
	nPjcAcUUx7gbpClw0WDUcK0YCJrcM1H0=
X-Gm-Gg: ATEYQzzjkm1KKuamIgnjNFViiiVKU4WOZdX6hRlakJQbWTdJiP51z8JDGY1yYnm+h82
	TZtYWyRYzeiUJBKB7rRU/73q1om2xM2edx4BKzv5x1KPktYQMmq2ofPpckJhl15QZ5gtJXh/Ps3
	i7eDHQ0o369bXTXycNY0kaiXXWUnJCj+8+Z49gwBVSGRTP/kOO2OYyzwbmLV3OSsJC61l2GqGdd
	RUXF7+EZpxw/4IazBxgzpB3h9QhmBWOMItgI9ulLNIm9/47sKEERVAWgwYiMqsBHnRICKrGlx0n
	SPhhQnrUlS2eP5l9epLuwxgRoFq7Z8hsS3rHCGcaEjdXCVh4wPaVe2MJ9zE3p2nnp6+IfgD4pdG
	BfBLLocMUNIL0u3IJR8GyeXnlsQ==
X-Received: by 2002:a05:6000:4387:b0:439:b791:f914 with SMTP id
 ffacd0b85a97d-43b527aa416mr8480966f8f.18.1773872787360; Wed, 18 Mar 2026
 15:26:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260318222013.2009349-1-ZeroXJacks@gmail.com>
In-Reply-To: <20260318222013.2009349-1-ZeroXJacks@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 18 Mar 2026 15:26:16 -0700
X-Gm-Features: AaiRm50bIT25fbuHVTzp4c41AmKRS4JHuGv_fkpf7hNqtthpufjg-PcZUsRp_D0
Message-ID: <CAADnVQJxsaL_5YiK_VjRsff4oofufAH8jPsWe55qbEWqbFaMjw@mail.gmail.com>
Subject: Re: [PATCH] bpf: fix out-of-bounds write in bpf_bprintf_prepare with %pI4/%pI6
To: Ibrahim Zein <zeroxjacks@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 18, 2026 at 3:20=E2=80=AFPM Ibrahim Zein <zeroxjacks@gmail.com>=
 wrote:
>
> From: Ibrahim Zein <zeroxjacks@gmail.com>
>
> In bpf_bprintf_prepare(), the bounds check for %pI4 and %pI6 format
> specifiers uses sizeof_cur_ip (4 for IPv4, 16 for IPv6), which is the
> raw byte count of the IP address. However, snprintf() returns the
> length of the formatted string, not the raw bytes. For IPv4 this can
> be up to 15 characters ("255.255.255.255") and for IPv6 up to 39.
>
> tmp_buf is then advanced by (err + 1) using the full string length,
> which can push tmp_buf past tmp_buf_end. The next iteration's bounds
> check underflows due to unsigned arithmetic and passes, allowing a
> write past the end of the per-CPU bin_args buffer.
>
> Fix this by checking against the maximum formatted string size instead
> of the raw byte count: 16 bytes for IPv4 and 40 bytes for IPv6.
>
> Signed-off-by: Ibrahim Zein <zeroxjacks@gmail.com>
> ---
> --- a/kernel/bpf/helpers.c      2026-03-18 18:04:49.000000000 -0400
> +++ b/kernel/bpf/helpers.c      2026-03-18 18:09:39.126681954 -0400
> @@ -930,7 +930,7 @@
>                                 goto nocopy_fmt;
>
>                         sizeof_cur_ip =3D (fmt[i] =3D=3D '4') ? 4 : 16;
> -                       if (tmp_buf_end - tmp_buf < sizeof_cur_ip) {
> +                       if (tmp_buf_end - tmp_buf < (size_t)((fmt[i] =3D=
=3D '4') ? 16 : 40)) {

Ibrahim,

Please stop this spam.
So far you haven't sent a single valid patch and ignored
requests to provide selftests first.
