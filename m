Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D9E32D0CE
	for <bpf@vger.kernel.org>; Tue, 17 Feb 2026 11:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771326316; cv=none; b=IJucXWrDUS+T9UzJU9k54l3ummvMdV1Rbz1gZOSXCNQaARhSnPeg7QntQiu/DBCYTUYof5ixUiSoL3cfTEm8RUuX9kAszH/RlvmSRxN0wdKxHjL5WIJtiljZmAFkxaSceYdbrT+uTWXrmMqAZGgwKHwz4HrkJxS8kR5Aq1vzt70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771326316; c=relaxed/simple;
	bh=uDBiU2C7+3Rgh9Df39HuQ5kfSjmQotATp66mNAM7j+A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AvjJoJHx9zcfnmKNoKsGu8Es0QC2FquevjtwR66oRT6fCR9eyJLyaXsW5bk+cZvj3x51LtEQspgrelMQdKUIpZK8TVS8TypiewKi1ww6/Vfc3IruOusu5gA3Ik+JN45qke/LYJSkUa1DFAzxHQGrI9KDWBKu0En5kPOCZWnTsxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d6m0Iqfh; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d6m0Iqfh"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4836e3288cdso25146035e9.0
        for <bpf@vger.kernel.org>; Tue, 17 Feb 2026 03:05:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771326313; x=1771931113; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DdieY3TeFCCP2lBrqX6SK0NNMt0g0Rj48YaZz/Wekss=;
        b=d6m0Iqfh7Q7FLdQvn7j4u9+mc8uypIKu7fdIjvm086jUWQ3X15wNwtJuvtEPjKEE46
         hJkYZFnfDVCR8ZZPdB3hVsHOOgNoVUXsAh3cYW+ZhHBcyyUMGY6XalocGtDS5BputbD6
         aIa5L81V6cN8A7fdzZ8dxP3ws9Z55zmTWrDtmqa5u2DRZNEh7dCj+0oFEajpibhhKwCc
         hYlpjZSi3xGr6tnCQT1VXEtTFcyZQhXGb0ijnQ7uwxntrym4+fxGhEmVfnbdtX2u8SUj
         SxcfUdHMiAmq4pBBGLy+9knivJE8CQgLlJTsnHYm6nXzCMeys2PScYJBM+BJIAYtH5lr
         dOuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771326313; x=1771931113;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DdieY3TeFCCP2lBrqX6SK0NNMt0g0Rj48YaZz/Wekss=;
        b=vg0o6ETp9mwlIZdQDHD1Tmicl+k+hs+jpSm7jiFY0MWVuCwqXAvh3LC98hR6y1m/Fp
         NBcUIz75qUFh/qDwi8qbD6nIq0gZaso6bQSWLTcSk497F/VzEN0dOp/pxJ5smWuMQfle
         +bN0insy5L0k6gEVQZhfqC8qsfjhDPMLfgC8zdIWfcu0OfYEso8UCVOWew3VLzW/wfvX
         2CsPnPsKOSHeNF/wdFMAr6KYV+WZx95RhbZSFX3cHzgq2fmz3eSO+WGdfHkJDUp0xgLR
         slo0Dv2uR/ExXI9G+SlUsttuCkxSjJAIg1XhKE7DAVbO+E8m6M9mS+f+yF/VCBVtvqc4
         j4qw==
X-Forwarded-Encrypted: i=1; AJvYcCXaf+Uuq/DCJSztohYZtVxlIzAdM0EPZx0rXcI0KaDpdW3fQkG8ADU7h17Q4el6yosGxqM=@vger.kernel.org
X-Gm-Message-State: AOJu0YznVxcwXcuhC5MvgMF0IdJphpVWAnpGwEmDOqiblvMbjaX9dGqY
	UA6N34siMy9CyAbl2qeaiZWVqMajGJsZQf9j3rSpW9d9UiCkM/jlhGZJ
X-Gm-Gg: AZuq6aJnbtZ4iakFrYApWLpRQLOcf/lu3uZo79x4yTDq9ZHk9q1iJS3i4lLQ5bU7sT1
	90PNmdD9H98lNV9s3pEIzUO/w0ubFoRI/97eljJMAWeeDXjCt0WV3iiW7s3rn3/Wm/SbGVkl11g
	368MrjfOXCFTW7Wm+SZHkYNWIQm4D/mOwEOa35Q/YDxCI4bde9D+pNbtFiDwuvmgHFwHy4f712k
	Oc0ygQu7ARgJLDCgnpJS4M5icwDIo+kg+xvunCToyAosVjMjF1CJ8rUKc9Nm8tb74+t2dn4do/J
	kqsNQPjurdSQqfqUF0Zf/03CST8nAK2J11+U2U4sDiwDdh6RBs2cgu9rvNcGCh+w0km5+k/1GFZ
	NOHMAO6Al9RgkJ9mDvRItLllvZdvAQAAXmqielk2no7GWwVcFghgR2Bd9iJsgtBpvm9ZRHkn4xJ
	6cdvlrT52pYU+hWyliX95pYcauYlbvIt0e3GYxHI7I3LYcmszGzfY47XhX3IVHXBE3AsyUwBwEt
	/Lia6HS3Vqd1wWgAAYGeKtzAR+bo0IfySuiU/f+xr26bh5JLrE7UbIu1fdrVTdYkei5o9kKopxq
	yQ==
X-Received: by 2002:a7b:c356:0:b0:47d:52ef:c572 with SMTP id 5b1f17b1804b1-48378d4f631mr137622535e9.1.1771326313228;
        Tue, 17 Feb 2026 03:05:13 -0800 (PST)
Received: from ?IPV6:2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c? ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4837b68e5adsm310486565e9.9.2026.02.17.03.05.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Feb 2026 03:05:12 -0800 (PST)
Message-ID: <47684e50-d7c6-4f20-9206-366c9c343eb3@gmail.com>
Date: Tue, 17 Feb 2026 11:05:10 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/5] io_uring/bpf-ops: implement loop_step with BPF
 struct_ops
To: kernel test robot <lkp@intel.com>, io-uring@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, bpf@vger.kernel.org, axboe@kernel.dk,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>
References: <ec7d21e6e16c49165fa1e8af2aa09d01c111ea97.1771260487.git.asml.silence@gmail.com>
 <202602171315.iJKYSSFe-lkp@intel.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <202602171315.iJKYSSFe-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/17/26 05:24, kernel test robot wrote:
> io_uring/bpf-ops.c:45 bpf_io_btf_struct_access() warn: always true condition '(off >= $expr_0x7fb415932650(30)) => (s32min-s32max >= 0)'

Got me confused at first, but it's the first field => offsetof() == 0,
and after type promotions it compares an unsigned type with 0.

I think smatch is too strict, and it's better the current way,
i.e. handling all fileds in the same way, but I'll respin to
silence smatch.

> 
> vim +45 io_uring/bpf-ops.c
> 
>      37	
>      38	static int bpf_io_btf_struct_access(struct bpf_verifier_log *log,
>      39					    const struct bpf_reg_state *reg, int off,
>      40					    int size)
>      41	{
>      42		const struct btf_type *t = btf_type_by_id(reg->btf, reg->btf_id);
>      43	
>      44		if (t == loop_params_type) {
>    > 45			if (off >= offsetof(struct iou_loop_params, cq_wait_idx) &&
>      46			    off + size <= offsetofend(struct iou_loop_params, cq_wait_idx))
>      47				return SCALAR_VALUE;
>      48		}
>      49	
>      50		return -EACCES;
>      51	}
>      52	
> 

-- 
Pavel Begunkov

