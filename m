Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC1BC3DFC84
	for <bpf@vger.kernel.org>; Thu,  9 Apr 2026 15:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775748394; cv=none; b=RDIqa4uRqWGDmfG65dbwdMqKRYS4spCnly9WN6wKiFuxhd2AMV6BzbvWrY3aaGWTpPAsGUEF7Ys0EfjRb2Izmwkf/vfTMP6L+YsXdnI0hlBvn+v5/i9ee8GaldFbZryaNQuuJYrsPpZsTn7LwZScHeb2XxIAMhITw2Ixrnb91g0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775748394; c=relaxed/simple;
	bh=Vo5BdvgMKNwCv/sgsRcNCPktf/KjsVUtBqlPMGZ3I/g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n4Zp3Az/iyBjiHc6f9cOgiEUZXlDmEiU8PhSqPHkOy8gNHGZWJB81gCRIs2HT9b/zQtVC3vKHEVxVcQC8VuiqifrEzGYpUoMoV/ZprCN8HK+jmw9TxKuMHHZSgiBf/zhNsy3RpWk7/LxOReuT2hdsRJMedTsqdvV1Y5ZVBuzF7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20251104.gappssmtp.com header.i=@davidwei-uk.20251104.gappssmtp.com header.b=MOkDm60q; arc=none smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20251104.gappssmtp.com header.i=@davidwei-uk.20251104.gappssmtp.com header.b="MOkDm60q"
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-12c0433a4b9so3388478c88.1
        for <bpf@vger.kernel.org>; Thu, 09 Apr 2026 08:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20251104.gappssmtp.com; s=20251104; t=1775748393; x=1776353193; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BHRoQZNPAYM8bnXSy4YbYk14YDP/fBgqD6/mrZ9ntqM=;
        b=MOkDm60q97mgNfdUgLpbHtDm6YcHujdQCMnEAjPmrtcrcwF/0ChMcHE4Uokqe51nqd
         VR9EYIaEEwTbk3pv1Lrr6+aoGtkx4Jl/vyUffmbWHKSjwFrE6ZIC0+qy3KgwKhiU8c8v
         o01SU95PUoijrTYG5s58nwzHj0IiLebrNJ5uxGxYfiF1Qw9Q0ECAbsRtkbU4f7YiXHqF
         KtW3bD1y3NTocIqYkSNTcNJlBp1kSU6m+GhIe0+76acMP/Uimr2uRvIWj3wISqphgins
         THtUkqUs5v23i0pGBeGb3mQK6NJ9AtUD0SRQO6SRRbJWa6e8b2eJswAXqe4ZVqcY8KKq
         eFHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775748393; x=1776353193;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BHRoQZNPAYM8bnXSy4YbYk14YDP/fBgqD6/mrZ9ntqM=;
        b=ilK6SQh/GtXM/yeLRNaiNyfaSC6sVRQOotk6ltKNnd5GTfTRlx/O5ES24X6PYc9ZTX
         1HEiU2LqNiTRMHgJ6UFWwmdtRX/VBP5/xl1TGfWUHhnLiNRu2itCI+1slTlwaCIby6xj
         UQc/cJ4+JXs9J3iIANltDgC0bGyJEHzFn910I6AgxyB+Nm/9EAdq6+G2VXKF1/jXVKRV
         0t64giI5m/pr4kkMd8apQ8vjkaeua2GG9WwiulsyqsZxB4AesQhmbzERcBImx9ZjwDpC
         dw6f0EPnzatDogJkjmx/VbaWBFLSW+zmVnHoSx7FOZGAjsDd6bZl46A7VGfcCtPY4FLC
         +26Q==
X-Forwarded-Encrypted: i=1; AJvYcCWIaszGLeDW3WBxADImcds8fD/ClD0X3z5IsSg6vLBbmuW72NA3Tegnn0FFw0x5NdoWL+M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEJ1cCNqHJpAgG+Kh+sjlSeLYsIEJLkUOFJJc9OvU81mYtPshE
	5nEwYiGS7VFcJwmX92K503GNGIRT644nFmZgT6+p/XJ7Q1RGebXoxiBV+qo0LfZf3OY=
