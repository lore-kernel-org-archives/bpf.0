Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD66C3B19B1
	for <bpf@vger.kernel.org>; Wed, 13 May 2026 18:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778697383; cv=none; b=bS+PPRppL6XUQcoPu0I/2xPjTcHoCsSgS92Y/ZQVgn/E6tnqOe6TKf/yyh/5xTJY+YrjIJGVQlX5qsKvzHOO5UyeZC1hlKrOyPfTtzvDrzfluZgC8EJrFEQopYlCMrbxk+7gYET1ipho/oTH9/gXbUYrsDnXHwGQ0J3R41R/M7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778697383; c=relaxed/simple;
	bh=rM3smG6DhfmKq6u5uT72ezd1TJoaV7KpSoZfNmuAruM=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Subject:
	 References:In-Reply-To; b=W8U7lDjsZ3GkfoAD5vjLcR2bpX5BFjCK8APOG5u1JULS/Lkd/wUTXYV0o639aDH+7YhaYRIXfZ46YkjesyqPAe2dNRZCiQJsjAC0ftv5tZ40Nvi/nO5PtPwBQWK/MEcUF98WAggR2iSxwAF9TzbYiQHFiSK2ju4hyPkc/kO4UHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Gtmd5QBD; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Gtmd5QBD"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-8b59772d441so70439326d6.0
        for <bpf@vger.kernel.org>; Wed, 13 May 2026 11:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1778697380; x=1779302180; darn=vger.kernel.org;
        h=in-reply-to:references:subject:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1aPyCkn8cjAjReTjdDgF7aPv74Q5Bw6zKWh4tDPFGek=;
        b=Gtmd5QBDZ96LdBQrMonh4NM6wrCOPcJkTO6LltdyRy1HT3UTsgLbOfeUUMoTQID8Rl
         /53IUUbkBOqAWGInrqbaislt696O2m70WGctNrWTZocHMbm3MUmiUrwPKfIS1SmfHYnd
         g0UBHSUc4ZHEAFoo601hVezxM/n84ux5WH7wRhYf8fP4AYqietaUNEZxBbc3esBmbhG8
         cTACiCtJhXHHtgBQrHuS7G7WihSb3ltCFGy9i1Gc2KL36/scMcoNJ7hlUWgFybyUMtOk
         RnJgjdhKtxHW7sGxfVog2UjdjDwT2CjElxfBkprAlV+kc/UOgoEZg2JPfAKzp5ExwowF
         z7NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778697380; x=1779302180;
        h=in-reply-to:references:subject:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1aPyCkn8cjAjReTjdDgF7aPv74Q5Bw6zKWh4tDPFGek=;
        b=ELi7rWAiJNJceI5wQxz/UwmfsZGiPaIfVsRh4VMaGqud+X/fq61KmqOuHjyRWQSBnr
         afEVgPXonZW0ThCT+m7ySCVFXYTyoq8VY3ddrNhxvTft5jDeDxHAzgkG5iHK3h0o1CTT
         CUfBluF9iIGRKT/Ei4nR7+ZrJOi3wGYC1nwtJeFbLTSuyQPVYecabAV4CHxzvZt9S4zu
         dTLcjJInicRLiT2a4g7HarFsQs/qm2f+VYbhRCTlDRYjEW1KFbNHNay/rfPwJe5S6k8o
         tlzgkxoxYwgFA4xB9VIVfBXQB+u1jZ0zZZjpc/x9Yw82Unnf1Uw+EGj9J5pqJTCMzLj1
         b0SA==
X-Forwarded-Encrypted: i=1; AFNElJ+lcscuy4RCCiwysMO3Vz79aOIhDRvetsRf8Z/nA4LUGau1/n9e5yDjsizHLpjT+977zmA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkLcTE840bXCGNhBuH1GcdV8henUTMlOSPj5sxUVLn1RgKiLcu
	bZmXihV9nN+40rJYVF8/8BK/Evwoy2kkJhrWynnLd7dF3hwqGP70d8poZLVZ01Hg2w==
