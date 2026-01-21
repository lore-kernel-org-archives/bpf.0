Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61ED833DEC9
	for <bpf@vger.kernel.org>; Wed, 21 Jan 2026 03:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768967083; cv=none; b=GyrorNrFgpxsbUBMqqkMd2ueL09FJIFFrs85ro+O+eFyiQnK3q82O4kecOMUDgAoF/9ufSwuOoOjbamw8Fe8L/Od8qzc+MLkxP/Xuymg5lKK8TJliprqQY7r/MOdzs1Zs5kbPuIQMxsEeaYpyc8oQId+caZ2ISZQPc202v/gohY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768967083; c=relaxed/simple;
	bh=gw/zexsat64Gv8TuikLKc5mSPf13yohroiifATy58+k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rlTT8Rnq0SfKrcJcgbVcnitXb9ZpSaPalqwvFImtqhlVeuVrPQsZ0S1wSUIm2Lbsit/MZNL4EY+QZO3R2brfuurWoiSIHDdSKiCQUny5v1zjd4E1OWgi97FMLPOU6jDyg7kmPPnPWuA81tl6uuAugUg/xxuv3c7UmFjNCi0YMHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=eDyYG1ya; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="eDyYG1ya"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2a75a4a140eso8475395ad.3
        for <bpf@vger.kernel.org>; Tue, 20 Jan 2026 19:44:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1768967080; x=1769571880; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aVyESZuF8vPeJbSMOEnjb9v3b+2mKVyjCwk5OYeVNdg=;
        b=eDyYG1yaTUiWmMfdhg5iTIMytTWaBVR5JiH6uCNlM6g/u3QFqmigWyMMHIzXFo+QQ9
         8sloz1a4/Vz0uaOSp2kjNNQAJOH8lbEpkvVEFB0GN/Vdvh+/yVQ/1E0mnuKHqYkBFZph
         r2NaR7BBmEViT6NvtRRaSAxfAEP4EkwP1k04B0ytxTgU9oxmBfmQrlOSPto+T+J8+er/
         PUykGS/ePPMszMe7UfyR546FPyaGWGBTAQmV3qpVY2oefhBzK9GUWrZScgl+DsUQ1nrK
         +FT3o5RuVmUa9oDDniQO8lgeJjNHaBlm7a0wGo8Fq0hCJjuuV34UKOj8IexBz3buxoYS
         qXYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768967080; x=1769571880;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aVyESZuF8vPeJbSMOEnjb9v3b+2mKVyjCwk5OYeVNdg=;
        b=mFgOzC3qoDsFl5IJ7KVfE2ht1jjFFKuhl69vOmrr7uChMkKa9A9WnaxV9bYc82q6sC
         Lho89eQkmubewVvj2hjWj80chZ2TT3jEEJXiAWE1bopn5DeKy+CH4ms/tFwZCgfGXCz1
         2xnYTTxuVYpIB7gPuUW83kMPRhWUNfPC5YnuA0zfGhAHZwRSfthyEFjesPHKK+diZFlN
         tt1QNdjMU2q7lfuFTLxCv+z/onXApA3oD+0P0MsNJeZaPJGRBX7hCBOnUUKmJu1lw+/R
         PyQAERFbwKh0gA+IentD6b60Eb354IN82SJBGkvrBo1tVnfaQGN72pOOxARBSIhoVzZb
         yczQ==
X-Forwarded-Encrypted: i=1; AJvYcCXWlgSls4MqCaY6eBUVNMxdJjcysaFz/tiEASHCREtRyEhvHX7DK8ypna3JfbwDDIXBpFE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyT6ZIlQFY4TyucOa6bAEZ2hBGjXKfgPTg/ksGHdySo4XCpdALt
	ndjKuUxZbOlcexZ0ecNgHUXqrDM9gA9ymarMDzU8/t4QC0RR9+OYbpki2g93g3UEhyg=
