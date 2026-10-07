Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B13F54A0915;
	Wed,  7 Oct 2026 15:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791385212; cv=none; b=HJVkT6bYoShoT0jYS/CZz+JweUSyfjPD74CYuHm9qjVbbjAQ/Lva5hyCkgewGP9PyU0bncs7DsNQ/WpmZYXXnFCWEET4Y1ptu6liQb14InzmdMtURF8EclUspE9ypSDCGnIKJHbGRZKYrmyP19QEOQTccENiMFs1rGBQQ9O2rls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791385212; c=relaxed/simple;
	bh=G76zBPF5TjpzhHP008Ppuq7rGi4Oh3NJr3mZdHZ6BbI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mIZ6OdSd3k+yYhKH2pZ1QWdyW3vFEiUJHvlQozqQbpw6ob2aMv3znTqnQvssckWFe1MBe5YcggRzW9Oh/KcQX2+Duy+rdnzPIMYYqEtGm4kD98Ysx3awUgH+d/nOd7XocqSpSzt4MNoI0kjmBEXwLSKPDMBe1Epy6e5V45ekCzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=cIU6WXoY; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=2/1+t7zz; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=cIU6WXoY; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=2/1+t7zz; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="cIU6WXoY";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="2/1+t7zz";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="cIU6WXoY";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="2/1+t7zz"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3028E1F38E;
	Wed,  7 Oct 2026 15:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1791385205; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w80dgYPSS45qRc1JEm1pGFFYGt+E5Kke5+EAa6khtW0=;
	b=cIU6WXoY6rhLxnTSY+62ldSCqQfK/qCQCAYuE5UAVbdUCqLMmj9jBrqI355ze5SScKu5i4
	PZVKkLfP05prp9s4nDEGoWW8AZIcihTiXfgJjptG5VZQaAfcl1/u4Tp4+9j0iAen+Ogvbu
	WMG5KVRBsMvftUahmaEV89FUpxUQoMc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1791385205;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w80dgYPSS45qRc1JEm1pGFFYGt+E5Kke5+EAa6khtW0=;
	b=2/1+t7zzBDES/TXMw2j1UCi1Ywva5bUQGV7GaVNo7J2dgtwdskRod6Y69KEkXPjxJ41meq
	kPfmnHSxT4PVtMDQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1791385205; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w80dgYPSS45qRc1JEm1pGFFYGt+E5Kke5+EAa6khtW0=;
	b=cIU6WXoY6rhLxnTSY+62ldSCqQfK/qCQCAYuE5UAVbdUCqLMmj9jBrqI355ze5SScKu5i4
	PZVKkLfP05prp9s4nDEGoWW8AZIcihTiXfgJjptG5VZQaAfcl1/u4Tp4+9j0iAen+Ogvbu
	WMG5KVRBsMvftUahmaEV89FUpxUQoMc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1791385205;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w80dgYPSS45qRc1JEm1pGFFYGt+E5Kke5+EAa6khtW0=;
	b=2/1+t7zzBDES/TXMw2j1UCi1Ywva5bUQGV7GaVNo7J2dgtwdskRod6Y69KEkXPjxJ41meq
	kPfmnHSxT4PVtMDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6231F13354;
	Wed,  7 Oct 2026 15:00:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id RQ8RD3RexmplbwAAD6G6ig
	(envelope-from <fmancera@suse.de>); Wed, 07 Oct 2026 15:00:04 +0000
Message-ID: <41e10839-ec8d-4509-a6b2-45e009b9232c@suse.de>
Date: Wed, 7 Oct 2026 16:59:09 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/9] net: skbuff: convert most BUG_ON()s to
 WARN_ON_ONCE() and an error
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Josef Bacik <josef@toxicpanda.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Kaiyuan Zhang <kaiyuanz@google.com>, Mina Almasry <almasrymina@google.com>,
 Willem de Bruijn <willemb@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bpf@vger.kernel.org
References: <20261006-b4-skbuff-bug-on-v1-0-1b4434c5357c@toxicpanda.com>
 <willemdebruijn.kernel.140f4eac91ab3@gmail.com>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <willemdebruijn.kernel.140f4eac91ab3@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Flag: NO
X-Spam-Score: -2.79
X-Spam-Level: 
X-Spamd-Result: default: False [-2.79 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.996];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	TAGGED_RCPT(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_TO(0.00)[gmail.com,toxicpanda.com,davemloft.net,kernel.org,redhat.com,google.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]

On 10/7/26 4:48 PM, Willem de Bruijn wrote:
> Josef Bacik wrote:
>> I'm going through and reducing BUG_ON() usage in areas that have created
>> the most problems for us.  89 commits in the tree quote "kernel BUG at
>> net/core/skbuff.c", 31 of them since 2024, and some of those could be
>> triggered from inside a user namespace.
>>
>> The first patch is a fix: skb_copy_and_csum_bits() leaves stale bytes
>> in a buffer headed for the wire when it hits unreadable frags.  The
>> BUG_ON() conversion of the same function needs the same handling, so
>> it's here rather than sent separately.
>>
>> The rest of the series converts 17 of the 19 BUG_ON()s in skbuff.c.
>> Each one becomes
>>
>> 	if (WARN_ON_ONCE(cond))
>> 		<error path>;
> 
> Good idea. I was thinking of doing exactly this sweep after addressing
> one case recently in commit ee1972def665 ("net: downgrade BUG_ON
> EIOCBQUEUED in sock_sendmsg_nosec")
> 
> Instead of WARN_ON_ONCE, which still triggers a panic on systems with
> panic_on_warn, DEBUG_NET_WARN_ON_ONCE?

I agree with using DEBUG_NET_WARN_ON_ONCE at least for paths that can be 
triggered from userspace. I did something similar in Netfilter subsystem 
not so long ago.
