Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F3BC301719
	for <bpf@vger.kernel.org>; Sat,  8 Aug 2026 16:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786205126; cv=none; b=rPZkqpcLm+2EfNH3pyNCfHg6VcA/5ujAWCFDglyLbaB0pXCpEaGu3WDM9NwuejQKAOnru+Wx8vkgLSLVVNEildnbarCIiD7GF3jM80psey5Q1jAsrxTbXCv5ZzfwI21YwDLdzfvoP3gQmZ5FpmzMJoVfxeCEROd42ADQ6yCpPho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786205126; c=relaxed/simple;
	bh=QSz0boZWODqc3XZiVUHn1AElgKKL4zNrjPqCEkBxV5o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EBrPal6s9XH11+EvHNsCigLpflnGyALEFIFX9qPp5qy/UvpMD9u7Is3BS7m9JKTExqLHuOoB1cR5jCfPKVMsOInFLpNraO+8/h3XXm5CLWSc/XVbakTIT3uJLhYwiC0fikCt7sVOTWLfsmLy7WYMRTME9VLE7skuf7eFtj+Qw+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=J+1964JL; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="J+1964JL"
Message-ID: <b9fe0394-bc46-4735-8584-51de6a96c076@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786205121;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uxxxcIJ3m8/FqLam/PGygaF8tqAkeeRsjXW4RaYUcGw=;
	b=J+1964JLfd6w3JqhzXls8nVJOPbHeCmtmY2Wc5KMBd3ra2Nfg3kJvUfn0DfpcQncJo3GKW
	5DQ5EJlS/KzlREA2kNHgmTvA5d7K601rtnvq1KvpckKu2WAvQG3JyxsdAbEnlsS/WOoW7a
	7kST6e6mIi/NHLZmviLE7bNnGYRDv08=
Date: Sat, 8 Aug 2026 09:05:00 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 06/13] bpf: Reject callbacks returning more
 than 8 bytes
Content-Language: en-GB
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 eddyz87@gmail.com, kernel-team@fb.com, martin.lau@kernel.org, clm@meta.com,
 ihor.solodrai@linux.dev
References: <20260804203553.1873415-1-yonghong.song@linux.dev>
 <2745ebef0f1c5b970d76736ab5828d4aea78433b2d3800b877f7e1a0555f4a4d@mail.kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <2745ebef0f1c5b970d76736ab5828d4aea78433b2d3800b877f7e1a0555f4a4d@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 8/4/26 2:54 PM, bot+bpf-ci@kernel.org wrote:
>> commit 9c43eef7a91393c06822d44c361ee806f383cf97
>> Author: Yonghong Song <yonghong.song@linux.dev>
>>
>>      bpf: Reject callbacks returning more than 8 bytes
>>
>>      A callback handed to a helper or a kfunc (bpf_loop(),
>>      bpf_timer_set_callback(), bpf_for_each_map_elem(), ...) is invoked
>>      through bpf_callback_t, and an exception callback is invoked by
>>      bpf_throw() through
>>
>>        u64 (*bpf_exception_cb)(u64 cookie, u64 sp, u64 bp, u64, u64);
>>
>>      Both prototypes yield a single u64 in R0, and neither caller has any
>>      notion of a second return register, so a callback returning a value in
>>      the R0:R2 pair would have the upper half of its return value silently
>>      dropped.
>>
>>      Reject both at load time:
>>
>>       - check_ld_imm(): a callback is materialized as PTR_TO_FUNC by an
>>         ld_imm64 pointing at its subprogram, so the subprogram's return
>>         convention can be checked where the callback pointer is created,
>>         before it ever reaches a helper or kfunc argument.
>>
>>       - do_check_common(): an exception callback is not referenced by a
>>         PTR_TO_FUNC, it is named by a BTF decl_tag and verified on its own,
>>         so check it as its frame is set up, next to the existing "cannot
>>         return void" and single-argument checks.
>>
>>      Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> This looks like a bug fix. Should this include:
>
>    Fixes: 63b5669f8a0d ("bpf: Add helpers to describe the R0:R2 return register pair")

There is no need to the bug fix. The actual R2 usage is in later patch
   Add verifier support for 16-byte returns in R0:R2

>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/30949310795

