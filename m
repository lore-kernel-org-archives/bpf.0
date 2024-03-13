Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F0E845028
	for <bpf@vger.kernel.org>; Wed, 13 Mar 2024 15:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710344869; cv=none; b=d/n1mGBoLcxeHX+m891p8SGYNdwBZSv3Nr6cCMvx1zdp0HB3xPhd2GXJ2yt6YEsrEBd2hJV9dcDI3s/KCklXGoXyFcpfRddhqv4L2ZJth2wz77ib4NZDSLJKXV6tQrJ7ZTKxJ4W29z6pP5Bd2jLYsEgH6Xqhi2WDlZrgrDaotyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710344869; c=relaxed/simple;
	bh=m6/NWkeBHZ4vXS4kiqJMpBWPaDfwpbbvjAko5G3N8Kw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qy7eDKZR4zx1ZMRob/bAA7k+HxJvO6tec1Ey2HOCv76iCWLfzNn34//2xFQwyIZ8DCpM3PesK6wedhPNd9oFCwlvry+8oNCqDibbyd9zoj845m2SFt3SKHf+0JU6vx4HqnCby3g/TA8Sc+Q8i7gHwNfeHpRsruYu+zK91MkYcZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=eLfWa3TE; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="eLfWa3TE"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-413ea3219feso4982705e9.3
        for <bpf@vger.kernel.org>; Wed, 13 Mar 2024 08:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1710344865; x=1710949665; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ENm6PXu0TksaJxBJ6999//XUXaJUtM0kT9c1uCxe5r4=;
        b=eLfWa3TE89udiy1B3eKRakQY0jroDp62aBpNy9Ry7/9MdIAlzKY2+MvvxENOvsO5Sc
         hAflTR0Dau+WFa7/IedntjWUWV28Oyh8LZg0navfimu0U5xbqKEbKjxqrGOCQM0ga2bG
         IICn/lYgBcOikEL+8IHMbG/riBeRE6yyT3H2IR7hSsr1qKbgiSQBpfr54/jfe6Er1uxn
         NynDYvLeBNLsWXgLf4fI82J8VJ/lIItWljYEuIvHBFT8XeJBrxj0ql7jou23cVkTJpcF
         V2C8+3mHIn3Aw4+TJB288bAXm04hG6kZBlPnDgA/bJZjA5ztRzPmLvDbsAvdENdSyKR8
         xflA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710344865; x=1710949665;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ENm6PXu0TksaJxBJ6999//XUXaJUtM0kT9c1uCxe5r4=;
        b=n8jTfotjJroUSw6La6AKXgX52mh45dv9qMzXS5cgysfizCdz81EagFL2g4z/Z7wMc2
         BNeZ67vxTydJPHvQYQ8wF6YRsxUrfbIN5MvoSB75+KdQQJGUZ++Uk+JygFolZQFgbTyp
         XDKC6W9AlF8vgssahI4wzLj2rxNBezZ7X8voHINpu3h9s17OwqUsMzX9Gf4o+zYd09iq
         zOikHzPD9XbqkSiMoQiQEcCNa0w9bTPn2bUgIDZ0FZUZC98FgWl0pJl/UCYvadu+ByqB
         iO9RmLFDDRZoA7HFJ9iIFsfaiLImJYbO8coiE+00C4GMZ40fM57iIsOBL9fvyYxRD2U0
         Jezw==
X-Forwarded-Encrypted: i=1; AJvYcCXLjqDgIgXgOvEPV8+qqTWFCeje/CxqeOveaJsVIKQfLICR7Uxr2Ljavd1GmY5xpyK47ggzinnpJ9tLH46DLAU9zd4F
X-Gm-Message-State: AOJu0YwgqgJO+mg6Tx8EKW1tY3Y+MAd6VKlpHEz51d0SljalQlora8VN
	iagvfhTwH+7/qfst4Ok1CP3PL0acu4cJe6QOtvLopWpIf5GqGSNe1DFMkUcAu8Q=
