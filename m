Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794938815;
	b=cAE+CM59kUwIIN0Y1AxfV3byn42IyTcbDBJ3GnLB0jWlkbfWME1X/6rGEJeqAN5Eq6vt
	 e6D+la3qdyTPaMS6mUqxarWyUsogAmbQJXgnZVYpW8VGoHUnbqWVkOtPMLfa9RRQYsLKs
	 sklskCHGNPNbWdepJPFxqDxSATK4wUDDglCe7d7ffwkvVXGz5wqUkNeBOmdhmRYdT9T60
	 0izgB/PgjwJqLHMTQzXaXCiPQB/VhU1Tbmw0Hmev9eiwGCUxPe5CgMwNL7VHgixcKUSem
	 /PDSQ6/t0G3s4hbPtu7ImJe8Uz46Ecs4T/Qwaa3tg6XoqhEClVmNSkdRPNND1EHz1wg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794938815;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:Content-Language:To:Cc:References:From:Autocrypt:Organization:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=sz1kcu9JF+E2F5NR973wlzOM3zOEOCqkLdOhm2F9Nww=;
	b=BlxH3QoAGQirMewWYNzeEwL87QBacmGpxdd93O5nRgE8tAL/mZYr9qbOhrG0Zx0oAgEf
	 7aDoLQa3aPuD2NOWu4OVX5icfvJQNbZ+tneDCJshiuPYNAOKkyW+UgTisS9INFXb6a5wO
	 Zrplfp8ItdV7upzoedTAjllQV5V1toMxhl6oC1xCV+rRELyST4wtJz/g0SJeo+6onkF0h
	 eOoG8Uq5EC9ai80uILpYt4eRD8I59LwFM509OTN7iX3B9+WgzIWYTh9Xwa2O07p7uIPLK
	 3oLA721c0uuPHt3hmuNR5JuNLBU5fb7U4mRTH5bl7uPNBE0WwJog4mCCBGz7T7clyaQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dgYx9psk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 727F8606A31C;
	Tue, 17 Nov 2026 18:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dgYx9psk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7B381F000C4;
	Tue, 17 Nov 2026 18:06:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794938815;
	bh=sz1kcu9JF+E2F5NR973wlzOM3zOEOCqkLdOhm2F9Nww=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=dgYx9pskm5Un7RwijMIXMGAiYk9oIy9dfmOa48yFh8RVWNoIFESN69RFVk6NKU0JK
	 XljxL7QYdM8eEs40yc24tPqSSvHCVTx8hrDu1dxd8muyvb4MAZDjjb2E7dU5ZVfI63
	 F274YVa0g7v3CzJPoW3FOUayoqa8IupPaLMUTh48vd2tE8Yy83qo58aob1tnY6+AiG
	 IjL4IBtFm/yYD42w1heCbba6RHsLXwhDRdfuHvYof75gF3dXhWLKew7YvJ9H4PvWWV
	 3VmrkMKVYp/5ggMNs1pHBcyjpvP4gFjVWdb1B0EAjetwhKAFBgwMf4KzIn4ZN37WG0
	 swPMGK4CC9zEg==
Message-ID: <a703661f-1877-4d7d-b632-418c97090327@kernel.org>
Date: Tue, 17 Nov 2026 19:06:48 +0100
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH net v3 2/2] tcp: accecn: initialize AccECN fields in
 syncookie path
Content-Language: fr
To: Thaison Phan <thaisonphan@google.com>
Cc: Eric Dumazet <edumazet@kernel.org>, Neal Cardwell <ncardwell@google.com>,
 Kuniyuki Iwashima <kuniyu@google.com>, "David S . Miller"
 <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?=
 <ij@kernel.org>, Olivier Tilmans <olivier.tilmans@nokia.com>,
 Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>,
 Stan Iliev <stani@google.com>, netdev@vger.kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261117124710.1338951-1-thaisonphan@google.com>
 <20261117124710.1338951-3-thaisonphan@google.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <20261117124710.1338951-3-thaisonphan@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Thaison,

On 17/11/2026 13:47, Thaison Phan wrote:
> cookie_tcp_reqsk_alloc() and bpf_sk_assign_tcp_reqsk() allocate struct
> request_sock without __GFP_ZERO, leaving saw_accecn_opt,
> accecn_fail_mode, syn_ect_rcv, and syn_ect_snt uninitialized. When
> accecn_ok is negotiated in cookie_{v4,v6}_check(),
> tcp_ecn_openreq_child() reads all four fields to initialize the child
> socket's AccECN state.
> 
> In addition, because the temporary request_sock used to send a cookie
> SYN-ACK is immediately freed, treq->syn_ect_snt is lost. For AccECN
> connections where the listener marks ECT on the SYN-ACK, leaving
> syn_ect_snt as 0 causes tcp_accecn_third_ack() to see a mismatch between
> the expected Not-ECT and the peer's reflected ECT in the ACE field,
> erroneously flagging TCP_ACCECN_ACE_FAIL_RECV in accecn_fail_mode. Refer
> to Table 4 of RFC 9768 for more details.
> 
> Initialize saw_accecn_opt, accecn_fail_mode, and syn_ect_rcv in
> cookie_tcp_reqsk_init() to match tcp_openreq_init(), and set syn_ect_snt
> from the listener's TOS/tclass in cookie_{v4,v6}_check() to match
> tcp_{v4,v6}_send_synack().

I missed the v3:

Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

