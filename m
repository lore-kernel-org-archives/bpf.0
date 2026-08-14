Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9362237F8A1
	for <bpf@vger.kernel.org>; Fri, 14 Aug 2026 19:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786734911; cv=pass; b=pNmOnsqhJb6iswJVtLZUgSRNK5ZZvpls+di8fBl6ZKmKw2ajo/+brAcmOc4INnvDB8inVN4cootVXsFygt6VMuvStbp6cb9n0+22Wlb5xi009FzMZ5iAK00u9FwcfS2Z1TrV15aXdO9kZDlyuEZdWvyd+SLBwRJm6FdFNcfR89c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786734911; c=relaxed/simple;
	bh=YARhzzSQQ1PYu0fWMrgI/uEX5C0qrr5INxA7sSEl8ig=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BYv+Jcux24UEwxSR0RAlNPinATVO4wiUSSIDyOTt5SJk0ypnqIELcox2fp+f/uV56MQucVm5TaO3yY36wtscc/L0meXT2SmcQzyR6t/a1OWBr+A9sKczLAu974aJoynIpE2+QbPVdwnbMTE1IbL2vYaKZekHTLtvupOJW5TNQX4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KYQ/nw7u; arc=pass smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KYQ/nw7u"
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-66c67a73eb7so2500180d50.0
        for <bpf@vger.kernel.org>; Fri, 14 Aug 2026 12:15:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786734908; cv=none;
        d=google.com; s=arc-20260327;
        b=msIv0W7/dXoznwcAz2o+vCzfn1RnQzvMqBA3N5ayeDp4HBsx3EBS7AwkwJrwjiaPps
         aiYYeR6cJHhEbqoclWRJ0Xe6h2uPVNRKw4qUybrgXu1PlQ13P1a/y6a7LMygMoB4vqyO
         iPKFuX8jRf+QuCMhwEU6fH3F97Tx1v1HgzyV3nCNjpGLNqsvxlUVir1s5HuqnVVO9DZ5
         AuFz7sW/vFlrKh8jxRsxPNhwc8zU9H2foLU3Nj6hx+QAkvbqijiWz206u0JEW5J55U3q
         4dbVIIe2YoJPQXewbFdY0lrYGuDVVae/IHGNTRxTY3cNIVTHYm4IzDL6+fubjWU3NHeL
         oe2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=krO17/bagVVmRXbK81DAUeMmTF89gRNsvTsVM9hl/s8=;
        fh=F/aKvsMONRFzcHwkLVI8gOv9iX3sWMIoLfTfaJb71YU=;
        b=q1STF5ivVxI4TCXQEqrmH+wz9Ihp/MruBcS1x71QQN+j/J8E5yLwdWb1UFCh2K8uoF
         +9s/R5acZM63DrNBu8GEoOXcb4j33rN7lRZOJfKLeOSmfSTvmFQhFYasnh1CBkXJGA0+
         HqVZ142J0K3nzdqpZSA44UIM+AshGHGj/60V/tTmgZZkwzDtlZaza1ztkhnxNwFSDYHs
         AGdOnsLBbGunDeJ4hc98PB95zqJLNjwwvksez8P5WkoGKN9/JwiBZXGJHehL/AUiRqJ8
         1OI4gOWjzpqKETcPRA1dZPRAeR/wOh11nItbbDjY6A256YU0vczSeerkVbag8CbUeZKB
         lyUQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786734908; x=1787339708; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=krO17/bagVVmRXbK81DAUeMmTF89gRNsvTsVM9hl/s8=;
        b=KYQ/nw7u3tV0TExnGT+kd0AY6B8/6BK+QfWLRP/6E4dlPlPZz1LjL8JhAJk+dBX+6w
         sblw4YbI6vQcbyROFtTvoxUEp7GvqM4YlGJonR16otVkwHGhkYgLS5HqOJQ2C+POypbu
         fTg9mPpzjVG1vy+EwpPg2/NNng118TQwedSvAwOTFyU0bX8sasEcM21H1lNUb57/hXOb
         PQJIkXuhhcw159yLRuQYcuIhk7/AeADb4t2d28HLXcH/QZWiw3jbR22ZauT4PoIJ2izm
         0mjHu1/pT0/fudQazr0Ra9taP5SbUPkRm3vmKuIZcHS/DfYBk5sBXpODtIGIOK4RxW/S
         cLCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786734908; x=1787339708;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=krO17/bagVVmRXbK81DAUeMmTF89gRNsvTsVM9hl/s8=;
        b=DlNbS71SWU9OtXyv6VzNBNt2rLXebyuE9BbsXMEhkw1133h7lu9u0K8t5KAG82CpRX
         P1tsF5agi9fba35zJYsIBbnh+13DyjTY2fwF3I/rhuxpUCfE9WQ19lG1C5SCikWh1Hpy
         W5i7cTUloGxhsKVqWzWMAYT7yDbFFeKdhbfPNyhHo7DvTQFcmIp7XbAx+vI1WWGa12D0
         IF1d+bbISKktTjpC1HaSkDpicKZ93wNcTrFolugbE9adLEDIky9x724kpKfar09T6tpx
         6vNcApzUgC2pP+45X1zyGHpRt9hlw2X5nCgH5IhC7atVV1NglIt/Ts3oEk8vd4hWS1r+
         7TCw==