X-Google-Smtp-Source: AGHT+IE2aRlV8ooxomsaOom3WWV7J2L6fA0a7CXidHY4q7gjiwvoVoMx/EThdcp/L2Z4gMd0g3sFGQ==
X-Received: by 2002:a05:600c:46c9:b0:413:1d40:88fb with SMTP id q9-20020a05600c46c900b004131d4088fbmr275288wmo.17.1710344865400;
        Wed, 13 Mar 2024 08:47:45 -0700 (PDT)
Received: from ?IPV6:2a02:8011:e80c:0:4ac2:8d7d:13ad:ef01? ([2a02:8011:e80c:0:4ac2:8d7d:13ad:ef01])
        by smtp.gmail.com with ESMTPSA id j15-20020a05600c190f00b0041312855081sm2644542wmq.5.2024.03.13.08.47.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Mar 2024 08:47:45 -0700 (PDT)
Message-ID: <c3cb7598-f777-4714-9e43-d9e0fbdf8711@isovalent.com>
Date: Wed, 13 Mar 2024 15:47:44 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2] bpftool: Mount bpffs on provided dir instead
 of parent dir
Content-Language: en-GB
To: Sahil Siddiq <icegambit91@gmail.com>, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org
Cc: martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@google.com, haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org
References: <20240308130619.28123-1-icegambit91@gmail.com>
From: Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <20240308130619.28123-1-icegambit91@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Thanks! Apologies for the delay.

2024-03-08 13:07 UTC+0000 ~ Sahil Siddiq <icegambit91@gmail.com>
> When pinning programs/objects under PATH (eg: during "bpftool prog
> loadall") the bpffs is mounted on the parent dir of PATH in the
> following situations:
> - the given dir exists but it is not bpffs.
> - the given dir doesn't exist and the parent dir is not bpffs.
> 
> Mounting on the parent dir can also have the unintentional side-
> effect of hiding other files located under the parent dir.
> 
> If the given dir exists but is not bpffs, then the bpffs should
> be mounted on the given dir and not its parent dir.
> 
> Similarly, if the given dir doesn't exist and its parent dir is not
> bpffs, then the given dir should be created and the bpffs should be
> mounted on this new dir.
> 
> Link: https://lore.kernel.org/bpf/2da44d24-74ae-a564-1764-afccf395eeec@isovalent.com/T/#t
> 
> Closes: https://github.com/libbpf/bpftool/issues/100
> 
> Fixes: 2a36c26fe3b8 ("bpftool: Support bpffs mountpoint as pin path for prog loadall")
> 
> Signed-off-by: Sahil Siddiq <icegambit91@gmail.com>

Note: you don't need the blank lines between the tags.

> ---
> Changes since v1:
>  - Split "mount_bpffs_for_pin" into two functions:
>    - mount_bpffs_on_dir
>    - mount_bpffs_given_file
>    This is done to improve maintainability and readability.
>  - Improve error messages
>  - (mount_bpffs_given_file): If the file already exists, throw an
>    error instead of waiting for bpf_obj_pin() to throw an error
>  - Code style changes

You can keep the changelog as part of the patch description.

> 
>  tools/bpf/bpftool/common.c     | 78 +++++++++++++++++++++++++++++-----
>  tools/bpf/bpftool/iter.c       |  2 +-
>  tools/bpf/bpftool/main.h       |  3 +-
>  tools/bpf/bpftool/prog.c       |  5 ++-
>  tools/bpf/bpftool/struct_ops.c |  2 +-
>  5 files changed, 75 insertions(+), 15 deletions(-)
> 
> diff --git a/tools/bpf/bpftool/common.c b/tools/bpf/bpftool/common.c
> index cc6e6aae2447..d2746681200e 100644
> --- a/tools/bpf/bpftool/common.c
> +++ b/tools/bpf/bpftool/common.c
> @@ -244,24 +244,80 @@ int open_obj_pinned_any(const char *path, enum bpf_obj_type exp_type)
>  	return fd;
>  }
>  
> -int mount_bpffs_for_pin(const char *name, bool is_dir)
> +int mount_bpffs_on_dir(const char *dir_name)

