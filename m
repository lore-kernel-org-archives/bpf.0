Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792979506;
	b=L+2uW4pHMfhzX5OqKvui38cPsTL5pCC4/400EPRsdzF+tEsScjs0U5V/WAkhMwSlz4NS
	 vdq86HBxMtWPLJYFrOkqz0L8S06mzMz6qu5nXimoUNFoV7tkzhHBSpvgJpvsOApYrFkO9
	 y++SJDA85gNL7nTOnZxbvQxczlnCh8TKFg0atGNANtc39eGICgwN3fa1zcLYNExu0Kwgf
	 2NVg5N7Z/JeyaUw6JIYueOjUmShNWiFukuNKM9NI9WJvrzEgCakB3kEh1Lzyl/82ozFEF
	 zV9dxrIum5YV04M0ySAVP/Kd4s9A5C05v0PI6TDHfXG6iiexDIR6BMapjD8kzIDJHAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792979506;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:X-Mailer:Content-Transfer-Encoding:MIME-Version;
	bh=IXt5xvOrWgVG3N+GpdyyPOrA9kPOQI1oYFj+yIA1B0M=;
	b=ulrvMobi2Y8IonfFPJdZ8Eyk7ntky99JUgXuMDP+0eyCHi6cnJG1zR20qUj1DWwMsjGL
	 5MtKsgWCtlY5KIQ9QuXUFO97XxZ212qL8BL6gh8UbZenO6KINPcr1ukV2VpiCs8OJcNgq
	 uVsmoFQ3/9YGXT7/Hns1vJ5qpTYUP1BjMRDnDCjuXj0ATd9ZQRse249vbUsa2ZJ7oczMC
	 ybX+lXh31lo/OgdqREbqvAjF3PoqyBdVXiUwD/valxhIdSzv45JFLzaoOpG3o6//57JvP
	 7f4cXx6AXU+gC22jeAeppE3GT4urA//X7XxdHamROFuNEp/kWAJDP8rkl+6DxPaG1/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=kpYYbdm4;
	arc=none smtp.remote-ip=209.85.216.47
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9326A606A31A
	for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 01:51:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9326A606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=kpYYbdm4
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3ae25008e2aso90470a91.2
        for <bpf@vger.kernel.org>; Sun, 25 Oct 2026 18:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792979505; x=1793584305; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IXt5xvOrWgVG3N+GpdyyPOrA9kPOQI1oYFj+yIA1B0M=;
        b=kpYYbdm4UIaNLa+4gA2O6vViuDhEEOp89PGqsr6EZIpTsN4tT9rOukWJvOxKhiMzeL
         GZsL88QdGFZkEGpbWgmYAFWisgtS4+VmFYBxz5F/QASaNM18840QlkwDndtICLSkDsYT
         +wm+sqLmhdtZ0wQYO/YYpFSkRwbXYA8hTeJsttvMdEb3hJ17KHaxACnHIddAhMAUVsc8
         zMiQZ/e/rOloj5PbH/wf2fzd0LKgnBXs3jpJ0hLVcoXa7yWfqzFCfpgz9PHDRvw+ZpKY
         9dQj8TE8BR25EYre0sIPa9V9z1wBOa6KnuohoN8g3q6QdscMbq/p2/JPiJeBQ9mgjIk+
         1qEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792979505; x=1793584305;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IXt5xvOrWgVG3N+GpdyyPOrA9kPOQI1oYFj+yIA1B0M=;
        b=vVVPakAbAM1ytacBAAyHtWIot7xtwjZrRZZEGyJp8YptCDAZr5JrQZXXsg1wLTsrp+
         oMipA+vabzNosr3uSthD/aAm25FioxnrYTVR1m4eeds4XtRjky7hBLXAWKb3KREiW6I0
         uQ3R7eIUk/B5F2uZdXZV71WKQ/dpIJZEShhiHfjX766JwPDbUKr83AmAUMFOMk3/+RXe
         CBGjUi7cgNcho/lq6ZokYGKeFBDHDmMIFT6r5pKhgniYCtZjEe/mWdOOyX2FE3Xq3+1t
         M3agFHiQku2Bs5gzn58/NC9MTyJlnWJKjCsFcmr/2kheE7CnGOv5ZJcV7HnXWfLyJ94s
         fWAg==
X-Forwarded-Encrypted: i=1; AKwUvBy7g0Iqcv646FP8EN+yWnBFCInN5CAv1Lzl2qPvjlFNr4LgBYpesMoQW1B5kz23G+acjtI=@vger.kernel.org
X-Gm-Message-State: AFq9FYKSP3/4PbUDGWmkk4SPLXOLGcsJsEL2xIriNnH/N6I89Ea/9Cme
	/8buQxHhA7DRTpGmSWU75tp5Oyn8SV/rYEsU5EwkEZvWQHhJMA5SVLRE
