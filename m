Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E6936607D;
	Mon, 22 Jun 2026 23:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782172097; cv=none; b=F6SYOR/gkaUjgD20R2mjWVMC8ciHseFP/VatULOOHljgKI/yEu/chotM76FZ8n/ILdR7/mLdUlR+qymMfM+3S76ggh26FcIOr+hxHhyjavex7cjLFuB94vNn8yOcPuFZ9v8pcFcPhj5C5zVd+2+9doWYeI6d/P7CXon+qikfmbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782172097; c=relaxed/simple;
	bh=zTzJcEORpcJyYdH00eo3AnBIwyCQWE2aocmOnvKbCbY=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=U8JU9I3rOzKcwNZruW8dPJmCfsq4zVTB3v8+sGypR+jFiZmVHuyzOyRymvFQ24pDiNd3ityS/i4W0+/Cv5KNRLdiWjLUULp14zu5l/m9Toc7skPMFGdKFv916FmQYGi+QT52IbMfr6DNVD483Fyaj8dkGTBq8FKL4ewZgStfWWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ux0xLAzM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ux0xLAzM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF5031F000E9;
	Mon, 22 Jun 2026 23:48:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782172096;
	bh=HkCz+sJFBpHJg59S3eBW56HO/cAnCFWCbk+H2kKCpbA=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=Ux0xLAzM2ul7+scQG7XGbuWeAzw8vNrHlxD55jnRNaO3ndujio4FssyqPR5GeTfRa
	 R9VwB0KkssbZuQdQHaI5ApsqRJ1hV9U0SKU53jh0dU2me763lGM6VFyGCUmxbvZXCX
	 zoKw4ZiYsCkOovdPLDgmYTh6a28XgftQ8dQ5bl02vqIRDnVlp+KOmI/2XUiMDUl5dN
	 0Zt67Q1USrOs3xnadVK4N2GQjQXT0Zpm+Y38Or+OoXMkhb12E9RUmpny7v2UiaPiSA
	 0jW0i+9NI6X0Mi5z/7rTMqikhkI4ksRJz6bAwCl2loX1wYf5w/m0Bi8kYpBAQfeO8t
	 4EIhFnVW3xesA==
Content-Type: multipart/mixed; boundary="===============6805690872853308917=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <a657c2499fb6cfdeb773915eadb2ff8f70abc04e6418485f0579b9ec6da9a9fb@mail.kernel.org>
In-Reply-To: <20260622-bpf-lskel-fixes-2-v1-1-004d72cba5c2@google.com>
References: <20260622-bpf-lskel-fixes-2-v1-1-004d72cba5c2@google.com>
Subject: Re: [PATCH] libbpf: poison unresolved weak kfuncs in light skeletons
From: bot+bpf-ci@kernel.org
To: sidnayyar@google.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com
Cc: bpf@vger.kernel.org,linux-kernel@vger.kernel.org,gprocida@google.com,maennich@google.com,ynaffit@google.com,nkapron@google.com,sidnayyar@google.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon, 22 Jun 2026 23:48:15 +0000 (UTC)

--===============6805690872853308917==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> libbpf: poison unresolved weak kfuncs in light skeletons
>
> When the light skeleton generator (gen_loader) fails to find a BTF ID
> for a weak kfunc, it correctly clears the immediate value (imm = 0) to
> convert the pseudo kfunc call into an invalid instruction.
>
> However, the generator fails to clear src_reg (which is set to
> BPF_PSEUDO_KFUNC_CALL). This leaves the instruction looking like a valid
> pseudo kfunc call with a zero BTF ID. When the target verifier's
> add_subprog_and_kfunc encounters this, it unconditionally scans all
> BPF_PSEUDO_KFUNC_CALL instructions, sees imm == 0, and panics or
> fails the load (e.g. bpf_unspec#0 or -EINVAL). This entirely breaks
> the verifier's dead-code elimination logic which expects to cleanly prune
> branches protected by bpf_ksym_exists().
>
> Furthermore, when the generator processes subsequent references to the
> same unresolved weak kfunc, it copies the imm and off fields from
> the first occurrence but skips the src_reg field, meaning subsequent
> calls also retain the poisonous BPF_PSEUDO_KFUNC_CALL flag.
>
> This patch fixes the issue by explicitly clearing src_reg for both the
> initial occurrence and all subsequent occurrences of unresolved weak
> kfuncs, converting them into standard invalid helper calls that the
> verifier's dead-code eliminator can safely recognize and discard.
>
> Signed-off-by: Siddharth Nayyar <sidnayyar@google.com>

This looks like a bug fix for the light skeleton generator. Should this
include:

  Fixes: 18f4fccbf314 ("libbpf: Update gen_loader to emit BTF_KIND_FUNC relocations")


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/27990767350
--===============6805690872853308917==--
