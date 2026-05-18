Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1023245107A;
	Mon, 18 May 2026 13:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779109291; cv=none; b=W+0d6HhsFaOSAdA00ySI1BUsWKNlZp9eNuTyH+o9ycqtseiqDfXpWHOXw1czkWY4DgYfyCqZKjvBxtqVi7ODhIkpAQ7OpAVKLESGKtVUgWPNb1G1TLmRpkDFROmZD3L7LQHXe8lAvzLv+iFeu0p13GmSpWRX5ufMrfPj6F18BNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779109291; c=relaxed/simple;
	bh=hojHRr+PheKoQ7m5OKEUeo0v+iLPsIfkBZlaT1Myalg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rQwFOZUhGGXkaDVwEdlNd97JopeBadvFFeNBtK7UosozmUWAfrQmxA2SaX290/06JIOiM2N04oLbgUpHOl9IB+VRF55F7kHwAh3jmMqO/NH4Gw2TtqIx0KAp06vxVVnMg9pN8YjccY5Ss0WcXVhKuy0HkNsAUR1COfS3ggRMAAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iCkNx4CO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iCkNx4CO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36914C2BCB7;
	Mon, 18 May 2026 13:01:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779109290;
	bh=hojHRr+PheKoQ7m5OKEUeo0v+iLPsIfkBZlaT1Myalg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=iCkNx4COB7SMaKeftGoydd9hWGfaLWmMcABqSc/aDRmNTLoszje2E78szvbBWyGOF
	 fY0oHcTNfwEHadVc2//53yGKZ+4JLrOVIEqxyHhbFYyolq/T+Wcnm8Z1TBz3OUEO0f
	 4JwIS+dtdmoOcxLge3kMaDgrGq3Y1IwNS4nAG+6GMZr6gvcfzmVqNPFhYjnrLJgl5B
	 eikuxuVBGsHT7MECuGfR1ri0vU8DY6RS6/1WQ3eGaQobkRjyA+ijYvSnTn01IOQ2eq
	 CoV1OInrdeR8/8erKc8ose8yipMm+grip2W5tohSMzhwkzx7qsTgvkYfqynMGZ7z8l
	 W3hEgd3Oz2wgg==
Message-ID: <f9606d4b-7ff7-479f-8e73-2e8cc77095fa@kernel.org>
Date: Mon, 18 May 2026 15:01:22 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 5/6] bpf: enable bpf timestamping rx in TCP layer
To: Jason Xing <kerneljasonxing@gmail.com>, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 willemb@google.com, kuniyu@google.com, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com,
 memxor@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 jolsa@kernel.org, john.fastabend@gmail.com, sdf@fomichev.me,
 Simon Sundberg <Simon.Sundberg@kau.se>, =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hy?=
 =?UTF-8?Q?gensen?= <toke@toke.dk>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org,
 Jason Xing <kernelxing@tencent.com>
References: <20260518082344.96647-1-kerneljasonxing@gmail.com>
 <20260518082344.96647-6-kerneljasonxing@gmail.com>
Content-Language: en-US
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <20260518082344.96647-6-kerneljasonxing@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 18/05/2026 10.23, Jason Xing wrote:
> From: Jason Xing <kernelxing@tencent.com>
> 
> Add two if statements to accurately isolate bpf timestamping and so
> timestamping. They can work respectively.
> 
> As to so_timestamping, only add a loose condition via report flags
> to avoid duplicate strict checks that is done in tcp_recv_timestamp()
> and performance impact. If the loose condition is hit,
> tcp_recv_timestamp() is able to handle the exact case and doesn't
> hamper the existing timestamping feature.
> 
> Make it work in TCP protocol.
> 
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> ---
>   net/ipv4/tcp.c | 14 ++++++++++++--
>   1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
> index 21ece4c71612..64c69bb3578a 100644
> --- a/net/ipv4/tcp.c
> +++ b/net/ipv4/tcp.c
> @@ -2949,8 +2949,18 @@ int tcp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len, int flags)
>   	release_sock(sk);
>   
>   	if ((cmsg_flags | msg->msg_get_inq) && ret >= 0) {
> -		if (cmsg_flags & TCP_CMSG_TS)
> -			tcp_recv_timestamp(msg, sk, &tss);
> +		if (cmsg_flags & TCP_CMSG_TS) {
> +			u32 tsflags = READ_ONCE(sk->sk_tsflags);
> +
> +			if (cgroup_bpf_enabled(CGROUP_SOCK_OPS) &&
> +			    SK_BPF_CB_FLAG_TEST(sk, SK_BPF_CB_RX_TIMESTAMPING))
> +				bpf_skops_rx_timestamping(sk, &tss,
> +							  BPF_SOCK_OPS_TSTAMP_RCV_CB);

Does this mean I can enable timestamp reading per cgroup?

In Simon's netstacklat[1] tool we are forced process all RX timestamp
(hooking fentry/tcp_recv_timestamp), and then we have a BPF filter[2] on
the cgroup IDs that we are interested in (which is a significant
overhead, as this is deployed at Cloudflare production scale).


[1] https://github.com/xdp-project/bpf-examples/tree/main/netstacklat

[2] 
https://github.com/xdp-project/bpf-examples/blob/main/netstacklat/netstacklat.bpf.c#L484-L488


> +			if (sock_flag(sk, SOCK_RCVTSTAMP) ||
> +			    tsflags & SOF_TIMESTAMPING_SOFTWARE ||
> +			    tsflags & SOF_TIMESTAMPING_RAW_HARDWARE)
> +				tcp_recv_timestamp(msg, sk, &tss);
> +		}
>   		if ((cmsg_flags & TCP_CMSG_INQ) | msg->msg_get_inq) {
>   			msg->msg_inq = tcp_inq_hint(sk);
>   			if (cmsg_flags & TCP_CMSG_INQ)

