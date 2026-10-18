Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87AD5175A79
	for <bpf@vger.kernel.org>; Sun, 18 Oct 2026 15:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792337476; cv=none; b=CwfdJeOXlZyvjTe/GEr/Lnvhg/GuwgIBFYPJYylQhYZAC3raEUo0+VvmYmO3I+2+qJEoUgcpTMWgCpr6mV+jKZ9UlihZHYE+9LeopHHJSvGLuW7JqF002ggmKJZ4viy++YoWWnCIQ2lqjDAaKSc/9DX2A8NK7CgqGe26jGhah2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792337476; c=relaxed/simple;
	bh=PzBI00utEXCdwv3FgCzoWyg7YfkkrwiBeVqnJzeHpRQ=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:MIME-Version; b=VAjdBE28lBv0jVii0TstXutI7WxGX5Im+SrCuPArAEuzgf0E1FWCR7x5o6cdPPBTDYS8ri0SbfuS4/LZk3Vl3J3XqB9ysmj6BHKWjPKbLh4VO184ZMc/sKDMIy9kJlLPNJsSlMRIjLePLTy0X87gmfgTDSRdyXLwYRMT75MEc80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D0L3FcTf; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D0L3FcTf"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2e940d5d2beso4737465ad.0
        for <bpf@vger.kernel.org>; Sun, 18 Oct 2026 08:31:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792337475; x=1792942275; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PzBI00utEXCdwv3FgCzoWyg7YfkkrwiBeVqnJzeHpRQ=;
        b=D0L3FcTf2k//NCBztV6gd0c3dINWeDqzPO5LbAw6TaD4FD6gba5EI57oQIYXTQTgN8
         AwJseldNRGPQJQlsy09SptbI/wE96eHy4Ukdo22oBqu4hqX1AiUDOSghj1tZw3btyIYG
         MtKm6C53HNX0uQbM5xyTzIjAuf5deysTbuHZR59kUSCG0+F6u6yx8g3kTbuTFFyULkJ9
         iSDkIqBWbQ2iCjxtHLNnYKM6M1Fs8HcFhINHSpcMjbpI82z2nofVsJkYCKZ9Sy8TAm3c
         MUJ4wFCFqJizKJnDIIvRCg+44Jp2QWSP61pczilZMKQgZHIuDKmUPIKVOzxr6enA1zS9
         emzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792337475; x=1792942275;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PzBI00utEXCdwv3FgCzoWyg7YfkkrwiBeVqnJzeHpRQ=;
        b=kZMEJ16xCSHNCWCnzd0JOSfGba9COVSvGTW+t/939q1ViD9kaD75L3y5tBA27+68hV
         T4bPelh3FGBV/WYpO1HFlNs1NBrkhO+p9Cfz9UE3s6VF/DQARAWWDVudPYPz/+Cd0UJf
         vaYxRRFfkVnQLN86CsNM0R7ieSZqnNc25NjpOrNnhcYFlY4+IeHWXov9PFrUL6JdrMIl
         i/XLNIr8ubgoNuGpJZJ7uprs/BPHhlaiuyE47LGeevzFyiy0TIDXjgaixlg3Y1c5RkTv
         XJI4sDt7kFTQSlpGdOQcBVCqbz9E//uaF6qtZUy8BBeKKPwWmgtW9O9DZSIcnZX0PDke
         ulqg==
X-Forwarded-Encrypted: i=1; AKwUvBwxyrVxuaMOQy4cMe60jhBrSDH8zik+kJQGtLQRNI1a/2zh0yUJel+VO5AnHKGQVTRk0NQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYLyXSoecNV8bzWbCHHauMW0kRcjYwK1i0It2CmEeGWs7Ogk0FQs
	URCY8NWXXaQJG1IiP3AsyQX6viJD3jeU7vWCl/FudUQv13/EX7AgQm+T
X-Gm-Gg: AYBFou1C+BYSpHVIZwBTafPn4HbP4djBkhYdUwCryI5AlnWdODYKnqrvcTl0tEEG3rN
	opGwgt4Ei3ut/PP+0zO53JtKqEFha/wUxH5IiPDYH8zNGpH/ZZ9vemETh+7FEPrf1r4YzynFLgw
	JHnWlpUkQjR0aNMq2tz59chSUHAmrT481XqU/LV9D/EMhd5LcU9Tav58M/YWY37ziHIMbMXH37k
	oBrILl+MfxcwWOHT5H60BKTvOJAEG4kwWzBhO44U9mYzDliMtiCL+ZIsMf0rdSczacfvVYsl90x
	0JDFjMmJiRkK9Pt41WQZDGnh6P1q7cj/mzNRLQ3vJb/k6UBEjIEq32Yen31A3qpD6zfMgwZvKu/
	EHqKBw1wXV08Zphh3iJLHDo5JWxhPgl8kLdo5Rt6Ju+6rmGC2lWxXC7MhguEJrnWsH2nvRqgv5E
	H9qkWWXEe2TeZ8QeMYXOfU8SlRYhflCAXeqO61U/29CBcScGBj00k7u/CpMQJF1euGPDDfwhwaU
	7qrp72JCX6MRUe6zdiF7zwPaRxTHQJYcoVqLERcQnIisfvPglItHSpaPDviLATdWQglFWLtGf+W
	f58cP/e2Euyv0g==
X-Received: by 2002:a17:903:2347:b0:2e9:5772:9aa5 with SMTP id d9443c01a7336-2e9a69e93dfmr43357165ad.32.1792337474904;
        Sun, 18 Oct 2026 08:31:14 -0700 (PDT)
Received: from localhost ([153.61.198.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e97e804d2dsm30343315ad.17.2026.10.18.08.31.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Oct 2026 08:31:13 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Sun, 18 Oct 2026 15:31:13 +0000
Message-Id: <DM82LW742MNX.XRJ64BXF8A8A@gmail.com>
Cc: <netdev@vger.kernel.org>, <bpf@vger.kernel.org>, <daniel@iogearbox.net>,
 <andrii@kernel.org>, <eddyz87@gmail.com>, <memxor@gmail.com>,
 <josef@toxicpanda.com>, <mason@kernel.org>, <steffen.klassert@secunet.com>,
 <herbert@gondor.apana.org.au>, <kuba@kernel.org>
Subject: Re: [PATCH net] net: free the policies if a socket's clone fails
 late
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: <netdev-bot+sashiko@kernel.org>
In-Reply-To: <179228971515.3135.11305942271655228187@kernel.org>
References: <20261017013912.396296-1-alexei.starovoitov@gmail.com> <179228971515.3135.11305942271655228187@kernel.org>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, Oct 17, 2026 at 07:15 PM netdev-bot+sashiko@kernel.org <netdev-bot+sashiko@kernel.org> wrote:
> [Severity: High]
> Can the same policy leak still happen through the branch just above this,
> when xfrm_sk_clone_policy() itself fails partway?

yeah. It's an old bug, not from this patch. It needs both policies on
the listener and an allocation failure on the second clone.

> Would it be safe to call xfrm_sk_free_policy(newsk) in that sub-case, for
> example in an else branch of the !is_charged check? Alternatively,
> __xfrm_sk_clone_policy() could roll back the already cloned policy on
> partial failure.

Yes.
Somebody would need to send a followup.
