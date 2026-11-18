Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795022201;
	b=rB0vMCnUqUt5g35iMzgyTL0xlB/UADqUFx473laLZM0MAVs9fxSiWDdD4Sx99M+gXy9c
	 SE6WjnzuNmOC90mgPrGMTdnwBSejMtzwpCTJi1b98/9s/0bKgci6Y9c6yY8QC225cQTpp
	 U45ieikCIkIt/lVydzA4CPQ0GZ36BWIIJ2Ygf/w+snE+hDKhTUeHywrDf2d9rcShgxAZZ
	 faLg5NeS2KjLW9yX3TmgOo8a6htSuijzHQcV2Pbkd4FCC6Cxs0algFXdXYLAxuB5TWbWh
	 cLx3MRk/cu/+iHAFfo+FHPlp5E4E/iqxJYmRxYKe8XB6ON2h/H0GJUctLVxYnVQciPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795022201;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=ONsjF+Nl+WPg5Kxue78E71bYJpf+UwEP4hGrwnoQqN8=;
	b=OUX7qU3R8GJEzeq1cfVWkJ/CVmKFy6XrcAz5obnswQI2TU4aTza1Bat28eraE5eqRB3W
	 b53vE4FmJS0eaHr5FnJ+DH31U61BaKhmtz+UcWFqRi1yrOEz5BFvFY5DJG4Mzz7UPSs4n
	 5oKO4eDG5TW43CKdnbkTaAoQXHuLCasTk2GI2ZCDF6ex/r//ySzWhDM4Ahtvqs92ejNiV
	 nGoY9VVmwf173WFEV9b2ueDKQB97sv14aakXnOzfMqou3HPYFtMRYICokR8hnulerfdQM
	 u77KL6hTNa/lbS/pqhSWhAWJUXVuxOKsTRl+24Uh0SjAbreQ7mEZT6TSKx1vqT/0snQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HoFRpB79;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42AC5606A320
	for <bpf@vger.kernel.org>; Wed, 18 Nov 2026 17:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HoFRpB79
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FEF21F000C5;
	Wed, 18 Nov 2026 17:16:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795022201;
	bh=ONsjF+Nl+WPg5Kxue78E71bYJpf+UwEP4hGrwnoQqN8=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=HoFRpB79xQZQNGkvyfJhoA2Zn3ILMUxVU/B2yLCsOt1snpP5BY0FNtLwSR/toTzcb
	 7nKC4ExqPu7JNbeIW19cDRrBsCxqn7jgWz//5oIIXcEVQewS+OhgKPY8t9kUmGSQ9i
	 o0ohQFEtQbOb9hMhsQ6j1vZxhFjW2OrGSLxQD5wQIMcwx4jwFJYD+RFZeKyry4iW/x
	 Eyac+OGbIJ2NgDe8Nd0o+GEwLy2w3D0FOuPkNhO2TLekM7pQ10l8DWcbXDXKNmFy7A
	 RavIShyhYyRYSqES7BOB/pQuAUXSxGiknKfwCR4vlG3//FGYLW+7u6SIjXN6kgJ3yB
	 I7SEoZrFkBM8g==
Content-Type: multipart/mixed; boundary="===============0425932577875428800=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <30018ce1534a86b38ae90c97ca5b28408f5d0d7d6fd873f3c8830ede3baf92c3@mail.kernel.org>
In-Reply-To: <20261118162108.178069-1-shlomojune6@gmail.com>
References: <20261118162108.178069-1-shlomojune6@gmail.com>
Subject: Re: [PATCH bpf-next v4] bpf: Check variable-offset accesses against special fields
From: bot+bpf-ci@kernel.org
To: shlomojune6@gmail.com,ast@kernel.org,daniel@iogearbox.net
Cc: andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,broonie@kernel.org,bpf@vger.kernel.org,shlomojune6@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Wed, 18 Nov 2026 17:16:39 +0000 (UTC)

--===============0425932577875428800==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Check variable-offset accesses against special fields

TL;DR: Commit message only: it cites ___mark_reg_known(), which doesn't exist
in this tree. The review asks whether __mark_reg_known() or
scalar_step_reset() was meant. No code issues raised.

>     bpf: Check variable-offset accesses against special fields
>
>     btf_struct_access() rejects direct access to special fields (kptr, ...)
>     of program allocated objects, but for a variable offset it only checks
>     the access at min_off.  This is enough for compiler generated BTF where
>     members don't overlap, but btf_struct_check_meta() allows overlapping
>     members in hand-written BTF:
>       struct node {
>               int arr[4];             /* offset 0, size 16 */
>               struct foo __kptr *p;   /* offset 8 */
>       };
>     A 4-byte store to arr[i] passes the check at offset 0 and overwrites
>     p at run time for i == 2 or 3; bpf_obj_free_fields() then frees the
>     corrupted pointer.
>     btf_record_first_field() returns the first field that ends after
>     min_off: it is where the check has to start, not where it can end:
>     every field up to max_off + size can be reached.  Check the offsets the
>     register can really take, min_off + k * step.  No separate constant
>     offset path is needed: reg->step is never 0 (___mark_reg_known() sets
>     it to 1), so a constant offset is k == 0.
>     Verified with hand-written BTF: a variable-offset store to arr[i] is
>     now rejected with "direct access to kptr is disallowed".
>     Fixes: 89e72f81a455 ("bpf: Varying offset access support for PTR_TO_BTF_ID pointers")
>     Link: https://lore.kernel.org/bpf/20261109094723.14614-1-shlomojune6@gmail.com/
>     Link: https://lore.kernel.org/all/avzIz70qnJIA2t3x@sirena.org.uk/
>     Signed-off-by: Shihuang Liu <shlomojune6@gmail.com>

The commit message says "reg->step is never 0 (___mark_reg_known() sets it
to 1)", but there is no ___mark_reg_known() in this tree.  Is this meant to
be __mark_reg_known()?

The step is set to 1 by scalar_step_reset(), which scalar_set_const() calls,
and scalar_set_const() is called from __mark_reg_known():

  static void __mark_reg_known(struct bpf_reg_state *reg, u64 imm)
  {
  	...
  	scalar_set_const(scalar_of(reg), imm);
  }

  static void scalar_step_reset(struct scalar *s)
  {
  	s->base = 0;
  	s->step = 1;
  }

Could the changelog name __mark_reg_known()/scalar_step_reset() instead?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/44351194274
--===============0425932577875428800==--
