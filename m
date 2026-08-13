Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C1FB476066;
	Thu, 13 Aug 2026 12:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786625427; cv=none; b=AGx9uvjOPCpPR0fARPbtFWVuVXoBzvusflM71p2hEYWNVxNXsCq877d7xnS6QIQCWconCWgI47qL6zg5iJjWO8UhGQWFpjis6Bx2nXoWL+vfAnsx9lMV/35DP82Kw0pbW1QDD2y+CYzXuez7+YPjTfqqnvFgJRPHCA6Sn0ugSnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786625427; c=relaxed/simple;
	bh=RYDccI0QA6Um43ZF/VtKV08gHtakT3fB8+zdcL5JMrQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W1jKgx/bm42686PoW/Ogqc9WwaRwzzTP6v3PaOLdkSPFZ/M4Ae7fPbLNpuQyj9oNshhBNivn4SmkqUInYkxGjiVCi4h6pwJopWS4hexsoX1DytdE7dXJ0vuPjX/WrJxm+zfJ4GrS5oGZnPRn7QYaiPfqeTEqouNdFh1Qn1PG1qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=OSPM5xjh; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="OSPM5xjh"
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1wuUsw-002VAE-DU; Thu, 13 Aug 2026 14:50:14 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID;
	bh=kpCtHQ+/mzrhCBz+fmEmw3Nc2og9BhxFGTg1aNX2/QE=; b=OSPM5xjhAuaX2Q+s5R6wrW4nLg
	xppxhHi3QeHFcfF2G8zanCyFh6XRxQ3d/o2xh3xcPB58rZDp6778iWCTQaZzQ5bOV3lX9sFUlJ1xA
	QvcmOPIvPL2jBx+jnjo/PgHHYJtTUunPJg9WplqItEt/PjpKXhOC1lNGahzhnE48iXwJ+d+E7jCWp
	Gz0p7f1lFTQn32hB5r3Tchbzvl76bMtL8n0nLlKPNx9aefwj4+qVNdHGUrbhSEKj9HY1MiCHPo4wM
	edf6LJT1reoQG78AkADcS/9RfUdGQfYZ/9RgEtkYVNui6dJCXSDE7azKWxvKIFDXnTMs1T+CuVlWI
	ESwB6Mdg==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1wuUsq-0007jb-Hd; Thu, 13 Aug 2026 14:50:08 +0200
Received: by submission03.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1wuUsa-001ZG0-5l;
	Thu, 13 Aug 2026 14:49:52 +0200
Message-ID: <d14df8cf-4da5-42bb-a248-21b8d937ce63@rbox.co>
Date: Thu, 13 Aug 2026 14:49:50 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf v2 2/2] bpf: Unconditionally take socket references in
 lookup helpers
To: Jakub Sitnicki <jakub@cloudflare.com>, Eric Dumazet
 <edumazet@google.com>, Kuniyuki Iwashima <kuniyu@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Emil Tsalapatis <emil@etsalapatis.com>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, "David S. Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Willem de Bruijn <willemb@google.com>, Jiayuan Chen
 <jiayuan.chen@linux.dev>, Joe Stringer <joe@wand.net.nz>,
 bpf@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Sashiko <sashiko-bot@kernel.org>
References: <20260803-sockmap-lookup-tcp-leak-v2-0-306e025bfe66@rbox.co>
 <20260803-sockmap-lookup-tcp-leak-v2-2-306e025bfe66@rbox.co>
 <875x1qyyyx.fsf@cloudflare.com>
 <CAAVpQUBcDGX42Dyzo24U3iMKVyNajgOa5ZD7uX=DhSWf4Nb-qw@mail.gmail.com>
 <87tsp88vl4.fsf@cloudflare.com>
Content-Language: pl-PL, en-GB
From: Michal Luczaj <mhal@rbox.co>
In-Reply-To: <87tsp88vl4.fsf@cloudflare.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 8/5/26 16:56, Jakub Sitnicki wrote:
> On Tue, Aug 04, 2026 at 09:01 PM -07, Kuniyuki Iwashima wrote:
>> On Tue, Aug 4, 2026 at 3:14 AM Jakub Sitnicki <jakub@cloudflare.com> wrote:
>>>
>>> On Mon, Aug 03, 2026 at 11:00 AM +02, Michal Luczaj wrote:
>>>> Lookup helpers gate whether to acquire a socket reference on
>>>> sk_is_refcounted(), a check re-evaluated at release. An established socket
>>>> refcounted at acquire time can gain SOCK_RCU_FREE via
>>>> connect(AF_UNSPEC)+listen() before release runs; the release-side re-check
>>>> then reads sk_is_refcounted() == false and skips the put. The reference
>>>> leaks.
>>>>
>>>> Make acquire and release unconditional and symmetric: always take a
>>>> reference, always put it. Adapt sk_select_reuseport().
>>>>
>>>> Fixes: 6acc9b432e67 ("bpf: Add helper to retrieve socket in BPF")
>>>> Fixes: 64d85290d79c ("bpf: Allow bpf_map_lookup_elem for SOCKMAP and SOCKHASH")
>>>> Reported-by: Sashiko <sashiko-bot@kernel.org>
>>>> Closes: https://lore.kernel.org/bpf/20260701235552.2B0AA1F00A3F@smtp.kernel.org/
>>>> Signed-off-by: Michal Luczaj <mhal@rbox.co>
>>>> Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
>>>> ---
>>>> TC bpf_sk_assign() has the same issue; it takes a reference only when
>>>> sk_is_refcounted() is true at assign time, but sock_pfree() (the skb
>>>> destructor it installs) re-checks sk_is_refcounted() independently at
>>>> release time. The same connect(AF_UNSPEC)+listen() transition leaks the
>>>> socket here too. I'd welcome suggestions on the right way to handle this.
>>>
>>> Can we make this scenario unsupported?
>>>
>>> listen() could return EBUSY if called on a socket that is refcounted.
>>>
>>> WDYT?
>>
>> I discussed this kind of buggy rehash with Eric today.
>>
>> We can't make it unsupported although it's super unlikely
>> that this is used by a real application.
> 
> I'm just wondering why not?
> 
> First I thought is was due to POSIX compatibility but POSIX seems to
> define connect(AF_UNSPEC) only for connection-less sockets [1]:
> 
> """
> If he initiating socket is not connection-mode, then connect() shall set
> the socket's peer address [...] If the sa_family member of address is
> AF_UNSPEC, the socket's peer address shall be reset.
> """
> 
> So if this is Linux-specific behavior (?) and we don't exect any users
> to rely on it, why not change it and see if anyone complains?
> 
> Seems like wasted effort to try to make it work properly.
> 
> [1] https://man.archlinux.org/man/connect.3p

Patchwork does not list this series anymore, so I've picked only the
cleanup/optimization patches and re-sent them targeting bpf-next:
https://lore.kernel.org/bpf/20260813-sockmap-lookup-get-ref-v1-0-31f5d55f44ac@rbox.co/

thanks,
Michal


