Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E282479861
	for <bpf@vger.kernel.org>; Wed, 26 Aug 2026 19:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787772331; cv=none; b=pd2IfqPmrOLROyjB94Ed8wmqoFVfJjLAYF5o2A+G5swdXyB77ZJn50h2l4LKUKZPYCgdAoIXhtx5IKF7d4NYWdxhoq6LNebTexzeKpFQKpaq1wvsaatk4ItyTTCBm2PNslt2IoDk7j3FUIC9a3PROxBzMi1Rop9pRy2RhfzBDH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787772331; c=relaxed/simple;
	bh=Pmq3QY0LMPgdqFQAT1k2TIEv06VyhBbeCNmyuHMRrkY=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=p1NF6WOMlOeuMeB0kv21tiR/zsIpmeNnhVqOnhX0spQcWfb2VXMqL2V0wMNxWJ5mEN7z8rs+IVg0ZTkC6tm1fbXSJtEvTVDK0zk14XpDAwAkX3ve8SkoF77Z+DFWVVwpA60EyfK0YLHt90LZ51dqRP12yNMfcu2GBUO5LQITACo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ANnTNHpS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ANnTNHpS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F83D1F00A3A;
	Wed, 26 Aug 2026 19:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787772320;
	bh=UEkoA788le27sVRL3kYHmeX98dsVW8RVGleMlElqHQc=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=ANnTNHpSEkhsqeBbRt38zUwg2XxINHfnnjPY3DUfB9rTjH/sL7YoYFeViL4NgZQTk
	 p4n2LXjLF53ehTNw4lUXq/iadkerrxTDVYJsoBxjBly8tlu5r2q7U/glLBX/HzTWOa
	 OLvctCjJwWu7cKohHYPwJI9PmniDrSa+J4qrpG+njGAXOiD0CcW6DMd11qOkj2QvtR
	 BtRLch9mNptrlvAso6ha7+ARVlzRnAWApuYCXYhb7VdciA+2zTvkcm07U0hQ8/wexl
	 cEhNdsTW9BFheHpaD2Eh6RFmef/TRxzC7owjVXbDV+FHlEb/aInU/l9vTtMkveqnaL
	 VaJI/j34sriUA==
Content-Type: multipart/mixed; boundary="===============5880712521898997828=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <6f12ee293cd4c254cdc9f2bb268626e76199d2e1a1f9f9246bde02bafcc992ff@mail.kernel.org>
In-Reply-To: <20260826181825.1826541-2-andrey.grodzovsky@crowdstrike.com>
References: <20260826181825.1826541-2-andrey.grodzovsky@crowdstrike.com>
Subject: Re: [PATCH bpf-next v2 1/5] libbpf: BPF program load type enum
From: bot+bpf-ci@kernel.org
To: andrey.grodzovsky@crowdstrike.com,bpf@vger.kernel.org,andrii@kernel.org
Cc: martin.kelly@crowdstrike.com,slava.imameev@crowdstrike.com,linux-open-source@crowdstrike.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed, 26 Aug 2026 19:25:20 +0000 (UTC)

--===============5880712521898997828==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index b749c01742ee0..821d854d43a9f 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c

[ ... ]

> @@ -15221,3 +15219,17 @@ void bpf_object__destroy_skeleton(struct bpf_object_skeleton *s)
>  	free(s->progs);
>  	free(s);
>  }
> +
> +int bpf_program__set_load_type(struct bpf_program *prog, enum bpf_prog_load_type type)
> +{
> +	if (prog->obj->state >= OBJ_LOADED)
> +		return libbpf_err(-EINVAL);
> +
> +	prog->load_type = type;
> +	return 0;
> +}
> +
> +enum bpf_prog_load_type bpf_program__load_type(const struct bpf_program *prog)
> +{
> +	return prog->load_type;
> +}

