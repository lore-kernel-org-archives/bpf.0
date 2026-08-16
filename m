Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DACB12DB798;
	Sun, 16 Aug 2026 03:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786852681; cv=none; b=dfePsv7+AeCxXx840f/HaIs2/C0a1mS1Xo2vg30DK3gE9fCB0LAkbZ0jKFQjVBUawaDY1WVXqYObmeKJ/rCSteKiDZil/Omxc7njRRd4kObD2SKUJOXjpXIvZFcyDnwb1TKlYyzsM5hJx01McMJz/uJ5M+dUkrbJpc4qZWlMgXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786852681; c=relaxed/simple;
	bh=gECAAk/4ExcxETs+rIfYIcGaME31GhWzE7ijuaUeZpg=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=iwgfymJh3lDnbGzFPzR5WBrL7w9XZO9bnuXFrzJrw1DSbeVJwDgCEVKpOc968dWl2svYkA2anTG1FGk6Ui511sXk5itGJa1sIl4tSegfdZ02LHjN7PR9wjo+k6wYjpi9EPOfiWHRMicp26o/9ZoEe+SYdk5Ctm21yJ43z5XrI/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZfFx4bQ1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZfFx4bQ1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ED3B1F000E9;
	Sun, 16 Aug 2026 03:57:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786852679;
	bh=MTSysb65ADjtlvNFIs4wkzTc2eQHtgkj3pmYPJpa6YI=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=ZfFx4bQ1/rLRgacIfeaiHLgahxI7FbPQnye+g4au0ZWrMMsRZ442SZ4K0i/3sLg2k
	 kfkQdRMZoGSsp8ndeuczeouSWKE9xPji5wrWANmwmk+41eoCYmC4lG/V8J57oVCYg+
	 Ww0dewOSz2ul17pLmtfxAxApXC0ytvqvp8E3uy4lKwsbXflFyEThJKWmitBwDj5H06
	 jRzwwO0WRPNkZnZg67ODvyVzcwV1Tu00TxwhM1pdTrLT1bebV+wi+YoQY+vsiqt1Nc
	 mc3SXQmkN/8IRm/yQ/GVrQZCewGTiBV773IryqnJhxis+CIF8Hslde9YD88kmDazKN
	 XZ22JM8WliQ3Q==
Content-Type: multipart/mixed; boundary="===============2544190724305362226=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <5aa97a9a0b8cd20feda29b304874967a8019d8b4b3dd4021dc5c0dac43c10d05@mail.kernel.org>
In-Reply-To: <20260816031245.268898-1-jiayuan.chen@linux.dev>
References: <20260816031245.268898-1-jiayuan.chen@linux.dev>
Subject: Re: [PATCH bpf] bpf: free page_pool frags via the page_pool path in bpf_xdp_shrink_data
From: bot+bpf-ci@kernel.org
To: jiayuan.chen@linux.dev,bpf@vger.kernel.org,netdev@vger.kernel.org
Cc: jiayuan.chen@linux.dev,syzbot+237bbeed8dfe0699b7f5@syzkaller.appspotmail.com,daniel@iogearbox.net,john.fastabend@gmail.com,sdf@fomichev.me,martin.lau@linux.dev,ast@kernel.org,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,davem@davemloft.net,edumazet@google.com,kuba@kernel.org,pabeni@redhat.com,horms@kernel.org,hawk@kernel.org,toke@redhat.com,lorenzo@kernel.org,linux-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sun, 16 Aug 2026 03:57:58 +0000 (UTC)

