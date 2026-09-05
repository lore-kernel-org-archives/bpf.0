Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09238320CAD
	for <bpf@vger.kernel.org>; Sat,  5 Sep 2026 00:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788569518; cv=none; b=fz71+8QDcDAFEPrvJIZnqg7iC0/Xg7iRxDzdSvx7CDcaLWa87uQXtn+QijnWvAZTMiypOy4TOgjoNBVHFpc+B572mk4EI7Sl0F6yTq9mPEtmWFRyypSHHddsMISjmixstODwGCQC5q4qW39m1AgbStQhkz6sogknCL/EGHmUJCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788569518; c=relaxed/simple;
	bh=HZjH7jZf5d4VMfHLtc2yHsctX2SdnsVgCCmOrdkIkUM=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=p45U9K2LV/XU/L2MK5pdo+NgBodvpqNAJJWrN6KcST1ZBJEvY1Ncshw5RURp6PKE6WMY1PP8UwTwOF0Khhlvkid0mdTM3ww2YvSt80cb4Jb5Mms4IM/jZzmP7pyRSXrqvoDpxWzbgH0IEzPaAJ56AQB0+pz/i8mnoPu8jGPhqWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qa8E74uV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qa8E74uV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9A111F00A3D;
	Sat,  5 Sep 2026 00:51:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788569516;
	bh=HZjH7jZf5d4VMfHLtc2yHsctX2SdnsVgCCmOrdkIkUM=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=Qa8E74uVcA7mml05eZbidg3W7FIdS3GPC/Fm+SHexW/haxwsoV6p8SGOGAFBTyzxk
	 vTuyD91AFZpJUgO9+ocqLYuxhPF4OQHIm9XetPqxJ1xICEGfVcJ2HqMnZve6LZBdok
	 r4h/BCWbWiuo/xPqT4jSNpraEivQS7iBTBr3M119XgZ/sxzJdUT+f4kM+Mw3lolXGQ
	 8qj8qu6XvJi8hqDj36Wbug9ygTVQZ3c083UeHcPJhbMIj9CVOPb/5jJ8t1DHUg9QDH
	 cMVpJwfWyCmEPbt0XBbEETHI+y5ng6WQhvG0scrBZ288r3X4Jf+B+LTSEmY+f3iL1Y
	 eXsQKFKMFDYxg==
Content-Type: multipart/mixed; boundary="===============1235704511795874793=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <af265a7df1a3d5d1cdc5aa9d5a1a35d5bd2a17047200562bfeb4a8a675a4b9f9@mail.kernel.org>
In-Reply-To: <20260904-register-is-null-precise-fixes-v1-5-0f5a360ff15d@gmail.com>
References: <20260904-register-is-null-precise-fixes-v1-5-0f5a360ff15d@gmail.com>
Subject: Re: [PATCH bpf 05/10] bpf: mark a NULL kfunc argument precise
From: bot+bpf-ci@kernel.org
To: eddyz87@gmail.com,bpf@vger.kernel.org,ast@kernel.org,andrii@kernel.org
Cc: daniel@iogearbox.net,martin.lau@linux.dev,kernel-team@fb.com,yonghong.song@linux.dev,eddyz87@gmail.com,memxor@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sat,  5 Sep 2026 00:51:55 +0000 (UTC)

--===============1235704511795874793==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> check_kfunc_arg() allows bpf_register_is_null() for nullable arguments
> w/o marking the underlying scalar register precise. Hence a checkpoint
> created on such a path would prune against arbitrary scalar value.
> Fixes: 3bda08b63670 ("bpf: Allow NULL buffers in bpf_dynptr_slice(_rw)")
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>

Should the Fixes: tag point to commit 1690dcf27c73 instead?

The specific code path being fixed (the if statement with
bpf_register_is_null() and type_may_be_null() that continues without
marking precision) was introduced in commit 1690dcf27c73 ("bpf: Classify
scalar kfunc arguments from BTF"), not in 3bda08b63670. While commit
3bda08b63670 introduced nullable kfunc arguments, the precision marking
bug appears to have been introduced later during the refactoring in
1690dcf27c73.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/33932783420
--===============1235704511795874793==--
