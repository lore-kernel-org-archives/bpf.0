Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50AFF30DD2A
	for <bpf@vger.kernel.org>; Wed, 27 May 2026 08:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779871815; cv=none; b=kkYI/NfbdLojPT6oBX7P438OazDDabmBcWWZoDDhWs+zlXHbc4bgxXu3fLWaqCcV7VnPyGjc5qLignFgStuttiUAkIzaCKHTOP82nAgXcdc3ltPawypzHS1GkYnf6EFz/vULaKF+tttc94I9Bq38c5V/LTqzElf2txgD2gSgTuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779871815; c=relaxed/simple;
	bh=LA9uv/m4NyyMqpcLnGdcUMDBzhfe9z2Xtl+Lvh00W7M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OR56xaMPaRjDHakv2L/HVeybVhzx6VSsyE8EXChmrYH5K0qT2MrYDFiH3SzaZLvzLInlElZNRUeiNP0VmFf6lVia3tIL6Ky9MvVVsFrsXM3guLSpxw1w6n2heBfKxyfcACxytTgVDDgdCmYP1iuPCT/IxYFRrLtdDkfvq6Q9FjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jCjIsdLY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jCjIsdLY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0DD21F00A3A;
	Wed, 27 May 2026 08:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779871813;
	bh=neza1uTcKNBDxaMuvM9JJfdxSvhB89MB/ejXGqqTXW4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jCjIsdLY1SbB4CL+BRcI9907SJgWGfFKmI0N2298ANjupQD9EC4q5+NnXTCfz2dgP
	 7xR/6UcIW4JriPgeBek5jaT7EKEtgg19lNM73vtVjDd3Q/beLVmL0KdbEkjX9BzcC+
	 gkzqFnuafQ1TZlxSCMWFI1xM0KVCd6l6fMKrncqe5gcpXvvxyG1Tpdy+gpJS9qh6LE
	 SSZu+mwD+OXgnNRtsZHivzDScFApMlCcMtRxCw3wsUKjEDv57ySfKGR8O2ekkur6mb
	 5fx/nJzUxjNnnsawhqUF6kQQnrSVO1eqhVuA8c0VyO7+GWchrDJ+f/LESeBWGrvsvI
	 bonENAO62Wrzg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC bpf-next v3 3/6] selftests/bpf: test cases for loop
 hierarchy computation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Eduard Zingerman" <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260527-better-1m-reporting-v3-3-b3ede0588a75@gmail.com>
References: <20260527-better-1m-reporting-v3-3-b3ede0588a75@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 27 May 2026 08:50:13 +0000
Message-Id: <20260527085013.D0DD21F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The commit message omits the test case for irreducible loops (Case =
E), which is implemented in the patch.
--

commit 0c9a2a0bab3cd380638bc61a05140fb934767741
Author: Eduard Zingerman <eddyz87@gmail.com>

selftests/bpf: test cases for loop hierarchy computation

This commit adds test cases for loop hierarchy computation to the BPF
selftests. It covers various branches in bpf_compute_loops() to ensure
correct handling of single, nested, independent, and irreducible loops.

> Test cases covering the following branches in bpf_compute_loops():
> - Case B: simple backedge creating a loop (loop_single)
> - Case B: two independent loops (loop_two_independent)
> - Case B + D: nested loops where inner header's loop_header points to
>   outer (loop_nested)
> - Case C: diamond CFG with no loops (fwd_edges_no_loop)
> - Case D: sibling inner loops within one outer loop
>   (loop_nested_siblings)
> - Three levels of loop nesting (loop_three_levels)
> - Loop with if-else body containing forward branches
>   (loop_with_if_else)

[Severity: Low]
This isn't a bug, but could the commit message also mention the test case
for irreducible loops? The patch includes the implementation for
loop_irreducible() (Case E) in the code, but it appears to be omitted from
this list.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260527-better-1m-=
reporting-v3-0-b3ede0588a75@gmail.com?part=3D3
