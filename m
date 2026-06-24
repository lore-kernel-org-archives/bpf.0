Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B060A3E5EEB;
	Wed, 24 Jun 2026 21:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782336285; cv=none; b=EKfI74Lxgb4ZtwLr2hDZ1JMyXsONvCNN40dLDfIU/D7NCR9cFsmvSfOioe8WfztxFH/b/lqQcT3iXxKqIKRewJ3MXdds/Wp2zaNn+jJWhmfN4pApWjHFwHM0rRmllZ+pZk+vbQGat8mqFNioacj+6+X0q7tQ6PimA3StQ4SfO8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782336285; c=relaxed/simple;
	bh=kHZtBaqOvCugjTHQj0B1OaA+osE8CuIzs3E7zkbVM5g=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=fD9OAurqTK8q4Pihd59c5fGDlu/2J4L6Mtgft2urdguPHRozNMl9IiygyVOikoKMxEjpscZcwlT6xGGoK0kM0yqj1hGIVaGOSSrixJwyX2U6WOs+MsBFA7UtJkShj1nGZg1+OReM3wxkvFvght+L4CBLQT2MLsmjYKWUVqUSn+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=LgP5Xp/i; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="LgP5Xp/i"
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1wcV5E-0071jo-45; Wed, 24 Jun 2026 23:24:32 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:
	Cc:To:Subject:From:MIME-Version:Date:Message-ID;
	bh=lyDPYtl2CSdhmwVeND7ks61hyybAjQmYm0gRw1OUEcc=; b=LgP5Xp/iVGQmTWyYUs3GITJh3B
	JH4Rvf6dCYVFWaOsiMWtRhSQtdiAEV5UFe69bpsnD5twwaZnRQwoaSjV8ehK3ctxefHh7xunAnnZu
	qXW628YRi1v5MhbtBMcmFKmOG5mqreXvROThz6/EhBiTfzIYDJzPj70BZ4Rb2IILBKU7Se2zyy76H
	BO8rIhrFaJq8BQm7FODMmbVPXjO1hOtlypPPALGHBj2u5eIuSGBnI7z6yZZHUEFLWMAg8Rjg7CjBO
	3PR3RaJqPDtkyhcFaqXSMN9MAYNHPPhKOV6TJBawOZrKRcvtz/L5eZBxPGLkeGT60V26Sl4DLdsIt
	/EGsMQWQ==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1wcV5D-00062X-6L; Wed, 24 Jun 2026 23:24:31 +0200
Received: by submission02.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1wcV52-0038uQ-MK;
	Wed, 24 Jun 2026 23:24:20 +0200
Message-ID: <e34d8743-58c3-4f50-8c0b-5e779cc53bdd@rbox.co>
Date: Wed, 24 Jun 2026 23:24:19 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Michal Luczaj <mhal@rbox.co>
Subject: Re: [PATCH bpf 2/2] selftests/bpf: Add test for UDP sock leak on
 sockmap lookup-bind-release
To: bot+bpf-ci@kernel.org, john.fastabend@gmail.com, jakub@cloudflare.com,
 jiayuan.chen@linux.dev, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, ast@kernel.org,
 cong.wang@bytedance.com, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com,
 shuah@kernel.org
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 martin.lau@kernel.org, clm@meta.com, ihor.solodrai@linux.dev
References: <20260623-sockmap-lookup-udp-leak-v1-2-05804f9308e4@rbox.co>
 <bd4abd3f584c38f1fc512a9d3ae1f90c2a374588fa23529b32b7f1aed6ab2ead@mail.kernel.org>
Content-Language: pl-PL, en-GB
In-Reply-To: <bd4abd3f584c38f1fc512a9d3ae1f90c2a374588fa23529b32b7f1aed6ab2ead@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/23/26 21:32, bot+bpf-ci@kernel.org wrote:
>> selftests/bpf: Add test for UDP sock leak on sockmap lookup-bind-release
>>
>>     Setup and join a cgroup, then attach a cgroup/connect4 program that runs
>>
>>        sk = bpf_map_lookup_elem(sockmap, 0)
>>        bpf_bind(ctx, sa, sizeof(sa))
>>        bpf_sk_release(sk)
>>
>>     Unpatched kernel leaks the socket.
>>
>>     Signed-off-by: Michal Luczaj <mhal@rbox.co>
> 
> This test reproduces a UDP socket leak across sockmap lookup-bind-release,
> but there is no Fixes: tag.
> 
> The sibling fix commit a2510dc351c5 ("bpf, sockmap: Don't leak UDP socks on
> lookup-bind-release") carries a Fixes: tag pointing at the commit that lifted
> the socket-state restriction allowing unbound UDP sockets into sockmap.
> 
> Should this test carry the same tag so it stays backportable alongside the
> fix?
> 
>   Fixes: 0c48eefae712 ("sock_map: Lift socket state restriction for datagram sockets")

I am skipping this suggestion as the test itself does not address any bugs
and requires no backporting.

Michal
