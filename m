Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85783379EF6
	for <bpf@vger.kernel.org>; Thu, 16 Apr 2026 15:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776353280; cv=none; b=PRGwL44tNyChBRrwStLhePkZebKJ6o03t+s2+Ny6PFvPETVLWUYuMoZNZCQCTvX3DxifusfRKgBoM7/vPbQuEGK3cFz1CGBllVzu/RErvbwQazb6c6E9WK8tty6WKcrwi0tHXtjAWi+z7LvyRhbPUN8LCXXXKI+v3oNSDqI127I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776353280; c=relaxed/simple;
	bh=RPJZVAXfH3fU3oPelWcx05PKv3rgZykmAHhfMTp44R8=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=m/gw1hDR45eWAey/m1D+N7xZxkd2EZp12j+kinxaCOjexqGIzNhmNqPFY0QC7fh9LEdj+xo0nGVntMA6DT0ZTU7HvVsPGvaaSayNKZ9IOlIV4oZ3ieuy/sQwXR7ZXrdb8QW3NreaKN74pkB8PeaZEsFq7k872gmuz0RtnIYpc20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ju93zymr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ju93zymr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00C96C2BCAF;
	Thu, 16 Apr 2026 15:27:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776353280;
	bh=RPJZVAXfH3fU3oPelWcx05PKv3rgZykmAHhfMTp44R8=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=Ju93zymrdtae3aC4nGhWdsYL3yjT0NdDrDBpbGKujb/rc8BWRN69BFoVGEyhykxI4
	 uYe7C3Rfb+RwGKI1bmWncsMEJI7ZxUP+ggfgqTvmnh2pHJ7SFxXvCxkjt7QXVV5WGd
	 Zv3GSx0VCHoqtGtXd9VegVFSZyKjODNjYY9Y4viADPe2pEb6zuTLQT2XFPuClZZaQm
	 abDBCPZfNfK3cfAlsY1qYv6dAVWdaHqma80Vz6JDM9ndvxwLN1NRxabtdGKTCoyan/
	 V6YGHlu4KcBPaxTIuvSqfqRbjzq3kX91laRE4Wb4Bp1cgYFOGvgvmqxclA5/zeBPG3
	 8FD5aGVFtPlug==
Content-Type: multipart/mixed; boundary="===============8049481639524996611=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <a6a080d72e21b45ceb48b61d2e3a04d9d70a9e09f1b34510048ae0e2949b5be9@mail.kernel.org>
In-Reply-To: <20260416143904.1220662-4-alan.maguire@oracle.com>
References: <20260416143904.1220662-4-alan.maguire@oracle.com>
Subject: Re: [PATCH v2 bpf-next 3/8] libbpf: Add feature for kernel extended vlen/kind support
From: bot+bpf-ci@kernel.org
To: alan.maguire@oracle.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org
Cc: martin.lau@linux.dev,eddyz87@gmail.com,memxor@gmail.com,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,qmo@kernel.org,mykyta.yatsenko5@gmail.com,bpf@vger.kernel.org,alan.maguire@oracle.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu, 16 Apr 2026 15:27:59 +0000 (UTC)

--===============8049481639524996611==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/lib/bpf/features.c b/tools/lib/bpf/features.c
> index 4f19a0d79b0c..f835931f4afe 100644
> --- a/tools/lib/bpf/features.c
> +++ b/tools/lib/bpf/features.c

[ ... ]

> +static int probe_kern_btf_vlen_kind_extended(int token_fd)
> +{
> +	static const char strs[] = "\0int\0foo\0bar";
> +	__u32 types[EXTEND_TYPE_LEN] = {
> +		/* int */
> +		BTF_TYPE_INT_ENC(1, BTF_INT_SIGNED, 0, 32, 4),
> +		/* var */
> +		BTF_TYPE_ENC(5 /* "foo" */, BTF_INFO_ENC(BTF_KIND_VAR, 0, 0), 1),

Is the btf_var linkage data missing here?  BTF_KIND_VAR requires a
trailing struct btf_var (linkage value) after the btf_type.  The
existing probe_kern_btf_datasec() in the same file includes
BTF_VAR_STATIC after the VAR type:

tools/lib/bpf/features.c:probe_kern_btf_datasec() {
    ...
    BTF_TYPE_ENC(1, BTF_INFO_ENC(BTF_KIND_VAR, 0, 0), 1),
    BTF_VAR_STATIC,
    ...
}

Without it, the kernel's btf_var_check_meta() reads into the next
type's data for the linkage value and rejects it.  EXTEND_TYPE_LEN
would also need to account for the extra __u32.

> +		/* datasec */
> +		BTF_TYPE_ENC(9 /* "bar" */, BTF_INFO_ENC(BTF_KIND_DATASEC, EXTEND_VLEN, 0), 0),

Are the BTF_INFO_ENC arguments swapped here?  The macro signature is:

    BTF_INFO_ENC(kind, kind_flag, vlen)

This passes EXTEND_VLEN (0x10000) as kind_flag and 0 as vlen, which
produces kflag=1 and vlen=0.  The kernel rejects kflag on DATASEC
types, and vlen=0 means the probe doesn't actually test extended vlen.

Comparing with probe_kern_btf_datasec() which uses the correct order:

    BTF_INFO_ENC(BTF_KIND_DATASEC, 0, 1)

Should this be BTF_INFO_ENC(BTF_KIND_DATASEC, 0, EXTEND_VLEN)?

Additionally, the third argument to BTF_TYPE_ENC here is 0, which
sets the DATASEC size to 0.  The kernel's btf_datasec_check_meta()
rejects size == 0.  Should the size reflect the var_secinfo entries,
something like 4 * EXTEND_VLEN?

These three issues (missing btf_var, swapped BTF_INFO_ENC arguments,
and zero DATASEC size) each independently cause the kernel to reject
this BTF, so the probe always fails regardless of actual kernel
support.  This means FEAT_BTF_VLEN_KIND_EXTENDED is never detected,
and bpf_object__sanitize_btf() will always reject BTF with extended
vlen or kind values even on kernels that support them.

> +	};

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/24517220149
--===============8049481639524996611==--
