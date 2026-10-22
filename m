Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792656270;
	b=MWe5nOorFRsdf/oQaSM657tmcDUIVwqToh5F7MXpcu3xhXp8HjNFqPfjT1Ugc1TRfhQS
	 a6199hV/cePnT+mgChLeAJJXDyqbeQy4iI5PU6km6vHthyudGv4XPwPih3cuTzX9t6B1V
	 KH4Ijf3v7Z7CEq08f16yC5qGDwMT5UqqC4ksTSOwwTuoGyHCOIlPCpqkbc868ZhcI03Jn
	 z3vaEkAu1TE4YjoC8PZZw/NMK0cGbXQnyk/CSyD+tVKEvMATWAaHddpO/q9nucybcK8oW
	 YmmS8vN9jseJzSj+3x1vtGBSLJvG9HcBq7Bf4B7sX4CtBMosdC1rEPxvHHUYrpbItTA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792656270;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=UvDK0wI43J9wCVFly8Sel32okFV+wP/02Pa6wIx7AmQ=;
	b=uu691aXCPviMgTxLRghdMgZWt1WosRfIcEvRN09pKnNPFIEFMiUDnmjbUQks2UFKjNlK
	 1EevIhrKkIoX3jLoqLNz1RFo1xrvmHwevU5CS2M8KW1N0WdS/HI4+KYXqdP3NXGeu8D6z
	 HB8yHAND8eJzATOP4noKRp906XytrgX4z69XNLwrgpL90/RiAgtj+Qg+0yU8w98+VfXtF
	 IC+yftfChACdjhcwpdKsJCI3Tl/kE541IKb6ZbStoYT3gISHaMF4ZTJf1btzj5xmrFYeQ
	 JkOfvD1o1jIJhzwlpClGoQP8+PoDFSKuA1Wdqf03vgPlCnM8rD4fRYqJ5ls/Kl4dh/Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nebusec.ai;
	spf=pass smtp.mailfrom=nebusec.ai;
	dkim=pass header.d=nebusec.ai header.i=@nebusec.ai header.a=rsa-sha256 header.s=google header.b=M1i9kRr2;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.47
Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9165F606A31A
	for <bpf@vger.kernel.org>; Thu, 22 Oct 2026 08:04:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9165F606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nebusec.ai header.i=@nebusec.ai header.a=rsa-sha256 header.s=google header.b=M1i9kRr2
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-679a2b5fe87so1445704d50.3
        for <bpf@vger.kernel.org>; Thu, 22 Oct 2026 01:04:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792656268; cv=none;
        d=google.com; s=arc-20260327;
        b=T7SWEZniMTNgYnGDi3sqJjHvZcEDgt9OiU8zWTFawUzVPK8ENA9woQHngyVKig5PW+
         5dYXOlcj0iohfq82PjDDtwFtHWV1ZYGLoqkVHFTTpOrT4uNt/Hjl5xvbI/vWp4/23xQr
         8bhBp/Z0eOtqPq0UweuDuTTiUz8ZWBwZxmk6kk+W/xvBSGXB3ul0Fjz/RIjtY4Qxvld8
         v/BzV1hiYpWt2JScnOX0sLK0bUFQFBgxnRyxjOzeVjL44SzxXX3xqdEAsPpeioY2nbEb
         0QayGCQBOQ9b28WIuAmwkk11yCdhcHkQuEPuzPBqIb8lJN5jOnf8Ou5KBa4Z4avv0SH1
         f6uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UvDK0wI43J9wCVFly8Sel32okFV+wP/02Pa6wIx7AmQ=;
        fh=Sc8Ecu71TzE0YoxyEYjVzvhP8y/zVlWGetZqw/h2Khk=;
        b=s6JZ/ruTak02O+89jt9s3pGv3Q+XYLvtgfi+4Nn9ec51w00mHDn8P+bt+vXn9BxC8v
         ux14dDARGbV63Gh6KGilj1Zu+xPm8iyxMQALA9KZ/VBR574SDGQmEjp/kTT35oHrAlU2
         L6dSLQp+ip6faajhDQF6VxO7emxkFl47VxiA1+nmYGldkstmeZfQvyCIqcA8yQFtz4UL
         hqTC5kM3MwO1ckEdvGhTmOLRn9igPgHN6D5plamxjVSNU0uNPnmN77SGJLqf59FGRcwg
         9KJWO6y1d5fFKU382QlmfpfukgjZvkh5vR88jlha5Sgo93mCdqpwpj6NHQ5gqhMth1j4
         q6tg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1792656268; x=1793261068; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UvDK0wI43J9wCVFly8Sel32okFV+wP/02Pa6wIx7AmQ=;
        b=M1i9kRr2So/mB54OOe7b24fDDZPhcuzLofxb1mTsd6/CnM7bhwcEYTqi+oH6KFV17j
         TbyI6v69ifh4j32NTNGCafeDMq/LAnZJ34jGKvMBl1Iz82n/4PRSJ7f0arcuVbFIm60K
         lgAK3Ut5OOBpnpbPm8eMhZf7+AEGMivWguzvGcE+1aM/fUA2v4xsXWjTeLA64ov47KA7
         EogOzuBwe5ACbOt9FG5bC7SPYjyU8QPHSvMenVAduMIFIHoeltXL4G2ri/P8MqvIjRUP
         gsKjU+NJasCWaqeoryJCSQtYYpxAaSjFZHQhZovpREwdvk1kllptrF2nhqveSzIWBg/l
         sswg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792656268; x=1793261068;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UvDK0wI43J9wCVFly8Sel32okFV+wP/02Pa6wIx7AmQ=;
        b=KOPRcGIWvbAmUul9oiXigtfZuCY6xez/U+/x9jZ94R4nLGPnsGSniXI/jR2ZFHAO4s
         xAjFyV6Db1JiMsEpjCVz2XmmCgU2MqXUApD6SiJYKgsFRpN+iPfLhLtyWRkE6Urdm+xZ
         o55M74eMAB4SKkF0Roka59wtNMyZD/v7ME5PiVfvWuoEAmQ81SM1QE8WdLVmLBOBFC2u
         aJTQlnQKsy+XCa4mETFU5Ix4BMhMEU2kwLjMTxOOFrc+3gChutNIkY0B29wd4Ts0pZZ5
         +E7My6zAOpDjcHfW1UTZrvQRstajb+u3/S61oPmAcW6amTHHSi3LdUgY1elBO13ofGaD
         fG2w==
