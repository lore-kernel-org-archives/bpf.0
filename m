Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D1A364BA
	for <bpf@vger.kernel.org>; Mon, 18 Mar 2024 11:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710761779; cv=none; b=kPNqXbRMRJE//3iKXxcUo6cuH4hGnrtWrgs4JYHj4Zy+EQzqAU3Su+Y+8GOdMepYTKw4aY1Q+tEcR599G3haVmQGiCIG+93BQ9H7wM5WYFKnaXJASfkWH21tDC7VamC2wR+7TvKeGYYBsuU2XGLLlV9j24E6SraWFbMYe4UG+KQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710761779; c=relaxed/simple;
	bh=TGTKiot/rRstCtyq9BgmYy56FNvuwNq/f8mArirnp2c=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tk6z6sLAuus8D+q+8LJ+k9pYoqI66L5TCJPjOYqVCyAV0znJIxd5kwo5eUomjsevi1bEmVJYLHI+idDe2QNavMagYmGwpam61zETVxxRWarY98USor07YIBJbZ2Cz9fhq5MdDUQgUzsDReIelc7LeTZ5UBzQ/fUkGkPiP4jnMXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jvdewy32; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jvdewy32"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-56a2b881911so941846a12.3
        for <bpf@vger.kernel.org>; Mon, 18 Mar 2024 04:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710761776; x=1711366576; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dHgNspFpYy4Tk6hLd5sv6GAFlHU6v9NihaYQl2h6YYU=;
        b=Jvdewy32Wv3zn5Rxaq/jf6ndXZvZWcZn7hmYz7Vnki8qfcaBC7msvLaYkxu5ls7WpA
         4XL6JRvmfqWtktQ8O7d1+Aqooz2jRun+b2TYMSOo2sfs+y5sF692IwoZYEQhNlwESL0Z
         u9gA7FYOoJhu8xBPpYp9F3OYt9vFcLlS880J9gPluj9shiLQKyt3noIpWWgbKYFeyvfc
         TSZTC1muwIHjLDGtNF22TPr8d9BbqVM1uNXD7fU87Bq1srJcqlN8NvZVfNMe4r6ENCmo
         tTs5VdY23pLLq3ZrToYNhQm9DCIYsP4Bj5mM+ewMSYGCLAI4JHLH4bEL67zerz3Ih/DC
         zWYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710761776; x=1711366576;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dHgNspFpYy4Tk6hLd5sv6GAFlHU6v9NihaYQl2h6YYU=;
        b=TO/tKjZO76l8fg8Th9+NQ/ATPRX8sN+bLlNYM3ZbKBFh86+i1mti9y9zDyHEN0GRTQ
         8r/rPO2kk0bVCSIHJJZFzulwQ//ijp/LGiR7NpKezl0EXsnVpfua9V6+BwPcoPJtlcZ6
         OwN5LAABylCNOqXMJxOroIwKG5DXdi1JIccTlEpH0CvbBKdMqawzkuqazNg6I/z7xuaw
         bfmtQwpIHfnI3Wv8WxVexFMG0RI+mFmOxdWbm3mKh59kutbXY5Z/sPP3V2b3MIAQ/ESH
         ReCFwFOQUqYz5xg9Syn4Zrn3MrR+YPBEf/mNIftHQE+GVyk+19tbMpkTvYLAb7zDIivd
         eNPw==
X-Gm-Message-State: AOJu0Yx0ZGmUTwdml3Zbci9Q1jaaK5T25wuWOb+hmaow7lrpFYzqEoXo
	Cfxk/Hxz9td1+MGj+3qYBfB8qTpkxkE5KCh3Omae6lXDM4mnmnsc
X-Google-Smtp-Source: AGHT+IFVluTw9z8VAFobLKYuRjrO8QMRotS22sW5SkVTJfZI6KHgh+Z3x3BEbAEEuZd+rHOPsAaUpg==
X-Received: by 2002:a17:906:1d13:b0:a46:a662:e56f with SMTP id n19-20020a1709061d1300b00a46a662e56fmr3867435ejh.38.1710761775531;
        Mon, 18 Mar 2024 04:36:15 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id ws4-20020a170907704400b00a46d001a259sm181040ejb.52.2024.03.18.04.36.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 04:36:15 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 18 Mar 2024 12:36:13 +0100
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>, kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Yury Namgung <ynamgung@meta.com>
Subject: Re: [PATCH bpf-next v2 2/5] selftests/bpf: Replace CHECK with
 ASSERT_* in ns_current_pid_tgid test
Message-ID: <ZfgnLQ5ytpU2IcUX@krava>
References: <20240315184849.2974556-1-yonghong.song@linux.dev>
 <20240315184859.2975543-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240315184859.2975543-1-yonghong.song@linux.dev>

