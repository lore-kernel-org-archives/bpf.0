Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E452D1F64
	for <bpf@vger.kernel.org>; Tue, 14 Apr 2026 20:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776198560; cv=none; b=UsWNXymuE2rNOqHjG8eGlEmpp4h4T/xgzW81fccEuSDV3Q+cwPiWHdJ+bN/cHtTVC54gtFu2T5zCEShKeSvQtsNjKiB2Y7prVXhdCow+UmPM36pBr9E8b8Yg8vZbTVb0ER/jrVAGoQ9GWMzGM8/T9G9sUTwTtPVYrQsvdohfKcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776198560; c=relaxed/simple;
	bh=pSRhEW774+mPJ248ZVALoIEFunbnEZ5Qy3OePaLkxv8=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=OZbNyl75rR0ObBX0+jaGSsqf0CJe5HUrDoXS3/X0fMfUjBBScEIy2hqDg3qQbphVPjlg31DgNKHKPnqESOYO+7DyZJ5BT2TwqvqX3Frh79TyOaiHLmhtLymvtChg+hGaazOeH319D3BY+NBgCxn+jmBkK6Cy4prn+mFMYvDcLQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VhJSj2Zl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VhJSj2Zl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F037C19425;
	Tue, 14 Apr 2026 20:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776198559;
	bh=pSRhEW774+mPJ248ZVALoIEFunbnEZ5Qy3OePaLkxv8=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=VhJSj2Zl1/DVXWDOwYW5Zue0SfTZBs85NK2IESo/Svv6GQRKTwwH3ANRPhwO0syn6
	 1HuVn3R3nDrjWsVPm/KscrloHVLAZrlq69vqHDayv+/HQaMDsKa8f7foTMmaflLjYw
	 ulvpTNl4UmVTYjcZho2pLZCJBQz2sLrsTEg5EYyrpjB/2P9FKnOs1jH5ZoiLfBAMje
	 STr1rmRdv/hnHrSKRWKiIiJtOa/WquH1BgXo6tehBW/dMJgwYhmZueXTCH8O+UYzAg
	 RU/yjWLppZIFxnQ1eDZSk7rAvPcgx8vZroNW0QMg8Qzvs6nt2kIoJcPxsIJR/jXh/s
	 +/p/hQC6qTtyA==
Content-Type: multipart/mixed; boundary="===============1988659359355805784=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <d975ff536f220ff614371435325e44251713ed131a8c64f2e5be5d04ae06f01d@mail.kernel.org>
In-Reply-To: <20260414195019.684531-4-alan.maguire@oracle.com>
References: <20260414195019.684531-4-alan.maguire@oracle.com>
Subject: Re: [PATCH bpf-next 3/6] libbpf: Add feature for kernel extended vlen/kind support
From: bot+bpf-ci@kernel.org
To: alan.maguire@oracle.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org
Cc: martin.lau@linux.dev,eddyz87@gmail.com,memxor@gmail.com,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,qmo@kernel.org,bpf@vger.kernel.org,alan.maguire@oracle.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue, 14 Apr 2026 20:29:19 +0000 (UTC)

--===============1988659359355805784==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_internal.h
> index 3781c45b46d3..8ef1fc96b73a 100644
> --- a/tools/lib/bpf/libbpf_internal.h
> +++ b/tools/lib/bpf/libbpf_internal.h
> @@ -398,6 +398,8 @@ enum kern_feature_id {
>  	FEAT_UPROBE_SYSCALL,
>  	/* Kernel supports BTF layout information */
>  	FEAT_BTF_LAYOUT,
> +	/* Kernel supports BTF vlen > 65535 */
> +	FEAT_BTF_VLEN_KIND_EXTENDED,
>  	__FEAT_CNT,
>  };

This isn't a bug, but the comment says "BTF vlen > 65535" while the
feature also covers extended BTF kinds (> 31).  The enum name itself
says VLEN_KIND_EXTENDED, the feature descriptor in features.c says
"kernel supports extended BTF vlen/kind", and the sanitization check
in bpf_object__sanitize_btf() tests both btf_vlen(t) > 0xffff and
btf_kind(t) > 0x1f.

Should the comment be something like
"Kernel supports extended BTF vlen/kind" to match?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/24420385267
--===============1988659359355805784==--
