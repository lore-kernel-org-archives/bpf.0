Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF5013F7894
	for <bpf@vger.kernel.org>; Wed, 17 Jun 2026 21:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781730672; cv=pass; b=cxkCJ72FcDEcx3dYR/yEZ2m1AB+faTvlL9YDGdurynUgLE/KgxWM6j53PGAsG7b3LqHJFhcQYN5RbQQH6512/UT3WSJQL9Dig7+8ibB3vHnA6v5p3d7FZJvaZ5PqjiHDmogS7QWTAZwdXdgjxL43kh8FD8lGDkgO5Qd9/Vq7BVI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781730672; c=relaxed/simple;
	bh=J40Tvu1rOCL+IK2vrbjXSPatiwaLTLlKb/XEG1NrFCg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=USdR26MGZ2n8uzHBJqfHEtxW26JUi96TLcaN/C4uJMXY86rMKNzesMcys5i4hw6pV11dVjwOTJ5G8WcbxhikgGmuFgSH4uTdITm9PvycgqXobblF6ym5qtERsEh+zzVRx1YekS3ktHE8y0Cmo+7ErFQXGvxBDPIuyisugEwcKm4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20251104.gappssmtp.com header.i=@jrife-io.20251104.gappssmtp.com header.b=NHQjduAY; arc=pass smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20251104.gappssmtp.com header.i=@jrife-io.20251104.gappssmtp.com header.b="NHQjduAY"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-5175f1e0e90so267611cf.2
        for <bpf@vger.kernel.org>; Wed, 17 Jun 2026 14:11:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781730669; cv=none;
        d=google.com; s=arc-20240605;
        b=cdypmR571QCojX7DBEZ0YzOS+nUvDmkPhqpOKb4VKsXw7TOGmGfS7InhOX1OJP4pCH
         zK/z6MOj6PKwGSPK0JcD6NiovItK20uI+PtDZ1TiiQXpa1hws+UTEZ7v49F0OZc6XSoy
         K/Q4+snsj02c48LsI1WOERZ8pjOq5sOO6esAz6KVevaimvnE13cejn9Egcgjpf0s8rkY
         CYaIargALauQSpPIsHPNTkcZidXIM7naV57iN8Fyak3i3CWnZ1i68oy3yTBX9ZHtMEM9
         qviGPaMedM6QwW/fwxBmmSv02Fn1nVwTvCkDxeXXYd4q6U9AtEghhpK6uFHOAmPmEXtG
         2+aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jNsypXk54MyAofAuixyNUwSehIAcko2VU3Z85jm6x+I=;
        fh=JCAP1pNv5i4Ir860HzH/cczr0b4m3Fhx5o3GABFNIrc=;
        b=CBHxvE3zivkMj67I+aXP3LLe05OdI8fTf+e+N+MVXbAQAP5GUH6GHVoqjewqQl08lH
         EC3Ike769rbBJbTWkfhnsN6ke9oFbs2PZUXcEWF4tIY6KGqOWvzNprviH0RxwUZIsPTX
         zJaTKNryI2j6IU6Ah9kXdMoV4pgq8PxEMQDasl4qeN9S6t+k7ZFhtnFOuQFtRBGZcJVZ
         ijgquWWvtVVLHdpICKryvKqDpTKnQlW4+B6SAzZfkVA2CvjvWD3RUkhAHqckw8C5ZRQA
         9rPbaQFpSxWI1geowrFuBnAWn9am2UYMeEis2SgEVGzWqgXCrvHbRrsCt9VlvtJ4kMli
         hvsA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20251104.gappssmtp.com; s=20251104; t=1781730669; x=1782335469; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jNsypXk54MyAofAuixyNUwSehIAcko2VU3Z85jm6x+I=;
        b=NHQjduAYYH3NxfMTEhW/wkQ6Y+kxjRH1azaC1eY0h9ADwdWykju0TWbFX4zCJwywo0
         lDYyY5DZYfHMMdOZscDHHTdfh1feUyCXpWApX78Dcg15h3S9APnhykPtTOOdUw4dgdxA
         Dyo9OnUD0bkVwb/mQZ1m/FRJvI4IvbU9RnVrmkBLKxrrvx5lv0hZ715plWKWW6wsA+nj
         uO8vP11QdD3+1FsOpxjNN5msbRDbV+Y/foSktgNsbZppC+ikNXh8kv/WFChcUtSBoPpB
         4fr7FZQ8/6oXyJC2WUAxFIRwSGAlVQ69/TjMKohKHHpIljuwqujuycWvWzq3+NayKPeA
         sv4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781730669; x=1782335469;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jNsypXk54MyAofAuixyNUwSehIAcko2VU3Z85jm6x+I=;
        b=H3DGryJBjBG0s+hmGCvYtBQIfLJquMntbJ/Lta8BEsJXrKc1FKxDDSDvzzDgyTINDD
         /eXdNBXNImovG4ARF7AbcfunDnE8fxPI4WBiQUo4z7EiPBImwnDOvTGiBP3oJb6xVzyn
         7YOR2MhJgn92dxVOZWoAYpTDthcu6XYTNzFLZ9I10OurVzntUUOS8V319ROuwy64K4Gb
         zqWF7C3vKB+AEEWvjoucmEy5dL5yN5jux9gqUPXyl5WJ+PWKC5aYt6ZtIIjximihYhbX
         21swhvHTm50TvS2t3E5MlAMf4smAAqv2HcwG5yE1mLvRNQ2snCQ0J6qADs7eyciDwNx/
         sDuA==