The new exported setter stores type without validating that it is one of
the two values enum bpf_prog_load_type defines. After this patch, the code
that checks whether to apply relocations tests load_type !=
BPF_PROG_LOAD_TYPE_DISABLED in multiple places:

  obj_needs_vmlinux_btf()
  bpf_object__relocate_core()
  bpf_object__relocate() [both call and data relocation sections]

while the code that actually loads the program tests load_type !=
BPF_PROG_LOAD_TYPE_AUTO:

  bpf_object__load_progs()
  bpf_object__attach_skeleton()

The previous bool autoload field made an out-of-domain value impossible, so
all sites agreed by construction. After this patch,
bpf_program__set_load_type(prog, 2) returns 0 and produces a state the two
halves of libbpf disagree about: vmlinux BTF is loaded and CO-RE, call, and
data relocations are applied for the program, but bpf_object__load_progs()
silently skips it (prog->fd stays -1) and bpf_object__attach_skeleton()
silently skips it too. The application gets no error from any libbpf call -
bpf_object__load() returns success - and cannot recover the state through
the bool API, since bpf_program__autoload() reports false while
bpf_program__load_type() reports the bogus value.

This is reachable from outside the tree because the symbol is exported in
this same commit (libbpf.map LIBBPF_1.8.0) with a two-value enum, and value
2 (BPF_PROG_LOAD_TYPE_DYNAMIC) is added later in the same dev cycle without
an ABI version bump, so an application built against the newer header links
successfully against a library built at this commit and gets a silently
half-prepared program instead of an error.

I see that commit 677f95c8adc5274970774bb635eca58cda6397dc later in the
series adds "default: return libbpf_err(-EINVAL);" to the switch in the
converted bpf_program__set_autoload(), which would fix this. Could that
validation be added here in the initial setter?

> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> index b965ad5715403..700634664e326 100644
> --- a/tools/lib/bpf/libbpf.h
> +++ b/tools/lib/bpf/libbpf.h
> @@ -2078,6 +2078,21 @@ LIBBPF_API int libbpf_unregister_prog_handler(int handler_id);
>   */
>  LIBBPF_API int bpf_program__clone(struct bpf_program *prog, const struct bpf_prog_load_opts *opts);
>
> +/**
> + * The program load type:
> + *
> + * - BPF_PROG_LOAD_TYPE_DISABLED: the program is not loaded.
> + * - BPF_PROG_LOAD_TYPE_AUTO: the program is autoloaded when the bpf_object is loaded.
> + */
> +enum bpf_prog_load_type {
> +	BPF_PROG_LOAD_TYPE_DISABLED = 0,
> +	BPF_PROG_LOAD_TYPE_AUTO,
> +};
> +
> +LIBBPF_API int bpf_program__set_load_type(struct bpf_program *prog,
> +					  enum bpf_prog_load_type loadtype);
> +LIBBPF_API enum bpf_prog_load_type bpf_program__load_type(const struct bpf_program *prog);
> +
>  #ifdef __cplusplus
>  } /* extern "C" */
>  #endif

Two new LIBBPF_API symbols are being added with no API documentation. The
comment block uses the doxygen marker /** without the required directives.
Documentation/bpf/libbpf/libbpf_naming_convention.rst states that API
documentation must start with @brief and include @param for each parameter
and @return for non-void returns. The immediately preceding declaration,
bpf_program__clone(), follows this convention.

The missing documentation matters for behaviour a caller cannot infer:
bpf_program__set_load_type() returns -EINVAL once obj->state >= OBJ_LOADED,
and bpf_program__load_type() has no way to report an error. There is also a
small parameter-name mismatch: the declaration names the argument loadtype
while the definition in libbpf.c names it type.

I see that commit 677f95c8adc5274970774bb635eca58cda6397dc changes the
block's marker from /** to /* (acknowledging it is not a doxygen API
comment) and relocates the enum, but the two new functions remain
undocumented there as well. Could API documentation be added for these new
exported functions?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/33000627295
--===============5880712521898997828==--
