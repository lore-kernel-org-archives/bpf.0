Received: from mail-wm2-f9.google.com (mail-wm2-f9.google.com [74.125.225.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A57F439A4BA
	for <bpf@vger.kernel.org>; Mon,  3 Aug 2026 07:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785743307; cv=none; b=W4vPwShrGcsOkgd5gFI6ZnI0yS3CDr371bIoAFiBjupel7nfz0JxTbdQlFSFk+LlIWFAL2kb3XMAFT8JQwq7eaVLzKcagMi2DJlFnTbK0IAJbgDinjHdA1DvhO39doOj1k4DUDT7AGsoWD6WjLdCoyBjOYdlJCEUvK5r/Egcxso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785743307; c=relaxed/simple;
	bh=WP7UlNML4eFKaUB/akoYBbWYzA9MjAvgTSFnhPtEPxs=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=X4nYs9tC+qw3gIj6UwgGA4R5LIaU37+dCUB69PYflfCGrFgKdx59O21i2tF5wv7dFFXeISZ82O8rx2Irf3vUFfnsfV8UWcv9mbQ2doiYAd8hK30dwAR6hDHED9fNjSZI3DPv+3gHKXU346fFpYNA/Cn/R77+bnWuuriqWMwbr04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oCdbVwOm; arc=none smtp.client-ip=74.125.225.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oCdbVwOm"
Received: by mail-wm2-f9.google.com with SMTP id 5b1f17b1804b1-49553da76dcso7093265e9.1
        for <bpf@vger.kernel.org>; Mon, 03 Aug 2026 00:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785743304; x=1786348104; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=WP7UlNML4eFKaUB/akoYBbWYzA9MjAvgTSFnhPtEPxs=;
        b=oCdbVwOmBt7BmJT1vmJdR83JB8maIhFNXFMsXkvgXuxfUAmIVlr/JC9jQAb1UjVnkL
         7qr8wO4zBGhjZNezQo9oib8Iwexd/QyfminQyg+WW1ktOsJ/wbQI36SY1IvOiX9A07E7
         /2SIRZyWz6x+hwazqIMbK3ggsreGpntLzxUUnnf/jsE9izvekkmuXYM8oLIFra2KnOs+
         4dctW++HIIFMh5015CfBaZzxnHKlU2SSxsGhOpsyfXgUnVsLpLt2138N/QKc3Pg5sfD3
         hBz1tDMWH+heVCsMHFfGusvmBxd4HT28rDZYbsb21EY6Pyj2F5OX1nZtYI2iW/E2n0HM
         gvNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785743304; x=1786348104;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WP7UlNML4eFKaUB/akoYBbWYzA9MjAvgTSFnhPtEPxs=;
        b=pPD3+OP+vOce1yHK9LCTe0Y4kztqj+LZ7PNSP/T9BdqWt06YhrjIKZ8Q/C1xph6rpZ
         iBE0oRmFjKRa00jjF3Ze5kg3zngB0e73wWr04CIOfOWe0pItGPKtx1W03GY78VcFePy1
         j6tIWjixrPjo1Oe0i+NWYjK0prkYuOvjnJZecwiIxJADPz4Bb38S91SpnHMtVnYf0/xe
         G9GjObW3F26i4uSnJ+k0p0XxAhOwOO1eGKwJFMGkGXRC2AuQaXjNwlxPN/YoYwrgReBr
         qZeOsn6UmwxbSKmS+yVRy13m3v4wup1WO4NLVaigsNDSI8GIOSF0cq+BiRxNb44cj8F7
         zgaw==
X-Gm-Message-State: AOJu0Yz10iYAhtxUi/Py+zBB6yJxFwjmXdFqW/GNX1d4+TMq23WWdyjR
	1FDPwcGorSHkuBKusZN3mElVasLxkitPqKvyYI6KwxCluvx/2OFvYcfA
X-Gm-Gg: AR+sD12Ma6qbBJQIVdpVPIJBAhghGW76INkV3jASByIpl1fXL6gJgK1CTkY40w2DKL1
	RRK8tJIzr0hWCoYCNk7qhk0XpzXyvo4T/ZR1+fgPurEjgPQFEudxpp90IQIHNZNNCYUdLhh1EM/
	rME6eSg2EFMngqC0qHWPVkmcplPbetHVqtoCGHD6Sa1yolJjK6t2r0mrPGlXhxaaTpy6hqiNGAV
	vYgH+1iNcs2M+mqWO+eNzAsIxoMTkmk8QC07fXCcNKrKmlnbwjJ10T+fgEpuwSkiitPeBQPKws/
	NfbuXyDkIH8Lpo2s/wa5rYlaOOKICATK/P6YUUWJCZrbY59MSUgl+g0dtXYUylVPqVnQQ9+hA58
	BN4GsQUAFb5nhUtyFAkUbPoMW8G+Z8ak+ZAXCa92YTvG+zGaJs2eFyvIqWkue3+5QdMQa6V70Dh
	lYag5oFgRhShWjWj0ROGDgCcmtGk/qtZ2Rvl37rG8++/14GSeNafjcMIIXUs0ctT7/01fNc+iA3
	HZLoibSI3DUT+2wMiGmw4SkUfNmexO77rHjF32bJPdhfYG2j5Ve2zLkLkK872WhFBf/jyd/vIEL
	YMWX/R6LUtMycW44dE/zeVLJEuQ=
X-Received: by 2002:a05:600c:3e15:b0:495:5dcc:52b4 with SMTP id 5b1f17b1804b1-4980c649cbcmr196808925e9.3.1785743303614;
        Mon, 03 Aug 2026 00:48:23 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4980878dd0asm203855055e9.14.2026.08.03.00.48.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 00:48:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 03 Aug 2026 09:48:22 +0200
Message-Id: <DKF56470QYCP.3SPZ9DJ1AVLOK@gmail.com>
Cc: <bpf@vger.kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
 <andrii@kernel.org>, <eddyz87@gmail.com>, <martin.lau@linux.dev>,
 <davem@davemloft.net>, <greg@kroah.com>
Subject: Re: [PATCH bpf v2 2/2] bpf: Reject untrusted pointers in
 refcount_acquire
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: "Ning Ding" <dingning04@gmail.com>
X-Mailer: aerc 0.21.0
References: <20260726235030.1152542-1-dingning04@gmail.com>
 <20260726235030.1152542-3-dingning04@gmail.com>
 <DKEUKIOKSY28.2XVQVGCKLI40C@gmail.com>
 <CAJP4iuuYfqFChH1P2=3Q6WxHbMTNnAkCagR2k+Lr4W155gCj3A@mail.gmail.com>
 <DKF31NEIMOOB.2CPM6KGVXD73K@gmail.com>
 <CAJP4iuuz0T694PnyZmcq9f9PaQLX2kV+Sd+veQN+uydsvZ=BFA@mail.gmail.com>
 <DKF3XPW4HDQK.FDJMYDLGXZ60@gmail.com>
 <CAJP4iuskVz4RUrXKcnNhcAwMwcNjCP-Pzpc6=HqfWoDpHKWgWA@mail.gmail.com>
 <DKF4LVGKEKE2.2LUROK1TAUGZ0@gmail.com>
 <CAJP4iuvL2=72SUwjHeN7mDLKOSkM-KKvBVYrE40R+rnOJs9P-w@mail.gmail.com>
In-Reply-To: <CAJP4iuvL2=72SUwjHeN7mDLKOSkM-KKvBVYrE40R+rnOJs9P-w@mail.gmail.com>

On Mon Aug 3, 2026 at 9:44 AM CEST, Ning Ding wrote:
>> In addition, I would add a comment saying that the BPF_WRITE case for th=
e
>> type_is_untrusted_ptr_alloc_obj() types was already rejected earlier, so=
 this
>> check only permits reads on them.
>
> Thanks, I=E2=80=99m preparing the respin and will check every
> type_is_ptr_alloc_obj() caller to decide whether it should use the new
> stricter one or stay the same.

Sounds good. I'd still keep type_is_ptr_alloc_obj() as the naming for stric=
ter
one, but auditing all users sounds good. On quick skim I don't think we nee=
d to
relax anything except this case.
