Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09BF4335564
	for <bpf@vger.kernel.org>; Thu, 28 May 2026 20:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780001757; cv=none; b=V13equG//YxzTfvEt7qEmQrRgxK7B/2GJCtawTco0pzmwnsql8TLCaJWghTtYCsYMObpHsNmuqRfwZIgnMuAOXf/CQGperiAVlwKZRc9ccWKo44OprCMPP5XvQkChfY5AoqzOQfTVFXsDvicdZYwcqiVJIX+XZLB8Fgjki6QoQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780001757; c=relaxed/simple;
	bh=JV3EIWDWySQZcxrb8pQzc3tm/Lck3sm4Zs9zoMzr9xQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p1uhR02YX5OyvcLTwt3tp09l70VXODYa+dmyIBU9T2aR+TjSCI+8J1bhtNQjInWI+0mIvNKvtaImed/jDsb3VB4TrE2nAhoMHveytWB5fq+4/co79W6c7I+/Nhh70xtxnRnhzQVVYST/PRY4sZPuClJNMO4E87jgpiFXZa9Ivj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=qVqIsAvQ; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="qVqIsAvQ"
Message-ID: <a81c1628-685e-42dc-9860-8c8ed507328f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780001753;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JV3EIWDWySQZcxrb8pQzc3tm/Lck3sm4Zs9zoMzr9xQ=;
	b=qVqIsAvQglegZFfayfKEMzAzl6SkxVK0ShNflUelX4PkfKwlJqMqaIb/qEhNIX79y1qifl
	pR/3USsL6xoY1boiyrBe3aH5SKfRhUdQWwB6dIEdJRTZ5+10ACTS91rtwhmnqGDCTBn7gD
	ltjzhGgG2YLGxjWNAefuOW7koYuDnvg=
Date: Thu, 28 May 2026 13:55:43 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Use at least 10 args in stack
 argument tests
Content-Language: en-GB
To: Puranjay Mohan <puranjay@kernel.org>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Song Liu <song@kernel.org>, Xu Kuohai <xukuohai@huaweicloud.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 linux-arm-kernel@lists.infradead.org
References: <20260528161750.1900674-1-puranjay@kernel.org>
 <20260528161750.1900674-3-puranjay@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20260528161750.1900674-3-puranjay@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 5/28/26 9:17 AM, Puranjay Mohan wrote:
> On arm64, the first 8 arguments are passed in registers (x0-x7), so
> tests with 8 or fewer arguments never exercise the native stack argument
> path in the JIT. Increase argument counts to at least 10 across all
> BPF-to-BPF subprog and kfunc stack argument tests so that at least 2
> arguments land on the arm64 stack.
>
> For the two-callees test, bump foo1 from 8 to 10 and foo2 from 10 to 12
> args to preserve the different-stack-depth flavor of the test.
>
> The bpf_kfunc_call_stack_arg_mem kfunc is left unchanged at 7 args to
> avoid breaking the precision backtracking test which relies on hardcoded
> verifier log instruction indices.
>
> Suggested-by: Will Deacon <will@kernel.org>
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>

Acked-by: Yonghong Song <yonghong.song@linux.dev>

