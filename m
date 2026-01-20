Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CDFE45BD5D
	for <bpf@vger.kernel.org>; Tue, 20 Jan 2026 18:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768933332; cv=pass; b=MG2DX5ruhd/LLG9+4s8QUxmVVsvi907sWZoKz6Rtcj7zc44V2UbSZUwlKVoaB9n1/XHKg7WLIkcX5akdFZBBwp3mia5tCQNzJq5lps42IgzmptEskYcIw/e27P+uKIb7Sje3y1o3PyZtKPltEeCso11SyMeObNb8oon2oPRm0BY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768933332; c=relaxed/simple;
	bh=ZagQrHQFuN6e2A4tbUmN0iCJ+Oxzcz6Xqi1hSuy4FGA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C0CAjju2FKop3ljE5HEhnYulk2TK43kkv2g0pZ308ZHhbW8kI7ZRq+eqKnYfeqll67OGVZeMTDwIrPU7gQSvzGcRSA8fYo4brFBQinZTkajlQz13SbxXSs0sQErwST5p2izw/XgDavIfVSNYqM3PULSQsxw6YGkR7+bmgRtZ/Xc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=V1twhqfN; arc=pass smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="V1twhqfN"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-8c532d8be8cso533346885a.2
        for <bpf@vger.kernel.org>; Tue, 20 Jan 2026 10:22:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768933329; cv=none;
        d=google.com; s=arc-20240605;
        b=fBHJbUBGnqR0nJz/ih1v8d51x3Qv50+H92JJxXbIGn5Gqr159UpoHvHZBLnQEoVoF3
         K9TqCHHaQ18SjWb8TkRBuOO6yv0f1jozwQzVlZHf7HghWqIqICxK0xLG2DlSjfnMURYk
         S+U8sOmf3rbewNXP/iiPjbIbrN0kHacu+ehIVfITvWN5vtORBtAbAzWf8D294ehZSvPs
         +phNFUj76zpWqUYXQh0O9Nfc3YTKbqUEJwBeDoNn1YPFHxApwlQ9PGZ/VOqrOdosyOth
         1N9YMn/OpxtxyaxQvvrFuzE8o60quCsbsw4pfJ1igc+kdWeSwnw3cayNwIsPOrZ66jI2
         TSeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZagQrHQFuN6e2A4tbUmN0iCJ+Oxzcz6Xqi1hSuy4FGA=;
        fh=ssG+9uY5b4tB8nm2r55FHHemw7IMirSKDjqFzuWyOYM=;
        b=EruO+zc82PFzael8RWDOWpFjTN1oy5W/EnqnOz7XRe5o2JrFZTfeJflEzvK4RPnbXV
         8MU5TbM3k36w6InHFRxFXCQXKgUN8LKRAteXePfBMQVEE0LF12LcCtj4kBg4mTpz5IxN
         Lqri58ckpzwvwtkSrd4fvUd/Q4+iN2CYcyKyVah7bKmNWjbHnMh0WfXyoRZPRIIULP7/
         oXkMFyLEPQSt84SXTcjHug4H+BVCBzvA6wbB1ZW1GyvZCd9Y4JhEsofxAlSwnQ2Mwty6
         H2f57l9zQ210gNrcgWNPmxfTJ38LUEPGvP3GECI/EER6zMxLI+/HQ2ych7GgfCo7FTjE
         nMGg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768933329; x=1769538129; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZagQrHQFuN6e2A4tbUmN0iCJ+Oxzcz6Xqi1hSuy4FGA=;
        b=V1twhqfNQgxIqAL86UhV6eZ5ewl1/+v1oclnw3QqGrQ+4Efb5K5rcNuQwnoPMEk/iM
         MedsZuiGr2botbP8R9adTT78c99XtNZ0e1rcB3fkasa3i8QT+wtFnUypT9PqHmc8Qi1f
         0z555qgfXkq+ft1tx7Ki/WOaJAyQZrqM+Af6/YSYb6fImgkhnSnQPw5dnlYmRDkYunlI
         py5Sj9CvGbgStbZrcTxi/AUJIXJjqoBjCh6//Qls/ZJG9KBuFNTA7+IMHa/W9ksBidi0
         HstoMirl5zMXIwoUKPrDf1arq8oeiNJeXr8KuSIvIlfhKahPRUAPph1w7tsS1pyTcjKm
         b8tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768933329; x=1769538129;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZagQrHQFuN6e2A4tbUmN0iCJ+Oxzcz6Xqi1hSuy4FGA=;
        b=RNe1p8fDzSB4N3kU16xLHH7m30mfqGon4Yon1dYAbnAHmPG/ceU70Y3/aPSBBt3uWc
         J/Thu5fl+bXKTL/5fBpyo1NcX67cpeDEApAs5OaGXnfnGVZ7I2D3DFg46q9D3+NCRFXJ
         oi0p+vC0x2Vmryi7UPmkS22Rvtc8YHM4WdI28tsoIpW01mogxuPJVwZMm/x7T9RIPPfH
         uBXeGLKr+qPmslJSnO4SQfqLVv/T4sek2WP+p3In/esbuchKbh3/z/3hr6jieLVSFls0
         ez+sMR/SO9Q8UaytlUqrtcRQfx5yOcGxVzNQ1h4zBd/by721c7kPlKVEnWZR8gRMzU/4
         Uzjg==
