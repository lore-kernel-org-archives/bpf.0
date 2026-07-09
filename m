Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B74377003
	for <bpf@vger.kernel.org>; Thu,  9 Jul 2026 16:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783615311; cv=none; b=CdHVHiriogZAoWtObhrpyrErqV//5iMLq+jIHXOgSwz8hOG31vc2xV6wgNaJ1nJr6PENpnM/IeCpcLIeRNRCwkaEaqw7cjZjs1fELldcSLCem14QwOHlEvHWNmf7aFutEstVoM60KFYc4j/gy5jwT0wneXSEfCl86409aCqvfm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783615311; c=relaxed/simple;
	bh=i+QD5ZVKiNKdXGWi/P/YAz3arIeKK6PpXkxusAC0wT8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gF7OGvaNE08BkxVf5PzxwOB+OJoacU9I/Lt96iwBE3R1EXID5WoGgC+qevsTm27IEguZrjW9NO/77evAjxtdBN4LX5HFkEPGb1Zo2Zhg7G+OVH++E5t5SiDQRTeBLkpq6g3WPqbJq+F/nIEU+DIt8XWzmJlnZ6Z+WWM0ZB2gMvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=igmJG4HE; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="igmJG4HE"
Message-ID: <9b64c48d-776b-430d-b96a-4b97b31c938c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783615307;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XlAbj6OqwkNMk6R35SfUHm2HR03D6qwQLHNF9t5OBVw=;
	b=igmJG4HERW+PEIGlxffgdo8g0r0vYOun3hC4k8OuOHZR5s1KR4/IV5RC1kOlu7lGUdJavc
	35FGojfNoZm2JKojckVJfHr20dA180xuCrMifyal6QVQq0r23ZowXGDvpvkpgWHGrRyyfa
	2exgywRH0PMFr+e4MtVj/aCEo41sbLY=
Date: Thu, 9 Jul 2026 09:41:43 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 04/12] bpf: Track R2 of register-pair returns in
 precision backtracking
Content-Language: en-GB
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 eddyz87@gmail.com, kernel-team@fb.com, martin.lau@kernel.org, clm@meta.com,
 ihor.solodrai@linux.dev
References: <20260708201000.2157684-1-yonghong.song@linux.dev>
 <cd4ca66299d6e7a8e4bdf2a524e302fe057d819303c82a9535b63279be52631a@mail.kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <cd4ca66299d6e7a8e4bdf2a524e302fe057d819303c82a9535b63279be52631a@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 7/8/26 2:10 PM, bot+bpf-ci@kernel.org wrote:
>> A function returning a value larger than 8 bytes (a struct/union, or an
>> __int128) uses R2 as a second return register alongside R0. Previous
>> precision backtracking only treated R0 as a return register at a
>> call/return boundary, so marking the second half of such a return precise
>> would trip the "unexpected regs" checks in backtrack_insn() and reject a
>> valid program with -EFAULT.
>>
>> Handle R2 like R0 in the three boundaries where a call defines the return
>> registers:
>>
>>   - static subprog exit (BPF_EXIT): R2 is a return register, not a leftover
>>     argument; clear it before the args check and propagate its precision
>>     into the callee.
>>   - global subprog call: a global subprog returning >8 bytes also sets R2;
>>     clear it before the args check.
>>   - kfunc call (BPF_CALL): a kfunc returning >8 bytes (model ret_size > 8)
>>     also sets R2; clear it like R0.
>>
>> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> This looks like a fix for the R0:R2 register-pair return handling that
> went in earlier in this series, where backtrack_insn() was not updated to
> treat R2 as a return register.  Should this carry a Fixes: tag?
>
>    Fixes: ec219322a9a7 ("bpf: Add verifier support for 16-byte returns in R0:R2")

This is still a preparation patch, so Fixes is not necessary. The same
for a few later patches.

>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/28973410219

