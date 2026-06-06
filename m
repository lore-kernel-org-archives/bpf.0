Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C731318146
	for <bpf@vger.kernel.org>; Sat,  6 Jun 2026 21:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780782498; cv=none; b=ugV/ZwV7NBULZnohlgHfXAI1sko+cqWJwBN9YVaKnsnJMIYTDQWEcRGMLu115JoYLPelueX5CS70Bt7/UDn6NeMjCrlBOx/OYZZQwFJF762A7lEeHVlsZN3oO8epyDBjpxtMd/UzgAsu9df3le5t/3P2MqmrNY/HaDUehc4fLco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780782498; c=relaxed/simple;
	bh=dTOjLuy2JYn6b74OTUj8C0FjcwFcIGOekedOuiWFtxU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EdI9bAKY9ByXmpRptDnivu2YHqh1AG3v/cgVuD6Pe1q5IZ5v+sBleKYjZf8jwSgIeGJQgMVaGmbU4q4Wr+tp6kBISIOBPus2Z3Wou4ptsXr4JiA0LjVHz0KlCWHC8PeJm4MNt/EvPnv+xXAvcbdzCTjYJuPXGZRdpAPcESpxTfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aIZj2E78; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aIZj2E78"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDF991F00893;
	Sat,  6 Jun 2026 21:48:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780782497;
	bh=rUvvyVcAlpP96rFhW8sfhk0ANyTrXD3+NE3ggXjrhAs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aIZj2E78fcBZW2ommfJD42MYJ9lnZMfxS6XdcHiJzcEfBoA+yriHBi2L/8nXUWxB9
	 Y0VaQPx+RjN4rlfIslJx+Nz8bosemPDPy4RNCLSB8w/pHB06ZuZ3b1OksM/1xp6Mi/
	 /r4rEShT+49IpkNpwecDQwTVHM1aoX7cVDX+8pHUevLcEVhTZfMmKWTSor/k+A6BQl
	 Sj+bQznLnVc75wLrg4o5gpxzI/UFzPDoHGs1CpTbSE/Ucl0JwA2Bz8hQIL4X+EA7H1
	 ZkYeAu81ea0hXZPj7L4kVGkkO0UzLM1/NdR1j3pdzxQj3PM+cevNyg2Dypn+IjMSrT
	 Qp+NXpLuUcfNw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net] tls: fix use-after-free in tls_sw_sendmsg() cork
 error path
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sechang Lim" <rhkrqnwk98@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260605214802.1647008-1-rhkrqnwk98@gmail.com>
References: <20260605214802.1647008-1-rhkrqnwk98@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 06 Jun 2026 21:48:16 +0000
Message-Id: <20260606214816.EDF991F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [High] Rolling back a split record causes iterator corruption and integer=
 underflow.

Pre-existing issues:
- [High] Incomplete Use-After-Free fix leaves dangling `msg_en` pointer in =
error paths.
- [High] Silent data loss when `-ENOMEM` is returned and memory wait fails.
- [High] Memory leak of remainder record when asynchronous encryption retur=
ns `-EINPROGRESS`.
--

commit 660863238de21d269b42799c777dacfb8d63bed1
Author: Sechang Lim <rhkrqnwk98@gmail.com>

tls: fix use-after-free in tls_sw_sendmsg() cork error path

This commit attempts to fix a use-after-free in tls_sw_sendmsg_locked()
by re-fetching the msg_pl pointer from ctx->open_rec after
bpf_exec_tx_verdict() returns -ENOSPC and the record is split.

> diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
> --- a/net/tls/tls_sw.c
> +++ b/net/tls/tls_sw.c
[ ... ]
> @@ -1161,10 +1161,11 @@ static int tls_sw_sendmsg_locked(struct sock *sk,=
 struct msghdr *msg,
>  			if (ret) {
>  				if (ret =3D=3D -EINPROGRESS)
>  					num_async++;
>  				else if (ret =3D=3D -ENOMEM)
>  					goto wait_for_memory;
>  				else if (ctx->open_rec && ret =3D=3D -ENOSPC) {
> +					msg_pl =3D &ctx->open_rec->msg_plaintext;
>  					if (msg_pl->cork_bytes) {
>  						ret =3D 0;
>  						goto send_end;
>  					}
>  					goto rollback_iter;
>  				} else if (ret !=3D -EAGAIN)
>  					goto send_end;
>  			}
[ ... ]
> rollback_iter:
>  			copied -=3D try_to_copy;
>  			sk_msg_sg_copy_clear(msg_pl, first);
>  			iov_iter_revert(&msg->msg_iter,
>  					msg_pl->sg.size - orig_size);

[Severity: High]
When jumping to rollback_iter after the record is successfully split,
does msg_pl->sg.size - orig_size underflow?

Because msg_pl was updated to point to the new smaller remainder record,
msg_pl->sg.size is now smaller than the pre-split orig_size. This
subtraction results in a large positive value being passed to
iov_iter_revert(), corrupting the iterator state.

Additionally, sk_msg_sg_copy_clear() is called with the pre-split first
index, which is invalid for the new msg_pl scatterlist array. Does this
corrupt the remainder record?

[ ... ]
> fallback_to_reg_send:
>  			sk_msg_trim(sk, msg_pl, orig_size);
>  		}
>
>  		required_size =3D msg_pl->sg.size + try_to_copy;
>
>  		ret =3D tls_clone_plaintext_msg(sk, required_size);
>  		if (ret) {
>  			if (ret !=3D -ENOSPC)
>  				goto send_end;
>
>  			/* Adjust try_to_copy according to the amount that was
>  			 * actually allocated. The difference is due
>  			 * to max sg elements limit
>  			 */
>  			try_to_copy -=3D required_size - msg_pl->sg.size;
>  			full_record =3D true;
>  			sk_msg_trim(sk, msg_en,
>  				    msg_pl->sg.size + prot->overhead_size);

[Severity: High]
This is a pre-existing issue, but does this leave the msg_en pointer
dangling?

The patch fixes the use-after-free for msg_pl, but msg_en is not
re-fetched. If the original record was queued and potentially freed by
tls_tx_records(), dereferencing msg_en here in the fallback path
results in a use-after-free identical to the one fixed for msg_pl.

[ ... ]
> wait_for_memory:
>  		ret =3D sk_stream_wait_memory(sk, &timeo);
>  		if (ret) {
> trim_sgl:
>  			if (ctx->open_rec)
>  				tls_trim_both_msgs(sk, orig_size);
>  			goto send_end;
>  		}

[Severity: High]
This is a pre-existing issue, but does this cause silent data loss if
sk_stream_wait_memory() fails?

In the zero-copy path, the copied variable is incremented by
try_to_copy before bpf_exec_tx_verdict() is called. If
bpf_exec_tx_verdict() returns -ENOMEM, we jump to wait_for_memory.

If the wait is interrupted (for example, by a signal), it jumps to
trim_sgl and drops the appended bytes via tls_trim_both_msgs(). However,
copied is never decremented to reflect this drop, leading userspace to
believe bytes were buffered or sent when they were actually discarded.

>  		if (ctx->open_rec && msg_en->sg.size < required_size)
>  			goto alloc_encrypted;

[Severity: High]
This is a pre-existing issue, but can this also trigger a use-after-free
on msg_en?

If bpf_exec_tx_verdict() returns -ENOMEM after the record was split and
queued, the code jumps directly to wait_for_memory without updating
msg_en. When sk_stream_wait_memory() resumes, msg_en->sg.size is
dereferenced, but it may point to the freed original record.


While reviewing this area, I also noticed a pre-existing issue in
tls_push_record() in the same file:

[Severity: High]
This is a pre-existing issue, but does this leak the tmp remainder
record when asynchronous encryption returns -EINPROGRESS?

tls_push_record() allocates a tmp remainder record when splitting:

net/tls/tls_sw.c:tls_push_record() {
    ...
    if (split) {
        tmp =3D tls_split_open_record(sk, rec, &orig_end, &msg_pl, &msg_en,
                                    &copied, &zc_frame, &bpf_strp);
    ...
    rc =3D tls_do_encryption(sk, tls_ctx, ctx, req, req_size, copied,
                           record_type);
    if (rc < 0) {
        if (rc !=3D -EINPROGRESS) {
            tls_err_abort(sk, -EBADMSG);
            if (split) {
                ...
                tls_merge_open_record(sk, rec, tmp, orig_end);
            }
        }
        ctx->async_capable =3D 1;
        return rc;
    }
}

If tls_do_encryption() returns -EINPROGRESS, the function returns
immediately. The newly allocated tmp record is never assigned to
ctx->open_rec, never merged back, and never queued. Are the tmp record
and its allocations permanently leaked here?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260605214802.1647=
008-1-rhkrqnwk98@gmail.com?part=3D1
