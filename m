Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.170
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795088156;
	b=Xfaqd3UTZZudG7/8FXr252VuX28VptlAEHU9GmsZq4v+Rrg1Dg8xcj+qWauu6ldPcMg3
	 yyEnDsBBPjQhQbhNzL0xu3Sf0n3qCwLELMmL66NzEikLQ6IytopkdkGv+06d2H9TX+L5b
	 5+q/11SYog80IzYoTaEM7ZZHyNRfh/6kQQoOXpQxNL0tsGmfSJ7RftKfosytIh+xVcWj8
	 vMOPCHIRomY6Ghr33Zhokh9TzwLHVfJ1EutSboeV19WPFl1KuK8tbfIisNzRrYKd/JqXv
	 SyckluwP+6cBwV8c+zyCiAt4y2POOFSHcQ2CJMRxC37O1vRhNrMHLsZ4puGRKcPDMpw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795088156;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=m7U6M/EGmEZmxU1yvdQ7vVBYlQ+ST0xMHMaAKZhcHEc=;
	b=tU2hsxY8MVNNx1dq7oC6WKljC8N12SubGaJZOjNNP2tGwJ4IRNN7kcG1rsb/ngU8bdMN
	 EmwlwU57yH2l2Y3FPceZUcSiD/NgM9ELOcxtqTQTeQWqqIHT5KJBVcUntei+uCXSFU2qr
	 BnEeVZFxZ1BbUwc27gaKzEpGftADANtfhVOzlIVEAFhiXSwEH8ksyNd/XybZEsitZNPTO
	 TapJl1RvAHhLP/twNhv84nPp38Nwxo3h1u6GtQuGNo9Iz0XgXhKqNHajnrCIId25WHJr+
	 lXFZkiCmZwtkTi8SOBn9Qxk1ijctnIQRY3ZSgAjeXSelRntMgYMgFVnPMlEJT8TVkDA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=sentinelone.com;
	spf=pass smtp.mailfrom=sentinelone.com;
	dkim=pass header.d=sentinelone.com header.i=@sentinelone.com header.a=rsa-sha256 header.s=google header.b=QcPl93oW;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.170
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10721606A32F
	for <bpf@vger.kernel.org>; Thu, 19 Nov 2026 11:35:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 10721606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sentinelone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sentinelone.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sentinelone.com header.i=@sentinelone.com header.a=rsa-sha256 header.s=google header.b=QcPl93oW
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-8b77e464208so245455b3a.2
        for <bpf@vger.kernel.org>; Thu, 19 Nov 2026 03:35:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795088155; cv=none;
        d=google.com; s=arc-20260327;
        b=iAMJYKf3y3j1taGW/wZvk2rre4X1FrLGeTIwmGrKigVcqoZOIu0a4a0VPuQj1HOGOp
         hdEvKGRrfjeeinfMIGRFj/6/sdPt2JUGj3Xj0PZntF2MmfWQ641P4Dv9kFepsOewWJWc
         lMgpNmMyPZIQtOnrEvckQ+MXSLP2dB73eGlSr3ICUwop+tig6lU7QCSxBDQNZmiHTd6U
         8sR7dc4Yk5RSyWI2SJr2W6vqHNifUq13m/16ZyN15PqeNGKmoow8AcOX9bVqqX8uts+y
         sBA81EGOWM6tunnIqnJgzTouEKMgtmZN5df3AQ7obgpu6Xm+o4cRHXPUz4vuNY+YYtMe
         xbTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=m7U6M/EGmEZmxU1yvdQ7vVBYlQ+ST0xMHMaAKZhcHEc=;
        fh=SP9MQuLGLKwYAkAMPXZZy/g7jD0jDxqmFswXJ38n1oQ=;
        b=Q/AVXExG6HNrKFeXcbEbC9lIsHiFWlNL9spDGtY0VeN5GM67N4t35VR778HELwiDLY
         8vIc+LWARwklPgLYG52tEMa/Xfrd2Ezh4A1d/RDvDj6tvBy1CXliBO9SpNCqKHqT1xG4
         cBczTPzzI0z2jlVaWjN0xHgprB/gauHaE1EESR1Haz757yBWLZYJ3XaiAOUBJrpLD5WJ
         oyHYKmoEItOcqRtmKRloIQBdrzusDAUEU0dfIKifSpXTaI312Phoph97WEv0zk5MjpRM
         rGDZmfBIFlcLrCvFg3UPTnTq0I4dtVbjA0pmOVXT1wrCm+QHbsv9jChC3Fno1mHBstQd
         Nw3w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sentinelone.com; s=google; t=1795088155; x=1795692955; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=m7U6M/EGmEZmxU1yvdQ7vVBYlQ+ST0xMHMaAKZhcHEc=;
        b=QcPl93oWLhCfA6leBBUG94g8wJ2Az2pfkebXkNqWqxr2f/4hbVCjDTxj4Wsgb4iD0r
         nGkRNlVXyaMag+N4sHAeLhHr4fFYUg51fIfhQLYNgG9/GzgqFiZ/4fjhrEe09ii5oSWk
         t8jvmiKoPyt6+LI7wNnxBX1bCvgbLK6ZjrZQ8f04aTDbIsVzjFvDiJfWdqNiN7iZqfVZ
         Z0SX1IEAeCCU8Nlb7V0FyKQBiCaDad+dj9zl3js/OW3CO7QzEZkdeWlSdf6r+naAIr/A
         FCCOZPjt4r6600Vq04BoxThCNOBtD+fxBkHJ75npg5p3lqF+E5+ObmkVKmoawWEJNj0V
         BfKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795088155; x=1795692955;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=m7U6M/EGmEZmxU1yvdQ7vVBYlQ+ST0xMHMaAKZhcHEc=;
        b=xE2/yAwAPca/2tInHiJObo5zavWezPomzRTKZw9s2Rl6VOpHAMS7d3M/abEhNt2CjW
         P0X6NKbc7fQZZ7iOgtIXUxs9HVR+YU9tBTTMafu0P3EDAK9M/p/seooPZVHQQfMkUh5V
         6tRi9IQBZrzno/SUaaaDRDFud4PBRtUtGJ4eh2GhwAiSYSfaqjHxxLuyr7KKZ1Myb2bC
         ynTOpuh/4i7nDuFC9dIzydpLmZanXlIKFn/OJASutdSvz86zt0CRTwE4JO7uCdf6Ua/U
         9Z3EEle4/pKBBESEXEDfqkgys5Q/0xLBjXrUeEn6ikedupcbwYVqZMnlja/M3Nk1Jlq1
         mhHg==
