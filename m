Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 281F9320A34
	for <bpf@vger.kernel.org>; Mon, 10 Aug 2026 01:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786327158; cv=none; b=FHBLIZKeOreomfculL3ugHB+oc5XpcwjYdPRxLdlOI/Xku+8+rDc7806EDD0q98uMs4Hn1eVCcL98ua+zy6gl7/D/4xquA2Iy+jxZ5tYu2oqgnPmeAM0iPRmv7DGgevpYAoVHZS7uE3ebEXOGRggF6r10HIPZbkOPQ9DNZwcCbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786327158; c=relaxed/simple;
	bh=fS8F1qDpJSpbg4UFesY//o2IDvJ5AxoYc0Bo5rrBUGM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ir0u0bzFh6a4I8tUao07Fzt869VkHNGsZgZBiZmcihPtVoentwWEBSPmXhTGnfvn1vIdYHRD2bzB5yowObyMFgEYBRhoCV49m7fBwGUge7O66UhJ365NUrcAcneDABDdw7GtpYuVCH7Oo3a1zWAPgVXNdmid/vh5CWf07Dd4MRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ltwy8Qlv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ltwy8Qlv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 924091F000E9;
	Mon, 10 Aug 2026 01:59:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786327156;
	bh=/ZQ2B3Q4Yy+h3vWKdyZvYbdfzWx90CxG31DRVl4i1zY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ltwy8QlveuCX1VspNzqGI/ymbCStcyewEtQF09Okw9k3WqKt/FbiXgnr1Vsp9Mqc1
	 oUodpTU4ds7xqRjd/9j5KhGb/QXi7lCiUOmLQqTr9pxH26CLDB55npcycvpQvccgJh
	 kvZGZKGZsRALQ9ObAiEsG3K7+VrWS7c6gI+FKpkwWlp2d9XuBAHMGYVt6l1zH586Ug
	 piENvvgjRkN+4Isz9lIzpAJeypvczqO5OrUu5gcYgXjLiCbrTYWaRbrNpOjcqGKwUL
	 DCqHFHRevVbA1EFOmmfFnkAx9PjyDBirXYcAMzRTCqafzAoQrXa0l6CbeKQUH5tKLH
	 f3nVtNyXzNvMA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 2/2] bpftool: fix spurious batch file read
 error
Reply-To: sashiko-reviews@lists.linux.dev
To: chenyuan_fl@163.com
Cc: bpf@vger.kernel.org
In-Reply-To: <20260810015216.2369940-3-chenyuan_fl@163.com>
References: <20260810015216.2369940-1-chenyuan_fl@163.com>
 <20260810015216.2369940-3-chenyuan_fl@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 10 Aug 2026 01:59:15 +0000
Message-Id: <20260810015916.924091F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but the comment stri=
pping logic bypasses the line truncation check, allowing portions of excess=
ively long commented lines to be silently executed as separate commands.
--

--- Patch [2]: [PATCH bpf-next 2/2] bpftool: fix spurious batch file read e=
rror ---
commit 858e1807e2fde336612fcf607106fe8e9010fc61
Author: Yuan Chen <chenyuan@kylinos.cn>

bpftool: fix spurious batch file read error

This commit addresses a bug where do_batch() incorrectly detects a read
failure due to a stale errno from a previously executed command. It replaces
the errno check with ferror(fp) and explicitly tracks cases where a line
exceeds the buffer size limit.

> diff --git a/tools/bpf/bpftool/main.c b/tools/bpf/bpftool/main.c
> index c91e1a6e1a1ec..c9a86039c400b 100644
> --- a/tools/bpf/bpftool/main.c
> +++ b/tools/bpf/bpftool/main.c
[ ... ]
> @@ -371,7 +372,7 @@ static int do_batch(int argc, char **argv)
>  			*cp =3D '\0';
> =20
>  		if (strlen(buf) =3D=3D sizeof(buf) - 1) {
> -			errno =3D E2BIG;
> +			line_too_long =3D true;

[Severity: High]
This isn't a bug introduced by this patch, but doesn't the comment stripping
logic right above this in do_batch() bypass the line truncation check?

If a batch file line exceeds the buffer limit (4095 characters) and contains
a '#' character in the first 4095 bytes, fgets() reads the first 4095 bytes,
but the '#' causes the string to be truncated early by setting '*cp =3D '\0=
''.=20
This means strlen(buf) becomes less than sizeof(buf) - 1, incorrectly bypas=
sing
this check.

Could this allow the unread remainder of an excessively long commented line=
 to
remain in the file stream, where it would be parsed and executed as a separ=
ate
command on the next loop iteration?

>  			break;
>  		}
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260810015216.2369=
940-1-chenyuan_fl@163.com?part=3D2
