Received: from mail-wm2-f11.google.com (mail-wm2-f11.google.com [74.125.225.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AEE637EFF8
	for <bpf@vger.kernel.org>; Tue, 15 Sep 2026 14:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789481696; cv=none; b=fqCJg+/WSjZQ6Mo2fUePNIPO66VMYKMlhHGzIRLxBvyONH9yuTpV+kZLw0DUPvDuRlU4NFEdpNDySZSXJhHlnn5wpF55QqW+nvMWQa9ajO+bGngSkNeXDq7xt750c+V1Lt1nvN1jeTSMuOxie3BZat5nmt8k8SNmgjjN+9Al48A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789481696; c=relaxed/simple;
	bh=pkSGxfSZbHnywDcP9nIshGA9C36ciSLa+2BrXsdpktU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=mTJx5b285vL4d9NMcpU/6LcIrI+UkGh5g7cSz72QRz7XumQ8QixjE20UjQnD7WJF+eDx0PqjweNCCAmcmNRWuhKIcO73FIVGAL8CoevkEE1dRb5vLrNb4f5vvZLrYPIZFQIJwvcrsxGpKq9ioagtkbwXuGt1m49aVF6yAPqzpWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZAAHpBiF; arc=none smtp.client-ip=74.125.225.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZAAHpBiF"
Received: by mail-wm2-f11.google.com with SMTP id 5b1f17b1804b1-49ccea58fe3so11680555e9.1
        for <bpf@vger.kernel.org>; Tue, 15 Sep 2026 07:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789481693; x=1790086493; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=0OZAFkwcE4oBOSQ4kUnt0cY6hilivdWhVzjEM2Eb7uI=;
        b=ZAAHpBiFdRkKE5SRnTkOZRG1WajsZrjoxctvZKuxvn0Woxe7LK49ppbKLyqoXeR4FC
         SP/RU/2LwTrifG5sBIECwd1JpHq/KEj1i8sx81RrKGmFmcI2p3JOgOE7syuGJtyA7u8+
         qV/+lX3BiQpnBpvwUDV7kilIAZZqBO19ur9ITY4NXAyqgYO0uY3cxarKbVSbmMGqtcVU
         QZIwMaq/sUXVG7pX0QRhl/j7SuHJBwEzRmiHQjS/r7irLfQ/MF1Dwh5SmkcfZwidpzDV
         85VdV0N25Pp6zBA4Ldj+ZZ+bnbTCAOxk1byxa9SG5vs24ckgRHTaLvO8oyYCVRDszjn8
         30Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789481693; x=1790086493;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0OZAFkwcE4oBOSQ4kUnt0cY6hilivdWhVzjEM2Eb7uI=;
        b=yJadlSs2Q+1aaX8Q7cyr3LylWkLi7cmdAR8AL+6vrCCYeGbQla3SBW3Idv5TRbtk/t
         YO41HhY0RK7TpJU1s8MYyCOs78lGNYBLlrGLfXDyIJFCSNmqsy88+cgfPNcyWm7pBWjh
         rNZvfe4ycBkkf9tWys70xFfMdsw6Fbtv1mDOlYYAtfenhQSU2jrOHVLU2hiSmxTuSe02
         O+QWtlW8opRvZR8qn+29h4h8n4O6CP9G3+dwSMez/RkiDHf6igkMb6xMU419yFU0TOsu
         7XzekTfhf4Ya66MxC9gi6fNVtpT4YYwQS2/OYljKP6LD3jt6cE+pQ72yO15E1/Irlxel
         jgiA==
X-Gm-Message-State: AFuF++lvD1NZeZFgV8Ny9Qqh80lolKfZvSwTeHvOk1ZrhKVOsn9Q2CLk
	DkHNaADV/3k3pVgfVEN+SYYKqibnCfEO5Q10n7RLADIreOJkQOz03zqrrYBTxituyNM=
X-Gm-Gg: AYBFou0GThRiY4e2rfBjjxVCD3+x/kZhNjknOrkHpAZJOEYuz+rXaAguLAlRyA2ZQXb
	30NAPfbJn8IpQJe312UsiPxgr5Ygub+5HkDdYuE/z2OCm4xVC6VNduVtCgp0sCHq2WYPTy4DoSC
	Jf9qdp4bZbCn0vG/e6X+9X7aXWSXStbrH8z1Tolw4ZexlEOxyhynCUxImfPbQh5hmQl0GjcI/+g
	tIaOoZ+EF/rSqTBdQzh2IQWUT17FItFl2bLAOGO/kW9PH/kvCtp0ZglM7WGZqg7/p1Qthb1dByV
	URERipGf7Q2qvmtLOmhNZdfZVkaaZcsRAk6qvntUB1JSLYKGMQI4UzUpSdJaYQHSozIavaD+Zg3
	qi+MES0Y3snDX2fHfeu/OLn2pHrA+8XCTHisjTiilSWHXTGDpCufYTjJBpTOpFgypHtEfJZ7pqp
	WTYg1hXOWY6gvTZ0uhUbk8yw570ca30yKnEAZEzxYmTryp2SYu4FJB1OjMwwhiEGGFEZWukpWYY
	+KJIX5itGTf9USqVqxP/xZAi2q7PXd9X0iYgr5bz2AUl6sb8bEaFWtquWZdJVXkk/mEoTvO4bJD
	7yFtINMRf0ElA3Y4cYtIqj9YOOIFLgTUWNMoOw==
X-Received: by 2002:a05:600c:a47:b0:49d:16f1:94a5 with SMTP id 5b1f17b1804b1-49e7a677980mr88542035e9.25.1789481692822;
        Tue, 15 Sep 2026 07:14:52 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e7d28c734sm61916215e9.1.2026.09.15.07.14.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Sep 2026 07:14:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 15 Sep 2026 16:14:51 +0200
Message-Id: <DLFYBG6LYFZO.RM7XHJ08ACMF@gmail.com>
Cc: "Alexei Starovoitov" <ast@kernel.org>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "Eduard
 Zingerman" <eddyz87@gmail.com>, "Emil Tsalapatis" <emil@etsalapatis.com>,
 "Tejun Heo" <tj@kernel.org>, <kkd@meta.com>, <kernel-team@meta.com>, "Amery
 Hung" <ameryhung@gmail.com>
Subject: Re: [PATCH bpf-next v1 0/3] Fix generic __uninit kfunc output
 buffers
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: <bpf@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <20260915141004.1196460-1-memxor@gmail.com>
In-Reply-To: <20260915141004.1196460-1-memxor@gmail.com>

+Cc Amery, sorry for missing it.

On Tue Sep 15, 2026 at 4:10 PM CEST, Kumar Kartikeya Dwivedi wrote:
> Generic __uninit kfunc arguments are output buffers. Their stack
> liveness already treats them as writes, but argument checking still
> requires readable contents and does not record definite initialization
> after the call.  Check these arguments as write-only and reuse helper
> output-buffer tracking, with one entry per argument slot.
>
> Kumar Kartikeya Dwivedi (3):
>   bpf: Fix generic __uninit kfunc output buffers
>   selftests/bpf: Allow privileged preparation for capability tests
>   selftests/bpf: Cover generic __uninit kfunc output buffers
>
>  Documentation/bpf/kfuncs.rst                  |  27 +-
>  include/linux/bpf_verifier.h                  |  11 +-
>  kernel/bpf/verifier.c                         |  70 ++-
>  .../selftests/bpf/prog_tests/verifier.c       |   2 +
>  tools/testing/selftests/bpf/progs/bpf_misc.h  |   9 +-
>  .../bpf/progs/verifier_kfunc_uninit.c         | 399 ++++++++++++++++++
>  .../selftests/bpf/test_kmods/bpf_testmod.c    |  56 +++
>  .../bpf/test_kmods/bpf_testmod_kfunc.h        |   9 +
>  tools/testing/selftests/bpf/test_loader.c     |  41 +-
>  9 files changed, 577 insertions(+), 47 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/progs/verifier_kfunc_unin=
it.c
>
>
> base-commit: 5ef40d69b38a93bc9951dadb1a15c85c597e1a40

