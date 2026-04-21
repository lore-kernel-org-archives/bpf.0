Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF243BE177
	for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 10:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776768770; cv=none; b=G01W6o5PlTJRzTqvExxp9iDM6yip/Zo5C+mh/Ay5+c+ljK7Hmr34NIBoe2XF+IUXNWBe9JSKsPhPRB7t6zdWS0F9pE0oce+LJQF9/VKMwQmPclPuu/2ewy2JYP1EZrmRD8DQ5sPB+OsD+wcU4bm/XOs8ys5+fbDmILgaRMLwf3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776768770; c=relaxed/simple;
	bh=s2cLGCqIxj2tLTuawRHmiHFZw06sP4n2pjrbd69MCRo=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N8KwdxjHsxRn7qblKTZqGFMW4gMt4qryjMHaCLzcDAPIPkNeixz5G1fEQrBpVTm8wx8AT0JVv/Gk4DtSXPc+GCGS57OgsNBKHOnsSw2DloTNJ/29qrJd5hv0WMvtph/Sai0j/7SVjmhGZ+5m4dI7UDQR6kSb0qkzv4IFelQMHzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EpvMXRgA; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EpvMXRgA"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-48909558b3aso31819235e9.0
        for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 03:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776768767; x=1777373567; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/DssGU0+rzpwgKnEuiXqwzg+hG6js1BvprdxT5pzyL4=;
        b=EpvMXRgA9knINhtuyv8i7NfsaKJYAmypy9nQnysR60+idSaORJjGV5G/yT3fGyjl+e
         5+zUlZWV21GoSzj00hsqu4og2JLmZipEboNZITiz0ErLUZHDvx1ZVNa7hJp1Y+sYEb6E
         aRmd1ZnNi3NGmEN6abJjIwBfZpz9VdqdFZej6aIy9beix1G1ce3YxD4qT7mcPmtNyH7W
         WbmT6523CmDXb0s3NwELz2oTvGpPCMIhaQnvyc7uOa+wBI6u4AkYLWzkdVxCjJZJ0deI
         AxTxgDbdyOI7PgXrtdI1sy3pJ0Das6LLQqmRlMbT8G7aCTN/CGdSyWB88KQKO/975Oba
         ccfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776768767; x=1777373567;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/DssGU0+rzpwgKnEuiXqwzg+hG6js1BvprdxT5pzyL4=;
        b=rMVqfqKQkNbtxZ8tlTUAFXIUG9aLudOxlbQRNzMUK1/9aB3kKXSiJPJsubSbXlf+Xp
         LU9mGVH4miEk0m2WyVMy+Vk/bRi/y2YDa4jKpTeifg8NXwv59tagUgmE7PEwhlp22aYO
         tN3+dNsUs5XPSGQNKxf1ki35VLWdwALpoYk/JCi4E5j8Qz2pWM/vlBh/uld/QfaFicp3
         KRQ5OeA5+SWI5ZrkbZKVoTyZfqMbc5XtX9NPCQBSy6pm88vNBBxbt4M/B5G9MreloTQX
         vi51dKXqEe3qvBnB+x1tE4+a7F6Yk6OGz8eRGAs+KPU3IvaDYkpS2mYUQgAX8qznX5YZ
         oT/g==
X-Gm-Message-State: AOJu0YziqozXJ8gWAhDzFZKzP3QFRVfYv3SuaE6xvB0lJfMnp+j/lwQl
	IyrK+p05evhkK7r6v7NBpkBdIlrEAp0F9O0ivZrPVV1LS6IRt0U00p6Y
X-Gm-Gg: AeBDies/u+Y+9xG3Vmfrb+MBSHGb1txVh+63PeCB966Z3ap7FQgbuV6Xrn27Pn5Maa2
	gAehc/UtdGEs5i6EOZ+LO8yLdGJbofB9mZMfhw/9BdD4eXkBoZUDi4RM63dh76Mf+WWvBEEHakS
	c7rm9mcyfmqimbRzNO9Xcl9v/sCLzZ+6LGTu4bs5ZPvGlvlx16b46WYmUqMclbpLOMZwRJowpDz
	wewOnjkvydcVW9NN/Go+kDix4mtFfXMYvNSpxwfaimfHFN6HIAzgRjLHUxS/lRp+Yx+N4BKoDID
	Up2MucBmM/ynldT49gT14JEncrBcuKGZ71zCdDsnCjq9A7tjtcqCCzp9jydF+YuVZ8RIKoC/X00
	dr1SxyK9DXWpYphKxmTjkKIM2Z0RrFQekcj6+LMFgm2PbeY/HBIM55k8nZKGwvbQaJCEjDyGwLu
	fJs2CYBV4=
