Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0EE73B2FE4;
	Mon, 27 Apr 2026 10:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777285396; cv=none; b=RiiHA2V5dPtBGgCitZs/hnOgW1ZCM7T/FKMZoGrzBvUXDMSHx1Cdq4ZumNUeebb/e2vssniyG1thtWS/EMhShWSU6M0DAM342XJBNAnQW09Hgbm6Y8n2HjLSYxpPUEbqbq5T22pd99AeU10fC64Mj0kxXAYcCEHvXuJIKuNrkRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777285396; c=relaxed/simple;
	bh=KYNnnw4HiGNPcsaG3tAwbVMKywNDqyNoJ8d6WUHUwkI=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=XYMBpYFb8ntZwZnf8tvfAvotDV053bS0ryYrzchoPEPKN3ZW0rcqpgBA8H60hs43RNGQ3BA82op4hqBtEvCHLpWvo1VK6dyL0UtQMLQCwci1tHnwdkW0P8ieY1ElS6PCyUhvKmQIgLZ6Kb2CCI0H75VBBQ+xpDj0NXc00L1htcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GQ8RnrP/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GQ8RnrP/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58E74C2BCB4;
	Mon, 27 Apr 2026 10:23:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777285395;
	bh=KYNnnw4HiGNPcsaG3tAwbVMKywNDqyNoJ8d6WUHUwkI=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=GQ8RnrP/r29khRiMqh9xxp8xY2wRszQKkVTZE5jneGn1ZfipXp2IWihCgRbltBi7r
	 pXsSkAZA7VU7YUXgEroBmbLr3O5ZxFcThU0iP0amusqdloKu/k2l5ugpytSkQrQuNG
	 XlQEs0aWMqDKATXN+qeuhbhJgwRcKEuB+IjU7CSgwmIc/xPoHZliV6wFd6+0eZHGUp
	 WWB4Z4vywtpW3/44/7XK8pyjQX345e9/+HGZFrPiCPMBKw/q+O/cI0s1mj3fpA9nfQ
	 714ZB1FbC/3tiWW69MLwHLSLX2sTetroO1IOxiIsVUq3tLJ1Qg2Y1ClJ1NkGvcD/ry
	 oQct3Lfmws8AQ==
Content-Type: multipart/mixed; boundary="===============3666957595155164308=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <7d8dab98e0e2d4f4f67b1e2d24c900f35b951ddfdf46c0aa32409c5f34f76fc9@mail.kernel.org>
In-Reply-To: <2b156bc4277a9e891f3399935416701d1f9efd7c.1777276241.git.linpu5433@gmail.com>
References: <2b156bc4277a9e891f3399935416701d1f9efd7c.1777276241.git.linpu5433@gmail.com>
Subject: Re: [PATCH v2 bpf 1/1] xskmap: reject TX-only AF_XDP sockets
From: bot+bpf-ci@kernel.org
To: linpu5433@gmail.com,kerneljasonxing@gmail.com,magnus.karlsson@intel.com,maciej.fijalkowski@intel.com,netdev@vger.kernel.org,bpf@vger.kernel.org
Cc: sdf@fomichev.me,davem@davemloft.net,edumazet@google.com,kuba@kernel.org,pabeni@redhat.com,horms@kernel.org,ast@kernel.org,daniel@iogearbox.net,hawk@kernel.org,john.fastabend@gmail.com,bjorn@kernel.org,linux-kernel@vger.kernel.org,tanyuan98@outlook.com,yifanwucs@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon, 27 Apr 2026 10:23:15 +0000 (UTC)

--===============3666957595155164308==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> commit 6df1a89cfba973e50ce1bcafe9ffe818f3de7c06
> Author: Linpu Yu <linpu5433@gmail.com>
>
>     xskmap: reject TX-only AF_XDP sockets
>
>     XSKMAP entries are used as redirect targets for incoming XDP frames.
>     A TX-only AF_XDP socket lacks an Rx ring and cannot handle redirected
>     traffic, but xsk_map_update_elem() currently allows such sockets to
>     be inserted into the map.
>
>     Redirecting packets to such a socket on the veth generic-XDP path
>     causes a kernel crash in xsk_generic_rcv().
>
>     Reject TX-only sockets during XSKMAP updates to avoid the crash.
>     They remain fully operational for pure Tx purposes outside XSKMAP.
>
>     Fixes: fbfc504a24f5 ("bpf: introduce new bpf AF_XDP map type BPF_MAP_TYPE_XSKMAP")
                     ^^^^

Is this the correct commit to fix? The original commit fbfc504a24f5
introduced xskmap WITH a check (xsk_is_setup_for_bpf_map) that prevented
TX-only sockets from being inserted. It looks like commit 968be23ceaca
("xsk: Fix possible segfault at xskmap entry insertion") later removed
this check, which allowed TX-only sockets without Rx rings to be
inserted into the map, causing the kernel crash.

Should the Fixes tag reference 968be23ceaca instead?

>     Reported-by: Juefei Pu <tomapufckgml@gmail.com>
>     Reported-by: Yuan Tan <yuantan098@gmail.com>
>     Reported-by: Xin Liu <bird@lzu.edu.cn>
>     Signed-off-by: Yifan Wu <yifanwucs@gmail.com>
>     Signed-off-by: Linpu Yu <linpu5433@gmail.com>

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/24988517198
--===============3666957595155164308==--
