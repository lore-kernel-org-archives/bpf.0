Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFC2440E8E7
	for <bpf@vger.kernel.org>; Fri,  5 Jun 2026 13:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780666843; cv=none; b=WbwZR9zw2T7fIqtmh8iAVG/sRuxrjEInQYV78Hhqnqsxx5Ro99mN4GPEloM9Eritvr6HN7w06H4tEfm/82vtkYrM42XIFFGlAJTNpaUNrY9neSXeOjt/DOAGO0Uc7TnWlhg5Md2Bgec69mDJaUZOvrA3fwv2yEBzjBhkyg3DkC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780666843; c=relaxed/simple;
	bh=uZxWDcg+X4RU0rbHDv3upuoF0lsebl1TKx9rVU3wVIY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jNpJ+nRJhItRqxwY9RLCInmTikQxAt/pag0HGvYOilc53HDAqnGSpdbF8QXU2c4aw7OyJiHm558ySV6lqH/QxIRthXzCwa8hIqR42BOKTu3qMFAXgcfJT9ij6AH6ilHCCqgqfnItR50ISLXOV0xEi3e7zD/MvN0cYSBc21xH4Hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YLRoqcVT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YLRoqcVT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 623E31F00893;
	Fri,  5 Jun 2026 13:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780666841;
	bh=nk4+RFI2hZ8KanJe+VWiCFn+wv9mgXA3qzPNFDjXlBQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YLRoqcVTrqQ3hbDvgQNc5Mw4V3aKEcijZll1IKg6voYl7zRklJLv/4olaZ3qy1crK
	 VeARo7CPy3rNxM5At/oNwgqcVYANt9d3CN/SGwxsb0wJ7LeVvSXpa5Jo02eV8zrjQV
	 wZql97XKiup3hTo8Bw0My6GtPplQwbpy26cerw6WsnEQ5CMeVZymNXJfNIpzZNsxUU
	 hXIKwcairgbxkM/Yw9+/+IhoZ1S2qf8KaAZAue0B4eFKeALhTF2lzB4Y40YMeOgn4M
	 GdXs+X4pSXP+JuzTa0DtyhlmwYAaHrIXBQKkI1FcN57lrQLZrCip5wsz9K9/bBifnm
	 +5vDweDbWX4JQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net] net/tls: preserve sk_msg sg.copy when splitting
 records
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yiming Qian" <yimingqian591@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260604134019.39161-1-yimingqian591@gmail.com>
References: <20260604134019.39161-1-yimingqian591@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 05 Jun 2026 13:40:40 +0000
Message-Id: <20260605134041.623E31F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] tls_merge_open_record incorrectly merges naturally contiguous =
scatterlist elements, leading to a page double-free.
- [Critical] tls_split_open_record() ignores the split_point argument, lead=
ing to an out-of-bounds write in the crypto layer.
- [High] sk_msg element shifting functions fail to shift the msg->sg.copy b=
itmap, allowing BPF to overwrite externally owned page cache memory.
- [High] sk_msg_alloc reuses freed scatterlist indices without clearing the=
 msg->sg.copy bit, causing valid memory to be treated as read-only.
--

commit d2043cc374b476d5c2b7d9a3d811593ca2bebf5c
Author: Yiming Qian <yimingqian591@gmail.com>

net/tls: preserve sk_msg sg.copy when splitting records

This patch modifies tls_split_open_record to correctly copy the sg.copy
bit state from the original sk_msg into the new sk_msg when an open record
is split. It introduces a helper sk_msg_sg_copy_one to facilitate this bit
copying for both partial and whole tail entries.

