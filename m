Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEEEC3BADAA;
	Wed,  5 Aug 2026 15:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785942052; cv=none; b=P61sraqgNDPxcSpMhFpzA+e0TBpQ3pOfHZRCzr2A/GSN22EbU0ovX+g/0G2KDuYw48hdqZQ0BiJ8LHgZM9zjTaSLeBGPxvCoQx1WEAaz2dRyezQmwTMXF+b4osOBopeoR0mEHRbuYa5ic3K5W7rJ2E6/siWlo006VWjQA7PEmtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785942052; c=relaxed/simple;
	bh=BpM6LcH6JMBUFl9Yn0UsTvy1li+uJZz7INVMq56n7x8=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=n90s1/WOCg+Hls6PZin5PIQMzeJjDKVJlmpUEzInw71ugTlTLhKIczj40gZf2o5opgVRkpYhTwshVWADyF2IeGlLycrNnIeUNO7IQ0gDOXHKxRlUp6SCEPHBOxI5w/OyRQWwF88IWeaSsSEDhzGsozJ7ZFTlyw9uSsQ880pl2i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=StozFnBs; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="StozFnBs"
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1wrd6Y-008Cww-0f; Wed, 05 Aug 2026 17:00:26 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:
	Cc:To:Subject:From:MIME-Version:Date:Message-ID;
	bh=4wWm0XSavEASEIUg8MVDlPFq0X7NdXbC6ZWOPd2Q2Y0=; b=StozFnBsw3pZqF47PbT4ojCfCq
	GO9RfHCf21r9bREXDYgmWnZudtY/ynSMj/pY6xHp9kHMuNfBEryGfiEarnSAMpWWlKUHF+Kx4NSO0
	HpESNtzLYyVJyUkgQ6R3y93bVlzA+9sMnNjPTgD/rMik3xQpNuHZxvcWl5FgL/yF23K+A8RaRBs2f
	QVaaHF46FUeuEWeODafLa5wmdwfhDqDJv9+xFqo1gA0OTMZVyrjZqfVyGeaVIuIZDrY8V2Nf6aNC9
	Q7lioKiAJo5/6wHWDypWgvuGFDAyfHCcaeArSXStpMJxxJEn3immo+jnh6zhx3EauPt+1Vdkm2Su2
	FwePau9Q==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1wrd6X-0004mA-1w; Wed, 05 Aug 2026 17:00:25 +0200
Received: by submission02.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1wrd6N-004B1a-Eh;
	Wed, 05 Aug 2026 17:00:15 +0200
Message-ID: <f131ac25-24c2-40b7-ad3a-f5a283b39e7f@rbox.co>
Date: Wed, 5 Aug 2026 17:00:14 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Michal Luczaj <mhal@rbox.co>
Subject: Re: [PATCH bpf v2 2/2] bpf: Unconditionally take socket references in
 lookup helpers
To: Jakub Sitnicki <jakub@cloudflare.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Emil Tsalapatis <emil@etsalapatis.com>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>,
 Willem de Bruijn <willemb@google.com>, Jiayuan Chen
 <jiayuan.chen@linux.dev>, Joe Stringer <joe@wand.net.nz>,
 bpf@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Sashiko <sashiko-bot@kernel.org>
References: <20260803-sockmap-lookup-tcp-leak-v2-0-306e025bfe66@rbox.co>
 <20260803-sockmap-lookup-tcp-leak-v2-2-306e025bfe66@rbox.co>
 <875x1qyyyx.fsf@cloudflare.com>
Content-Language: pl-PL, en-GB
In-Reply-To: <875x1qyyyx.fsf@cloudflare.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/4/26 12:14, Jakub Sitnicki wrote:
> On Mon, Aug 03, 2026 at 11:00 AM +02, Michal Luczaj wrote:
>> Lookup helpers gate whether to acquire a socket reference on
>> sk_is_refcounted(), a check re-evaluated at release. An established socket
>> refcounted at acquire time can gain SOCK_RCU_FREE via
>> connect(AF_UNSPEC)+listen() before release runs; the release-side re-check
>> then reads sk_is_refcounted() == false and skips the put. The reference
>> leaks.
>>
>> Make acquire and release unconditional and symmetric: always take a
>> reference, always put it. Adapt sk_select_reuseport().
>>
>> Fixes: 6acc9b432e67 ("bpf: Add helper to retrieve socket in BPF")
>> Fixes: 64d85290d79c ("bpf: Allow bpf_map_lookup_elem for SOCKMAP and SOCKHASH")
>> Reported-by: Sashiko <sashiko-bot@kernel.org>
>> Closes: https://lore.kernel.org/bpf/20260701235552.2B0AA1F00A3F@smtp.kernel.org/
>> Signed-off-by: Michal Luczaj <mhal@rbox.co>
>> Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
>> ---
>> TC bpf_sk_assign() has the same issue; it takes a reference only when
>> sk_is_refcounted() is true at assign time, but sock_pfree() (the skb
>> destructor it installs) re-checks sk_is_refcounted() independently at
>> release time. The same connect(AF_UNSPEC)+listen() transition leaks the
>> socket here too. I'd welcome suggestions on the right way to handle this.
> 
> Can we make this scenario unsupported?
> 
> listen() could return EBUSY if called on a socket that is refcounted.
> 
> WDYT?

I'm not sure I understand. Isn't a freshly created socket already
refcounted?

