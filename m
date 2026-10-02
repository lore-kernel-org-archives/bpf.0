Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E893C09EF;
	Fri,  2 Oct 2026 10:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790937763; cv=none; b=OlvOgo//AzRUuMBlbbjuJEb+N7KabsXeY3V1rGSJWFWhHnx1JAYkoXBlaXyrSqiyEzpqZ446Ni3P+sa+psMTvMk/iDXDiWXuipHmDye+50j4soScJ2Vx6TZdBtkcOhedFroZT40FBclVXqhK04YvwOaEQy4y/UsjRp90s6wCX4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790937763; c=relaxed/simple;
	bh=MOf5ttjotxFZUcXLkswkUs5bKxaUAAx4fQEpPTn0ewg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ckX+Z4bNgqeVJVonvRKAnEYKtEdeVv/1Jrq+nTGcxH7wziqWUamoi7O+tMu9hJWCDrUJbhQIdYunoB2iCmgrRhxeCC5aNJG6gs+DSITDPO8Cf9Lp8VgZEO9xck69NzMiBESrKULGokY/obW9VOp8IKGDx/oc/kmPHg2isHoS4JM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=MNONvmo/; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=9zEiGyfp; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=MaNnL5uU; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=DHzA805q; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="MNONvmo/";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="9zEiGyfp";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="MaNnL5uU";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="DHzA805q"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CCBC621E88;
	Fri,  2 Oct 2026 10:42:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1790937756; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L8d0wskOPC8bqaDMsD74WV8L3K7R9l1OBqGDLyy6rFI=;
	b=MNONvmo//Yui5lLij2JFZGxeNAnB9rIMs9p+xKn/d9FcumjDxYR2dIDTsNJol/FdbkF10T
	NsUX09BxDDxTq4jn201X/D+Sp022nQ391nMcG7CrMaFC4/N78JEp/8yA8ROCIF4qlFMVJL
	5tMDfJPaBzV2/GQkFEbV4C2rf9xhG0A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1790937756;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L8d0wskOPC8bqaDMsD74WV8L3K7R9l1OBqGDLyy6rFI=;
	b=9zEiGyfpW94K7GMQ5eYv5E+JxVY8cT83DV1HGonG77sFtBnm46sA5SknvAKy6z4i5YgapF
	MAtM7MV/Nap+6uDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1790937751; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L8d0wskOPC8bqaDMsD74WV8L3K7R9l1OBqGDLyy6rFI=;
	b=MaNnL5uUY89T6FfQLEp67gFSDGbEgAwD90I3KQ4IpCWP+gqcufgYDJ6FjecDZt4s9Pf1EV
	x728kNuF5ys+eti2jTcZfs7U1P0Xu94Zpiwa0b5w2RaC7cmSd9CNGY9qAKK3DCvdNj2Za0
	/gLsM3KpvKBVmACjwPajDQcDIKsj1iQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1790937751;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L8d0wskOPC8bqaDMsD74WV8L3K7R9l1OBqGDLyy6rFI=;
	b=DHzA805qo4cW/RLPXGcI8/LD8xddn1CcYn8RXvcM9Uymh7RyMSig6NyXOcrbLOYrV8K3cr
	Hf/EmOjJK4s64pCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D60CF13C24;
	Fri,  2 Oct 2026 10:42:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id qo8WK5aKv2qySwAAD6G6ig
	(envelope-from <fmancera@suse.de>); Fri, 02 Oct 2026 10:42:30 +0000
Message-ID: <816f2ae9-e436-4b0b-ad1e-5f6067f69d70@suse.de>
Date: Fri, 2 Oct 2026 12:41:24 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2 1/1] ipv6: defrag: orphan skb before queuing
To: Ren Wei <weir@nebusec.ai>, netdev@vger.kernel.org, bpf@vger.kernel.org,
 edumazet@kernel.org
Cc: dsahern@kernel.org, idosch@nvidia.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, joe@wand.net.nz,
 ast@kernel.org, kafai@fb.com, vega@nebusec.ai, petalzu987@gmail.com
References: <cover.1790850176.git.petalzu987@gmail.com>
 <5c396b7011168cd98b9812df4d6bbd00a96048e7.1790850176.git.petalzu987@gmail.com>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <5c396b7011168cd98b9812df4d6bbd00a96048e7.1790850176.git.petalzu987@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,nvidia.com,davemloft.net,redhat.com,wand.net.nz,fb.com,nebusec.ai,gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,nebusec.ai:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -4.30
X-Spam-Level: 
X-Spam-Flag: NO

On 10/2/26 11:25 AM, Ren Wei wrote:
> From: Zixuan Chai <petalzu987@gmail.com>
> 
> IPv4 and nf_conntrack fragment queues orphan skbs before returning
> -EINPROGRESS, but ip6_frag_queue() leaves the socket association intact.
> 
> A socket installed by bpf_sk_assign() may use SOCK_RCU_FREE and be released
> while its fragment remains queued. The skb destructor can then dereference
> a stale socket pointer.
> 
> Orphan the skb before returning -EINPROGRESS so the queued fragment no
> longer retains the socket association.
> 
> Fixes: cf7fbe660f2d ("bpf: Add socket assign support")
> Cc: stable@vger.kernel.org
> Reported-by: Vega <vega@nebusec.ai>
> Assisted-by: LLM
> Signed-off-by: Zixuan Chai <petalzu987@gmail.com>
> Signed-off-by: Ren Wei <weir@nebusec.ai>
> ---
>   net/ipv6/reassembly.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/net/ipv6/reassembly.c b/net/ipv6/reassembly.c
> index 05c51f669754..a7964125c764 100644
> --- a/net/ipv6/reassembly.c
> +++ b/net/ipv6/reassembly.c
> @@ -232,6 +232,7 @@ static int ip6_frag_queue(struct net *net,
>   	}
>   
>   	skb_dst_drop(skb);
> +	skb_orphan(skb);
>   	return -EINPROGRESS;
>   
>   insert_error:

Reviewed-by: Fernando Fernandez Mancera <fmancera@suse.de>

Thanks,
Fernando.

