Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 956021A239A
	for <bpf@vger.kernel.org>; Wed, 18 Feb 2026 18:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771440435; cv=none; b=VkNxY5ohs0IfU1ohOTuyiDsWm6+4pWfrx3RHK95eWbmBnI52+Txgj20aA012+9A0Hs9VhawMX4mmrXhBrmCWk9aL376OL3vo5dg1DrISWv4brgoKFKNBRAKp+YWGsjtETo4X48iuufUwoAbEBvsTTwIBOKbQEcucL3rP3CapIuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771440435; c=relaxed/simple;
	bh=Iv+hIlAezaKfnuKpXvopMXCkXB721UOrG1pM8I359lc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tJCda9f8fsI0CIXpklo7RVsvQ+1w5sBQLkQ2GkZVR9ugX6GgDJHYSh5QVgLdPfvYTw99Hi+D88X5PfmLkEX75Q70SZ2+UOeIhRF6sOTZRNI6cXrhJXS8GyVOLw2LZNiyvHVqQ3jjizvUY5zu0DZ3da+xxqZucb5FucgfodzUoNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=euH1egHf; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="euH1egHf"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-4376de3f128so125876f8f.0
        for <bpf@vger.kernel.org>; Wed, 18 Feb 2026 10:47:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771440433; x=1772045233; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=u8ZKglBvPnhFbBjcuYSWRHqG1F2jNJyd9TBe00BveAo=;
        b=euH1egHf2J+DUayxaS3eRHI4kFRMweC5o8wdzVBbsLviOVwxLsexTwHF8fl5OyKSvI
         yDqJtfmlK69Z9QGpoP6p/VltuSw/DuSlJC82Anxp2/74w2UZ6g6YSTfup/YZZ6SIvGuo
         3xH7eU90nALwAldsHRY/KpX2hmLjPAWQ48Jl1m7+S3raNRIq24SRZ9t9mmzd72dBVMI5
         4VU8YEPcXJa0arJ5n0KhCNXRRtUgrk3XVrxGUUDoA8llX294oRUk4HP8yBXclpxB83Jd
         /4FFtIW00hLb4TKj+ACIE22aymJ3YRwOKciPmzj7E2puKpz3HVcvhHE/YnZ5fXRr2hWm
         ANJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771440433; x=1772045233;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u8ZKglBvPnhFbBjcuYSWRHqG1F2jNJyd9TBe00BveAo=;
        b=taIA3NAHmjl47PJvi7AhXb4aB8VKzbSOzVJMl0pVrdP70HSpHjWfb0YobkvcnoR6JW
         P95lBlv6nnkeduc2jTdSjNphvPmnDPEGQHkfNlO1a6S0KY8g4xGUlapD13FiuOhhST4a
         YmWhAZez4O6Hi3lBetUXITffPUB7f9yi8687Mr3K+MIhfpgc8DVoaY/Q+N5tQ8BxmtYU
         Xyjfbpsy70IIO3eh/esPa3k/b8cYUJKm3P3i6E064a4GbZZdSeX1xSANnf27EBcMlEZQ
         kd0EtZi1QC/hwgGPnvqfEwkkA1Ux4hGh+eG/yNLyzAcJ5F3jd/+2MAL7sfMOhKovQjKn
         yz3Q==
X-Forwarded-Encrypted: i=1; AJvYcCVYyJamODU9tjVn7ksHcYq+5LppSvBRTEJ8Gobi3KeIZkObIYqwLtrg7BDOI+LjuyLPLHo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNRaKMMlGeCc6o4R4AlsS54vxJ0jAa7GG84CrGVcMXHgNkWa7B
	wsGpV0YXYwqiwf1B8bOQ1ObZg50Z5u9rAQ4hzJt82siyYVxNSuoduNV8
