Received: from mail-pz2-f1.google.com (mail-pz2-f1.google.com [74.125.228.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5863438039
	for <bpf@vger.kernel.org>; Mon, 10 Aug 2026 18:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786386955; cv=none; b=CbtGT7P4u0DPXCEQzHfbvW/bLEUPiBcv/PyxfouDRJ2da7WBSI7bBs3Ad9KXgLf3ZnRM7dBb8SglS5RcIVauRqU4UAHWaQ8ldo+rYDQdnEJpgoWKxjpG2xBl1upvxwiIAWg5E13BCt9sNdKDiXwUa3qEhSs3OQmB2xZy45RQ90o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786386955; c=relaxed/simple;
	bh=4IVWRcLRZXG5mOOKciVTw4By5F6dI/gIUOH1wHmHPOM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hU/jewD8Uprsoxj2McbULLrpstVfxEQKcNihf8WBexebjIAibYiNn9Y3iYQF9TNURf3o3XFb1zF6tai/CqoAwLsoJKgmLu7DiNNHHwpDgnyBuA7LfAiNEFWDgkpnstS0LaisQByjLG9zSWuQB4rXk4/pdyqow2SVL0a/RThqV9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CWxtYVLR; arc=none smtp.client-ip=74.125.228.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CWxtYVLR"
Received: by mail-pz2-f1.google.com with SMTP id 41be03b00d2f7-ca7d1dc4554so1183442a12.1
        for <bpf@vger.kernel.org>; Mon, 10 Aug 2026 11:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786386953; x=1786991753; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=23HKfRQ9BSobiUbEA/UGqys9deBbbeVTQfHggJ+Eyd8=;
        b=CWxtYVLR8K1ee+JDl+OqCfKgRTWRwm6T2zI0d8Qcs01TPAqZJmKVdr4XIq9VXFjc1U
         q/bAEL57zgZpwLrSc+6GApejpEAG+RN6ISCq57ZVhe7nCOzuJ9BYH6EkapUVG7M7L7RE
         mgJag8bJ8RbfpQh/WK2DWGbP/rNZp0egkNErjj4U6DKAADg/Hygvw9anYG1HSqhuNekb
         En210g5U9eTe/pkw4+GPC/vT8DnucQGS//2Kj5OIGRSRUciBRQzie14pzE+lo1m0WfNZ
         WNMADJyajy/kRJPNFdYaZgWQ6UliIshr6gmOE6Z47UkPw+T/hucZ633q6vMA3hWGjRLp
         RZYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786386953; x=1786991753;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=23HKfRQ9BSobiUbEA/UGqys9deBbbeVTQfHggJ+Eyd8=;
        b=c8BIBgHjAQCXg3RN2Og/oAlBFPLyFiZrwtzI/4op9kci8H3udbK8tEjHuSvrSGLjvF
         X4/zL4f+g5GA3NxeIajg7rszHjZtHxyOjkH6WO8rtywe84gxycx8o1iXAlVAyDp6KkIB
         wjIxQURVp9hkD7zrxiKtBjgrvPmKG+Rlk3XbcOp4ob2/sda+TeTCzJsGO0a/Wjf06zwG
         485FqUjqxwiv9tN9wut/ivP7JIQrmw/9dDAgthTLthp1F3vs2rMW5Ro8GtAB9mPmory5
         peVpnFznxQjlgsHCmqUBHbnzq4sdRLhULrGSgRkv9gz7Bu27oYm5w0/r65GllyZkOEFH
         ZSSQ==
X-Gm-Message-State: AOJu0YzaVqGsEONHi7sWG1z76GmuIF4rLrV6hj358ZfCfWvz4I+ETVqD
	G9NmuJZTMbOnkyiAWGxS4nbF2vRph470AAHrKukb7Pb0z3yD99Wqw9oC
X-Gm-Gg: AR+sD113CBGdjYhcjpZgsNgKvXmrXAQYbv1pV71LMrvVpJ5MqlMcjq7+lvSzFyJY5J2
	5VXuODHwCfioHpqc9efKl+YYxqOYFHiXCn0CxuSl88S4OUiVuBtFpiwxzzy43T7jSV2hM5YQ1Cz
	ynsubrzFfBdBudphRqlI24TGT7GKSdi/jaVeaDr4O5WqZxYtuXJtePlGPN3SS/PQcfdov8TP27R
	vnPqpxVQKn6KjEqLbhvs110pWaowwxymu3ZHJDOUSbmx/mgS5XcaaYeFIjldMYPZn3lkr9z23qQ
	okJBizNVSky/HOGJkZZjZLUtPb7VMCalSblOpnx9duCHYBV2IW7v5A6eIPnm+5ByS0gqOBv3NbL
	ZVqsr5iRyduNbhmInJqU+CkX2X8uWYcS7l/fVwvaKk0bbryCV4dkAWWvjbRyiH7YD3+un/657kM
	b/SEyKh/H+Ip4ybd8HiAt7NzGGkgJrTYUsQe0J4+yDuXOUHv8lp1yU
X-Received: by 2002:a05:6a00:2d0c:b0:84e:2382:f4f0 with SMTP id d2e1a72fcca58-84f2dfc8ed4mr47552336b3a.4.1786386952925;
        Mon, 10 Aug 2026 11:35:52 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:3::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84f5a3a18a5sm4308106b3a.8.2026.08.10.11.35.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 11:35:52 -0700 (PDT)
Date: Mon, 10 Aug 2026 11:33:58 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Mahe Tardy <mahe.tardy@gmail.com>
Cc: bpf@vger.kernel.org, andrew+netdev@lunn.ch, andrii@kernel.org, 
	ast@kernel.org, daniel@iogearbox.net, davem@davemloft.net, eddyz87@gmail.com, 
	edumazet@google.com, john.fastabend@gmail.com, kuba@kernel.org, liamwisehart@meta.com, 
	martin.lau@linux.dev, pabeni@redhat.com, song@kernel.org, netdev@vger.kernel.org, 
	ameryhung@gmail.com, kuniyu@google.com, memxor@gmail.com, jiayuan.chen@linux.dev
Subject: Re: [PATCH bpf-next v5 1/5] net: Add connect_socket() helper
Message-ID: <anoZjx8Y4IH-hydj@devvm7509.cco0.facebook.com>
References: <20260807171532.125149-1-mahe.tardy@gmail.com>
 <20260807171532.125149-2-mahe.tardy@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260807171532.125149-2-mahe.tardy@gmail.com>

On 08/07, Mahe Tardy wrote:
> Add a helper that connects an existing socket while invoking the LSM
> hook. Reuse it in __sys_connect_file() to avoid duplicating the connect
> logic. Other socket operations have equivalent helpers that trigger the
> appropriate LSM hooks that can be reused, this one was the only one
> missing.
> 
> Acked-by: Song Liu <song@kernel.org>
> Signed-off-by: Mahe Tardy <mahe.tardy@gmail.com>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
