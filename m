Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC65125AA
	for <bpf@vger.kernel.org>; Wed,  1 Jul 2026 00:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782864629; cv=none; b=W28jI7iTbwnuJuh4Uu5B9AU9jY81M8Ht6XQSJBCeJ9dErXsBULnKb4Mlua31hHEF8xNkICgzy0ppqFyF/1zxNpBLLF2by/2jj2bi7NjKN7QzPxWyValImw27lpeq79kepv5HGwBui+zG1rU+bRXwed1RcBCYME16V16eo0hq6OA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782864629; c=relaxed/simple;
	bh=h3OPAHc6C1XvzxT6cx8e7622PtDg/GnQUlgHe9kP9os=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QL7AaZl0lPltgNtrWmqAXb52C07GW2D10zSbW6eKMXG9rmd5J9IEnzEsZUXdAnzPy0kqcQXl675O34X/o0Df2oF/zjph1/vUMYE8scLep8e2aLj/3wZibu1eCZboE0+WEhvr88l0YGIi8SxUsUt0c+QEeG2H2DjFEqYDVDIL+5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sZnry86D; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sZnry86D"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-37defb2f231so41222a91.2
        for <bpf@vger.kernel.org>; Tue, 30 Jun 2026 17:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782864627; x=1783469427; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5qbc/GpNfKXXWiTDBIO3A45WUQ8ek6nJfHhq11a1Wyk=;
        b=sZnry86DLFBVU4Yx86holz0W0Pn1Tgh9/UD1qG2Y7D0Km2njR33nHiDuI5c5Mf5YIQ
         kpYn/NaglyUFNJJXpM9xmpUrMXRpeVQW4CZ/EDKthWb6xKD+MhSa2lpxqs+jSWgXDW0C
         0t54qjCUuhDsQFdU3pwGXmdh0OSThbjA/MWJUE4P7uON/msuds+BixO31wIh0K1kg2xc
         Ug5GAOOaqwvk3/w7c4Bkj6fvn6nmC/qfrecLrH2q9X8/QemCRvri96a7E+DQBZ7rT2vu
         gofjkdPaFHgbuz4xrrIZdVC5XlU+HbyYe/mD6ZHeh9+rv5bVuVp79NNeXuQtlUt9vQhn
         ymDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782864627; x=1783469427;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5qbc/GpNfKXXWiTDBIO3A45WUQ8ek6nJfHhq11a1Wyk=;
        b=FVR4BFWdWAUS2GiuKywb7RSMSg5e9aNYJWNpRpjW2naQqVU84EGyz+9y4CheE+Rn9K
         Q/fgcV4l0HyBXX7cQRQ63xja+l6wv6c1WBZHCAit2VtOeqk8Ao/0UEBCu3N7mEhrb3Vm
         meQivkEri63WZAEzTXNu+jf1FR4uCm64YZYgAzlZGLlNHX/SyAjmmGIzrXjWlHNQEnJK
         mPFKy2MBDlaX2pQJAGpTuy6STGe9wJMVbbs87AhHL/FXEfR83TCGvDkkMfFeZXl3Tlal
         JhDkvQHd54brpPfr+y3xzTaRs/ACXHn/BnLaUTZK1t65FmXzGg12EwV1Z51kRklFLV2h
         3bZQ==
X-Forwarded-Encrypted: i=1; AHgh+RqYJaUtsVAKB9GuByRWbjLNyJQnlQSv8hOMGRCUXouRnBkem22UhEdLzvtriAb6/pO1k3Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHTjHijGT0DA7Apx/tSvDn/eY4ukuc5/ubZUSrh6vf2DN1w4n+
	tuj/Yi1dGEuCbvKV4TzHr6ZfjCkcV5dOgLANy006bkNOzHJP58Tg3RRU
X-Gm-Gg: AfdE7cmXt5eC+/vTbP1JBn5+yVoUKvkYX6Lwh7zPcuFHZBEpBFCHVp5PuenBuVZAQuM
	gOcdmd7QKf0nfO4b7p+h0tYmFkMDYvf6BhesOo+7ZvVm+HItv4CJNnzMS+INz7NSYtu8Y2U/NmR
	lqSKzW56RLQW4uijDzUo/Uox1wgAisxpaDRzCrmypIXSAS+ffq4cNChemCU2Osmp391IhkloaSH
	B6yctucA3rvod9ffJ6PXT3v49jadyqfxAyl2IIYBMDTuxErkdPRWIox2iADRcxq/O5YtPd1QgjL
	mUHWc8k7+kLxBD+dEs9mY+ZDGOpjo+uNLRr0SjSglfK+hRW946uZm5ls8L13LfUhYPmKMnitFW/
	2JyzrWTHsirtq5rUMKXpKpe1XlWIGlc/nsK1p11SR8Srg77aMI0MQJZkTY2VVbA/SzRNubu25+b
	UuUZT7SOfLBg==
X-Received: by 2002:a17:90b:390b:b0:380:540:d49a with SMTP id 98e67ed59e1d1-3808bd2ffe9mr2231773a91.7.1782864627409;
        Tue, 30 Jun 2026 17:10:27 -0700 (PDT)
Received: from john-p8 ([98.97.43.89])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3809646e38dsm675137a91.17.2026.06.30.17.10.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 17:10:26 -0700 (PDT)
Date: Tue, 30 Jun 2026 17:10:24 -0700
From: John Fastabend <john.fastabend@gmail.com>
To: Sechang Lim <rhkrqnwk98@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Jiayuan Chen <jiayuan.chen@linux.dev>, Varun R Mallya <varunrmallya@gmail.com>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf-next v4 2/2] selftests/bpf: drop
 tc/xdp/flow_dissector/socket_filter sockmap mutation tests
Message-ID: <akRa2NjCanobYZSw@john-p8>
References: <20260630145410.3648099-1-rhkrqnwk98@gmail.com>
 <20260630145410.3648099-3-rhkrqnwk98@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260630145410.3648099-3-rhkrqnwk98@gmail.com>

On Tue, Jun 30, 2026 at 02:54:06PM +0000, Sechang Lim wrote:
>tc, xdp, socket_filter and flow_dissector programs can no longer update
>or delete a sockmap. Adjust the tests:
>
> - verifier_sockmap_mutate: the tc, xdp, socket_filter and
>   flow_dissector cases now expect __failure with "cannot update sockmap
>   in this context".
> - sockmap_basic: drop "sockmap update" / "sockhash update", which load
>   a SEC("tc") program that copies a sock between maps.
> - fexit_bpf2bpf: drop "func_sockmap_update", whose freplace program
>   updates a sockmap in the tc cls_redirect context.
>
>Remove the now-unused test_sockmap_update.c and freplace_cls_redirect.c.
>
>Signed-off-by: Sechang Lim <rhkrqnwk98@gmail.com>

Reviewed-by: John Fastabend <john.fastabend@gmail.com>
