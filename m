Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 106B47261A
	for <bpf@vger.kernel.org>; Sun, 19 Jul 2026 16:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784477853; cv=none; b=KK6euYulfS6vJSl1D+14Y/KGf9G+3FYBfbLFC5GUcB6WwXNv1wqowfyw8u1lfv8Sw1G8J7ZIRgAXILwfVtSZtjI9TtZJ9Z+p0RiTi0rqQHo3/kAlfoxV1yLWSWjo8aWMeZo2OmgrlLniLQgFW6ezsns2HYaSa7HpSQpsNUKNEEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784477853; c=relaxed/simple;
	bh=ugp54boI6/nE78CoDNWwjmMAZulHaYKE1PnDsXhM2MA=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=IgSJ/a9NGX6ty2aaUQZQbj1G3bBbS28be1EWWYryemR2AwDJmhEy/oLU+PsSI7a0fFFVzO7/gYCxEav0B6Dr0g0uWTyLtyfLIOycU8bDgI0Dt6k/gBJzhRYfi9qnGTbype+2QToQ8KU9wP0wX0HTHDRVjd1Kpw2PXw6oVBGk1ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gy1hyjv1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gy1hyjv1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B16B1F000E9;
	Sun, 19 Jul 2026 16:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784477851;
	bh=ND/qz8t3BF14puGe1/n2uOZQlDN0rsFHWNuz3VVkW2I=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=Gy1hyjv1oC1F6RAWtlU/aUwiQlTfa7PpaY3oNR/5Sg1uqQsnt8r0CQiaDqLDVmVkj
	 r273HW+78OgExfMTHt+HWChptAb/AzlWn8A0N0dH4VrDIgFGojWCUv5+MKV+aGtNWw
	 7dEOZ/IqOlB5kzgp/nQdAq6s5yCCcCvbYYdadpbrXCjHuBSUpQvxUWteyxDrOjUfUX
	 k87H9cB+o/7b8u53X+QK8q2/6COT5Vp6kk6sitwrM27GaYIYLL+CihO8l7XQVTitZr
	 mEbQdEpe95eM8phnoFh/59tiuRFHz/HlyvuTuxiK56C15j5X0/eyQXAbBk9gNwnyPO
	 UE5oS9Si62CfA==
Content-Type: multipart/mixed; boundary="===============6636955529607574466=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <2e38fbad43ee446b30a232ae9c220d10d2124b612f61cdeb15bc58ffbb6a4907@mail.kernel.org>
In-Reply-To: <20260719153634.2908692-2-memxor@gmail.com>
References: <20260719153634.2908692-2-memxor@gmail.com>
Subject: Re: [PATCH bpf-next v2 1/5] bpf: Fix offset warn check for bpf_res_spin_lock
From: bot+bpf-ci@kernel.org
To: memxor@gmail.com,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,emil@etsalapatis.com,kkd@meta.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sun, 19 Jul 2026 16:17:31 +0000 (UTC)

--===============6636955529607574466==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

>     bpf: Fix offset warn check for bpf_res_spin_lock
>
>     Sashiko pointed out correctly that the case statement for
>     BPF_RES_SPIN_LOCK incorrectly checks offset for BPF_SPIN_LOCK.
>     Fix it by checking res_spin_lock_off instead.
>
>     Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

This looks like a bug fix.  The incorrect check
"WARN_ON_ONCE(rec->spin_lock_off >= 0);" in the BPF_RES_SPIN_LOCK case of
btf_parse_fields() was introduced when that case was first added.  Should
this include:

  Fixes: 0de2046137f9 ("bpf: Implement verifier support for rqspinlock")


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/29693647189
--===============6636955529607574466==--
