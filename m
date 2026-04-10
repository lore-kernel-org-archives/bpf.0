Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A1B2BDC0B
	for <bpf@vger.kernel.org>; Fri, 10 Apr 2026 01:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775785806; cv=none; b=a8UMxGkRs7AiVBv2w40GlWbtppFVnJIRcsr06ljh8ebMdp0U7qwFSkD0ZXYbxexhWVsYbsGt05NRZSGHCihZKMx+XEBgoIYrHXZ2lZJ2izHQHH0gaOMjIPoKTvMmFHBOTQDnycJ5OBw9MldA8cYR+0g2izImu9MJQb3SmaEw3ZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775785806; c=relaxed/simple;
	bh=6x+NgQLeJr61tdh3uNUnpJn4zElDEPT5e098vp9tPWc=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=agEshWPGe9RY0C30Fmshchr/EX3Ta672OCnz5Lxje6mk/jU9K5wfTqpjz2oXCqB+hq1ZdvaDAof1z7MaNe6NlT5snAcLjiF5CEpq1eYPueovBX+UYzV87o70A2fD5+SZqkD7IIwOvysK25jnlK/dzSEKDAgqz9oX77nNzCjcGX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JR5iFjYw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JR5iFjYw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC161C4CEF7;
	Fri, 10 Apr 2026 01:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775785806;
	bh=6x+NgQLeJr61tdh3uNUnpJn4zElDEPT5e098vp9tPWc=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=JR5iFjYwhKi11pEYG8kzhif0TYTyQYt0V3GjDAl65uCO/KDL6+ygoL/G4wRuWmBld
	 MdkL8TDWzW05Ba88YOeTy8CazX2Fq95gVYwwhYxzuiJZtAL1rZFLxV9gbicVHL1GaM
	 nAk372PYN325EvKAtQ00po3IPxp4FaZY2wd8RrMCmcbjJUom5+Lw4FW94l5bSZ3hVq
	 3VR4zNS6iTl9h2mWVAaGFr6TNoHAWC4ugI2y18OoKeTgajsexN9PJ9G6qs3toQN+6w
	 M4Y0rTcOlFYjUaGPaYwxCaHPBmLePcyOMD94J5nsemJXXc4ZcoM+BsSXq4S4RAAAF8
	 DsvCdzOIXybvw==
Content-Type: multipart/mixed; boundary="===============7314274119170049737=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <95b6b794090c7d1b35fa0040db3573cb6fdb0d9d566c313a14c942f029cbb56b@mail.kernel.org>
In-Reply-To: <20260409-patch-set-v2-2-651804512349@gmail.com>
References: <20260409-patch-set-v2-2-651804512349@gmail.com>
Subject: Re: [PATCH bpf-next v2 02/13] bpf: save subprogram name in bpf_subprog_info
From: bot+bpf-ci@kernel.org
To: eddyz87@gmail.com,bpf@vger.kernel.org,ast@kernel.org,andrii@kernel.org
Cc: daniel@iogearbox.net,martin.lau@linux.dev,kernel-team@fb.com,yonghong.song@linux.dev,eddyz87@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri, 10 Apr 2026 01:50:05 +0000 (UTC)

--===============7314274119170049737==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index 15f7f9f35be9..410939d7b325 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -664,6 +664,7 @@ enum priv_stack_mode {
>  };
>
>  struct bpf_subprog_info {
> +	const char *name;
>  	/* 'start' has to be the first field otherwise find_subprog() won't work */
>  	u32 start; /* insn idx of function entry point */

With name added before start, the comment claiming start has to be the
first field is now inaccurate.  Looking at find_subprog() and
bpf_find_containing_subprog(), the binary search accesses the field by
name (vals[m].start), not by raw offset, so field ordering doesn't
actually matter:

bpf_find_containing_subprog() {
    ...
    while (l < r) {
        m = l + (r - l + 1) / 2;
        if (vals[m].start <= off)
            l = m;
        else
            r = m - 1;
    }
    ...
}

Should the comment be updated or removed to avoid confusing future
readers?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/24221779050
--===============7314274119170049737==--
