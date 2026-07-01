Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6BD63BBFD1
	for <bpf@vger.kernel.org>; Wed,  1 Jul 2026 20:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782938423; cv=none; b=Bi6EVnEk/3X3rUYCPlJ4HyZoWAzcKtO7+3HbrvKKJU0wiMBFljcelFjtdyauU9HHSkvF2cRDb5U2gGq/EhAbKy8iJLN6nKSd9dpXUSlpoCY706vLGg7pOz6Lgfr5NmYJBzEN5WFMP3knnSDqqyMBGacjQtJ2lBCx8OWeYXBx3Ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782938423; c=relaxed/simple;
	bh=U2hF8G7MxMlTrCk03c/hCMOtixrsLEfPEzGm4AL91X8=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=kHu4CHID5PiObhpOEWE7Ok5fmS2phmGsVndOOj9nDkDZZSswEcmwR/1ke0jRRhyIbYwp/IzkcxHL+Yp5pD9miycwI+j/Pv3W9Unb+6F87LHooaHjurWzm4WrPwejAsUJPO2TFTm3Q58gaDI+g+nIpdDKdZsIsi3wETaFZInh9q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=x7LYEDNc; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="x7LYEDNc"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-9217d13c276so62542985a.1
        for <bpf@vger.kernel.org>; Wed, 01 Jul 2026 13:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1782938421; x=1783543221; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EXb+Hm8EqB+tIxEhH7zHV/2Rqng5Rp8lq/N7EdSukgA=;
        b=x7LYEDNcFudrXI3W83Dq4B3qLqg8nJwlwsXaEbCOysCZp3984EQVCGEqfcpHhuQexr
         WOc4b+6Mki0quXp7ue3ak0cnAwJjU0q2La9bHkMZxDehh0NphOi0X1DUeFSECtC8OKdM
         snbPzf/VXyOujxA8p3zyBI4Uh1nAXb1l7M6ehUodhAyWgUsOzOUu48ZGS4zEjaWxLhrK
         pXbPNx/LQ6LOcgf1KGxLZ4SzUC/9cEXmM0U/n9jd5xpQTmLDhTG8ypuhpH/dP0YGj73G
         7Nrec++K29OPgyKHNFEUR1KneUZ/QV0cfqR/lbXzVRhnMQqAucqNV3tTDMmBS9p9M+z2
         tE5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782938421; x=1783543221;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EXb+Hm8EqB+tIxEhH7zHV/2Rqng5Rp8lq/N7EdSukgA=;
        b=sq1xTorX4StbwUewEvkttabwfCG/C6BsKuoI5M+bjgnVKFqsD3QP2uD5bW9iiO27ur
         xtli+eY8/00mJv+CjWwmLVMfDB9RclM0hdhfC+UWwT0fCH8GT8Ub2de5WLY7kaYX3AIN
         cdt+9wv5jSyvCXOkHMcEhRQrVQckbrFai0SgFaIIZqZgojaztsxi16OhA5ZAFQPSyw/Y
         QYMjkT0OIJaJGZlU4kE7QFJEvoTthKqegO3sMBXrQbEW76SpUgnAq5vu2nLQPcN2mOOK
         Iwu5ek8/7OPUnW1G2TA2rZkxQ2YqT0hMo7wTydbjwVmDPeDMTfsyiOifzDXenpTYzGcE
         4U+A==
X-Forwarded-Encrypted: i=1; AFNElJ8dAGpZlEqNl8Jhg/vsXXI3g04ll9K5HUu9AibhiDV7O5uZuNBcc52dcYP12cJNcQYmHJI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlMfTdBsXypcTlxvwg9Dz0cSb6NynOGM/R+lE3AnhLcs4u+xpd
	sLFTPrEJ45t8Ui2UYWK8EgLQVEXMS3h71OPVPfa6Rd3N7O+4vxU48sS9AR/GgDKMuHE=
