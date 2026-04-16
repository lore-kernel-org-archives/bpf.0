Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B3E641C72
	for <bpf@vger.kernel.org>; Thu, 16 Apr 2026 20:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776371534; cv=none; b=eobdX1ofsSOEFvcFuMwQN3SztVrFbuVxXSQPJQ1OHZwyA6/xO7ai7gQZZke3hcmwYofnTRXoyw9dl6Oky5q8hWF/IMoQCqdY/gzC8LCrp5cWu4E7nGqKnqCRay1Ta/tLrnhRtAKRqbsGbQpdRatzwFUbu1bn4Mx3uFh3DxPnVXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776371534; c=relaxed/simple;
	bh=p0hSPEgHLLS6gRfA/fYkshYSR+pxd02U49lURAvj7ZA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uiUZHinQZuqIi6G0OT+7tButmVra9/4BNEqXlACAM0t33uoRKkgKAFWAu7TnCdG89JT/b9Air/6GqKekZD/VV82pznS6yo+CcEqYh44630rvVxP+QaO9MVlY+vrPgXi01CUZc7cZb7Ult5yLfVf4YusYm+70Wi2Rx0YQYlUTOw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZGWdVFT0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZGWdVFT0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D04CCC2BCAF;
	Thu, 16 Apr 2026 20:32:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776371533;
	bh=p0hSPEgHLLS6gRfA/fYkshYSR+pxd02U49lURAvj7ZA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=ZGWdVFT0yfnyqncz2CrDbSlV4+QKOGxyjoizsZosxF8Yyxp5BGA2ai04kBPiq2Flu
	 QuiFimSsdN+VdBmCttbS3Hs/bGD8DU5w499HILQKDOqmPC7r0GWQiuZDRpMvO+43Bc
	 Zx2wLWV8iLk9W4mVpXl/HxDb9rTIwEUYECLJsD6iaV6maKY7f07GhyQsrMYcF8OxUj
	 jjyHXso29QdT4j2KkNMIMfTBk+dCna9lQ6Ja/Lh0vxyIrGokddFxjP9cx/GetkmRjB
	 aW8RN5Guj7suRTuRdI2Xe/51/1cnfORAZjM/06Ss2P1+pxlRg5qKjOiufHXV4UC2UM
	 qBO4+ux7XpFJw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 bpf-next 7/8] selftests/bpf: Fix up __u16 vlen
 assumptions
Reply-To: sashiko@lists.linux.dev
To: "Alan Maguire" <alan.maguire@oracle.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260416143904.1220662-8-alan.maguire@oracle.com>
References: <20260416143904.1220662-8-alan.maguire@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Apr 2026 20:32:13 +0000
Message-Id: <20260416203213.D04CCC2BCAF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Sashiko AI review found 1 potential issue(s):
- [Medium] The patch fails to fix the 16-bit assumption for `vlen` in `tool=
s/testing/selftests/bpf/prog_tests/ctx_rewrite.c`.
--

commit 033bc70f770dbba15f69901f422f7378dd7cd70e
Author: Alan Maguire <alan.maguire@oracle.com>

selftests/bpf: Fix up __u16 vlen assumptions

Fix up a few cases where we assume vlen is 16 bits.

Signed-off-by: Alan Maguire <alan.maguire@oracle.com>

> diff --git a/tools/testing/selftests/bpf/prog_tests/btf.c b/tools/testing=
/selftests/bpf/prog_tests/btf.c
> index 0cc347e32db37..a9de328a86976 100644
> --- a/tools/testing/selftests/bpf/prog_tests/btf.c
> +++ b/tools/testing/selftests/bpf/prog_tests/btf.c
> @@ -8092,7 +8092,7 @@ static struct btf_dedup_test dedup_tests[] =3D {
>  static int btf_type_size(const struct btf_type *t)
>  {
>  	int base_size =3D sizeof(struct btf_type);
> -	__u16 vlen =3D BTF_INFO_VLEN(t->info);
> +	__u32 vlen =3D BTF_INFO_VLEN(t->info);
>  	__u16 kind =3D BTF_INFO_KIND(t->info);

Does tools/testing/selftests/bpf/prog_tests/ctx_rewrite.c also need to be
updated to handle 24-bit vlen values?

Looking at find_field_offset_aux(), mnum is still declared as __u16 and
assigned the result of btf_vlen():

tools/testing/selftests/bpf/prog_tests/ctx_rewrite.c:find_field_offset_aux(=
) {
	const struct btf_type *type =3D btf__type_by_id(btf, btf_id);
	const struct btf_member *m;
	__u16 mnum;
	int i;
	...
	m =3D btf_members(type);
	mnum =3D btf_vlen(type);

	for (i =3D 0; i < mnum; ++i, ++m) {
	...
}

If a structure or union has more than 65,535 members, could mnum be
truncated here, causing the loop to terminate prematurely and failing to
resolve field offsets?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260416143904.1220=
662-1-alan.maguire@oracle.com?part=3D7
