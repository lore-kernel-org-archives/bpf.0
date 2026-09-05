Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0710A331EBC
	for <bpf@vger.kernel.org>; Sat,  5 Sep 2026 09:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788599449; cv=none; b=WMf0pl46CqKyIVbH4lIczQSBwytyDZDHtsu9YUMf2HXPrYqqRDkQZQXQq5pY7+Et5Q7RYojotfzhAC6mM0DhFve5XpCW6FKkOO2L0R0/BL4aN5KFU+0Ai8WwvW9MxI7hF4R7rPscXBdDR9xp5M1hT/YE6H1UqcEGD44XuE2oc+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788599449; c=relaxed/simple;
	bh=MtbnDijP1cIxzMaQWRAwE4ksH5GsE5JcCYJv0w51FB8=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=neBuxM6KVZMZMHS6RmokRWl2VvwBZBHXriLWdxhvp0J4vXqticIS8cZ+JD18MmVdXfGbXI4+mMYdUuBMVnzBjesosIBxqzXV+gzEbI1852Hqu3ZAu6165gd4TFatcxoY3kjhyPBNaJyP8uqcchNnKnSW1tIN8qWRi6WvsfdGPHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hps73nPa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hps73nPa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFD8C1F00A3D;
	Sat,  5 Sep 2026 09:10:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788599447;
	bh=FEaZoGWLeWnz+7P56AdG3i2w8sFQL8VQuCdjAb3ZoBs=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=hps73nPadudG0RvSpmccF7xmjKOXOmer8CVCIqYTCCE8GWoR19z3WCvBgdPKitZ9m
	 N3olHx56kvfLRjmuAAnAitQGOsnRr0OoeXHfqo73k9CTlecw7XmDJjCiyjS6/EKaIw
	 WN0d26n+873/+iYLx6mv0ZEaTyCWlAVZTcSjb3qi+6bOjhe57z2UIrtOS2SUZedQL9
	 QKuzB8z56g2XCZxSTrSmWvc1quPigqZJQYv/NZvBnhQW5TmrlPsmmVMXTVTC7iHEe7
	 rNE5d5+BQFFSI+l1DDcYn148ITHVvcZ8Ni4ecZWZv4g/d6ldpIBLL0KdWraN5Twhsz
	 vBHFXlGtGrv4Q==
Content-Type: multipart/mixed; boundary="===============1956137162742311587=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <544281703921c55cdd02288442ac660b858f73dd8c9253473fa3a534d7697b0d@mail.kernel.org>
In-Reply-To: <20260905083418.3723623-4-memxor@gmail.com>
References: <20260905083418.3723623-4-memxor@gmail.com>
Subject: Re: [PATCH bpf v2 3/7] selftests/bpf: Test packet pointer class displacement pruning
From: bot+bpf-ci@kernel.org
To: memxor@gmail.com,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,emil@etsalapatis.com,npc@anthropic.com,kkd@meta.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sat,  5 Sep 2026 09:10:46 +0000 (UTC)

--===============1956137162742311587==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/progs/verifier_xdp_direct_packet_access.c b/tools/testing/selftests/bpf/progs/verifier_xdp_direct_packet_access.c
> index 0b86d95a4133..692a8468f3d7 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_xdp_direct_packet_access.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_xdp_direct_packet_access.c
> @@ -5,6 +5,50 @@
>  #include <bpf/bpf_helpers.h>
>  #include "bpf_misc.h"
>

This isn't a bug, but any reason to place this ahead of the converted
tests rather than appending it at the end of the file, so the
`/* Converted from ... */` block stays contiguous?

> +SEC("xdp")
> +__description("XDP pkt regsafe preserves packet pointer class displacement")
> +__failure __msg("R2 min value is outside of the allowed memory range")
> +__flag(BPF_F_ANY_ALIGNMENT)
> +__naked void pkt_regsafe_class_displacement(void)
> +{
> +	asm volatile ("\
> +	r8 = *(u32 *)(r1 + %[xdp_md_data_end]);\
> +	r9 = *(u32 *)(r1 + %[xdp_md_data]);\
> +	r6 = r9;\
> +	r6 += 8;\

This isn't a bug, but would it be worth matching the surrounding file's
asm layout here (aligned continuation backslashes, `lN_%=:` labels with
the first insn on the same line), or is the more descriptive label naming
deliberate for the multi-path control flow?

> +	if r6 > r8 goto l_exit_%=;\
> +	r0 = *(u64 *)(r9 + 0);\
> +	r4 = r0;\
> +	r4 &= 15;\
> +	r7 = r0;\
> +	r7 >>= 63;\
> +	if r7 != 0 goto l_path_b_%=;\
> +	r2 = r9;\
> +	r2 += r4;\
> +	r3 = r2;\
> +	r3 += 4;\
> +	goto l_join_%=;\
> +l_path_b_%=: \
> +	r4 &= 3;\
> +	r4 += 8;\
> +	r2 = r9;\
> +	r2 += r4;\
> +	r3 = r2;\
> +	r3 -= 4;\
> +l_join_%=: \
> +	r5 = r3;\
> +	r5 += 4;\
> +	if r5 > r8 goto l_exit_%=;\
> +	r0 = *(u64 *)(r2 + 0);\
> +l_exit_%=: \
> +	r0 = 0;\
> +	exit;\
> +"	:
> +	: __imm_const(xdp_md_data, offsetof(struct xdp_md, data)),
> +	  __imm_const(xdp_md_data_end, offsetof(struct xdp_md, data_end))
> +	: __clobber_all);
> +}
> +
>  SEC("xdp")
>  __description("XDP pkt read, pkt_end mangling, bad access 1")
>  __failure __msg("R3 pointer arithmetic on pkt_end")


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/33955969043
--===============1956137162742311587==--
