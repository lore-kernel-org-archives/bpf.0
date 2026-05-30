Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58E251AA1F4
	for <bpf@vger.kernel.org>; Sat, 30 May 2026 00:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780101859; cv=none; b=ih3JidpPwqTYCGMSmUPhN7+mwR11avb1/JhLxJI8P+ksL0nNk9783smpcapfZZ+6pCGCc/C7H2Z60glXKH0gkN5QK/kZO9dF8WPVh8yoxiXf8vVFkDiKsCpMj6KhdZpi8MBh1zxFLkxpbgkkGmiw8Zgh/mrV0jRAP/K8tgQXa6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780101859; c=relaxed/simple;
	bh=FvL/bfry83WcTVrgvxIJiZCmgH6KVcqc6fK3+bvMnes=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=PQwNOeUjas0loEOtpU4GOxxs9XYEXtY5nC0YT0GNpoUn0EOtTb2/x/+5u8KO9GVfh5Tf4rmP16ARR9FsMaZTRvSt/Q8FUT6xjxwopkRuMfwWumN4j+IkNbNYEc/rR8YD2jb2ptjotmgcq3eItRqKRBF25aaE1WlKWY0zYsXdWG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KNt/Ibqg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KNt/Ibqg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BF251F00893;
	Sat, 30 May 2026 00:44:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780101858;
	bh=kNoAvEMYE9nnr1kwTUYJLypNiPFMes6IT5mzKMaB3U0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KNt/Ibqgd+75o4r+zixQD8ssXZRdwkOBRQ4KXHYvQqbLhKZ03gA+JxP5W3AwUn8sj
	 twxX3TOF1nMEi/KYb2gyn+U0ql7pMHih5qQrTXzRDIEoBKBp+R5D5X/b/0nnCYbdOW
	 L/cfu53ND1f8hBcOX8xim35Y00po9BQzCs8wEewelRDzxXEU6JQLD6XTOvWdFUpyb/
	 1tWXpAEwLgiYXWEkwZCeO2rczKTDKktXt8HNteDFQQwgQlwA4Mml79hJX8lT/r4l4p
	 iq0SEPOrjVudoA1njbB7hFeMzjmHPLfe+ea0+iNxo7NqFqxAk21o/ZuiugDPGzgY9s
	 P5V4vUshgeEtQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v4 5/5] selftests/xsk: drain CQ to wait for TX
 completion
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jason Xing" <kerneljasonxing@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260520004244.55663-6-kerneljasonxing@gmail.com>
References: <20260520004244.55663-6-kerneljasonxing@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 30 May 2026 00:44:17 +0000
Message-Id: <20260530004418.0BF251F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The newly added TX drain loop and `outstanding_tx` clamping intr=
oduce a race condition that causes premature exit from `wait_for_tx_complet=
ion()`, leaving valid packets in the TX ring and causing flaky test timeout=
s.
--

commit dbc5e902ae609e02c24da36756b02d3a7d8a3445
Author: Jason Xing <kerneljasonxing@gmail.com>
Subject: selftests/xsk: drain CQ to wait for TX completion

This commit addresses an issue where dropped multi-buffer descriptors publi=
sh
their addresses to the completion queue via the skb destructor. It modifies
complete_pkts() to clamp outstanding_tx to zero and adds a drain loop in
wait_for_tx_completion().

> diff --git a/tools/testing/selftests/bpf/prog_tests/test_xsk.c b/tools/te=
sting/selftests/bpf/prog_tests/test_xsk.c
> --- a/tools/testing/selftests/bpf/prog_tests/test_xsk.c
> +++ b/tools/testing/selftests/bpf/prog_tests/test_xsk.c
[ ... ]
> @@ -950,17 +950,11 @@ static int complete_pkts(struct xsk_socket_info *xs=
k, int batch_size)
> =20
>  	rcvd =3D xsk_ring_cons__peek(&xsk->umem->cq, batch_size, &idx);
>  	if (rcvd) {
> -		if (rcvd > xsk->outstanding_tx) {
[ ... ]
> -			return TEST_FAILURE;
> -		}
> -
>  		xsk_ring_cons__release(&xsk->umem->cq, rcvd);
> -		xsk->outstanding_tx -=3D rcvd;
> +		if (rcvd > xsk->outstanding_tx)
> +			xsk->outstanding_tx =3D 0;

[Severity: Medium]
Does this clamping of xsk->outstanding_tx to 0 cause the main wait loop in
wait_for_tx_completion() to exit prematurely?

> +		else
> +			xsk->outstanding_tx -=3D rcvd;
>  	}
> =20
>  	return TEST_PASS;
[ ... ]
> @@ -1293,6 +1289,17 @@ static int wait_for_tx_completion(struct xsk_socke=
t_info *xsk)
>  		complete_pkts(xsk, xsk->batch_size);
>  	}
> =20
> +	do {
> +		if (xsk_ring_prod__needs_wakeup(&xsk->tx))
> +			kick_tx(xsk);
> +		rcvd =3D xsk_ring_cons__peek(&xsk->umem->cq, xsk->batch_size, &idx);
> +		if (rcvd)
> +			xsk_ring_cons__release(&xsk->umem->cq, rcvd);
> +	} while (rcvd);

[Severity: Medium]
Can this drain loop exit early if the hardware is actively processing packe=
ts
but the completion queue is momentarily empty?

If rcvd =3D=3D 0 is momentarily true, the loop exits. The 100 microsecond s=
leep
might be insufficient on real hardware, which would leave valid descriptors
stranded in the TX ring because the TX thread exits and stops issuing wakeu=
ps.

Would it be safer to increment outstanding_tx by the total number of
descriptors pushed to the TX ring instead of clamping it?

> +
> +	usleep(100);
> +	complete_pkts(xsk, xsk->batch_size);
> +
>  	return TEST_PASS;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260520004244.5566=
3-1-kerneljasonxing@gmail.com?part=3D5
