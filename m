Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 285F63F65F3;
	Mon, 18 May 2026 11:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779104279; cv=none; b=KaexmSLWpiYlkcCpwFx9XkxDXIERce2AuuYBx87S9WlfplpAuPm2lMlyhcHeqvFMh16toVsaiwCgHEusderCvv5a5YNZcjeeSHQUvVeenGRqbBG5Hq4ZRAYQqdDpw4aOGy2tXWrs/Pkmxn8EWvOCtAtSts6nSzAFwgBx+ydRcbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779104279; c=relaxed/simple;
	bh=/MBx4iAaT+bKS7godRXNFZ5WOKFAolb0dAA9ZYeT3eI=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=HUvf3UMb1LI2LYhIfRybaEI8FQpedHv0xiARIonX0CXfwuyIuupJOSz+DOD45WKjTeslY5Vdh46suRDYKwwJ1E3MzQkxqedl1ESWIs5seoqlCThDPn8QzPPzVt/7IoHdAT9S99xutpuk5SDXC6NaHUk3FaQ5K49VOUWwp9x3hZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VDFkaPJ9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VDFkaPJ9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44F6DC2BCB7;
	Mon, 18 May 2026 11:37:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779104278;
	bh=/MBx4iAaT+bKS7godRXNFZ5WOKFAolb0dAA9ZYeT3eI=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=VDFkaPJ975V04saTEzgxwLsRkqgCN/xezIEqrw/9dnpeghkOfBIf0hb1tOhhq2Hs1
	 4JmTsS1tWfONiEFqqdKDbvBLvzIQUKK3N7ZKeKVjcvk9Qq+dVqeNKnsrlFZ5hqLD7A
	 Y+ZBVqetFEFi5BVE4AMdzJfb1dGVRSiLw0vmCRCgPl17Bjg4EY1tr4baATDed7Yylo
	 GKW257yOWGlI/hYMUu4/hYknTiz3r9C9o1pBL47MHPlME3xCXYh1A6zxCsk/A35UCk
	 jHPWRO+qznhIl0rGBpYI9Ncd7clozO2Ajueq627uNrqENxCDEgnpm2OLmumS28SNl6
	 mQB/FGlnQaPIw==
Content-Type: multipart/mixed; boundary="===============5408726358768098547=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <a5a57eb9690a537c2d8d7ec619fb1d200c9fc804436ae085b9344b691c2470df@mail.kernel.org>
In-Reply-To: <20260518105957.123445-5-jolsa@kernel.org>
References: <20260518105957.123445-5-jolsa@kernel.org>
Subject: Re: [PATCHv2 04/11] libbpf: Change has_nop_combo to work on top of nop10
From: bot+bpf-ci@kernel.org
To: jolsa@kernel.org,oleg@redhat.com,peterz@infradead.org,mingo@kernel.org,mhiramat@kernel.org,andrii@kernel.org
Cc: jakub@cloudflare.com,bpf@vger.kernel.org,linux-trace-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon, 18 May 2026 11:37:58 +0000 (UTC)

--===============5408726358768098547==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> libbpf: Change has_nop_combo to work on top of nop10
>
> We now expect nop combo with 10 bytes nop instead of 5 bytes nop,
> fixing has_nop_combo to reflect that.
>
> Fixes: 41a5c7df4466 ("libbpf: Add support to detect nop,nop5 instructions combo for usdt probe")

Should the Fixes tag reference commit 5c3c59c7952a ("uprobes/x86: Move
optimized uprobe from nop5 to nop10") instead? Commit 41a5c7df4466 originally
introduced has_nop_combo() with the correct nop5 check. Commit 5c3c59c7952a
later changed the kernel to use nop10 instead of nop5 for uprobe optimization
but failed to update the libbpf has_nop_combo() function accordingly, creating
a mismatch between kernel and userspace.

> Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
>
> diff --git a/tools/lib/bpf/usdt.c b/tools/lib/bpf/usdt.c
> index e3710933fd52..7e62e4d5bedd 100644
> --- a/tools/lib/bpf/usdt.c
> +++ b/tools/lib/bpf/usdt.c

[ ... ]

> @@ -596,14 +596,14 @@ static int parse_usdt_spec(struct usdt_spec *spec, const struct usdt_note *note,
>  #if defined(__x86_64__)
>  static bool has_nop_combo(int fd, long off)
>  {
> -	unsigned char nop_combo[6] = {
> -		0x90, 0x0f, 0x1f, 0x44, 0x00, 0x00 /* nop,nop5 */
> +	unsigned char nop_combo[11] = {
> +		0x90, 0x66, 0x66, 0x0f, 0x1f, 0x84, 0x00, 0x00, 0x00, 0x00, 0x00,
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

This isn't a bug, but Jakub Sitnicki suggested in v1 review to use
ARRAY_SIZE(buf) instead of repeating the scalar value 11 in multiple places.
The suggestion was included alongside the Reviewed-by tag but was not
addressed.

Reference: https://lore.kernel.org/bpf/87fr3t7wpu.fsf@cloudflare.com/

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/26030080109
--===============5408726358768098547==--
