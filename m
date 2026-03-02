Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0531A368287;
	Mon,  2 Mar 2026 13:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772458338; cv=none; b=NFiATnheDTet5Yu+WzcbYxz7okSd2ehk5fexdGzM5R6LLKagGqBFH/7s7MNCUq7BKnW15DBSRsTRsPBws/zyo/YWRm/L0QYLuxGlc37EfqZdto+sK+ImNF0JyB1oczY0TC/uXxbIsZ81hmrwtv9m56/rTmbpCRNw9oMiJviB9Gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772458338; c=relaxed/simple;
	bh=8kIaLf3/mEO9V4y951FkdiQBN6lWp+r/3tEeh7UwbN8=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=MOo4Szd5B3yJobNLFxVgB1z2jYx25Dq4t0PJEizrv6/Pd53e4yhjgKOHqjTH7GpbQjShxxe1T/orteK5jzHPSg2RCoQGjgAZBqcv1uCGv0lZJskr2GTA3REdvskrEpyNUxzATXEgtXNWfR2/+hNyu7h0EwqxDKYQsurCFTkAGG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z/bEBEHM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z/bEBEHM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3836AC19423;
	Mon,  2 Mar 2026 13:32:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772458337;
	bh=8kIaLf3/mEO9V4y951FkdiQBN6lWp+r/3tEeh7UwbN8=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=Z/bEBEHMZYr5rf0HyvdEWT82281WFiwe1MDwFPQ9zUwcJKU8YlfQIv3Gpt4SrPO/F
	 e2h48o2BhZBcaLBomzuKixyvA1HlkYSOgCQCi5jCxnuMEeTttvTsCdA+mBIUsoTgtp
	 WA8wTecyHCqu3NLzl22aXBPYFo1dZnb1EuiQqg7GgZZ8TuN1RtNydR06T288AIp8jn
	 UYmPu3gXSjxSbUHVjgzQHMVh8qaS5yYKm7+BBa0yTnPKaGI11V2TJGO9FnZKoHtvDF
	 DQprzEXosikcXskEbdQi6gShZG2Ee6K06GSBmE5rfFdyIfdRTIIXKSuJWLtdH9Q8Rh
	 YAC16fQOXsgjw==
Content-Type: multipart/mixed; boundary="===============4771949766527131899=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <a4316335c76275e884a40fd0b2d1a7b2b4e35fb6fb80944d45e2bbc1e5a29c70@mail.kernel.org>
In-Reply-To: <20260302124028.82420-2-pilgrimtao@gmail.com>
References: <20260302124028.82420-2-pilgrimtao@gmail.com>
Subject: Re: [PATCH v3 1/6] bpf: Introduce the bpf_list_del kfunc.
From: bot+bpf-ci@kernel.org
To: pilgrimtao@gmail.com,martin.lau@linux.dev,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,john.fastabend@gmail.com,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,jolsa@kernel.org,shuah@kernel.org,chengkaitao@kylinos.cn,linux-kselftest@vger.kernel.org
Cc: bpf@vger.kernel.org,linux-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon,  2 Mar 2026 13:32:17 +0000 (UTC)

--===============4771949766527131899==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c

[ ... ]

> @@ -4080,20 +4100,25 @@ int btf_check_and_fixup_fields(const struct btf *btf, struct btf_record *rec)
>  	int i;
>
>  	/* There are three types that signify ownership of some other type:
> -	 *  kptr_ref, bpf_list_head, bpf_rb_root.
> +	 *  kptr_ref, bpf_list_head/node, bpf_rb_root.

Should "bpf_list_head/node" be just "bpf_list_head" here? bpf_list_node
doesn't signify ownership of another type -- it is the type that is
owned.

The unmodified paragraph just below still says:

  "Hence we only need to ensure that bpf_{list_head,rb_root} ownership
   does not form cycles."

And further down in this same function:

  "A type can only _own_ another type in user BTF if it has a
   bpf_{list_head,rb_root}. Let's call these root types."

Both correctly exclude nodes from the ownership types.

>  	 * kptr_ref only supports storing kernel types, which can't store
>  	 * references to program allocated local types.
>  	 *
>  	 * Hence we only need to ensure that bpf_{list_head,rb_root} ownership
>  	 * does not form cycles.
>  	 */

[ ... ]

---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/22576595943

AI-authorship-score: low
AI-authorship-explanation: Slightly formal commit message phrasing is consistent with non-native English; code and multi-version iteration strongly suggest human authorship.
issues-found: 1
issue-severity-score: low
issue-severity-explanation: Inaccurate comment in btf_check_and_fixup_fields incorrectly describes bpf_list_node as signifying ownership, contradicting other comments within the same function; no runtime impact.

--===============4771949766527131899==--
