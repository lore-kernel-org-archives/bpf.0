Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795207358;
	b=DY17A3z2Fng4AJFLHq7+NDFv/vuZGPBoXpItRXAINIvWMV1U8LzmtQywGhJSgCHv6fKn
	 LoC8SVJRRSkaphgqGCC15xXLyFfFrGrDaIbWeSJraFeKWQSDE9cJ56765WfvbYx89uZzd
	 AmDsca9iOVGk/WMLGzedW0BdCjs3wyoZz+UZWy2Bv7d4BFTuD4Z4eYcPnfAT3/++OmCDQ
	 8LCI7UcUvo2DC4YKVVt+s8oKILQEEF2ATFOuPvFgv8mltqoFRysm+FKHGZOREBTPiHTUQ
	 Rd/3VhfPfvqBYbCxFW6qsGg3VOmTechizRtt6S/ZNLDG3LjxdIdHkmqUGaKdP7qG5Nw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795207358;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 MIME-Version:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding;
	bh=rtb6dKj5LN/FEVm2jhNPaNf/E5DPE0maWn7m8EHNqa0=;
	b=G9rzgJdK6olGit15itCuHSZ7yY1NrtVh/0f8QQ4W/VcpjHGbIWZahSak3ikCERTXi6wp
	 W4l5M4uufn/z160A5fLjFkjlXh1PKofITsIDq3xDGBm1ThIIeBxvvIMIwNctCycLEbT4H
	 j96Wc8bI6ixhdg+yzcE8sTPzniHQ5PVmck1iA0Try9rBge1e7KpZ5wgE5d5EnMsz4PSqB
	 YqiJwQwKEDGa32ueK9ZROuznowH0sYjJSEhvgM8yY8MEeCKWmvZoA0U+gkVIt9wYIqwRm
	 rBGkW5S4ldW/R4DoT1q6CvwKyGinGmcFLSbIIkmOl3SLt9DTYCmimTRC1YuNdH8xTOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=kernel.org;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.222.177
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 073FE60A2601
	for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 20:42:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 073FE60A2601
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-945e6d9ceeaso121080285a.0
        for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 12:42:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795207356; x=1795812156;
        h=content-transfer-encoding:content-type:references:in-reply-to
         :mime-version:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rtb6dKj5LN/FEVm2jhNPaNf/E5DPE0maWn7m8EHNqa0=;
        b=Y+wp+6KKG5KTOyMfEt6Ww01kkApPwe0JQIwoqY/PM77sKVFlw/q+8HsMtfQtx/uopM
         9rfe66sFcHjKRDdfkVmQSO3nMb6KvzNDXuhveKF1JYF5UFLiT/7ZJJAP5ZE6Tpvp/foQ
         R2eYm0NCSbQbihXZ2sQWxZqirS+VdF3BeIBFbATEvVr6nmZ3qEOVCYfK7z4xx7Xz/N0T
         QD+vY76dPCeich4+xvIh/YUY7+0ApI6LhTEm6LwnlzSpyrLAm46/sv0rh80r9EooRvK/
         c85IU8Sk+BvTLjQ/97eFzMGYIDXhHzv3GKz9zRxyLC6PMwuqp6G40j7g4Nd1cerVnLnO
         KlnA==
X-Gm-Message-State: APuU4Z8sxs1HvgtxyFXi2k6CpUtglOTomVHIXoBzqkeDTniK5uJUebb/
	7P3M8oQgbRaDwWcwQZH3+k3vMAr2Sst6pugyhCk5NkewJ89/GXmZNdP9
X-Gm-Gg: AYBFou360eHcSafVjXkfQaLL+CI8p9RpdhX+wfSZEU0nTIOiFGQT9kzBkIr0uSOOmdv
	JB8WA17XH2y+s56iOBkfIrbjCMNCKEg9jC9jX071iLx4RzIwujaTR9blBqvw6eNlmkjpSs7mDrM
	oF3QF+NktfmherUGrUDdn7wnU0n/fJHBvbvg/Qsj84wsuHaDtyZcQCjulkSBpE55hcTc6qHHzXK
	o/yGgx1KE4oZzSUscdMj6BHLWBe8uj5Ey42PVHfg2yjCM6xibgolqnmnbHUIlVn9MSvYgr2Qkcb
	zs+fmsHF3cHr39BdtbnlVqrHTcXkTyxlhWPdPtNAqgpLp39tru/Usbtwl5WvGBc0RwlUDVeJ9Y2
	6bodYJ+O1fkUcXHgcCCZNDA63ZWG+FWoChJ6u/BvE+IknP+Le/V1sFIY+N5DBiCblf9UQkQ1Qv2
	kqKiDWQSK07YAmatEhR+G/6Knz5UWu8abqjR8EBUOlLoYadeG3505Y7ceW6zIR+Yo8bWOGJ10qW
	batFcG/vjQ/RhSXA+ieKUS6pcbB8/xqw2WN5lGpCvnxQXG9jqac7VGIl9974G+L6FATqTvrjv1m
	x8jao7o1ijSrc+gzzTRF3j3ju9RHutdstf7s2VPeUmwyyZR1r4aP6ivzOjns7VfQIwf1FUYzD7m
	nt9VsByyzk0MSYDqm+EPAg0x0wuU54QGduvVXKtvF7yRyCJIwjn9a
X-Received: by 2002:a05:620a:28d5:b0:949:6ece:8aed with SMTP id af79cd13be357-949ba9aa388mr693527485a.36.1795207355972;
        Fri, 20 Nov 2026 12:42:35 -0800 (PST)
Received: from localhost ([199.170.132.196])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-921349d0e35sm35061626d6.20.2026.11.20.12.42.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 12:42:35 -0800 (PST)
From: Tamir Duberstein <tamird@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
Subject: Re: [PATCH bpf v2 5/8] bpf: ringbuf: Handle pending position wrap
Date: Fri, 20 Nov 2026 17:51:54 -0000
Message-ID: <179519711439.18576.6015951285184464138@kernel.org>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <20260619004559.4E1531F000E9@smtp.kernel.org>
References: <20260618-bpf-ringbuf-fixes-v2-0-33fde039ddf3@kernel.org> <20260618-bpf-ringbuf-fixes-v2-5-33fde039ddf3@kernel.org> <20260619004559.4E1531F000E9@smtp.kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit

> Does the use of max() on wrapping unsigned long counters here lead to
> erroneous available data calculations?

Yes. 3f611e9b820e fixes that ordering issue and is now in the base.

The complete-counter-lap case remains unresolved: taking the minimum of
zero and a positive overwrite distance still yields zero. I have not
reproduced it at runtime; it needs a separate overwrite-counter fix.
