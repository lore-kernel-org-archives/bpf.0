Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB5582D781B
	for <bpf@vger.kernel.org>; Mon, 10 Aug 2026 08:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786350742; cv=none; b=BgRljHEiHHs+RR3/1Jr0pf+38ZSKzUawEAnJ9ZQ5VZKybH5HdY8gGdoajFBprTESckcql5U6rTNGOsXzi+g587IHjxSYdDEtiiVrFw73g0akdbKXckV90GBFRUS7hUAMt4tF/ztOg44YNNfU6MSDtNPL16o1zm9+kNBlJocwYVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786350742; c=relaxed/simple;
	bh=uP6Pp/g26cEOzGswRFWWVoG9C1vfV9EFmgV/OqaqAwo=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=Bd6MHnu/LgJXpQOp9TIwb/FGDudYJEn9PG4GYekhsAmAbej8Wy5obDmJciyGCSCM0VzFhPyNbksUgaMm4Q2A9lL9D7HFfbDQXkMDW20u6N5o6tBVVpS1Ki2evnURfpAGrZUaf+ScLR5698s8G9lKB0egIG6z0vD0sBXFZml88mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FZ2p0FtS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FZ2p0FtS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1B661F00A3A;
	Mon, 10 Aug 2026 08:32:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786350740;
	bh=SN0vQvXVvuiTZPHT2ARE4D4pk7DOwco3HKQ2F7tHaFA=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=FZ2p0FtSMAkez5SfgHDmH0TYezMA+1Ou1HpobbcfMDCLmB+fopqKGI1VmPjcNuNr2
	 46nICCIHwtdWsuyBZWJ2HRthhAhJC623kTRQxXoybVBSCxhsrSC3V/rj6xVSAwJnO3
	 +4AYStUreqE6ucoCr5yOTtUxRZHny/NYU2R4OFw7fF1+RUwQ+FYqZazwRZg3bvk5Ei
	 /+YtCxfDm3TbL+GEP/2oPjX2IEf8DXCu8Nt2PpixHzxHDdbyrdoAuMQMRLa9A5IcyX
	 TpNQXs8WrtRv9ScX8qDYDujj33kDQEY4knuh6G1RgYLjHILsr6o+5S/Ww+JRXlrA6J
	 pJ5Ktx3LHYsdA==
Content-Type: multipart/mixed; boundary="===============3649084657726964854=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <65c07088611a285e338e350112539d876155297c79245de24a83afb50e1bb161@mail.kernel.org>
In-Reply-To: <20260810073348.2586225-4-chenyuan_fl@163.com>
References: <20260810073348.2586225-4-chenyuan_fl@163.com>
Subject: Re: [PATCH bpf-next v3 3/3] bpftool: Fix bypass of the batch line length check by comments
From: bot+bpf-ci@kernel.org
To: chenyuan_fl@163.com,bpf@vger.kernel.org
Cc: qmo@kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,chenyuan@kylinos.cn,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon, 10 Aug 2026 08:32:19 +0000 (UTC)

--===============3649084657726964854==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

>     Fixes: 71bb428fe2c1 ("tools: bpf: add bpftool")
>     Signed-off-by: Yuan Chen <chenyuan@kylinos.cn>

Does the Fixes: tag point to the right commit?

The bug being fixed is the ordering of the comment strip relative to the
line-length check. In commit 71bb428fe2c1 ("tools: bpf: add bpftool")
do_batch() had no '#' handling at all; the loop body started with the
length check immediately after fgets():

    while (fgets(buf, sizeof(buf), fp)) {
            if (strlen(buf) == sizeof(buf) - 1) {
                    errno = E2BIG;
                    break;
            }

So an overlong line was correctly rejected with E2BIG and the bypass
described in the changelog was not possible.

The defect was introduced by commit 06cc7fe7c295 ("tools: bpftool: support
comments in batch files"), which inserted the truncation directly above
that check:

    while (fgets(buf, sizeof(buf), fp)) {
    +       cp = strchr(buf, '#');
    +       if (cp)
    +               *cp = '\0';
    +
            if (strlen(buf) == sizeof(buf) - 1) {

That is the commit that made strlen(buf) shrink before the length test,
which is exactly what this patch reorders. The tag should read:

    Fixes: 06cc7fe7c295 ("tools: bpftool: support comments in batch files")

This also matters for stable backport scope: 71bb428fe2c1 landed in v4.15
while 06cc7fe7c295 landed in v4.16, so the current tag widens the backport
range to a kernel where the bug is absent.

Note the parent commit fbbb15fafea3 ("bpftool: fix spurious batch file read
error") does correctly carry Fixes: 71bb428fe2c1, since the errno-based
check it replaces was present in that commit; the tag appears to have been
carried over unchanged into this patch.

The code change itself is correct: recording 'truncated' from fgets()
before the '#' strip makes the E2BIG rejection independent of comments,
and the new local is block-scoped inside the loop body so it is
re-initialized on every iteration.

> diff --git a/tools/bpf/bpftool/main.c b/tools/bpf/bpftool/main.c
> index c9a86039c400..c77e66bffbc9 100644
> --- a/tools/bpf/bpftool/main.c
> +++ b/tools/bpf/bpftool/main.c
> @@ -367,11 +367,13 @@ static int do_batch(int argc, char **argv)
>  	if (json_output)
>  		jsonw_start_array(json_wtr);
>  	while (fgets(buf, sizeof(buf), fp)) {
> +		bool truncated = strlen(buf) == sizeof(buf) - 1;
> +
>  		cp = strchr(buf, '#');
>  		if (cp)
>  			*cp = '\0';
>
> -		if (strlen(buf) == sizeof(buf) - 1) {
> +		if (truncated) {
>  			line_too_long = true;
>  			break;
>  		}


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/31367518511
--===============3649084657726964854==--
