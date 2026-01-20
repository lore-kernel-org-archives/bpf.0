Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B489A31E0F2
	for <bpf@vger.kernel.org>; Tue, 20 Jan 2026 23:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768952899; cv=none; b=K6foZD7Ev9HepzL+NpanlYHjfSpnTHvOQ0l6DfQuw7UyVaq06+gDKHLLvWclT7auZcBLzofNMyYpfvuLqhZuRtZmPaFp9RtAC1ipWOZtSNkzHXlXlqWl8s/m+QX/TTvCr12Nh0TJoL95nVaT3wJaP/wJt2ZIRXr7uUOgFjXX59o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768952899; c=relaxed/simple;
	bh=JHw6MBiOVUzAC/kgADPaTZyeVExn3ug1Mz3Odgfrr4o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CJEZLslQ+vt9lDJRvqs+U5Ds2aCsa7VTczIJgiBzDCyO/Pj+UlzVeexM9rtJsQv24qKSuMy7ib6i4onxfgN5zYd0d0O3YZScIwmI3kWXhqjkPOCmKaCJYynTeRUTPXjX8VehPOzHdpgpJT1ERwt+rNYFbW8MQNX+vFuOBIt7dio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LgMg9kRJ; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LgMg9kRJ"
Message-ID: <d4563561-c507-4876-8a03-40e4dca2a34e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768952895;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JHw6MBiOVUzAC/kgADPaTZyeVExn3ug1Mz3Odgfrr4o=;
	b=LgMg9kRJNxVEDVsSDqM/SaDP/Z7imlAm1yRHwTzWmimUpLnMCQpckmMrXWR+CPltw01xV6
	V0W7gBu/vjLdpWZ6dWvW7HSRoA9bu8twwBz+bPrIrl9xnc9tSMoKtYtXQiAbVTzlaqlOb6
	ib8HtB0k4Piku0wRfuODA6R/H3LsCQA=
Date: Tue, 20 Jan 2026 15:48:06 -0800
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
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20260119-skb-meta-bpf-emit-call-from-prologue-v1-4-e8b88d6430d8@cloudflare.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 1/19/26 11:53 AM, Jakub Sitnicki wrote:
> Remove pro_epilogue_with_kfunc test program and its supporting code in
> bpf_testmod. This test exercised calling kfuncs from prologue and epilogue,
> which is no longer supported after the switch to direct helper calls.

Is it easy to change it to test calling helper in pro/epilogue?

