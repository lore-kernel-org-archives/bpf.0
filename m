Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 139AE1F099C
	for <bpf@vger.kernel.org>; Sat, 13 Jun 2026 21:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781387044; cv=pass; b=F5rkBMqt3+xFm6ONJ1ZQoKB3dMFTV6h8Dv0re+d4Fh8CeG6Z9H4Hqak5lNQbYm7pLHmQxY+ykf6gZRlcfya5NmRYfxQDJeCQNouAsuyQyZcyH+9bQ0SLtWik3RYubO87L+RTk03OugZ9tqNC4adUSGHEqY9BT/sY8onfjF/dg2c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781387044; c=relaxed/simple;
	bh=shGqwXIT/9k1CTZiY7lQbAjqDdaUMQMO41xsdAlkuHk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b4NDZ2bIDt6OFPneYn8BiWpdAmpDAvGdxGHn6sO/Nj7py7kNnDkfIKidvBrnbpv7EIbogw/vHZ4f0z+8Bx7Tvl2ZMJoPQ09e6/+yQa5mcbN+IBMX1OYg7vGx8kP/976dpxrQH95e/kpoXIcc0bIdpl3i6C9VrGVruDSL9+i1gLI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Yn5cGcaX; arc=pass smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Yn5cGcaX"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6914a658115so2632166a12.0
        for <bpf@vger.kernel.org>; Sat, 13 Jun 2026 14:44:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781387040; cv=none;
        d=google.com; s=arc-20240605;
        b=lNFx3jl8dl1/Q7CPPijcWtUgX+1pznCZkvcL1/JLSd0zXCO9e7RrPDMSsmsbnbA0xY
         lSvt8DKfoQGRVlrL+T8OKvAmmTMden+NbMjhodmmxecPmf8FNN1t1J+Vi3dVo8AjF7Xd
         ARB2Z/VMUwFdra5lIS9z3lXmvQLz0GoqbSkr/pakLl/YVjWJRRbzMyx7ZotzD3iiDta1
         2W1//6kFBfPFfYOEBRmVKmIJQnNNjZ6rKoF9vy/smSW40T+bXrItnKeqbRbdyhyvyzaQ
         sX/bIOD7DDmVScMow0UUX3I65RenGcAHGih4w+xo4PkO9wdAh25IFxLNTq0mb1Xk32tO
         65rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QzdEIs8IbYBJwlFunPACllXp2t7V7kjH0qnCjgXYRcg=;
        fh=8OFWPgbFS/cAac3Qfaw1hp4Reojld9FM0k1oYfwaADU=;
        b=Z2RZEnhYrxDwk9DVYWoiZRnH7HqXNdLzHfO+dA3P9GICqjezLMnWOePX9fKKFLL8UZ
         ndeMjQshCSWiJr9ZI9ErzLPKxr2ofYMsoHuaqNkzSlbQqJP5Bt5VYUsPyqwOPZgsuyq/
         5RXmDJyEZCZqlozyIOSBMQ9acublARppiVzJFoU5E6fNRbE75O+9X3luNM0nN5Mvp0p/
         e1E5x1052RyCGLoNzSH9fJqrIgjm+G+5yncPvdoMCc1yKt8Bucj38de1YXLlY/AmYRfi
         GYDVJCjhdgz2j+byhM2/N0wQzKPx5DLXHc6G28/VxF4jRN9/xsQSrvVz7hFxggD45Qmw
         TwwQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781387040; x=1781991840; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QzdEIs8IbYBJwlFunPACllXp2t7V7kjH0qnCjgXYRcg=;
        b=Yn5cGcaXeR3/B/k5z0AVfO6kbuIVcEeLXkkjZ7Q1lrooW6yLC4Z1opSA8qcKhQex0f
         2+uN22TcHYOZ3lV9bCb+y7VVrVnxbODatgwAZfGduna5IbXKU3fFWIIudwJHuJtt4pJo
         MDIgxo6ocNeKn8lerymXf1Sbqv9ur0VR4Q92lLw8w3HkX56IPBEhjoskNB2SZdveWWq3
         grGuIlT+mBS5yHM6UNIBTrLPpX167zIGi1J9zfPv077li51jgnK7loL2vDCGQXY+LukY
         RaLaKDNMKO5alLFnn+uK/trCXOX9tLqnsv2bOuY8kMbc7LtTEAaXA0RbBV5VhnaYxOKf
         e0hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781387040; x=1781991840;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QzdEIs8IbYBJwlFunPACllXp2t7V7kjH0qnCjgXYRcg=;
        b=Od/0mlhnqhietMYKgWz4Z+rvZgOX6gLAG648xBb09oLCmMsp5cWSGu20DpvJdQr00z
         E/owpWy9dw2MqGGIRHd5zCB7aV7QbrdiO3Hn1tzP5SR/ADVkK/EIGYyZ81ChYW0oF6Hh
         DCElNrqRPk+YnsY7c0IXtk2O67D0OSXkoBI53N1sGiEHg8W9ObtsCiiwVKBT6ITTIQwI
         aej9YxCjSKvrF3VrK4XkTfyMPBRR0oNv2c07IbLNrwyCtsZul65jqlCIKSiLoI1dZS0q
         clcbGCcqr+90yZg2NIDHrwpgtI+bfqHJHFt2HWbFpbx3Hmg4ilPWI/hxA6MrNE3DULeq
         KhWw==
