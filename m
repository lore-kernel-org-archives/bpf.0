Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79DE63BA235;
	Mon, 17 Aug 2026 08:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786956920; cv=none; b=JotEZ2auXfng3xbcOltFhcy7/9oejNYwFFGBaqSh2PtWA/Vrj3WIibIakLvcRHD98/5+c7BAbuAzAEUWV14YttdyYdN1ozT6TQqWaflpeplkiiVWQEVvVUpPEOYoRb8yUuH+GtFC3yTzMJFa4pp4KFt/1dAOzH3IbtXKKtp4Xb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786956920; c=relaxed/simple;
	bh=qG4W8FZSLQgbODO1N0MzlCxgNi96uMRMzgagbbEQu8g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vGdr9E5S3HtDFMTXsyqa8tGk/ArfRc2GGf5obUx7d03eQXmcbCDisOBSzHvNKR05LnDQTHSWoTTvylp1bZGXxZA2XMHF58aM9E1qwai0vyh1cm4M9prMCVJEstjW921VXO/jfqjdIKskfxassCQZCiFfHtzwGilSVovW5WoYgs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=CNiOvucC; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="CNiOvucC"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=PzxZMYZyvNobYQwazFJ6TwTep3p8YEU/dFfec5P3lJQ=; b=CNiOvucC6c+azq+w6urhli/rNy
	YDX7L/5uHz8rAHpZCfgURjQRZW6btuGm/Fld8Il4h7nT/sDGyMEJqBUSmhvh6mGI5TTan31GDC5yz
	29wx9vINKWa8KTVgd++r4a4YueSXfw+1cebFOnscLk2M09SUbASYx2506wpuXE4lllQGMWiqp8CmT
	m0360LmFjfAyRgGcljyBw7k86LFxaOqgpO9jfsCLnVh93zifWrlFqazpVd2uWtqY85IpFE7Ri5sm3
	ehVoJVwHunhfCPTc3/8pVEnNyjb3OE817C689xP99QaBHtw9PJimbeDQfpA1uVVhA9DKTh3nX4QcD
	QfQ+eo2g==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1wvt7i-000EQH-13;
	Mon, 17 Aug 2026 10:55:14 +0200
Received: from localhost ([127.0.0.1])
	by sslproxy02.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1wvt7h-00034Z-2y;
	Mon, 17 Aug 2026 10:55:13 +0200
Message-ID: <07776a9c-2998-4d65-af3e-c714181d4241@iogearbox.net>
Date: Mon, 17 Aug 2026 10:55:12 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf v5 2/2] selftests/bpf: allocate a larger timeout for
 connection
To: =?UTF-8?Q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?=
 <alexis.lothore@bootlin.com>, Alexei Starovoitov <ast@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Emil Tsalapatis <emil@etsalapatis.com>, Shuah Khan <shuah@kernel.org>,
 Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: ebpf@linuxfoundation.org,
 Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260814-tc_tunnel_flaky-v5-0-5b93d030c42c@bootlin.com>
 <20260814-tc_tunnel_flaky-v5-2-5b93d030c42c@bootlin.com>