X-Gm-Gg: Acq92OHjNnE8ZDBD2rc956FaxAq8vYZgjgd54aO8+VHX21p7eW1RpW6PaQcRf52D1jF
	XFmi0CNzfg3QS/S72poUUhtmsxjDmcXXDHss7TGKywLjIMMFCZD0ztSREXxowWcEaVMAY7N0X3N
	n8QbdHhHoPeIAkLTbEkw/2CJs8pMjZstiSh2/UcSMj4DROqwLFYMbzwOx/LSDsy5cvrWgmUPfBX
	pUOfS+XADfQat9iyozhwW5OyjS5a8yvJ1JGkUuM956OiNtf7QB/1AxDMNLl8kUflYsGo6f0/AEV
	ZUdRY6pAh5vrUpVcQ8BOtVyjT+SPLrD057ZhnuraaTWqsGvm0++3frF5swKBlYOpRgI0BCxr2fQ
	NzivxAMIrDInTvHIKOE4HYdqlE+rD/aa3NNKnllDofL/Sklp9MWIwK9zr+uM+nxmLmxhNLDflvj
	iwohz6EKmQ0xhku9lxI1gwdUYNdGf/yB8QBbADJWK5Luhpz+hmx5zOGKpcObKS6qaAxk4gjnx28
	iEN6dU=
X-Received: by 2002:a05:6214:5781:b0:8ac:b237:9fb5 with SMTP id 6a1803df08f44-8c7bd2d3297mr68869026d6.49.1778697379782;
        Wed, 13 May 2026 11:36:19 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8c908562d3csm3280956d6.4.2026.05.13.11.36.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 11:36:16 -0700 (PDT)
Date: Wed, 13 May 2026 14:36:16 -0400
Message-ID: <5c1eb7f77bb48eae4ace38a5b35d207d@paul-moore.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20260512_1604/pstg-lib:20260513_1343/pstg-pwork:20260512_1604
From: Paul Moore <paul@paul-moore.com>
To: Blaise Boscaccy <bboscaccy@linux.microsoft.com>, "Blaise Boscaccy" <bboscaccy@linux.microsoft.com>, "Jonathan Corbet" <corbet@lwn.net>, "" , "James Morris" <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>, =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>, "Dr. David Alan Gilbert" <linux@treblig.org>, "Andrew Morton" <akpm@linux-foundation.org>, James.Bottomley@HansenPartnership.com, dhowells@redhat.com, "Fan Wu" <wufan@kernel.org>, "Ryan Foster" <foster.ryan.r@gmail.com>, "Randy Dunlap" <rdunlap@infradead.org>, linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, "Song Liu" <song@kernel.org>
Subject: Re: [PATCH v7 7/10] hornet: Introduce gen_sig
References: <20260507191416.2984054-8-bboscaccy@linux.microsoft.com>
In-Reply-To: <20260507191416.2984054-8-bboscaccy@linux.microsoft.com>

On May  7, 2026 Blaise Boscaccy <bboscaccy@linux.microsoft.com> wrote:
> 
> This introduces the gen_sig tool. It creates a pkcs#7 signature of a
> data payload. Additionally it appends a signed attribute containing a
> set of hashes.
> 
> Typical usage is to provide a payload containing the light skeleton
> ebpf syscall program binary and it's associated maps, which can be
> extracted from the auto-generated skeleton header.
> 
> Signed-off-by: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
> ---
>  scripts/Makefile            |   1 +
>  scripts/hornet/Makefile     |   5 +
>  scripts/hornet/gen_sig.c    | 401 ++++++++++++++++++++++++++++++++++++
>  scripts/hornet/write-sig.sh |  27 +++
>  4 files changed, 434 insertions(+)
>  create mode 100644 scripts/hornet/Makefile
>  create mode 100644 scripts/hornet/gen_sig.c
>  create mode 100755 scripts/hornet/write-sig.sh

Merged into lsm/dev, but I did add a .gitignore for scripts/hornet/ and
I fixed up the SPDX tag (it wants C++ style comments).

--
paul-moore.com
