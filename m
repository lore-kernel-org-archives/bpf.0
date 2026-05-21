Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD11242D67
	for <bpf@vger.kernel.org>; Thu, 21 May 2026 23:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779405362; cv=none; b=q8Td5NvLST7bdwjSpdP7iXak88ot/glw1N8qSSphkFDo5rBdxS63/Ftlh5NPiUJR8zLT0p1+p/K4ODoZB80vLStOGilsK2pvXQFvABHe2VKFqiT9Ha2iGgFlOx+qcJpKHWvEP+vWMcQngLe6ZMahuOtCQ0gMuWpIzCx7hXlUa4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779405362; c=relaxed/simple;
	bh=MbWcbBxLcLB/eLykaMLeIPSCpHT0tbzxy7eTd+6IegE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jmQhrvk0iJtk/v5n+JpnoPYRl8mWjSRG7LitZoA10jT3ideXJ1Z/gfe8mgetQGBlEhifdnTu1kqIDaO/3K+uDpWEeVY+Beafuz4p+wBIoOxfdPxmZMLKReYq5lqD2II95NPpl2m0SOOS/hBwNHAITCA7UAZOGnG6uUStIBbK9qI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PrSOGc2A; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PrSOGc2A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E14FD1F000E9;
	Thu, 21 May 2026 23:16:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779405361;
	bh=clvtNbS0imD4ewSjXZ2i74HRI2zsIO2WG8aS8MorqV0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PrSOGc2APuZh5YF292vYpvW7/dWCKM1Y+xOr0W18HF0p0ip8HeK2Lmw/HcLVA+tQv
	 YhM8eASAt3+G3irGmnbe9BCtCXyM1UtEMMYT5wdO3QvQXmEoqOQTlSrGvRBZerjz4C
	 CxATEgSMhNn7azfsM2esvltkvHA9VcbrD2EEfVRWYy6+da5/Mv6gNiq18u0BMNp1Nk
	 rHc439PZbUVQKzkm8bPKMx+V8aehqao8XUc/d2y+BGBU1DANdwhsQXomU49wIUNGJz
	 Oxn50fLZBALhNOuoVb4kGA+/NReODj0K0PTf1P0VJb1UCw1byeUisirXCtSjQZt3vE
	 Mgxvbif/0KMjg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v6 1/3] bpf: Factor out stack_map build ID
 helpers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ihor Solodrai" <ihor.solodrai@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260521225022.2695755-2-ihor.solodrai@linux.dev>
References: <20260521225022.2695755-2-ihor.solodrai@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 21 May 2026 23:16:00 +0000
Message-Id: <20260521231600.E14FD1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Data race and incorrect ordering in stack_map_build_id_set_valid=
 causing stale reads
--

commit 4eb2cc8713ca7f31dcbc75f5166e94dd60761e7c
Author: Ihor Solodrai <ihor.solodrai@linux.dev>

bpf: Factor out stack_map build ID helpers

This commit factors out helpers from stack_map_get_build_id_offset() to
prepare for adding a sleepable build ID resolution path. The commit
message states there are no functional changes.

> diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
> index da3d328f5c15a..4c753e02c4159 100644
> --- a/kernel/bpf/stackmap.c
> +++ b/kernel/bpf/stackmap.c
[ ... ]
> @@ -152,6 +152,28 @@ static int fetch_build_id(struct vm_area_struct *vma=
, unsigned char *build_id, b
[ ... ]
> +static inline void stack_map_build_id_set_valid(struct bpf_stack_build_i=
d *id,
> +						u64 offset,
> +						const unsigned char *build_id)
> +{
> +	id->status =3D BPF_STACK_BUILD_ID_VALID;

[Severity: Medium]
In bpf_get_stack(), the destination buffer can be a BPF map value that is
concurrently readable locklessly by user-space. Since the buffer initially
contains the raw instruction pointer (ip), does setting status to VALID
before writing the offset create a data race?

A concurrent lockless reader polling the status field might observe the
VALID status while the union still holds the raw ip instead of the correct
file offset, and before the build_id string is fully copied.

Prior to this patch, the offset was written before the status. Could this
reordering of assignments cause concurrent readers to observe stale data?

> +	id->offset =3D offset;
> +	if (id->build_id !=3D build_id)
> +		memcpy(id->build_id, build_id, BUILD_ID_SIZE_MAX);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260521225022.2695=
755-1-ihor.solodrai@linux.dev?part=3D1
