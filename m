Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C86822309AA
	for <bpf@vger.kernel.org>; Thu,  9 Apr 2026 02:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775701583; cv=none; b=aXuC1cVbUhTzSCkx35qRspK1JHeyb47GS/kwzq4X6IW/ErTfiRINPD4DzwZ8beApOQlsYYNORMHOp+pFqX5iSyTk5P9MOlmddx9zduZif7ugA0Ki6ztmv7AA7H4tiwmRGvPI+pfGVPemcAAtf5AzQ/sLV+mdCX96HB9VZ21d9vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775701583; c=relaxed/simple;
	bh=g2MJASTizUvm6wNS9QTjTykpKotz7ko89Tl/Bl0jy8k=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=tzVrufejWdrllocPe/IqMd1RwWoSCH6lhXDk90rYAB5nlQKvKKhWmIHiyC47Lebg+YaY6cA4bbkN0Z3dBL3jeTsL8vZN1k+jpQghjFD/nkEy+KDB3YfoaTON9jqzGMwBa2qA8D6ysXvy3FjXD6/u6+4ZTOcRET7h3BFMgPUF9HI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AIjlENCF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AIjlENCF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56634C19421;
	Thu,  9 Apr 2026 02:26:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775701583;
	bh=g2MJASTizUvm6wNS9QTjTykpKotz7ko89Tl/Bl0jy8k=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=AIjlENCFqCSfkQ0Iy7jS/3Tnx1KvOLoiH8E7hFN0CXtrw3/thMBdnfJ9NWp4POIql
	 o/pCiXydZ1gq/8LZfO2O6KVkdgcu7GJ1etRE2QaYbzl0LlieZ6x8dRhEgnmR5TplEj
	 yYhN8kMMPcx3N/9uivUDQFliQ2uy7AOCJx+BDf6/rweTXDuEo0/lsKzFPw1Em2ELZe
	 0ayYy4gFcMoKLxUSrQf3j7zW6aqeVgtsDz2WT/HIJ7836KG+7R7dOvuTsNmwbIOtVd
	 ovpsvoSFwE3rVwm30PSsFC/iVWo/3Opwqo6qq0cwy7IEaJAVyFDBhcpYfNAGXRPqx2
	 bGh4avH4sMEyQ==
Content-Type: multipart/mixed; boundary="===============5411063647363649929=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <eee99abdfe26e1a150c77a8c218c621ef18cc43f2774ba9fdb5fc9e7f10b6ce6@mail.kernel.org>
In-Reply-To: <20260408-patch-set-v1-7-1a666e860d42@gmail.com>
References: <20260408-patch-set-v1-7-1a666e860d42@gmail.com>
Subject: Re: [PATCH bpf-next 07/14] bpf: introduce forward arg-tracking dataflow analysis
From: bot+bpf-ci@kernel.org
To: eddyz87@gmail.com,bpf@vger.kernel.org,ast@kernel.org,andrii@kernel.org
Cc: daniel@iogearbox.net,martin.lau@linux.dev,kernel-team@fb.com,yonghong.song@linux.dev,eddyz87@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu,  9 Apr 2026 02:26:23 +0000 (UTC)

--===============5411063647363649929==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c
> index a3af5972520f..4f7748720250 100644
> --- a/kernel/bpf/liveness.c
> +++ b/kernel/bpf/liveness.c

[ ... ]

> +/* Track callee stack slots fp-8 through fp-64 (8 slots of 8 bytes each) */
> +#define MAX_ARG_SPILL_SLOTS 64

Should the comment say "fp-8 through fp-512 (64 slots of 8 bytes
each)"?

The define is 64, and the code consistently uses it as a slot count.
For example, fp_off_to_slot() rejects offsets below
-(MAX_ARG_SPILL_SLOTS * 8) = -512:

    if (off >= 0 || off < -(int)(MAX_ARG_SPILL_SLOTS * 8))
        return -1;

So valid offsets are fp-8 through fp-512, which is 64 slots, not the
8 slots (fp-8 through fp-64) described in the comment.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/24168298083
--===============5411063647363649929==--
