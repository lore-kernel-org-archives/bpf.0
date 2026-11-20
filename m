Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.181
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795190729;
	b=ms3wT+BZdcWc8FCHOM1mLkDh6D2AI+PKn7vZYSTPo+hqOQE/UbiXrzh4tb/8kxxKoKZE
	 ybYNT0NEzNyqeRuVAqfYcIe20Vtj4tX/9x9URve6GOdKPtGtto0aJfBUbpYB3k2e2UUHz
	 gquhc1509nW1+O8aY4/G89i0K/tAAbG6ID3ieDfBBn6fY9McUqEhog8dVQZfTspT+5Oqe
	 yIatrw5bQXRYq8/qyZxYuztbcfi3gdZxnhUbcjwMLCTSPY5jViCB0/e0Sm3cdztzchfmk
	 eQTZxweQpYiHBCGc3LwOzI9KDZUTgljX96lNkQNpIrdOYlCFg2hOg5j1ef4fMnlWY0Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795190729;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=D5qRI4h4vBd2n5ugHmd5LfCCF82oMGWtSg5RhJQE2Qw=;
	b=CgyYpdxyV9Cyv9quaHDt4BI6UlprjS+Vin3cE8wwh7c4VcQIoNd9VIyWnsfhNFJpD+lp
	 w5bGyOlBMcX/Z1JkkPIEeoAG+sqEUSB/Ucko8NUwLzMdmNa0R+lNHvvWPTLuyKgw4R5Ck
	 2aYwwbdjE3KW50uKUGI8dtPsW5aJEb0ai29re7ccjzVfRMZpRoYVpEgGI2o9uauX9s3SF
	 DkrQUtUhzdymKWsF8un19EoL8DLBTvfFC/lpA8blm7XD3gEuutHOHDtIWuBkHduhjXDNA
	 1DeiWDgdwVDgorXgvti71mzKh/1sfzKeoyJkzmwqGZaZhNYZvOqCOpbTEBSwgPaSQrg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=K6Nn0dYI;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.181
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D05DC606A332
	for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 16:05:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D05DC606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=K6Nn0dYI
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-8b360828905so9195297b3.2
        for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 08:05:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795190728; cv=none;
        d=google.com; s=arc-20260327;
        b=Abyg8iak3Zsz/vcSuiNCWHu1i3tpJJ9jRjrr/OYBuWNKVWYoSFsN0NIR+jQlGi5e7O
         eT53h/kTiPTSnFFb6G9K/o9ZotMAWZTrkSJkFkGbnOai+ltLHKbucEdU5WW7i2SxYnNW
         fLFlpn6fnaZAxn4LeDFPSGvGVub7gYNK8MrwZLGCA3rS3+uV2Xf9tlpfnm9R7mAjWVvt
         kVaeMS3kWzxmCBfFzcE90XIj2pVZXJMn+7v0ffGOEljP7FvUSOBgYtYnxY8rbo3w2x8o
         13Gz1ZyYoaWC9dX0L3LkXFc7m2QVjgcA75v0dccdhcCQaey7EApqkZam1sHRGi+5/f2w
         QnQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=D5qRI4h4vBd2n5ugHmd5LfCCF82oMGWtSg5RhJQE2Qw=;
        fh=WFabqLKPIAMwTAA4MFTYfQpuo4wiLGeD7rNNaYzp3w8=;
        b=GQtMmn8RWai1bXgh4QK1s9gVZSIe/XKyBRat3Sbb9vDyzap8V9SRWjwgU/QR8aMszy
         zHZH+1asa52NJ1ovYbEMfBpnskCG3OysCThBFGbScN+RJssdx7m7PKIosexZTFL4ngNG
         b78CK0UqU03fbn43x5wVsytOBJ/V+GmAiDJMp6P8IrhhVOFn8t54zuwlSNkbyNHajy1U
         ZmBwpsYxN964I/Lw6cFrIlqVPuYR6XRz1PGYW9TauHj6S1fiHxPXXlTJB2sMOT981ry7
         9peJnyTlTEkpw72G8svNEbWR2wM9rpJ2/mzxTOvIN02+LYR15KH7OrsXSAFspIPsmwWH
         rgag==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1795190728; x=1795795528; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=D5qRI4h4vBd2n5ugHmd5LfCCF82oMGWtSg5RhJQE2Qw=;
        b=K6Nn0dYIebQ5u8bEJ1qwH/Xj1OSc/jWHWSxf/kAmX7N/lz6XVvlCxcaj0RLD/vLojt
         7EBsCoFW2xYaaJqwRxsQDtO51IXyz6cV6SWmrutsRBazzRiom8lRBUdiemPWWRgNqVrS
         NCPUrTrjo9bj4jkIGtSTAw3akvQcYdHFPM5BA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795190728; x=1795795528;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=D5qRI4h4vBd2n5ugHmd5LfCCF82oMGWtSg5RhJQE2Qw=;
        b=Azn/9s278oxyLf5DTK3bSZO5L/CZYQ8v5Gj7Zky78uD1GWaaUAdjvNwmTizAazwmmy
         TO8aUwqt/gyFgSjiSW7cWqUatOX4Vq6vdj2ioNqcGUNU+kAa/cf+0K0aqOMZNcuN2aF0
         zn4AXR0tIgYU17ojRkuERtKdmH5FCJbOYIIP4PNZ2j01WzsJe9ljg86P2b0e/rUIVB5a
         X9P0cvO66j2kDkkPRgmeYwIWRxaOvTxR3B0O0db4TPKWI3ny34KSRsTglkHuIHw+jZeH
         DqSuctVZe7pMtnMno56CfX1fPw/FTEhtPOBfGA5mc7BK2djyDPAfIfPre52L7sbzZmhV
         h1vg==
