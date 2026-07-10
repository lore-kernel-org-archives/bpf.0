Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B65424E4C6;
	Fri, 10 Jul 2026 17:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783704793; cv=none; b=fNBSkTpJq29qtXbtX4rZD8Vnp57F+FzaXxVgPNXqyCELHIzSzPLTypPRIPcqLmK4H1EbCYsv5nM1dvxTHCFL/ftHwsP7ve4DYme/+kMgloeYsH83zpsFz7lhYoPY6mR99ZQdGE0VU77T7AEB+fIRsgnzHMJ9PRNo8xNfPUR+A18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783704793; c=relaxed/simple;
	bh=UJd/lifO1h0XitO6NT3vGGEKpw/eqLw9ZhxfAXrAsPw=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=pLek6cAr/Xf9AXDIbfwl/zp95cIBfYkOr2K2kXWwtzSO1x0NuLvrDJzgEdYrX1H0JzDemHF8z1u4bNXHs3/KFpVxD3nXXzPR3vpy3QqpcaoyqemzF7pm1Axur7rpDsUTDaEkuJLsE+x+hN5e6MHslEtOYwcLSrfQ4KrOE9kmiA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FFvs++jZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FFvs++jZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54F421F000E9;
	Fri, 10 Jul 2026 17:33:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783704791;
	bh=4gNuVtfUygql4wlr6WnLsGdK2iQ/6LjP/qz20++PmCo=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=FFvs++jZW9HMGOG+7jXgjZ+BnBDxbPIn1Mr64ntSj3fuSkkxUublHnhPWtXWHJ8qj
	 v+NSbmTaPGdPQhTs7RLg20vaoutJzyIGsMWj2D8x/gOOZCvKAlUZqI475e8HijyVwx
	 YWFfRgxMmDGZxgmvv7pKY43rxN/76tTfR8Nwd+iTcrXHSEjThjrnsid/yi4CGpaSjP
	 U0sds/+99iWScCmBDQTbRiS74+73RzP3J+qTUhksGYqWAwnKYJCR/MjgIGcxJYdp2B
	 wGDuZ5yXs24sEhNM4hL5+pc8H9Fhd/4SWbrzoFtuT4L5tS2iyh1XYuY26UufhfR9Nr
	 avNa721GdoE5A==
Content-Type: multipart/mixed; boundary="===============4403372005652049611=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <35e5413b43191284440eea77999ac72ceba991460975b3b7cb7d32c8e43f087a@mail.kernel.org>
In-Reply-To: <20260710-tc_tunnel_flaky-v1-1-42aab5399a49@bootlin.com>
References: <20260710-tc_tunnel_flaky-v1-1-42aab5399a49@bootlin.com>
Subject: Re: [PATCH bpf] selftests/bpf: keep polling connection that is still in progress
From: bot+bpf-ci@kernel.org
To: alexis.lothore@bootlin.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,shuah@kernel.org
Cc: ebpf@linuxfoundation.org,bastien.curutchet@bootlin.com,thomas.petazzoni@bootlin.com,bpf@vger.kernel.org,linux-kselftest@vger.kernel.org,linux-kernel@vger.kernel.org,alexis.lothore@bootlin.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri, 10 Jul 2026 17:33:11 +0000 (UTC)

--===============4403372005652049611==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testing/selftests/bpf/network_helpers.c
> index b82f572641b7..97ddbe589e53 100644
> --- a/tools/testing/selftests/bpf/network_helpers.c
> +++ b/tools/testing/selftests/bpf/network_helpers.c

[ ... ]

> @@ -305,13 +309,42 @@ int connect_to_addr(int type, const struct sockaddr_storage *addr, socklen_t add
>  		return -1;
>  	}
>
> -	if (connect(fd, (const struct sockaddr *)addr, addrlen)) {
> -		log_err("Failed to connect to server");
> -		save_errno_close(fd);
> -		return -1;
> +	err = connect(fd, (const struct sockaddr *)addr, addrlen);
> +	if (err && errno == EINPROGRESS) {
> +		struct pollfd pfd = { .fd = fd, .events = POLLOUT };
> +
> +		err = 0;
> +		err = poll(&pfd, 1, CONNECTION_IN_PROGRESS_TIMEOUT_MS);

This isn't a bug, but the err = 0; here is immediately overwritten by the
poll() result on the very next line:

	err = 0;
	err = poll(&pfd, 1, CONNECTION_IN_PROGRESS_TIMEOUT_MS);

Could the err = 0; assignment be dropped?

> +
> +		if (err <= 0) {
> +			if (err == 0) {
> +				log_err("Connection timeout");
> +				errno = ETIMEDOUT;
> +			} else {
> +				log_err("Failed to poll connection status");
> +			}
> +			goto close;
> +		}
> +
> +		errlen = sizeof(err);
> +		if (getsockopt(fd, SOL_SOCKET, SO_ERROR, &err, &errlen) < 0) {
> +			log_err("Failed to getsockopt");
> +			goto close;
> +		}
> +
> +		if (err) {
> +			log_err("Failed to connect to server");
> +			errno = err;
> +			goto close;
> +		}
> +	} else if (err) {
> +		goto close;
>  	}
>
>  	return fd;
> +close:
> +	save_errno_close(fd);
> +	return -1;
>  }


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/29109351717
--===============4403372005652049611==--
