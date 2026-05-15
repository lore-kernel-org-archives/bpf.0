Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE125371045
	for <bpf@vger.kernel.org>; Fri, 15 May 2026 01:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778809115; cv=none; b=sxrFFwCC5N4zae1mHe4ipN/QZXya5c2FeZVFlyWHWzGJGB//xNePSnOE+yNpnOo0KVmbkNZXz8NpUofO/qCEAcut2bdNEQiCuAUb8dqKhNIlW3aDQjLYpvLaKMMBYU9UqFWUQa4aevig/RL/xb4Zs/JmOhMjSfIl2mLwqbnDb/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778809115; c=relaxed/simple;
	bh=kMsGGfSwy3zUT3HnqLF0TZNWpqXnEuS23K+Vpwjhzlg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FP/5gZbQgA3GWj5P0+0g/3wmiw2gvJkqw6vUg34MAUM0xh9cvmJEzxdGbH2z/ZJ6FO/F7z2l+ocnQvSQTcsKsMJ8x1xMWmGNHc2kjHduIcSMecsIHXjsf5rYHykgpAr8FuKc39v72jCMqLve4qBbwp/juNeRAR4aGY8yIcGGXaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=q2nVTBgx; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="q2nVTBgx"
Message-ID: <ea3fc76a-42ca-41fb-a589-69bd13b09e03@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778809110;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=exow2UuxwPmSlXBn5xzieAsflEGqjXY/KN9NH+bCOsw=;
	b=q2nVTBgx1thask+qXlQTJxONscY8atxQlYxyD9D1+nIzC8g5SQQU81t7eYCxXLmsT7O+Ef
	MC9VNV4Nm+y8uPceRw0ZM/6jADauC9IMK1yY3E994GuprrL0D78GzXrflj90Zkxf22ZKCA
	ikZcZfg/U3xqduXFEJRKl3YTTV4vRHs=
Date: Thu, 14 May 2026 18:38:21 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 1/2] bpf: Validate outgoing stack args when
 btf_prepare_func_args fails
Content-Language: en-GB
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bot+bpf-ci@kernel.org,
 bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 kernel-team@fb.com, martin.lau@kernel.org, sashiko-bot@kernel.org,
 eddyz87@gmail.com, clm@meta.com, ihor.solodrai@linux.dev
References: <20260514184827.1619863-1-yonghong.song@linux.dev>
 <b3a04daccb7920ec037fa1e814c82d13b626bf24ceed7e03cf54624f9bf477de@mail.kernel.org>
 <DIISYMB87J47.2N64UTCAGDXFA@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <DIISYMB87J47.2N64UTCAGDXFA@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 5/15/26 1:53 AM, Alexei Starovoitov wrote:
> On Thu May 14, 2026 at 12:37 PM PDT, bot+bpf-ci wrote:
>>> commit 284cf62e75bd5632d61c528e48fe3f738870b269
>>> Author:     Yonghong Song <yonghong.song@linux.dev>
>>>
>>>      bpf: Validate outgoing stack args when btf_prepare_func_args fails
>>>
>>>      btf_prepare_func_args() sets sub->arg_cnt before validating arg types.
>>>      If validation fails (e.g. unsupported pointer type in a static subprog),
>>>      check_outgoing_stack_args() is skipped because btf_check_func_arg_match()
>>>      returns early. For static subprogs, check_func_call() ignores non-EFAULT
>>>      errors and proceeds with the call.
>>>
>>>      This causes the callee to read stack arg slots that the caller never
>>>      stored or not initialized, potentially dereferencing NULL caller->stack_arg_regs
>>>      or getting no-initialized value.
>>>
>>>      To fix the issue, when btf_prepare_func_args() fails and the subprog expects
>>>      stack args, call check_outgoing_stack_args() to verify the caller initialized
>>>      the slots. Return -EFAULT on failure so the error is not ignored.
>>>
>>>      Reported-by: Sashiko <sashiko-bot@kernel.org>
>>>      Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
>> This looks like a bug fix for stack argument handling. Should this include:
>>
>>    Fixes: 3ab5bd317ee2 ("bpf: Set sub->arg_cnt earlier in btf_prepare_func_args()")
> fixes tag is necessary indeed, but please drop 'Reported-by: Sashiko'.
> If we start doing such things every patch will have it.

Thanks. Will add fixes tag and drop 'Reported-by: Sashiko'.

