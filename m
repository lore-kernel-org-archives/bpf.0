Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 954673E9F95
	for <bpf@vger.kernel.org>; Tue, 20 Jan 2026 10:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768904734; cv=pass; b=fNKww56wRIu7EqquIIEPiTr/3plQbZyxdBxo/24mtZlKIe+6hcSlF+3HXzDGy/ZfQt56iozcvVQz0/wTmoLvLa1M9okedtb5kXTUZsMAmNevR4+doj5xi4FX4nJjFY7XFzGPWI3D6J1cDHwPL/DxY7eERnjeRa7aKTPNk5hyjyo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768904734; c=relaxed/simple;
	bh=wjJ+Nws351Qs1zaYiW8MF562GhG0txIVy0NZYF2vpvo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VF33YK664SSwJ1kB1VIJH6l39A7j0IixAe+FG0ALfnbK6/v5MeczJ7PT1RZ5Y9mJ4dCa0Wa5zss6HXX8H8XKHdXoismpv8p0OMvJI0TdRHAzFnb5UBXVj/kAO1mGoGzZWnet1sw11wKtpwmiOKn3S2sJmiZL7v4gW+DBnSLqKIE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0MLoa5g2; arc=pass smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0MLoa5g2"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-8c53421cdbfso501195485a.0
        for <bpf@vger.kernel.org>; Tue, 20 Jan 2026 02:25:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768904730; cv=none;
        d=google.com; s=arc-20240605;
        b=QBTeJVPI9o0cOha7fCbmRk+BS07q6v3xvWL42MUGkTgUxoyZqMLPAUeyL41xo5J3Mo
         8xIK77eB6dP62AhP9P3oiZp6GYpyayMOnohUrp4qp7sk75SwzfW1Im4pN0S8VmlFq4ML
         9t7k7WSpKI7d/YR2sbLsSmzYQ2K7S9gta+U+05Ip2gtPszYWFmPAvwzaqCeA+RFHTbS2
         zFQXIE+hwqLBh4Ok8GWmdCxeVh1GIjyzpSiu/ODhpiBXGonO0jTKoVBsON+qG634yfmu
         3yh+G+6fFgIWS0QjQeTij+tVEgOasYyQT/I8pKFtUmjNsVOxtPcai3NSrquc+QmWS3BO
         o3ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wjJ+Nws351Qs1zaYiW8MF562GhG0txIVy0NZYF2vpvo=;
        fh=cgf6c9gNxf09pNRlQyqHeCw1b7JGfK26I0qX/bxHI34=;
        b=fKplKgD8dfGSwJtsRKSulXM11IyHjIhWSUEsQxHXAKsXHwdpu2wadmU4d036ApbE/r
         spPy72LZy4ORkE95AHjsTWuGRP0yefp1e/A/323KpFP0m5ZOMzLmdVObgDvRoqNTvQtp
         8uTBZOJXhWY0iGRS0eUeyzYgOOZtG/1cpCm6R3gxeGcGwvX5ZJ7Pk0Tfue4R9CPG0fFz
         BXgAvshqMoIZ0z+3QgY7nrhRuE8xrVv5V9J4BTZZUJ5DP2l6lmw1dNr3X1D/HZoU7zVe
         HA+V2ShcTXx2BHi8+kgnZVeN1QmH+eEzjqKR6R9si8XAfP1x3aH05M0RnaOc9ViApnAI
         JtAQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768904730; x=1769509530; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wjJ+Nws351Qs1zaYiW8MF562GhG0txIVy0NZYF2vpvo=;
        b=0MLoa5g2PfCyeo+1/vEDpd8wWDjQmTPWqQUdJjSPPpiq7qmcmGeDLKE/WzgLwrpKAQ
         3ymVQTGSykLqPZ6elyTjQFZO0QMIK5Xyd259NJ8hEgd4CPlKptQHqihhy/L3sEkKQ3pP
         fBoA7vUHQi9bE3vArS9v/adTBoCvpwPN0OPuQyehyEEumx/mmDbYCoIeEn0EsmTTLTMX
         bOZGsy/sR94ywAORlTNcYl0C1ZNMTqrulnEney6DmlSEo6auplShGYvW3x091LJS1S2R
         11IWC8b7mArisAW38h4Db0zJfR7fPWguUT+qkHzJ+/f63kuyDkqxkaNFJWGJxJZtI7rU
         Uqeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768904730; x=1769509530;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wjJ+Nws351Qs1zaYiW8MF562GhG0txIVy0NZYF2vpvo=;
        b=vAl/ecIvqaFrv3YpmOgQMXFyhHALmwTuDakwL94RNue/iNAD1BEbqOBJ81zC5Tx2yu
         KfwZgKIdBxkALXYAU03AvLi4fgUjKx4/hOyCFnI9KQBhRngG01GFjRJLBPnULqLYJ6ZT
         K7blnCzDFO7GmCeyDrSxelnmSemvX51tI/z/RD0bwhu4TEb+sdt6W1v50ECV67m9x/0e
         B9BCfNmhv+ylnQdFPY07PRVjFx3uW2dnDaFSWx+TPuOlsxBJv7t9CwfsYj6G3xoxQWKe
         uDNcY7kiICkr5IQ8DYkRQGVIulHNmmXam6XtyzUQ9zfhMS7Sntqsf1Plrfq6Ef4Sse5W
         csUg==
