Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2108523EAB8;
	Fri, 17 Apr 2026 20:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776458833; cv=none; b=qhs7QzfMm5JeMQkiizz3i7wY5QpFSd2GyCeXhTQQefzJG2ipsSFv+U51qVJYmIJHGZHU+8yWVfToUS4VITG6/ukOILaJNYu/7BBFXh8o3qPyGDXm4L6pmxfMkM3EDBIOLW2MPJM1IOhmQYFNSZTRF8g9Tub5Aw/dpkg4rA5iD5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776458833; c=relaxed/simple;
	bh=ynC5swxf3nALIWBTz3YfPsjrjxX4EFyf7mShOkS2Tz0=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=L2jqJ3VDBxd3kVLrEhv6o+fB2EIMG9i+GZ7zNDfAFX81X3BESvH04fFFSArVmHN4oEhxFjzmYrL1Fvrc0XSJ0N7kxxUU7mmF5yJY+41i7Q5nIdsKXtXlRaQOahhicnR1NjrQaDdIskUvm9nAgAy5IR6g1hsw22q01fP4xsNwCeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bC3LAjkN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bC3LAjkN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84880C19425;
	Fri, 17 Apr 2026 20:47:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776458832;
	bh=ynC5swxf3nALIWBTz3YfPsjrjxX4EFyf7mShOkS2Tz0=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=bC3LAjkNI+Xpqr/AyZqq7sewUKwasr4zr1T7Dq4kOx+ht7U6cBhffWFB8FBj2Z28H
	 SBbS259pd3icoB4a6NRioIrjJKmOW9drmJ7Wg6a/DQQVVOB/5fODmI7u4p+cwYJgJz
	 iu6bFPbTzMFHWt39QPr6j2/XdlqZBQzfj2xHxw4uWn6zu56RJRWIZLw+sPAhvE91h5
	 hjuePp7MYdObGf14w/uJvrLWCnPgXgM0QYbi6DUdoycQ82Q1WbCoWRgDAbIvK5FNqF
	 hhB/x1xXEBLQXrwXpo779axO2zYiuGTuu1qTexPIBQoCFsEN/jP5XvKQDqn74QB5A3
	 ly+vNMDbHYb4A==
Content-Type: multipart/mixed; boundary="===============4031934097603330410=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <8826c633c40a18b9e1f2741adfb29d72f4271eb9c8c7d5b971ff91bdb0e8662f@mail.kernel.org>
In-Reply-To: <20260417195816.1265179-1-atomlin@atomlin.com>
References: <20260417195816.1265179-1-atomlin@atomlin.com>
Subject: Re: [PATCH] libbpf: Report error when a negative kprobe offset is specified
From: bot+bpf-ci@kernel.org
To: atomlin@atomlin.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com
Cc: martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,atomlin@atomlin.com,bpf@vger.kernel.org,linux-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri, 17 Apr 2026 20:47:12 +0000 (UTC)

--===============4031934097603330410==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 8b0c3246097f..af81e0e200b9 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -12279,7 +12279,7 @@ bpf_program__attach_kprobe_multi_opts(const struct bpf_program *prog,
>  static int attach_kprobe(const struct bpf_program *prog, long cookie, struct bpf_link **link)
>  {
>  	DECLARE_LIBBPF_OPTS(bpf_kprobe_opts, opts);
> -	unsigned long offset = 0;
> +	long offset = 0;
>  	const char *func_name;
>  	char *func;
>  	int n;
> @@ -12301,6 +12301,13 @@ static int attach_kprobe(const struct bpf_program *prog, long cookie, struct bpf
>  		pr_warn("kprobe name is invalid: %s\n", func_name);
>  		return -EINVAL;
>  	}
> +
> +	if (offset < 0) {
> +		free(func);
> +		pr_warn("kprobe offset must be a non-negative integer: %li\n", offset);
> +		return -EINVAL;
> +	}
> +
>  	if (opts.retprobe && offset != 0) {
>  		free(func);
>  		pr_warn("kretprobes do not support offset specification\n");


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/24584708297
--===============4031934097603330410==--
