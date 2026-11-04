Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793752225;
	b=ftOOnn5OtIjIBqXjCcvqXzGbm+1jaBJ2U0ZaGlDSmiHN6wamOowYrE4wrY0OfA/3RiNR
	 mYROz9kuXf+DfgpnQ/TfehBu5XrudSvseorrRVt+F25znHt4m1ZipSm7aWXsN867AhqBj
	 sge4jWtHpL2LZeCRXFEmOqRUVlZMm+hsWqmB6f3MOHYP7BeiVtkqL9Xocts4vYxaHYAAC
	 p4oE+W3yi3QpFgiw3N6YPmhLbSTsuLYe4TuGdiP9AcgZoytBBJgL7i5fQOaIWpur4BmSR
	 3ZTARnPoGcUAJqzza3KK0BMP0imkFD/zKlyogdAA3qlSjkJY5vt6gBN7wPj3YIE95xg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793752225;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Content-Type:Date:
	 Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Content-Transfer-Encoding:MIME-Version;
	bh=eEi4Cxmtvez/mBUi4eznPoU/CcbHOpGSzjw4nibALaU=;
	b=pjSXEqXlyjwtns3z6ACDwYNcAmONXWzB4WwU7jsBS65QNCrRMCUcG7dWWb6lN3EuWJ0D
	 Y3GSud5JaVnMzHtS/kYwsjdJ9kPAO4KrYfIfQujeaHXbb2Xu+dR7Q94YevkFfWieVTEmp
	 YtKs/11mvZzNex6qIajQqOD9Zzi5gaRULAJawvBa0UNusoFgaKhlTOcuM3ng877nYTR9C
	 aUuomDwyNsgSw8Bi5wrSXAxbfM3219F+pQxNNt/C+1+5/7PZ/SJktFaRuqXDfWdLJxHyL
	 FYCjpiYmmSS2DcXOggIYssWnGlE7w71We17o9+A+FG1IrvtlNqxmTbmzaAC2bZeTo5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zKJMjQZ2;
	arc=none smtp.remote-ip=209.85.216.51
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7169D606A326
	for <bpf@vger.kernel.org>; Wed,  4 Nov 2026 00:30:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7169D606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zKJMjQZ2
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3acb512a7a0so136901a91.1
        for <bpf@vger.kernel.org>; Tue, 03 Nov 2026 16:30:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793752225; x=1794357025; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:from
         :subject:cc:to:message-id:date:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eEi4Cxmtvez/mBUi4eznPoU/CcbHOpGSzjw4nibALaU=;
        b=zKJMjQZ281aKiS/bWO849qnX+J63/ObIv6qtGf4h23nwKtLqvuZeAZkSYeqkDanS5i
         6GXi2Kg5gPdFQJxv9PQ5+AhikjGWTkkXSRlWqAhtKAmAJdIgrhWqPXgWl36D/ZErOKss
         mb+y8vF1hOTiGLsahM2m5wTT8ZhdUiszk0F2loGelEb0OuAMnp9eQS1ee2niyvStMQ5z
         BYDpWyZi4/eWqfMH5awg8c3sd0CL17nqkwxHixqLQ357paesHt1C1HFUewnjY1BDhyxZ
         wSo6f65RtSL36fmHWlZzIZM2lJEsuWlUH1+TIyu+d39JWMrZcSLH9fvTnFLOlrYqlQIz
         5bWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793752225; x=1794357025;
        h=mime-version:content-transfer-encoding:references:in-reply-to:from
         :subject:cc:to:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eEi4Cxmtvez/mBUi4eznPoU/CcbHOpGSzjw4nibALaU=;
        b=z6DqXjAAjhcRPmgzn1Uw0lGtOY1fC6TFSMkjoNBRGsmfzstQPPQWcR9H3Lnj11wqTz
         B96P1CZgASQ2ci66YUXdqbpizRSptZuMGax2K0fehLUpPYiuwI62EypNla4Qtr8WfYra
         gZ80OPFcnuGWX/EDdUp3xpakeB3OS2WauZTZHZAILPM255HQXAEnohl/+Mtril5An/63
         ypmCidM5sfXRu0pASPsEd6Qw5ZA+gV3DbPLFHdArxVzMoyGrBwj0nc6uHRcfiqjwFZgM
         InN7PoQ5jVzNqvNWDXRnKEUR04acXxXwDqTWj1EFInjieDew4/Vdj1cEq5fbhPJD/a7M
         tGpQ==
X-Gm-Message-State: APuU4Z9MSzEKqP+uxQLoaTMN20rV0h1gNG60GygRgmLEZ6+/2ac7zB09
	+O3p+YVzjjuLMx/jEgg7EGgdLDWCURzamdB4LzpskqLF6OCosonpmfcJ
