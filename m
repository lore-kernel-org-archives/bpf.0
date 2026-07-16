Received: from out162-62-57-87.mail.qq.com (out162-62-57-87.mail.qq.com [162.62.57.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58E983EC6BD
	for <bpf@vger.kernel.org>; Thu, 16 Jul 2026 08:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784190690; cv=none; b=phvd+iY0tULU1WLV60QjQJt9SHfZDYQr1MIvEIp6O/5FecuLM7pmVEjYjN7aQb4fsSgVPOFX4ko40NoextA4fV1YWW6t9j1oXI+86yE2047wC5kQmVd2HpfKh+d8PwYH56g2WSmDTPfdL2bu/MfbaKYmhGSp1v45ZPn9u5QapJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784190690; c=relaxed/simple;
	bh=oAKcpYyqB5R1GIsbR8uVDRb31dUeyXygJM/OY9+d25M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jFUKYzbme6CreZhyV8c5B2BkT2WrHhxbnl02DSOg5fwBOx5nQ2cSbu4gTmb90aX/PUzr0u0sEdY3P4xCuS1btbbQE6Wh8j3JTpJH4faDGv2GqzhCCJ+2DH1cpQReMYzQu1aqj0q3YMcsWFQz0NL6sbcITtgSrBq1K7VVjWeCJbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=TdU4F8zf; arc=none smtp.client-ip=162.62.57.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="TdU4F8zf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1784190682;
	bh=eRn/vLGNe3UxqQjtdEDgrmLkrNtu+4WFyBXxC1Qnvpo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=TdU4F8zfNhWd1vdAPENJYS7d5+RQUfKbVhceeY7rPqxaGPlwTBAYt6sLiidD9tAEf
	 MA3dQxORJSWjVdTWRwjLf4DYMxe79y+0z28alyrlIIFUdBcGMX7UPKRw4CMx13MwQm
	 lZQz82o+YykePMPOiUJGWnws3mmTVSDjuAXrlp1g=
Received: from [10.56.52.25] ([39.156.73.14])
	by newxmesmtplogicsvrsza63-0.qq.com (NewEsmtp) with SMTP
	id 7D4B5638; Thu, 16 Jul 2026 16:31:20 +0800
X-QQ-mid: xmsmtpt1784190680txyde9d0d
Message-ID: <tencent_5B3A21BA18AC085166295ED6A994BD8A8F0A@qq.com>
X-QQ-XMAILINFO: MJf32pulH4819N1UT0GEzj0CD443KacVz9RTt9pv4YpO3CycAx0lOpKxKDB0Bv
	 MiFdMVF0Y56vy9r8OXU8nJzZ4D61/ZIBJ0e5iZioK6cXleEqz5amtwFwvZo51qkEpLW5wiZ4krLd
	 32q0501odPh/P4nNV/X/DFTRtCQoIZ14+IuB/1tEBfA5PAaDuEM9cySfiGH0uDFcaGfbsgnXPhRV
	 B5Blj4VTdhxJaInzZUxA8fUorVxLs3TfwAbKEGd1G9s2C89biRlLSTniv8JWVsFjil0DxwWu5QaU
	 smSIZ2TXzR8ltxRmNfIjVJNKo2xs756+CZHaX7rktQlE+1WDGxXncgTu+8Mzr8hRAZH5JlcaYCmT
	 tG5lakdOI/TiPInNsgUew8BRodFKSO2T+crnNFmiGFL+sG1AWT9ak7wYHZgoXLIZr6EYRQNe5D3n
	 dyVEbg3dhXfh1D3MD2cE9OfyEtd6vd2FQJnG32oPjmu8ab6Z9zKjnypHEvvRYV3sjeRtALsf+P8h
	 ykoOWBsAg7Q6nD3cMEr2WI9jhpC9baidcOx2qgOIEiTYolY+ulo9TTYyohJrGA0o18djj9iBIKEQ
	 9fQeozaTBdjq5d5lz9onvF278Q/T7iqMSv7Jw6h1Fao+ZmdUfOcmK+XSIrRV+FoF58Mbh6mfVVkF
	 QbCalHg/5FnUvXH2ag1wwXviaZ58HrKCQiQr6NeMNrSNG0GdM37oMQqmbm9NHUcStWHQVDWP0SXM
	 H3Mgt3ZVvSKTsWSL45nYbB8mQT6wfBlDWatuehZgNfpOHFFcpIzZxYReJHs5hCxKYTidEKF5dSPH
	 of+Uh38b8YHaosfrSZwULX/MoUL7JjIQALTFeeXAwhtYL3C8AXVkWMjo1sj4+K+YBqsLu12ptzu3
	 HWhP3HuU4X4k2ZRQs54AfS3dkKAUFc3YMDgNwBgxjClTttymKDoLfcQn8rCPPXJ7ZYi5PFQuK9lc
	 vKZmPEXJToM0zteOuMWsudX72pkYbAGcnQO2TmKl+BVCZQuzMS345Q6MhGUv0pjsftGG4r7eEdp/
	 0PMmE8gh4EQme3kbZMD5NyP3uaRmM7Jm165ITbEw==
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
X-OQ-MSGID: <454584d3-b45e-41db-b65c-c70476157c89@foxmail.com>
Date: Thu, 16 Jul 2026 16:31:20 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 1/2] bpf: add bpf_strcat,bpf_strncat kfunc
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <cover.1784078494.git.rtoax@foxmail.com>
 <tencent_9EC04DC824CBF5124305E73564341511C405@qq.com>
 <20260715014036.B00561F000E9@smtp.kernel.org>
Content-Language: en-US
From: Rong Tao <rtoax@foxmail.com>
In-Reply-To: <20260715014036.B00561F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 7/15/26 09:40, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> - [High] bpf_strncat unconditionally reads one byte beyond the caller-specified source limit (len) after the copy loop, causing a spurious -EFAULT if the source buffer ends at a page boundary.
> - [Medium] The destination string is left completely non-null-terminated if a memory fault occurs during the copy loop.
> - [Medium] Integer overflow in the `space` calculation causes spurious `-E2BIG` failures for destination buffers larger than 2GB.
> --
>
> --- Patch [1]: [PATCH bpf-next v2 1/2] bpf: add bpf_strcat,bpf_strncat kfunc ---
> commit 638de7ac547b3d0857f680c3e68dbfcae6e2543c
> Author: Rong Tao <rongtao@cestc.cn>
>
> bpf: add bpf_strcat,bpf_strncat kfunc
>
> This patch adds string concatenation kfuncs bpf_strcat and bpf_strncat to
> the BPF subsystem. These functions allow appending non-null bytes from a
> source string to a destination string with size limits.
>
>> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
>> index c18f1e16edee4..401f94efd687c 100644
>> --- a/kernel/bpf/helpers.c
>> +++ b/kernel/bpf/helpers.c
> [ ... ]
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
> [Severity: Medium]
> Will this calculation overflow if dsz is greater than or equal to 2GB?
>
> Since space is a signed int and dsz is a u32, dsz - dlen can result
> in a negative number for large destination buffers, such as those from a
> BPF arena. A negative value satisfies the space <= 1 check, causing the
> function to incorrectly abort and return -E2BIG.
Already check above 'dlen >= dsz'.
>
>> +
>> +	guard(pagefault)();
>> +	for (copied = 0; copied < space - 1 && copied < slen; copied++) {
>> +		__get_kernel_nofault(&cs, src, char, err_out);
>> +		if (cs == '\0')
>> +			break;
>> +
>> +		__put_kernel_nofault(dst + dlen + copied, &cs, char, err_out);
> [Severity: Medium]
> Does this leave the destination string non-null-terminated if a memory fault
> occurs during the copy?
I'll use strncpy_from_kernel_nofault() in v3, thanks ;)
>
> If the loop copies at least one character (overwriting the destination's
> original null terminator) and then a subsequent read or write triggers a
> page fault, the code jumps directly to err_out without restoring a null
> terminator.
>
> While it returns an error, BPF programs that do not check the return value
> might operate on corrupted state.
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
> [Severity: High]
> Can this unconditionally read one byte beyond the caller-specified limit sz?
>
> When the copy loop finishes, copied may equal sz. The pointer src will
> have been incremented sz times. If the original src buffer is exactly
> sz bytes and ends at a page boundary, this read will trigger a page fault,
> causing a spurious -EFAULT return.
>
> Additionally, if copied == sz, the subsequent sz > copied check evaluates
> to false anyway, making the read unnecessary in that case.
Thanks ;)
>
>> +
>> +	return dlen + copied;
>> +err_out:
>> +	return -EFAULT;
>> +}
> [ ... ]
>

