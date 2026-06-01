Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E0AF37BE7B
	for <bpf@vger.kernel.org>; Mon,  1 Jun 2026 19:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780342684; cv=none; b=tvpo2zUi2RQSKYACyM7cvMvdM9C5LgMbAd5F7yoQC5wwKIr9ap95V2+r5/Ss8yu0/WlqJXt1AI+7g0dNVL576GW2rHDZyuNrBTLqfnYOD+hcs2pEV9lwuu+mOjCf1mN5VXKkRJJ8kIh6Z+bvRlCMyMOM21/zPAmZ/ecjOMh413s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780342684; c=relaxed/simple;
	bh=yn8QoO6B++RiDRZWpnVl7nEGtcOXXjzMEp/aTYMO544=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XFqf26JU89C9wEth6CPqNin9u0NulqHlOinDXVvuhSvc162j6ZrI7WIdGefNrg320+2+rSCQnxycO9xpd3sQ/AzP7ROtPVndpqSMnbhoK063KF8v/fmUUqs5LMgA/ju6HaagkqvK9HyulQ6Oey/mWLZus/G7AoNOTdMn6hRtTZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cS+XbDN3; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cS+XbDN3"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-49050bfe053so74117955e9.3
        for <bpf@vger.kernel.org>; Mon, 01 Jun 2026 12:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780342682; x=1780947482; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=koHEWg7rZ9rnh8BMaCzEjh5C53SqOp62+G2T65KEvcg=;
        b=cS+XbDN33dNX6QGBXctU6aqa6dzqZGTN9FMCsOxo67/jab17BYGzXBwozPFU8Nt3yJ
         njLbQBnJstHsHJo2l56WkWNUtWtTi88oGOk/iVriakEqUBHu7p1DfNtv5ZrXnWrdGulU
         vadYC4H53KhMJufNbmbKARd+iz4/FUF+ff/s/7cRTL4XOc1VuRYpY46vHMIAwhpO9gxV
         XnRp+qWxNjZUHBDcmrOAmVe+/ML4wcpBjWsJQT3Xf1nIfWTCdTVJuBzdSZqFpKOSuJt7
         cLOZRxuQHo8FZi5w3KfCeuuJe+bgf//VMx1Z8vxmhH1sbonFynJhdRSbv7x8CJKFmiBt
         Q/Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780342682; x=1780947482;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=koHEWg7rZ9rnh8BMaCzEjh5C53SqOp62+G2T65KEvcg=;
        b=YD/CJ+sV6tQ2aEF43+BajdVODyxn/B1tc/bEBHojxDTELWC0aw2kF1MyNQSCAHxOcJ
         Uz/zbep42VXdhNBCMdyZBFHBeb8oF4mxbm97OwWAC53P0pkV8OOLsmPZy2uhzygtK/C4
         Ae2+A2rmXpGx6cnZN/DfOhpdOr9mSV87ykaV+CdXY6SEdJa2Nyi3TGHIPgXl5QHcbDiS
         6qH5kmLX96dBmDNIkndFgGHznVDMBs+Ckyvhq2Gb39jBdbgOzh8I788heiLtBFRRXSWt
         rLzwFsZ9uBDWjrd601btQyYLae3x+Fqy76XXBxqiyiUOp1fjUoSEZ6Z9cuGxsby7vNxq
         xunQ==
X-Gm-Message-State: AOJu0YxmgNEpfPOpe9j4GRiBZPndTmmDnsnTiDOfpwRyDJNHONj0zHS0
	hUEY9JKQcQet+nlYZgpl5VbnuQi7Tg8fEqtwrKJWOpGrvVYC0MqY9Sjd
X-Gm-Gg: Acq92OG/HBKp+kh9NgcTkN/X4eibxZJOJcglAerEvvgv8awVFV/bQAtJSCD/j6QT+Hb
	O9mBJiIAaiWHQfd/nyYk3Aotajgbu7SIcicwkWgj/AlkNDuN0R3ODa2cfa3RL0fIqWJjFKsOV/v
	eVmpWDcJkU7r+XJheJr5dSNnmsFNDINyXsI2VOAzID5nb3izQpWx9nNadkFGW7oUkOnkbpHWDcR
	dSVxG1SZAw/n0ThcEJ8yeBC2Apud+iBppaqzuAPki7QwOCnvzQse0DmsU16gXVljY7u8i0hQAww
	PT6md6uqrZ00+tdZwJKijX2rQmyHZTYFtBHj84OX9+UQ2KPlkPzq0LuNvDtAlgfpyTUoR3VSYV5
	G2i9lmgP2RaMfW8ETJC1o+lS0uWrEYDM2/gEYUx/aj1czsS1IY3Fgzc7Eskw6H0wTUCZ7rd4sgW
	0LPpq38engw5Jfuij74Vy8zU7kzJsAz4zXW6PSwXkLtROGpj7XDnga0UpHrd76FjX0pHCFjxHim
	E95xRqbcFwG6MnBE9k4Vg==
X-Received: by 2002:a05:600c:3b10:b0:490:b0df:9eac with SMTP id 5b1f17b1804b1-490b0dfa72bmr15593725e9.3.1780342681385;
        Mon, 01 Jun 2026 12:38:01 -0700 (PDT)
