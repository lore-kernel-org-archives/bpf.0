Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6990F3F2113
	for <bpf@vger.kernel.org>; Wed,  8 Jul 2026 21:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783545053; cv=none; b=CMZZZMvb3aB7/caqUIzkl3xLawgSXAan+uaU/pm/qQ2smToy/ThFHooYlnxS+rDsonOJZnOTRpv/PMsO3qmmoe65Z0ASrynqrp6Z2SuIn54n8ZblHhXFPyZwWZRuP0WQF/wFL7hTtNNFMUnnykTp4+MENVse60zQfv/kri3lDS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783545053; c=relaxed/simple;
	bh=3oPHlBX4SVL5u7NrdgNN9fU5nz6clVL51XQ01RdW6ts=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=okjw4X79De3ux9fBiRyUzykrMdWaN+DEqhNXfZbFmFHNb6C6zFI9vAcm9zFGjPRjkbeINlAMJoZ8tOatubN5nLSCi0YkhoLBEwExNkJLThYwVeH1VCa07bNZAZ7SPRhR6M565VV7gkLCwfxXlYlj/zbfzqZVy9duA6w9HNTrmAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eFMxo+4E; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eFMxo+4E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9A3E1F00A3A;
	Wed,  8 Jul 2026 21:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783545052;
	bh=Yk75JAjxZLq0NJQJ/N18GYnZhaLJtIT6I6rOheCP2Ok=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=eFMxo+4ESRRocv1sbZqViTJTHHYuBXuveJXxJWx9uRnNiATzLzJ3/QGPJChP9vdLt
	 GkQjGFBhEkSRF5YPPElj/ZzzENWloX6v+bzmZqgy3qs15KHzXsRMmF/oqAZc8Bw7Wk
	 eKyTTBkXgk30lgSJ+2htBnnaAFT5gh0OEDJo3D8S/tBTgxe3NWjsketVvs0vSita4f
	 itvGh99wL0GP9gPQo9VdVBpZKQFA4HdO8wF9xeAr/hDW23KL3KWevxV8G/16xl7bAZ
	 fdEnIgs3pKbdfcJQBB2tBzqL5s3a2GeH1RmEMgceVsi+U/quMoDxz1VhfHXa2zwYEU
	 BBzwLTkVaFIBg==
Content-Type: multipart/mixed; boundary="===============4641891099166004605=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <e5297dafc4eb3f8cdab74a9fbdb5234a15fa5dd385228cd696a05067b5d42627@mail.kernel.org>
In-Reply-To: <20260708201010.2158718-1-yonghong.song@linux.dev>
References: <20260708201010.2158718-1-yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next 06/12] bpf: Force JIT for programs using the R0:R2 register pair
From: bot+bpf-ci@kernel.org
To: yonghong.song@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,kernel-team@fb.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed,  8 Jul 2026 21:10:51 +0000 (UTC)

--===============4641891099166004605==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

>     bpf: Force JIT for programs using the R0:R2 register pair
>
>     The R0:R2 return convention introduced in this series is only implemented
>     in the JIT. The BPF interpreter has no notion of a second return register,
>     so a program relying on the R0:R2 convention would compute wrong results
>     under the interpreter. Force the JIT when bpf_prog_aux->ret_reg_pair is
>     set.
>
>     Signed-off-by: Yonghong Song <yonghong.song@linux.dev>

This looks like a bug fix for the R0:R2 return convention, where the
verifier accepted such programs without gating them to JIT-only.  The
bpf_ret_reg_pair() support that introduced this was added earlier in the
series.  Should this include:

  Fixes: ec219322a9a7 ("bpf: Add verifier support for 16-byte returns in R0:R2")


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/28973410219
--===============4641891099166004605==--
