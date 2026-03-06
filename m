Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C063932E68F;
	Fri,  6 Mar 2026 02:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772763781; cv=none; b=qzysPCmvKqw2qZCNI2k2hPvXKNFWugzVio5aJ6TJdRBmnEE7XA/x/eioR/X9b7tT0asXkTcXBf8nS5KW7PSCVpCOYRhee4+15qL2ZaPdB/LW5zuH/MFwDo/nhHWxxoHWBCQg9EFbHS/m7f2AoD2ghsUOg6ZyI3ih5qfTwJ2JaKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772763781; c=relaxed/simple;
	bh=IEoxs28u1fVOb8Sor9of1alADUpK2rwKo540PzQDZMA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PBLnVS254HEf10n9htbs4QmWPBQE6MY6TVZBMESOQZ6r581h5c99pCPazgqbJgfbwPEXArraE/oKSP/FKNfS542fN8KWyyHX1viTQ6p4aO3KZ1pCXPDtIU9Z/2BOocGFfWqHlHyWAjh+iAR+jAETF1fPk1GMa8r7SOA2DpiH0CU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nNYEmJXc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nNYEmJXc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44AA1C116C6;
	Fri,  6 Mar 2026 02:23:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772763781;
	bh=IEoxs28u1fVOb8Sor9of1alADUpK2rwKo540PzQDZMA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nNYEmJXcGUiTFqGaAKMlFPgbJDdwIgll1w7/eLfiGe2YboFbaSYz4fMZwe/LXPnXL
	 9ROQT57JQRZ2XLL3AYibHuxohpOr/u+ne2TGtFAdaAo+otNAy55oI13FYSpLB/hnn1
	 hLNgnESxath3GwwhsEvzijkj+oyYjrJwqmqZyJCK3Dle34GNIb+5M6dHCHBgLGLtYp
	 QdV9uvI5ayoBZ9+oV8ykxDyDNxRCg7c7tdvoUAHMtheRyAmxeR4wfjEqeOXHSCkze4
	 00udfcLtYb0Fi16hqD8AgIFzg/344JvGf9CbeSGHLM2Hw/Vv965WAbO1M6bZW8qcmG
	 MAulqEog1+W0Q==
Date: Thu, 5 Mar 2026 18:22:59 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: "Ricardo B. =?UTF-8?B?TWFybGnDqHJl?=" <rbm@suse.com>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, Daniel Borkmann
 <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, KP
 Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Toke =?UTF-8?B?SMO4aWxhbmQtSsO4cmdlbnNlbg==?=
 <toke@redhat.com>, David Ahern <dsahern@kernel.org>, Jay Vosburgh
 <jv@jvosburgh.net>, Andrew Lunn <andrew+netdev@lunn.ch>, Hangbin Liu
 <liuhangbin@gmail.com>, Fernando Fernandez Mancera <fmancera@suse.de>,
 bpf@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v3 0/3] {net,bpf}: nd_tbl fixes for when
 ipv6.disable=1
Message-ID: <20260305182259.0887cd14@kernel.org>
In-Reply-To: <20260305-net-nd_tbl_fixes-v3-0-fde28b30a744@suse.com>
References: <20260305-net-nd_tbl_fixes-v3-0-fde28b30a744@suse.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 05 Mar 2026 18:29:54 -0300 Ricardo B. Marli=C3=A8re wrote:
> Signed-off-by: Ricardo B. Marli=C3=A8re <rbm@suse.com>
> ---
> Changes in v3:
> - Don't use ipv6_mod_enabled() in net/core/filter.c.
> - Link to v2: https://lore.kernel.org/r/20260305-net-nd_tbl_fixes-v2-0-b7=
177db1a9f3@suse.com
>=20
> Changes in v2:
> - Used ipv6_mod_enabled() helper, guarded by unlikely().
> - Link to v1: https://lore.kernel.org/r/20260228-net-nd_tbl_fixes-v1-0-2b=
2a274df9bb@suse.com

Please add some content to the cover letter, you're basically sending
an empty email now. And please read this:
https://www.kernel.org/doc/html/next/process/maintainer-netdev.html
--=20
pw-bot: cr
