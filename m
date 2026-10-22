Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792663639;
	b=hJNO3bL6M4RUNE8YEoGubbTOmjjjkp/Y/6O+bXLuzcvtfbhkCdk38mG9WO3QSmdfO5Su
	 t7A65lTlIq2xzzDpRs9lGeJLuO5N2iXM5xuouWcUzEKkS4KOEUIAglmeqmpjfYZOlWCMO
	 tA8k7itS67gagAEYza1e6Ap4uLUGFhfBP3dFDx5iqRj+JoP1g0tzjTxHtSuoiNaW9OQMP
	 nek9C5Hg6ICHCrE/V3JxUwWzqVeOzBquzkBPdL8w80C2AJkVUY2qZE9WZ8s+qLjNPDScy
	 Prdjhqil24OCnQCQzpWOYTUPpve/ZgVS9Vb30g0dGrVUiO4x6XBuUrKORzTY3dhvOhg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792663639;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=Ll4SV3bdtwckm24BNpifgTpXaQLWXCqLJuIxLlH5XTc=;
	b=CYbWXLIzdrXCndqHcx0nmpFeY9cebRvF8tcdmniE3brJQsUI6dHu3vC88Dfq8AFIhXPT
	 /2J/PWiY194EkWG+6wA0MSkvHdcE4OF+dB7FO2VQ873Pf/Km5MAHPdu7EKicShVsektZn
	 9/9/4SCS1vYBDrYJvmxqAbPyeJDc9/T38nKLhAJm//vUm76uaUQ7z40rly94YPMSmnNA8
	 niH98IYLWpKizjSQqrsVqFhmYsokBebeK9vZlr5Sti2r8pFcLfV5WkX+sa21zNOCwethl
	 ako+kZbBPPtECNYC+DYq/suBnVqEXC0yo8Eb+V8vbk7IgbCoNaQWOr+PxZ5jVBPPx4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=UEDlWDih;
	arc=none smtp.remote-ip=95.215.58.52
Received: from mta1.migadu.com (out-52.mta1.migadu.com [95.215.58.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EDC7606A321
	for <bpf@vger.kernel.org>; Thu, 22 Oct 2026 10:07:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0EDC7606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=UEDlWDih
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=cUVZFAauvYfdrMN84AtZG9D1SbyolDZQ3ZjIcFK8qXg=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1792663635; v=1; x=1793268435;
 b=UEDlWDihUTZM4UJgumgPsw3XU8hOv2/8P82ve8/2i5D38q/nbvDY9afEsK3lXWOHH/NFYhA6
 w931+cH8EMURwKSOuz8dAPaU6VV2lWy9QSMAWgqrLnLyGdRBEcdAY1uHhYmpw8npEEHL5WpghWc
 Is+sW8ZogTG7LaYV8iISgSwI=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 8363c2b801802ffb;
	Thu, 22 Oct 2026 10:07:15 +0000
X-Mizu-Trace-ID: 8363c2b801802ffb
X-Migadu-Flow: FLOW_OUT
Message-ID: <677e01d0-6226-4670-a4d5-8900f8a88cde@linux.dev>
Date: Thu, 22 Oct 2026 18:07:04 +0800
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
Subject: Re: [PATCH] bpf, sockmap: Propagate sk_msg_memcopy_from_iter error
 code
To: Rui Qi <qirui.001@bytedance.com>, netdev@vger.kernel.org
Cc: John Fastabend <john.fastabend@gmail.com>,
 Jakub Sitnicki <jakub@cloudflare.com>, Eric Dumazet <edumazet@kernel.org>,
 Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Levi Zim <rsworktech@outlook.com>,
 "open list:BPF [L7 FRAMEWORK] (sockmap)" <bpf@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20261022095853.1829161-1-qirui.001@bytedance.com>
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20261022095853.1829161-1-qirui.001@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 10/22/26 5:58 PM, Rui Qi wrote:
> tcp_bpf_sendmsg() stores the return value of sk_msg_memcopy_from_iter()
> in a local variable "ret" and jumps to out_err on failure, but never
> copies that value into "err".  The "err" variable therefore keeps
> whatever it held before the copy: 0 on the normal allocation path, or
> the stale -ENOSPC left behind by a partial sk_msg_alloc().
>
> On the first loop iteration "copied" is still 0, so the function
> returns "copied > 0 ? copied : err" -- 0 on the normal path and the
> stale -ENOSPC on the partial-allocation path -- instead of the real
> error such as -EFAULT.  A blocking sendmsg() handed data but returning
> 0 with no errno can drive userspace into a busy retry loop or be taken
> for a successful short write, and the wrong errno misleads recovery on
> the other path.
>
> Propagate the memcopy failure so the real errno reaches userspace,
> consistent with every other out_err path in the function.
>
> Fixes: 5153a75ef34b ("tcp_bpf: Fix copied value in tcp_bpf_sendmsg")
> Signed-off-by: Rui Qi <qirui.001@bytedance.com>
> ---
>   net/ipv4/tcp_bpf.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
> index 97541acb3cce..8cf63a9e7fed 100644
> --- a/net/ipv4/tcp_bpf.c
> +++ b/net/ipv4/tcp_bpf.c
> @@ -578,6 +578,7 @@ static int tcp_bpf_sendmsg(struct sock *sk, struct msghdr *msg, size_t size)
>   					       copy);
>   		if (ret < 0) {
>   			sk_msg_trim(sk, msg_tx, osize);
> +			err = ret;
>   			goto out_err;
>   		}
>   


Thanks for your report but it has been fixed.

https://lore.kernel.org/netdev/20261019082214.102398-1-dmantipov@yandex.ru/


pw-bot: cr



