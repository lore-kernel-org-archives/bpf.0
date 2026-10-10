Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACAA636166A
	for <bpf@vger.kernel.org>; Sat, 10 Oct 2026 18:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791655843; cv=none; b=Ua2vb3DYt2VYAVPHP0GW+GXGs20ACgWUZHqCwC36q8utGyIaOpSZ93s00csZWTU5XX0QsEsEvWdAFuutZ7EfxSVaVhzX2ZwEWPXAuF+7C0j3GCmkTiwAn4JHZSMTQaPu8MgA7aj3ADIzuA3uVUiEUKHDgKmMHt2DDyAP/5rKaPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791655843; c=relaxed/simple;
	bh=D4j7jigH3IDJT1uH+JDSltXr5yrzoVriCLkjbvQ0QF4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ljF725kWuuc+xB6CrSA5WonYVOzNtlZysw4G+dMWN5P9frhYxDYNLGzopTMuw5pgws1Fssn/qUgBz3VXbga1SO/uiuMmlQIkgRgHsW2VgD/92OdDeNyRE2gD+IS6Q8V7Q//KjOSYqgL/jumO4ozKaztH9hq+ym3o/XdmB+zma1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=TUXH8nvo; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="TUXH8nvo"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-48c4d870d54so400458f8f.2
        for <bpf@vger.kernel.org>; Sat, 10 Oct 2026 11:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1791655840; x=1792260640; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=D4j7jigH3IDJT1uH+JDSltXr5yrzoVriCLkjbvQ0QF4=;
        b=TUXH8nvoEToTC88b6MhrRj0RWhednvBqmnPF7iYP1ex37EZDepQw9yRqtL84bGiZV/
         mwzezVYqHFyerHlij4s7Zvcn1SwX7fnp/kyjkpBhGPGduxAbWw5KbLi+TYd05a9/0Zpl
         1/wyVT7R3DF5cxfmg7JDeHSiIENMn/6cBTbG2+dUhEb2LfkEXGnMS4o6kWD7rO2l0Ml4
         ytvAY7EEKOpsSwdws5BertXZ7ubaiatEv6kPv8NF6iPQJlBy5gzWbkD+FQOkrrmzPvHB
         07KwmX23wdpsxK9cGvIgukpOAHTcAU37DILhwDzBI3CyKrW8pZ+Vg3rGtEoVk6cXsYI/
         pTsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791655840; x=1792260640;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=D4j7jigH3IDJT1uH+JDSltXr5yrzoVriCLkjbvQ0QF4=;
        b=TO0veww1fUaloHtwOf4S4q9wxzAQrwExCPvf8SVIhCmNdux/79HyK0TGPqszjxWJlP
         zmTMfP1xccPcV+bkat+qYSzAjkwwzUSpx6CJWwJSa8N/Q15IMceHQ3JwYitjAzj7ApkT
         dd/SKOqkNTTPhzqAlHzsDvhYzHOAvYsg2AyQMNr36T4z22EYupSdUxUI813rmReBthGO
         aNyGCcvnFNWNB+oGDPh/cVzFXOAKTCcVL96U4YGzzyLsKtEBCb10idxqIrTMAA4ytmuO
         t+ZJxD1JZDQ5cwY0ur3j4dXWMedw8VIOB54URTkaEObg7yHAhpRVhlxfDpf4nmeybMI3
         qgZg==
X-Forwarded-Encrypted: i=1; AKwUvBy2pZ4/pa4ixSuzg0aFLycozxhxPno8ipdceENOjrIbqcvi+4iChWmHqYdv6ovGriJj/fg=@vger.kernel.org
X-Gm-Message-State: AFq9FYJGyui8cIRwmoiuY0EKcF8bAuc8pGZFI2/8qcuBF7Qq3EMwKPWQ
	Ukw1SLhuXAoN9prCnFrCT4M+ppRQemulwm8I7q+O1+F5uzMkovTuT5obpDkjNL4D09s=
