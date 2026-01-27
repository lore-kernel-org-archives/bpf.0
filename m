Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D9A23570C8
	for <bpf@vger.kernel.org>; Tue, 27 Jan 2026 22:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769552486; cv=none; b=bZ509Phmt3DuhzrSjdLFPWUUh0LTeL02kOKcASDsq0fT1+WDDbH/q1ny4/UxGz8I0jPuKy6/wnt6m4ZEOpIvfT/yM/cNwHiRuQIcUvfmb6q61KhSIohncLpMtpXktXtIV4XK2yAWJgqUzIwqPHyh9wlW78ikAmXXKN/WcA6YXPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769552486; c=relaxed/simple;
	bh=0bm1KvZ9RZh+xJqSgyXeAsRJGQKVVQZF2EVdIgQxwkI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Md2zcJsU3HOGnxKBEaLg8ik0GpMVPSTk2pR/0L1Vo8aYIS1hVkwyUg4khNvQnixWxe6AOW81HOetwTEOL+2mUifGxtzefG3CW6qWaO0NWM+Wq9BvquiRiqWKhSWayAfnxEOin+9Lz1R9CvQZ1V6Yq86oPygepvwlR1R0vESr/LA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b=lIsE0a8v; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="lIsE0a8v"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-432d2c96215so5404550f8f.3
        for <bpf@vger.kernel.org>; Tue, 27 Jan 2026 14:21:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769552484; x=1770157284; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=10rIsxSqD2RcmvyIQ1g7gwllyOY4QtznnQ8CJGOxXHQ=;
        b=lIsE0a8vtGfxgWhJd2XCOu0CqTKG292Z6LSsyne/BmKtMXaYiZhyHvqFG+DuQtxvgp
         8Csf31JXsDroMezDJkym0SqWE4C+DD3WXG8AJt5PC082N+egd5CPtazXFUgMLbWZIVov
         Xt7o1cX4nab6/AwGsO08pRs5UXLCB/FJTGo9sbamjZfEHM4GzF8AJzonchjSPv73UBgy
         P6ydSG2T2V80Sz94q2StwQ1uNDHiC3VePWMZh6RlAsSCBhEOBXa6mrGtX9NokyREcqmf
         nEAG+ToR5Hj31CHK1nhDn7buC2nIAA1bngGo1Ic374EI5ShexxaWFy0/6IwlbMKm1AXk
         P6jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769552484; x=1770157284;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=10rIsxSqD2RcmvyIQ1g7gwllyOY4QtznnQ8CJGOxXHQ=;
        b=iE2eTTzuqPWzJFPbUzs1GC2smw0xKQEbBTavjVtVqfxpLeFdm4EECgsIJz+qXqZW5f
         iNLfNLvHgI24rT0Ll4c9lh4nstfjAnLgtuoxGFII5BTDUruoRKcquWg4ra5dqa8nCCZ0
         VcraDZXyLhoZ4zct4jlwu+Jx20HUY5ZTGfOttOrUY62fCfotrJAG3O4l8bgxCXqbG8vr
         AQOoJiBN9cVpJY0WdFZ4eXzipBTI4+/p9iFU89GfZoo3eq66kcsf4HRf5DGkVkNs778W
         Y/+RVBn8zr1ZnqXm0EHRLKhI7sagxmonTbLsQ2yOnJTeJFG628QEP3z2+x/IKtOsF10X
         jTnQ==
X-Forwarded-Encrypted: i=1; AJvYcCUlHjtk+uPFKOvrrqgwgyjGSHNJbwvzx+bGxZSED/GrC6eWS29M6tZ4s8YYzsdndG8BWRo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxb/eIrAD+HX21tisP1d/7zpPwp55otOjB1TH3EdTOJL90NhKJm
	IYINMRTSPKdFFNDzQDKIvgPvnZyfa8CJM23fjBltv0cqsZ4qaB0+mOVJjaBm3qHn5uM=
X-Gm-Gg: AZuq6aIr5XzpBYIiylMU9DKdFieC1lTFjPkYHtdmTc9KSzEAfINrha2oOeNBvBF9zWo
	v20PLmHmefrdURbDBEFb/0MVrrEclpNJ0u7s36j/fFvlk4lcTv8jDgon/RpoYz11w0HqiCqoSBe
	CzIQoUXIu1l3/nn5LQwimoXtdAhap4L6CyBM/bRqZMloMrBPmRvImqAblC4M6TDVD/B2E76zYkQ
	mPdBvK/mo7Byw65pNKMcnmIKOJNt/vb5ZY6kVVl3YC/Atnqdu/rwDBwssMPnSuQugo/IQXWx5QX
	lZ+hp56jrdABC7ApJcmbYVwOw3d3URp0OxEZIxuk/JIeUTgSlnJuCnycohvjG9SKcaMJVFpW5xx
	ImwaBPCXvJfeaxFLrhskDFSFRT7WHh5Jz/0NCW8bwCqShwBHqYU95xLRsXsBfXlkgFCsCsEsLvr
	E47U89EQGZMfaiwOKkvvW9DHl+IJoaD0FJnDl04UMSl11N3Zj4V69p
X-Received: by 2002:a05:6000:22c9:b0:435:bd00:3978 with SMTP id ffacd0b85a97d-435dd1d3268mr4741687f8f.60.1769552483523;
        Tue, 27 Jan 2026 14:21:23 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435e10e483asm1844349f8f.3.2026.01.27.14.21.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jan 2026 14:21:23 -0800 (PST)
Date: Tue, 27 Jan 2026 14:21:13 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Simon Horman <horms@kernel.org>, "illusion.wang"
 <illusion.wang@nebula-matrix.com>, dimon.zhao@nebula-matrix.com,
 alvin.wang@nebula-matrix.com, sam.chen@nebula-matrix.com,
 netdev@vger.kernel.org, andrew+netdev@lunn.ch, corbet@lwn.net,
 linux-doc@vger.kernel.org, lorenzo@kernel.org, pabeni@redhat.com,
 vadim.fedorenko@linux.dev, lukas.bulwahn@redhat.com, hawk@kernel.org,
 ast@kernel.org, bpf@vger.kernel.org, sdf@fomichev.me, daniel@iogearbox.net,
 john.fastabend@gmail.com, edumazet@google.com, open list
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 net-next 00/15] nbl driver for Nebulamatrix NICs
Message-ID: <20260127142113.3309fc99@phoenix.local>
In-Reply-To: <20260127105304.21279cc2@kernel.org>
References: <20260123011804.31263-1-illusion.wang@nebula-matrix.com>
	<aXj-uam1HodC0851@horms.kernel.org>
	<20260127105304.21279cc2@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 27 Jan 2026 10:53:04 -0800
Jakub Kicinski <kuba@kernel.org> wrote:

> On Tue, 27 Jan 2026 18:06:49 +0000 Simon Horman wrote:
> > As per Jakub's advice in his review of v1 [*],
> > Please try to create a minimal driver in the order of ~5kLoC.  
> 
> Perhaps other maintainers will disagree, but for ease of review
> and to avoid the huge reposts perhaps we should consider merging
> something like patches 1 and 3* first, as the initial series.
> And then you can build up the driver from there in reasonable,
> 5kLoC-at-a-time series?
> 
>  * patch 3 currently includes things which do not seem machine
>    generated / like register descriptors like structs added to
>    nbl_def_channel.h and nbl_include.h
> 

Part of the size problem is that the driver has multiple layers:
resources, channels, etc and lots of code that tries to be common
across OS's. This can lead to bloat.  Very few drivers have done
that successfully. 