X-Gm-Message-State: APuU4Z/8GW1nY74cL97VSkG0y7bitr7pQ8CNDPWdPpv6xcKkNZE9BSXQ
	W5AJi47fQF1TeZ+o5PNu9ki4e1nP7Zn6hd+fksy9J0rxFe8mdd5jW5zAcJT/2B2QqfPMiZsGm/r
	31ZfOb1H/58VpFaE1rhIRYfBeD4h8mfhixAOZ5T3wEg==
X-Gm-Gg: AZFdTZdmbAu+lGhe9hBhFoH1riuDem3XRkc0K2BTi2tURIRT+8oMRCwMvMnssK5GTkz
	0RDQrxICfRJguR5U74q36V0kptZDSjlZ9QRJlAcbuK8eIgiBaXcCLJygEIuHPLap8kWYdS2kogx
	2m4EpPwttJLATHSslKKsRz9q6EtCmc5Fh955W3liYMTZ4Hb/5ukaZ0fYDY1Hqut/CshkP3GK1U1
	jVcCZJDg00wITS/VUKzvU/PbWYaOcfaKabnN5D7MwOr8OddGAJxLhLpRlrM860bNpByy63XjLue
	bPracefNQeF8dRTn0ncUUBjgTWFr50O8UMt6TmWvCfhf+Phu+6ycZSZ9xBGMOdJXHgrfNQWE0/K
	ZYuD2abD79fBfBet6K/H5CalZKOj8st6dB3FnaGaIG39B3LfqmCbVl/Y=
X-Received: by 2002:a17:902:e888:b0:2ed:29a5:782d with SMTP id
 d9443c01a7336-2eff72e15f0mr91673755ad.2.1795088155325; Thu, 19 Nov 2026
 03:35:55 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261117-bpf-preempt-v2-r2-v3-0-586376ec3672@sentinelone.com>
 <20261117-bpf-preempt-v2-r2-v3-3-586376ec3672@sentinelone.com> <8fa7eb35-950f-49c4-b60a-c00b52cc6e4d@linux.dev>
In-Reply-To: <8fa7eb35-950f-49c4-b60a-c00b52cc6e4d@linux.dev>
From: Mike Bazov <mikeba@sentinelone.com>
Date: Thu, 19 Nov 2026 13:35:56 +0200
X-Gm-Features: AclHuK_P4lCX2n9SuYxSAwroQnE6rqvhil-JFhCxhFnQsc1M0KgmmeelNAQBEi4
Message-ID: <CAPnbwjpaTwDH1GqV0Mxtc6VOL7feWTBrQwaMD5bzq1kzDmE3vQ@mail.gmail.com>
Subject: Re: [EXT.MSG] Re: [PATCH bpf-next v3 3/4] bpf: Check program
 recursion per task via bpf_ctx
To: "JP Kobryn (CrowdStrike)" <jp.kobryn@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Emil Tsalapatis <emil@etsalapatis.com>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Martin Kelly <martin.kelly@crowdstrike.com>, 
	Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>, tyler.wilson@crowdstrike.com
Content-Type: text/plain; charset="UTF-8"

> Was a limit on chain length considered?

My proposal in the v1 thread had a cap of 8. If it turns out to be
needed, I can add one.

> did you try the array-based approach mentioned and compare perf?

Not measured. I asked in the v2 thread whether it is worth doing.
I can measure an array against it and post the numbers.
