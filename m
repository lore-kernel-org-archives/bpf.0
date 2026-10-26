Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.228.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793026543;
	b=5Chte+PNhwX4cAvfsHDZoPucri0f64ZtYXhr8CWtlKygt7rOwsKOj/qEhI9ufWGQCHsT
	 nfbbpRR0XfDD7Mxx0YtXJsayomd07Ckv/E7N0Zf5v0o5eicUqXzbhJIDavwZEDFkfTts9
	 IaR8EC8rm520fKmjgjJK8o39ZkEjUvpui2z8ePVfR42NdR+Jcw1ZZttP/B6K6vVvyX2/3
	 Y++Rl81A/rT6KSn/KqRB9F6axV5+G/62+g0BL5G7FyZKMHNFRP7YPDM1vBmDEMC2j5vtT
	 b1xijliTMcaQ7AybSjPEbRxNYWxaKSL0zNv3kLG6djGTuV+GYjVju4UqlL9kU5D3pRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793026543;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=N3UVCZ01NtzZBTQTfy6B2Rj4m9gham0iwhTudNRqEe4=;
	b=sn2uPEzf3Zikqi/2HDdN2/+AQ/tUdmGv+r0F3CpLTlAO42STQ9444IpMLSNmqAPR/Zp8
	 px4Tln37ugnfZobtlXRAhJOPL+RHnF/E+ValGVRegMj6tIcbGW0YWE0UuNssNp/L1Ywqa
	 x3FosBHXMInESzmOIUNvqLMXO1n2aEg0uSYmy8ZsQDyX02P9Kd/R5AkzAz/wYUyvxdTDM
	 HhUPJnDaZlrcg+As9MVc0wrXa039keLZLanb+BVuvQwIMfqvNw95+eqhtwTqdFT0cB/H3
	 yb2BKEMRyjpYEACwBBjLxxoIZ5qJjKXWY03ZCL2XvZ0pNTsLsyC+j4otIA45+AgGfAA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Ya7N+tEq;
	arc=none smtp.remote-ip=74.125.228.5
Received: from mail-pz2-f5.google.com (mail-pz2-f5.google.com [74.125.228.5])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85DA9606A325
	for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 14:55:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 85DA9606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Ya7N+tEq
Received: by mail-pz2-f5.google.com with SMTP id 41be03b00d2f7-cdac05f11bcso225246a12.0
        for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 07:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793026543; x=1793631343; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=N3UVCZ01NtzZBTQTfy6B2Rj4m9gham0iwhTudNRqEe4=;
        b=Ya7N+tEqw7L5wqauN62InhvMjZ07hzBv8z1qv4xYl2l7+7mOtjMxFicn89wJu8WQVz
         pVHjA1mp2HdRtfukIy/YsDoV3KYlr0G5uIegku1JE/42fMSxxJPmKtGDklYBwnkSwnI8
         TElChyK1/vUWAws789Aq0wc2r/GMyal2jK+81TKfc0m73RDr1V5P5Za1VVzQUNCedoqA
         478ec51dXrH/qGDIYhLjmf2T/uMmtN8c3aPqOKGIoiyNNn2Otxpq9Uo4VzNamliEKvoB
         Dg5S3jC5fM8ztd4zHkXjLifKH00SYCtNXc+pmNaBbQtEdgWdBOS4Mg1srpwqPYC9flbK
         aMKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793026543; x=1793631343;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=N3UVCZ01NtzZBTQTfy6B2Rj4m9gham0iwhTudNRqEe4=;
        b=COQxg6psf0NR2yYN7lYHTYvEGRuW2UQVLZ0QbraliZRS/ySmpX4b4OycJHuesG2gTg
         ox7yUZdpy4s312wCcxL4buGSXV2DvkDEtfk3VRzj3j/gzR0EbnyDotU55+v65+Vcc/PP
         X01hA3/VKJSFW89NisJxRlfWYaYyPnGjnzqObkvFuJ6sSBzJ/EcFvtYxjRpaUwBx34c1
         /gdnqKqOYC/HIgyVyA3yHvNvJ+HYYNYCbwfGE4WN0EdAcE3JGphuu/ioorqy9Qc0eGUL
         BS9CZCaUz9EBhRoYVlylIsRhOuNcUjP/pNUf1+NSn9pswKiMRa/e5rBHjaSSfn4mNwUF
         yyNA==
