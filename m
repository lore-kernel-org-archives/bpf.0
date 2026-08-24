Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0248C363C53
	for <bpf@vger.kernel.org>; Mon, 24 Aug 2026 23:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787614939; cv=none; b=lD5TLyR54wPoZzfgYQRel9Wz7kg1yD7c2hkA0TyVyll3zLyNbFg/j2M7AIwZvthw8FFIW/ena7V+iol1dCt7vTqzwXYjB8AKUy4l7p3iAtA161osA4hgm/bjf7gaytaQ/jfMh0iJhlU3byJFvoLWPLC8bnZYimM2RJbZeSltsFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787614939; c=relaxed/simple;
	bh=jM5Mwn50IpG0nkwAZ0goAyRequ6zu8wbkJFKhdanWF0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FBG3qWXlbE0PaomJnqN/l3jTdhe5sM+XMn3m4VXlmm1ebvni3D7348iTGHUcLyCTP+sMl8xtfihhWR5ae2IB1dzE40LwOLkJ8J/r0Pim6XXj0jb2wal5hCY5L7+AH7W/woh+WQMYNMOd+xHIZ4En8Mr+kZR6tLVEj/J8Oka7fEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MCpl4ZG4; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MCpl4ZG4"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-384930ca5e2so3974240a91.3
        for <bpf@vger.kernel.org>; Mon, 24 Aug 2026 16:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787614937; x=1788219737; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=jM5Mwn50IpG0nkwAZ0goAyRequ6zu8wbkJFKhdanWF0=;
        b=MCpl4ZG41vISgfhwyYVGWcWdOTlQRnpO7myKykzZ7kDSqpwSEVaqIM6ZaI4AXbJrKU
         F+XPiSHR0noxtNFz6UGBQndE/M4/5gxR2akuEfcbUTH7xxt8AhPEoXichm0+TP5Qq3Sx
         tZt/W7NYoToNYmVKoHEoz2lZyX5qhUV6sRNEqspFc9T/E6QUVwz1qMav2hmu3GV+BweQ
         Nhmk5bwxj71DsWmBq39PT5rDQ9sstcUIEPpjIzKe2WPYNYWFmJ7nvPNzYR/V1y7j6TwC
         o4KU30J64mddsVtv9qBU4wHFlQzWPgsECE2X5CQtfumN8raDb6j+azwF89wzgnev2wkp
         +1Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787614937; x=1788219737;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jM5Mwn50IpG0nkwAZ0goAyRequ6zu8wbkJFKhdanWF0=;
        b=c33OYazM4Vxo/hupiwf49X4HIjneKWiuUlb+mTrcUX9HRMcHtL8u5dU6BNjgj5vIhm
         d/sxRNGk1FwRrqGvo2CCoYez/xTyTqSVd3Z95x8UGb5LG3RakW7jSQANQUZNLm3dN9n4
         6wqwBze/CPuAKQoVh9umOu5jT316hIL5/eS3s5r/KkDGHMMzRkGxgkpcedBUN1NICVVI
         P6ilm/kZyKxHF5jiqxM6LxEArFKum1Za7QbFYGhxFjq2t/mr2acdMuzVntWhAWTQjWJK
         rTEA4C3cU79PHHUeBlRvGe5gubFer4xA+GXzpp8cSzjQLJCgzf3y2Naz1dl0JnKZeb90
         ERiw==
X-Forwarded-Encrypted: i=1; AHgh+RqPDLisdnOO4cYQNjf2Wx775KVkJkwpcbaPi9ss0AQ2qKHlf/1PvelxrtUM/lYBpVmp0ps=@vger.kernel.org
X-Gm-Message-State: AFuF++lke7vgPtAslM74E76o4YzcSXFr8DgvTZO9ffVfenRON7TFbtLD
	vC4B6bdgOc0KLRYs/MGcZRWmcR7QQgQxGOBfF8d+aDHZnvyNUaqdVIdR
X-Gm-Gg: AR+sD11v8RxHKu8RUH1Ri/g5iV7JKfmZPYRwgNTFOVwEIHgkrLnPsXcTGTdIaty2H85
	EfsRjCkUE/OFwX4A/YuLH50jy4YrfrvqqDeI54H9lV1Vv88BCeaeiL90INeMpcz0IcBtIBaPlwj
	daWgjMhR81N43dnPRNGRYvi8gh6GTx3OihAqtUZAEkW4XV+oTq+kZmO7jBb7HWg3SkY0nPJ54LV
	MQ3PkMVTRchMiXRyDUk93zejcHVkzAAkQ7qsJDDPv1B1uOi8ag24W6NOilcaEn5GEktkwpwP0Cw
	fV2CCvzYePAXLHJfUw/gzbO33dH5HSw8I556t/TmH0ssCznpsX+ADFar1KwNCiVBO5QZljsw1GF
	rZ5mWW2Fx3+lQzyTeOSEcrR9szDqi3j8LEmis71JoqF1PgnyTl1V1R8mC8qCrrib7sFDHEdfd4W
	lYD5/MuFfWGKwK4NPndtP9c3Uweb91niW+LcpDrcpMnnf9uohDpL/u+E6kmNCXVgk6WRH5rgd+N
	vkXdlx5CprYoPx6XNVnjeJ9mGyq5ZHjZAJjp0Jy2wuvhg==
X-Received: by 2002:a17:90b:3911:b0:38e:2860:253f with SMTP id 98e67ed59e1d1-395df2926d9mr38370688a91.12.1787614937188;
        Mon, 24 Aug 2026 16:42:17 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:73a5:7312:7113:7142? ([2620:10d:c090:500::4:5021])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-32801d7f812sm27304916eec.1.2026.08.24.16.42.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 16:42:16 -0700 (PDT)
Message-ID: <6cc90c7eddaf3fd8bf842543efa0eae060c9e019.camel@gmail.com>
Subject: Re: [PATCH bpf-next v7 6/9] selftests/bpf: derive the bench object
 list from the sources
From: Eduard Zingerman <eddyz87@gmail.com>
To: Mykola Lysenko <nickolay.lysenko@gmail.com>, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, 	song@kernel.org, yonghong.song@linux.dev,
 jolsa@kernel.org, memxor@gmail.com
Date: Mon, 24 Aug 2026 16:42:14 -0700
In-Reply-To: <20260823194241.3415152-7-nickolay.lysenko@gmail.com>
References: <20260823194241.3415152-1-nickolay.lysenko@gmail.com>
	 <20260823194241.3415152-7-nickolay.lysenko@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2026-08-23 at 12:42 -0700, Mykola Lysenko wrote:
> The bench binary links every benchs/bench_*.c object, but the link
> rule names them one by one in a hand-maintained list, which has to be
> extended by hand for every new benchmark although the pattern rule
> already builds any bench_*.c placed in benchs/. Derive the list with
> a wildcard instead: a new benchmark is compiled and linked in by
> dropping its source there (its skeleton dependency line, when it has
> one, is still declared next to the others).
>=20
> The derived list is sorted, which changes the link order of the bench
> objects (previously roughly chronological) and with it the symbol
> layout of the binary; no benchmark behaves differently. The trailing
> '#' terminator goes away together with the block it closed: the two
> remaining entries after the variable are fixed, so the append
> friendliness it provided no longer buys anything.
>=20
> Signed-off-by: Mykola Lysenko <nickolay.lysenko@gmail.com>

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

...
