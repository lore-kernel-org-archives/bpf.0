Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91DAD3BD239
	for <bpf@vger.kernel.org>; Tue, 10 Mar 2026 12:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773145963; cv=none; b=Ey9O7XM1ja08XT2pnNeufssikaurfYHIwupRctIplkhH1PZHvYqaIuB9JMnIcdpgnhoUYDI9q8KJN/F5l32wbmmYIr25NGZzHR72W/3vyBl9k02Ljs5r0BpOv0+g4dH5f9UWL/D8FFyTylAojzCsmjqX2IRBnYr+gERxTFCKmmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773145963; c=relaxed/simple;
	bh=f8ojFrs8YwqfCP11dfC4uWCMT+bzoF1v5l4v3BpDu98=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XXe5npRmYYUdaLHViFTJMw8+fjd9YmRI1ywAkMMfjMdqeYWwYEsv60u5XfnAWGIhImWaS/k54/GSvQ0q4roE2UlITCf+N345VZU+KX7OJDxWGkPb+85T0IjchOIOsmbqu6J2SLf8FzyMYWbGg1RwolV2g/7dOxQe17eGGOaDo3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XFd/cXUy; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=eBRyBtVd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XFd/cXUy";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="eBRyBtVd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773145960;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hJ/54ek25wEeXuH5PdggTdIWUMdd/TVsrwTJ2bw2N/k=;
	b=XFd/cXUyj+bJcpQY/U1tiSrvKOh2gCxOkw2rZwAsSkIA9duip4riU8h6bEjIULiVFy51jq
	b4IzQMQzUM3D0LRMOm0onsqUkknbGHAm3i3k3AWInhw32H+XSY2uwjhL/dqppmL9ZEj0Vy
	7aRJcAHgWDFUji+VsuDhk5ELtDrIq58=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-434-nX1NJFwSMTWuWpHLrRlyqw-1; Tue, 10 Mar 2026 08:32:39 -0400
X-MC-Unique: nX1NJFwSMTWuWpHLrRlyqw-1
X-Mimecast-MFC-AGG-ID: nX1NJFwSMTWuWpHLrRlyqw_1773145958
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4852fbfc379so34447395e9.0
        for <bpf@vger.kernel.org>; Tue, 10 Mar 2026 05:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1773145958; x=1773750758; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hJ/54ek25wEeXuH5PdggTdIWUMdd/TVsrwTJ2bw2N/k=;
        b=eBRyBtVd0k2mVefshnembYlIp2RHDoiPTn5Czo9tozAvngyNESO9i88YKCQGbs5mRm
         Ra+IWUBKVqn8zpTnh+ue8bFWPid2st4mfms+qgEuRoLzu742IhwNraE7IR57V7e/SXj8
         o9fZKi5T9A4in+mWnTgBYJ27l/Ci5RQcjomcn6JhD8HCo8wEPrP0QnNwUzRcEW4JdPbU
         NUaqFFdIbfZ6ta9Z0EI/H7XTbEt4hubXiz+8KE/a4CoFPC+u08fY9Zipg6wXX6mzXahW
         kil5jwZOqo4pEUD8CFUbt+Dtt1Jh5+3Q8JzOLpQc7Kb9IjTmhP5ggxgVLmSRISLAAyaY
         +XYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773145958; x=1773750758;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hJ/54ek25wEeXuH5PdggTdIWUMdd/TVsrwTJ2bw2N/k=;
        b=jXqc+DeHwBUo8/ND2odxHAaz9pPwtaoAh4a/ktW0OiPk5rWg7fl8FPkWLKZgNS3nrE
         VPDmpZYxkVVXwLRyVLE9I6BQSEQTzUibmElD1dn72gmIa2OYK4clRsfUSI6bMEX7X1Ze
         3HiZTNM31thm1082pKtwOLnbPzhFXAkVi90IAcMkIAqSTzSU5JTdz3k6u7MXP0POBxqC
         hWKSITOzRKUKPXZisSMoFyhCCmRW2wn42r2GWJM8u0r1WTYdGlbt2ClpClDNh21WcC62
         2cFwJIZrtc9yibu8W0mcaW7GKr2pAmwKzrLsC6mp4JHaMTw/0wZeV/X5aif1Xx/DCE69
         eSkg==
X-Gm-Message-State: AOJu0YwgTzpaM1EpfaK6h+LnNqN8jnxZf/M7BotXolTbJkjDRBEDmLja
	F0cW7fH/cokTw6dfLG47olpw9Gcv7ktBDUPA6QmTDimgo1Nnlo/XTvPVu21SvNRyxusJwAhwFJQ
	5ifzr6CWWFcd7uzdaC+xr3Se/VE9jEMvmfBsi8yWCBRD5c9gIh5L8
X-Gm-Gg: ATEYQzwF4AKeJNjoipHwDBzNO8a05ZHagl/g2SluPXLqATSOv1390yHanGixPNXqGj/
	MmU1tDeYi2yOGiSSvJ3XUBV/toLRDHGtwHKzc3XgwuJGjoLSy4VNrhfWTNaWp1yl0Nh55u4IhzR
	VbJSSQUYZPaoVI5uCzx6GbeMjQhlhqk/mx4CFo7w7cddhJyx8yD/1SEVFTUsnVEw2hu0oHFRfA7
	OuEsncrUJLZHuQtCaQM6V8xmUr8lmdemGacdvmIpW5xon62m2VB0DD371YOJzMEvifZBOEWGyai
	FX7uAz45hl3513JohSXGKA5sZEHx8Fo32Z1WiomSSzFeKyrgToatFFufCEyoqTPnTFmnaDd5ZMV
	yeKjxeSbelA==
