Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0DAA5CDF1
	for <bpf@vger.kernel.org>; Sat, 25 Apr 2026 05:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777093831; cv=none; b=p4lV+SAOY1cgO+7fp9G7QdOVx9oRaif3mA/qW1C4rlglMLlOqqHUojzrY+yblwsn1ecDzEoZ1jZILe7565UiBGclN/2o0zzLtAD9hIU9m976Agnl4yFXm28iMWY7IFQ5txivkUX1S9Zn/pRuiXKoQefr6R/NcWZc58k0zW19E9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777093831; c=relaxed/simple;
	bh=APbou66HdgtT8/nB8FJuySXXpKdPRX2BmSlM1c53pEQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H1pozhFICCR3iQGVN6M7dCaL9yIqV7jcsHgfM7JYlWibOUToRffy74/1mgId49DPXpZcl0ezkMgBz3wYdwXI54f7PrE1JOvLdGYs5Dsw6C8M8PbQGVDBOTG1D3w5/YZF+ha9FlKhTd6CWyIcPGGV4+pLrn6DaYC9hVQARhG+8B4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XcyCKtM9; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XcyCKtM9"
Message-ID: <e489d03d-566b-4399-b873-4df20997ac86@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1777093827;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=APbou66HdgtT8/nB8FJuySXXpKdPRX2BmSlM1c53pEQ=;
	b=XcyCKtM9VMdbcOETI4iGbznzpxV4EfMJNryGEzH6c1NlKFa5WpVP1WpbwE2O+DJYMQi5Ar
	YPdNrPMIg558u4CcNOHhZgE0J5KQ8rO5z+8YrzU2cJ5s/S9H6BlOaJXllysOE7qywql7Rt
	MjjYrG5b2Qg0qC6ZsnhD1F2a8zhOChM=
Date: Fri, 24 Apr 2026 22:10:16 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 02/18] bpf: Add precision marking and
 backtracking for stack argument slots
Content-Language: en-GB
To: bot+bpf-ci@kernel.org, bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 jose.marchesi@oracle.com, kernel-team@fb.com, martin.lau@kernel.org,
 eddyz87@gmail.com, clm@meta.com, ihor.solodrai@linux.dev
References: <20260424171443.2034958-1-yonghong.song@linux.dev>
 <21545d85b7307fb5c8e05c70a9b302af95bea55e79e749cd379a2c053ff08c75@mail.kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <21545d85b7307fb5c8e05c70a9b302af95bea55e79e749cd379a2c053ff08c75@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 4/24/26 11:00 AM, bot+bpf-ci@kernel.org wrote:
>> bpf: Add precision marking and backtracking for stack argument slots
>>
>> Extend the precision marking and backtracking infrastructure to
>> support stack argument slots (r11-based accesses). Without this,
>> precision demands for scalar values passed through stack arguments
>> are silently dropped, which could allow the verifier to incorrectly
>> prune states with different constant values in stack arg slots.
> This commit appears to be fixing a bug introduced by commit 8ade62ae1543
> ("bpf: Support stack arguments for bpf functions"). Should this commit include
> a Fixes: tag?
>
> Suggested: Fixes: 8ade62ae1543 ("bpf: Support stack arguments for bpf functions")

Not really. See "bpf: Enable r11 based insns". So you can consider this
still a preparation patch.

>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/24902767240

