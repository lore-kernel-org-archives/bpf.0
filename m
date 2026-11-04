Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793759830;
	b=3EVxjxE6wKxt0iq0iSuj/dlUB7+m/IL1AeBOu+RRDK1lXbOsKdEwv76mB9k1/7CHbD4r
	 I9EsyFPFxQAju9vwA8MTfPDJBBjrR204LxBZh3nRg3jmhZjkXZGMT5R59sk00NnCpyCur
	 OC8iCYxbLHrvCqyXzkzBYaPsQRLNBkTOwXeSGgqlAGjZy2S8adV32BRj3UdlnOwi6lfMu
	 KNQlwvHrXYpGMv4/YcpaTg1BBY5k95Z/V9P+WN5IjMVruuLxss+h/5Iee8Q92xEfwwz9p
	 6JuAH/JkOXGO9FwMUukvRA2bmWulnqVwukfM0VF9dbAcHCFJ2NgELmvcMGHrpS1tiBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793759830;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
	 Cc:Subject:From:To:X-Mailer:References:In-Reply-To;
	bh=XLnoIpzSxDFdhKtQb49/oEceTAIjw4HsHtGoP3scKEs=;
	b=PFiaPQYQHx8l0gI0q1uX3rJ+kPQBk0VstZX0rKEhH465N8LgMqcoKxJGs8yANaRFlNyf
	 QSiEPpNsWBjmmtlhzuhPNoXc/+sHIeWN8u8XgzspfdjtA6ejQyFu9MP4ZxlZ/nvxPxqrO
	 YB131osRxnn0glhcnRNOxDQuHwCN78QmMNkjXz8mefc1IidtraSAx0dItxpwuTVHqccwf
	 lrIDVz4i/UxVp2tvmAyJdVht2aaVdtlZpEp/xYp0uClfZGYarL+u8WM8ELV6kukhMoyVB
	 iUV0hP/z/ENNW+sh3QZeB6q4bmk68N4na2IsmnW/Iv9+RrTD6GWPp5O03b2J3Lmst5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="B/go1qXy";
	arc=none smtp.remote-ip=209.85.216.42
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D21606A329
	for <bpf@vger.kernel.org>; Wed,  4 Nov 2026 02:37:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A7D21606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=B/go1qXy
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3ab2cb8d577so244783a91.1
        for <bpf@vger.kernel.org>; Tue, 03 Nov 2026 18:37:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793759829; x=1794364629; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=XLnoIpzSxDFdhKtQb49/oEceTAIjw4HsHtGoP3scKEs=;
        b=B/go1qXye9l9V3znZ4yybm+Oyc2RUzavDN+B6OanfwIX3RaTlFKQXeyca1V7yiLGaC
         fcASchYl0AY2g98Wchnv2Dw/1Q+XjCVcF5fl6CJmbUhuCZ/ULqGK6G7HJEFIWAgv/YFU
         8cQs+UG3rBRQObAzcvpMdY3dzgpHC0qpTYxNeXWTX4iWSljbk15ce4d+S8jaQcrdhBdb
         8ODwXGbV6zQVCafOk9CSkF5eFQ3IRXPnF2HVxSi5PRvLnENwvbCv5nSAjHuVd9rsuJe3
         k/MAeglK7r3fT6iO7/OA4NirLTbI0M/lb2FaH0mWwqR/RI2IrK6pbyJeQUI3U+YqKCDB
         QX0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793759829; x=1794364629;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XLnoIpzSxDFdhKtQb49/oEceTAIjw4HsHtGoP3scKEs=;
        b=xWjnvyMfA7psO5CL1lmMde9M0uZQf1VlHNr2+hBaDeohrUEFGZuOzDE3/Lli6H/o1I
         OzSXgifI5aPuI+ir48Ry3ZEoMI2a9khQlXscM4Bc0ip6wpUVoeQ4Y3G+eTnPojxz6a0u
         /7KdbDwVIBZvT4+oGged3y95ZtsOz8Gxs2ULQ2qp/WCDAvVHUjP0nTddlsW8lbYKdUEK
         s0aOW+2YDFpZyJJmcBqzKVKAJKVUCFe5jS0jYct5wDtfAk70IHy0Klfoc2uLDG6RiczM
         0QiLndiQqxgCcvy3FYmRvU+5Xi4yF+oJOjnTIVTcM1lLpbWKiT3cAcHI2fq+CoRLHJdI
         gDMg==
X-Forwarded-Encrypted: i=1; AKwUvBxCQKOddybZdTNs0KR8oM0Urr5b7XnP61o4sptBccERC2+r7V1Hxy3sR8lauIVF1jmWP48=@vger.kernel.org
X-Gm-Message-State: APuU4Z/0l9LsjoLwu0l9Gj25aN9TCdjSghszJbfKRdaAqKryBDh+L4if
	2EuaeCn+pzEKROGdEmoIQjMBWr8TVOdxTG7rPAY+cTxv/1CEGf0KboLr
