Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 513F7484234;
	Tue,  1 Sep 2026 17:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788282759; cv=none; b=F1hoPr2o9haINKKJbmtwEOZ596PZyP2Mijq3sQ0Zqd1Os1mA5/BX8Xh47ua3yMydW10p8KcKv/4kJLy0Pz7IDu4rmzBhB9as5hCtZqLRVZfkEpjnaUl0sFqjXpTElV290LUwswwT55GmExVZMUHC8e8DBm0tEt/P7HBz1LevMy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788282759; c=relaxed/simple;
	bh=JVqW1TQO9sG9sMSqkuvYJtidTVnqLbtFQystXfxtfPQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GmU8Y+lyEMybmlYHLx0w3LAdLf7NGxvCbIr76woTnRfcVKOhNk9vUlr2oCN6JSHW+kSpw9WxgTKTghgaeOuJh4YWEKbrH25yP2LPiVqQgI+e+i1K4dBdlnd2Ybx7cj1f/Bd959bvtXbFZ+IeINLLFH7+zAv8ZQmo/CkgDZC+rG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L9432Edh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L9432Edh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0BDA1F000E9;
	Tue,  1 Sep 2026 17:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788282757;
	bh=q/Puu7QWkStM8ummTyB+h/YAUuGv89euTH/QA874cOs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=L9432EdhOTYNIovph/wMfyKD7icgOUBdvP9E2SxTvNSuRs4I15WT0efGKx6KK32AS
	 /dW3Jxx3f7Hgh8cveAXGpqbpCI0ApW9hzGbnDtUQsemi70RKT5s2E2XceSZGSrxuhe
	 43J7+0IbnbcgOJ4/ubjyBVLgg8kBWzbqZ3XrwIo29wFiRXQByLEiR3I3GI+tVI+fCF
	 +UkXuE6Ypl4/O6dVMatDyiyrN/UGd14l80p+IOBP7W9ishbuAtMYVby6pI9UMLX6o7
	 U8sYpgk0MG3IO6riWzqEZibiBovtZoS64GykYqBt8+cLiZStKTH/z1yTklmoXNKGdh
	 WlsE1Jkg1dAPw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 bpf-next 10/18] bpftool: Document support for
 multi-split BTF
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alan Maguire" <alan.maguire@oracle.com>
Cc: bpf@vger.kernel.org, linux-modules@vger.kernel.org
In-Reply-To: <20260901165757.801449-11-alan.maguire@oracle.com>
References: <20260901165757.801449-1-alan.maguire@oracle.com>
 <20260901165757.801449-11-alan.maguire@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 17:12:37 +0000
Message-Id: <20260901171237.B0BDA1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Low] The synopsis in the manual page incorrectly implies a maximum of tw=
o base BTF options.
- [Low] The interactive help text for the `btf` subcommand was not updated =
to reflect multiple `-B` options.
--

commit 42ebee481eb7237c0598d57bed53fc37d0f50a61
Author: Alan Maguire <alan.maguire@oracle.com>
Subject: bpftool: Document support for multi-split BTF

This commit documents the ability to pass multiple levels of split BTF using
the "-B base_btf" options.

> diff --git a/tools/bpf/bpftool/Documentation/bpftool-btf.rst b/tools/bpf/=
bpftool/Documentation/bpftool-btf.rst
> index cf75a7fa2d6bc..60c46748b8663 100644
> --- a/tools/bpf/bpftool/Documentation/bpftool-btf.rst
> +++ b/tools/bpf/bpftool/Documentation/bpftool-btf.rst
> @@ -16,7 +16,7 @@ SYNOPSIS
> =20
>  **bpftool** [*OPTIONS*] **btf** *COMMAND*
> =20
> -*OPTIONS* :=3D { |COMMON_OPTIONS| | { **-B** | **--base-btf** } }
> +*OPTIONS* :=3D { |COMMON_OPTIONS| | { **-B** | **--base-btf** [ **-B** |=
 **--base-btf** ] } }

[Severity: Low]
Does this syntax incorrectly imply a maximum of two base BTF options? The t=
ext
below states that multiple base BTF objects can be passed, but the synopsis
seems to limit it to two.

Additionally, should the interactive help text be updated to match?
Looking at tools/bpf/bpftool/btf.c:do_help(), it still shows:

    "       " HELP_SPEC_OPTIONS " |\n"
    "                    {-B|--base-btf} }\n"

which lacks the documented multi-split BTF option syntax.

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901165757.8014=
49-1-alan.maguire@oracle.com?part=3D10
