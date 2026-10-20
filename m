Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792516148;
	b=X8023UZ4QOc+s/EJlvoroj6UUn/Om7OMA5ZAUt8QivX6+NLLBBTAMiOXjftN0av4F1g9
	 ZaLCUBkdJG/DsbhUIcUmS1Rv0o71CVS37KuZvtJmBvBi+iAH58EJY+4QNRCvgNcYxuL3u
	 iOu5rLI8gbqenxJDqH8xOwnMt0ooqnPl8s23vPkYrfAZKc4GIDjDCixePaLch0jehjD3H
	 l/KghuBO19YEZZmO81gW7URbumx31nJs9J/71jCad22SIyY5Dz96hGhdfvdOTiYl3k/NB
	 ScQCFcXCszX2LwtIIlAwZdOwHcBTfk9FwptaWTU2gg5jzRyHFrOnjCTOXMgNL0pEIzQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792516148;
	h=Received:Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date;
	bh=gvYVT/Wi1TZ9dnq+0QbzJ7fSdeN4ALRA7DrD+z7c92U=;
	b=xf2/ZF/7Q4dJOEIgEC4HQ2LlFuZdMT6tYiWOe9OkmzHNe0MNaIUQRqbFyI5QC/B1TXb0
	 GLM7Q6/Yluvpytkoxsja+cNeApkdoJQ4x23fuAgDCc0l4N6ljFK66cgJkoirY4jG1qwcE
	 9gfXWX97VXad5FTsjheK9znVE5A+RosBNCrrRwHxrMjXIydL+FtHhy5b/jEnSYaClCj32
	 vhgo5CQYJowpm7Xi2F+0tzxLTiZ5xD3C265ncqUaweyEvsT6L+dYptSK5EVWxJbbIPnCH
	 b9s0FUF267MTH1pIbnZNYcoPH90bL7PYCuFs9GDBpYDmfAB6AXwoUNDawslh7Lhe9yQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ADC3606A320;
	Tue, 20 Oct 2026 17:09:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B26ED1F000CB;
	Tue, 20 Oct 2026 17:09:06 +0000 (UTC)
Content-Type: multipart/mixed; boundary="===============5893420697026274867=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <d6b900be6e27a2ab0ff198e30d28c0d35410daa23bf03ead13a359569f9bfdd9@mail.kernel.org>
In-Reply-To: <20261020161907.2115379-5-vineet.gupta@linux.dev>
References: <20261020161907.2115379-5-vineet.gupta@linux.dev>
Subject: Re: [PATCH bpf-next v3 04/12] bpf: Track low-32 scalar equality across zero-extending movs
From: bot+bpf-ci@kernel.org
To: vineet.gupta@linux.dev,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com
Cc: martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,john.fastabend@gmail.com,shuah@kernel.org,bpf@vger.kernel.org,linux-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,vineet.gupta@linux.dev,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Tue, 20 Oct 2026 17:09:06 +0000 (UTC)

--===============5893420697026274867==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Track low-32 scalar equality across zero-extending movs

TL;DR: The comment and changelog claim a zero delta from an add is refused
composition, but a 32-bit add of known zero records the same link as the mov
and composes. Behaviour is sound; the explanation looks inaccurate.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -17594,11 +17584,28 @@ static int adjust_reg_min_max_vals(struct bpf_verifier_env *env,
>
>  		if (dst_reg->link_kind) {
>  			/*
> -			 * If the register already went through rX += val
> -			 * we cannot accumulate another val into rx->off.
> +			 * Only the zero-extending link the mov above records,
> +			 * BPF_REG_LINK_ZEXT with delta 0, can take a delta:
> +			 * (u32)((u32)(base + 0) + off) is (u32)(base + off).
> +			 * The add has to be 32-bit as well, since a 64-bit one
> +			 * parts company with the link once the low half wraps.
> +			 *
> +			 * Everything else still drops the link. A zero delta
> +			 * reached by an add rather than by the mov, say "r1 +=
> +			 * r3" with r3 known to be 0, has already spent its
> +			 * delta; composing onto it keeps a link alive across a
> +			 * loop's increments, and since the delta is compared
> +			 * for equality, every value the loop reaches becomes a
> +			 * state of its own and stops pruning.
>  			 */
> +			if (dst_reg->link_kind != BPF_REG_LINK_ZEXT || !alu32 ||
> +			    dst_reg->delta) {
> +				/* also the target of the two gotos above */
>  clear_id:
> -			bpf_clear_scalar_id(dst_reg);
> +				bpf_clear_scalar_id(dst_reg);
> +			} else {
> +				dst_reg->delta = off;
> +			}
>  		} else {
>  			if (alu32)
>  				dst_reg->link_kind = BPF_REG_LINK_ZEXT;

The comment says a zero delta "reached by an add rather than by the mov"
has already spent its delta, and the commit message says allowing
composition onto "a zero delta that an add produced rather than the mov
still costs 1176 -> 1196".  Can this test actually tell the two apart?

A 32-bit add or sub of a known zero ("w1 += 0", "w1 -= 0", or "w1 += w3"
with w3 known to be 0) on a register that has an id but no link_kind goes
through the else arm quoted above and records:

    dst_reg->link_kind = BPF_REG_LINK_ZEXT;
    dst_reg->delta = off;    /* off == 0 */

That is the same state the mov records, so a following "w1 += 1" passes the
"dst_reg->link_kind != BPF_REG_LINK_ZEXT || !alu32 || dst_reg->delta" test
and composes.

Only the 64-bit example from the comment ("r1 += r3", which records
BPF_REG_LINK_FULL) is actually refused.

The result is still sound, since (u32)((u32)(base + 0) + off) is
(u32)(base + off).  Should the comment and the changelog limit the claim to
64-bit adds, or does the mov-produced link need to be made distinguishable
from the add-produced one?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/39458500836
--===============5893420697026274867==--
