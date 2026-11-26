Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795709936;
	b=XvQ160uVDM8NYHxqP+ObLf7rFbt8rKe8y7PeujV6aGJw8F9yRmHTa7Rc7cQJk1NPNGEd
	 6XgC+3Zs4xvDu1mC4l8nJaXZ01L1slgD3rw9RAXRHCaM4cQWlSjzx9cGOmcaL/29D4kOj
	 xvex1sbY/NOn2MKeHHbl9dkJmC65rUhrmRVVpW5/QvJDaLwkNEunLhSxE3hsU4UAVY0E6
	 S7jYTTSGydLsEkJ795IrIT5UxvymmHmDRxbMVsCmn/NNofNOqss9e9E3h5Fp6LwG3gUpY
	 TExRyzUok3O+taQSmWdDIsY6Qz55iGwIo4YTQ4bc2nKfI+SDxtqsAjNbWJPTHKdRohA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795709936;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-Mailer;
	bh=rtZBeAu55s7ZloA+uxO3vPTR6c/NwsIGOFMs0FGmw6Q=;
	b=UdGEOTRmACC0SGV3oGQUAdsEmgqgCT8/GC3uPIF0pFNVN0bdH1qBsyz4j/6pp0G/opKn
	 CsofWOaPLFwH2QuMY2HUiV4cCOeIixAYZ9BAQ0CINFW5u0zzkudv9fxwVNGn+j6wXZZnU
	 qLaC64wY6OP6aP5nwaTvnXjflB9+AbYptE0V2aSmJ5ryVKwu5U56gOgZKx9s6Wga5z79y
	 WYnA0wY7Tg0PrUcjdUhTPgv6gFYIijcMq80DDRUIDirGV+e8cTuLM4r2YpLcOEZDCBxuG
	 7BfFOGGPUtia9CCdI45rjgHLmXjow25HNXu/B4UX8L4ImJsBYwTJ2csfrvgrdEj2UnA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kernel.dk;
	spf=pass smtp.mailfrom=kernel.dk;
	dkim=pass header.d=kernel.dk header.i=@kernel.dk header.a=rsa-sha256 header.s=google header.b=qxuxe3Q0;
	arc=none smtp.remote-ip=209.85.210.178
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A106606A321
	for <bpf@vger.kernel.org>; Thu, 26 Nov 2026 16:18:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6A106606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.dk header.i=@kernel.dk header.a=rsa-sha256 header.s=google header.b=qxuxe3Q0
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-8a070781f63so3490237b3a.1
        for <bpf@vger.kernel.org>; Thu, 26 Nov 2026 08:18:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel.dk; s=google; t=1795709935; x=1796314735; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rtZBeAu55s7ZloA+uxO3vPTR6c/NwsIGOFMs0FGmw6Q=;
        b=qxuxe3Q0W5XXpl0fUvUZLskvRNe9SG5ofEfHdMDb3+R4KITuQjJ0XYanUY9xQ/nQul
         whJS2fIcQz2/4QwDDjbOMiyf/Q3yGe5H1mwdJ97pnfaykqylS40+DYolz5Qy1dnW0sJi
         +PEFJ1Pn3eHnkxQ53h7U9HJdXzh5OWXqOLTFYiPdQsRw7meUS8BS9NcsDNmvWE13L8X0
         4teNlL6KnWoa33dBm73ssubc6KHK7V3ZH3yHz/z02CFt32uQeV1UBl5WLNer/lFfji8y
         1KDJRNBVQ7IuZgsnHz454wS6PdudLpkTabwc9/A35NwoviY8aht5rBRYJ20Xj5sc0L0f
         KBQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795709935; x=1796314735;
        h=content-transfer-encoding:content-type:mime-version:date:message-id
         :subject:references:in-reply-to:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rtZBeAu55s7ZloA+uxO3vPTR6c/NwsIGOFMs0FGmw6Q=;
        b=K0inFFteYDB5+q8yKzDHwc1fSE+ae4LyN8CUnkqBd/GeqNnfC9Vas5F3fiAdjSTg5B
         CzXA0BKI1k0D1T8pBlfzijYdL2Ofr5iyhw0rsTxH4xz+mvTmmAqgMMqBF4SUXZjVa3EW
         N64SWyAiro7sYb063oS77sSSojRHNseugHpTh0ujyuPcMZ0d4Vk9kGrCBGbJ7M7CxiUS
         4V+aP0ag4rfptS+g2myFQU9N7vC4jp1IKR5/XrCcYJAvGdKPbAb94pqvFfulZuug08TW
         PVF2SqV1DYhKJwbRZOozbKbBl/nceIFf0KAoaz84BY5OoNInOXmTuBnJm5kfvYvU1C3T
         naAQ==
