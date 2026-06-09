Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3CF03F482A
	for <bpf@vger.kernel.org>; Tue,  9 Jun 2026 10:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781000981; cv=none; b=qY3oXVR9uVWE32h1k5k4q4Y/Ikl9uOE4OCBmxVIPTdkPMTvY0uqCc0YjhHIjuOhSyoN0T9D+Q1TScCk2LSBpYoNFMhgk1O0mL25Vgo14yOR20KM5GgZPFYHmj/sV41Wciz7iLWtNP1e83S4C/tY29zKapCOZSFxvS20dDx04afI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781000981; c=relaxed/simple;
	bh=9iAoIUno3LT4xNl5MSLr/+kQf+ObYyQ8vLeNQcpmsT8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A95Lz9qdnxNOCYTkCrJl8JzXdmkmkGIdHmTESV0ifXzRjGxJocMDajbui3kyEertX38HNrEsxSxOwEZfl275AVK285uPZ0nVJtm1flewJZJsLmkO3nVsMwsonnTpSnr6yQMDWTn/lC2sNYOygRgT2I0Sx3Z9Hj3U86XF1a47a74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=llxObk0Y; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="llxObk0Y"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2c0b944f6edso55149435ad.2
        for <bpf@vger.kernel.org>; Tue, 09 Jun 2026 03:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781000979; x=1781605779; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9iAoIUno3LT4xNl5MSLr/+kQf+ObYyQ8vLeNQcpmsT8=;
        b=llxObk0Yt/Ms+U0YQtyENHLqY1zXXwCWwHfN64BZTL8VVNn/aokwznVVuJ93cmLdt3
         qS1j5HTauWmRHZUIOIM8wp1Sxyp1aRivvgoQ5R2tA8eorNOcguSkgSNfOnUbDkCNByf5
         WTRxTzTDUdc/Q3/UVMU/QTJ3gi8QTmoOY6stzWRLDMnEUL18cPtNykXsPwx//w782ojN
         6I+XfbS6Fii8jHjdXK3IpZJG+SkTGu76wpnMP2BQnfH6gV2SZUOs6DZcXP/dUBVnLftV
         GlOhwY75m7eB77jGPCZjPQ4oVKumaaB8QuyzNaDBfd+CjsP2vp+osEVbC8/XPS2IfPWK
         sS+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781000979; x=1781605779;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9iAoIUno3LT4xNl5MSLr/+kQf+ObYyQ8vLeNQcpmsT8=;
        b=W/DNPZPoJ9+60KPQl1JErkojknk53Zmok+Mk4SWUIux/jsFb1MSZLCb6xb5Lsg1DXb
         0NZSenM5ehKKGWKMLHo23p9E+pb9j0pLupGKDCHsulh+h+7bC5wLR8YlYBnbgkXlF5Fu
         xa31rhTq5U2sRyXQOyZMxK7uTSzW+WTRK+mVfs0v+4MBiinqeA2RNG+iV52m4Ejv9Ns2
         tjWF+9tncrDMfY6su7IeWdXEqPzL83+8Px6q2sJQOMF/MPSFwYUAdDLvgLGn4m5btiyj
         rK1R6bIldEWuVfY/9uVTylzAvQtBV8b/bNid8IKQSH/o5J4LXvYuc/jg5TQossZzyTZK
         3DFQ==
X-Forwarded-Encrypted: i=1; AFNElJ9srZT+z1zehH+2KTwOIS/6LZ84uUf7xC/EnjuoApwVJ15NAh2l+Y58KowGGoW+fODpCaA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/r7pTIA0QjWUgbXZhAlohlGMqv9eAKokfm2+yrdRDjuzGEcfq
	7BhKmp+V2JMheJvDYTwx3np1Fn7CuwrKIzyBIYUCeVT9RNCYsDRCqMNI
X-Gm-Gg: Acq92OHi28zHUQIupvUTLjEEYHL7ucMkW8K4+3Gh9alJL6LHV3wnPC1lgocRmNPV2jO
	0recQXLe4a817wkybYKyUk5wnV1SEpMXTczU4EjZJh2rVxOGNrXSwUMa6POpB29u47AgvM3xjYM
	cg5jWjWDjBSaNB7k80GTgHHXGJK5Rq5IoTYMDT+f2s/k5685McCTlYtgIiP5nkuVY+S7ev4vx/o
	oqR4/1vd86mDTwGrXsy5FJKALBBY6RCZRQaMq+H4ILt2uJR95uodQFv3/o94YrO+tVK2b/IrAEw
	OZLBAinV8jrrAjd/Mxax9oqgtJqb+dCTWbRgLZH8NeWOUsw6lLm0EuuLfgE1LD9P+HOhyqFppJS
	9y8mioo9Qov9x0pl4aJoRlrfWI2A4DKMRTjFD0puNXkW2yKFfstquzi8qeCrxcgoNGigRgQf8F8
	AQ9z9ClhkXHGokzug+1CwyTPmtIUP7ZYy4ROr4IMhihyd6eAs0OfKMUjiQyrI4m5n0XwBEcclCg
	/e0FXymNlZ2Kxr31WNJQZJ9Ow==
X-Received: by 2002:a17:902:ef0a:b0:2bf:2e28:db28 with SMTP id d9443c01a7336-2c1e8232ec8mr242458615ad.29.1781000979247;
        Tue, 09 Jun 2026 03:29:39 -0700 (PDT)
Received: from secrnd-cstp.tailb7f510.ts.net ([125.131.91.97])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164f85de1sm209070015ad.20.2026.06.09.03.29.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 03:29:38 -0700 (PDT)
From: Sanghyun Park <sanghyun.park.cnu@gmail.com>
To: yonghong.song@linux.dev,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org
Cc: Sanghyun Park <sanghyun.park.cnu@gmail.com>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	puranjay@kernel.org
Subject: Re: [PATCH v2] bpf: Fix use-after-free on mm_struct in bpf_find_vma()
Date: Tue,  9 Jun 2026 19:26:15 +0900
Message-ID: <20260609102618.3508682-2-sanghyun.park.cnu@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <a775c0b8-07f3-4265-8cfd-ec01ffd9efbf@linux.dev>
References: 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello Yonghong,

Thank you for the feedback. You are right on both points.

In v3 I will drop get_task_mm()+mmput() and instead mirror the pattern
from upstream commit d8e27d2d22b6 ("bpf: fix mm lifecycle in open-coded
task_vma iterator"): use spin_trylock(&task->alloc_lock) to read task->mm
and mmget() to pin it, then release the reference with mmput_async(). I
will also reject irqs-disabled contexts and !CONFIG_MMU on the foreign
path, and fix the whitespace damage.

v3 coming shortly.

Sincerely,
Sanghyun
