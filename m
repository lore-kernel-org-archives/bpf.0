Received: from mail-106119.protonmail.ch (mail-106119.protonmail.ch [79.135.106.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4C853CB918
	for <bpf@vger.kernel.org>; Thu, 30 Jul 2026 10:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785406888; cv=none; b=CC+78+EhaB/YfDLNxT+9BzHkKThTyaVWdHbt+w1vZA7CkT49FRFcP2oeTzSCAuPRUX2rsaJj8/Lacl3NEsuMYjGjr5EJrcLmsolZC4ClgJpQwlqiGC+cHVblln/A67prbukl/s0BS/hQe7AYdm5t9MD9v7g7XuqFtVJ9IktgOtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785406888; c=relaxed/simple;
	bh=a7ZV9jeFyKWn2ARkaPUvfcLR4cMRhJSdbrjzW+QDizs=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=WnCHrxedg8ISBd4tJVd4PbMipsR8ZAq9YgTsYFt4sz+DLP3fIrA87MSCDqjchjOOeISDgf5r0PyYtRSlfQcViub5Kii/ORlGiG7dftAObcuABxMe7CzQlvelNz0JDiCa6HJMS+ye26SlIfphPG5tj4taqx/dnfDVsIp3jKDwQ9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=p7BOjzTo; arc=none smtp.client-ip=79.135.106.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="p7BOjzTo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1785406877; x=1785666077;
	bh=jSAj8cLFx8oGxMGo4+7jwjYLO0k71WOFz0qHCjb6DFI=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=p7BOjzToUo1jaGP7BBt3FoTWT6MAyvVaYtNK2yrq5UxKEMTEDX88i4vkwqu/a6vS1
	 he1oz/R4o0BzD/0dxFKqduqd3xvFc/95A6e3hhRqC16YKKapGXmx1aDqKKPLsgM6dX
	 uSrImhDUq6MkGhAhJ0A/ciWcJcF6/qKYB1ItFah+iPkfGPsjvhF9PF6XUX/T5LaWwI
	 EYVa84rWW2kHK9k6VWb89rDsmyE9u6Hpj/pU4m40VVqLEB5kcky38L6J/V8xU7d6DB
	 EjT460DxcCmQlf4gXbe9FoGT2hkPY2Oc/788i6b0+z6rl8O8Fu9MAQpqDv+p0mpH6k
	 tOnDWl+5uxY9g==
Date: Thu, 30 Jul 2026 10:21:11 +0000
To: bpf@vger.kernel.org
From: Vinicius Sampaio <vldsampaio@pm.me>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, tangyazhou518@outlook.com, shenghaoyuan0928@163.com, vldsampaio@pm.me
Subject: [PATCH bpf-next v4 0/3] Simplify min()/max(), contains() and normalize() cnum implementation
Message-ID: <20260730102129.15209-1-vldsampaio@pm.me>
Feedback-ID: 138063245:user:proton
X-Pm-Message-ID: 989a68b1b8ecf06818ada1d1418a09ed036d3f36
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

This patches simplifies some functions of the cnum implementation:

- smin()/smax()
- contains()
- normalize()

---

v3 -> v4:

    - Remove the opening line of commits regarding contains() and
      normalize() simplification.

v2 -> v3:

    - Change 'optimization' to 'simplification' in commit descriptions.
    - Fix typos in commit description.
    - Make commit messages about contains() and normalize()
      simplification more descriptive.
    - Make '/*' be on its own line in {u,s}range_overflow comments.

v1 -> v2:

    - Split the contains and normalize changes into 2 patches.
    - Added comments regarding the use of empty cnum's in
      {u,s}range_overflow().
    - Fixed typing mistake in cover letter (removed the `fix` word).

v3: https://lore.kernel.org/bpf/20260730001145.381820-1-vldsampaio@pm.me/
v2: https://lore.kernel.org/bpf/20260729194932.292368-1-vldsampaio@pm.me/
v1: https://lore.kernel.org/bpf/20260728015601.1567098-1-vldsampaio@pm.me/

Vinicius Sampaio (3):
  bpf: Simplify cnum contains() by removing redundant branches
  bpf: Simplify cnum normalize() by dropping unnecessary comparisons
  bpf: Avoid redundant min()/max() in cnum signed bounds

 kernel/bpf/cnum_defs.h | 37 ++++++++++++++++++++++---------------
 1 file changed, 22 insertions(+), 15 deletions(-)

--=20
2.54.0