X-Forwarded-Encrypted: i=1; AL+hErGQ7fhRqPimx4DngK0euVpTWB5sY2mVikVebjg7c+Jnxkk7Kq2Myzsy0iSG7IEXGf5xAgQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z+Ok1hTSdpGj6r50C5P9++k07VcYTeo8L5l5TQS0N66ClXcF5Hb
	PGXRCspaGcfBsaaGb4xcAPFgDXmVAQ3u/UiWmKf/vAyVQqpCwEwqWHych6C5M6DZqCtHNIenhnY
	7ihiHWQ4=
X-Gm-Gg: AZFdTZeIZB/hTNtHcxryDr14+6Sy3oG8VP785nL9Noyh9F9/B7zP4fDOqECG61BRlFC
	ofkMu+am1z4gKOVblbe7FoxepFXz6wxixHwRDWM3H+3Nw7HzzPg5QgE0NlV6cDs2FjPv50seP7I
	u1EQmv1kCvYCkMVO1Kye2MaccYUoBZCcVSURnli4cqqCASHzfmhIp3rWNRoaBNyDjuBw7mNfeiz
	c+q0qvxr+jA/KNUR5+mSeW7jfCuH2h93JVr5yMvWafO7yR1auinA8kKmXn1+su5KQga/WfcQhnT
	h+5SaXOncaQFvlWkv9hnGKvTUsGzfLCUBG/iqF3gKrYVfJbRbjfTORn6f6LuCOwkAAMXRvT0cgT
	+hRzYNcUv44W2OLSrIoJW9nusg327LXe7OxVUzsT3/hALPksWPcXE0D1rK0dLXmGoUyeuzoNorP
	7c3/XyXTzh2dXdANA61E7ck1BNP4Xr6AZAVD8EpRp3MXAILBBtbuJqVbDGU8Odrt8CzdiZBLgE1
	fd6p+CATSttbmU9jchTDcqxvhfw096uOT/GFpK44oHgsl9pW+ATNogZKD162REq5Mbp0NXzG26c
	GjCfjgKImtHKQtSgVmB1Yxn2xo+gulD0wf1+h5yHXzgb9tsrazUiC0Z5A8yMeBev4ndxM+NkfDn
	e1Ns1/WumjAkRAvIIFiVirw88OA9V5OLnqZQAyFzPyUPZqKii+uqYGY8s+rADcUaHFJJzYw==
X-Received: by 2002:a05:6a00:1817:b0:8a0:5f63:5521 with SMTP id d2e1a72fcca58-8c8792bef60mr19479396b3a.8.1795709934821;
        Thu, 26 Nov 2026 08:18:54 -0800 (PST)
Received: from [192.168.1.142] ([198.8.77.135])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c87344058bsm10863765b3a.41.2026.11.26.08.18.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 08:18:54 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: asml.silence@gmail.com, Sechang Lim <rhkrqnwk98@gmail.com>
Cc: io-uring@vger.kernel.org, bpf@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20261119115942.3613868-1-rhkrqnwk98@gmail.com>
References: <20261119115942.3613868-1-rhkrqnwk98@gmail.com>
Subject: Re: [PATCH] io_uring/bpf-ops: validate loop_step before
 registration
Message-Id: <179570993387.7152.8807787806232376566.b4-ty@b4>
Date: Thu, 26 Nov 2026 09:18:53 -0700
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Thu, 19 Nov 2026 11:59:29 +0000, Sechang Lim wrote:
> A struct_ops map with only ring_fd set leaves loop_step NULL. The
> struct_ops update path skips a zero program fd, and bpf_ring_ops does
> not validate the completed value. Without BPF_F_LINK, the update then
> calls bpf_io_reg(), where io_install_bpf() triggers a kernel warning
> before returning -EINVAL. With BPF_F_LINK, the warning occurs when the
> link is created.
> 
> [...]

Applied, thanks!

[1/1] io_uring/bpf-ops: validate loop_step before registration
      commit: ba0084f1402bdf2946282290a3fb0af8f3544759

Best regards,
-- 
Jens Axboe