X-Gm-Gg: AYBFou1P9LP2tkkwxerhl7gCl76l2cB4DrsVmbvo02JAdYNwKXlmevd+pwOjOuFq6LM
	GP/3OILY+7lnkX75NGUBdTZel9N5PGkEz7ypXlTus6K4wtSIMqtZY2A9crvLW8Lz469X3Ho5Vm/
	1hbfazv/wTpTazt0MqrnoqCiAe60xk/evgxPuDc3Qtj2T4zqwts1uGdnL5U5GsA8ra21PwJ0Hk4
	wBEtR7V4RHqN4YNQMQavFNHNTbqF/YBU5z+KuJhKS5VephWAOJpianPUTw/xeRuFYatpCquRGoJ
	g7Sptwmz3+Apqu5yVICNCr5Lz7C9mjypAmbwgpqPU6sZmP6CnY6hsu2D1RFZiuP1K+U7IQw0WC8
	drLM+wxMJm6eM8x3Sb7upsLlLiw3reHADN7TQQivJE6SvZtT2NNZxqZFnvMt1osQ/CxW5EcYdDP
	VbkGpCEQr34RnuaTfT9pBhfODHvaHBMTtJlxx4X9bGeN42BieaEyoJgujxoUMPxkkl+d0IShF3G
	DcPhPNIDcwgvOOs3iLuQObajDCTud4z95cYe6e7ip/URmlDiVQVzZ5+lHb7eQXr3eIhQGd6i1Oo
	9cCQkBTcY/YydyO/MSxSWv1we1euvxQ1C3jWpkeAztfJYNHO3rs6mheBDXVRLQ==
X-Received: by 2002:a17:90b:17cc:b0:3ac:a5ff:2cc3 with SMTP id 98e67ed59e1d1-3ade9b2ff58mr4868899a91.8.1792979504834;
        Sun, 25 Oct 2026 18:51:44 -0700 (PDT)
Received: from localhost ([153.61.198.246])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adebac408asm6281205a91.0.2026.10.25.18.51.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Oct 2026 18:51:44 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Mon, 26 Oct 2026 01:51:43 +0000
Message-Id: <DMEE6SW3UE97.2DF11HBEBKYYI@gmail.com>
Cc: "Geliang Tang" <geliang@kernel.org>, <netdev@vger.kernel.org>,
 <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH bpf 1/2] bpf, sockmap: Stop reporting EPIPE on
 zero-length skb redirect
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: <kernel@eliskeggs.com>, "John Fastabend" <john.fastabend@gmail.com>,
 "Jakub Sitnicki" <jakub@cloudflare.com>, "Jiayuan Chen"
 <jiayuan.chen@linux.dev>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@kernel.org>, "Jakub Kicinski" <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, "Simon Horman" <horms@kernel.org>, "Cong Wang"
 <cong.wang@bytedance.com>, "Daniel Borkmann" <daniel@iogearbox.net>,
 "Andrii Nakryiko" <andrii@kernel.org>, "Eduard Zingerman"
 <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, "Martin
 KaFai Lau" <martin.lau@linux.dev>, "Song Liu" <song@kernel.org>, "Yonghong
 Song" <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>, "Emil
 Tsalapatis" <emil@etsalapatis.com>, "Ihor Solodrai"
 <ihor.solodrai@linux.dev>, "Shuah Khan" <shuah@kernel.org>
In-Reply-To: <20261025-sockmap-bare-fin-v1-1-bb8feae7c4a7@eliskeggs.com>
References: <20261025-sockmap-bare-fin-v1-0-bb8feae7c4a7@eliskeggs.com> <20261025-sockmap-bare-fin-v1-1-bb8feae7c4a7@eliskeggs.com>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Sun, Oct 25, 2026 at 04:41 PM Eli Skeggs via B4 Relay <devnull+kernel.eliskeggs.com@kernel.org> wrote:
> On an ingress redirect, the empty message is still queued as before, but
> the target socket no longer reports EPIPE.

That leaves the target broken.
Nothing dequeues the empty sk_msg. __sk_msg_recvmsg() sees
sge->length == 0, returns -EFAULT and leaves it at the head of ingress_msg.
tcp_bpf_recvmsg_parser() finds FIN in is_next_msg_fin(), returns 0 and
does copied_seq++ on a socket that didn't receive any FIN.
So every recv() on the target returns 0 and moves its copied_seq further
past rcv_nxt, and the data redirected from other sockets stays behind
that msg forever.

[...]

> -			if (ret <= 0) {
> +			if (ret < 0 || (!ret && len)) {

Lets skip empty skbs instead. That covers both directions.
The socket's own FIN that goes through the backlog is not queued either,
but SOCK_DONE check in tcp_bpf_recvmsg_parser() returns 0 anyway.

Something like this (compile tested only):

diff --git a/net/core/skmsg.c b/net/core/skmsg.c
index df385a5..a5003c7 100644
--- a/net/core/skmsg.c
+++ b/net/core/skmsg.c
@@ -711,7 +711,7 @@ static void sk_psock_backlog(struct work_struct *work)

 		ingress = skb_bpf_ingress(skb);
 		skb_bpf_redirect_clear(skb);
-		do {
+		while (len) {
 			ret = -EIO;
 			if (!sock_flag(psock->sk, SOCK_DEAD))
 				ret = sk_psock_handle_skb(psock, skb, off,
@@ -735,7 +735,7 @@ static void sk_psock_backlog(struct work_struct *work)
 			}
 			off += ret;
 			len -= ret;
-		} while (len);
+		}

 		/* The entire skb sent, clear state */
 		sk_psock_skb_state(psock, state, 0, 0);

pw-bot: cr
