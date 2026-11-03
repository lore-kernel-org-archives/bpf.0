Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.141
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793672740;
	b=Mb/sxktDT7l1DrYtVrry1HINs4KLjZncmby92k2v7Xce70CEpDqJCiiDZAAyarE5umUO
	 RIDtgVIm6QNQ9M7KjMovOS8+UUZhkMxPBcTLb8fEsggGh0Lb8NYRXENQZGvcK63V7Ygi3
	 vKaJn1UxEYvAGJcr++8OZHak/E4mRWaO4xhoassLnM9xun9r2BQTr7cKzN4ITadeIrNAS
	 0xGQfjsU7GLwaZDb21s37X5bjxNuUnbJJkU1rK9Q29VSFcwdRfnoAD/vkaG+S8QMzEoJe
	 ZO5ogwz+gdXEUMa4wQM0/1BK5SvKkFcUD+3UPXlRLk8iOoq7sawN36/m7Qice2kSUpw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793672740;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=IvOE97nqCYOuKLVpMLw0btVRPz7o5pR9mipwEI05Wt4=;
	b=p7g22ZhwajBz9DnqXi6+gjd9hnlb9Qky9MWgUdWNGH7vIXymHP5FppLHQ0QE/0EkSIug
	 EEz65thc3vg87zF0bAgZ9LkIiSXeHRKz6prq3KoTaePtBKf7skPMywvz8cioQzLVSNX3N
	 KJSimS5OqhJPEK8Nt+ole2norR3a3IIddru7VumoVZcc9BpKsoqEZlg9rwpNRf3AeWbLw
	 boisbne5d48wag6wjQyGwIPOTMJMMU6BfEE5XO8y6z+2IH3ES3uaMjsb7OvQQ0Lk26p9x
	 7PwBDGT1FjAKa7iCnsxhqDCpqZOz25gjAsFOPMdlOzvyidzqelo01JxLS9BJlMiSRdg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	arc=none smtp.remote-ip=91.218.175.141
Received: from mta0.migadu.com (out-141.mta0.migadu.com [91.218.175.141])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49FAF606A326
	for <bpf@vger.kernel.org>; Tue,  3 Nov 2026 02:25:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 49FAF606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=IvOE97nqCYOuKLVpMLw0btVRPz7o5pR9mipwEI05Wt4=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793672736; v=1; x=1794277536;
 b=I5SSa/hBkeH/5TPTeuN4X07ju8nimjMubtSxy3YDqbsZhEDXwfvyXC6MLzr5m+4WTeH6YWl1
 5rQ6R5/95ZCsT+JnqTUDRVVFWUMFrFnuCiHacr9bTC82WWKt8l09zoQx9sGf3T36x3UNzzUPRwl
 x1p1nzzCBuYxH7Fp8cytOjlc=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 736ecbeae81c178a;
	Tue, 03 Nov 2026 02:25:36 +0000
X-Mizu-Trace-ID: 736ecbeae81c178a
X-Migadu-Flow: FLOW_OUT
Message-ID: <fc5a153e-f1d8-4b2f-a1ee-646ac5d8d8e4@linux.dev>
Date: Tue, 3 Nov 2026 10:25:24 +0800
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
Subject: Re: [PATCH bpf v2 14/15] bpf, sockmap: Keep the rest of the cork
 after a redirect
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org,
 netdev@vger.kernel.org
Cc: daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com,
 memxor@gmail.com, john.fastabend@gmail.com, jakub@cloudflare.com,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, kuniyu@google.com, willemb@google.com,
 matttbe@kernel.org, mptcp@lists.linux.dev, mason@kernel.org,
 josef@toxicpanda.com
References: <20261102072112.4160195-1-alexei.starovoitov@gmail.com>
 <20261102072112.4160195-15-alexei.starovoitov@gmail.com>
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20261102072112.4160195-15-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 11/2/26 3:21 PM, Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
>
> After bpf_msg_apply_bytes() a verdict can apply to a part of the message.
> Then tcp_bpf_send_verdict() sends this part and goes to more_data, and the
> sk_msg prog runs on the rest. The SK_REDIRECT branch does not go there if
> the message is the cork. It removes the cork from the psock before it
> releases the socket lock. After the redirect it frees the cork together
> with the rest. Thus the rest is lost, and sendmsg() reports it as sent.
>
> If bytes remain after the redirect, put the cork back into the psock. Then
> the prog runs on the rest, as after SK_PASS. If the new verdict is SK_DROP
> or the push fails, sendmsg() now returns a smaller value or the error.
>
> msg->cork_bytes keeps its value, thus the rest can stay in the cork. If the
> psock has a new cork after lock_sock(), the kernel still frees the rest. If
> the redirect of a cork fails, sendmsg() still returns success and frees it.
>
> Fixes: 4f738adba30a ("bpf: create tcp_bpf_ulp allowing BPF to monitor socket TX/RX data")
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>


Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>

