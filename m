Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793752106;
	b=FT/4sbPWkW1qYezF9/ChMX+sKU7TxtZOnhqpVwjopYYKrQEV9iM+h+gG1CdEZp5iYWk/
	 NK3GdrXytXcjs8sEnLQevqoioNJGx9moOOqTKyNitzSnbyf34zimI6PyGYFvY2OmVD6lj
	 kESX9UKpjLeipF/1DQKEaXg24CW9SOIeWxIcrICZtdBg8jxCr1IR8EX46xYAu6wlnWw4h
	 BTH0j+rNIUcmyDupHgWAhcHERCCHGiClmsFz6W5JwOi+wgkof9VCSf62mKqd1wKveyG7O
	 X+yetVd7IibqIY/zb7NYDFehhX9RNhWSROmJmxA4DkBYl5DJU8e6yPAPTYdvhtZfZGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793752106;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Content-Type:Date:
	 Message-Id:Cc:Subject:From:To:In-Reply-To:References:
	 Content-Transfer-Encoding:MIME-Version;
	bh=N9u2giWdwIjOfoxPhFOBtJJGKmXk1nnXCe77BsBVdFw=;
	b=g+bu0i8hXl117X68X80FuznG6PAZSSAccrgql8HvrO24Vfc+8cf2zCg+9ZkVFi4Vu7e+
	 nJDehYyxgyvDsCQ6drDOU/fggKd2Be9Kzv0wb3CIagehwT3hT43ETjnoqT6TMJZ8eA8fQ
	 bZcjC7uCMLwyKyEEUVv3hwkvNJnAuJVBn1zJ536TcLjf4YcxENfdPAH8+Nl+d1fSBdFgy
	 G2w5QnmlmQPplcxutTsC1u+IbYB9t1mOcXBwStD29W6LPSwRc6AJfGjUHaDQ4T/7eT3MN
	 S0+N68spf2o8JDnliYGJ0L16cVl0mX6jqkdf9WZtik9wcc/BUnh9LuO4eU4jwMyYBPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YxkZp1mz;
	arc=none smtp.remote-ip=209.85.214.175
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 651E7606A326
	for <bpf@vger.kernel.org>; Wed,  4 Nov 2026 00:28:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 651E7606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YxkZp1mz
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2e8fe8e343fso579285ad.2
        for <bpf@vger.kernel.org>; Tue, 03 Nov 2026 16:28:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793752106; x=1794356906; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=N9u2giWdwIjOfoxPhFOBtJJGKmXk1nnXCe77BsBVdFw=;
        b=YxkZp1mz77ojbFPxidaXHQKjUlHQaIgDEy5h4M9t1/S4CoKN0VHi8gjLfZxbymF55+
         aHmiuKgloUrDu+nvzQQ+Sgp9HgHlHjpGtUztVe/SK2hNF1iQBwfOcq3jrx9SmaOWdbYx
         IOP66YHyJB5zeog0zg3fuqBPwdKVBUHzB7aGKihgH51rmVtlY8TE6IWBhwsad3/DU+0r
         A20sej+C3V8QObTb3FNNjAu5xTZn9XLwICCGcPyuMJN68DJbYA6vXUU0pTUVIIbADUZH
         ubicMipElbC8x11tPTMXjtazSoYuI5H4aTutLFCuz0jWDswOXFEBUYU5xcMx463oa1a1
         RVaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793752106; x=1794356906;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=N9u2giWdwIjOfoxPhFOBtJJGKmXk1nnXCe77BsBVdFw=;
        b=OZhV6jpuqSNoMIR7oWJgRsvTdtzdalDpdqi2z1tcqt8bZ/kyjsqQvLEKPAO/JZvoyq
         /g8U6ajpptuTHby/DPDBZHdgSaUWL1MPVFG31Doc7YDmSXJpkQGTFF8xFUgtZimD0Uhd
         8rVqFkVrnmUg1VKrGAkaP4gYVEE3b16ZDSMT969OR0hGtSwASOm+bCoy7pRS54nwc1pG
         e55FJchgkVq3LI1qoKjx+YLjt+u4xpFzZrS/xAKFqFpAdUpIuHGgPLrpMT0RQYaGqEXF
         k71x9FHOO0gUVvZF39aFuhvMhbgVoZsPqCtDqoVjnR8PlB5Jd2jDDn1fn6E1z96vkKdf
         5ivQ==
X-Gm-Message-State: APuU4Z9Z+63HXrrH9YBcuBNkt3ZTN3sFaycZM8cBof9pH2+dXHn/rLRi
	EVbO1lVmtVE1t1oh3YDBK1SZpimHcnMJ1eRynWUVHJD7MUdfuHl/PntX
