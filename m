Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 569403A75A9
	for <bpf@vger.kernel.org>; Fri,  3 Apr 2026 15:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775231051; cv=none; b=FvfBvps3zyj/KZ3be07qnIz9LKr4vnNVOzeDMD1p1i0mscr16C9OUSWYhOF6TN7m0mnhziDfNvR/ZpaIMhZSyQXMV4xcfNjKWv2C9DGF6777oLBOBBRZLEq7UnIDCAz+pJ4TCUIzBMCHK2UNF8BkGeQhZUiSj9q/Jj+k57vKiTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775231051; c=relaxed/simple;
	bh=uYq/3416mlXI+iwcJOHQrrp6Lqd67kQJ64MXtoCFamU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J95c9gftqH+9td4oNQrsrxMkyZ8rm5lwZ7f5b/atHJrBZKL2jyU4kz14TzaOxL+1lXEn1+DxD59w+RbA2QGPcQ4IA0F9q1WKBtkEmMUVhE/HnEpwaF1+uVuOYmZdFZ1BqrwG9NhEfsHxhH9m9BUcm0+XZivhVdehSK8+PXQzI44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=T7gHCzj+; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="T7gHCzj+"
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-41708f6c3feso1313644fac.3
        for <bpf@vger.kernel.org>; Fri, 03 Apr 2026 08:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1775231047; x=1775835847; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UP39jJ3rhxJQ4+9IiHy7051NnSJJsim1X1uLLCgprng=;
        b=T7gHCzj+I96jIWLWWBJlOa6DpoweH3SRVBxFm3qkXg0qhQ/w1vQvCWhPekd6C/Ov4c
         ejSrWZ0J5INj4AOk3qIRwaCsGjMJ6vJyl/bM3wzRrr85diJbsoOiF7sABNYXCXEr33hB
         S1PGpHgY2gHgNlBMTKRczwWtLVrb3yZOpbtA6Vj6qsNUVBF6XYxBp9uyjooZAv1NjeFj
         s/O3eXnqwWuilED5kiRox7o51T9ZrmD7vx36pl9dV5wQAZ/zFtNEaixgt9AyK3xW2dUR
         gIb4sh/YjTR2eKa5vYPag6tTDNGdQvvBJwdEIkTiduOyKQQN6K0iKJkRQjbtztHAlq4g
         PgIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775231047; x=1775835847;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UP39jJ3rhxJQ4+9IiHy7051NnSJJsim1X1uLLCgprng=;
        b=o6GbWNZAi2aeO2CZFu3EEWbTEvjbKVYP/SkYJPBDuIxkrqb1FCja2DtQIB1XiINWBV
         kgFzb4yCscxg6I1Sg/dlkfvgfTAv2O/4J5ZqUowaIGXo9hJk3MlOfGFZ0n2+ZuCZhIRH
         L8jaxDaFIF0IrUrm14amcCkUe7EzfXQMRhSkS4hxdQgaMJumCiX4ulS0RV+pRObJgE0a
         HeGxwIfYcEcdC/64jLrx2QgEhmECmHdh/kqH5mzRGqzZVeW37WA9jBI4kHSisIHgf/Nk
         ByBn5LQ+hGR2VP6mtYDUPQD/IvppREMd6Le5bU9YR1b/K6sqYxbbbsVSMrsUAPUKBTUA
         BpGA==
X-Forwarded-Encrypted: i=1; AJvYcCVvqgp1gNnQpVgh2ALMRrPqKVEyh0yikrGhFkz4S3Otu/Uv1+vtDCjTQCFSUzNd07upEH0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYoSHdRpQZC0hnrTxh8fkuILXeO0yDcw8EoFajnwQrlVKtfSsP
	kgL6eIuahEiBnTxBh5kPYt6fOjsbnpoXNTKcYQrsDR3L548rmucpbxbgnk1F0Avq/1s=
