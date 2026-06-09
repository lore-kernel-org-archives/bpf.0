Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 493C33749F5
	for <bpf@vger.kernel.org>; Tue,  9 Jun 2026 20:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781036078; cv=none; b=CY0fw1z/YEw6DUNXLy4CCeCO8cz6vymFt3G2I4XNFCCcVK/nhJaK3zlT67ENxUDTcfVHojkUQkqWaF7mKcsrJO90eqZLqySJtgkcL5KdFOkh+rVSJgwH1SnUw9TJ+D2v0vUqF/6zfbkRaAPj9olm8Fv5ucLr/Z10ivtVzIiEJnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781036078; c=relaxed/simple;
	bh=hprTfB754mLY1EMoptmcabMyk8Qi2IBNgYxDZtI+sD0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fTCn1MLNk5g6n0/pLX6LiopqMroyJ0VxE/rW2fGW6xjqXWgtb9NjUGT6OdhH1lOUc+/xkWS7Gp9+fR2eHEWuDjegV+XGfsqlc+iNr/8ioGHsnD+BFUWy+AA6++apgd5aGmCxcuQe10rVOCojCC1ByHgyk5gA8jbQQ5TGd2XOxWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JS4NESIi; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=tmdqwAyV; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JS4NESIi";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="tmdqwAyV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781036076;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hprTfB754mLY1EMoptmcabMyk8Qi2IBNgYxDZtI+sD0=;
	b=JS4NESIi8uIDfQb+NZsLbDIbpI5JPVMx+3iW7ayX7HnzYCT/XbKmU4m5OK2hZzPflMeEL0
	VABktHeiOvgwUWWm9rvkmS6F4FbxDxaROESohspd41pepmfqi99VD+At/AXyKp+swteOlI
	iJumZofZ6+HPRV6u825Lk76CHD66xO8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-519-b0fH3MJdMwqc6SeGoPHNXQ-1; Tue, 09 Jun 2026 16:14:35 -0400
X-MC-Unique: b0fH3MJdMwqc6SeGoPHNXQ-1
X-Mimecast-MFC-AGG-ID: b0fH3MJdMwqc6SeGoPHNXQ_1781036073
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-490abeb7298so62303405e9.2
        for <bpf@vger.kernel.org>; Tue, 09 Jun 2026 13:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1781036073; x=1781640873; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hprTfB754mLY1EMoptmcabMyk8Qi2IBNgYxDZtI+sD0=;
        b=tmdqwAyV8sweQ+4yf72Tfz1NqU+yJbIV5m7Wcc6lUrH/KqEhlpdHmf2zHMgU67fCZn
         zmedDU1OTZ/P7jn9LkWfOATk1HrVodlYM3sEEVbDIJczdmKsjZlfHxdjyk1pao1cmiAR
         7quodlGILi7ydUjojrvZo0/QO7F5mxJiJwCkj8n9h3dllKE40cc13tl4VFALvVnd8L/C
         SK/QvYd3qOwkOwPu7/q3ViDmRUcpKEc06OoM4MgLMB1fJghefDDX1HMd75iekgdDD+Fs
         0PCidiUQMbgJzvk1+UPEx8FMZkkUzS7zUjqy3NVKbir6+r+6wlDzPkCQAWgVoP641IIZ
         1TAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781036073; x=1781640873;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hprTfB754mLY1EMoptmcabMyk8Qi2IBNgYxDZtI+sD0=;
        b=ixYLpeOuStRIpEHvimNbWYd6q/pMOjmdr7AOkyqEHeaVKTvAFVzqMwlUjW3dD2LeAg
         8crtA5pPXF4cObI4xj907gORs0fX10UajjHs8cFzDGbK4xYIiygnsmfD+iIrLUSL7O2W
         SxEtM38QVI8PwiFmt/gez3q1KE5DpPlzhGtNgpuPmpAh96u3xGoY4BeK0/jDUHGVvs45
         gZg0pckEN8iOM5/N3DzBdZbxzUS34KOnVt8oGuT//e9ZA4a5Ow5hg9mKUx5uA85kWhPc
         GGXgJY5OzhC1FsUeusGxtvzlR9jSxXYD1tE+5tp3sQwDY2U9fIk6PyTEB3ITvNEXFqdx
         YjOg==
X-Forwarded-Encrypted: i=1; AFNElJ/Q3mRDxXum8bqDiHlpG4dwZ0ecUkS1cz1XrTzkPdp24o+iqGfJCFKud0aKR4sr/aT4Wxc=@vger.kernel.org
X-Gm-Message-State: AOJu0YynaVpy9Qk7rpHhEMcU04+qpZnJ1Lk9nmdv1IEsng7HjZG30BCP
	ES4g6kJFF7j5RotDzDA8SvL1WMQ4R5ulwGjYn+O6G3bn0HAkrO5y2Jt6buYblPSTjSlp55V7TSk
	Kg/cHNF6fczoEmIDuyd98TguUR/S9ja/f2fBdV6wmL+PwKVM5B/0pPw==