X-Forwarded-Encrypted: i=1; AFNElJ9TtuKVtnSxEbUPTmk82dMG/lmmlJyjBcuVfSLJgyO01P1Swj2CfYzCRcXenzhLvj6a36Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQJoeH/mMNulEjyYke8MHzWtiZY2uJs2GU99tVHGCbjMi5Zw0z
	bQHUAsbY41L4FkNO/w+exXTSTAP/FVjFV22DK5C7bG6x4TybvDa1FwVKNW39R0NaJFRoNuGOzjD
	ytwDvUi6rqOO+IbJeLKvF9BJyvxm8uE05T4YNBiFAHw==
X-Gm-Gg: Acq92OE/M1ZKZK5aSYm+fDD1lB6qlns7O94SoSArBql3M5HfFummpko77QrFx0Nvjbt
	zCyyY9TcUap7U9JyDseohquZ2CL8gpHlqk8BX6zzGHsr0mC+6+fyGj2/2P2YLv8/uHr5DZtmCdb
	bMWPCf0SbpERcvcEcQI1zPYiyidnPJ7sg+7Pg+kEDmj2gzrKI+w+pUX2qr6HhHKSVq1JRnBuHZT
	WNdeCPSx5iSIF5LTxVY0Jk/fB63+yGG3XArbZAdJ3jwI55Liooq5Iq9zyLW0D2Em8LGT/8eCedY
	mu+J/AMbnQvlpKZjXsDQLrsLS+uODA==
X-Received: by 2002:ac8:5f0c:0:b0:517:5cbe:515d with SMTP id
 d75a77b69052e-519c6f2b40emr8185321cf.5.1781730669446; Wed, 17 Jun 2026
 14:11:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260613183424.1198073-1-jordan@jrife.io> <ajAXF8Nvg91xU4f2@mail.gmail.com>
 <9da94ca2-a479-42e2-8941-b38c1a08566b@linux.dev>
In-Reply-To: <9da94ca2-a479-42e2-8941-b38c1a08566b@linux.dev>
From: Jordan Rife <jordan@jrife.io>
Date: Wed, 17 Jun 2026 14:10:58 -0700
X-Gm-Features: AVVi8CeEoqA4Hb4ot8Vx5adymXrSmujvHBhdKdVYZkDkbwAQc0BBebVHurmB8Iw
Message-ID: <CABi4-ohaL5Sov1rzms+0wT1Dd5ov3e_r6KxX-qOwFBLxrzuG=g@mail.gmail.com>
Subject: Re: [PATCH v1 bpf-next 0/2] bpf: bpf_redirect_peer egress redirection
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: Paul Chaignon <paul.chaignon@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Stanislav Fomichev <sdf@fomichev.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> Agree.
>
>
> For the existing bpf_redirect_peer(ifindex, 0), there are two ways to
> read what 0 means:
>
> 1. If we consider the operated object to be the peer of ifindex, then 0
> means the peer does ingress.
> 2. If we consider the operated object to be ifindex itself, then 0 means
> ifindex does egress
>     (which results in its peer doing ingress).
>
> This patch's new mode operates on the peer =E2=80=94 on the host side, we=
 want
> to "write" to the dev inside the pod to
> make the packet look like it leaves the pod. That fits reading (1), where
> the flag describes the peer's direction: 0 is peer ingress, and this new
> mode is peer egress.
> So BPF_F_EGRESS would be the clearer name; reusing BPF_F_INGRESS for
> what is really a
> peer-egress action is what creates the ambiguity.

(2) is my original interpretation that makes BPF_F_INGRESS make sense;
you're operating on ifindex, so the flag matches the direction
relative to ifindex. Under that interpretation, 0 for "egress" (really
ingress on the peer side) and BPF_F_INGRESS for "ingress" (really
egress on the peer side) makes sense.

That said, I agree BPF_F_EGRESS is probably clearer, so I'll go with
that in the next version of the series.
