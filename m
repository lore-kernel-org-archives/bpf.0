Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794939375;
	b=1gN/cgGYgXD0HNijW2+nA4nHq5nYTmUNUvj+9Msi8yvVNEotMwD0PK1vcD/SDh/MXZ6e
	 AKUKncZs6Ad+1M3ANZjMB4SbF1Z6/rwHvTexBzRXmVT2CgWuOQcBnEu7ixzD0z1OVmNKJ
	 IqBhiVOMS6dSHFV2XAmgqwiiCZOxA0dn3Bk/M2Gd16sFmG86QRBlHPhC7oASSSalEwpQX
	 v027omUYC7Elp7mHeEZKW9mYXxGxibTV7O5lXdwEa6SaZTeqZdQCH3IVRptj1A5muKYnB
	 JPIEsJ0eCpfFqgTe9Dsf3SV6qKGyL4u7jFm0Yv9F+dgtwG3VrESfWyh62797dH/qnyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794939375;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=TUIrBrOTgzgmyk6kl26pUhy9DQuBuGR438tBzebx9QA=;
	b=aNVwwotOwSUpGjbre21Aii/yo19NYl6Dj61Q43TizBn1sCINSuJEuRrESSLVQ53QZB6I
	 QBvBMnp+wPVVjXZhGEPE/IdPdGBLRBhOObMr2G73CQyAVy/prGvzHD2MKQJ5FSvmcithv
	 TfAAkVaPJGPCbi1zlr4EzH3XE2TedpzzamSBh1Y1vnvl1xd3wiuBPn4sC92TL+Rl6EN62
	 Pgv4L4sE84IgtLu1FcZYlNE2WjwGB2oI7ayLsypAXwNJaZSqgALTHklae3RzrLLF/yLjb
	 1TRADvEpyA/fAgNKxbI/GfQ1Y7iqImyuEO41chRVPwq/h/v5nONjjShhUEh31j7FT7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cloudflare.com;
	spf=pass smtp.mailfrom=cloudflare.com;
	dkim=pass header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=ct39gTeO;
	arc=none smtp.remote-ip=209.85.218.47
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D68DF606A31C
	for <bpf@vger.kernel.org>; Tue, 17 Nov 2026 18:16:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D68DF606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=ct39gTeO
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c5075fa7ed0so822678266b.2
        for <bpf@vger.kernel.org>; Tue, 17 Nov 2026 10:16:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1794939373; x=1795544173; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TUIrBrOTgzgmyk6kl26pUhy9DQuBuGR438tBzebx9QA=;
        b=ct39gTeOPqqzNOu1cYN8qIqrSWum8W/cRJTuXbyaGIoTF7sPfa/apC2s4M8rE0OAK8
         A+23IFq5nG4K9NSQb+30CqQxrUoa6Z/gfx9ESzldcPZDqSA9ACPlIEaqUp2dtlH3KIZg
         C1yLdyIoxSXcdnIpaUMXjxm1kfIf9Lrxbmg11g09hy6tOAfzDFwZvEDvslQjQxNMX7a+
         Y5LUiAzzR8UvT29CU0qIIOzqW9P8dxRPw1c/l0+nBikA+21HeCEZ9xk5B0ji2WgdaoIb
         GTgVsCLIYsdzFGUIeJP1n+LmEt80jqvkrdTxId/AvCFMTWOSZLQshm8XlP8QhptUDtzI
         23CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794939373; x=1795544173;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TUIrBrOTgzgmyk6kl26pUhy9DQuBuGR438tBzebx9QA=;
        b=WOiexdsSLgWEK0wO3j8uEhtcl4FTsDVgWXQuFEH/PbfWcwlKutfnSw2wHLcaIf0sr3
         KXk9reDD6Ax3xrcoPNpmN+6nOX2oaQeuetylv5SAdOEObM0jDF0xyCqqenU2cyC2OUZw
         rXiCqJrE366+lMuNDyBFBJV2ILicXgB0WBL1CRtAlrpBXlTLEtvRHLdPFu1/GatMiUxz
         v+nzVUpgwu5OX3/edtCOyb9egj8WXNIZP8du9aTtYAaUPTX0cwPfTYM5Ill+W8gNVy00
         GHVml19MAUzeMgiUw68vqZchjPjh/J45ANPamiTO9+7P0oa04YIBP2WwjiqUW1tRKbx3
         n11g==
