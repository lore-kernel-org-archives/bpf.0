Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D62B40681C
	for <bpf@vger.kernel.org>; Mon, 29 Jun 2026 13:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782738782; cv=none; b=q+gnbuep1qIJSGANwGk19HuROGlAo4M3+OykFVrCiTD5s9g9t+Ttv9joS+68yKlP2payB1IMsoWCOe9adKLJk5SJ9HknXKIBDi1LJcPt7jD5P4cMyRdNhEIkYRUuvVYvym6ZkENHSNBQnR9dJwVWMeZYn7rLnrpH/8uBPiUB10o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782738782; c=relaxed/simple;
	bh=629ggVmG/cDj/bhFqRMDUreocXClx9WMeuSfgdHZ47U=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=q7PQ2XVCQXO45paDXGSQ1ZhTA+yKldpbu1iIYfb3/lRhDLIbq+rf1hk2dwDpRw3pvTPsH770Y7tojPP/d5ExRrnyhh8zbIy1FkY5rch9HdsP5Kty3EeDHODwsNrLCQK4o9R2iLnTzfjs8hrviOvZDoWnNEENKVRmkjQiU4aRy14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IgERYcJ5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IgERYcJ5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 937A51F00A3A;
	Mon, 29 Jun 2026 13:13:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782738780;
	bh=nwbtGxzae8jwJ6ZSSgkvjjvM9bDrfoNRL7Hvr+xwAko=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=IgERYcJ5crS6sGXjqZlRYEqO+2kDRB68+zfmfl7+S5f3Rc4cyepx7uEsEELqnmvx+
	 lNAeaOrR2WFbw0qzqHaxmEnRvxrD6hP0s9A17BQ10lBq8v4GU4OvUlnJ0D1wXrS0nA
	 WCN0FS2y3I4CATry0715DoC5JmQqxHb7lxMnWo2U2MkCJXACoeGWxipUOpR0zvEwN4
	 4Rjh/bp6vZR9rxuNUndEsHQRjxBY3dvlh7MW/pnqxchsVnKSRLSRxXKK9RU6/5lVO1
	 czWE8Mbl0+3QTwdHuibjbABkkORwIfJHa+Xuh5HsSQGNOmsxkRI44P2wOjdFSfMiJR
	 /RwevH6L7dGxQ==
Content-Type: multipart/mixed; boundary="===============7785773947655452546=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <21dec7945e2fb3743e7a8148b24e84986a3d79c1c57cfcd54a44329a1f07035e@mail.kernel.org>
In-Reply-To: <20260629122559.3828469-1-maghasi@disroot.org>
References: <20260629122559.3828469-1-maghasi@disroot.org>
Subject: Re: [PATCH] libbpf: Add length checks for path parameters before memory allocation
From: bot+bpf-ci@kernel.org
To: maghasi@disroot.org,bpf@vger.kernel.org
Cc: andrii@kernel.org,eddyz87@gmail.com,ast@kernel.org,daniel@iogearbox.net,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,maghasi@disroot.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon, 29 Jun 2026 13:13:00 +0000 (UTC)

--===============7785773947655452546==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> commit db9140ef75b49207c16db30f458eed63f232d989
> Author: Masoud Aghasi <maghasi@disroot.org>
>
>     libbpf: Add length checks for path parameters before memory allocation
>
>     Several libbpf API functions such as bpf_object__open_file() and
>     bpf_program__pin() allocate memory based on user-provided paths without
>     first validating input length.
>
>     This can result in out-of-memory errors or different error codes
>     (ENAMETOOLONG, ENOMEM) being returned.
>
>     This patch adds missing path length checks to ensure all affected APIs
>     return a consistent error code (ENAMETOOLONG) for invalid path lengths,
>     preventing potential memory allocation failures.
>
>     Additionally, adds some missing NULL pointer checks to prevent
>     potential segmentation faults.
>
>     Best regards,
>
>     Signed-off-by: Masoud Aghasi <maghasi@disroot.org>

This isn't a bug, but could the "Best regards," closing be dropped from the
commit body? Kernel commit messages conventionally end with the rationale
before the Signed-off-by trailer, without email-style salutations.



---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/28373171289
--===============7785773947655452546==--