X-Gm-Gg: AYBFou0Gqaq7iwlLgd+7BrZfMuN3vq1aMkDu9idQ7rRQE4hmf2sEwF+ckFhMPodMqs2
	EFrfvbWABm5Xg91ar+tvyHa5zjxLJZYtenD3dbmnmIt1S1IoNaAp1MYyUwmePVAdwDf2XAs2Ijh
	6qvcGMvqiRhmRHvexIoAZDioSqxnnOApcRpeUQcvPVUPyuq2cf8L1ev8utWZYQstXvzcUuKQSM+
	W8qdQ1DAM+ykGeGV6S0BSgX6b4SK6GVjofgqs8OmEiTU7TYtanngGNRrwrpA4LqWvNwLog0Mzus
	r6SGR9ABV9BFJxP+IC8YqCSOfL9BUAoOeDI1dho+g/hiH5QkScwNzRx4Fi6BqygmccCvczfK7Jc
	KaZuVLqyhawa2PNVbwXSsosasNYye8clWhaiJfmH1ERF/sdqXHa/O3oRHMQul3R4b9oG+PzReG8
	UYm4rHr1FIO87cC8vb18NmKsc5qfJq0i5fRb6e3fM2TRVtX1p0hfSW3Ux5PnobAph+IHSq4vZng
	FxCXFFc4PuPOQuAqcxeZSGSYUd12hS6lqGL8SivXj9R+Se0/VIavsbMtwz8SQUbXxDRlmU7K8xX
	jF711k4TO8xT/y2L70QhS/AiIIm/oJIRfehx4u2lDpqi4N+liFGpU0m9AFFlNwVpJILF/X3c6io
	4AtnUURYEe48YCNWQSf8ciJ4Wv7z8i2eWmQ==
X-Received: by 2002:a17:90b:528c:b0:3ac:adce:60be with SMTP id 98e67ed59e1d1-3ae897c8105mr12886992a91.21.1793759828747;
        Tue, 03 Nov 2026 18:37:08 -0800 (PST)
Received: from localhost ([153.61.198.249])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b07c7dea24sm6701219a91.5.2026.11.03.18.37.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2026 18:37:07 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 04 Nov 2026 02:37:07 +0000
Message-Id: <DMM2SGQ43OOJ.1QYUMNEVN2LIQ@gmail.com>
Cc: <sashiko-reviews@lists.linux.dev>, <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next v3 06/14] libbpf: Relocate pointers that are
 stored in arena
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Roman Gushchin" <roman.gushchin@linux.dev>
X-Mailer: aerc 0.20.1-355-gf870624f6c37
References: <DMM226XFK9P5.265MSTVAV5QPL@gmail.com>
 <EB1C0109-74FC-4DFC-A25D-DB11BD62EC97@linux.dev>
In-Reply-To: <EB1C0109-74FC-4DFC-A25D-DB11BD62EC97@linux.dev>

On Wed Nov 4, 2026 at 2:32 AM UTC, Roman Gushchin wrote:
>> On Nov 3, 2026, at 6:02=E2=80=AFPM, Alexei Starovoitov <alexei.starovoit=
ov@gmail.com> wrote:
>>=20
>> =EF=BB=BFOn Tue, Nov 03, 2026 at 05:44 PM sashiko-bot@kernel.org <sashik=
o-bot@kernel.org> wrote:
>>>> +    ptrs =3D libbpf_reallocarray(NULL, nrels, sizeof(*ptrs));
>>>> +    if (!ptrs)
>>>> +        return -ENOMEM;
>>>> +    obj->arena_ptrs =3D ptrs;
>>=20
>> [...]
>>=20
>>> 1. If multiple SEC_RELO sections target arena_data_shndx, the second ca=
ll
>>> overwrites obj->arena_ptrs (leaking the prior allocation) and allocates=
 only
>>> nrels entries, while obj->arena_ptr_cnt holds the sum across both calls=
. When
>>> bpf_object__create_maps() -> relocate_arena_ptrs() later runs:
>>=20
>> Not a bug. Only a hand-made ELF has two SHT_REL sections for one section=
.
>> clang emits one for .addr_space.1, and the static linker merges them by
>> name in linker_append_elf_relos().
>>=20
>>> 2. If an empty .rel.addr_space.1 section has sh_size =3D=3D 0 (nrels =
=3D=3D 0),
>>> libbpf_reallocarray(NULL, 0, sizeof(*ptrs)) calls realloc(NULL, 0), whi=
ch may
>>> return NULL and cause bpf_object__collect_arena_relos() to return -ENOM=
EM.
>>=20
>> No. Nothing emits an empty SHT_REL section.
>> glibc returns a pointer for realloc(NULL, 0). Where it's NULL the open o=
f
>> such a file fails, and that's fine.
>>=20
>> I'm replying to a bot hoping that Roman will teach it to learn from main=
tainers
>> and stop reporting such bugs in libbpf where input is trusted.
>
> Thanks, well appreciated!
> It=E2=80=99s going into that direction, now at least it should not raise =
it again in next versions.

Thank you!
