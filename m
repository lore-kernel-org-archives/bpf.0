Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F14317165
	for <bpf@vger.kernel.org>; Fri, 17 Apr 2026 15:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776440353; cv=none; b=Th068f7cACo/e1/y6BXnp+d6OyTLrCNAOgb+4IlFjDy4EWpFzRLJ+ujALFNlbK7tPpGo8qA+s0xTxvXsBymyWXTp5dnQ6/o2mXk2INeKhMKi4llypyjiux42NpotX7JA9Kw47gXTFLe13h8xrufrBHzqB0cKQY7NisI7EhGvjOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776440353; c=relaxed/simple;
	bh=lfJ6AECW8NHixEaveA2cynuiHuvoozBxIz208Q9uJPM=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=pv/CKe8nv5qMVuttraUKxaSenWqT/yfQUtxt8OIbZZ1slHEFDTmvFC13b08n8pNqSe2zlHeHwLLRkrkOuhu0a4p3bAGVA8dIe69SmhInr/oFh0m3E8NxKNLm56T2brXkDU9LbD+3ZRI5g4JoRbMUmvh0MbgUB8ZKaUSm6aRUUws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=abU8gunY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="abU8gunY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF625C19425;
	Fri, 17 Apr 2026 15:39:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776440353;
	bh=lfJ6AECW8NHixEaveA2cynuiHuvoozBxIz208Q9uJPM=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=abU8gunYq0+aiW6ecUQ5jfLKU+CRP3WMr9SesiizY/7fho2YCDlH73230Q4OLCuIv
	 7WbfXjCFOAaOvG/JTIGlCOF3DyJqBslsuiTPnign88jfAZj6U/32foc4uB2r4DROJ8
	 HRnJvG+fQNmxEoJjOycXF6X7os2N8xoFOlM2uhwh5Dr7uFwGaHb8wDa2knp6Diyuvi
	 B4E2Vdw72d3HLcc5VvrMaiqpEAclYRwWIBFKRsDmfr6TsP3NFJk8PSMjhWnWD54I6F
	 TW+5URE0oojXRNWUAPIdKZ3o3jcXOLv+sAE0hjKKaq0B09KdssoGACnpH1nIjoIm4p
	 92hJ3UAI78jvA==
Content-Type: multipart/mixed; boundary="===============5665111667069205873=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <0c04590254c3cf4a4a53803c5c8d613bf2ad288b3eaf2a641794f78d4bf0d5c9@mail.kernel.org>
In-Reply-To: <20260417143023.1551481-7-alan.maguire@oracle.com>
References: <20260417143023.1551481-7-alan.maguire@oracle.com>
Subject: Re: [PATCH v3 bpf-next 6/6] Documentation/bpf: Update btf doc with updated vlen, kind sizes
From: bot+bpf-ci@kernel.org
To: alan.maguire@oracle.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org
Cc: martin.lau@linux.dev,eddyz87@gmail.com,memxor@gmail.com,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,qmo@kernel.org,mykyta.yatsenko5@gmail.com,bpf@vger.kernel.org,alan.maguire@oracle.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri, 17 Apr 2026 15:39:12 +0000 (UTC)

--===============5665111667069205873==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/Documentation/bpf/btf.rst b/Documentation/bpf/btf.rst
> index 3b60583f5db2..3f05f17990ad 100644
> --- a/Documentation/bpf/btf.rst
> +++ b/Documentation/bpf/btf.rst
> @@ -97,10 +97,8 @@ Each type contains the following common data::
>      struct btf_type {
>          __u32 name_off;
>          /* "info" bits arrangement
> -         * bits  0-15: vlen (e.g. # of struct's members)
> -         * bits 16-23: unused
> -         * bits 24-28: kind (e.g. int, ptr, array...etc)
> -         * bits 29-30: unused
> +         * bits  0-23: vlen (e.g. # of struct's members)
> +         * bits 24-30: kind (e.g. int, ptr, array...etc)

Does the kind field documentation accurately match the UAPI implementation?
The UAPI defines BTF_INFO_KIND as:

    #define BTF_INFO_KIND(info)     (((info) >> 24) & 0x7f)

The mask 0x7f is 7 bits, which means kind occupies bits 24-30. This
documentation shows "bits 24-30" which appears correct.

However, checking the actual implementation confirms the kind field uses
only 7 bits (0x7f mask), leaving bit 31 exclusively for kind_flag.


Should the documentation have removed the "bits 16-23: unused" description?
The previous documentation listed bits 16-23 as unused, but after expanding
vlen to bits 0-23, these bits are now part of vlen. The current bit
allocation is:

    - Bits 0-23: vlen (24 bits)
    - Bits 24-30: kind (7 bits)
    - Bit 31: kind_flag (1 bit)

The patch removes the "bits 16-23: unused" line from the struct comment,
which correctly reflects that these bits are now part of the expanded vlen
field.

>           * bit     31: kind_flag, currently used by
>           *             struct, union, enum, fwd, enum64,
>           *             decl_tag and type_tag


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/24570998051
--===============5665111667069205873==--
