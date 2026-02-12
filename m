Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02DAD2E36F3
	for <bpf@vger.kernel.org>; Thu, 12 Feb 2026 23:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770937699; cv=none; b=hOIVCAldwDZSbdI/R1IvPs2SN9HCtNAEmxAH0Gv2H3/544J3jNIokKZ1/PLwpEZR6RqO6OLNNw8zYTbr1nsllGuejpqP110aYdinVBw3+6nqMapAYVDnpK56HTml9/+bKhjXIiFfpMswXqHTzgUD191fQ+sw4d2iUgXHnyNYTFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770937699; c=relaxed/simple;
	bh=+2qQ4Lqt58YN0m8NGbzAX704gO2yCJz3ZLqmn2FvBUI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FYrcMYsCdm47u2kWDolY4ppAUunaA9yQuxhqT1zJ/gfTG5qPt8vrMfxBgkZkRyxuVrSLvfij2LffSaKX11hpH/AMl5UDdeozUlNoV4yk7kdWSXfC6Y6xM/wGF3qmiMJqUqEk2eAKwJ8PZOePwKpC4keyy5oKk8od5UiK3xH4adE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DMZxXFWE; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DMZxXFWE"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2aaf9191da3so2046615ad.2
        for <bpf@vger.kernel.org>; Thu, 12 Feb 2026 15:08:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770937697; x=1771542497; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NWqY5z6+CItkRRdlJX+08xGLqf2S+uEzXHa8ErcapMA=;
        b=DMZxXFWEFBEmWetI+KNI4lMwsDy2HSTB39ft41eCS7U0HkP/ei+JssxyEs0L/WqyvK
         lFhFzWIm2l5Frt/YiWLd+ntybd/dA95BAqaJgidolVwj9pw9FBAT1/gxpC8ENxSDE+5c
         2Eb8wxtULBlermd45xxJYMPG7ilCXY/0z+B3N+31LTMfrNq1AkxkiYVQ2qQgY7uFvpl6
         sGmo50akRDO6jdH/Vy2tDtT/V9xa6k7xZgXOfHwcJzHbDrlAc+GrbZ4Lv6Rs4hyZKN7S
         hkgkbtFH7Wy73NcdaXUu87p8KDiPBn4yYGa2GqN8Bmtrjav6UzogJ356vW6kmuUmmeAW
         pnCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770937697; x=1771542497;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NWqY5z6+CItkRRdlJX+08xGLqf2S+uEzXHa8ErcapMA=;
        b=I3HMfuSRAM82Lpdh9qwAJ7RJiI/Mj3yOtOqfsgh8lq21J7eIAbLMxV6WMl+eEzRAJy
         mhf0gZUHy+plukZq4CzrpJ1WAluKb+mO16FpchA5P6kZlQVhnYhTXcIs8C2kX86c9w0Q
         /iEc5nzOD8uarYmXaNfTMuCEvRODQKbDaxEXZnE1y9DLlzZ3BIupXAMZ3nmot8WbyS/s
         8mwaCk9/Dm0RljroWyWplNKm7Cf7BS3VpyMjG2fhJj/l+cSwU/4BiKkHivsAB3hqiQ8F
         3i9Yw7BxyrSaj6gWi7PlwAX4wobDKOYQy/DFmA6AVubEnvodZ+YezfJc310sLKYtBz0L
         u5nw==
X-Forwarded-Encrypted: i=1; AJvYcCWLThYHUzY0YoG1YNYowOnn+6FyY0AOZ2gi7qRSRet6sK6fJBlIF2vHRLygeKzsfTE0IjU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPXTwLyHe6A3RsBrXIZYoGC7HlstDYv/KNDbPKyyTiOmVTqE5X
	rI2ggu3KAEp6UIiVlar1x5B/6PoKZjpfGbp/3sDV/Tb4vepd24JkszO+
X-Gm-Gg: AZuq6aLePI3XPVNi0mui6RfMh4/scxy4UsCcvMawdlStJMTBd2nPCScp/3jzxEbocfK
	qTRYwA2zqTp+A36Q2b0S8fy1yIh4IU2hQBfHsHtNR/FpvKdG6PneTuzjcyof1oOdX5Tul2ukzLT
	ad3ZFRDysduuvscsvIcI6HluIaRp2qiBrlbmW4BH5fzWigydn3FAbcB+T8EJmGIAYX9nSodP0MZ
	c43q1lI6IUPqEgLuCvdzEunEKQGC5fiMIdSe9M7kVepiUGO070LWC7uYtB6vl0KSoewpotnWjFV
	MziR/hp3KoTC+r+dvWVOPAESB7V0leqmOoQQ56P4kzFJvcKXsFuOS+i96UFjaap7BJvgF0bLyYL
	9BY8XQdMfya2LPQoxKaWFw1nnENEvS3aYzSseX/JqaSEAVAmhace+lImbOQVhZ45XXrG8OTMhtW
	Q80TAUXT1AKrD0Aa4eRAoDJ1YDVyso+SoZ1Uv4NSnjmmQPpJ7JQk0=
