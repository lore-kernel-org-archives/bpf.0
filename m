Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 853313BE626
	for <bpf@vger.kernel.org>; Thu, 12 Mar 2026 21:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773351702; cv=none; b=lE5ML5QateuoGH/c1sVJMuAES/oLxgGOTgHp32i93xcT9V9DqPWYbuXotERJQ0mb0Mjdasf3BwYuNsDkQILynR5tTwal5YJKjh+K/siGHYBbWKSZJc7klCDR03bwcLZGa86Hp4uH6UPKGp8v138LxbUZ/60K8i/bRroJ0SMC8us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773351702; c=relaxed/simple;
	bh=IAsltmrXizn0dd2DF71NAmOuZuGV0Uf2/p6QdWDnjSY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aD4wiSlZBt3PHHFPwKvI4ze989aTYCNdQzljjtTj710SCQk9aJqnmuL/bVx+DGhL/9F18B5s/jY6HPKnQ/DiQTudRifK+3RfN/uiWpZAyXqHbxwdMszNIcN2h3gox/5wPBJaVfcZHNfL14tG10/qi10tUJioO2tkwjZo7Kqd254=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BoQsAZWi; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BoQsAZWi"
Message-ID: <d8175ac4-0632-4b29-9e93-04c7ce92404e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773351689;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kVkpyJURMDzVJ0lm3HYtjTFAcoyXsUetjHMlwSHh/wA=;
	b=BoQsAZWid+wQNoYAtVPXOVUu4t+NvRtcYTybseQIUUAKpy1n7wKKom4lEdi8hnPIzPeiRD
	f6a7GlBBQoQ/lfjY3ow6fxFjLPdDHnOfm7730nb2GG01GsfZYNtrnGaxnTTd3ipNsEuOP5
	ix97n7NLcu/B6QNtEVl35p1vSvMgzCs=
Date: Thu, 12 Mar 2026 14:41:20 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 1/2] selftests/bpf: Fix read_iter buffer termination in
 test_bpffs
Content-Language: en-GB
To: Sun Jian <sun.jian.kdev@gmail.com>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, Shuah Khan <shuah@kernel.org>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>
References: <20260310102145.857810-1-sun.jian.kdev@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20260310102145.857810-1-sun.jian.kdev@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 3/10/26 3:21 AM, Sun Jian wrote:
> read_iter() always NUL-terminated at the end of the buffer, so strstr()
> could scan uninitialized stack bytes on short reads. Terminate at len and
> use O_RDONLY.
>
> Signed-off-by: Sun Jian <sun.jian.kdev@gmail.com>
> ---
>   tools/testing/selftests/bpf/prog_tests/test_bpffs.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/test_bpffs.c b/tools/testing/selftests/bpf/prog_tests/test_bpffs.c
> index ea933fd151c3..e8021ff0581c 100644
> --- a/tools/testing/selftests/bpf/prog_tests/test_bpffs.c
> +++ b/tools/testing/selftests/bpf/prog_tests/test_bpffs.c
> @@ -17,11 +17,11 @@ static int read_iter(char *file)
>   	char buf[1024];
>   	int fd, len;
>   
> -	fd = open(file, 0);
> +	fd = open(file, O_RDONLY);
>   	if (fd < 0)
>   		return -1;
> -	while ((len = read(fd, buf, sizeof(buf))) > 0) {
> -		buf[sizeof(buf) - 1] = '\0';
> +	while ((len = read(fd, buf, sizeof(buf) - 1)) > 0) {
> +		buf[len] = '\0';
>   		if (strstr(buf, "iter")) {
>   			close(fd);
>   			return 0;

The change here is unnecessary. Typically /sys/fs/bpf/ should be mounted
earlier and the 'iter' should appear with early prog/map id's. This ensure
'iter' will be discovered earlier. If you have an issue for this, fix
your setup.

>
> base-commit: 1f318b96cc84d7c2ab792fcc0bfd42a7ca890681

