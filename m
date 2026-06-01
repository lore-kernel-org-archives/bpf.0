Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABE532BE05A
	for <bpf@vger.kernel.org>; Mon,  1 Jun 2026 16:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780329829; cv=none; b=CCpnOJXHTBX4AFUX+s3Rhm7ZxH4NJ/tc6NMce2tipGvWlqLFHwB328Szbk8YVAcxIBquZhhQsD7LBi24EQK1o4PbHeTq3d4Vyvcpwv1FYJN6zr6s102BW/k4hrtivrKoONz9MeIhzCJYia1WCXIzSXwTYm+e2NzxB3i6wv32sCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780329829; c=relaxed/simple;
	bh=8rjsc0+wvNmXV0C+qkClTkZdO+y+paMlnwq0DacOlZg=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=F4CmQrBCh5/TkxMdvnm9IO2SvirggenZgvrfuHTzjaqFXr1Y3VHdj5PKcL7vJ8YxidGuCMbLk2jEMmTDMTEAEbyxu8uQJtME2GgNyRpODa8lwEhrgolZ8wGtNb9H3nOScbsu2QfL8G5YSDRTBpQMbOM1JNpnxrTd+GUzYBW+6qE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OcikclQh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OcikclQh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36C7F1F00893;
	Mon,  1 Jun 2026 16:03:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780329828;
	bh=aH2SRczzfqXhBWp4crh+a7e1CN6yF1FRzoxB8VqU+cE=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=OcikclQhsz0/ILD1oxf2NbiCRepnuBj/j5oweo9z2E9f0hSrg3LlkHtRKrNVJy9Hy
	 MLBCh42aQ8yR7hXXJprLe5/Ty05zNZM6BwL8vCkXw9zzYkvgMImCQ6WiF68Kl4Zk9q
	 hvzBj8+rzQ9YqzTJJgfs1QAzh1RpshUTxF9Gk68cJvBoLLbzi6vyRNbXedM0NTKhSP
	 u8eaVjqpEcogHnLPK8wE0HuftLb2uw4v2yuatFmazjivFGcJK3+yDrine8jRodPv4Z
	 2zCkaCZiDkNnSSNbVbGI9hN4zlCN/4Xer/gNoTPt+OlIp96Y2R0GcoEgJo50E5eleq
	 z0Yw3qtzTDgMg==
Content-Type: multipart/mixed; boundary="===============3738245916912872766=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <1ce6141cb12d34da5a5d19d44cc68a03cbc5cae2b75a6026183325b07a378cfb@mail.kernel.org>
In-Reply-To: <20260601150248.394863-4-daniel@iogearbox.net>
References: <20260601150248.394863-4-daniel@iogearbox.net>
Subject: Re: [PATCH bpf-next v2 3/7] libbpf: Reject non-exclusive metadata maps in the signed loader
From: bot+bpf-ci@kernel.org
To: daniel@iogearbox.net,alexei.starovoitov@gmail.com
Cc: bpf@vger.kernel.org,kpsingh@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon,  1 Jun 2026 16:03:48 +0000 (UTC)

--===============3738245916912872766==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

>     libbpf: Reject non-exclusive metadata maps in the signed loader
>
>     The loader verifies map->sha against the metadata hash in its
>     instructions. map->sha is calculated when BPF_OBJ_GET_INFO_BY_FD is
>     called on the frozen map.
>
>     While the map is frozen, the /signed loader/ must also ensure the map
>     is exclusive, as, without exclusivity (which a hostile host could just
>     omit when loading the loader), another BPF program with map access can
>     mutate the contents afterwards, so the check passes on stale data.
>
>     With the extra check as part of the signed loader, it now refuses to
>     move on with map->sha validation if the host set it up wrongly.
>
>     Fixes: fb2b0e290147 ("libbpf: Update light skeleton for signing")
>     Signed-off-by: KP Singh <kpsingh@kernel.org>
>     Co-developed-by: Daniel Borkmann <daniel@iogearbox.net>
>     Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>

Is the Fixes: tag pointing at the right commit?

The bug being fixed is in emit_signature_match() in
tools/lib/bpf/gen_loader.c, which verifies map->sha without checking map
exclusivity. That function and its map->sha verification loop were
introduced by:

  ea923080c145 ("libbpf: Embed and verify the metadata hash in the loader")

The referenced commit fb2b0e290147 ("libbpf: Update light skeleton for
signing") only touches tools/lib/bpf/skel_internal.h (the light-skeleton
runtime path) and does not introduce the verification code being changed
here.

A sibling fix in the same area, 3c5e2f1a8584 ("libbpf: Skip hash
computation when loader generation failed"), also touches gen_loader.c
and attributes it to ea923080c145.

Should the tag instead be:

  Fixes: ea923080c145 ("libbpf: Embed and verify the metadata hash in the loader")


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/26764265302
--===============3738245916912872766==--