X-Gm-Gg: AeBDiev/Fmin/aYQhSI5D+iy30x/TKZ2CirjsVDwAJhWMBs9edJPVRlzqp/FEIAfM/Q
	2CaIAM+RPuRqAit6AZJQ2LIBu95Ow73zSU8ZJVsdLIMMunDoRriC+iLZYwpWzhDKNgA48L2SHuT
	lLqLqyg+xzTfmHudKsRU1qfiU5nIIplD4Mb2C2aaj0a6DA4Vpd1WnryIvJETOaGRQVDz+pGzQRG
	sQ1JevHIfqsX/RH2s6q3SdswR8Sr0Rc9m29xFUi6QQLxyDKMWRlMrzRL9vvDliMWYRYU4V26teN
	srH0Za5D2kB+joVUyl6L9bCeC058wg5VbCMUAtjo7cCsshIYmULpuOQM6yxCwoXQMd+8ZU0k+h5
	pX/r8tjN4Ccf3sr+LSySYbs9YQBm/AljNuJfeNSyAUXfjqQNXOb2vvi9YIh2bzgEWYShPSLjAKp
	4qQiVo9lxH+8GjqNeXKbRq+1miqi15iSOiVo7+hW00Q+9UsXKa4SfVd/j/7t37hTGX8K0l1IH/U
	k4qAE5F
X-Received: by 2002:a05:6870:8181:b0:41c:f16:f74c with SMTP id 586e51a60fabf-423100208a4mr1655548fac.32.1775231047165;
        Fri, 03 Apr 2026 08:44:07 -0700 (PDT)
Received: from [192.168.1.102] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-422eaed6647sm5089543fac.2.2026.04.03.08.44.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Apr 2026 08:44:05 -0700 (PDT)
Message-ID: <ba3654fe-5553-4349-8a7e-7d542bc399a6@kernel.dk>
Date: Fri, 3 Apr 2026 09:44:03 -0600
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V3 05/12] io_uring: bpf: extend io_uring with bpf
 struct_ops
To: Ming Lei <ming.lei@redhat.com>
Cc: io-uring@vger.kernel.org, Caleb Sander Mateos <csander@purestorage.com>,
 Akilesh Kailash <akailash@google.com>, bpf@vger.kernel.org,
 Xiao Ni <xni@redhat.com>, Alexei Starovoitov <ast@kernel.org>
References: <20260324163753.1900977-1-ming.lei@redhat.com>
 <20260324163753.1900977-6-ming.lei@redhat.com>
 <5e8766d3-a801-48e0-8d27-60e75523ebd1@kernel.dk> <ac88hCYgrFXBX3-g@fedora>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <ac88hCYgrFXBX3-g@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/2/26 10:05 PM, Ming Lei wrote:
> On Wed, Mar 25, 2026 at 07:49:22PM -0600, Jens Axboe wrote:
>> On 3/24/26 10:37 AM, Ming Lei wrote:
>>> @@ -493,7 +494,16 @@ struct io_ring_ctx {
>>>  	DECLARE_HASHTABLE(napi_ht, 4);
>>>  #endif
>>>  
>>> -	struct io_uring_bpf_ops		*bpf_ops;
>>> +	/*
>>> +	 * bpf_ops and bpf_ext_ops are mutually exclusive: bpf_ops is used
>>> +	 * for io_uring_bpf_ops struct_ops, while bpf_ext_ops provides
>>> +	 * per-opcode BPF extension operations (IORING_SETUP_BPF_EXT).
>>> +	 * The two cannot be active at the same time on the same ring.
>>> +	 */
>>> +	union {
>>> +		struct io_uring_bpf_ops		*bpf_ops;
>>> +		struct uring_bpf_ops_kern	*bpf_ext_ops;
>>> +	};
>>
>> What am I missing here, why is this the case? What makes the use of both
>> at the same time impossible?
> 
> Please see the following code:
> 
> static inline bool io_has_loop_ops(struct io_ring_ctx *ctx)
> {
>         return data_race(ctx->loop_step);
> }
> 
> io_uring_enter():
> 	...
> 	if (io_has_loop_ops(ctx)) {
> 		ret = io_run_loop(ctx);
> 		goto out;
> 	}
> 	...
> 
> So if ->loop_step is assigned from io_install_bpf() called from bpf_ops
> registration, traditional userspace SQE submission and CQE reap are
> bypassed completely, then IORING_OP_BPF and any other OP can't be handled
> at all.

It ends up calling io_submit_sqes() all the same, so not sure I follow the
problem here. Seems to me that the only thing that is making it mutually
exclusive is the fact that you unionized the ops.

-- 
Jens Axboe