X-Forwarded-Encrypted: i=1; AKwUvBwop9e4fyHClsaOm2Tl/E1BXfW3SppGNP8Q6Y3T1RTl6a/fvVd+0Vh6Lpchm/di9OC2i34=@vger.kernel.org
X-Gm-Message-State: AFq9FYKO8Qqklau0QF7Kzh9ZlmwIeWs4MnplmE0jhKkV795F69WUHhzF
	I6lIq+cEepebBhor/MnL0inNw1tjTLc8I4ecckXNFG281kuM4AemTaqHjezjx3bjgllWGfUeM94
	LEfO02XAtf7F13biSxUzP+wwg2zyU8hXFyjJYSdKAO2g=
X-Gm-Gg: AYBFou1BsGHzJ6iY5BKf6gdF3su1Mhg53vmsJ88hzGzHA9iA9v0Tp2qAKfnJPXF18Yr
	ms0IK839m0m/0+5+yU3wgojJElApzFvDUfn+7aloV05eGSXi6dJgBfC7L0SvI96vr0blHbO/sWf
	ZVaoJFA0323fvGSWmzRJfI0AmEwJbrndAfk1dXAK8nJYG/9Dm+UUEV07KlOvYiRkf2Xqbz0yxmA
	BRQBK8zOU3WD2UW1fr71UFRSGzQKBtzW3nN7bYOtju2OupyfkeqWTGWMcwwPS4EviSu7UZRZzw8
	ggdJG0yUKYKhIcTek3XNDmb+kSQva4q+apE8fXhZGQ7gzot9B89to4b/qx0A0Qcmcad7/mKvIvz
	BH3BuEuwd1AkTwERwFjMlUANB1MmRyVLDMA/EtIwLZY+uNlKs2Nw82gAOLQ==
X-Received: by 2002:a05:690e:43cf:b0:679:a353:7a7d with SMTP id
 956f58d0204a3-67a0e499423mr1493514d50.53.1792656268256; Thu, 22 Oct 2026
 01:04:28 -0700 (PDT)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <cover.1792654486.git.zhilinz@nebusec.ai> <179265618778.3290.6590304416142136273@kernel.org>
In-Reply-To: <179265618778.3290.6590304416142136273@kernel.org>
From: zhilin zou <zhilinz@nebusec.ai>
Date: Thu, 22 Oct 2026 16:04:16 +0800
X-Gm-Features: AclHuK-ttxpk1qZkWA7RJa0y-e5ZRmyvNmGza_feFtiOdaTdxm9Ij-dj8EOUrr8
Message-ID: <CANB6i5zgeY7U+2sjEWjvKxCJBM1vcwYVz_rJP2E6y56wjTxOLA@mail.gmail.com>
Subject: Re: [PATCH net 0/1] xsk: validate fill-ring producer index
To: netdev-bot+sinfo@kernel.org
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, magnus.karlsson@intel.com, 
	maciej.fijalkowski@intel.com, sdf@fomichev.me, davem@davemloft.net, 
	edumazet@kernel.org, pabeni@redhat.com, horms@kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com, 
	vega@nebusec.ai
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 22, 2026 at 4:03=E2=80=AFPM <netdev-bot+sinfo@kernel.org> wrote=
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

Please disregard the mismatch between the cover letter subject and the
patch subject. This was my mistake, and I apologize for the confusion. The
patch subject is the intended one; the patch itself is unchanged.

Best regards,
Zhiling
