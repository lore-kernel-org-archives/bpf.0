Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.226.149.37
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794784256;
	b=QiyQhwEdWC/OGnPoIWxHFhNaIPdDkpit/Vsdd3ncED5O5BbPs9UaUOHb5Db01VQsiUwE
	 UY7H4gAAfA4tHURXH0Z+wObQBb6f2d1/nhryfdD+SalFAqcea1gDEw5WD3p/W+w3WJbiB
	 enkjoEjvaubui6/lDHYUGN8SokvpcxHS4XSMThxo8mwSbWV3q0rXfq5OPTR37ZA+f4SHI
	 12hFPw1PhqTeIBiK9/7d0xu4ioDfeIN4BvBWMWgetHq8/2Vf7pBhoF2ur2UEShyd0OZbK
	 FkwH7XEWi6+gBd9cNZcKnb8JMQV9gryQoJiditwY59z+9U+9rZMjFbA25C4OZ4Io8Yw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794784256;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:From:Subject:To:Cc:References:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=Y2c4GuntC+J+u1XdIe8/YlwOw+mNu6OQYE3WM0aA4Sw=;
	b=3N8+VsKKD0dI/5I45yI00ajEQ/UAtmPVxM7FAnVyPNHf7wAzM7GGmTAG4adMy73NFZAE
	 tVzOOW2hrvlRcIMtXpE7ilwjO8fyqW4DZ7q7BOCsIaEkrVnjXyDvvJt57ttUSoc8hKpQW
	 Q1wXzf+56bY86fsqyfk+YrnLQ57K7BSfI8z4NYxx1o+GpVnKWXe2W/zGxFixiregtamP5
	 ZvWhEPf4zmKyT1O3cQjX1cTJrah+PA1Hp4Lc2HngKAQit5UhdkUwh+orK0RfwarfufKzZ
	 eqhCxX5ABh1txzFhyEAxCJ9i93EPD7T16VBOxe6yOpnY9etaLehJbJqAqejqhd5aBAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rbox.co;
	spf=pass smtp.mailfrom=rbox.co;
	dkim=pass header.d=rbox.co header.i=@rbox.co header.a=rsa-sha256 header.s=selector1 header.b=Y5kqtfjb;
	arc=none smtp.remote-ip=185.226.149.37
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF37B606A31F;
	Sun, 15 Nov 2026 23:10:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DF37B606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=rbox.co header.i=@rbox.co header.a=rsa-sha256 header.s=selector1 header.b=Y5kqtfjb
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1xSjMb-00EbLr-OF; Mon, 16 Nov 2026 00:10:21 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:
	Cc:To:Subject:From:MIME-Version:Date:Message-ID;
	bh=Y2c4GuntC+J+u1XdIe8/YlwOw+mNu6OQYE3WM0aA4Sw=; b=Y5kqtfjbJEBZsunJyvYzYSuOKJ
	x4GqsvQFHvgz6aMwDH35pjfmNTCxYUppfB+rnK63mUjpLQWszSGSzqnWenkREZ98QWq0quF1sByHE
	ZlzY9j6508J9K+z3CGvJvjvCdIzjVKa3UoLSnstBqpQQ8BI7ggksAIB/AsGYhWiB2s1S+46SThI5s
	HeuMc00fyAyAt83o3Qd3TJnKjU6o7Or5v+fBiLyGEeZ1j5sb3tSOVFUqwp8o0WuoWjqiqFzqOrbKh
	AeQo30VTE0YXV9+3O8kohQd3lf1omZmHB94dTmmsdwlvARbC2IEyq0fDDMRMctSMFZh+enWO9CUxW
	zu2hz7oQ==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1xSjMN-0001t3-8N; Mon, 16 Nov 2026 00:10:07 +0100
Received: by submission03.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1xSjML-000piU-I1;
	Mon, 16 Nov 2026 00:10:05 +0100
Message-ID: <e8f1736e-3f13-4f92-ad69-8b166c41e68a@rbox.co>
Date: Mon, 16 Nov 2026 00:10:03 +0100
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
Subject: Re: [PATCH bpf-next v3 0/8] bpf, sockmap: Restrict iter-context
 sockmap updates to sockmap iterators
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Emil Tsalapatis <emil@etsalapatis.com>,
 Ihor Solodrai <ihor.solodrai@linux.dev>, Shuah Khan <shuah@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, Eric Dumazet
 <edumazet@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>,
 Jakub Sitnicki <jakub@cloudflare.com>, Jiayuan Chen
 <jiayuan.chen@linux.dev>, "David S. Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>, Stanislav Fomichev <sdf@fomichev.me>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-doc@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>
References: <20261107-sockmap-update-limit-iter-v3-0-7c0bad1ad036@rbox.co>
 <DMV5NLOEYFGF.C7ITHCRCNA7P@gmail.com>
Content-Language: pl-PL, en-GB
In-Reply-To: <DMV5NLOEYFGF.C7ITHCRCNA7P@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/14/26 19:45, Alexei Starovoitov wrote:
> On Sat Nov 7, 2026 at 5:58 PM UTC, Michal Luczaj wrote:
>> Follow-up to Sashiko's report [1] and the decision to restrict which
>> iterator may perform sockmap updates [2]. Series started short: remove
>> about-to-be-stale test, restrict updates, add a negative test. Then it
>> expanded: mark bpf_iter__sockmap::sk as PTR_TRUSTED, restrict
>> bpf_sock_destroy() callers to iter/{tcp,udp}, few little tweaks.
>>
>> [1]: https://msgid.link/20260626205814.BAC3C1F000E9@smtp.kernel.org
>> [2]: https://msgid.link/87echn2fhd.fsf@cloudflare.com
>>
>> Signed-off-by: Michal Luczaj <mhal@rbox.co>
>> ---
>> Changes in v3:
>> - Drop RFC prefix
>> - Update bpf_iter_reg::feature docs
>> - Fix tcp_request_sock BTF build error
>> - Restrict allowed callers of bpf_sock_destroy() to iter/{tcp,udp} (Alexei)
>> - Link to v2: https://patch.msgid.link/20261102-sockmap-update-limit-iter-v2-0-e96a63c43b39@rbox.co
> 
> Sorry for the delay. Applied.

No problem, thanks.

To follow up on bpf_iter__unix::unix_sk, looks like there's a single helper
that will become unusable from iter/unix (once plain-PTR_TO_BTF_ID is
gone): bpf_get_socket_cookie(). PTR_TRUSTED then?

Michal

