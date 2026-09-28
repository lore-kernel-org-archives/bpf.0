Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE8C22D9780;
	Mon, 28 Sep 2026 12:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790597804; cv=none; b=AcOg9A6u9K5FAE3T+bQuv+g4ARn/rjuwfSctBEXjZYuHbiU5VLLNYdo59cASD4tef44pP39veYsBZbqro1SOLWdhrvlw3ddx0FlZfDCocPqH9nUC6aVtLwiM9xcw4fSpGOoztfb/dBcPHeQW9mbOqGVT7hXZpMBlAzosovANGas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790597804; c=relaxed/simple;
	bh=OuWmBA2AfGbO9O6NdK7R0zBcaotzJKjBa8IaakDd9so=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=l/JLb1eNtbL200pwQAYiN8vbJ0FB3crGCchfZMZUe+Zs9wnoBgGrFcmg70aMFsjyyP0OK9Z3ZHqv1rl0xe5l4L24noyFjqy6IZSpBASM9CGP035MYnhf6L2NnM2g029MEgfsW7hiUWlxiSLVVXxqDADYf4Rxrcif/WaQvFAQxbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=moa9aQb3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="moa9aQb3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2A5B1F000FF;
	Mon, 28 Sep 2026 12:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790597802;
	bh=+BPqsEVt6o4S2aBhcJVM3MwO8plXj1e6T8B9ELdlxEA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=moa9aQb3uCCfgmel/5Ls6dMMX8FiDIbpFtAl0OglOc5WQq9twT1qo3F8SrENZSoje
	 t/j4bsP0U5yWAILoh5PLYxgawlHdLxZSRDxX84SWTG7srrTOp3fMnBshwR/c/pcsr2
	 BPBO5oH1Le5OgGV2Ztyb92XBLO/Hp2W2MMO4WmJpBZpRi8D/TJr6r2G4enp1UQgreP
	 G1jiEbXBudwxinLrlCVk7t5aQZCb6a7XjvtW2mloEez0gUUebYBc+X+cNjjSFg4LeK
	 eWtggWd4ipNrb6qAr1teES8bUO8OQ9VQjAxOlZng3NkqCPduVkWmefUoD3kQivOOHa
	 lLk3ffPsllK7A==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: James Hilliard <james.hilliard1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit
 <hkallweit1@gmail.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, "Russell King (Oracle)"
 <rmk+kernel@armlinux.org.uk>, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Christian Marangi <ansuelsmth@gmail.com>,
 Tiezhu Yang <yangtiezhu@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, John
 Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev
 <sdf@fomichev.me>, Serge Semin <fancer.lancer@gmail.com>, Suraj Jaiswal
 <quic_jsuraj@quicinc.com>, Richard Cochran <richardcochran@gmail.com>,
 Joao Pinto <Joao.Pinto@synopsys.com>, Vladimir Oltean
 <vladimir.oltean@nxp.com>, Ong Boon Leong <boon.leong.ong@intel.com>, Voon
 Weifeng <weifeng.voon@intel.com>, "Song, Yoong Siang"
 <yoong.siang.song@intel.com>, Linus Walleij <linusw@kernel.org>, Martin
 Blumenstingl <martin.blumenstingl@googlemail.com>, Magnus Karlsson
 <magnus.karlsson@intel.com>, Maciej Fijalkowski
 <maciej.fijalkowski@intel.com>, Simon Horman <horms@kernel.org>, Thierry
 Reding <thierry.reding@kernel.org>, Jonathan Hunter
 <jonathanh@nvidia.com>, Chen-Yu Tsai <wens@kernel.org>, Jernej Skrabec
 <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, Jose
 Abreu <Jose.Abreu@synopsys.com>, Yao Zi <me@ziyao.cc>, Philipp Zabel
 <p.zabel@pengutronix.de>
Cc: Richard Genoud <richard.genoud@bootlin.com>, Alastair D'Silva
 <alastair@d-silva.org>, Maxime Ripard <mripard@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org, ZhaoJinming
 <zhaojinming@uniontech.com>, Lorenzo Bianconi
 <lorenzo.bianconi@oss.qualcomm.com>, Ding Hui <dinghui1111@163.com>,
 Linkui Xiao <xiaolinkui@kylinos.cn>, Linkui Xiao <xiaolinkui@126.com>,
 linux-tegra@vger.kernel.org, linux-sunxi@lists.linux.dev, James Hilliard
 <james.hilliard1@gmail.com>
Subject: Re: [PATCH net-next v5 04/19] xsk: freeze deferred pool teardown
 during system sleep
In-Reply-To: <20260927-submit-stmmac-reset-fixes-v1-v5-4-feec6c14dd06@gmail.com>
References: <20260927-submit-stmmac-reset-fixes-v1-v5-0-feec6c14dd06@gmail.com>
 <20260927-submit-stmmac-reset-fixes-v1-v5-4-feec6c14dd06@gmail.com>
Date: Mon, 28 Sep 2026 14:16:38 +0200
Message-ID: <87a4p14lll.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

James Hilliard <james.hilliard1@gmail.com> writes:

> Pool destruction calls the driver under RTNL from system_wq. That queue
> is not frozen during system sleep, so ndo_bpf() can run after the device
> suspend callback has gated its clocks or after the noirq phase.
>
> Use the freezable workqueue for deferred pool release. Work already
> running completes before device suspend, and newly queued destruction
> waits until device resume. The pool, UMEM and netdev references remain
> owned by the work until then. This does not replace driver error
> handling after a failed resume.
>
> Fixes: 1c1efc2af158 ("xsk: Create and free buffer pool independently from=
 umem")
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>

This fix should go as a separate net fix for AF_XDP (potentially paired
with a minimal stmac-fix).

> diff --git a/net/xdp/xsk_buff_pool.c b/net/xdp/xsk_buff_pool.c
> index 9d2d94f1fb75..c58f56f24a9c 100644
> --- a/net/xdp/xsk_buff_pool.c
> +++ b/net/xdp/xsk_buff_pool.c
> @@ -337,7 +337,10 @@ bool xp_put_pool(struct xsk_buff_pool *pool)
>=20=20
>  	if (refcount_dec_and_test(&pool->users)) {
>  		INIT_WORK(&pool->work, xp_release_deferred);
> -		schedule_work(&pool->work);
> +		/* Teardown calls ndo_bpf(), which may need powered hardware.
> +		 * RTNL alone does not exclude the device's system PM callbacks.
> +		 */

Remove the comment, please. The commit message is enough in this case.


Bj=C3=B6rn
