Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6181E1552FD
	for <bpf@vger.kernel.org>; Sat, 25 Apr 2026 05:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777093886; cv=none; b=fqWHAmMCBaMYF8nKsU/gaq2mQzF8BVa0JwnDkXiUA9/YLO4pgYAUOs9OzNxx1inNlsKtTipt97k+bHLCVjYB02Kls8Tu/65wyAup1w8Wc6JhB/EhGN2uw9ORbxghomQMf3JcnO7aiXfxcrZ5+Ic8g+rBFPVSrD99eHFi+xhTEsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777093886; c=relaxed/simple;
	bh=x6jmj4cwR75Wg88NdInEWbNT5Fm6CcanGE+mcOvn5NE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AgG5OKk8hbKB2+SUTgvtbPdlAWs5BbiSmRIk7SpZM8oT5oSLwgcVO7hfGAgZV9qaj7taMIAPuY4NColSDRfttwuEZHVvvQoyHDRXBJIu9JtYPQo9ikuEh2fqE2g6UEJiJqs+pjojsUFmTQ8wnrY9ns0ADMd29WSp0qVfKfMh0Y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=d0PCrTVU; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="d0PCrTVU"
Message-ID: <15903362-b172-4a7c-96aa-7f545a49ffda@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1777093882;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YXwcBGBwF9rLiimgWrhS2QW8KWqoo/Lcu6P6LP8hS9Y=;
	b=d0PCrTVUwnMFfwAzg1+W79kjG4/VFRX1f2Q1e33Sb4n2zk/hh3RppiB77yG2xi7qZ239gj
	FPj8SkFZPNBDvk27rqiXXgff81Guv54uo9uyVPYLQFSmW+Ra+C5Feytd3M0krLgGSTnvr3
	CmYVF5lRB8tVCyVdi4x27P37hd6fc1Q=
Date: Fri, 24 Apr 2026 22:11:15 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 04/18] bpf: Extend liveness analysis to track
 stack argument slots
Content-Language: en-GB
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 jose.marchesi@oracle.com, kernel-team@fb.com, martin.lau@kernel.org,
 eddyz87@gmail.com, clm@meta.com, ihor.solodrai@linux.dev
References: <20260424171454.2035580-1-yonghong.song@linux.dev>
 <6deff9aef8ef4f3d5ba6f9dde696f7d62c0b8c5a9baade13e99030209a2a60df@mail.kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <6deff9aef8ef4f3d5ba6f9dde696f7d62c0b8c5a9baade13e99030209a2a60df@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 4/24/26 11:00 AM, bot+bpf-ci@kernel.org wrote:
>> bpf: Extend liveness analysis to track stack argument slots
>>
>> BPF_REG_PARAMS (R11) is at index MAX_BPF_REG, which is beyond the
>> register tracking arrays in const_fold.c and liveness.c. Handle it
>> explicitly to avoid out-of-bounds accesses.
>>
>> In liveness.c, extend the arg tracking dataflow to cover stack arg
>> slots. Otherwise, pointers passed through stack args are invisible
>> to liveness, causing the pointed-to stack slots to be incorrectly
>> poisoned.
>>
>> Add a parallel tracking array (at_stack_arg_out/at_stack_arg_entry)
>> in arg_track_xfer() to record FP-derived values stored to outgoing
>> stack arg slots and to restore them on incoming reads. Extend
>> record_call_access() to check stack arg slots for FP-derived
>> pointers at kfunc call sites, reusing the record_arg_access() helper
>> extracted in the previous patch. Pass stack arg state from caller to
>> callee in analyze_subprog() so that callees can track pointers
>> received through stack args.
>>
>> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> The commit message describes fixing out-of-bounds accesses and extending
> liveness analysis, which suggests this fixes a bug introduced in a prior
> commit. Should this include a Fixes: tag? Looking at the commit history, it
> appears this should reference:
>
>      Fixes: 8ade62ae1543 ("bpf: Support stack arguments for bpf functions")

Not really. See "bpf: Enable r11 based insns". So you can consider this
still a preparation patch.

>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/24902767240

