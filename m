Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A18A1BF33
	for <bpf@vger.kernel.org>; Wed,  1 Apr 2026 01:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775007986; cv=pass; b=JgZ61J9hVcEOIBtM+DjPRo6+7xUiqOHBwLHh5gcMgTklzV1Ht28egZBcLQ/gTRRFqEXZvlBeyfPYlIEOjJmCYibrMF4uBLgLgSjO5zNM+wMqNVUDpvukPl0g2M3bEtQZhD1N5TkloGWquEe7fi2mBc5E8gFR7QS3pYtR2NwG19I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775007986; c=relaxed/simple;
	bh=pKG4ca6852OQxsYAnBo+tYEOJiLvVKZae5OfJRVU53A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PHpM8XmgZqXOCDKRNpHXTQEww+obZeLrZQxHT5n5B1DUdEJw2EO2GcMYA3YKW861VfAVP/i6avGIxLt4kiyyCyAtfJJN7VDZCP5R49L7ZFaaRtuV1dO107cotnLq6yeosKIT/GSCSxDDJ3z9GkBfllZVYwoMaBR1X+UvSBJ1znA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UxoqS3bW; arc=pass smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UxoqS3bW"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-79c590026d0so9557327b3.0
        for <bpf@vger.kernel.org>; Tue, 31 Mar 2026 18:46:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775007984; cv=none;
        d=google.com; s=arc-20240605;
        b=B5S1OCi1Bt7xPN02JQDOEZ6ctTBids8bHU+MPv+TOyZnZn29t6x+6eVbahQSSjfktZ
         HctiGr6ECRDcVQJvX4LnoBbwCNniK4+66gLY8pS27oKtFviBnIt+SnwoHMvfS1umodkW
         iJTP0krYpU37FCF89cY79ATCef8Y978ctoxiEXcYKPXfOp9lwZGeAWhdVyQ/jVOcVit2
         h8C5k7W25gA3binkhfe45nnCjKYKDEIJgGYppvR8DPBjDtAtaRUJR+l9jDJeCn95WzD2
         Ih+B7NQmWba6AuKyxWCmQ530CS3zkwLywP6VGL1zrB32ZQ7yQNLdHjf5haC4IR2Idnp/
         +38w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=y4jL4JKUJqxGymiPtbbQvUh4UzMSHg/w7VUEVLrtaY0=;
        fh=jLrlXpAN1N+6I2c7BxDrN4VK5iGiuQSN/y4zidXjizY=;
        b=Pb4pu5LLVqvqME0W2MQbL+tNdwQHDT5edZHXiHRRT6chHSy9aTs5xEyQKca/Wdnv1w
         483IIw2/mXWUBOrP4vsran3wPasTb0MADhCrORtRQGACHpSAPELS2sHu7PLXkG3bAT1i
         fPoNYifXA/mHTXKJ1vkxPqxer5GVUJ3E+VBj4WRwSczJtoj7CWSiIRs1y+wRfszEiEiR
         5CQZC2h/y7Qav7zJDDSk6EI6ZtylCKza090SMvP+RJroR8BRBo/Rs8muHCIg6WK0cHwo
         u/5wSykvqO/gCVn7YJFO2iGVQHmTkA+fFGMjhU0Giqvu9xoLQepnBwFLsKP1oLdOcXsr
         wT0w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775007984; x=1775612784; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y4jL4JKUJqxGymiPtbbQvUh4UzMSHg/w7VUEVLrtaY0=;
        b=UxoqS3bWb3sgX8EKXa+n1j2RJObCXLPoHQ9SzMFyF8Z5dc5+DThl99hRiIVJVE7/xT
         NHT9Iy+D2DrPUCHDt/FDr8mUZcHm0b2WE57wC1rII0Yi8aUN35s3+IlM39kY4maHogAA
         wQwsT2bs4XlZ3Q7NgjUk0jACp9lC3U8xqQvrxn/p7d1T3VC8OFjPk6xQXn/KoTRvU27W
         UkIXxNyR/aN4llXjNkEw6mRLLG57s9MMKu+khRLjzA/nsx3Lr+fur2kTuxptqrut3OrO
         RSZauX27MYf/cMf2HF9+xeVlFEBAsJy40H2gadE0r/0410t451SSDNOsS84Yb+AeebcN
         lAuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775007984; x=1775612784;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=y4jL4JKUJqxGymiPtbbQvUh4UzMSHg/w7VUEVLrtaY0=;
        b=DgJV3jw93mZ8DfF7PkjEzS+RmOMv2HjDqCAnnm4sfbTG670xsuAt7yCoB8vkcii3Cl
         h8PC8YT2PnuP9/e8jKqqDrfAWpIAbAncOxNXfK3RzJXgeGCupo88L2h7szIEvpSmtx3o
         XsElAiRrDPdcsFk+tIpSqOpEpyLQioMRbxnDzIMWbe0rk2mj/p0zRsORyPKqRfucvDR6
         RYJ99piBiPC/BuFT7FGtaolMsvF8wzHIGHNtbF7DeJh2eSSkaDHwFgsSBF8KvNSInF/D
         WNfZ/RC3K/BAVoXYkUeIinTyYJCBUfHi3lkY41Glx4KU6ZxCEnvoCYNC3B0RxygdziUV
         2n5g==