Received: from ?IPV6:2a01:4b00:bd1f:f500:f867:fc8a:5174:5755? ([2a01:4b00:bd1f:f500:f867:fc8a:5174:5755])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490b0e20bacsm12546705e9.6.2026.06.01.12.38.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jun 2026 12:38:00 -0700 (PDT)
Message-ID: <5b434d06-22fc-4f1e-9122-05261f1237ef@gmail.com>
Date: Mon, 1 Jun 2026 20:38:00 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v6 12/13] selftests/bpf: Test using file dynptr
 after the reference on file is dropped
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org,
 alexei.starovoitov@gmail.com, andrii@kernel.org, daniel@iogearbox.net,
 eddyz87@gmail.com, memxor@gmail.com, martin.lau@kernel.org,
 kernel-team@meta.com
References: <20260529014936.2811085-1-ameryhung@gmail.com>
 <20260529014936.2811085-13-ameryhung@gmail.com>
 <29eaa2d6-784b-4a12-acb3-099052ba0933@gmail.com>
 <CAMB2axOb0Bi9Xn5RS1J+n0_vdD2oFygAa1xCH6O3JR4JJfihyA@mail.gmail.com>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <CAMB2axOb0Bi9Xn5RS1J+n0_vdD2oFygAa1xCH6O3JR4JJfihyA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 6/1/26 7:42 PM, Amery Hung wrote:
> On Mon, Jun 1, 2026 at 5:05 AM Mykyta Yatsenko
> <mykyta.yatsenko5@gmail.com> wrote:
>>
>> On 5/29/26 2:49 AM, Amery Hung wrote:
>>> File dynptr and slice should be invalidated when the parent file's
>>> reference is dropped in the program. Without the verifier tracking
>>> dyntpr's parent referenced object, the dynptr would continute to be
>>> incorrectly used even if the underlying file is being tear down or gone.
>>>
>>> Signed-off-by: Amery Hung <ameryhung@gmail.com>
>>> ---
>>>  .../selftests/bpf/progs/file_reader_fail.c    | 60 +++++++++++++++++++
>>>  1 file changed, 60 insertions(+)
>>>
>>> diff --git a/tools/testing/selftests/bpf/progs/file_reader_fail.c b/tools/testing/selftests/bpf/progs/file_reader_fail.c
>>> index 0739620dea8a..d5fae5e4cf9a 100644
>>> --- a/tools/testing/selftests/bpf/progs/file_reader_fail.c
>>> +++ b/tools/testing/selftests/bpf/progs/file_reader_fail.c
>>> @@ -50,3 +50,63 @@ int xdp_no_dynptr_type(struct xdp_md *xdp)
>>>       bpf_dynptr_file_discard(&dynptr);
>>>       return 0;
>>>  }
>>> +
>>> +SEC("lsm/file_open")
>>> +__failure
>>> +__msg("Leaking reference id={{[0-9]+}} alloc_insn={{[0-9]+}}. Release it first.")
>>> +int use_file_dynptr_after_put_file(void *ctx)
>>> +{
>>> +     struct task_struct *task = bpf_get_current_task_btf();
>>> +     struct file *file = bpf_get_task_exe_file(task);
>>> +     struct bpf_dynptr dynptr;
>>> +     char buf[64];
>>> +
>>> +     if (!file)
>>> +             return 0;
>>> +
>>> +     if (bpf_dynptr_from_file(file, 0, &dynptr))
>>> +             goto out;
>>> +
>>> +     /* this should fail - file dynptr should be discarded first to prevent resource leak */
>>> +     bpf_put_file(file);
>>> +
>>> +     bpf_dynptr_read(buf, sizeof(buf), &dynptr, 0, 0);
>>> +     return 0;
>>> +
>>> +out:
>>> +     bpf_dynptr_file_discard(&dynptr);
>>> +     bpf_put_file(file);
>>> +     return 0;
>>> +}
>>> +
>>> +SEC("lsm/file_open")
>>> +__failure
>>> +__msg("Leaking reference id={{[0-9]+}} alloc_insn={{[0-9]+}}. Release it first.")
>>> +int use_file_dynptr_slice_after_put_file(void *ctx)
>>> +{
>>> +     struct task_struct *task = bpf_get_current_task_btf();
>>> +     struct file *file = bpf_get_task_exe_file(task);
>>> +     struct bpf_dynptr dynptr;
>>> +     char *data;
>>> +
>>> +     if (!file)
>>> +             return 0;
>>> +
>>> +     if (bpf_dynptr_from_file(file, 0, &dynptr))
>>> +             goto out;
>>> +
>>> +     data = bpf_dynptr_data(&dynptr, 0, 1);
>>
>> File dynptr is always read-only, so bpf_dynptr_data() always
>> returns NULL. Verifier does not know this (not sure if we should
>> address it). Maybe it makes sense to remove this call or substitute by
>> probe read, just to avoid confusing example.
>>
> 
> Thanks for taking a look at the selftests and pointing this out. Does
> replacing it with bpf_dynptr_slice() make sense to you?
>
 
That'll do, but bpf_dynptr_read() is more straightforward API for reading file
dynptr, as you always have to copy the data.

>>> +     if (!data)
>>> +             goto out;
>>> +
>>> +     /* this should fail - file dynptr should be discarded first to prevent resource leak */
>>> +     bpf_put_file(file);
>>> +
>>> +     *data = 'x';
>>> +     return 0;
>>> +
>>> +out:
>>> +     bpf_dynptr_file_discard(&dynptr);
>>> +     bpf_put_file(file);
>>> +     return 0;
>>> +}
>>