X-Forwarded-Encrypted: i=1; AL+hErFYwoRDz1ICQZRBA83LbNZYVF9CwHIzlENM59UbYA6J2aGZMFnlO0JN92vnOOHuOWR9Prs=@vger.kernel.org
X-Gm-Message-State: APuU4Z/qkvwuDsQtBgDg6acEvzo2Rs1Bm+rhLLyEYZ9FhZqm6YBvJk6u
	SWR/4Ky8ToHUl8dNolp9ZAcH/quQvLRT2oTqwj5anX3RM+EFz3ko7z5IpHxaS3lzxb3JnMUuqK8
	5I5UrTPsCgdMwb+cGaNtCg5auNGJRCBLXIXtNJR4P
X-Gm-Gg: AZFdTZc30Jl/gexibrMOlSXM1dcwNaXxYyq4OSaFkPsbmVqG1g2L0DWbDatgYcmYR5m
	0GEIZVGGiwye7emHURrbdGyqVipOnK2bp040T/Ru5HcKvFxAvFibwhDqFykcl5/mHi6+2iT5RmO
	wT5oEP0VGdFfNIuDUFJepM7E7axfKPpOIVllNQpG7ucArjy73TXKHHC0ge/ikzIPnESyMrGI/Iy
	rJM4Ma0TV508kJlx00tTy23rX8pNu0obggmy0xXCZoYqQIdKR44U1Cx0kvmkBb5jhi3B/Dg/IS7
	GoxcnwabgRJoXwnG+aGD7ljvT/TI9zK20JylUe4b8ntTio/EJ6+VUD81gO8+PZGqlPH1B/vTBpz
	dYPKxAIazX2RSKiQC07hANmDzgW0yF1F72BS+h7w24hqjistkNWDsCyOpkVTC1unD8C+LPHiROX
	vJWFAEfjvRLN6JIoWsoy76
X-Received: by 2002:a05:690c:4a09:b0:8b4:d1d3:36b1 with SMTP id
 00721157ae682-8b52031c312mr14043177b3.3.1795190727625; Fri, 20 Nov 2026
 08:05:27 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <CORE-J9UK.v1.r0.20261120103344@mojatatu.com> <179518966319.3291.5653366565460355407@kernel.org>
In-Reply-To: <179518966319.3291.5653366565460355407@kernel.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Fri, 20 Nov 2026 11:05:14 -0500
X-Gm-Features: Aa3M54o0Ta4AC0N37lo8mG_wIU7T1CO3mQnLv3LZLQgqwYQpH6Oxq6D75p0ceNg
Message-ID: <CAM0EoMkqsLHFfthUzA4cD4XLH_bSs6nA+Rf0_4+j7m07wZOu-w@mail.gmail.com>
Subject: Re: [PATCH net-next 0/1] net: neighbour: skip the stale dst lookup
 for a redirected skb
To: netdev-bot+sinfo@kernel.org
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Jiri Pirko <jiri@resnulli.us>, Victor Nogueira <victor@mojatatu.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 20, 2026 at 10:47=E2=80=AFAM <netdev-bot+sinfo@kernel.org> wrot=
e:
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

It is a followup of the thread listed on the cover letter. The
original thread is derived from a sashiko followup of "pre-existing
bug"

cheers,
jamal

> Please do not repost the series just to address the above. Instead,
> reply to this email with the missing information, so that reviewers
> can take it into account.
>
> *IMPORTANT*: If you do repost (for other reasons) - please include
> the relevant info in the cover letter or commit messages.
> --
> The evaluation is done by an LLM so it may be wrong, if you think
> that is the case please reply and explain.
