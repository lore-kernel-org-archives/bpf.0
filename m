Received: from mail-wm2-f11.google.com (mail-wm2-f11.google.com [74.125.225.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 754A636A35A
	for <bpf@vger.kernel.org>; Mon,  6 Jul 2026 19:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783364657; cv=none; b=DU8Jwabo/VGuH+f/GUq8TftsHuqL6s8y9N8eq7Gvb4wWChlLUfbU++0oLbLIYQk2nuDyGdcij7ptfoKc2dnvIFnHJ+lmpUwtn6DvYHkrKMxUb2cJCx9Fia+i6kmka/zhjm8N+bUUONyIZIwkRdcro2Dfawbu0vk+rcTeVhUl0Us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783364657; c=relaxed/simple;
	bh=REGMATiMN1YgapZMWS6YFsRTpoKXFt8/jAMiDLVAKVo=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=TLiM/1kiMTiFXI1hSnpItkWPFMPsC0BWfrJ/7Quxokzt11SHHu32DVkA4zsaW4SWpD1ePJGQ+43e8rzRjWOlL0bXVjaENiHhkfXk/qSCXLfPhhcup7Wg/AzK6mf3/Ejqb9qNWDWnfXrqTzKRo9EK09vrIH+w1rw6EOMM9kAsll0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X/BSUGav; arc=none smtp.client-ip=74.125.225.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X/BSUGav"
Received: by mail-wm2-f11.google.com with SMTP id 5b1f17b1804b1-493d43b6c28so1380675e9.1
        for <bpf@vger.kernel.org>; Mon, 06 Jul 2026 12:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783364654; x=1783969454; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=V2CVMlxLpE8OxL57kzpm7Srk1evLXl+Dk2fXe596u80=;
        b=X/BSUGavkDa4Jha4E2smMN7QzjvhyS8zRVDVEdLi6AyHMzoXB3za5VYRS4mvGwKREx
         PQvF5x6OL6r52n1NOyGaQ/rHCdHH6jDs0vwqkWe59YrUhums7oPsELRdqVcFnafv+RMF
         frUuaDpfm3Wn2j3Wfi3EyOq0P5i7GpyrR/Z5wIQLaABCrFOT699CvpLsYzF0DUL8uJLe
         2nZ29o/DuIVKDfbTX48BD70zOJeIleHNLR1pEX1dZlzwPhGE53jkNzjqJEWGE1i/80Id
         v3v/iocwRcO3Z8JO9Ds55vCrldxq8iQV+8lcKsnSQrAy7Q64LkFr1xPn934pcv8Nhw1I
         HTcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783364654; x=1783969454;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=V2CVMlxLpE8OxL57kzpm7Srk1evLXl+Dk2fXe596u80=;
        b=jm2XKNWNPmhZ8MbjiWZW9nSxTseUFDQgHXrLZ7M36DE71SP8pgUHUugEpE71NR3xIt
         OvpirmLX69KP6Px8+vcsRPSVBtIOFw5Y3ssKa1QyL23+PXDksHF4Uojzg99OGRNf1PO/
         oRWK/DVB8uieFR4rO5PfPhnRvcagXEAZkr1Uan+8bveltTEt+GaPWv3soBHa3aEzDIt4
         sFStSzsNe4zGXfEX6pAr3XCKadK5a/6NRFZjwGc36O9cWn9EMOcc8+MXCaHF2wZkXotI
         GTzaMB6SfABJZ4D0vgwUedWYNZfzfyJKgl6A54giHFA+RTxqNfnOJbkvofUx6cvBUebl
         dV3g==
X-Gm-Message-State: AOJu0YzSvkRnsVYNQVChcKskQshfITXu2idcyhHJtQ2NZM4eLz8sTsQ9
	Oi1M7/zPTKL1ILKx/U4GQ4D5qMpBD9CpCxVUgkXpZxtQUAxw6niLeiL3
X-Gm-Gg: AfdE7cmAOXdEWWCEdRaxDxtp+xSjLld9X/K87JGg5rEY9PLmfVHKvnIJaJW4e11+t9x
	fE62IFXsFLH5pVjLKlgUcU6r3ZbKDOMRyFjkXS5cyUDT+nznxEc9erc0pOOpJ1WOs+W9ELexs9i
	H1dtuMXHkl/gydMQraNHkKHodz6tAgx+du9z+qOgAOlkCFtBVqhriwuGofIboF+GRGprWPZLnHX
	RPGoNPUBAHLXSjyjLLP8mMD1q8oOsEPEobsJ6ul00W0jDToaGJwQYbfh0NJC4FG3YoENRTyDx9O
	tinfxcyFlgtP6JZAtOqJGnIlCXai3d7ERwv7VM25rjOSoCHcsT+D5vASthvhqbs2IEpDvSp2eWF
	9pTgcSQig1s49kf2lgMUrIMEkg6O/JYtzv/mWo2XwpS2CzADGBb/TyTZp5fbD/Ul2ZaOuwjW9qh
	/TN6+8/GRG3r3QVhTlpF5tGoj9nkSIEiuJafAWxRghnwmzN9uM4W8px7e8cucby/a1HSbu8ayEB
	X4HzYxVYvFSPWOrwiIy5C/2s8vLCpeHTCgGNiJLRFVu9TgJf2+DplU=
X-Received: by 2002:a05:600c:4689:b0:490:e19b:bd99 with SMTP id 5b1f17b1804b1-493df088e59mr21289615e9.30.1783364653603;
        Mon, 06 Jul 2026 12:04:13 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493e01f5716sm3882685e9.11.2026.07.06.12.04.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 12:04:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 06 Jul 2026 21:04:12 +0200
Message-Id: <DJRQ0BBKZLBA.8Q8ACS615TZK@gmail.com>
To: <sashiko-reviews@lists.linux.dev>, "Emil Tsalapatis"
 <emil@etsalapatis.com>
Cc: <bpf@vger.kernel.org>
Subject: Re: [PATCH RESEND bpf-next v3 4/6] selftests/bpf: Add arena-based
 bitmap data structure
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
X-Mailer: aerc 0.21.0
References: <20260706181730.21731-1-emil@etsalapatis.com>
 <20260706181730.21731-5-emil@etsalapatis.com>
 <20260706182758.21B901F000E9@smtp.kernel.org>
In-Reply-To: <20260706182758.21B901F000E9@smtp.kernel.org>

On Mon Jul 6, 2026 at 8:27 PM CEST, sashiko-bot wrote:
> Thank you for your contribution! Sashiko AI review found 4 potential issu=
e(s) to consider:
> - [High] Silent failures and falsely reported lock acquisition in bounded=
 atomic bit operations on loop abort.
> - [High] `bmp_empty` and `bmp_subset` return `true` on an aborted loop, d=
efaulting to an unsafe affirmative state.
> - [Medium] Bulk operations unconditionally apply a bitmask to the last wo=
rd even if the processing loop aborts early.
> - [Medium] Missing `READ_ONCE()` or `volatile` cast in `bmp_test_bit` exp=
oses lockless polling loops to compiler hoisting.
> --
>
> commit 634ac04142cf736158c99f577c0f903470937bfc
> Author: Emil Tsalapatis <emil@etsalapatis.com>
> selftests/bpf: Add arena-based bitmap data structure
>
> This patch adds an arena-based word-aligned bitmap data structure. The
> structure is useful as a building block for components like sched-ext
> to represent cpumask structures.
>
>> diff --git a/tools/testing/selftests/bpf/libarena/src/bitmap.bpf.c b/too=
ls/testing/selftests/bpf/libarena/src/bitmap.bpf.c
>> index 0000000000000..80e814401fb9e
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/libarena/src/bitmap.bpf.c
> [ ... ]
>> +__weak
>> +bool bmp_test_bit(u32 bit, struct bitmap __arena *bmp)
>> +{
>> +	return bmp->bits[BIT_WORD(bit)] & BIT_MASK(bit);
>> +}
>
> [Severity: Medium]
> Does this memory access need a READ_ONCE() or a volatile pointer cast?
>
> If this function is used in a lockless concurrent polling loop, could the
> compiler hoist the plain memory read out of the loop and cause an infinit=
e
> spin that misses updates from other CPUs?
>

This one seems worth addressing; I would ignore the rest about can_loop
exhaustion. Please send a follow up fix.

> [...]
