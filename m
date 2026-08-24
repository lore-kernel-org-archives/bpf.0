Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07EED2EACF9;
	Mon, 24 Aug 2026 04:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787544687; cv=none; b=PCjma4ZXqDSeL+eoVK2jZj4JVssEpXv84X3hvZIHmGx5gYs9EHo0fbz/pD01okPctEq++CMxG2GN24ZYh+HVKa1pZsuo0kJdLNYRC2LjKkF+b/JUoDMQmuiLgVuxZQrJ7ffpisRXfjXc+vFTUavkrg/Hum6jpaCAz2oc7h1rnZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787544687; c=relaxed/simple;
	bh=TYMeMJgVoY45ace/els+xRCbp3g7KdlmlFQFFhzhONQ=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=BUcCVGVzOaWSKWhRsZ6Q4U975PszDZU5tsmciov2/ipttC/dB81Km8s2VxJuG88SoAVAeKBNjy6yISxKZvu5rKvR4+HAP1Fq+5niKzWjd3CAd6BeI+p39eFnEs+C7F84JYvIC9C8k3rgKFNgNw//Cy9G0iW5cOlhkRxU/QT9GIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DjzhSlDz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DjzhSlDz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDFE91F000E9;
	Mon, 24 Aug 2026 04:11:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787544685;
	bh=QeI/7eWUXfKV/VyFc7adJR0OGtgGRyaVgLAs6zdM6Ts=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=DjzhSlDzML7eE+yDQduBGNd3npkxKM0yrtWtCVu/zNxEMKdHz4oRKfTXAPxmrxO03
	 ZN+cHFI8K/+DzT3eZXMQGq2WBIdJg3UQYlpTx0LEd07iuZ+gxIayUK2Lbo47NHrD9O
	 qV+QqYq0b7vryhsUbvSuNtM8HkybJsTdTDtqbO7Qeeju673F7LYS1MNvo5bmSYNENf
	 2ZN3iydIwfoLh/TOhBQLVXC7/U8QHBoAtS1kgfInbA/1o0V3otwhM0ImWi+/cCjSrC
	 ADJhpj/G6mc6MaWz78XCdi7zO3enaTtMaztPbTL7fTiGtPfYuaG/0fVePVyCBCp++q
	 Q4vz+jpNwM1Sw==
Content-Type: multipart/mixed; boundary="===============4446199060120398593=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <72d2d49e5c6d6e6644d9a9b647cb5a8746f1c6e9e73ac190c75b2b903043caf8@mail.kernel.org>
In-Reply-To: <20260824030705.266049-1-jiayuan.chen@linux.dev>
References: <20260824030705.266049-1-jiayuan.chen@linux.dev>
Subject: Re: [PATCH bpf v2 1/2] bpf, veth: xdp: fix page_pool page leak on skb-backed XDP
From: bot+bpf-ci@kernel.org
To: jiayuan.chen@linux.dev,bpf@vger.kernel.org,netdev@vger.kernel.org
Cc: jiayuan.chen@linux.dev,syzbot+237bbeed8dfe0699b7f5@syzkaller.appspotmail.com,andrew+netdev@lunn.ch,davem@davemloft.net,edumazet@google.com,kuba@kernel.org,pabeni@redhat.com,ast@kernel.org,daniel@iogearbox.net,hawk@kernel.org,john.fastabend@gmail.com,sdf@fomichev.me,horms@kernel.org,martin.lau@linux.dev,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,shuah@kernel.org,kuniyu@google.com,liuhangbin@gmail.com,krikku@gmail.com,mkarsten@uwaterloo.ca,toke@redhat.com,lorenzo.bianconi@oss.qualcomm.com,linux-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon, 24 Aug 2026 04:11:24 +0000 (UTC)

