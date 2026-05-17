Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE67F1F16B
	for <bpf@vger.kernel.org>; Sun, 17 May 2026 12:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779022203; cv=none; b=PZSsqgXFfVjdJaSm3avQsxjuRQhwcXEpyjEubGTT1qHOGIGrQkrBsgOgQoSz2poAAhrwmaLCTOKkC6yqha/ucddJn1xctPkVtEfK0vjtuFdGUGONJxNmlXz9ukdlIH2/wvnXGa022tI1OtBGvqvYk9wtqFeNO/eG38kMYfu2h4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779022203; c=relaxed/simple;
	bh=7/Dca950+SZ2zLKpwTSHJvk4OmULaol1EhGONdb/KcE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uI3OmugiKy+anChD5BdS3OmwEtY75wRqWs86S1OFjvMUMXnj7dozBV/ybd8iwNsTYwT4QHlCbnD1iFTZEyGOPsDEJvRvbVL+iqeTfhkRfLxO7vGhyXqpfLcNdtxzY2I+28UsHFPde6q2kWE0C0oohwqIwwV9kDicGYdZ9BvH01k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y3bLqdSb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y3bLqdSb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82952C2BCB0;
	Sun, 17 May 2026 12:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779022202;
	bh=7/Dca950+SZ2zLKpwTSHJvk4OmULaol1EhGONdb/KcE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=Y3bLqdSbSc2ayZrPsmLMpiSxipRDPf4js8quHZVu9x6gDSDu0eY+wWYIZ71G5dJoD
	 k1tgTz07JHk3zAnGf51/rTiz5T4NhHgeJ77QNeD9OpEhTl/wH6tKODtELrBg2AhyHw
	 lMbbiCFeQKcWrVcXde/493ZBhBMYM6UvK8ubRpkjUPEAnokVopmZ4GZUX+WlGw+Bej
	 wptLpihLvvvsIqvuj/FE2gpjWQ/sQTE/7EWwmsZuJDXAQfCQV71dfW7yKy9kOnxkd1
	 MtwqONjjwEr6SsJVYIIfmqSZCYqyAqUQbGeBVVFSLcwu4Rs6ieK1TTtfL6nxb6haKw
	 QUaZbqFvfucAw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] bpf, sockmap: keep sk_msg copy state in sync
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zhang Cen" <rollkingzzc@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260517121626.406516-1-rollkingzzc@gmail.com>
References: <20260517121626.406516-1-rollkingzzc@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 17 May 2026 12:50:01 +0000
Message-Id: <20260517125002.82952C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Critical] Integer Overflow in bpf_msg_push_data() leading to Out-of-boun=
ds Write
- [High] Uninitialized Memory Leak (Information Disclosure) in bpf_msg_push=
_data()
- [High] Ring Buffer Overflow and Data Corruption in bpf_msg_push_data()
--

commit 9081fa26db59dd3001e41a16c3e730205c716696
Author: Zhang Cen <rollkingzzc@gmail.com>

bpf, sockmap: keep sk_msg copy state in sync

sk_msg uses msg->sg.copy as per-scatterlist-entry provenance. Entries with
this bit set are copied before data/data_end are exposed to sk_msg bpf
programs for direct packet access. bpf_msg_pull_data(), bpf_msg_push_data()
and bpf_msg_pop_data() rewrite the sk_msg scatterlist ring by collapsing,
splitting and shifting entries.

[ ... ]

> diff --git a/net/core/filter.c b/net/core/filter.c
> index 9590877b0714f..018c30a0d71fb 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c

[ ... ]

> @@ -2794,6 +2827,8 @@ BPF_CALL_4(bpf_msg_push_data, struct sk_msg *, msg,=
 u32, start,
>  {
>  	struct scatterlist sge, nsge, nnsge, rsge =3D {0}, *psge;
>  	u32 new, i =3D 0, l =3D 0, space, copy =3D 0, offset =3D 0;
> +	bool sge_copy =3D false, nsge_copy =3D false, nnsge_copy =3D false;
> +	bool rsge_copy =3D false;
>  	u8 *raw, *to, *from;
>  	struct page *page;

This isn't a bug in this patch, but does bpf_msg_push_data() leak
uninitialized kernel memory?

bpf_msg_push_data() allocates a new memory page for the pushed data and the
copied bytes:

net/core/filter.c:bpf_msg_push_data() {
    ...
	page =3D alloc_pages(__GFP_NOWARN | GFP_ATOMIC | __GFP_COMP,
			   get_order(copy + len));
    ...
	sg_set_page(&msg->sg.data[new], page, len + copy, 0);
    ...
}

Since the allocation does not include the zeroing flag, the new len bytes
inserted into the message are never explicitly zeroed or initialized.

If the bpf program does not manually overwrite these bytes and the message =
is
transmitted over a socket, does this regression leak uninitialized kernel
memory to the network or userspace?

Also in bpf_msg_push_data(), could len cause an integer overflow leading to=
 an
out-of-bounds write?

The len parameter is an unbounded u32 value passed from a bpf program. When
calculating the allocation size, copy + len can overflow a 32-bit integer:

net/core/filter.c:bpf_msg_push_data() {
    ...
	page =3D alloc_pages(__GFP_NOWARN | GFP_ATOMIC | __GFP_COMP,
			   get_order(copy + len));
    ...
		if (back) {
			from +=3D front;
			to =3D raw + front + len;

			memcpy(to, from, back);
		}
    ...
}

If copy + len wraps around, alloc_pages() will allocate an undersized buffe=
r.

Later, the destination pointer for shifting tail data is calculated as
to =3D raw + front + len. Due to len being a large value, front + len wraps
around and results in a large positive 32-bit offset (zero-extended to
64-bit).

memcpy(to, from, back) then performs a controlled out-of-bounds write well
past the allocated page.

Could this regression lead to memory corruption?

Could the ring buffer state become corrupted when data is appended exactly =
at
the end of the message and the ring buffer is full?

In bpf_msg_push_data(), if data is appended exactly at the end of the messa=
ge
(start =3D=3D offset + l), the loop finishes with i pointing to the unused =
slot
msg->sg.end:

net/core/filter.c:bpf_msg_push_data() {
    ...
	if (!space || (space =3D=3D 1 && start !=3D offset))
		copy =3D msg->sg.data[i].length;
    ...
}

If the ring buffer is full (!space), the coalescing fallback logic reads
copy =3D msg->sg.data[i].length. Because i points to an unused slot, its le=
ngth
is 0, making copy =3D=3D 0, and the fallback coalescing block (if (copy) { =
... })
is bypassed.

The function then unconditionally calls sk_msg_iter_next(msg, end), which
increments msg->sg.end.

Since the ring buffer was already full, advancing msg->sg.end causes it to
wrap around and equal msg->sg.start.

Does this regression corrupt the ring buffer state and overwrite the first
element without calling put_page(), leading to page leaks?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260517121626.4065=
16-1-rollkingzzc@gmail.com?part=3D1