X-Gm-Gg: AYBFou1Lq42bWoScAT3YbVIPnS0IV/enwIt4q8XDMgy8uJubwDn66hW8RBdxTi9FyJJ
	846B8gzJ6dc+5eJekPXAlT0MeJ1j7rgRLhpmLV+EN/sj/ON7x/SyWV/CuIXNQEeyFlWhYYm0hQ8
	5tRnM1k7NmYsZ3IVFBnNW4yV9+AwFoEUsv+I2gimhOkDwD1rMI1jX44t3bZ8fJ5S+9miKECR46K
	1BT+1xhAXCUnd2+wLyIjPgL/J+mXz4y5IJV1OtSzzclT5995wdDwH7gBxPntQfditnb6j4gN2XJ
	XClhwkSA/Ds8a9pcjlynfYsAJtuXK07JA6KRVo8mHRL5HCI8X+70LKOoF2wmH0XunW+r857Y7Oh
	RLWBW7UHV3r0SmaGHXLbHtZR5zWDYYa7oeR4yaLZQ6aINkAnJky6m34MEhT9H6/XQDkpYPhJyGh
	4gC03OPTgcHA/9v1egBZLfxdA3McwlIoDesbVHThTCkn5mV7rAyZUxKFhLLSWleL5bYBdOkrBSb
	jm5/Pk8YodCmXgTtkI2rjtvev1Soc4Kx3jQ5/aFY49x2mx315hDD5S10wb18Ztv4WsZK5UMgdVD
	i6wl22uXvy4MDXcbflUekFSRq8CPEYqmbV/KPMasmCmCnade+x9eOv21kV4FrmFSIIZRSVHCuPt
	sNupqC9aC+b+nhGl6gwBJlNlls8BdOh61xQ==
X-Received: by 2002:a17:90b:2741:b0:3ac:7556:8eda with SMTP id 98e67ed59e1d1-3ae897b955emr11276403a91.26.1793752105586;
        Tue, 03 Nov 2026 16:28:25 -0800 (PST)
Received: from localhost ([153.61.198.245])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b093d481a3sm1165337a91.1.2026.11.03.16.28.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2026 16:28:25 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Wed, 04 Nov 2026 00:28:24 +0000
Message-Id: <DMM01WTK5E12.1RIGV9OGW23PZ@gmail.com>
Cc: <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <daniel@iogearbox.net>,
 <andrii@kernel.org>, <eddyz87@gmail.com>, <memxor@gmail.com>,
 <john.fastabend@gmail.com>, <jakub@cloudflare.com>,
 <jiayuan.chen@linux.dev>, <davem@davemloft.net>, <edumazet@kernel.org>,
 <kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>,
 <kuniyu@google.com>, <willemb@google.com>, <matttbe@kernel.org>,
 <mptcp@lists.linux.dev>, <mason@kernel.org>, <josef@toxicpanda.com>
Subject: Re: [PATCH bpf v2 03/15] bpf, sockmap: Don't let an SK_PASS verdict
 cover the next message
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: <netdev-bot+sashiko@kernel.org>
In-Reply-To: <179374187706.488855.8366350890804573396@kernel.org>
References: <20261102072112.4160195-4-alexei.starovoitov@gmail.com> <179374187706.488855.8366350890804573396@kernel.org>
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
>> +		if (!psock->apply_bytes)
>> +			psock->eval = __SK_NONE;
>
> When psock->apply_bytes is not 0, eval stays __SK_PASS during the push.
> The budget is still debited only after tcp_bpf_push() returns. Can a
> second sender on the same socket still get past the prog here?

Yes, as today. It's already explained in the commit log.

> But B's message is sized against the budget before A's in-flight bytes
> are removed from it. Would it be better to reserve the budget before the
> push? That means debiting tosend, and ending the verdict when the budget
> reaches 0, before calling tcp_bpf_push(), instead of subtracting after a
> failure.

No. That breaks the single sender. After -EAGAIN the verdict has to
cover the bytes that the push didn't send. A refund after the failed
push can land on B's verdict.

> The shared-cork problem with two PASS senders already existed. The kfree()
> variant used to need a third sender to end a byte-limited verdict. The
> early reset makes it reachable with only two senders.

yeah. It's an old bug, not from this patch.
Two senders are enough today too. B's first message goes out with A's
verdict, and the code after the switch resets eval. The prog runs on B's
second message. SK_REDIRECT frees the cork that A still pushes.
The log of patch 13 says that a cork is not safe for two senders.
Jiayuan proposed to serialize the senders in the reply to that patch.

> With the early reset, can sender A's bytes be charged against a verdict
> that another sender installed?

Not a bug. eval, apply_bytes and sk_redir belong to the socket, not to
a thread. B's verdict ends early and the prog runs again for the rest.
