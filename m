Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793752156;
	b=XsXysv87bKYRPWfyRtkKU7WvHHFR8QtROwnvqSGQQiPQ2lZ48CAMwIdI9azm1X97pC40
	 CRoDF+K9TR5nbmfxJ1npCkqv1ZHjRfT9dMjP36xSZkYQOiWJRQEpbZGr+OGyQsU3Y0+7O
	 iAntwuq4GGU8n13V72bkTIH0NxFuHeiRRzh9zU9Qc4KdM7ucR/1Y9IDaOFEk/0EiYHVBE
	 OOeJzuMPGGdvuZzDKVQeoBc5mcAPOYt1fW5u5JsffrkCl2nfIIfCBt58U3+FE0K04atyT
	 t/uAMj8hPjd782ROX5x51O1stdnuVZSiaLMp+cM16mtKzwAHs7OZuUisB6wIBTaPZqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793752156;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Content-Type:Date:
	 Message-Id:Cc:Subject:From:To:In-Reply-To:References:
	 Content-Transfer-Encoding:MIME-Version;
	bh=GYqdfg8Wy1Of3wbQKhJaRmMS8pU171KJe34oGAgyzsg=;
	b=yOALJnqAjocNZlfxue5VyFryMfQxTsfFTjG0PYpv3zO5Yb0Brr4opTlUuR/XH04YGIG8
	 BrwRNXWDZD2p15HRg11fspQSiUjpnIZLUbtWWcRtaPbcPoo+DdvpTXXmeSosTLwoyBBsN
	 jd1O+VCcKJQBKYH4U7V4dUzUrR89SVpelat1/9K2YmDXTip1BUnMKJH2MbX3mcDoxaUn/
	 7YGV8LJ7SIGyhDxT2mGGxSnyt2KfLlZEbyxak6Zr2ek3bm9OztPPB20knG2Iar7F8uAUs
	 cOTF9ALxZUzs8j5FRD+NZFnAzAVjHrqgMU1hRh6ZfTfEcI5amFxr8AauhzWEHk52FmQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RBUEiztG;
	arc=none smtp.remote-ip=209.85.215.180
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFAE4606A324
	for <bpf@vger.kernel.org>; Wed,  4 Nov 2026 00:29:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EFAE4606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RBUEiztG
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-cdac6d19ddaso69363a12.2
        for <bpf@vger.kernel.org>; Tue, 03 Nov 2026 16:29:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793752155; x=1794356955; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GYqdfg8Wy1Of3wbQKhJaRmMS8pU171KJe34oGAgyzsg=;
        b=RBUEiztG2mkc9wkpbfWllotA5zqmrPvAI+p0nJ8kQwmD3bEEwGI4J3ukZN8tZaAjzm
         2I/RzAuS1GA+aJoW9TwSl9KYPP4xuCr/2XViDm1nb7CzGeOjmBBZXQnhZ/wgLtcUWAQR
         LxCySRWs2wStsR0B+V/L2k7amGXRHhVKlPzSmWKoUYmQMxxIBznJnS9SOiQJJcUpinbF
         erXG5Yf3upf7oFXK55zxMvZM6iRS+/IZRicXZYNeiesTezDlAf2XO9cJ+9ey0eMaRAxE
         Yu+uwierp25Wk3pqUAiy+T8FkNTOwF9j5hDg7h4+Qsz8+R+HY83pr3g1dUsZWpyPs2TB
         +HHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793752155; x=1794356955;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GYqdfg8Wy1Of3wbQKhJaRmMS8pU171KJe34oGAgyzsg=;
        b=a4GiAmBfK60d09xMk5BVAHkv8avp8cWvsS5TyA0PeUr1MRPU07hYYjlB8Z/60fq+su
         KU4rTXP9a4i/Qtk/nb3Bzchc9Q5s5ZqeRPXfdnfSOxLCS/e3Uz9wTksGp3N5EkMNNZFL
         Q8XOBhPafntUwYereCTe4+/Iiwe0q/t27FR5UC3/DMmsS7gRxf0y+dZTO4XLxdTfPAbO
         PTCmFoI/kthPdew+mOF4QelaNYrovx6IAaGxMFMdHBFTto2Az0a5VtRHQA4d2Qit4Mr3
         A5rAWKWSqmHRG6VZLKCYHUGlrwif8QjnBqYV99T96ENeuCS+1Xaiv+4gKXa/FUyO4Mtc
         j3Uw==