On Fri, Mar 15, 2024 at 11:48:59AM -0700, Yonghong Song wrote:
> Replace CHECK in selftest ns_current_pid_tgid with recommended ASSERT_* style.
> I also shortened subtest name as the prefix of subtest name is covered
> by the test name already.
> 
> This patch does fix a testing issue. Currently even if bss->user_{pid,tgid}
> is not correct, the test still passed since the clone func returns 0.
> I fixed it to return a non-zero value if bss->user_{pid,tgid} is incorrect.
> 
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> ---
>  .../bpf/prog_tests/ns_current_pid_tgid.c      | 36 ++++++++++---------
>  1 file changed, 19 insertions(+), 17 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/ns_current_pid_tgid.c b/tools/testing/selftests/bpf/prog_tests/ns_current_pid_tgid.c
> index 24d493482ffc..3a0664a86243 100644
> --- a/tools/testing/selftests/bpf/prog_tests/ns_current_pid_tgid.c
> +++ b/tools/testing/selftests/bpf/prog_tests/ns_current_pid_tgid.c
> @@ -20,19 +20,19 @@ static int test_current_pid_tgid(void *args)
>  {
>  	struct test_ns_current_pid_tgid__bss  *bss;
>  	struct test_ns_current_pid_tgid *skel;
> -	int err = -1, duration = 0;
> +	int ret = -1, err;
>  	pid_t tgid, pid;
>  	struct stat st;
>  
>  	skel = test_ns_current_pid_tgid__open_and_load();
> -	if (CHECK(!skel, "skel_open_load", "failed to load skeleton\n"))
> -		goto cleanup;
> +	if (!ASSERT_OK_PTR(skel, "test_ns_current_pid_tgid__open_and_load"))
> +		goto out;

you could just return in here so there's no need for the out label
otherwise lgtm

Acked-by: Jiri Olsa <jolsa@kernel.org>


jirka

>  
>  	pid = syscall(SYS_gettid);
>  	tgid = getpid();
>  
>  	err = stat("/proc/self/ns/pid", &st);
> -	if (CHECK(err, "stat", "failed /proc/self/ns/pid: %d\n", err))
> +	if (!ASSERT_OK(err, "stat /proc/self/ns/pid"))
>  		goto cleanup;
>  
>  	bss = skel->bss;
> @@ -42,24 +42,26 @@ static int test_current_pid_tgid(void *args)
>  	bss->user_tgid = 0;
>  
>  	err = test_ns_current_pid_tgid__attach(skel);
> -	if (CHECK(err, "skel_attach", "skeleton attach failed: %d\n", err))
> +	if (!ASSERT_OK(err, "test_ns_current_pid_tgid__attach"))
>  		goto cleanup;
>  
>  	/* trigger tracepoint */
>  	usleep(1);
> -	ASSERT_EQ(bss->user_pid, pid, "pid");
> -	ASSERT_EQ(bss->user_tgid, tgid, "tgid");
> -	err = 0;
> +	if (!ASSERT_EQ(bss->user_pid, pid, "pid"))
> +		goto cleanup;
> +	if (!ASSERT_EQ(bss->user_tgid, tgid, "tgid"))
> +		goto cleanup;
> +	ret = 0;
>  
>  cleanup:
> -	 test_ns_current_pid_tgid__destroy(skel);
> -
> -	return err;
> +	test_ns_current_pid_tgid__destroy(skel);
> +out:
> +	return ret;
>  }
>  
>  static void test_ns_current_pid_tgid_new_ns(void)
>  {
> -	int wstatus, duration = 0;
> +	int wstatus;
>  	pid_t cpid;
>  
>  	/* Create a process in a new namespace, this process
> @@ -68,21 +70,21 @@ static void test_ns_current_pid_tgid_new_ns(void)
>  	cpid = clone(test_current_pid_tgid, child_stack + STACK_SIZE,
>  		     CLONE_NEWPID | SIGCHLD, NULL);
>  
> -	if (CHECK(cpid == -1, "clone", "%s\n", strerror(errno)))
> +	if (!ASSERT_NEQ(cpid, -1, "clone"))
>  		return;
>  
> -	if (CHECK(waitpid(cpid, &wstatus, 0) == -1, "waitpid", "%s\n", strerror(errno)))
> +	if (!ASSERT_NEQ(waitpid(cpid, &wstatus, 0), -1, "waitpid"))
>  		return;
>  
> -	if (CHECK(WEXITSTATUS(wstatus) != 0, "newns_pidtgid", "failed"))
> +	if (!ASSERT_OK(WEXITSTATUS(wstatus), "newns_pidtgid"))
>  		return;
>  }
>  
>  /* TODO: use a different tracepoint */
>  void serial_test_ns_current_pid_tgid(void)
>  {
> -	if (test__start_subtest("ns_current_pid_tgid_root_ns"))
> +	if (test__start_subtest("root_ns_tp"))
>  		test_current_pid_tgid(NULL);
> -	if (test__start_subtest("ns_current_pid_tgid_new_ns"))
> +	if (test__start_subtest("new_ns_tp"))
>  		test_ns_current_pid_tgid_new_ns();
>  }
> -- 
> 2.43.0
> 
> 
