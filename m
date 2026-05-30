Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE1AB2E54A3
	for <bpf@vger.kernel.org>; Sat, 30 May 2026 00:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780101967; cv=none; b=LKrDEkA0vO65GpCrNRQP9VwPdiGHcOF/bDzsMS7aUhZdwM90czRIiMMGYUKoLL5z+iLnGbf7XOYXvTKa1Z4oH9s5yzV2lNxuut0zUSIlJpr01At9mF7JheYoqvNdEoIHHanpqgNFAJ1PMb5b5eLm1gLsXAu2bU+JcirvxyqmWJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780101967; c=relaxed/simple;
	bh=MnM28UGlDZlQ3+MIod7yp6nBl80vS5GwGqbTaU+yJeg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NhGmTqlwNYzTvy/bBb572uUKtXU8qcpoQ78ta8AT8yyMc2gkC99MTPjF7nQBZr2hIHiytgw9rUi1vl70sr1Q8d+5/YsLHhZkwiig1JmXbN2+uwlD09Q1+Gv8L4tJZMAiw33LxyfASka3tEf2cb4tOLi5XsQSkYTC38ULgnn+rvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YSoIhFwC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YSoIhFwC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 674481F00898;
	Sat, 30 May 2026 00:46:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780101963;
	bh=Isi1YbOom5eonvNU2e+DuFcuzgdNDvi9JgoOCRm5IMM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YSoIhFwCeW3HiVQksqeGmeqyk/+f6VFdYy5V/eY+TwMrCwVVEAc7YfFHIGMi2rPb9
	 L82tT3uuaGdVpnrEDAlyVvb2BX9OIritGnnLEuDat3oyW9UQG01Fw9Oh9CexYUYhMx
	 rHhY6mRp8cQ+rK3ziScANxzfKfflidJri5Q9vxMK4IC+BQrXfekt2KpEgEoIu6tt8F
	 33mpYf9UZ2aJuzJuzTCm29DvHXN7KogOAP4O8Cp0ro6X+c2tYeQc7CsHE/Lbc5n3f8
	 mfbIguCgCUIrzYO5snXTf3NauAcsvfgweuVs3VhEoPgaBV9+4LEMAgc9R5nxgY6vEq
	 be8Lfnt7zer+g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v2 4/6] bpf: add BPF_SOCK_OPS_TSTAMP_RCV_CB
 callback
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jason Xing" <kerneljasonxing@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260521135244.40869-5-kerneljasonxing@gmail.com>
References: <20260521135244.40869-5-kerneljasonxing@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 30 May 2026 00:46:03 +0000
Message-Id: <20260530004603.674481F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Multi-line comments added in `bpf.h` violate BPF subsystem style ru=
les.
--

commit 70849c3ed58c6a550a61d9e2bed8d76cf14bd58a
Author: Jason Xing <kerneljasonxing@gmail.com>

bpf: add BPF_SOCK_OPS_TSTAMP_RCV_CB callback

This commit adds the BPF_SOCK_OPS_TSTAMP_RCV_CB callback and a receive
tunnel function to allow the kernel to report both software and hardware
timestamps.

> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 1e09b5cd7a39e..113a2a72cbf45 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -7169,6 +7169,11 @@ enum {
>  					 * sendmsg timestamp with corresponding
>  					 * tskey.
>  					 */
> +	BPF_SOCK_OPS_TSTAMP_RCV_CB,	/* Called in tcp_recvmsg() to record
> +					 * sw/hw timestamp of the last skb
> +					 * after receiving all the data when
> +					 * SK_BPF_CB_RX_TIMESTAMPING is on.
> +					 */

[Severity: Low]
This isn't a bug, but does this multi-line comment follow the preferred
subsystem style? Should the opening /* be placed on its own line?

[ ... ]

> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bp=
f.h
> index 677be9a473476..483ff4497d512 100644
> --- a/tools/include/uapi/linux/bpf.h
> +++ b/tools/include/uapi/linux/bpf.h
> @@ -7168,6 +7168,11 @@ enum {
>  					 * sendmsg timestamp with corresponding
>  					 * tskey.
>  					 */
> +	BPF_SOCK_OPS_TSTAMP_RCV_CB,	/* Called in tcp_recvmsg() to record
> +					 * sw/hw timestamp of the last skb
> +					 * after receiving all the data when
> +					 * SK_BPF_CB_RX_TIMESTAMPING is on.
> +					 */

[Severity: Low]
This isn't a bug, but the same multi-line comment style observation applies
here. Should the opening /* be placed on its own line?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260521135244.4086=
9-1-kerneljasonxing@gmail.com?part=3D4
