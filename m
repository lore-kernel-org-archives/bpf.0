Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3078B27AC31
	for <bpf@vger.kernel.org>; Thu, 16 Apr 2026 15:15:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776352551; cv=none; b=ZPb1VP647FGrYediv8rM3D0/V0xe4lLcA6WV8VJXE0NQ92hmNXaN7se+ChDL2Kp3cL9Pz0nD2NII+MasHcNEWtmTyjFeOApfyQEuzWzOhyukcNN9LG0/axKQiEX9pR3BFWf6GP7xhAm8v6hDs6+hsK8Y3KM4QEjoQlNSiW3Tdgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776352551; c=relaxed/simple;
	bh=gF55HNTGr093vIbvj72UCK1ob/dSLJ65yyz24eJWjMQ=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=QLiBdDH1ROhCVutl/hIMVJpJ6Imvq6gUTWthWIpAAA3zywALsLTTKAkM2J0AQl+sF/m8/8MptmVqlVDzFzljUs96AzBRvbH7RLYMS4sZMhOIgJ++EP/4QY4SDyQ747mQAmBHHHp8ZoLs5D3VIYysbUDQf0B+kqGzFNmiPWJ3S1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ulelKqYv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ulelKqYv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72620C2BCAF;
	Thu, 16 Apr 2026 15:15:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776352550;
	bh=gF55HNTGr093vIbvj72UCK1ob/dSLJ65yyz24eJWjMQ=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=ulelKqYvqSL/Ur7AuHP2jEA9d030iuwp4J9lPpKJZ5Zx3xfplQFljKHoG9vjULWsR
	 xNzzywa5J+SjmahU/WybZqy4JsMiXdJWCR6t8y7SxEldNmADUxK/vMUCpd4bkKdtAT
	 u44eC2hhjqUyVJGuvW6uF3WCqsEZmJGD83DcLfHAQJUZGqY1JdbvfvTz6564+0MeW7
	 FWLo9oaYZEIXYotqHFravzLq9z8k5KhSKhWMRNRUDfEagh11DExtvARMiZrHjiKMG/
	 iu7nxrk1kN7Rg1w7Gdq1Z3Zys74VIjL+Vb3shKnHTpDKPD8CZ5RcW/FDUglKCtDzgs
	 pZbMpgkPldnww==
Content-Type: multipart/mixed; boundary="===============1413418372167646656=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <6f22154ebefa662ba091fdb5caa627add34a655149634abe23c20462e28cb17d@mail.kernel.org>
In-Reply-To: <20260416143904.1220662-5-alan.maguire@oracle.com>
References: <20260416143904.1220662-5-alan.maguire@oracle.com>
Subject: Re: [PATCH v2 bpf-next 4/8] bpftool: Support 24-bit vlen
From: bot+bpf-ci@kernel.org
To: alan.maguire@oracle.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org
Cc: martin.lau@linux.dev,eddyz87@gmail.com,memxor@gmail.com,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,qmo@kernel.org,mykyta.yatsenko5@gmail.com,bpf@vger.kernel.org,alan.maguire@oracle.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu, 16 Apr 2026 15:15:50 +0000 (UTC)

--===============1413418372167646656==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
> --- a/tools/bpf/bpftool/gen.c
> +++ b/tools/bpf/bpftool/gen.c

[ ... ]

> @@ -2523,8 +2526,7 @@ static struct btf *btfgen_get_btf(struct btfgen_info *info)
>  		/* add members for struct and union */
>  		if (btf_is_composite(type)) {
>  			struct btf_member *cloned_m, *m;
> -			unsigned short vlen;
> -			int idx_src;
> +			unsigned int vlen, idx_src;

This isn't a bug, but the rest of the patch consistently uses __u32 for
vlen (in btf.c dump_btf_type, and in btfgen_mark_type_match), while
this one spot uses unsigned int.  Should this be __u32 for consistency?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/24517220149
--===============1413418372167646656==--
