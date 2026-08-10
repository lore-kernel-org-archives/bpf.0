Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D85182D781B
	for <bpf@vger.kernel.org>; Mon, 10 Aug 2026 08:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786350739; cv=none; b=nst+OetnuqJ/IPBkUI06hPc5NKbqsSTzJAtmFDZoFUqOMBXq9rqJm/cWgLfmA3uuDCmewPKQQQjAlIxyeUrd5s3TtbfewxCm9Q15Fd/GG9u4D+srB3BRcTx8/gr6ShrzWYZbn7znFfhOwqq87bpa8DEYvyy3nTOwSws9dM9s04I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786350739; c=relaxed/simple;
	bh=rUg6eNTDLzOCqcxwfTRscdRmNteSEsen7KhCwpXerfc=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=FmwqZCNNnFWYftBaz+rUgEKneAq2s3lLFICtLOWlTJ6sBV667GdgP79ZreFlAjzTu1VD2ATmXx1xl1GN4yKzVUp5TQd/K5qI0Y1F81qks/wDhY8gHnv4Rbg5gYap9k0MlsF9+iFFxLi1l1LtNmDLE9SAgGPnhaLSkhdgmWUsqw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aVmGrlSb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aVmGrlSb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06DF91F000E9;
	Mon, 10 Aug 2026 08:32:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786350738;
	bh=gENWeYQxb+W+a4UHVEgN2OEDYpZDzMOsCtKnpaa+F5Y=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=aVmGrlSbMJU40cZvs2NFSCOJyjOIQ+04eWsht6Rm31hzjjn0BYQrJ10chzICSYiR1
	 KFzKdu1h2YN2Zr6N5qLG0qJizAfvTcfWL+pDHDCwWs7W6BmJSmVld0B/E3n8dOJb5w
	 rck8Reii3/2XpyvoAd7QVbLaCFEQrltWTzuExaaV3UwJKmK6wwo0dl2Na2azW4oKDX
	 acW/+9ZDkjAcnUX3gMVXFnb6lGmFlhgRlUzuJGy/7dTT2UtXrrPyNx8RUw1htMufBg
	 8yMQ8v8Mr1qPSBenWrUR0zuZHaj26Z31IRV/F9VxjNV1XpgVS0b3cbPstpU0RhKYSm
	 wmypEuYacWxSw==
Content-Type: multipart/mixed; boundary="===============8360869251992057636=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <7bc009c8016f6c38f063064ae529893180895aadb8da317bfd917a608468d1a8@mail.kernel.org>
In-Reply-To: <20260810073348.2586225-3-chenyuan_fl@163.com>
References: <20260810073348.2586225-3-chenyuan_fl@163.com>
Subject: Re: [PATCH bpf-next v3 2/3] bpftool: fix spurious batch file read error
From: bot+bpf-ci@kernel.org
To: chenyuan_fl@163.com,bpf@vger.kernel.org
Cc: qmo@kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,chenyuan@kylinos.cn,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon, 10 Aug 2026 08:32:17 +0000 (UTC)

--===============8360869251992057636==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/bpf/bpftool/main.c b/tools/bpf/bpftool/main.c
> index c91e1a6e1a1e..c9a86039c400 100644
> --- a/tools/bpf/bpftool/main.c
> +++ b/tools/bpf/bpftool/main.c

[ ... ]

> @@ -429,7 +430,10 @@ static int do_batch(int argc, char **argv)
>  		lines++;
>  	}
>
> -	if (errno && errno != ENOENT) {
> +	if (line_too_long) {
> +		p_err("reading batch file failed: %s", strerror(E2BIG));
> +		err = -1;
> +	} else if (ferror(fp)) {
>  		p_err("reading batch file failed: %s", strerror(errno));
>  		err = -1;
>  	} else {

[ ... ]

This isn't a bug, but now that the batch read check uses ferror() rather
than errno, is the USE_LIBCAP errno = 0 reset in main() still needed?

Looking at main():

#ifdef USE_LIBCAP
	/* Libcap < 2.63 hooks before main() to compute the number of
	 * capabilities of the running kernel, and doing so it calls prctl()
	 * which may fail and set errno to non-zero.
	 * Let's reset errno to make sure this does not interfere with the
	 * batch mode.
	 */
	errno = 0;
#endif

The comment says the reset is specifically to prevent interference with
batch mode, but do_batch() no longer checks errno to detect read failures.
Could this block be dropped alongside the ferror() change?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/31367518511
--===============8360869251992057636==--
