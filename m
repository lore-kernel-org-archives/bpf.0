Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37FBC221726
	for <bpf@vger.kernel.org>; Thu,  5 Mar 2026 21:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772745999; cv=none; b=CN5C1YosUbuo3L+9FgcsT0w8iJYjpKdA+AVcz2EX/LFBYgCdKIkp/QZdhlmwQJ0/gPPonw3xJEVX7yHZ7SOtgkiM4fWMEbhcTNp24uayHDIhOsZ/Fc7UPhr2cNjtFt1wlS4b2GRtF4v45EkmQiRR358z9s6p0Y+z1C+tfiO6POo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772745999; c=relaxed/simple;
	bh=vwfVkOraMGJmdZHCHUJ/QUhlMXoWfxMZmRFMx10lBzQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l/p0b0MxZzpPsPLX60PpgZKk2luAu8hvaYTg3jZjlgRMLgXX8lwlVHAyd7IXmuRNFICOTo6TYnx+txOQWopqsHqs79fRn76szuHum3c0RWlm8DBMIM/SBVoGVgrVfUeaBv9kY1Mw/mtG+Hok3o5lLgYDqIzwP/wL/+I+FZuYd9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=jocbHS79; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=DrQD5Fa1; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=jocbHS79; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=DrQD5Fa1; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="jocbHS79";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="DrQD5Fa1";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="jocbHS79";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="DrQD5Fa1"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 69A243E77E;
	Thu,  5 Mar 2026 21:26:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1772745996; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iga9xtQ/RUxO8Oc2EfPrhEW7eJRfKb85EfjFkpc3cNM=;
	b=jocbHS799Vr6qIUn2ScG6iCOso9QXpRQ9t4ZKA3FmhgyleS50HNl1+hY+umEdO4mA8vKTu
	i5+dEXLzcKH9HvZayExQtFjmTAYE09E7vjSzrwcbXSUeVavHa0ukl7hbK/9IbBLftbmDLa
	cshvyRAFdYepVOcLBI/mwCsu4uFFpR8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1772745996;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iga9xtQ/RUxO8Oc2EfPrhEW7eJRfKb85EfjFkpc3cNM=;
	b=DrQD5Fa1zlnfRmcbGWerrHNr+u9QDHr5f+eBUJf6qYNc63cqvuhWnDjw1p4Nxy2585YBA9
	/jbKeDrLUVx456BA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=jocbHS79;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=DrQD5Fa1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1772745996; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iga9xtQ/RUxO8Oc2EfPrhEW7eJRfKb85EfjFkpc3cNM=;
	b=jocbHS799Vr6qIUn2ScG6iCOso9QXpRQ9t4ZKA3FmhgyleS50HNl1+hY+umEdO4mA8vKTu
	i5+dEXLzcKH9HvZayExQtFjmTAYE09E7vjSzrwcbXSUeVavHa0ukl7hbK/9IbBLftbmDLa
	cshvyRAFdYepVOcLBI/mwCsu4uFFpR8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1772745996;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iga9xtQ/RUxO8Oc2EfPrhEW7eJRfKb85EfjFkpc3cNM=;
	b=DrQD5Fa1zlnfRmcbGWerrHNr+u9QDHr5f+eBUJf6qYNc63cqvuhWnDjw1p4Nxy2585YBA9
	/jbKeDrLUVx456BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 03F8E3EA68;
	Thu,  5 Mar 2026 21:26:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id R0CMOQr1qWncIgAAD6G6ig
	(envelope-from <fmancera@suse.de>); Thu, 05 Mar 2026 21:26:34 +0000
Message-ID: <88927403-ceab-45f9-bece-f95d656c6e4c@suse.de>
Date: Thu, 5 Mar 2026 22:26:16 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 2/3] bpf: bpf_out_neigh_v6: Fix nd_tbl NULL
 dereference when IPv6 is disabled
