Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3546A2236F2
	for <bpf@vger.kernel.org>; Wed,  4 Feb 2026 19:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770235101; cv=none; b=L2DdpqanPIb0fJy+FUv0OELScSD+gKBZdh11/Poz7SX6agdFKSavQsNmrenvfRiSygtSjIY/yGSE2FcU6oNpntnMN+TTYg6cvbgXLXRgquEMlBi8NURaE49MFBg3FFUWu3cN2WHhRfJi8JQdJv93oSH+XxqKkfngqyWk145IQGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770235101; c=relaxed/simple;
	bh=g1b2ZO5m/s6vlvFm8z5XUDio3uSYEq8eIjTw3jCA0Fw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aTPOjvX/DmwLuSWlmG3Wf278taj5UvAvhfzFjD7LGPH2xXEy0zfPJ5E3dsuyGme3YvgywrjG5ZqPil0dsKMdmu4hHJpn/wIqKOrcbYlZmYwgkngsIn6Tke+gOKyYihqDCp9ZL972eaGGpK08HpZhj0V3ocZar1TcojVfzVMjZY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z7ITvwWL; arc=none smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z7ITvwWL"
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-124a635476fso431582c88.0
        for <bpf@vger.kernel.org>; Wed, 04 Feb 2026 11:58:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770235100; x=1770839900; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3bUR+TDVM9GqGFKKNB1l68HjOyKea5S1gZoFJ5WKIkA=;
        b=Z7ITvwWLUStKNVk35IXMCDHW2FgOMrEcBfc9QP55Rgx3Sw3N/NJBhnB6wSTxWaxFki
         UgW2sD/Opj2utZER+LIB7hdheIgU2lik801kKy3kC7QFT/UA6UD73kh/tiY9I7IryNYr
         nJrbRwcfw4UknyYCcKnM9u+fL7ezlL1lpqj97fpK2Yh1hWdQo3zdhn/3ykjOxwATXeyA
         9qqW1f7U5yFaUu8Ioyu4g9wWKTwlec6SNtkbVvRSSyackgmiBfawJTt2YR0OGB4p+D9g
         DD04vkXX+fVwE8dk5bwu42/GUqfzOAby2TOqI//n5pvPVODrX971AxtATNiDWwgtPczt
         6zKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770235100; x=1770839900;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3bUR+TDVM9GqGFKKNB1l68HjOyKea5S1gZoFJ5WKIkA=;
        b=cCNWrf29UsNLCN2RmGk2NFWqB8ZRiAW/KpIIQaypV2LlXGr3LQt1wXx6D+IzGkHMBR
         ABgqiTCDoUbBL+I99EMT3majbwGrIcAvaEMTLDQym8Eps6AK4UETJdUN3JONOemRMFcF
         U3u9S0z6LjJPytCSnP3K99VtLckkASt0iG69+aC5V35OEYc0fkmVPJOsXbyZz7X7drjp
         Yy4sGgO8t4J2b/1tSczcx6hH10IsOmpdHN0Sbbi5h1t/0PrcXA14L9iPGw+LoMFB6A5N
         QO+BjRU42tf+L3SostERdvqN/aZ+EXnM3croWTnhGjU0Syc5R+MGtd829QRriOi3m4+Y
         XhRQ==
X-Forwarded-Encrypted: i=1; AJvYcCUxjdfBf867peAMJ2DaYt6XDUbV9icwsFugZTYNe1pEtmp17uUuoa09wZvifGfR8WwcMQo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhYZW6J405O/9g0ynwJGNWNinaIsmo6Cf4ZAxf84D06Ii398si
	sj9zPDYE1t/uEodl0fZNlKzO2SFKlc8xiM9b1grIZtCei/HRBMh+Y11a
