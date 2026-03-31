Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC8883A382E
	for <bpf@vger.kernel.org>; Tue, 31 Mar 2026 19:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774983949; cv=none; b=jPz+FutiuFQMZiaLDAkcensP1iu5qsCZHMACqzq4ZbkV4jxQh9At4ObYYBF9SgklqyLU/ey8GgAACys8Wf9QFHnb9aDo6Hz+FQmMlcc3jv3oJ82qjdQAfAzeoXQWImJJlrz1rdQuWNhTW651v4d0KvRnm4SZdVPqT8YCsqqQBVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774983949; c=relaxed/simple;
	bh=oSZ8g1bjCkqJwY2DGBThusr7FfkICvf91cOTag38RKs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VxzJrPkndfPko5CiFC1FjUqpUNqANnSbUyHr/pwlqYt4ufxWyaHSrPPv4ctW64nsfDzy8wKTIKLKYQ6YhGzG7gKMd9KOCINAb2G1AoNdY33memB5El+zVULG9d1w+ym7C+DFcbfRb7/RlHU5Ypgzo7AXLWG2qLRq2pL3P45kNDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NmDgE3Wr; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NmDgE3Wr"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-43cff5dafc3so2116219f8f.1
        for <bpf@vger.kernel.org>; Tue, 31 Mar 2026 12:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774983946; x=1775588746; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5QVbd5e5IqxdCExscwZLPm+SOmPoSjytCCtpJN/kv3g=;
        b=NmDgE3WramdG96P5l0vBf1ub8ZHRTZt28jfpwlDw+9H+BFAJ/PsSLbD0BVNN9CP9JG
         dHyscL6+nmKCUrVGNOMRHYSzerKcjNzhLh/fgsjfW3CKXRBkozq0ssBlBnw90D3rO1va
         kO0X0QWl1QcITvJk2I43hc0xmAN9OFm6IpXoNMaeOMIufom4pxqZR/qKLPDFBVSzUW1U
         TpixxGT2OnPB7/DJZ39q9Kjh69uBms6fZwFACHadSZxck1VJfpON/l8y/d6+n0RS+NVV
         ATRvXQFHw/IqWSO65wuFYP4f7xuT/Z+N/fmfMb3ZeahCoLXOAICBl0U9tFV/ksJNxElf
         zQ6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774983946; x=1775588746;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5QVbd5e5IqxdCExscwZLPm+SOmPoSjytCCtpJN/kv3g=;
        b=Iz20fvV3gXO3nkIMPdx61jZROYfCjA7xvOPNXs4oEKvXdVGDbyifdKNFBorkrzDftJ
         O7utFAqYOIcNbeVc6hA0i6IXyJ8bumUcNnIqdRTvfZAT8R1+8CnMu+9y1uhg0GuL6hmC
         9duiKujMsVpf1i8Vve+vOSabQscK2ryMbv2IXBTGCsH2/4RZaMne6PhT8cTr6qAeFR5n
         iEuUu0b4EF8aE8jcclXsysHqQawu4YDir/8X9fEUD85e6AKLepIfy/rmaYhQvAwlmU0V
         LY0E3BLKsFwXhIS5+dufRx6JoyXyojeS8Qp7JHliYFWQxBa9J/x2PVkapH7a8sYoziRC
         /J2w==
X-Forwarded-Encrypted: i=1; AJvYcCUEUGImZEsQgA+lTT027WGjGD2tGjUv3OV18ldJRZOxenO5nxDyqIH36iUKiGnUDypDn6c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfoxJ5cSl9e3QyPEd9XThQUryh9zumXo/h6itoLAR/RypgT4B2
	0btKpw2YLyZfmyllzH2Jybg/qoGy9H189hB0vVBM4dCfDtQw2awJWWCx
