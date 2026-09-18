Received: from mta0.migadu.com (out-116.mta0.migadu.com [91.218.175.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84BDE3B6C14
	for <bpf@vger.kernel.org>; Fri, 18 Sep 2026 03:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789703088; cv=none; b=QK0BXh1D1NTfOW9rTyQFmfcaycpa0lapQvSFGX16dGUQ+TxuwS0GD/KMGKgjs1cjbNXwLCXvAPuhQulugCWRl1twuCQsyUUmjNkto+YsN5GUs3OSfQJsjSsXiQ/oAOndjo4CUTtkDB7mTeQuJMS2IS2yCMVAMefA3CTH5jTlSSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789703088; c=relaxed/simple;
	bh=u1KEEBYeREVhDig1yhAtZPlOw+T+5A7kLX530zHmelg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MLvvVmYPTb2obzqoYJRTVSeiUakJE/TQWMBmt1e+iZOQ+4zgTGTyjkHRxvm/4YghIyMIyNi8ywm3ZB8Uka1BTdthMRN0PZz1rvI77beJwmnLCk4kz+YfopnQsV5lRY0uSKZvfO2VDZcK/y1swS9Eca6wR4G1hSSNaTTBxkq0mdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vvQ0wa3l; arc=none smtp.client-ip=91.218.175.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vvQ0wa3l"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=u1KEEBYeREVhDig1yhAtZPlOw+T+5A7kLX530zHmelg=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789703082; v=1; x=1790307882;
 b=vvQ0wa3lqSf1rLdfQZk3PJ9tcvEx0ko9dFjd+kpaFKxyOr2ZPOtPRwVIQ2ZLBFucrsNccqZx
 eA22HmOkh8NSWBqFXM8h0QNZ8sXiAMHB1VILRO2gJ/ZEzSV/JDu3Y7n8z9GM3o3MEHyUs5dix1k
 0CYOF2XG1Ruve9Mg7O638awI=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id a9894047c007adea;
	Fri, 18 Sep 2026 03:44:41 +0000
X-Mizu-Trace-ID: a9894047c007adea
X-Migadu-Flow: FLOW_OUT
Message-ID: <48fd0275-b710-40de-890b-df81882e1b2e@linux.dev>
Date: Thu, 17 Sep 2026 20:44:39 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 15/20] libbpf: Collect .bpf_cleanup records and
 pass them to the kernel
Content-Language: en-GB
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260917055645.3926444-1-yonghong.song@linux.dev>
 <20260917055802.3933672-1-yonghong.song@linux.dev>
 <20260917061212.515111F000FF@smtp.kernel.org>
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20260917061212.515111F000FF@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/16/26 11:12 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [Medium] bpf: undefined behavior when calling qsort with a NULL pointer
> - [Low] bpf: array bounds violation via type-punned pointer arithmetic
> --
>
> commit 1e591245d7ec663b872eae44c8fa7f02cfd956a4
> Author: Yonghong Song <yonghong.song@linux.dev>
>
> libbpf: Collect .bpf_cleanup records and pass them to the kernel
>
> This commit parses the compiler-emitted .bpf_cleanup section and hands
> the resulting table to BPF_PROG_LOAD so the kernel can resolve exceptions.
>
>> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
>> index ea1c09fa37939..d7cb93a70f58d 100644
>> --- a/tools/lib/bpf/libbpf.c
>> +++ b/tools/lib/bpf/libbpf.c
> [ ... ]
>
>> @@ -4847,6 +4885,214 @@ static struct bpf_program *find_prog_by_sec_insn(const struct bpf_object *obj,
> [ ... ]
>
>> +static int bpf_prog_collect_cleanup_info(struct bpf_object *obj,
>> +					 struct bpf_program *prog)
>> +{
>> +	size_t i;
>> +	int j;
>> +
>> +	for (i = 0; i < obj->cleanup_rec_cnt; i++) {
>> +		struct cleanup_raw_rec *raw = &obj->cleanup_recs[i];
>> +		struct bpf_program *owner = NULL;
>> +		struct bpf_cleanup_info ci = {};
>> +		__u32 *fields = (__u32 *)&ci;
>> +		void *tmp;
>> +
>> +		for (j = 0; j < CLEANUP_REC_FIELDS; j++) {
>> +			size_t idx = raw->insn_idx[j], final;
>> +			struct bpf_program *p;
> [ ... ]
>
>> +			if (owner == prog) {
>> +				final = raw->insn_idx[j] - prog->sec_insn_off;
>> +			} else if (prog_is_subprog(obj, owner) && owner->sub_insn_off) {
>> +				/* sub_insn_off is where this subprogram was
>> +				 * appended to the main program being relocated;
>> +				 * zero means it is not part of it.
>> +				 */
>> +				final = owner->sub_insn_off +
>> +					raw->insn_idx[j] - owner->sec_insn_off;
>> +			} else {
>> +				owner = NULL;
>> +				break;
>> +			}
>> +			fields[j] = final;
> [Severity: Low]
> Is it safe to cast a pointer to a struct field into an array pointer and access
> subsequent members via pointer arithmetic in this loop?
>
> The struct bpf_cleanup_info fields are populated by casting a pointer to the
> struct to a __u32 * array and indexing into it in a loop.
>
> According to C11 6.5.6, pointer arithmetic on a pointer to a scalar (the first
> struct field) only allows accessing up to one element past it, making fields[1]
> and fields[2] undefined behavior.
>
> This can trigger compiler warnings (-Warray-bounds) and potentially cause
> aggressive optimizers to generate incorrect code.

Yes, the code is correct but it is awkward and my trigger compiler warnings with
additional compiler flag. Will make it explicit with bpf_cleanup_info fields.

>
>> +		}
>> +		if (!owner)
>> +			continue;
>> +
>> +		tmp = libbpf_reallocarray(prog->cleanup_info, prog->cleanup_info_cnt + 1,
>> +					  sizeof(*prog->cleanup_info));
>> +		if (!tmp)
>> +			return -ENOMEM;
>> +		prog->cleanup_info = tmp;
>> +		prog->cleanup_info_rec_size = sizeof(struct bpf_cleanup_info);
>> +		prog->cleanup_info[prog->cleanup_info_cnt++] = ci;
>> +
>> +		pr_debug("prog '%s': cleanup region [%u,%u) -> landing pad %u\n",
>> +			 prog->name, ci.begin_off, ci.end_off, ci.landing_pad_off);
>> +	}
>> +
>> +	qsort(prog->cleanup_info, prog->cleanup_info_cnt,
>> +	      sizeof(*prog->cleanup_info), cmp_cleanup_info);
> [Severity: Medium]
> Can this unconditionally call qsort() with a NULL base pointer?

You are right. It is possible prog->cleanup_info_cnt is 0 and in such cases,
cleanup_info will be NULL. Will add a condition like 'prog->cleanup_info_cnt > 0'.

>
> If obj->cleanup_rec_cnt is 0, or if none of the records match the program,
> prog->cleanup_info_cnt remains 0 and prog->cleanup_info will be NULL.
>
> Calling qsort() with a NULL pointer invokes undefined behavior under C11 7.1.4,
> even if the element count is 0. This triggers UBSAN errors (nonnull attribute
> violation in libc headers) and can fail runtime checks.
>