X-Gm-Gg: Acq92OHS1zb3xmPt7eFK2yAGLgJ2Bzj2Ly5URnfBQ8XfjYMsp1hCTaMbvIAyd4VF8K+
	FIb35kHEffYaUSSSDz9VoZ0Aok4/hrIprLJkmDw8bvyK4IbqNrZ5PXfixz5SNAQP5i+e7a18oLw
	kuEVYB9UQNlDlAVJdEjyGDSt3SUkIugaejR9vOmvBp0bYRN1HdrdKZRq2qCB1joVjUOk0n3rpgg
	cjPNrlyyepK5ZzvxQ7py6AlUtf341vpB71hLrDJ/XVTpaHcFc5qDadBty4erc2M2zq91rcYxbHF
	eaiBJWg5xRnXYp+GPI8WpirhlQ4pHKtww16uF9ZSR8VQjDuRG7j5TIp2h5UXnkPQuZkOBUAUAVE
	FYKJpDJTj5bTyjH4HRINUwQ49SsNt+viFAnnzAoHhY9Ly7bhCiCVP9SNf0lw=
X-Received: by 2002:a05:600c:a086:b0:490:52fb:12dd with SMTP id 5b1f17b1804b1-490c259f616mr361087195e9.10.1781036073013;
        Tue, 09 Jun 2026 13:14:33 -0700 (PDT)
X-Received: by 2002:a05:600c:a086:b0:490:52fb:12dd with SMTP id 5b1f17b1804b1-490c259f616mr361086915e9.10.1781036072659;
        Tue, 09 Jun 2026 13:14:32 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk (alrua-x1.borgediget.toke.dk. [2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc3b5b06sm460746815e9.3.2026.06.09.13.14.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 13:14:31 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id ADE4C7BC400; Tue, 09 Jun 2026 22:14:30 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Avinash Duduskar <avinash.duduskar@gmail.com>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu
 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa
 <jolsa@kernel.org>, John Fastabend <john.fastabend@gmail.com>, Stanislav
 Fomichev <sdf@fomichev.me>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jesper
 Dangaard Brouer <hawk@kernel.org>, KP Singh <kpsingh@kernel.org>,
 bpf@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next] bpf: Add BPF_FIB_LOOKUP_VLAN flag to
 bpf_fib_lookup() helper
In-Reply-To: <20260609172052.81613-1-avinash.duduskar@gmail.com>
References: <20260609172052.81613-1-avinash.duduskar@gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Tue, 09 Jun 2026 22:14:30 +0200
Message-ID: <87a4t3a2u1.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Avinash Duduskar <avinash.duduskar@gmail.com> writes:

> bpf_fib_lookup() returns the FIB-resolved egress ifindex straight
> from the fib result. When the egress is a VLAN device, the returned
> ifindex is the VLAN netdev's, which has no XDP xmit handler; XDP
> programs that want to forward the frame (e.g. xdp-forward) must
> instead target the underlying physical device and push the VLAN tag
> themselves. Today the program has no way to learn either the
> underlying ifindex or the VLAN tag without maintaining its own
> VLAN-to-ifindex map in userspace and refreshing it on netlink
> events.
>
> Add BPF_FIB_LOOKUP_VLAN. When the caller sets this flag and the fib
> result is a VLAN device, populate the existing output fields
> params->h_vlan_proto and params->h_vlan_TCI from the VLAN device,
> and replace params->ifindex with the underlying real device's
> ifindex. params->h_vlan_TCI carries the VID only, with PCP and DEI
> bits zero; a consumer wanting to set egress priority writes PCP
> itself. Only the immediate parent is resolved; stacked VLANs (QinQ)
> are not walked. When the flag is not set, behaviour is unchanged:
> h_vlan_proto and h_vlan_TCI are zeroed and ifindex is left at the
> FIB result.
>
> This lets an XDP redirect target the physical device and learn the
> tag to push in a single lookup, which xdp-forward's optional VLAN
> mode (xdp-project/xdp-tools#504) wants from the kernel side.
>
> The change extends bpf_fib_set_fwd_params() to take the egress dev
> and the lookup flags so the VLAN swap happens in the same place the
> vlan output fields are zeroed by default. Both IPv4 and IPv6
> callers pass through. The helper's input semantics are unchanged.
> Under !CONFIG_VLAN_8021Q, is_vlan_dev() returns false and the new
> block is a no-op.
>
> Suggested-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
> Signed-off-by: Avinash Duduskar <avinash.duduskar@gmail.com>

Other than the bots' comment, I think we should make this bidirectional.
I.e., it should also be possible to supply the vlan tag from the packet
when doing the lookup.

This requires a second flag, which has to be exclusive with
BPF_FIB_LOOKUP_TBID, as the tbid field unfortunately overlaps with the
VLAN fields (so they can't be used together as input).

-Toke

