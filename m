Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F3633BBAD
	for <bpf@vger.kernel.org>; Thu, 16 Apr 2026 04:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776315016; cv=none; b=EYoEvASvAi1nEFFgrpqT2ihZDjxWZ0aRtQykxmCPiVYADzmsajQzHF3pZjQRfRm8fftTNism3xtmK1njppeXaA2EU9x2WO/3e50BTWsjRxsEWipGPyRQiVRA8/KF0Zmewl1uBfeZRorAhF3KJtO7abeUQkbIuWQJFSx/6AnkIUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776315016; c=relaxed/simple;
	bh=Z25tbuVDAtKPUasQhv8bYTLmQCQUVmMKyXLduvwM1m4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fm9HhQ7klXghihCtn7BtGtNvAvdzilLjFywZrRbYO7tOKjilnWFYke0lE7GqOYZfdROBA7N1aqmuZNP2KfcqCr2g/fpHIlS2bPRnXGtewYQCHqIOtn2MePIE5WyhTEVwV76nqpmPUYmQLWs7HRg2SBqC3BZ/WC3wErazCg4KIO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MsqGd22L; arc=none smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MsqGd22L"
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-128b9b7e3edso6739757c88.0
        for <bpf@vger.kernel.org>; Wed, 15 Apr 2026 21:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776315015; x=1776919815; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=POYBr04RvjL/xRMpDtloZmJ7yANniaqfk1d/StwPN0g=;
        b=MsqGd22LKNFtGqru28WotIci/Am8DS0RyNAYjW4i5Of8KJrVIhu1p4GiW7/1XKIn+4
         4BXaYFqgAFpB3DEBf38xhnQ3r3XpZtqAIE2PptlFFHrS1zU4Csqg+iZUCg4OVM6SBzjd
         LDhzRZZTQLnA1NLZiNQFp+I/dP4sELZWZWLbDPOaiaPQgmCEfXxE5sFXI+3NvQPjcjku
         WqhETWcXR1OLr5lzpZv25477dz3bDkwd0Z1SSDxe9ZtArvNPSyRMoNup+bFhh9XtJhH+
         1waDcyEece3njSBd7fbBFBWIo9GYD/MEtOR5TOKVXH4uQASLVYTcQW1w92JIE9Kkfs0T
         +sLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776315015; x=1776919815;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=POYBr04RvjL/xRMpDtloZmJ7yANniaqfk1d/StwPN0g=;
        b=Gqh1V+oAObHuP9vwf0ZWU6XLGd5jST092WbDgRpYBBLYkTAU58TtOMYaQNhxMK2U7I
         Tifs1rCfdumRmtKAGaCGFfuXDL6g88N0rfQzPQ1EMaoxBSj+DnRRFvqK+zo+9C1pQyHA
         nNq2mB+htvLVjXD26yGRR7PT5mPHSY/BKmDVJ+rWiZGdbLpqBQVTYiBDENNYtTBICpDu
         lTHlna51d2Yv9t/7PRwqtU4MJB4b/DR9MDfRZc3ila2yNRGWQgNSghhWwccCWe5F2OJC
         EJyaVSzRvsi1EerHvunJdeg0ym9BI1deZxM+xrsbD1EQQ+FaGheyfIGirH7M1XaCVN67
         dZ/A==
X-Forwarded-Encrypted: i=1; AFNElJ8fbvV3jx1zxeQT7HoPQbnp+u5ReMl5nDDJU9CBslyVe3R99VUO2NoUEFrlNGtl0ntl6+8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyk/MFuVIjHOgUE7XxlnfzKOXLauvoAvO+Sb/bKlgboa7rZ1mMq
	Eo8opLyUDGIsnSQEMO0Wa2RCctpNO45Xvm2s5vbR1URvT4/9TAlSkByX
X-Gm-Gg: AeBDieuEd7dGxY1aGbD6iJzPy8Ok9QVd5DvdjeEZSXhtcTxbgWBY6QB0ZWRKeSehhNL
	QIfi2A2FiB0pPLgeSfSLi1in+g1MAo0Bu6l54g/w5a2k5sryBRvXqHUdsLmsSfR2nRPn2jxU8ZU
	3625eIDRPraDCX5q2mThrkePZ0uHrWyMem19J3sCFXUoXszcmJcjCrUQAy3jEnx8jkPx7PA1RPg
	hVeObwDaadScdMjihVhUqOaqDZ5mgrWKL0xjfJshc6gqaEzVNFRLCRrTxUvFFrhajrKGEg0kt88
	J0L8fMfcEOpTCu7CY/DAw8MzaNf8qTU2wVFUSquuyMCOc7lc4fEBnm3MNyS3nEMKIBnovGKAr3y
	fcWrbfTjkBLwhicTCg3kGT/v70GS5vwOncRGd/hckKmEqsc5n0c89mjsUbFAv+9fzikkuw8g+4E
	jKVyTHjS+7EdnLZGRviKlUkDutlAUEMW2ckyZWw04RTpH8MZQ1I5nVNFrtYM75AR+W
X-Received: by 2002:a05:7022:618e:b0:12a:7165:7405 with SMTP id a92af1059eb24-12c34e599b0mr14444554c88.8.1776315014714;
        Wed, 15 Apr 2026 21:50:14 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:d5d3:8a61:7d0b:71c9])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12c5e62b9d1sm4651917c88.5.2026.04.15.21.50.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 21:50:13 -0700 (PDT)
Date: Wed, 15 Apr 2026 21:50:10 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: sashiko@lists.linux.dev, bpf@vger.kernel.org
Subject: Re: [PATCH RFC net-next v4 06/14] xsk: support dynamic xmit.more
 control for batch xmit
Message-ID: <aeBp7gJSEIYRfS2K@google.com>
References: <20260415082654.21026-7-kerneljasonxing@gmail.com>
 <20260415093539.4A4BFC19424@smtp.kernel.org>
 <CAL+tcoDUa=MpXSEtweT0LvkBEM2hcYnrjn4FK-ntU3WNMbLEWQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL+tcoDUa=MpXSEtweT0LvkBEM2hcYnrjn4FK-ntU3WNMbLEWQ@mail.gmail.com>

On Thu, Apr 16, 2026 at 11:43:53AM +0800, Jason Xing wrote:
> On Wed, Apr 15, 2026 at 5:35 PM <sashiko-bot@kernel.org> wrote:
> >
> > Sashiko AI review found 1 potential issue(s):
> > - [High] Stalled TX queue due to missing hardware doorbell ring on early loop exit

Does sahshiko bot have reply-to set to "sashiko@lists.linux.dev" by
chance? And can it be changed? I am subscribed here for discussions and
news about sashiko itself, not for replies from all different kernel
subsystems to reviews of their patches...

Thanks.

-- 
Dmitry
