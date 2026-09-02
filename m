Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F39C408026
	for <bpf@vger.kernel.org>; Wed,  2 Sep 2026 09:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788339666; cv=none; b=fISI3jEREJMCQMt70eMg4nC71e2ju68fKJCB1VvVfpm7B1fIsTwJwI+o4IqkqEtf4F/0GpADungatDrkXK8tEDvkv4L0kNmw/+owxSikixtu0re/xw1UubHji72nAWkuLi9a1aUraFUmojyTjYUoFFtvoqwVbasFnuOHefJo514=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788339666; c=relaxed/simple;
	bh=XSK+zRuSMVw8jLK60WcdQQofoqidIRH6crZyCiqiZN8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vce7+tPs72ffXy+yzrSOyPn+jd3r9HLKPgH0gjgziGiMomSKpXMNCQKXmc6bDC9HWIwFxI4MAsjIkHGlNG+pLoYe1Fx0X8I9W/l6KR/fGxQ8k8mK7cJOADBZ7zGCn8Is1qFPyN56Lv/zwvm8uUQPzUBlbQfHZSYX9ohpTNjFZLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id D410E60405; Wed, 02 Sep 2026 11:00:58 +0200 (CEST)
Date: Wed, 2 Sep 2026 11:00:58 +0200
From: Florian Westphal <fw@strlen.de>
To: bot+bpf-ci@kernel.org
Cc: bpf@vger.kernel.org, andrii@kernel.org, eddyz87@gmail.com,
	ast@kernel.org, daniel@iogearbox.net, martin.lau@kernel.org,
	yonghong.song@linux.dev, mason@kernel.org, ihor.solodrai@linux.dev
Subject: Re: [PATCH bpf] selftests/bpf: Add tests to assert that netfilter
 progs cannot write to skb
Message-ID: <apflyjoO0S-9XuUE@strlen.de>
References: <20260902065226.25201-1-fw@strlen.de>
 <da1f216ffd5f1f1102cb82245064b6f60f6e893f6a2e6cb46983206195f49c75@mail.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <da1f216ffd5f1f1102cb82245064b6f60f6e893f6a2e6cb46983206195f49c75@mail.kernel.org>

bot+bpf-ci@kernel.org <bot+bpf-ci@kernel.org> wrote:
> >     Assert that bpf netfilter program type exposes readonly access to the
> >     skb, either via direct packet access or via dynptr API.

> This isn't a bug, but since netfilter progs have no direct packet access,
> would it be clearer to describe this case as writing through ctx->skb (BTF
> walk) instead of 'direct packet access'? The test (ctx->skb->data[0] = 0)
> walks a BTF pointer, which is why the expected message is 'cannot write
> into rdonly_untrusted_mem' rather than a packet-access error.

I'll shorten this to:

"Assert that bpf netfilter programs do not allow skb write access."

I'll also follow the other suggested changes to function names.