X-Gm-Gg: AeBDietPetTFfM6U/SQ0JeGiBljKN7n36BF39EeoFXigNsE1EUSpI4ex/f/bKQ7AB7p
	XwUuR1d0375ij8aGeldTYzfCTsFRezDkUbJKQL/vgnCi63FsmXpEpcJG39PiAOH544oO7aZ7ufc
	F1ttS7St/AHloYRvsR5yFSaGo0O1fVdyGbZqr0f/3V1Hc4RPx1luasvkk9PIL/2nPn0ZYG1XiLU
	NNMTN3Rf/sU2GO+3Kj5yJeZOb5KY6MO49I7caNZJ3IoEM6CE5bEZT+xwKWpj5ocpwFZ+2eJjvbj
	0qlgzihtrzN5446xohFYhyCE1gEh5Xjz0iE/5lfv34fs297XlT/qDXBJxujv4cJXxIGLnBn+2Y9
	uBSQrdE+KlGS8zlvDOY4Wv41C7pHAZGlNjR3dSd7/ipLRI651pXMOfWdPSG/R81hDV4ZbiiDehG
	tESMfNNnan3ZiBvD13u9UOYwoOBMqGOU2+5ieSsZQ5u1UJMBzfQVQKcz1wqxqvoloQtUIjO6PD+
	y4n1/2TaWIwbViIsoXkUy0A
X-Received: by 2002:a05:7022:7a4:b0:127:33e0:ea40 with SMTP id a92af1059eb24-12c28bf1e52mr2275147c88.15.1775748392572;
        Thu, 09 Apr 2026 08:26:32 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1156:1:c8f:b917:4342:fa09? ([2620:10d:c090:500::3:da93])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12c14a371b1sm12471884c88.13.2026.04.09.08.26.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Apr 2026 08:26:32 -0700 (PDT)
Message-ID: <244b745a-3c95-48c3-b6c5-11ed3eacdf46@davidwei.uk>
Date: Thu, 9 Apr 2026 08:26:30 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v11 14/14] selftests/net: Add queue leasing tests
 with netkit
To: Jakub Kicinski <kuba@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, davem@davemloft.net,
 razor@blackwall.org, pabeni@redhat.com, willemb@google.com, sdf@fomichev.me,
 john.fastabend@gmail.com, martin.lau@kernel.org, jordan@jrife.io,
 maciej.fijalkowski@intel.com, magnus.karlsson@intel.com, toke@redhat.com,
 yangzhenze@bytedance.com, wangdongdong.6@bytedance.com
References: <20260402231031.447597-1-daniel@iogearbox.net>
 <20260402231031.447597-15-daniel@iogearbox.net>
 <20260408162238.16709090@kernel.org>
Content-Language: en-US
From: David Wei <dw@davidwei.uk>
In-Reply-To: <20260408162238.16709090@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2026-04-08 16:22, Jakub Kicinski wrote:
> On Fri,  3 Apr 2026 01:10:31 +0200 Daniel Borkmann wrote:
>> +    ksft_run(
>> +        [
>> +            test_remove_phys,
>> +            test_double_lease,
>> +            test_virtual_lessor,
>> +            test_phys_lessee,
>> +            test_different_lessors,
>> +            test_queue_out_of_range,
>> +            test_resize_leased,
> 
>> +        # test_destroy must be last because it destroys the netkit devices
>> +        ksft_run(
>> +            [test_iou_zcrx, test_attrs, test_attach_xdp_with_mp, test_destroy],
>> +            args=(cfg,),
>> +        )
>> +    ksft_exit()
> 
> ksft_run() can't be called multiple times.
> 
> The first run looks like it's purely testing netdevsim. So that should
> move to selftests/net. The rest which tests HW should stay here.
> Please also move all the setup inside the test cases.

Sorry, didn't know about multiple ksft_run(). I'll prep the follow up
separately so we can land it soon after 7.1.