X-Received: by 2002:a17:903:2441:b0:2a2:d2e7:1601 with SMTP id d9443c01a7336-2ab4d0193admr4925935ad.48.1770937697280;
        Thu, 12 Feb 2026 15:08:17 -0800 (PST)
Received: from [192.168.0.56] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ab29873c5esm64375435ad.36.2026.02.12.15.08.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Feb 2026 15:08:16 -0800 (PST)
Message-ID: <95a233fe9a6058fb800cd0abca17f79e9bfa0c97.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 05/14] selftests/bpf: Fix memory leaks in
 tests
From: Eduard Zingerman <eddyz87@gmail.com>
To: Ihor Solodrai <ihor.solodrai@linux.dev>, Alexei Starovoitov
 <ast@kernel.org>,  Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>
Cc: Amery Hung <ameryhung@gmail.com>, Mykyta Yatsenko <yatsenko@meta.com>, 
 Alexis =?ISO-8859-1?Q?Lothor=E9?=	 <alexis.lothore@bootlin.com>,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 	kernel-team@meta.com
Date: Thu, 12 Feb 2026 15:08:14 -0800
In-Reply-To: <20260212011356.3266753-6-ihor.solodrai@linux.dev>
References: <20260212011356.3266753-1-ihor.solodrai@linux.dev>
	 <20260212011356.3266753-6-ihor.solodrai@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.1 (3.58.1-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-02-11 at 17:13 -0800, Ihor Solodrai wrote:

[...]

> @@ -2005,6 +2005,7 @@ int testapp_stats_rx_full(struct test_spec *test)
> =C2=A0{
> =C2=A0	if (pkt_stream_replace(test, DEFAULT_UMEM_BUFFERS + DEFAULT_UMEM_B=
UFFERS / 2, MIN_PKT_SIZE))
> =C2=A0		return TEST_FAILURE;
> +	pkt_stream_delete(test->ifobj_rx->xsk->pkt_stream);

This one is a bit strange.
pkt_stream_replace() allocates test->ifobj_rx->xsk->pkt_stream and
test->ifobj_tx->xsk->pkt_stream (rx and tx streams), and proceeds to
immediately free the rx stream and allocate another one for it.
The following seem to be a better fit:

  -       if (pkt_stream_replace(test, DEFAULT_UMEM_BUFFERS + DEFAULT_UMEM_=
BUFFERS / 2, MIN_PKT_SIZE))
  -               return TEST_FAILURE;
  -       pkt_stream_delete(test->ifobj_rx->xsk->pkt_stream);
  +       test->ifobj_tx->xsk->pkt_stream =3D pkt_stream_generate(DEFAULT_U=
MEM_BUFFERS + DEFAULT_UMEM_BUFFERS / 2, MIN_PKT_SIZE);
          test->ifobj_rx->xsk->pkt_stream =3D pkt_stream_generate(DEFAULT_U=
MEM_BUFFERS, MIN_PKT_SIZE);

(I effectively inlined pkt_stream_replace()).

> =C2=A0	test->ifobj_rx->xsk->pkt_stream =3D pkt_stream_generate(DEFAULT_UM=
EM_BUFFERS, MIN_PKT_SIZE);
> =C2=A0
> =C2=A0	test->ifobj_rx->xsk->rxqsize =3D DEFAULT_UMEM_BUFFERS;
> @@ -2017,6 +2018,7 @@ int testapp_stats_fill_empty(struct test_spec *test=
)
> =C2=A0{
> =C2=A0	if (pkt_stream_replace(test, DEFAULT_UMEM_BUFFERS + DEFAULT_UMEM_B=
UFFERS / 2, MIN_PKT_SIZE))
> =C2=A0		return TEST_FAILURE;
> +	pkt_stream_delete(test->ifobj_rx->xsk->pkt_stream);
> =C2=A0	test->ifobj_rx->xsk->pkt_stream =3D pkt_stream_generate(DEFAULT_UM=
EM_BUFFERS, MIN_PKT_SIZE);

Same here.

[...]
