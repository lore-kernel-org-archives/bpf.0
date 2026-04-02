Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B36175A92
	for <bpf@vger.kernel.org>; Thu,  2 Apr 2026 07:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775114850; cv=none; b=J0Ls52ys5G+Cu/YOWH9za00g5iONgn7FwiNsOZcItHOOz9G3boNAgL8V0M/6bpEoOqRFzlIVxc+tUOZUszZvZp9DNqg1lkYIrrFxJaV2ojRtLEcSe/TEWbnku3FbZ0Ou/JZxr8jPSZIax5goKPOypL9RIYPEFlA0/0PXaa1qzsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775114850; c=relaxed/simple;
	bh=pXYqKyxeHk6gEbhcNMHdS09H4RgmGErLSd1GXUZ7HeY=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=MeG8Hhh/9b5AFrD5qfIfP+vARaARZdMqKD5fwU+mdqSz9s02b5Q+gSrrOxsblhKr8RjoyqguNCHxoZRKmYahQeBkPaySTJNDAJmGPkc2jVSjmdSheaXnKwpVhZ9vjXxSaikqQlzFBm0sI8MW95itoiYnu5kRPW8O5exrfk4Fl/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jJKEwH13; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jJKEwH13"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB79FC19423;
	Thu,  2 Apr 2026 07:27:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775114850;
	bh=pXYqKyxeHk6gEbhcNMHdS09H4RgmGErLSd1GXUZ7HeY=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=jJKEwH133pv9NPFrGdgmI00nQh+E4yBDIz71sAJdWCrco94EwU9YNriVB+cLZzY60
	 quEKPhf180qcTZSW4/ixDUqWSuCtpstTEu4CNtBelm/MZPkb42bXEpQejjz/0a8+GR
	 NpPKQ2p6JKLzHU1uOTCRG90fYZFAKk5Zzw5CY+vhUjmdWA2YbQz1qpgQJ7l5Gse7UP
	 G7tal46ZTKMdtt3UwcbVkrbUVJr3TGIxKsctw6xKVUU4ZqsUlbgo0i19aStyLTFHcK
	 16fZMPmT5mbXYJ2jjGg8nyK5N25tHGB9Aqj2eCTTSP27hL9mmJP5qtSKI16aMNgYgy
	 61o59Zh5ictjA==
Content-Type: multipart/mixed; boundary="===============6109671173520709626=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <8fb084d57fcf2668418e1a90e8e99769a644e50d4f3e66b01224fc512b4b902c@mail.kernel.org>
In-Reply-To: <20260402061744.10885-6-alexei.starovoitov@gmail.com>
References: <20260402061744.10885-6-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH v2 bpf-next 5/6] bpf: Move verifier helpers to header
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,martin.lau@kernel.org,memxor@gmail.com,eddyz87@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu,  2 Apr 2026 07:27:29 +0000 (UTC)

--===============6109671173520709626==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h

[ ... ]

> @@ -1109,6 +1133,11 @@ static inline bool insn_is_gotox(struct bpf_insn *insn)
>  bool bpf_insn_is_cond_jump(u8 code);
>  bool bpf_is_may_goto_insn(struct bpf_insn *insn);
>
> +int bpf_find_subprog(struct bpf_verifier_env *env, int off);
> +void bpf_verbose_insn(struct bpf_verifier_env *env, struct bpf_insn *insn);
> +bool bpf_get_call_summary(struct bpf_verifier_env *env, struct bpf_insn *call,
> +			  struct bpf_call_summary *cs);

Was bpf_find_subprog() intentionally declared twice?  It already
appears a few lines above in the same header:

    int bpf_find_subprog(struct bpf_verifier_env *env, int off);
    int bpf_compute_const_regs(struct bpf_verifier_env *env);
    int bpf_prune_dead_branches(struct bpf_verifier_env *env);
    int bpf_compute_postorder(struct bpf_verifier_env *env);
    bool bpf_insn_is_cond_jump(u8 code);
    bool bpf_is_may_goto_insn(struct bpf_insn *insn);

    int bpf_find_subprog(struct bpf_verifier_env *env, int off);  <--

The duplicate compiles fine but one of them could be removed.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/23887359808
--===============6109671173520709626==--
