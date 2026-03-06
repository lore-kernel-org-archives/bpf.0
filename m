Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A60347513
	for <bpf@vger.kernel.org>; Fri,  6 Mar 2026 17:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772817907; cv=none; b=eTXQMgwKL7f+hNbNuYY4MonAq5MFS9WcUTBoL4uE8k3bSgCjl6yvf5UqObS8w6igR1jTeXNIN0SjQXDIVF8uy2oW2D5/y178k5rbGlk2b0ffdbvQdF1cTmdF3mdQHS9FDyi/RfpHPzUxnrZOEKeH7QK7mUYbi33Rl8kpsKUw13k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772817907; c=relaxed/simple;
	bh=sJvu5ZIusWpM65LX9/Pg8n9g4CDCjntwYIq9HwVj0AA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aN+ZCFwJf0oWTAOcvoKJlJE2z27zbVU/2wkxvijvnS6txJhMZw2axJ7pFrdm0zhAOi4qkv+xKkNv06cmKYZkX/bV9NTrMxV9Y6M6cWupCvtsj6kzEs5nbIXjAsfNzbKZsAWQXDut4DPW0xuy+mTJle7jgbkyywdY51uW02X6aXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MNtzk/ug; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MNtzk/ug"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-483770e0b25so81488345e9.0
        for <bpf@vger.kernel.org>; Fri, 06 Mar 2026 09:25:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772817903; x=1773422703; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=cXylfdNhh0fJwU2zW8/9CEKJG92aF2DVQNEe8gTW+9U=;
        b=MNtzk/ugkh7TNI2kf4QZodxb03iTssbvZvCmht9gnM8AS8szlGmM77DyKODzuFXsD8
         ZNVl9KSLcHDet9+XkVqEAGSLs9EDJhASW4iSWr/C8h+qemK2GgTmFzNEfMw2FnkkTWVy
         ZPhN6D4jOKVwQueWqHhkeuY68nRCE8SIC5I03J085mo73UuttOayeNQoxlHcCcRe3VVy
         +6qSWcgaeltKjnDkHfj4GBaZ2VwRDRBSYq4z5kOYaCgZ2slT1oqJ8IRQPybghFlN7LVB
         bmMRfKnuHwQElk2pNONnGIaLuK0/krArOyx+X9PQigejjhzxVnIqD0FM4IywtkW63ZCW
         6Vwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772817903; x=1773422703;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cXylfdNhh0fJwU2zW8/9CEKJG92aF2DVQNEe8gTW+9U=;
        b=RHSchimjPo7MhptK0FTXjQvMOKaC91ml5O5kUNqDBDtyOcWU+RLK85bMzsQEGS7gay
         fJlELs6rP1u49l061hhf2lUx+O4Iv5+exqvDEkqK0My34gZFIudg+8BV12WxktTbjwey
         WkIC8OsnftKH545QDcmgmypjg300rwY1sDVAItfZl87BXFU9XVNKSRP9/M/tke0Vykhq
         bh7J9xbe8F9atG/EvbGlYtRLDmHTVMto8g18bRgP98jJUA9Qwgayo+2y8oF0drPdAXAy
         zGDKGiQ/qSfMpvUE9UckG912dJWCm8hTtdbhmMDp8JNyOjq4Gp9e2kza8TYBU8rzFgtt
         oPvA==
X-Forwarded-Encrypted: i=1; AJvYcCXhmhRfU0vIFxSHKX5J8YtqegsDf4VL10cBKvUKeKM0n3Ac/ab4//R+D/qaZ9BFDv+ODDQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuqOSttWJ9ZYX2kMYqDT1CckA2C3E7y/hevwcDGksRZjRfjeoC
	780wEpMd2pnRqfN+xqiecEsW7bhgy1DKNcT6FnWhtAuDMYwZKbHRF5AY
X-Gm-Gg: ATEYQzxZSvhDCfIu9Mr2V0AsXcrU3OSEkh4WtuVnLE9vblhMsQkyKbKum6c7YCdUn1L
	TP96wHn3m/Q2oslWjFEk8ECnSSZL6AAwaT2meSVCKlGtGsccwp4b8KFZ9UJnqwb/WEpGT2xOboz
	Wuej+mc10rT3fJokIoRokI+ei6v/Pn1TU+DLAIUBsnMn7h2hXLyrn7cvnnxkpcliZ1i5mNvt8OP
	8Fd/qKCx18UYsZaAOaeDDB3JW43acZl6tYiwO2guf6CS5qQOhkgx9D6UxnfaxBk1Ircm5t3yPMv
	I90oht7iNTyDylvDn4TMSaqSoS6QBKNtBOm6fPW3EP1g/WXadYsE+Y/beKE6cwKXWgx0TKrRHQ/
	P+BeEq4UhciAgBNGb4f5uCE63mh3yGDRfOQtHceNY0DOoZd9G9iEajPNvhY1n8H2GgsxZjQELCI
	WliZvrNNCsqAPNAl5uAd8HveHlBeXk/qj98D6+9A==