X-Gm-Gg: AZuq6aIktpnR0qJco9WCy2VWW9A3dKIVVNe7gDBaNNuS03pWfS9n7aZ+d0N5mqbcVnm
	Pu2lAj8VR2uf2a7UBUi/ye+fnymcCOwLpBWafDJinKslMRyviWJHt8YNzCEZZa8bpmtN2ybEFtG
	yCvVmWYWdU/UgIq4rnx2ZW0wEBhQJP+bYbr9+2FYy/FXC/m3TjBMOxNKC0J2YTSHnOuSt6kzHfF
	6a1yGy+ZNnbMQpYA1Co85dpxWETkc/6axTI46Ag5SrsBj7AuCoEvCZobg7b196y17nM8+Q5La7h
	ixCzbcZHBlxxLzep0/+1pADlATjnxQ+N9gSZxX9Dh6HGXITuucRSBkbyjoZuNojypxT7uI2pUAX
	mxF89FdeegENKI3SejfX1xpJ5P+qTC3/ZO+bPStEWP+9c/lZynTZDXMfrGS3b5jkGmzTUfBYCvw
	j6zJ/7q8FcX2k0AebhCCNPgXJHrzUeCDKk6OgcZ0SnuNRYJ6ft8Aik81blX0F7KE8=
X-Received: by 2002:a05:6000:2c0c:b0:437:6a74:3e4e with SMTP id ffacd0b85a97d-4379db33f5fmr29583655f8f.12.1771440432728;
        Wed, 18 Feb 2026 10:47:12 -0800 (PST)
Received: from ?IPV6:2a03:83e0:1126:4:93ab:614:2c34:ab35? ([2620:10d:c092:500::6:66e8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43796a6a5e5sm41264845f8f.9.2026.02.18.10.47.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Feb 2026 10:47:12 -0800 (PST)
Message-ID: <745c48cc-e8e9-4d31-8a4c-acfaec89cb41@gmail.com>
Date: Wed, 18 Feb 2026 18:47:10 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf v2 09/15] selftests/bpf: Fix double thread join in
 uprobe_multi_test
To: Ihor Solodrai <ihor.solodrai@linux.dev>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman
 <eddyz87@gmail.com>, Jiri Olsa <olsajiri@gmail.com>,
 Mykyta Yatsenko <yatsenko@meta.com>
Cc: Amery Hung <ameryhung@gmail.com>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-team@meta.com,
 =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
References: <20260218003041.1156774-1-ihor.solodrai@linux.dev>
 <20260218003041.1156774-10-ihor.solodrai@linux.dev>
 <53f7ac2f-3e7f-485e-ae46-040518ee7610@linux.dev>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <53f7ac2f-3e7f-485e-ae46-040518ee7610@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/18/26 17:54, Ihor Solodrai wrote:
> On 2/17/26 4:30 PM, Ihor Solodrai wrote:
>> ASAN reported a "joining already joined thread" error. The
>> release_child() may be called multiple times for the same struct
>> child.
>>
>> Fix with a memset(0) call at the end of release_child().
>>
>> Acked-by: Mykyta Yatsenko <yatsenko@meta.com>
>> Acked-by: Jiri Olsa <jolsa@kernel.org>
>> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
>> ---
>>   tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c b/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
>> index 2ee17ef1dae2..be6ff1d4a75b 100644
>> --- a/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
>> +++ b/tools/testing/selftests/bpf/prog_tests/uprobe_multi_test.c
>> @@ -68,6 +68,7 @@ static void release_child(struct child *child)
>>   	close(child->c2p[1]);
>>   	if (child->pid > 0)
>>   		waitpid(child->pid, &child_status, 0);
>> +	memset(child, 0, sizeof(*child));
> The CI is failing because of this change.
>
> Apparently, there are asserts on child object after it's released in
> kick_child(), so we can't just memset it (without changing the test
> logic).  The previous version of the fix [1], resetting only
> child->thread, is more appropriate I think.
>
> I missed this because uprobe_multi is in DENYLIST.asan
>
> I'll wait a bit in case there is more feedback and send a v3.
I think it's more logical to memset it before the test run,
not after (in release_child()).
>
> [1] https://lore.kernel.org/bpf/20260212011356.3266753-10-ihor.solodrai@linux.dev/
>
>>   }
>>   
>>   static void kick_child(struct child *child)
>
>

