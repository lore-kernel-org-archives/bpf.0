Received: from out203-205-221-153.mail.qq.com (out203-205-221-153.mail.qq.com [203.205.221.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5523A279DC3
	for <bpf@vger.kernel.org>; Wed, 15 Jul 2026 01:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784077392; cv=none; b=mE8eirEH9E9h81UAp3I3MRX7OMtHgp1YftEzw4G5s/FxUqYlT0MXIOL6pLuaO4Bz1LtI1oQ6rVL2BG74p5FhlKlqfPycq3BBbrsfx5MU99R60BpV0HQTlp6pzc+RzdeHcQLEwjkR/QLDqQ/uOiQgvmrTpQOtdL8FDRSySd2i25c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784077392; c=relaxed/simple;
	bh=Pr+FcyIJAIaGTPvNLVGNiqEwVwmLoj1wNuaL56VSm0A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o8tNFjKCu9jsouBFKNCBhpXdX5bvmz8qEumNbt0XEvp7gMqPPBMrOGpAgh4FO0QNVUg4R1bfxaJYH+FaT3eZHukvV5XbYUsRtJFNa5+4GWgGEjnBIWQ58Mq7aXK6Ij1jwOo2eJxy26119+qXtG8FGCG8d5y2+06RGjfFdBhclf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=WJd4kA55; arc=none smtp.client-ip=203.205.221.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="WJd4kA55"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1784077382;
	bh=+ezWaPL8o+Bf9DeBMrDIJ6C9VjJpCHDmRZLbvOm2aLw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=WJd4kA55fRvoz7Elgy3JD9LPVMaIipWdI+7pG5bxbUgngu6gbIVIgHsj01skZbjPI
	 iRfeap7xwz19SB6PWaRiJZJrhj6u1ww4wAPM7QvmwVTVFvxQNtImemqRUjXCOWjXON
	 Frko+mjizBX7sEZbjTTblQJmkisnex+JIQd7vBj0=
Received: from [10.56.52.25] ([39.156.73.14])
	by newxmesmtplogicsvrszb51-1.qq.com (NewEsmtp) with SMTP
	id C0B066F; Wed, 15 Jul 2026 09:03:00 +0800
X-QQ-mid: xmsmtpt1784077380t5aucd3hs
Message-ID: <tencent_D85EA546CD11A70CDA84E0B33A2F87547009@qq.com>
X-QQ-XMAILINFO: OIJV+wUmQOUAceMm1HCrPD82gY1K0qPip8ARpzE3CNhE3XxC9b9m4vSwo/V1bC
	 yviS4Kbtiwuqz5HivRRLVqYHEVLoMPoDswR8fIcF8U3yfSpiRsYOP5jbS8422pq05L0ruKGgylip
	 Ah23E3GGrOSSaWUqwom5UX9X5qQpymAeWlDxFKx1K6+lpcgAE2NFPyJilNESwy5gFlxXDtDXLZQk
	 aRTNB3Pbo0bjDh0BdNyNwN1cL36r2HSOuVt18rNsR5uJV0F0IrOzg0ntPzFzMtHWKucOU41QF/Mg
	 mXWf71Kl5B6BLjVCxBNR7/cjKGZKEdltP8+1BAQpaxybt3Tovo4tpBAH9zceHE2EhEA09QGxs8qP
	 FxA1U0XRr5nDyO7Q3cPt5m4rmFrFiCOBjwoa6rlGxW+VohRaXBS0q3M9cEwpIHYJsDvVbLG7v44Y
	 xAdOyn/SWjhHD/tnxxhDjspI4FFEQn1V53pItmBXFAyXVXMGSA0xsY3rVu8bxeewlruTHLsbDoFf
	 OZ+iWwrLJZ8JEWaTW/V4XnJom6MIXSeTt0QOoLEiPU0w2llPRlAAlG0x25GQXu3zxmw6F9RYBcFS
	 lf6eSnMIltez+XbSHipWbeAsZ0fV426uTmL46jnmg43kA8T9fh2g7b3dl+s6zr4PUn4IvcTN7/4z
	 v+JRoLVpvK+tzTn8IP/Mk6JSkcN9uNSWK95lbusupmBE4qBmJcxIlYxx+GGnHzvR8s5H0Y2CE/7b
	 R4YxfUI/5pHzUWI0Mwxhpic3e5bNolSAHt047hiHt9hLow23BFTnEGgoKIPDh+EUMTpc7kUYUszG
	 ISvC1u6FMhefNcH+La47HMrq5hwLMGZacNfM70f8lcRM/Z7OS1/57cKMQvxgV1ZWMzbmLCJz3hn9
	 +x0nrrRGU1yIEBONFW79HItX0Cn7z4KQKlIF1CEH6sGVVn2hvCQdqX4O11b0ifWcYBsFK2fIdmfm
	 6i1j5X97/Ma0i+cyYTqXP4+dKy3blhijioEASDHPI/4bTg8NfP98/BEukEci5dC18fCA/PPWZN8r
	 txnoxLioFbJ4apm+TD
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
X-OQ-MSGID: <4c4fa501-95a2-47c3-bbc7-b9816eeb435f@foxmail.com>
Date: Wed, 15 Jul 2026 09:03:00 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 1/2] bpf: add bpf_strcat,bpf_strncat kfunc
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <cover.1784021302.git.rongtao@cestc.cn>
 <tencent_59689407B1C3204B08362BEEF244A5FE5505@qq.com>
 <20260714101933.4AD381F000E9@smtp.kernel.org>
Content-Language: en-US
From: Rong Tao <rtoax@foxmail.com>
In-Reply-To: <20260714101933.4AD381F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 7/14/26 18:19, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 5 potential issue(s) to consider:
> - [Critical] Arbitrary Kernel Memory Write via Verifier Bypass
> - [High] Missing page fault protection leading to sleeping in atomic context
> - [High] Time-Of-Check to Time-Of-Use (TOCTOU) race leading to unbounded loop and soft lockup
> - [Medium] Unbounded out-of-bounds read on destination buffer
> - [Medium] Unbounded out-of-bounds read on source buffer
> --
>
> --- Patch [1]: [PATCH bpf-next 1/2] bpf: add bpf_strcat,bpf_strncat kfunc ---
> commit a7b2e5fa67dde4d93faf939b8283a2aa59b8ca2d
> Author: Rong Tao <rongtao@cestc.cn>
>
> bpf: add bpf_strcat,bpf_strncat kfunc
>
> This commit introduces bpf_strcat and bpf_strncat kfuncs to allow string
> concatenation in BPF programs. It requires the destination buffer size as a
> parameter for safety.
>
>> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
>> index c18f1e16edee4..e99b643136822 100644
>> --- a/kernel/bpf/helpers.c
>> +++ b/kernel/bpf/helpers.c
> [ ... ]
>> @@ -4195,6 +4195,95 @@ __bpf_kfunc int bpf_strncasestr(const char *s1__ign, const char *s2__ign,
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
>> +	dlen = bpf_strnlen(dst, XATTR_SIZE_MAX);
> [Severity: Medium]
> Does this code perform an unbounded read on the destination buffer? The limit
> should be bounded by the provided size dsz, rather than statically set to
> XATTR_SIZE_MAX.
Thanks!
>
>> +	if (dlen < 0)
>> +		return dlen;
>> +	slen = bpf_strnlen(src, XATTR_SIZE_MAX);
> [Severity: Medium]
> Does this scan read out-of-bounds on the source buffer? The limit could be
> bounded by the requested copy length sz rather than unconditionally reading
> up to XATTR_SIZE_MAX.
Thanks!
>
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
>> +	for (copied = 0; copied < space - 1 && copied < sz; copied++) {
> [Severity: High]
> Does this code introduce a Time-Of-Check to Time-Of-Use race? The loop bounds
> omit checking copied < slen, relying entirely on encountering a null
> terminator.
>
> If a concurrent thread modifies the source buffer to remove the null terminator
> after bpf_strnlen() executes, could this loop run out of bounds and lead to a
> soft lockup?
Thanks!
>
>> +		__get_kernel_nofault(&cs, src, char, err_out);
> [Severity: High]
> Does this sequence lack page fault protection? Unlike other string helpers,
> __bpf_strncat() fails to wrap its memory accesses in guard(pagefault)().
>
> If a BPF program executing in a non-sleepable context calls this on an unmapped
> address, it seems the generic page fault handler will attempt to take sleepable
> locks.
Thanks ;)
>> +		if (cs == '\0')
>> +			break;
>> +
>> +		__put_kernel_nofault(dst + dlen + copied, &cs, char, err_out);
> [Severity: Critical]
> Can this write to arbitrary kernel memory? The function writes to the unchecked
> destination pointer.
>
> Because the bpf_strcat() kfunc signature uses the __ign suffix for dst__ign,
> verifier safety checks are bypassed. Any user capable of loading BPF programs
> could potentially use this to write user-controlled bytes to arbitrary kernel
> memory.
Thanks ;)
>
>> +
>> +		src++;
>> +	}
> [ ... ]
>> +__bpf_kfunc int bpf_strcat(char *dst__ign, u32 dst__sz, const char *src__ign)
> [Severity: Critical]
> Does the dst__ign argument bypass verifier checks? The __ign suffix explicitly
> instructs the BPF verifier to ignore this argument, which removes all memory
> safety and bounds checks for the destination pointer.

Thank you very much, I will fix all the potential problems.

Rong Tao


