Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B67ED1DFDA1;
	Wed,  4 Mar 2026 23:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772665353; cv=none; b=rAPg7jkHfpY5LV6bW01b/4NciL89gTtUQyqXw/qXnOLgQoMPovYWYla7jLP43LlQiMQw3SVd90tIZEwJCluLDD+CRolnWIHoYp+j2lx8xeNsW7dnJWFhZ5FuuIwJF6tHkRuJpH3AYfohlUJIvYvh4xuo1a8eBBXyWEXKCIQsYrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772665353; c=relaxed/simple;
	bh=0EdNCJsDLDqBmyoHWtn8JAcs4nalnxJjBdbpLEQnZzM=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=hT+t0bNYUpGOHHRSBGCCewITJTOL7Fq3CLJbUbCvXO9pg/uEqOFdP6ZdVugjO2XT/GH79dD+IaETt+y8x7dCGNXIjtBe235HblpyEF1kP6d4dq+t9hBl+BRldHUlNCfjZMjbJUAMYRvFLoEdl08KSEBh8SAo8FoVRH+Ay9FnXtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=otiJAT0U; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="otiJAT0U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B174C4CEF7;
	Wed,  4 Mar 2026 23:02:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772665353;
	bh=0EdNCJsDLDqBmyoHWtn8JAcs4nalnxJjBdbpLEQnZzM=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=otiJAT0UhiPZpGkL4hVcY12esDpAm2+MK7jd+Gg/GsYRLZ/SpvkLy+HOyDKr+VlUG
	 j/+jW3ps9mrpESdOwxhp3EO2L+b0mgvxm319wDq3lbWNdexTDgJPpk/7OV3du1dtET
	 Sg1zTbBBT7wHQIbP1OcQBJcrPrKKj/7/3HTuw71KPHvfiDtA+y8ZW/dOeixeRCvZO/
	 e7Ned9970qIMcyWwqZP40wCwvsYWUxK3WacXIC9tqyxevpocaxPtIDqrKKcnmU3N/q
	 ofjKpF8/dSySgTCPFJoBiQ0rjg/O5FPzlfS5p3lC/eXg9HfY9KDmMe7OXnGdssxUJv
	 BioERHsNdYGfw==
Content-Type: multipart/mixed; boundary="===============0097848254027258512=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <90246a2d7a691e7374b18d699e0778f10b750b85fd0739d485c96960925a822b@mail.kernel.org>
In-Reply-To: <20260304222141.497203-7-jolsa@kernel.org>
References: <20260304222141.497203-7-jolsa@kernel.org>
Subject: Re: [PATCHv2 bpf-next 06/23] bpf: Add multi tracing attach types
From: bot+bpf-ci@kernel.org
To: jolsa@kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org
Cc: bpf@vger.kernel.org,linux-trace-kernel@vger.kernel.org,kafai@fb.com,eddyz87@gmail.com,songliubraving@fb.com,yhs@fb.com,menglong8.dong@gmail.com,rostedt@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed,  4 Mar 2026 23:02:33 +0000 (UTC)

--===============0097848254027258512==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index d92cf2821657..832a87da5a86 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -25173,6 +25181,8 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
>  	case BPF_TRACE_FENTRY:
>  	case BPF_TRACE_FEXIT:
>  	case BPF_TRACE_FSESSION:
> +	case BPF_TRACE_FENTRY_MULTI:
> +	case BPF_TRACE_FEXIT_MULTI:

The new multi types are added to this switch, but earlier in the same
function bpf_check_attach_target() there is a check that prevents
BPF_PROG_TYPE_EXT from targeting fentry/fexit/fsession programs:

kernel/bpf/verifier.c:bpf_check_attach_target() {
    ...
    if (tgt_prog->type == BPF_PROG_TYPE_TRACING &&
        prog_extension &&
        (tgt_prog->expected_attach_type == BPF_TRACE_FENTRY ||
         tgt_prog->expected_attach_type == BPF_TRACE_FEXIT ||
         tgt_prog->expected_attach_type == BPF_TRACE_FSESSION)) {
            bpf_log(log, "Cannot extend fentry/fexit/fsession\n");
            return -EINVAL;
    }
    ...
}

Should BPF_TRACE_FENTRY_MULTI and BPF_TRACE_FEXIT_MULTI be included
in that check as well? The comment above it explains that extending
fentry/fexit programs is blocked to prevent
fentry->extension->fentry->extension call chains. Multi programs map
to BPF_TRAMP_FENTRY/BPF_TRAMP_FEXIT in bpf_attach_type_to_tramp(),
so the same concern would apply.

> @@ -25202,7 +25212,17 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/22692622038
--===============0097848254027258512==--
