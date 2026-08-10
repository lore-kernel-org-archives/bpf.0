Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6AC2285060
	for <bpf@vger.kernel.org>; Mon, 10 Aug 2026 07:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786347746; cv=none; b=Yazh7gpfiGmvVzjNCBpUJWfN5NtCYIIUtsYRHNEfPf+zXem4n1b/gjNF5PRn/yeg5NB6eaDClL6Ef9cRQY8CmNtZ4T8wy/qDD4fg3VelosKirxOvquMBO5rIG5hbcS9Bu8r5WMx9w8VRXJvY+TSJd+q2vuqXl6iY9nhjS+98/pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786347746; c=relaxed/simple;
	bh=jU+9fjPiNBui8OCWT8+L0vYb/DPeEoc/qlkBgkrMHQA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jFMzyqSEsBs1RKYL6f10bDljFOBIjNM5pK4UUTpxe8yHgnzai5y0/d00YufEPiPlaEmN8dzMD7q3TcbLOV82ibbIUxHGFDg7ykwPlYHYcZhOxQ4jIHcEv+BoHeAvAN09iWRrrf87xDkjBAhZNMIANy1qcWWWXM4Vrx8Eewti52k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=STXH3eN3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="STXH3eN3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 334EC1F000E9;
	Mon, 10 Aug 2026 07:42:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786347745;
	bh=0Idpnhi173e5XVx65TFMD2MaoMlDw+ygamQdJ2rmJMs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=STXH3eN3FVQSzo0ylSlFSzW10Y4YVwzedJ/1RGrQbjdbZypyP9wGcH85YykyOmA/9
	 ARiyDjZgLQSvUu/0xx8Yig8svrC7xtidlXHfqsXZy0o0oyuSF6IOaEQehXo6EDIv6J
	 Q1TxqB0skp8twB7BCb2JEDAplJPu7C2ybH/dbPDNgPbDTTsGpEEtn+o9VO4seP3c8K
	 3FNLecWs9Ltv9bfA5GGshq0dZzL/xftm/VE1/IlHKhyFVwdmbApb2D9tDbLrxLDWso
	 ioGvISFsImfzCTs8Sg4ZvtumQKbmizVMgsdY4E4+L8RKJW1O/Xpk8Ai2DyRskUPugo
	 VATGNor9dvUCg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v3 3/3] bpftool: Fix bypass of the batch line
 length check by comments
Reply-To: sashiko-reviews@lists.linux.dev
To: chenyuan_fl@163.com
Cc: bpf@vger.kernel.org
In-Reply-To: <20260810073348.2586225-4-chenyuan_fl@163.com>
References: <20260810073348.2586225-1-chenyuan_fl@163.com>
 <20260810073348.2586225-4-chenyuan_fl@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 10 Aug 2026 07:42:24 +0000
Message-Id: <20260810074225.334EC1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [Medium] The patch fixes the batch line length check bypass in the main b=
uffer but misses the identical vulnerability in continuation lines, allowin=
g command smuggling.
- [Medium] The newly introduced `truncated` check relies on `strlen()`, whi=
ch can be bypassed by injecting a null byte, re-enabling the command smuggl=
ing vulnerability.
--

--- Patch [3]: [PATCH bpf-next v3 3/3] bpftool: Fix bypass of the batch lin=
e length check by comments ---
commit 9e86e77bd4ad670faad801b29d45cd5587bdf90a
Author: Yuan Chen <chenyuan@kylinos.cn>

bpftool: Fix bypass of the batch line length check by comments

This commit attempts to fix a command smuggling vulnerability where overlong
lines containing a '#' character bypass the buffer length check. It records
whether fgets() truncated the line before stripping the comment to ensure
overlong lines are properly rejected.

> diff --git a/tools/bpf/bpftool/main.c b/tools/bpf/bpftool/main.c
> --- a/tools/bpf/bpftool/main.c
> +++ b/tools/bpf/bpftool/main.c
> @@ -367,11 +367,13 @@ static int do_batch(int argc, char **argv)
>  	if (json_output)
>  		jsonw_start_array(json_wtr);
>  	while (fgets(buf, sizeof(buf), fp)) {
> +		bool truncated =3D strlen(buf) =3D=3D sizeof(buf) - 1;

[Severity: Medium]
This isn't a bug introduced by this patch, but rather a pre-existing issue.
Can the new truncated check be bypassed if the input contains a null byte?

Since fgets() reads up to sizeof(buf) - 1 bytes without stopping at null
bytes, but strlen() stops at the first null byte, wouldn't an overlong line
with an injected null byte result in a smaller strlen(buf)?

If that happens, wouldn't the truncated check evaluate to false, bypassing =
the
line limit and leaving the remainder of the overlong line in the file stream
to be parsed as a separate command?

> +
>  		cp =3D strchr(buf, '#');
>  		if (cp)
>  			*cp =3D '\0';
> =20
> -		if (strlen(buf) =3D=3D sizeof(buf) - 1) {
> +		if (truncated) {
>  			line_too_long =3D true;
>  			break;
>  		}

[Severity: Medium]
This is a pre-existing issue and was not introduced by the patch under revi=
ew.
Does the same command smuggling vulnerability still exist for continuation
lines?

Looking further down in do_batch(), continuation lines are handled similarl=
y:

tools/bpf/bpftool/main.c:do_batch() {
    ...
    while ((cp =3D strstr(buf, "\\\n")) !=3D NULL) {
        if (!fgets(contline, sizeof(contline), fp) || ...)
            ...
        cp =3D strchr(contline, '#');
        if (cp)
            *cp =3D '\0';

        if (strlen(buf) + strlen(contline) + 1 > sizeof(buf)) {
            p_err("command %u is too long", lines);
    ...
}

If a continuation line exceeds the buffer size and contains a '#' character
within the first 4095 bytes, it will be prematurely truncated before the
length check.

Because this artificially reduces strlen(contline), doesn't this bypass the
bounds check and leave the unread remainder of the overlong continuation li=
ne
in the file stream to be executed as an unintended command?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260810073348.2586=
225-1-chenyuan_fl@163.com?part=3D3
