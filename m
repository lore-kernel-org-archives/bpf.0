Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD1B58AC5
	for <bpf@vger.kernel.org>; Tue,  5 Mar 2024 10:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709634937; cv=none; b=OSt3bdA6wm50Wyz2AMBSfuHPrQYazJYj2YEOGiX3n/bpY8HnkMJdwM0aLjXF0V+7cUA//ybMRSXKqy4jM8rCpLZRVQW3R3n45nkLqJleodRFD07AksGtmT86A0bWm8Y3Pwc557FNK6NIcxHxR+tDLePlejAzK1YPzLC3gPxjLac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709634937; c=relaxed/simple;
	bh=tpzU2Gi0/AnulmYII+MNLu+H3Gp0lMpW5v/XfS3XHKY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bKxsk611bhsfjS8vB0nisP1uvAdjuXCsTDkPcTM4ophI7yZeFlMmUFa7vRYITVj3HtaMQEn1AGYsxp4dSzWPNcE30q+RFgjhnqsnEexGLc2umpWAalB3bFfFQxXN+xNYO9+HrjvEPPKwC3778dHw5WEHdJ9e2TeYBaiExB9pN/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=TU8mEer5; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="TU8mEer5"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-512bde3d197so5391126e87.0
        for <bpf@vger.kernel.org>; Tue, 05 Mar 2024 02:35:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1709634934; x=1710239734; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rEsdEFT0O971Nqh1xcDFdrQYqDc9+PPbmxuFaPln9Og=;
        b=TU8mEer5BqkefumuZoF7Kbp1I2jH9Gum9IOHsG965NVZZatTaZGVaAlJ0ZbHsbwdN6
         kAoM2spb2V7SE3ipmF59hi0MCV8JQBkhbHCd/58CwJfOzdrR2cpLJsMW7SMnaEFXVMBy
         aKyyIjCF7hGDtPCGA+N7d40q4iin7MqWvHh528kI6d7Xnrq3ttZcl9bnuFnRZYJR8JjX
         8qRry2UIyHv8DMTq1Zhg/ky3SUucHj1Fbc+4LolVri/m5yx5MIQBQwSSCMQX7kwixFrZ
         W/2n8QgdIONMZPl7ZUmwklk93+8H/KrRyPWf4Bwv9r4tntnf6W780uuM33xqnfIWO71b
         HiAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709634934; x=1710239734;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rEsdEFT0O971Nqh1xcDFdrQYqDc9+PPbmxuFaPln9Og=;
        b=eYN7/fTRdF/VRaciKSZh4hOYvXrb4r501nIee+XULbQByzBiDK0i4f3A07SfCIBMXu
         b0Mk33nc5/bWg4PAo57rsW9p+21HKdSo3+w0TxFGSkTDJJDZJegZrf3ulKBqVlae3tRl
         7SG88gCCaHwYK6xVjchOM5/Ymu2O2MHe3rCiWtTQqd+d4zJ+XPs/CL9AEs7Vassh/WiW
         CQkk/kkBB9wWFL8Tng9kUqxR4w7ekkRFNWvmyYIHoylg2SLZQOUhBrPYZB/DPaor4hNI
         0jc/inGA41ZRo0WTGh4zky1urLRY232Xsyx6OknCtdbuilYv4umE3figEAVNfAfeBmRm
         cvAg==
X-Forwarded-Encrypted: i=1; AJvYcCV8Zhbt3dOt09NYrjQHJuOr6ayrMmxbMZTeRpPZA5bfB5OCO5Evk83aWN5Nc7AmyxuFJ5qLLQ2xtIVYMcyDqcUye3sp
X-Gm-Message-State: AOJu0YzXwctjo5ikDu+XsuhxgrwEHGys05hufd72OkAS0tb4kIaLOvgT
	pRRtlBO2egbycr/ljbsOagZ3EDfBLUaN5CPJsoySwTkOIfqoR9LDfKnWtp8V938=