X-Forwarded-Encrypted: i=1; AHgh+RpqRClCqCqRz5pNEtxMo6+8OWpMjMZgvEetXA7nrzRU4KQAoc3tRzxkc/qqQTJe2haZGWU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNnr1p8t25+TAl548by5JU1smnXTXSFS6BB0FZIjnr43zMFJOE
	HmWE7DM2fAnCYb099hb7CTGiI9Y9maIgzCO/sMjKJ4EnXdGelx5z52rgwqg5LqLSVHSGg/lpNMk
	oBudVhfHAa5wJGduKDayGcu22WG0zZf0=
X-Gm-Gg: AR+sD10+z/FEs24B0tqRXVL5XbCdYp1Jxflw1vxh0XCE2AiwvyerzhtGm00AJE+q50c
	ReyGG7JauLnhpQ4Lb4l/1Qc1MewmMpOry3Kuao4P2oLa8Pr1OArbED0en+G9OpWLEhhQmBSVYuR
	7/jC6BC/BjZ00FrMLDbyhTyCCBTKM90/edA5+MyLs03oGuG2KGRkSaD8Tb3LV14ncvjekpPI/+M
	pIbQQ7mn2WrjBrBdCLqJHxQVOdwoK2mc7Vl8lNq75KOJ7t9Cc+Y8d4NWyUnIfs+eWBN8XFbRASK
	uzV8Esc8zwkgk98oxYPjVWttU1NPIJtvbMklkDVaFgBzsm3/cPRucNAodwq3BC7rr9Gbqtz9v0H
	BIQ==
X-Received: by 2002:a53:dd0a:0:b0:668:894a:f534 with SMTP id
 956f58d0204a3-66c54cc5fcfmr4473139d50.25.1786734907868; Fri, 14 Aug 2026
 12:15:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260804213510.673084-1-chia-yu.chang@nokia-bell-labs.com>
 <20260804213510.673084-2-chia-yu.chang@nokia-bell-labs.com>
 <20260811173017.3d18dfdc@kernel.org> <PAXPR07MB79849A3F1724DBB2DA8EA20AA3DC2@PAXPR07MB7984.eurprd07.prod.outlook.com>
 <20260812155430.6ec81eec@kernel.org> <PAXPR07MB7984E3E73868BF8966821C27A3DB2@PAXPR07MB7984.eurprd07.prod.outlook.com>
 <CAF=yD-LQbndjPZiXcfA6fMp6msza_+YdzqqwyeUDVTdOCOHhDw@mail.gmail.com>
 <47BE8A8A-F80C-4C30-BC95-C85FEBFFB606@ericsson.com> <PAXPR07MB7984ED42ED0849D3A9AB8C19A3DA2@PAXPR07MB7984.eurprd07.prod.outlook.com>
 <willemdebruijn.kernel.c248a28f9c86@gmail.com> <20260814120121.50e61d01@kernel.org>
In-Reply-To: <20260814120121.50e61d01@kernel.org>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Fri, 14 Aug 2026 15:14:30 -0400
X-Gm-Features: AUfX_mzfpoxQCDCly02kzT0GRl9rBucQ1xz8t4L_tqiifrYvAjnLnYkwChvD3sw
Message-ID: <CAF=yD-L1-Sxz9uyP_4WqtNRJHnwTVMhQba_KF-=Eiy=d9Jf-qA@mail.gmail.com>
Subject: Re: [PATCH v5 net-next 1/2] net: update comments for SKB_GSO_TCP_ECN
 and SKB_GSO_TCP_ACCECN
