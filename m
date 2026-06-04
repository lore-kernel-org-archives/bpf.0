Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA8938C41E;
	Thu,  4 Jun 2026 15:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780587940; cv=none; b=o+xC5M2RhGEF1kqPvbRSVALbWVKrfO1/lcAw4Hgf5bpbW7zRvA1nTpVK9TPi1/6xpOo0/ifs0rJ73eVmHRZ9J6ZeSyCFUozZoAl0LMGnMnRnv6x6fi4KkC17QDZsrvSDUt8haSi5eDMjeHw6SPkxJ+nNBRpZcEK4EZnCXQWQHm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780587940; c=relaxed/simple;
	bh=y6XxMHipGTUFLGtRuN9QCWIM4eAnW4ejy98QP106bRA=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=ACPUXx8bkMkEdAiZ2S1gKN8BEeIcNt5fCt/Q6qjNODjZRlF2bwhaGNC0UqkvBwLhf4dMTM7pcrsCySnuZZwdBr52LolVw2PGO/bG6htIT7HTPDHdSuz5pkWeS5k2xd8XHd5LvnsSoDNFut/+xrTBv+TKf0bOMgQf9HrDsxUNgJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m2gNkuoC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m2gNkuoC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D97341F00899;
	Thu,  4 Jun 2026 15:45:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780587939;
	bh=NsOirGav+yB/QU239J6Db1wOSJ9m8egKEp87NxqN1pY=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=m2gNkuoCI1ddSgfRCRE2Jq32ewCk0JdJxkykxh8QKSuoZ1lgrIbyhZvanrH95fb8F
	 6q4JR2WUwBU/FqzHMhqF+XmZktffOYEDi0swwKY2DvW+rByH3YT2zJB+ZG4V+hlms6
	 zNx/cVgohWzCw1hCQoTMyzwzivdEUvOoS5dInNtM8DWopdq94vgWFohWOpDG3CUQ5Z
	 bXybe7cY77BARrwTheEolwSWzzgVLdOC76zc0TArVYOZURLa+gkX3xW5HjHl2qm1xU
	 Aey8homsoxSv0VYf+H/pYWYw9jr/i8M/ccTBlaU/GrBkZZMmxBZ4Et3N18UtoAyvt9
	 sLf00EjePoWiQ==
Content-Type: multipart/mixed; boundary="===============2592704308964919204=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <3e8f405c266d6f15cc2ffeb3ffbe3674b19633c43048c1942e9a33db86c4c811@mail.kernel.org>
In-Reply-To: <20260604150505.99129-2-leon.hwang@linux.dev>
References: <20260604150505.99129-2-leon.hwang@linux.dev>
Subject: Re: [PATCH bpf-next v2 1/3] bpf: Check tail zero of bpf_map_info
From: bot+bpf-ci@kernel.org
To: leon.hwang@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,daniel@iogearbox.net,john.fastabend@gmail.com,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,memxor@gmail.com,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,shuah@kernel.org,yuyanghuang@google.com,leon.hwang@linux.dev,kpsingh@kernel.org,davemarchevsky@fb.com,sdf@fomichev.me,linux-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,kernel-patches-bot@fb.com,yatsenko@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu,  4 Jun 2026 15:45:38 +0000 (UTC)

--===============2592704308964919204==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 625a4366fe6d..1007fb7c87e9 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -5400,10 +5400,11 @@ static int bpf_map_get_info_by_fd(struct file *file,
>  {
>  	struct bpf_map_info __user *uinfo = u64_to_user_ptr(attr->info.info);
>  	struct bpf_map_info info;
> -	u32 info_len = attr->info.info_len;
> +	u32 info_len = attr->info.info_len, len;
>  	int err;
>
> -	err = bpf_check_uarg_tail_zero(USER_BPFPTR(uinfo), sizeof(info), info_len);
> +	len = offsetofend(struct bpf_map_info, hash_size);
> +	err = bpf_check_uarg_tail_zero(USER_BPFPTR(uinfo), len, info_len);

Does this change break the ABI for existing deployed binaries? Previously,
expected_size was 104 (sizeof(info)). If an existing binary passes info_len
= 104 with uninitialized stack garbage in the 4-byte padding,
bpf_check_uarg_tail_zero() would see actual_size <= expected_size (104 <=
104) and immediately return 0.

By reducing expected_size to 100, actual_size > expected_size (104 > 100),
so bpf_check_uarg_tail_zero() will actively check the 4 padding bytes and
return -E2BIG if they contain garbage. This rejects previously working
applications.

Additionally, does this actually protect against the stated future issue?
If a future kernel adds a new 4-byte field, the struct size stays 104, and
the new kernel's expected_size will be 104. At that point, those old buggy
binaries passing info_len = 104 will once again hit the fast path
(actual_size <= expected_size), skipping the check and allowing the
uninitialized padding to be consumed as the new field.

Reference: https://lore.kernel.org/bpf/20260603151405.6DB111F00893@smtp.kernel.org/
From: sashiko-bot@kernel.org
Date: Wed, 03 Jun 2026 15:14:05 +0000

>  	if (err)
>  		return err;
>  	info_len = min_t(u32, sizeof(info), info_len);


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/26960942650
--===============2592704308964919204==--
