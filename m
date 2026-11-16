Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794847233;
	b=WDJtlm96KFkgs1EEAQT9NxqdBr4Ywy1fBSGIMg0Aq3u3fwqrB7OmPxazcdAd92LbbSO8
	 nheTmy+nt8JhoDNVfyb2JM1RxZ/48wmAKITgAy/WR1dtG0ATKAK8p6sT/M69hMUMA+1pf
	 ISqzeEldvU6Ps8Owlycxx6hiTS3jmId6MG8I4laSJN0CYH0ZuFDs71Ja23bA6rF1Vn3XC
	 D3e4gU7kGasEp0iGSw/1nG74hMkFChg73H9cw7zmZZUBKc05c0csp535SEmgOJDd+BpLd
	 j4YKHDsIHDYZougq5svoMdI5td6YSv0vudjrQcsWLZziE1kH4CdRnBWbEohBAfr8i9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794847233;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=uT9dGfnNHZVYLS4OP43xiMgwtbDlKvr9wQr6PZJ9F1Q=;
	b=w0a86ozqUpdlRpbJ7Fj1fPlcYuvT0/mZQu9iGt5b+xgnPeBR+dN/xL5MMJNlBHcM0BMd
	 dDBdlVsJ0KBVW3cWRlIyiPDtvfMXeWRes+nTPXNHeRDv1vcI/gKqUWn36/25wqmxnfhl2
	 K96nRM9zyI63x2v+ay+by2sh7dpU0xFW4lLjp3tSJRqw3+P1stFa8A6lxbocCY2c2yAL6
	 rcUuYLx3cFpeJVb4IIpOUwV1CktGAQSDSLN82JhqRRRycDpG4tFZKv81OyGoevobSxhtf
	 dDGFLudRdnO0v3ymFwwv16S+wMZKlwbb9jWnH+nvNmJTbqg/fgXNHlIcbpibD0c+JyQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cloudflare.com;
	spf=pass smtp.mailfrom=cloudflare.com;
	dkim=pass header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=NzEwAmtv;
	arc=none smtp.remote-ip=209.85.218.45
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCD82606A31C
	for <bpf@vger.kernel.org>; Mon, 16 Nov 2026 16:40:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DCD82606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=NzEwAmtv
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c445c95d553so528783766b.1
        for <bpf@vger.kernel.org>; Mon, 16 Nov 2026 08:40:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1794847231; x=1795452031; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=uT9dGfnNHZVYLS4OP43xiMgwtbDlKvr9wQr6PZJ9F1Q=;
        b=NzEwAmtvoM5yV4dkf4b+6MKvm7WLzvH6v9s12vspGgBLPj00OvAkKne59SU3I07L20
         A+V3TIOH/E5JH5pA2ZxjJUY2XQqHsFJcFobM2+hcKHuPZPefeM3Ajccs483QueMLHMil
         9GigM5V59gRHT2aT60v7UQn2s534ymS8toIhfuy3hJxo6XZ+1VDNykg+d16Jlp02T2XP
         GI0f0r8LPForYseKQ4cippwMcN6wt3pZDz4dnwuLPs2QFewdxCQItVgAulOJoAr+rC+v
         XmyBEsB3AGVR3dBu0HxBAcTe0C7G6EN0D3t5NRZh5de/tgI1+wryeLQRdcass1mnoRpp
         prkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794847231; x=1795452031;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uT9dGfnNHZVYLS4OP43xiMgwtbDlKvr9wQr6PZJ9F1Q=;
        b=zHK8DlVEGUB6VMdqdIQx+5zXKZB2sKl5IdECpRqwdE7WovvgXxJ5mZuj3P9kVvwtQK
         KtAoBIwpZyrd7j0o+70wUJODo2tu9OKzWoPik1J73CC/JrTwQPtbKOG9e3Na0Hp8u1B7
         pVD64W3kaGlPyNKVstEV7jOcGOI41R08njXz5NHiOnUNhZrzvyzUq62m34BkSfqLltFb
         1gX8gChF2UywVOPihijBLZl4BrVx2w7qCaEcGxrts6n6gapZKbh6rABSM4Yxot7nH5k3
         FLcKOlSkca7YLpHJZQzJ8NgjAwH8XyfjBSK1XzITO9aoLntEqs2jlgbOQX0cn7QiIIZe
         OKYg==