X-Gm-Message-State: AOJu0YwBgPPA6+NKHm0x2eAvnAvK9feKH8BlFgE2Dg6z/v6dTNCTy+g+
	mX/OhGGGbNvoE5UScBmntD+gyY35a38zbxPAjTlGVLZQbdludv+uLcuvaTTUE5g8jlm+lUOEDAU
	764BbsIezWEz6FTYMsig/8i7U9hdQZZY=
X-Gm-Gg: ATEYQzypBBpD57+anVNLSwWALQ0XXi1SUYg5WlQHfqhkas0Xtr5qdwp+1ZkYVabL/kA
	ZhxXka5hm/BrRe4C9qDzzO3NHxc8nJgtWEi2x0eRO8asX2DSf9sl9pwtxhslNIkq+V0mp4tzfaw
	1b9/32NXYCWbfh1xULYCPsPfHtHORcQYwVHSrnZlkFy0BGFfQxnx8aSq+o8MISneJIE5SZBaZK2
	33sMcOXHVzbZL0uhgaPqQ9xzEu0D6mgnxNrlR3h2i4Gwbnj/bQ8Zw76khFG06L2tTwetE1PsO+r
	k36b+rttgtPx9vLfN89+cJQu825PctnUI6LurZJVi0EzU4YhwJJZfOg0gY3jTg==
X-Received: by 2002:a05:690c:c504:b0:79e:8299:7522 with SMTP id
 00721157ae682-7a20ffcaaabmr21048467b3.17.1775007984189; Tue, 31 Mar 2026
 18:46:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260331213555.1993883-1-ameryhung@gmail.com> <20260331213555.1993883-3-ameryhung@gmail.com>
In-Reply-To: <20260331213555.1993883-3-ameryhung@gmail.com>
From: sun jian <sun.jian.kdev@gmail.com>
Date: Wed, 1 Apr 2026 09:46:12 +0800
X-Gm-Features: AQROBzChgloXjDFFT-ThI6KE73CKM70nCeotiyMd_wEnhOoSTSbyBhNsfhorydE
Message-ID: <CABFUUZHYzJgaVvH71WvqU3HUakAOyTHb+HqRFZsTH9Z4=OYAcA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 2/5] selftests/bpf: Simplify task_local_data
 memory allocation
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, alexei.starovoitov@gmail.com, andrii@kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, memxor@gmail.com, yatsenko@meta.com, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 1, 2026 at 5:41=E2=80=AFAM Amery Hung <ameryhung@gmail.com> wro=
te:
>
> Simplify data allocation by always using aligned_alloc() and passing
> size_pot, size rounded up to the closest power of two to alignment.
>
> Currently, aligned_alloc(page_size, size) is only intended to be used
> with memory allocators that can fulfill the request without rounding
> size up to page_size to conserve memory. This is enabled by defining
> TLD_DATA_USE_ALIGNED_ALLOC. The reason to align to page_size is due to
> the limitation of UPTR where only a page can be pinned to the kernel.
> Otherwise, malloc(size * 2) is used to allocate memory for data.
>
> However, we don't need to call aligned_alloc(page_size, size) to get
> a contiguous memory of size bytes within a page. aligned_alloc(size_pot,
> ...) will also do the trick. Therefore, just use aligned_alloc(size_pot,
> ...) universally.
>
> As for the size argument, create a new option,
> TLD_DONT_ROUND_UP_DATA_SIZE, to specify not rounding up the size.

The default path looks right to me.

I'd suggest dropping  TLD_DONT_ROUND_UP_DATA_SIZE, since it seems to
rely on allocator-specific, non-portable aligned_alloc() behavior.

Sun Jian
