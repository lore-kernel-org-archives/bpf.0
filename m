Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C26B3C1FD2
	for <bpf@vger.kernel.org>; Wed, 21 Jan 2026 19:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769022829; cv=none; b=GSrq3tB4OJffh83grFHltDr4DX5cieMO+ogdEFW0bbYzBpIKfh6eAS1JzVEBvVzH0HD2uJUAZlEWSzvJTjcKvpCBj8oP8YHq5WeqxXvsIqA6kZf03dzdDazpXh/ntBtzkI489Kfi7pGSAnjNkwieuGhQns/FMxr1r8AvhriFt/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769022829; c=relaxed/simple;
	bh=vjOVXSo3T85HEyir+H+bPxqWVOrjA1RPvJMn1qN1v64=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rL+krXeev2/I1jBruEHCNtBiKZi4TrXimw6WTe2mKkobWi9QnuaP3WSt+84f+AfpM8/iENJy1HKZQThrYqEEtE8NQKFVIJGo8O82H133a7S8c8FSJMpikSnfD0ZI9gd73je2UqzWOH4EyEWocQ4fsnCYSR5uJMkA7cAUtISyngo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=V0ZyBtvy; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="V0ZyBtvy"
Message-ID: <4423cc78-ec0c-4171-bf34-cc9b6596fa5a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1769022815;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E99BhWiOtvsKj9LVOMwPQhY+2wWMRQYA7EVhZuxyw14=;
	b=V0ZyBtvyKJZdMGqTU0STyz8AP7VS5c8AEuDECKwstnTitLABAxUEHAO0njHeGLiKpo1twQ
	ya7whERJswcaLc3EURTQ6V8hrKIaShPgeu3eQw3MjLGYN9uyhuD0LpExN//l+7hqliPdAo
	Wkl6hFyh6efkq/Ly73mg86SKA7f4QSI=
Date: Wed, 21 Jan 2026 11:13:29 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 4/4] selftests/bpf: Remove tests for
 prologue/epilogue with kfuncs
To: Jakub Sitnicki <jakub@cloudflare.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 Amery Hung <ameryhung@gmail.com>, netdev@vger.kernel.org,
 kernel-team@cloudflare.com, bpf@vger.kernel.org
References: <20260119-skb-meta-bpf-emit-call-from-prologue-v1-0-e8b88d6430d8@cloudflare.com>
 <20260119-skb-meta-bpf-emit-call-from-prologue-v1-4-e8b88d6430d8@cloudflare.com>
 <d4563561-c507-4876-8a03-40e4dca2a34e@linux.dev>
 <87o6mnthwf.fsf@cloudflare.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <87o6mnthwf.fsf@cloudflare.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 1/21/26 1:49 AM, Jakub Sitnicki wrote:
> On Tue, Jan 20, 2026 at 03:48 PM -08, Martin KaFai Lau wrote:
>> On 1/19/26 11:53 AM, Jakub Sitnicki wrote:
>>> Remove pro_epilogue_with_kfunc test program and its supporting code in
>>> bpf_testmod. This test exercised calling kfuncs from prologue and epilogue,
>>> which is no longer supported after the switch to direct helper calls.
>>
>> Is it easy to change it to test calling helper in pro/epilogue?
> 
> I gave it a shot and the obstacle is that bpf_cgroup_from_id and
> bpf_cgroup_release are not exported symbols, so they can't be referred
> to from bpf_testmod. We'd have to move the whole thing to lib/test_bpf
> so it's a built-in.

I was thinking of creating a helper in bpf_testmod.c but then noticed it 
may fail in the JIT that needs bpf_jit_supports_far_kfunc_call(). A 
cleaner way could be to use the existing pro/epilogue in bpf_qdisc ops. 
I was wondering if the __xlated test here could be quickly adapted in 
patch 4 but it seems that's not the case. The existing bpf_qdisc is 
testing it quietly without the __xlated, so no need to hold up this set.

For patch 3 and 4,

Acked-by: Martin KaFai Lau <martin.lau@kernel.org>
