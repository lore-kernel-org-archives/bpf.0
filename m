Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F2A47D95C
	for <bpf@vger.kernel.org>; Thu,  7 May 2026 19:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778181597; cv=pass; b=s2xt0yrM4pfs90qWMGdWHTtULNY2H1UKn1hutBVVhN/FLjVPj4Xe68dU2FJSlAY/anT40OTWVUbD7SmsAoH65J7n2A3lxpAT4s5HikI9c7cS++Gx7Vc08H0X2kbZFPoGtwTm7tXTh9CDi+drnL+KQl/9towTjWDxnnEuc7qg43o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778181597; c=relaxed/simple;
	bh=I5DZUCNXHDpvnJ8tiHxWBxQrtvvS0aWP/FaWpvJs1Mw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=opzyVkBXIh0hTwy09Se8S2wmERxxNZwofsI6gMGKAfNnpqq2/T7Q05TlE2glGHxqekAIW9f5OFLK4RjMKNFf9WxsXQpAZT1p2GF4ZhLZ8kC6093TgUBX1xF5apO705iLG6QoXn2rQTEAaWznjNVQ9e8kTKxgItMBWOuyZ7J1nTw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=GLnNKXiY; arc=pass smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="GLnNKXiY"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-364eef1891dso993352a91.1
        for <bpf@vger.kernel.org>; Thu, 07 May 2026 12:19:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778181595; cv=none;
        d=google.com; s=arc-20240605;
        b=kikUxCJFfj5zvPLS1UET2NgKVHxCFU0r3bV9ImLOrO3doX+Y/uYWYUeRZHRSA2S+on
         TeT02a16ifyssQF+p+ibY+unzpsAborZjPF7Ti/z0D2s2sE1YgXitC1Uhn0WT86AEzgW
         T+bbBBtcTwMZWXQexecCWpiEb95dj/7acnFNxnoYpqI+4Ynufv4oHgyQySAKVvnG6LfK
         0e7vRmvUkSSmIvlA8KsBxRkvDHXwLwtBiUJIigH/RSC+X4LMifwocMTLgUbqN1O1tEda
         r0WSojsi13W4APsPY7U95mOXx3CNmM9LTvOsAqLv4FEQFQ1qCgMuWclWx8eRYYX14r9/
         CLKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lLAJ2nIgwojcJGz7oCLjCvCHgUm4ZxZWAITSlIqPTzE=;
        fh=9bhHeSAw/gVACPbYcY7BSqnu1BGifLBS+eLnI3CxxzQ=;
        b=XcYm7pIpZ9G2lptiUvKsTJ8LpHtJ7Z5FQyc1vRRmCLjwxyK4xFcxiGZTk8Z3DFaDZN
         pu2YT1FMmPfjLkwS1KkpRBHfNqS2RskNmBlIzqJaowA3yxxBepXXr1YM12K2PpdSN/B+
         /lXGDX8DeSdWpvYSoqlZdPb4b9pRAHL5DQ+FivDxhn59YvMhV3kfaxVDdaKQOiBkaN8J
         zqwlcQ5R4U/Tr1fFPexV7nt/+DlTnat1NS7yi1/MJNIFTueDs4Vzxfq6FBYb9XQIKwft
         nkB5vyzf3060DPClsMBEtYc4fnRJs3RZpMYhyerdn+T21myGfjSGF4HQ7GmLm1fy5RZz
         zEFw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1778181595; x=1778786395; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lLAJ2nIgwojcJGz7oCLjCvCHgUm4ZxZWAITSlIqPTzE=;
        b=GLnNKXiYDLm9X4lYJUk02s0b+xtbyxLM6HP4HQx4rvJuLbAOYJILY1cJpj1vNvYPq7
         IsgG3W/RqKyXG988mhDHnBhJKdvLepgkXwL0CiTNMCHdxOFlJqjE0CUq4yheVcwODhYy
         uN/JtKwkvlrtUbHhiMzDk0LHc94wDdqa1JuReUq3eOpJkysLpIO+F4ANHmloLujAkE8X
         T77szf4tb5LSXgz1RHfFaROnD6uMCDwWsDzAJBEXzhhkrDHauI8M2MxkOpBbou+zAAlv
         fC1A0peVt1fHW63vTiXaWyJh8nJ01Czu7BUWbHZRwpnyYQjWoKepZ3tLXLtcSt4vBAs1
         b1yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778181595; x=1778786395;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lLAJ2nIgwojcJGz7oCLjCvCHgUm4ZxZWAITSlIqPTzE=;
        b=K1uTrdpyXgq/Ie+0MGWZ89mL5Nbqqz+ZoXf8rVCmTKusVDiaGsru24xA/ls/IC1Gkb
         U5Kxy6bgBdJEmex+rQGrBp+uo8tQKW7jewD67SLfq9vEvPqxlGoBxJOWi7jzFyruyq6F
         pQ1VsRPROenwOQ/F49+SPI3NaLUVY0NH2HSyKrkHF3fGjOrBVbWm4VmFaJpAflC2W+m/
         jJbauWllhQr/djL6ZEX9zvG5NDA/K5Gyuv74s8nxppBuwHJleEsO0d1MwHeOZXsBBIJe
         3iDPcyTTpCATKV9egCUiHMt3jemppsDQnQqlqWPqh+GzG98K0jNrPfsLYZMDma6AnE9H
         D/LA==
