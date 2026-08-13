Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 985933AA9D1;
	Thu, 13 Aug 2026 10:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786617187; cv=none; b=Ws8cz4hpm58/xo7QAL3GH/Y+M0fU/SJXmt3ng4KwE2wP4bSiAMuq6RQFjKUfOeY24qpxn6yN1p9J9HKbrl6g+psPqguUxLkM8h6J5w803mBirRCY9WEE33bTQ+s4jaSqExjm63xVwZ5imHD2a2mUt4x23PHoH2rxSdEKQIHBqq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786617187; c=relaxed/simple;
	bh=ZG3vl6wp/emp5KZpbDVqu3kKe4mWDV5/Yv1gPF7xwEk=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=tsYwl5MVbHqN9ESU+74RAGIynvDFfR5nY6namDD5jy8nms8uJ1PTcGk1JviG3YSBP0S7PkpOLvDtwtYcoadabNWrK1c3Y6hMBadByHJGhCHkMu5HD56w4nqyVdnVbDZTicrKy70jK/tKz3ySD63t7VGQhuw7AjsuZZwTCKhjoi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q+no/3Jo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q+no/3Jo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24D291F000E9;
	Thu, 13 Aug 2026 10:33:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786617186;
	bh=aumptI8Km+TSQnEtfKraKsMkywUpL+OFHEcwC7HyLaY=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=Q+no/3JoaJffiWF8+C9CMVorFWUvOIz5AMILkDPRGCljWhSJlZSsUs+zdjtZdChj6
	 hPJXtV5iYR6+mLahCRoOufGBAEjSm4zXbe7WuN9dnufroaWSzxyKrrfJoyqIdJn1S0
	 UjrFiIsMTT0vaCLD1JuKeb6EOXhzqqfSxQ5Pjt5lnfo1wgN7VKV5mwHoezEVhsLAqI
	 i+MB2blDZYqUgMonpHh2b9mpzOF0B92vIT1mvXpn6Cvb6Cq0iltTFVqWQWFQ+mMfi3
	 ort23SidY+cyZcILF1r7GhZD0VvSwJE9bc8yiaVf+5Q1cqJ/ZMdP+6PCUATP/TLZPJ
	 3ZqonlJU789iA==
Content-Type: multipart/mixed; boundary="===============5507318827023917187=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <5485fa0008f289c8cc299b9e382dfc12f275d92c82944d48dc4e311ee3d17409@mail.kernel.org>
In-Reply-To: <20260813-tc_tunnel_flaky-v4-1-3534df3fe930@bootlin.com>
References: <20260813-tc_tunnel_flaky-v4-1-3534df3fe930@bootlin.com>
Subject: Re: [PATCH bpf v4] selftests/bpf: allocate a larger timeout for connection
From: bot+bpf-ci@kernel.org
To: alexis.lothore@bootlin.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,shuah@kernel.org
Cc: ebpf@linuxfoundation.org,bastien.curutchet@bootlin.com,thomas.petazzoni@bootlin.com,bpf@vger.kernel.org,linux-kselftest@vger.kernel.org,linux-kernel@vger.kernel.org,alexis.lothore@bootlin.com,ihor.solodrai@linux.dev,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu, 13 Aug 2026 10:33:05 +0000 (UTC)

--===============5507318827023917187==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testing/selftests/bpf/network_helpers.c
> index b82f572641b7..dd33bcdf75d7 100644
> --- a/tools/testing/selftests/bpf/network_helpers.c
> +++ b/tools/testing/selftests/bpf/network_helpers.c

[ ... ]

> @@ -305,13 +313,33 @@ int connect_to_addr(int type, const struct sockaddr_storage *addr, socklen_t add
>  		return -1;
>  	}
>
> +	/* Override timeout configuration with a larger value for the
> +	 * connection
> +	 */
> +	if (settimeo(fd, connect_timeout_ms(opts))) {

A subsystem pattern flags this as potentially concerning:

Both multi-line comments added by this change start their text on the
same line as the opening '/*'. The loaded BPF subsystem guide requires
the opening '/*' to sit on its own line for files under
tools/testing/selftests/bpf/.

The guide specifies: "Multi-line comments MUST have the opening /* on
its own line, with the comment text starting on the next line."

However, this file contains 8 pre-existing multi-line comments (at
lines 455, 896, 1064, 1070, 1076, 1110, 1181, 1286) and every one puts
text on the opening '/*' line; there are zero instances of the form the
guide prescribes. Across tools/testing/selftests/bpf/ the ratio is
roughly 1986 to 689 in favour of the style used here.

Should these comments match the guide's requirement, or is the local
convention the right choice for this file?

> +		log_err("Failed to set connect timeout");
> +		goto close;
> +	}
> +
>  	if (connect(fd, (const struct sockaddr *)addr, addrlen)) {
> -		log_err("Failed to connect to server");
> -		save_errno_close(fd);
> -		return -1;
> +		log_err("Failed to connect");
> +		goto close;
> +	}
> +
> +	/* If the timeout configured by the test is different from the
> +	 * connect timeout, restore it
> +	 */
> +	if (opts->timeout_ms != CONNECT_MIN_TIMEOUT_MS &&
> +	    settimeo(fd, opts->timeout_ms)) {
> +		log_err("Failed to set timeout for connected socket");
> +		goto close;
> 	}
>
>  	return fd;
> +
> +close:
> +	save_errno_close(fd);
> +	return -1;
>  }


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/31688637156
--===============5507318827023917187==--
