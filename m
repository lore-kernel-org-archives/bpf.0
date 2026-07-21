Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99592433BC3
	for <bpf@vger.kernel.org>; Tue, 21 Jul 2026 07:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784618281; cv=none; b=WCH7cSBIWzMktLyG0VqFAyHiEYNjJygdgXOuD+4vYLF4zoWE0BMvy3Dp2oyIVRpC2/BBSfJJr6/6OAke0kWMGh2FhDOh8ruyLploKEKcyOBEc6O+qJ+P9b8qVANBftywetZBkiEwbSbMaFzOmHkF8fCcdWYTg5Wh8ksXODEzf4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784618281; c=relaxed/simple;
	bh=7MCd6OudWBhjJORh/39I8LeZg8cTYiWnJndMJ7VlSpY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=I43reANDVF0ew/cIIms1Z4szBdIH02SxuLe6p0QM+DZNOglyE7r4SMd47MU+qybtjptCwBuHhBBu9sCl4MybUXjPGwr1KQwPJOfxzKEAF6AtsITrcuolwCqmw6O4XjoG0q63xXi9Szo09kMPDuDVNdVRdvAP8f6rXMpl/3SNoK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gzj9EqTb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gzj9EqTb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09F411F00A3A;
	Tue, 21 Jul 2026 07:17:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784618279;
	bh=TuICvdkhYFkfwJvswpn7FhCUDElehUmd6cepDTkR13g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Gzj9EqTbSQ+CoiwzgnDu+DKS5kPeY7lQbvSt6ftllA8MK8e8TMDlY/4OUig+JNltJ
	 Qtc8I85MgN9CYwfa5zWMMXbbWczKsG3sYKcMXGreCW3xGUviR4ZpHD+sCpjle2mozd
	 rgLnuGvrfTDkcqBJhap3/tFmVbz03M83BeJaoVykOliFljLrdxgGNBn8gTRiVui8uR
	 ogVOcM5cuw9qFwOMn63v6McoVKQ2u1piqfuECiYAwh3yvYOFNWxQsEwomdTf6tQcoT
	 oZpHgYw0JeRKt8jypvNRzrd68FOye92BDiI0fZdopxFwXg2Ti/MlLcTQhNfOfsYNzH
	 Qbzx9xvAsLuqA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH net-next 04/13] net: knod: add offload device core
 and control plane
Reply-To: sashiko-reviews@lists.linux.dev
To: "Taehee Yoo" <ap420073@gmail.com>
Cc: dri-devel@lists.freedesktop.org, bpf@vger.kernel.org, media-ci@linuxtv.org
In-Reply-To: <20260719175857.4071636-5-ap420073@gmail.com>
References: <20260719175857.4071636-1-ap420073@gmail.com>
 <20260719175857.4071636-5-ap420073@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jul 2026 07:17:58 +0000
Message-Id: <20260721071759.09F411F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 10 potential issue=
(s) to consider:
- [High] Lockless traversal of knod_dev_list in IPsec datapath races with l=
ist mutations in knod_dev_detach, leading to kernel panic or Use-After-Free.
- [High] Lack of hot-unplug detachment and missing net_device refcounts lea=
d to Use-After-Free if hardware is removed.
- [High] knod_pass_detach uses a timeout that forces premature freeing of p=
age pool structures, causing Use-After-Free when delayed SKBs are eventuall=
y released.
- [High] Uninitialized variable 'i' is used in the free_spsc error cleanup =
path if memory allocation fails.
- [High] Hardware SDMA target pages are prematurely recycled if the hardwar=
e fence times out, leading to silent data corruption.
- [High] PP_FLAG_DMA_MAP is improperly set for a custom memory provider tha=
t supplies pre-mapped device memory.
- [High] Hardcoded sdma_idx =3D 0 causes hardware fence polling on the wron=
g queue.
- [Medium] Netlink operations do not reply with a full message for object c=
reation, and notifications ignore NLM_F_ECHO requirements.
- [Medium] Direct modification of netdev->features bypasses networking core=
 feature synchronization and notifications.
- [Medium] Double-attachment in knod_ipsec_attach corrupts the saved xfrmde=
v_ops pointer.
--