--===============4446199060120398593==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/drivers/net/veth.c b/drivers/net/veth.c
> index 6ed3ee81153f..0afa0661ada1 100644
> --- a/drivers/net/veth.c
> +++ b/drivers/net/veth.c
> @@ -775,6 +775,11 @@ static int veth_convert_skb_to_xdp_buff(struct veth_rq *rq,
>  	if (skb_shinfo(skb)->nr_frags) {
>  		skb_shinfo(skb)->xdp_frags_size = skb->data_len;
>  		xdp_buff_set_frags_flag(xdp);
> +		/* A nonlinear skb was cow'd into rq->page_pool above, so the
> +		 * frags must be freed to that pool, not via the rxq's
> +		 * MEM_TYPE_PAGE_SHARED.
> +		 */
> +		xdp_buff_set_frag_pp(xdp);
>  	} else {
>  		xdp_buff_clear_frags_flag(xdp);
>  	}

[ ... ]

> diff --git a/net/core/dev.c b/net/core/dev.c
> index 38336858c168..be36020484b6 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -5532,6 +5532,11 @@ u32 bpf_prog_run_generic_xdp(struct sk_buff *skb, struct xdp_buff *xdp,
>  	if (skb_is_nonlinear(skb)) {
>  		skb_shinfo(skb)->xdp_frags_size = skb->data_len;
>  		xdp_buff_set_frags_flag(xdp);
> +		/* A nonlinear skb was cow'd into page_pool memory by
> +		 * skb_cow_data_for_xdp() before we got here, so the frags must
> +		 * be freed to that pool, not via the rxq's MEM_TYPE_PAGE_SHARED.
> +		 */
> +		xdp_buff_set_frag_pp(xdp);
>  	} else {
>  		xdp_buff_clear_frags_flag(xdp);
>  	}

This isn't a bug, but is the comment completely accurate?

The comment states the skb was cow'd "before we got here" by
skb_cow_data_for_xdp(). This is correct for the netif_receive_generic_xdp()
caller, where netif_skb_check_for_xdp() calls skb_cow_data_for_xdp() before
bpf_prog_run_generic_xdp().

However, bpf_prog_run_generic_xdp() has three other callers:

cpu_map_bpf_prog_run_skb():
    kernel/bpf/cpumap.c calls bpf_prog_run_generic_xdp() directly

dev_map_bpf_prog_run_skb():
    kernel/bpf/devmap.c calls bpf_prog_run_generic_xdp() directly

For these callers, skb_cow_data_for_xdp() is not called immediately before
this function. Instead, the page_pool invariant is inherited from an earlier
ingress generic-XDP pass where the skb went through
netif_receive_generic_xdp() -> netif_skb_check_for_xdp().

Should the comment acknowledge that the cow may have happened earlier in the
packet's path for some callers, rather than stating it always happens
"before we got here"?

[ ... ]

>     So record it in the xdp_buff. Add a XDP_FLAGS_FRAGS_PAGE_POOL flag; the two
>     skb-cow sites set it, and bpf_xdp_shrink_data() frees the frag to the

This isn't a bug, but is "the two skb-cow sites" the right description?

The commit message states "the two skb-cow sites set it", referring to
drivers/net/veth.c and net/core/dev.c where xdp_buff_set_frag_pp() is
called.

Looking at the code:

drivers/net/veth.c:782 is inside veth_convert_skb_to_xdp_buff(), which does
call skb_pp_cow_data() a few lines earlier to cow the nonlinear skb into
rq->page_pool. This is a cow site.

net/core/dev.c:5539 is inside bpf_prog_run_generic_xdp(), which does not
itself call skb_cow_data_for_xdp(). The cow happens one level up in
netif_receive_generic_xdp() -> netif_skb_check_for_xdp().

Would it be more precise to say "one cow site and one post-cow site" or "the
two sites where skb frags are known to be page_pool memory", since
bpf_prog_run_generic_xdp() is not itself performing the cow?

Also, bpf_prog_run_generic_xdp() has three callers that never cow at all:
cpu_map_bpf_prog_run_skb() and dev_map_bpf_prog_run_skb(). Their skbs
originate from xdp_do_generic_redirect_map() after going through
netif_receive_generic_xdp() where the cow already happened. So the flag is
set even though no cow occurs in the current call chain, which makes "two
skb-cow sites" a bit ambiguous.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/32686145995
--===============4446199060120398593==--
