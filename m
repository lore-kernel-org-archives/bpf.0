Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A663D9020
	for <bpf@vger.kernel.org>; Thu,  6 Aug 2026 18:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786042639; cv=none; b=tT9HSTEIZIIkOiUtIl9jxY9GVAjxRk2ICAn4vQ+IMBeeaCUVN5Xe6VUz6qAsIhmEY2yeI1RuPEKy35QVCepEI6vztSr0ZpQOcFVkU+gY0jAzijNCYt5hs+DN+2LV7/BBqC0ZSifi9wNI9GIYgVSMfYamONE0/eIhsEeBBvgnk34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786042639; c=relaxed/simple;
	bh=FfMf+Bp6cLwLev3QZf8OODCZ/4jlepMwXNtHzfiav+k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NhqrvkeFo49zY/KG6MohB2caMAJai7rhEXmyMvqp+lv0Hg2xnDNd+6PLU9Cf/CYlhUik/baGe8GY6/12SbEWetevUSZmvaObBwzdHNvfnqfMhjA+dBCZSjpye93hvUolvigPNqnCsMJEfMMq7wFMEUKo2C4DAovOSdYhxztrOQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Ggeh4y7k; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Ggeh4y7k"
Message-ID: <71b9f5ae-eed4-4d03-a3b9-2493b525bc34@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1786042632;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TnKlokgKaGMjeqkxKWUO8tLs0dQnQKHqVL+e33E5DO8=;
	b=Ggeh4y7kbrGNYFxeOSk2gLH6+hWkgTkYttMIZpU58zvB9C+cPzborhZ1wXg0Cv1gJKNrbK
	cY3oeA8sRY7UB/XVMBLD1tkGSb7hAxkHtWXcIp5dmkgOkcikTfpwbfCV0QQQsoT8q/5m+4
	JTvfbHCXKRWdsJSExSu7kD4BmCpZSGE=
