Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0994C3AFCF7
	for <bpf@vger.kernel.org>; Sat, 10 Oct 2026 08:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791622292; cv=pass; b=DxRTmaLmhpbSDerOa3XIfF9DG6WByOPCM1xO9G2IbwLxbOcEFzcHKLKfkfn8sJ0YkCDgSGFWriUQ8sNnlJIEzfwKItx2lERp/01kqeu9Ws+1YsW52Lt+dsVFx41aSRFHoiTmyKo5rLu26pF+IZP2/1tcC1+RQWN0f4EeeeTNzgY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791622292; c=relaxed/simple;
	bh=u6d7SFXuP1ZVnuQoZ762H6ZqDSQEKstty+kgOiz1vSM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gQzXzWaiMDz+ijpLTRKi6qKQ0czaFZSZUy8X6B6JcVV/IRAxBBvZoozZdwonHwEF/8CeKBWgjBQcUY0j2YubEBHDiksGlZwZvKfJ062bFTlZR7k7kFuHbUUUPnZR1eNntFAb2rUbIdAogYloazub0I/70zQDCUkdSl0ZggBjWwg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YvwAxthP; arc=pass smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YvwAxthP"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6ab0140ecb2so2538a12.0
        for <bpf@vger.kernel.org>; Sat, 10 Oct 2026 01:51:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791622289; cv=none;
        d=google.com; s=arc-20260327;
        b=kg7//KnNAzFdWH6BgXLa9pehoDLbPKH6Zh4QizEnsxNVIF0oaY4+caymwr4Hajt7DJ
         WWfzgKAlyELIQqbqo1U0zPyvLP0il++aTiiYXwj0rYttDye/vLhKrY+QCt+tAiF1iO36
         kx54R0fVoukM+RhQp503goDMy1cdCqT3JEKRsz3phF40s+wV8qYwdUXPwW/Ej2A6qP3F
         V3ygS2lFrP8is+DFBWjJKEkvDMW14fisezHXOtorpAxBVfm65VswA3h5QvnIhVueCXIm
         zWdT54n7AxrxHEvwp5BuhrzZovpl9qJQMy17H6lAGEgB5Wq7ZiEbLwZXPHIXBaD6/olb
         EBLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1qzTr0YbnBfbPj9+5K148QJC7O1RDLZnnS+cEO+oPi8=;
        fh=X2DIljf3i6UiJqziLxdNerbkqceAXInbly0NJXSwHb8=;
        b=JIV433LnEnBVtrh7Nw7I8b/mAOdtHnG00ffybBiyeXUq1fdpccS8iVYMuNzm1coEL6
         rtFVKPmgcsYVDljhRzGp1IY1vS6QuIs6oC6IopB+UC/RMOWLWf4acw8ssyV+9T/EqMWp
         tsHp66LbIMfXkzX3ihp+wpGIcZjZNxpfaKAafABlXYM1ZxFC3/+bWM03hb0bpe7UvIKF
         C0vL0RXjNF0VvqWOhaDgCM/VDkoVMJzEf2K2MyaKH1RR0VGzx2Q3eXxQBsbK9vRihVnH
         hlNFPrCUg4ZbaSG3Gb7eKDv9BBZ7iFfBBdtLI/66ZJlHaNqJbqMS1KAdx5IDhIFbeUTr
         CSAw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791622289; x=1792227089; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1qzTr0YbnBfbPj9+5K148QJC7O1RDLZnnS+cEO+oPi8=;
        b=YvwAxthPJyhOL4eFMPj0oYntTOJvVIk9w6WH9Kt1na3Q8Wgx4rZMnn9dxOU49RjCKr
         CO0sEt9yZ/E7IjKLXwLT5Y83fZ3rqqiMxVfKkAXqAtusxKuuSC3RJxzOHeb3JfGiLciL
         KFXvToowiYRZkcD5JR9G8fThOogDpnD+lPlzyEScANN8zpz4f5jjHswzU7leUSYxVWQP
         yFnsGOluSCCxaSRpXhIqn/dOweHPSCbD1K9BOrQXQnRqGJYKCM1GUaf4cj8TkSN13ayP
         YNc8Yndp9eBUghyyjftch4P6OF/fGHjktFbAfr2FDPxvVSLNB20orh0BWXSJb6kD38Js
         GBjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791622289; x=1792227089;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1qzTr0YbnBfbPj9+5K148QJC7O1RDLZnnS+cEO+oPi8=;
        b=Ch9xJjU4PMnDSOZfAFSIFQOv15pWM18nHa1tIOhvznXDa0NM3Gu1n3m2COFwUE8W1B
         II4YUSybC/3IkZyu/esNz7+CY07uoy0/g5ZONxvlAFuoWS1Ul2wbe4IqKIicZP6IoGfY
         SeIo6SxIC/qn1tvUM8z4R3iDrfkMt45/lCf70rxpoQFsUlWdovjn39hXVNO3wYAA1K3L
         vOzOwkoVNXMxcatvD5KAeYI7qKpXJDvcPG5LoPY9bsbRclHB7G8PaGXiSqEZagsZ1WYH
         Z/TZpMd3awxioO5g9Z33cn0k+A3FbTutmQptWLxrTGkEdxDmVO1X2XZTRzMq0mG9zlV5
         W+CQ==
