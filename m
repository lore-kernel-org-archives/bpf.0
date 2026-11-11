Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794403247;
	b=K+IDv29hakDmsHTDQAsYhv2mgTDPmofwXZ/c7RhqnQjCF4BPxJatytZ88njK/TgQ/kfv
	 gdm7E96F8lrKL2ivsikHVxaLKpqPWyipJlH9905jqzS2bgQ6BC3n3SxM4mmt0FLRYOETw
	 6AJ7tjl01ig5QLep4Mj0ELqdW8FtxffWRJ7Xn8+aZ0vDhJMZEq4HF6jWbaSHdayPsCG7D
	 gBGJADpqMwK1Ze5Pya3ALKqE49X//uTf5mnVEQzb3nWR9rwU60efJVY1j/8DD5JED1djx
	 04w8/Uocj/aPzPE8qQ8vfbKfcO8u7c9fXekmmRhNTRoEf8A7w2pvUVs6NOEwWgZYXTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794403247;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=PsTusISIfkLb4YmiFCWu5Ncgbjr2BmauNQT+ft6mVr8=;
	b=wNiBU0b0/J2fiL+oMhq7P5ZHhP6JgaPskAWu+ef9z4RWpASyqwTwawVpG2DycdF83ndu
	 Mul5pTyAOypbjY/Pp6v555TybG9PzO4m68QOZFof4DA4wq9B7aEa/O4kSiD6PeAnQNg9o
	 wrcehRzcZr5Dq7vqoYxVYh3LKDYOFpG+inrlOYo5YIFxei4Rp7wbMuSRY1RyfMq6P40kl
	 IPn8+gYs61JwGxgoC4JyakZVyVfLpDgFXKhWsqi1WGy0hy1HoDSF3naqvuZwkvEfby0Fx
	 y+C/zc4/3iuslpaUq0FEq+22ykmGhIk5/NE466la6LTZE7dE6n3CYkpqFcu4cJSq3ug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FTKw4bDt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BDAB606A339
	for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 13:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FTKw4bDt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38CDD1F00A05;
	Wed, 11 Nov 2026 13:20:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794403247;
	bh=PsTusISIfkLb4YmiFCWu5Ncgbjr2BmauNQT+ft6mVr8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FTKw4bDtImPyC+DoL0/8z5p7nyp5j04S1Rs8dhH/oYNTMEfkpqb6yim535ov+sSKj
	 zvifzbY7tCdvQ3al4z15ywf9VZpZdbq96mfdiDdkAYBE1qpXSZH1wYNFKu08T5LR8k
	 GFZXPDgdo6H1m64Na++JbkhkObFisnyiPh7Icy5Y/sEO/Gn52ERA3OkTKQLhmimVlZ
	 j112KjC/yjkR+C2GV37FRtzN4FhrafFnWC2RQyoWob9LRZA0X4RyBj119DpH5j13Bu
	 HXOQqFsfGUGYf/flInX1tOwhsSunB+nrQYG0AffADpMzMummQucTgby40guZuVO67w
	 gndAfRGpU71sQ==
Message-ID: <sashiko-outbox-209067@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH net-next 10/12] io_uring/opaque: add
 IORING_OPAQUE_CREATE
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alex Markuze" <amarkuze@redhat.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261110132006.3280986-11-amarkuze@redhat.com>
References: <20261110132006.3280986-1-amarkuze@redhat.com>
 <20261110132006.3280986-11-amarkuze@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 13:20:46 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Medium] io_uring/opaque: double fetch of sqe->addr3 in
  io_opaque_prep()
- [Medium] io_uring/opaque: active memcg kept for user copy in
  io_opaque_create_build()
--

commit 990f7cf758f745b1bd5de4e8984b2d7a6df26c8e
Author: Alex Markuze <amarkuze@redhat.com>

io_uring/opaque: add IORING_OPAQUE_CREATE

This commit adds the IORING_OPAQUE_CREATE operation to IORING_OP_OPAQUE_OBJ,
allowing applications to construct immutable opaque objects synchronously f=
rom
userspace memory.

