Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D8403F8226
	for <bpf@vger.kernel.org>; Mon, 10 Aug 2026 14:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786373079; cv=none; b=tYaeFzUKmp/fj1dIlwVIbiFJPXZiMjoFDdG+OEEo4BVh7EgX8xhT8iy+WiPr7RbpNuMqci/iuZ9Nu6xNFCdf+t1Z5DmXHyE2L9dXNUm4mM4elWqrbtMedCDlOBVk/iC3U9KSg70tCfWIcVc3vNfM2SeTVDaq0POl16F4+kZSgC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786373079; c=relaxed/simple;
	bh=oWALGQ1b6llnpOjP2aNqiJMvq5img/0c1YVq4sMQfWc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=omYO6z4mTzp8e5B7+kYvk5I2nyDayAxfYJYqRZt1xuTeC+Cb0KpWlZh0Huj9zIfcc1A5ArWSxB/3uDkuPAoISwt0DJAJPDdu1vVFwSPW4OIo2z230j0GvMEjHfiIYvASjloXJIjfrulnr3Z9SBt7wDvz1jR5DYd9NrHYg7zhXjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=frdYkCIB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="frdYkCIB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DACEA1F000E9;
	Mon, 10 Aug 2026 14:44:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786373078;
	bh=RZhAxqypLn1WrFk7jhRZaQ17Fv8h0gdNsxejIkOFPTw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=frdYkCIBhbYd8PKTcME3GyecTAauCJkP9CdnMe0IE9WuY2cJZcf+qrKZOGoBQ4i/i
	 pwJeJ3FOtPsA6Q/DcsZI4twCGzXnX32qdk/On8AvCKTiL/dSXu7y/VYZBux+fJcArY
	 +rZXwghwT3IH9QkykkVfrJzPL6RxZKu/LvDlluvovK2gLOt//YPgIMkDXmqes6mPAJ
	 IUkjh5pFB3ABrwF5s0OK0+sGvlSZCXfskdqm7VLuu+TapLaASx+nTQ1AA5vz/XLszX
	 U05bJ+t3LnXeepdZeS1LSN8hn0Iax/i2f4xUwDVo1kGSPJbibgWVfnD6CDCYteUlRB
	 5KEw/g8IsgXEw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v5 3/3] bpftool: Fix bypass of the batch line
 length check by comments
Reply-To: sashiko-reviews@lists.linux.dev
To: chenyuan_fl@163.com
Cc: bpf@vger.kernel.org
In-Reply-To: <20260810142224.2907373-4-chenyuan_fl@163.com>
References: <20260810142224.2907373-1-chenyuan_fl@163.com>
 <20260810142224.2907373-4-chenyuan_fl@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 10 Aug 2026 14:44:36 +0000
Message-Id: <20260810144437.DACEA1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Uninitialized memory read in `memchr` when `fgets` reads a short=
 line without a newline.
- [Medium] Discarded newline character breaks the command continuation logi=
c for maximal-length lines.
--

--- Patch [3]: [PATCH bpf-next v5 3/3] bpftool: Fix bypass of the batch lin=
e length check by comments ---
commit 6f345d4b0d20421906e194cdb508c0d3bd38e98a
Author: Yuan Chen <chenyuan@kylinos.cn>

bpftool: Fix bypass of the batch line length check by comments

This commit fixes a bug in bpftool where batch lines containing a '#'
could bypass the line length check, leading to the remainder of the
line being executed as a separate command. It introduces memchr() and
feof() checks to accurately detect truncated reads.

> diff --git a/tools/bpf/bpftool/main.c b/tools/bpf/bpftool/main.c
> index 0bbb2e1984503..337fbf1ec596a 100644
> --- a/tools/bpf/bpftool/main.c
> +++ b/tools/bpf/bpftool/main.c
> @@ -367,11 +367,27 @@ static int do_batch(int argc, char **argv)
>  	if (json_output)
>  		jsonw_start_array(json_wtr);
>  	while (fgets(buf, sizeof(buf), fp)) {
> +		bool truncated =3D !memchr(buf, '\n', sizeof(buf) - 1) && !feof(fp);

[Severity: Medium]
If a short command that does not end in a newline is read, fgets() will
append a null terminator and leave the rest of the stack buffer uninitializ=
ed.

Does this memchr() call result in an uninitialized memory read by
unconditionally scanning the full buffer size past the null terminator?

> +
> +		if (truncated) {
> +			/*
> +			 * fgets() filled the buffer. If the very next byte is
> +			 * a newline, the line fits the buffer exactly and is
> +			 * not truncated.
> +			 */
> +			int c =3D fgetc(fp);
> +
> +			if (c =3D=3D '\n')
> +				truncated =3D false;

[Severity: Medium]
When a command line reaches exactly the maximum buffer size minus one and e=
nds
with a continuation backslash, fgets() fills the buffer and stops before
reading the newline.

If we read the newline character here and discard it without putting it back
in the stream or adding it to the buffer, will it break the continuation lo=
gic?

Later in do_batch(), the code checks for the presence of the newline alongs=
ide
the backslash:

    while ((cp =3D strstr(buf, "\\\n")) !=3D NULL) {

Will this strstr() check fail since the newline was permanently consumed?

> +			else if (c !=3D EOF)
> +				ungetc(c, fp);
> +		}

[ ... ]

> @@ -380,6 +396,8 @@ static int do_batch(int argc, char **argv)
>  		 * with '\' in the batch file).
>  		 */
>  		while ((cp =3D strstr(buf, "\\\n")) !=3D NULL) {
> +			bool cont_truncated;
> +
>  			if (!fgets(contline, sizeof(contline), fp) ||
>  			    strlen(contline) =3D=3D 0) {
>  				p_err("missing continuation line on command %u",
> @@ -388,11 +406,15 @@ static int do_batch(int argc, char **argv)
>  				goto err_close;
>  			}
> =20
> +			cont_truncated =3D !memchr(contline, '\n', sizeof(contline) - 1) &&
> +					 !feof(fp);

[Severity: Medium]
Does this memchr() call introduce the same uninitialized memory read regres=
sion
for the continuation line buffer as the one above?

> +
>  			cp =3D strchr(contline, '#');
>  			if (cp)
>  				*cp =3D '\0';

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260810142224.2907=
373-1-chenyuan_fl@163.com?part=3D3
