Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC8F40DFB7
	for <bpf@vger.kernel.org>; Wed, 25 Mar 2026 23:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774482103; cv=none; b=tx6tPlZnwYAAzEoOW/6cHPhho4lrTUaI8D8SB4CVnh9jcbsuO3JYjvzoszWe1c3WqGk7DwAVP6OxFFgxWqMCX1KBzTCRBGo2Qyvt6yrsHvnWsRYry4WT5ZjvJ0S4y8xRmq8dGkSFkifOgUrkfzspi3S5yIUf/0bFw4T7lUoEHg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774482103; c=relaxed/simple;
	bh=jYCVgmxz5jNZnOjNjMVwWJe9POcf7UkXjFSoSKNXTOY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V1ezCYg8d7HJtc4jDVi0qFiHfLknXWfUbu9HetPspzgXvyP9C6CTCINHb6/j67ah8W9wQNdTkZQP2rFdxTdqm+kEbrOX+3+1dOg6vu2fYt2HSnku+T9CV4VbiZebqtgZVVOUU4hH9P4NFP++NTkCNlus2AgCazfw4n+u3GdcOOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=XXRoKPtG; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=LG+3VGbH; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=XXRoKPtG; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=LG+3VGbH; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="XXRoKPtG";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="LG+3VGbH";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="XXRoKPtG";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="LG+3VGbH"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 4F6745BD81;
	Wed, 25 Mar 2026 23:41:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1774482100; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LOsq0jAIHPQdW7BmKMCZGbfbHnB6SIxQq+7TSBHwCKA=;
	b=XXRoKPtGRV4SHqp5BjVI/Zr+M2X8JRaRVCmPKyFF7/gJJI0pD/c4yKUSWa9EM/MzkyfHVs
	L6UlEBT/vJR1d60X452vDHsABQM/2BiETaYdt9zdO8yF9cuVjQzRysrcJ8unYK4x0dCDgQ
	f7JPs0A96OTWEkS8Hk+9K9rDz/VS3zA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1774482100;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LOsq0jAIHPQdW7BmKMCZGbfbHnB6SIxQq+7TSBHwCKA=;
	b=LG+3VGbHSIFyBqwrU9ASpgeY8SrBHK50UTCTlPXN7nxhzKK5eF9iaQ5nkSwlJ4XdjmbpH6
	3jrN/ms2jkQjCxDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1774482100; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LOsq0jAIHPQdW7BmKMCZGbfbHnB6SIxQq+7TSBHwCKA=;
	b=XXRoKPtGRV4SHqp5BjVI/Zr+M2X8JRaRVCmPKyFF7/gJJI0pD/c4yKUSWa9EM/MzkyfHVs
	L6UlEBT/vJR1d60X452vDHsABQM/2BiETaYdt9zdO8yF9cuVjQzRysrcJ8unYK4x0dCDgQ
	f7JPs0A96OTWEkS8Hk+9K9rDz/VS3zA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1774482100;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LOsq0jAIHPQdW7BmKMCZGbfbHnB6SIxQq+7TSBHwCKA=;
	b=LG+3VGbHSIFyBqwrU9ASpgeY8SrBHK50UTCTlPXN7nxhzKK5eF9iaQ5nkSwlJ4XdjmbpH6
	3jrN/ms2jkQjCxDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 05F4D4A0A2;
	Wed, 25 Mar 2026 23:41:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id EVj8ObJyxGlkdAAAD6G6ig
	(envelope-from <fmancera@suse.de>); Wed, 25 Mar 2026 23:41:38 +0000
Message-ID: <77792d0f-925f-4600-913c-b9dcdf8e9ea9@suse.de>
Date: Thu, 26 Mar 2026 00:41:32 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/11 net-next v5] bpf: remove ipv6_bpf_stub completely
 and use direct function calls
To: David Ahern <dsahern@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>
Cc: =?UTF-8?Q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>,
 Daniel Borkmann <daniel@iogearbox.net>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
 Guillaume Nault <gnault@redhat.com>, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, netdev@vger.kernel.org
References: <20260325120928.15848-1-fmancera@suse.de>
 <20260325120928.15848-10-fmancera@suse.de>
 <1ff47530-44ee-4012-a013-0202182de208@linux.dev>
 <99c37135-a1cc-4eb9-a910-ca38e129b5b0@suse.de>
 <93822084-f558-4194-be2b-cb328b81e412@kernel.org>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <93822084-f558-4194-be2b-cb328b81e412@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.79 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.19)[-0.952];
	MIME_GOOD(-0.10)[text/plain];
	TAGGED_RCPT(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[24];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[suse.com,iogearbox.net,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,linux.dev,fomichev.me,nvidia.com,vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid]
X-Spam-Flag: NO
X-Spam-Score: -2.79
X-Spam-Level: 

On 3/25/26 11:40 PM, David Ahern wrote:
> On 3/25/26 2:29 PM, Fernando Fernandez Mancera wrote:
>> Hi Martin,
>>
>> I don't think so. The IS_ENABLED(CONFIG_IPV6) check here is just to
>> prevent an undefined reference when compiling with CONFIG_IPV6=n. Note
>> that this code isn't reachable when ipv6.disable=1 is set during
>> booting, as it would have crashed even before this change because
>> ipv6_stub->nd_tbl is NULL if the IPV6 is disabled since booting.
>>
>> We addressed the vulnerable paths already during this series:
>>
>> https://lore.kernel.org/netdev/20260307-net-nd_tbl_fixes-v4-0-e2677e85628c@suse.com/#
> 
> What about the use case of IPv4 routes with IPv6 nexthop address? Has
> that been tested with a bpf forwarding program?
> 

Hi David, I did the following testing:

1. ipv6.disabled=1 since booting - the IPv6 nexthop cannot be added to 
the IPv4 route at all.

2. ipv6.disabled=1 after booting but before configuring the IPv4 route - 
same result as above.

3. ipv6.disabled=1 after booting and after the IPv4 is configured - the 
neighbor lookup is fine as the nd_tbl is initialized. It didn't crash.

I did tracing to make sure that code path was hit. I tested the 
forwarding with 3 namespaces 1<-->2<-->3 loading the BPF program on the 
second one performing the bpf_fib_lookup() instruction.

I could do more testing regarding this if needed, let me know.

Thanks,
Fernando.
