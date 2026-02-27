Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 817A43859CB
	for <bpf@vger.kernel.org>; Fri, 27 Feb 2026 19:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772219423; cv=none; b=ja1Lrj8xg9uI7v4S58mK7FIHyr4zJoPdtONNg8xUaRSeX9zcwZNYF8x+JfXvhLJd3ugq2lEV4uHuueZAzbGKPZu6p5BhRwOPzaKUN8DvxsPStKFAdA7+MmHclk1Xk01JVQWUb1r4RlvLpydu3Mij+RMQa0nBTaXm3nvgTadmgLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772219423; c=relaxed/simple;
	bh=wRsz6sFYCEWGluPn6aUYpGD4Zes6VntrFKWbRAHPmTw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ISGeN/xLLt916/e/c3dybkpxs1fDlZRbiBrgEUO03KBSnzgyard/QW1kz1bJ7ak8CiCW+6jxIDEjxHp3zvVddDd+byDhxOjtZWCv0J0afl8tMKu1InminfxHyLI9SIUiDFruxfE18Q6ZV03wco2NL8Tt/o9GCQwpFBWSqKteneU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b=VUUmes+J; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20230601.gappssmtp.com header.i=@dama-to.20230601.gappssmtp.com header.b="VUUmes+J"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2aad1bb5058so23818205ad.0
        for <bpf@vger.kernel.org>; Fri, 27 Feb 2026 11:10:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20230601.gappssmtp.com; s=20230601; t=1772219422; x=1772824222; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5X43j2DUGdIFSq3q1jZJ01eH8jaKKw5456FRtyKFHSA=;
        b=VUUmes+JdnB8m/B9DbzwHPxu+PKW9jT27j8IHUrKviSvkOnvPLUNFvswy7RiwtUPoj
         zx49BBGV3GYRDmgdYhadpT6DdPRJopqfCaVAmtPU2i4+mLTO1u6nnJIgkNXmLvSMxCe0
         TfYFYW6ZrYvOqckATrwaducMTKkrlPopnn6Hc3xAKmSP0XTBX84Leij2TegqtnBaBKFG
         RZGQQohwhspjEF/FNGRxZo3CtDM8hqjbbl3UVfkgKhP0fGo1/dWeoJP2ftgpFL/mSdGH
         BLF6FV11IX/LsSiNYD1v1VVwiPY5P5TI1gJ3b1h4j/pKc6S4TX+Cq3WWztkKpLUHBxrn
         OvrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772219422; x=1772824222;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5X43j2DUGdIFSq3q1jZJ01eH8jaKKw5456FRtyKFHSA=;
        b=Um7NhB1n4hyywfe0yCAUKhbV5gJAJ9D2qV5ssBMvD1rP5wSp31cePRdmINcPN+BRpf
         C70hKI3E3LfhhS5MdrIBUnwK7TLuA8LXGxKaglcAlqw24b1U80q3MlMglhS5RYPYWu/h
         1CoirksC6VO60B2AMOLebeF/esLbwzlLgqRSQVcAxfIIGZo5k77BbCUXKHb+NcXMeqsP
         0YICI2sgjMXYq7xtfZfxYgrtKMEpJfQDhdaABsD61XfLteJQe9hOzO07Ltu5VvRV8PvE
         u7Voduwr7S6sC/CPuuktY3J4DSc+R8WfZksDK94gog2OU/Lh022uYuQrc2J+opO1ZE4Y
         +wXg==
X-Forwarded-Encrypted: i=1; AJvYcCUdG8cMbfHdgO71VBXZWbITM06N94KszbQowjT5jwjTMJAr5N5ULfhfXfmOp+a9hEnWdW0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8NrGZuWhVHPFF0Zuj4Si3z9Dw5u4nJdAccc72WJ/psVRcv52g
	3/CUnadNg+QbZc9TbDHjv4jKM7bkJqaubMbYJyyQVB/Qcpa/UCtfx6ceiwudxmLKyMM=
X-Gm-Gg: ATEYQzzUFkocwF3LA0VuOl17J18qN0V+A5ngVFBv6PA1Njbd3/MdniELC3lxVxqnqJ3
	0HJS4GKzJ2TPfKDtRIh3cgfcT0pZnaheb6SWSA/JqeVY8iQyq/GY76gZuv5Fh3rM05q8nTD7iZO
	YavT8RE1sxIm/5NHepuzlJxAG3exGtrwB7jB+BdbSul/fl22sx77tkkDM6eQRTpmTTw28Aqmf0s
	WfmMsIleV6d5TS1wSCOgzbeRQjYSXLYeMzdEwFZK0Bzchd6AO4lEigtKRb+opPxK6+AMwB/1D19
	pmrKKIe+hmaz0LFh3b9ohwm8hrC3MYX213TrDLgzQCfusBjy0TvsksVUeAd7J1gJebKtM/Ga71K
	mNdMAGu+JOhAdKu2+utYAMin970AZPv3NCQZ240lzAY+KC5PjNBpQSOfClse8Qk6/X+kXdeC5Tn
	S8jdeBKWC/MwMcaiY=
X-Received: by 2002:a17:902:cf0f:b0:2ad:bd4c:a6 with SMTP id d9443c01a7336-2ae2e4e2373mr39407325ad.49.1772219421803;
        Fri, 27 Feb 2026 11:10:21 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:5b::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb5e1174sm64053165ad.41.2026.02.27.11.10.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 11:10:21 -0800 (PST)
Date: Fri, 27 Feb 2026 11:10:20 -0800
From: Joe Damato <joe@dama.to>
To: Chris J Arges <carges@cloudflare.com>
Cc: michael.chan@broadcom.com, pavan.chebbi@broadcom.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>, kernel-team@cloudflare.com,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH net-next 3/4] selftests: net: move common xdp.py
 functions into lib
Message-ID: <aaHsHJYss1lgxmcg@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Chris J Arges <carges@cloudflare.com>, michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>, kernel-team@cloudflare.com,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org, bpf@vger.kernel.org
References: <cover.1772211065.git.carges@cloudflare.com>
 <632dde7417fc23bbcaf48bdc2e947f2695463e53.1772211065.git.carges@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <632dde7417fc23bbcaf48bdc2e947f2695463e53.1772211065.git.carges@cloudflare.com>

On Fri, Feb 27, 2026 at 11:40:19AM -0600, Chris J Arges wrote:
> This moves a few functions which can be useful to other python programs
> that manipulate XDP programs. This also refactors xdp.py to use the
> refactored functions.
> 
> Signed-off-by: Chris J Arges <carges@cloudflare.com>
> ---
>  .../selftests/drivers/net/lib/py/__init__.py  |  2 +
>  tools/testing/selftests/drivers/net/xdp.py    | 95 +++++--------------
>  .../testing/selftests/net/lib/py/__init__.py  |  2 +
>  tools/testing/selftests/net/lib/py/bpf.py     | 68 +++++++++++++
>  4 files changed, 95 insertions(+), 72 deletions(-)
>  create mode 100644 tools/testing/selftests/net/lib/py/bpf.py

Reviewed-by: Joe Damato <joe@dama.to>
