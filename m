Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D583B2FF6
	for <bpf@vger.kernel.org>; Thu, 12 Mar 2026 21:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773351896; cv=none; b=QK3M8HkFMTD8r/9QiKCE6fD2dxxgELTTBOJS7aFkfS5jbsjuTmVSNX9Bc83qxfbhe+ixDLuUa+ACOsMlcTl0YoUikJPVzMtInx9gV3bEsmGu064yBaShPQpYuQzFCstrQeSfDeZUZfCxqmLWBfN/p2WcsYCKqZbIQiuxv2+/zLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773351896; c=relaxed/simple;
	bh=QeijNsoNtd6GQPWzerTX+IaKb2DM6SkMsorrZ7z16+4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aWTLTOPD+8ho2zU9f8NQg4SrGeUSkw691GIP+g/UW2kLcWxYpwsy79Lqw9kx4lZTp0lkH7L2A0ohniwEIA7BVF1oJSxFbYMRokKo6mbR2cqNy7aGsjNCHZ+OUZwOjPdw7q0lyqlLASXxNQQs5b783jqud1lHrnCHPM459Py4AAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=K13Oxdam; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="K13Oxdam"
Message-ID: <9f1acc68-823d-4003-a177-face6cdcc950@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773351883;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4GvzcePLLgkAfDV6ygSwq4ugxc3ASiCPf0F7nHEp5jE=;
	b=K13OxdamgGkCcfas6jyuWiiiufmNh/r1l3ekqlfiMIe7HuGDAxWcQaR7s6J8evOwQWFp6N
	F3Q8y5WrSH/WvFEpaheOkMLbxdy9xCnHotcm3mCz6kDeFpXq1HLYJ8v3pt7nidHEn7nk7D
	oomXRV/HBvJnK8GErNc0MSpOhjFZuJI=
Date: Thu, 12 Mar 2026 14:44:37 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 2/2] selftests/bpf: Skip bpffs debug iter checks when
 unavailable in test_bpffs
Content-Language: en-GB
To: Sun Jian <sun.jian.kdev@gmail.com>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, Shuah Khan <shuah@kernel.org>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>
References: <20260310102145.857810-1-sun.jian.kdev@gmail.com>
 <20260310102145.857810-2-sun.jian.kdev@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20260310102145.857810-2-sun.jian.kdev@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 3/10/26 3:21 AM, Sun Jian wrote:
> maps.debug/progs.debug may be inaccessible or absent (EPERM/EACCES/ENOENT)
> in some environments, which used to abort test_bpffs before it exercised

In which situation these two files have issues? This already root
access. If file operation failed, that must be due to your special
situation.

> the pin and rename checks. Treat these errors as "iter unavailable", log
> an INFO message, and continue with the core bpffs tests.
>
> Signed-off-by: Sun Jian <sun.jian.kdev@gmail.com>
> ---
>   .../selftests/bpf/prog_tests/test_bpffs.c     | 43 ++++++++++++++++---
>   1 file changed, 36 insertions(+), 7 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/test_bpffs.c b/tools/testing/selftests/bpf/prog_tests/test_bpffs.c
> index e8021ff0581c..95a7d2582ba7 100644
> --- a/tools/testing/selftests/bpf/prog_tests/test_bpffs.c
> +++ b/tools/testing/selftests/bpf/prog_tests/test_bpffs.c
> @@ -11,15 +11,18 @@
>   /* TDIR must be in a location we can create a directory in. */
>   #define TDIR "/tmp/test_bpffs_testdir"
>   
> -static int read_iter(char *file)
> +static int read_iter(const char *file, int *save_errno)
>   {
>   	/* 1024 should be enough to get contiguous 4 "iter" letters at some point */
>   	char buf[1024];
>   	int fd, len;
>   
>   	fd = open(file, O_RDONLY);
> -	if (fd < 0)
> +	if (fd < 0) {
> +		if (save_errno)
> +			*save_errno = errno;
>   		return -1;
> +	}
>   	while ((len = read(fd, buf, sizeof(buf) - 1)) > 0) {
>   		buf[len] = '\0';
>   		if (strstr(buf, "iter")) {
> @@ -27,10 +30,33 @@ static int read_iter(char *file)
>   			return 0;
>   		}
>   	}
> +	if (save_errno)
> +		*save_errno = (len < 0) ? errno : 0;
>   	close(fd);
>   	return -1;
>   }
>   
> +static bool is_iter_skip_err(int err, int serrno)
> +{
> +	return err && (serrno == EPERM || serrno == EACCES || serrno == ENOENT);
> +}
> +
> +static int read_iter_or_skip(const char *file)
> +{
> +	int serrno = 0;
> +	int err = read_iter(file, &serrno);
> +
> +	if (is_iter_skip_err(err, serrno)) {
> +		fprintf(stderr,
> +			"INFO: %s unavailable (%d), skipping iter check\n",
> +			file,
> +			serrno);
> +		return 0;
> +	}
> +
> +	return err;
> +}
> +
>   static int fn(void)
>   {
>   	struct stat a, b, c;
> @@ -69,13 +95,16 @@ static int fn(void)
>   	if (!ASSERT_OK(err, "mount bpffs " TDIR "/fs2"))
>   		goto out;
>   
> -	err = read_iter(TDIR "/fs1/maps.debug");
> -	if (!ASSERT_OK(err, "reading " TDIR "/fs1/maps.debug"))
> +	err = read_iter_or_skip(TDIR "/fs1/maps.debug");
> +	if (err) {
> +		ASSERT_OK(err, "reading " TDIR "/fs1/maps.debug");
>   		goto out;
> -	err = read_iter(TDIR "/fs2/progs.debug");
> -	if (!ASSERT_OK(err, "reading " TDIR "/fs2/progs.debug"))
> +	}
> +	err = read_iter_or_skip(TDIR "/fs2/progs.debug");
> +	if (err) {
> +		ASSERT_OK(err, "reading " TDIR "/fs2/progs.debug");
>   		goto out;
> -
> +	}
>   	err = mkdir(TDIR "/fs1/a", 0777);
>   	if (!ASSERT_OK(err, "creating " TDIR "/fs1/a"))
>   		goto out;