Content-Language: en-US
From: Daniel Borkmann <daniel@iogearbox.net>
Autocrypt: addr=daniel@iogearbox.net; keydata=
 xsFNBGNAkI0BEADiPFmKwpD3+vG5nsOznvJgrxUPJhFE46hARXWYbCxLxpbf2nehmtgnYpAN
 2HY+OJmdspBntWzGX8lnXF6eFUYLOoQpugoJHbehn9c0Dcictj8tc28MGMzxh4aK02H99KA8
 VaRBIDhmR7NJxLWAg9PgneTFzl2lRnycv8vSzj35L+W6XT7wDKoV4KtMr3Szu3g68OBbp1TV
 HbJH8qe2rl2QKOkysTFRXgpu/haWGs1BPpzKH/ua59+lVQt3ZupePpmzBEkevJK3iwR95TYF
 06Ltpw9ArW/g3KF0kFUQkGXYXe/icyzHrH1Yxqar/hsJhYImqoGRSKs1VLA5WkRI6KebfpJ+
 RK7Jxrt02AxZkivjAdIifFvarPPu0ydxxDAmgCq5mYJ5I/+BY0DdCAaZezKQvKw+RUEvXmbL
 94IfAwTFA1RAAuZw3Rz5SNVz7p4FzD54G4pWr3mUv7l6dV7W5DnnuohG1x6qCp+/3O619R26
 1a7Zh2HlrcNZfUmUUcpaRPP7sPkBBLhJfqjUzc2oHRNpK/1mQ/+mD9CjVFNz9OAGD0xFzNUo
 yOFu/N8EQfYD9lwntxM0dl+QPjYsH81H6zw6ofq+jVKcEMI/JAgFMU0EnxrtQKH7WXxhO4hx
 3DFM7Ui90hbExlFrXELyl/ahlll8gfrXY2cevtQsoJDvQLbv7QARAQABzSZEYW5pZWwgQm9y
 a21hbm4gPGRhbmllbEBpb2dlYXJib3gubmV0PsLBkQQTAQoAOxYhBCrUdtCTcZyapV2h+93z
 cY/jfzlXBQJjQJCNAhsDBQkHhM4ACAsJCAcNDAsKBRUKCQgLAh4BAheAAAoJEN3zcY/jfzlX
 dkUQAIFayRgjML1jnwKs7kvfbRxf11VI57EAG8a0IvxDlNKDcz74mH66HMyhMhPqCPBqphB5
 ZUjN4N5I7iMYB/oWUeohbuudH4+v6ebzzmgx/EO+jWksP3gBPmBeeaPv7xOvN/pPDSe/0Ywp
 dHpl3Np2dS6uVOMnyIsvmUGyclqWpJgPoVaXrVGgyuer5RpE/a3HJWlCBvFUnk19pwDMMZ8t
 0fk9O47HmGh9Ts3O8pGibfdREcPYeGGqRKRbaXvcRO1g5n5x8cmTm0sQYr2xhB01RJqWrgcj
 ve1TxcBG/eVMmBJefgCCkSs1suriihfjjLmJDCp9XI/FpXGiVoDS54TTQiKQinqtzP0jv+TH
 1Ku+6x7EjLoLH24ISGyHRmtXJrR/1Ou22t0qhCbtcT1gKmDbTj5TcqbnNMGWhRRTxgOCYvG0
 0P2U6+wNj3HFZ7DePRNQ08bM38t8MUpQw4Z2SkM+jdqrPC4f/5S8JzodCu4x80YHfcYSt+Jj
 ipu1Ve5/ftGlrSECvy80ZTKinwxj6lC3tei1bkI8RgWZClRnr06pirlvimJ4R0IghnvifGQb
 M1HwVbht8oyUEkOtUR0i0DMjk3M2NoZ0A3tTWAlAH8Y3y2H8yzRrKOsIuiyKye9pWZQbCDu4
 ZDKELR2+8LUh+ja1RVLMvtFxfh07w9Ha46LmRhpCzsFNBGNAkI0BEADJh65bNBGNPLM7cFVS
 nYG8tqT+hIxtR4Z8HQEGseAbqNDjCpKA8wsxQIp0dpaLyvrx4TAb/vWIlLCxNu8Wv4W1JOST
 wI+PIUCbO/UFxRy3hTNlb3zzmeKpd0detH49bP/Ag6F7iHTwQQRwEOECKKaOH52tiJeNvvyJ
 pPKSKRhmUuFKMhyRVK57ryUDgowlG/SPgxK9/Jto1SHS1VfQYKhzMn4pWFu0ILEQ5x8a0RoX
 k9p9XkwmXRYcENhC1P3nW4q1xHHlCkiqvrjmWSbSVFYRHHkbeUbh6GYuCuhqLe6SEJtqJW2l
 EVhf5AOp7eguba23h82M8PC4cYFl5moLAaNcPHsdBaQZznZ6NndTtmUENPiQc2EHjHrrZI5l
 kRx9hvDcV3Xnk7ie0eAZDmDEbMLvI13AvjqoabONZxra5YcPqxV2Biv0OYp+OiqavBwmk48Z
 P63kTxLddd7qSWbAArBoOd0wxZGZ6mV8Ci/ob8tV4rLSR/UOUi+9QnkxnJor14OfYkJKxot5
 hWdJ3MYXjmcHjImBWplOyRiB81JbVf567MQlanforHd1r0ITzMHYONmRghrQvzlaMQrs0V0H
 5/sIufaiDh7rLeZSimeVyoFvwvQPx5sXhjViaHa+zHZExP9jhS/WWfFE881fNK9qqV8pi+li
 2uov8g5yD6hh+EPH6wARAQABwsF8BBgBCgAmFiEEKtR20JNxnJqlXaH73fNxj+N/OVcFAmNA
 kI0CGwwFCQeEzgAACgkQ3fNxj+N/OVfFMhAA2zXBUzMLWgTm6iHKAPfz3xEmjtwCF2Qv/TT3
 KqNUfU3/0VN2HjMABNZR+q3apm+jq76y0iWroTun8Lxo7g89/VDPLSCT0Nb7+VSuVR/nXfk8
 R+OoXQgXFRimYMqtP+LmyYM5V0VsuSsJTSnLbJTyCJVu8lvk3T9B0BywVmSFddumv3/pLZGn
 17EoKEWg4lraXjPXnV/zaaLdV5c3Olmnj8vh+14HnU5Cnw/dLS8/e8DHozkhcEftOf+puCIl
 Awo8txxtLq3H7KtA0c9kbSDpS+z/oT2S+WtRfucI+WN9XhvKmHkDV6+zNSH1FrZbP9FbLtoE
 T8qBdyk//d0GrGnOrPA3Yyka8epd/bXA0js9EuNknyNsHwaFrW4jpGAaIl62iYgb0jCtmoK/
 rCsv2dqS6Hi8w0s23IGjz51cdhdHzkFwuc8/WxI1ewacNNtfGnorXMh6N0g7E/r21pPeMDFs
 rUD9YI1Je/WifL/HbIubHCCdK8/N7rblgUrZJMG3W+7vAvZsOh/6VTZeP4wCe7Gs/cJhE2gI
 DmGcR+7rQvbFQC4zQxEjo8fNaTwjpzLM9NIp4vG9SDIqAm20MXzLBAeVkofixCsosUWUODxP
 owLbpg7pFRJGL9YyEHpS7MGPb3jSLzucMAFXgoI8rVqoq6si2sxr2l0VsNH5o3NgoAgJNIg=
