Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA98346ADE
	for <bpf@vger.kernel.org>; Tue,  3 Mar 2026 02:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772505583; cv=none; b=LkXsSA2KX1E+Lfh/EJuQE1SB3gKNNMhhtrFmg0AXqWJRqr/ODX8VDpXyil0LNqmWTR9p40xp4sdo3CuCfBQnhGsWnyVGXuuMHAvbqIIN6UcATklHtDrAV3xxd/QuNKhwBRMkpntb9E7CI06uaPYCCZggeLEDsOu0bWDUJarnLAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772505583; c=relaxed/simple;
	bh=T0cqjCwPvGE8zwx/T0Uo+KK3ac7/xsG3+KRqmE8nIrg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W1hrAB5XdZ9gYOTbQvoK4ucNfPTw1KVX8sh68n1p1xHBbiOZWhMFpPoF3useYPoQ7ZOspWKmq6JUu7aMsNNHDj2fGG3Hiu5efEyw0mzW/5YwyU0mCXQs1BvxuAYyAhbYJQZTMkyFd7TwDWzb8QIXcdBD+OihKPekv/iAqLEvzp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=h4zQtD5J; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="h4zQtD5J"
Message-ID: <ad50571a-ce13-47c9-ba5d-570adb4fc689@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772505580;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rcQBl4+DxnX9Uk553kw+FydgskPAvd1e5qW9QMDg1UA=;
	b=h4zQtD5J206GALJqu1wb/dXYfS5GUVmCpXl1UqIOD5MdWa+eD+g+T4do3XtJzMu4wE1DS/
	X140H9qyAXu8V2wmLH6Pr5zQrnkM0L1qBotj20zFiWvR2SBDA3dulwoSwrhQiWXdaAgSi3
	h459+M6/hwAC6qLU5ewbYsQgBjgbZww=
Date: Mon, 2 Mar 2026 18:39:30 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf v3] bpf: fix: Race condition in
 bpf_trampoline_unlink_cgroup_shim
To: xulang@uniontech.com
Cc: bot+bpf-ci@kernel.org, andrii@kernel.org, ast@kernel.org,
 bpf@vger.kernel.org, clm@meta.com, daniel@iogearbox.net, dddddd@hust.edu.cn,
 dzm91@hust.edu.cn, eddyz87@gmail.com,
 hust-os-kernel-patches@googlegroups.com, ihor.solodrai@linux.dev,
 kaiyanm@hust.edu.cn, martin.lau@kernel.org, sdf@fomichev.me,
 yonghong.song@linux.dev
References: <FFFA8066FE63B894+20260228022403.99235-1-xulang@uniontech.com>
 <5a89fd3edd5e90ed47ff1189efdfa626f9b4610daa02da46a3a8fe4d5762796c@mail.kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <5a89fd3edd5e90ed47ff1189efdfa626f9b4610daa02da46a3a8fe4d5762796c@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 2/27/26 7:04 PM, bot+bpf-ci@kernel.org wrote:
>> diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
>> --- a/kernel/bpf/trampoline.c
>> +++ b/kernel/bpf/trampoline.c
> 
> [ ... ]
> 
>> @@ -1003,12 +1004,13 @@ struct bpf_attach_target_info tgt_info = {};
>>
>>   	shim_link = cgroup_shim_find(tr, bpf_func);
>>   	if (shim_link) {
>> -		/* Reusing existing shim attached by the other program. */
>> -		bpf_link_inc(&shim_link->link.link);
>> -
>> -		mutex_unlock(&tr->mutex);
>> -		bpf_trampoline_put(tr); /* bpf_trampoline_get above */
>> -		return 0;
>> +		link = &shim_link->link.link;
>> +		if (link == bpf_link_inc_not_zero(link)) {
> 
> The other callers of bpf_link_inc_not_zero() check the return value
> using IS_ERR(), for example bpf_link_by_id():
> 
>      link = bpf_link_inc_not_zero(link);
> 
> and bpf_link_get_curr_or_next():
> 
>      link = bpf_link_inc_not_zero(link);
>      if (IS_ERR(link)) {
> 
> Should this use the same IS_ERR() pattern for consistency? Something
> like:
> 
>      if (!IS_ERR(bpf_link_inc_not_zero(link))) {

The same feedback by ai-review. I don't have a strong opinion. However, 
the newly added "struct bpf_link *link" variable is not needed also. I 
would carry the ai's suggestion further and remove the new local 
variable also. Just test:

	if (!IS_ERR(bpf_link_inc_not_zero(&shim_link->link.link))) {

> 
>> +			/* Reusing existing shim attached by the other program. */
>> +			mutex_unlock(&tr->mutex);
>> +			bpf_trampoline_put(tr); /* bpf_trampoline_get above */
>> +			return 0;
>> +		}
>>   	}
> 
> This commit fixes a use-after-free introduced by commit 69fd337a975c
> ("bpf: per-cgroup lsm flavor"), which added the bpf_link_inc() call
> that could resurrect a zero-refcount link. It appears to be missing
> a Fixes: tag. Martin KaFai Lau's review of v2 also expected this tag
> to be present.

Indeed, please ensure to address the earlier reviewer's feedback.

pw-bot: cr

> 
> Suggested:
> 
>      Fixes: 69fd337a975c ("bpf: per-cgroup lsm flavor")
> 
> https://lore.kernel.org/bpf/cd99eba7-ac03-4b53-a79c-a6206abbddb6@linux.dev/
> 
> 
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/22511586078
> 
> AI-authorship-score: low
> AI-authorship-explanation: Human authorship patterns: references maintainer suggestion, informal testing description, iterative v1/v2/v3 development with reviewer feedback, addresses a bug reported by a different researcher.
> issues-found: 2
> issue-severity-score: low
> issue-severity-explanation: Missing Fixes: tag (requested by BPF maintainer) and non-standard bpf_link_inc_not_zero() return value comparison pattern; neither causes runtime problems.

