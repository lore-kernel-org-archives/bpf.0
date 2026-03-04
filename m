Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A7B34D939;
	Wed,  4 Mar 2026 15:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772639379; cv=none; b=fOQJ4bfn2oxieEfFyhi0v3QuEsIT8TZxfcdDJ/Zvc9XiuhM0JFiNHpfRiHIJ7y0QprpW9Wt50Krnv8t/TiZYVcyoxEG9z2oBh/VAhOnL/n/DAekLJk0sFW5o2bZaIwk/KlUqs1Ag1OaCP52VSX7GYKcMamKSpXaey8E8HLHrvrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772639379; c=relaxed/simple;
	bh=iPAF1drKICNggNun7GphaTRw/CcYhCbJrK++qvsvkhw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EcpsD7pfE78j1iso8RbZ771jUdplxV5vMWZOLtL+E2mtfCgzTHYqZV49N8u+fEgXaZTyRoUeoH87MFAp1DRnqeOysv2jqaGBY8PhyoA5DnObIryTsyrxfxfE7S0E6+YdvRyDaZMgVAVcTOfAv8QzDzVAPrZ1HpYpTs5g9YEUUNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B6nxALNu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B6nxALNu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2BBBC19423;
	Wed,  4 Mar 2026 15:49:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772639378;
	bh=iPAF1drKICNggNun7GphaTRw/CcYhCbJrK++qvsvkhw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=B6nxALNulkQaxogDUAvbSdI12+tHQzeiM+xvyrZi3r7vlxedr4L9c8r0LwInk+pi4
	 /4mYJoknWpo2PSUbeRsIo8D4I3aksQTwXUNbYPWclyX46TWAYCUsLNukIjYVKk7F9Q
	 aSW2yCZsZ4dzbTx2oHdiWR/3KLb09mxtI8v6cJZvVpn5MtFPtde8qaSWjieesrcb0o
	 zLFlVvP8c2/T29hWJQh1p5H+4+k/+Ml4msnzwHbCQ48Yfw9FnFHGFMYskwMVqKPZaq
	 i9s0glhyJsmghXa8R/2dfu+MJch4FbY8M+6U/tahL+mkTuMztxb7yO/MOoSOVTm4vU
	 6HKN5cqxWh0jg==
Message-ID: <ba665193-bb6f-4293-b8ca-bbb267e92eb3@kernel.org>
Date: Wed, 4 Mar 2026 08:49:37 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/3] bpf: bpf_out_neigh_v4: Fix nd_tbl NULL
 dereference when IPv6 is disabled
Content-Language: en-US
To: Daniel Borkmann <daniel@iogearbox.net>,
 Fernando Fernandez Mancera <fmancera@suse.de>,
 Jakub Kicinski <kuba@kernel.org>
Cc: =?UTF-8?Q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>,
 Martin KaFai Lau <martin.lau@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?=
 <toke@redhat.com>, Jay Vosburgh <jv@jvosburgh.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Hangbin Liu <liuhangbin@gmail.com>,
 bpf@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260228-net-nd_tbl_fixes-v1-0-2b2a274df9bb@suse.com>
 <20260228-net-nd_tbl_fixes-v1-1-2b2a274df9bb@suse.com>
 <0b52257d-d557-4f26-9931-34c81ab621bc@iogearbox.net>
 <20260302171131.28373ccb@kernel.org>
 <0d7bb5c5-4122-4dc9-b52b-c305591207d1@suse.de>
 <bbee1ce1-0615-4be2-b7b1-a14eaf2afe26@iogearbox.net>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <bbee1ce1-0615-4be2-b7b1-a14eaf2afe26@iogearbox.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/3/26 9:49 PM, Daniel Borkmann wrote:
> Maybe the "fix" could be to just switch IPV6 from tristate to bool in
> the Kconfig, and then once net merges into net-next we could deconstruct
> all the helper cruft which makes the late on-demand module loading of
> IPv6 work.

+1