In-Reply-To: <20260814-tc_tunnel_flaky-v5-2-5b93d030c42c@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28095/Mon Aug 17 08:23:59 2026)

Hi Alexis,

On 8/14/26 9:11 AM, Alexis Lothoré (eBPF Foundation) wrote:
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
> Acked-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>
> ---
>   tools/testing/selftests/bpf/network_helpers.c | 36 ++++++++++++++++++++++++---
>   1 file changed, 33 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testing/selftests/bpf/network_helpers.c
> index cdf2d7d3ab32..8c9236c0a5a5 100644
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
> @@ -305,13 +313,35 @@ int connect_to_addr(int type, const struct sockaddr_storage *addr, socklen_t add
>   		return -1;
>   	}
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
>   	if (connect(fd, (const struct sockaddr *)addr, addrlen)) {
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
>   	}

Could you do one last spin? I'll get the comment fix applied, but the above
still has issues as pointed out by sashiko, so maybe this could be reworked
as follows (untested):

diff --git a/tools/testing/selftests/bpf/network_helpers.c b/tools/testing/selftests/bpf/network_helpers.c
index 8c9236c0a5a5..ec209a744889 100644
--- a/tools/testing/selftests/bpf/network_helpers.c
+++ b/tools/testing/selftests/bpf/network_helpers.c
@@ -293,10 +293,27 @@ int client_socket(int family, int type,
  	return -1;
  }
  
-static int connect_timeout_ms(const struct network_helper_opts *opts)
+static int connect_with_timeout(int fd, const struct sockaddr_storage *addr,
+				socklen_t addrlen, int timeout_ms)
  {
-	/* Enforce a minimum connect timeout value */
-	return MAX(opts->timeout_ms, CONNECT_MIN_TIMEOUT_MS);
+	int connect_timeout_ms = MAX(timeout_ms, CONNECT_MIN_TIMEOUT_MS);
+
+	if (settimeo(fd, connect_timeout_ms)) {
+		log_err("Failed to set connect timeout");
+		return -1;
+	}
+
+	if (connect(fd, (const struct sockaddr *)addr, addrlen)) {
+		log_err("Failed to connect to server");
+		return -1;
+	}
+
+	if (connect_timeout_ms != timeout_ms && settimeo(fd, timeout_ms)) {
+		log_err("Failed to restore timeout for connected socket");
+		return -1;
+	}
+
+	return 0;
  }
  
  int connect_to_addr(int type, const struct sockaddr_storage *addr, socklen_t addrlen,
@@ -313,35 +330,12 @@ int connect_to_addr(int type, const struct sockaddr_storage *addr, socklen_t add
  		return -1;
  	}
  
-	/*
-	 * Override timeout configuration with a larger value for the
-	 * connection
-	 */
-	if (settimeo(fd, connect_timeout_ms(opts))) {
-		log_err("Failed to set connect timeout");
-		goto close;
-	}
-
-	if (connect(fd, (const struct sockaddr *)addr, addrlen)) {
-		log_err("Failed to connect");
-		goto close;
-	}
-
-	/*
-	 * If the timeout configured by the test is different from the
-	 * connect timeout, restore it
-	 */
-	if (opts->timeout_ms != CONNECT_MIN_TIMEOUT_MS &&
-	    settimeo(fd, opts->timeout_ms)) {
-		log_err("Failed to set timeout for connected socket");
-		goto close;
+	if (connect_with_timeout(fd, addr, addrlen, opts->timeout_ms)) {
+		save_errno_close(fd);
+		return -1;
  	}
  
  	return fd;
-
-close:
-	save_errno_close(fd);
-	return -1;
  }
  
  int connect_to_addr_str(int family, int type, const char *addr_str, __u16 port,
@@ -406,20 +400,12 @@ int connect_fd_to_fd(int client_fd, int server_fd, int timeout_ms)
  	struct sockaddr_storage addr;
  	socklen_t len = sizeof(addr);
  
-	if (settimeo(client_fd, timeout_ms))
-		return -1;
-
  	if (getsockname(server_fd, (struct sockaddr *)&addr, &len)) {
  		log_err("Failed to get server addr");
  		return -1;
  	}
  
-	if (connect(client_fd, (const struct sockaddr *)&addr, len)) {
-		log_err("Failed to connect to server");
-		return -1;
-	}
-
-	return 0;
+	return connect_with_timeout(client_fd, &addr, len, timeout_ms);
  }
  
  int make_sockaddr(int family, const char *addr_str, __u16 port,

