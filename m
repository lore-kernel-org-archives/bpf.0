Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792609769;
	b=gCOF45nhwiBDvQ1LScSRcn19vdD61JDkBaMitHu+qUnS9bP5mP3QhR+dtDZ4WNxC/Cgi
	 i6rWXpku9UleL1PIb+OIViXC+lGfZ0wKOgQiGdvk9C5w38z/ikM4fF534uKLLotp2rWIg
	 sWRqpd2wbpe9y3GNL2b926gdae9IbQ3UzDLhZNXqFwe59J+FgKnOzPWCf7vEnOMrvseXE
	 x+arP7fJBoT+HeaN8Wiz3GMl1RnUceKg5VlwNv1rq4/LtJK3GzM3M+OfrAhYXKXQPzxF2
	 xzswA7CdRi8hspjUx07kcHw33vLAuykqHilNK5wDPeoI06XvcprZrDG2iWdiOE/h8kw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792609769;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=ufRtPFO5aj6aewLUp6DYG7D+kb+rTkZYeWyyvjR5ckI=;
	b=ueJ94m9+y4AdzzfEli/1voGbOE/aptz+1aPlmESfr6uT76KzMKvPl+wlNWoWfmnwnqAk
	 kpjkaw3c+syOIHCtrgYgOyeGgEMeCZUZUgaCMCdwlwGgY7nbOinLlrLsOk0pPP3Hj+7gA
	 HgriZFvz+PaGkKd3quwNhg2ugjZnIT96VHbfzmbV09bTV5sQnm0lnCWtU5ZRbs9dpZuCg
	 15CiO1bA3yt7qSvKCxG1l+IXGon5+DBriQFM0AQS1KcZFGY2mpScyf2JyH14tZMl3hTxs
	 d3PLoIcnLoC3cWwKyiiXS2DQYFhqwfY9aZF0PtRN7NK+ABz76z83ffQj44C/SE92XWw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nebusec.ai;
	spf=pass smtp.mailfrom=nebusec.ai;
	dkim=pass header.d=nebusec.ai header.i=@nebusec.ai header.a=rsa-sha256 header.s=google header.b=FJW083KS;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.49
Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38E0A606A319
	for <bpf@vger.kernel.org>; Wed, 21 Oct 2026 19:09:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 38E0A606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nebusec.ai header.i=@nebusec.ai header.a=rsa-sha256 header.s=google header.b=FJW083KS
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-6798d4ab549so1091024d50.0
        for <bpf@vger.kernel.org>; Wed, 21 Oct 2026 12:09:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792609768; cv=none;
        d=google.com; s=arc-20260327;
        b=VNJCTyQsch54G8ALig7y9kJxLEZNL/FrDsktiaUQazW5Dp9BKpOSm4j9beNwWSq7+/
         yKenp9ZZxy9mZctGVzhY4yqHoBkP5y+N6Mjrv5WgN1tuICcR66G/l7eBwYpLAYsOH9Jd
         F0yIhWnvNEXfDyAxuGguiTRImiqa+1efo+An3CgtZrowCZb6wR4Vl0OCJmEwjywOj8/W
         dbl7nSXvn/Yf+Jiy61kgMfkg1sMy7Q6iq1Pf475e4ZHrxTyHzHHU2uN/CxfSAiKG/KQ7
         kLibJ6BoaxI+x73/enSzx5zuGuUCIxrZZHNBaNeSuPvbMdpsBPECCq6JKo2C/7dMggW7
         GLdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ufRtPFO5aj6aewLUp6DYG7D+kb+rTkZYeWyyvjR5ckI=;
        fh=GroOqkHxdGMqOis01T4DJ5qMDD06nNUT0++DggAEuck=;
        b=iVTEu4s0cxSby7cHT+uQYelnxz4ldPCHkqxJwjRoHUDV5BHUO5f3bo+2n4R1Jbn/Xf
         q6/83Fb9m+JXPVY4k1FzfKlmwTv2mTHNLM4phSPPYXET3RJ7KNd0z+tWAOrRU3xGImdl
         y8YFIMJKKozhqgbMiM1rubMuP+MaZXO5hhsEO8mW73vh8fVv5rIM6CFdZsD6faxqaybk
         jfGuJD0Tvb0p+6tKdDVq0fIPMCK5MnsyNQd2HJxQplSGxFn2R3bCq5c4q7T+wwvFa4+q
         WPTHBfxAm0nd1ap6nUlp+xwa8nK0kW5RKndm/CD3g1h2C8Ws/I9/TNXLCxavEBwkkDKr
         YY9w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1792609768; x=1793214568; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ufRtPFO5aj6aewLUp6DYG7D+kb+rTkZYeWyyvjR5ckI=;
        b=FJW083KSn1VUn7MrgFasH/OzdbUwqjVvb4YWYOmZ9GeV4J6Tc2QQ9PrMYGR63yIShf
         b4etRlqON09weOqlry/x0R8rSN5d9Hukd4dJR/j+iXck1GwKerOSXAE/ZuTA27Uz1xa4
         vmPn1WAMIvZcMPxt3ys3jnA5ZjnsLR9BmOEV2HCgi0qOrQL8nuUUZsbmBXVPuYxCscUp
         ehzjDIPMT0xEB6S/gUrqL29Q8cPXryB9Egd9lFoe1BM94GRcCm93R2Ai5+C19w8g7MEE
         7jVEY244CP1pYcFMDf9xAuRfyvdtvH59XpSAj8lhEouepThjMf26MCyhvAnzJO5JCay2
         LOUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792609768; x=1793214568;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ufRtPFO5aj6aewLUp6DYG7D+kb+rTkZYeWyyvjR5ckI=;
        b=j/nsGHF3VlqU7eZqUP6eEO9BAaB5lN0ovwcBw/eUPCsqS0gCWeyuoYB8EXxdgYOLDQ
         4HnINVBWZENyfbgpzI8thC/+fzBXeSW5mydcdIZHSgCova8PUTZY9oE4NNgwSUo3M+ga
         MS8BLddprXiGZSFvmgb0HFKIkrkRsXfTk3B1YVpGto7MnFMgLMB+P83VoQAU0GA1OjRU
         EdFrdkUYHRdNED9BjKCAunLr650WQKrc+GI5sPUgsPvakBRi776B7sOL/nExBy77plvL
         Z1pbTGUXwQtZsXzqzxZn2lOx1ZsXTDErAKOGpEM9iu1oy98yII4t2LGn67IIy+SxYsuu
         qrYg==
