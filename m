Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D99E2384235
	for <bpf@vger.kernel.org>; Tue, 24 Mar 2026 02:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774320863; cv=none; b=i26idG5dYmbLYugsdZtVgRN8PjF1GjufE0v912rLKluyPmxKDzurMqPVTnFAWn+UsoPS18Vl93xB7RdQKNLN2hjOmAh2HmlhETei+MS5yhB/dz7zzqqI//9O0gIFlO5tKv0vXbSrOGb/IgDiTLVZXXXA86KtaHxKWv2omh9sSyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774320863; c=relaxed/simple;
	bh=EDKMe4sPIv6tDaMJTfs6stvxZwxbh9egPlNbC5+n06c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jX84ngawIRGd5yUgX7XCIZ9pwLB7h0ov44eFrYoV7LBqxcHc26dQqsbfw5z0m4kLMIoHqkRusEEhr8zy3QrU7PHlDGVNwrcYp6J4zwNPlewjj0KcnrvC949idYp1XF1DVh9lfyQcOKrQtMfWwVpUTIIJlRrkP8Jc3x6hYxZ8oEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rtXfJZs/; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rtXfJZs/"
Message-ID: <d749228d-15b8-4487-8c2f-604b9d5d4316@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774320850;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tApYWEiNxZyjFXtpR2YuCIAPW0T7R5T38Mpwssdvk4A=;
	b=rtXfJZs/4IvB9AdsBuUj4FX2WZMbuBrwFUuuDL/2oRN+Wbacsj8i6M+lnf2pIc35vlnyah
	fHbLg5Ns6K25SguuxIzr/Gp/KgdBXeW6pcbTlTtD+4eIeivmKIbR4YX3LCid4YeJq53i1L
	YIDX/3lvcQafGzoGTghQMQAcU6Jg5Dg=
Date: Tue, 24 Mar 2026 10:53:59 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2] selftests/bpf: test access to ringbuf
 position with map pointer
Content-Language: en-US
To: Menglong Dong <menglong8.dong@gmail.com>, ast@kernel.org,
 olsajiri@gmail.com
Cc: daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, shuah@kernel.org, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260323021839.101316-1-dongml2@chinatelecom.cn>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <20260323021839.101316-1-dongml2@chinatelecom.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 23/3/26 10:18, Menglong Dong wrote:
> Add the testing to access the bpf_ringbuf with the map pointer.
> "consumer_pos" and "producer_pos" is accessed in this testing. We reserve
> 128 bytes in the ringbuf to test the producer_pos, which should be
> "128 + 8", and the "8" is BPF_RINGBUF_HDR_SZ.
> 
> It will be helpful if we want to evaluate the usage of the ringbuf in bpf
> prog with the consumer and producer position.
> 

128 is a plain test for ringbuf, like those in
ringbuf_overwrite_mode_subtest().

The reserved size can be 0; however, a test for it is missing. It would
be better to add a test against 0-size here or there.

> Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

Acked-by: Leon Hwang <leon.hwang@linux.dev>

One nit below.

> ---
> v2:
> - don't set the max_entries for the ringbuf map
> - add comment for the producer_pos
> ---
>  .../testing/selftests/bpf/progs/map_ptr_kern.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/tools/testing/selftests/bpf/progs/map_ptr_kern.c b/tools/testing/selftests/bpf/progs/map_ptr_kern.c
> index efaf622c28dd..d7611e7018ca 100644
> --- a/tools/testing/selftests/bpf/progs/map_ptr_kern.c
> +++ b/tools/testing/selftests/bpf/progs/map_ptr_kern.c
> @@ -647,8 +647,14 @@ static inline int check_devmap_hash(void)
>  	return 1;
>  }
>  
> +struct bpf_ringbuf {
> +	unsigned long consumer_pos;
> +	unsigned long producer_pos;
> +} __attribute__((preserve_access_index));
> +
>  struct bpf_ringbuf_map {
>  	struct bpf_map map;
> +	struct bpf_ringbuf *rb;
>  } __attribute__((preserve_access_index));
>  
>  struct {
> @@ -659,9 +665,21 @@ static inline int check_ringbuf(void)
>  {
>  	struct bpf_ringbuf_map *ringbuf = (struct bpf_ringbuf_map *)&m_ringbuf;
>  	struct bpf_map *map = (struct bpf_map *)&m_ringbuf;
> +	struct bpf_ringbuf *rb;
> +	void *ptr;
>  
>  	VERIFY(check(&ringbuf->map, map, 0, 0, page_size));
>  
> +	ptr = bpf_ringbuf_reserve(&m_ringbuf, 128, 0);
> +	VERIFY(ptr);
> +
> +	bpf_ringbuf_discard(ptr, 0);
> +	rb = ringbuf->rb;
> +	VERIFY(rb);
> +	VERIFY(rb->consumer_pos == 0);
> +	/* The "8" here is BPF_RINGBUF_HDR_SZ */
> +	VERIFY(rb->producer_pos == 128 + 8);
> +

NIT: Use BPF_RINGBUF_HDR_SZ directly. Is it missing in vmlinux.h?

Thanks,
Leon

>  	return 1;
>  }
>  