> diff --git a/include/linux/skmsg.h b/include/linux/skmsg.h
> index 19f4f253b4f90..f3988ce2219db 100644
> --- a/include/linux/skmsg.h
> +++ b/include/linux/skmsg.h
[ ... ]
> diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
> index 964ebc268ee46..434753de8aadd 100644
> --- a/net/tls/tls_sw.c
> +++ b/net/tls/tls_sw.c
> @@ -623,6 +623,7 @@ static int tls_split_open_record(struct sock *sk, str=
uct tls_rec *from,
>  	struct scatterlist *sge, *osge, *nsge;
>  	u32 orig_size =3D msg_opl->sg.size;
>  	struct scatterlist tmp =3D { };

[Severity: Critical]
This is a pre-existing issue, but does tls_split_open_record ignore the
split_point argument?

When a BPF program uses bpf_msg_push_data to expand a payload beyond the
pre-allocated encrypted buffer capacity, tls_push_record calculates a
necessary split_point and calls tls_split_open_record.

However, tls_split_open_record ignores the split_point argument entirely
and unconditionally sets apply =3D msg_opl->apply_bytes.

If apply_bytes is 0, the function effectively splits at 0 bytes, creating
an empty msg_opl. The fallback logic in tls_push_record then merges them
back together.

Subsequently, sk_msg_trim silently fails because the size is larger than
the target, and tls_do_encryption uses the undersized buffer to encrypt
the oversized msg_pl. Can this cause an out-of-bounds write in the
scatterlist array when constructing the crypto request?

> +	u32 tmp_i =3D NR_MSG_FRAG_IDS;
>  	struct sk_msg *msg_npl;
[ ... ]

net/tls/tls_sw.c:tls_merge_open_record() {
    ...
    if (sg_page(osge) =3D=3D sg_page(nsge) &&
        osge->offset + osge->length =3D=3D nsge->offset) {
        osge->length +=3D nsge->length;
        put_page(sg_page(nsge));
    }
    ...
}

[Severity: Critical]
This isn't a bug introduced by this patch, but does tls_merge_open_record
incorrectly merge naturally contiguous scatterlist elements?

When tls_split_open_record splits an open record exactly on an element
boundary, no extra page reference is acquired.

If encryption subsequently fails, tls_merge_open_record attempts to merge
the elements back. To detect a split element, it merely checks if the
pages are the same and the offsets are contiguous.

If the user originally provided two elements that were naturally contiguous
in memory, this condition falsely evaluates to true. tls_merge_open_record
then adds their lengths and calls put_page on sg_page(nsge), improperly
releasing a reference that was never taken.

The element remains in the scatterlist, resulting in another put_page
during destruction. Does this directly cause a double-free on the page?

net/core/filter.c:sk_msg_shift_left() {
    ...
    do {
        prev =3D i;
        sk_msg_iter_var_next(i);
        msg->sg.data[prev] =3D msg->sg.data[i];
    } while (i !=3D msg->sg.end);
    ...
}

net/core/filter.c:sk_msg_shift_right() {
    ...
    while (i !=3D msg->sg.end) {
        msg->sg.data[i] =3D sge;
        sk_msg_iter_var_next(i);
        sge =3D tmp;
        tmp =3D sk_msg_elem_cpy(msg, i);
    }
    ...
}

[Severity: High]
This is a pre-existing issue, but do the sk_msg element shifting functions
fail to shift the msg->sg.copy bitmap?

BPF helpers manipulate sk_msg scatterlist arrays using sk_msg_shift_left
and sk_msg_shift_right. These functions physically shift the msg->sg.data
entries but fail to concurrently shift the corresponding msg->sg.copy
bitmap.

Consequently, shifted scatterlist elements incorrectly inherit the
read-only states of their new indices.

If a read-only element is shifted into an index where the copy bit is 0,
sk_msg_compute_data_pointers will erroneously provide a writable data
pointer to the BPF program. Could this allow an unprivileged BPF program
to write to externally owned page cache pages?

net/core/skmsg.c:sk_msg_alloc() {
    ...
        sge =3D &msg->sg.data[msg->sg.end];
        sg_unmark_end(sge);
        sg_set_page(sge, pfrag->page, use, orig_offset);
        get_page(pfrag->page);
        sk_msg_iter_next(msg, end);
    ...
}

net/core/skmsg.c:sk_msg_free_elem() {
    ...
    memset(sge, 0, sizeof(*sge));
    return len;
}

[Severity: High]
This isn't a bug introduced by this patch, but does sk_msg_alloc reuse
freed scatterlist indices without clearing the msg->sg.copy bit?

When sk_msg_free_elem or sk_msg_trim frees a scatterlist element, it zeroes
the sg.data entry but does not clear the corresponding bit in the
msg->sg.copy bitmap.

If sk_msg_alloc later allocates new memory and reuses that same index in
the ring buffer, the stale copy bit remains set.

Because of this, sk_msg_compute_data_pointers incorrectly assumes the newly
allocated, writable memory is read-only and sets msg->data to NULL. Does
this abruptly break BPF programs that rely on writing to pushed data?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260604134019.3916=
1-1-yimingqian591@gmail.com?part=3D1
