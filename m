Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5613246C833;
	Tue, 18 Aug 2026 11:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787054184; cv=none; b=aEMeb/wCNVXpiJL1HPFVeG6cSBNMl2lnuDs27nyFMPQR7NZteC+CqwxUgD+9nJ7TyzGiznrc+qeWHkND3g9xWh8PxNqHkAe2RJjVRqatt14Oez8AL4VF/kI+idn7IsxqzjO1PqQaNFOYrEjbCw1Ya8Ff4lSpxAkFyr0tNhSK2k0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787054184; c=relaxed/simple;
	bh=Iv5US5B7t8r8Me9nlw1SOZ/vA3ero2ERM3lNPAW0fds=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=NNICDzrSnfo6kpfGRL5CnXH4Z91cB+omkFJuavKz08T2Yacne+JsWhddWpPTliwHmMYXT+NbjXdc2eMfbH0u4hERH6W5C6DwQigIEEqaYCzQwT4XIHvUa9SwuHK+nUBip/kZrMHHpF8eXMUlugCd6TF/n4dFI5qsR87kGw1YT3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=e+KJonJA; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="e+KJonJA"
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1wwIQ9-0009it-7C; Tue, 18 Aug 2026 13:55:57 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:
	Cc:To:Subject:From:MIME-Version:Date:Message-ID;
	bh=QK8T12e09pHXas09f+Y2o4MkHsqueci1dUh5t0k/mrw=; b=e+KJonJAoflPK5jE1ZZZqgdE1o
	8ISn9QjwRgXnp3RSrzbfqI1cGKU/0gqCi6U9KARclZeyRqXf9rDipPxrwt/mn1B2Dv8YfKVJo5XXb
	m4n/OrvfiGtCUDVb12JSilGxg+9e6Y5bMqBazM90+z7hD8etNGXVm3m1SxTaMRiT091CBmJEzHzWL
	yj1OSAbR1tAzB1cjZ796rCW0UiTVJ/SsOUChZ/mkFaKUlV24/53XmohqDXQI9F+6502f/RUkNHMRr
	E9zABRk+JTk4vL7ccsaUq2a2FLuBWbFFE99KG2AYYBjJ0CaHbSoiBCesYlnio6pt3sJtFWUBIhPaR
	jl7bhPfA==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1wwIPr-0003lQ-A5; Tue, 18 Aug 2026 13:55:39 +0200
Received: by submission02.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1wwIPa-00EDoG-OT;
	Tue, 18 Aug 2026 13:55:22 +0200
Message-ID: <d2b7e7e4-23b0-4efc-9192-279b33af8b99@rbox.co>
Date: Tue, 18 Aug 2026 13:55:21 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Michal Luczaj <mhal@rbox.co>
Subject: Re: [PATCH bpf-next 0/2] bpf: Cleanup & optimization
To: Jakub Sitnicki <jakub@cloudflare.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Emil Tsalapatis <emil@etsalapatis.com>,
 Ihor Solodrai <ihor.solodrai@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Jiayuan Chen <jiayuan.chen@linux.dev>,
 Kuniyuki Iwashima <kuniyu@google.com>, Willem de Bruijn
 <willemb@google.com>, bpf@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260813-sockmap-lookup-get-ref-v1-0-31f5d55f44ac@rbox.co>
 <871pc10ym9.fsf@cloudflare.com>
Content-Language: pl-PL, en-GB
In-Reply-To: <871pc10ym9.fsf@cloudflare.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/14/26 12:45, Jakub Sitnicki wrote:
> On Thu, Aug 13, 2026 at 02:41 PM +02, Michal Luczaj wrote:
>> Non-functional cleanup and a refcnt bumping simplification.
>>
>> Series extracted from a fix attempt[1] currently under discussion.
>>
>> [1]: https://lore.kernel.org/bpf/20260803-sockmap-lookup-tcp-leak-v2-0-306e025bfe66@rbox.co/
> 
> Discussion seems to have stalled. Or it's just vacation season.
> Anyway, I'm fine with fixing the refcounting your way.
> Merely wanted to offer an alternative idea for consideration.
> Thanks for working on this.

All right, I'll wait for this series to land in bpf.git (to avoid merge
conflicts) and then repost the fixes.

thanks,
Michal
