Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794505703;
	b=pNCUso5aSrqIEFMUMH78/qGZNQyzN9TdnY8P0sBvK0VGmx9RwyPc5/jmd3iLwo/y1nVV
	 vH9E32ZnWA/jQyI+zZgDR8QMvEA9FratQ2Sv+H7u5lBLixjjGVfDNQd2U+uPZ2DZcSLPS
	 NzU26kfnp0rEFq9qA5ayugvYfXBgczmsZm1UawswgCZRAvyvwk0RTHqFEeYG2ONpwhzhr
	 0nHBG9R9GrKMWIUgePC11RENBcFphs7gczyNDr5UMylz+7sm/Lz5/NLTkeNVMZfYPdkpg
	 ezbQEZGT5UujeDTYILrIWkUVsF7vgXg6JsyZhBWBgnoHeYXLxvHrSEjpKmjVYYLU6Vg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794505703;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=kAB3ubZWZWKgt5W3LiAE4XpMe0vKoM0CcJK+pWNk9go=;
	b=VRLVpFj2R4Uykm7YIozKPp67Knl1JMxq97CHoYUlDLX9DWch4tNQ5zgmj3dvCx1VpKXR
	 Gu3gDtiBs7YJPe6PfyKJfw7PWY8ETpQO48Oju0SA9DISd76i31UjQ40sWhnuIsGDBU71w
	 NgfapAAo27ZUp5Ogm4RlkbcNC3ngCdWuXCO4L/DLkY3Nqx8eMhjQf6JvEqD06EOO8BaVC
	 KQSrIfHN/N015aNiEa8YIjNd6DaQ0Q9PniFlnfgoVCmjSPJOGwh9amRXDo7P++ZToQ1Vk
	 dC4JSrpLGCSo72BCpbuIIpREXlh5dhvy3utnXon1Ox7W5MD/hE8xA8oIoQSes8nU7xg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n45oqanG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0934C606A33A
	for <bpf@vger.kernel.org>; Thu, 12 Nov 2026 17:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n45oqanG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F9991F000C4;
	Thu, 12 Nov 2026 17:48:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794505702;
	bh=kAB3ubZWZWKgt5W3LiAE4XpMe0vKoM0CcJK+pWNk9go=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=n45oqanGkEp4CyzsvJH2W+3gCz9bKxLERLkwp4F3qHby4xF9S3UcfT5cxg3z+dXDN
	 p6TAAC8Ng1sbA3jn9PqfftEmhpeDh23EiyjeMhvRYHxheHZ53xS6e2EXMsvBHVLZoH
	 criL+1n/669N4IIiuNQ8P1SP9JUDr2/2ZZlC3EGyAubhvaxPcuFia9OsF37sZcg5Uw
	 CWIZzrA/w0X13dHYP7CmrRQRt1MClJLARy5ZElZAiO3l4n7UxiGWTxJkY5n2WfLh8b
	 jADuSOHw1uwDoaD1UaLXMNA0ylyj1cfqHHCILz6ibZdyQ8SuUudP4nOwBW3TekuGsm
	 VMy1Kz60SRtig==
Content-Type: multipart/mixed; boundary="===============5172542355940017295=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <248cb69597e198439cd74efffdb9ed9674a6cdab784c54182036bd759c309433@mail.kernel.org>
In-Reply-To: <20261112164610.1917256-6-alexei.starovoitov@gmail.com>
References: <20261112164610.1917256-6-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf-next 05/10] resolve_btfids: Tag the functions that return errors
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,a.s.protopopov@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Thu, 12 Nov 2026 17:48:21 +0000 (UTC)

--===============5172542355940017295==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> resolve_btfids: Tag the functions that return errors

TL;DR: In fmodret.c, errno filtering may use the build host's numbering, not
the kernel's, so on some hosts the generated bpf_fmodret_retval BTF tags could
depend on the host and drop real errors.

> diff --git a/tools/bpf/resolve_btfids/fmodret.c b/tools/bpf/resolve_btfids/fmodret.c
> new file mode 100644
> index 000000000000..89254538ec09
> --- /dev/null
> +++ b/tools/bpf/resolve_btfids/fmodret.c

[ ... ]

> +#include <errno.h>

[ ... ]

> +/*
> + * The codes of include/linux/errno.h, 512 and up, never reach user space. They,
> + * -EAGAIN, -EMSGSIZE and -EINPROGRESS tell the caller to retry, to go on or to
> + * wait, not that the function failed.
> + */
> +static bool means_failure(int error)
> +{
> +	return error > -512 && error != -EAGAIN && error != -EMSGSIZE && error != -EINPROGRESS;
> +}

Are EAGAIN, EMSGSIZE and EINPROGRESS here the values of the build host
rather than of the target kernel?

fmodret.c includes <errno.h> and resolve_btfids is a host program, so these
macros take the errno numbering of the host architecture.  The constants
being filtered come from x86-64 or arm64 kernel code, which uses the
asm-generic numbering: EAGAIN 11, EMSGSIZE 90, EINPROGRESS 115.

If the kernel is cross-built on a host with different numbering, for example
MIPS (EMSGSIZE 97, EINPROGRESS 150), SPARC (EMSGSIZE 40, EINPROGRESS 36),
Alpha (EAGAIN 35) or PA-RISC (EMSGSIZE 218, EINPROGRESS 245), the codes the
comment says must not count would end up in the bpf_fmodret_retval tags,
while real errors such as -ENAMETOOLONG (-36), -ELOOP (-40) or -EAFNOSUPPORT
(-97) could be dropped.

That would make the generated BTF depend on the build host.  Would using the
generic values directly (11, 90, 115), or including the asm-generic errno
header explicitly, be more appropriate here?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/43267213382
--===============5172542355940017295==--
