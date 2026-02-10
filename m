Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E67F0322DB7
	for <bpf@vger.kernel.org>; Tue, 10 Feb 2026 11:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770724117; cv=none; b=tgM36HMP0fEwS4wAhdAl8MY5wZeMpnviP9yvrSFoFGN4EzQWLHP/x0HFXh4wCdXqNPXv5mnk0wMjmhaUQiffRrMs+qTRocFzkf/4Ut6S2KEUMJ0/wGxp3PXPjGjiCOfYp+sLaH75OmY167XJATfPrFTAGOEcos6JlgnAiPuVXaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770724117; c=relaxed/simple;
	bh=8ZZv4x0mWKh353nLDvnuQWlzARGnj66LH5VUfC2gSYs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Vhnf0XIMJvjPLtdNLCEHE82waIQHJUTCdguDRKrGxEoBCAnm+ofL45lUHdxjc6QRtvCmra1TMitKia46OP4ImbJOtAPRWVECKUjZ7KgE8MxzYNvF3Lnyju5NuKdqrCTxV508EoXbfFiGqfR/pd1f62wdL2275tEE12i7iPVoWcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=be1XVxDk; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=bz6G6Tn0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="be1XVxDk";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="bz6G6Tn0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770724115;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8ZZv4x0mWKh353nLDvnuQWlzARGnj66LH5VUfC2gSYs=;
	b=be1XVxDk2xRfu91K19jo9tGMCD1kNEdFxUiloETfsqppu+1VcTZm9NfDx6tudkf/+oCZzw
	ao5Q+GGXDPZEQulRrDfSPwkDjaHRa3uvID3DkTfGtxjBLqH5SADTvBC/cIVRbm5h4UzsH6
	45TyyaV0xddMDZ7z0p98DOm01YUX7q8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-275-zTtuAN84O1yRmWPhLI6JeQ-1; Tue, 10 Feb 2026 06:48:33 -0500
X-MC-Unique: zTtuAN84O1yRmWPhLI6JeQ-1
X-Mimecast-MFC-AGG-ID: zTtuAN84O1yRmWPhLI6JeQ_1770724112
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-483101623e9so6823495e9.3
        for <bpf@vger.kernel.org>; Tue, 10 Feb 2026 03:48:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770724112; x=1771328912; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8ZZv4x0mWKh353nLDvnuQWlzARGnj66LH5VUfC2gSYs=;
        b=bz6G6Tn0WdxlxLBr2Fe3uqpN8LNeqvdMDiIcCVGwUtEQ8t4HE/vOQ/yf5XrAa3on95
         AA+R3tfJLwfb4HEa6Js8lcKs3pTcr6Zyaglt2mWO01Xf83LuZvNK/lu0MGlQnDfUYAPw
         cWsl0gAqvn1Q9g0KQt1aEnd8rd5gwL1DT3Oj6uD1/BxElDeXLpbg6Q3eymRyG84zSdhT
         /IeGDsGLbhQUmnfsxP1qd2pTMSVd223E3RDtufj5MUxFuy3AJ/MhUMmBwM41Mer5N5TY
         2QteTcE8iY3g8kYPx4WJOPSWMfJk9S9RjL3UqQjCkjm4tdeQ2G09wmyZfdtOKt5TOkRI
         f7+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770724112; x=1771328912;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8ZZv4x0mWKh353nLDvnuQWlzARGnj66LH5VUfC2gSYs=;
        b=ff7664vAFDp0sDmWv+TDIcplkVCQwErdcNiP5QUbbaHOJyFO6SH0aSXXqPow0Kssgo
         XfSszk7M6dc3Kfj7XywDgVT6SOok0gXSJmeAuhMa/+z4SA1w3nyIsnvDKjbqz/isFIdp
         PVU3Gm0jA618OZWndUbgyvbxFdzInsUEW8oWdDkSv8dLwxzhdtK6N79dCdQXMzfKVfus
         hDd9klpEh0KkP3KE8K/5j9Q5C8sLSgOVZS5KNzE+Vgaocxr6qvW5CIHPnH06D1MCqhs+
         6sp9YnCeaXUiwoBNRJ+r5Ct7GUuQ66kQMYwuJhwF2wqeavKCGwN983pG9ZK6xrcBOELm
         Ctww==
