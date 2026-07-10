Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7229E573
	for <bpf@vger.kernel.org>; Fri, 10 Jul 2026 04:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783656379; cv=none; b=FoW4zB6fdkZ5CG45eVHD0aNNqmpi/hcODbiKsvQFp/rk6MUeUEI3yWgyweHOABQCX6MDh9tCVg0t09di6nAqbSRfi0hyvNbJzLQa+mkRNGmdFWhj2yXtOcv0n2EoC5NowKqJlYlA1Thxj09RYyhWZTDoDKia7UQAX8yU9XlHgDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783656379; c=relaxed/simple;
	bh=7KO6WOCVINLoNnmebpEzOjjhcUb26Jw3TanrsxG2mng=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bT3dl4TXBDyFAS452w4WiiE+prUYVRboTjCi94cgota4Ro0ULt1VGXdBuRoSbq+CrAveuAvkXCaEfeOVO57RBjoTvoTJ7UbG9B2+MEyFEBmUQO3KnrED7+/MSfqNqgxEHqnLzfwv5WWuSe713csiNWXEEDj9ME9i/t6lW394ZO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XlrkQE+i; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XlrkQE+i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 817871F000E9;
	Fri, 10 Jul 2026 04:06:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783656378;
	bh=eBIqamhXDVz0+l4swfpG/wuK4VDEbC/lTh+VbvK9Yjo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XlrkQE+iF/C3epxn5K76etJXDYeh6mwL6GWZP51uL0Olu42EACSfPtjdfIU7BG12G
	 X2IFPtDq4Uv41fUtsIYIzWsHNVXkeppW+1cHg9gi1DyoMmEHZoBLclZ7XBq6kSH7Yf
	 +q6XLM6J1tjKr7zQdpDY1bG9wsFnfFyhrY26Q9mF2q5r908y9YCiDJDMVnN9xotzxb
	 TDdnIvq8kVY2hKPwXmtYK1h7tgqzAEnxv388AmqEallA0cHHZ27ZWz2W9WxEutlCBK
	 zhMfqzbnXyt+gqb8bZLzglFAfBcqeL58yZx8uWNxnuwsP1DDFVT3yERG6fkvM6Tjke
	 rwK3UOPyFtUWw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] bpf: return -EINVAL from bpf_ringbuf_query for unknown
 flags
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jianlin Shi" <shijianlin11@foxmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <tencent_39A7924F2A472D74FA6AD444744E57027905@qq.com>
References: <tencent_39A7924F2A472D74FA6AD444744E57027905@qq.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Jul 2026 04:06:18 +0000
Message-Id: <20260710040618.817871F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] Returning -EINVAL from a u64-returning BPF helper breaks stabl=
e UAPI and results in massive positive values.
--

--- Patch [1]: [PATCH] bpf: return -EINVAL from bpf_ringbuf_query for unkno=
wn flags ---
commit 9dc2317be6516748b67981dfde67e0a14dcc2725
Author: Jianlin Shi <shijianlin11@foxmail.com>

bpf: return -EINVAL from bpf_ringbuf_query for unknown flags

This commit changes the fallback behavior of bpf_ringbuf_query() to return
-EINVAL for unrecognized flags instead of 0. It also updates the UAPI
documentation to reflect this new error code.

> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
[ ... ]
> @@ -4694,13 +4694,14 @@ union bpf_attr {
[ ... ]
> - *		Requested value, or 0, if *flags* are not recognized.
> + *		Requested value on success. **-EINVAL** if *flags* are not recognize=
d.
>   *
> diff --git a/kernel/bpf/ringbuf.c b/kernel/bpf/ringbuf.c
> --- a/kernel/bpf/ringbuf.c
> +++ b/kernel/bpf/ringbuf.c
> @@ -656,7 +656,7 @@ BPF_CALL_2(bpf_ringbuf_query, struct bpf_map *, map, =
u64, flags)
>  	case BPF_RB_OVERWRITE_POS:
>  		return smp_load_acquire(&rb->overwrite_pos);
>  	default:
> -		return 0;
> +		return -EINVAL;

[Severity: Critical]
Does this regression break the stable UAPI for existing programs that might=
 be
relying on the helper returning 0 when probing for unsupported flags?

Since bpf_ringbuf_query() is defined to return a u64, returning -EINVAL (-2=
2)
will be implicitly cast to a very large positive integer (0xffffffffffffffe=
a).

If a BPF program checks whether the returned value is greater than 0,
wouldn't it now wrongly assume a huge size or position instead of
handling it as an error?

Also, because ring buffer positions are monotonic byte counters, could a
perfectly valid position eventually reach 0xffffffffffffffea and become
completely indistinguishable from this new error code?

>  	}
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/tencent_39A7924F2A4=
72D74FA6AD444744E57027905@qq.com?part=3D1