X-Gm-Gg: AYBFou04NYUhWocSFL3QZS7rV6HUz45lFJ8JQ3Y4dAHAOGB2z/i6AJV2TWDYBeJNOOT
	0Lo00M7BZpPsFBenXyvNFYUUHQRrnkvuw7cpB4kHbLoMvTUz+dfg2029/o3LHt5389uvp0ok+H7
	3pQzk0+rBL5XPeHdmfsU1kMwcBduv7D1RgHMkhKASjRDd8hNwfVBTrHBHU0DJW/gzAtnQ7N2y5/
	RwtqIgBW+Z/5jCPzF+6QsGNz9D9AcdyIsfVrOTEFvrPoow7vnMmjUOc2+PdE66dWTTxzN4ndHix
	D1pBf6lW7Renb3BdeHedgcQvzIh90vbBxlP2oRKMCXyOHp0wnQnlhaFiTQUlIjQuCn0b45GNFaS
	JPboGAmCJiUIXKElzsqm28Q3sTKmo+ula4Qbk2Vqmx3TjZGs5WNwXY7fk0YBi5xLmT539EUbkbo
	eSLM7ftVz01eVZDuTVsEt3lzeLQLZlVqqOhQCnF72G/natKlzVWVMNGNibUWhTSZrVFJYKF0p0z
	KRms85Gt7NpH9Uucw==
X-Received: by 2002:a05:6000:230e:b0:487:1f7:f506 with SMTP id ffacd0b85a97d-48dbaadeba7mr7949230f8f.11.1791655839802;
        Sat, 10 Oct 2026 11:10:39 -0700 (PDT)
Received: from D90XRJJJNQ ([2a09:bac6:37af:26d2::3de:5a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48db946323bsm11294868f8f.2.2026.10.10.11.10.38
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 10 Oct 2026 11:10:39 -0700 (PDT)
From: Tianyi Gao <tianyi@cloudflare.com>
To: netdev-bot+sashiko@kernel.org
Cc: andrew+netdev@lunn.ch,
	ast@kernel.org,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	davem@davemloft.net,
	edumazet@kernel.org,
	hawk@kernel.org,
	horms@kernel.org,
	john.fastabend@gmail.com,
	kernel-team@cloudflare.com,
	kuba@kernel.org,
	linux-kselftest@vger.kernel.org,
	lorenzo@kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	sdf@fomichev.me,
	shuah@kernel.org,
	tianyi@cloudflare.com,
	toke@redhat.com
Subject: Re: [PATCH net 2/2] selftests: net: veth: test peer ndo-xmit after GRO toggle while down
Date: Sat, 10 Oct 2026 19:10:37 +0100
Message-ID: <20261010181037.34130-1-tianyi@cloudflare.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <179165459278.434549.1711113374323842550@kernel.org>
References: <179165459278.434549.1711113374323842550@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

On Sat, 10 Oct 2026 17:49:52 +0000, netdev-bot+sashiko@kernel.org wrote:
> [Severity: Medium]
> If cli.py is present but can't run, should that be a skip instead of a
> failure?

I don't think so. Running net selftests from a source tree already
needs the ynl CLI and its dependencies: double_udp_encap.sh calls it
without any check, and the Python tests import the same library. A CLI
that is present but fails points to a broken setup, so failing is
correct. The file check only covers the installed layout, where cli.py
is not shipped.

> [Severity: Medium]
> Does this block change which code path the chk_gro "aggregation with TSO
> off" check below it tests?

Yes. A kprobe on __veth_napi_enable_range confirms that the NAPI is now
enabled from veth_set_features() instead of veth_open(). The series is
already applied, so I will fix it in a follow-up for net-next, together
with the selftest requested in [1]. It will end the block with GRO
enabled while the device is down.

[1] https://lore.kernel.org/all/155aabf8b873bb8cdcafbd6139c42b08513e5fe6.camel@redhat.com/

Cheers,
Tianyi
