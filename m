Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795057455;
	b=aX6RXZ1dr1PpZwBlt8p1wC5sbCWFcu2c223Pv1UuoL/6SUod97iGkQKUHBkTLnYL1/GB
	 XQgkzjMSZhXIfCjokHBhvATixNPM7vgi2lhkSGrnpjbKKyOOztxSQMXY95xUMWnS5DE4b
	 pdHy84sFrx+2yhRiVODSzEZpFytag9qE99mdw+Aw7Jl/8LYLrZM+6NfHpiZLe3jPva0Oc
	 GquDomhlS5+q8XfMGLqpKa4wkF8DP4mVYEwQRdJjQ9CeXL6/BXp9Z8UgrlA+QXry4H0Ce
	 Ljj0BbHbKpgS5vx6/NWv78lYjkBkSOGQfNBwne4tv8v/HLbdpQpshnsqqLM5K4YZ44w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795057455;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=0SbJDsJK4PSjk5SKz/IpSKiXp0UG0peF0ib+V6K/eBE=;
	b=fjgBj7lF/oY/mOaEN/u4VGtlCZpVhfIX9AjCJt4uPvKVHwWv3ODwKEmGBYoJdrkuLuGq
	 44O1AUfot+PHqqzjjskmBcnR+BZhFN8jaqJrEJjTSUi0R6AhBkWjDRB3H1UsYfK0UVivF
	 ZHiFeBgYh1ATJnKsu0+7prbk+G10SoEJiSDNJt+agDdohti/9HZ1h5lVP9V4MWAqA+A2g
	 aEyZ3TSN55SmnhnwhVyFbIF6SaJ7KjcYq3hd0b3XuAmw3QsGpRuvRgBZqnBQqXnOeF/xk
	 3/yxMbaKpZE2VJWyGHJNZShHmmn50MBsAC9bMiGqkmx8T4cfBZhxbVyumJXpf+F98nA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=DWK3GpEt;
	arc=none smtp.remote-ip=95.215.58.53
