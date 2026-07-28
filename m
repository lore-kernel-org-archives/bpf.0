Received: from out162-62-57-64.mail.qq.com (out162-62-57-64.mail.qq.com [162.62.57.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8659A2F25F3;
	Tue, 28 Jul 2026 02:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785207065; cv=none; b=ujByDDiyV6wSCInA0RKgjYjiJMiGIi23cJX8KvH1H3dUrBJy0Jf1cU/tIl4jVr/fukNbt2FDTiiiED4CfabyEqjEZoPB5J4HQSNpgvfZVeIV2nMtKiNdsCe+Sog7OHxeB+mhurUMYf58f4otui1+I4yW4bNoA7mX8L7uC/9eMKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785207065; c=relaxed/simple;
	bh=W0BDYtxuDDdRLOUW+Dp+LxIodUKthKlk9kd+76vX//M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QUcqIYfPbdHCcNRk6/4f2NZyN15yNR3LI799FhKywPAutVD4b+/QeJTdNmo6F+wFgzyBb/c6aVuIyFz4iU8SgIDM+S94KLW1O8ACt6jILyWeZcPMWOsRJHm7oBHirewWiVjbkCqIO7KORWFp7DRQWi57B9wS1Dhshe3T+hPOeUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=Mk9Vmt20; arc=none smtp.client-ip=162.62.57.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="Mk9Vmt20"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1785207049;
	bh=cW0TbNCISblwoiaULiHR+ZWC6JdcXp2rxqQLctE2VnU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Mk9Vmt20bk3Aoxd1gHH+7vbcFVUiZOB178RTWFm784elJGlLXUWmU4EWe9YMiFnVG
	 FI+D6PxfAcpQNe4a/0fPtXnVJGipAz+D5EOxICg/BkRljCjU2gcaIaJKYQ1wjRGS83
	 zU0yA85zga9aNH8RP4Yfatuoz4b7Q1wuoNFsZSzk=
Received: from [10.56.52.25] ([39.156.73.14])
	by newxmesmtplogicsvrsza73-0.qq.com (NewEsmtp) with SMTP
	id CAD2E6BA; Tue, 28 Jul 2026 10:50:45 +0800
X-QQ-mid: xmsmtpt1785207045tl40c9evp
Message-ID: <tencent_185F6B461110090D468588B2422E5955A409@qq.com>
X-QQ-XMAILINFO: OZsapEVPoiO6qM7uZ4+S4/crVvRsJwd18KbjZMQDojTlKNfqKjjCCplOw9PAQy
	 PVQeO+EAkQo5jKl+H1imUfVLK22X0ZhsdNs5lylSrHXtlzj7q39ovB15TPr3Jr12AO08bw08Ifa6
	 bBKCy/p1OKM2qn+Vrk0PBeLNRKRQTuDF87REDN3ktCiAeKi8OTepuiIV3hdB9h+fyqrJ2MUdKyZb
	 TBREELrZIWZ3d9mnsblXj++8nyBaL6cRcON6pb3EbqGDFH6zivYKO5wnJarGaf1gVslNkd+iqQpA
	 4/lV/G5D/28wUUv/JH5dKaz83k2Sz3xxsbG/wHmkfWANpzVN4BqoPAD0pyJSn/wlqlwTRByP9qx5
	 wBJX79rhKgYREVZp8TubJrB5JQxQvZEGy1zFZcrhQmJcLHXV2uIyrDSR4OEteZJ/KIQi2u0EA93n
	 94t17Frmd+bX6eev936cg68q9NLeG2C33xK50Tgl31bZ+6cl7fc7PJ++iyDerBddPLrZ4M/eMR5Y
	 GF6eRSWXO7TOjzax1la8pAEDuzIl38V3jPSqc6gTMgwzOfpc78OHLgSlMe+PP6Cgul/iO1P3eBbN
	 w/YQzUWs4Vw2PgaGhI749Qozu0nwaXDgOXIQvh9/Og3oK7L/ao35wTjZZAQVb9PIL2dGqPiKK6M0
	 kOC6iEQ6cw3x30pEFJIR2STg8pVKCH2ZReBC/BPKNz2JhlaOjICN+UFrYUN1Ow4A5gx6IGnwHUQH
	 Ip+ZA5JGH1RhUZq6BCP76zhklUQ2dohy+Q4pAO6qtOSiCdQ7gdyQDRfOacWQrfDjFx9iQljNC/vU
	 Qjf4YM2kRXAWbLsULFSj9/SH35t5FNDnPIovp/tRt8HvQpC4SBNVONZkTujCFqk04Sl8e3BHtEma
	 9PFtZRnjazbXzz5VcrEVdpkxMGLoAFXSBvwcr418VNLpaTBvPDnmoOuI47y8XrBl07wPrPfsUH/G
	 v8o62FwaihSe+0iHpmnx2aAcTF5igb0svrzYhmckewqr1NTBhDelVDLlDThdJyUVM22AGzu8wEY1
	 BPORCLf5X771zUT+elmG5bfuJR/nAeYcFwFxzawcmq6rTvrI+K6QnZdWZzUfu3KLbVlObYxDjfsF
	 j1ZwedE1PPWuStnxI=
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
X-OQ-MSGID: <f9a69aed-a050-4ca3-abe5-c32720534430@foxmail.com>
Date: Tue, 28 Jul 2026 10:50:45 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v5 1/2] bpf: add bpf_strcat,bpf_strncat kfunc
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: vmalik@redhat.com, andrii@kernel.org, ast@kernel.org, rongtao@cestc.cn,
 Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman
 <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Emil Tsalapatis <emil@etsalapatis.com>, Shuah Khan <shuah@kernel.org>,
 Yuzuki Ishiyama <ishiyama@hpc.is.uec.ac.jp>,
 "open list:BPF [GENERAL] (Safe Dynamic Programs and Tools)"
 <bpf@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>,
 "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
References: <cover.1784695085.git.rtoax@foxmail.com>
 <tencent_60882E4BE4F247C5F6D564F41BF1C3004805@qq.com>
 <CAEf4BzbRvjT3X=Ds+YqLiZt=A0ujk1t2GCDcmbdT3+QX+DsQDQ@mail.gmail.com>
Content-Language: en-US
From: Rong Tao <rtoax@foxmail.com>
In-Reply-To: <CAEf4BzbRvjT3X=Ds+YqLiZt=A0ujk1t2GCDcmbdT3+QX+DsQDQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 7/28/26 06:56, Andrii Nakryiko wrote:
> On Tue, Jul 21, 2026 at 9:42 PM Rong Tao <rtoax@foxmail.com> wrote:
>> From: Rong Tao <rongtao@cestc.cn>
>>
>> Add string concatenation kfuncs, prototype:
>>
>>    int bpf_strcat(char *dst, u32 dst__sz, const char *src);
>>    int bpf_strncat(char *dst, u32 dst__sz, const char *src, u32 len);
>>
>> This differs from the glibc library functions strcat and strncat, which,
>> for safety reasons, require the size of the target string's memory space
>> as a parameter.
>>
>> The src parameter cannot directly pass a string constant, such as "XYZ",
>> otherwise it will throw an error "write into map forbidden".
>>
>> Signed-off-by: Rong Tao <rongtao@cestc.cn>
>> ---
>>   kernel/bpf/helpers.c | 75 ++++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 75 insertions(+)
>>
>> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
>> index c18f1e16edee..85afff60365c 100644
>> --- a/kernel/bpf/helpers.c
>> +++ b/kernel/bpf/helpers.c
>> @@ -4195,6 +4195,79 @@ __bpf_kfunc int bpf_strncasestr(const char *s1__ign, const char *s2__ign,
>>          return __bpf_strnstr(s1__ign, s2__ign, len, true);
>>   }
>>
>> +static int __bpf_strncat(char *dst, u32 dsz, const char *src, u32 sz)
>> +{
>> +       int dlen = 0, slen, space, copied;
>> +
>> +       if (sz == 0 || dsz == 0)
>> +               return -EINVAL;
>> +
>> +       while (dlen < dsz && dst[dlen] != '\0')
>> +               dlen++;
>> +
>> +       if (dlen >= dsz)
>> +               return -E2BIG;
>> +
>> +       space = dsz - dlen;
>> +
>> +       slen = bpf_strnlen(src, sz);
>> +       if (space <= slen)
>> +               return -E2BIG;
>> +
>> +       copied = strncpy_from_kernel_nofault(dst + dlen, src, sz);
> I'm not sure strncpy_from_kernel_nofault() is designed to work
> correctly if dst can be modified concurrently. Which in BPF case, even
> though we validate that memory is correct, it still can be modified
> concurrently in such a way as to cause strncpy_from_kernel_nofault's
> inner dst[-1] based loop logic to go beyond the boundaries of target
> buffer.
>
> i.e., I don't believe current implementation is concurrency safe

Thank you very much for your reply. There is indeed a thread safety 
issue. Let's look at a solution. I will submit v6. Thank you ;)

Rong Tao

>
> pw-bot: cr
>
>
>> +       if (copied < 0)
>> +               return copied;
>> +       else if (copied == 0 || copied == 1)
>> +               return dlen;
>> +
>> +       /* The copied character count includes '\0'. */
>> +       return dlen + copied - 1;
>> +}
>> +
>> +/**
>> + * bpf_strcat - Append non-null bytes from a source string, and null-terminate
>> + *              the result
>> + * @dst: Destination string.
>> + * @dst__sz: Maximum bytes of @dst__ign, includes the trailing NUL.
>> + * @src: Source string.
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
>> +__bpf_kfunc int bpf_strcat(char *dst, u32 dst__sz, const char *src)
>> +{
>> +       return __bpf_strncat(dst, dst__sz, src, dst__sz);
>> +}
>> +
>> +/**
>> + * bpf_strncat - Append non-null bytes from a source string, and null-terminate
>> + *               the result
>> + * @dst: Destination string.
>> + * @dst__sz: Maximum bytes of @dst__ign, includes the trailing NUL.
>> + * @src: Source string.
>> + * @len: the maximum number of characters to concatenate, the null terminator
>> + *       \0 of the target string @dst will also be included.
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
>> +__bpf_kfunc int bpf_strncat(char *dst, u32 dst__sz, const char *src, u32 len)
>> +{
>> +       return __bpf_strncat(dst, dst__sz, src, len);
>> +}
>> +
>>   #ifdef CONFIG_KEYS
>>   /**
>>    * bpf_lookup_user_key - lookup a key by its serial
>> @@ -4958,6 +5031,8 @@ BTF_ID_FLAGS(func, bpf_strstr);
>>   BTF_ID_FLAGS(func, bpf_strcasestr);
>>   BTF_ID_FLAGS(func, bpf_strnstr);
>>   BTF_ID_FLAGS(func, bpf_strncasestr);
>> +BTF_ID_FLAGS(func, bpf_strcat);
>> +BTF_ID_FLAGS(func, bpf_strncat);
>>   #if defined(CONFIG_BPF_LSM) && defined(CONFIG_CGROUPS)
>>   BTF_ID_FLAGS(func, bpf_cgroup_read_xattr, KF_RCU)
>>   #endif
>> --
>> 2.55.0
>>

