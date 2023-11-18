Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ptWfop5o"
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [IPv6:2001:41d0:203:375::bb])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C31410C6
	for <bpf@vger.kernel.org>; Fri, 17 Nov 2023 16:00:22 -0800 (PST)
Message-ID: <5b187e42-5cfb-4004-9c96-3caac42749b2@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1700265620;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mCXhv6F+HuhQNpbEGxnDGnDNABQJmtcjmKp9u2zZ4kQ=;
	b=ptWfop5oRqhFha5LLSrTHtT9G5fkGQkLqROD7pLs6rXkk44GtGEelAbD4/VlVJCeh75UBa
	W4vb9KFbXJL8fokDl88Pgb4l6RaNGHIxasbLuCUf65wFZHYQmoqjNUClkdizymCMx6MYdd
	8/e5iP0M+8jgo31yX64e7N8XuXTvPM4=
Date: Fri, 17 Nov 2023 16:00:13 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf v3 0/8] bpf_redirect_peer fixes
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: kuba@kernel.org, razor@blackwall.org, sdf@google.com, horms@kernel.org,
 netdev@vger.kernel.org, bpf@vger.kernel.org, martin.lau@kernel.org
References: <20231114004220.6495-1-daniel@iogearbox.net>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20231114004220.6495-1-daniel@iogearbox.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 11/13/23 4:42 PM, Daniel Borkmann wrote:
> This fixes bpf_redirect_peer stats accounting for veth and netkit,
> and adds tstats in the first place for the latter. Utilise indirect
> call wrapper for bpf_redirect_peer, and improve test coverage of the
> latter also for netkit devices. Details in the patches, thanks!
> 
> The series was targeted at bpf originally, and is done here as well,
> so it can trigger BPF CI. Jakub, if you think directly going via net
> is better since the majority of the diff touches net anyway, that is
> fine, too.
> 
> Thanks!
> 
> v2 -> v3:
>    - Add kdoc for pcpu_stat_type (Simon)
>    - Reject invalid type value in netdev_do_alloc_pcpu_stats (Simon)
>    - Add Reviewed-by tags from list
> v1 -> v2:
>    - Move stats allocation/freeing into net core (Jakub)
>    - As prepwork for the above, move vrf's dstats over into the core
>    - Add a check into stats alloc to enforce tstats upon
>      implementing ndo_get_peer_dev
>    - Add Acked-by tags from list

Acked-by: Martin KaFai Lau <martin.lau@kernel.org>

Considering folks may still be traveling after LPC, will give it an extra 
weekend before landing.

