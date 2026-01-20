Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 543B1421A1A
	for <bpf@vger.kernel.org>; Tue, 20 Jan 2026 11:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768907995; cv=pass; b=RcaSPC6NOWqdFalsqkvw7iOKH/sVKQGT8MeLoKxo0wGz4M9a9Q9sn/EMzlMUmTrlSPKnm+/zEC80s9rjeYetiiqAXdB1yJ2r39MjFhLL4gvvb0fERKEnYkUf0xauhTkU8bKSdijEWFcFj8stBMyuFKpt/5m/+iakDn6xIln91d8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768907995; c=relaxed/simple;
	bh=2SaI+Uz3QGNZurl++WnxVltgVZ/pVYMSpuX7ISsHQbQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gbo5EPAnWnlJ4+fhGuI15duysQr2sUDCvqZ2ucVgpGTYSf7iG4v1297bn0OLkqQhicNkwzi8nH73EKis/8Q2yE9lP3nAxkhOHzi0va0LIYZeSA+qNhSpTXwosegLYKjHqJkbBIAhTZ/kpJ20sx5EDg9Y0db7K1Z3FO1OgxKWYps=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3L+6hw7+; arc=pass smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3L+6hw7+"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-5029aa94f28so39891481cf.1
        for <bpf@vger.kernel.org>; Tue, 20 Jan 2026 03:19:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768907992; cv=none;
        d=google.com; s=arc-20240605;
        b=MAtHoSEIRJ/FucTb2XOlhSKHQ5u2NqNfVNYIvq2LJw2Dw5sRfoGZ74teHOscdssYx0
         ZECdqK3/qQ/kIPC9eRsgHRASggO8IF5Qxm5EkonxDQhJridWtyJ2bSPtzVB+xFUb8+3B
         TSkteTaiudnIDDw5ch5xC+eBHbm9bXtYpix8ZBEe0Z2XKWu/b8KOoLVxPCouE66LJAlc
         9iyBoWwKdMDPtGNEMqJIyP9cwarjbg2KnzSXnEGtR1JWAYRvhID1wJMWQPjWURku11G0
         y/6mKOa8oaKcdIAxRxi2xtV+eQ/ICNp92OiMh40tmjSkxjOnwKu+4O/yqulHJ9Lbun5n
         fT0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VqnDOdzFUDP6Yo0/hl8kW5DFgiqEg80gO7B+GBRDshA=;
        fh=dv1bgSr+FnB/mD6JD/jJzvnhimqCBtj8vRCePgQLQpY=;
        b=atrCejCwZgyaDHvZzFiAPV1Jw6leTZsyx4YeOLYL1UStR+AHnDD9YTdNYtZLfzxa2/
         0XaZ6Oma456b7WYR7FPVwYZCyV69q27fJ9tv6wk19f4vasvAfCjO3uNQdPxaGOwQBOCE
         gbSNn6yUPPpNxb4Is79Y2O8h4IROyRYP30+MfEp/F0blCXSGUcS/jAp+oY98jk5AAiWC
         C60lUICQnsSaNgnuVQP5p9ypHFQWwcxRRw4QBhRSynldiRjp+/CQoHiKaqg9HcDkA5ev
         Qo/NO7ehirQmS0JSosKyyT/6vmsoKeTN8PO8qOqaWJ00u1kA2iVm8mXnAjk1uh50WRq7
         aXCA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768907992; x=1769512792; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VqnDOdzFUDP6Yo0/hl8kW5DFgiqEg80gO7B+GBRDshA=;
        b=3L+6hw7+J/bvuzDos2PmP/fEqPXW6Vv/PafJcFx6vJQWpS2lDQhi9uQtq/88F954o7
         vd6e8kufz3LdVkvcgn5AsHHXaqNSpGEYnePLRl9cSosx1tHx37i2+GEW1svJZz7rbSfg
         MVwdzPKbpeMLnZ9CwwtLryrxZr4mBubNjBBu9KkyZcUeQiBgQ7vfBuHGvQk+C4+1GaAZ
         LxpLlOj40rEyQqWfrEGhYFBEkurwtlBWUERzWK6+uNh11EU4Wso03UFCiB1C8dxESqRi
         9IhG/DqVbR2qB3E232HcKoyLKpS6vbr9KoB07TtGlLQLXYEyzTbgkDL437C6Q+jl+ZKc
         0deA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768907992; x=1769512792;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VqnDOdzFUDP6Yo0/hl8kW5DFgiqEg80gO7B+GBRDshA=;
        b=YpQ6wMaRc3rYAsJY1fQP5/cS0qaqChCtBVqekP18pZky0Ep3FE572eVNkKQHv8zuiw
         YlQ9FnyjmtrCZ8qaYefmi8jBEFPJtMJFicQaIwVqLRZ6dg7vJMy2FpFdqGz7rTEqrYwX
         wVokCiZQyBuUErZUjXTEAkfiMDKUAcjknvcT3rMl6IRT5ofNOne1iu96JW2kiWZkSTnl
         PVNfRI1MbikLnfkjG2nMywincyMiUM/CHFnRqLvAha3Z6rliHJ+OrN5KIIo5M9EdnNet
         bwHvFie/s3u14b0utApgFGCQgBD1F6jn3Gn93LJWUp9PD9GMo4bs3cB0qJ2DkrO1NhPr
         aDLQ==
