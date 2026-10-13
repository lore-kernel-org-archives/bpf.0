Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBCE14756C1
	for <bpf@vger.kernel.org>; Tue, 13 Oct 2026 16:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791909909; cv=none; b=FKDBMaT5Eskv8eJBk3yeohQlX7/z6eXs/JXyAc+88GtUtoTvzioYuj4BKAQ673olUT0jsN2iKRLQ1I3eVsBzA/yBwfcIpSR3Dl7uLf8pjSWqjFwdhcLLtoXg4X/BcXM4OMAo1P2ZrcL8bihMNa0ifozQ0jvx9vylMCQ9Qi9R/Aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791909909; c=relaxed/simple;
	bh=pU+BYfj77J8yxGf0tRLuyGGtGZBB3b8x9dtH8buUP04=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=ZQVnbMjjYdSKoLuF0Oel7Zy1YyxZVexul1MJg0LaEqrcYTR9dq1bNoR33djp8uRYtBYv/Rbmk7xlSh85pqcmWMFJlEnp4oXfsIzol7tg7tS9YNWmDoZEy4p51S+B05gToO5u8zMcaJH06D6BF3PKhx1D9s7BsOosE/wf5MHaGS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OvFqGaE9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OvFqGaE9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26DA01F000FF;
	Tue, 13 Oct 2026 16:45:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791909908;
	bh=/rXWB7j4pkj6oTZ5c9R/SC9WGPsBaVQCC/OrQ2aQaOg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OvFqGaE9WJcK4vbhjMG2gIH+qLt/xZZ6AuSMBu5je967a7PmyxjabOxJfqK4bTiMh
	 rfgcav5bkIHpSaHlMLA3VlyUhWWVUPrmk8actAeBzmFAtBEOxF641zWbFZgdQFDDyz
	 9icP/KXAJdfwlAwztRcFP8dgkut3a5SxcVIBAbbs3NoD3VMkXA6bQu2/dhDb+Fb9yh
	 ooOO79ZIiAt+El44I98RgqDO2R2JIOb3k7CnaSQ7BiQDxOW68ubtlCdLaCOwm3hpmD
	 9SMezqZbOA7SkH7f1bzXRT2xGG2LeVZ4M1wAl4o7s6cYHmkjWTRzPOmAmtHM3YiGyC
	 qy3aTWpcHT3Mw==
Message-ID: <sashiko-outbox-170147@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v6 2/4] net: stmmac: drop split frames on
 AF_XDP zero-copy RX
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lorenzo Bianconi" <lorenzo.bianconi@oss.qualcomm.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261012-stmmac-rx-mb-v6-2-2225050915c1@oss.qualcomm.com>
References: <20261012-stmmac-rx-mb-v6-0-2225050915c1@oss.qualcomm.com>
 <20261012-stmmac-rx-mb-v6-2-2225050915c1@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 13 Oct 2026 16:45:07 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] net: stmmac: inverted likely() branch prediction hint penalizes fas=
t path
--

commit 4d2daa16c79cba581290a2a573499971819eb3dc
Author: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>

net: stmmac: drop split frames on AF_XDP zero-copy RX

This commit fixes the AF_XDP zero-copy receive path to properly drop and
drain frames that span multiple RX descriptors. It ensures the fragmented
descriptors are released without being incorrectly processed as a new frame.

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/=
net/ethernet/stmicro/stmmac/stmmac_main.c
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c

[ ... ]

> @@ -5721,8 +5724,9 @@ static int stmmac_rx_zc(struct stmmac_priv *priv, i=
nt limit, u32 queue)
>  		if (likely(status & rx_not_ls)) {

[Severity: Low]
Does this use of likely() invert the branch prediction hint?

Since XDP limits MTU to 1500, valid frames should fit completely into a=20
single buffer, making rx_not_ls 0 in the normal fast path. By using likely(=
)=20
here, the compiler is instructed to optimize for split or dropped frames.

Would it be better to use unlikely() so the fast path for valid packets isn=
't
penalized? A few lines further down, stmmac_rx_zc() correctly uses=20
likely(!(status & rx_not_ls)) for the valid packet case.

>  			xsk_buff_free(buf->xdp);
>  			buf->xdp =3D NULL;
> +			rx_dropped++;
> +			error =3D 1;
>  			dirty++;
> -			count++;
>  			goto read_again;
>  		}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012-stmmac-rx-=
mb-v6-0-2225050915c1@oss.qualcomm.com?part=3D2
