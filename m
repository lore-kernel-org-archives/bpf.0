Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC4E8274B39;
	Thu,  4 Jun 2026 15:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780587938; cv=none; b=QOQ6HRWCj2Jt7LBHlUdrBVoy36BZZ8tSRJD+1aDArKKgUqqJUyKHT4QOyOewnWzR43Uml1zEGQz/IypFlqgnO54ZscGuwWvx4q/+dgp7iTixkLBdDrunXJdEMkw5/BC15uITgnrOxiOsCjCTBZBWBEAQg5KYoDpq9irJxrbcJEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780587938; c=relaxed/simple;
	bh=cyalNU4QWStfLZaG9ieifjV1y+ep7KKqQLl4LywpOss=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=Dwquw3eJsM5tm4Nu3B9FiuFfkdrIIC38u1VaV21GA9p3kL/mTA4AFry1LKD0t/lcOZN4OZAqGQAFU9h2vywWShl+4vjuGdb1Uui1CGBpZ27QwAUXqJTanhPTDGCcbGtEWvJ8Z4Cp2NaW7yQUoO1O63Z/rNBtQBjAoeCIqojBhKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E1Xoui0U; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E1Xoui0U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27B511F00893;
	Thu,  4 Jun 2026 15:45:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780587937;
	bh=qTVRTql+uquEceDTyFNYH+ewQpPgP12icd/3VkFjv2c=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=E1Xoui0U7SlTT5R4mL2R1wW2t597agUymseDQQRd1FmsW242o9RLwrThvHrrPkVVy
	 Li9q5Hdj65O3gCnB6YrLoAkBn7HVWiCxNLvq255VyAuRSNkrOCJX+M7Bep3IERqD8V
	 ko8EcVG2bv67RUh4qQGhzlGWoW8oLkKi3Ukegp2UK1lvCI7y6yyC/efabituFYKnCi
	 jyC+OZMSqN0jsX6LNvaXbAmWbKgfELJMr9Ry8Ervpv1ryKRciguO2DUxv06OG1+MJC
	 xsOI5+csoIx+rkPEYH2VlvSHupD7UBtPOLnOflcYok9CpKnyyNIbgv4NV+fFZN/P/Y
	 gPIQCvZYWp+rA==
Content-Type: multipart/mixed; boundary="===============0244661512033162205=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <bf694ae5eb97196472331649ac188cc13e5072c227a3741f8b67fa42e65b3451@mail.kernel.org>
In-Reply-To: <20260604150505.99129-3-leon.hwang@linux.dev>
References: <20260604150505.99129-3-leon.hwang@linux.dev>
Subject: Re: [PATCH bpf-next v2 2/3] bpf: Check tail zero of bpf_prog_info
From: bot+bpf-ci@kernel.org
To: leon.hwang@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,daniel@iogearbox.net,john.fastabend@gmail.com,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,memxor@gmail.com,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,shuah@kernel.org,yuyanghuang@google.com,leon.hwang@linux.dev,kpsingh@kernel.org,davemarchevsky@fb.com,sdf@fomichev.me,linux-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,kernel-patches-bot@fb.com,yatsenko@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu,  4 Jun 2026 15:45:37 +0000 (UTC)

--===============0244661512033162205==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 1007fb7c87e9..0c86a70d31c1 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -5115,10 +5115,11 @@ static int bpf_prog_get_info_by_fd(struct file *file,
>  	u32 info_len = attr->info.info_len;
>  	struct bpf_prog_kstats stats;
>  	char __user *uinsns;
> -	u32 ulen;
> +	u32 ulen, len;
>  	int err;
>
> -	err = bpf_check_uarg_tail_zero(USER_BPFPTR(uinfo), sizeof(info), info_len);
> +	len = offsetofend(struct bpf_prog_info, attach_btf_id);
> +	err = bpf_check_uarg_tail_zero(USER_BPFPTR(uinfo), len, info_len);

A concern raised during the v1 review on the list does not appear to
have been resolved in the code, so it seems worth raising again here.

With len now equal to 228 instead of sizeof(info) == 232, a caller that
passes info_len == 232 will have actual_size (232) greater than
expected_size (228), so bpf_check_uarg_tail_zero() will actively check
the 4 padding bytes and return -E2BIG when they contain garbage.

Could this reject callers that work today?  An existing binary that
allocates struct bpf_prog_info on the stack and passes info_len == 232
without zeroing the trailing padding would have hit the fast path
(actual_size <= expected_size) before this change and returned 0.

There was also a question about whether this actually prevents the
future-field scenario described in the commit message.  If a later
kernel adds a new 4-byte field, the struct size stays 232 and that
kernel's expected_size becomes 232, so an old binary passing
info_len == 232 hits the fast path again and the uninitialized padding
is consumed as the new field.

For reference, the original discussion is here:

  https://lore.kernel.org/bpf/20260603151405.6DB111F00893@smtp.kernel.org/

>  	if (err)
>  		return err;
>  	info_len = min_t(u32, sizeof(info), info_len);


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/26960942650
--===============0244661512033162205==--
