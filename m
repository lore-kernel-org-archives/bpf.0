Received: from out162-62-57-87.mail.qq.com (out162-62-57-87.mail.qq.com [162.62.57.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0F3175A6E;
	Thu, 16 Jul 2026 08:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784189830; cv=none; b=bzI7hbQtjkSygOKOT68d0EEWi1ioode4OoSSCRrb36O4nCIyC3ltbxMEKqKBcpLA7jGLtskh2zPkMcQMjs5IxSQ3msObsuboTCxIzkXFlctQbalty9VU5t+hXRGkxvZ/QmSdONCzAKh/lXsHbw8X7MRwexg0R1l/bDgxEffB4s4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784189830; c=relaxed/simple;
	bh=7M1euXencXzIlDVpxTFxV6wP03qFaroaKLzx/mimEgA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RQCq8mlMSA+yvqztQdL2hXffcKe9eCDhCE3ZxwqCilE44UZJ2SB2hz4CnmLnFiOZ5rTmd+ZtwuNgZY2+3smxBV1rb2PWlVUnbAKR+YBPTgXKsHloureQKDKVt//Ckwv/m6DRZGdXbo34JWB/4Pw5zogCWAKEi4m4tih0P53f9AE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=ClJSA2Rk; arc=none smtp.client-ip=162.62.57.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="ClJSA2Rk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1784189815;
	bh=Xa6BCkgk1/fC2Dtic/mhFxC5RTU1WybD9TKKB1/aG0s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=ClJSA2Rk9otcFbgo3H2xbkEak6zQWA07IZM32ahtsDpoBrcO524BBOOp0hZFSFwZJ
	 2csxRVHWgKXU0NU2j6UXaS/QLl3Lwu01PYswW+UatjXEWVa36bheueP8pnkHMEUn49
	 9L/JPEM9Wvy6+h9+vsnrj22UbHanlMHDrMSFB3dw=
Received: from [10.56.52.25] ([39.156.73.14])
	by newxmesmtplogicsvrsza73-0.qq.com (NewEsmtp) with SMTP
	id 433A521D; Thu, 16 Jul 2026 16:16:51 +0800
X-QQ-mid: xmsmtpt1784189811t3ksvzp5h
Message-ID: <tencent_0BA3FA88A206504220597897E32A65AF5B08@qq.com>
X-QQ-XMAILINFO: NC4p7XQIBeahPzKyZrtfPErppj8koITcZq5B+TiD/0Z/apDEt6EYMD3n4Kapwh
	 g6fdOwQ9ACtUMfZ8/O4sqMqnWRjDhqY5Fc/Zejz4lkvcO0JsUBy1PHua3r5c+1pV2l3IGvwVKlpx
	 eG8qt8Cr3tHv3jP2Cq3lbClQtnzeCE7ER+YeWkRyCx3OIJ59AWuS3R5znxzwj7of+ehTzv/uiHAG
	 ZbE9ss/j2ntE/H1oxXYevmyoCPLGtbVtvBuvLO3VkIDSkpOGp7ZcGoRffpaa6C0OUpFwUGrxm4yZ
	 HWFt8cpObM+l6lk1NlikMJLgRiPjipIDJ/Hs3veMpZSwEodYwksOS7ZFiwgoWwLKwvWRLHQLAXTl
	 2m6A+AXifOlkGe9kGHVZud1Tsr9SzW6dkrY7GccWgh7gCyEpkZw0DDNU3OlXNQ0lQohGnPM6yFjp
	 COHYP0wFglWIdj5eJ+3latfg3wy0lK+ua22kGuY+iBWBACW6MzR596wzbYXH66uZaR+3PEpgBKZM
	 r4mxhstJ3huu/PqXlrJkxKuTAPIPVPl1dJdZ+AscnB7gGLiVUoo6lD8UEAbLFmPzRsCe100nN97l
	 apy2bz/eNEr9vZ5gqKHSd0iifi3DPUdMbT7AO3RqtqCMmzKebZij9sHxuvpDrP+wEGISBj265uMz
	 0uBnK45s0Jioxh/3HHq+/OhH3j2UJqvUT6Giv8jRZ9x+djmVvh1knNZfijzEBWF7Y6tZxqM3pt4q
	 NcwRAwoVWU3yQL339zxq5FevDIOtt9Jr3CxBi639SHhzCeqYm5aJbwX7yxOg72oVynyH1pS/n12K
	 H9IOgeFRLRPutAbKc9D0w5DB9DS0CDykaA+MYedbr/55XirKEo9wTRaSdw96DC6q/g+IoNhaN2ma
	 oGyqztNL/PLzGQbizdmVYC4au8EYihrBZjYqVOgTm1gUp6UJS5YYFbAAqWwB1z7PPtgAvVX7sVZd
	 xSMYmk9wVdRdnEDtyAfAF1s7Nnj4Xu0jMn4c8AF944hgTfrPm24NMRSKsn4FSBst6tiDL4CA8qHs
	 Kjoce47mteH4YA/Kx0w4Msq5df9mRcCZmb9InMRw==
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
X-OQ-MSGID: <67c510f5-cb69-4b82-ba42-01a7c64bc000@foxmail.com>
Date: Thu, 16 Jul 2026 16:16:51 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 1/2] bpf: add bpf_strcat,bpf_strncat kfunc
To: Viktor Malik <vmalik@redhat.com>, andrii@kernel.org, ast@kernel.org
Cc: Rong Tao <rongtao@cestc.cn>, Daniel Borkmann <daniel@iogearbox.net>,
 Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Emil Tsalapatis <emil@etsalapatis.com>, Shuah Khan <shuah@kernel.org>,
 Yuzuki Ishiyama <ishiyama@hpc.is.uec.ac.jp>,
 "open list:BPF [GENERAL] (Safe Dynamic Programs and Tools)"
 <bpf@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>,
 "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
References: <cover.1784078494.git.rtoax@foxmail.com>
 <tencent_9EC04DC824CBF5124305E73564341511C405@qq.com>
 <58e45629-e959-4995-afc8-900b5c5d691c@redhat.com>
Content-Language: en-US
From: Rong Tao <rtoax@foxmail.com>
In-Reply-To: <58e45629-e959-4995-afc8-900b5c5d691c@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 7/15/26 16:56, Viktor Malik wrote:
> On 7/15/26 03:27, Rong Tao wrote:
>> From: Rong Tao <rongtao@cestc.cn>
>>
>> Add string concatenation kfuncs, prototype:
>>
>>    int bpf_strcat(char *dst__ign, u32 dst__sz, const char *src__ign);
>>    int bpf_strncat(char *dst__ign, u32 dst__sz, const char *src__ign, u32 len);
>>
>> This differs from the glibc library functions strcat and strncat, which,
>> for safety reasons, require the size of the target string's memory space
>> as a parameter.
>>
>> Signed-off-by: Rong Tao <rongtao@cestc.cn>
>> ---
>>   kernel/bpf/helpers.c | 92 ++++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 92 insertions(+)
>>
>> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
>> index c18f1e16edee..401f94efd687 100644
>> --- a/kernel/bpf/helpers.c
>> +++ b/kernel/bpf/helpers.c
>> @@ -4195,6 +4195,96 @@ __bpf_kfunc int bpf_strncasestr(const char *s1__ign, const char *s2__ign,
>>   	return __bpf_strnstr(s1__ign, s2__ign, len, true);
>>   }
>>   
>> +static int __bpf_strncat(char *dst, u32 dsz, const char *src, u32 sz)
>> +{
>> +	int dlen, slen, space, copied;
>> +	char cs = '?';
>> +
>> +	if (!copy_from_kernel_nofault_allowed(dst, 1) ||
>> +	    !copy_from_kernel_nofault_allowed(src, 1)) {
>> +		return -ERANGE;
>> +	}
>> +
>> +	dlen = bpf_strnlen(dst, dsz);
>> +	if (dlen < 0)
>> +		return dlen;
>> +	slen = bpf_strnlen(src, sz);
>> +	if (slen < 0)
>> +		return slen;
>> +
>> +	if (dlen >= dsz || sz == 0 || dsz == 0)
>> +		return -EINVAL;
>> +
>> +	space = dsz - dlen;
>> +	if (space <= 1 || space < min(slen, sz) + 1)
>> +		return -E2BIG;
>> +
>> +	guard(pagefault)();
>> +	for (copied = 0; copied < space - 1 && copied < slen; copied++) {
>> +		__get_kernel_nofault(&cs, src, char, err_out);
>> +		if (cs == '\0')
>> +			break;
>> +
>> +		__put_kernel_nofault(dst + dlen + copied, &cs, char, err_out);
> I don't think that we need __put_kernel_nofault() here. My understanding
> is that since we don't use the `__ign` suffix for the destination
> string, the verifier should make sure that `dst` points to a valid
> memory with sufficient capacity (thanks to the `dst__sz` arg). We could
> use `strncpy_from_kernel_nofault(dst + dlen, src, space)`, which makes
> me wonder how would `bpf_strcat` be different from directly using
> bpf_probe_read_kernel_str().

Indeed, bpf_probe_read_kernel_str() and bpf_strcat() seem to have no

fundamental difference. Perhaps helpers are not as convenient to use

as kfunc? For example, in bpftrace's stdlib, to avoid including certain

header files that would make it inconvenient to use helpers, one would

have to use a complex method like asm() + BPF_FUNC_ to call the helper.

Using kfunc is much more convenient.

Rong Tao

>
> Viktor
>
>> +
>> +		src++;
>> +	}
>> +	cs = '\0';
>> +	__put_kernel_nofault(dst + dlen + copied, &cs, char, err_out);
>> +
>> +	__get_kernel_nofault(&cs, src, char, err_out);
>> +	if (cs != '\0' && sz > copied)
>> +		return -E2BIG;
>> +
>> +	return dlen + copied;
>> +err_out:
>> +	return -EFAULT;
>> +}
>> +
>> +/**
>> + * bpf_strcat - Append non-null bytes from a source string, and null-terminate
>> + *              the result
>> + * @dst: Destination string.
>> + * @dst__sz: Maximum bytes of @dst__ign, includes the trailing NUL.
>> + * @src__ign: Source string.
>> + *
>> + * Return:
>> + * * >=0      - Length of the concatenated string.
>> + *
>> + * * %-EINVAL - String @dst__ign is invalid.
>> + * * %-EFAULT - Cannot read or write one of the strings.
>> + * * %-E2BIG  - String @src__ign is too large or the remaining space in
>> + *              @dst__ign is too small.
>> + * * %-ERANGE - One of the strings is outside of kernel address space
>> + */
>> +__bpf_kfunc int bpf_strcat(char *dst, u32 dst__sz, const char *src__ign)
>> +{
>> +	return __bpf_strncat(dst, dst__sz, src__ign, XATTR_SIZE_MAX);
>> +}
>> +
>> +/**
>> + * bpf_strncat - Append non-null bytes from a source string, and null-terminate
>> + *               the result
>> + * @dst: Destination string.
>> + * @dst__sz: Maximum bytes of @dst__ign, includes the trailing NUL.
>> + * @src__ign: Source string.
>> + * @len: the maximum number of characters to concatenate
>> + *
>> + * Return:
>> + * * >=0      - Length of the concatenated string.
>> + *
>> + * * %-EINVAL - String @dst__ign is invalid.
>> + * * %-EFAULT - Cannot read or write one of the strings.
>> + * * %-E2BIG  - String @src__ign is too large or the remaining space in
>> + *              @dst__ign is too small.
>> + * * %-ERANGE - One of the strings is outside of kernel address space
>> + */
>> +__bpf_kfunc int bpf_strncat(char *dst, u32 dst__sz, const char *src__ign,
>> +			    u32 len)
>> +{
>> +	return __bpf_strncat(dst, dst__sz, src__ign, len);
>> +}
>> +
>>   #ifdef CONFIG_KEYS
>>   /**
>>    * bpf_lookup_user_key - lookup a key by its serial
>> @@ -4958,6 +5048,8 @@ BTF_ID_FLAGS(func, bpf_strstr);
>>   BTF_ID_FLAGS(func, bpf_strcasestr);
>>   BTF_ID_FLAGS(func, bpf_strnstr);
>>   BTF_ID_FLAGS(func, bpf_strncasestr);
>> +BTF_ID_FLAGS(func, bpf_strcat);
>> +BTF_ID_FLAGS(func, bpf_strncat);
>>   #if defined(CONFIG_BPF_LSM) && defined(CONFIG_CGROUPS)
>>   BTF_ID_FLAGS(func, bpf_cgroup_read_xattr, KF_RCU)
>>   #endif