--===============2544190724305362226==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/net/core/filter.c b/net/core/filter.c
> index 16845987b244..3aab5556abe2 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -86,6 +86,7 @@
>  #include <net/inet_dscp.h>
>
>  #include "dev.h"
> +#include "netmem_priv.h"
>
>  /* Keep the struct bpf_fib_lookup small so that it fits into a cacheline */
>  static_assert(sizeof(struct bpf_fib_lookup) == 64, "struct bpf_fib_lookup size check");
> @@ -4288,6 +4289,14 @@ static bool bpf_xdp_shrink_data(struct xdp_buff *xdp, skb_frag_t *frag,
>  	if (mem_type == MEM_TYPE_XSK_BUFF_POOL) {
>  		netmem = 0;
>  		zc_frag = bpf_xdp_shrink_data_zc(xdp, shrink, tail, release);
> +	} else if (netmem_is_pp(netmem)) {
> +		/* The rxq mem model does not always describe how a released
> +		 * frag must be freed: the generic-XDP and veth paths run the
> +		 * program on a shared rxq while the frag has been cow'd into
> +		 * page_pool memory. Trust the page itself and return a
> +		 * page_pool frag to its pool regardless of rxq->mem.type.
> +		 */
> +		mem_type = MEM_TYPE_PAGE_POOL;
>  	}
>
>  	if (release) {

The comment says the fix handles rxq->mem.type "regardless" of its value,
but the implementation still checks MEM_TYPE_XSK_BUFF_POOL first. When the
shared rxq has been left with mem_type == MEM_TYPE_XSK_BUFF_POOL by
veth_xdp_rcv_one() (which writes frame->mem_type into the shared rxq on
XDP_TX/XDP_REDIRECT and never restores it), a page_pool frag skips the new
netmem_is_pp() branch entirely and goes to bpf_xdp_shrink_data_zc() instead.

Should the comment say "regardless of rxq->mem.type, unless the rxq claims
XSK memory" or should the netmem_is_pp() test be unconditional so the stale
MEM_TYPE_XSK_BUFF_POOL case is also handled?

The commit message states: "A single rxq->mem.type can be wrong in either
direction." The code, however, only corrects one direction: it upgrades
mem_type to MEM_TYPE_PAGE_POOL when the frag is a page_pool page, but it
never downgrades when rxq->mem.type already says MEM_TYPE_PAGE_POOL and the
frag is not a page_pool page.

That second direction is reachable on the very path the commit message
cites. veth_xdp_rcv_one() (drivers/net/veth.c:638) points the buff at the
shared rxq and then, on XDP_TX/XDP_REDIRECT, writes the frame's type into
it:

    xdp->rxq = &rq->xdp_rxq;
    ...
    case XDP_TX:
            xdp->rxq->mem.type = frame->mem_type;
    case XDP_REDIRECT:
            xdp->rxq->mem.type = frame->mem_type;

Once one redirected frame with mem_type == MEM_TYPE_PAGE_POOL is TX'd or
redirected, rq->xdp_rxq.mem.type stays MEM_TYPE_PAGE_POOL for every
subsequent packet on that queue.

A later frame whose frags are plain pages then reaches:

    } else if (netmem_is_pp(netmem)) {   /* false, mem_type left as PAGE_POOL */
    ...
    __xdp_return(netmem, mem_type, false, zc_frag);

and __xdp_return()'s MEM_TYPE_PAGE_POOL arm (net/core/xdp.c:436-446) skips
the check and dereferences a garbage pool pointer:

    /* No need to check netmem_is_pp() as mem->type knows this a page_pool page */
    page_pool_put_full_netmem(netmem_get_pp(netmem), netmem, napi_direct);

netmem_get_pp() reads page->pp, which for a non-page_pool page holds
whatever the allocator left there.

This specific crash is pre-existing rather than introduced by the patch, but
the patch is the change that claims to make the frag itself authoritative,
and it had the netmem in hand. Could the decision be unconditional:

    } else {
            mem_type = netmem_is_pp(netmem) ? MEM_TYPE_PAGE_POOL : mem_type;

plus a guard for the stale-MEM_TYPE_PAGE_POOL case, or should the "wrong in
either direction" claim be dropped from the commit message so the remaining
hole is not reported as fixed?

This isn't a bug, but a subsystem pattern flags this as potentially
concerning: the new multi-line block comment added at net/core/filter.c
starts its text on the same line as the opening:

    /* The rxq mem model does not always describe how a released
     * frag must be freed: ...
     */

The BPF subsystem style required for net/core/filter.c puts the opening on
a line of its own:

    /*
     * The rxq mem model does not always describe how a released
     * frag must be freed: ...
     */

Most existing multi-line comments in net/core/filter.c use the old style, so
the new comment matches its immediate neighbours and checkpatch will not
complain. The guide says the rule applies even where surrounding code uses
the old style, but the decision is yours.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/31924332756
--===============2544190724305362226==--