Date: Thu, 6 Aug 2026 11:56:47 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf v2] selftests/bpf: keep polling connection that is
 still in progress
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
References: <20260803-tc_tunnel_flaky-v2-1-657b287dfa75@bootlin.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <20260803-tc_tunnel_flaky-v2-1-657b287dfa75@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 8/3/26 12:36 AM, Alexis LothorÃ© (eBPF Foundation) wrote:
> Some tests, like tc_tunnel or tc_edt, sporadically fail in CI with the
> following logs:
> 
>   (network_helpers.c:309: errno: Operation now in progress) \
>     Failed to connect to server
>   send_and_test_data:FAIL:connect to server unexpected error: -115
> 
> This is due to SO_RCVTIMEO and SO_SNDTIMEO being set on the client
> socket (see settimeo() in client_socket()), allowing connect() to return
> an error and to set errno to EINPROGRESS instead of blocking until
> connection result is known. Increasing the timeout value for those tests
> is likely not a good solution (and it has already been done by commit
> 2790db208b44 ("selftests/bpf: Improve tc_tunnel test reliability")):
> they involve subtests that expect the connection to fail, and so
> increasing the timeout value would increase overall test execution
> duration again (not only the connection, but any socket operation).
> 
> Another solution, as documented in man 2 connect, is to poll the socket
> for POLLOUT once connect has returned EINPROGRESS, and to get the actual
> connection result through getsockopt: this allows to keep the overall
> timeout values low for the general traffic, while letting a chance to
> the connection to succeed even if CI runners are loaded.
> 
> When connect() returns EINPROGRESS, poll the socket for POLLOUT and
> check the connection result via getsockopt(SO_ERROR).
> 
> Fixes: 99126abec5e5 ("bpf: selftests: A few improvements to network_helpers.c")
> Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>
> ---
> Changes in v2:
> - drop unneeded initialization
> - add back error message for immediate connection failure, and slightly
>   reword the async connection failure error message
> - Link to v1: https://patch.msgid.link/20260710-tc_tunnel_flaky-v1-1-42aab5399a49@bootlin.com
> ---
> I manage to reproduce the issue locally by running `./test_progs -a
> tc_tunnel` in a qemu machine, while making all my CPUs busy with
> stress-ng on host side; the issue happens pretty quickly. I have not
> been able to reproduce the issue anymore with this fix.
> ---
>  tools/testing/selftests/bpf/network_helpers.c | 41 ++++++++++++++++++++++++---
>  1 file changed, 37 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testing/selftests/bpf/network_helpers.c
> index db935a9d9fc1..52e7b72f8a77 100644
> --- a/tools/testing/selftests/bpf/network_helpers.c
> +++ b/tools/testing/selftests/bpf/network_helpers.c
> @@ -14,6 +14,7 @@
>  #include <sys/types.h>
>  #include <sys/un.h>
>  #include <sys/eventfd.h>
> +#include <sys/poll.h>
>  
>  #include <linux/err.h>
>  #include <linux/in.h>
> @@ -40,6 +41,8 @@
>  #define IPPROTO_MPTCP 262
>  #endif
>  
> +#define CONNECTION_IN_PROGRESS_TIMEOUT_MS	3000
> +
>  #define clean_errno() (errno == 0 ? "None" : strerror(errno))
>  #define log_err(MSG, ...) ({						\
>  			int __save = errno;				\
> @@ -294,7 +297,8 @@ int client_socket(int family, int type,
>  int connect_to_addr(int type, const struct sockaddr_storage *addr, socklen_t addrlen,
>  		    const struct network_helper_opts *opts)
>  {
> -	int fd;
> +	socklen_t errlen;
> +	int fd, err;
>  
>  	if (!opts)
>  		opts = &default_opts;
> @@ -305,13 +309,42 @@ int connect_to_addr(int type, const struct sockaddr_storage *addr, socklen_t add
>  		return -1;
>  	}
>  
> -	if (connect(fd, (const struct sockaddr *)addr, addrlen)) {
> +	err = connect(fd, (const struct sockaddr *)addr, addrlen);
> +	if (err && errno == EINPROGRESS) {
> +		struct pollfd pfd = { .fd = fd, .events = POLLOUT };
> +
> +		err = poll(&pfd, 1, CONNECTION_IN_PROGRESS_TIMEOUT_MS);

Hi Alexis, thanks for the patch.

When I ran tc_* selftests in parallel it looked like they hanged.

I think what's happening is that this 3s timeout is additive, making
some tests to wait for too long. For example tc_tunnel has 1s timeout,
but with this change it actually becomes 4s. AI says a successful
tc_tunnel run makes 50+ connections, so it adds up to minutes.

We should probably be using opts->timeout_ms as an absolute budget set
by the caller, and pass it (or remainder?) to the poll().

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

Also poll() can return EINTR here. I think we should retry EINTR,
taking into account the absolute deadline.

pw-bot: cr

> +
> +		errlen = sizeof(err);
> +		if (getsockopt(fd, SOL_SOCKET, SO_ERROR, &err, &errlen) < 0) {
> +			log_err("Failed to getsockopt");
> +			goto close;
> +		}
> +
> +		if (err) {
> +			log_err("Eventually failed to connect to server");
> +			errno = err;
> +			goto close;
> +		}
> +	} else if (err) {
>  		log_err("Failed to connect to server");
> -		save_errno_close(fd);
> -		return -1;
> +		goto close;
>  	}
>  
>  	return fd;
> +close:
> +	save_errno_close(fd);
> +	return -1;
>  }
>  
>  int connect_to_addr_str(int family, int type, const char *addr_str, __u16 port,
> 
> ---
> base-commit: 2efc18d4bb9ad28d240b69bd324937f1ec12e93d
> change-id: 20260710-tc_tunnel_flaky-27e9a191bd03
> 
> Best regards,
> --  
> Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>
> 