X-Forwarded-Encrypted: i=1; AL+hErHiQ/H/CfDuq3GZRPbJzDEvzaYFGUNKYTI4HWKBL93dCnOjN0GZ8oCOd6mFm40pShi70ks=@vger.kernel.org
X-Gm-Message-State: APuU4Z/iLIeMXXlOO7dpsp7gwXjsk2SA+l3BbnxiwLL4i6FGs4oIlSRc
	oWFe1UNzNs5JFbxD/ag4u5YEn8awZ57gMir9gvf44Z7LzbhdNawelV8Ox82sxZrdPrg=
X-Gm-Gg: AYBFou1Keh7O3z1KRcI2nMIsD6wye3R0p4drDaTTpJiBuY9a62AgYEGWf0OGD+N8GQU
	YjN0vJ3nONfHFsvZ1hBKU61R7qDiF5vNydvR7g579WHbgmsGJ8utflnPSwU2bdMHFGKm/yeFgMG
	ZNppNcX2nbad2Ve71LNdeqEnJ0eobB/MVKxEf7wg+PdKDV4cnNCgD28wlrXlgFmVldFxSrtnohU
	KVkgURoF4Odh+jI6e3dp35gtI/KrSKwEAPiTDEQUDzpCoAtDxs88mqgTUiMsDYM7gMcLgt1OlUJ
	u0gIx+1BU1NxHubkVcqt/d7geM1iVAwgdiRt1gh0GUE6zcWr/wqkbhGp88ftadPV7r3epa76I8R
	YglL+wvt05XCru+lxtL+a2tKDr0JsIHT9rjYVY+o/ytM2I7x+aNBYCRroayROH014Wsozx88SYg
	PNKq3bUtOxLN/vtytwbf2JLMkSgZQLM8lwxeHuge9QkyOiCGoMWmM5y6xP9TYSZPqzUMaKahPdl
	a4BeGUl/YxNrcmwTp25QTMpk8ZV78D+iQRH382oOV8kucpMVx8HUqCar/gt8gh+GfjmDv53s66B
	KpiBfh5V0s0RZ0D8D+yasCMIBVMMG2zT2MDdH4s9026uBKc=
X-Received: by 2002:a17:907:d7c9:b0:c2e:63ba:1f90 with SMTP id a640c23a62f3a-c510e58731cmr7270066b.48.1794939373210;
        Tue, 17 Nov 2026 10:16:13 -0800 (PST)
Received: from L9JK9NPFH9 ([2a09:bac6:37ad:1e5a::306:c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b886a7d7b2sm93434a12.6.2026.11.17.10.16.09
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 17 Nov 2026 10:16:11 -0800 (PST)
From: Tianyi Gao <tianyi@cloudflare.com>
To: Simon Schippers <simon.schippers@tu-dortmund.de>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Toshiaki Makita <toshiaki.makita1@gmail.com>,
	=?UTF-8?q?Jonas=20K=C3=B6ppeler?= <j.koeppeler@tu-berlin.de>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@cloudflare.com,
	tianyi.gao@linux.dev
Subject: Re: [PATCH net 1/2] veth: wake a stopped peer txq beyond real_num_tx_queues
Date: Tue, 17 Nov 2026 18:16:05 +0000
Message-ID: <20261117181607.30219-1-tianyi@cloudflare.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261113104648.225983-2-simon.schippers@tu-dortmund.de>
References: <20261113104648.225983-1-simon.schippers@tu-dortmund.de> <20261113104648.225983-2-simon.schippers@tu-dortmund.de>
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

Hi Simon,

On Fri, Nov 13, 2026 at 11:46:47AM +0100, Simon Schippers wrote:
> Fixes: dc82a33297fc ("veth: apply qdisc backpressure on full ptr_ring to reduce TX drops")

I agree with Sashiko on the Fixes tag.

I have reproduced the stall with your script (stuck after 2 cycles) and
confirmed this patch fixes it (all 30 cycles pass).
It is tested with veth from net at 5e9b2ad9b838, as a module on an arm64
VM with 8 vCPUs.

Reviewed-by: Tianyi Gao <tianyi@cloudflare.com>
Tested-by: Tianyi Gao <tianyi@cloudflare.com>

Cheers,
Tianyi
