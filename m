Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF607345CA3
	for <bpf@vger.kernel.org>; Tue, 20 Jan 2026 10:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768904556; cv=pass; b=W/K4JfAbFBAhQolEgDK3WG1K2xiZ6JNoiYkulng+A5KQrpBp9Afdp8dDBHj6kDIFVleb5qzP1DX+2NRkn2BpLff9VakZmbcAUMZ60RHtNcJYBgB2WbnXSaQge1SzskywAucU5H88wDQcvXIGvPOR3iXVrRl6NzTYHGbOZAYwXhg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768904556; c=relaxed/simple;
	bh=5w2+VNa2XcFV0uZ0AA/PoYuG7MXZPHrIK5lfvnq3r0c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d7XlMeQI6evYcesOj+WesQ2Gx2RnoWbRbrj71Cg7J+Jwqih2MjfI6a0+72luFlmjjkYq6p0oubCOjN1oQFsCPPHRbUrOz74pvfJAZVP5v7DgtcjOlIO9fW5OT0TrPPmWgCvrQLAQt1/qiFfCJF6AHDmjhas+Ic58keupy7XaV9Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BVH0iemt; arc=pass smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BVH0iemt"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-5029fb0b977so36681271cf.0
        for <bpf@vger.kernel.org>; Tue, 20 Jan 2026 02:22:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768904553; cv=none;
        d=google.com; s=arc-20240605;
        b=T4q+ASumGYFyZ+tG43dd+g8MoZaLx52jaww8G4Ku1fntdX3gzCxcGDf5ewIjzWyGUl
         PxC+6HyG2X6wpPXnZwJ+m4Q+71tKYrjEDtYJbWRSeXdzpBfM2OnXUedLeokvHeP3ben8
         JApVOMu9b0UcgsNXZaYLzc5DVa4BkZeWEGwIDjLtTdIgLqHgvZk8U/ruyei0ZlWLhij+
         rqGZ3pDExRr9FS9TICCiGu9kamTF926Lwwp9P/JhxVAQUP17ltMf3GJSbW51Z88XscAf
         KvX03EQFhTKgjKh4Qyk4ISAzJYmArwzBihHALf0wmBmjBec7o7tWu7SL4bkT9dL7xIyy
         0GKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5w2+VNa2XcFV0uZ0AA/PoYuG7MXZPHrIK5lfvnq3r0c=;
        fh=MYp1BXL6H3PIaWc6KVYHKgzRt0dqT3STuTuwymzPO38=;
        b=IMpUYhm/4yja13PoFxQfFr7HXqnwPUbI6N0qzHkaeBfPfzqQOuJAYIFiQtfMfVemzM
         T34EVRg82RPWm0htWcQkKBwviHZTqdE5B8Ly+gTSnf2IZ74P4FZYk4gCPWVwxVa+uqAX
         2og9aoUxtkMtLWfG9LXU3zLd5gbn5egTqgfqYb/j1FKi7Szmtu1H5rShDsqVz2GycpLC
         jaeI3wBpFRm8QHf0ZOVFc5WsZmbR9O+FDe886HrHhhGZz1D0PWvj68WFLYO2vJv/sj15
         GdSJQ+Z984rCeUpMGuKoDBg55QAN1OWUrXRfArhyiF8fGS+cJsbRTicMyxgKAVxKeTja
         /rkw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768904553; x=1769509353; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5w2+VNa2XcFV0uZ0AA/PoYuG7MXZPHrIK5lfvnq3r0c=;
        b=BVH0iemtJXKgFzcspkojUU8TuSs21rpLoDur2zzJ922EnIgWrkLaRMp0B9iuSoktNz
         5khK03tz7j7PR5kUv2f2CyTtzux3YZlaF5IHhlZ5DXMbV81KSbPJC99Eqlpk1RAFtCX1
         kcgM+g1EuR3S1b9x62NLLLBHhV7l5ORtqmC8YWruZ5CW30RV1vxOD7/nagZH4UIyLHGi
         YSWeK48Q3xFjL/2JjJpn+NjaEeggPzhKQy1pmtns8mcq5b2RM9ONHdWaB8hceS2Yvc0B
         c9kotr6V+LvrwRvSfFWeLTyNXlGEM/3lI/7canEuRoqj+bHKm0ZXuIq2Q8s102nxLK3U
         qSJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768904553; x=1769509353;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5w2+VNa2XcFV0uZ0AA/PoYuG7MXZPHrIK5lfvnq3r0c=;
        b=dfsjCtyp8eo2pXQZZuYtf2t2GsbNcPQcRS890He9jk3WWzj51IOq4FQ9ta7BUXkIVs
         1R8eglnw+YQQgLO8zTkP34dkWuAa3FRDGuUuyKLLRuJdyHAS3FCVlJdS8cUUGXNT201v
         w5V7Y4hjuGADUom4faqoRpOrTcRYkDo8E8yycaTWzFKmKlKLQ7JhrRmjdMCNUlrLy+lP
         J4/XUWHg5bDVUx9Ro25dCJxgb0agaBmNkIAtqH78yWSe2ZuS6cFUctWGS4/LnTPMamrl
         hN3G/9hzh7jFnmrNjS25Qppb0OptHmKjycahc/TNj5EjcaYhClzwIPmKz3LP/rtFPEqy
         Oxew==
