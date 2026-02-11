Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A6643594A
	for <bpf@vger.kernel.org>; Wed, 11 Feb 2026 15:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770823380; cv=none; b=rl6hmj3m8rHdfTBxNBcFQq6wjLk+Y5wBl16cAuAornUwci+OEwPTtZv6tX1pCbSMKYrw6Xc3JwCY6yeGTlmMLKplj4JsjTHtiVYOfDSmqWKT6wwe478PWHDllEvJBouAE/66bCzFXMAv5o7zWioFraW/1pVkRu1Bxs+dZEWMOjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770823380; c=relaxed/simple;
	bh=oe7zlQrj9Fj4FRzQlB6N0RD3Qljj/+uCn1sYn22xCYU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TemHq6/h57t5rsDGjtnkYNdvaKy+xqwqe1eatsaBPlotjmaCnQlb/c1LRUcr+qjM6kfbUdjzDacm3W17iog5r+vAAJmENBWn10lYCahpzLALhhYxukAE0sQOdjfF7SehPAemzuDPI6RhZO7GLZ7a6scOm/w0fbQuMZbKGyyAQtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=Xpk1bmCJ; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="Xpk1bmCJ"
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7cfd04f1be8so2123630a34.2
        for <bpf@vger.kernel.org>; Wed, 11 Feb 2026 07:22:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1770823377; x=1771428177; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vIdKaU8HmSz8XrXB9v2WoeP7wxPfpURDZ/uABicXGNM=;
        b=Xpk1bmCJ0E71ghJDxcwnkcDYrFnv5mTWknOF+Q/BrsEnoq6WRCIydE3DrLcRnS8A4h
         1dBjH+nVIihIewIKOoHa6Nym+KZSZy3g9SPVxqQl8swZ2kxfM0hLTXVeHN99OqBQbHbc
         njF5jMI5kgpsNf/Lo6oKcjI24SrqiksyJPwNdb4hz+BfUlAvyPEqEtNl6LG5S2qA9e09
         RahyBlxk9k6wo4XQnG7aJKwrra5P+jM/YJ4BcLzY8z3af6eByu966UgutV6Aoh9ime5M
         5WIgZuBDRxopsBbW60zFbl42bAKPi5p2/Ftj3Fb7M/RusYsI3OxZdeGvdHp71gRS+82a
         6Hug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770823377; x=1771428177;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vIdKaU8HmSz8XrXB9v2WoeP7wxPfpURDZ/uABicXGNM=;
        b=vSAdH++oIaE+B9q3Ei/WhI0a6E8lMxGN977zB7F4SVkhoX4v4fjHpGKAGOqDp0+5t4
         9meMAgcb8xGkPGWxaEsAOdIN9MgBp2KJ0pxMg4OpxcXcaPeZbJxwqhuEqjStT8nDaILb
         NwISq+tnshXUYBxVTDb6qBLKpozgZTe8MOwLgwkgYtxIGAioh+FqGPPwoOeFDT9Q3wmi
         9PVfOulbPV+1vfYRz/87pPl89xVeCc6BZ4tKme7DPtQ0moESySFumWUKCqxbUd0T8vZh
         xIJanYUMyu9PMXKbSysWACFkI2vx9yutuNLmUk6FsufkoFF1IymeTkfVmHPEgJGRB7zN
         yLFQ==
X-Gm-Message-State: AOJu0YziNzlwecC2NTnjBTasFmF30A1tZ3zx2GHX2TYpEPClvc7nM5Yl
	+MFGfDgo5mFbQCKlWP54zuhj5FZNm6W3dQchopKoFQEA9O3dHYxeHwmW7k4+XSfKkOQ=
X-Gm-Gg: AZuq6aLXTJZuEZUZim6ocCc37yjHD5p7San+TMx3CsjOpTe4oa6JWfhChaclw02fu2M
	JyiEKyWsnHvbFabS7gN9Zptepk52CumYnGN3U+x3ghfNEwCmmjFaGD2pBK6HQHQ2lyouezyopv9
	Cw/T2g93RmgdbUGn2nDtFSvtxV5sJ/3563LU7GiFPZJ4/yG53VcbdzTMSzw50zOaWLxlSdF0bk2
	QJzobBG2fF8qtIG04oECqprOYCPEBR8JqC8KFfjggxaxc/O4VUmrpJy85DTFDMHrcrxAR7BVrQS
	lWqoaeWuiKddFXYJiFyEQSpn5bhSHyssnFDcQhtrvBH2EWMIbyqbhr9OazO0W9yX70/QjeOJxh2
	w0M524ZK8Wu+/qcfNRGCu8ga5sqeAMOqxeDggpa84XcpDSWuaPCQUQz5ruboDLKX+DojHC0HL8L
	rqz+yjJS/0I8/2ssqtGmgvcYtuXzmJsad9bBgd611fiWz7VWPVsg4Ak82R7igI3e2RNwg4GGhm4
	cAe74AcGDBgORdW8oRs
X-Received: by 2002:a05:6830:82ed:b0:7cf:da7d:6757 with SMTP id 46e09a7af769-7d4a570aaf1mr2133615a34.11.1770823377350;
        Wed, 11 Feb 2026 07:22:57 -0800 (PST)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d4a75309bcsm1448893a34.1.2026.02.11.07.22.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Feb 2026 07:22:55 -0800 (PST)
Message-ID: <cc018c92-1215-4424-8995-4fd5f318c420@kernel.dk>
Date: Wed, 11 Feb 2026 08:22:54 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 5/5] selftests/io_uring: add a bpf io_uring selftest
To: Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org
Cc: bpf@vger.kernel.org, Alexei Starovoitov <alexei.starovoitov@gmail.com>
References: <cover.1770818588.git.asml.silence@gmail.com>
 <52d39c60d06ee9d02ddb04521382045a6b1d543d.1770818588.git.asml.silence@gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <52d39c60d06ee9d02ddb04521382045a6b1d543d.1770818588.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/11/26 7:32 AM, Pavel Begunkov wrote:
> +	if (inflight < max_inflight) {
> +		unsigned to_submit = max_inflight - inflight;
> +
> +		to_submit = t_min(to_submit, reqs_to_run);
> +
> +		for (int i = 0; i < to_submit; i++) {
> +			struct io_uring_sqe *sqe = sqes + i;
> +
> +			sqe = &sqes[sq_hdr->tail & (SQ_ENTRIES - 1)];

Nit: assign sqe and immediately reassign.

-- 
Jens Axboe