X-Gm-Gg: AfdE7cnHuzcOlQvj0/7iEuwuEZTm80M919sMoaDPSvY9qMbNI5LZ6bZQ3QXg+SlxjnJ
	IuZbDSpZntiA2A72/0DGCmN3i5pMFhVkZa29GInaW6smQd6YlaPlyn/Jini03MzTjwWwe0sEZiS
	EUSePmwlhgT1C/yLwB4vL+4DXWBKXRZjR9yzesdlyA1RNjY5i8p5Yx5XDIUa0JTyFj6G5p9v8CJ
	kPPooqRFtstzKyHYntzCDmN3cyM8rhJlVlt9dEN1w1zi5j7aomvicsQq8rAqhaI3HBjg0UZ1K6r
	jR6KRpLyZG0mkQchpTFC6NVT0z0zzXIs1PidoukIq9YKvnF9DFbI4hWq3vUn0st2uB6wz1I44OT
	R0H+U8zGzICzgf2BxmC9tuB8EW6KZJp4iUqw+xuCnGPfzD6NDmPAZEDd1vQ4lgzNQNuIvgol43/
	biohq+xT96YB0=
X-Received: by 2002:a05:622a:116:b0:516:e152:7a59 with SMTP id d75a77b69052e-51c26b14343mr43716081cf.42.1782938420485;
        Wed, 01 Jul 2026 13:40:20 -0700 (PDT)
Received: from localhost ([198.58.242.173])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8f471813f56sm7192136d6.30.2026.07.01.13.40.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jul 2026 13:40:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 01 Jul 2026 16:40:19 -0400
Message-Id: <DJNIX6BLBZU3.3TAKCXAF7L0XY@etsalapatis.com>
Subject: Re: [PATCH bpf-next v2 5/5] selftests/bpf: libarena: Add parallel
 bitmap selftest
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: <bot+bpf-ci@kernel.org>, <emil@etsalapatis.com>, <bpf@vger.kernel.org>
Cc: <ast@kernel.org>, <andrii@kernel.org>, <memxor@gmail.com>,
 <daniel@iogearbox.net>, <eddyz87@gmail.com>, <mattbobrowski@google.com>,
 <song@kernel.org>, <martin.lau@kernel.org>, <yonghong.song@linux.dev>,
 <clm@meta.com>, <ihor.solodrai@linux.dev>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260701185235.4516-6-emil@etsalapatis.com>
 <c4b56704d686ce2c0a944b0726914b06a593620812d129573855a7d89c9ce646@mail.kernel.org>
In-Reply-To: <c4b56704d686ce2c0a944b0726914b06a593620812d129573855a7d89c9ce646@mail.kernel.org>

On Wed Jul 1, 2026 at 3:38 PM EDT, bot+bpf-ci wrote:
>> diff --git a/tools/testing/selftests/bpf/libarena/selftests/test_paralle=
l_bitmap.bpf.c b/tools/testing/selftests/bpf/libarena/selftests/test_parall=
el_bitmap.bpf.c
>> new file mode 100644
>> index 000000000000..5381deeb8d37
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/libarena/selftests/test_parallel_bitma=
p.bpf.c
>> @@ -0,0 +1,191 @@
>> +// SPDX-License-Identifier: LGPL-2.1 OR BSD-2-Clause
>> +
>> +#include <bpf_atomic.h>
>> +
>> +#include <libarena/common.h>
>> +
>> +#include <libarena/asan.h>
>> +#include <libarena/bitmap.h>
>> +
>> +#define TEST_BITMAP_THREADS	2
>> +#define TEST_BITMAP_BITS	(2 * BITS_PER_LONG_LONG)
>> +#define TEST_BITMAP_WORDS	BITS_TO_LONG_LONGS(TEST_BITMAP_BITS)
>
> This isn't a bug, but TEST_BITMAP_WORDS does not appear to be used
> anywhere in this file - could it be dropped, or is a use intended?
>
> The sibling serial test (test_bitmap.bpf.c) defines the analogous
> TEST_WORDS macro and does use it as a loop bound.
>

Ack to this and the bot nits. Sashiko failed to apply the patch,
but the CI did so just fine.

>> +#define TEST_BITMAP_SYNC_SPINS	BPF_MAX_LOOPS
>
> [ ... ]
>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READM=
E.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/285413=
48016

