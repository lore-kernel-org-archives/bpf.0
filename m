Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D30114CB5B
	for <bpf@vger.kernel.org>; Tue, 14 Apr 2026 21:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776202010; cv=none; b=H4SltC9RsK1rs2iGyykaLOcQM5SRv8vVqm5YUJn2HWUB/BuJCApGVvmc15mfCIIp0wB/1iSkaTT3ys5RwjOz7JmN0mzObAuO7d5UFVFZNEfDVo/pQq0gsxYIErBqJ6AcI1wTKiHeuOmebzlZGNRsj6uJCVz7zmxm6a7VUJ85EiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776202010; c=relaxed/simple;
	bh=g2VcFJF46F3FTxIdcmL0AcED3AG1zvfpCrdCiImbsc4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ltr8pe60QBCstoQuGK8np5khAVFDba2r+fvJ0vGcIcaQT4yOthVUUsoRRurg8Ze0udoLmreEdbrnS6MExuR3UraV98/p7N4x7yWRqT0iYQBKERb6TtB6ZrzwZdu4rI1SMDKN5ThLPs4nT9yRR7wtl89PkSjAWLzkPEo6jR+VIeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aEnGPQvK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aEnGPQvK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F89BC19425;
	Tue, 14 Apr 2026 21:26:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776202010;
	bh=g2VcFJF46F3FTxIdcmL0AcED3AG1zvfpCrdCiImbsc4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=aEnGPQvK72Ix9nnwWOi4xiy/vZImKmV3TbjBIOVafC6cQC7l4sLmSjnOmoHxK87bQ
	 T2xgTLIvyP2rnSV9P5UXux71rUua26g+TGYiCITy0pB6stm8iP5YtY5J/kQSMsw7TX
	 g27fUiv09QmakjwjeRXxhAuvAr/Iqs1cf+9t3TZv7t07OEo4jgm6eTeh4+un+BB8zr
	 m3NScDFoJX0/LY8jxGAnXaoxohK07icSk8RdHBOtY8788ouQ1/lT808Uz9DBzXopQc
	 r+3H19zC/6w6kKZos4ozFoPEb581HKHUCem+el4Np6T8l2A4OZwcAyqhwk4jhgOH/o
	 GRj2SrCeytpFQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v4 6/8] bpftool: Generate skeleton for global
 percpu data
Reply-To: sashiko@lists.linux.dev
To: "Leon Hwang" <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260414132421.63409-7-leon.hwang@linux.dev>
References: <20260414132421.63409-7-leon.hwang@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Apr 2026 21:26:49 +0000
Message-Id: <20260414212650.4F89BC19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Sashiko AI review found 1 potential issue(s):
- [High] Missing read-only memory protection for `.percpu` initial value bu=
ffer in generated light skeletons.
--

commit e61b5ee6e5a7cee758b644de0f6b4aaea40f020c
Author: Leon Hwang <leon.hwang@linux.dev>

bpftool: Generate skeleton for global percpu data

Enhance bpftool to generate skeletons that properly handle global percpu
variables. The skeleton includes a nested structure for percpu data, which
is marked as read-only after loading so users must update the map directly.

> diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
> --- a/tools/bpf/bpftool/gen.c
> +++ b/tools/bpf/bpftool/gen.c

[ ... ]

> @@ -847,7 +851,7 @@ static int gen_trace(struct bpf_object *obj, const ch=
ar *obj_name, const char *h
>  	bpf_object__for_each_map(map, obj) {
>  		const char *mmap_flags;
> =20
> -		if (!is_mmapable_map(map, ident, sizeof(ident)))
> +		if (!is_mmapable_map(map, ident, sizeof(ident)) || bpf_map_is_percpu_d=
ata(map))
>  			continue;
> =20
>  		if (bpf_map__map_flags(map) & BPF_F_RDONLY_PROG)

The commit message notes that after loading the skeleton, maps.percpu->mmap=
ed
has been marked as read-only.

By skipping the .percpu map entirely here during light skeleton generation
in gen_trace(), does this leave the user-space buffer for .percpu writable?

If a user modifies skel->percpu after the light skeleton is loaded, will it
silently succeed without actually updating the kernel per-cpu map? Does the
generated light skeleton need an explicit mprotect(..., PROT_READ) for the
.percpu initial value buffer to enforce the read-only constraint?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260414132421.6340=
9-1-leon.hwang@linux.dev?part=3D6
