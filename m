Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A75233943
	for <bpf@vger.kernel.org>; Fri,  7 Aug 2026 04:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786077540; cv=none; b=rD56BouAcatw9yALfW4H9ppji3L4kMd9sZlxSx47wr91Q4nDOzty+o2akhnboyIvZWA91CTd/8RZ1DM/BfQnf3zoHaP8CWwhcRIamHkJRamg49myYPmZyAHMHoHOt5p8a9lcTs3wfH3Ds4e5VaGCCjGFDM8OUiQTlH2yxoG8OKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786077540; c=relaxed/simple;
	bh=DLdu/5Sh/+2vhc5WLf2oJ6t8a9P9N5xUSUsJ0s2Kr5k=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=nwmdBcEtoEmwjnPt90UCDO7m3o4h0SCJQPonrGLSNnl0ZPMT7aYQSl9EDRvKhdCKMB290tdl9nqiqRyPzosC5LIw29v+pKyi8vLo2yJR92D4FeXl4Hf8FYNrwCRUY12VK6xI0XZ1ts6Bu4KKZjdAuwjx+2ZQw8ZDNMM04Tu7xWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F4vvdhcb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F4vvdhcb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B45D1F000E9;
	Fri,  7 Aug 2026 04:38:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786077537;
	bh=pmiID+1+jd0vknmwxmwSPCqSvOHEDEdBEfhS9BGhvaM=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=F4vvdhcbidX8M5v/hU4STdeMVU8gC9YUOxDuCsHFRpH3OV/TtYNADdd6aAKxK5TJn
	 +xJgWEdSMz17+sR1qskwwMlWtOSb/edGFYHzoZtx0iGF3cHWzrl5U7sHUt5RISvxfT
	 Fdt7ZxG0FBogLGHFpm3Ho94Y3Cl2qNvVYDbUe6rC5XP6lz+GUFk7rV2hDM0WG9D55f
	 bQeZH46jNioALQ/JRa2j9zKaAUQnQ6PCbLFM8KWGV/T0zzp+i9Z3MnVQfv2EqQ9ULU
	 BPfCJEMsfv8iUR6M/NluVOcvb7EpNKQVih1ceHsBaZBwOCJlgf3AecPWTrl3BACtrZ
	 1cq8LIabtlTag==
Content-Type: multipart/mixed; boundary="===============1179773625317747549=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <b394c5635c62edc015cff3a4e75521d190684aca56257f8a55b822bac4f4b704@mail.kernel.org>
In-Reply-To: <20260807032029.78092-6-ihor.solodrai@linux.dev>
References: <20260807032029.78092-6-ihor.solodrai@linux.dev>
Subject: Re: [PATCH bpf-next v3 5/6] selftests/bpf: Verify decl tags emission in resolve_btfids test
From: bot+bpf-ci@kernel.org
To: ihor.solodrai@linux.dev,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,memxor@gmail.com
Cc: alan.maguire@oracle.com,jolsa@kernel.org,emil@etsalapatis.com,bpf@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri,  7 Aug 2026 04:38:57 +0000 (UTC)

--===============1179773625317747549==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/prog_tests/resolve_btfids.c b/tools/testing/selftests/bpf/prog_tests/resolve_btfids.c
> index 8482f00046d4c..732cfed35e1c5 100644
> --- a/tools/testing/selftests/bpf/prog_tests/resolve_btfids.c
> +++ b/tools/testing/selftests/bpf/prog_tests/resolve_btfids.c

[ ... ]

> @@ -260,6 +284,22 @@ void test_resolve_btfids(void)
>  	check_kfunc_set(&test_kfunc_set);
>  	check_kfunc_set(&test_kfunc_set_rev);
>
> +	/* Check resolve_btfids emitted a bpf_kfunc decl_tag for each kfunc */
> +	for (i = 0; i < ARRAY_SIZE(kfunc_symbols); i++) {
> +		ASSERT_TRUE(btf_has_decl_tag(btf, DECL_TAG_KFUNC,
> +					     kfunc_symbols[i].id),
> +			    kfunc_symbols[i].name);
> +	}
> +
> +	/* Check resolve_btfids emitted bpf_fastcall for KF_FASTCALL kfuncs */
> +	for (i = 0; i < ARRAY_SIZE(kfunc_symbols); i++) {
> +		if (kfunc_symbols[i].flags & KF_FASTCALL) {
> +			ASSERT_TRUE(btf_has_decl_tag(btf, DECL_TAG_FASTCALL,
> +						     kfunc_symbols[i].id),
> +				    kfunc_symbols[i].name);
> +		}
> +	}

This isn't a bug, but could the bpf_fastcall check use an ASSERT_EQ form
instead of the conditional ASSERT_TRUE?

The arena block below this code uses:

	ASSERT_EQ(is_arena_tagged_ptr(btf, proto->type),
		  !!(fl & KF_ARENA_RET), name);

which checks both directions: flagged functions have the tag, and unflagged
functions don't. As written here, the second loop only verifies that
flagged kfuncs get bpf_fastcall; it doesn't check that kfunc_a, kfunc_c,
and kfunc_d (which lack KF_FASTCALL) are correctly left untagged.

Using the same form as the arena check would fold the two loops into one
and cover the negative case as well.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/31144437704
--===============1179773625317747549==--
