Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B9EB37B02A;
	Fri,  5 Jun 2026 16:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780677392; cv=none; b=lLVTLm7lGvPlQkSiCLfr8j0+raY9ErXEQrcb998zi/lM6BnkYR2Up6qmTLpLgHWneFvrYWBZ+PTZarbQ1YgjTqfMnNuOwzaxWFNswV0DNGZe1fAeE1MccnOXReAhZD4YIu/0TzZINdmplK4pTny/NdvWOBLVkLn3N/T09mtA5vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780677392; c=relaxed/simple;
	bh=v5ELkvGCZq1N3nX9mAXJeHVpZuf0ySnc+4V/iBCGN/k=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=ePIxHOdhQWteh/ZUvnE1FAe2mnfoIV2+0aNVpON/pv9zZQH/BYQzmjy1l2KB1Ngh1GBtVR4DcODapAY1abdHGzQnxl5doU7YVbqozM0ATHK3yE8NTPhZkCVD483/3vkCDQTBdct6qTEQmtxTUu48mTB0HIjKUFy+I+vLNCsjgbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P/FCGBy5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P/FCGBy5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E30131F00898;
	Fri,  5 Jun 2026 16:36:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780677387;
	bh=NhzGkTvTOsDPvtPajOB34RAWLOEB+uxckYz3rZNDzQo=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=P/FCGBy54L7ZsandkeOpn1trMhH6fE3DgUFDFVgnAM+MYQNq+2cQHTlCLv0qN0sHI
	 UyP0dKyjddXliOHQwMoFydE9IEb07GUpKpUi16Zc2AdN1NjumQbVVh1Nj44MD2Rf/P
	 MGQ5E8uyB6ZeBXDR4vX7DwuqFH8l4NeB9kXriAVk4gk8DVN+O6VFHsAG4q68J6dSvf
	 FQUUqiZXAPicjtEGlCFoKRdQpuADrOfHjTdYTJiYFaxXr9NYfYFbAEqDBbvsfvPEyr
	 ceSgUbltF+jjubNKaaqNEC0enuIStWjzjF59UG0xFFtQ7N3aMAywY9BS4BJXw33DGH
	 oBrJ8FpAk17Mg==
Content-Type: multipart/mixed; boundary="===============3143658977373259747=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <2d84292ee48c9b2d0e1bdedb591ce43af8cdfdc575bc6fb0ac326a34b8a3fcd9@mail.kernel.org>
In-Reply-To: <20260605155249.20772-3-leon.hwang@linux.dev>
References: <20260605155249.20772-3-leon.hwang@linux.dev>
Subject: Re: [PATCH bpf-next v3 2/3] bpf: Check tail zero of bpf_prog_info
From: bot+bpf-ci@kernel.org
To: leon.hwang@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,daniel@iogearbox.net,john.fastabend@gmail.com,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,memxor@gmail.com,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,shuah@kernel.org,yuyanghuang@google.com,leon.hwang@linux.dev,kpsingh@kernel.org,davemarchevsky@fb.com,sdf@fomichev.me,linux-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,kernel-patches-bot@fb.com,yatsenko@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri,  5 Jun 2026 16:36:26 +0000 (UTC)

--===============3143658977373259747==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> commit acd0d2042870d7613c0c27932c41262d1c41b4e1
> Author: Leon Hwang <leon.hwang@linux.dev>
> Commit: Kernel Patches Daemon <kernel-patches-bot@fb.com>
>
>     bpf: Check tail zero of bpf_prog_info
>
>     Since there're 4 bytes padding at the end of struct bpf_prog_info, they
>     won't be checked by bpf_check_uarg_tail_zero().
>
>     pahole -C bpf_prog_info ./vmlinux
>     struct bpf_prog_info {
>             ...
>             __u32                      attach_btf_obj_id;    /*   220     4 */
>             __u32                      attach_btf_id;        /*   224     4 */
>
>             /* size: 232, cachelines: 4, members: 38 */
>             /* sum members: 224 */
>             /* sum bitfield members: 1 bits, bit holes: 1, sum bit holes: 31 bits */
>             /* padding: 4 */
>             /* forced alignments: 9 */
>             /* last cacheline: 40 bytes */
>     } __attribute__((__aligned__(8)));
>
>     If a future kernel extension adds a new 4-byte field, older userspace
>     programs allocating this structure on the stack might inadvertently pass
>     uninitialized stack garbage into the new field, permanently breaking
>     backward compatibility. -- sashiko [1]
>
>     Fix it by changing sizeof(info) to
>     offsetofend(struct bpf_prog_info, attach_btf_id).
>
>     And, add "__u32 :32" to the tail of struct bpf_prog_info.
>
>     [1] https://lore.kernel.org/bpf/20260513224823.6494FC19425@smtp.kernel.org/
>
>     Fixes: aba64c7da983 ("bpf: Add verified_insns to bpf_prog_info and fdinfo")

Is the Fixes: tag pointing to the right commit? The padding bug was
actually introduced by commit b79c9fc9551b ("bpf: implement BPF_PROG_QUERY
for BPF_LSM_CGROUP"), which added attach_btf_obj_id and attach_btf_id after
verified_insns, creating the 4 bytes of padding at the end of the structure.
Commit aba64c7da983 added verified_insns as the last field but did not
create padding.

Suggested: Fixes: b79c9fc9551b ("bpf: implement BPF_PROG_QUERY for
BPF_LSM_CGROUP")

>     Acked-by: Mykyta Yatsenko <yatsenko@meta.com>
>     Signed-off-by: Leon Hwang <leon.hwang@linux.dev>

[ ... ]

> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 89f020a44fc9..c5d4ae957e87 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -5121,10 +5121,11 @@ static int bpf_prog_get_info_by_fd(struct file *file,
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
>  	if (err)
>  		return err;
>  	info_len = min_t(u32, sizeof(info), info_len);

Does this change break the ABI for existing deployed binaries?

Previously, expected_size was 232 (sizeof(info)). If an existing binary
passes info_len = 232 with uninitialized stack garbage in the 4-byte
padding, bpf_check_uarg_tail_zero() would see actual_size <= expected_size
(232 <= 232) and immediately return 0.

By reducing expected_size to 228, actual_size > expected_size (232 > 228),
so bpf_check_uarg_tail_zero() will actively check the 4 padding bytes and
return -E2BIG if they contain garbage. This rejects previously working
applications.

sashiko-bot and bot+bpf-ci raised this concern in v1 and v2:
https://lore.kernel.org/bpf/20260603151405.6DB111F00893@smtp.kernel.org/

While v3 adds '__u32 :32;' to prevent future field additions in the
padding space (addressing forward compatibility), the backward
compatibility concern about breaking existing binaries remains unresolved.

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/27025811732
--===============3143658977373259747==--
