Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.226.149.37
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792423245;
	b=TeEWk6bmNvyBOI2KXVLzxNjdMl52JKzuNKcJEzNq3yAj3IfCfqu8UulRvZBNYJDZg9aj
	 WBa3iEUc64y0wXv9x76Fs0hGeE4mPG7ZnXVdnNVPjZEZktSFK1fe3FYgnaVVVwUsG1Yuy
	 8iQm3D59fjFXBT87Fc6ohEw8of0DQqa87SKucJJahk5jQKmmGWzR/MFG26hHb/V9v+npb
	 I9Km9XVPYU5n/HY/0zwPX/mx24j4GUUcnsYljCa1c9q4WRn5ECBqRcAbODPk7C/4wI3ti
	 qVE1nwV0HarAVePP9wr5D4gu3ZabX/hMnTrBQGFFtPzkig6ffcZ7gAsOCcXff5rM0YQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792423245;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:From:Subject:To:Cc:References:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=ZtF3pLjwdO/EjU6H/l0B9QYdOBekN6Mz1r0HXeqWce0=;
	b=iq+wlgNW4zFW3G4DZ2x7FWlC3ACDHRdpUVrbwZqVuIzVdIU+Ux8z6FdEfdISXwHlI2jR
	 ne3PxSQiwvtbnHNkc9QrDNfpOvgMZA7xqOA445e1zMHTbWADmaTQq09+GsujKhPINb3tK
	 Wh/9HrFLBjYqAYUg/y+zac5+bkfbHt+JIUEoGyeigLP6gQccwIg18dK6qdM2EyEQdn7g6
	 cxUF5bxJ8PkXdGU33QpZLOsAvkBQXfnKm2tijB4v2PvHJIypAfAAw5/DfX3RNwrfsjpcQ
	 yJ0+ukLVwXukC9eosoKbYrKraTLdcNyDtifWAQYx85XJZiGxabzVSbhjnjNsfmHdC1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rbox.co;
	spf=pass smtp.mailfrom=rbox.co;
	dkim=pass header.d=rbox.co header.i=@rbox.co header.a=rsa-sha256 header.s=selector1 header.b=DY6YxkkD;
	arc=none smtp.remote-ip=185.226.149.37
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB1160A7E4E;
	Mon, 19 Oct 2026 15:20:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3DB1160A7E4E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=rbox.co header.i=@rbox.co header.a=rsa-sha256 header.s=selector1 header.b=DY6YxkkD
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1xIpA5-0033bO-0y; Mon, 19 Oct 2026 17:20:29 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:
	Cc:To:Subject:From:MIME-Version:Date:Message-ID;
	bh=ZtF3pLjwdO/EjU6H/l0B9QYdOBekN6Mz1r0HXeqWce0=; b=DY6YxkkDUmTX8UqWgioRvLjJS5
	DANrdy1OniLaalx1SR0mZq7QLxopCq7qV5bnROKJBfaN32xs8gP0nROCCbutICsSP189kbbd2cVeI
	pqebf+IM+G+6z+qii/pnOCfqHV2rUTwdIZOA6yKQJvEufAPztRnRExCEK+Py7MN+mgDMC74eJUzo0
	/qQYskF0+QsDO/n/DsfZts2fVqZAntNQTbnB1T7XndkanQ73SSEhbFOVFR8sfI3fGb1QFa35OxFgD
	SBTYmu8cxjatHZp2fpuJzELYETqR7xhi2FZR6eDuJKKXd+kNZxT9yIFJfM+Ixiua5CQKF2v0Qb08w
	yYx0PV5w==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1xIp9y-0008Ot-A1; Mon, 19 Oct 2026 17:20:22 +0200
Received: by submission01.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1xIp9p-006D8P-CR;
	Mon, 19 Oct 2026 17:20:13 +0200
Message-ID: <a9ba4549-4bae-4516-85ef-ee38f13551cd@rbox.co>
Date: Mon, 19 Oct 2026 17:20:12 +0200
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Michal Luczaj <mhal@rbox.co>
Subject: Re: [PATCH bpf-next 2/3] bpf, sockmap: Restrict iter-context sockmap
 updates to iter/sockmap
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Emil Tsalapatis <emil@etsalapatis.com>,
 Ihor Solodrai <ihor.solodrai@linux.dev>, Shuah Khan <shuah@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, Lorenz Bauer <lmb@cloudflare.com>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>,
 Jakub Sitnicki <jakub@cloudflare.com>
References: <20261016-sockmap-update-limit-iter-v1-0-23fa946db59e@rbox.co>
 <20261016-sockmap-update-limit-iter-v1-2-23fa946db59e@rbox.co>
 <DM6O08VBRY20.1PFUYACCZ38JL@gmail.com>
Content-Language: pl-PL, en-GB
In-Reply-To: <DM6O08VBRY20.1PFUYACCZ38JL@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/17/26 01:52, Alexei Starovoitov wrote:
> On Fri, Oct 16, 2026 at 11:09 PM Michal Luczaj <mhal@rbox.co> wrote:
>> [2]: commit 64c2f93fc325 ("bpf, sockmap: Take state lock for af_unix iter")
> 
> unix_state_lock() in bpf_iter_unix_seq_show() was added only for
> unix_stream_bpf_update_proto() called from the iter prog.
> iter/unix cannot get there anymore.
> can we drop it ? can be a follow up...

So we don't care about having a stable socket state while iterating? Which
is the case for iter/sockmap, but is unlike iter/{tcp,udp}.

>> +		if (eatype == BPF_TRACE_ITER &&
>> +		    env->prog->type == BPF_PROG_TYPE_TRACING &&
>> +		    !strcmp(afname + strlen(BPF_ITER_FUNC_PREFIX), "sockmap"))
>>  			return true;
> 
> iter/sockmap prog is not limited to ctx->sk it seems.
> bpf_skc_to_unix_sock(ctx->sk)->peer is a plain PTR_TO_BTF_ID and
> the value arg of bpf_map_update_elem() accepts it.
> The peer doesn't have to be in any map, so it has no psock,
> and sock_map_seq_show() holds nothing but rcu.
> sock_map_update_elem() takes bh_lock_sock(), then sock_map_link() does
> sk_psock_init() and unix_stream_bpf_update_proto() on a socket
> that unix_release_sock() can be tearing down.
> That's the same unlocked socket as in iter/task_file.

I'm not sure I see the (stream sock) issue above. psock->sk_pair holds the
peer, so peer pointer remains valid during proto update. iter/sockmap is
safe, because sk is held by RCU. And for iter/unix we currently take
unix_state_lock().

But iter/sockmap dgram peer is a problem, right? No sk_pair, no lock, and
connect(AF_UNSPEC) can get the peer dropped.

> Should we restrict it to ctx->sk somehow?

I recall a discussion about having BPF helpers accept only trusted
pointers:
https://lore.kernel.org/bpf/CAADnVQK_93g_KkNFYXSr8ZvA1fYh4hoFRJCJFPS-zs4ox0HhAA@mail.gmail.com/
Restricting only iter/unix seems better?
