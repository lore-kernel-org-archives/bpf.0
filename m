Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E14963A4F30
	for <bpf@vger.kernel.org>; Mon, 10 Aug 2026 09:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786353281; cv=none; b=omRNaTGE+tkznM6pwF30ldKUN1KF0pi8rwQnniRl8qFnXg4lm1uZoq5OaMR7IsLUj2BCUBMTD8JHtkMm6jENmINQEMGinKk9ajDwyiujDn3/Fj5WZL71poyBy4exLJL0eJUVur7AxSrwCosJ959osswzQbt+ZnXPgFyV/Znpj3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786353281; c=relaxed/simple;
	bh=c9bJHd70fz8jataKz1wkFN7KcK406eq4f9W2w28ZhQg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hExUJin9XANlo2wuPcHJD14YCWmRHEKMjgV/UgyXroM/lgvrz9qJaKDV9+j98Yd29thfXjySyYeFXdjPbIPPc0OF0gBC4JGrFC06V17BTPGbQu7XQCd01wo4HD3VJjrSC2rbdyiT/YKX2xg770YCd3U9+t/xhTP4bz5GtYUR8Jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GkPu2WQh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GkPu2WQh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 645E31F000E9;
	Mon, 10 Aug 2026 09:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786353279;
	bh=pjmtAMNnDpT+Jyrg8ouPVX83lKo40IbdCUtRn9TGrEI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GkPu2WQh904A2JtiZO0UTWW6UJcceVh4Kgd6bNtq3guFN4JmoAU0mKMoiFPuNCpE7
	 EBFWWgy2o4FZtEuegAbSaN66chcPLCOQDcyc2e23t+dzODmN9oK+Y7ZoINAxBzKJ9A
	 1L3JPaakkfbU6SjYOSQNBuQz/ByLK0ueSB3qGsrT90iql+L/QuO8oNfSNFUD3pH/nX
	 edrNn++VicfRlPO7r+R/0rOQkuTYwSY4J5jdpnZC7bXbraXzQ6MlitSTQPN6zmr9Td
	 DNCMXPA0UQ/dGLVVJQSe0Wkbg7S1FdwxPHY0qoe9vv7Bb/aX9ADO8XqFHwdh0k5QQS
	 QEo0W1qrWAV+g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v4 3/3] bpftool: Fix bypass of the batch line
 length check by comments
Reply-To: sashiko-reviews@lists.linux.dev
To: chenyuan_fl@163.com
Cc: bpf@vger.kernel.org
In-Reply-To: <20260810090459.2666243-4-chenyuan_fl@163.com>
References: <20260810090459.2666243-1-chenyuan_fl@163.com>
 <20260810090459.2666243-4-chenyuan_fl@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 10 Aug 2026 09:14:39 +0000
Message-Id: <20260810091439.645E31F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Incomplete fix for batch line length check bypass, allowing comman=
d injection via embedded null bytes.
--

--- Patch [3]: [PATCH bpf-next v4 3/3] bpftool: Fix bypass of the batch lin=
e length check by comments ---
commit 1803699d659bb5e5e3beb9beeb6577cdf2791dda
Author: Yuan Chen <chenyuan@kylinos.cn>

bpftool: Fix bypass of the batch line length check by comments

This commit fixes an issue in do_batch() where trailing comments truncated
by '#' would bypass the line length check. It records whether fgets()
truncated the line before stripping the comment to reliably reject overlong
lines regardless of comments.

> diff --git a/tools/bpf/bpftool/main.c b/tools/bpf/bpftool/main.c
> --- a/tools/bpf/bpftool/main.c
> +++ b/tools/bpf/bpftool/main.c
> @@ -367,11 +367,13 @@ static int do_batch(int argc, char **argv)
>  	if (json_output)
>  		jsonw_start_array(json_wtr);
>  	while (fgets(buf, sizeof(buf), fp)) {
> +		bool truncated =3D strlen(buf) =3D=3D sizeof(buf) - 1;

[Severity: High]
This isn't a bug introduced by this patch, but does using strlen() here lea=
ve
the length check vulnerable to an embedded null byte bypass?

Since fgets() reads up to sizeof(buf) - 1 bytes, if a batch file line
contains an embedded null byte ('\0'), strlen(buf) will stop at the null
byte. This makes strlen(buf) strictly less than sizeof(buf) - 1, causing the
truncation check to evaluate to false even if the line exceeded the buffer
capacity.

If this bypasses the length check, could the unread remainder of the
buffer-exceeding line remain in the file stream and be parsed and executed
as a separate, arbitrary command on the next loop iteration?=20

Might it be safer to check if the buffer is missing a newline character
instead of relying on strlen()?

[ ... ]

>  		/* Append continuation lines if any (coming after a line ending
>  		 * with '\' in the batch file).
>  		 */
>  		while ((cp =3D strstr(buf, "\\\n")) !=3D NULL) {
> +			bool cont_truncated;
> +
>  			if (!fgets(contline, sizeof(contline), fp) ||
>  			    strlen(contline) =3D=3D 0) {
[ ... ]
>  			}
> =20
> +			cont_truncated =3D strlen(contline) =3D=3D sizeof(contline) - 1;

[Severity: High]
This is also a pre-existing issue, but does the same embedded null byte
bypass apply to continuation lines here?

If contline contains a null byte, cont_truncated will evaluate to false,
potentially allowing an overlong continuation line to bypass the length
enforcement and execute trailing input as unintended commands.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260810090459.2666=
243-1-chenyuan_fl@163.com?part=3D3
