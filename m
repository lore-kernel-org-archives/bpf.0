Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE61211A28;
	Thu, 21 May 2026 13:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779369964; cv=none; b=r4RQfWahum+QLqOGD1+5IXxtbVTt2tvg3j6/ZNrgcSWE0/8JbHJXSpZt0AjFWPEcSEJJP/eglzGU0pW817PyqkipawWPtBWqmvJJavjcByYB9RRZt/+Abuj7Nw2lYfn1K75cmXlNXvYfLh5v+ZvJTCt//oYhZCfC2PfTW2E7/0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779369964; c=relaxed/simple;
	bh=q7kOhJZa9F7G8a24kX0XxpiIW8jxNCtlHBTAGiztjDs=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=Z3GbzRuSOdzeh2kPhjp6pXU6HxBh9m+7IhGwgIdNR5Hzy/cDi9z4kqsHaptZgu+H4jp76UQXoOuOVurwlMWE47wHF0Kuzm6SxaW35GwcXJUzKKEya4vsNHOXEf14c8zVPWNdhg1oq4XrsiKV/dSnVYhOgWG51ORqtrmcIgEksA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bScyOvbC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bScyOvbC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CA461F000E9;
	Thu, 21 May 2026 13:26:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779369963;
	bh=CrfzgIosjY4IU53O+RlOMFi9k80P8AT95d6NC3xciW4=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=bScyOvbCCl2CAabYEOZixYgPPiBSUkdZZxiHd3t8qFPcL8hMANOIelgjDD0pIiLTM
	 ThZnYOx8hvv42hz6uWBTuzNUE2ojtLm7JtxZYd8L7WNg/qdzqXrvkuthW7Zkx0e8yh
	 bNAqaSJh1BIrEGABzdA7qqvDdUCBvbwSB8hnio+/22YEEjRHYRN4xDSZHEqdfVz4Go
	 NWQ9tnb6sB0ns6pgaQQGLifpZ6tH787HECgUZE8eFYv++t5j06SR+vCCYaV7wjeh5I
	 qLiF0W8IcJdc2P6SUPpLGjcrenh+CqKnpU1dOHe8Vy0gfvgo2lK/RjQ1M2a1CuDgaj
	 fy/dg4p8ImHQg==
Content-Type: multipart/mixed; boundary="===============6382773644959989125=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <0bf2e7b44d8c8a97d226456fc6cfad3f1b01030bb03bca160182788c8e7c79f1@mail.kernel.org>
In-Reply-To: <20260521124411.31133-7-jolsa@kernel.org>
References: <20260521124411.31133-7-jolsa@kernel.org>
Subject: Re: [PATCHv3 06/12] libbpf: Detect uprobe syscall with new error
From: bot+bpf-ci@kernel.org
To: jolsa@kernel.org,oleg@redhat.com,peterz@infradead.org,mingo@kernel.org,mhiramat@kernel.org,andrii@kernel.org
Cc: bpf@vger.kernel.org,linux-trace-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu, 21 May 2026 13:26:03 +0000 (UTC)

--===============6382773644959989125==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> commit adef46acd6e910a58509f054ca1d94c79b4c2bf2
> Author: Jiri Olsa <jolsa@kernel.org>
> Date:   Thu May 21 14:44:05 2026 +0200
>
>     libbpf: Detect uprobe syscall with new error
>
>     In the previous optimized uprobe fix we changed the syscall
>     error used for its detection from ENXIO to EPROTO.
>
>     Changing related probe_uprobe_syscall detection check.
>
>     Acked-by: Andrii Nakryiko <andrii@kernel.org>
>     Fixes: 05738da0efa1 ("libbpf: Add uprobe syscall feature detection")
>     Signed-off-by: Jiri Olsa <jolsa@kernel.org>

The Fixes tag points to commit 05738da0efa1 ("libbpf: Add uprobe syscall
feature detection"), but wasn't the bug actually introduced by commit
40b54d7e3dab ("uprobes/x86: Move optimized uprobe from nop5 to nop10")?

Commit 05738da0efa1 originally added the ENXIO check correctly, but commit
40b54d7e3dab changed the kernel to return EPROTO instead of ENXIO, breaking
the libbpf detection.

The commit message even says "In the previous optimized uprobe fix we changed
the syscall error," which refers to 40b54d7e3dab.

Should this use:

  Fixes: 40b54d7e3dab ("uprobes/x86: Move optimized uprobe from nop5 to nop10")

This concern was previously raised in review by bot+bpf-ci@kernel.org on
Mon, 18 May 2026 11:37:54 +0000:

https://lore.kernel.org/bpf/545ca16cc113f00a390baf1ffcafba33233af771fc7c879e3c850bb33949da29@mail.kernel.org/

> diff --git a/tools/lib/bpf/features.c b/tools/lib/bpf/features.c
> index b7e388f99d0b..e5641fa60163 100644
> --- a/tools/lib/bpf/features.c
> +++ b/tools/lib/bpf/features.c
> @@ -577,10 +577,10 @@ static int probe_ldimm64_full_range_off(int token_fd)
>  static int probe_uprobe_syscall(int token_fd)
>  {
>  	/*
> -	 * If kernel supports uprobe() syscall, it will return -ENXIO when called
> +	 * If kernel supports uprobe() syscall, it will return -EPROTO when called
>  	 * from the outside of a kernel-generated uprobe trampoline.
>  	 */
> -	return syscall(__NR_uprobe) < 0 && errno == ENXIO;
> +	return syscall(__NR_uprobe) < 0 && errno == EPROTO;
>  }
>  #else
>  static int probe_uprobe_syscall(int token_fd)

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/26227520868
--===============6382773644959989125==--