X-Forwarded-Encrypted: i=1; AJvYcCWZSYdCZCvAxaD4XJ5IToSyGoS/PaKl3Nfr9F+PjJqzeH04oZkcydFCL8qPz27+KXtx2pQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDGW2LI5C7KfwQDcAfhp346SkoJoomwRlU00g6hV7AjLggf9dR
	oBWdPgl9RPd02g3SjSz8slGAUjGNzmDc8bfywdzWL8r0yoxVSopV7K3sqsRRKTsXJwjj//n9k/t
	Xv908vSxE/vHNxd7burqDHYAHmgd40zeLSiE0c+9f
X-Gm-Gg: AY/fxX7Q06k08ltUeN0DVQQcsNKlxBzU7lHNq0q+0CeIakkvZykSJYwKgXzUYm2ClLW
	kjwzy8QJhTGUOlmGqRgB4pSec+yHEV51vBlQYxGQMczUpAAxOnbvtnmolrbEuqDdgqnS8RunoB9
	4+qoffgMftGtwLLp4Bn1Lz9AKAcspFiGHqySXv0/Q82Ycb+q+V1U6yT9OnQ2RgzPdeETqE8o3d3
	HQdHzM2oYIIli0+jUcQIsM3J6zqymr+8vaUZdh4lhE9KHCrPSS4euag3U2pj5EHMtnakEQ=
X-Received: by 2002:ac8:7dc3:0:b0:4e8:af8a:f951 with SMTP id
 d75a77b69052e-502a17de1edmr195650251cf.83.1768904552249; Tue, 20 Jan 2026
 02:22:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260119185852.11168-1-chia-yu.chang@nokia-bell-labs.com> <20260119185852.11168-8-chia-yu.chang@nokia-bell-labs.com>
In-Reply-To: <20260119185852.11168-8-chia-yu.chang@nokia-bell-labs.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 20 Jan 2026 11:22:20 +0100
X-Gm-Features: AZwV_Qj6HtGAH-_1CoFAtwz8z7DAfNNNRGDqqnAwXby63-7-acE9435g0aUmmD4
Message-ID: <CANn89iKKQH=moYMied14AHrsDTOKK0pM4kVQHdh1FS4WcnU7ww@mail.gmail.com>
Subject: Re: [PATCH v9 net-next 07/15] tcp: accecn: retransmit downgraded SYN
 in AccECN negotiation
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
> Based on AccECN spec (RFC9768), if the sender of an AccECN SYN
> (the TCP Client) times out before receiving the SYN/ACK, it SHOULD
> attempt to negotiate the use of AccECN at least one more time by
> continuing to set all three TCP ECN flags (AE,CWR,ECE) =3D (1,1,1) on
> the first retransmitted SYN (using the usual retransmission time-outs).
>
> If this first retransmission also fails to be acknowledged, in
> deployment scenarios where AccECN path traversal might be problematic,
> the TCP Client SHOULD send subsequent retransmissions of the SYN with
> the three TCP-ECN flags cleared (AE,CWR,ECE) =3D (0,0,0).
>
> Signed-off-by: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> Acked-by: Paolo Abeni <pabeni@redhat.com>
>

Please amend the changelog to give the RFC precise relevant chapter
(3.1.4.1 if I am not mistaken)

Reviewed-by: Eric Dumazet <edumazet@google.com>
