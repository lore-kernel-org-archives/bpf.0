Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F9E928850C
	for <bpf@vger.kernel.org>; Wed, 21 Jan 2026 15:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769007837; cv=pass; b=kRM4hwRPKsK2GLSHFTXnN3wy0mAlTyC8iFY5fcq+WDflTQKXSySBZhCJbZ1EY/AzE1ouVjoBI2dY9QCyK4orjzYEmFfnafEl0seJygu/gpGIHJImz6dq/L/Pyt5nQBVU6j1HBTp5wElFxKF+Qs3Oi5Y6LvoL/WN8kh4Z1TiZspY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769007837; c=relaxed/simple;
	bh=QnaNpo6lSG0kfxJQjSpSQ0lKtOo9FhwWS7NgxulV+90=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eSwGIzXig+IIhY0jTm4U+RPzCwuZNHpyI5vo5oC0fbfGLbdFqmlkoXcGIU2UbPnQS0f2m1e3usBZT/I4C1MEycXPFZ5wPzIXM1XkO0zUonMZBqPTvokJIJj75hoVLfLbHpn0Swd49qwh/topiR0B7KDF/sUN2wTfTTU6zrYBGoU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GbCPjr8u; arc=pass smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GbCPjr8u"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-5029af2b4bcso29889061cf.0
        for <bpf@vger.kernel.org>; Wed, 21 Jan 2026 07:03:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769007835; cv=none;
        d=google.com; s=arc-20240605;
        b=A4QG3keNAlLO1maxBGGJfYbGAuU3BrLDmhX8jOaVc8APTlJ9NqGTrqjEI28D4aPnxF
         pEoarl7lyudrk5hn1fb7JD03A6mdJMYJZGmPGIA6z4wc6bCWV/AraiaFf4cnPCva9Byv
         +0AELj4bvAu3emcXgh8jW681UVozS0rJ89WdHxure0uCW+NX/3XICeTz6z2AZVvP1fAH
         fFY5YS6kULGacDTbWVFTmRLjt5RceQTswkzbYWDIFrc9d4xom1LGr5m3+EQ8uGJMLgCw
         AcqWP3EP+wo5epA/V5KI25xmb27qovdNfVlcdjuxxBXjkUvKfPBuJhr/MGJM+KBKlBcT
         xCsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BkfXslef5CleGTOMTYe++OlaJ9VsT1NdIrx0Bt2jP6E=;
        fh=7gfYFHUN7fAChHaX+na9bUpO/GxW18cYbovjwJFinLs=;
        b=QhoAjWyN4xwLgh1P79qiSAY8MabDrxD6M0TGJFCmwTeIAa7p9uk9A9i1I9tM535u++
         kyQxejwZGv+lRIJLnhOR7HF8goA1ZsFvmbm7UIT+iFqyGTgUZ7C8lqVFu/gRhJDS4IKi
         wpW7Nz1BEnfeqkulKbicbysMAGsV38fK20WV3Tpf6kOCyvzEeeah+EpJo0de9H+gT1kn
         D7v1Z7hI/9l2YsLgZtz2pIrwchRJ/LqG2N7NRAaW+ukbeklG57EpFOOLn9PoCzlGG1h6
         Wb1DA15jVn6wwgdIsRzAQkuJgBY3bSGGulhSq0J+PwoufGKH7P8wI4YHrmGmDJe+wcDx
         d1dQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769007835; x=1769612635; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BkfXslef5CleGTOMTYe++OlaJ9VsT1NdIrx0Bt2jP6E=;
        b=GbCPjr8u0SxkrNuOj/F+aztCCHfE5nwZe9Et23PvmkjZfL4RKDUh4WSOqoedBr9LHH
         Hw1PETrMTJsNeCxF1eqy0FlUkwuBH7i9JmVdG0a6bh9wA+of1Ty0d+pC6JqdqOCw1pBf
         i4XCZi8hYLgRdvEC2MDuyBaH/zrJH+/7CkT4MHypOyO/Aa6hxdJsaiUIkBetAeVlMO+W
         B95p3FLmq5CDKQT2T+MBwcJbZHNwL24IMtPagFbPJ2yF0eZ/gi2tKDRsxJ3OFYrVkhVT
         srzWEQeIXNXAABEP3EfdHSvVVG1DosM/p78pjkxF80ZM08HE+LeK+wDQNoeYxSaRzo1c
         Dseg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769007835; x=1769612635;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BkfXslef5CleGTOMTYe++OlaJ9VsT1NdIrx0Bt2jP6E=;
        b=UjrhQKwfgtr0UF9aRs4jMhDsfoD7KGmSQJM7vRsb6Zv1UT76aFnCJvjzAWT7+id2QV
         KFiRZOjHJ6TAUReh4ukHv0GKtu1KNBoTtRI0P6Pc6cztXsGdJMZgSyFMiypJDXIzUDtw
         RNa9OQtnfe9ndij83aTaDd2NXoOFmrp9t0LyYCdEvN7fPRmXdWjGiXVJYW7klo4FWzM/
         ZNSr9QEBr0d7VJDLibaMkittW29LWjMlDjIiK35P0vRAph5c/tdlSn1/mt3MQeT0zdLK
         01yuUqV9G3uvOmpSmqwpgK1U6868FeH5A0hgPmR//8z1auL8rsJgT/jGbLZ8y6g36MVG
         VFsA==