X-Gm-Gg: AZuq6aLuAMh38OwuUTtqdIfx5BhES1FExASqqDqCjFkRO98enDE56RkoUxo7rX1B4HR
	3zHE4v0DQckNBm6gIUgPO6m2Ci+/bgeGE1FHztZOI990lIAY8kFvzNsSXi2Kt/2Zr22DOyktyQC
	gye5n6DylmgTZVxMXcxj6GMPHQJ8wHSSm2W+BjuJWrXmvyXswXbldSpChv8NDFDoA4RHYkhASnf
	CEpASqph+pyZtuTSp8N6jI6/h5Bo3IfgIb10jaO2gh9227TeCgB61yNK4gbVVvNO/rN3tVaDP7z
	11EitqbtODlErKvOeeEipkIM6qxq55ZdqKsDXU/07VrDlSY8+0eF2mNsEq5lWaIp9G+GmLUenJe
	YJKWd0/IKD6papqUwXrGyKPKqMRk7gjNJk+NHpTxdaY8Y/MBrni7l1gjQ3qsLznmTA0C9jWJLCN
	505FP/YuFTfSHNCAFEqOmTRS6u1t/goOZF/a8vtMagfea/lTFXfcfrmqE=
X-Received: by 2002:a17:903:4b27:b0:2a0:d05c:7de3 with SMTP id d9443c01a7336-2a76923cebemr33428955ad.15.1768967080464;
        Tue, 20 Jan 2026 19:44:40 -0800 (PST)
Received: from [192.168.86.157] ([136.27.45.11])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a784af4269sm17959895ad.77.2026.01.20.19.44.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Jan 2026 19:44:40 -0800 (PST)
Message-ID: <11241110-6bd5-4b06-8d4c-55e52c571ff6@davidwei.uk>
Date: Tue, 20 Jan 2026 19:44:39 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 05/16] net: Proxy net_mp_{open,close}_rxq for
 leased queues
To: Jakub Kicinski <kuba@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, davem@davemloft.net,
 razor@blackwall.org, pabeni@redhat.com, willemb@google.com, sdf@fomichev.me,
 john.fastabend@gmail.com, martin.lau@kernel.org, jordan@jrife.io,
 maciej.fijalkowski@intel.com, magnus.karlsson@intel.com, toke@redhat.com,
 yangzhenze@bytedance.com, wangdongdong.6@bytedance.com
References: <20260115082603.219152-1-daniel@iogearbox.net>
 <20260115082603.219152-6-daniel@iogearbox.net>
 <20260120180402.2b9ab13a@kernel.org>
Content-Language: en-US
From: David Wei <dw@davidwei.uk>
In-Reply-To: <20260120180402.2b9ab13a@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2026-01-20 18:04, Jakub Kicinski wrote:
> On Thu, 15 Jan 2026 09:25:52 +0100 Daniel Borkmann wrote:
>>   	if (!netdev_need_ops_lock(dev))
>>   		return -EOPNOTSUPP;
>> -
>>   	if (rxq_idx >= dev->real_num_rx_queues) {
>>   		NL_SET_ERR_MSG(extack, "rx queue index out of range");
>>   		return -ERANGE;
>>   	}
>> -	rxq_idx = array_index_nospec(rxq_idx, dev->real_num_rx_queues);
>>   
>> +	rxq_idx = array_index_nospec(rxq_idx, dev->real_num_rx_queues);
> 
> The white space changes here look haphazard.
> 
>> +	rxq = netif_get_rx_queue_lease_locked(&dev, &rxq_idx);
> 
> I really hate this function but I don't have any great suggestion on
> how to make it better. I'd prefer if there was a clear separation
> between the case where we call directly, vs where swapped the queue.
> Instead of replacing pointers passed in by reference :| And that'd
> remove the conditional locking too.

Yeah :/ I will clean up the unnecessary whitespace changes and pull out
the checks at least. The current way makes it easier for the callers as
they don't need to distinguish between direct vs swapped. But, I do
appreciate how awful it feels.

I can try moving netif_get_rx_queue_lease_locked() out into the callers
and see how that feels instead. __net_mp_open_rxq() will then fail for
virtual netdevs.
