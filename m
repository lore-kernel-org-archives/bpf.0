Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793645361;
	b=J5DmS/WstyeCltC6K6F5y6EpEUUWuLc3BfU4b2Cgk9Un8sJ0BJvGyCykzqqSRV6hEc0W
	 DL/U6wXY4rbOdlVF68csLo6s4B07rztENW//XR+ejExLGP8+HMRXax2c1bb4wyutCJiPW
	 aSZ/eOAiQkHrZ+8fnGc0biA3eGrxMQtWXIGWvk2bwX4qdU1SYCwGQPm4MUnq1DdPc78uS
	 p8YMxjimZH7EzI3gEQBPn1EceO4f2bm3ofkCcSIEVrGO8CoegaCjVoy7aKPnJFiAZb8n1
	 HW3B8wUp0B9WEtPlEknj8i4CpCLLa/7ryZG0qjDupgPiRRsiLfPj0GUzmMniXTMFdow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793645361;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:User-Agent:References:In-Reply-To:Message-ID:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	bh=4vMJyvF9u6Lpo0n/jndkN841uR7BcIWd5sMOX8N/aKQ=;
	b=iQJlqXuBZYlv+lQLqHWG4X93e547N2K3ZA2p67WmNvkctpxBC3lsgxHwUM4qeE04wu6T
	 wWUqlnovsPVyztKJhCZH2lK6N/acY+HHM6jQuw71kjAXTzn6JuHJCJyEWOY/q70Ip+qH/
	 G5apYMp+41wL+cnQndTPIV0h46Z4aI5qqEwIKZbdUJmOhpjCkNNbBeuLa3gaq0E6jxDBq
	 kj4JUnPoqALs+RtwjZIS20+WbUGDrPTNaasQbJ+8i1NJ9oNPIhs970E7SroZRPll2bpGK
	 vgVn47WPMaPcHZY6SUv+i4qiAF5in25O4m15WIjqiQ+CCBYNXQJR7ZnTUCMH5zd3w4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Pg9NFYks;
	arc=none smtp.remote-ip=209.85.215.171
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B292B606A324
	for <bpf@vger.kernel.org>; Mon,  2 Nov 2026 18:49:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B292B606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Pg9NFYks
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-cdab6ae1ee9so1354577a12.1
        for <bpf@vger.kernel.org>; Mon, 02 Nov 2026 10:49:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793645360; x=1794250160; darn=vger.kernel.org;
        h=content-type:content-transfer-encoding:mime-version:message-id
         :in-reply-to:references:user-agent:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=4vMJyvF9u6Lpo0n/jndkN841uR7BcIWd5sMOX8N/aKQ=;
        b=Pg9NFYks9gpgqRc8umdDXJ22OFO9Biy/EaNROHoasLmA1XWaVcs4eflGnUPlpeQnit
         TiR1n5GDgsexOLkUozfAYC8rvCoGwAEKvTnvYXNmaFKUnPcSoxD6nwe6MhyE9ybFnz33
         TY4vfoY/cDjygnKMnZwVNj82PsqqHBYoRjgXeGXGqLs/vaGxG2v9Cnves+LnlhQJMBae
         3whtZO73djtKfp/SzHRlw3umBVoFbtIi80uDclaWTouc1dt0bwP3c/u7DxMMrai9/jBj
         H1JmobJ7pF4M2qkmbm4Pj/QS7ljScOb3sVgR8aCQt/DG/T236kn6R+GdoOFY4nBQ5WGx
         ReIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793645360; x=1794250160;
        h=content-type:content-transfer-encoding:mime-version:message-id
         :in-reply-to:references:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4vMJyvF9u6Lpo0n/jndkN841uR7BcIWd5sMOX8N/aKQ=;
        b=WjFT6Bm1c80A3rHPYkFb9WYAwhWObDXSs84X0hkQqgKjKvRNvPCQ75a9Bbh2sES8KR
         y+owAE8pgI3CSPMvdeaPm0z94+3o0bPd96zh9Z+kK8ibm0UMUFjdWBKeIcA0/wx+O4fg
         TcF4TRtLSg+3UelpMUhZIZwogm2TlS/YQyryx0B8O5ngSZ+43tUysjCm9PODflJ4p0iB
         V9Y8+BShqMOtxassLstfz+EvlaaJHOrL2YLvnIW5ouPl8SPnaYyBkfhL4wrvL7GaB4Vf
         w7EOK7Ebiu9hIifIUzNFvGXJ2h0UguLPU4yVpqzo8Y7kj+ix89Yh+ZkVjxEipdcetPP3
         jjPQ==
X-Forwarded-Encrypted: i=1; AKwUvBzdzeP4qvPDWUnBYjbjlhsG13sm08rvAEAGBv4+4yZzBVZoplA5JGD3vHBnIQZ9vSkQm8I=@vger.kernel.org
X-Gm-Message-State: APuU4Z9s0J3IpmyQXFTXlH0edKvGAAfTeDP8fvaSZdZXPizN/wkoIUkI
	PetiXkC2xTp2mewiEqGO7F+ksMUEAQPpNcm3J6bEmjBj8H0GB8rxf/G7