X-Forwarded-Encrypted: i=1; AKwUvBzVve7dl3ei1LX1T7YZQ5O/VQw/ZuFY6mEKwgOLgwsBiQ8r/eyuqarHvYJnXtJPtIOeHWg=@vger.kernel.org
X-Gm-Message-State: AFq9FYJcTdpnyNRk5Jdr8X9ooH0GaykdguQ/iNoIddUpiUOG81jdBoct
	nuUmN5fWk7+hJEZPSFp76orImDH3zoQa+vDJZjqL7hJfRrYe57wV92IT
X-Gm-Gg: AYBFou2qqeHeuDXS0XTAwzT6jGlFCFuygruX2cMMbAcmMQS2AfD6Bq+hB0ScGTeLkfX
	M3BsdKeqd6E2pRg8wLXrkdg6gaS3l8Q7/q6e5YY6zSMcO1u5IwS9wJm7HmJJAjqWeMnufrLc0Pu
	66F50dHj4cPb6qLPVs8Xst5lVrUERAPwPqEVGG9ubTdc8PGqAKX5dP+x8OzN1wSO4MUCbF49y5A
	lChr73MKInJR3zdr39tWH9t4/aDIjDnZa55YctILwamYz+fM4QKrZNRyjG+qcrqMwRCpEpORmlq
	FKxHMxSzoeu7RX0fXBbHfMuEItc2h4VeqgIm2Lu0J3jO30XhsQ50noTea9fs9tSwiyp45oXfsJ0
	7Pcm7JtLvSp7W6hp8po3BkBGwGwkWo7w8boKHq4K0uaeyx5nkteTOm/ZtvelbrdXJ9kxFsnxjo9
	Rd/7gogXT1Sg736+GDxyQ7UCtL3U3pnAzEN1LuKYA+1W5ywHKti/iGgy7l1VFXK29xliSrOdd7L
	2InhOylXP40gMsBRxdFsFITgsQp2I3yrj7vkxQiEFpC+4/pKE+RRXhGpTOZrpivtlKHfU/8pvaQ
	ZgRpB7Mry3i3/ZKY
X-Received: by 2002:a05:6a00:3a23:b0:8a0:1dab:fd50 with SMTP id d2e1a72fcca58-8a367a2e5bamr5994625b3a.20.1793026542774;
        Mon, 26 Oct 2026 07:55:42 -0700 (PDT)
Received: from localhost.localdomain ([240e:46d:2300:286:8580:7ae4:15b1:705])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8a36b469507sm1361172b3a.31.2026.10.26.07.55.37
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 26 Oct 2026 07:55:42 -0700 (PDT)
From: Rongzheng Wang <testwrzwrz@gmail.com>
To: netdev-bot+sashiko@kernel.org
Cc: Magnus Karlsson <magnus.karlsson@intel.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Jason Xing <kerneljasonxing@gmail.com>,
	Stanislav Fomichev <sdf@google.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	stable@vger.kernel.org,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH net v2 2/2] selftests/bpf: cover AF_XDP multi-buffer TX software checksum
Date: Mon, 26 Oct 2026 22:55:30 +0800
Message-Id: <20261026145530.46896-1-testwrzwrz@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <179293961591.3134.5478895656850588086@kernel.org>
References: <20261024141157.59301-3-testwrzwrz@gmail.com> <179293961591.3134.5478895656850588086@kernel.org>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Sashiko,

Thanks for the review.

> Should RX_MAC and TX_MAC be copied here? In this file they are text
> strings meant for the ip link commands:

No. This is a regression I introduced in v2. RX_MAC and TX_MAC are the
text strings used for the ip link commands, so copying ETH_ALEN bytes
from them copies only the first six ASCII characters, "00:00:".

The root cause is that I reused the ASCII macros intended for the ip
link commands as packet bytes. The test only checks the UDP destination
port, so it still passed with the wrong Ethernet addresses. In v3 I will
restore the binary literals and add an Ethernet MAC check so this
regression is caught.

> Should the condition be retries-- > 0 instead?

This check is pre-existing and not introduced by this series. I will
send a separate patch for it rather than mixing it into this fix.

Thanks,
Rongzheng

pw-bot: cr
