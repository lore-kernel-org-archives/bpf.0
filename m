Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.207
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793671654;
	b=FIa7CHQCyJ3esUw7cqTW/iDkvRwEkWp9ntEJlnNvMsEWTEGbWnOE2Dqlo/x1kcKMG6kt
	 Z3mTaDu5Ab3k1/4YZf1l3zuo2YwyKGtA9KO8pdisGTygotq/kKIAohmmEMe64SVj+tEXK
	 LicoWgr8uZvJ85LLU0x+Wpf0qskUzVoVy+PlVK30T5Ssunm3/PuR/1rzh1Md+xWSG7/QW
	 f1Ez97tBtkEnfGWjfeRPBFYls9LuONg8Wx7dnyOPrpLkmDVBf/JLyHlUr9j32Wv3T7AZ5
	 zyEevL+wdAS2bgcq1ppm21rEikGhygov/WBUH8snh3anuV5UOfAK5lDFtXcOjzVLcLg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793671654;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=P7k5cnC+t2I3C26m1w5k2WjBKMTtjaHYcmzM++bUry0=;
	b=Vpmb9HMnpPJEZ99Ox8WejeT2QdUZYHucmKWhZMO1ryqFHeB2VQxujmChv1DW9zj9N8l+
	 ATbFzk5VCR2SIsiidmo7NmQ5qdVaYHiRthHdwSTKJ/mQ5WcFIAW/XYgNl6DiYGHFC15/c
	 a0DAhyJW7yNGXiimA0Vfys2zQ7fRAuVIxrxFs2irx3LDBBe0afFI4IC4TGPPSAWICbIya
	 Y9EN6AYIcbwcXUfc5hG3O5kJQDqklEucoouyRrHoGBsu6p/xrgvQxcwhJ4edN79ay/KYc
	 Z2Cvn9eDtsbuYbLChgKb8AEECeBIxUcYIWvXGHDrr1z/s9xLzr2gjr2BLqx2spqMEiQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=CoccJxjV;
	arc=none smtp.remote-ip=91.218.175.207
Received: from mta0.migadu.com (out-207.mta0.migadu.com [91.218.175.207])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 451FC606A329
	for <bpf@vger.kernel.org>; Tue,  3 Nov 2026 02:07:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 451FC606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=CoccJxjV
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=0seUYfdCS8VwnvHk3Qjkg69KJT02ZhaNs/EnHfYw7T8=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793671651; v=1; x=1794276451;
 b=CoccJxjVlkU46zufn5h61S55XxHyIcc3pbaHjWPdt3Owf/7IGLLXfMbAVGNiNdF48CNErGBQ
 u/WfmkWu2HwDnO5os8Kjo3sH2Tml2dNojjicRFtKf4s32BT/+xDQJ/n6Am1ExqRyWJnQHmOGzhd
 zZqJVkBMabuo9gEHxWeAbkYQ=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 572a8b41bc4b2687;
	Tue, 03 Nov 2026 02:07:31 +0000
X-Mizu-Trace-ID: 572a8b41bc4b2687
X-Migadu-Flow: FLOW_OUT
Message-ID: <57fa7d2f-7cb2-4fa3-92cb-50bcd8ed576d@linux.dev>
Date: Tue, 3 Nov 2026 10:07:18 +0800
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
Subject: Re: [PATCH bpf v2 13/15] bpf, sockmap: Check that the redirected
 message is the cork
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org,
 netdev@vger.kernel.org
Cc: daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com,
 memxor@gmail.com, john.fastabend@gmail.com, jakub@cloudflare.com,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, kuniyu@google.com, willemb@google.com,
 matttbe@kernel.org, mptcp@lists.linux.dev, mason@kernel.org,
 josef@toxicpanda.com
References: <20261102072112.4160195-1-alexei.starovoitov@gmail.com>
 <20261102072112.4160195-14-alexei.starovoitov@gmail.com>
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20261102072112.4160195-14-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 11/2/26 3:21 PM, Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
>
> In tcp_bpf_send_verdict(), msg is psock->cork or the sk_msg on the stack of
> tcp_bpf_sendmsg(). If psock->cork is not NULL, the SK_REDIRECT branch sets
> it to NULL before release_sock() and calls kfree(msg) after the redirect.
> Thus the branch assumes that a cork is msg.
>
> This is not true after release_sock(), because a second sender on the same
> socket can make a cork. The first sender can run the branch again, and then
> psock->cork is not its msg. Nobody sends or frees the cork of the second
> sender. kfree() gets the sk_msg on the stack, and the kernel crashes.
>
> Compare psock->cork with msg. Nothing changes for one sender, because
> psock->cork is then NULL or msg. The other branches do not change, and a
> cork is still not safe for two senders on one socket.


I think I should try to serialize senders on the same socket. The underlying risk here probably goes beyond this series.


>
> Fixes: 4f738adba30a ("bpf: create tcp_bpf_ulp allowing BPF to monitor socket TX/RX data")
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>


Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>


> ---
>  net/ipv4/tcp_bpf.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
> index d8e29b09818c..b1071b0960cf 100644
> --- a/net/ipv4/tcp_bpf.c
> +++ b/net/ipv4/tcp_bpf.c
> @@ -517,7 +517,11 @@ static int tcp_bpf_send_verdict(struct sock *sk, struct sk_psock *psock,
>  			psock->eval = __SK_NONE;
>  			psock->sk_redir = NULL;
>  		}
> -		if (psock->cork) {
> +		/*
> +		 * Another thread can make a cork while this one sends msg
> +		 * without the socket lock. Leave that cork alone.
> +		 */
> +		if (psock->cork == msg) {
>  			cork = true;
>  			psock->cork = NULL;
>  		}