X-Received: by 2002:a05:600c:4fc2:b0:477:a1a2:d829 with SMTP id 5b1f17b1804b1-4852692bfa5mr49036885e9.13.1772817902616;
        Fri, 06 Mar 2026 09:25:02 -0800 (PST)
Received: from localhost ([2a01:4b00:bd1f:f500:f867:fc8a:5174:5755])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48527686fa9sm61754555e9.8.2026.03.06.09.25.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 09:25:01 -0800 (PST)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: Jiayuan Chen <jiayuan.chen@linux.dev>, bpf@vger.kernel.org,
 john.fastabend@gmail.com, jakub@cloudflare.com
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, Willem de
 Bruijn <willemb@google.com>, David Ahern <dsahern@kernel.org>, Neal
 Cardwell <ncardwell@google.com>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard
 Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, Yonghong Song
 <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, Jiapeng Chong
 <jiapeng.chong@linux.alibaba.com>, Ihor Solodrai
 <ihor.solodrai@linux.dev>, Michal Luczaj <mhal@rbox.co>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf-next v1 6/7] selftests/bpf: add splice_read tests
 for sockmap
In-Reply-To: <20260304063643.14581-7-jiayuan.chen@linux.dev>
References: <20260304063643.14581-1-jiayuan.chen@linux.dev>
 <20260304063643.14581-7-jiayuan.chen@linux.dev>
Date: Fri, 06 Mar 2026 17:25:01 +0000
Message-ID: <87eclwyioi.fsf@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jiayuan Chen <jiayuan.chen@linux.dev> writes:

