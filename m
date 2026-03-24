Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2803537C924
	for <bpf@vger.kernel.org>; Tue, 24 Mar 2026 07:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774336213; cv=pass; b=BESFqb+1nFIoj/njImDqBXn5G0SM1x7Jx8+O55JJyJbM2CYKnApYGWtenlYeMhtk07g10g8/onL8EaFXXL1f/MsL5TjkCp5Zg72JV1YXiRkZhqytpoeNla/r5Y3afWDb2XOuhrOHIgnEEPdAcoZQga7RESU5UPrZfaICV+zGPtc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774336213; c=relaxed/simple;
	bh=B7VPMKU8S41YOV0cq+2rJWZqQOczXWbCnxUejuoOI1M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PQbAQ4etXUh1TbX9/ZPbh0plEjfCxz1tlLEPCjRCoeJCs/1XMZH+Dxz+G++XO+sBdy8fuJrDC4CZ0DdTKfJzPf4uRmZkQElW6mnypghTjgbQd2LaUinIeyGFpUrjMgeo+kKuc3fbSOhBezcHmGadQ51ur3+Q0vuWq8Myyv4Uisk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PD/Ej470; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=p7H9mPcX; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PD/Ej470";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="p7H9mPcX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774336202;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j0p7ruypCDdXXfhz5IqiaSpJ0nIoncl+MrV7FY/rAAI=;
	b=PD/Ej470eOb+g84OhCkfHcxaEVAW2ZaWGBRxMZ/6RlQWtlPDUE73LTb2OcLeiY5mcx5x5T
	mVRx4h59t4Cd+8/kGeq4nYb49CPsOOSik5h5yA5LZOaygJiXlduKycoP3wEJOtuXPP6PTw
	XV44ms/XCid68DShZR9v9dgbyfvVFSY=
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-680-kWjnNsZZO4GLDzdp7hqqzQ-1; Tue, 24 Mar 2026 03:10:01 -0400
X-MC-Unique: kWjnNsZZO4GLDzdp7hqqzQ-1
X-Mimecast-MFC-AGG-ID: kWjnNsZZO4GLDzdp7hqqzQ_1774336200
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-2c0e264d802so7208709eec.0
        for <bpf@vger.kernel.org>; Tue, 24 Mar 2026 00:10:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774336200; cv=none;
        d=google.com; s=arc-20240605;
        b=HK2a9JlxSkKftF04VHyKDxLVDxikffnU2+XoWbiFmQehpdMTSyxNc7jHaObCm/mTMS
         dBX5+LZOd08bXBMowrx2K52d/SvR0/Y2qtpRHv0YXL4sTjItTg4MR8wDAMv7S0UpnJJ0
         v2nkgA+zGXLkuPQevNBkVbmsKvdp4aSquCSUH2bMdWMKhypJ2343gTpQUFWWf+rU6vY8
         2HCGUvSo11l3LdAwZY+YRxE+yU6l9Kr2r/RXaL0mGu365Cc9Wfjjp8Pl0U1YjRqtsYDA
         xG+gVEd3K2rqyx00PET9FcXLtw54Dy/WWY2xQTHSjreWj4fJgiMru8KlCHrsxoEQKTjZ
         LXQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=j0p7ruypCDdXXfhz5IqiaSpJ0nIoncl+MrV7FY/rAAI=;
        fh=Gqp0BmUFX+5u5ufOLqUZdZEVPJxTcnqaPmrNh5/CQxI=;
        b=Iqrizkwegwu3/yOL+s0w6Vj/mghRkPnqnCugeryNAL1DYqaIaGk9Qg4QDabj1oO1wG
         pU558IXbfJPBzugpgaIoPKuirt12iY65akiFGZOaqrlzrxTwiEZEfzYRTDv9N9VlfSlf
         21GNGqbnUg8J4gUdZ3kUOFdInynH9wwopGaYhLnlccYHIgfKlLUXQCGNuPP1N8yYdt0S
         he4bN0UcVSrb3XLZhJxsAPFYJGpw9nUrK7BbI4xJ6q+39sJL5CGB/j2FjOU5LA3U8wbD
         UVMJr/VUk6nmqef4AM9iR4oDjRstg3eG+KhJp1aUFYrqX02msklKXgO+6yP9zzXZbZdG
         SuSA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774336200; x=1774941000; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j0p7ruypCDdXXfhz5IqiaSpJ0nIoncl+MrV7FY/rAAI=;
        b=p7H9mPcXEPZwdQ5IuomoLCuFGTcp35DMgfgWm+tPKC/0T1ZvuH38DWRzVjxpAFnIr1
         iAM8y+nJYy/dHSWCMicJ7bOzDlVzT8r0j0345AoYWEunqkMHGTTu9RzvuePLMjHsckw9
         Eru6RXWmbprCdtffpKK3+7DnjFQtqljIbaboJxwaveSqTqtpkr+IaS4oxNumJTzVcxjk
         KEoC23ff+fSasdnLpxLxarRdQZ/ObMnpIPe0z/SrQCqIohpRUJNhHASNe4rFOri1YTSa
         Y0hrch/L8mzkOAJuPTJDr/uqIAE6ffn228GfwxpqpcEPdeLnEfGl/UnG1F877v9jtyAS
         Fopg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774336200; x=1774941000;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=j0p7ruypCDdXXfhz5IqiaSpJ0nIoncl+MrV7FY/rAAI=;
        b=p42k+a8x5KBjDlsOkx/Z4Xs5zV7m+DaSwal7ouoO3QR6oi5HYhwUGwkn6Vifnko6lZ
         poJFaiuJ4kDhM2l6QRk8Ujn4Zz8kDUmsyhI6K9XdnnkPjEdmgkeO1afeXtBqn5uXX+ZD
         sphnJGAR5DDB0hZgi5AIOB03x1QJDm+GgoiP59ZcgbmAvPg8/MZjooAHUISGWPfkPf4C
         x8ZY/SmixwxK3ntNZQDkcR/+G36XF0H4TPwsnqacJwV32KRjFo4t8MAJ5xJ2v3W+IsVk
         1dvt/ubOrEGd0icqagSuYzCsT7QkmjjIJiBxZfXbqVGrO/rdx2p9uy69dn+gh2nkOEEx
         G2Pg==