To: =?UTF-8?Q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>,
 Martin KaFai Lau <martin.lau@linux.dev>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
 David Ahern <dsahern@kernel.org>, Jay Vosburgh <jv@jvosburgh.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Hangbin Liu <liuhangbin@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260305-net-nd_tbl_fixes-v2-0-b7177db1a9f3@suse.com>
 <20260305-net-nd_tbl_fixes-v2-2-b7177db1a9f3@suse.com>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <20260305-net-nd_tbl_fixes-v2-2-b7177db1a9f3@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[suse.com,linux.dev,iogearbox.net,gmail.com,fomichev.me,kernel.org,google.com,davemloft.net,redhat.com,jvosburgh.net,lunn.ch];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DKIM_TRACE(0.00)[suse.de:+];
	R_RATELIMIT(0.00)[to_ip_from(RLjnappfs4fazzqxz8xagywz8p)];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Spam-Level: 
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 69A243E77E

On 3/5/26 9:37 PM, Ricardo B. Marlière wrote:
> When booting with the 'ipv6.disable=1' parameter, the nd_tbl is never
> initialized because inet6_init() exits before ndisc_init() is called which
> initializes it. If bpf_redirect_neigh() is called with explicit AF_INET6
> nexthop parameters, __bpf_redirect_neigh_v6() can skip the IPv6 FIB lookup
> and call bpf_out_neigh_v6() directly. bpf_out_neigh_v6() then calls
> ip_neigh_gw6(), which uses ipv6_stub->nd_tbl.
> 
>   BUG: kernel NULL pointer dereference, address: 0000000000000248
>   Oops: Oops: 0000 [#1] SMP NOPTI
>   RIP: 0010:skb_do_redirect+0x44f/0xf40
>   Call Trace:
>    <TASK>
>    ? srso_alias_return_thunk+0x5/0xfbef5
>    ? __tcf_classify.constprop.0+0x83/0x160
>    ? srso_alias_return_thunk+0x5/0xfbef5
>    ? tcf_classify+0x2b/0x50
>    ? srso_alias_return_thunk+0x5/0xfbef5
>    ? tc_run+0xb8/0x120
>    ? srso_alias_return_thunk+0x5/0xfbef5
>    __dev_queue_xmit+0x6fa/0x1000
>    ? srso_alias_return_thunk+0x5/0xfbef5
>    packet_sendmsg+0x10da/0x1700
>    ? srso_alias_return_thunk+0x5/0xfbef5
>    __sys_sendto+0x1f3/0x220
>    __x64_sys_sendto+0x24/0x30
>    do_syscall_64+0x101/0xf80
>    ? exc_page_fault+0x6e/0x170
>    ? srso_alias_return_thunk+0x5/0xfbef5
>    entry_SYSCALL_64_after_hwframe+0x77/0x7f
>    </TASK>
> 
> Fix this by adding an early check in bpf_out_neigh_v6(). If
> ipv6_stub->nd_tbl is NULL, drop the packet before neighbor lookup.
> 
> Suggested-by: Fernando Fernandez Mancera <fmancera@suse.de>
> Fixes: ba452c9e996d ("bpf: Fix bpf_redirect_neigh helper api to support supplying nexthop")
> Signed-off-by: Ricardo B. Marlière <rbm@suse.com>
> ---
>   net/core/filter.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/net/core/filter.c b/net/core/filter.c
> index ff02dbe4c94f..3344fa0789f0 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -2228,6 +2228,9 @@ static int bpf_out_neigh_v6(struct net *net, struct sk_buff *skb,
>   			return -ENOMEM;
>   	}
>   
> +	if (unlikely(!ipv6_mod_enabled()))
> +		goto out_drop;
> +

I don't think this is possible here if ipv6=m is set. Could you check 
that, please? A NULL check will be needed. See this similar situation:

https://web.git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git/commit/?id=168ff39e4758897d2eee4756977d036d52884c7e

Bonding is fine as it enforces `depends on IPV6 || IPV6=n`.

Thanks,
Fernando.

>   	rcu_read_lock();
>   	if (!nh) {
>   		dst = skb_dst(skb);
> 

