Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C24F2989BC
	for <bpf@vger.kernel.org>; Wed, 11 Feb 2026 23:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770851324; cv=none; b=d7u+Qx/NWSdzHFG9tj7ZWyabGqofQlWXby+VOeka0w57vs/ocwRo3le9H30z5n8Y8Wv8TBKMiwRhR6QlaguLzRtAbiP1gIRCkHzmf+4HJI5XpSWKI4rr7DiV/Frftb+k0SG2rHs3tgVd7sInmKGQOXOZq9vcuQUzOFpw1IsGAqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770851324; c=relaxed/simple;
	bh=k4WK5GulXsUsqM5YL8iL6fwyfbaxxTyVUFGpwid5uco=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=cz19Ja48n5jmtLWxsB1jM5gRwTAFVg8kJloxQq2Ea/SUdOIdsLxNW43zbAW1KdZqqg0qQj/jJZsfj9oS/k+k/NV4Oi3ut9ttSdPkTpIFFOnR1U+zpXdxOR4PwEjdInPtzAJ++DUATpPUUD9x5m/782mLh72uf3NErfjVKJ3ZWaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d4NntPOo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d4NntPOo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63CDAC4CEF7;
	Wed, 11 Feb 2026 23:08:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770851323;
	bh=k4WK5GulXsUsqM5YL8iL6fwyfbaxxTyVUFGpwid5uco=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=d4NntPOo/EL7lauNnJQtx2PLwvbHMfQ6LLahGWCCQug7fKvWxXE46MkNHr+N7J/qR
	 z7RQ15/K52DYXy0Kn4VGGoi5sFoAdxoA9k/F7FMbohLThIXEsmHbw+ut03luCYPuDV
	 h17fSNT4EQbTcQnZWDuXlBzUmtm5BrppCTZRRcTIcf6TG3rCvIj7QCSa/OnbzEigSd
	 8DQ24QVTkfHvfd4qxu0TUvUrO35rvK/MCr9tlOEdw2UBvsc6NDvFNAwVa5+S9axYL3
	 cVswA1wYA99qREOVz7oVOugVQ4dS9H5OfT8jZW/oZs2xCZQkVPDV7Jjuw0TnyqjY9w
	 ts//vVPpAyErQ==
Content-Type: multipart/mixed; boundary="===============7499917274981490068=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <da7183b4b0da3ec7ffe00c05a471098ea1eeb655f627d061baf5776d203677a2@mail.kernel.org>
In-Reply-To: <20260211-ptrs-off-migration-v1-3-996c2a37b063@gmail.com>
References: <20260211-ptrs-off-migration-v1-3-996c2a37b063@gmail.com>
Subject: Re: [PATCH bpf-next 3/3] bpf: rename bpf_reg_state->off to bpf_reg_state->delta
From: bot+bpf-ci@kernel.org
To: eddyz87@gmail.com,bpf@vger.kernel.org,ast@kernel.org,andrii@kernel.org
Cc: daniel@iogearbox.net,martin.lau@linux.dev,kernel-team@fb.com,yonghong.song@linux.dev,eddyz87@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed, 11 Feb 2026 23:08:43 +0000 (UTC)

--===============7499917274981490068==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -40,7 +40,7 @@ struct bpf_reg_state {
> 	/*
> 	 * Constant delta between "linked" scalars with the same ID.
> 	 */
> -	s32 off;
> +	s32 delta;

The NFP BPF offload driver still references reg->off in several places:

drivers/net/ethernet/netronome/nfp/bpf/verifier.c:
    nfp_bpf_stack_arg_ok() {
        off = reg->var_off.value + reg->off;
        ...
        old_off = old_arg->reg.var_off.value + old_arg->reg.off;
    }

    nfp_bpf_check_stack_access() {
        new_off = reg->off + reg->var_off.value;
    }

    nfp_bpf_map_mark_used() {
        off = reg->var_off.value + meta->insn.off + reg->off;
    }

Where reg is const struct bpf_reg_state *. Was this driver intended to be
updated as part of this rename?

Also, the comment block inside struct bpf_reg_state describing BPF_ADD_CONST
still references the old field name:

> 	/*
> 	 * Upper bit of ID is used to remember relationship between "linked"
> 	 * registers. Example:
> 	 * r1 = r2;    both will have r1->id == r2->id == N
> 	 * r1 += 10;   r1->id == N | BPF_ADD_CONST and r1->off == 10
> 	 * r3 = r2;    both will have r3->id == r2->id == N
> 	 * w3 += 10;   r3->id == N | BPF_ADD_CONST32 and r3->off == 10
> 	 */

Should this comment also use r1->delta and r3->delta to match the new field
name?

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/21926167247

AI-authorship-score: low
AI-authorship-explanation: The commit follows standard kernel conventions with a concise technical commit message and straightforward rename operation typical of experienced kernel developers.
issues-found: 2
issue-severity-score: high
issue-severity-explanation: Build failure in NFP BPF offload driver due to incomplete field rename; the driver references the old field name which no longer exists.

--===============7499917274981490068==--
