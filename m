Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DCDE3D47AD;
	Tue, 24 Mar 2026 08:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774342720; cv=none; b=qANfQEqInqERwCngbPdj0o1Mr7/6bgcKp5z8Spb6kSOSsVm2D3aDEhhwn5Cr/i+VVMzAYpMGUlUgoZDWTwCyrfuSTTYq1KzAIWzzSSHqYGChHRubQSdOMaIYQE/rbuZZHZxm3SZFFjfMt4MvakCOu4K3MXbg5uFLq+A+nZjU8Hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774342720; c=relaxed/simple;
	bh=DdRGu+zU4PWGAInuW3WV7GbGPB8GnzmEFflSjw7AHhI=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=U0bYckpH/yj7q8G7K3L1RkQY+0ZsJCaYrnBlD4G42WJh9CRCdF7M7laT+jPFNgq1iKkA4RpNN3Fbibv3tF8nppl1QYBLeJGMO3BaJflO2TOpmO6ahLeh3H5JtNlff5zWp2J6DvtUj3s4hupCdq9c/HxlaNGVYGFdhbGyT1HrGaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F+7qIfaE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F+7qIfaE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92DAFC2BC9E;
	Tue, 24 Mar 2026 08:58:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774342719;
	bh=DdRGu+zU4PWGAInuW3WV7GbGPB8GnzmEFflSjw7AHhI=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=F+7qIfaEjWIo+pu0HoRTJRajg4pf9ESMspowiKeHUeUhGn4aNXwNiEsuXNwXzD8Pz
	 N5CNduztrzWDsGEqEZYZnexY/6HrYEujjfw01J58DRn9sfHG6iPdlVtkjsW3zk7gCa
	 jaeLTd8MR7VnGb1mafCvpDlTZT6ccyA/4oSn6qiIeUPhfDar3D2k/YqvGZCUqc/eqN
	 CARQmcJdccy/QvIVLj+41TCVQxLguClSW3C06hiMZLlA/GgBefGkqCzUcJrB9n5luy
	 VFzSJBpsk6TsbFTWc6PPvJiUGwHuES3RsaS0Cv17/4hcjs+lPz3uss44po36zUz57b
	 6N1johJJ667Aw==
Content-Type: multipart/mixed; boundary="===============2899610495426949031=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <164b58d37098843f85298dac240da89e8383c552500148fa53f642d40d72b682@mail.kernel.org>
In-Reply-To: <20260324081846.2334094-17-jolsa@kernel.org>
References: <20260324081846.2334094-17-jolsa@kernel.org>
Subject: Re: [PATCHv4 bpf-next 16/25] libbpf: Add btf_type_is_traceable_func function
From: bot+bpf-ci@kernel.org
To: jolsa@kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org
Cc: bpf@vger.kernel.org,linux-trace-kernel@vger.kernel.org,kafai@fb.com,eddyz87@gmail.com,songliubraving@fb.com,yhs@fb.com,menglong8.dong@gmail.com,rostedt@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue, 24 Mar 2026 08:58:39 +0000 (UTC)

--===============2899610495426949031==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index c6cd6ccb870b..139df8484edb 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c

[ ... ]

> +bool btf_type_is_traceable_func(const struct btf *btf, const struct btf_type *t)
> +{

[ ... ]

> +	/* No support for struct/union return argument type. */
> +	t = btf__type_by_id(btf, proto->type);
> +	while (t && btf_type_is_modifier(t))
> +		t = btf__type_by_id(btf, t->type);
> +
> +	if (btf_is_struct(t) || btf_is_union(t))
> +		return false;

It looks like t can be NULL after the while loop exits, since
btf__type_by_id() returns NULL for out-of-range type ids.
btf_is_struct() and btf_is_union() would then dereference it.

The kernel's __get_type_size(), which btf_distill_func_proto()
calls for the same purpose, has this after an identical while loop:

kernel/bpf/btf.c:__get_type_size() {
    ...
    while (t && btf_type_is_modifier(t))
        t = btf_type_by_id(btf, t->type);
    if (!t)
        return -EINVAL;
    ...
}

Should there be a similar NULL check here before calling
btf_is_struct(t)?

> +
> +	for (i = 0; i < nargs; i++) {

[ ... ]

> +	return true;
> +}


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/23480161822
--===============2899610495426949031==--