X-Forwarded-Encrypted: i=1; AFNElJ9Z6/Ds8f3h5tl7XsJqimcG17JXuV127bv/J+eslOfRVe/AKe57gIsBuSMCrXTuNVZ3EUw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0nq1hftqg1ksJ+QfIiwa+b6DWxfer1NRc8Tey9OP9e4caob4I
	BUtdn/DUWfIT50CJ+C3ELaW6/3Ngyc1ZoE3kJmul4SF9pqJpgngvGIE4RmT7aJ4fJegEfPTyJtQ
	ZyDSI9Fm5qq843b+8fgtuq1XTwp8b/c/CdSHxOndz
X-Gm-Gg: Acq92OFcQTGrNwyZihwhIXZpR0hntuAQGyvrNDnvbBRy+lis3pRgMYwnBf1M+Ghf4ih
	y1LLvk0vH+H7Wg8iiTYZx3QChgzGkvEZLNBkAdW1WNehr4cNw5wHfoUZruL7U4+gST3sRmTuCgM
	dRWk6j/CoFOnIdWkzL5gHSwM3Oq98dlEY1/YKm/E+9Nhr/UmMcpZt5GZrOIrWDnxr4YyTG4wObN
	CyiNs8Qtquq/5Ows85bZnwj+lIa2wMW1/0nH4Qt/XXfX3cQLzWAHSzV0m3Gb0s/XHMOVzNr5r0h
	v2xLx5s=
X-Received: by 2002:a17:90b:3c8f:b0:35e:5ae3:299d with SMTP id
 98e67ed59e1d1-365abcddd36mr9275143a91.11.1778181595203; Thu, 07 May 2026
 12:19:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260429191431.2345448-1-bboscaccy@linux.microsoft.com>
In-Reply-To: <20260429191431.2345448-1-bboscaccy@linux.microsoft.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 7 May 2026 15:19:43 -0400
X-Gm-Features: AVHnY4K2gE6-_wPdetwQUwodb--l1vbJFrrIitihnjQHsL-gyI1WmZmW-6cI99I
Message-ID: <CAHC9VhScmOoCtoFtccJ6x_cTdwvKCBfUyg=1p-kuAGmo=FdgwA@mail.gmail.com>
Subject: Re: [v6 00/10] Reintroduce Hornet LSM
To: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
Cc: Jonathan Corbet <corbet@lwn.net>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	"Dr. David Alan Gilbert" <linux@treblig.org>, Andrew Morton <akpm@linux-foundation.org>, 
	James.Bottomley@hansenpartnership.com, dhowells@redhat.com, 
	Fan Wu <wufan@kernel.org>, Ryan Foster <foster.ryan.r@gmail.com>, 
	Randy Dunlap <rdunlap@infradead.org>, linux-security-module@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	Song Liu <song@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 29, 2026 at 3:14=E2=80=AFPM Blaise Boscaccy
<bboscaccy@linux.microsoft.com> wrote:
>
> This patch series introduces the next iteration of the Hornet LSM.
> Hornet=E2=80=99s goal is to provide a secure and extensible in-kernel
> signature verification mechanism for eBPF programs.

I see that Fan identified a few issues that need resolution, but I
just wanted to make sure you've read the expectations for a new LSM.
To be clear, I think you've ticked all the boxes, and there is a
MAINTAINERS entry with your name attached, but I just wanted to make
sure you're okay with maintaining Hornet.  I like Hornet, I think it's
a nice and fairly clever solution, but the last thing I need is a new
LSM to maintain :)

https://github.com/LinuxSecurityModule/kernel#new-lsms

--
paul-moore.com