X-Forwarded-Encrypted: i=1; AJvYcCUcElBmgFhYogrLf7TQjaIRwHMNETLH8poH/4LPBMPLDgvl5dnNR3U2rDHDNlSLJCoVAhw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQVD/a1FHOUFlqFA3WYqLnoF2BiO08Y7rNoI7BasQbsnvUkvnn
	nPzfV3GLs8fxYZ84B/jyOXFREQrve95q9LXW0WHQaIUUS8OLrMIzKAhcv86s1+vAlsu7pSOkNEH
	R6xOyUPdZlygMY/uJw+oXHdQb4Xyw2DxZ/LS1jAny
X-Gm-Gg: AY/fxX5gDiHZ836NGFoFHuzLYw13yBOzyhIBNzmZwWLELe4oYB3g8kpMgPcow7FB3NO
	3wido2OiOPjyWjvt2+gglV4OVoR1moEFwF/oQOYzQyBKhIkY4PIGTci37SDCxmpTuJTRVAtgJH1
	GoBV+fDaJHoT8JAOYbWm8Ij5gPLTFc+22M9BlTi871xzvnQZhtJU0QJMa4eRZI9OBv/is9KCjRA
	Cfz4FfljeiAUOi46DirpS/X7KkzyfrsbCqOuB+L5dxkSSqJIFkbzrv2tQ6UpJwQ0Wa5fNg+SNm2
	J6wbQw==
X-Received: by 2002:ac8:5d4e:0:b0:4ee:1c81:b1d1 with SMTP id
 d75a77b69052e-502d84d36e8mr12347611cf.22.1768904730033; Tue, 20 Jan 2026
 02:25:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260119185852.11168-1-chia-yu.chang@nokia-bell-labs.com> <20260119185852.11168-9-chia-yu.chang@nokia-bell-labs.com>
In-Reply-To: <20260119185852.11168-9-chia-yu.chang@nokia-bell-labs.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 20 Jan 2026 11:25:18 +0100
X-Gm-Features: AZwV_QhXZCQk1XE-q39P2gd1Nz-BCTJZ9hlSkcwUiVU-61knB_BOINgx5AQZsrs
Message-ID: <CANn89i+6KjPh916bSTJ96=mDtR8d4kQ4LNs5eqfJHZnRGMx1bQ@mail.gmail.com>
Subject: Re: [PATCH v9 net-next 08/15] tcp: add TCP_SYNACK_RETRANS synack_type
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
> Before this patch, retransmitted SYN/ACK did not have a specific synack_t=
ype;
> however, the upcoming patch needs to distinguish between retransmitted an=
d
> non-retransmitted SYN/ACK for AccECN negotiation to transmit the fallback
> SYN/ACK during AccECN negotiation. Therefore, this patch introduces a new
> synack_type (TCP_SYNACK_RETRANS).
>
> Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> Acked-by: Paolo Abeni <pabeni@redhat.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>
