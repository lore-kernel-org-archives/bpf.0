Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 309CE3C0A04
	for <bpf@vger.kernel.org>; Thu, 16 Jul 2026 21:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784236322; cv=none; b=eN596jRnFhVT+yqoQU9CePImmNacjQYYdRnNMYv3Y23HmF9IfglYbh3uVzogZFzoXnadvXKnIXC6SZ4aPzK9s2N7YVLy+jvn56ka2V6RgXbtl+AoK+2luHRRvoJEqfvmS/Cbe7m0TgkyVqrALyUaY3SFten8y8HRIRKGkCMv7Cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784236322; c=relaxed/simple;
	bh=nCdlB/eVVRL6A0PB3beHYoCfynsp3ENW/4elEUSOz8U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Pdmdjf2ggVc38zmYwTUeX9GcnTLBRyI5cF4dJMpxSeiQyBtiBFwaqP0+TEfr+wwL5O7lgaIYakgvh/zzySXoS4ZnhVnO1djFZFYkJ6PxtssOHy5/esN/hgetSk9LXiY/17JeZtM6ddGRWqlkRRaV9S4XWjD2l0fscHSHEZWTakE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=m+LiJmlA; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="m+LiJmlA"
Message-ID: <2088b8ed-c26c-4120-a3d6-8e6dfbf89f58@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1784236317;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=trws+fg1iLjXQ6hRYgo7PQNpwTAMKP6KkF9pJjvNvM8=;
	b=m+LiJmlAIkOksJZ7fPAAHvUvCZwIo7x2nq8QguHO3rfiAmul8BdBdNo/eAkYXuDkkiJqGM
	ADhO63tyEwMthfMTbev1M3sRXSgpaTRSIZHCEr/c4YRnH3Q+C33XeudGja+1Gs/fUM1kaS
	OotbYZHGWqOrpoX5M0weB/1qS/U4MiM=
Date: Thu, 16 Jul 2026 14:11:44 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 3/4] selftests/bpf: Fix lsm_bdev dev_t encoding mismatch
To: =?UTF-8?Q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Emil Tsalapatis <emil@etsalapatis.com>, Shuah Khan <shuah@kernel.org>,
 =?UTF-8?Q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?=
 <alexis.lothore@bootlin.com>, Christian Brauner <brauner@kernel.org>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260710-selftests-bpf_fixes-v1-0-aa24dfd6f4f9@suse.com>
 <20260710-selftests-bpf_fixes-v1-3-aa24dfd6f4f9@suse.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <20260710-selftests-bpf_fixes-v1-3-aa24dfd6f4f9@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 7/10/26 3:09 PM, Ricardo B. Marlière wrote:
> progs/lsm_bdev.c keys its verity_devices hashmap with the raw kernel dev_t
> read straight off bdev->bd_dev, i.e. MKDEV(major, minor) = (major << 20) |
> minor. prog_tests/lsm_bdev.c instead builds its lookup key with dev_key =
> (__u32)st.st_rdev from stat(2), but the stat(2) syscall fills st_rdev via
> the kernel's new_encode_dev(), a different bit layout: (minor & 0xff) |
> (major << 8) | ((minor & ~0xff) << 12).
> 
> For any device with a non-trivial major these two values differ, so the
> lookup can never find what the BPF program stored, and test_lsm_bdev()
> always fails with:
> 
>   test_lsm_bdev:FAIL:map lookup unexpected error: -2 (errno 2)
> 
> Reconstruct the raw kernel dev_t from the decoded major/minor instead of
> casting st_rdev directly, restoring the layout the BPF program actually
> reads.
> 
> Fixes: 96f4c251a087 ("selftests/bpf: add block device management selftests")
> Signed-off-by: Ricardo B. Marlière <rbm@suse.com>
> ---
>  tools/testing/selftests/bpf/prog_tests/lsm_bdev.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/lsm_bdev.c b/tools/testing/selftests/bpf/prog_tests/lsm_bdev.c
> index a970798e1173..28bc4b117f41 100644
> --- a/tools/testing/selftests/bpf/prog_tests/lsm_bdev.c
> +++ b/tools/testing/selftests/bpf/prog_tests/lsm_bdev.c
> @@ -17,6 +17,7 @@
>  #include <stdlib.h>
>  #include <string.h>
>  #include <sys/stat.h>
> +#include <sys/sysmacros.h>
>  #include <sys/types.h>
>  #include <unistd.h>
>  #include "lsm_bdev.skel.h"
> @@ -172,7 +173,7 @@ void test_lsm_bdev(void)
>  	if (!ASSERT_OK(stat(DM_DEV_PATH, &st), "stat dm dev"))
>  		goto remove_dm;
>  
> -	dev_key = (__u32)st.st_rdev;
> +	dev_key = (major(st.st_rdev) << 20) | minor(st.st_rdev);

Acked-by: Ihor Solodrai <ihor.solodrai@linux.dev>

nit: I wonder if there are other tests with this bug. Have you checked?

>  
>  	/* Look up the device in the BPF map and verify. */
>  	err = bpf_map__lookup_elem(skel->maps.verity_devices,
> 

