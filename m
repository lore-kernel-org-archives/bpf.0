Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F3E344E678;
	Mon, 17 Aug 2026 20:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786997648; cv=none; b=ktjAchPv+59lZVvSffKJXVF5nt1W6l/U/tWwpK3VTOakTsxGxMv8725l9yg/gsTZwy8v7Eat3eE7urVABuNyRX7mtdPeqBe+6VCDBfdlLEdDVxtASwG6mRwqM/fhVewbxJWyJDty8FY1Qz4xr6K4YsSS9d7acXc1QKaj0r6SLRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786997648; c=relaxed/simple;
	bh=MKAJTs4N20chRMx11ir24sEGxfvLBVvzTI4RLgwfzK8=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=E5a/VvVrFm75yeKslDqukiPC99lWBA3AWbTgCQp4ob/a+lH/laWsPlcakmcC+9iU2MlIX46RAowq6Trqc2vZqZWgw24z8/7P2ldAZr4atYepgRnd152AUoDSbFMnfcbPGiFfdRJlKNPdPzaEkiFqs8/Bb0DrV26gAqSN5Gvdg2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WCtGvW0U; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WCtGvW0U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3437C1F000E9;
	Mon, 17 Aug 2026 20:14:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786997647;
	bh=sm5ecoGDsVrlrsmLrRZTgm/GCM0BDVcP6qlE+u0dDto=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=WCtGvW0UxYn14utiR4TdgB2fCAiK6EmTM/m/B5V2HpCDGwIIBDobjSqww27mX8v+W
	 uG7Gwz2XUhx6H/we9vg9GGgKFKeXDgppQuEnH9jMCSrjuiWEfKoks7izsp7xb74kUS
	 SlklJMJBsXoxc3/WG3da5jkFDEDDjpaOtPGLp3VhatmPkpbhk64z1UjX+GTVIwny9x
	 KubfHxoPSy8W/kee0dlZ5j2neBvxePX7c/uoivNSxisp+zmFFWZTwlk0ZQGyUTTNxT
	 ggsNb1YqHai2IlhPW0S7QStBXw1WUFrH8+gaUc1+DPxtMvAX0Q262X431qDVCol0IQ
	 kJOXxFFWtrBVw==
Content-Type: multipart/mixed; boundary="===============7027275377149721589=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <c7945c532eb31abc4d3fbbd0720d7a1f47eff936621cf8d11ecdfd9aeef27f93@mail.kernel.org>
In-Reply-To: <20260817-tc_tunnel_flaky-v6-1-c02ccde847f2@bootlin.com>
References: <20260817-tc_tunnel_flaky-v6-1-c02ccde847f2@bootlin.com>
Subject: Re: [PATCH bpf v6] selftests/bpf: allocate a larger timeout for connection
From: bot+bpf-ci@kernel.org
To: alexis.lothore@bootlin.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,shuah@kernel.org
Cc: ebpf@linuxfoundation.org,bastien.curutchet@bootlin.com,thomas.petazzoni@bootlin.com,bpf@vger.kernel.org,linux-kselftest@vger.kernel.org,linux-kernel@vger.kernel.org,ihor.solodrai@linux.dev,alexis.lothore@bootlin.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon, 17 Aug 2026 20:14:06 +0000 (UTC)

--===============7027275377149721589==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testing/selftests/bpf/network_helpers.c
> index b82f572641b7..1fda1fa7281c 100644
> --- a/tools/testing/selftests/bpf/network_helpers.c
> +++ b/tools/testing/selftests/bpf/network_helpers.c

[ ... ]

> @@ -291,6 +293,37 @@ int client_socket(int family, int type,
>  	return -1;
>  }
>
> +static int connect_with_timeout(int fd, const struct sockaddr_storage *addr,
> +				socklen_t addrlen, int timeout_ms)
> +{
> +	int connect_timeout_ms = MAX(timeout_ms, CONNECT_MIN_TIMEOUT_MS);
> +
> +	/*
> +	 * Override timeout configuration with a larger value for the
> +	 * connection
> +	 */
> +	if (settimeo(fd, connect_timeout_ms)) {
> +		log_err("Failed to set connect timeout");
> +		return -1;
> +	}
> +
> +	if (connect(fd, (const struct sockaddr *)addr, addrlen)) {
> +		log_err("Failed to connect");
> +		return -1;
> +	}
> +
> +	/*
> +	 * If the timeout configured by the test is different from the
> +	 * connect timeout, restore it
> +	 */

This isn't a bug, but do the two block comments here add anything over
the code they sit above? The first sits above settimeo(fd,
connect_timeout_ms) where connect_timeout_ms was computed with MAX(...,
CONNECT_MIN_TIMEOUT_MS) on the line before. The second transliterates
the condition on the line below (timeout_ms != connect_timeout_ms means
"restore it"). Could they be trimmed to a single line about why a larger
connect budget is needed?

> +	if (timeout_ms != connect_timeout_ms && settimeo(fd, timeout_ms)) {
> +		log_err("Failed to set timeout for connected socket");
> +		return -1;
> +	}
> +
> +	return 0;
> +}

[ ... ]

> @@ -376,20 +408,14 @@ int connect_fd_to_fd(int client_fd, int server_fd, int timeout_ms)
>  	struct sockaddr_storage addr;
>  	socklen_t len = sizeof(addr);
>
> -	if (settimeo(client_fd, timeout_ms))
> -		return -1;
> -
>  	if (getsockname(server_fd, (struct sockaddr *)&addr, &len)) {
>  		log_err("Failed to get server addr");
>  		return -1;
>  	}
>
> -	if (connect(client_fd, (const struct sockaddr *)&addr, len)) {
> -		log_err("Failed to connect to server");
> -		return -1;
> -	}
> -
> -	return 0;
> +	return connect_with_timeout(client_fd,
> +				    &addr, len,
> +				    timeout_ms);
                            ^^^^

This isn't a bug, but could this call fit on one line? With the leading
tab it comes to about 71 columns as a single statement, well inside the
80-column limit. Elsewhere the file only wraps arguments when the line
doesn't fit.

>  }


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/32062499118
--===============7027275377149721589==--
