Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC863D75AA
	for <bpf@vger.kernel.org>; Wed, 13 May 2026 09:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778663838; cv=none; b=XVD2EQ1ruAT1FEIZ6PhYqGPJcywnNVEkmVhK4wbnbvcxUBXhGj34PBtzGWoO5CKJ2cJSnZvZjhW8Sfs8mxLaMnhEyPy/xgmvGoMvnSJpTi4B995yZLeGMQiCR185khKNgbCKHnzZEFFZ6JyFhGZAMdEG/CDJyO9MqtyRYZm5BB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778663838; c=relaxed/simple;
	bh=SIg35o41z1LZVAKC3fAi3BASks1XM5AoHSYceWAirFk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EDfATO4tjWCrmNlEcFV75ZCKtk07PejenXElDh5JNQRh8bcvNqb910Zfp9lqAZBY/n9iemH59CRIGaeJYY8Lp8YfctOh9dLa7AjRDxluchSYiHQAQ3Rl7m82zYJRt5lozcF28ardii+RAtNJ691GxUJQIwl+XCcvONfF5FKilNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=duPfeiNF; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="duPfeiNF"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-bcb5370bb0dso944977766b.1
        for <bpf@vger.kernel.org>; Wed, 13 May 2026 02:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1778663835; x=1779268635; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=SIg35o41z1LZVAKC3fAi3BASks1XM5AoHSYceWAirFk=;
        b=duPfeiNFAprAJGBmpdyVnMnxkvfy6NFXEnzHRzsG3hy0jXvgYke45Fwv+RJ9MEnR8+
         xhrf5Isu2/isFEai/mvr6H3P6k++JhXzMo7JWy5vcY09qG/1ts16giIy1lryE6IvJez+
         dnlCJC3PAFHw6Qsj5PWBlGUq7/YeFLPKpEtt8w3a9d8WfzhmFFdR6v50rVwUh2n5ifDm
         lS801S0uPgCyir2mZJsyqreP0J7wCHQhxHkE6tV26H7PdZQ51YXdaPyOJ6DkQR8E/4Ls
         Aj+t45Ovpp21Wwpq9CmRv8diSrQbNI5RERt8wGJT5/AlMGi8CXvYvA7bjPBEd8cYjEDV
         wf8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778663835; x=1779268635;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SIg35o41z1LZVAKC3fAi3BASks1XM5AoHSYceWAirFk=;
        b=ehnOc6z7HgTi0w+liFZRntjhJ82/CWiGVsT+OoIyWMm8Q/9Wu++XgIs9qTPxkISt/m
         ETl8/v9gJqAJ/iRrb5vw+eZQijxTcG6P3egTEwtca/+B9zn0DTIzkbw8vaw/mBFqP28d
         gxuvt1W6rRrGT3OMzKXKumhBNjErTfk7LQYv6aU+fdwecU7w45YGD4P9aNXotRxMPlVO
         xHPfoyE8luWTLu6yGUiY/09umVf+BSgALbl4JnErllBqAoMjcGq68Wigjr6nI+DCaHzx
         jBfr8vY3oM4ETG5+oWc+ncmiuBKS4SuXgbN7TEnYhkPJd4kwly124X+bN+9bHtesbQX8
         5MXg==
X-Forwarded-Encrypted: i=1; AFNElJ8Zmzu4hZER8mWtqgEbiCn0jl/0z3QfJQyKDU9aVWAh1yZi8CwYQzXuSMoUd234c4l2jno=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywv2wqLr4gD6hT77glMb1qvteQRiiPrFcyr2K4R7PupBlVIwmFB
	hWapOVEnynfCcqhJstfJFqQaDVbPIqo3C7L/ghhHqjibFLUunzFK6ZFPR9HsuR4QsGY=
X-Gm-Gg: Acq92OFrkfBNoHe5QEdex2diI8Gi1IGY3Agu/fwEixVDFSIyAH+l2Uo9/PCuIBgk+U1
	k3iyGWmzLY9zxflg7xSUTzhPuGPSsE4iL7u7I7UZ8gmphlboB9LfEUreMi326rw/pvDV1xRYFDs
	rdJCsOAfIDRCR2tIF2VtFAoh9ERHmZ4juKFi4n8V3eebSae5z4vLN+5YQ3kUmEC0kDvfJ32cxg9
	Pc/83lJaVtZPz2cFZXZ7/qrYmFyZsrCwVITjJqS8HEMoXdYBbMKZRi7HUepZqtS0Gol2Ca+3BvL
	LeLxEsZmVWqCBJFHumN5aUd+tLDlYv+ONKvKeThHm5sYlM2k33g7DmdEwujb6gxGGeVN4OJu9hx
	+goomExgYsW0ggN9nWLRe5J+emtvYzsSlfTIJytPkxEArkf2OIH7D7u1DmsaFSqAdPJ9J7/Nv0/
	hfAHfYhXpqw/nyCy32qB/wtVbQMA==
X-Received: by 2002:a17:907:72c9:b0:bd2:3623:dab4 with SMTP id a640c23a62f3a-bd3c0edec93mr165052266b.28.1778663834927;
        Wed, 13 May 2026 02:17:14 -0700 (PDT)
Received: from cloudflare.com ([104.28.21.182])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bcd60f726desm584093366b.25.2026.05.13.02.17.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 02:17:14 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Jakub Kicinski <kuba@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>
Cc: "David S. Miller" <davem@davemloft.net>,  David Ahern
 <dsahern@kernel.org>,  Eric Dumazet <edumazet@google.com>,  Paolo Abeni
 <pabeni@redhat.com>,  Simon Horman <horms@kernel.org>,  Martin KaFai Lau
 <martin.lau@kernel.org>,  netdev@vger.kernel.org,  bpf@vger.kernel.org,
  kernel-team@cloudflare.com
Subject: Re: [PATCH net] net: Clear skb metadata before LWT xmit
In-Reply-To: <20260430173153.5cd1d348@kernel.org> (Jakub Kicinski's message of
	"Thu, 30 Apr 2026 17:31:53 -0700")
References: <20260428-wip-skb-local-storage-from-scratch-v1-1-8f7ca9b378ce@cloudflare.com>
	<20260430173153.5cd1d348@kernel.org>
Date: Wed, 13 May 2026 11:17:12 +0200
Message-ID: <87jyt78y93.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Apr 30, 2026 at 05:31 PM -07, Jakub Kicinski wrote:
> On Tue, 28 Apr 2026 21:44:37 +0200 Jakub Sitnicki wrote:
>> skb metadata is meant for passing information between XDP and TC.
>> LWT programs cannot access the __sk_buff->data_meta pseudo-pointer.
>
> netdev wasn't CCed on the sashiko reply but I think it now auto-marks
> the patches as Changes Requested :| The Sashiko comments didn't seem
> actionable to me. WDYT?

Apologies, I completely missed your message in the chaos of the
conference.

I actually wanted to double-check with you and Daniel - is consuming
metadata from TC egress supposed to be supported?

If not, then I agree - nothing left to do about the Sashiko feedback
[1].

[1] https://sashiko.dev/#/patchset/20260428-wip-skb-local-storage-from-scratch-v1-1-8f7ca9b378ce@cloudflare.com?part=1
