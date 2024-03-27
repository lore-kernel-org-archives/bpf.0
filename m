Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C247318C36
	for <bpf@vger.kernel.org>; Wed, 27 Mar 2024 01:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711502097; cv=none; b=IPHMOmbQ41yo0BORRWvl11ZyLJgFDeK4uV24ahHUEXhQjBufejv6t2Wxh9FGwqK/4AgEmrTTU+dXBJGjov6X7BuVvz5Z88ir/mf7z6i+kTFbLcsXD0i0Fto4P27c/J4fUcTXGtp5YV35MwCGJPtg00oJc0/LcsrI7LTajLCJ6zE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711502097; c=relaxed/simple;
	bh=D33s9UFjNEmhrQM7ET7lHvtQvnzVqr/8bpZtPixabSY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N7jK/BUFya5H//BSPDuDUsheUic9whXoPi2N0Mgk4cmzIIy7iTYiM04j4VGP9GnIgm/j8zMmz9afcMddUlbAzwCJo81TWXBwn644xxLzeYY3MPl6W1K/OmwnTb+UyWkUzwZJI9JV21mQPFSuewEMPxRxOUhaamQvOujT5jCmrcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CwHI/Hr8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CwHI/Hr8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8DBBC433F1;
	Wed, 27 Mar 2024 01:14:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711502097;
	bh=D33s9UFjNEmhrQM7ET7lHvtQvnzVqr/8bpZtPixabSY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=CwHI/Hr8sdNH6DeV16xatiEHDjRFnffo3+2OKhYpKQHcOUYQUiYX+aLx00jVRmxMR
	 S2+VyuSJw0eCNnjsW0CuZS4I/77Ds6bbjzFmwOXiHTIxnXlGbFTpcd8qg+AzETuf9f
	 kI3HmS0RFKUcWxadO/WWy6/h9InUAmMpESJ6Oj0drIrL7+qtlTL9zR/5FTRAn/y1KK
	 YImFLqzVF8q+/3rOd40+p/XowNjh8H9OuRtJXVgxiHWjI1h8EejJqq7r8ahlQmY8Ev
	 SMp3qUFocJUifwEOU2TGfDpEF7mwE1hr4+QkIhLbV7wtlsQGM4SzIy78QI47viKlMs
	 HpybjOWImtytw==
Message-ID: <dfcab867-0b5d-4d3c-aeb0-43633b571196@kernel.org>
Date: Wed, 27 Mar 2024 01:14:52 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH bpf-next v3] bpftool: Mount bpffs on provided dir instead
 of parent dir
To: Sahil Siddiq <icegambit91@gmail.com>, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org
Cc: martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@google.com, haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org
References: <20240321191955.24992-1-icegambit91@gmail.com>
Content-Language: en-GB
From: Quentin Monnet <qmo@kernel.org>
In-Reply-To: <20240321191955.24992-1-icegambit91@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Sahil, sorry for the delay, and thanks for the v3! I've got some 
minor comments on the error messages, but the rest of the code looks 
mostly good - although you forgot to rename a function and it currently 
fails to compile. Please see inline below.

On 21/03/2024 19:19, Sahil Siddiq wrote:
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
>   - Split "mount_bpffs_for_pin" into two functions.
>     This is done to improve maintainability and readability.
> 
> Changes since v2:
> - mount_bpffs_for_pin: rename to "create_and_mount_bpffs_dir".
> - mount_bpffs_given_file: rename to "mount_bpffs_given_file".

That's the same!

