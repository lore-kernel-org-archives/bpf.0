Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C7FD4FD29C
	for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 21:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790025239; cv=none; b=ZcdT1uLrXuNamRyq4DDAx4Bpcdn9YRiJWyUCL9vIxmMzw6vv3T1uC5ipqTlCiBieMFAHj4Ys5VdnFZqYa52TR5gJc50Stjw7hud36+NwKy+WYFAtdrY9YUcOUoBM+tDsRP0rBOVu5YM8zNH9gh/etpC0S+KgTNYnoaktVqdXTgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790025239; c=relaxed/simple;
	bh=caYiNmLv2rKCemRnIAg74NIWJ3ng0o0IBHUDuhcgbrU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=eBfhWe5tG+9g6NhOc6XAmJbWhGbKezuH0tI3pmEBj9Sm+75x65pW2GCXu8hW7Xk3A4FT5MkkzNM2sH+trAxxFu5tltcI3fgYbw9agm7NBeOvdUSRZwj3WKiSkAPYOWP9uZSY2rTlBCNkYq0NkPuUBHQNdFLTxmAeTyqWrhde0iE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KrKy/qQK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KrKy/qQK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D91A41F000FF;
	Mon, 21 Sep 2026 21:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790025236;
	bh=pPgKZQTAndTz9PlXzk+4733D9tBKrcmTN7Vp0i7QhHQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KrKy/qQKxSvfMcDlogenID8dS47r9+NE1NlH+l6kGZUxFOXo6V+cXyar070OkKGhT
	 0CRpXwCVTFCgNqyvCnWiPx2hqN7/trolCIPU1iX/ItXufAfXxm4DRXbjSzwcMUretr
	 osGPQrWWnzHs6tx0NptmbKRrgOneDAi/F0d0UiNthIi+i6IFbnaD3uDlVECE8tJP2f
	 gPsxlK5mY7EJiOZ/VKRikYZTeR94SJIFn0zCo2MZjkgnSKcXc9UO6S2HeQ75K4xnyo
	 6UOrtzDsHal07ZYvNLbgsU1GhP6g3+Gz16sYFlY2QEAlV43WNiEc2br3zTPGnckH8C
	 rnI4FjDmKsoMA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v4 13/20] libbpf: Resolve the compiler's
 _Unwind_Resume to the kernel's kfunc
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yonghong Song" <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260921210140.1722891-1-yonghong.song@linux.dev>
References: <20260921210033.1715000-1-yonghong.song@linux.dev>
 <20260921210140.1722891-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 21:13:55 +0000
Message-Id: <20260921211355.D91A41F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] bpf: multi-line comment style violation in kern_extern_name()
--

commit 293bdf5bcf5e7193069a28fa045283b34511449e
Author: Yonghong Song <yonghong.song@linux.dev>

libbpf: Resolve the compiler's _Unwind_Resume to the kernel's kfunc

LLVM terminates a cleanup landing pad with a call to _Unwind_Resume.
The kernel provides that terminator as a kfunc, but under the name
bpf_unwind_resume. This patch translates the name during both direct
load and light skeleton resolutions to ensure it resolves correctly.

> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index cd1ea1bb53cbf..13ae9175e9686 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -8379,6 +8379,15 @@ static void fixup_verifier_log(struct bpf_program =
*prog, char *buf, size_t buf_s
>  	}
>  }
> =20
> +/* LLVM terminates a cleanup landing pad with a call to _Unwind_Resume, =
the
> + * base unwind ABI's entry point for carrying an unwind on once a frame's
> + * cleanups have run. The kernel knows it as bpf_unwind_resume.
> + */

[Severity: Low]
This isn't a bug, but does this newly added comment violate the strict BPF
subsystem multi-line comment style rules? The BPF subsystem guide requires
multi-line comments to have the opening /* on its own line, with the text
starting on the subsequent line.

> +static const char *kern_extern_name(const char *name)
> +{
> +	return strcmp(name, "_Unwind_Resume") ? name : "bpf_unwind_resume";
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921210033.1715=
000-1-yonghong.song@linux.dev?part=3D13
