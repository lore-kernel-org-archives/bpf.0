Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D41EED8;
	Tue,  7 Apr 2026 02:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775527737; cv=none; b=ouYvg5DC7ie4C4asegOWm6nFi+PlqpHrQEAOuSpLFA1BrtQluZm8tDTxXlG+UGPJQqF7EDcNzUNKHlmH5tqP9p1+ti2ewBoHzun1CiMnJFjqzS/xE+7ayV77D5cTA+zNOLK4rMtGwjOGE2+O30clAb8R/u0RDc4oRjknedf81hU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775527737; c=relaxed/simple;
	bh=He/fqeGcwQSmgNiVZyJYEsyIDIMjQPKTbSWJEV+kcCU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T3lKmnncjBlf1V/krjrZEAnkPSenrw7cklK9IuWfIIVdxw4Cj12XicSlQik1b7dJ01exNSG0PZ7P2k0xR+v8kSizaukLI7G12xlz/+OJwJOVOqO5+PuOjyufjDl2clCNyc2zcxSKzgQs/xlMyMndzmMwzTunhUOXtJXj6z8+FeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SCwtf8bs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SCwtf8bs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73830C4CEF7;
	Tue,  7 Apr 2026 02:08:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775527737;
	bh=He/fqeGcwQSmgNiVZyJYEsyIDIMjQPKTbSWJEV+kcCU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SCwtf8bsMl12ktsPj3oFIc41TE+oL3ZUtJTlC97i90HEZdaH8X31PgsavVyH3kh6k
	 CCCqFJ/2XHGourzmLkiJRmAfLRskkbx//u9zDnspLyUJJWy70eweGSOZkVwIYbqLGf
	 ygxoAxXlUTUgO93D+H9m/4LbLJkeShPK28qPppBGLoNDwCd2oK/GZDkb7X47QZaZHk
	 8Aq/Ph9PlCkVvCXuCAvJb4hbQNA2U701K8T7huPQWgxAkBNufohNjw58v29o2tFMGt
	 aeImjBNE+hCaCnqJ7xKFrunMecQIm/I3xxrR4QLVV0FPhPVsKGkNO+b+3jvojxvhFh
	 SWhw+PJl2n2UA==
Date: Mon, 6 Apr 2026 19:08:54 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Jitendra Vegiraju" <jitendra.vegiraju@broadcom.com>
Cc: netdev@vger.kernel.org, alexandre.torgue@foss.st.com,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, bcm-kernel-feedback-list@broadcom.com,
 richardcochran@gmail.com, ast@kernel.org, daniel@iogearbox.net,
 hawk@kernel.org, john.fastabend@gmail.com, rmk+kernel@armlinux.org.uk,
 rohan.g.thomas@altera.com, linux-kernel@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org,
 andrew+netdev@lunn.ch, horms@kernel.org, sdf@fomichev.me, me@ziyao.cc,
 siyanteng@cqsoftware.com.cn, prabhakar.mahadev-lad.rj@bp.renesas.com,
 weishangjuan@eswincomputing.com, wens@kernel.org, vladimir.oltean@nxp.com,
 lizhi2@eswincomputing.com, boon.khai.ng@altera.com,
 maxime.chevallier@bootlin.com, chenchuangyu@xiaomi.com,
 yangtiezhu@loongson.cn, ovidiu.panait.rb@renesas.com,
 chenhuacai@kernel.org, florian.fainelli@broadcom.com,
 quic_abchauha@quicinc.com
Subject: Re: [PATCH net-next v9 4/4] net: stmmac: Add BCM8958x driver to
 build system
Message-ID: <20260406190854.13596789@kernel.org>
In-Reply-To: <20260402213629.1996133-5-jitendra.vegiraju@broadcom.com>
References: <20260402213629.1996133-1-jitendra.vegiraju@broadcom.com>
	<20260402213629.1996133-5-jitendra.vegiraju@broadcom.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  2 Apr 2026 14:36:29 -0700 Jitendra Vegiraju wrote:
> +BROADCOM BCM8958X ETHERNET DRIVER
> +M:	Jitendra Vegiraju <jitendra.vegiraju@broadcom.com>
> +R:	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>

Should be:

L:	<bcm-kernel-feedback-list@broadcom.com>

It's not a parson.
Before you ask - FWIW what other subsystems allow in MAINTAINERS
is irrelevant.

> +L:	netdev@vger.kernel.org
