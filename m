Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9683D12D74B
	for <bpf@vger.kernel.org>; Wed, 27 Mar 2024 11:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711540697; cv=none; b=BHcY0X0FYXxgJ79Vp6/fX/AiOZBbzpTiqW17KunHU2TWYXT0e3y3uRyEUnZocA2tPP8+TO//CLtorx9WYkTofClifu1tUXkzedPSoa5ylTpBQuWHug5oinYRhiRA4YMc/gALhWYkPnHUUcEfQla/nm6dY3Ymxw449NQtKC8nRls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711540697; c=relaxed/simple;
	bh=yXFOgrp9Mbok60jY0wKqFY2cCYzTnAOOAAjfDm6Q9xo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rJWV9zGaF4eP7KXFYdilW1lKBUGnJyLr3mqDqhzy2NLJOtADx/gpt4SjK6arQOxb01U88adNyeeBGLWk+rtiDCPBUTIk5KpvowietBPzizx5G7W294InlypU/mndOI8AXHEyx7BjDBsGnTlOCrHk6pa+fsQZgbho89Ubb6EsGzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=titzVpoj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="titzVpoj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4BCBC433C7;
	Wed, 27 Mar 2024 11:58:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711540697;
	bh=yXFOgrp9Mbok60jY0wKqFY2cCYzTnAOOAAjfDm6Q9xo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=titzVpojUOXjiQnxRCtfh5KHeIH62GwUw0DY+Jr6y6BiXzGFRyzTyUfgg1AMyrzsI
	 BZRkz+XKs0k1EDhkVO8FYE5hVVF3OuARs1QR15jaxRbm/8xEU2Fpl1ggXmLZDuvj+q
	 Z213JmhILCUfCzE8ke66haPgX/+V+1dbqqYYNor38+XYCps6cvb36iTi3tRbjC+R++
	 YlJZVVqE6/NljtQw6eOGYvfx/CLNa1kA2sNMKvsi+4qfxLEtOD8v1UnG5/2OuFgMdb
	 GQ/WD+lczaokH0p+8af6C4MOML94xOeC1M4I4pqFVCbcZELCBimX5c5Xw/8PpQsNoO
	 FHgSI4WD993Lw==
Message-ID: <5ab89ff4-57c2-4779-bb89-5a1ca23364dd@kernel.org>
Date: Wed, 27 Mar 2024 11:58:13 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 3/5] bpftool: Add link dump support for
 BPF_LINK_TYPE_SOCKMAP
To: Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Jakub Sitnicki
 <jakub@cloudflare.com>, John Fastabend <john.fastabend@gmail.com>,
 kernel-team@fb.com, Martin KaFai Lau <martin.lau@kernel.org>
References: <20240326022153.656006-1-yonghong.song@linux.dev>
 <20240326022209.656999-1-yonghong.song@linux.dev>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <20240326022209.656999-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

2024-03-26 02:22 UTC+0000 ~ Yonghong Song <yonghong.song@linux.dev>
> An example output looks like:
>   $ bpftool link
>     1776: sk_skb  prog 49730
>             map_id 0  attach_type sk_skb_verdict
>             pids test_progs(8424)
>     1777: sk_skb  prog 49755
>             map_id 0  attach_type sk_skb_stream_verdict
>             pids test_progs(8424)
>     1778: sk_msg  prog 49770
>             map_id 8208  attach_type sk_msg_verdict
>             pids test_progs(8424)
> 
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>

Reviewed-by: Quentin Monnet <qmo@kernel.org>

