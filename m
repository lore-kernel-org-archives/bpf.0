Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 450C3212B2F
	for <bpf@vger.kernel.org>; Thu,  5 Feb 2026 14:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770300927; cv=pass; b=jjXalSY77QyVBGHWyu6TXsLBCqug+vX2qauQfuR3mzRTRgDq88jRSpk+KJK5b7loy7Ym4zgkOiQt6J7xeEsGH5ORdItTaJd8bsKNSXGjrWZpXmHFeIiJzW2fhXcUbqMKvW9Dp2FoFh1HZzW9D2ZsExylA2eYnL4FRSBQyfaQtE8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770300927; c=relaxed/simple;
	bh=KI5NOv4fRNJMI4byknR/9hp0wk/tAmDp4sUkhHwm8jA=;
	h=From:References:MIME-Version:In-Reply-To:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rf/5fJpSR+7wQXfUc7MVh6LXVA/weGq9au/9dSN00lm/Se7cizwUup7aSD31YEwCmBeHgHW3iCzYzSX4r3bBE3hUPFh3KguW0T8eG+t3xBPSAg50Nr5Ul9vRmE3TgbcuB4Vqnkfk2/P2Ub+M0cvjZZRl/6xVsWWW61WbZu81Hns=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KfgjRpA0; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=okDMgw9Y; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KfgjRpA0";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="okDMgw9Y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770300926;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KI5NOv4fRNJMI4byknR/9hp0wk/tAmDp4sUkhHwm8jA=;
	b=KfgjRpA0q0vIZFGG02yedlDbq8DC+PdpZrIw+QfzplRqA+6iTk0bUKS40CbY0gRfaf7SP6
	/sjDc3JMPhfXIB4ZjnZ1Pl72bd8ixHrr+brTqDDHzLWOmyspSjz+S9Gzk66/3vGyIXIub+
	qzwQsESmz11pPQCpsxO+B3jP8kYs/Dg=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-541-VwJoZuJUOgCVO4v_n6goSw-1; Thu, 05 Feb 2026 09:15:25 -0500
X-MC-Unique: VwJoZuJUOgCVO4v_n6goSw-1
X-Mimecast-MFC-AGG-ID: VwJoZuJUOgCVO4v_n6goSw_1770300925
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8c71156fe09so264616185a.0
        for <bpf@vger.kernel.org>; Thu, 05 Feb 2026 06:15:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770300924; cv=none;
        d=google.com; s=arc-20240605;
        b=iGt5/qoQaTyrbkCmOJqZb17xyPEAap59B7Ue01/skTo1AH5ny+XLTnImrxNvQMhE+n
         XOrgF9R1vk3YwpLYy3IcGao7Scclt/JBlP9ezfRMit8gQgosoynqh1tEFzVz/OIUUuKM
         GcxT471Kg2H2dXXik6l7duiAhQJIgpE7lxZpF2vtxqQXFeSnfvq9s3BjlMq6ENoD1+9s
         lM7eiVQ/MkXyJY0bBir9qhFjRlceO9ogUaQuTNMMaKIHkj/8FYPXhDYDtBSmzMlyfWOD
         GAQ4NJqV7Lvb2h65DtYcla6hzIonHoLZv3h/7pIBAyYJreoVzNmCjKy1bLZTe5W/Urdu
         LzDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:in-reply-to
         :mime-version:references:from:dkim-signature;
        bh=KI5NOv4fRNJMI4byknR/9hp0wk/tAmDp4sUkhHwm8jA=;
        fh=yAsYU+ES+HEm/3buPhT0/5ap2uLNMrTnSrK4nw6VIzw=;
        b=Vz3kyKZxxvmln/9p8gW+i/A18N2zK64zd1W2bwC3ikWMcBx5lEpIn8R5Z+bxaw9Vdk
         I7NphaxhcisgMQgu1QImG1QoVpfNa4xJoOckaVx+LFWN0KEyiN1owjAIEo+Q1ZBKPp/f
         4fxmZciw7+xSoabxmCM9KNpqfeyfRPistxfKa4W2FSWZvNz/+l9yVBIEYYlJGO0b+aSN
         NRC6Y1ot7OjC220wv4OmJX2/i7RW6Bd5ELnyL5ipw5fRkXq7Ry9WT2oS/+V18XSEEaJS
         P2MwQmfG1rBilRiEOb2J6ctOREAp2IdkSPU5ER8urPBTCSH0dAwvkWwnTh3R5FQQseDx
         qmJw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770300924; x=1770905724; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:in-reply-to
         :mime-version:references:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KI5NOv4fRNJMI4byknR/9hp0wk/tAmDp4sUkhHwm8jA=;
        b=okDMgw9Y6wCx4RH/0o+XJoXhPfbmIrCtiKYwMU2QY5ghcjWnYv9P00tJo2Zp/pO3aI
         ArlTpaGrtniZE4gfIQLhFK8MtVoDVyjGqfDch+179cAQCvvSTtRV5osuG25zBoYripfH
         q/MfrMJ4L6m8qWWj7brLrEXeoxA9t0yyrpUFSnZYn4smxcuqce9paAWXpKvsEwlIxdgH
         P/8hcdBH9ToKwBLUv/nQMrNmWT7NxNZhLGItx4q3RoO9j80I/9wBh2W1BTg4jKpBiyIW
         0GmtWgGlcbLOSX5x6nhGIIgkL9d1DRhxwuXprvmz8NJhcPObyKjw8W2X3QcE7nQNs1TZ
         GUnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770300924; x=1770905724;
        h=content-transfer-encoding:cc:to:subject:message-id:date:in-reply-to
         :mime-version:references:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KI5NOv4fRNJMI4byknR/9hp0wk/tAmDp4sUkhHwm8jA=;
        b=dJuaMvcwklhRJSCx4blsxkyySISjVkgReAtH5FNPnNP5AiqR5hchwgj7hFPXbQHcVW
         Ca27El302IQOM3ihku8xAHLyAMZ/7raTBI7zFa9pe2JvTfu5da5KVYHXmRsKz4E04nwE
         tYj30Fn3UGRwAu6/6sOdjlf9Bzth/qrsnEq8SB9ge+otF4BxT/kzuVI/JRNuWO3/xthR
         rBkE64g/UBdVmLb8alXWtatoKducFqu9dpd2yiTrE+p3Xurjiz/GNBgY+1YYwhRanG24
         RQGfn2UoCJ+/yHrplqlQoMqAlRmlPG89/2+hkUj5CkkECiDO11Rhr3tmdSd0bIWRBXHd
         Szdw==
