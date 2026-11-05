Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793914537;
	b=db10GUTpA2svHfZtYWcL/qQvjgJLyERDQ6yJj/hvKRjWpSddorTLHEem6Oqx1nkg2aTt
	 SXXsR03/3jojx89tGeC5NIehRAmWtdzq+lAIFDg8pxwab9VjMvreq+TUjNh33J0WrLnuc
	 hHNaee6aSiCSvmVQpNGPexPtlSwxgyyhk7kHtYWpi9G19uDRcMfoxoY4wnOPXK9BuyulL
	 Z9wN3dxjuMxzRb4S9od40yyECNqYyyZMxguCW0WYGD9sa4rK5TMpcqweScwumgnMhVZd5
	 bzpIl3x/SRLgbwqKSXcsi1FdUbhp3zBkdxtAlBTZdcm7N14W7ARyXqKubo5ogeqMvkg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793914537;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=HqPZKinNOrJ9uKIkiueWYOt93rBuO1WyzHvCyZmyblM=;
	b=vjD+demNmkrak2rDkZHf1bHd9bBqenJ0Ts7jAT7fU3J4w2fGUfMAEXLncm5uDrxu/dn1
	 lD+QkNwvSMS8JFqbLccYlBqSwB3FmraZUfkQQ6+seGwF91duiYI9pc4HgyZKo5Olq8wpy
	 Qu0qER600c7z3aeP7vUmdnsZ9hdgE4bADmvy3qIXxHC+Z5ivL20rpuKdeGvm9tnYTq0zA
	 EogtkxFM7o+vH9Uoz1vmwV/c5IVQO6zKfZiMWyZ914bgF6p1fDTgmrPZvpTvAzSmZKtYz
	 POien9+H99MlNPloRhl8lNohPrbW6WLhEHs9qF0hFk7ZsuOWS/t0chUKNWiByvAfFTQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Sh67gxAI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C65606A335
	for <bpf@vger.kernel.org>; Thu,  5 Nov 2026 21:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Sh67gxAI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E573C1F008BE;
	Thu,  5 Nov 2026 21:35:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793914537;
	bh=HqPZKinNOrJ9uKIkiueWYOt93rBuO1WyzHvCyZmyblM=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=Sh67gxAI6t/WDfonQFV28jEhO66uwgwMzDk4q0r/YN1fSskMpk1/RUjtKmY4Fn7Fq
	 N3DqhNPUUPoC/nwxFoRXCQT/zc5/1iqzQhGBoKy6INAR0UIQM8zGAhi6K7jP4aW2M/
	 xvXO2LsLFx6UzSv1ERFhj94d1UUBotwnRZquMyUc3d3cB89nJAD2xOoTkTJ+4SCw+C
	 v5E3wUHWcrh9FqvU64WTP0ALVcSsnB75279JN35eQzBlEwbSR64Nd0mekbI5pJ3OQz
	 8ZRSaFDUJE7VFDTkayfqJ73d3Ir3WR2rB0Xgk6H8WGDyKcEuTuVnd3rxVROEucAWnR
	 8tMiRL2g9WtvA==
Content-Type: multipart/mixed; boundary="===============0001277804578442375=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <23765a934c960eeac8bc2081d140312b9c027ac182cbbe5450995f8c7d612995@mail.kernel.org>
In-Reply-To: <20261105204513.2230344-6-alexei.starovoitov@gmail.com>
References: <20261105204513.2230344-6-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf-next v2 05/35] bpf: Add join of verifier states
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Thu,  5 Nov 2026 21:35:36 +0000 (UTC)

--===============0001277804578442375==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Add join of verifier states

TL;DR: The new iter.loops bitfield in bpf_reg_state may grow the iter struct
from 16 to 24 bytes, enlarging every register; no wrong behaviour found, and a
later patch in the series fixes it.

> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -120,6 +120,11 @@ struct bpf_reg_state {
>  			/* packing following two fields to fit iter state into 16 bytes */
>  			enum bpf_iter_state state:2;
>  			int depth:30;
> +			/*
> +			 * The number of loops, in all frames, that the program was in
> +			 * when it made the iterator, see iter_stops_loops().
> +			 */
> +			u32 loops:30;
>  		} iter;

On 64-bit, state:2 and depth:30 already fill the 32-bit unit at offset 12.
Doesn't the new u32 loops:30 start a new unit and grow the iter struct from
16 to 24 bytes?

That would contradict the comment just above ("fit iter state into 16
bytes") and the comment on raw ("Max size from any of the above").  The
union becomes 24 bytes while raw stays 16, so struct bpf_reg_state grows
from 80 to 88 bytes for every register, spilled_ptr and stack_arg_regs
entry.

adjust_ptr_min_max_vals() uses "dst_reg->raw = ptr_reg->raw;" and
memset(&dst_reg->raw, 0, sizeof(dst_reg->raw)), which now skip union bytes
[16,24).  I found no path where this goes wrong today, since those bytes
are only nonzero through iter.loops of a STACK_ITER spilled_ptr.

Was the growth intended for the intermediate commits?  Narrowing depth or
moving loops would keep the struct within 16 bytes.

This is fixed later in the series by commit 190019d84c9b ("bpf: Remove
is_state_visited(), bpf_compute_scc() and iter.depth"), which removes depth
and brings the iter struct back to 16 bytes.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/42109044416
--===============0001277804578442375==--