> diff --git a/io_uring/opaque.c b/io_uring/opaque.c
> index 4610e212a8005..78ae19a6ad82f 100644
> --- a/io_uring/opaque.c
> +++ b/io_uring/opaque.c
> @@ -1884,7 +1884,6 @@ int io_opaque_prep(struct io_kiocb *req, const stru=
ct io_uring_sqe *sqe)
>  	    READ_ONCE(sqe->buf_index) || READ_ONCE(sqe->__pad2[0]) ||
>  	    cmd > IORING_OPAQUE_AVAILABLE ||
>  	    cmd =3D=3D IORING_OPAQUE_COMPACT || cmd =3D=3D IORING_OPAQUE_SET_PO=
LICY ||
> -	    cmd =3D=3D IORING_OPAQUE_CREATE ||
>  	    (req->flags & (REQ_F_CQE_SKIP | REQ_F_FIXED_FILE)))
>  		return -EINVAL;
>  	op =3D io_opaque_req_alloc(req, store);
> @@ -1899,6 +1898,21 @@ int io_opaque_prep(struct io_kiocb *req, const str=
uct io_uring_sqe *sqe)
>  	op->offset =3D READ_ONCE(sqe->off);
>  	op->length =3D READ_ONCE(sqe->len);
>  	op->addr =3D u64_to_user_ptr(READ_ONCE(sqe->addr3));
> +	if (cmd =3D=3D IORING_OPAQUE_CREATE) {
> +		u64 pointer =3D READ_ONCE(sqe->addr3);
> +
> +		if (op->handle || op->offset || !op->length ||
> +		    op->length > INT_MAX || !pointer)
> +			return -EINVAL;
> +		if (op->length > store->config.max_object_size ||
> +		    ALIGN((u64)op->length, PAGE_SIZE) > io_opaque_rx_limit(store))
> +			return -EMSGSIZE;
> +		if (check_add_overflow(pointer, (u64)op->length, &end) ||
> +		    pointer > ULONG_MAX || end > ULONG_MAX ||
> +		    !access_ok(op->addr, op->length))
> +			return -EFAULT;
> +		return 0;
> +	}

[Severity: Medium]
Does reading sqe->addr3 twice from the shared submission ring allow op->addr
and pointer to diverge if userspace modifies the SQE concurrently?

The non-NULL, overflow, and 32-bit truncation checks validate the second re=
ad
in pointer, whereas access_ok() and the later copy_from_user() in
io_opaque_create_build() use op->addr from the first read. Reading sqe->add=
r3
once into a local u64 and deriving op->addr from it would keep the checks a=
nd
copy consistent.

> @@ -2046,12 +2060,110 @@ static int io_opaque_stat(struct io_opaque_req *=
op)
>  	return io_opaque_stat_copy(op, &stat, sizeof(stat));
>  }
> =20
> +/* Construction is synchronous under the ring lock, like READ_OBJECT cop=
ies. */
> +static int io_opaque_create_build(struct io_opaque_req *op)
> +{
> +	struct io_opaque_store *store =3D op->store;
> +	struct mem_cgroup *old =3D set_active_memcg(store->memcg);
> +	u64 done =3D 0;
> +	int ret =3D 0;
> +
> +	while (done < op->length) {
> +		u64 pages_left =3D DIV_ROUND_UP_ULL(op->length - done, PAGE_SIZE);
> +		struct io_opaque_extent *extent;
> +		unsigned int order;
> +		struct page *page;
> +		u32 chunk, written =3D 0;
> +
> +		page =3D io_opaque_dest_page(store, pages_left, &order);
> +		if (!page) {
> +			ret =3D -ENOMEM;
> +			goto out;
> +		}
> +		chunk =3D min_t(u64, op->length - done, PAGE_SIZE << order);
> +		extent =3D io_opaque_extent_new(store, page, 0, chunk, done, true);
> +		if (IS_ERR(extent)) {
> +			put_page(page);
> +			ret =3D PTR_ERR(extent);
> +			goto out;
> +		}
> +		op->create_reserved -=3D page_size(page);
> +		extent->backing->copied =3D true;
> +		list_add_tail(&extent->list, &op->data->extents);
> +		while (written < chunk) {
> +			u32 bytes =3D min_t(u32, chunk - written, PAGE_SIZE);
> +			unsigned long left;
> +			void *mapped;
> +
> +			mapped =3D kmap_local_page(page + (written >> PAGE_SHIFT));
> +			left =3D copy_from_user(mapped, op->addr + done + written, bytes);
> +			kunmap_local(mapped);

[Severity: Medium]
Does keeping store->memcg active across copy_from_user() charge the caller's
user page faults to store->memcg?

If copy_from_user() faults on unpopulated user pages when store->memcg
differs from the calling task's memcg (for instance on an imported store),
filemap page-cache allocations and __GFP_ACCOUNT fault allocations such as
user page tables are charged to active_memcg() (store->memcg) rather than t=
he
faulting task's cgroup, and remain charged after the opaque object is freed.
Scoping set_active_memcg(store->memcg) around the kernel allocations (as
io_opaque_frame_import() does) would avoid charging user faults to the stor=
e.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110132006.3280=
986-1-amarkuze@redhat.com?part=3D10
