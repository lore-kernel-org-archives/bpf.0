Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F592147E6
	for <bpf@vger.kernel.org>; Sun,  1 Feb 2026 10:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769941588; cv=pass; b=c3hL8WyBxWVZQOdr7DgeyUKhX2WLXEWydeVWc1sv0njSWMyZuaBd0DnvSVXI0OFG7Za9yJwdiwqHJxChXnuIFDthHO5hefZubzpGM/Q2bUmqkrXm6h6rbmQyA9aNdusUskZUJGGFG6UIpDJwajEKz1S1lsR4I5AgyMPMtj2dv+4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769941588; c=relaxed/simple;
	bh=amYpk8y7uZ17bXL/jYzc2DIrfTgbEjzT20gzakvuc2s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CPxjWMpZJB4LsTeJ9eJh6evd4vWRflhcMIzqe8xRlHxOAatTfnZktC1haXFAXFOGb4/INsJdlsI/wMnGSserNEkJAy6+ylZC0AywlVAUILzj+N0IDVlYrreInmO7AsSCLu76Qa7hg0hFRB79kktnEGbLZ+BpEIHuf5/w4GIR2P4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tjWXVEIk; arc=pass smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tjWXVEIk"
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-50331ac1fedso44123601cf.0
        for <bpf@vger.kernel.org>; Sun, 01 Feb 2026 02:26:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769941586; cv=none;
        d=google.com; s=arc-20240605;
        b=STfzqG8G2yKao+2c8SZBtuZZ01FrzmpDDQK1G4jOqNFHFdpO8MDInXC63lGnf1GkQ3
         pHjhOhQkt0+JBq3y17woYSni+rGoEUv9LLIGJ46ilIvW4jdQIPoDQfMrowp0SwCZbjH1
         n1I1vWtOMbjljqodEf07lQkMmjubX0/04F+rEUwsMUibmXqrpgcoxOgH7VWuMFr64/OT
         IC8hxk1K1NAAM+1+5/4RcVkTBiJ8VjDixF6nUuAsaOtVsFgkma3Porw4+7RAjUTxM1p/
         MPiqp6C4ykpxaPNuF1ScWODwLZ7TXjUtu9c2jV8imiAAaC1i6+LAbezN8EZNi4yiChyQ
         DOww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=amYpk8y7uZ17bXL/jYzc2DIrfTgbEjzT20gzakvuc2s=;
        fh=/hIyvyVGXg3Dr4pfTeNR0RD5Iuu4kdS4BZq3Kk4tu2Q=;
        b=TUImH3ECrY9BQzvh1xYOnmmca7uHsnydGKUgOrXTuTDZALnowumnG7bjR8a0T/majs
         ZTswfQ9KJG1DpPQaAo+Rs8CR2pdJGtXxXHGt4Czn0r4BKwsodSu8CSQ/V3kP+8hBGznw
         dhpM2ZLXs96vbaPbpWiVkbkDOSkJ7x1JY5kImj7k6yvBTR439Ul9jm+lugUbYxwpQeLw
         GdKfltfnCkx1Kr/bnMA1ndH1+SKLzBEgGeW9Zz/nOM+PHy84NI3vQGnviwWIId5UXQy4
         g7tcJdlwtFGx5WmRKRqoeiQY850TVsjlpyLk+Dqf0QOe6OAyzW/6lwVUFV2wfaA3jOE1
         TfSQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769941586; x=1770546386; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=amYpk8y7uZ17bXL/jYzc2DIrfTgbEjzT20gzakvuc2s=;
        b=tjWXVEIkwuWlA/YmIFxQycJ590x8iPoVszHh0oOmLhIj3YUMioygV1KM3fv92WjZ0F
         SHY5wx3LeG4cozL2PK8A3mbNvXvCenltELpXLUGtNCU+BuBeWX16hGri2tPTrLZ8KhA7
         NY+/rato5A/jMf5EUPWojk+ie8GJKNXyqrNyarsXyGaq2NqyMZOqHH04v9EnZ0d5O50B
         aBN+h5xgvWuY8k0S6atOqamEFKP/lARddKxU0NexaiEf8rzDo8icLpaWWeJvkRgM1ya1
         oitFZWauwURHO+nFbvtOrYPd6O6Bm2LyGhcwmgYMKRtTMt0fjP24A+hYD8DxfWyiDfSn
         bv9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769941586; x=1770546386;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=amYpk8y7uZ17bXL/jYzc2DIrfTgbEjzT20gzakvuc2s=;
        b=YY7uui91URk0lexUXG9naKBxcAlPEF3KaVZqS+ajX5QCRM4LOKMU3z8LUPCCVZ2bEi
         EGbPHnmC1rJsByfMVwjgQ9m4PGEeNklrHGkgP/VW49q7EpmZuUb7wjrpXmTTRU85OFS8
         IV4FHe/UW2wpOR2hYL9x4F/nL4YRctWFODZ7tUYFmBU8o/bvCZI7OSblJR5pCuTN/UuQ
         m7dJ39IimWYn0eagxhB8Ow1J1WLP2i73v+4q/WAkw1yq5iUBuN27ClRDe2JKby/TL9hq
         DZXscWqHK3hUkIP9D/4pyVfbKBLPItVCee6LRPur053P8eF3unORUJ120FTw+DKy3bWb
         Qb3A==
