Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.214
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793609157;
	b=b7nF9n+KLnNQgCZ5EXDfGQQ8hnsG4+6YduhJBc+fzbEZ6RnHBpRhEStWyfKxfZfUxYnc
	 hPgLa595KpEpaN1n6K3VLM6w43sOE1vPXDHfCT2IkPUp3KOOcXh2JtEpL6v6fe6CcmGGF
	 GSWFFngdJrWaotyWPvFXvnVoqR02tnq/s22z34j/BGYO/MeAHaadaFhn3S3gnRL/IhTYD
	 PZ2grJr4xM+a+OXTtVlwvCoh2lOiyooaLhucFIZVDQbNMDxMZDhCsqBKMda1u9MwXUDkl
	 k9GTAIPRfi3eACyZF5omBPBfzl9eiDLl/h9v9LRLRlbCXzbmORa8QVfzJ6ikz7Ym3Qg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793609157;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=jx4qlQkPxS7DAszsO8FykZUqEui3HDCIXlBMJeUNy0Y=;
	b=Wz7lr0DIFWZe2o0wvitMM4d4xiX6wvp7GqYWlyl4cTskPwvywN1EzICKfeqyKVJImCX9
	 qV7i/MQ//Cearebsq1VdcCEF+mXX/0lb1zL/6hLO+WUAoGDgFjMmsfC7iPKmG0lC/lhKz
	 uiKoRq9VMcx4u6q09b9AqBMjfhPORn+yYilCKVPG71fl4dsbgWOxW3eaYEEdqm1CzmBNo
	 ucaFDUyeY8ZxobJCZDlhuZpn03CCejNu/3r/mCWN6MENZDj59PlABU2wCvJIy2/YWu6gx
	 R1wTlvEcM5p8qtp7aNdsHvv+OuqjJM5cWq09QOJBjYYMSXgfPdF6lCR4PMBf7awueMg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=cjHN8xey;
	arc=none smtp.remote-ip=95.215.58.214
Received: from mta1.migadu.com (out-214.mta1.migadu.com [95.215.58.214])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD5D3606A32D
	for <bpf@vger.kernel.org>; Mon,  2 Nov 2026 08:45:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DD5D3606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=cjHN8xey
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=xxE5inaPrVu+F+7VswAWI/5YBh6Q8RuY05CNRqyPUa4=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793609154; v=1; x=1794213954;
 b=cjHN8xeysAL5ALPxZMu2qazghWYfyhOK3oO2LxRICrgbvHbJaHbAmgL4XyWaCJGsdL+Tp2vw
 NPjjSBXOjlHy6J1rzNqwgbVnEmiwkGBgcI84XPFJTyIe+e5rRR/mXCJtGOFo3arFF94Fw1JW969
 1LAoqiHbd/H4CLbp7oH8zysY=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 2b7e906160719b9f;
	Mon, 02 Nov 2026 08:45:53 +0000
X-Mizu-Trace-ID: 2b7e906160719b9f
X-Migadu-Flow: FLOW_OUT
Message-ID: <bc3366e4-3429-4826-b04b-ca1ff20b9686@linux.dev>
Date: Mon, 2 Nov 2026 16:45:44 +0800
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
Subject: Re: [PATCH bpf v2 02/15] bpf, sockmap: Don't let an SK_DROP verdict
 stick
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org,
 netdev@vger.kernel.org
Cc: daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com,
 memxor@gmail.com, john.fastabend@gmail.com, jakub@cloudflare.com,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, kuniyu@google.com, willemb@google.com,
 matttbe@kernel.org, mptcp@lists.linux.dev, mason@kernel.org,
 josef@toxicpanda.com
References: <20261102072112.4160195-1-alexei.starovoitov@gmail.com>
 <20261102072112.4160195-3-alexei.starovoitov@gmail.com>
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20261102072112.4160195-3-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 11/2/26 3:20 PM, Alexei Starovoitov wrote:
> From: Josef Bacik <josef@toxicpanda.com>
>
> The verdict of an sk_msg prog is valid for one message, or for the bytes
> that bpf_msg_apply_bytes() requests. These bytes can come from many
> sendmsg() calls. Thus tcp_bpf_send_verdict() keeps the verdict in
> psock->eval and runs the prog only when psock->eval is __SK_NONE. The code
> that resets psock->eval is after the switch statement, but the __SK_DROP
> branch returns before that code. Then sendmsg() drops all subsequent
> messages with -EACCES and does not run the prog.
>
> Reset psock->eval when apply_bytes is 0, as the __SK_REDIRECT branch does.
>
> Fixes: 4f738adba30a ("bpf: create tcp_bpf_ulp allowing BPF to monitor socket TX/RX data")
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>


Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>


> ---
>  net/ipv4/tcp_bpf.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
> index 8cf63a9e7fed..d90bcc911b36 100644
> --- a/net/ipv4/tcp_bpf.c
> +++ b/net/ipv4/tcp_bpf.c
> @@ -509,6 +509,9 @@ static int tcp_bpf_send_verdict(struct sock *sk, struct sk_psock *psock,
>  	default:
>  		sk_msg_free(sk, msg);
>  		sk_msg_apply_bytes(psock, tosend);
> +		/* The verdict holds for apply_bytes, not for ever */
> +		if (!psock->apply_bytes)
> +			psock->eval = __SK_NONE;
>  		*copied -= (tosend + delta);
>  		return -EACCES;
>  	}