To: Jakub Kicinski <kuba@kernel.org>
Cc: "Chia-Yu Chang (Nokia)" <chia-yu.chang@nokia-bell-labs.com>, 
	Mirja Kuehlewind <mirja.kuehlewind@ericsson.com>, 
	"shaojijie@huawei.com" <shaojijie@huawei.com>, "shenjian15@huawei.com" <shenjian15@huawei.com>, 
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>, "eperezma@redhat.com" <eperezma@redhat.com>, 
	"jasowang@redhat.com" <jasowang@redhat.com>, 
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>, "mst@redhat.com" <mst@redhat.com>, 
	"xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>, "pabeni@redhat.com" <pabeni@redhat.com>, 
	"edumazet@google.com" <edumazet@google.com>, 
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "corbet@lwn.net" <corbet@lwn.net>, 
	"horms@kernel.org" <horms@kernel.org>, "dsahern@kernel.org" <dsahern@kernel.org>, 
	"kuniyu@google.com" <kuniyu@google.com>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "dave.taht@gmail.com" <dave.taht@gmail.com>, 
	"jhs@mojatatu.com" <jhs@mojatatu.com>, 
	"stephen@networkplumber.org" <stephen@networkplumber.org>, 
	"xiyou.wangcong@gmail.com" <xiyou.wangcong@gmail.com>, "jiri@resnulli.us" <jiri@resnulli.us>, 
	"davem@davemloft.net" <davem@davemloft.net>, "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, 
	"donald.hunter@gmail.com" <donald.hunter@gmail.com>, "ast@fiberby.net" <ast@fiberby.net>, 
	"liuhangbin@gmail.com" <liuhangbin@gmail.com>, "shuah@kernel.org" <shuah@kernel.org>, 
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, "ij@kernel.org" <ij@kernel.org>, 
	"ncardwell@google.com" <ncardwell@google.com>, 
	"Koen De Schepper (Nokia)" <koen.de_schepper@nokia-bell-labs.com>, 
	"g.white@cablelabs.com" <g.white@cablelabs.com>, 
	Ingemar Johansson S <ingemar.s.johansson@ericsson.com>, 
	"cheshire@apple.com" <cheshire@apple.com>, "rs.ietf@gmx.at" <rs.ietf@gmx.at>, 
	"Jason_Livingood@comcast.com" <Jason_Livingood@comcast.com>, "vidhi_goel@apple.com" <vidhi_goel@apple.com>, 
	Parav Pandit <parav@nvidia.com>, Willem de Bruijn <willemb@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 14, 2026 at 3:01=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Fri, 14 Aug 2026 09:34:01 -0400 Willem de Bruijn wrote:
> > > Current SW GRO sets SKB_GSO_TCP_ACCECN when the flushed skb carries C=
WR in tcp_gro_complete():
> > > if (th->cwr)
> > >     shinfo->gso_type |=3D SKB_GSO_TCP_ACCECN;
> >
> > And I suppose it follows correct AccECN rules for coalescing.
> >
> > That is a performance regression from RFC 3168 ECN, as it allows for
> > less effective coalescing. I have no intuition how much it will
> > differ in practice.
> >
> > > For HW GRO of a legacy device that implementing RFC3168 semantics, se=
tting SKB_GSO_TCP_ECN seems reasonable.
> > > However, such a device would not be able to preserve ACCECN signaling=
 across the GRO/GSO.
> > > In that case, if preserving AccECN signaling is required, disabling H=
W GRO may indeed be necessary.
> >
> > Right.
>
> I'm still not following.. Maybe Willem can ELI5 what the problem is.
>
> _SW_ GRO follows only the AccECN rules.
> But if HW GRO follows RFC 3168 and we mark the aggregate as
> SKB_GSO_TCP_ECN - TSO will also abide, and segmented output
> will be identical to pre-GRO input.

+1

> Are we trying to ban RFC 3168 behavior in HW purely to match SW?

I think that's the intent here?

>
> > And there currently is no kernel API to disable only ECN
> > coalescing. NETIF_F_GRO_HW enables or disables HW-GRO entirely.
> > Or even to signal whether a HW-GRO implementation is AccECN
> > capable.
> >
> > Disabling HW-GRO can be a huge efficiency regression. I suspect
> > many users will prioritize the efficiency over preserving the AccECN
> > signal.
> >
> > That said, some devices may have other ways to configure such
> > finer details of their HW-GRO, even though not available through
> > Ethtool.
