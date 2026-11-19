Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.178
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795067791;
	b=F22bUl9s/pYiDoO8h+VT45i6sxkIp/nhpkuXBTKD84kM2uSLlxQWrcOe6ig72HsJdcmx
	 DHKiLXviescY0700cMNuvrrYKUdrygC09/XLDnmDrEGkrTKO0iJ7/4mrOPL3XUZ4d7/G0
	 +eWfoPSOmVnuTbghEabf/Qs/FSmXRFTVD8yVdjacCPHPwqg7sCp5jOQzvAg8Chg0TdzNY
	 W4fbjkgXMvJCd9CjDSl/eL7riYsUJGgRk4LtKyRiwGM9CyDIMJQYbTWAzoUeNl0xDfiq9
	 Kw0zzqhTs/vau9IURG32AivN7sPRPiDl6Z7BO7KrwRMnDTLLX/+ilHebcyfwM0G80RQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795067791;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type;
	bh=mnZnYd1uErokHW3JZtcuDus+QTj/bsC1tUBcSjVgMow=;
	b=b8fACpRbczScBDw3mkXyPQsXqC/FpDhtW68MMES7NR1mlREYm1RvkAs9ZOJhkB3PJX+I
	 r7SOheW9DT7GfYIES70o6i0uj0VOdlYjLD/AqGLxl4Hr2vXi2D3yz5Gm+e1QE5Myogj5h
	 IY+ryAOCFO3huIdqbqQcHIBlzLHeAdH8rpk6lyo25c5o1ccDVS4E/EOLdi39BbJDUFWag
	 WflKDxkdWJNIVMO5IWjkvJws2Kew/pRcu2db0pLXIKPakqmVYB1o9oafBSFaFl+x1sqIc
	 z53l+0zVUfS/ZJIolE/v5Tyxfp6/LltK/uQ//wXNkZm5Ce75q5hpkOng3dhSEXm5BVQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=csAroUZG;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.178
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C05606A32A
	for <bpf@vger.kernel.org>; Thu, 19 Nov 2026 05:56:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 85C05606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=csAroUZG
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-55b8cd4e2abso19071041cf.1
        for <bpf@vger.kernel.org>; Wed, 18 Nov 2026 21:56:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795067790; cv=none;
        d=google.com; s=arc-20260327;
        b=lcSYg5QN1rhG0TpzdJIGK3AgEpo4+yiPUww5uphnmmBN6+MAGAb+wyZAb9t9IEUMqU
         yWlWX+gf3Q/M652WRtuIEdlVFzUjvqoiiMmx9BS08jpNQHO+XW6Qxy9uHgmvsU++JhN2
         TtwEmysschxLKTUH0YHk1HXBTln1bdtD6Ec+YCOQ4yGYJRJpq8pMMQkieKwl+KoFmHe2
         ewceRzC2y0cj80HjkwHFX/eVYTdNtgjP9xITaOkSTHqGnJi+KLFo9pHyBSm/Qy6oz8td
         viwOON053sCl4vLfZxWpz6UNDma1x7+VF9sBPQZhK1tz8SJkecJpt41uubnpQbatMg7O
         iYtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=mnZnYd1uErokHW3JZtcuDus+QTj/bsC1tUBcSjVgMow=;
        fh=hh64WXw32xDCPRIwo8kqdpPDKtEO7rcNvFi6kTS088k=;
        b=MokhfJ+Fg28G/X7zUNH9q7WPGxMDDUErehM4bl+MS1TwPH/CP/+Ib96/J7uEUZSIVO
         V7DaJS3Tlr2oVhIIQedrf9NYNRbb6FuWnLKqozRPnRHscoxM9Agx+LRRqKvED9PkWNBs
         mI1sSIZaDkZ/NRMh8q0ygAoZ2A+bEZbWp+as/cnI/Mg6f4CPA+zRE2mpJE3AsFbT3jsV
         OY/3+dSbDH7m6lxQQc0w2IJqcFzjtxm/3E5YOkiGxWSFkk/1gOdj+nSIVnaN3Aj+OQxu
         lEImdJzvTAcERRItSTTV5nUimbd7gJrsvxU6a+I/1Mpb7BMJP+QOCl+SfLLKdRNv254r
         B3Fw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795067790; x=1795672590; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mnZnYd1uErokHW3JZtcuDus+QTj/bsC1tUBcSjVgMow=;
        b=csAroUZG8+rlHC33rnWAg/z8yoZZkBbAll+6Ixis9S1JptlfgQBBwGTmzcb91fRStP
         Vdm3WIaPr9xoTswtb5+uwM4/P1UWRPVb3wFMWc2M+gjnJ6JJLY7NElEW0rfI+nJ2Eqts
         45yNiakWcgw6bVFF7uiVYEpTMWcwmYc+je3iitGW2RjKHFnjLffcTDh0VglnVFg98lgr
         w0RZxkKDF/t1nALGN2URHgR2ZWECQuTxRZsFqQwEx7PaVWM8ottmOsktPdz5UTCLLnFQ
         RG/M8b9kJFbHx7OpZEbIUXqw7UXn8S/0g3TgHSxOXdZmFEbd8p4xiCbWHJTitrluQUHO
         Eavw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795067790; x=1795672590;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=mnZnYd1uErokHW3JZtcuDus+QTj/bsC1tUBcSjVgMow=;
        b=j0FHKmqLn4SqGtv8EEj4BPX4jZhhgpTxj3fG1q1HbRyKWDU/NWgshe8VBYfFj34fMd
         JjnKEjT8WsqiEGMv9JpH7Vfs26v0ER/waxFjZjhj3JWRalyy+O3JYwUCdfFAq7tRUJNb
         2H5ETY5IvH1rXcPIJPg3Z4jKCsIi4fuz9u+U8QX+GmX9Ms1oLMQQThwUeFSSlBnbn0S4
         sZbzZBVsTAyyeie/Cfsvhg7qhIm5GGiOY/26xffwBnRTs0F2xwJD8RhTZhrjLfn6Q+fx
         o+FSBUzm6/DI4W0bKQZwgEbS+ATR1qtJQy3fnitajqd82msnJSoRoB49VDWBcMV6hjzt
         zeww==
