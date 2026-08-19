Received: from mta0.migadu.com (out-221.mta0.migadu.com [91.218.175.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE753A83AC
	for <bpf@vger.kernel.org>; Wed, 19 Aug 2026 15:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787155089; cv=none; b=HJBxGp3HkF3mNGDVoedQMZxX5BDO6d6zcBfMVR1uFO/Ztzyc9PVF5FTx4sZRch56CXB+LdgdAV3ONN+Lyb+Hwy3/bBGPTA5xVMHRm+Z0cttQW/xhIF9eBJAN1AC4CZ/tZueaU2JjxBexi3ri/QQxsc9OdDdhTPyFLm2agbPPDpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787155089; c=relaxed/simple;
	bh=FWaFGKWuUxeFPH6zBXBVFa0pgthvHQeLweM0aRM9/Jw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M+JyJW93gLq70rGUU34taLb/y7zTLxLPMclOsX8BlpQWJ/Ti33cALAw0P0b3+7mhnwUNdLaqlrlkhLPkCkHmxVOvUbFNgAP+BcDxco4xqa8lkNFxuOirDKNn2KvCMAQXqgMJ82Rx3FEObIxx4QxWj+XLzXPm2Einu0Z88KjxlWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GuZZ7NAv; arc=none smtp.client-ip=91.218.175.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GuZZ7NAv"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=FWaFGKWuUxeFPH6zBXBVFa0pgthvHQeLweM0aRM9/Jw=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787155085; v=1; x=1787759885;
 b=GuZZ7NAvnHOmVNuJYrhO7TiHwIIy/Dutl3lx/yw/5ozSGqnoEIzFDl19/oGiP2dtSXz0mVcO
 tnwte5/h9/Wvgkw4MHdfXCijC+n/vNU7ti0Xh3YCy0jfzQrAXgefsrhjrlN5/AIlPKAPStY7RLf
 R0uWfMNfcdVFBiR0/bMZGMC8=
X-Envelope-To: bpf@vger.kernel.org
Received: from [IPV6:2a03:83e0:1151:15:1c5e:37e8:36:dd37] (2620:10d:c090:500::7:5d0e)
	by smtp.migadu.com with ESMTPS id b876b1494aa10217;
	Wed, 19 Aug 2026 15:58:05 +0000
X-Mizu-Trace-ID: b876b1494aa10217
X-Migadu-Flow: FLOW_OUT
Message-ID: <8acfeb2f-664b-421c-b98a-58f64387a6eb@linux.dev>
Date: Wed, 19 Aug 2026 08:58:00 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v7 05/10] bpf: Account R2 of register-pair
 returns in live register analysis
Content-Language: en-GB
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 eddyz87@gmail.com, kernel-team@fb.com, martin.lau@kernel.org, clm@meta.com,
 ihor.solodrai@linux.dev
References: <20260819055304.3296353-1-yonghong.song@linux.dev>
 <c980dd5e462778928bef54067202b7861ff06e0e6abf6667d7cd8ee79f2431d8@mail.kernel.org>
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <c980dd5e462778928bef54067202b7861ff06e0e6abf6667d7cd8ee79f2431d8@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 8/18/26 11:32 PM, bot+bpf-ci@kernel.org wrote:
>>      bpf: Account R2 of register-pair returns in live register analysis
>>
>>      A BPF_EXIT of a subprogram returning a value larger than 8 bytes (a
>>      struct/union or an __int128) reads R2 as well as R0, since the second half
>>      of the return value is passed back in R2. compute_insn_live_regs() only
>>      marked R0 used at exit, so a callee's R2 could be considered dead and
>>      cleaned from checkpointed states, which would allow unsound state pruning.
>>
>>      Mark R2 as read at the BPF_EXIT of a subprogram that does return a register
>>      pair. bpf_compute_live_registers() now loops over the subprograms and, for
>>      each, over the [start, end) instruction range from env->subprog_info[], so
>>      the return convention is queried once per subprogram through
>>      bpf_ret_reg_pair() rather than once per instruction.
>>
>>      Marking R2 at every exit instead would be simpler, but R2 would then stay
>>      live backwards across any call that is not followed by a write to R2, which
>>      is nearly every program, and would needlessly hurt state pruning.
>>
>>      Acked-by: Eduard Zingerman <eddyz87@gmail.com>
>>      Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> This commit fixes a bug where R2 was not marked as live at BPF_EXIT for
> subprograms returning register pairs, which could allow unsound state
> pruning. The bug was introduced when register-pair return support was
> added. Should this include:
>
>    Fixes: b176d222c14a ("bpf: Add helpers to describe the R0:R2 return register pair")

No need to have above Fixes in the same series.

>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/32221968339