With all the checks and the potential directory creation, we could maybe
rename this into "prepare_bpffs_dir()" or something like this?

>  {
>  	char err_str[ERR_MAX_LEN];
> -	char *file;
> -	char *dir;
>  	int err = 0;
>  
> -	if (is_dir && is_bpffs(name))
> +	if (is_bpffs(dir_name))
>  		return err;
>  
> -	file = malloc(strlen(name) + 1);
> -	if (!file) {
> +	if (access(dir_name, F_OK) == -1) {
> +		char *temp_name;
> +		char *parent_name;
> +
> +		temp_name = malloc(strlen(dir_name) + 1);
> +		if (!temp_name) {
> +			p_err("mem alloc failed");
> +			return -1;
> +		}
> +
> +		strcpy(temp_name, dir_name);
> +		parent_name = dirname(temp_name);
> +
> +		if (is_bpffs(parent_name)) {
> +			/* nothing to do if already mounted */
> +			free(temp_name);
> +			return err;
> +		}
> +
> +		free(temp_name);
> +
> +		if (block_mount) {
> +			p_err("no BPF file system found, not mounting it due to --nomount option");
> +			return -1;
> +		}
> +
> +		err = mkdir(dir_name, 0700);
> +		if (err) {
> +			p_err("failed to create dir (%s): %s", dir_name, strerror(errno));
> +			return err;
> +		}
> +	} else if (block_mount) {
> +		p_err("no BPF file system found, not mounting it due to --nomount option");
> +		return -1;
> +	}

I'd maybe change this block a little (although it's up to you):

	bool dir_exists;

	dire_exists = (access(...) == 0);
	if (!dir_exists) {
		...
		free(temp_name);
	}

	if (block_mount) {
		...
	}

	if (!dir_exists) {
		err = mkdir(...);
		...
	}

	err = mnt_fs(...);
	...

This would also enable us to remove the directory we just created, if
we're not able to mount the bpffs on it, before leaving the function.

> +
> +	err = mnt_fs(dir_name, "bpf", err_str, ERR_MAX_LEN);
> +	if (err) {
> +		err_str[ERR_MAX_LEN - 1] = '\0';
> +		p_err("can't mount BPF file system on given dir (%s): %s",
> +		      dir_name, err_str);
> +	}
> +
> +	return err;
> +}
> +
> +int mount_bpffs_given_file(const char *file_name)

I'd remove/replace "given" from the name, maybe "mount_bpffs_for_file"?

