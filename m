Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 525C344A401
	for <bpf@vger.kernel.org>; Sun,  4 Oct 2026 14:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791123895; cv=none; b=t0fz0w83Ym0B5WZ+y5Qd5dexd7F+eq4MlVO7BNUSeiLAV3Dp1dKdgQwHtfsHwKjrwsIYv8Fns+OvdN0J5/35ucki0VVHvVAKTRKVZvTUIDrAih3gO0zkmrFcEKYzRYWZGcmPNoZnUr2kmj8fKT1aE/3397SKRDSEZgD5+ef0oMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791123895; c=relaxed/simple;
	bh=09C3cFFklfR9artLv+UsScXCQZV/ha8rMmA8nt/Gij0=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=dZH+BtnSwHnYPdvn5qhSKylhtIeMC8Rjy1Be+LWPqGHhASEI8+DDiPFJhkHte/ZLxbkAvWm8SqEAixNv65q+RPbHv56KltXVVdCym1StNvPA5bz/j/lanBIvwABD/SusLRRPQw7QjyE6s3qIoIAXeznldyMWEkkOXpaTdNcSEBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f9P8i4z+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f9P8i4z+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A19401F00893;
	Sun,  4 Oct 2026 14:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791123893;
	bh=GNHRcJTfC6ErPfy0D5LprwyUQxOmiU/hDMW8UrQL/+w=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=f9P8i4z+lhaODbWNFMEc/+WhO+wOhynCSw9kLdUWRwYe533Ped/UbDJUJxXmIs9nH
	 hMWczW6fBn9qkjbpGRk42RvlmONLMT3qXplHLO7+cGCCybuKPm5Bq6fzatIRcIesAh
	 Y9hUtA1JNtL3W4MrsRgrYEtgtY+w1C3s4kpxeI2dkgYPVj9SXHk/lFUeRWKkvUd+YH
	 oPZOf2nuTQGwrB6suU/i2ZRm42DIxLna8dWWSN3Yj26lR9eSsc+tp2+eRBw9XnuPqd
	 0BX0k+KtBWTtCRuz8boDmLGnYBfnmZcBsErcSZmmV4fTDX8r3HbvRNygzBajyCfdKP
	 7iswuWDGJ+L6w==
Content-Type: multipart/mixed; boundary="===============0167457055807216960=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <747f502bbfa586fd1bfa07243d4afc43c738bf207e8d887cecb5c071a95bd349@mail.kernel.org>
In-Reply-To: <20261004-scev-minimal-rebase-v2-29-f6254e29fdf2@gmail.com>
References: <20261004-scev-minimal-rebase-v2-29-f6254e29fdf2@gmail.com>
Subject: Re: [PATCH bpf-next v2 29/43] bpf: use SCEV to widen bounded loops
From: bot+bpf-ci@kernel.org
To: eddyz87@gmail.com,bpf@vger.kernel.org,ast@kernel.org
Cc: andrii@kernel.org,daniel@iogearbox.net,kernel-team@fb.com,yonghong.song@linux.dev,eddyz87@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sun,  4 Oct 2026 14:24:52 +0000 (UTC)

--===============0167457055807216960==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: use SCEV to widen bounded loops

TL;DR: scratch_widened_reg_id() in kernel/bpf/scev.c ends a switch with a bare
"default:" label, which may fail to build on GCC older than 11 or with Clang
under CONFIG_WERROR; a "break;" is suggested.

> diff --git a/kernel/bpf/scev.c b/kernel/bpf/scev.c
> index 9ef28e0d8d48..a98f3fea52ec 100644
> --- a/kernel/bpf/scev.c
> +++ b/kernel/bpf/scev.c

[ ... ]

> @@ -1581,3 +1585,839 @@ int bpf_init_scev(struct bpf_verifier_env *env)

[ ... ]

> +static void scratch_widened_reg_id(struct bpf_verifier_env *env, struct bpf_reg_state *reg)
> +{
> +	switch (base_type(reg->type)) {
> +	case SCALAR_VALUE:
> +		reg->id = 0;
> +		break;
> +	case PTR_TO_PACKET:
> +	case PTR_TO_PACKET_META:
> +		reg->id = ++env->id_gen;
> +	default:
> +	}
> +}

This switch ends with a bare "default:" label directly followed by the closing
brace.  A label at the end of a compound statement is only valid from C23
onward, so does this build with the toolchains the kernel supports?

With GCC older than 11 (the minimum GCC is 8.1.0 per
scripts/min-tool-version.sh) this is a hard error:

    error: label at end of compound statement

Clang accepts it with -Wc23-extensions, which turns into a build failure with
CONFIG_WERROR=y or W=e.  The same pattern has needed fixing before, for
example in 84f9288208df ("Bluetooth: hci_qca: Fix build error") and
d98a04dc1906 ("KVM: arm64: Add break to default case in
kvm_pgtable_stage2_pte_prot()").

The PTR_TO_PACKET/PTR_TO_PACKET_META case also falls into the default label
without a break.  Would adding "break;" after the "reg->id = ++env->id_gen;"
assignment and after "default:" address both?

The pattern is still present at the end of the series (2c96fb13421f), so no
later commit fixes it.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/37207249098
--===============0167457055807216960==--
