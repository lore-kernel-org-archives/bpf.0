Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 732895BAD7
	for <bpf@vger.kernel.org>; Tue,  2 Apr 2024 21:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712094027; cv=none; b=QhQdTIDlj3C+9F73TJA1xmETyGOSeEhk7gsU9nNJ9Zg/DBXL9pzVxFXCKUhhPMoPvs4memctl5NcuLpnMAvm8bFYvYOTA37aV2ccvOCX5HzcvqkzN8pOhYLpR0pKAmqrYVAo5MKABghj2bJXsD1iTNMJVhm1uWmA64C71TKRQis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712094027; c=relaxed/simple;
	bh=pEvvwp2uF+BoaAPGzbRrw8FkMpC0RI9U/huBZlSJSAQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tJ6szpZfLGSIEJIaJsrcOGizRuqgLtnzhp9+/htRhm4OdQ7PKjSGpv7m0Y0IUTZs/k8KrUTQo9S+GYWKhMyocv83ANgZEy25HSkAH/7p4qpCEA1hgv4YGPBfELGadsesOL5I2vp50NyH5t4rDZi4F3vPNg6n/za+iBjvWQs8ge8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PfD7vPyM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PfD7vPyM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C8DCC433F1;
	Tue,  2 Apr 2024 21:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712094027;
	bh=pEvvwp2uF+BoaAPGzbRrw8FkMpC0RI9U/huBZlSJSAQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=PfD7vPyMi4ZRAYbY9DXWosj8AeoLyQil3iAEHYFuPulyF23CX70w2izAEmOBoTm5P
	 Ztab41SdnUYCzFWXyVlRE1MSeeVw9t2am4Of4TukPmjXSZBT5oC1VLcfZTHtzoACo5
	 S1AxHsgc7UNtWJgG0EsoM3IqRcPn01lKrQOeQtRO+IAuwHsoTWxtePNqrAHJalNPwS
	 4jKHmlM8Wxf9WiNhmHrQ+V/V2rbWWjjaNw3JNKM+IAT8HZNJve0TC5iZCXZd3FWiIY
	 ljs/A6XQE7dkIIBBPkChgC2ZiibMoXc9J+Yu6BO3GW+lqcEEKh7AjTjXuXwwYNxupV
	 lg5sZd5mVjJxg==
Message-ID: <45c72ae1-ab0d-439b-8237-80a38e15f571@kernel.org>
Date: Tue, 2 Apr 2024 22:40:22 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH bpf-next v4] bpftool: Mount bpffs on provided dir instead
 of parent dir
To: Sahil Siddiq <icegambit91@gmail.com>, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org
Cc: martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@google.com, haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org
References: <20240401190407.20363-1-icegambit91@gmail.com>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <20240401190407.20363-1-icegambit91@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 01/04/2024 20:04, Sahil Siddiq wrote:
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
> Closes: https://github.com/libbpf/bpftool/issues/100
> Fixes: 2a36c26fe3b8 ("bpftool: Support bpffs mountpoint as pin path for prog loadall")
> 
> Changes since v1:
>  - Split "mount_bpffs_for_pin" into two functions.
>    This is done to improve maintainability and readability.
> 
> Changes since v2:
> - mount_bpffs_for_pin: rename to "create_and_mount_bpffs_dir".
> - mount_bpffs_given_file: rename to "mount_bpffs_given_file".
> - create_and_mount_bpffs_dir:
>   - introduce "dir_exists" boolean.
>   - remove new dir if "mnt_fs" fails.
> - improve error handling and error messages.
> 
> Changes since v3:
> - Rectify function name.
> - Improve error messages and formatting.
> - mount_bpffs_for_file:
>   - Check if dir exists before block_mount check.
> 
> Signed-off-by: Sahil Siddiq <icegambit91@gmail.com>

Tested-by: Quentin Monnet <qmo@kernel.org>
Reviewed-by: Quentin Monnet <qmo@kernel.org>

> ---
>  tools/bpf/bpftool/common.c     | 98 +++++++++++++++++++++++++++++-----
>  tools/bpf/bpftool/iter.c       |  2 +-
>  tools/bpf/bpftool/main.h       |  3 +-
>  tools/bpf/bpftool/prog.c       |  5 +-
>  tools/bpf/bpftool/struct_ops.c |  2 +-
>  5 files changed, 94 insertions(+), 16 deletions(-)
> 
> diff --git a/tools/bpf/bpftool/common.c b/tools/bpf/bpftool/common.c
> index cc6e6aae2447..56a5abbb1bf8 100644
> --- a/tools/bpf/bpftool/common.c
> +++ b/tools/bpf/bpftool/common.c
> @@ -244,29 +244,103 @@ int open_obj_pinned_any(const char *path, enum bpf_obj_type exp_type)
>  	return fd;
>  }
>  
> -int mount_bpffs_for_pin(const char *name, bool is_dir)
> +int create_and_mount_bpffs_dir(const char *dir_name)
>  {
>  	char err_str[ERR_MAX_LEN];
> -	char *file;
> -	char *dir;
> +	bool dir_exists;
>  	int err = 0;
>  
> -	if (is_dir && is_bpffs(name))
> +	if (is_bpffs(dir_name))
>  		return err;
>  
> -	file = malloc(strlen(name) + 1);
> -	if (!file) {
> +	dir_exists = (access(dir_name, F_OK) == 0);
> +
> +	if (!dir_exists) {
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
> +		if (access(parent_name, F_OK) == -1) {
> +			p_err("can't create dir '%s' to pin BPF object: parent dir '%s' doesn't exist",
> +			      dir_name, parent_name);
> +			free(temp_name);
> +			return -1;
> +		}
> +
> +		free(temp_name);
> +	}
> +
> +	if (block_mount) {
> +		p_err("no BPF file system found, not mounting it due to --nomount option");
> +		return -1;
> +	}
> +
> +	if (!dir_exists) {
> +		err = mkdir(dir_name, 0700);
> +		if (err) {
> +			p_err("failed to create dir '%s': %s", dir_name, strerror(errno));
> +			return err;
> +		}
> +	}
> +
> +	err = mnt_fs(dir_name, "bpf", err_str, ERR_MAX_LEN);
> +	if (err) {
> +		err_str[ERR_MAX_LEN - 1] = '\0';
> +		p_err("can't mount BPF file system on given dir '%s': %s",
> +		      dir_name, err_str);
> +
> +		if (!dir_exists)
> +			rmdir(dir_name);
> +	}
> +
> +	return err;
> +}
> +
> +int mount_bpffs_for_file(const char *file_name)
> +{
> +	char err_str[ERR_MAX_LEN];
> +	char *temp_name;
> +	char *dir;
> +	int err = 0;
> +
> +	if (access(file_name, F_OK) != -1) {
> +		p_err("can't pin BPF object: path '%s' already exists", file_name);
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
>  	if (is_bpffs(dir))
>  		/* nothing to do if already mounted */
>  		goto out_free;
>  
> +	if (access(dir, F_OK) == -1) {
> +		p_err("can't pin BPF object: dir '%s' doesn't exist", dir);
> +		free(temp_name);
> +		return -1;

Or:

	p_err(...);
	err = -1;
	goto out_free;

to be more consistent with the other error paths. But that's fine, no
need to respin for that.

Thanks a lot!
