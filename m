Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B92CB433BC2
	for <bpf@vger.kernel.org>; Tue, 21 Jul 2026 07:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784618277; cv=none; b=cXqjMU3OBZWqJLuLc3hAY1wAWTXZzsIr62gyjUrjTvjGS9r5nVC/bCPAFZsqX+oPMPG1K4jquM4QdaI2yGbTbTf7hTYsvmikxErZ+jul0LlISyv2yl4Wd8HLa75sCY8XtZ87KcwH/Og2zmtgIr1SeCtmskTLW3kkO0zculWyVOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784618277; c=relaxed/simple;
	bh=IqixMiSG+NPAKw9C3OMzWqhmfXTuHoeDvNxo8D5/zeo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=p8Yad1WEmRSruYSQsJ9Opq4diRM9HPuLYbVFJ0Ugp2hX8aKOIkBIjLQ8k4KBFJ4cYg4yeNruc5kJSSxnvpl09kPJgG++vodb1nCtWXf1n93NPpcT5KHd6tLiIxnYw3UcwigiKMMveKgvAL5cpG3NMiGLwD281oxXGjH2H7ci1XY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BTqdTn+2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BTqdTn+2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A53E1F00A3D;
	Tue, 21 Jul 2026 07:17:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784618275;
	bh=SabUEnmC16MubNNi5nwBGFFE5ovi3EdBZTF6CVTSOYE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BTqdTn+2Gjagxhd64bQFm2IDKjhL9Nywn9tZdN5jxPbujS2VdHtEVoHN6wU//PG2f
	 /w9NAJHq14pS6edNwTEfzBPzYpOCCPRsFgsVxcmetb2g6p99uVss/i2SJM6D2kTcbq
	 +ET6LPGuRX/UAaW1G96m6v0HLpAXUsSY+ozMXr5n6sstLXdb6/htqrV+UzWepKQuAS
	 8riy18MOl2Jy0Rqyao7HSD4pvA3dK5OEva8IasLNCOKnXkTTcDBRncOVj2MulZeEvP
	 4GRu5zuroIeL9N0lCnWuKbxaFzsk3/ik3UsV/e2/r51k0wcgQHajT4VB4UrLmX7OyD
	 IFZDbInyDo5XQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH net-next 01/13] net: knod: add uapi and core headers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Taehee Yoo" <ap420073@gmail.com>
Cc: dri-devel@lists.freedesktop.org, media-ci@linuxtv.org, bpf@vger.kernel.org
In-Reply-To: <20260719175857.4071636-2-ap420073@gmail.com>
References: <20260719175857.4071636-1-ap420073@gmail.com>
 <20260719175857.4071636-2-ap420073@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jul 2026 07:17:54 +0000
Message-Id: <20260721071755.3A53E1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 7 potential issue(=
s) to consider:
- [High] Broken lock-free API: `spsc_push` and `spsc_pop` introduce data ra=
ces.
- [High] Use-After-Free in `knod_napi_kick()` due to lifecycle mismatch wit=
h standard NAPI teardown.
- [High] NULL pointer dereference in inline helpers when no accelerator is =
attached.
- [High] `spsc_acquire()` lacks a Write Memory Barrier (`wmb()`) before pub=
lishing the advanced cursor, risking data corruption on WC memory.
- [Medium] The `attach` Netlink operation violates uAPI design guidelines b=
y missing reply attributes.
- [Medium] Severe false sharing in `struct spsc_ring` due to unpadded produ=
cer and consumer cursors.
- [Low] Missing `n` parameter in `for_each_xdev_safe` macro.
--

--- Patch [1]: [RFC PATCH net-next 01/13] net: knod: add uapi and core head=
ers ---
commit 518fe6d810fd2f47140b3bb011b370cf924724ed
Author: Taehee Yoo <ap420073@gmail.com>

net: knod: add uapi and core headers

Add the uAPI and core headers for KNOD, an in-kernel network offload
device that connects a NIC RX path to an accelerator (e.g. a GPU) for
zero-copy packet processing.

