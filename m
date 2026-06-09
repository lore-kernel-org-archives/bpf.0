Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB33A26CE32
	for <bpf@vger.kernel.org>; Tue,  9 Jun 2026 02:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780971838; cv=none; b=iSTd3T+4TdCxgNsP2I1g97f0HU3bUdWqunnTXHugKFzjQqMTI6ejjQSmzhthexlojjCiVDsg1ozyPXas33hIiS1KO2nEuhd3tngJL5PnuL8xVToJVjosqlQGzIXmgr8I6ZCGU1StMd0AnPUvd3p0ojB5Bpej1NKTQ+9dgJK0Xf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780971838; c=relaxed/simple;
	bh=4Kh4Cfp3zAFu7AFZE668kBJQF++pR2uYHFcVCJuZIkY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uRUuUDxUU5sX3s/TYUa6TWArPsC8hKxQINzIh+BSiCrnXfI9uURKfMJGPiy35Hf3T3f/SRDde0c4gv7UJvr/oyPpQ/Ksz66YnGRfq6wSnHra+Pi+Vf87pdATCXfQisHEZrj5koHXvcjA43hv7tsRQaC/zsw4zLB/PY+T9IVETDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l225m7mF; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l225m7mF"
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-304e83724bfso6047996eec.0
        for <bpf@vger.kernel.org>; Mon, 08 Jun 2026 19:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780971836; x=1781576636; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DAR6Vz6+zacpmaDX06JjKNC9VzrSzhj5Igmbq9ULD8c=;
        b=l225m7mFM9GUbH7ZXuykpdophk+cjuJ2Mbxk+n1/j+/HL+0nIBpOCvhHdXOMd5vSp9
         b5JMAzgyQBxC5D5tQ2cwrA/p8k0fN6p/Fb+HtkGhElUuKEj6sqi/AwLAFHZFZWysivwl
         0fQ6Jwb+JHdIWjC39nsSqGRp+ttzoBM1HAmSaJzd9A/Nkxz9pjQAz9bmW7cQUe8g7sh5
         2rXE+qZeQtBZDPCwygfOSJ/smB1Shibfo9f/3CZhKjIJLtaHDzLa0OJrbEcTSr5pqbAl
         71aiGR+b4j7gPhULWi4zrpVOJ2JUV2d09vOFfr3DwV2kj9ZyHMD4h99RYY6P/NDsKpR5
         hsJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780971836; x=1781576636;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DAR6Vz6+zacpmaDX06JjKNC9VzrSzhj5Igmbq9ULD8c=;
        b=JyIx38GFS4qakSxYPUT364MhC4rFbEWeSPaWZmULtyOHwcMK0iOoKa71OahRn5g8fe
         DDwf2oBaXbUjRCBitAoB6CM/LD5cCHFOYb/BCJvNmmhcXZM313idc839MHWP/E7n5E6P
         VKVc9coU5t9rUJwSRlYcnP0wgyFM+eWyflG6ZA5HmrCpJJRLNasmtMjr707dMyEo+GK0
         XiY/ZZaytFuuHQFa3XjMwlqgjS2ZB/xl5hRq8+mV1CLWCN1+T7Piyad/iucejmV5/6ck
         0QbkIKwAyAFiWfxF4Y/71KcQTu3SWrvszMBDNzxzijre3kmZJQvqQ2L2WsmmKeB4xey2
         wTog==
X-Forwarded-Encrypted: i=1; AFNElJ9RapQ8eGFze+v82T+r5V0G4mpnVK1BPkmbJ2crgw3Jwe93Q3QYJ7yBUp/r5ft8yIE2Opw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2fk/DFr6bfZjKOaAdKKJoETbP9AZxvbXDpW2OMcCF0rPuxU9i
	nWc/0zt4dB8pynjrmfpES532SfDd6KHdWXTMkxYa2dcmiKWaCOqaOsrf07nuLQ==