X-Gm-Gg: AYBFou2qGglpoZ3b6ClSXpIgBZdecwoMho5P/HLJTA8DxKaNCweloaYEPZGkg/AmK+v
	vnv+eOgHUlYgxFYYmUtPkiNIptJ8f/Sk8wd3tGuBFJQWlMat5FLdZ6GTh1nRVq/m/wEF9IYBUVA
	/9TgK63z+WyettPFVcA5a95A9hQJHzNy/AW2uVZu1dTHPJdhPjmSJc2EMHJ8ScglUU2/LUzJdpM
	6XU0dgRVWI666Rfy7/sWzYPUBmoj592e9z57Z44hjkTEfCWoUdQb2BRj0QlDDjvZP+rmiCzg2y6
	TBOtoJwV2IKQJHC87tPWW3/QiLO45CYRL/TItvopcKDTzUVP/9jfaIhMRmvzWsuQZxqXcaA/T91
	hxo/7pkrWiKg256Zi0w5bhelmkhPdJdLZujk0aOKT9zy/jY2YL3zs4o98phuEfSqsLH8RhSVLbW
	8mKF8XK65IEaTMliHbzs0hRgOKBagvpcypccmc6SB6bto1c6WmfpDM+XUZNURsOIUCsGmkPma6D
	tS464vQMwtPHgrt8xIT3/fMHxtJTZDDfAoWR6VQG1wmxWlIBheCjvF3Bs3rt0h7dptEAvuDjeBg
	9dgqaFJtP4cHfbbnk+Ymv1RkqovmKRp1AjUh6XMZmn0eA6w/8yMaVn7x6l9I8ZgVQOI4
X-Received: by 2002:a17:90b:48c6:b0:3a8:6045:5a24 with SMTP id 98e67ed59e1d1-3ae897e0e39mr7985674a91.38.1793645359949;
        Mon, 02 Nov 2026 10:49:19 -0800 (PST)
Received: from meli-email.org ([98.97.42.147])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b07c6271ccsm431541a91.7.2026.11.02.10.49.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 10:49:19 -0800 (PST)
Date: Mon, 02 Nov 2026 11:47:50 -0700
From: John Fastabend <john.fastabend@gmail.com>
To: mptcp@lists.linux.dev, Alexei Starovoitov <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org
Cc: daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com, john.fastabend@gmail.com, jakub@cloudflare.com, jiayuan.chen@linux.dev, davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, kuniyu@google.com, willemb@google.com, matttbe@kernel.org, mptcp@lists.linux.dev, mason@kernel.org, josef@toxicpanda.com
Subject: Re: [PATCH bpf v2 02/15] bpf, sockmap: Don't let an SK_DROP verdict stick
User-Agent: meli/0.9.0
References: <20261102072112.4160195-1-alexei.starovoitov@gmail.com> <20261102072112.4160195-3-alexei.starovoitov@gmail.com>
In-Reply-To: <20261102072112.4160195-3-alexei.starovoitov@gmail.com>
Message-ID: <tnw1m6.2g2esuogz4hv6@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"

On Mon, 02 Nov 2026 00:20, Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
>From: Josef Bacik <josef@toxicpanda.com>
>
>The verdict of an sk_msg prog is valid for one message, or for the bytes
>that bpf_msg_apply_bytes() requests. These bytes can come from many
>sendmsg() calls. Thus tcp_bpf_send_verdict() keeps the verdict in
>psock->eval and runs the prog only when psock->eval is __SK_NONE. The code
>that resets psock->eval is after the switch statement, but the __SK_DROP
>branch returns before that code. Then sendmsg() drops all subsequent
>messages with -EACCES and does not run the prog.
>
>Reset psock->eval when apply_bytes is 0, as the __SK_REDIRECT branch does.

So no one has tried to do apply_bytes + DROP I guess. If you want after
this series is merged I can add some test.

Thanks.

Reviewed-by: John Fastabend <john.fastabend@gmail.com>

>
>Fixes: 4f738adba30a ("bpf: create tcp_bpf_ulp allowing BPF to monitor socket TX/RX data")
>Signed-off-by: Josef Bacik <josef@toxicpanda.com>
>Signed-off-by: Alexei Starovoitov <ast@kernel.org>
>---
> net/ipv4/tcp_bpf.c | 3 +++
> 1 file changed, 3 insertions(+)
>
>diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
>index 8cf63a9e7fed..d90bcc911b36 100644
>--- a/net/ipv4/tcp_bpf.c
>+++ b/net/ipv4/tcp_bpf.c
>@@ -509,6 +509,9 @@ static int tcp_bpf_send_verdict(struct sock *sk, struct sk_psock *psock,
> 	default:
> 		sk_msg_free(sk, msg);
> 		sk_msg_apply_bytes(psock, tosend);
>+		/* The verdict holds for apply_bytes, not for ever */
>+		if (!psock->apply_bytes)
>+			psock->eval = __SK_NONE;
> 		*copied -= (tosend + delta);
> 		return -EACCES;
> 	}
>-- 
>2.55.0
