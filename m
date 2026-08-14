Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BF1B423EA7;
	Fri, 14 Aug 2026 07:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786693778; cv=none; b=py+xVfBi+g2ZN6wI88wNjASnE7YeXiIDNTAfCRpKr8aFzvMEu4a9uCz0y7dm5abk1N0b+3pgrKqsiD8YbMRP0bxK/ZTEMrhMdheHIgXVyIeOvOSu+NtYIpgf18hZVIgnCsUFMyrbpAQzkgmny43mSQIHiAG6qWHKLn+5Dm+W6rI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786693778; c=relaxed/simple;
	bh=o1xLSAipLkDNdf2UfqEkdi7+U/Fv8iTC3b6zbBXgN10=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=QQK23KOL+/p9SJ0TRjeG6sLND0yFA63wxPItgWvKKBajldczRydrviPaYIBLdaoxbu3D2yMhp28KDUULmInWS05CgqZJOB0DTBzZF7GbbIGImV0Cwy1n7cM3vzKcb++PhR7PnwiMMmkkQnHdZTNZBNQFeTjnF295MyUtCJH1hKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=izihtpJn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="izihtpJn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2CD61F00A3D;
	Fri, 14 Aug 2026 07:49:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786693774;
	bh=s64dBOTKC0R6E1PAHslQ47N2gTinmRmUQXE/JZOLjVQ=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=izihtpJnESnAyiI1SJdyCXP/cns5ZMckczkHdGiFhviD//mwIWurXKlwblSbb6bDn
	 v4tDx1Oogg2y1quQpMe3EfhpvOeNrMaA9rRYF6O4YcHJINeXBLSG9C2ddScvf8wg73
	 hShwnHjz1wHetR52g11I5Zs4fDoAMU1JQEYBNhFbleB6od/xiSEf5zwl1gqATQWBZA
	 sCPt5b/E6U1l49I6kaQ9M6mJalAxGJjd0V+S5DSqHekxjgTkaa4f0dhqXuiMOftVQ6
	 vG6q3ZKDqMd4jcZdRerisr2GV/QU1eKrXWUpkZzaXarbjbE+e2L63T346r/dtw3liu
	 jYNkD7BhGcI8A==
Content-Type: multipart/mixed; boundary="===============7332989385545228721=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <cb911f14067c913d58871b63b709ca20ba9fcf445025cd8092cb8f0f98af87be@mail.kernel.org>
In-Reply-To: <20260814-tc_tunnel_flaky-v5-2-5b93d030c42c@bootlin.com>
References: <20260814-tc_tunnel_flaky-v5-2-5b93d030c42c@bootlin.com>
Subject: Re: [PATCH bpf v5 2/2] selftests/bpf: allocate a larger timeout for connection
From: bot+bpf-ci@kernel.org
To: alexis.lothore@bootlin.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,shuah@kernel.org,ihor.solodrai@linux.dev
Cc: ebpf@linuxfoundation.org,bastien.curutchet@bootlin.com,thomas.petazzoni@bootlin.com,bpf@vger.kernel.org,linux-kselftest@vger.kernel.org,linux-kernel@vger.kernel.org,alexis.lothore@bootlin.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri, 14 Aug 2026 07:49:33 +0000 (UTC)

--===============7332989385545228721==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testing/selftests/bpf/network_helpers.c
> index d311db786880..ed4aeee1555d 100644
> --- a/tools/testing/selftests/bpf/network_helpers.c
> +++ b/tools/testing/selftests/bpf/network_helpers.c

[ ... ]

> @@ -291,6 +293,12 @@ int client_socket(int family, int type,
>  	return -1;
>  }
>
> +static int connect_timeout_ms(const struct network_helper_opts *opts)
> +{
> +	/* Enforce a minimum connect timeout value */
> +	return MAX(opts->timeout_ms, CONNECT_MIN_TIMEOUT_MS);
> +}
> +
>  int connect_to_addr(int type, const struct sockaddr_storage *addr, socklen_t addrlen,
>  		    const struct network_helper_opts *opts)
>  {
> @@ -305,13 +313,35 @@ int connect_to_addr(int type, const struct sockaddr_storage *addr, socklen_t add
>  		return -1;
>  	}
>
> +	/*
> +	 * Override timeout configuration with a larger value for the
> +	 * connection
> +	 */
> +	if (settimeo(fd, connect_timeout_ms(opts))) {
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
> +	/*
> +	 * If the timeout configured by the test is different from the
> +	 * connect timeout, restore it
> +	 */
> +	if (opts->timeout_ms != CONNECT_MIN_TIMEOUT_MS &&
> +	    settimeo(fd, opts->timeout_ms)) {
> +		log_err("Failed to set timeout for connected socket");
> +		goto close;
                     ^^^^

Does this condition match what the comment describes? The value applied
to the socket before connect() is connect_timeout_ms(opts), which returns
MAX(opts->timeout_ms, CONNECT_MIN_TIMEOUT_MS). The guard tests
opts->timeout_ms != CONNECT_MIN_TIMEOUT_MS, so the two expressions only
match when opts->timeout_ms <= CONNECT_MIN_TIMEOUT_MS.

When a test passes a timeout larger than the minimum, the guard fires even
though the socket already has the right value. For example,
prog_tests/xdp_synproxy.c calls connect_to_fd(server_fd, 10000).
connect_timeout_ms() returns 10000, settimeo() applies 10000, then the guard
(10000 != 5000) is true and settimeo() re-applies the same 10000 value the
socket already has.

Would opts->timeout_ms != connect_timeout_ms(opts) express the stated
intent? That guard would be false when opts->timeout_ms == 10000 (nothing
to restore), and true when opts->timeout_ms < CONNECT_MIN_TIMEOUT_MS
(restore the smaller value the test asked for).

> +	}
> +
>  	return fd;
> +
> +close:
> +	save_errno_close(fd);
> +	return -1;
>  }


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/31779510003
--===============7332989385545228721==--
