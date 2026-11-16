Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.100
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794798273;
	b=hl8dCm3ltEeo3JICyvvaX4A0n3wFCIj+/Id4fxSoEjpR1u84R34jT0Xw9n+bzYKYZRac
	 J4wX4o3mgtoWE5BsGfrjTviW7mRtmghjJFu5wDh96rabzMmsaTDpKUns5jpwibiJ7oJxU
	 4oGULIdUkHc2VfB05tJlb5nLyL+PiMdUsgHyPMhHP1lHZlNfvCxQIitqp537kgUkyyXfP
	 FqwwOKDI9w8FVFVwjMsN6wiqOodQvfRpbrTtUTyVPyhBjYsi/nwrnUxMT9m7Z09jun2Ir
	 W9C+OMIWQUUiTNmCuDaBOzcngN1TbUV+fIB9Dh70b4AGCb2vEA1PEd0nCjT2W4XyHIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794798273;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=gjvOzc12J2sR02D1SD6105ACjek4G9ZZ21f6s6C+IuA=;
	b=IlgUU0BiI/ZjCuWV+KJ3QbRi9GKXLKRlTxfYXpx2ZW/lHz8X8tcfgLBPkk5/gB8qw39D
	 xEWEWtNpwED/fKvM56L49LatuKfu1TYcmbDBVe2Nhdp4Ihi/XoEvSLXvxJIPzx5EFAOiW
	 ov6iDkOYQFfhmCyhrchcZULkx/mIaUPu7ecEMCVWamqprOqz/RhR1QAm1xkdQ4+5RwZJz
	 dIcMf/3BifjM2KDBQidefVbJA+YaVgPArn07DvIblhepwwJozFsNYKa2/2SeGySzaAw+g
	 Nyjn6AiArGKkocnCBfhFZhlsiQvM3iWumELrDs8F/0pYy2m/uBfWoC6c0N8TL1F1F0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=fMfGxmrw;
	arc=none smtp.remote-ip=95.215.58.100
Received: from mta1.migadu.com (out-100.mta1.migadu.com [95.215.58.100])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA031606A895
	for <bpf@vger.kernel.org>; Mon, 16 Nov 2026 03:04:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EA031606A895
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=fMfGxmrw
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=2kSxzvz8rnLMULtMF34NYKP/UIdl2tqu/nArinaMAV8=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794798269; v=1; x=1795403069;
 b=fMfGxmrwMc0syW9EWBB+7sGPlvgA1yhdPr6jm0eFi5zBbAwZ134CN/GEkIMmjqg+42AIaMPP
 Nr6BmPPJQiqp9/D2ztbmaLt1AIdKoscDaI+naPqcgiO208yvNSHuhk+QoVJW3skzLVf1siUTBMK
 sspBV0cYnN2anJlgrNvMdhAs=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 80d53e618474a42b;
	Mon, 16 Nov 2026 03:04:29 +0000
X-Mizu-Trace-ID: 80d53e618474a42b
X-Migadu-Flow: FLOW_OUT
Message-ID: <bbb07259-a2e8-40b5-9933-eb3d5d7a4bba@linux.dev>
Date: Mon, 16 Nov 2026 11:04:19 +0800
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
Subject: Re: [PATCH bpf-next] selftests/bpf: Skip memcg_proactive_reclaim when
 data lands in shmem
To: Kurt Lin <lylin1023@gmail.com>, Hui Zhu <zhuhui@kylinos.cn>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Ihor Solodrai <ihor.solodrai@linux.dev>,
 Emil Tsalapatis <emil@etsalapatis.com>, Barry Song <baohua@kernel.org>,
 Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261113180159.602033-1-lylin1023@gmail.com>
Content-Language: en-US
From: Hui Zhu <hui.zhu@linux.dev>
In-Reply-To: <20261113180159.602033-1-lylin1023@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Kurt,

I have two suggestions below.

2026/11/14 02:01, Kurt Lin:

> workload_dir() keeps the data file off tmpfs because shmem cannot be
> reclaimed without swap. But statfs() only sees the top of a stacking
> filesystem: with /tmp on overlayfs over tmpfs, as in virtme-ng guests,
> the check passes and all 32 MiB are still charged as shmem. Whether the
> test then passes depends on unrelated page cache in the cgroup; in a
> full test_progs run it fails with:
>
>    test_memcg_proactive_reclaim:FAIL:reclaimed unexpected reclaimed: actual 0 <= expected 0
>
> Check memory.stat after writing the file and skip when most of the
> data was charged as shmem.
>
> An AI coding assistant (Claude) was used to find and analyze the
> failure and to draft the fix and this changelog.
>
> Fixes: 0f9b1e9ef584 ("selftests/bpf: Add bpf_proactive_reclaim test")
> Signed-off-by: Kurt Lin <lylin1023@gmail.com>
> ---
>
> Notes:
>      Tested in a virtme-ng guest without swap: with /tmp on overlayfs over
>      tmpfs the test now skips; on a disk-backed directory it passes.
>      
>      After writing 32 MiB, memory.stat shows shmem 32.0 MiB on overlayfs
>      /tmp and on tmpfs, and 0.0 MiB on a disk-backed filesystem.
>
>   .../bpf/prog_tests/memcg_proactive_reclaim.c  | 28 +++++++++++++++++++
>   1 file changed, 28 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/memcg_proactive_reclaim.c b/tools/testing/selftests/bpf/prog_tests/memcg_proactive_reclaim.c
> index c22dcfabe856..c03550676041 100644
> --- a/tools/testing/selftests/bpf/prog_tests/memcg_proactive_reclaim.c
> +++ b/tools/testing/selftests/bpf/prog_tests/memcg_proactive_reclaim.c
> @@ -46,6 +46,28 @@ static const char *workload_dir(void)
>   	return NULL;
>   }
>   
> +/*
> + * statfs() only sees the top of a stacking filesystem. When /tmp is an
> + * overlayfs whose upper layer lives on tmpfs, as in virtme-ng guests, the
> + * check above passes but the written data still ends up as shmem. Ask the
> + * cgroup how the pages were actually charged.
> + */
> +static bool charged_as_shmem(void)
> +{
> +	static char buf[8192];
> +	unsigned long long shmem;
> +	char *p;
> +
> +	if (read_cgroup_file(CG_PATH, "memory.stat", buf, sizeof(buf)))
> +		return false;
Would it make sense to turn the silent "return false" into an explicit
assertion, e.g.:

     if (!ASSERT_OK(read_cgroup_file(CG_PATH, "memory.stat", buf,
                     sizeof(buf)), "read memory.stat"))
         return false;

My reasoning: memory.stat exists on every cgroup v2 hierarchy and the
"shmem" key is emitted unconditionally (not behind any CONFIG), and
cgroup_setup_and_join() has already succeeded by the time this runs.
So a read/parse failure here likely means something is genuinely
broken, rather than an environment limitation. With the silent
fallback, a shmem-backed dir falls through to the old confusing
"reclaimed: actual 0 <= expected 0" failure and the real cause is
never reported. The ASSERT_* macros are statement expressions, so this
works inside the bool helper: the failure is recorded with a clear
message first, and any subsequent "reclaimed" failure becomes
obviously secondary. (Skipping on the error path would be worse still
-- a genuine breakage would be counted as a pass, so I'd keep it as a
failure either way.)
> +
> +	p = strstr(buf, "\nshmem ");
> +	if (!p || sscanf(p, "\nshmem %llu", &shmem) != 1)
> +		return false;
> +
> +	return shmem >= FILE_SIZE / 2;


Small nit: a one-line comment on the threshold might help future
readers, something like "all-or-nothing: the data file is either fully
shmem (stacked tmpfs) or not shmem at all (disk-backed), so half of
FILE_SIZE is a safe midpoint". Also, printing the measured shmem value
in the SKIP message could be handy when debugging odd environments.

Best,
Hui


> +}
> +
>   void test_memcg_proactive_reclaim(void)
>   {
>   	struct memcg_proactive_reclaim *skel = NULL;
> @@ -99,6 +121,12 @@ void test_memcg_proactive_reclaim(void)
>   	if (!ASSERT_OK(fsync(data_fd), "fsync"))
>   		goto out;
>   
> +	if (charged_as_shmem()) {
> +		printf("%s:SKIP: %s is backed by shmem\n", __func__, dir);
> +		test__skip();
> +		goto out;
> +	}
> +
>   	args.cgroup_id = cgroup_id;
>   	args.size = FILE_SIZE;
>   	skel->bss->reclaimed = 0;
>
> base-commit: 0021f17128de5dc0b19f1a523f448df2440d8088