--- Patch [4]: [RFC PATCH net-next 04/13] net: knod: add offload device cor=
e and control plane ---
commit e070e2966937b9789951030b969d12e24910bb8f
Author: Taehee Yoo <ap420073@gmail.com>
Subject: net: knod: add offload device core and control plane

Add the KNOD core framework and its genetlink control plane. The core
maintains three object types and drives the RX data path over per-queue
SPSC rings. The genetlink family exposes attach/detach, inventory, and
feature selection.

> diff --git a/net/knod/knod_core.c b/net/knod/knod_core.c
> index af50a69bca651..[snip]
> --- /dev/null
> +++ b/net/knod/knod_core.c

[ ... ]

> 		desc =3D ptr;
> 		desc->netmem =3D dst;
> 		desc->src =3D src;
> 		desc->off =3D off;
> 		desc->len =3D len;
> 		desc->fence_val =3D fv;
> 		desc->sdma_idx =3D 0;

[Severity: High]
Does this hardcoded index cause hardware fence polling on the wrong queue?

By setting sdma_idx to 0 instead of the dynamically assigned napi_index,
subsequent calls to d2h_fence() in knod_d2h_drain() and knod_pass_flush()
will always poll queue 0. This could lead to premature delivery of incomple=
te
DMA buffers or hang indefinitely on multi-queue configurations.

[ ... ]