X-Gm-Gg: AYBFou0lqvULUL+/iPkhXoCPhnkXE2g0Fzbquwj2yKPk3TdYftUIT7RvkODLAsZrFQ6
	/aZaiboX6HN26r4K8L4ayZdH0FZVScj608DkYg9taQqN/W78EivhlgdRu3igGOFnrSKEH0XORH9
	SDhL1rISZi3tIivvRCxmvl/f8p/YGy1SCSXyWg/KushZw8VV5UVAMRVw+08XZjRgQMNeNjEwuFN
	FBjVa0Kod9jGbWER+sX8kh8VwEdU2a0Qw0fvEW13ml5vpzuEE4EuBmmCA0pT22bmGRuyCjI8HnX
	J+f0b0zMhAv5NnBLgJG+buMKqhxMTNp/d4vfRunoKoVoqEoZWx2htmB/qtL0qOVA0QRfFd3TIVO
	AO2MtrC0ynIaDedSncQN78Aj8NG6f1O/5vg36w6Vfhpz7jJ2Zyce8sETQQl+JmeRpnWqerK8IQq
	ZJdsc3Fi80uT9BCDFvttO7InVc9nvivkM1IfPVr481rthLfzWoLboGif2z1cnfedReYeKvdXKP9
	YijywQvTIvUzjTbuWjIWIYFaE0HCUvCdWLqX4NQ7N8w2EknWrEWQkA5aHi2r/erHjQTD6l8j+IJ
	Cv3REbQIH/0LspGCTbpHLZglb2sqvltVz6L23BK1CzO70hKWQmH8scp07/c2lJPJ3Fb7xt5SZGD
	3NknTI8n6XnTuSUZEo6NSvp/XLeSZcqVVMQ==
X-Received: by 2002:a17:90b:35c8:b0:3ac:9a5e:9ce7 with SMTP id 98e67ed59e1d1-3ae897aa7aemr12306124a91.49.1793752224515;
        Tue, 03 Nov 2026 16:30:24 -0800 (PST)
Received: from localhost ([153.61.198.255])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0944eb1d1sm636905a91.0.2026.11.03.16.30.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2026 16:30:23 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Wed, 04 Nov 2026 00:30:22 +0000
Message-Id: <DMM03F7F8IDM.VMOKC4RWW2LV@gmail.com>
To: <netdev-bot+sashiko@kernel.org>
Cc: <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, <daniel@iogearbox.net>,
 <andrii@kernel.org>, <eddyz87@gmail.com>, <memxor@gmail.com>,
 <john.fastabend@gmail.com>, <jakub@cloudflare.com>,
 <jiayuan.chen@linux.dev>, <davem@davemloft.net>, <edumazet@kernel.org>,
 <kuba@kernel.org>, <pabeni@redhat.com>, <horms@kernel.org>,
 <kuniyu@google.com>, <willemb@google.com>, <matttbe@kernel.org>,
 <mptcp@lists.linux.dev>, <mason@kernel.org>, <josef@toxicpanda.com>
Subject: Re: [PATCH bpf v2 14/15] bpf, sockmap: Keep the rest of the cork
 after a redirect
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
In-Reply-To: <179374188416.488855.8465787275984951547@kernel.org>
References: <20261102072112.4160195-15-alexei.starovoitov@gmail.com> <179374188416.488855.8465787275984951547@kernel.org>
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

On Tue, Nov 03, 2026 at 01:38 PM netdev-bot+sashiko@kernel.org <netdev-bot+sashiko@kernel.org> wrote:
>>  			if (!cork)
>>  				*copied -= free;
>>  		}
>
> Should the cork case also subtract the freed bytes from *copied and keep
> the error?

No. That's deliberate, and the commit log says that it stays. See
commit fec51d40ea65 ("bpf: sockmap, zero sg_size on error when buffer is
released"). A cork has data of earlier sendmsg() calls. An error for
that data doesn't go to the current caller.

>> +		if (cork && msg->sg.size && !psock->cork) {
>
> Is this case meant to stay out of scope, or should *copied at least be
> reduced by the freed tail?

Out of scope. It's already explained in the commit log.
A smaller *copied alone is wrong. ret is 0 and tcp_bpf_sendmsg()
continues with the next bytes of the user buffer. Then the return value
doesn't tell which bytes are lost.

> This isn't a bug introduced by this patch, but putting the tail back here
> adds a new way into a race that already exists in the SK_PASS branch. Can
> a restored cork be freed while tcp_bpf_push() is still using it?

yeah. It's an old bug, not from this patch.
Each SK_PASS on a cork has this window, with or without a redirect
before it.

> Would it fix this to detach psock->cork in the SK_PASS branch before any
> push that can drop the lock, and attach it again under the lock afterwards,
> as the SK_REDIRECT branch does?

For this case, yes. Jiayuan proposed to serialize the senders in the
reply to patch 13. That covers this case and the new cork above.

> Non-cork messages already have the same accounting problem. Should
> sk_msg_apply_bytes() be charged with the bytes actually sent rather than
> tosend?

No. The verdict has to end before release_sock(). See
commit cd9733f5d75c ("tcp_bpf: Fix one concurrency problem in the
tcp_bpf_send_verdict function"). A refund after lock_sock() can land on
the verdict of another sender.
The prog runs again on the rest. Without this patch the kernel frees it.

> Could a test be added that checks how many bytes the peer receives?

Right. test_sockmap doesn't catch it. It can be a follow up.