> +{
> +	char err_str[ERR_MAX_LEN];
> +	char *temp_name;
> +	char *dir;
> +	int err = 0;
> +
> +	if (access(file_name, F_OK) != -1) {
> +		p_err("bpf object can't be pinned since file (%s) already exists", file_name);

I'd remove "file", the existing object might be a directory and it might
be confusing.

> +		return -1;
> +	}
> +
> +	temp_name = malloc(strlen(file_name) + 1);
> +	if (!temp_name) {
>  		p_err("mem alloc failed");
>  		return -1;
>  	}
>  
> -	strcpy(file, name);
> -	dir = dirname(file);
> +	strcpy(temp_name, file_name);
> +	dir = dirname(temp_name);
>  

Here, we could check for the existence of "dir", and error out
otherwise. The reason is that with the current code, if dir does not
exist but user passes --nomount, then we fail to pin the path (given
that the directory is not present), but the message returned will be "no
BPF file system found, not mounting it due to --nomount option", which
is confusing.

Same note applies to the other function as well.

>  	if (is_bpffs(dir))
>  		/* nothing to do if already mounted */
> @@ -277,11 +333,11 @@ int mount_bpffs_for_pin(const char *name, bool is_dir)
>  	if (err) {
>  		err_str[ERR_MAX_LEN - 1] = '\0';
>  		p_err("can't mount BPF file system to pin the object (%s): %s",

We could also indicate the path where we tried to mount the bpffs, in
this message.

> -		      name, err_str);
> +		      file_name, err_str);
>  	}
>  
>  out_free:
> -	free(file);
> +	free(temp_name);
>  	return err;
>  }
>  
> @@ -289,7 +345,7 @@ int do_pin_fd(int fd, const char *name)
>  {
>  	int err;
>  
> -	err = mount_bpffs_for_pin(name, false);
> +	err = mount_bpffs_given_file(name);
>  	if (err)
>  		return err;
>  
> diff --git a/tools/bpf/bpftool/iter.c b/tools/bpf/bpftool/iter.c
> index 6b0e5202ca7a..3911563dcc60 100644
> --- a/tools/bpf/bpftool/iter.c
> +++ b/tools/bpf/bpftool/iter.c
> @@ -76,7 +76,7 @@ static int do_pin(int argc, char **argv)
>  		goto close_obj;
>  	}
>  
> -	err = mount_bpffs_for_pin(path, false);
> +	err = mount_bpffs_given_file(path);
>  	if (err)
>  		goto close_link;
>  
> diff --git a/tools/bpf/bpftool/main.h b/tools/bpf/bpftool/main.h
> index b8bb08d10dec..20e06ad183ec 100644
> --- a/tools/bpf/bpftool/main.h
> +++ b/tools/bpf/bpftool/main.h
> @@ -142,7 +142,8 @@ const char *get_fd_type_name(enum bpf_obj_type type);
>  char *get_fdinfo(int fd, const char *key);
>  int open_obj_pinned(const char *path, bool quiet);
>  int open_obj_pinned_any(const char *path, enum bpf_obj_type exp_type);
> -int mount_bpffs_for_pin(const char *name, bool is_dir);
> +int mount_bpffs_given_file(const char *file_name);
> +int mount_bpffs_on_dir(const char *dir_name);
>  int do_pin_any(int argc, char **argv, int (*get_fd_by_id)(int *, char ***));
>  int do_pin_fd(int fd, const char *name);
>  
> diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
> index 9cb42a3366c0..09b5f0415a5e 100644
> --- a/tools/bpf/bpftool/prog.c
> +++ b/tools/bpf/bpftool/prog.c
> @@ -1778,7 +1778,10 @@ static int load_with_options(int argc, char **argv, bool first_prog_only)
>  		goto err_close_obj;
>  	}
>  
> -	err = mount_bpffs_for_pin(pinfile, !first_prog_only);
> +	if (first_prog_only)
> +		err = mount_bpffs_given_file(pinfile);
> +	else
> +		err = mount_bpffs_on_dir(pinfile);
>  	if (err)
>  		goto err_close_obj;
>  
> diff --git a/tools/bpf/bpftool/struct_ops.c b/tools/bpf/bpftool/struct_ops.c
> index d573f2640d8e..bf50a99b2501 100644
> --- a/tools/bpf/bpftool/struct_ops.c
> +++ b/tools/bpf/bpftool/struct_ops.c
> @@ -515,7 +515,7 @@ static int do_register(int argc, char **argv)
>  	if (argc == 1)
>  		linkdir = GET_ARG();
>  
> -	if (linkdir && mount_bpffs_for_pin(linkdir, true)) {
> +	if (linkdir && mount_bpffs_on_dir(linkdir)) {
>  		p_err("can't mount bpffs for pinning");
>  		return -1;
>  	}

Other than the comments above, the patch works well, and the different
cases are much easier to follow than in v1, thanks!

I've checked that the programs load as expected, the directories are
created (or not) as expected, and the bpffs is mounted (or not) as
expected, for all the cases I could think of, with the following
commands (copied here, for the record), all worked as I expected:

    mkdir -p /sys/fs/bpf/some_dir
    mkdir -p /tmp/test-dir/some_dir

    # /tmp/ret.o contains 1 program, /tmp/rets.o contains several ones

    # Load one program under bpffs
    bpftool prog load /tmp/ret.o /sys/fs/bpf/foo type xdp
    mount | grep bpf
    ls /sys/fs/bpf/foo

    # Try to load one program when pin path exists, under bpffs
    bpftool prog load /tmp/ret.o /sys/fs/bpf/foo type xdp
    mount | grep bpf
    ls /sys/fs/bpf/foo
    rm /sys/fs/bpf/foo

    # Load one program under bpffs, with --nomount
    bpftool --nomount prog load /tmp/ret.o /sys/fs/bpf/foo type xdp
    mount | grep bpf
    ls /sys/fs/bpf/foo
    rm /sys/fs/bpf/foo

    # Load one program outside of bpffs, with --nomount
    bpftool --nomount prog load /tmp/ret.o /tmp/test-dir/foo type xdp
    mount | grep bpf
    ls /tmp/test-dir/foo
    # Load one program outside of bpffs
    bpftool prog load /tmp/ret.o /tmp/test-dir/foo type xdp
    mount | grep bpf
    ls /tmp/test-dir/foo
    # Try to load one program when pin path exists, outside of bpffs
    bpftool prog load /tmp/ret.o /tmp/test-dir/foo type xdp
    mount | grep bpf
    rm /tmp/test-dir/foo
    umount /tmp/test-dir
    umount /tmp/test-dir

    # Load multiple programs under bpffs, directory exists
    bpftool prog loadall /tmp/rets.o /sys/fs/bpf/some_dir
    mount | grep bpf
    ls /sys/fs/bpf/some_dir
    rm /sys/fs/bpf/some_dir/*
    # Load multiple programs under bpffs, with -n, directory exists
    bpftool --nomount prog loadall /tmp/rets.o /sys/fs/bpf/some_dir
    mount | grep bpf
    ls /sys/fs/bpf/some_dir
    rm /sys/fs/bpf/some_dir/*

    # Load multiple programs under bpffs, directory does not exist
    bpftool prog loadall /tmp/rets.o /sys/fs/bpf/new_dir
    mount | grep bpf
    ls /sys/fs/bpf/new_dir
    rm -r /sys/fs/bpf/new_dir
    # Load multiple progs under bpffs, with -n, directory doesn't exist
    bpftool --nomount prog loadall /tmp/rets.o /sys/fs/bpf/new_dir
    mount | grep bpf
    ls /sys/fs/bpf/new_dir
    rm -r /sys/fs/bpf/new_dir

    # Load multiple programs outside of bpffs, directory exists
    bpftool prog loadall /tmp/rets.o /tmp/test-dir/some_dir
    mount | grep bpf
    ls /tmp/test-dir/some_dir
    rm /tmp/test-dir/some_dir/*
    umount /tmp/test-dir/some_dir
    umount /tmp/test-dir/some_dir
    # Try to load multiple progs outside of bpffs, with -n, dir exists
    bpftool --nomount prog loadall /tmp/rets.o /tmp/test-dir/some_dir
    mount | grep bpf
    ls /tmp/test-dir/some_dir

    # Load multiple programs outside of bpffs, directory does not exist
    bpftool prog loadall /tmp/rets.o /tmp/test-dir/new_dir
    mount | grep bpf
    ls /tmp/test-dir/new_dir
    umount /tmp/test-dir/new_dir
    umount /tmp/test-dir/new_dir
    rm -r /tmp/test-dir/new_dir
    # Try to load multiple progs outside of bpffs, with -n, new dir
    bpftool --nomount prog loadall /tmp/rets.o /tmp/test-dir/new_dir
    mount | grep bpf
    ls /tmp/test-dir/new_dir
    rm -r /tmp/test-dir

Thanks,
Quentin