Received: from mta1.migadu.com (out-53.mta1.migadu.com [95.215.58.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E067460A260E
	for <bpf@vger.kernel.org>; Thu, 19 Nov 2026 03:04:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E067460A260E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=DWK3GpEt
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=KazbasjxrRYbBydSTs2O2Ixd8P66DwsGYWpJXQkSjv4=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795057450; v=1; x=1795662250;
 b=DWK3GpEtx6OslLzkWCdUk612hJfK1YdzajCAowfM8hDrqAFe2bKFYuds5eoDrvpUlrsaZ2N+
 oHrUc2j0j2jxSiTk8FBWrOM3BjM3laE7T2Ge+x1PKYn+99dnkBn/K9WzoI+X70uVs8pvPT+b1h3
 cfV/KvH/aizE0w6QBEPiN/4Q=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 57bbc1b48389dcb3;
	Thu, 19 Nov 2026 03:04:10 +0000
X-Mizu-Trace-ID: 57bbc1b48389dcb3
X-Migadu-Flow: FLOW_OUT
Message-ID: <79797479-029f-4e9b-8076-6a92a2a70cdd@linux.dev>
Date: Thu, 19 Nov 2026 11:04:02 +0800
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Betterbird (macOS/Intel)
Subject: Re: [PATCH bpf-next v2] selftests/bpf: Fall back when
 memcg_proactive_reclaim data lands in shmem
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Kurt Lin <lylin1023@gmail.com>, Hui Zhu <zhuhui@kylinos.cn>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 Jiri Olsa <jolsa@kernel.org>, Ihor Solodrai <ihor.solodrai@linux.dev>,
 Emil Tsalapatis <emil@etsalapatis.com>, Barry Song <baohua@kernel.org>,
 Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261117170704.1146730-1-lylin1023@gmail.com>
 <DMY136RTAL9Q.2WQSZ57W1YLV2@gmail.com>
Content-Language: en-US
From: Hui Zhu <hui.zhu@linux.dev>
In-Reply-To: <DMY136RTAL9Q.2WQSZ57W1YLV2@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


2026/11/18 11:49, Alexei Starovoitov:
> On Tue, Nov 17, 2026 at 09:07 AM Kurt Lin <lylin1023@gmail.com> wrote:
>> After writing the file, check memory.stat and move on to the next
>> candidate directory if most of the data was charged as shmem; skip only
>> when none is left. Give each candidate its own cgroup so that stale
>> stats from a previous attempt cannot interfere, and poll memory.stat
>> until the write shows up, as reading it does not force a stats flush.
>> Fail the test if memory.stat cannot be read or never shows the write.
> This is overkill.
>
>>      To exercise the polling, FILE_SIZE was temporarily cut to 2 MiB in a
>>      128-vCPU guest, which keeps the write below the flush threshold.
> So the test with 32 MiB didn't hit it.
> Pls don't add code just because a bot said so.
>
> Here is what I mean. I didn't compile it:
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/arena_memcg.c b/tools/testing/selftests/bpf/prog_tests/arena_memcg.c
> index c76a7eb..334bfa6 100644
> --- a/tools/testing/selftests/bpf/prog_tests/arena_memcg.c
> +++ b/tools/testing/selftests/bpf/prog_tests/arena_memcg.c
> @@ -53,8 +53,12 @@ static int alloc_pagecache(size_t size)
>   	fd = open(".", O_TMPFILE | O_RDWR | O_EXCL, 0600);
>   	if (fd < 0)
>   		return errno == EOPNOTSUPP ? -EOPNOTSUPP : -1;
> -	/* tmpfs hands out shmem pages, which are not reclaimable without swap */
> -	if (fstatfs(fd, &stfs) || stfs.f_type == TMPFS_MAGIC) {
> +	/*
> +	 * tmpfs hands out shmem pages, which are not reclaimable without swap.
> +	 * overlayfs hides the type of its upper layer, which can be tmpfs.
> +	 */
> +	if (fstatfs(fd, &stfs) || stfs.f_type == TMPFS_MAGIC ||
> +	    stfs.f_type == OVERLAYFS_SUPER_MAGIC) {
>   		close(fd);
>   		return -EOPNOTSUPP;
>   	}
> diff --git a/tools/testing/selftests/bpf/prog_tests/memcg_proactive_reclaim.c b/tools/testing/selftests/bpf/prog_tests/memcg_proactive_reclaim.c
> index c22dcfa..2ba0791 100644
> --- a/tools/testing/selftests/bpf/prog_tests/memcg_proactive_reclaim.c
> +++ b/tools/testing/selftests/bpf/prog_tests/memcg_proactive_reclaim.c
> @@ -30,7 +30,8 @@ struct reclaim_args {
>    * being available, and a read-only mount cannot host the file at all (EROFS
>    * applies to root too). /tmp is tmpfs on many systems, and test_progs is
>    * routinely run from a tmpfs working directory, so both candidates need the
> - * check.
> + * check. overlayfs hides the type of its upper layer, which is tmpfs for /tmp
> + * in virtme-ng guests.
>    */
>   static const char *workload_dir(void)
>   {
> @@ -40,7 +41,8 @@ static const char *workload_dir(void)
>
>   	for (i = 0; i < ARRAY_SIZE(dirs); i++)
>   		if (!statfs(dirs[i], &st) && st.f_type != TMPFS_MAGIC &&
> -		    st.f_type != RAMFS_MAGIC && !access(dirs[i], W_OK))
> +		    st.f_type != RAMFS_MAGIC &&
> +		    st.f_type != OVERLAYFS_SUPER_MAGIC && !access(dirs[i], W_OK))
>   			return dirs[i];
>
>   	return NULL;
>
> pw-bot: cr

Hi Alexei,

What about two things: only check when the test fails, and check
KPF_SWAPBACKED instead of f_type?

1. Check only when the test fails.
What the test needs is "these pages are reclaimable", not "these pages
are not shmem": with swap available shmem reclaims fine, and then
reclaimed == 0 is a real regression that must not be skipped. So probe on
the failure path only -- nothing is paid when the test passes, there is
no polling, and a regression cannot be masked.

2. Probe with KPF_SWAPBACKED.
f_type is a blacklist, so the next stacking filesystem repeats this.
shmem-ness is a property of the pages rather than of the mount, so ask
the pages: /proc/self/pagemap for VA -> PFN, /proc/kpageflags for
PFN -> flags, then test bit 14.

     #define PAGEMAP_PRESENT(e)  (((e) & (1ull << 63)) != 0)
     #define PAGEMAP_PFN(e)      ((e) & ((1ull << 55) - 1))
     #define KPF_SWAPBACKED      (1ull << 14)

     /* 1 if fd is backed by shmem, 0 if not, -1 if it could not tell */
     static int file_is_shmem(int fd)
     {
             unsigned long ps = getpagesize();
             uint64_t ent = 0, flags = 0;
             int pfd = -1, kfd = -1, ret = -1;
             char *addr;

             addr = mmap(NULL, ps, PROT_READ, MAP_SHARED, fd, 0);
             if (addr == MAP_FAILED)
                     return -1;
             *(volatile char *)addr;

             pfd = open("/proc/self/pagemap", O_RDONLY);
             kfd = open("/proc/kpageflags", O_RDONLY);
             if (pfd < 0 || kfd < 0)
                     goto out;
             if (pread(pfd, &ent, sizeof(ent),
                       ((uintptr_t)addr / ps) * sizeof(ent)) != sizeof(ent))
                     goto out;
             /* unprivileged readers see PM_PRESENT with the PFN zeroed */
             if (!PAGEMAP_PRESENT(ent) || !PAGEMAP_PFN(ent))
                     goto out;
             if (pread(kfd, &flags, sizeof(flags),
                       PAGEMAP_PFN(ent) * sizeof(flags)) != sizeof(flags))
                     goto out;

             ret = !!(flags & KPF_SWAPBACKED);
     out:
             if (pfd >= 0)
                     close(pfd);
             if (kfd >= 0)
                     close(kfd);
             munmap(addr, ps);
             return ret;
     }

     if (!skel->bss->reclaimed) {
             struct sysinfo si;

             sysinfo(&si);
             if (!si.totalswap && file_is_shmem(data_fd) == 1) {
                     test__skip();
                     goto out;
             }
     }
     ASSERT_GT(skel->bss->reclaimed, 0, "reclaimed");

What it buys: it sees through any stacking filesystem instead of only the
listed ones, it is per-page rather than inferred from a magic number, it
needs no polling and no extra cgroup, and it costs nothing on the success
path. Returning -1 when it cannot tell keeps the caller conservative --
a failure beats a silent pass. Both files are root-only, which these tests
already are, and selftests/mm/vm_util.c already pairs pagemap with
kpageflags.

Best,
Hui