X-Gm-Message-State: APuU4Z9FLByd4CzS352trizCus85m0mA6VE1jMSmUG6Q7zjo8KRE5ID1
	lGOTYNYuVw+OFzujbUxj2ERyEPM2Bb8M8KV2V/dSSYbyuF9hBN8yx2DqwwqlKMWqSi8=
X-Gm-Gg: AYBFou2hfNu8zlU4AcYuNmL01RM/E6dtjr71OXYFSjLgspRT7rP1EQZEHm/JzNOwiNU
	5IZhul3fCPAT9H2lCayIsVMXCnW7SNEKldDgIxf+fZHh4LJPjNvNKlUQyL4PSVB5uYB/Tzg5p++
	7ndM6viKBfwf1Hd4X1+lTbRLwZ9uuB56phSFCfvlk19HMpFA79iFO19sgFCUsoehvq1VQhHYeH6
	6Kt6Bq+SIgS0KKE/3ds7PyDtMXLpGuJv0Lp6EZDcqRM7YW6aWjSjXdYHg3taUgsv/x3Rla/P7U7
	3LQhuYpZJ6TH1/87wa3Fz7BhUBOyfydxvIMa6xlmul9dkcH7MEYI9DJLK6eE80lS7GyCeKF23vA
	VztLHztLkrN9U0geTdh9rbTo865TxUbBVmMgPg6giP27lMVA9O6FA4mc9i8rMZ/AIQZtLn1QpwJ
	9Aam6i7YWVl7h2vgyZKzBRIE0nAT+DIgIekA/ZQLSLAghS8e1R2eRWaAQBXVuWck2xkfMdxrCNT
	Gyijguc5ncFzFwtnnVgCFiUriwg+gwQHQSAdNTmz1DPHaMiKM2gKtpwwIi2pjRZjh44MLdX7F64
	rjk7GaVk2u0JGzY8ojEQeV8csJXxzhAE
X-Received: by 2002:a17:907:d10:b0:c4c:ddd1:cffa with SMTP id a640c23a62f3a-c5096398ae2mr930659766b.29.1794847231194;
        Mon, 16 Nov 2026 08:40:31 -0800 (PST)
Received: from L9JK9NPFH9 ([2a09:bac6:37ad:1e5a::306:a])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c5095b7b2c9sm444919166b.73.2026.11.16.08.40.30
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 16 Nov 2026 08:40:30 -0800 (PST)
From: Tianyi Gao <tianyi@cloudflare.com>
To: sashiko-bot@kernel.org
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	Michal Kubiak <michal.kubiak@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	kernel-team@cloudflare.com,
	tianyi.gao@linux.dev
Subject: Re: [PATCH bpf-next 11/15] ice: set skb RX metadata from the skb core extension area of xdp_buff
Date: Mon, 16 Nov 2026 16:40:28 +0000
Message-ID: <20261116164028.37110-1-tianyi@cloudflare.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <sashiko-outbox-206188@kernel.org>
References: <cover.1794281983.git.tianyi@cloudflare.com> <ae488c057454cd57fb01ac01aefc3e97d6271ada.1794281983.git.tianyi@cloudflare.com> <sashiko-outbox-206188@kernel.org>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit

Hi,

On Tue, Nov 10, 2026 at 04:23:22AM +0000, sashiko-bot@kernel.org wrote:

[ ... ]

> [Severity: Critical]
> This problem wasn't introduced by this patch, but clearing xdp->data before
> checking whether xdp_build_skb_from_buff() succeeded causes an invalid page
> dereference and leaks the head buffer [1] when skb allocation fails:

[ ... ]

> Should xdp->data = NULL be moved after the !skb check (since
> __libeth_xdp_return_buff() already clears xdp->data on the failure path)?
>
> [1] https://sashiko.dev/#/bug/linux-d6eb94b5-df62-4b78-9f73-358fdd002a0c

This is a pre-existing issue in ice from commit 93f53db9f9dc ("ice:
switch to Page Pool"), not related to this series. Cc Michal, the
author of that commit.

Cheers,
Tianyi