X-Forwarded-Encrypted: i=1; AJvYcCX8KaKumXZ0WjwUUoNVNK503YvgYOLObe4APXbgvQkj18a8TgF7RUKW/COt2oH/PGFekvM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1r5Q8Rxqci4SbElX8eXuKVPXFe1NQDQ/m9kcFuUXBYMoP1kmu
	HcqqUjp6hPoA2m/K8YkZs+fWwHwxBbAvwNrDwffESyUP2EM3k5zaFPvHlgbIazeAhvJ0aqqjoIJ
	RRwCn9BihSs98F2DJfKSbi1C9LxlxQ2jaavvMC1MM
X-Gm-Gg: AZuq6aI1zNwgCbuebuhfuu00ZauvbpRkrVkq8oY3I+Cik5lCYPCK2ra8mkBAyfgBO2o
	BB7uU/+YjQxxtTATmLRuSxAQc6ppyPyATgRqcxPfbk5+PAdzCzQ24TDoj2FRpgTqpXPd9BqgEqK
	4p9hZDMXzZGaOtaBjOaUwhPLIIkCvZGTCU6u3x0e9tnoXFP4HDKdU184fh7Rh4G4nBLY75Qz98B
	uERsLWlIi7+YqX4pt0vkd+n1gDcRffvBrjnWdbYkURmyVnAfyfkb9oILeVpYo2KH8Mfwj0=
X-Received: by 2002:a05:622a:1aa9:b0:501:3c88:131 with SMTP id
 d75a77b69052e-505d219e7aemr108573901cf.22.1769941585616; Sun, 01 Feb 2026
 02:26:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260131222515.8485-1-chia-yu.chang@nokia-bell-labs.com> <20260131222515.8485-16-chia-yu.chang@nokia-bell-labs.com>
In-Reply-To: <20260131222515.8485-16-chia-yu.chang@nokia-bell-labs.com>
From: Eric Dumazet <edumazet@google.com>
Date: Sun, 1 Feb 2026 11:26:14 +0100
X-Gm-Features: AZwV_Qi7N4AZtgtvbxnXQyIYVraEeuRtL1qe-JczyTuupqULFqmqcdCuYubvvbo
Message-ID: <CANn89i+F8Hmx3-DoOBcW_tJnsyqeeKHZm+_jC1nk5hrnBWN2Jg@mail.gmail.com>
Subject: Re: [PATCH v13 net-next 15/15] selftests/net: packetdrill: add TCP
 Accurate ECN cases
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

On Sat, Jan 31, 2026 at 11:26=E2=80=AFPM <chia-yu.chang@nokia-bell-labs.com=
> wrote:
>
> From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
>
> Linux Accurate ECN test sets using ACE counters and AccECN options to
> cover several scenarios: Connection teardown, different ACK conditions,
> counter wrapping, SACK space grabbing, fallback schemes, negotiation
> retransmission/reorder/loss, AccECN option drop/loss, different
> handshake reflectors, data with marking, and different sysctl values.
>
> The packetdrill used is commit cbe405666c9c8698ac1e72f5e8ffc551216dfa56
> of repo: https://github.com/minuscat/packetdrill/tree/upstream_accecn.
> And corresponding patches are sent to google/packetdrill email list.
>
> Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> Co-developed-by: Ilpo J=C3=A4rvinen <ij@kernel.org>
> Signed-off-by: Ilpo J=C3=A4rvinen <ij@kernel.org>
> Co-developed-by: Neal Cardwell <ncardwell@google.com>
> Signed-off-by: Neal Cardwell <ncardwell@google.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>
