Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 466BA3168EE
	for <bpf@vger.kernel.org>; Mon, 17 Aug 2026 04:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786942679; cv=none; b=kOjC+RZuDfhfCJYT62xNe9CP+h9kq8vMKky4hpfOArhSEfchcB0OniTVHTER6BR/CBc+MgsZImYwxrsedDNprBYR0BSSUHbJYNiJtCCSbjDGlad4YEik6R0EnEriG23I7gV71F8Nz4esUbAx9fFGgx+/LmtXi+eU8OlhhKcq81A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786942679; c=relaxed/simple;
	bh=HHPAtRYfGK1Id96a+hj6GLRaAmT8DqfxE3FY6ZzrkIw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xc7ZyrYxYggp9ccis3OfDqemjUBZaqo4KC61thUpAObbh2J8dDErSMqPWZcUY0X4LSSfIx9p5RITyx3fQ1hXTvs72U/uFUt7hF+ZIe6LnbrsXkq0FDk4HaUlHO7ceyhBGgAB6ip7wcDqLmTVcpGFLkbYqea1YcsKirARg8PYsh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LnZ/+/Bp; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LnZ/+/Bp"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3811f512167so4208766a91.3
        for <bpf@vger.kernel.org>; Sun, 16 Aug 2026 21:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786942678; x=1787547478; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HHPAtRYfGK1Id96a+hj6GLRaAmT8DqfxE3FY6ZzrkIw=;
        b=LnZ/+/Bp2HYppTNbEhKyveKDtC9/cmE9V8aMjQzJo1RTp9htiuoEUVYr8MMp2+eBbY
         V/WoeQaEoNeZqycv5tTAbBfHUym9mgGoPOEh7s8HInB1EGHh/30VlF3jtuCI4rBmCfky
         snMUvvybBajLv9mrIC7Oujx51dbgxNVYebqGseaaIGkI7WlneHZluuG5yRLJJ8Bu6Cpm
         VaHwXOMx4MkWEOcuZV2Y0Sy1HChPt5mgRViWTBJNC0T3o2UDlnbmj5uUqqc3/zHeDjSL
         JlEMHOGF7xzOwYMLyf/kLHo/m0cdYQNYJWeWFrbvqsr7zqHgIKRlFD+Vf0AaL9yew27l
         qung==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786942678; x=1787547478;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HHPAtRYfGK1Id96a+hj6GLRaAmT8DqfxE3FY6ZzrkIw=;
        b=Ov58YLAv0T9gHM4ymYg6A2J0AI0Zy8OO0uQuMIT0U+C7BHBlFuZCVFS2VM8Achs1kT
         5CGQIbjRiunbWAVcbx5GFkVzkueL8bO1cImiq75XVinpcoT+zhy2dswdLcdYv2CE484n
         mQ5VjnL2UXtrx1Md0dJCIerAgfLU00zpxHkAJor9Mw4z89sfb8oY3NQa/qTH3FLAiOMF
         ewvpv1SdT5C4cO4vPFo/I9dYHWLyqDBieHEvb6Yv2o4twlX/Tb1KmZOmA6OKHc/qzPMw
         tFeM03jMab9mRTDpNRsjynvt63WfyMhYemOpkPj+5nKYOs9RhyY/My3oO92+HVbxdCEh
         wIbw==
X-Forwarded-Encrypted: i=1; AHgh+RpAct0COsLG17i3QUqvLejHvuL7NYJ3E2VS4nK5J4l/sScf2WqZfVmqRatvCbxyJw0HAk0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3aJqKIM+hVGbD1jsIYpT5TWSNo8MqW5Lyr/EYxmw3KwGSLpYx
	oBYXWl2u0kvhESpfNN3c08r+kTPKfsel/jPWxnueQ+1J5De32EUDalMI
X-Gm-Gg: AR+sD13AD4b4+nz6iTMtkhLyQFMDXd8r2wLIZQioREy9bQLmKQZqzezxQAvr41jVeHc
	3oNolbdhaDAY5fX11sGn4XNJwIYT0OsoJd29S3lO0AkeCmooUo5GC9v3C4dZmH5b2yKwv8BRe1b
	5Pm1mByy1R460xyEdtOnBnQNl4LQsqD8oy0PS3RFRals8gtKNvrl9brnoqgwJmF4zH2Ny8V3GTL
	hkpmRxi6a/lJnYr7w3uvYhNBjlzqrCwGclDeL8NiDvo9nqxyM/iLWdil/X1UyPIGS4YJxb/S4Ki
	36vnECLcpF1YwAkyoyY63s3LoobF9/zb90MCcnAr9tQzcVc8XeXNMmd1lRQ+onw7y7XsagGGbjZ
	rlxBxQ5I6epv47V+PLY7jbxcEI6fJindLEfhlOM2BC221pZzvG3BAaqOSCXgdfeLIi0faiuK1ze
	dyrG1M3hQJal1lM7+KIY+sN6vHzhhGIqlCL6AlBeZDJ/qST0fwbaA=
X-Received: by 2002:a17:90b:384b:b0:37f:e1af:df22 with SMTP id 98e67ed59e1d1-3933ba90e38mr21982899a91.17.1786942677388;
        Sun, 16 Aug 2026 21:57:57 -0700 (PDT)
Received: from hp-zirajs ([14.38.83.62])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3954de0f48esm180939a91.0.2026.08.16.21.57.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Aug 2026 21:57:56 -0700 (PDT)
Date: Mon, 17 Aug 2026 13:57:44 +0900
From: Junseo Lim <zirajs7@gmail.com>
To: bot+bpf-ci@kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev, sdf@fomichev.me, 
	song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, rhkrqnwk98@gmail.com, 
	martin.lau@kernel.org, clm@meta.com, ihor.solodrai@linux.dev
Subject: Re: [PATCH bpf v2 2/2] selftests/bpf: Exercise negative optlen in
 cgroup getsockopt hook
Message-ID: <aoKQ04mN7zzWAqkI@hp-zirajs>
References: <4dbdcda23b2f2be06c5659f8102cd6bd036825b3.1786448307.git.zirajs7@gmail.com>
 <9cafe1dfeab0dfd1249f4881846a10c613e72a09124dadeff1b59765b664d512@mail.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9cafe1dfeab0dfd1249f4881846a10c613e72a09124dadeff1b59765b664d512@mail.kernel.org>

On Tue, Aug 11, 2026 at 03:10:47PM +0000, bot+bpf-ci@kernel.org wrote:
> Is the intent that this test relies on WARN/taint detection or
> panic_on_warn, or is the value of the test primarily as a WARN-only
> reproducer rather than a pass/fail assertion?

Yes, the intent is for this to serve as a reproducer for the WARN rather
than a pass/fail regression test. A clear pass/fail verdict would be
preferable, but that does not seem feasible here since EFAULT is
returned regardless of the patch.

Another option would be to add a KUnit test for the negative optlen
validation, but that seemed excessive for this fix.

