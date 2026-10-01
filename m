Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0B094E5348;
	Thu,  1 Oct 2026 10:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790850460; cv=none; b=HlluY88ai0/5r/HypZJXyEPI5EPNza1/nVJNqy2kaheuMQYQUuFlVVFXq2wrXb2pmBouKOyQ6OxTvdXJTGAY5cF1li55KCLIya/kUyyKzjS5ilUYLas+/5BpascLVdAnH+BqK+k+s+m3iWz97Qrj9O8wpRpbv75jmkAJM6+crBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790850460; c=relaxed/simple;
	bh=x57VT8SA0pphdWEQEkM/iqc6er++BIDwNdzE0dptaJs=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=dDJQcaRXCaov86wRFEYV8ByU9W0ij7AkzeAEKhl7NUOn9RfAqr5Mx9OubRy8ErmM+7Y6FYnTg5oV4ngCV5LQV1HhmtQMA2Q56UOjG5lYAG1IOPm4OotVP2INGwGVlJLzxvlV3iRAc3g/FwQBDcGUi2VqJdTi2GaEbYiu+q7xynk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SLkKj8MV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SLkKj8MV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C99C1F000FF;
	Thu,  1 Oct 2026 10:27:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790850458;
	bh=XYzs7o+5h0U9Vrf1IvIXwIIUltb94MWDVQUuaUnhbR0=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=SLkKj8MVGQsOdD5vsXhNNbPvVbeNGCh3UlaAOIhV4zHQbJoRvbG2VJDQgfGxhzsQs
	 0vOr5p16ruAgjwKqSohOnvTCCwdw45AkPCvdqcmbc2hXX0hdiA0fD22qUNDEy8KUtP
	 gO+HrqDCSxvHO7BTeF0MPxQcZM7rAVEH921LkZONFeCsY5JoZeLXydNCdA2pPvYDDa
	 1kA5fl6noZQ/484lqxgj8PmCNJvN06IWxc/O8w7pghNiCtM3Okk8CCiLtkPz89B1QD
	 hLUy9ZWgVVdzps66SnCaF7poGAt3ZRm8H+VRc8q91Y25RgfyfZCMwGje0TnDQuT4qK
	 4OJ5F9AW4CNMw==
Content-Type: multipart/mixed; boundary="===============5002025029551811504=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <613bf6afe2483c66dd4b8f057bd7ca3ebf6211589def2a874347f1a2683aa513@mail.kernel.org>
In-Reply-To: <20261001-bpf-verifier-patch-batch-v1-1-a12df8a09160@gmail.com>
References: <20261001-bpf-verifier-patch-batch-v1-1-a12df8a09160@gmail.com>
Subject: Re: [PATCH bpf-next 1/4] bpf: Add a list of deferred instruction patches
From: bot+bpf-ci@kernel.org
To: odys.yuan@gmail.com,ast@kernel.org,daniel@iogearbox.net,john.fastabend@gmail.com,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,shuah@kernel.org
Cc: bpf@vger.kernel.org,linux-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,odys.yuan@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Thu,  1 Oct 2026 10:27:37 +0000 (UTC)

--===============5002025029551811504==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Add a list of deferred instruction patches

TL;DR: Nit only: patch_list_adj_aux() duplicates the aux-data propagation
logic of adjust_insn_aux_data() in fixups.c; the review asks whether a shared
helper could keep those rules in one place. Not a bug.

> diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
> index 37cf130ebb57..39566f382510 100644
> --- a/kernel/bpf/fixups.c
> +++ b/kernel/bpf/fixups.c
> @@ -404,6 +404,301 @@ struct bpf_prog *bpf_patch_insn_data(struct bpf_verifier_env *env, u32 off,

[ ... ]

> +/*
> + * Fill the aux data of the 'p->len' insns at 'slot' from the aux data 'old'
> + * of the insn they replace, the same way as adjust_insn_aux_data() does.
> + */
> +static void patch_list_adj_aux(struct bpf_prog *prog, struct bpf_insn_patch *p,
> +			       struct bpf_insn *patch,
> +			       const struct bpf_insn_aux_data *old,
> +			       struct bpf_insn_aux_data *slot)
> +{
> +	struct bpf_insn_aux_data *last = slot + p->len - 1;
> +	struct bpf_insn *orig = &p->orig;
> +	u32 i;
> +
> +	*last = *old;
> +	last->zext_dst = bpf_insn_def32(prog, &patch[p->len - 1]) >= 0;
> +	memset(slot, 0, sizeof(*slot) * (p->len - 1));
> +
> +	for (i = 0; i < p->len - 1; i++) {
> +		slot[i].seen = last->seen;
> +		slot[i].zext_dst = bpf_insn_def32(prog, &patch[i]) >= 0;
> +		if (!memcmp(&patch[i], orig, sizeof(*orig))) {
> +			slot[i].non_stack_access = last->non_stack_access;
> +			last->non_stack_access = false;
> +		} else if (bpf_is_mem_insn(&patch[i])) {
> +			slot[i].non_stack_access = true;
> +		}
> +	}
> +
> +	if (bpf_is_mem_insn(&patch[p->len - 1]) &&
> +	    memcmp(&patch[p->len - 1], orig, sizeof(*orig)))
> +		last->non_stack_access = true;
> +
> +	/* indirect jumps to the replaced insn land on the first new one */
> +	if (last->indirect_target) {
> +		slot[0].indirect_target = 1;
> +		last->indirect_target = 0;
> +	}
> +}

this isn't a bug, but patch_list_adj_aux() repeats the per-slot aux fill
that adjust_insn_aux_data() already does for the BPF_PATCH_KEEP_TARGET
case, as its own comment says.  The seen propagation, the zext_dst
computation via bpf_insn_def32(), the non_stack_access transfer keyed on
memcmp() against the original insn, the last-slot bpf_is_mem_insn()
marking and the move of indirect_target to the first slot are all
duplicated.

Could adjust_insn_aux_data() and patch_list_adj_aux() share a small helper
that fills 'len' aux slots from the insns that replaced 'orig' (taking the
slot base, the patch insns and the mode), so the aux propagation rules live
in one place?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/36845462631
--===============5002025029551811504==--
