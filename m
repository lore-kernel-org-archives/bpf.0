Received: from mta0.migadu.com (out-122.mta0.migadu.com [91.218.175.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15FC847F774
	for <bpf@vger.kernel.org>; Wed, 19 Aug 2026 15:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787154746; cv=none; b=GvBnBJQl1w1FniA+BmaxMfgUxOwhZNXlIJNTGEBpovh3U7m44V3AvnoEXy4QpfDL4Aj0LjjaukkKnIpiC300rrsqL9th3saY7HgRb4GUC023jwzOfGatAWug82WmtLS1OAxhgPDb5/cuXMehHfD2ROov9XFodB+jImJT4+Snl7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787154746; c=relaxed/simple;
	bh=90SWeDUioP2o4mY+EocuTM513VEle6mMQm+bkDB+o3w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NbPbWAh29AW1yQ1ZvZLBc1zzUp+5teFz8aFSTfohyLT36OlIavG2E+kpmDSYoHeP8UunM7GSEbTgE/TvKh8ewK/qu6aU5wk7kMDDY6Ac3Eary+11jQbrsAKJqnXyFBFEPADwSM8zahN7gnQE4xv54eAz3umAGAlkU/fo/TXsC2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=X8p2fr2n; arc=none smtp.client-ip=91.218.175.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="X8p2fr2n"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=90SWeDUioP2o4mY+EocuTM513VEle6mMQm+bkDB+o3w=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787154740; v=1; x=1787759540;
 b=X8p2fr2nGQ5XpSQgxvXJR5JpoXlciFZWOufqqu+EtOkxkw10FHUagsmsKQMz1sEvkHhmy65C
 JX+ZIXNjkdfS2hYdyCBMd2iFnhE+j7gIabJxoaY+YfKasPrcMjeDu4jXvprlyO6eswryPRWb+yl
 bL1Le1HO6G+jLI1tD1v99Pns=
X-Envelope-To: bpf@vger.kernel.org
Received: from [IPV6:2a03:83e0:1151:15:1c5e:37e8:36:dd37] (2620:10d:c090:500::7:5d0e)
	by smtp.migadu.com with ESMTPS id bff934f89a5438c1;
	Wed, 19 Aug 2026 15:52:20 +0000
X-Mizu-Trace-ID: bff934f89a5438c1
X-Migadu-Flow: FLOW_OUT
Message-ID: <3b0d1471-9f59-4fda-b5b3-73fda3325ddd@linux.dev>
Date: Wed, 19 Aug 2026 08:52:14 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v7 03/10] bpf: Wire up JIT support for 16-byte
 kfunc returns
Content-Language: en-GB
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 eddyz87@gmail.com, kernel-team@fb.com, martin.lau@kernel.org, clm@meta.com,
 ihor.solodrai@linux.dev
References: <20260819055254.3295610-1-yonghong.song@linux.dev>
 <4533383af7562516a24ecadf8e2242d17e50ab4e8835bb8c9baf573b37944b0a@mail.kernel.org>
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <4533383af7562516a24ecadf8e2242d17e50ab4e8835bb8c9baf573b37944b0a@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/18/26 11:49 PM, bot+bpf-ci@kernel.org wrote:
>> bpf: Wire up JIT support for 16-byte kfunc returns
>>
>> LLVM 23 returns an __int128, or a struct/union larger than 8 bytes and no
>> larger than 16 bytes, in the BPF R0:R2 register pair. The previous patch
>> added the shared helpers describing that convention; wire up the JIT side
>> so that the second half of the return value actually lands in R2.
>>
>> Placing the second return half into R2 is possible on any JIT, but it needs
>> architecture-specific JIT work. Rather than requiring every JIT to
>> implement it at once, add a bpf_jit_supports_kfunc_ret_reg_pair()
>> capability, defaulting to false in the generic core; an architecture opts
>> in once its JIT handles the R0:R2 pair, and the remaining ones are left for
>> future work. Only the x86-64, arm64 and riscv64 JITs opt in so far.
>>
>> On arm64 and riscv64 the native second return register is already BPF R2
>> (x1 in bpf2a64[] and a1 in regmap[] respectively), so the upper half needs
>> no move at all, unlike x86-64's RDX->RSI. The lower half is covered by the
>> move into BPF R0 that those JITs already emit after every call, from x0
>> into x8 and from a0 into a5. This has been tested on x86-64 and arm64. The
>> riscv64 path is expected to work by the same register-mapping reasoning as
>> arm64 but has not been tested.
>>
>> bpf_add_kfunc_call() also rejects a kfunc that is marked KF_FASTCALL and
>> returns more than 8 bytes. The bpf_fastcall contract implemented by
>> mark_fastcall_pattern_for_call() assumes a call clobbers R0 plus the
>> registers holding its arguments, so a return in the R0:R2 pair would
>> clobber an R2 the caller expects the fastcall pattern to preserve. Such
>> a kfunc is rejected with -EOPNOTSUPP as well.
> This isn't a bug, but could the closing sentence be folded into the opening
> one? The paragraph opens by saying bpf_add_kfunc_call() rejects a
> KF_FASTCALL kfunc that returns more than 8 bytes, and closes with "Such a
> kfunc is rejected with -EOPNOTSUPP as well", which restates the same fact.
> The middle sentence carries the rationale (the fastcall clobber mask covers
> only R0 plus the argument registers, so R2 is assumed preserved), while the
> closing sentence adds only the errno. Something like "... is rejected with
> -EOPNOTSUPP" in the opening sentence would let the paragraph state the
> rejection once and spend its length on the fastcall rationale.

We should be okay here.

>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/32221968339

