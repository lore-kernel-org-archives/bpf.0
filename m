Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7249530F7FB
	for <bpf@vger.kernel.org>; Sat, 21 Mar 2026 16:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774112139; cv=none; b=Chd5gJDYcXxldd9DdCZpaZk1tu7uJ0Sdb/jBG/GMSDwfizSphod80S2Hy/6s70qFhlVbGdUR+CMHavkNfHDbAg4kyplNmtkFNhxY75HMeqi6Hd0CKM6BflmvZ4Ce4s6S6OCkGGFN0j+jCG7X7tXr/cMYlTCQukD/mWnNOs4dK8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774112139; c=relaxed/simple;
	bh=MKn/1LL70V0yuCTc9ZKa5/QA2zU32c+fbOYMAks8u4g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fn3HMSIjP+tmNWlwdH1e/jVdVKWu9LwDw/B5GYwlZ8xmlKWj6GFDKFg8FsDtp0zwy9WKAS6F3COdMeL2nFvrQHFbibSwM4M9h8/y3n7zJwsCN3lOEIQeSU46rVxhvLedZUWc1QvGkmgy0UWi4IXTHYRh26mdZGYIM2hSg9Qc0dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=g/rXUFhk; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="g/rXUFhk"
Message-ID: <98688c8e-9f10-4b8c-96a6-a692bb9c4e24@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774112126;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tCl0T88JvDdkpY9oIKdf6SD9Jh/555wS+PDgvRNEt8o=;
	b=g/rXUFhkV0sRpBBS+k8oRTvdEUURRjIm0khQoRTQMytKzWcbNSbnL4E4dPyEfCxqaPJ+vl
	0j9BhUgd1FoLmoJ6b2gVveSbaq/yqxhbVnXnQ0XI+EpsKeUJ4uO/i/0ZWp1yvbX00XHCXa
	1jwuWZRbevAes0uE8D6gpQLIEhavybY=
Date: Sat, 21 Mar 2026 09:55:14 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf v2 2/2] selftests/bpf: Add tests for bpf_throw lock
 leak from subprogs
Content-Language: en-GB
To: Ihor Solodrai <ihor.solodrai@linux.dev>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman
 <eddyz87@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-team@meta.com
References: <20260320000809.643798-1-ihor.solodrai@linux.dev>
 <20260320000809.643798-2-ihor.solodrai@linux.dev>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20260320000809.643798-2-ihor.solodrai@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 3/19/26 5:08 PM, Ihor Solodrai wrote:
> Add test cases to ensure the verifier correctly rejects bpf_throw from
> subprogs when RCU, preempt, or IRQ locks are held:
>
>    * reject_subprog_rcu_lock_throw: subprog acquires bpf_rcu_read_lock and
>      then calls bpf_throw
>    * reject_subprog_throw_preempt_lock: always-throwing subprog called while
>      caller holds bpf_preempt_disable
>    * reject_subprog_throw_irq_lock: always-throwing subprog called while
>      caller holds bpf_local_irq_save
>
> Assisted-by: Claude:claude-opus-4-6
> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>

Acked-by: Yonghong Song <yonghong.song@linux.dev>

