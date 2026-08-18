Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42BC5346E7D;
	Tue, 18 Aug 2026 19:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787080986; cv=none; b=J/INgsNV1Tn58kuvmQnNKE14f/yPGh8dRhhouKWWkJRbTCpBoKRrrpIKSjo4g5hOULYps5TZJRvLO+51HzNIBBvc4MhcmK4xZb+KTAnWE7Ldj2lcdSVy+swaWR+3f3j3L7OwK5kcWj4bU8M/w6ezx42BTYVURKzihSznuAvSKqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787080986; c=relaxed/simple;
	bh=lQRxNS4d05kQAqG2bVOvBsIurzMvX6ZwwIQWQU0HLcU=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=qryietR4MoKO0H3+Y9SjaDYK4N2GeFKnYJMtgBDMUnktTdAgP2fnIIu/m+oaBHWHM2/OAV7E+8Gm4UBlWBebp31+XAXEgv+qtqkW2jogLhffb+7CRfmyAwc5YL+Wer9E5h9atdeiXSvKf/MiYai+1qkC0n+RdNioMZS/zVimAmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fP2hBNTN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fP2hBNTN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D4BF1F00A3A;
	Tue, 18 Aug 2026 19:23:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787080985;
	bh=rdmhfD3PiVS3wdrrP9DwnsXChoLTG8E9NJnpYLSxS0g=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=fP2hBNTN+9ytZ36ziE4WBmNhVJj9AWu52C8iqMTLCM8t9VLloTYB+LBPeZU1jaW1Z
	 /vIX+WPolQ8YQ78JbsXIv7bmeXGZ6wImG0CdILebDt2T3pibmgM1gFk35FjI6x55Si
	 l0GenpkD+S7+YIhg8D9MxfL2QNA9w7VDRGdfTzYE6ZmPwUiEtW0uMxhLN1nLX97gNk
	 fythUkmezczOPvTA4omTBfR2NiooWQp2swZX3RdP53ppyapyY7nU0FzsybyQGwIVyY
	 OGYaY+YssVcLDvk8ft9fMdN4Vdlt/fsD8MzpIpE2XqOt3WPuCZXxEUCbnl/kaZaNVq
	 XilG0WV0aZaqA==
Content-Type: multipart/mixed; boundary="===============8883660200475105318=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <60472e2d261b280c49f896716cf5c50d1188c4dc33cf86a5a7139b91078c4e54@mail.kernel.org>
In-Reply-To: <20260818-tc_tunnel_flaky-v7-1-aec161e74ef2@bootlin.com>
References: <20260818-tc_tunnel_flaky-v7-1-aec161e74ef2@bootlin.com>
Subject: Re: [PATCH bpf v7] selftests/bpf: allocate a larger timeout for connection
From: bot+bpf-ci@kernel.org
To: alexis.lothore@bootlin.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,shuah@kernel.org
Cc: ebpf@linuxfoundation.org,bastien.curutchet@bootlin.com,thomas.petazzoni@bootlin.com,bpf@vger.kernel.org,linux-kselftest@vger.kernel.org,linux-kernel@vger.kernel.org,ihor.solodrai@linux.dev,alexis.lothore@bootlin.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue, 18 Aug 2026 19:23:04 +0000 (UTC)

--===============8883660200475105318==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testing/selftests/bpf/network_helpers.c
> index b82f572641b7..380b776f182d 100644
> --- a/tools/testing/selftests/bpf/network_helpers.c
> +++ b/tools/testing/selftests/bpf/network_helpers.c
> @@ -49,6 +49,8 @@
>  			errno = __save;					\
>  })
>
> +#define CONNECT_MIN_TIMEOUT_MS	5000

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

Does the 5-second floor apply to callers that deliberately set a small
timeout because they expect the connect to fail?

Looking at cgroup_skb_sk_lookup.c, the test expects a connection to time
out after 1 second:

  /* Client outside of test cgroup should fail to connect by timeout. */
  err = connect_fd_to_fd(out_sk, serv_sk, 1000);
  if (CHECK(!err || errno != EINPROGRESS, "connect_fd_to_fd", ...))

The call chain is:

  test_cgroup_skb_sk_lookup()
    -> run_cgroup_bpf_test()
      -> run_lookup_test()
        -> connect_fd_to_fd(out_sk, serv_sk, 1000)
          -> connect_with_timeout(..., 1000)

With MAX(1000, 5000) returning 5000, settimeo(fd, 5000) is installed,
and the deliberately-dropped connect() now blocks for 5 seconds instead
of 1 second.

The test still passes because the cgroup_skb program drops the SYNs
permanently, so at 5 seconds the socket is still in SYN_SENT and
connect() returns EINPROGRESS. But the test now waits 5 times longer than
intended.

The commit message mentions that some tests expect data transfer to fail
and that increasing timeout would increase execution duration, which is
what happens here for connects expected to time out.

Would it make sense to honour the caller's timeout_ms when explicitly set,
and only apply the 5-second floor when timeout_ms is 0 or use a default?

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/32172718494
--===============8883660200475105318==--
