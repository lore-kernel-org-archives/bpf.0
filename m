Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63145406286;
	Tue, 26 May 2026 14:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779807280; cv=none; b=Kt1W+Z5nEXm+kjOsj20CmimOZC5r35OEa/nqpZWrG0Ikt2+6IKeTqfnbg4wzNOL1FrxLwoYnPeTWOVBxNkTw19PxixZF40set2BYNTVNgDy4Z9eCqP9JKydgJ2y0QDBwAcaheVM6BiyLbu6J+58351ZOHEFXYTYGVFLhiHfW0hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779807280; c=relaxed/simple;
	bh=iOfju0tNISwD7QsRNb9KsimWpA8sFI6Ylk2S4DAwBCY=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=jftGZGO4sGH1uEuodLGLnZCaFyeOrmhW33k1qD2vPEnPnP9i+rIVXpb7wyOcrTdhmfD4JFVuh7cZ5rPJPDOD0ErTPLXOjcJ+MAoPa6hwo4otSZWn0y3SKKpTbAYaXK9vS1ZADsrlB5767GFjxcvjTDHSKCBbPOq/b/KELKXSEcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gto0/Fxe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gto0/Fxe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7D0D1F00A3E;
	Tue, 26 May 2026 14:54:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779807279;
	bh=9nxc+iOwDFh1mL+ufQGIFXe/VMPJgIJDfFxoy6HwRFo=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=gto0/FxedNAY6ID6chDwIhg6BDehv8h3OUlQOnivWwyM37G6eitwWl7FBp31kqu0Z
	 Mf/ForSN0sUX2Oa/OhS2K4loMfVq7H4jAbHzy06gesrykn+bn3UAiO7Cetqkj997SS
	 WAKchOIRLx3sFCnxumgHFwz8bDlrSPMBE28CNVm4kXlr4lpc5PKrK2gKRHUm77V9wj
	 siOIjo7fP1mNF6cZJtOHF7DisxQRjB+U/TWl47RR3z+q54nElfNAQ8q08t+hbm0edF
	 G/D56YDJrz1ysTqAa7dJCwftWNUq+dlUgkrRJV/5ypMVa3DJw339Kg9iOnr7WTa7BA
	 WhWax0LdtERzA==
Content-Type: multipart/mixed; boundary="===============0171208587434760181=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <987a8838c1a618a27d5535316ef40ccb7a8d134c715cf85a284bd0d74f8ec935@mail.kernel.org>
In-Reply-To: <20260526-libbpf-load-vmlinux-btf-in-gen_loader-mode-v3-2-5b4fa2a5e1a4@google.com>
References: <20260526-libbpf-load-vmlinux-btf-in-gen_loader-mode-v3-2-5b4fa2a5e1a4@google.com>
Subject: Re: [PATCH v3 2/3] libbpf: zero out btf_key_type_id for STRUCT_OPS maps
From: bot+bpf-ci@kernel.org
To: sidnayyar@google.com,andrii@kernel.org,eddyz87@gmail.com,ast@kernel.org,daniel@iogearbox.net,martin.lau@linux.dev,memxor@gmail.com,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org
Cc: bpf@vger.kernel.org,linux-kernel@vger.kernel.org,gprocida@google.com,maennich@google.com,sidnayyar@google.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue, 26 May 2026 14:54:38 +0000 (UTC)

--===============0171208587434760181==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> commit df12a01912b915400d5eedf67067cd516e5d81eb
> Author: Siddharth Nayyar <sidnayyar@google.com>
>
>     libbpf: zero out btf_key_type_id for STRUCT_OPS maps
>
>     For BPF `STRUCT_OPS` maps (such as `sched_ext_ops` maps), the kernel BPF
>     subsystem enforces strict map-creation safety validations inside
>     `map_create()`.  That is, if `btf_vmlinux_value_type_id` is set, the
>     kernel forbids passing any userspace `btf_key_type_id` or
>     `btf_value_type_id` (they must both be `0`).
>
>     However, inside libbpf's map-creation options initialization
>     (`bpf_object__create_map()`), libbpf zeroed out
>     `create_attr.btf_value_type_id` but does not zero out
>     `create_attr.btf_key_type_id`.
>
>     Fix this by explicitly zeroing out `create_attr.btf_key_type_id`.
>
>     Signed-off-by: Siddharth Nayyar <sidnayyar@google.com>

This looks like a bug fix for STRUCT_OPS map creation support. The bug
was introduced in commit f1eeafaa2798 which added the STRUCT_OPS case in
bpf_object__create_map() that only zeroed out btf_value_type_id but
forgot to also zero out btf_key_type_id. This causes kernel validation
to fail for STRUCT_OPS maps.

Should this include:

  Fixes: f1eeafaa2798 ("adding ci files")


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/26454419965
--===============0171208587434760181==--
