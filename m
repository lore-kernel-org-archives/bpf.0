Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1425568FA3
	for <bpf@vger.kernel.org>; Tue, 29 Sep 2026 19:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790710916; cv=none; b=tClbgao2bpOc8olus3GMvMnytD9cZYUea2xjknvv4XSFTdpdFDlXDusHe9svzxtI+kO+7itiQvN2qPL4tD8G65kv2QPz4IWLq6KmcmV6b+nbSQc6MrtKguOMPovCVeGi9zfYvpCVJLNycjHoHMv7xjxE5qjzY2V6MTf8sc7mTzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790710916; c=relaxed/simple;
	bh=s7k5azmsPxbq7J6mhy/7oNjhou3mz8LlLKncTHHKD+M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SG4xV0yn9T3UAqfOtD53UZd2JVQKehZO6fjbBtALWPPq0Pk3jF/0Sxy/ZnwMmQMMgZiIN8zCX+ykX8l7IL/iBu+NNtD0xwEi2/Za1qtm2GD3+ff+VnmSWkXkjgLBC85FIPolGbQbXrO2wNP190QWmf1f8Kg7lg+GjF9EgZgstOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=dplLWs79; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=QMlCUMoT; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=RnHhLWzg; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=vOWbEXI3; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="dplLWs79";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="QMlCUMoT";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="RnHhLWzg";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="vOWbEXI3"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7423A21A80;
	Tue, 29 Sep 2026 19:41:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1790710908; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p5eOl/n10jFY8HGURcYb+jWrGXFuGwUMfio2zcjG4zw=;
	b=dplLWs79oAAJpT1HxcArH+hemV84qQJgb3ZHCwBoPGay59irFOTAh3ch5dAkfDpjivjJqF
	RVXSYjTwU/+PuR0Fw/IScqp5ypMuQf+PZsgsB/8tmdKVFDAo7kI/v7ET/RiaQ8mI/gT3Km
	pdUms0ds2MVvYzvInJE4HAu+1P8zhYI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1790710908;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p5eOl/n10jFY8HGURcYb+jWrGXFuGwUMfio2zcjG4zw=;
	b=QMlCUMoTD6Fb5z/8BwiEk8DDLJSniuvs8TlxxzN4CNNsfNxX3rrb13iW3pn5Gw5/xiOvd3
	dYtp+K6mTrVlffAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1790710904; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p5eOl/n10jFY8HGURcYb+jWrGXFuGwUMfio2zcjG4zw=;
	b=RnHhLWzgN/bd6DKda0ZXlPBh1W997K4tp9Oq+H3vZvUMoznhxqnuhnQuGQkmTIrPQvQ8y4
	w6d6KosL48VmxxAsis9UjEz7vnvhZQNL4VRMjngyHqVvxr6/t4yCrldNsd6yvCRxFGSCOy
	o7KSAa/n7RvW83Z/un9wHx3uEezvt0o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1790710904;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p5eOl/n10jFY8HGURcYb+jWrGXFuGwUMfio2zcjG4zw=;
	b=vOWbEXI3DLrzfcduWb6VoBRNnpUCwcgDJ9JSkrlZ2UXl8eHFgN3lH3Tldg4hEGkroxW1JP
	FZ6nR+dKxym5paBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 09492136E4;
	Tue, 29 Sep 2026 19:41:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id d+VwMXcUvGpMLwAAD6G6ig
	(envelope-from <fmancera@suse.de>); Tue, 29 Sep 2026 19:41:43 +0000
Message-ID: <1b0656cf-0b8c-4f1e-8044-1d8079722fa6@suse.de>
Date: Tue, 29 Sep 2026 21:40:43 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/16 net-next v2] ipv4: udp: split IPv4 specific logic
 into udp_ipv4.c
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org
References: <20260928193046.6698-1-fmancera@suse.de>
 <20260928193046.6698-7-fmancera@suse.de>
 <20260929193244.CA0F01F00893@smtp.kernel.org>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <20260929193244.CA0F01F00893@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.996];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	URIBL_BLOCKED(0.00)[suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_NONE(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email]
X-Spam-Score: -4.30
X-Spam-Level: 
X-Spam-Flag: NO

On 9/29/26 9:32 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] net: IPv4 BIG TCP UDP support broken by length extraction truncation in udp_rcv()
> --
> 
> commit 348e86f71529a8963fd2bec33bd3ebd366457c18
> Author: Fernando Fernandez Mancera <fmancera@suse.de>
> 
> ipv4: udp: split IPv4 specific logic into udp_ipv4.c
> 
> This commit moves IPv4-specific UDP socket functions from the generic UDP
> infrastructure into a new file, udp_ipv4.c. This change enables compiling
> the INET subsystem without IPv4 support.
> 
>> diff --git a/net/ipv4/udp_ipv4.c b/net/ipv4/udp_ipv4.c
>> new file mode 100644
>> --- /dev/null
>> +++ b/net/ipv4/udp_ipv4.c
> [ ... ]
>> +int udp_rcv(struct sk_buff *skb)
>> +{
>> +	struct rtable *rt = skb_rtable(skb);
>> +	struct net *net = dev_net(skb->dev);
>> +	struct sock *sk = NULL;
>> +	unsigned short ulen;
>> +	__be32 saddr, daddr;
>> +	struct udphdr *uh;
>> +	bool refcounted;
>> +	int drop_reason;
> [ ... ]
>> +	uh   = udp_hdr(skb);
>> +	ulen = ntohs(uh->len);
>> +	saddr = ip_hdr(skb)->saddr;
>> +	daddr = ip_hdr(skb)->daddr;
>> +
>> +	if (ulen > skb->len)
>> +		goto short_packet;
>> +
>> +	if (ulen < sizeof(*uh))
>> +		goto short_packet;
> 
> [Severity: High]
> Does this change in udp_rcv() break support for IPv4 BIG TCP UDP packets?
> 
> By replacing the robust udp_get_len() helper with a direct ntohs(uh->len)
> call and downgrading ulen to a 16-bit unsigned short, ulen evaluates to 0
> for BIG TCP packets (which intentionally have uh->len set to 0).
> 
> Because ulen evaluates to 0, the subsequent bounds check (ulen < sizeof(*uh))
> will evaluate as true (0 < 8), causing valid BIG TCP packets to jump to the
> short_packet label and be incorrectly dropped with
> SKB_DROP_REASON_PKT_TOO_SMALL.

This one is real I messed up when rebasing and resolving conflicts with:

efbc1aa8ed54d1f48d2855f8cff0017429531331

Will fix it on v3.

Thanks!

> 

