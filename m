Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F4D63043DD
	for <bpf@vger.kernel.org>; Thu, 19 Mar 2026 06:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773900870; cv=pass; b=KWAdxvEpaDICH1zXqHqCWBuieiKoCGB+7eQXB9SBUiKm+B83KU/8cWsp7GNbqHJd+c37pvKnfguxWObzTlc2vKiof9CG9DlW6tTG35iWwbKkpA2QEN02RhZf9F5t9JPRdGtah8PYiFxTXfPg6QOOFu9BtpFwndlTSdUhiDShTKU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773900870; c=relaxed/simple;
	bh=SQ+z3M1aVBV/yGiIHj3soRAMSRUr0kzLrKssGiOSYTQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NCn9XH+3+q6X4YjfdKN0B3hxOX/wU8KWvOsEpQFGuOnSvLQ+LYVdx4btlzC73ZC497xmsxpxlyuHiTUgbQvhs4b9mFou96I3PLOHwWRGBFHyHPBmG2MT4Nl1PZfnw/zniFYdV9poQFBDurfZAm9cLNGz1hW5pCVAOesMj61rW84=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iRw959To; arc=pass smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iRw959To"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-439c6fc2910so339238f8f.0
        for <bpf@vger.kernel.org>; Wed, 18 Mar 2026 23:14:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773900867; cv=none;
        d=google.com; s=arc-20240605;
        b=Vh7nShI3Mk3v+cYG3OhYP4pgjlpIiFWdn3JRnEB0oeg4COonF9BYslnVrgsJhGfi6h
         teVzXZUCyBbgL8MZON/z/ufzsSummAGFa8PyQSqLBbPtLTE3uNXu+mz8iedmBaLb5O5C
         lqO3UPW4juGVzyDkqV/mWS/Ecb17Nnlq50kUtOY3hku9YGR54d2armUigMPFZCR12/eM
         O7FTxlAgtNiqyvOgOf6lAguedUdz+DqS2rsZu81VfVdrTEWTL6JNHE4IlIP+5y2pcYAN
         awmwA6k/UBCcsxa7WepMux+YjEzxMDJxOV8P5qa0G3xeqwbrdgEup7jAaH9IwlxzHrI2
         Hd4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SQ+z3M1aVBV/yGiIHj3soRAMSRUr0kzLrKssGiOSYTQ=;
        fh=56BP9urDyK4iNCpmqB1kWveTLvwy7RdVVMhqRiPQ9rc=;
        b=ir3mmqkGtQ/ivwCmy4NdBRGr2s3+oD4DHXUqUCjpsuAYe8vpafzVSv2rQKrOonzQaU
         qQqMrI5lA+FmuD+ZVUosus2q1qYS9BC8cJgKyiSZ1syRPqk4dy8fL3K3GQsWbjAmUexh
         TeNgOU6BlC31mwl3E6IG7kMLIjFzN7eXDyV7Y7W9smfXZ2ZsObUbC1vPZaHVb+11R5LO
         wnSASbuZS15jwcDqLaI046mAMnjTiO2TB0fa/euQRXfUZ3G/o6p4aKIwJpFwDsiPOcO7
         R3F37GJX5AWwK/pq+3C074UPa1Kiwy9exa4kW1X0Y6TjRNlan9sjnr4hJXDtAKK7lLvj
         ufPQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773900867; x=1774505667; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SQ+z3M1aVBV/yGiIHj3soRAMSRUr0kzLrKssGiOSYTQ=;
        b=iRw959ToEM+5ZLpOhk7wdr2Suj18S794qSZ3lBQoeQEudJma9UvH4Cj/8k6k4mJhkf
         jUc9NwECD81zI77McBMj0BAr54GBTZ3Ue2erYZZuaJm2xhoz62nrQ56COpYLNQSkyKVw
         i2sX5ND1lKseVpP4Rx2e7Cqw+eQj5rTA1njrUpsQ5u7IIVfuJs9bjZDKjxAZU1JsxXCg
         HsXfHN3/kT0iMGsYJX4XNKOEXVcLeFUvWV7LLkO1+UgZdq8zQQxBaKKHefpzCGAnIJS4
         C0J2+dyKqg+JxPqQ+QHNPp8QU1d2KIpZKfknz4TYvkmKH9JrHrCcl+tnD68P6e/pN2q9
         jDYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773900867; x=1774505667;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SQ+z3M1aVBV/yGiIHj3soRAMSRUr0kzLrKssGiOSYTQ=;
        b=q086GMdu5zNiqFpOiEvYwgmeE+sJwR6A8KDAlbcQ6a4E5OHNtQ0gw+FFlQEh0Xc3uX
         +ZbPQuSkhH9l674/wjuFD86B0J0D0ou9jPZTWKMJII5Xy+ipORvt5hekBf68wzQMXRg7
         kESq4AsaXxe1uivOGVkQfGiVQ3sqj+nbPb3DR58gj5qSlfSlQVInPjNAzn3o3a1jBCb1
         8hUTiqG05a1Qy5hfe008xVdU9ZwjVcU2jl69RE+dcGKF58LnQX8IxWUWVKIkbuzzkRRq
         0E0FEt1uCpyQx9N1HkHW8sYC/l5hx4f38NdMfpFmYgGYc2Okv/vq6+NBb7w4TS1KWFbu
         uFLg==
