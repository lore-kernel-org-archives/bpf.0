Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A3F2FF17A;
	Fri, 17 Apr 2026 20:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776457360; cv=none; b=TFkgKw5O5owCmXdYphLLcFG5ytnq2tBmIYGvcD7r9/PBfouIZk/T/C0Shb/ZZHzKUgK37YQ7I9+tqd0lcRXU5Rv0RqczQgY38kf4fW91PpD209oie/s0WUl22QpbhhOpsE2QXjGhFtI0qxC5Rj98ppAqWCOo0z1nSzXrxASOA8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776457360; c=relaxed/simple;
	bh=oaMhTEP23X7wZ6hsj+T7Q5XqDKrT6ktZZiGB8nhsMd8=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=alaWTAycCOiLB+t9cTmVmJZYiI/No8vfgHD8uLPFAaVzlhrRr1jeq8VsdjXbJEtM1XAtSR59HrSzkIYUKEAs452K50kWkIuHNwBU2E7TVNIxJ/tASJmO7CwtceDqZa2m3F9bflTMt6rF3Wy7/7e/DyvVXjON2ttaMK+cTY/AIeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RU8zRq/7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RU8zRq/7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75266C19425;
	Fri, 17 Apr 2026 20:22:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776457359;
	bh=oaMhTEP23X7wZ6hsj+T7Q5XqDKrT6ktZZiGB8nhsMd8=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=RU8zRq/7BNRA/7Pet2D3xQ3/c0+fAiJh0EC7k+LDGHUXpRcGb5LKm6DeL5l/XbY9m
	 EzIXqeAkwQcmeoGySAJJa0/OGEDpxu4x4vmKUBNHaVPRcJs8wc9VLroPUnkMLRQXgS
	 1QprW7bmGs5wOnW02yhaq0XZQRGzICG5/YwIz2xDmvU0kViyMk7My3zs1jEwTOftaJ
	 YQL+5LEY8eo7ViBCImEQbW1iOyT5BdOX+1jkISpsan1RYpVkmdMxArZ0qr2lOZVmPs
	 6BGE9aAtMN6aZAJVJ8d0wlPiqap8nGMSGItTARAo58aq3Iuh3WsFN3PyM6q2dRZtUh
	 XpzwsRYsVEY8Q==
Content-Type: multipart/mixed; boundary="===============5287328911341442696=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <1ef3a598cb11de0fac8dfe1ac94287d3588ca36257f27b0a2407e85f5037667a@mail.kernel.org>
In-Reply-To: <20260417192502.194548-11-jolsa@kernel.org>
References: <20260417192502.194548-11-jolsa@kernel.org>
Subject: Re: [PATCHv5 bpf-next 10/28] bpf: Add multi tracing attach types
From: bot+bpf-ci@kernel.org
To: jolsa@kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org
Cc: bpf@vger.kernel.org,linux-trace-kernel@vger.kernel.org,kafai@fb.com,eddyz87@gmail.com,songliubraving@fb.com,yhs@fb.com,menglong8.dong@gmail.com,rostedt@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri, 17 Apr 2026 20:22:39 +0000 (UTC)

--===============5287328911341442696==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 552bc5d9afbd..5f814e7101cf 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -1154,6 +1154,8 @@ enum bpf_attach_type {
>  	BPF_TRACE_KPROBE_SESSION,
>  	BPF_TRACE_UPROBE_SESSION,
>  	BPF_TRACE_FSESSION,
> +	BPF_TRACE_FENTRY_MULTI,
> +	BPF_TRACE_FEXIT_MULTI,
>  	__MAX_BPF_ATTACH_TYPE
>  };

In the RFC version posted on February 4, 2026, Leon Hwang asked whether
BPF_TRACE_FSESSION_MULTI should be added alongside BPF_TRACE_FENTRY_MULTI
and BPF_TRACE_FEXIT_MULTI for consistency, since BPF_TRACE_FSESSION exists
and is handled similarly to FENTRY/FEXIT.

Reference:
https://lore.kernel.org/bpf/3015991d-2e9b-4bf4-9c17-26e00b5d5926@linux.dev/

You acknowledged this with "good catch, will add it" in the same thread:
https://lore.kernel.org/bpf/aYM-jeV50WaVik1b@krava/

However, BPF_TRACE_FSESSION_MULTI was not added in any subsequent version
through v5. Should BPF_TRACE_FSESSION_MULTI be included here for API
consistency?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/24583317711
--===============5287328911341442696==--
