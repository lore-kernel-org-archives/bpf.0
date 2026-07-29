Received: from out162-62-57-49.mail.qq.com (out162-62-57-49.mail.qq.com [162.62.57.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A43A4C6D;
	Wed, 29 Jul 2026 01:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785287376; cv=none; b=gR1hagxthFqeZzqZamSxCiKxQMlUeLQKFObNtDnp2VvQi8kgJkljK6huvmmfybxyyTMjlmw57nDUKNpecfU6gQmAxGpKIO9nhEeYAaPCVIV5QMtb0mOCfVieNAdnihPU3PS7NycC9ousPx7wj29UoQ5qZJkAPeGcAwPunxYAd24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785287376; c=relaxed/simple;
	bh=NNxWxDe7kC54EChcb0afgEdncgGE85PBgYX/IthWpao=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fxCzl39RFGkaB+vpJJ+cXNg8uXCdBQsLPzo/UtFchZ4MSNl09uwCH3CBSbWQNgHA/rWNwEF05evPsuHKGUjOZnn60NGBO01EAUR7c1BzPwUyFKWGaW8by0aSRbZLSOcnLcWBB38DT1k+Z8a1N7fHky0Eep0AVTp11Mg7ouQrqd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=NounuZcA; arc=none smtp.client-ip=162.62.57.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="NounuZcA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1785287366;
	bh=NGrM93qcsTKpKJ2a72fk46gVB12KhLwjYNwPwYiXtbk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=NounuZcAfTNdLIV0/JI1nLMXNEcgIDklDuF1YAbUFtBGZDXN5ftM9isd80tgVIm8w
	 TUPJr5xo4KmBIwjUIjye3WzUMEWOrQ0LmZi/SQUYfoHLRGH3xHC8Qnq0Izeadj8ifn
	 fWiOwS2iI6+nmib/D8VH0pN39z9NYzF3B5zcZXLM=
Received: from [10.56.52.25] ([39.156.73.14])
	by newxmesmtplogicsvrszc56-0.qq.com (NewEsmtp) with SMTP
	id 2002B400; Wed, 29 Jul 2026 09:08:00 +0800
X-QQ-mid: xmsmtpt1785287280tzgiu16hj
Message-ID: <tencent_C3B23E2E87554A5E5747DD10790D44843209@qq.com>
X-QQ-XMAILINFO: OUk+E8Vw5ntvi+W+ju8ja5BDsHZ0EHPgY/f5BnHTXw1MalAkvUzoVED6se0uXL
	 wQe6DxjM8otvfiTBwL37D7UeRQeanoJfG4ZsAn6xnifiL2bZDw3pBwSafEUyCNfw0OWcAaFQDRC+
	 2zkR9Cmi9vY7ZS46Zbm/zSp3OPMEXZ8YyYU2FR8oz7rTA9dbbc/mi44hOSWw34eN+L2HxqJ9Foa5
	 FVoJtyFnwr7iTiQ52JttqXTcaoVh2XxC+meuw8g37ZtLwPDcij4nS3EzwCIXJKU04LuuqLHkyoYR
	 Mt5+tFfpugvfM6Pm2EuE+Ui5jx+j7UtP2oecq4cQVuZJc7a8adbcgGeXehvkk6Yd3wKul7UZgMj6
	 2illl9K/qPQv0ii/tB+S8kGgk0j1Mz2yXnG5U99hK+mZSE+RgIxes3/NNP+Fm/i2uG8gFNyyf7js
	 vByg1H4VE9tZZRz8GlZBCQtAJQ+R194yit3cZWlWC4HpVM1XT2SGvdaRm7stz81fNr/EDCG5BmRW
	 yOtNYjJU7FgWrdReVixejeBEajSNysgvJi79vZ5iiF/iPm4JOH+prhv7J4p8LsjWZGzLTbVO8ACB
	 Y3oNbuTE+Jdw09EPDAQnZglTl1EKgPojNYM2P2cTZKIXwtQwUQsSMwuuMIp23RWsNLVSQ26Ua8aL
	 jcsgZsXtVnpuU/BFd91GJKvVc9u/H0z3Q079gl65x1KbNtOGIKGTZJ3xALTaeaWNC8St7XO30imM
	 qmvenVP7kI3c40br6Ppg0j4NyKGVPfs+kHPB56yhsnymm2ECT5XLqAGnijmfoqUb6qjLWNKPUK8B
	 uBu1CO+Lpg7GxPggH7klVrD3yB0z3jY9dtewnWaxEOP5zIm7ZtLoLmsqq9EyR1qQn+rLQINDvjQH
	 EAR4+QjMgS+vDfDIy+E/qzBTKSCPfJ9LhAM5JlVgn28s9syvNqVrgoR8l3gOP3Tz1Q7S/WXaXyKA
	 1Y15ZtA2iKzEeSPZBMnqe+XTod1xdZDqYxkjR0wwaQENb/iRTA0PGtQjLF6LzcIsxY2ZO5Oe/j+V
	 wXYSh7Uxr9ST8uM6dhryOi6P6gz4dCapAt4xBeHktBHN/FYMhv8F54Bu/349IiGDYvlVYQrjXFJv
	 +JDkt1j45XT6V09wE=
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
X-OQ-MSGID: <6d7d5ae0-56d3-475b-b85e-ffb5a08089aa@foxmail.com>
Date: Wed, 29 Jul 2026 09:08:00 +0800
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
 <tencent_185F6B461110090D468588B2422E5955A409@qq.com>
 <CAEf4BzY6RPkm0xv=RHAKoNphYxM_6GmyLdhDbbZ3nAqNhkdW_g@mail.gmail.com>
Content-Language: en-US
From: Rong Tao <rtoax@foxmail.com>
In-Reply-To: <CAEf4BzY6RPkm0xv=RHAKoNphYxM_6GmyLdhDbbZ3nAqNhkdW_g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 7/28/26 23:58, Andrii Nakryiko wrote:
> On Mon, Jul 27, 2026 at 7:50 PM Rong Tao <rtoax@foxmail.com> wrote:
>>
>> On 7/28/26 06:56, Andrii Nakryiko wrote:
>>> On Tue, Jul 21, 2026 at 9:42 PM Rong Tao <rtoax@foxmail.com> wrote:
>>>> From: Rong Tao <rongtao@cestc.cn>
>>>>
>>>> Add string concatenation kfuncs, prototype:
>>>>
>>>>     int bpf_strcat(char *dst, u32 dst__sz, const char *src);
>>>>     int bpf_strncat(char *dst, u32 dst__sz, const char *src, u32 len);
>>>>
>>>> This differs from the glibc library functions strcat and strncat, which,
>>>> for safety reasons, require the size of the target string's memory space
>>>> as a parameter.
>>>>
>>>> The src parameter cannot directly pass a string constant, such as "XYZ",
>>>> otherwise it will throw an error "write into map forbidden".
>>>>
>>>> Signed-off-by: Rong Tao <rongtao@cestc.cn>
>>>> ---
>>>>    kernel/bpf/helpers.c | 75 ++++++++++++++++++++++++++++++++++++++++++++
>>>>    1 file changed, 75 insertions(+)
>>>>
>>>> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
>>>> index c18f1e16edee..85afff60365c 100644
>>>> --- a/kernel/bpf/helpers.c
>>>> +++ b/kernel/bpf/helpers.c
>>>> @@ -4195,6 +4195,79 @@ __bpf_kfunc int bpf_strncasestr(const char *s1__ign, const char *s2__ign,
>>>>           return __bpf_strnstr(s1__ign, s2__ign, len, true);
>>>>    }
>>>>
>>>> +static int __bpf_strncat(char *dst, u32 dsz, const char *src, u32 sz)
>>>> +{
>>>> +       int dlen = 0, slen, space, copied;
>>>> +
>>>> +       if (sz == 0 || dsz == 0)
>>>> +               return -EINVAL;
>>>> +
>>>> +       while (dlen < dsz && dst[dlen] != '\0')
>>>> +               dlen++;
>>>> +
>>>> +       if (dlen >= dsz)
>>>> +               return -E2BIG;
>>>> +
>>>> +       space = dsz - dlen;
>>>> +
>>>> +       slen = bpf_strnlen(src, sz);
>>>> +       if (space <= slen)
>>>> +               return -E2BIG;
>>>> +
>>>> +       copied = strncpy_from_kernel_nofault(dst + dlen, src, sz);
>>> I'm not sure strncpy_from_kernel_nofault() is designed to work
>>> correctly if dst can be modified concurrently. Which in BPF case, even
>>> though we validate that memory is correct, it still can be modified
>>> concurrently in such a way as to cause strncpy_from_kernel_nofault's
>>> inner dst[-1] based loop logic to go beyond the boundaries of target
>>> buffer.
>>>
>>> i.e., I don't believe current implementation is concurrency safe
>> Thank you very much for your reply. There is indeed a thread safety
>> issue. Let's look at a solution. I will submit v6. Thank you ;)
>>
> tbh, I'm not sure we need these new kfuncs at all. You should be able
> to easily to do the same with dynptr for dst buffer and existing
> strlen/probe_read helpers/kfuncs.
Thank you. You share the same view as Viktor. Indeed, strcat and 
probe_read are functionally redundant. Let's discard this commit. Thank 
you.
>
>> Rong Tao
>>
>>> pw-bot: cr
>>>
>>>
>>>> +       if (copied < 0)
>>>> +               return copied;
>>>> +       else if (copied == 0 || copied == 1)
>>>> +               return dlen;
>>>> +
>>>> +       /* The copied character count includes '\0'. */
>>>> +       return dlen + copied - 1;
>>>> +}
>>>> +
>>>> +/**
>>>> + * bpf_strcat - Append non-null bytes from a source string, and null-terminate
>>>> + *              the result
>>>> + * @dst: Destination string.
>>>> + * @dst__sz: Maximum bytes of @dst__ign, includes the trailing NUL.
>>>> + * @src: Source string.
>>>> + *
>>>> + * Return:
>>>> + * * >=0      - Length of the concatenated string.
>>>> + *
>>>> + * * %-EINVAL - String @dst__ign is invalid.
>>>> + * * %-EFAULT - Cannot read or write one of the strings.
>>>> + * * %-E2BIG  - String @src__ign is too large or the remaining space in
>>>> + *              @dst__ign is too small.
>>>> + * * %-ERANGE - One of the strings is outside of kernel address space
>>>> + */
>>>> +__bpf_kfunc int bpf_strcat(char *dst, u32 dst__sz, const char *src)
>>>> +{
>>>> +       return __bpf_strncat(dst, dst__sz, src, dst__sz);
>>>> +}
>>>> +
>>>> +/**
>>>> + * bpf_strncat - Append non-null bytes from a source string, and null-terminate
>>>> + *               the result
>>>> + * @dst: Destination string.
>>>> + * @dst__sz: Maximum bytes of @dst__ign, includes the trailing NUL.
>>>> + * @src: Source string.
>>>> + * @len: the maximum number of characters to concatenate, the null terminator
>>>> + *       \0 of the target string @dst will also be included.
>>>> + *
>>>> + * Return:
>>>> + * * >=0      - Length of the concatenated string.
>>>> + *
>>>> + * * %-EINVAL - String @dst__ign is invalid.
>>>> + * * %-EFAULT - Cannot read or write one of the strings.
>>>> + * * %-E2BIG  - String @src__ign is too large or the remaining space in
>>>> + *              @dst__ign is too small.
>>>> + * * %-ERANGE - One of the strings is outside of kernel address space
>>>> + */
>>>> +__bpf_kfunc int bpf_strncat(char *dst, u32 dst__sz, const char *src, u32 len)
>>>> +{
>>>> +       return __bpf_strncat(dst, dst__sz, src, len);
>>>> +}
>>>> +
>>>>    #ifdef CONFIG_KEYS
>>>>    /**
>>>>     * bpf_lookup_user_key - lookup a key by its serial
>>>> @@ -4958,6 +5031,8 @@ BTF_ID_FLAGS(func, bpf_strstr);
>>>>    BTF_ID_FLAGS(func, bpf_strcasestr);
>>>>    BTF_ID_FLAGS(func, bpf_strnstr);
>>>>    BTF_ID_FLAGS(func, bpf_strncasestr);
>>>> +BTF_ID_FLAGS(func, bpf_strcat);
>>>> +BTF_ID_FLAGS(func, bpf_strncat);
>>>>    #if defined(CONFIG_BPF_LSM) && defined(CONFIG_CGROUPS)
>>>>    BTF_ID_FLAGS(func, bpf_cgroup_read_xattr, KF_RCU)
>>>>    #endif
>>>> --
>>>> 2.55.0
>>>>