X-Forwarded-Encrypted: i=1; AJvYcCXiv31EMwBz5iocj1dIAF3DFOUai/pN71D39HMSNfQbP+pEbDoPKUPJcBfCwzD4QX5FdM4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzS/oWa8vkg/rl+E11HV+BI4/4ct7nPxaurcrUnUF7urFLt5jIu
	qUE8NnBGlIktKHSwVTQSrKsVea5p9xBVPPZmUxrFUp4CrZtA1lAbTP1bbJi2V6G8y7XZlvYrsq4
	KC4NdnAqJOCvsHX3566dKO8cqGysuVWo=
X-Gm-Gg: ATEYQzx6M5juM3B9sw0gFVjh8W5PlwSJ97wGgSW3QhpIPeSl2vLywbcjjYLecv12QP+
	GieBhTNzP6UHv++zfoqUfW3l01QjQcyt+tHgWNYczIu3lkFujH10PILDlUAFaTL2KE88wSNtKF0
	d+YE/mNgd/NK0/v2M1TECiU50f8+iIVSXWg4aGtCVvZwrpT58t92Y2RLFvNSV5VVQ7HXVWYBhik
	gLFh/JwavgWePMOdIXelMkr09snm/amjyO7Iom48lGcaQq2fKb8IB5S1k0mUMXMqOygcUcGN8Pl
	IssRjfCLFgyOwX2yt5UTDgL6fX1QGSTDAWlouloAv8wXm31R7rs4FkR1HP6JuAHtrGI0YWczGsM
	lfy6/1Vgq6akfRojy1MCTq5movPEThVHU4Emx
X-Received: by 2002:a05:6000:2504:b0:43b:497c:effd with SMTP id
 ffacd0b85a97d-43b527c3c0amr11044546f8f.27.1773900867220; Wed, 18 Mar 2026
 23:14:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260319045122.9122-1-zeroxjacks@gmail.com>
In-Reply-To: <20260319045122.9122-1-zeroxjacks@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 18 Mar 2026 23:14:16 -0700
X-Gm-Features: AaiRm50f_IYYhVikvzj6E2w07QXqlK90DOLutXk0cx9_pW4r9NSrXrFd6_UGYtc
Message-ID: <CAADnVQ+BQ0danodXFvrD_+kJav0qSwSOHg-n8Q4riykWT=1K_g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] bpf: fix out-of-bounds write in
 bpf_bprintf_prepare with %pI4/%pI6
To: Ibrahim Zein <zeroxjacks@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 18, 2026 at 9:51=E2=80=AFPM Ibrahim Zein <zeroxjacks@gmail.com>=
 wrote:
>
> In bpf_bprintf_prepare(), the bounds check for %pI4 and %pI6 format
> specifiers uses sizeof_cur_ip (4 for IPv4, 16 for IPv6), which is the
> raw byte count of the IP address. However, snprintf() returns the
> length of the formatted string, not the raw bytes. For IPv4 this can
> be up to 15 characters (255.255.255.255) and for IPv6 up to 39.
>
> tmp_buf is then advanced by (err + 1) using the full string length,
> which can push tmp_buf past tmp_buf_end. The next iteration's bounds
> check underflows due to unsigned arithmetic and passes, allowing a
> write past the end of the per-CPU bin_args buffer.
>
> Fix this by checking against the maximum formatted string size:
> 16 bytes for IPv4 and 40 bytes for IPv6.
>
> Fixes: 48cac3f4a96d ("bpf: Implement formatted output helpers with bstr_p=
rintf")
> Signed-off-by: Ibrahim Zein <zeroxjacks@gmail.com>

if you want to land these patches please participate in code reviews:
https://lore.kernel.org/bpf/CAADnVQ+TKKptnNB25V3=3Dbcdybh5G6c2DyW2sYtXvyRaV=
nPN8MA@mail.gmail.com/

pw-bot: cr