X-Gm-Gg: AZuq6aK+mmnQ9Gs1LOVp6LhY2d4NSf/XS0vEo1V+XcO0LU7qDgbD2Asqda3xhgpAeKw
	YJDGUhcexvo6S7trM7TDllzIx/AogGMRz9Lxf8Q64mQICtA/S522zar71K9mAUe/43RJjzL3/2p
	+QMCfzOi7MqBX35dBq02mQDaWK456ggZVr71Fze9fjkATl8BvNuCHIMazfkW2BAYJJc0cYXKYnu
	ybtdilB98aY6f3rPth7F7hiNIgPFwWL/z+/Ja5VjfG/uLUO5nb7BrQfWim3S1kMMA+GELS6GATw
	AFOfgltM4I9ok+E9M8w3+6PucuZKo4sLbYLL3tuEkwbFoj9IYoAwmPiOD1Xqi9gEd0co597uigJ
	3V1lAa8KgqyC4YSQp+tBtoZwk9AAFMO/fC+/J9ROsWNNUN0zIESvuN002UcDoVtU2C4uzK4cCih
	baelbSNYP/1b2Ku5MvntnieWoiwHzq13ZObqD62+6FO8VDxq71m0+LNAaaR4GB+xdNsJyR
X-Received: by 2002:a05:7022:90a:b0:11b:9386:a389 with SMTP id a92af1059eb24-126f48e115amr1550214c88.44.1770235100107;
        Wed, 04 Feb 2026 11:58:20 -0800 (PST)
Received: from ?IPv6:2a03:83e0:115c:1:ac05:8e30:1e93:7ef5? ([2620:10d:c090:500::2:5ebc])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-126f503ea14sm2793466c88.16.2026.02.04.11.58.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 11:58:19 -0800 (PST)
Message-ID: <e316e3675ffae5f65f70cfc25d8c5e2522c97e09.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 2/2] selftests/bpf: Add tests for BPF_END
 bitwise tracking
From: Eduard Zingerman <eddyz87@gmail.com>
To: Tianci Cao <ziye@zju.edu.cn>, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, 	kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, 	tangyazhou518@outlook.com,
 shenghaoyuan0928@163.com
Date: Wed, 04 Feb 2026 11:58:17 -0800
In-Reply-To: <20260204111503.77871-3-ziye@zju.edu.cn>
References: <20260204111503.77871-1-ziye@zju.edu.cn>
	 <20260204111503.77871-3-ziye@zju.edu.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-02-04 at 19:15 +0800, Tianci Cao wrote:
> Now BPF_END has bitwise tracking support. This patch adds selftests to
> cover various cases of BPF_END (`bswap(16|32|64)`, `be(16|32|64)`,
> `le(16|32|64)`) with bitwise propagation.
>=20
> This patch is based on existing `verifier_bswap.c`, and add several
> types of new tests:
>=20
> 1. Unconditional byte swap operations:
>    - bswap16/bswap32/bswap64 with unknown bytes
>=20
> 2. Endian conversion operations (architecture-aware):
>    - be16/be32/be64: convert to big-endian
>      * on little-endian: do swap
>      * on big-endian: truncation (16/32-bit) or no-op (64-bit)
>    - le16/le32/le64: convert to little-endian
>      * on big-endian: do swap
>      * on little-endian: truncation (16/32-bit) or no-op (64-bit)
>=20
> Each test simulates realistic networking scenarios where a value is
> masked with unknown bits (e.g., var_off=3D(0x0; 0x3f00), range=3D[0,0x3f0=
0]),
> then byte-swapped, and the verifier must prove the result stays within
> expected bounds.
>=20
> Specifically, these selftests are based on dead code elimination:
> If the BPF verifier can precisely track bitwise through byte swap
> operations, it can prune the trap path (invalid memory access) that
> should be unreachable, allowing the program to pass verification.
> If bitwise tracking is incorrect, the verifier cannot prove the trap
> is unreachable, causing verification failure.
>=20
> The tests use preprocessor conditionals (#ifdef __BYTE_ORDER__) to
> verify correct behavior on both little-endian and big-endian
> architectures, and require Clang 18+ for bswap instruction support.
>=20
> Co-developed-by: Shenghao Yuan <shenghaoyuan0928@163.com>
> Signed-off-by: Shenghao Yuan <shenghaoyuan0928@163.com>
> Co-developed-by: Yazhou Tang <tangyazhou518@outlook.com>
> Signed-off-by: Yazhou Tang <tangyazhou518@outlook.com>
> Signed-off-by: Tianci Cao <ziye@zju.edu.cn>
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
> ---

Nit: Technically I did not ack this patch, just suggested the changes.
     For such cases you should keep SOB as in the previous version,
     or add suggested-by. Acks should only be added if someone sent
     and email with ack itself.

     Anyway, patch-set looks good to me, thank you for working on this!

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]