X-Forwarded-Encrypted: i=1; AJvYcCWN5qw8/QzhbdGq5MyeYXidln6RO2LYOQQCW2A96iINCe1VCA1jDv/fD0CDdsL8VVmRZqE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxA5TP4ngum/h+o9Nc/QR95CwIEXh4S207Go51CCokHNd16tyHr
	1Jb9H4IT3T0BpSO5Fz+tqTJ1SIBg+Ij3GQnumoccFbeR092pugeHbQH8hl2v1TRe2odfZnfk0Cr
	MdGraoWeWrxCLEqCQHN2BHW6MQZTRn1a95sewzUukt+8MSSZUI54MWJbrFaM2f/fScWA5XvJQ5G
	47CN1sInLLWoUi0T5UHcyig0JE71yK
X-Gm-Gg: AZuq6aJ1MaLtZVrBjF2F5OS1XOtNB52QX0q8t3jeMie9Pxr6Ag2RFagSXqwfLFJWkeP
	EAhPxUF5TbMiFQV5DI394iaSF6SDlwF5QIRKAD51LkLrLw22fZCqNU2iAWoI5ibpAPSQCJAQrki
	FDpOIqr3EHxjwUBCZyQsPkiWxW4KBgSN+P+sa7AuWPSGkyENhyFJVPsTQGj9bAC2YCr7HtD0U3t
	WkQPlaop0t8vYJv+rF3KopUHQ==
X-Received: by 2002:a05:620a:4541:b0:8b2:eb66:c64 with SMTP id af79cd13be357-8ca2f867672mr990703385a.29.1770300924406;
        Thu, 05 Feb 2026 06:15:24 -0800 (PST)
X-Received: by 2002:a05:620a:4541:b0:8b2:eb66:c64 with SMTP id
 af79cd13be357-8ca2f867672mr990694185a.29.1770300923828; Thu, 05 Feb 2026
 06:15:23 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 5 Feb 2026 09:15:23 -0500
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 5 Feb 2026 09:15:23 -0500
From: Antoine Tenart <atenart@redhat.com>
References: <177022452988.1827734.5121740962985640333.stgit@firesoul>
 <20260204190417.110f5498@kernel.org> <2e1eb11c-cd47-4772-baff-45d43d4fa539@kernel.org>
 <877bsr1l1h.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <877bsr1l1h.fsf@toke.dk>
Date: Thu, 5 Feb 2026 09:15:23 -0500
X-Gm-Features: AZwV_QjcB_MBND46w0GTpSb-IAFDgDb1HaZ79yjWvd5G1Kk8nknomGGZF6Rm4Fc
Message-ID: <CADCXZ1yMkZbRd7ioGw5QQ61OdmYp6misUDoj-s-g7wuoiCHKbg@mail.gmail.com>
Subject: Re: [PATCH net-next RFC v1 0/3] net: sched: refactor qdisc drop
 reasons into dedicated tracepoint
To: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	Eric Dumazet <eric.dumazet@gmail.com>, netdev@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, bpf@vger.kernel.org, 
	horms@kernel.org, jiri@resnulli.us, edumazet@google.com, 
	xiyou.wangcong@gmail.com, jhs@mojatatu.com, carges@cloudflare.com, 
	kernel-team@cloudflare.com, Antoine Tenart <atenart@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 05, 2026 at 12:34:18PM +0100, Toke H=C3=B8iland-J=C3=B8rgensen =
wrote:
> Jesper Dangaard Brouer <hawk@kernel.org> writes:
> > On 05/02/2026 04.04, Jakub Kicinski wrote:
> >
> >> It will presumably require existing users to migrate over
> >> but sooner we do it the fewer users that have to move?
> >
> > I agree. Existing users will loose some details, but the patchset
> > results in fallback to SKB_DROP_REASON_QDISC_DROP as a drop reason,
> > which existing tools/users will still handle.
> > (The more specific drop reason is now avail via trace_qdisc_drop).
> >
> > Eric and Toke is this acceptable for your users?
>
> I like it! My only concern is that drop monitor tools will see two
> events for each qdisc drop. I guess that could be relatively
> straight-forwardly deduplicated in the tool, though? +Antoine who works
> on Retis to give him a chance to complain if not :)

Thanks for the heads up. We'll have to add support for the new enum
(pretty straightforward), other than that things should just work.

I'm wondering why not using the drop reason subsys logic to combine the
qdisc specific enum while not conflicting with drop reasons and allowing
to inject the qdisc reasons into drop reason enabled helpers as well?

Thanks!
Antoine

