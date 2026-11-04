Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793796816;
	b=fX3cOLoHEDhHX7E6eWYqIhBdddkYh6JbU1Sls/UVCMyjQylgcc6PsDI88+Jc1rEk4JQG
	 pJBVfD/SgY/qXZRMPr8UMa9LpkZnl0u1VepJW+Hw5Vc3AnVXCd+o6yGTA4dyVm4eY0wDj
	 0iuYEi4xtSuSfQscv+NTxmD9O0XWaj0KlryIwumTOQz96WROCsVQkckmXZYvJ3QGVrbT+
	 1emrog9BcIT7Dp7pDCiBmfixa9KAh9bMZP4Ec98A3NuXTnDG4p4Hdz3MOJLX+Njk3bmag
	 W/rYeih2GNh/EIGZvsEJpyWiMAr2HL0xMNssoMnHawr/LaYbwUefNc1eUouHGvf0r8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793796816;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=N63fQTTLR34VDWJCWhrfa1n6ElIwxBuDp0fIP83L2jY=;
	b=u+SUoHQyXe5dtrQRe7T4uOy3glIQbLCqNA4Fucmn8qk1J5XWlKpn9YZaNFqcE4BcnXAa
	 tcEzO0S2qHdvGH2cSXWOOTKdW0uAbO8t1elpmlciRSmjAx13nViM53UjiCJQrH3T+GKPz
	 3IdbZCIz5EfqGEjWH03FsHtil+ve1PSVxmPT8RLeIe/AOFoSupx6kr0hR6ySoEMzZx9RO
	 kh9bIfq1npLWtDFDpCbElNT9o7+CCD1l6kzWO4EXxEAadCijHZbQppqNblGDDZKuxbWwn
	 6YvSmAYXvHCCM5BbQxEYqBaeQ+1pLxXMsPvT/5xhRNM4xCiEoEYtCWr0A0+xZHco+vg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GGO7lYRO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FBDC606A329;
	Wed,  4 Nov 2026 12:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GGO7lYRO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6475A1F000C1;
	Wed,  4 Nov 2026 12:53:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793796815;
	bh=N63fQTTLR34VDWJCWhrfa1n6ElIwxBuDp0fIP83L2jY=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=GGO7lYROT+GSqzD8kuSJi57ZWaQVxilB6wZYAcudClbYx2l/ZMnRAon5YHphb80iF
	 As+KCaS+AeYXL4Y7UETG+mP67e1NdtDfpcrvnDy6EgmG18rcW5v2jctKLNNufpD3Uu
	 E0cwPTE9mR1eXzhFo4qTpk/ynpEweD89sIAymr2ffcK+cF0qKIyxxCyWrm84yw4fV4
	 vfZqqSzzkx7FplQZeYvpXeRkEG/BuihtYOnU5y6G2fcC2CfULCfOkT73VunillDddN
	 fx2c8mcoT32uOf/ry19l6eHc8A+Tb/FsxowFco39yPRH88Z6RwaYSZzWkUaZdCf/tZ
	 HhZ8nWytzrQhA==
Content-Type: multipart/mixed; boundary="===============6622439773063420790=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <9b616d465e6f88aab813a79cc84c51ed358861e201bfb23921864e62fc9dc023@mail.kernel.org>
In-Reply-To: <20261104121316.1155680-2-sst@poczta.fm>
References: <20261104121316.1155680-2-sst@poczta.fm>
Subject: Re: [PATCH v6 bpf 1/3] xdp: introduce xdp_convert_skb_to_buff()
From: bot+bpf-ci@kernel.org
To: sst@poczta.fm,ast@kernel.org,daniel@iogearbox.net,davem@davemloft.net,kuba@kernel.org,hawk@kernel.org,john.fastabend@gmail.com,sdf@fomichev.me
Cc: netdev@vger.kernel.org,bpf@vger.kernel.org,magnus.karlsson@intel.com,aleksander.lobakin@intel.com,ilias.apalodimas@linaro.org,toke@redhat.com,lorenzo@kernel.org,ihor.solodrai@linux.dev,tavip@google.com,maciej.fijalkowski@intel.com,sst@poczta.fm,syzbot+ff145014d6b0ce64a173@syzkaller.appspotmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Wed,  4 Nov 2026 12:53:35 +0000 (UTC)

--===============6622439773063420790==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> xdp: introduce xdp_convert_skb_to_buff()

TL;DR:
- Persistent mem.type store in shared rxq may make BPF_PROG_TEST_RUN frag
  release hit page_pool path: WARN, leaked page
