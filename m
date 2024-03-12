Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A2777829A
	for <bpf@vger.kernel.org>; Tue, 12 Mar 2024 09:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710237234; cv=none; b=sHuz2ei4rOVcdpO8aiJATgcrZawme9q1RIaQP2BSBdduV7pKycvH6N7wCgEs48Nhi/30CA36tiiC5OLZ1H4Gj1rUdQ9phOfGJActuRfVvO8SIIAQYM3NDq+Cd2mKkZJrVw9delDNcqgzw4AhDRmq3xIbIj/RNqtE5vAJC9rkZUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710237234; c=relaxed/simple;
	bh=3s6A+HRj29Z54PXRwWvf+DZkSagSB5YIezKOb3jp9co=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PesUBKpxcweJ/mDBPUtBfZu2y0zJpgX/QFaL0qTuWBgvoqM0Q7yk/i5trFufiuUue8nyfUXgXx2U5SwJYGz2FUHvX/NM2aXwW/OYLq/BXi4YT+ilWIqvPW9ZykmBDEdOl0fQ339+O+kS60oklaGkyI00zK0610rJw0a3wO9ESxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=NA7ZyrSl; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="NA7ZyrSl"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4132a4b0971so9947635e9.3
        for <bpf@vger.kernel.org>; Tue, 12 Mar 2024 02:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1710237231; x=1710842031; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FLz84WFc+uvm0OgDvpP2YimwJ20b1tGE+HgG1/01c6g=;
        b=NA7ZyrSlWyRFJVDO9//caoszOgMxUTj2dncdqwekyovh2QL4remIiEC8l5Anuw4VkN
         Xpqo5si7qfM7c9HFBZ694ovABnUDEIeyfWLPXLGlizYpQ5n6golasqZs4zoPSek5pxrB
         vniGR16OQNXBnFM8RNisQCnWycdRoXD9bZ62b8cKq4uMkj26xNYRzwqcBrpxJvwQW4yR
         0JJf59tml9tMfzcFVYc1FAy7oD3aLZEu496OW6VL+02mFvlHoiKYLmVmuzIMpTIaKNYy
         JjfVbgpoR23RuPNdgNUftIP4g9lNFZCf99aqqjTU2L98aMwG+dAUoRwdmRS5t7LHMw+L
         lLXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710237231; x=1710842031;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FLz84WFc+uvm0OgDvpP2YimwJ20b1tGE+HgG1/01c6g=;
        b=Syoir1GBbxxTUGmOVQ1jdojz49cslSkPuagRqXk3VuGsgMdF1eE5X6ectjS8spDgGx
         Erukku5TN57JJj8vIhiSDXvAaZ8PDzyMHaZvVhUSegBloyiFlaDST91/TJNvv5s3h+TP
         nRnmOI/ArgCNqDYPEifTjaC9fUh+jgHE2MWIhBL9iKn72LWm/SzqQQ547vZM7Q1Z6ZPl
         OMvbx7Gl+vjPBek8RVabz5IfhLa1k9wPBNG6VPHnyTK5/Unp+fQ/fYg3o0sU7GcIz+PM
         /RvKWcpAs9d9TGXxqur0G986VIJbzhhLpQwM+j3eo7tkLLX1uWo7OOwkCnRAYc3foxSO
         1KjA==
X-Forwarded-Encrypted: i=1; AJvYcCU6U9oG7J/JGciVsHKVzrPCkts5f98qTQnv5gexY1quu8mAXeXlfMcLYV9naQSWtoj5IgRQadcCpLEkyOIT0qyWxIjl
X-Gm-Message-State: AOJu0YwRD1bAC9le+AJhZNhO2kiP/0gNNCxFStrXwNLUjXRzM5lko+g5
	Au2kVAw/V++fKSRDjCEi/0lrtnR2wV+xpyoTlrH6La26bqj6N++8jV2olaMh8Aw=
X-Google-Smtp-Source: AGHT+IGn/957XmhvahBozxGlAJF8nfkrgOWiy9pv/WcdIvERnCw17P14BmfUmykTAkSNuLCJzYJXIA==
X-Received: by 2002:a05:600c:5101:b0:413:2958:d145 with SMTP id o1-20020a05600c510100b004132958d145mr4157306wms.4.1710237231536;
        Tue, 12 Mar 2024 02:53:51 -0700 (PDT)
Received: from ?IPV6:2a02:8011:e80c:0:5231:db44:25b0:339e? ([2a02:8011:e80c:0:5231:db44:25b0:339e])
        by smtp.gmail.com with ESMTPSA id fc19-20020a05600c525300b0041312855081sm11996411wmb.5.2024.03.12.02.53.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Mar 2024 02:53:51 -0700 (PDT)
Message-ID: <6e44c9da-ea3b-45bb-a62e-3094889408fe@isovalent.com>
Date: Tue, 12 Mar 2024 09:53:50 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next] bpftool: cast pointers for shadow types
 explicitly.
Content-Language: en-GB
To: Yonghong Song <yonghong.song@linux.dev>,
 Kui-Feng Lee <thinker.li@gmail.com>, bpf@vger.kernel.org, ast@kernel.org,
 martin.lau@linux.dev, song@kernel.org, kernel-team@meta.com,
 andrii@kernel.org
Cc: sinquersw@gmail.com, kuifeng@meta.com, yhs@meta.com
References: <20240312013726.1780720-1-thinker.li@gmail.com>
 <2c0512f4-6bbc-459c-b6e6-7319d59595a7@linux.dev>
From: Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <2c0512f4-6bbc-459c-b6e6-7319d59595a7@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

2024-03-12 05:22 UTC+0000 ~ Yonghong Song <yonghong.song@linux.dev>
> 
> On 3/11/24 6:37 PM, Kui-Feng Lee wrote:
>> According to a report, skeletons fail to assign shadow pointers when
>> being
>> compiled with C++ programs. Unlike C doing implicit casting for void
>> pointers, C++ requires an explicit casting.
>>
>> To support C++, we do explicit casting for each shadow pointer.
>>
>> Cc: yhs@meta.com
>> Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
> 
> LGTM.
> 
> Acked-by: Yonghong Song <yonghong.song@linux.dev>
> 

Acked-by: Quentin Monnet <quentin@isovalent.com>

Thanks!

