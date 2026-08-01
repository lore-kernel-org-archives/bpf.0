Received: from oss.cyber.gouv.fr (oss.cyber.gouv.fr [51.159.188.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C261D2BE05A
	for <bpf@vger.kernel.org>; Sat,  1 Aug 2026 08:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.159.188.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785573783; cv=none; b=ScoAoPH+CF7cp7Ur2a1gtrpTKcuXxl+6R6I3gQkl7KlKAjqT6lewt6Jh/t5f7a+V4ewIFyHNervv/vP7xOv/DisC8YvVM/H32BWW0L5OootDJjOy92iNuNT/wSGZ2gAWWeXxjaPZPbGZUP1ySCnXRevk124D9hs4Y7z+f/Sr0qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785573783; c=relaxed/simple;
	bh=GlF0biM5iQ8vPuGTpIrBuIvnc5rGXpX+jvNFcDS3vOI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IN2iQjqV8TjEhFob2147cbKd5UVvMXc8imC4N1t1KRqEJXqnkeYJJ10jgU5X5NmfKcnbVbNaCUTlbcPpEFuXt8NPdTt7UsZ+OFCK59iVW+7xO3BIrdE5fr29Euc68cZ9PdgpNl0FAtdhU98fj5qCK5tzak77n31xNwTcev6hne0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr; spf=pass smtp.mailfrom=oss.cyber.gouv.fr; dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b=iTs4/N2i; arc=none smtp.client-ip=51.159.188.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b="iTs4/N2i"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=oss.cyber.gouv.fr; s=default; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=GlF0biM5iQ8vPuGTpIrBuIvnc5rGXpX+jvNFcDS3vOI=; b=iTs4/N2iOo45+WFK1UnbUl2MKL
	6Us1gE9tnw/fu8VxM6mo8715/v7Hm9bQnXDTo0M5sWIDqqKFR9GgY6Q6O6IN09usyRHQr2yCXuCxi
	uebbz2oFDltahRISujwQ9FUgxZiHyoBT2jm/S5//emcirb2W8kFCLTxK6GkRgYdhsAJJwCr/eWT4G
	K5e8R0R3Rxyq4BJSOKC7dCtJxHnUQqsgepDDMPcpZ06ZBnLFkTqVI8vYdCopxk4PrT2NEY0HR8Cq5
	xAynUwHNw+qmGkbAWjDXBjDPe0Ba00i1pTEBtTLjp3l35HwbWq6QFtaor8Qfuc9mBR3PpITxaaWr6
	GGXqFHlw==;
Received: from [151.115.150.205] (port=36650 helo=gepetto..)
	by pf-012.whm.fr-par.scw.cloud with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.5)
	(envelope-from <Jeremy.Jean@oss.cyber.gouv.fr>)
	id 1wq5J7-0000000Ag6M-3Il3;
	Sat, 01 Aug 2026 10:43:00 +0200
From: =?UTF-8?q?J=C3=A9r=C3=A9my=20Jean?= <Jeremy.Jean@oss.cyber.gouv.fr>
To: bot+bpf-ci@kernel.org
Cc: Jeremy.Jean@oss.cyber.gouv.fr,
	andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	clm@meta.com,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	ihor.solodrai@linux.dev,
	martin.lau@kernel.org,
	yonghong.song@linux.dev
Subject: Re: [PATCH bpf] bpf: harden bloom filter allocation sizing on 32-bit kernels 
Date: Sat,  1 Aug 2026 08:42:39 +0000
Message-ID: <20260801084247.4015319-1-Jeremy.Jean@oss.cyber.gouv.fr>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <94c58ce6291cb55387b002e164f06f9888a516a70e55b8faab480350487c1134@mail.kernel.org>
References: <94c58ce6291cb55387b002e164f06f9888a516a70e55b8faab480350487c1134@mail.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-scw-domain: oss.cyber.gouv.fr
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - pf-012.whm.fr-par.scw.cloud
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - oss.cyber.gouv.fr
X-Get-Message-Sender-Via: pf-012.whm.fr-par.scw.cloud: authenticated_id: jeremy.jean@oss.cyber.gouv.fr
X-Authenticated-Sender: pf-012.whm.fr-par.scw.cloud: jeremy.jean@oss.cyber.gouv.fr
X-Source: 
X-Source-Args: 
X-Source-Dir: 

Thanks for the feedbacks, I addressed those in a second version of the patch.

Jérémy

