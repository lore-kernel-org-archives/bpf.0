Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1FB45349DE;
	Tue, 22 Sep 2026 10:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790072608; cv=none; b=IpQYHzAjwALpQC03EjzKK6BmmSPFe2pHgqnrKVHNSXAdeoTJEyRrWdyPgJjpoltq70uo+4J3rmAcuvpA6yKk/OlEiFQk8qKPOaZ0lsZmTN0DEpVbCCLM4Ovm+wrt0gD8fbzUwZrf2m1usuvJonhmmihc5ml6DLsNuWJDQkVs7Rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790072608; c=relaxed/simple;
	bh=N/XTOvAZFCE2uxDxA2KGA+DDvghlWNihgNU5dCh5ItQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XvxGiVKyWwnx/QytsxVMS/lPK2EHDDfIsuFqlgJPZKMEebnSJRiLLuTEiMbVIJRLxNXsajq2LSWm7UCnd+XRgrXZgnLZ8OQnyw0wt7/LQ2lG5JkyeaHh+M5XjDRt24/fA3kpV2rEzIcrZIoE5VVTDtE/VlTY5F1W5BQWfpydgp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fIKVwI1o; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fIKVwI1o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32A6F1F0089A;
	Tue, 22 Sep 2026 10:23:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790072606;
	bh=dyMT/N53dTTeC7Yd9CWDWTzhnoNsNOIKIlUPSL0CC1o=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=fIKVwI1otPF8KN+yLeK/RQg/K6Bt9yyy8pfQRcmvbqQUbJCK1JkL8olGxWFUOXJ4O
	 BGZolDI+90Uc6OPZsP/mvIrJsUvwfEn2sNnup+kslg9TNE1v0hZDRc/g53mzkGcEQc
	 Z/Q2CZWB+bUti58/LLAXZZqR09zgB0Ea4kqLS8KfWrqdeqKJNj6P5zQK9QUfSCKD25
	 5YSbibEfM7Qslb/rZ52ILznaopM0oR46lCEnAB1p2gH5z8njynV6wp1HlSLtGqoioj
	 WRoi063bDykrgt8w+pf46Se42fgRwO2SJjBFOmEryyvV6XBgSHu9yPDu9MtAIt80Qs
	 zWH0yV54jVBSg==
Message-ID: <3a639eae-1f94-4d3d-b2f1-99b7716bd684@kernel.org>
Date: Tue, 22 Sep 2026 11:23:23 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 3/3] bpftool: Add support for BPF_F_PREORDER
 cgroup attach flag
To: Hui Su <sh_def@163.com>, bpf@vger.kernel.org,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Yonghong Song <yonghong.song@linux.dev>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Jiri Olsa <jolsa@kernel.org>, Emil Tsalapatis <emil@etsalapatis.com>,
 Ihor Solodrai <ihor.solodrai@linux.dev>, Shuah Khan <shuah@kernel.org>,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260922025442.3176057-1-sh_def@163.com>
 <20260922025442.3176057-4-sh_def@163.com>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <20260922025442.3176057-4-sh_def@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

2026-09-22 11:54 UTC+0900 ~ Hui Su <sh_def@163.com>
> Commit 4b82b181a26c ("bpf: Allow pre-ordering for bpf cgroup progs")
> introduced BPF_F_PREORDER to request pre-order execution across the
> cgroup hierarchy. Furthermore, attachments legitimately use combinations
> such as BPF_F_ALLOW_MULTI | BPF_F_PREORDER or
> BPF_F_ALLOW_OVERRIDE | BPF_F_PREORDER.
> 
> With BPF_PROG_QUERY reporting the per-program BPF_F_PREORDER attribute,
> bpftool's exact-match formatter falls back to "unknown(40)" when
> BPF_F_PREORDER is present alone, or "unknown(41)" / "unknown(42)" when
> combined with BPF_F_ALLOW_OVERRIDE or BPF_F_ALLOW_MULTI. Additionally,
> do_attach() only accepts "multi" and "override", rejecting "preorder"
> with "unknown option".
> 
> Before:
>   $ bpftool cgroup show <cg>
>   1234  cgroup_inet_ingress  unknown(42)  test_prog
>   $ bpftool cgroup attach <cg> cgroup_inet_ingress id 5678 multi preorder
>   Error: unknown option: preorder
> 
> After:
>   $ bpftool cgroup show <cg>
>   1234  cgroup_inet_ingress  multi,preorder  test_prog
>   $ bpftool cgroup attach <cg> cgroup_inet_ingress id 5678 multi preorder
>   (attaches successfully)
> 
> Refactor the attach flags formatter into a bitmask formatter that outputs
> comma-separated flag names for plain text while preserving unrecognized
> bits as "unknown(...)". Render attach flags as an array of flag names in
> JSON output. Accept "preorder" in do_attach(), update the cgroup
> documentation and synopsis to express valid flag combinations, and teach
> bash completion about them ("multi" or "override" optionally combined
> with "preorder").
> 
> Signed-off-by: Hui Su <sh_def@163.com>

Acked-by: Quentin Monnet <qmo@kernel.org>

Thank you