> diff --git a/Documentation/netlink/specs/knod.yaml b/Documentation/netlin=
k/specs/knod.yaml
> new file mode 100644
> index 0000000000000..7c64df4676349
> --- /dev/null
> +++ b/Documentation/netlink/specs/knod.yaml
[ ... ]
> @@ -0,0 +1,176 @@
> +# SPDX-License-Identifier: ((GPL-2.0 WITH Linux-syscall-note) OR BSD-3-C=
lause)
> +---
> +name: knod
[ ... ]
> +    -
> +      name: attach
> +      doc: Attach a NIC netdevice to an accelerator.
> +      attribute-set: dev
> +      flags: [admin-perm]
> +      do:
> +        request:
> +          attributes:
> +            - nic-ifindex
> +            - accel-id
> +        reply:
> +          attributes: []

[Severity: Medium]
UAPI design rules state that NEW/ADD operations must reply with a full
message describing the new object. By leaving attributes empty, does this
permanently freeze a broken ABI for userspace applications relying on gener=
ic
netlink?

> +    -
> +      name: detach
> +      doc: Detach a NIC netdevice from its accelerator.
> +      attribute-set: dev
[ ... ]
> diff --git a/include/net/knod.h b/include/net/knod.h
> new file mode 100644
> index 0000000000000..50333b0e028b7
> --- /dev/null
> +++ b/include/net/knod.h
[ ... ]
> @@ -0,0 +1,467 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __NET_KNOD_H
> +#define __NET_KNOD_H
[ ... ]
> +struct knod_work_priv {
> +	struct dma_buf *dmabuf;
> +	netmem_ref *netmems;
> +	unsigned int *data_lens;
> +	int *data_offs;
> +	int cnt;
> +	int index;
> +	struct napi_struct *napi;
> +	struct spsc_ring spsc_bds;
> +	void *spsc_pool_priv;	/* accel driver priv for spsc pool memory */
> +	u64 spsc_pool_gaddr;	/* device-visible address of spsc pool */
> +	/* framework-owned delivery pool */
> +	struct page_pool *pass_pool;
> +	/* provider ctx (owner storage) */
> +	struct page_pool_hostmem pass_hm;
> +	/* d2h: SDMA-issued, awaiting drain */
> +	struct spsc_ring pass_pending;
> +} ____cacheline_aligned_in_smp;
> +
> +static inline void knod_napi_kick(struct knod_work_priv *wpriv)
> +{
> +	struct napi_struct *napi;
> +
> +	rcu_read_lock();
> +	napi =3D READ_ONCE(wpriv->napi);
> +	if (napi)
> +		napi_schedule(napi);
> +	rcu_read_unlock();
> +}

[Severity: High]
Does this RCU lock actually protect the NAPI structure from being freed?
Standard NIC drivers often dismantle and free their queue arrays synchronou=
sly
after napi_disable(), without an RCU grace period. Could this lead to a
use-after-free when calling napi_schedule()?

> +
> +#define KNOD_DEFAULT_PASS_SLOTS	64
> +
> +/*
[ ... ]
> +struct knod_dev {
> +	struct list_head list;
> +	struct knod_netdev *knetdev;
> +	struct knod_accel *accel;
[ ... ]
> +};
> +
> +static inline bool knod_dev_active(struct knod_dev *knodev)
> +{
> +	return !!knodev->accel->xdp.xdp_hw.prog;
> +}
> +
> +static inline struct bpf_prog *
> +knod_dev_offloaded(struct knod_dev *knodev)
> +{
> +	return knodev->accel->xdp.bpf_offloaded;
> +}

[Severity: High]
Can knodev->accel be NULL when a NIC is registered but detached from an
accelerator? If so, will these inline helpers unconditionally dereference a
NULL pointer and cause a kernel panic?

> +
> +static inline void knod_dev_offload(struct knod_dev *knodev,
> +					   struct bpf_prog *bpf_offloaded)
[ ... ]
> +extern struct list_head knod_accel_list;
> +
> +#define for_each_xdev(d)         \
> +		list_for_each_entry(d, &knod_dev_list, list)
> +#define for_each_xdev_safe(d)         \
> +		list_for_each_entry_safe(d, n, &knod_dev_list, list)

[Severity: Low]
Is the n parameter missing from the macro signature? Any file using this
macro without a pre-declared local variable n will likely fail to compile.

> +#define for_each_nodev(d)         \
> +		list_for_each_entry(d, &knod_netdev_list, list)
[ ... ]
> diff --git a/include/net/spsc_ring.h b/include/net/spsc_ring.h
> new file mode 100644
> index 0000000000000..1eccadc927d62
> --- /dev/null
> +++ b/include/net/spsc_ring.h
[ ... ]
> @@ -0,0 +1,645 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
[ ... ]
> +struct spsc_ring {
> +	void		**slots;	/* pointer-per-slot into pool */
> +	unsigned int	mask;		/* capacity - 1 */
> +
> +	/* Producer side */
> +	unsigned int	head;		/* next slot to publish */
> +
> +	/* Consumer side */
> +	unsigned int	tail;		/* oldest unconsumed slot */
> +	unsigned int	acquired;	/* sliding window read cursor
> +					 *   tail <=3D acquired <=3D head
> +					 */
> +
> +	/* Element pool */
> +	struct page	*pool_page;	/* compound page backing elements */