X-Forwarded-Encrypted: i=1; AJvYcCU9xObbBlV6VaXa6/6AGbOnidou/+096i+yywMjSLXxTZAkaRauYrCYNOSPHoJn+jWHGK0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZACtczVKERDjU7jPgJCnRFA2l5qqCF89/hrQuZI4E/p/Utfih
	xxL9f650KwJasveIN+eM191EK503+cKUm4l0zavdMpbq2fmBk1jMRn2ECI2+5p2zlvgNkUUQwDV
	6IeGae9KGzIpVdfsnSlyhH/PQtbLhk8bKRmKvw8ny
X-Gm-Gg: AZuq6aIUeTk8KO4nJgzDSRL2OEaluMWepg7gFnDLArscIH7e5qjoGOEoIgwsptMXeed
	HE/JvxR2ZJ647t/zAVpkpKbZOXZ7/euUJLYmewozORglO4C7B0jS55v6ofuEJjiMFq8WR7uu2kK
	rp/9GnwD4YGwDgohSnyl7WZfgAubWxaslFfy8sVT8UAmOJ/YVieeqE0syctex8NGBho4UQrGr9w
	4lpccLI4wrOQn9TOT1clONgp9GOQ/eE/gAj3kBuDhb5juHZI6YQIaqq1ZK3DgRo3VsIRcA=
X-Received: by 2002:a05:622a:180e:b0:501:47d3:217a with SMTP id
 d75a77b69052e-502d829a969mr66313571cf.25.1769007834257; Wed, 21 Jan 2026
 07:03:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260121143215.14717-1-chia-yu.chang@nokia-bell-labs.com> <20260121143215.14717-15-chia-yu.chang@nokia-bell-labs.com>
In-Reply-To: <20260121143215.14717-15-chia-yu.chang@nokia-bell-labs.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 21 Jan 2026 16:03:42 +0100
X-Gm-Features: AZwV_QhPskOIydB8GymjUhQQqHYwHvz2ukB4yAm_VArjAbRnW32yObrkavrJhr0
Message-ID: <CANn89iL6ax4=xk1Q+KhiSRAQwCRpOSPVLTe0gwjBf0FBd0vm1Q@mail.gmail.com>
Subject: Re: [PATCH v10 net-next 14/15] tcp: accecn: enable AccECN
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

On Wed, Jan 21, 2026 at 3:32=E2=80=AFPM <chia-yu.chang@nokia-bell-labs.com>=
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