X-Forwarded-Encrypted: i=1; AJvYcCWpFZn9pQzFOKVEc9i9D2x3fR4Xbet6BQQHeSaQCpkMjD5H/v9ZXc1pTTDKgfVNWaFjnhY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4J9wzqds0xVwISUqxOdaJxtEokwusTywp/GGrOhHrZCwN/g14
	gF7ZDYOyDZt2L7DRLnpVMDzFiPPctDm0fFcMBrXvB06air4mia1bi8FAiGdHm4ll3h6Us/G7Ytp
	KKjPX46EOLAP86YQNepj2VasPPUJqD9uA5qiJGqTJ4KPtaFjAnJ7smd+/tUt7jLJTAat5Jv2M4p
	idOKqnrcmyaDOalEI8gPMw75/x4NS7
X-Gm-Gg: ATEYQzwnIhEelew2vYW0bHLMoAnBBttgQZJysqgLba7CmEDjU+IDhQtBIoajZbszEG+
	JRUbUMFEOFBiF9IJZc+qQLcFP9LUqgJaStwMg5SzKUBWqdBT4y76H7uAdvZZlAoBSiv1bsQaris
	prFmJI4vFakm4F2dqxdvR7NG58zQbltKdCf58nr4iUBxf7D3tFfclJi45xczDoqksgA7rUmXF12
	SGtPCA=
X-Received: by 2002:a05:7300:a145:b0:2be:617:2ddf with SMTP id 5a478bee46e88-2c10970ed0fmr7262385eec.16.1774336199477;
        Tue, 24 Mar 2026 00:09:59 -0700 (PDT)
X-Received: by 2002:a05:7300:a145:b0:2be:617:2ddf with SMTP id
 5a478bee46e88-2c10970ed0fmr7262363eec.16.1774336199034; Tue, 24 Mar 2026
 00:09:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260322014402.8815-1-piliu@redhat.com> <20260323120202.e662110de3ca696086f9e1f9@linux-foundation.org>
In-Reply-To: <20260323120202.e662110de3ca696086f9e1f9@linux-foundation.org>
From: Pingfan Liu <piliu@redhat.com>
Date: Tue, 24 Mar 2026 15:09:48 +0800
X-Gm-Features: AQROBzArO1s8UFiUXdDfYP1zd5xobyzeix-spM303OTU0oAnUprxLEsDtBalr70
Message-ID: <CAF+s44RKERrXWEt+a7c8+bMt5fDbFUfVo109nS2d++sTH_S9fw@mail.gmail.com>
Subject: Re: [PATCHv7 00/13] kexec: Use BPF lskel to enable kexec to load PE
 format boot image
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "David S. Miller" <davem@davemloft.net>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jeremy Linton <jeremy.linton@arm.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Ard Biesheuvel <ardb@kernel.org>, Simon Horman <horms@kernel.org>, Gerd Hoffmann <kraxel@redhat.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, Philipp Rudo <prudo@redhat.com>, Viktor Malik <vmalik@redhat.com>, 
	Jan Hendrik Farr <kernel@jfarr.cc>, Baoquan He <bhe@redhat.com>, Dave Young <dyoung@redhat.com>, 
	kexec@lists.infradead.org, bpf@vger.kernel.org, 
	systemd-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 24, 2026 at 3:02=E2=80=AFAM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Sun, 22 Mar 2026 09:43:49 +0800 Pingfan Liu <piliu@redhat.com> wrote:
>
> > Nowadays, UEFI PE bootable images are becoming increasingly popular
> > among distributions. Currently, we have several kinds of image format
> > parsers in user space (kexec-tools). However, this approach breaks the
> > integrity protection of the images. To address this integrity protectio=
n
> > concern, several approaches have been proposed to resolve this issue,
> > but none of them have been accepted upstream yet.
> >
> > The summary of those approaches:
> >   -1. UEFI service emulator for UEFI stub
> >   -2. PE format parser in kernel
> >   -3. Signing the arm64/boot/Image
> >
> >
> > For the first approach, I tried a purgatory-style emulator [1], but it
> > encounters hardware scaling issues. For the second approach, both
> > zboot-format [2] and UKI-format [3] parsers were rejected due to
> > concerns that variant format parsers would bloat the kernel code.
> > Additionally, for example in arm64, both UKI and zboot format parsers
> > would need to be introduced and chained together to handle image
> > loading. For the third approach, I attempted [4], but since zboot or UK=
I
> > images already have signatures, upstream maintainers dislike the
> > additional signature on the Image. Moreover, for secure boot UKI, this
> > method cannot use signatures to protect the initramfs.
> >
> >
> > *** The approach in this series ***
> >
> > This series introduces an approach that allows image formats to be
> > parsed by BPF programs.
>
> AI review has a ton of questions:
>         https://sashiko.dev/#/patchset/20260322014402.8815-1-piliu@redhat=
.com
>
> Coverage is partial because some patches didn't apply.  Probably some
> of these questions are legitimate, others will be false positives -
> we're still figuring this out.
>

Thank you, I will check them too.

Best Regards,

Pingfan

