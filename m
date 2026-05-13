Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3815439D6CC
	for <bpf@vger.kernel.org>; Wed, 13 May 2026 17:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778692859; cv=none; b=Ye0hpXhMDwLc0dLjiYHM3QFUoDUEvXx0mFx2FE12NFHetBrkwF8Z2d+tkyleAuozCfrYDlE4Jf+Ub5ZZkgUQ5PRdbOzvlKUbrpEcbi/KZXx0vCB/xW2sC1ta1u1FLU/AYdRFxFvJQ5d2+VehGaqkEmFFxqWlvYRYBM810zzNzC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778692859; c=relaxed/simple;
	bh=ZDYwuT+pRztunnTtdznsc9Jv1uOAp6s3iDrPZDr272Q=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=FaR1yFgVNXuVd/EH6A+ObJoIzCNBaEdBYX1qWi6aAZ76fOLUhUJvVreXh625SF3A+XjSKbKybQGE3S3wHJqp0GEYI1U5qiWovqYHpkvyhHPGbDPUMhd528naJMuOaIaPzOGWFzCFqtw26ZqXRy7h+IDggYh3slpsep8T83GfdG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CMwR+UKm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CMwR+UKm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5003C19425;
	Wed, 13 May 2026 17:20:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778692859;
	bh=ZDYwuT+pRztunnTtdznsc9Jv1uOAp6s3iDrPZDr272Q=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=CMwR+UKm8akt7cWTbiqtUK5sJwuuRdW/6+AhKobj6TW4mnyf84Zz9mdhDvE7Q5pti
	 vI5Lct+2gZ/WTKo6UWhUsQ6otAuhBxsCsrVAKd5WyInDFzFaDOsugC1We6DGhwslfz
	 JPic3Df9Acj5IQ2TmQVEDhD57Fu2STIJOKTS6c1tKOTIe8xrXz757lNj/eczKPEQ8R
	 KyYXG+VMi0BU1BnTAN0OZELCT81MWx5vCC1GOn+L8ij7Yhj4rVK1UfczvywUulPVle
	 UWOf++9HwXdMdNV8A/k3VdICRtM98kfrVxS55GIgdd/IcCIbjpawTn2Ap63hg2cF1e
	 lV4aSMtKmCLkQ==
Content-Type: multipart/mixed; boundary="===============0774855344180501410=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <4381e877be9406065cb02b0257a9b4dadf94abab5a72d36fe93e2d2f6eee2aaf@mail.kernel.org>
In-Reply-To: <b3459e61c408daef30d82272f1eacc6399844896.1778689025.git.paul.chaignon@gmail.com>
References: <b3459e61c408daef30d82272f1eacc6399844896.1778689025.git.paul.chaignon@gmail.com>
Subject: Re: [PATCH bpf-next v2 3/3] veristat: Report max stack depth
From: bot+bpf-ci@kernel.org
To: paul.chaignon@gmail.com,bpf@vger.kernel.org
Cc: ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed, 13 May 2026 17:20:58 +0000 (UTC)

--===============0774855344180501410==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/veristat.c b/tools/testing/selftests/bpf/veristat.c
> index 5c82950e6978..9a2275d19ee1 100644
> --- a/tools/testing/selftests/bpf/veristat.c
> +++ b/tools/testing/selftests/bpf/veristat.c
> @@ -48,6 +48,7 @@ enum stat_id {
>  	SIZE,
>  	JITED_SIZE,
>  	STACK,
> +	MAX_STACK,
>  	PROG_TYPE,
>  	ATTACH_TYPE,
>  	MEMORY_PEAK,

[ ... ]

> @@ -795,7 +796,7 @@ static const struct stat_specs default_csv_output_spec = {
>  		TOTAL_INSNS, TOTAL_STATES, PEAK_STATES,
>  		MAX_STATES_PER_INSN, MARK_READ_MAX_LEN,
>  		SIZE, JITED_SIZE, PROG_TYPE, ATTACH_TYPE,
> -		STACK, MEMORY_PEAK,
> +		STACK, MAX_STACK, MEMORY_PEAK,
>  	},
>  };

Does this need .spec_cnt updated to 16? The ids array now contains 16
elements (FILE_NAME, PROG_NAME, VERDICT, DURATION, TOTAL_INSNS,
TOTAL_STATES, PEAK_STATES, MAX_STATES_PER_INSN, MARK_READ_MAX_LEN, SIZE,
JITED_SIZE, PROG_TYPE, ATTACH_TYPE, STACK, MAX_STACK, MEMORY_PEAK), but
.spec_cnt is still 15. All consumers of this struct (output_stats,
output_comp_stats, output_header_underlines and the parse_stats_csv
column-count check) iterate from 0 to spec_cnt-1, so MEMORY_PEAK won't be
included in the default CSV output.

>
> @@ -834,6 +835,7 @@ static struct stat_def {
>  	[SIZE] = { "Program size", {"prog_size"}, },
>  	[JITED_SIZE] = { "Jited size", {"prog_size_jited"}, },
>  	[STACK] = {"Stack depth", {"stack_depth", "stack"}, },
> +	[MAX_STACK] = {"Max stack depth", {"max_stack_depth"}, },
>  	[PROG_TYPE] = { "Program type", {"prog_type"}, },
>  	[ATTACH_TYPE] = { "Attach type", {"attach_type", }, },
>  	[MEMORY_PEAK] = { "Peak memory (MiB)", {"mem_peak", }, },

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/25813246860
--===============0774855344180501410==--