X-Forwarded-Encrypted: i=1; AFNElJ8bfUJWSr553C3Jys4OzeP9jeb+lMWgQFtRG7/NhKvdfw59dazh9htGelCTGERpWDhCdIM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjjxhxxalxqpMh+VvMWgDU+6xkzxrYhD+ZdJMZE855jMILvkK9
	U6ZkTW8Uxdpoy5N+VTiZiTvZqgRcyU1W9u5CcpSY6KxycHWQxbXWI9itAxj3YYvi8Kqu4TTVIsL
	UTiamtzn8OqAiEnYGJ1LdumGuNangnn3vag9ex1Vr
X-Gm-Gg: Acq92OEinWDDANDj+c4U5XPMrL6ig7uLvwS2Uq0j4gUkiE21JR6KNH1l8cHgbks5ue1
	uKS22axVZ59j39fW0/gEd+nKSe+fj7ALQ2Su6Orf6oKj2qoelBfWVrmACD97SrgyDFJNfqlFobZ
	4kfbPIQrnzw5mViIu9TpRi4caPg/kOUirgeZyBtDaKG32FYsKHQ2IJnJ1Kd6uuN0cklLnkmiWs5
	tJl0ANXWT3mT1n5aQ+0hD4YtvOEA0SbA+P0Weakhl4uuCISBDNE9X/pxa7ArjH9BtRAZeYcR9DE
	UrFTdmsL/RRSDJsOeSqph1ciZvN4b+0lu5SMflgO9YOL9IBcKIUHwJixLU6xjA+u0zKFuhEQf+W
	begnR1qBPYgMmyO3jJxqMDsmA2dbEgjggZybHQX0PQbuUS+Z2K5sLBLX2FBsr4+k=
X-Received: by 2002:a05:6402:390a:b0:68e:4c0:f599 with SMTP id
 4fb4d7f45d1cf-693784de192mr3613711a12.5.1781387039742; Sat, 13 Jun 2026
 14:43:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260613010039.1362312-1-kuniyu@google.com> <20260613102041.55e3b50e@kernel.org>
In-Reply-To: <20260613102041.55e3b50e@kernel.org>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Sat, 13 Jun 2026 14:43:46 -0700
X-Gm-Features: AVVi8Ccn4RYCTXqzMYwrPCruXfWWhOo7OhdWRurpDqUSjxzTS9ZYmbEdgW-fxsU
Message-ID: <CAAVpQUBP_21b5MB8MS-wFwg9BUdcgMoNxi8s479YQHH9g5ahCw@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next/net 0/5] bpf: Support RX/TX HW timestamp proxy.
To: Jakub Kicinski <kuba@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Stanislav Fomichev <sdf@fomichev.me>, 
	Andrii Nakryiko <andrii@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 13, 2026 at 10:20=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> On Sat, 13 Jun 2026 00:59:57 +0000 Kuniyuki Iwashima wrote:
> > When standard socket applications are run on these hosts,
> > a userspace proxy is required to mediate traffic between the
> > hardware and the applications.
> >
> >             +---------+                 +----------------------+
> >             |  proxy  |                 |  socket application  |
> >             +---------+                 +----------------------+
> >               ^     ^                               ^
> >   userspace   |     |                               |
> >   -----------| |-----------------------------------------------
> >              | |    |    +---------------------+    | skb
> >              | |    `--->|  virtual interface  |<---'
> >   kernel     | |   skb   +---------------------+
> >   -----------| |-----------------------------------------------
> >               |
> >               v
> >        +------------+
> >        |  hardware  |
> >        +------------+
>
> The first patch looks kinda nonsensical but then I saw this diagram.
> Looks like you're vibe coding an integration that makes it easier to
> treat netdev as a slow path for a user networking stack.
> Please tell me if I'm missing anything otherwise add my nack if you
> repost.

Hmm, what would be a better way to tell users that HW TS is
available on tunnel devices ?

Other options were 1) add attribute to tie the tunnel to a physical
device and use its ndo_hwtstamp_set/get, or 2) add bpf retval
hook in the path like update_socket_protocol().

Or do you think applications should handle ENOTSUP by ioctl
as soft error and always set SOF_TIMESTAMPING_XXX_HARDWARE
since the underlying physical device may support it ?

Anyway, I'm happy to drop patch 1 for now and explore options.

(Believe it or not, I haven't let AI write code because I don't
 want AI to take over the most fun part.)