> static struct knod_dev *knod_ipsec_find_xdev(struct net_device *dev)
> {
> 	struct knod_dev *knodev;
>=20
> 	list_for_each_entry(knodev, &knod_dev_list, list) {
> 		if (knodev->netdev =3D=3D dev)
> 			return knodev;
> 	}

[Severity: High]
Can this lockless iteration of knod_dev_list cause a use-after-free or
kernel panic?

This function is called from the IPsec transmit path via
knod_ipsec_xdo_offload_ok(). Concurrently, knod_dev_detach() for other
devices modifies knod_dev_list using list_del() and kfree() without RCU
protection or locking, meaning this traversal could read poisoned list
pointers or freed memory.

[ ... ]

> 	knodev->ipsec_orig_xfrmdev_ops =3D knodev->netdev->xfrmdev_ops;
> 	knodev->ipsec_added_hw_esp =3D
> 		!(knodev->netdev->features & NETIF_F_HW_ESP);
> 	knodev->netdev->xfrmdev_ops =3D &knod_ipsec_xfrmdev_ops;

[Severity: Medium]
Is there protection against double-attachment overwriting the original
operations pointer?

If knod_ipsec_attach() is called twice, the previously installed proxy
operations will be saved as the original xfrmdev_ops. During detach, this
proxy will be restored instead of the true hardware operations, breaking the
offload and potentially creating recursion loops.

> 	knodev->netdev->features |=3D NETIF_F_HW_ESP;
> 	knodev->netdev->hw_enc_features |=3D NETIF_F_HW_ESP;

[Severity: Medium]
Does directly modifying netdev->features bypass core network synchronizatio=
n?

Dynamically modifying features should typically be done by updating
hw_features or wanted_features and invoking netdev_update_features().
Modifying them directly misses the NETDEV_FEAT_CHANGE notification, leaving
userspace tools like ethtool out of sync with the hardware state.

[ ... ]

> static bool hostmem_pp_release_netmem(struct page_pool *pool, netmem_ref =
netmem)
> {
> 	struct page_pool_hostmem *hm =3D pool->mp_priv;
> 	unsigned long addr =3D page_pool_get_dma_addr_netmem(netmem);
>=20
> 	page_pool_clear_pp_info(netmem);
> 	gen_pool_free(hm->genpool, addr, PAGE_SIZE);

[Severity: High]
Can this lead to a use-after-free when delayed SKBs are released?

In knod_pass_detach(), there is a timeout that forcefully frees the wpriv
structure (which contains pass_hm) if the page pool hasn't drained within
5 seconds. When the network stack eventually frees those delayed SKBs,
this callback will dereference the freed pool->mp_priv (hm) when calling
gen_pool_free().

[ ... ]

> 	struct page_pool_params pp =3D {
> 		.order		=3D 0,
> 		.pool_size	=3D KNOD_PASS_SLOTS,
> 		.nid		=3D NUMA_NO_NODE,
> 		.dev		=3D knodev->netdev->dev.parent,
> 		.dma_dir	=3D DMA_FROM_DEVICE,
> 		.max_len	=3D PAGE_SIZE,
> 		.flags		=3D PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV |
> 				  PP_FLAG_CUSTOM_MEMORY_PROVIDER,

[Severity: High]
Is PP_FLAG_DMA_MAP appropriate for a custom memory provider returning
pre-mapped device memory?

Setting PP_FLAG_DMA_MAP instructs the page pool core to automatically unmap
the page via dma_unmap_page_attrs() on release. Since hostmem_pp_init uses
GTT device addresses instead of standard system RAM DMA mappings, this will
result in invalid DMA API unmap operations.

[ ... ]

> 			if (desc->src) {
> 				struct page_pool *src_pp =3D
> 					netmem_get_pp(desc->src);
>=20
> 				page_pool_recycle_direct_netmem(src_pp,
> 								desc->src);
> 			}
> 			page_pool_put_full_netmem(pool, desc->netmem, false);

[Severity: High]
Could recycling these DMA target pages after a timeout cause silent data
corruption?

If the polling loop in knod_pass_flush() times out, the pages are recycled
back to the active pools immediately. Since the hardware operation was not
definitively aborted, the accelerator might complete its delayed DMA write
later, silently overwriting whatever new packet data has been placed in
that page.

[ ... ]

> 	knodev->netdev =3D knetdev->dev;

[Severity: High]
Should dev_hold() be called here to take a reference on the net_device?

If the device is hot-removed, the hardware driver invokes
unregister_netdev() and frees the net_device. knod_netdev_unregister() only
removes the object from the list without detaching it. This leaves a
dangling pointer in knodev->netdev, which can cause a use-after-free when
accessed by Netlink queries like knod_nl_dev_get_dumpit().

[ ... ]

> 		if (knodev->accel_ops->alloc_mem) {
> 			size_t total =3D pool_size * nqueues;
> 			u64 base_gaddr;
> 			void *base_pool;
> 			void *pool_priv;
>=20
> 			base_pool =3D knodev->accel_ops->alloc_mem(knodev, total,
> 					&base_gaddr, NULL, &pool_priv);
> 			if (!base_pool) {
> 				err =3D -ENOMEM;
> 				pr_err("%s: alloc_mem failed\n", __func__);
> 				goto free_spsc;
> 			}

[ ... ]

> free_spsc:
> 	for (i--; i >=3D 0; i--)
> 		spsc_destroy(&knodev->wpriv[i].spsc_bds);

[Severity: High]
Will this loop use an uninitialized variable if alloc_mem() fails?

If alloc_mem() fails, the code jumps to free_spsc before 'i' is initialized.
The loop then operates on an uninitialized stack value for 'i', leading to
an out-of-bounds array access on knodev->wpriv[i] and passing an invalid
pointer to spsc_destroy().

> diff --git a/net/knod/knod_nl.c b/net/knod/knod_nl.c
> index 77799202abcf4..[snip]
> --- /dev/null
> +++ b/net/knod/knod_nl.c

[ ... ]

> 	genlmsg_multicast_netns(&knod_nl_family, net, ntf, 0,
> 				KNOD_NLGRP_MGMT, GFP_KERNEL);

[Severity: Medium]
Does this ignore the NLM_F_ECHO flag?

Notifications emitted in response to requests should pass the request
information to genl_notify() to honor the NLM_F_ECHO flag. Using
genlmsg_multicast_netns() drops the request context.

[ ... ]

> 	err =3D knod_dev_attach(knetdev, accel);
> 	if (!err)
> 		knod_nl_notify_dev(knetdev->knodev, KNOD_CMD_DEV_ADD_NTF);
>=20
> unlock:
> 	mutex_unlock(&knod_lock);
> 	rtnl_unlock();
> 	return err;

[Severity: Medium]
Should this operation reply with a full message?

According to Netlink uAPI design rules, NEW/ADD operations must reply with
a full message carrying identifying information about the newly created
object, rather than just returning zero and ACKing the request.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260719175857.4071=
636-1-ap420073@gmail.com?part=3D4
