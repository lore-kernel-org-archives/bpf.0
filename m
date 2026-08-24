Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78FD63FB07B
	for <bpf@vger.kernel.org>; Mon, 24 Aug 2026 10:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787565779; cv=none; b=LKDHUXvFf2QbQxsM33gLvtsBPJW0fnbCMwDVNqATO92skqotSQAPxhFuPf08agBje+PjgUWUs9tIHtgapKBnNYPuVt4NdHOErh9LSoPPM14tUbNiQh+/ZStJ9B/gmMEXgb6wT4QBhTBH7P3aaDB2+8+MlaVZZgJyKcgsWmyuNUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787565779; c=relaxed/simple;
	bh=CyXh99nJVh4YHtjtd5KjlCiBiMwLbXppdMbZN9c4Eu4=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=pJdhX7PWlBYeVnnZZdvURRnrcO4Cr3s3/eck2/bn1XaMQHNTJRXB7+H3PdYdH7YXPbY2Ht0G/f7ltSVxoqXOfiNbVSoJqyyCNGv1mfMYML5QYkH49rOhzmXhhZGeJV4n3P5+upmTShn3OKA60dcR+puYN8aQUgv/zfZTV8WGxZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c7A8KBXU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c7A8KBXU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C91971F000E9;
	Mon, 24 Aug 2026 10:02:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787565778;
	bh=f8Q0tMJvFokQucJtUUDl41nPcq0e/gR1KmgyPyO5vSY=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=c7A8KBXUDYrpyLPlSg1Bqg5zBhiDyJH/ojKLaz+QZ9QPZruR2bqL14vO0fBpiiCC+
	 owzopFL9uU2nm84PeRZ01Egpw44/uSJm5eOuNLC9bdjBh34OYZ37yikkaSLHay5ZAQ
	 uqOiG11FwPDpWwBoCbMaf2Jx6fZDKbMf+41jQiUBihk+P/kUC8T30fPE6nsNIhVXWz
	 zRFT19Z3TYp7N38rUhGkbEp+jlW2+zcTtCe0ipbX3diW8IUWbc7Hu72BD7b3q3NF7Z
	 ldIHWzoT3v5ZHIMUq/2Cj34YYl3f/gAJFvr/V4oUmQZyuz/NFMrZVGz2Iv7epQGaqu
	 6zzD69wxlVZ9Q==
Content-Type: multipart/mixed; boundary="===============8895680357147544790=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <cd8d37561a1cc725fb9c430ea234be45176942964d246b435c441d640ad8d824@mail.kernel.org>
In-Reply-To: <20260824092657.1789956-2-chenyuan_fl@163.com>
References: <20260824092657.1789956-2-chenyuan_fl@163.com>
Subject: Re: [PATCH bpf-next v6 1/2] bpftool: fix spurious batch file read error
From: bot+bpf-ci@kernel.org
To: chenyuan_fl@163.com,bpf@vger.kernel.org
Cc: qmo@kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,andrii.nakryiko@gmail.com,chenyuan_fl@163.com,chenyuan@kylinos.cn,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon, 24 Aug 2026 10:02:57 +0000 (UTC)

--===============8895680357147544790==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/bpf/bpftool/main.c b/tools/bpf/bpftool/main.c
> index c91e1a6e1a1e..7a0c214f08a0 100644
> --- a/tools/bpf/bpftool/main.c
> +++ b/tools/bpf/bpftool/main.c
> @@ -365,7 +365,11 @@ static int do_batch(int argc, char **argv)
>
>  	if (json_output)
>  		jsonw_start_array(json_wtr);
> -	while (fgets(buf, sizeof(buf), fp)) {
> +	for (;;) {
> +		errno = 0;
> +		if (!fgets(buf, sizeof(buf), fp))
> +			break;
> +

[ ... ]

>  		if (errno && errno != ENOENT) {
>  			p_err("reading batch file failed: %s", strerror(errno));
>  			err = -1;

This isn't a bug, but now that errno is cleared before each fgets() and the
post-loop check only sees the last fgets() outcome, is the errno != ENOENT
exemption still needed?

Looking at the code, fgets() and read() cannot fail with ENOENT. The
exemption was load-bearing before this change: commands like map show
(map.c:740), link show (link.c:1356), and map dump (map.c:875) all return
with errno == ENOENT, and the exemption prevented those stale values from
triggering false failures. This patch fixes that at the source by clearing
errno before each read.

Would dropping the errno != ENOENT check here (similar to how the
USE_LIBCAP reset is removed) make the intent clearer?

>
> @@ -467,16 +471,6 @@ int main(int argc, char **argv)
>
>  	setlinebuf(stdout);
>
> -#ifdef USE_LIBCAP
> -	/* Libcap < 2.63 hooks before main() to compute the number of
> -	 * capabilities of the running kernel, and doing so it calls prctl()
> -	 * which may fail and set errno to non-zero.
> -	 * Let's reset errno to make sure this does not interfere with the
> -	 * batch mode.
> -	 */
> -	errno = 0;
> -#endif
> -
>  	last_do_help = do_help;
>  	pretty_output = false;
>  	json_output = false;

This isn't a bug, but could the changelog use an example that still
reproduces on current bpf-next?

The commit message cites "map dump's EBADF from a double close" as the
example of a stale errno:

>     do_batch() checks errno after the read loop to detect read failures,
>     but fgets() does not clear errno on success, so a stale errno left by
>     a previously executed command (e.g. map dump's EBADF from a double
>     close) makes bpftool report a batch file read failure and exit with an
>     error even though every command succeeded.

Looking at the current code, map_dump() no longer closes the fd
(tools/bpf/bpftool/map.c:893-898 just has exit_free: free(key);
free(value); free_map_kv_btf(btf);), and do_dump() is the sole owner
(map.c:941-962). So there's no double close and no EBADF left behind.

A successful map dump actually leaves errno == ENOENT from
bpf_map_get_next_key() exhaustion (map.c:874-877), which the existing
errno != ENOENT exemption already suppressed. This means map dump isn't
actually a command that could have triggered the symptom described.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/32712601990
--===============8895680357147544790==--
