Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C48C934BA5A;
	Thu, 26 Mar 2026 19:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774554127; cv=none; b=uzl18tYPPcKGHyHzEcRpabzvbO7qh/rGO0qXXwyGf/aGG9qDoE5d5C517iEYw5oOkPZjuvN4Z4E7p/YU+0zSLjkkhEqGzaGnoi6qe6U7HAjcgMB2eFK8sCyY07aiS8S73Aa0UsrHYutd7tDHbBidPOL/cxkpUj80iwfxB1xOCaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774554127; c=relaxed/simple;
	bh=2c0nPF3JcBZBuucJxsAUZUSdm1t3EasoLZEnpiiV6GI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o1YzO4y6k/rH5Z6elH/O+LtNq9vsi3Rxrl9CSCodh4QdXcawoC3eAj0A3TcIrksZj8ds3VhDtPkvJ3zmLSqWw00vZRDh3hPAjcPcZWEUTK+bq5dhj1yMcTubfTK4FonMiMeJBQ2u1i/U2CssKsR7z94yuzqIwP6P4sBktbb8Uas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z2+AIPKx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z2+AIPKx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 648C6C116C6;
	Thu, 26 Mar 2026 19:42:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774554127;
	bh=2c0nPF3JcBZBuucJxsAUZUSdm1t3EasoLZEnpiiV6GI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Z2+AIPKxhFJSmMevO5N+1hoPO2EsnUrs8aLgabfyPdBD+QAAHosy/hnFPG8eL1yZn
	 lCeKD1AhktlKKHTM105xkMd2JPEM8w3Vs3zm5MHOswPMXpb+mnFAN11hdkzMbwloQv
	 Stm7AV6g6IycJBtilbKqwQ34mRN+CVdnFU5J2s9A7a2WwR7HFhridzOlBbVO1FUdN8
	 Ch6lK4Hxk/Pu9wA5Ed2O1F4V6yop8rNfgbYd4mPJAHZO8IbeOjtlAmFU4Isn72yhKq
	 cvjzGg58LDdBymtZRnsNARPcYqsUtWZHvnvTpOIprp/QVZx05NsbIffwI/yYVJYk/6
	 OzBBv2fmKOcpg==
Date: Thu, 26 Mar 2026 12:42:05 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu
 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, KP Singh
 <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, Shuah Khan
 <shuah@kernel.org>, "David S . Miller" <davem@davemloft.net>, Jesper
 Dangaard Brouer <hawk@kernel.org>, Toke Hoiland-Jorgensen
 <toke@redhat.com>, Lorenzo Bianconi <lorenzo@kernel.org>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 netdev@vger.kernel.org, kernel-patches-bot@fb.com
Subject: Re: [PATCH bpf-next 1/3] bpf: Disallow freplace on XDP with
 mismatched xdp_has_frags values
Message-ID: <20260326124205.1a3bb825@kernel.org>
In-Reply-To: <20260324150444.68166-2-leon.hwang@linux.dev>
References: <20260324150444.68166-1-leon.hwang@linux.dev>
	<20260324150444.68166-2-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 24 Mar 2026 23:04:42 +0800 Leon Hwang wrote:
> The commit f45d5b6ce2e8 ("bpf: generalise tail call map compatibility check")
> was to ensure backwards compatibility against tail calls. However, it
> missed that XDP progs can be extended by freplace progs, which could break
> the backwards compatibility, e.g. xdp_has_frags=true freplace progs are
> allowed to attach to xdp_has_frags=false XDP progs.
> 
> To avoid breaking the backwards compatibility via freplace, disallow
> freplace on XDP programs with different xdp_has_frags values.

It may be worth adding a selftest to
tools/testing/selftests/drivers/net/xdp.py
which sets MTU to 9k, tries to attach a non-frag-capable prog
if that fails attaches a frag-capable prog and then checks if
replacing the capable prog with non-capable fails.
Drivers may be buggy in this regard.
