Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60FFE8472;
	Sun,  6 Sep 2026 17:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788714176; cv=none; b=Peds55qqRtBIGC8R6YazliWTiN+FwJxaKj3iIJQK7mRomJ38pfhB2NtnLNXNmXwdCFdhIOxV1ztQdXlzk493bto3CAaKj4PdPlehPNq9piptCY7uHZ6BIyUrXvBob5XYwLKWKCuu7TaRzx8czcntV68rI/bI4xTo6burlkvcwjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788714176; c=relaxed/simple;
	bh=QyHdNnmyM6dLVHkg0+sJ89DOljku6meMJb3tIDrUVLA=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=kL4Ljymxn6RPJwvFWIyRLYSFa5xEZX4aeDHhVogElsh/vO5EAzGjC1gUfQgHbS69/pKh3xNVufKDEv1slbnjkTc7ATGwDi4BAQrjuUQa6UQCXZ9Gp6IgDmYRAHm7TyCZvJeYT349eysJa1pxKpH9kNUzP4Ov7G5i26kYL/WTCVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ci5FUCgy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ci5FUCgy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09F781F00A3A;
	Sun,  6 Sep 2026 17:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788714175;
	bh=TBeFAIFQ4spFa6+WzZT7KG9TSEJ5lXH3S3WUVWuoYo8=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=ci5FUCgyC/QInhQXTJ05mtFV29CfPr6LvOcjDgJ1xEKZAtM7HR3K7gN5fL8ABYtZU
	 EOceTC8fe4q+YQxL8MdhtadIasJmCyFAnN7rsIbZ4wqjQY07i0zr1umYkJ/6Ii7hPJ
	 vqOtQQdJQgUIpNvlHWFgT3x3VlLHYLsrzgOQUfiyIRd1hAw+zo2FI9JkMC/L0IcJ8A
	 qx0rU7ckA0c7ONVJFZsOH3bUddbd6u4mKEzkstQslcLKZ4sivFem6/T8tEIpIzwyVR
	 zDqCoYu8fmvp3KUIAzzcnLN6FibR65BmM/QhwDngt9Ico5yFFIpnCF/FEWrH7xi62A
	 B0PGnEeVsNQUw==
Content-Type: multipart/mixed; boundary="===============8862146096104192090=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <36471b9e2d7f9a324b5563343e6f76b70ad344c3bfd527cac9749734cd2377b5@mail.kernel.org>
In-Reply-To: <178870998583.979169.16526173782819097354@tychen.cc>
References: <178870998583.979169.16526173782819097354@tychen.cc>
Subject: Re: [PATCH bpf-next v2 1/2] bpftool: Add recursive map dumping
From: bot+bpf-ci@kernel.org
To: hi@tychen.cc,qmo@kernel.org,andrii@kernel.org,eddyz87@gmail.com
Cc: hi@tychen.cc,ast@kernel.org,daniel@iogearbox.net,memxor@gmail.com,shuah@kernel.org,bpf@vger.kernel.org,linux-kselftest@vger.kernel.org,linux-kernel@vger.kernel.org,martin.lau@kernel.org,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sun,  6 Sep 2026 17:02:54 +0000 (UTC)

--===============8862146096104192090==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/bpf/bpftool/Documentation/bpftool-map.rst b/tools/bpf/bpftool/Documentation/bpftool-map.rst
> index 5daf3de5c744..38d1f542bf5a 100644
> --- a/tools/bpf/bpftool/Documentation/bpftool-map.rst
> +++ b/tools/bpf/bpftool/Documentation/bpftool-map.rst

[ ... ]

> @@ -170,6 +170,25 @@ OPTIONS
>      Do not automatically attempt to mount any virtual file system (such as
>      tracefs or BPF virtual file system) when necessary.
>
> +-r, --recursive
> +    Also dump the inner maps referenced by **array_of_maps** and **hash_of_maps**
> +    entries when running **map dump**. Each map ID is visited once, even if
> +    several entries refer to it. Selected maps are followed by their inner maps.
> +
> +    Plain output includes a header identifying each map. On success, JSON output
> +    is always an array of map objects, each containing an **id** and an
> +    **elements** array, including when only one map is dumped. Outer map entries
> +    retain their **inner_map_id** field, which identifies the corresponding inner
> +    map object.
> +
> +    Inner map IDs are resolved when the maps are visited. The dump is not an
> +    atomic snapshot: concurrent updates can change map contents or remove a
> +    referenced inner map before it is visited. Failure to open a referenced
> +    inner map stops the dump and returns a nonzero exit status. Output may
> +    contain maps or entries printed before the error.
> +    In JSON mode, an error during traversal is included in the output and the
> +    enclosing arrays and objects are closed.

This isn't a bug, but would it be worth reflowing this option block
to 80 columns? Two lines run to 81 columns (the "Also dump the inner
maps referenced by" line and the "retain their **inner_map_id** field"
line), making them the only prose lines over 80 columns in the file.

Also, should there be a blank line before "In JSON mode, ..." if it's
meant to be its own paragraph? It currently starts on a fresh line
after a short 53-column line, so it renders as a continuation of the
same paragraph rather than separated like the other paragraphs in this
block.

[ ... ]

> diff --git a/tools/bpf/bpftool/main.c b/tools/bpf/bpftool/main.c
> index 5ababd8f7d0a..33f4c7172583 100644
> --- a/tools/bpf/bpftool/main.c
> +++ b/tools/bpf/bpftool/main.c
> @@ -26,6 +26,7 @@ static int (*last_do_help)(int argc, char **argv);
>  json_writer_t *json_wtr;
>  bool pretty_output;
>  bool json_output;
> +bool recursive;
>  bool show_pinned;
>  bool block_mount;
>  bool verifier_logs;

This isn't a bug, but would a name like recursive_dump or dump_recursive
read better here? It's a program-wide global exported in main.h, and the
neighbouring flags all carry a qualifier that says what they apply to:
json_output, pretty_output, show_pinned, relaxed_maps, verifier_logs.
Note that --json and --pretty didn't become json or pretty for the same
reason.

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/34044964295
--===============8862146096104192090==--
