Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2515333E35C
	for <bpf@vger.kernel.org>; Wed, 13 May 2026 01:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778636357; cv=none; b=c9pY2QZQT9lr8zBZniPaaULf15yp2NiBmKBx7LbKYfIaJVIL8iUa7gkXMOyXwD3yzZqWHRJiM6q/qGNf/Do/NW+NMDhxEBePN+Azy+LK3VMyTcD9TRSbOV3DYGTo80WaVo5uyz/X+ab2riKMMrx3lAdAzNu6C+LUrchc+PVs/2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778636357; c=relaxed/simple;
	bh=QaX5Q5EUyiXFOqB1SfRSfi0jT97+h8iTn1pZH5G+Kbo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=B08zINChMznKIZT9zcMQzu+YQYtTvvfIFjalKRlWrU6clfBb0es065+17TBg55gQcjou/OT/o4IWS8nnD5iYI5+aAzlNn6knrhQknAlv/b2r6SXdDalUiMcd97P1Q/x/ivW2AVRMLTSCGNIK4aszJJ0eDWuWAOmAczfdHc+k7GI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n3Rct9KX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n3Rct9KX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37E1FC2BCB8;
	Wed, 13 May 2026 01:39:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778636356;
	bh=QaX5Q5EUyiXFOqB1SfRSfi0jT97+h8iTn1pZH5G+Kbo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=n3Rct9KXndBGExW9KtLASeJh6oUEbfAfTGeGZl8JfvEE2x42G6wTadF+yF4FqmA59
	 HD2kG+sMe89FjFhw2StrYfULTkGT119n53uQVBG93YSdzSEA/Ht2gzD2n/0IyAF849
	 9vgQCpq39gEt+PAbOR66WsayG35W7p3nyzXItO6IVLTBIEYWh5Ac1Nn952bMfrTDOL
	 0t/0YudeVsLghS11EgqEEl8P6fIwE4ZvIJx/Tfhctve8ta9cRVZUAJL/Vy6JPz1V42
	 uZrtq7GWOVNjJDnPqSxLNIGTS6z5cchtIaNzmfcNpll76eroq994h7YphGXp+q23h6
	 B3xEo8VxphTlA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v2 4/4] net: tls: remove bad rollback and UAF on
 ENOSPC
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jakub Kicinski" <kuba@kernel.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260511174920.433155-5-kuba@kernel.org>
References: <20260511174920.433155-5-kuba@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 13 May 2026 01:39:15 +0000
Message-Id: <20260513013916.37E1FC2BCB8@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] Silent data loss and stale state usage (UAF) in the -ENOMEM er=
ror path.
- [High] BPF policy bypass due to uncleared psock->eval state on -ENOMEM.
--

commit 9867dad26c6eb929c35af6ad7b485aac95c01aef
Author: Jakub Kicinski <kuba@kernel.org>

net: tls: remove bad rollback and UAF on ENOSPC

This commit removes the attempt to roll back the iterator when BPF
encounters an ENOSPC error. Since BPF may have modified the message,
variables like orig_size and other pointers become stale, so rolling
them back leads to use-after-free or corruption.

> diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
> index 360f71fd78842..22b77840e35ae 100644
> --- a/net/tls/tls_sw.c
> +++ b/net/tls/tls_sw.c
> @@ -1164,11 +1164,8 @@ static int tls_sw_sendmsg_locked(struct sock *sk, =
struct msghdr *msg,
>  				else if (ret =3D=3D -ENOMEM)
>  					goto wait_for_memory;

The commit message notes that BPF may have modified the message, making
pointers and state stale. Does this same stale state issue still exist in
the -ENOMEM path?

If bpf_exec_tx_verdict() executes BPF (which may push or pop data) and then
fails with -ENOMEM, execution jumps to wait_for_memory:

wait_for_memory:
        ret =3D sk_stream_wait_memory(sk, &timeo);
        if (ret) {
trim_sgl:
            if (ctx->open_rec)
                tls_trim_both_msgs(sk, orig_size);
            goto send_end;
        }

If sk_stream_wait_memory() fails, the code calls tls_trim_both_msgs(sk,
orig_size). Can trimming to the pre-BPF orig_size corrupt the scatterlist
if BPF changed the size?

Additionally, copied was already incremented by try_to_copy. Since the
function returns copied, might it falsely indicate to userspace that the
discarded bytes were successfully sent, causing silent data corruption?

What happens if sk_stream_wait_memory() succeeds instead? The loop in
tls_sw_sendmsg_locked() restarts, appending more data from userspace to
the open record.

If tls_push_record() inside the bpf_exec_tx_verdict() path returns -ENOMEM,
does it return early without resetting psock->eval to __SK_NONE?

If so, when bpf_exec_tx_verdict() is called again, could it see psock->eval
evaluating to __SK_PASS and skip the BPF evaluation entirely, allowing
the newly appended data to be sent without verification?

>  				else if (ctx->open_rec && ret =3D=3D -ENOSPC) {
> -					if (msg_pl->cork_bytes) {
> -						ret =3D 0;
> -						goto send_end;
> -					}
> -					goto rollback_iter;
> +					ret =3D 0;
> +					goto send_end;
>  				} else if (ret !=3D -EAGAIN)
>  					goto send_end;
>  			}

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260511174920.4331=
55-1-kuba@kernel.org?part=3D4
