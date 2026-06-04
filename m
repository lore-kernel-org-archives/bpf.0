Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78E3A3C277C;
	Thu,  4 Jun 2026 07:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780559319; cv=none; b=G3pW4w/2zZ1Qkiue0WIrZWRQca1D71KR8CCuOTHY1Z4twUMKMaXdmh7Fm37aN7VeZO9SEMrj+gzWCeb1WKb6EXQfRbsoDzopTOk+wAjZbOATzpfUZx9GTNNJgbTte31XQx/Tr8FEux2P9HavlNmo3D3MDhk2QU+S3lyMBFttU7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780559319; c=relaxed/simple;
	bh=oEG5J/LOk15YQLjgKKPFlsfm/cTbVS+2gW1ZpK8mrAU=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=D/QzsCjbLWwBw4HEQO4OzYZgxODXSpCaamXmjo9XhYBYFJtnTR3G1Dh92XQp4Bnp5l16/DyuKvrJBZSHh0VKlFVihelVJAhsExHNerT9hqpwIri/v5E/DO9WohSW0JCcwh/9qCuvnCOlWykUOZ3WLgemSWo/Knt20bg8U21dTMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j3ksA2dc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j3ksA2dc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C855F1F00899;
	Thu,  4 Jun 2026 07:48:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780559318;
	bh=rkgzbBvaofa7xvPAt3Mvw0ddVSkfgCC7wnxvFFq+Z70=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=j3ksA2dcrQA2eCA7XruAlQ+CosomVg/PbSGgeWaLSbsz3k44nukE6DFuvIuBK7g4u
	 o1BExgdQnYbR4oC1DN2PlNtfKfddDKJfE96f3XmgZtVCo1/5dfGvZzy6jhCfK6lMhY
	 4I4B/qt28rrnm004DeL7stu3ZWYNOXvTU0Kgh7TptukwPaSDAcYDp5QGt3RjrnccOT
	 ytDK7L1AQ826R5uzc7JJirXfdqtuOX4Cdw0bFXl7q3ZGvEkgy19mhKZ+EaF4Wiqh6m
	 X5gQlyaQ2urzCUJjniRBUJFTQbHh3LprIWTd+43BPzkUvR2nlK4xbjR/mmqDw+mEE7
	 PmAkMSfkYAMVA==
Content-Type: multipart/mixed; boundary="===============6195489814518535589=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <ed3f03d2f6e66ffe1ed007d976b402e5453045a53a91b36555f59ff481710fa6@mail.kernel.org>
In-Reply-To: <20260604070318.2869813-1-malin89@huawei.com>
References: <20260604070318.2869813-1-malin89@huawei.com>
Subject: Re: [PATCH v4 1/2] bpf: Tighten cgroup storage cookie checks for prog arrays
From: bot+bpf-ci@kernel.org
To: malin89@huawei.com,ast@kernel.org,daniel@iogearbox.net,bpf@vger.kernel.org
Cc: andrii@kernel.org,john.fastabend@gmail.com,martin.lau@linux.dev,eddyz87@gmail.com,memxor@gmail.com,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,zhuyifei@google.com,shuah@kernel.org,linux-kselftest@vger.kernel.org,linux-kernel@vger.kernel.org,ameryhung@gmail.com,malin89@huawei.com,cuirongzhen@huawei.com,tanjingguo@huawei.com,cenxianlong@huawei.com,chenzhe@huawei.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu,  4 Jun 2026 07:48:37 +0000 (UTC)

--===============6195489814518535589==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index a656a8572bdb..d85869544dc8 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -2480,8 +2480,12 @@ static bool __bpf_prog_map_compatible(struct bpf_map *map,
>  				break;
>  			cookie = aux->cgroup_storage[i] ?
>  				 aux->cgroup_storage[i]->cookie : 0;
> -			ret = map->owner->storage_cookie[i] == cookie ||
> -			      !cookie;
> +			/*
> +			 * Tail calls keep using the caller cgroup storage
> +			 * context, so prog-array members must use the same
> +			 * storage cookie.
> +			 */
> +			ret = map->owner->storage_cookie[i] == cookie;

Does dropping the "!cookie" term here reject a configuration that was
previously valid and safe?

With the old check, a program that uses no cgroup local storage (cookie
== 0) could join a prog-array whose owner uses cgroup storage
(storage_cookie[i] != 0), because "!cookie" was true. With the new check,
"storage_cookie[i] == 0" is false for that owner, so the storage-less
program is now rejected with -EINVAL:

prog_fd_array_get_ptr()            (kernel/bpf/arraymap.c)
  bpf_prog_map_compatible()        (kernel/bpf/core.c)
    __bpf_prog_map_compatible()

The original fix in abad3d0bad72 ("bpf: Fix oob access in cgroup local
storage") appears to document this allowance as intended, describing case
(ii) as "allow the tail call combination if the second program was not
using any of the cgroup local storage maps."

The out-of-bounds access that fix targets happens when a program that
calls bpf_get_local_storage() runs under a mismatched-size entry-program
run context. bpf_get_local_storage() in kernel/bpf/cgroup.c reads the
entry program's pinned run context:

	storage = this_cpu_read(bpf_cgroup_storage[stype]);

A program that uses no cgroup local storage never calls that helper, so
can it actually trigger the out-of-bounds access?

For the A -> B(no storage) -> C(storage) path in the commit message, would
C still need to match the owner cookie to join the prog-array, since
C's cookie is nonzero and "!cookie" is false for it? If so, is the bridge
path that this patch aims to close already blocked by the existing check
on C?

This change is Cc: stable and applies under CONFIG_CGROUP_BPF=y, so could
it break existing BPF applications that mix storage-using and storage-less
programs in a single prog-array?

---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/26936884530
--===============6195489814518535589==--