> Add splice_read coverage to sockmap_basic and sockmap_strp selftests.
> Each test suite now runs twice: once with normal recv_timeout() and
> once with splice-based reads, verifying that data read via splice(2)
> through a pipe produces identical results.
>
> A recv_timeout_with_splice() helper is added to sockmap_helpers.h
> that creates a temporary pipe, splices data from the socket into
> the pipe, then reads from the pipe into the user buffer. MSG_PEEK
> calls fall back to native recv since splice does not support peek.
> Non-TCP sockets also fall back to native recv.
>
> The splice subtests are distinguished by appending " splice" to
> each subtest name via a test__start_subtest macro override.
>
> ./test_progs -a sockmap_*
> ...
> Summary: 5/830 PASSED, 0 SKIPPED, 0 FAILED
>
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> ---
>  .../selftests/bpf/prog_tests/sockmap_basic.c  | 28 ++++++++-
>  .../bpf/prog_tests/sockmap_helpers.h          | 62 +++++++++++++++++++
>  .../selftests/bpf/prog_tests/sockmap_strp.c   | 28 ++++++++-
>  3 files changed, 116 insertions(+), 2 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
> index dd3c757859f6..ea0b49ec9a93 100644
> --- a/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
> +++ b/tools/testing/selftests/bpf/prog_tests/sockmap_basic.c
> @@ -18,6 +18,23 @@
>  
>  #include "sockmap_helpers.h"
>  
> +static bool use_splice;
> +
> +static bool __start_subtest(const char *name)
> +{
> +	if (!use_splice)
> +		return (test__start_subtest)(name);
> +
> +	char buf[MAX_TEST_NAME];
> +
> +	snprintf(buf, sizeof(buf), "%s splice", name);
> +	return (test__start_subtest)(buf);
> +}
> +
> +#define test__start_subtest(name) __start_subtest(name)
> +#define recv_timeout(fd, buf, len, flags, timeout) \
> +	recv_timeout_with_splice(fd, buf, len, flags, timeout, use_splice)
Not sure if this is a good idea to redefine test__start_subtest and
recv_timeout.
It looks like recv_timeout() is called 5 times in this file, so maybe
handling recv_timeout_with_splice() explicitly won't be too messy. 
> +
>  #define TCP_REPAIR		19	/* TCP sock is under repair right now */
>  
>  #define TCP_REPAIR_ON		1
> @@ -1314,7 +1331,7 @@ static void test_sockmap_multi_channels(int sotype)
>  	test_sockmap_pass_prog__destroy(skel);
>  }
>  
> -void test_sockmap_basic(void)
> +static void __test_sockmap_basic(void)
>  {
>  	if (test__start_subtest("sockmap create_update_free"))
>  		test_sockmap_create_update_free(BPF_MAP_TYPE_SOCKMAP);
> @@ -1391,3 +1408,12 @@ void test_sockmap_basic(void)
>  	if (test__start_subtest("sockmap udp multi channels"))
>  		test_sockmap_multi_channels(SOCK_DGRAM);
>  }
> +
> +void test_sockmap_basic(void)
> +{
> +	use_splice = false;
> +	__test_sockmap_basic();
> +
> +	use_splice = true;
> +	__test_sockmap_basic();
> +}
> diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_helpers.h b/tools/testing/selftests/bpf/prog_tests/sockmap_helpers.h
> index d815efac52fd..1f0da657243f 100644
> --- a/tools/testing/selftests/bpf/prog_tests/sockmap_helpers.h
> +++ b/tools/testing/selftests/bpf/prog_tests/sockmap_helpers.h
> @@ -80,4 +80,66 @@ static inline int add_to_sockmap(int mapfd, int fd1, int fd2)
>  	return xbpf_map_update_elem(mapfd, &u32(1), &u64(fd2), BPF_NOEXIST);
>  }
>  
> +static inline ssize_t recv_timeout_with_splice(int fd, void *buf, size_t len,
> +					       int flags,
> +					       unsigned int timeout_sec,
> +					       bool do_splice)
> +{
> +	ssize_t total = 0;
> +	int pipefd[2];
> +	int fl;
> +
> +	int sotype, protocol;
> +	socklen_t optlen = sizeof(sotype);
> +
> +	if (!do_splice || (flags & MSG_PEEK) ||
> +	    getsockopt(fd, SOL_SOCKET, SO_TYPE, &sotype, &optlen) ||
> +	    sotype != SOCK_STREAM ||
> +	    getsockopt(fd, SOL_SOCKET, SO_PROTOCOL, &protocol, &optlen) ||
> +	    protocol != IPPROTO_TCP)
> +		return recv_timeout(fd, buf, len, flags, timeout_sec);
> +
> +	if (poll_read(fd, timeout_sec))
> +		return -1;
> +
> +	if (pipe(pipefd) < 0)
> +		return -1;
> +
> +	/*
> +	 * tcp_splice_read() only checks sock->file->f_flags for
> +	 * O_NONBLOCK, ignoring SPLICE_F_NONBLOCK for the socket
> +	 * side timeout. Set O_NONBLOCK on the fd so the loop won't
> +	 * block forever when no more data is available.
> +	 */
> +	fl = fcntl(fd, F_GETFL);
> +	fcntl(fd, F_SETFL, fl | O_NONBLOCK);
> +
> +	/*
> +	 * Pipe has limited buffer slots (default 16), so a single
> +	 * splice may not transfer all requested bytes. Loop until
> +	 * we've read enough or no more data is available.
> +	 */
> +	while (total < (ssize_t)len) {
> +		ssize_t spliced, n;
> +
> +		spliced = splice(fd, NULL, pipefd[1], NULL, len - total,
> +				 SPLICE_F_NONBLOCK);
> +		if (spliced <= 0)
> +			break;
> +
> +		n = read(pipefd[0], buf + total, spliced);
> +		if (n <= 0)
> +			break;
> +
> +		total += n;
> +	}
> +
> +	fcntl(fd, F_SETFL, fl);
> +
> +	close(pipefd[0]);
> +	close(pipefd[1]);
> +
> +	return total > 0 ? total : -1;
> +}
> +
>  #endif // __SOCKMAP_HELPERS__
> diff --git a/tools/testing/selftests/bpf/prog_tests/sockmap_strp.c b/tools/testing/selftests/bpf/prog_tests/sockmap_strp.c
> index 621b3b71888e..2226399eee0d 100644
> --- a/tools/testing/selftests/bpf/prog_tests/sockmap_strp.c
> +++ b/tools/testing/selftests/bpf/prog_tests/sockmap_strp.c
> @@ -6,6 +6,23 @@
>  #include "test_skmsg_load_helpers.skel.h"
>  #include "test_sockmap_strp.skel.h"
>  
> +static bool use_splice;
> +
> +static bool __start_subtest(const char *name)
> +{
> +	if (!use_splice)
> +		return (test__start_subtest)(name);
> +
> +	char buf[MAX_TEST_NAME];
> +
> +	snprintf(buf, sizeof(buf), "%s splice", name);
> +	return (test__start_subtest)(buf);
> +}
> +
> +#define test__start_subtest(name) __start_subtest(name)
> +#define recv_timeout(fd, buf, len, flags, timeout) \
> +	recv_timeout_with_splice(fd, buf, len, flags, timeout, use_splice)
> +
>  #define STRP_PKT_HEAD_LEN 4
>  #define STRP_PKT_BODY_LEN 6
>  #define STRP_PKT_FULL_LEN (STRP_PKT_HEAD_LEN + STRP_PKT_BODY_LEN)
> @@ -431,7 +448,7 @@ static void test_sockmap_strp_verdict(int family, int sotype)
>  	test_sockmap_strp__destroy(strp);
>  }
>  
> -void test_sockmap_strp(void)
> +static void __test_sockmap_strp(void)
>  {
>  	if (test__start_subtest("sockmap strp tcp pass"))
>  		test_sockmap_strp_pass(AF_INET, SOCK_STREAM, false);
> @@ -452,3 +469,12 @@ void test_sockmap_strp(void)
>  	if (test__start_subtest("sockmap strp tcp dispatch"))
>  		test_sockmap_strp_dispatch_pkt(AF_INET, SOCK_STREAM);
>  }
> +
> +void test_sockmap_strp(void)
> +{
> +	use_splice = false;
> +	__test_sockmap_strp();
> +
> +	use_splice = true;
> +	__test_sockmap_strp();
> +}
> -- 
> 2.43.0