- Commit message nits: inaccurate "assigned to xdp_buff", stale "about to be
  integrated"

> diff --git a/include/net/xdp.h b/include/net/xdp.h
> --- a/include/net/xdp.h
> +++ b/include/net/xdp.h

[ ... ]

> +/**
> + * xdp_convert_skb_to_buff - build an xdp_buff on top of an skb
> + * @skb: skb to describe, packet data is taken from its MAC header onwards
> + * @xdp: xdp_buff to initialize
> + * @xdp_rxq: Rx queue info to attach to @xdp
> + *
> + * The memory type set on @xdp_rxq is only used to release fragments that
> + * the XDP program consumes; the head can not be freed from under the skb.
> + * A non-linear @skb is expected to have gone through skb_pp_cow_data(), so
> + * all of its fragments are page_pool backed.
> + */

[ ... ]

> +	DEBUG_NET_WARN_ON_ONCE(skb_is_nonlinear(skb) && !skb->pp_recycle);
> +	xdp->rxq->mem.type = MEM_TYPE_PAGE_POOL;
> +}

Can this store break other users of the same xdp_rxq_info?

bpf_prog_run_generic_xdp() passes &netif_get_rxqueue(skb)->xdp_rxq, which
is the device's long-lived dev->_rx[i].xdp_rxq.  The new mem.type is never
restored, so after the first generic XDP packet the queue stays
MEM_TYPE_PAGE_POOL.  Before this patch nothing wrote this field, and it
stayed at MEM_TYPE_PAGE_SHARED from xdp_rxq_info_reg().

bpf_prog_test_run_xdp() builds its xdp_buff on the same structure:

    rxqueue = __netif_get_rx_queue(current->nsproxy->net_ns->loopback_dev, 0);
    rxqueue->xdp_rxq.frag_size = PAGE_SIZE;
    xdp_init_buff(&xdp, rxqueue->xdp_rxq.frag_size, &rxqueue->xdp_rxq);

(or the rxq selected by ctx->ingress_ifindex in xdp_convert_md_to_buff()).
It allocates its frags with alloc_page(GFP_KERNEL) and relies on the
default MEM_TYPE_PAGE_SHARED.

If an xdp.frags program run through BPF_PROG_TEST_RUN then releases a whole
frag with bpf_xdp_adjust_tail() or bpf_xdp_pull_data():

bpf_xdp_shrink_data()
  __xdp_return(netmem, MEM_TYPE_PAGE_POOL, ...)
    page_pool_put_full_netmem(netmem_get_pp(netmem), ...)

this runs the page_pool path on an ordinary page.  pp_ref_count overlays
page->private, which is 0, so page_pool_unref_netmem() sees
atomic_long_sub_return() return -1 and hits WARN_ON(ret < 0).  The page is
not freed, and it has already been removed from sinfo->frags, so the
__free_page() loop at the end of bpf_prog_test_run_xdp() does not free it
either.

To reproduce, attach a generic XDP program to lo, pass one packet, then run
BPF_PROG_TEST_RUN on an xdp.frags program with data_size_in larger than one
page whose bpf_xdp_adjust_tail() shrinks by at least the last frag.  The
result is a WARN (a panic with panic_on_warn) and a leaked page per run.

The kdoc says "The memory type set on @xdp_rxq is only used to release
fragments that the XDP program consumes", and the commit message says "The
mem type is only consulted when the program releases fragments".  Both
describe only the generic XDP buffer, and neither mentions that the value
persists in shared rxq state.

Could mem.type be saved and restored around the program run, or could
bpf_prog_test_run_xdp() set the mem type it needs (or use its own
xdp_rxq_info)?  The later veth commits in this series only touch
drivers/net/veth.c and do not address this.

Also, the commit message says:

> Pull out the existing code from bpf_prog_run_generic_xdp() that
> init/prepares xdp_buff onto new helper xdp_convert_skb_to_buff() and
> embed there rxq's mem_type initialization that is assigned to xdp_buff.

Is "assigned to xdp_buff" accurate?  struct xdp_buff has no mem type field;
the helper writes xdp->rxq->mem.type, i.e. netdev_rx_queue::xdp_rxq.mem.type.

And the commit message also says:

> This problem was triggered by syzbot as well as AF_XDP test suite which
> is about to be integrated to BPF CI.

This isn't a bug, but is "about to be integrated" still accurate?
selftests/bpf test_xsk.c already appears to be integrated into test_progs
in this tree (d1aec26fce25), so the wording looks stale.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/41828746707
--===============6622439773063420790==--