X-Forwarded-Encrypted: i=1; AKwUvBxyx1KKQ2y4SZzHGOvBgzn+0Ia9dPyhCutX0CZ6FVgczLavJg+1vJPInW3Q5Dda2qwOxk8=@vger.kernel.org
X-Gm-Message-State: AFq9FYJkG0rccCy09czgzTV2HywiR4aWoz3sBniN6Ja8v5vMTy/FIM8e
	JdLRsX45Geo79IE8C1ydfvcP7TvEleRapaKs+In57oxx48IrZEYRSuWQMvR0o7x4Hl5dOx92/oE
	7m5rD35OMfXctnJTuHVGFYSQfpQm95l+JahnF+WIiTdM=
X-Gm-Gg: AYBFou3In3d2l0d5iOvAmypg6rB7uw4bRoBpKoLNvc/g/nlY9Ak9V1lnZb9yETm5Wv6
	NOcjLhSQ8wNiWlvnBkLQnlzLHWel63bOZzpA52456gjwUuJe35XXPoCJzWm8j9r3Yk/aKNh+mvt
	cEyqMXxq1La6BHddGZxSwi593r/cmAbz2whFGSBj1uF5YyRpvm9w4hGlYkQY/G/nGprThBHquXQ
	houVlF+DGNUpaQdisn5IuyvXwQ0bulKPImxjyrW9pMNzMnQU2A0fT8bZJlhkJnNCba86qLIYAh8
	b4cTgA9xRQY4XtJ8mRkJSdgr/CcWTTbcT8wNkQc3/AsUfdPEbKesYh6ZqY3EsMAH6Qtnxo0VXT9
	cw8NNLJmGTe7Lt7Jpzkmi5OpI2szOYajR/rCE
X-Received: by 2002:a05:690e:147:b0:679:b0d3:9f1d with SMTP id
 956f58d0204a3-67a0e4f771emr1009384d50.47.1792609767831; Wed, 21 Oct 2026
 12:09:27 -0700 (PDT)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <cover.1792607608.git.zhilinz@nebusec.ai> <179260934140.3290.12382990945643523195@kernel.org>
In-Reply-To: <179260934140.3290.12382990945643523195@kernel.org>
From: zhilin zou <zhilinz@nebusec.ai>
Date: Thu, 22 Oct 2026 03:09:16 +0800
X-Gm-Features: AclHuK9MeXpeNLn-EU3mGZxdX-1U_EvCX4QVyPCBo27t-D9R4k2PDnYoaJgt4qM
Message-ID: <CANB6i5zH4BsN02FCWCJC47-5VWODVdQaurE62P70LRkZaAY23w@mail.gmail.com>
Subject: Re: [PATCH net 0/1] tcp: release congestion control reference on rejection
To: netdev-bot+sinfo@kernel.org
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, edumazet@kernel.org, 
	ncardwell@google.com, kuniyu@google.com, davem@davemloft.net, 
	pabeni@redhat.com, horms@kernel.org, jonathon.reinhart@gmail.com, 
	vega@nebusec.ai
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 22, 2026 at 3:02=E2=80=AFAM <netdev-bot+sinfo@kernel.org> wrote=
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
> Please do not repost the series just to address the above. Instead,
> reply to this email with the missing information, so that reviewers
> can take it into account. If the series needs another revision for
> other reasons, please include the information in the commit messages
> then.
>
> The evaluation is done by an LLM so it may be wrong, if you think
> that is the case please reply and explain.

Hi,

The issue was found during manual code inspection of reference handling in
tcp_set_default_congestion_control(), assisted by an LLM. The inspection
identified that bpf_try_module_get() succeeds before the restricted-algorit=
hm
check, while the -EPERM path does not release the acquired reference.

Thanks,
Zhiling
