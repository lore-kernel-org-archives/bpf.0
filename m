Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E315919F13F
	for <bpf@vger.kernel.org>; Wed, 18 Feb 2026 04:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771388186; cv=none; b=Kwws1BzdykvGy63/u3Bh7+VvjWIpqeN5v8NvMXdhuqG5whaj0nIYo32qcgE7GyjjIO01N33qFqKO40CRpJQGVI2E8EXAsO/zyT9kTwIcwC5ub4m1eSV/eOjBUs2avZoiofpOKurP6GFk+Y/JK0dB4sqelBR9FDyLtuDUwJqrdq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771388186; c=relaxed/simple;
	bh=0+P+y+lElXMF3tTwcsU7YJna11M/GeqMe6959eZffXo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Mlqit/p8JsjseqCdh1SwYnKRUPcuEdTEi06+KITlfIUQqIgHYsL/wxoCdltSmBA1LHLxfWV7vcrjQfHAkmdBKFVQ1sB9LOL6PGBza7kH71ZL6QIoUAGONOqrqGww6y0WMuMilWUT40IGUKFe3Xub55FkKFePxZJPM/Ejzg0Cqi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZcWX9SB8; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZcWX9SB8"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2a7bced39cfso50454815ad.1
        for <bpf@vger.kernel.org>; Tue, 17 Feb 2026 20:16:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771388184; x=1771992984; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0+P+y+lElXMF3tTwcsU7YJna11M/GeqMe6959eZffXo=;
        b=ZcWX9SB8QML/eU3/+e63XKDLUbFoS4mTsNdKfZj1SaZ8v7TX94COFQ2ks5y1EI3Lvu
         WVNSZQgyAL2QjeezySiVmW6pQCAou9cvgTpWFBGBtdksRqXoUIehxUxm/cUOjZq53vmF
         pmTSD6vtPvLcpZBgY559DFvkse7lj9kID9AexbOa0hz3y20VqMnZZrYpOTsKLYDJUCOY
         o6L/uoKlxx5E1jpJJLaxwqbOc901387B4NROAXsgY+UZvjWMQx2A47B7aab05Z9LxamD
         tOJBUbDNvxvrS4+G9kYLRe4dckw4ByZvj07tPpZ13I94MtD9OtLaXRWjFc440ovnbLq0
         yK2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771388184; x=1771992984;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0+P+y+lElXMF3tTwcsU7YJna11M/GeqMe6959eZffXo=;
        b=DF2rTHUweN9B40XDAiBeOD2POoSaZXJNvPCAQ9FKJsaLeTbUoSAE0w0FUE60WcDVcl
         NW8x+iehNHlxOxIBWZibExMCMs3wZUPAVtQRyeolWvDlfV7pMJ09gdN5sHNMql4Ch4Ik
         6Ns+e3g2F8OCssIgtCA2wTX6Te4aneBlxWKymZbQp/bVM0+EEYEVN5sXyt8eOHrqz9du
         gI7wms8dNV4zPp99ZZYRxMw5axXgs89BwHWesled3otSXZqfK5ITckm10lXefmcqtrOY
         2MoLJyeAOSFTzCVKDjNAWf829+o3o/IRRVg19TvWt+RXvTQd9miJCPeW1MiccSgb/Q/G
         jxog==
X-Forwarded-Encrypted: i=1; AJvYcCVNlpno7yfwLXAh6fG2fp6eggeHtNxK9kQFsn3FCVH14p1JsnDVDvuyBZvroRj29vCLtYk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6SROLo0Yw6cZgeJuMYWDkNYlgdOUks/OCPJkQRx15AkpvY3m5
	QUhmDPY+tETcPO8ltw4AKm/lwTiVU7biC6BQGJ9S8meF/YhYtwnwYO02
X-Gm-Gg: AZuq6aIZUB1BVlCNqr7rqAPiUWSEXlaMMm+BMc2S4917jS2o0KZceLedInbiZrSsYtg
	QHlhPP8JOee0VahKsXleE7/Hgy8+nWxTeU/zbsrza0JtS0GvkoYGpeE/tf8dPrt1hJDJB1KyctH
	5r2wdDXMcRR0RRZtgNJIBJfXbWiH0JueAAJHiPVKVIOYbkLIJUVHA2cf1ALFZsJcxKwUiEbWnXp
	SVXkfITWFCcPF/jDqBxKPFt4hmPNcBfky7WOgMbQknduqIqXVKjiiG18yfikSic1BxM4sDMSz9z
	QgwBuKtkt7bmPvR2BYeloySFwAtj7ZaNSZLef77Zow3pySNmJ4/2vpp7kCSiGUn6cbd7adGwBrs
	9Mah68PcbPsenkzacz838ecrP4NY3HOJX9VYZtgPglNEkrq/2GPUaAdefMjiBKxEqNtQLo3Atsu
	v+paxLfZjgzccnrqwg+zjlrRA+bmWnU7OA3Ara7uEHMA+Qt9k1/EelNo+4/FyisZmCWzl5l2kVU
	Is8CvMWch0/846JYPzgHtWIrHGQa5KW0aYnRABM
X-Received: by 2002:a17:902:ce09:b0:2ab:1dad:e500 with SMTP id d9443c01a7336-2ad50e8dd66mr6918255ad.18.1771388184212;
        Tue, 17 Feb 2026 20:16:24 -0800 (PST)
Received: from localhost.localdomain ([2401:4900:c906:adbd:f506:1dbc:e3f3:e38e])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad1a72e444sm123802185ad.34.2026.02.17.20.16.18
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 17 Feb 2026 20:16:23 -0800 (PST)
From: Anand Kumar Shaw <anandkrshawheritage@gmail.com>
To: kuba@kernel.org,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org
Cc: ast@kernel.org,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	davem@davemloft.net,
	sdf@fomichev.me,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev
Subject: Re: [PATCH] bpf: cpumap: add missing XDP_ABORTED handling in xdp prog runner
Date: Wed, 18 Feb 2026 09:46:15 +0530
Message-Id: <20260218041615.35817-1-anandkrshawheritage@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Mon, Feb 16, 2026 Jakub Kicinski <kuba@kernel.org> wrote:
> Why are you populating netdev with xdpf->dev_rx when the
> bpf_warn_invalid_xdp_action() above did not? Either both or neither should?

Good catch -- the NULL is a pre-existing inconsistency.
Will fix it to use xdpf->dev_rx in v2.

Thanks,
Anand
