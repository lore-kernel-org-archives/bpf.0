Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDDC837BE73
	for <bpf@vger.kernel.org>; Thu, 30 Apr 2026 22:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777588294; cv=none; b=VWHCAkaDsBDakQKAwkx02rZotJgmK/uXcj6fLFV48Pei4D2K9syyQYYTWYNZFk2YEzvOWBCxWenIm68MrCuoFCSoPLDIJe2YfUQoW/z9cFVfyG/JMd6Er6X2CZ8l7mxX5AO8NQAXJ0xyVWBcES9vCKx8n+cv4uQVcMZueWAlMpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777588294; c=relaxed/simple;
	bh=doPcbtPxlN5/tuWeenrkC1sHAArF9mgd7LjPbvmBW+Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YhCBGTHUu3wsfEgEGiICIc+OMI0Fa5JmYAR+g5nv29HNfv+aHhhjGpl/PEJQq+jEIciaucnAUzxMIm9zDc9XxvTKotV/zJlKSTbCdqN+sETSsG8OfieO80lC/k0S7uLSphv9HtbdKdcblm0wBxrG1t2+cea3MjMhD7HykuljhTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u3Z1PzCc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u3Z1PzCc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 844A3C2BCC6;
	Thu, 30 Apr 2026 22:31:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777588293;
	bh=doPcbtPxlN5/tuWeenrkC1sHAArF9mgd7LjPbvmBW+Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=u3Z1PzCchdIe3HEsugPJ9Mxwgp6n/f0FFD818HxlAUmR6BVUoDlavCg4BUQrATQwX
	 bxPssxG1POpeL8kjBT/+F1g3hcQ8rJnn92WK5e2UiPCYo+OAUxz++OKgxUOUvgx4rq
	 P9W5tnx2aX1a5mQ1JC1okx1A/Rd1Gxc9CNn4FGn9x4+jHqW/ilihOnSIHVMzb65q7/
	 PhzXD6eLBuNxJxpoqVZxdJlzKFQbDCxAyB3lnCXHAk0mHqPu6KsjQsEAgwluyPUeCo
	 M1WUeu5Oqw6UNFtZ2rlEuqDMkdUl9XjTh7kBS1BsEfp2ENLaTYzo3kzBWjlKXKAhBc
	 HWKYshnYoqr5A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net 6/7] net: tls: fix use-after-free in
 tls_sw_sendmsg_locked after bpf verdict
Reply-To: sashiko@lists.linux.dev
To: "Jakub Kicinski" <kuba@kernel.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260429222944.2139041-7-kuba@kernel.org>
References: <20260429222944.2139041-7-kuba@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Apr 2026 22:31:32 +0000
Message-Id: <20260430223133.844A3C2BCC6@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] Arithmetic underflow, state corruption, and silent data duplic=
ation in the iterator rollback path.
- [High] Use-After-Free when `bpf_exec_tx_verdict` returns `-ENOMEM`.
--

commit ba7ab075901b934710734a96c18f344dbc28cf04
Author: Jakub Kicinski <kuba@kernel.org>

net: tls: fix use-after-free in tls_sw_sendmsg_locked after bpf verdict

This patch fixes a use-after-free in tls_sw_sendmsg_locked() when
bpf_exec_tx_verdict() returns -ENOSPC. It updates msg_pl and msg_en after a
possible record split to avoid referencing a freed record.

> diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
> index 2c6a3c4a9fcc..4f8d656f39a3 100644
> --- a/net/tls/tls_sw.c
> +++ b/net/tls/tls_sw.c
> @@ -1157,6 +1157,13 @@ static int tls_sw_sendmsg_locked(struct sock *sk, =
struct msghdr *msg,
>  				else if (ret =3D=3D -ENOMEM)
>  					goto wait_for_memory;

If bpf_exec_tx_verdict() splits the record, pushes it to tx_list, and then
encounters an -ENOMEM error while transmitting, it returns -ENOMEM.

This jumps to wait_for_memory without refetching msg_en. If
sk_stream_wait_memory() returns 0, the loop continues and evaluates:

	if (ctx->open_rec && msg_en->sg.size < required_size)
		goto alloc_encrypted;

Could this result in a use-after-free read when dereferencing msg_en->sg.si=
ze,
since msg_en still points to the freed original record?

>  				else if (ctx->open_rec && ret =3D=3D -ENOSPC) {
> +					/* bpf_exec_tx_verdict() may have
> +					 * called tls_split_open_record(),
> +					 * freeing the old record. Re-fetch.
> +					 */
> +					rec =3D ctx->open_rec;
> +					msg_pl =3D &rec->msg_plaintext;
> +					msg_en =3D &rec->msg_encrypted;
>  					if (msg_pl->cork_bytes) {
>  						ret =3D 0;
>  						goto send_end;

If bpf_exec_tx_verdict() splits the record and then returns -ENOSPC (for
example, from a failed sk_msg_alloc on the remainder), the new msg_pl points
to the remainder record. If msg_pl->cork_bytes is 0, execution falls through
to rollback_iter:

rollback_iter:
	copied -=3D try_to_copy;
	sk_msg_sg_copy_clear(msg_pl, first);
	iov_iter_revert(&msg->msg_iter,
			msg_pl->sg.size - orig_size);

Since msg_pl is now the remainder record, its size might be smaller than
orig_size. Does the subtraction in iov_iter_revert() underflow and corrupt
the iterator state?

Also, sk_msg_sg_copy_clear(msg_pl, first) is called, but 'first' was captur=
ed
from the original record. Could this cause an out-of-bounds access on the
remainder's scatterlist?

Additionally, is it safe to roll back the iterator after the first chunk of
the split record was successfully transmitted? It seems this could lead to
the application re-sending already committed data.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260429222944.2139=
041-1-kuba@kernel.org?part=3D6