X-Google-Smtp-Source: AGHT+IE//GyerJqIDpUUpnDHInaUvMbhuHLx2hNhRTHLESU7aAeuJPJJCU7w3k95VPQctMIpBDRUtA==
X-Received: by 2002:a05:6512:159c:b0:513:588a:262f with SMTP id bp28-20020a056512159c00b00513588a262fmr66748lfb.39.1709634933919;
        Tue, 05 Mar 2024 02:35:33 -0800 (PST)
Received: from ?IPV6:2a02:8011:e80c:0:7312:bd04:dac0:d180? ([2a02:8011:e80c:0:7312:bd04:dac0:d180])
        by smtp.gmail.com with ESMTPSA id m9-20020a05600c4f4900b00412ec373ad4sm1749847wmq.27.2024.03.05.02.35.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Mar 2024 02:35:33 -0800 (PST)
Message-ID: <2f65b98c-a442-4316-884c-a877233edc60@isovalent.com>
Date: Tue, 5 Mar 2024 10:35:32 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next] bpftool: Mount bpffs on provided dir instead of
 parent dir
Content-Language: en-GB
To: Sahil <icegambit91@gmail.com>, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org
Cc: martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@google.com, haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org
References: <20240229130543.17491-1-icegambit91@gmail.com>
 <3290360.44csPzL39Z@valdaarhun>
 <2aeecee4-3499-4036-8c26-59ccffc2c6ab@isovalent.com>
 <2347452.ElGaqSPkdT@valdaarhun>
From: Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <2347452.ElGaqSPkdT@valdaarhun>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

2024-03-04 20:34 UTC+0000 ~ Sahil <icegambit91@gmail.com>
> Hi,
> 
> Thank you for the reply.
> 
> On Monday, March 4, 2024 7:20:40 PM IST Quentin Monnet wrote:
>> [...]
>> Splitting the function was a suggestion, but you don't *have to* do it.
>> What matters is the clarity of the resulting code, we want the function
>> to be easy to follow and to not mix the file vs. directory paths too
>> much (or then it's very easy to introduce bugs such as the existing one,
>> or the missing --nomount check in your v1). Don't focus too much on
>> malloc()/dirname() here, just make the logics easy to understand.
> 
> Understood, I'll refactor it accordingly.
> 
>> [...]
>> If I understand correctly what you're asking, for files, "is_dir" would
>> always evaluate to false so this check would be useless, wouldn't it? So
>> yes we'd remove it.
> 
> This is the first part of my query.
> 
>>> If "is_bpffs(name)" returns false, then that could imply that the file
>>> exists and its parent dir is not bpffs, or that the file does not exist
>>> and no comment can be made on the parent dir. In either case the malloc
>>> and dirname will have to be done.
>>>
>>> On the other hand if the file exists
>>
>> Note: We handle the case where a directory exists, not when the file
>> itself already exists. If the file exists we get an error when trying to
>> pin the program.
> 
> Right. And this is related to the second part of my query. If the file already
> exists, an error should be thrown. But if it does not exist and the dir is not
> bpffs, we'll end up doing:
> 
>     is_bpffs(name) // in the condition mentioned above
>     [...]
>     dir_name = dirname(name); // get parent dir name
>     is_bpffs(dir_name) // call is_bpffs again
>     [...]
> 
> So, in the "if" statement below:
> 
>     if (is_dir && is_bpffs(name))
> 
> will it be better to remove the second condition as well, and in lieu of that
> we could simply run dirname() and is_bpffs(dir_name) if the function gets
> a file as an argument?

Yes, we should remove this second condition too for files. Running
"is_bpffs(name)" makes no sense as we know we'll have an error at this
point.

What we could do to improve the current code, however, is returning an
error from mount_bpffs_for_pin() if the file exists, rather than
mounting the bpffs and waiting for bpf_obj_pin() to return the error.
This would prevent bpftool from mounting the bpffs when we already know
the operation will fail.

Quentin