X-Forwarded-Encrypted: i=1; AJvYcCUvN/9lXvsKIz2oDyXTKSayrFLPLtzzxBxWGSwOqD1/g3OGV1ohmtPPXMFgL4jFh5UKWII=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtCIaQSsArodKaJmlPgCjY/1DF+83CBCpMk12lIjnkPcptHyTD
	TsY0xX0BR80xeHdr84qxZBxbEbJQpSXt/E1PjJzuFYJ7ot5P1AkRcxDgaJEThzDA3FPp2M/yU5s
	wvSYoH1Jxm/lt2/5vIfWloVg6aZfwvg3lLKdM9h/ULKrMMJ1ruJOvlw==
X-Gm-Gg: AZuq6aIDSfNBP6+RvfhXsUEq8xwUY6lHg06eTs3iZCLNm8S7AVPwbDNcMLsL6qsDomU
	pUa3TMTF0Ro67e59ulAcV3s/dw+Qs5sws+DtQzi2RLUc6u9/+zcRJb8HXYHQl4KEKYWJjHbRLVQ
	PhVYVtuB7rJxD4wYZz+k95L1dh63sz+YEs0CrDKIu7L8IYYLi9zO9C+P7hp/23z40l6oRylOAeZ
	G+OW2zHQtkXnTOLLXWOw3DLopvzIvb7rPsygOKSXPo/vNfJzoRRdxL37KetCXsnLP5670yATaKW
	iQN/Sa9n2+I1OTWh3/dosmMSfjzTtbo6N6oylTZ6bX9Y8c/qf6cYb00SSNxywBuQGc4Sfj8P1OR
	1zI4iElqsDmajhommsiRWHRX3I/awu5bip+nLmnjcif3FDw==
X-Received: by 2002:a05:600d:6401:20b0:483:498f:7963 with SMTP id 5b1f17b1804b1-483498f7a88mr43201165e9.26.1770724112105;
        Tue, 10 Feb 2026 03:48:32 -0800 (PST)
X-Received: by 2002:a05:600d:6401:20b0:483:498f:7963 with SMTP id 5b1f17b1804b1-483498f7a88mr43200915e9.26.1770724111682;
        Tue, 10 Feb 2026 03:48:31 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4834d82a4afsm117106035e9.11.2026.02.10.03.48.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Feb 2026 03:48:31 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 4C0454FE899; Tue, 10 Feb 2026 12:48:29 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Jesper Dangaard Brouer <hawk@kernel.org>, netdev@vger.kernel.org, Eric
 Dumazet <eric.dumazet@gmail.com>, "David S. Miller" <davem@davemloft.net>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>, bpf@vger.kernel.org, Jakub
 Kicinski <kuba@kernel.org>, horms@kernel.org, jiri@resnulli.us,
 edumazet@google.com, xiyou.wangcong@gmail.com, jhs@mojatatu.com,
 atenart@redhat.com, carges@cloudflare.com, kernel-team@cloudflare.com
Subject: Re: [PATCH net-next v3 2/6] net: sched: sfq: convert to qdisc drop
 reasons
In-Reply-To: <177039506943.2258217.14978587773203412149.stgit@firesoul>
References: <177039500964.2258217.2989656069254156812.stgit@firesoul>
 <177039506943.2258217.14978587773203412149.stgit@firesoul>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Tue, 10 Feb 2026 12:48:29 +0100
Message-ID: <871piszunm.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jesper Dangaard Brouer <hawk@kernel.org> writes:

> Convert SFQ to use the new qdisc-specific drop reason infrastructure.
>
> This patch demonstrates how to convert a flow-based qdisc to use the
> new enum qdisc_drop_reason. As part of this conversion:
>
> - Add QDISC_DROP_MAXFLOWS for flow table exhaustion
> - Rename FQ_FLOW_LIMIT to generic FLOW_LIMIT, now shared by FQ and SFQ
> - Use QDISC_DROP_OVERLIMIT for sfq_drop() when overall limit exceeded
> - Use QDISC_DROP_FLOW_LIMIT for per-flow depth limit exceeded
>
> The FLOW_LIMIT reason is now a common drop reason for per-flow limits,
> applicable to both FQ and SFQ qdiscs.
>
> Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>