X-Received: by 2002:a05:600c:3d90:b0:482:f564:d613 with SMTP id 5b1f17b1804b1-48526930529mr236845805e9.15.1773145958129;
        Tue, 10 Mar 2026 05:32:38 -0700 (PDT)
X-Received: by 2002:a05:600c:3d90:b0:482:f564:d613 with SMTP id 5b1f17b1804b1-48526930529mr236845015e9.15.1773145957521;
        Tue, 10 Mar 2026 05:32:37 -0700 (PDT)
Received: from [10.43.17.131] ([213.175.46.86])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48541b6f708sm98362985e9.11.2026.03.10.05.32.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Mar 2026 05:32:37 -0700 (PDT)
Message-ID: <f0d1eb34-2d6a-487a-b486-3dc64c25df6c@redhat.com>
Date: Tue, 10 Mar 2026 13:32:36 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] selftests/bpf: Skip bpffs debug iter checks when
 unavailable in test_bpffs
To: Sun Jian <sun.jian.kdev@gmail.com>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, Shuah Khan <shuah@kernel.org>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>
References: <20260310102145.857810-1-sun.jian.kdev@gmail.com>
 <20260310102145.857810-2-sun.jian.kdev@gmail.com>
From: Viktor Malik <vmalik@redhat.com>
Content-Language: en-US
In-Reply-To: <20260310102145.857810-2-sun.jian.kdev@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/10/26 11:21, Sun Jian wrote:
> maps.debug/progs.debug may be inaccessible or absent (EPERM/EACCES/ENOENT)
> in some environments, which used to abort test_bpffs before it exercised
> the pin and rename checks. Treat these errors as "iter unavailable", log
> an INFO message, and continue with the core bpffs tests.
> 
> Signed-off-by: Sun Jian <sun.jian.kdev@gmail.com>
> ---
>  .../selftests/bpf/prog_tests/test_bpffs.c     | 43 ++++++++++++++++---
>  1 file changed, 36 insertions(+), 7 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/test_bpffs.c b/tools/testing/selftests/bpf/prog_tests/test_bpffs.c
> index e8021ff0581c..95a7d2582ba7 100644
> --- a/tools/testing/selftests/bpf/prog_tests/test_bpffs.c
> +++ b/tools/testing/selftests/bpf/prog_tests/test_bpffs.c
> @@ -11,15 +11,18 @@
>  /* TDIR must be in a location we can create a directory in. */
>  #define TDIR "/tmp/test_bpffs_testdir"
>  
> -static int read_iter(char *file)
> +static int read_iter(const char *file, int *save_errno)
>  {
>  	/* 1024 should be enough to get contiguous 4 "iter" letters at some point */
>  	char buf[1024];
>  	int fd, len;
>  
>  	fd = open(file, O_RDONLY);
> -	if (fd < 0)
> +	if (fd < 0) {
> +		if (save_errno)
> +			*save_errno = errno;
>  		return -1;
> +	}
>  	while ((len = read(fd, buf, sizeof(buf) - 1)) > 0) {
>  		buf[len] = '\0';
>  		if (strstr(buf, "iter")) {
> @@ -27,10 +30,33 @@ static int read_iter(char *file)
>  			return 0;
>  		}
>  	}
> +	if (save_errno)
> +		*save_errno = (len < 0) ? errno : 0;
>  	close(fd);
>  	return -1;
>  }
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

I don't think this is a good approach as it will mask genuine bugs that
would cause the files to be missing/inaccessible with one of the above
error codes.

If you really need to execute the rest of the test cases in the file,
how about you split the test into subtests and then just add the failing
subtest to your DENYLIST?

Viktor

> +		return 0;
> +	}
> +
> +	return err;
> +}
> +
>  static int fn(void)
>  {
>  	struct stat a, b, c;
> @@ -69,13 +95,16 @@ static int fn(void)
>  	if (!ASSERT_OK(err, "mount bpffs " TDIR "/fs2"))
>  		goto out;
>  
> -	err = read_iter(TDIR "/fs1/maps.debug");
> -	if (!ASSERT_OK(err, "reading " TDIR "/fs1/maps.debug"))
> +	err = read_iter_or_skip(TDIR "/fs1/maps.debug");
> +	if (err) {
> +		ASSERT_OK(err, "reading " TDIR "/fs1/maps.debug");
>  		goto out;
> -	err = read_iter(TDIR "/fs2/progs.debug");
> -	if (!ASSERT_OK(err, "reading " TDIR "/fs2/progs.debug"))
> +	}
> +	err = read_iter_or_skip(TDIR "/fs2/progs.debug");
> +	if (err) {
> +		ASSERT_OK(err, "reading " TDIR "/fs2/progs.debug");
>  		goto out;
> -
> +	}
>  	err = mkdir(TDIR "/fs1/a", 0777);
>  	if (!ASSERT_OK(err, "creating " TDIR "/fs1/a"))
>  		goto out;

