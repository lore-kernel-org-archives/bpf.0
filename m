Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.107
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794190541;
	b=r7xWh7ch4cvDRPVlLqFHGK9Am8bqH4SqfzWRu9CeK19+PTHJlbjgHZuuGAf01LS7k/vH
	 8LtAknuOl3UKgRe2Z8PtI40IQw+yqHoa3rMttyDDtCfaumdUN+lZGMnsqnqwbC8XOnN1z
	 aEYrv5EEyWU3YRCULTPVwUyy9EFB//kFuDvGqGig0O6XFGwI8qzvplpHbvH8hpISQEPSl
	 0QuOtkbI9qCZsSgUQCU+VyfrZX8Pw0rsa6GktF3xsqroP9IRIJ7JZG8PDzBrCkx9TEeUW
	 sj294/fFq3dXr66H1CjB0ay/XXCoLBFT6b/+Xbw5CE8C+IZOafrfv+bMg+Z/6LAxiXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794190541;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=42Bgp9QK8SxMu4RaMFo7ITDdz1xu9H4f5I3RqLrzFX8=;
	b=ocKFEvQcGTROH80dXnV0n6XQEFTrwwtXU/QC4Q55/EB5D2Shrg3ANhK6VV4EPtyU3jr/
	 xcQ9XLftNfqj3B3mRHY+S5Lp+vKzOHnMX489jdDslNQCE8kisk3wE6RsR0dagaK3eu7A1
	 7H2ZilKnI/HexskQkB4HKYCqR7ZMmtp1sUgofTwbFIVMSvbQeUYsbAN+hj7zquNbdBFYR
	 OaMMqxyLQvwiXYhI6QGlwoFCyMMZq/V3hRw4yGx6xlqXC22POFUrzcpZvRcOkP0Fdbk+S
	 4QmCgiRDwpWDLADwbz8ySRdw9s35rXCWG7/1rG1Ij6iH5rRQQcFnk8lR1/BvJFYmr1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=CkqQONWS;
	arc=none smtp.remote-ip=95.215.58.107
Received: from mta1.migadu.com (out-107.mta1.migadu.com [95.215.58.107])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9EE6606A321
	for <bpf@vger.kernel.org>; Mon,  9 Nov 2026 02:15:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A9EE6606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=CkqQONWS
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=42Bgp9QK8SxMu4RaMFo7ITDdz1xu9H4f5I3RqLrzFX8=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794190538; v=1; x=1794795338;
 b=CkqQONWSG9KB95QZktl/P5f9lasdYz+ixAT14Lq8aTrrFSgJ17oYYEQUzmXfkUVsDouGzGV/
 eFJImttXCM8vc5OiFQrrf+e+SETMZvZLsTb8q2lAdmK2kg1jkvotRh+G26Vvm+JW++zcLNsLoNV
 Rgi/Q4atLWoumpAfVrv9EcPs=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 8f4563db198ec34e;
	Mon, 09 Nov 2026 02:15:37 +0000
X-Mizu-Trace-ID: 8f4563db198ec34e
X-Migadu-Flow: FLOW_OUT
Message-ID: <47eae9bc-6d8b-4b73-8fe7-869753ef9600@linux.dev>
Date: Mon, 9 Nov 2026 10:15:21 +0800
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
Subject: Re: [PATCH bpf-next v3 2/8] bpf, sockmap: Restrict iter-context
 sockmap updates to iter/sockmap
To: Michal Luczaj <mhal@rbox.co>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>,
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
 <20261107-sockmap-update-limit-iter-v3-2-7c0bad1ad036@rbox.co>
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20261107-sockmap-update-limit-iter-v3-2-7c0bad1ad036@rbox.co>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 11/8/26 1:58 AM, Michal Luczaj wrote:
> Among tracing progs, allow only iter/sockmap to update sockmaps and
> sockhashes. Previously, any BPF_TRACE_ITER program could perform these
> updates, which caused locking issues in specific scenarios [1][2][3]. This
> tightening is part of the broader effort to lock down the BPF API [4].
>
> [1]: commit 4d328dd69538 ("bpf, sockmap: Fix af_unix iter deadlock")
> [2]: commit 64c2f93fc325 ("bpf, sockmap: Take state lock for af_unix iter")
> [3]: https://msgid.link/87echn2fhd.fsf@cloudflare.com
> [4]: https://msgid.link/akRZ_e7DJh2aP-2i@john-p8
>
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://msgid.link/20260626205814.BAC3C1F000E9@smtp.kernel.org
> Suggested-by: Jakub Sitnicki <jakub@cloudflare.com>
> Signed-off-by: Michal Luczaj <mhal@rbox.co>


Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>