X-Forwarded-Encrypted: i=1; AKwUvBx6SaJ5J0/nTvQhA9295obdPDHm3AdTDE0Cmxa9tZtz4eMrvHQXrAj94wAxwSWKxFE4fGI=@vger.kernel.org
X-Gm-Message-State: AFq9FYJQVhuLqD4CatMMboqSYgOkF/CaG+Ogh/Ty68aFJ7VyIRjtOYB+
	yKfmiEVG2AHqn8IDbxD5WaCkur8C9t1M8v5bJUkFovuY2QJRgPnoKlimMf8s8QRdHevOxoL1swh
	1TG3jeID7GFCiCQI5AYJLW3mc7tGeiBEIy/hWRMjn
X-Gm-Gg: AYBFou2Y6XIJ8/B6enRqB9tPeSaXvENVb5ssrjD1ZsKf8ab/f6FN8/4Tls8KmRNgr+d
	pxENzI767FIF9ypHJn1b0rnh81BbaAMNOiJ9pnWnUBB/XG4NWhi67LmXAiJBP9pjFmwisO43cqf
	2IVP8/NnvPZsqmpznEHQkDpL1Lc10jN4g/HMWxtk+JQPUzpyGzfXmL1eW4fNLY/u4CCMFDiu5hf
	NEZm+bnmcWbNEFwwFBwHZcUZBRSVQuRqIq08BqsVwCah1NHhOpI14FOJ0diAgzJHYVWJvR+65GW
	NKd/3gh0mi3ff7Z4m0RmGQRaaVpzo0tPMAFZEFaAHdTdIudwjveJrQ==
X-Received: by 2002:a05:6402:c4ce:10b0:6af:97a9:224a with SMTP id
 4fb4d7f45d1cf-6b19883993fmr15040a12.2.1791622288658; Sat, 10 Oct 2026
 01:51:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261010083935.3274178-1-almasrymina@google.com> <179162194176.2527009.17837283221529280785@kernel.org>
In-Reply-To: <179162194176.2527009.17837283221529280785@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Sat, 10 Oct 2026 01:51:17 -0700
X-Gm-Features: AclHuK_yiP687Fitsz3qcW8jp5keSTQlvPwHmngAicI8BRA9_47JLCvvHXQHfsY
Message-ID: <CAHS8izO=MW1Hy0k0yjm4HbJ0P9F5_oOQieLvFA5T4SzBDdDP1w@mail.gmail.com>
Subject: Re: [PATCH net-next v1 0/6] net: unify symmetric netmem and page_pool refcounting
To: netdev-bot+sinfo@kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-rdma@vger.kernel.org, bpf@vger.kernel.org, 
	Ayush Sawal <ayush.sawal@chelsio.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Tariq Toukan <tariqt@nvidia.com>, 
	Simon Horman <horms@kernel.org>, Steffen Klassert <steffen.klassert@secunet.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, John Fastabend <john.fastabend@gmail.com>, 
	Sabrina Dubroca <sd@queasysnail.net>, Eric Biggers <ebiggers@kernel.org>, Kees Cook <kees@kernel.org>, 
	Michael Grzeschik <mgr@kernel.org>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>, 
	Petr Machata <petrm@nvidia.com>, Arend van Spriel <arend.vanspriel@broadcom.com>, 
	Jakub Raczynski <j.raczynski@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 10, 2026 at 1:45=E2=80=AFAM <netdev-bot+sinfo@kernel.org> wrote=
:
>
> Hi!
>
> This is an automated message. This series looks like a fix, but its
> commit messages seem to be missing some information:
>
>  - How the issue was discovered, e.g. hit in production, hit during
>    development, syzbot report, manual code inspection, LLM or static
>    analysis tool scan.
>
>  - Whether the issue was actually triggered, or is only theoretical
>    (e.g. found by code inspection). If it was triggered please include
>    the symptoms, like the stack trace or error messages.
>
>  - What hardware the change was tested on. For driver fixes please
>    mention the device (and if relevant firmware version) used for
>    testing, or say that the change was not tested on real hardware.
>
> Please do not repost the series just to address the above. Instead,
> reply to this email with the missing information, so that reviewers
> can take it into account. If the series needs another revision for
> other reasons, please include the information in the commit messages
> then.
>
> The evaluation is done by an LLM so it may be wrong, if you think
> that is the case please reply and explain.

I was reminded what I complicated mess skb frag accounting currently
is when I looked at this patch:

[1] https://lore.kernel.org/netdev/xfrm-iptfs-pp_ref_count-underflow-v4-1-9=
12fa72106f0@secunet.com/


And saw that the author was trying to write their own skb frag helper
inside the driver because core didn't provide one that made sense :/
code inspection + LLM written tests for accounting confirmed the
issues. I worked with the LLM to fix the discovered issues. Not hit in
production or reproduced organically. Only code inspection and
artificial tests.

--=20
Thanks,
Mina