X-Gm-Gg: ATEYQzx46WusXPs/olQ0rWdEsbYFSvjnLeI6gR9EaP2fuR6SiocX4aOyEYk8h3kql+a
	n0BAsADP+WYXBshjg6EfZl3eZ0OyQkTCaUYasIVB1AXsn0aYNOQc46ZfP10oDbpvR1JcfYlMHkR
	f4gvOlCAf7gsAgYXMMcVmSS2gDt3ft5HIhC/l+F0TcZZPHOWyasiI9YmNpl7mjsgImYKfWtoJzA
	3jlsaULYbTHS3ZzOGfaAK76n5Jd6StZkjHryQXP+EOPKTVsreV5s/9VvAvcGU4mnE4EW2p3nWPO
	hRDU+bIn63k778kmeITUdAlNkZdfy4Mtvn6fwvI84Y4MCJ2FbfV7ZeWuCCu5UwXVcBrlQobVOV1
	MfJD5gKppzYnnpR0qYJcTvvgNUhXDSXuwJwBRAST7PjEP79w73JVllopNMxx7XHoo3x/Rq8INIv
	uWeM7qBTcZ9SLZBenPcqCNAIpH5RlcFKVOXIg8Ssio+Bihj9mpfA2ZR532CRnYxK9YZJ8Nu0snp
	0CkfDD1kRE=
X-Received: by 2002:a5d:64e7:0:b0:43b:45d1:f449 with SMTP id ffacd0b85a97d-43d150ee9c2mr1472415f8f.51.1774983945735;
        Tue, 31 Mar 2026 12:05:45 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bd1f:f500:f867:fc8a:5174:5755? ([2a01:4b00:bd1f:f500:f867:fc8a:5174:5755])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43cf21eba4dsm32151422f8f.11.2026.03.31.12.05.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Mar 2026 12:05:45 -0700 (PDT)
Message-ID: <f48518a3-091a-4af7-a420-bee4d124f9a9@gmail.com>
Date: Tue, 31 Mar 2026 20:05:44 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 1/2] libbpf: Fix BTF handling in
 bpf_program__clone()
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org, ast@kernel.org,
 andrii@kernel.org, daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com
Cc: yatsenko@meta.com, martin.lau@kernel.org, eddyz87@gmail.com,
 yonghong.song@linux.dev, clm@meta.com, ihor.solodrai@linux.dev
References: <20260331172634.57402-1-mykyta.yatsenko5@gmail.com>
 <29afc1f08868691fee1ea4273e01ee669cfdbb2ca960fc1ee71fc4ed486cd069@mail.kernel.org>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <29afc1f08868691fee1ea4273e01ee669cfdbb2ca960fc1ee71fc4ed486cd069@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 3/31/26 7:35 PM, bot+bpf-ci@kernel.org wrote:
>> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
>> --- a/tools/lib/bpf/libbpf.c
>> +++ b/tools/lib/bpf/libbpf.c
> 
> [ ... ]
> 
>> -	/* BTF func/line info */
>> -	if (obj->btf && btf__fd(obj->btf) >= 0) {
>> -		attr.prog_btf_fd = OPTS_GET(opts, prog_btf_fd, 0) ?: btf__fd(obj->btf);
>> +	prog_btf_fd = OPTS_GET(opts, prog_btf_fd, 0);
>> +	if (!prog_btf_fd && obj->btf)
>> +		prog_btf_fd = btf__fd(obj->btf);
>> +
>> +	/* BTF func/line info: only pass if kernel supports it */
>> +	if (kernel_supports(obj, FEAT_BTF_FUNC) && prog_btf_fd > 0) {
> 
> The commit message says this aligns with bpf_object_load_prog(), but
> that function checks btf__fd(obj->btf) >= 0:
> 
>      if (obj->btf && btf__fd(obj->btf) >= 0 && kernel_supports(obj, FEAT_BTF_FUNC)) {
> 
> Should the check here be prog_btf_fd >= 0 rather than prog_btf_fd > 0,
> to match the reference implementation?

this is intentional because 0 is a default value for the prog_btf_fd, 
that the field takes when it's unset, so to detect that situation, I'm 
filtering out fd = 0, even though it is a valid fd.
> 
> [ ... ]
> 
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/23811027187