> - create_and_mount_bpffs_dir:
>    - introduce "dir_exists" boolean.
>    - remove new dir if "mnt_fs" fails.
> - improve error handling and error messages.
> 
> Signed-off-by: Sahil Siddiq <icegambit91@gmail.com>
> ---
>   tools/bpf/bpftool/common.c     | 93 ++++++++++++++++++++++++++++++----
>   tools/bpf/bpftool/iter.c       |  2 +-
>   tools/bpf/bpftool/main.h       |  3 +-
>   tools/bpf/bpftool/prog.c       |  5 +-
>   tools/bpf/bpftool/struct_ops.c |  2 +-
>   5 files changed, 90 insertions(+), 15 deletions(-)
> 
> diff --git a/tools/bpf/bpftool/common.c b/tools/bpf/bpftool/common.c
> index cc6e6aae2447..dce73105b0a5 100644
> --- a/tools/bpf/bpftool/common.c
> +++ b/tools/bpf/bpftool/common.c
> @@ -244,24 +244,95 @@ int open_obj_pinned_any(const char *path, enum bpf_obj_type exp_type)
>   	return fd;
>   }
>   
> -int mount_bpffs_for_pin(const char *name, bool is_dir)
> +int create_and_mount_bpffs_dir(const char *dir_name)
>   {
>   	char err_str[ERR_MAX_LEN];
> -	char *file;
> -	char *dir;
>   	int err = 0;
> +	bool dir_exists;

Nit: "reverse Christmas tree order": In the absence of other criteria, 
we tend to sort the variable definitions by line length. Please swap 
dir_exists and err.

>   
> -	if (is_dir && is_bpffs(name))
> +	if (is_bpffs(dir_name))
>   		return err;
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
> +			p_err("bpf object can't be pinned since dir (%s) does not exist",

Maybe "can't create directory '%s' to pin BPF object: parent dir %s does 
not exist"?

> +			      parent_name);
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
> +			p_err("failed to create dir (%s): %s", dir_name, strerror(errno));

Or "failed to create directory '%s': %s".

> +			return err;
> +		}
> +	}
> +
> +	err = mnt_fs(dir_name, "bpf", err_str, ERR_MAX_LEN);
> +	if (err) {
> +		err_str[ERR_MAX_LEN - 1] = '\0';
> +		p_err("can't mount BPF file system on given dir (%s): %s",
> +		      dir_name, err_str);
> +
> +		if (!dir_exists) {
> +			if (rmdir(dir_name) == -1)
> +				p_err("failed to remove newly created dir (%s): %s",
> +				      dir_name, strerror(errno));

We're already on an error path, I'd maybe drop the check on the return 
value from rmdir(). It doesn't matter much if it fails, I think.

> +		}
> +	}
> +
> +	return err;
> +}
> +
> +int mount_bpffs_given_file(const char *file_name)

This function must be renamed, as you did at the call sites.

> +{
> +	char err_str[ERR_MAX_LEN];
> +	char *temp_name;
> +	char *dir;
> +	int err = 0;
> +
> +	if (access(file_name, F_OK) != -1) {
> +		p_err("bpf object can't be pinned since file (%s) already exists", file_name);

Not sure why the parenthesis, let's use quotes? Can we also replace 
"since" with "because", or "given that", or simply a colon, please? And 
I'd drop the passive voice, here's what I would use:

     "can't pin BPF object: path '%s' already exists"

> +		return -1;
> +	}
> +
> +	temp_name = malloc(strlen(file_name) + 1);
> +	if (!temp_name) {
>   		p_err("mem alloc failed");
>   		return -1;
>   	}
>   
> -	strcpy(file, name);
> -	dir = dirname(file);
> +	strcpy(temp_name, file_name);
> +	dir = dirname(temp_name);
>   
>   	if (is_bpffs(dir))
>   		/* nothing to do if already mounted */
> @@ -277,11 +348,11 @@ int mount_bpffs_for_pin(const char *name, bool is_dir)
>   	if (err) {
>   		err_str[ERR_MAX_LEN - 1] = '\0';
>   		p_err("can't mount BPF file system to pin the object (%s): %s",

"object '%s'" instead of "the object (%s)" please.

> -		      name, err_str);
> +		      file_name, err_str);
>   	}
>   
>   out_free:
> -	free(file);
> +	free(temp_name);
>   	return err;
>   }
>   
> @@ -289,7 +360,7 @@ int do_pin_fd(int fd, const char *name)
>   {
>   	int err;
>   
> -	err = mount_bpffs_for_pin(name, false);
> +	err = mount_bpffs_for_file(name);

Compiler says "undefined reference to `mount_bpffs_for_file`", please 
build and test your patch. See also how most CI jobs fail:
https://github.com/kernel-patches/bpf/pull/6614

Quentin
