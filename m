Received: from mailtransmit05.runbox.com (mailtransmit05.runbox.com [185.226.149.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A0AA3B9DA7;
	Mon,  3 Aug 2026 09:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785748103; cv=none; b=AdP4/cA+NfvtDG5+goAElbXhVm+ks65I/bZybsn382sZlBS1Fzgu2vZruUBQ8xw+n4g9cNZc3z0fRSsNAE+sfwDPvyyLvxs6jh3OkkWGNApVUa/YAwpm4vQM+E2dnt1eU7ACUvkuRmdbs0coCpWKiIh5krw2UrMU1Wx06Lo8xHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785748103; c=relaxed/simple;
	bh=1jQsz17UW5IXD+YZ94eMQI7v3boiVWtOQIrTjRdTuYc=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=YtAvnaumTBzr9kslvmP0h6ioyj27toimz5Ir8JotDoSA55dt1VEbdRTjrzgDq5kYBh+jEPk+tOpnQYA7d5yIX5d/wh/4ejMhknpWZjX6L+TIZ0Ugeruu2amCiV1eMx4L9Zf8ilsfj5U6ks+4bljJnlSjy7S6/YoDciXS26EV0no=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co; spf=pass smtp.mailfrom=rbox.co; dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b=uDeZ6/PC; arc=none smtp.client-ip=185.226.149.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rbox.co header.i=@rbox.co header.b="uDeZ6/PC"
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit05.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1wqoeX-003gzW-KG; Mon, 03 Aug 2026 11:08:09 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector2; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:
	Cc:To:Subject:From:MIME-Version:Date:Message-ID;
	bh=ZYYHi9h+gS1ijRVonZP/RUIa+2ondSf6v0ir0GDMNtc=; b=uDeZ6/PC2pchAWB0D6RVfRfrrq
	DnK0Dh/8ayufWUQOGIgT9YsVJ/d9rMhIWG7Esj99XVTTQBgbh95t6p+eRLTribvdFTFcZIK0w1psv
	A0vzUM43ghUWwJGuY+qly5KuKmrJsL7wb0vGzyjjgpdgFY827DWgMLwrPwd7uhL5tuGEG0UvjaIKa
	k+c5Pory/iuPYGNChZvnFdOs+YMuLDVkM3yLLhxLFaUxQtOkMzTrd4sA+DipQC17sfGXXNV3/ax4j
	Cuu6f0I+AnIMVa1tEoDwq0BBpqSIoj6STAA0kJct01QbAdqzeuSOO2hemlACUheTToLZlOTpW7CeC
	s8Acj8KA==;
Received: from [10.9.9.73] (helo=submission02.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1wqoeX-0004SU-7o; Mon, 03 Aug 2026 11:08:09 +0200
Received: by submission02.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1wqoeN-00Fsjp-Uv;
	Mon, 03 Aug 2026 11:08:00 +0200
Message-ID: <e9e7e534-80d5-4597-b340-e7f34ca08d8f@rbox.co>
Date: Mon, 3 Aug 2026 11:07:53 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Michal Luczaj <mhal@rbox.co>
Subject: Re: [PATCH bpf 3/3] bpf: Unconditionally take socket references in
 lookup helpers
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Emil Tsalapatis <emil@etsalapatis.com>, Eric Dumazet <edumazet@google.com>,
 Kuniyuki Iwashima <kuniyu@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Willem de Bruijn <willemb@google.com>,
 John Fastabend <john.fastabend@gmail.com>,
 Jakub Sitnicki <jakub@cloudflare.com>, Jiayuan Chen
 <jiayuan.chen@linux.dev>, "David S. Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Stanislav Fomichev
 <sdf@fomichev.me>, Martin KaFai Lau <martin.lau@linux.dev>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Joe Stringer <joe@wand.net.nz>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>
References: <20260723-sockmap-lookup-tcp-leak-v1-0-1bbdc58ce514@rbox.co>
 <20260723-sockmap-lookup-tcp-leak-v1-3-1bbdc58ce514@rbox.co>
 <DKBCACHGQHYB.194JPC04N9WT0@etsalapatis.com>
 <591fd57e-d006-4e51-af5c-fea65a071819@rbox.co>
 <DKDR02T36EVT.ODA2A3LW6MC2@gmail.com>
Content-Language: pl-PL, en-GB
In-Reply-To: <DKDR02T36EVT.ODA2A3LW6MC2@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/1/26 18:29, Kumar Kartikeya Dwivedi wrote:
> On Thu Jul 30, 2026 at 1:55 PM CEST, Michal Luczaj wrote:
>> On 7/29/26 22:32, Emil Tsalapatis wrote:
>>> On Thu Jul 23, 2026 at 7:33 AM EDT, Michal Luczaj wrote:
>>>> Lookup helpers gate whether to acquire a socket reference on
>>>> sk_is_refcounted(), a check re-evaluated at release. An established socket
>>>> refcounted at acquire time can gain SOCK_RCU_FREE via
>>>> connect(AF_UNSPEC)+listen() before release runs; the release-side re-check
>>>> then reads sk_is_refcounted() == false and skips the put. The reference
>>>> leaks.
>>>>
>>>> Make acquire and release unconditional and symmetric: always take a
>>>> reference, always put it. Adapt sk_select_reuseport().
>>>
>>> Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
>>
>> Thanks!
>>
>>> The bot's concern about the comment style is obviously invalid here.
>>
>> Are the prompts incorrect?
>> https://github.com/masoncl/review-prompts/blob/59469708305eca305cbd9eb94e5aa0ee3627529c/kernel/subsystem/bpf.md#bpf-comment-style
>>
> 
> The prompt is correct, but we don't bother for existing comments, if you add a
> new one, you can use the new style.
> 
> Overall, looks like the set is pretty close. You can respin targeting bpf-next
> as John suggested (and we can wait for his ack before landing) so it can go
> through CI again.

Sure, here's v2 with patch 1 dropped (I'll repost it targeting bpf-next
later):
https://lore.kernel.org/bpf/20260803-sockmap-lookup-tcp-leak-2-0-306e025bfe66@rbox.co/

thanks,
Michal