X-Gm-Gg: Acq92OEbybbqbeeaUcScYCbvb8WWI+ulR3YBpKQrJP0OJWWBICBPfzyia4jzcTJCE+z
	yy/D+OwfdanzbagNVWfCT12F4WDfC54ntj/mgxSi7mtSD/3cO9Nr17D+IcvSj0mSnk4Pay8fdAd
	xjyUY1RK6Y0gyqC6lec+NsTZZp+xkXhfFDmKqK9w07GU6gGOC1OaXG5X1uzLjkf1JgBBizsk1JW
	vPMcm4Zp3pBnAkNETS7XqE0TA4GoMPbsZ8CosaIt1QSw6YuwCfXe+3leW6e7ZtRGZTkqtvxF5XF
	lsMoJE4/iixJWAG/0Acve1Lzy2OallnTwVqrwDf8OtSXqf+LKsA1aGaSJxyRSmcyDZw9qYWj9sa
	hMg4l8VcKVwOUBxTp3F+7dzxVACdV2yiJuzWHDM89gimPM9rAeEO4/3uCe/lsID4B8FkNPj3aJR
	imKvcfYzSpR/RtgQbEuXcsTthd1yHA+rqpzPICEEu4WOj4Gd6lwOaMblEl9zxR2eayFVynzAQ=
X-Received: by 2002:a05:693c:62c3:b0:307:d4e7:b18b with SMTP id 5a478bee46e88-307d4e7b28bmr363355eec.20.1780971836063;
        Mon, 08 Jun 2026 19:23:56 -0700 (PDT)
Received: from pop-os.. ([2601:647:6802:dbc0:2534:7d6b:e6e0:1a46])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3074df8076csm20765922eec.29.2026.06.08.19.23.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 19:23:55 -0700 (PDT)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: larahishamahmadby@gmail.com
Cc: andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	daniel@iogearbox.net
Subject: Re: [RFC] eBPF-based production deadlock-risk detector: kprobe/uprobe/tracepoint pipeline with userspace wait-for graph and Rust runtime awareness
Date: Mon,  8 Jun 2026 19:23:53 -0700
Message-ID: <20260609022353.44120-1-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAKCqX5oNwWaY7OMsdN-wJWf6YZMBdbxaDmyonj+bf-Bs-+0Ytw@mail.gmail.com>
References: <CAKCqX5oNwWaY7OMsdN-wJWf6YZMBdbxaDmyonj+bf-Bs-+0Ytw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Lara,

Nice work, and thanks for the detailed write-up.

Before you invest more in the userspace wait-for graph and cycle
detection logic, I'd strongly suggest taking a look at liblockdep
first. It is the userspace port of the kernel's lockdep, i.e. the
exact same lock-correctness validator the kernel uses, packaged as a
library that intercepts pthread_mutex/pthread_rwlock and friends. The
lock-order graph, cycle/deadlock detection, and lock-class tracking
you are reimplementing in your loader (and partly in BPF) are all
things lockdep already does, and it has had many years of hardening on
exactly these problems (false positives, lock classes, nesting, etc.).

Some background that may save you time:

  - https://lwn.net/Articles/536373/
  - https://github.com/svagionitis/liblockdep-kernel
  - https://www.vctlabs.com/posts/2014/Jul/09/liblockdep/

Reusing the lockdep validator instead of growing a parallel graph
implementation has a couple of advantages: you inherit a well-tested
deadlock-detection engine, and you stay closer to semantics kernel
developers already understand. Your eBPF pipeline could then focus on
what it is uniquely good at - low-overhead, production-safe event
collection across kprobe/uprobe/tracepoint sources - and feed those
normalized lock events into the lockdep algorithm rather than
recomputing cycles yourself. That separation may also make question
(1) (lock-order graph in BPF) and question (4) (upstreaming fit) much
easier to answer.

It is also worth checking the current state of the code: the in-tree
liblockdep under tools/lib/lockdep/ was removed from the kernel tree a
while back, so the out-of-tree forks above are the practical starting
points if you want to build on it.

Thanks,
Cong