X-Gm-Message-State: APuU4Z9sQflPIIpN4zJ9ec11wY2Sshhn3a0KywAWWfw4ne52eT35sPcL
	NyZc2K5nN5xY5SsHHaVcn4S/IxDKNCiPCsRRMi8mkdbBDxCwE+urPyuGq2yvDVS2Rrf1K6tpLqM
	yPjYVOHxo5sbddIAlUopIsGHUtcvjBLltBv6Oi4TLHbMp
X-Gm-Gg: AYBFou3h1UmlelCN9x94Api1aHpl/H5pkyDEZz8vD6BqZS6ljj5f2lSyJDRHT6ZQKUl
	LYzMMRjCxOpoa9fKpvBDLjA2h9JQ8B0NxsfyObhDf1HevKUE+E6FHYmVgIn0R1w/bUoHckPOfPR
	UXHuIKZCB+5kmqyaF4Xkn3Fn23OYCjLbnHYKlgLVSxPtnUbj3My5AHRburJic4YakIWlt2GiePX
	1fKK+nmpabFWTYpN4Xu7Rh//O2EOtfrtnRXHvoH9GSvjIodt1JoAKDJ1irfh5MQh2uToQB6/0gu
	0myNaj4K5sJyxw+q4yVSBdZIwUhU3hSP9J/KY8fz4gx0i/2vNUCaQsaK+YzOyd+ajpYANDcfDAP
	DEL+X4bvH4Dl3fyD+dlD4R/37oIofadI3QUciwDvsgeXuJr21TQTgWVI9mhbs6fVTRVXu4vwys9
	/hoArOztRI7k/GRhBIZA==
X-Received: by 2002:a05:622a:4084:b0:55b:f621:e7d2 with SMTP id
 d75a77b69052e-55d5a553982mr82620341cf.15.1795067790316; Wed, 18 Nov 2026
 21:56:30 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: =?UTF-8?B?5qKT5bed5ZKy5aSq?= <inkxiao12@gmail.com>
Date: Thu, 19 Nov 2026 00:56:19 -0500
X-Gm-Features: Aa3M54pTyqXxiigIKRiBsOD1wWBco0xT5X2rnoC-8iFR9mlDCcnWgnsDo6aKIlo
Message-ID: <CAMcAce_TKY0jMqggzwoYgB29OrFZYAi8Qae3Q2ZMVP_qKOAq1A@mail.gmail.com>
Subject: [PATCH 6.6.y] Backport request: beaf0e96b1da ("bpf, lsm: Remove
 inet_conn_established from sleepable hooks", CVE-2026-63865)
To: stable@vger.kernel.org
Cc: bpf@vger.kernel.org, gregkh@linuxfoundation.org, sashal@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Stable Maintainers,

Please consider backporting upstream commit:

  beaf0e96b1da ("bpf, lsm: Remove inet_conn_established from sleepable hooks")

(CVE-2026-63865) to linux-6.6.y.

While v6.12.118 already has this fix, linux-6.6.y (tested on v6.6.162,
kernel/bpf/bpf_lsm.c:309) still retains BTF_ID(func,
bpf_lsm_inet_conn_established)
in sleepable_lsm_hooks. The hook is invoked in TCP established state under
atomic softirq context, leading to sleeping-in-atomic bugs when attached BPF
programs sleep.

The backport is a clean single-line removal of line 309 in kernel/bpf/bpf_lsm.c.

Fixes: 9e1026079c65 ("bpf: Add bpf_lsm_inet_conn_established")
Signed-off-by: BoBppy <inkxiao12@gmail.com>
