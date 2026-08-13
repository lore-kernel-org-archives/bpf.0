Received: from mta1.migadu.com (out-28.mta1.migadu.com [95.215.58.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B95E5400994
	for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 18:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786647405; cv=none; b=GopOj+6UVccaO253ODDTFJ/wYh7g6+5/17M9ThbUn0C6Q8yHAbJ4XP9VR8XJFDVTsKezqhBgHfXSSJgXXz1Rcpny+7wcckKgF2+oLUm12pG4SLmOqXTecggGMi8tVGueqHho760L+fdLjAUh7P3ez2rN2isWmiGHQQJpQPIpSig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786647405; c=relaxed/simple;
	bh=J1i+AXq+lGZQMMVzygvxV02mDWKZCFWdE31qEIkjOyo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JAizFTglW1UOAvx1aAoliyDEQuXyhQbdXHEHuGuTMi2ssBt29tiGDhdyw9yx042s3j3NZm5O9l+nI/lJXdloYBPbV7lTkDGaHb9ufLF/PW6IaCq+tqEge8YnffkGmaG9AV3VD57kILA9sHhGfi3HI6C46bRj1JuyJ/cyCHajfU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ek3nyuIM; arc=none smtp.client-ip=95.215.58.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ek3nyuIM"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=J1i+AXq+lGZQMMVzygvxV02mDWKZCFWdE31qEIkjOyo=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1786647399; v=1; x=1787252199;
 b=ek3nyuIMxub6JC1Jahx0vCZpYrpu6kB74+XsCaXq940hjvim6N8mO0md3koQcG6c9O0ZM6Pm
 mVJNLy193xNpM30DKmgaCKoHWYLPbP2H8FEA/1Q8/Oty05H8XGg/tcRszxRsx9Ztc9IvY3LwjV+
 4EoGRw6fUkGpdloaVniPVBdU=
X-Envelope-To: bpf@vger.kernel.org
Received: from [IPV6:2620:10d:c085:21e8::13e6] (2620:10d:c090:400::5:fb16)
	by smtp.migadu.com with ESMTPS id eaa4d84f5a220772;
	Thu, 13 Aug 2026 18:56:39 +0000
X-Migadu-Flow: FLOW_OUT
Message-ID: <92e15af5-b490-4a4e-a908-9a6320da6583@linux.dev>
Date: Thu, 13 Aug 2026 11:55:19 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf v4] selftests/bpf: allocate a larger timeout for
 connection
To: =?UTF-8?Q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?=
 <alexis.lothore@bootlin.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Emil Tsalapatis <emil@etsalapatis.com>, Shuah Khan <shuah@kernel.org>
Cc: ebpf@linuxfoundation.org,
 Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260813-tc_tunnel_flaky-v4-1-3534df3fe930@bootlin.com>
Content-Language: en-US
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <20260813-tc_tunnel_flaky-v4-1-3534df3fe930@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2026-08-13 2:38 a.m., Alexis Lothoré (eBPF Foundation) wrote:
> Some tests, like tc_tunnel or tc_edt, sporadically fail in CI with the
> following logs:
> 
>    (network_helpers.c:309: errno: Operation now in progress) \
>      Failed to connect to server
>    send_and_test_data:FAIL:connect to server unexpected error: -115
> 
> This is due to SO_RCVTIMEO and SO_SNDTIMEO being set on the client
> socket (see settimeo() in client_socket()), allowing connect() to return
> an error and to set errno to EINPROGRESS instead of ETIMEDOUT.
> Increasing the timeout value for those tests is likely not a good
> solution (and it has already been done by commit 2790db208b44
> ("selftests/bpf: Improve tc_tunnel test reliability")): some tests
> expect some data transfer to fail, and so the timeout value would
> increase overall test execution duration again (not only the connection,
> but any socket operation).
> 
> Another solution is to allocate a timeout budget specific to the
> connection: we can apply a larger timeout only for connections, and once
> the connection is established, set back the timeout configured through
> opts->timeout_ms; this would allow connection to succeed under heavy CI
> load, while keeping timeout reasonable for the rest of the test traffic.
> 
> Set a larger SO_SNDTIMEO/SO_RCVTIMEO for the connection step, and reset
> it back to the timeout configured by the test once the connection has
> succeeded.
> 
> Fixes: 99126abec5e5 ("bpf: selftests: A few improvements to network_helpers.c")
> Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>
> ---
> Hello,
> this is the v4 of the series aiming to reduce the flakyness of
> tc_tunnel/tc_edt tests in CI. This revision takes a step back, based on
> Ihor's tests,  and drops the poll loop in favor of a bare, larger
> timeout value applied only for the connection step. The main downside
> of this new mechanism is a slight increase of the duration for tests
> expecting a connection failure. In my testing setup (x86-based Qemu on
> my work laptop), I observed a ~10s increase (on a ~5m18 base for the
> whole test_progs set).

Acked-by: Ihor Solodrai <ihor.solodrai@linux.dev>

I think it's better to fix those comment nits.

Thanks!

> ---
> Changes in v4:
> - dropped the polling loop in favor of a larger, connect-specific timeout
> - drop timeout configuration from tc_edt test
> - Link to v3: https://patch.msgid.link/20260811-tc_tunnel_flaky-v3-0-876f4e0bc603@bootlin.com
> 
> Changes in v3:
> - set errno before logging errors
> - respect time budget set by
> - respect opts->timeout_ms when polling: only poll for the remaining
>    time not already consume by connect()
> - keep polling if poll returns with EINTR
> - reorder early returns and add intermediate variables to clarify code
>    flow
> - Link to v2: https://patch.msgid.link/20260803-tc_tunnel_flaky-v2-1-657b287dfa75@bootlin.com
> 
> Changes in v2:
> - drop unneeded initialization
> - add back error message for immediate connection failure, and slightly
>    reword the async connection failure error message
> - Link to v1: https://patch.msgid.link/20260710-tc_tunnel_flaky-v1-1-42aab5399a49@bootlin.com
> 
> To: Alexei Starovoitov <ast@kernel.org>
> To: Daniel Borkmann <daniel@iogearbox.net>
> To: Andrii Nakryiko <andrii@kernel.org>
> To: Eduard Zingerman <eddyz87@gmail.com>
> To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> To: Martin KaFai Lau <martin.lau@linux.dev>
> To: Song Liu <song@kernel.org>
> To: Yonghong Song <yonghong.song@linux.dev>
> To: Jiri Olsa <jolsa@kernel.org>
> To: Emil Tsalapatis <emil@etsalapatis.com>
> To: Ihor Solodrai <ihor.solodrai@linux.dev>
> To: Shuah Khan <shuah@kernel.org>
> Cc: ebpf@linuxfoundation.org
> Cc: Bastien Curutchet <bastien.curutchet@bootlin.com>
> Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
> Cc: bpf@vger.kernel.org
> Cc: linux-kselftest@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---
>   tools/testing/selftests/bpf/network_helpers.c | 34 ++++++++++++++++++++++++---
>   1 file changed, 31 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testing/selftests/bpf/network_helpers.c
> index db935a9d9fc1..89336201572f 100644
> --- a/tools/testing/selftests/bpf/network_helpers.c
> +++ b/tools/testing/selftests/bpf/network_helpers.c
> @@ -49,6 +49,8 @@
>   			errno = __save;					\
>   })
>   
> +#define CONNECT_MIN_TIMEOUT_MS	5000
> +
>   struct ipv4_packet pkt_v4 = {
>   	.eth.h_proto = __bpf_constant_htons(ETH_P_IP),
>   	.iph.ihl = 5,
> @@ -291,6 +293,12 @@ int client_socket(int family, int type,
>   	return -1;
>   }
>   
> +static int connect_timeout_ms(const struct network_helper_opts *opts)
> +{
> +	/* Enforce a minimum connect timeout value */
> +	return MAX(opts->timeout_ms, CONNECT_MIN_TIMEOUT_MS);
> +}
> +
>   int connect_to_addr(int type, const struct sockaddr_storage *addr, socklen_t addrlen,
>   		    const struct network_helper_opts *opts)
>   {
> @@ -305,13 +313,33 @@ int connect_to_addr(int type, const struct sockaddr_storage *addr, socklen_t add
>   		return -1;
>   	}
>   
> +	/* Override timeout configuration with a larger value for the
> +	 * connection
> +	 */
> +	if (settimeo(fd, connect_timeout_ms(opts))) {
> +		log_err("Failed to set connect timeout");
> +		goto close;
> +	}
> +
>   	if (connect(fd, (const struct sockaddr *)addr, addrlen)) {
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
>   	}
>   
>   	return fd;
> +
> +close:
> +	save_errno_close(fd);
> +	return -1;
>   }
>   
>   int connect_to_addr_str(int family, int type, const char *addr_str, __u16 port,
> 
> ---
> base-commit: 673b1f0272d7dedeec78dee2b47040481e4332ba
> change-id: 20260710-tc_tunnel_flaky-27e9a191bd03
> 
> Best regards,
> --
> Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>
> 

