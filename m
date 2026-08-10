Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A9763A9D9B
	for <bpf@vger.kernel.org>; Mon, 10 Aug 2026 09:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786353322; cv=none; b=jfNyGf9p3yaV/x83ZiawrCYgtygXiQp4l5gu1ArhSpeOVUZAbdq3Sn3FrEwx0+v//lDg1vGxjLTSH1Lpn7PyPLpnmEHDQuMB0y8axCnX3OUiViYag2SsgMVsip20/9ruXKvUcLhBM3zygIZkyDf9QWB3xtBjphzX+zbe3Vqata4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786353322; c=relaxed/simple;
	bh=IPxvUPolFW2ajYVtF0IPCiExMtTLUed449JhfBEledg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BruYuZYw6C+nmjbik2FGYe3Fu5tQaICUCjnR0MgW3/4wcRtVWpPjT/c8vaT1q3HABoH4f0s/I6DC5zZVIPPb68cCyArMU4KM0ebZQZQJMa4wq73S4nxwSWp5Q48fX+26jI/+ADw/nYQSMKMbzmxaC6T2WXd00T6YdgUgoUwn+RA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MzJxHnED; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MzJxHnED"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56E5E1F000E9;
	Mon, 10 Aug 2026 09:15:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786353320;
	bh=p4Rut3OarNfQL5HCgLFflJraWHPlX2qNblmTszM01c4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MzJxHnED5IYyEzIL0dYFBgSjI3ghFNXfPU96IRGR7AKzmDmji/9Pa2n99YP7GDng4
	 e2KJM2g55Biy+nB0ca6YPJI0vVZrI3dhkBKEZfPxbYVAFtspfzzglUeOePZqUmLoLt
	 GarGJqM9Elz8Feg4pELwkuf6DG1jwhqxcObEYDWFyH3uy0cqWxF+AZBQ57zNLIoDAA
	 o810DdW8zct4z0WuLgiggbjS2kwH3eU202QqgVNy4BZ7kNysa7D5UyZihilRlLodEN
	 unZkHB7QWQcwfMNb3Dsty2qgIgPa71dWoYTnGQmxw7Ha8J5pfWwyA1hlao15hOCBhR
	 vVgjb/k14iy+A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v4 2/3] bpftool: fix spurious batch file read
 error
Reply-To: sashiko-reviews@lists.linux.dev
To: chenyuan_fl@163.com
Cc: bpf@vger.kernel.org
In-Reply-To: <20260810090459.2666243-3-chenyuan_fl@163.com>
References: <20260810090459.2666243-1-chenyuan_fl@163.com>
 <20260810090459.2666243-3-chenyuan_fl@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 10 Aug 2026 09:15:19 +0000
Message-Id: <20260810091520.56E5E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The batch file line length checking logic in `do_batch` is fundame=
ntally flawed, leading to three issues: 1) It incorrectly rejects valid lin=
es that are exactly 4095 bytes (including the newline). 2) It allows oversi=
zed lines with comments to bypass the length limit because the truncation c=
heck is performed after comment stripping. 3) It fails to validate continua=
tion lines properly. These parser flaws can cause the unread remainder of a=
n oversized line to be executed as a completely new, hidden command.
--

--- Patch [2]: [PATCH bpf-next v4 2/3] bpftool: fix spurious batch file rea=
d error ---
commit cf1f390638590ec88aac09a2ed99cf49c783fe7f
Author: Yuan Chen <chenyuan@kylinos.cn>

bpftool: fix spurious batch file read error

This commit fixes a spurious batch file read error in bpftool. It replaces
the use of errno with ferror() to detect read failures and explicitly tracks
line length truncations.

> diff --git a/tools/bpf/bpftool/main.c b/tools/bpf/bpftool/main.c
> index c91e1a6e1a1ec..0bbb2e1984503 100644
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
This is a pre-existing issue, but by checking the string length after
stripping comments, couldn't an oversized line containing a '#' bypass this
truncation check?

If a long line is read and contains a '#', strchr() will null-terminate
it early, making strlen(buf) smaller than sizeof(buf) - 1. The unread
remainder of that oversized line would then be left in the file stream
and executed as a new command on the next fgets() iteration.

Additionally, does this logic incorrectly reject valid lines that fit
the buffer exactly?

This same parser flaw appears to exist for continuation lines where
lengths are also checked after comment stripping.

Should the truncation check be performed immediately after fgets(), before
any characters are modified?

>  			break;
>  		}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260810090459.2666=
243-1-chenyuan_fl@163.com?part=3D2