X-Forwarded-Encrypted: i=1; AJvYcCXH99dcgxT2tsK1/xQZm9sHbxi1DClFHkaU8YQis9gtH2KQWOJL/1Rt/WqiBSeCb1YSXbo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxe6BmSi6C2C/zxIqQtez1dH9pkgxIzGQJU9gii4uDOYRq6xHIZ
	bYjgM3YIzImUWmg4Vl8S+P9ssgXJAoiV9IBRZsEpc3oSipqjoKc9HXVmKML9DFXqtHOxgQcObnL
	Yj9kV81U+JU5KImB+aEa84m29nRI0LScYQ+lSvy7z
X-Gm-Gg: AY/fxX7+MZG8D5si3A3cqLjsZEs/SX3N97+ZrIaHPgQIruYjXQ7L1Y4i4UmD2bqYCsG
	CXnAOTrz8n9cOnFr0VcgwWXMuaI5sp/eAb+xZQdZjX+koQBcWxtU9AJzqawlxwZGUgpascNsNiV
	mfAuWo+SVOdO2/+WjE8a2d0LCjti3DdCCmC8V/BifQvaEgyYgnk0XzypVYwNmUedduFLJ6Bgl3r
	qG5mIjacP2PsMjxE7JpfMggVYN6f0KeyUYYhiOl1Er3BtGinZMxUPOo9Y9ilaKBjw2KTRk=
X-Received: by 2002:ac8:7fd0:0:b0:501:7d6c:2d4e with SMTP id
 d75a77b69052e-5019fafcbc0mr253993531cf.42.1768907991860; Tue, 20 Jan 2026
 03:19:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260119185852.11168-1-chia-yu.chang@nokia-bell-labs.com> <20260119185852.11168-15-chia-yu.chang@nokia-bell-labs.com>
In-Reply-To: <20260119185852.11168-15-chia-yu.chang@nokia-bell-labs.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 20 Jan 2026 12:19:40 +0100
X-Gm-Features: AZwV_QibkXIKRoXdwgvYg4Ojoj32k0JWscBRg_R3cjBAHC3thHUdUCmCY1qsLyM
Message-ID: <CANn89i+fQQvoVhpg3HVh=RerB1tjKi25kGypVh3fwob2HWoH2Q@mail.gmail.com>
Subject: Re: [PATCH v9 net-next 14/15] tcp: accecn: enable AccECN
To: chia-yu.chang@nokia-bell-labs.com
Cc: pabeni@redhat.com, parav@nvidia.com, linux-doc@vger.kernel.org, 
	corbet@lwn.net, horms@kernel.org, dsahern@kernel.org, kuniyu@google.com, 
	bpf@vger.kernel.org, netdev@vger.kernel.org, dave.taht@gmail.com, 
	jhs@mojatatu.com, kuba@kernel.org, stephen@networkplumber.org, 
	xiyou.wangcong@gmail.com, jiri@resnulli.us, davem@davemloft.net, 
	andrew+netdev@lunn.ch, donald.hunter@gmail.com, ast@fiberby.net, 
	liuhangbin@gmail.com, shuah@kernel.org, linux-kselftest@vger.kernel.org, 
	ij@kernel.org, ncardwell@google.com, koen.de_schepper@nokia-bell-labs.com, 
	g.white@cablelabs.com, ingemar.s.johansson@ericsson.com, 
	mirja.kuehlewind@ericsson.com, cheshire@apple.com, rs.ietf@gmx.at, 
	Jason_Livingood@comcast.com, vidhi_goel@apple.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 19, 2026 at 7:59=E2=80=AFPM <chia-yu.chang@nokia-bell-labs.com>=
 wrote:
>
> From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
>
> Enable Accurate ECN negotiation and request for incoming and
> outgoing connection by setting sysctl_tcp_ecn:
>
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D+
> |              |  Highest ECN variant (Accurate ECN, ECN,  |
> |   tcp_ecn    |  or no ECN) to be negotiated & requested  |
> |              +---------------------+---------------------+
> |              | Incoming connection | Outgoing connection |
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D+
> |      0       |        No ECN       |        No ECN       |
> |      1       |         ECN         |         ECN         |
> |      2       |         ECN         |        No ECN       |
> +--------------+---------------------+---------------------+
> |      3       |     Accurate ECN    |     Accurate ECN    |
> |      4       |     Accurate ECN    |         ECN         |
> |      5       |     Accurate ECN    |        No ECN       |
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D+
>
> Refer Documentation/networking/ip-sysctl.rst for more details.
>
> Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> Acked-by: Paolo Abeni <pabeni@redhat.com>
> ---

Reviewed-by: Eric Dumazet <edumazet@google.com>
