Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0EA54D2EF8
	for <bpf@vger.kernel.org>; Wed,  7 Oct 2026 18:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791397082; cv=none; b=tnd5h+P1QCnHEGoCj6faHXoWZCwmKi5IS+WBNyQlg/qOwlWXlOaPFLU63rKKaCXYMJbLSFTfQMM7yZPO6oPH5nhpXYyhGVYUUrGM8apQrXqzwY6nXfFORUHY0SAoQ6kKFRoShUTg8q0nztREMV/Nv7wZSqXOCUSeh5SuP6c5oV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791397082; c=relaxed/simple;
	bh=K7O5KC5ZqSVlVa0JnTBzUfjWrC0WkdpOrWeLbRn46fQ=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=TVOLcmfyPXJRdym287n02HNaDbh3+ixy3QDXrkU9HY+oybfJmhvhxVOenWEE/LLDGrJlJKOCfR3r0VqFDhvTj/bA6VMyt50mWFDGXZBM+xdJq3OFGM3aEe+xyCRwSAPA/YxLRqMB8L3VTUx87PRyyz07ArblydrpPVm6na2AMqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GyCqjOBZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GyCqjOBZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36C4D1F000FF;
	Wed,  7 Oct 2026 18:18:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791397081;
	bh=/bmMd2z0xNLwKRUGiy6R0WcU9AncpQTQwKMYiJmHku8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GyCqjOBZJOVWbmOyRVI163YnhfHnLjxdZ/XYjuj7rSrCWyCvdtLWv+0XZt5pjSV32
	 s6Ikwwcjcq+i3dq0HsAcBQmkE303qdOvSBWMYr/9uocq7MGX2iCTLOuxqeHPE68TMF
	 PpTdeRbgpHZGCVmmkiLEdtnXMvxp7Gm1GuwF5Pk+ggjGKIIfpeJvPQWEGPKwk1hMdZ
	 kjB+BSPAiS4Xmz7IbNH64hjAJgWdq3pHqFeY6SvF2bSKJJxMP+h/0SL43E7YS87LTa
	 fsROrO/l7q0hwUCrbvLFeMR03eSrddRXRUn319vVuQKmZD4Gk+SB+4zdxSzwzBBNgl
	 n9BWD/c9jNcXg==
Message-ID: <sashiko-outbox-163281@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf 2/2] selftests/bpf: Cover test_run csum validation
 after bpf_skb_change_tail()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Maxim Skokov" <skokovmaksimevg@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261007181249.352831-3-skokovmaksimevg@gmail.com>
References: <20261007181249.352831-1-skokovmaksimevg@gmail.com>
 <20261007181249.352831-3-skokovmaksimevg@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 07 Oct 2026 18:18:00 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] bpf: multi-line comments do not follow the preferred BPF style
--

commit 5ce414e78d4de76ae6dba0dcb75c0182e95cd2d2
Author: Maxim Skokov <skokovmaksimevg@gmail.com>

selftests/bpf: Cover test_run csum validation after bpf_skb_change_tail()

This commit adds BPF_F_TEST_SKB_CHECKSUM_COMPLETE tests for tc programs
that modify the skb using bpf_skb_change_tail(), moving it out of
CHECKSUM_COMPLETE. It verifies that csum validation still correctly spots
invalid checksums.

> diff --git a/tools/testing/selftests/bpf/progs/skb_csum_complete.c b/tool=
s/testing/selftests/bpf/progs/skb_csum_complete.c
> new file mode 100644
> index 0000000000000..8e8d53530899a
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/skb_csum_complete.c
> @@ -0,0 +1,44 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <vmlinux.h>
> +#include <bpf/bpf_helpers.h>
> +
> +SEC("tc")
> +int change_tail_trim(struct __sk_buff *skb)
> +{
> +	/* Drops CHECKSUM_COMPLETE. skb->csum still covers the trimmed bytes,
> +	 * which hold the non-zero tcp.urg_ptr of pkt_v4, so it no longer
> +	 * matches the packet.
> +	 */

[Severity: Low]
This isn't a bug, but does this multi-line comment follow the preferred BPF
subsystem style? The global guidelines mandate that multi-line comments in =
BPF
files should have the opening '/*' on its own line, with the comment text
starting on the next line.

> +	if (bpf_skb_change_tail(skb, skb->len - 4, 0))
> +		return 1;
> +	return 0;
> +}
> +
> +SEC("tc")
> +int change_tail_grow_write(struct __sk_buff *skb)
> +{
> +	__u8 val =3D 0xab;
> +
> +	/* Drops CHECKSUM_COMPLETE. The new bytes are zero and do not change
> +	 * the sum, but the write below can no longer update skb->csum.
> +	 */

[Severity: Low]
This isn't a bug, but similar to the previous comment, shouldn't the opening
'/*' be on its own line to match the required kernel comment style for BPF
files?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261007181249.3528=
31-1-skokovmaksimevg@gmail.com?part=3D2
