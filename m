Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 958C13DCD90
	for <bpf@vger.kernel.org>; Tue, 24 Mar 2026 09:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774346135; cv=none; b=AP7B4f8HBcB7L1vNBeKsK2bGqfEg92c0pqsUZqSfAETzGGGCyqpN8/dluc1C2Wd5ph8/DgmOLsQFAw0k0md6oHD6mX1Y/JXrhxpwXup1eeicubdNu2DUa0GRKj1okMvItN3NCjIfQfJZ0/povHzyBZf7U6HcRDiyRVIXqRTCJAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774346135; c=relaxed/simple;
	bh=kQXSrqH+bBHyZU8Ikga3QmufCvLi6niQGDxpCGfL+3o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jJoL1QqhyWd3IdNmR1XHF1WKqGvzLETuyZ2YOi4CIyDglHB2nrFLTQJnoXV9SIm1Hd6oX3sn59imyQhjMx1Y8yMEDxikMiWxpuJjqxGdu9izeWDw17CHLYXuyyqj5c4jTiqE3MW0jhMZWLDI21zRDWL02y3PbeGF5FRammGsI+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=SxwmUWHi; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=syeEvkFr; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=SxwmUWHi; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=syeEvkFr; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="SxwmUWHi";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="syeEvkFr";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="SxwmUWHi";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="syeEvkFr"
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id B965D5BCC1;
	Tue, 24 Mar 2026 09:55:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1774346130; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VI3RmIUNecDumCgUvYIUS8Oe2HB5G8HAfqwqqKdnkiQ=;
	b=SxwmUWHiFIemAPlF+oRiBFnJe+AXQp9/6icj/bRaV4SLehFhB2ipHkQBmiC/zTVJZjOjU0
	EDntxw0h0Von9GJAbfM8YUEvzclQta9Id02u7E6yldgubXN73dQrDdJOJEq1a+kWEot9wy
	2ZJIpyp0O3LgN9ZtsSRfKmQA/ZlxyCc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1774346130;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VI3RmIUNecDumCgUvYIUS8Oe2HB5G8HAfqwqqKdnkiQ=;
	b=syeEvkFr6rwPEOFGGZd35V/arJSKlQGdF/T+VsIw0c42v1hD1v235e2ZVyg0IN98DgdIYO
	ckH0nAgRfpL20ZBg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=SxwmUWHi;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=syeEvkFr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1774346130; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VI3RmIUNecDumCgUvYIUS8Oe2HB5G8HAfqwqqKdnkiQ=;
	b=SxwmUWHiFIemAPlF+oRiBFnJe+AXQp9/6icj/bRaV4SLehFhB2ipHkQBmiC/zTVJZjOjU0
	EDntxw0h0Von9GJAbfM8YUEvzclQta9Id02u7E6yldgubXN73dQrDdJOJEq1a+kWEot9wy
	2ZJIpyp0O3LgN9ZtsSRfKmQA/ZlxyCc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1774346130;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VI3RmIUNecDumCgUvYIUS8Oe2HB5G8HAfqwqqKdnkiQ=;
	b=syeEvkFr6rwPEOFGGZd35V/arJSKlQGdF/T+VsIw0c42v1hD1v235e2ZVyg0IN98DgdIYO
	ckH0nAgRfpL20ZBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5516443D95;
	Tue, 24 Mar 2026 09:55:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id hNXhEZJfwmm3QQAAD6G6ig
	(envelope-from <fmancera@suse.de>); Tue, 24 Mar 2026 09:55:30 +0000
Message-ID: <08247bfa-b67b-4c66-aa09-71ebdbca0df0@suse.de>
Date: Tue, 24 Mar 2026 10:55:21 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next] bpf: test_run: Remove ipv6_bpf_stub usage
To: Martin KaFai Lau <martin.lau@linux.dev>, bpf@vger.kernel.org
Cc: 'Alexei Starovoitov ' <ast@kernel.org>,
 'Andrii Nakryiko ' <andrii@kernel.org>,
 'Daniel Borkmann ' <daniel@iogearbox.net>, netdev@vger.kernel.org,
 Jakub Kicinski <kuba@kernel.org>
References: <20260323225250.1623542-1-martin.lau@linux.dev>
Content-Language: en-US
From: Fernando Fernandez Mancera <fmancera@suse.de>
In-Reply-To: <20260323225250.1623542-1-martin.lau@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	URIBL_BLOCKED(0.00)[suse.de:dkim,suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Queue-Id: B965D5BCC1
X-Spam-Flag: NO
X-Spam-Score: -4.51
X-Spam-Level: 

On 3/23/26 11:52 PM, Martin KaFai Lau wrote:
> From: Martin KaFai Lau <martin.lau@kernel.org>
> 
> bpf_prog_test_run_skb() uses net->ipv6.ip6_null_entry for
> BPF_PROG_TYPE_LWT_XMIT test runs.
> 
> It currently checks ipv6_bpf_stub before using ip6_null_entry.
> ipv6_bpf_stub will be removed by the CONFIG_IPV6=m support removal
> series posted at [1], so switch this check to ipv6_mod_enabled()
> instead.
> 
> This change depends on that series [1]. Without it, CONFIG_IPV6=m is
> still possible, and net->ipv6.ip6_null_entry remains NULL until
> the IPv6 module is loaded.
> 
> [1] https://lore.kernel.org/netdev/20260320185649.5411-1-fmancera@suse.de/
> 
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Fernando Fernandez Mancera <fmancera@suse.de>
> Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
> ---

LGTM!

Reviewed-by: Fernando Fernandez Mancera <fmancera@suse.de>
