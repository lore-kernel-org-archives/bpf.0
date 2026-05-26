Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B4223B993A;
	Tue, 26 May 2026 21:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779832000; cv=none; b=B1mb4V8ACIewBYU8Lh0CAfdlv0Ccp+Wyv6Y2CJK/rTnmZn2rwLh+klPIHena1tvln73lidAWtz0hlHTIFWQE4AIic6EQf/LE0dO45c5pIaEFDCBOkAOukwO7kUcL3BgYeORGHQKUWER84jGRsd21EQEvkSaQx0d5LokSJmWwAFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779832000; c=relaxed/simple;
	bh=Sxa4v9+NZO60bbcec560K6FA9raLXPhuVZMULay/7V4=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=UP02vyok3foTKseL4vdeKOPM+w8jvJqEE4oJ/WSMCoQ/Uuy6M5IeppkdOSAS9eNdE5QM134mkhaBoflfUF12+jli3Z/rbMn07CzQf6wvSm67mRGlTCdFz6KORzwgKdfnMydCTYx1wZHZTE8jMowH+vW0/E6I7QjBFd5kHRW3eFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R5JdRd5L; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R5JdRd5L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 165311F000E9;
	Tue, 26 May 2026 21:46:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779831997;
	bh=LsCENWmGWJMyheRKKdzZB/GlcVKTIoGXQH5EQVDKXdA=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=R5JdRd5Lqyk347NBbV6/Qz0xeu/VDTXIi4sUa+XA38F9Ue8P18ZFZD5IPI86ZxiLT
	 I2RWc1MlIpqtaJDGwRudh+JofJ5xWiwgtqWESOFwcvqUjdiCvuWZsl0bBUr+NAAFze
	 TchQGL095Be5LGN9EY4hyzI4oMFTO+1JVT7y9nfNgEsFs0I/WhsGPpjzYr6bvqmhqz
	 BKk85sgT3HsaRFBZSIPx84E8uE6zaOFkXisgXzkw7HH6Bhgt4oVWIjaNQLeU79SEQI
	 OaThgkb3FAElj2T1yKG+5yHDpcfDB9jbaM5vNJpjn70zhYeKAWH0eVv78H59fERxIT
	 nz4K9J3HwIRaQ==
Content-Type: multipart/mixed; boundary="===============6555364161729660658=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <4ea9f26531f9e53da6c8e5c8a638ef7aeaffd6b3fb6ed20e742069783e660e05@mail.kernel.org>
In-Reply-To: <20260526205840.173790-7-jolsa@kernel.org>
References: <20260526205840.173790-7-jolsa@kernel.org>
Subject: Re: [PATCHv4 06/13] libbpf: Change has_nop_combo to work on top of nop10
From: bot+bpf-ci@kernel.org
To: jolsa@kernel.org,oleg@redhat.com,peterz@infradead.org,mingo@kernel.org,mhiramat@kernel.org,andrii@kernel.org
Cc: jakub@cloudflare.com,bpf@vger.kernel.org,linux-trace-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue, 26 May 2026 21:46:37 +0000 (UTC)

--===============6555364161729660658==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> commit 5ad96df841a0877eeca7d2cbe4b3f726b7fd0b72
> Author: Jiri Olsa <jolsa@kernel.org>
> Date:   Tue May 26 22:58:33 2026 +0200
>
>     libbpf: Change has_nop_combo to work on top of nop10
>
>     We now expect nop combo with 10 bytes nop instead of 5 bytes nop,
>     fixing has_nop_combo to reflect that.
>
>     Fixes: 41a5c7df4466 ("libbpf: Add support to detect nop,nop5 instructions combo for usdt probe")
>     Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>
>     Acked-by: Andrii Nakryiko <andrii@kernel.org>
>     Signed-off-by: Jiri Olsa <jolsa@kernel.org>

The Fixes: tag references commit 41a5c7df4466 which originally added
has_nop_combo() with correct nop5 support. However, the actual bug was
introduced by commit af734a7ddb4e which changed the kernel's uprobe
implementation from nop5 to nop10. Should the tag be:

  Fixes: af734a7ddb4e ("uprobes/x86: Move optimized uprobe from nop5 to nop10")

> diff --git a/tools/lib/bpf/usdt.c b/tools/lib/bpf/usdt.c
> index e3710933fd52..484a4354e82b 100644
> --- a/tools/lib/bpf/usdt.c
> +++ b/tools/lib/bpf/usdt.c
> @@ -305,7 +305,7 @@ struct usdt_manager *usdt_manager_new(struct bpf_object *obj)
>
>  	/*
>  	 * Detect kernel support for uprobe() syscall, it's presence means we can
> -	 * take advantage of faster nop5 uprobe handling.
> +	 * take advantage of faster nop10 uprobe handling.
>  	 * Added in: 56101b69c919 ("uprobes/x86: Add uprobe syscall to speed up uprobe")
>  	 */

The comment at the end of this block references commit 56101b69c919 which
added the uprobe syscall. Andrii Nakryiko noted in v3 review that it would
be good to also reference the commit that switches nop5 to nop10, though he
acknowledged the hash isn't stable until it lands. Now that af734a7ddb4e is
available, could this be updated to reference both commits?

> @@ -596,14 +596,14 @@ static int parse_usdt_spec(struct usdt_spec *spec, const struct usdt_note *note,
>  #if defined(__x86_64__)
>  static bool has_nop_combo(int fd, long off)
>  {
> -	unsigned char nop_combo[6] = {
> -		0x90, 0x0f, 0x1f, 0x44, 0x00, 0x00 /* nop,nop5 */
> +	unsigned char nop_combo[11] = {
> +		0x90, 0x66, 0x2e, 0x0f, 0x1f, 0x84, 0x00, 0x00, 0x00, 0x00, 0x00,
>  	};
> -	unsigned char buf[6];
> +	unsigned char buf[11];
>
> -	if (pread(fd, buf, 6, off) != 6)
> +	if (pread(fd, buf, 11, off) != 11)
>  		return false;
> -	return memcmp(buf, nop_combo, 6) == 0;
> +	return memcmp(buf, nop_combo, 11) == 0;
>  }

This isn't a bug, but Jakub Sitnicki suggested in v1 review using
ARRAY_SIZE(buf) instead of repeating the scalar value 11. The author
preferred keeping the literal number for simplicity, though the value
now appears in 5 locations (array declarations, pread size, pread check,
memcmp size).

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/26475828601
--===============6555364161729660658==--
