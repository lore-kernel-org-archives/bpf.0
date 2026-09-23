Received: from mail-dy2-f26.google.com (mail-dy2-f26.google.com [74.125.229.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBDC540927D
	for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 16:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.26
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790180786; cv=none; b=d4O6PAuTMsPVyzRtDH391tdHNdCWcJPDGQzQWg3Ph71aa2jvllkD2ZGv/Ck98MFD64FP6Wn8SSuzRiMbHh7pmK+c9LbUrKt3YPEgcnKuHgg7CoKC3NCQ7hRpMFmV4xgoCgnALnqYGLCz7iT+Dd6Isctb25d0TKJSv8jRcLgSseg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790180786; c=relaxed/simple;
	bh=MyvCKgq9aQpn0gIJgKFmKYVf5PgsneZJP+svjxsKleY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Tt4FJ5RHg+tmYDJYOJKgivspAVhgtHLpcKZQmTwiNrRGsK5BMRckqjK3pMYaPAFA+rfGYboNP3IpLE8LphnT6rwUirSBMVqrIU2OER+emySGCcD63rzGpsISWWGCEpJf9Q7nqB7ZED9TCu5CENTSLi0YVIpl2Nzu2p9aJ0c7YwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V40ERVtl; arc=none smtp.client-ip=74.125.229.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V40ERVtl"
Received: by mail-dy2-f26.google.com with SMTP id 5a478bee46e88-33175556ebbso673542eec.2
        for <bpf@vger.kernel.org>; Wed, 23 Sep 2026 09:26:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790180782; x=1790785582; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=y8hZD8qasz80HyHEbzAv2WZihxPXHEoPoDOkcNqF0H8=;
        b=V40ERVtlFhBc+y8mTua/qCJdCBgiB2sK3RsvJIq4UuJCXiqm6Hqy4m+amZDBW1B7Kd
         LBX4yt8A/h9b2NwnzCWpnYEliIF0VoPFOq8Y2PrUv0pY+0poukiErGNa4Oiy/rE13qjp
         bscXOHd5Ws/avN9NG77UdQABj8nrDkt1OjkfKprLKF3bONsn6tVqPBuPSxXMvdvvlFem
         vV13/p3cEB0YKu27E0WWHMXhczHefGT1eFpfHk5bFIhOAHhkIRGlfab82EREt7zgeg2T
         eFNuo8fPK3VWLY74XKgSCuHDHBsrHhTKtqkho77aiZE8jW10Fb3zCDUqKXBs4VgApzny
         so6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790180782; x=1790785582;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=y8hZD8qasz80HyHEbzAv2WZihxPXHEoPoDOkcNqF0H8=;
        b=Y/FjTuRZqflhwdN/g2BHpupHlyJHXfbAx79SOLH+P/dxvBya008YPydwjGpeIhK8iU
         AofktXLELCthrvJWL58a25HVCZL3TDNEoeQXxhAaPYXj5yP+6lpolGD3TiqjmpmmpapJ
         rl7QMzVrYHoHOssFxDD6XYd75aMti5NEDa36kHNFXsra5NIKB5KwUmigrqn+LT55vPPu
         TgQSBaxTeRgBiMTLfSb/6moaVQGAzI+PrFYCHD2EdNRfXGbN5AAD4FksdDNS+AoVctJW
         MNiruJlNiFVgqyTOxMGXAXilIzsiHZFaknRlLfDABWCqF116+Qdq1Q8jdZLYpNk4MJL3
         uIzA==
X-Forwarded-Encrypted: i=1; AKwUvByoyXREWcdbGABNRerPe7kNAm2mFpxoZJPYZC7Y7SoN6YzbMPjKLul1DkVI0bvO4i++RiE=@vger.kernel.org
X-Gm-Message-State: AFuF++kHaRRJGBvmb4Rx41xDG8wVN0u4yQTDKwML7Vhf4esL5CpILjLJ
	Frv94KAAwLiHijcCiy+VLIvHPEJh74IW9YaZzWUarK2Khl3Xkd02J2Kg
X-Gm-Gg: AYBFou20V75pmAEsASG0/jCPv/tY6IbIHKyJropQB7gQ6U1LVVBMTn0+tvuJgBqIQPR
	NC5hL1ss4OdPD0DvlR5s+CNGU6YMOJre4UCkj4FqpFlpp7yXdbeiiKWuVvTBIvITMXNbLXnx1UV
	3U1BLQUf1b0KLxV8shkD/B1EbIyCWNOQYY5PoZCrQWcEUH+SdmCzkE5ER4TyQEvg8iT0W4osb7y
	/9VcShU+DyKXgT0tpowCXk2do6+bsAB+883DYOfb77u97b3qbIg2nBLkcYVLo1EpVMgEWclzkGf
	zv6UcDkAoTeiz53Z+0NbFYaHpVjk9ZC5bDq4so7gWm8J7LoXMplpqPCrlRPOgIaEotyntmdCELd
	ACsjY/u4Syedb6nE6VHxyJTM/vpq7qbByWeDOuZkqB8lSdDBN8Bs+N0jqGmjU5wh06ND0JP5bmj
	RPbWad3MDs0rqAKAsKXIBnPoEDQhl8nupyJ/RFSPkWD6m+qN793ULwwBE7XTm+SUb4tQ62jk5xt
	iZZn3UiRid9S7IwWXmqGNa1dEpIteSw2EW4xlwmxGO49gd2CptLfh09
X-Received: by 2002:a05:7300:7913:b0:33e:4ad0:4bc0 with SMTP id 5a478bee46e88-33e8c53ad63mr3115834eec.9.1790180781231;
        Wed, 23 Sep 2026 09:26:21 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:c487:37ae:5ef2:4c1? ([2620:10d:c090:500::7:ac0c])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33e96e48e3esm8067768eec.26.2026.09.23.09.26.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 09:26:20 -0700 (PDT)
Message-ID: <df24934c5ecbd70bc35b528b8e58ae668ce02051.camel@gmail.com>
Subject: Re: [PATCH bpf-next v5 07/21] bpf: Explore the landing pads no call
 site reaches
From: Eduard Zingerman <eddyz87@gmail.com>
To: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>,
 kernel-team@fb.com
Date: Wed, 23 Sep 2026 09:26:19 -0700
In-Reply-To: <20260923045922.2417689-1-yonghong.song@linux.dev>
References: <20260923045846.2414643-1-yonghong.song@linux.dev>
	 <20260923045922.2417689-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-09-22 at 21:59 -0700, Yonghong Song wrote:
> A cleanup record need not cover a call an exception can unwind out of: a
> frontend is free to emit a region around a helper or an ordinary kfunc,
> both nounwind here. Nothing marks a call site then, and that record's
> landing pad is reached by nothing at all -- leaving bpf_check_cfg() to
> refuse the program over code its own frontend had no way not to emit:
>=20
>    0: call bpf_preempt_disable
>    1: call bpf_preempt_enable      record =3D { begin =3D 1, end =3D 2, p=
ad =3D 4 }
>    2: r0 =3D 0
>    3: exit
>    4: r1 =3D pads_ran ll             landing pad
>    6: r2 =3D *(u64 *)(r1 + 0)
>    7: r2 |=3D RAN_NOUNWIND_REC
>    8: *(u64 *)(r1 + 0) =3D r2
>    9: call bpf_unwind_resume
>   10: exit
>=20
> The range [1,2) holds one call, and it is a kfunc, so an exception cannot
> come out of it. mark_call_sites() marks nothing, nothing pushes an edge t=
o
> 4, and 4 through 10 are reachable from nothing: "unreachable insn 4". The
> pad is dead, which is correct -- no exception can ever arrive at it -- bu=
t
> the program is fine and has to load.
>=20
> Walk every pad the table names that the edges did not reach, the way the
> walk is already re-seeded at an exception callback. From there the pad is
> code like any other: do_check() never enters it, because no call site
> dispatches to it, so the dead code sweep removes it along with everything
> else that was not reached.
>=20
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---

Yonghong, in v4 you said that rustc does not generate dead landing pads.
Why do we need this patch?

...