[Severity: Medium]
Does placing the heavily contended producer cursor (head) and consumer
cursors (tail, acquired) in the same cacheline without padding cause severe
false sharing? This could significantly impact throughput due to continuous
cacheline bouncing.

> +	unsigned int	pool_order;	/* page order */
> +	unsigned int	elem_stride;	/* cacheline-aligned element size */
> +} ____cacheline_aligned_in_smp;
> +
> +/* =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D */
[ ... ]
> +static inline int spsc_acquire(struct spsc_ring *r, void **out,
> +			       unsigned int max, unsigned int *cnt)
> +{
> +	/* acquire the producer's head; slots it published are now visible */
> +	unsigned int head =3D smp_load_acquire(&r->head);
> +	unsigned int acq =3D r->acquired;
> +	unsigned int avail;
> +	unsigned int i;
[ ... ]
> +	if (out) {
> +		for (i =3D 0; i < avail; i++)
> +			out[i] =3D r->slots[(acq + i) & r->mask];
> +	}
> +
> +	/* Publish the window to the releasing consumer (a different CPU than
> +	 * this acquirer): pair with the smp_load_acquire() in spsc_release()
> +	 * so it cannot observe the advanced cursor before the element stores
> +	 * (e.g. an accel verdict) those slots now point at.
> +	 */
> +	smp_store_release(&r->acquired, acq + avail);

[Severity: High]
On architectures like x86, smp_store_release is only a compiler barrier and
does not flush Write-Combining buffers. Is a wmb() needed here before
publishing the advanced cursor, similar to spsc_produce_commit, to prevent a
concurrent releaser from reading stale memory before the WC stores land?

> +
> +	if (cnt)
> +		*cnt =3D avail;
> +	return 0;
> +}
> +
> +/**
[ ... ]
> +static inline int spsc_push(struct spsc_ring *r, void **out)
> +{
> +	int ret;
> +
> +	ret =3D spsc_produce(r, out);
> +	if (ret)
> +		return ret;
> +
> +	spsc_produce_commit(r);
> +	return 0;
> +}

[Severity: High]
Doesn't spsc_produce_commit publish the slot to the consumer immediately? If
the slot is published before the caller writes the data into the pointer
returned in out, could a concurrent consumer read uninitialized data?

> +
> +/**
> + * spsc_pop - dequeue one element
> + * @r:   ring buffer
> + * @out: receives pointer to the consumed element
> + *
> + * The element pointer remains valid until the next spsc_push() or
> + * spsc_produce() reuses that slot.
> + *
> + * Returns 0 on success, -ENOENT if empty.
> + */
> +static inline int spsc_pop(struct spsc_ring *r, void **out)
> +{
> +	/* acquire the producer's head; slots it published are now visible */
> +	unsigned int head =3D smp_load_acquire(&r->head);
> +	unsigned int tail =3D r->tail;
> +
> +	if (tail =3D=3D head)
> +		return -ENOENT;
> +
> +	*out =3D r->slots[tail & r->mask];
> +
> +	r->acquired =3D tail + 1;
> +	/* release: hand the consumed slot back to the producer */
> +	smp_store_release(&r->tail, tail + 1);
> +
> +	return 0;
> +}

[Severity: High]
By advancing the tail cursor before returning the element pointer to the
consumer, is the slot made available to the producer too early? A concurrent
producer might overwrite the data while the consumer is actively reading it.

> +
> +/**
> + * spsc_pop_n - dequeue up to @n elements
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260719175857.4071=
636-1-ap420073@gmail.com?part=3D1