X-Forwarded-Encrypted: i=1; AJvYcCUMNo5oFJTFnK52/YDHF0UBeEo850Zl7Q6wt+yfuMK229xuJuFrObOd4vr3w/YsAUKu6jw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUnyfdP037xn26oPs57tWTcd08hLe9ISJxFsNx4qIfXEJr9kJa
	NCyaB8/TiklFkly8HOzD3jTtEs2VDTLOjEF6QpgXmf1LERfm4VpjoHJ563db79IWYizv4Ptd3fU
	+H5RbQ/DQ9n0XWfvbdBj2EzLadjJ8lLMjDMWAtmIK
X-Gm-Gg: AY/fxX7mQZrAwMoEnZ8zFiEf+2+uYIvwimEAmzdhITxgIfxUZcPTAPLxIG8Wm25z/K+
	Cg/xmYKuCOd96H9RXQiPfc4oFk7spVP5O7LE8PJ+YYJRRiXN0AdQ+EAKL816Mpu38X3e4WW4yTr
	XXJtMktQreMoNUTxo6ESCe8aOJ4IkJgfIkWhVR8DEQCNvrBma1rc6Wabt2FKUekldBf7VA+SR9J
	v0g4w+9a2ajtq6s+2R5x12mp8sbxh1ScKcIQ6aj4h1w3qk+K3yVTm0vayioCSK+Ja/NGS67
X-Received: by 2002:a05:620a:2947:b0:897:56e7:6aa3 with SMTP id
 af79cd13be357-8c6a676db0amr2122139685a.56.1768933328887; Tue, 20 Jan 2026
 10:22:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260119185852.11168-1-chia-yu.chang@nokia-bell-labs.com>
 <20260119185852.11168-11-chia-yu.chang@nokia-bell-labs.com>
 <CANn89i+NEyZ+1R1pouUcroarCfNrQEN01azsEhOuZoeR0Y3mhA@mail.gmail.com> <PAXPR07MB7984E2D22D4337CA97EBB9CBA389A@PAXPR07MB7984.eurprd07.prod.outlook.com>
In-Reply-To: <PAXPR07MB7984E2D22D4337CA97EBB9CBA389A@PAXPR07MB7984.eurprd07.prod.outlook.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 20 Jan 2026 19:21:57 +0100
X-Gm-Features: AZwV_QhBrdPdlMbRCuth_kzLC6UfgC6v0TcEzAFsayFTN8n9oL2sLEky-qL_slw
Message-ID: <CANn89iK5jhfO7B1yZK11bEs4DyF3Wjfr6DUgOt-JMDzEAs+94A@mail.gmail.com>
Subject: Re: [PATCH v9 net-next 10/15] tcp: accecn: unset ECT if receive or
 send ACE=0 in AccECN negotiaion
To: "Chia-Yu Chang (Nokia)" <chia-yu.chang@nokia-bell-labs.com>
Cc: "pabeni@redhat.com" <pabeni@redhat.com>, "parav@nvidia.com" <parav@nvidia.com>, 
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "corbet@lwn.net" <corbet@lwn.net>, 
	"horms@kernel.org" <horms@kernel.org>, "dsahern@kernel.org" <dsahern@kernel.org>, 
	"kuniyu@google.com" <kuniyu@google.com>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "dave.taht@gmail.com" <dave.taht@gmail.com>, 
	"jhs@mojatatu.com" <jhs@mojatatu.com>, "kuba@kernel.org" <kuba@kernel.org>, 
	"stephen@networkplumber.org" <stephen@networkplumber.org>, 
	"xiyou.wangcong@gmail.com" <xiyou.wangcong@gmail.com>, "jiri@resnulli.us" <jiri@resnulli.us>, 
	"davem@davemloft.net" <davem@davemloft.net>, "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, 
	"donald.hunter@gmail.com" <donald.hunter@gmail.com>, "ast@fiberby.net" <ast@fiberby.net>, 
	"liuhangbin@gmail.com" <liuhangbin@gmail.com>, "shuah@kernel.org" <shuah@kernel.org>, 
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, "ij@kernel.org" <ij@kernel.org>, 
	"ncardwell@google.com" <ncardwell@google.com>, 
	"Koen De Schepper (Nokia)" <koen.de_schepper@nokia-bell-labs.com>, 
	"g.white@cablelabs.com" <g.white@cablelabs.com>, 
	"ingemar.s.johansson@ericsson.com" <ingemar.s.johansson@ericsson.com>, 
	"mirja.kuehlewind@ericsson.com" <mirja.kuehlewind@ericsson.com>, cheshire <cheshire@apple.com>, 
	"rs.ietf@gmx.at" <rs.ietf@gmx.at>, 
	"Jason_Livingood@comcast.com" <Jason_Livingood@comcast.com>, Vidhi Goel <vidhi_goel@apple.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 20, 2026 at 7:11=E2=80=AFPM Chia-Yu Chang (Nokia)
<chia-yu.chang@nokia-bell-labs.com> wrote:
>
>
> Hi Eric,
>
> Thanks for the feedback.
> Do you mean sk_listener here is read-only despite there is no const here?

It is not const because we probably need to increment reference counts on i=
t.

But if you have 1000 SYN_RECV, they might share the same listener
socket, and we do not lock the listener socket,
this would not scale very well on servers with 10,000,000 tcp sockets :)

So using any listener-fields to store 'per-syn-recv' information is racy.

>
> Then, could you help to suggest the way please?
> Beacuse for AccECN, here we need to set fail flag after retransmitting SY=
N/ACK > 1 time.

Why not use state in req itself ? (Or tcp_rsk())

> And this was done within tcp_make_synack(), but now move to every place w=
here could retransmit SYN/ACK.
>
> Thanks.
> Chia-Yu