X-Received: by 2002:a05:600c:4f13:b0:489:1a65:dd6e with SMTP id 5b1f17b1804b1-4891a65de3emr143246375e9.8.1776768766994;
        Tue, 21 Apr 2026 03:52:46 -0700 (PDT)
Received: from krava ([2a02:8308:a00c:e200::d99c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4891cc7b2efsm81786335e9.0.2026.04.21.03.52.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 03:52:46 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 21 Apr 2026 12:52:44 +0200
To: Jerome Marchand <jmarchan@redhat.com>
Cc: bpf@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
	Shuah Khan <shuah@kernel.org>, Mykyta Yatsenko <yatsenko@meta.com>,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests/bpf: Page out as late a possible in file_reader
Message-ID: <aedW_Aj4NrvqBeDg@krava>
References: <20260420134637.2513867-1-jmarchan@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260420134637.2513867-1-jmarchan@redhat.com>

On Mon, Apr 20, 2026 at 03:46:37PM +0200, Jerome Marchand wrote:
> The file_reader/on_open_expect_fault fails consistently on my system.
> It expects a page fault on first dynptr read of some range the exe
> file of the current process because it has paged out that page range
> earlier. However a lot can happen to that range (which depending on
> the actual memory layout could contain text section, data section,
> sections )related to dynamic linking...) between the moment it was
> paged out and the moment the bpf program expected to hit a pagefault
> actually run.
> 
> A bit of instrumentation with mincore() shows that pages from that
> range were accessed several times before the program is run. In
> particular the call of file_reader__load() seems to fault all the
> range in.
> 
> Move the call to madvise(MADV_PAGEOUT) to just before attaching the
> program to minimize the risk of having those page pulled back in from
> under our feet.
> 
> Signed-off-by: Jerome Marchand <jmarchan@redhat.com>

nit typo in the subject a -> as

Acked-by: Jiri Olsa <jolsa@kernel.org>

jirka


> ---
>  .../selftests/bpf/prog_tests/file_reader.c    | 22 +++++++++----------
>  1 file changed, 10 insertions(+), 12 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/file_reader.c b/tools/testing/selftests/bpf/prog_tests/file_reader.c
> index 5cde32b35da44..48aae7ea0e4bb 100644
> --- a/tools/testing/selftests/bpf/prog_tests/file_reader.c
> +++ b/tools/testing/selftests/bpf/prog_tests/file_reader.c
> @@ -10,6 +10,7 @@
>  
>  const char *user_ptr = "hello world";
>  char file_contents[256000];
> +void *addr;
>  
>  void *get_executable_base_addr(void)
>  {
> @@ -26,8 +27,7 @@ void *get_executable_base_addr(void)
>  static int initialize_file_contents(void)
>  {
>  	int fd, page_sz = sysconf(_SC_PAGESIZE);
> -	ssize_t n = 0, cur, off;
> -	void *addr;
> +	ssize_t n = 0, cur;
>  
>  	fd = open("/proc/self/exe", O_RDONLY);
>  	if (!ASSERT_OK_FD(fd, "Open /proc/self/exe\n"))
> @@ -52,16 +52,6 @@ static int initialize_file_contents(void)
>  	/* page-align base file address */
>  	addr = (void *)((unsigned long)addr & ~(page_sz - 1));
>  
> -	/*
> -	 * Page out range 0..512K, use 0..256K for positive tests and
> -	 * 256K..512K for negative tests expecting page faults
> -	 */
> -	for (off = 0; off < sizeof(file_contents) * 2; off += page_sz) {
> -		if (!ASSERT_OK(madvise(addr + off, page_sz, MADV_PAGEOUT),
> -			       "madvise pageout"))
> -			return errno;
> -	}
> -
>  	return 0;
>  }
>  
> @@ -90,6 +80,14 @@ static void run_test(const char *prog_name)
>  	if (!ASSERT_OK(err, "file_reader__load"))
>  		goto cleanup;
>  
> +	/*
> +	 * Page out range 0..512K, use 0..256K for positive tests and
> +	 * 256K..512K for negative tests expecting page faults
> +	 */
> +	if (!ASSERT_OK(madvise(addr, sizeof(file_contents) * 2, MADV_PAGEOUT),
> +		       "madvise pageout"))
> +		goto cleanup;
> +
>  	err = file_reader__attach(skel);
>  	if (!ASSERT_OK(err, "file_reader__attach"))
>  		goto cleanup;
> -- 
> 2.53.0
> 
