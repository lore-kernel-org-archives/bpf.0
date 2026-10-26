Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.94
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793027224;
	b=L2E47/RMEtURQwDTDLwrHBSE9SuLfaqWZpPtnZWcv0pj0jtgftYUeFgte2/0xG82wTRJ
	 HBcLDnlAp0WFNbCF472CP3tnTVTEX2EcXKvu3hjQGskZIOh7n9a/AgBtDwMH+H4j44kit
	 2OcLgdlwqlRfb18KxLu0O1a3gPYvjkSJaDBwxfq2fTApjvBmO0aGHxJEt1PoPnzuNsEDr
	 jIADpIYi7XfPSY6yZMoXuCQaaxH6gHNtnXRvA6CTzTawwERjhHkWqkLyAXW4YF1HMrkUE
	 5DBWq6CQULc5SeFmCAPCW32ZisCR9wVyx4RGNeKAWgQdKTugTLuWZRkYCO3icnW6VQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793027224;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=J0h2FhD1/ZqD4NmuBs6+MD7h5IX24/kXFYvf/GTy2DY=;
	b=iNgc1rwPE2QlQV93f7qDW+EzEQuhLT0O0OUH5ntKMeX4ebbmniucilX2ZztzDjKMZYCV
	 oJl8R32C9oQt3E1zYorgGdjatYjo+prz3wGGtsD3QFOrVWLN7za8GDxEStxhFWVryVojV
	 /nJ/LHaqwht7E/yook+ublZPwjrN5yH6TVqfplWcef+w/IhmS5kn8k0OJHiehnpkvbc9J
	 ohgxihcigRv+eox0XRoxp5AnzeUxlJcIPMKHcduK+Nj4OetkRVLBTK8AOwSrCVDhjDd9f
	 lgZy6CRIdTToI6zX42JiMdcJ9Y3UjnskSq+XhrQfjjVSIK4ywPbT8UaSiZWqbUfLzwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=o1QiMdro;
	arc=none smtp.remote-ip=91.218.175.94
Received: from mta0.migadu.com (out-94.mta0.migadu.com [91.218.175.94])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC653606A31A
	for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 15:07:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AC653606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=o1QiMdro
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=kiILAlyer4KDpB0b5u3nzcUamLQxdEs4r06HO3T5veo=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793027220; v=1; x=1793632020;
 b=o1QiMdroJ2Lo6pnEdfheer83seqjM1F3U78Hxrf7FV7j1Zcn6EKKSVGK25bI775ogEtCtwTJ
 3yLxHD9UZ5KQrrI7S1xdsQR5fjqhyON+UdKS07BuqZpXpaEYDYCpm2KuoqZz3+wEW26+WpJ+tUD
 Cnm2+WWLxkkfPshCrQGll+Hg=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 873537cec047169a;
	Mon, 26 Oct 2026 15:07:00 +0000
X-Mizu-Trace-ID: 873537cec047169a
X-Migadu-Flow: FLOW_OUT
Message-ID: <f971dbdc-cc00-42fc-8989-5e6460f88c22@linux.dev>
Date: Mon, 26 Oct 2026 23:06:51 +0800
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
Subject: Re: [PATCH bpf-next v4 2/6] bpf: Add syscall common attrs support for
 xdp link_create
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Emil Tsalapatis <emil@etsalapatis.com>,
 Ihor Solodrai <ihor.solodrai@linux.dev>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Shuah Khan <shuah@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>,
 Hangbin Liu <liuhangbin@gmail.com>, Martin Karsten <mkarsten@uwaterloo.ca>,
 Masashi Honma <masashi.honma@gmail.com>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20261024153608.58569-1-leon.hwang@linux.dev>
 <20261024153608.58569-3-leon.hwang@linux.dev>
 <DMDIVEW7P9QN.1TB58XDPD7V3A@gmail.com>
Content-Language: en-US
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <DMDIVEW7P9QN.1TB58XDPD7V3A@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026/10/25 09:19, Alexei Starovoitov wrote:
> On Sat, Oct 24, 2026 at 08:36 AM Leon Hwang <leon.hwang@linux.dev> wrote:
>> Instead of passing bpf log or extack to bpf_xdp_link_attach(), pass an
>> errmsg pointer to receive the kstrdup() error msg, because
> 
> [...]
> 
>> 2) passing extack will access underlying driver string out of dev_put()
>>    guard, which will crash kernel when the device is unloaded
>>    concurrently.
> 
> Netlink does exactly that.
> rtnl_setlink() looks up the dev with __dev_get_by_index(), so no refcnt,
> do_setlink() -> dev_change_xdp_fd(dev, extack, ...) calls into the same
> drivers that set the same strings, rtnl is unlocked, and only then
> netlink_rcv_skb() -> netlink_ack() does strlen(extack->_msg).
> All extack users work this way. kstrdup() in one of them fixes nothing.

Oops, I was overthinking about it when self-reviewing the patch. Failed
to verify the describing crash issue just now. I should verify my review
when self-reviewing.

> 
> Instead of patches 1 and 2:
> 

Will change like this.

> 
> I'm think I gave this suggestion earlier. Why did you go with strdup()?
> 

Sorry for my overthinking. Will verify my review to my patches in the
future.

Thanks,
Leon

