Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A766D286A6
	for <bpf@vger.kernel.org>; Thu,  4 Apr 2024 22:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712269939; cv=none; b=AnwWab7i1cS5WMHb5+QcMB80gF2C8Ol7ycLTp51OIjVTfq+wQa17h2CUHL2FDPWnDRETs9Hcghbl8qJfu/1yeORxfu2772U5Pzs/rEw96NeYp8R0OLIlmT9gpHiHEvPif06clS8w6VCoZsWHJV8YbPJiakm1BZbcQ8uxGOLpIXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712269939; c=relaxed/simple;
	bh=ibl465D/PMeJpb5Kyew2Z+ikA2cB192NomKfeWDEmwo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ye/QWYNlVH76jsBv09bfSRs+U2CTnR2HWwAEiq3Bb7s2rjRrW+ug4I+J/rHHfUPhk8ugRdGmUOtbieQCFkas7i40mL702tyCarTMRrnHgQVBxdEsczBFMjYu4rFl6ZmSbdd/4Vm06vI2Ob++05qJ33iF3xSCRLa493dvARBo/CY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RUocg1I8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RUocg1I8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5068C433F1;
	Thu,  4 Apr 2024 22:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712269939;
	bh=ibl465D/PMeJpb5Kyew2Z+ikA2cB192NomKfeWDEmwo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=RUocg1I8SloRDeob59nuZOXjOFqONEj1OVpbmS9AS+MjwqFcN4orjOeWR4KV5+USY
	 hEsrfMgHug7zpltzDDK336v64Zp5ugLX+ljjeqXzF4jS07GeJOyc7FK5+QvEsAftI9
	 RUsIBoXi6O5CeySmg7jhFZFr9tQo4uUKds+emduVSDNoiLpeqlhci2nZr0+NLtkZCj
	 vQ/DgrN4v7Rv69o4IlkfmOsiOsaXcySzw1bI68w7C/o3nb8qmh/pFcHvgHlMKmxDN2
	 3bC7h6jV5APNt0Su5wxfADlrRysm6Vbj5cqYXBknS/Nsf8kSPCfXvQsrTLyBQX/pHl
	 IgBaSwXQWyJNg==
Message-ID: <7de85056-b15e-4c4a-a2f5-a450eaadfab1@kernel.org>
Date: Thu, 4 Apr 2024 23:32:14 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH bpf-next v5] bpftool: Mount bpffs on provided dir instead
 of parent dir
To: Sahil Siddiq <icegambit91@gmail.com>, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org
Cc: martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@google.com, haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org
References: <20240404192219.52373-1-icegambit91@gmail.com>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <20240404192219.52373-1-icegambit91@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 04/04/2024 20:22, Sahil Siddiq wrote:
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
> Changes since v4:
> - Use strdup instead of strcpy.
> - create_and_mount_bpffs_dir:
>   - Use S_IRWXU instead of 0700.
> - Improve error handling and formatting.
> 
> Signed-off-by: Sahil Siddiq <icegambit91@gmail.com>

Tested-by: Quentin Monnet <qmo@kernel.org>
Reviewed-by: Quentin Monnet <qmo@kernel.org>

Thank you!