X-Gm-Message-State: APuU4Z8fCkhJxximabnzpAQc+4AJPHtyHX7xPiH6WT4L4ZhHIz+Nd6Ar
	qIlNJR4mYpyYQLkBBF/DHQZmCgb21+ILjoqDdc/pnbe74RH/GBpAYT8O
X-Gm-Gg: AYBFou19sdjq9JnZ/fv/D9oT76YKMaaw/n/gSWqNiMRFDWIheL0+WlFlfUfRaC2y+zN
	dxOp4qWXJ4Ag/yHn6vaiPIQj5eKdZMAGKE/9BWCSzyca9BnrGmV1iel/hi62xBlJlCdSa34Lh7N
	jQu4J8/6fwpUzmH75k+QZAC/fz2vrrivD64QBZ7Lp9MtPOxQN6fnV45PuW0s+Yox4kV6k8Maj6S
	mQtRpOBVwo5MUJ/ry9SW04Z7HSRhDYT3UmrQYFf9dHr0D1E984K7+JVFJUQlj1tErF+pq8iW0j0
	O9t5VkmDM11eHVeWpAb6zmXuIEWHpJ3B9XkSvu72haef5GIF2yenR3qLIqQ270gMoUMmquB4lgw
	ooJjlND/0U8d1WTuFdUI1EU+8vG6PcDd93jcx2qR8Onxq3U3rKn0WMl/GGr9EZNwN73/bDTr5qD
	WFGR+6aM0/Am5J9s1cH9usRIurmZdn4U2NwgPnUhSrhQVlyfFu84unPk/jjMwNfWTEVVt29wQnu
	74ZswhKcsPU7uRolhDVNnbJJKBgbjr2HezDPR772U4TDbEQiYOm85r79o/6Ei2EB88hYMU0ZE1Q
	qrT1UrMLJOstVqyru7k7SV9ZQ9ftDCmMc3zhIZ56bXIkpIl6G4CQ4g/fCL8mtVJK1cpkLoMxFFp
	iLZWnSaYFe7y02TD+TYdVNk6vEhZJx6zaLA==
X-Received: by 2002:a17:90b:588d:b0:3ab:9c73:147 with SMTP id 98e67ed59e1d1-3ae8970ef58mr11861580a91.14.1793752155221;
        Tue, 03 Nov 2026 16:29:15 -0800 (PST)
Received: from localhost ([153.61.198.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b07c5aa69fsm6514115a91.2.2026.11.03.16.29.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2026 16:29:14 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Wed, 04 Nov 2026 00:29:13 +0000
Message-Id: <DMM02JFDLH2N.3UXPNYN6KZ5JK@gmail.com>
Cc: <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <daniel@iogearbox.net>,
 <andrii@kernel.org>, <eddyz87@gmail.com>, <memxor@gmail.com>,
 <john.fastabend@gmail.com>, <jakub@cloudflare.com>,
 <jiayuan.chen@linux.dev>, <davem@davemloft.net>, <edumazet@kernel.org>,
 <kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>,
 <kuniyu@google.com>, <willemb@google.com>, <matttbe@kernel.org>,
 <mptcp@lists.linux.dev>, <mason@kernel.org>, <josef@toxicpanda.com>
Subject: Re: [PATCH bpf v2 06/15] bpf, sockmap: Give no progs to a TCP
 listener
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: <netdev-bot+sashiko@kernel.org>
In-Reply-To: <179374187870.488855.7800063583184291863@kernel.org>
References: <20261102072112.4160195-7-alexei.starovoitov@gmail.com> <179374187870.488855.7800063583184291863@kernel.org>
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

On Tue, Nov 03, 2026 at 01:37 PM netdev-bot+sashiko@kernel.org <netdev-bot+sashiko@kernel.org> wrote:
>> +	if (sk_is_tcp(sk) && sk->sk_state == TCP_LISTEN)
>> +		goto no_progs;
>
> This only checks sk_state at insert time. Can a socket that was inserted
> while ESTABLISHED still become a listener that carries the psock's
> sk_data_ready?

Yes. It's an old bug, not from this patch.
This hunk is for a socket that listens when it's added to the map.
For a socket that listens later the patch fixes the children only.

>> +	if (!is_insidevar(prot, tcp_bpf_prots))
>> +		return;
>
> The callback reset only happens when the copied sk_prot is a tcp_bpf
> proto. Can a child copy the restored sk_prot together with a stale psock
> sk_data_ready?

The window is there, but it's tiny and it's not from this patch.
Without the patch every child of such a listener gets the callbacks.
