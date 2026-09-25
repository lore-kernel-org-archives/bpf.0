Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDCF83C3792;
	Fri, 25 Sep 2026 17:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790355952; cv=none; b=thSaIJEEjdMpfH2P5Fr/+JgAYJVO1A5wPUMH858b12YIwdjMjQXA5Nju+QN2FxMToJ9nzlAyoMJgq67xQk0/iWjAdZSGymTPPRJG6SNaL8Ri98KWOJ6UCbp/Qf743C6ZSmO+7mE9G5/8VgaSda0HvyZTJTCdpLOq61dzpYR6zvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790355952; c=relaxed/simple;
	bh=pItW0QjKazlH125MEspmJv84EQmK5tGIGB73KMGPaGc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oVwsL9oUmIakvSOCwioslYXvgx11VWSIgGVOA+uDBsHTqZV/TmgOE8EclfFsUMjOYTZ9ykHb8kxiBcicXhf4ndFgo5wgvJO2AC31r99lqspY28LHUQ48gzxdwVjdgtyOedN3DzYWoHeMZKjBxKJsqC+sYQ8cnjNkn9YHrexM29k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KkQG3Syo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KkQG3Syo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 323991F000FF;
	Fri, 25 Sep 2026 17:05:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790355945;
	bh=kyuD9zdgNA7m75jirj+BDhZ0XZ3VoYRe+a/F5wKlrhk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=KkQG3SyogbmhSw/Hmn79pfm0hB5tVJ2cSuhwk+vY8AGGD8JoYHdS8K44cMflRRUK4
	 Wsdel+UNYyuwj62Di/qewbSSDcqOV9IzCndo51n20pJHCR5fKD9MtscuPDRel68IZu
	 GiC3p2GoHW2t31bdYL50dFEIkXPWgTuJySLD4+YBn2yE25y9unsM4VcvDXeQ941Jwx
	 HTDHFRXAzIqLRbh3qjyhHDahUTGffzn2G+SnQVCvfRKyp6B7qNq+EGkGUGqPBwaVTD
	 n/eGXroQUp/JoKW3lJbXbF/IeKhTK4OF+B3mjQFCr9DN0Q+nr0D0mqSV/DV+rKddBX
	 LgWd8md956eyg==
Message-ID: <d5a5b5e7-4063-4511-acdc-46b2407565a7@kernel.org>
Date: Fri, 25 Sep 2026 18:05:42 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v5 1/2] bpftool: Use batch lookups for bounded
 hash map dumps
To: Tianyi Chen <hi@tychen.cc>, bpf@vger.kernel.org
Cc: andrii@kernel.org, eddyz87@gmail.com, ihor.solodrai@linux.dev,
 linux-kselftest@vger.kernel.org
References: <20260924163403.203491-1-hi@tychen.cc>
 <20260924163403.203491-2-hi@tychen.cc>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <20260924163403.203491-2-hi@tychen.cc>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

2026-09-25 01:34 UTC+0900 ~ Tianyi Chen <hi@tychen.cc>
> Use BPF_MAP_LOOKUP_BATCH when dumping hash maps to reduce the number


Thanks for this!

Why hash maps only? I think there are some other types of map that could
do this too, no? LRU_HASH has a good chance to be highly populated and
sounds like a good candidate. (It's OK to start just with hash maps, I'm
only asking to understand if I missed a particular reason to not include
other types).


> of BPF syscalls while preserving plain, JSON and BTF formatting.
> 
> Compare against the unpatched base using a populated 100,000-entry hash
> map with 4-byte keys and values, with stdout redirected to /dev/null.
> In an x86-64 KVM guest running Linux 7.2.5, both builds use GCC 16.2.1
> and run on one vCPU. After two warm-ups per binary and output mode,
> alternate baseline and patched runs for 15 untraced samples each:
> 
>                  baseline       batch       elapsed-time reduction
>   plain          88.165 ms      54.951 ms    37.7%
>   JSON           81.973 ms      48.216 ms    41.2%


That's nicer than the initial numbers, thanks for re-running your tests.


> 
> These are median wall times, including process startup and formatting.
> Separately, strace counts 200,004 versus 395 BPF syscalls for the plain
> dump. Complete JSON output is identical for this map. These results are
> specific to this fixture and guest, not a general speedup guarantee.
> 
> Hash batch lookup must fit an entire bucket. Restrict eligibility to
> maps whose maximum key/value storage fits in 4 MiB, so even a worst-case
> bucket can fit without restarting a partially printed dump. Start with
> up to 256 entries and grow on ENOSPC using the same input cursor.
> 
> Fall back to individual lookups only when the initial batch operation
> is unsupported. Restarting after output has begun would duplicate
> entries. Process the final partial batch on ENOENT, but do not trust
> count or output buffers after other errors. Keep fatal diagnostics on
> stderr so JSON element arrays contain only map entries.
> 
> Link: https://github.com/libbpf/bpftool/issues/63
> 
> Assisted-by: LLM
> Signed-off-by: Tianyi Chen <hi@tychen.cc>
> ---
>  tools/bpf/bpftool/map.c | 117 +++++++++++++++++++++++++++++++++++++---
>  1 file changed, 109 insertions(+), 8 deletions(-)
> 
> diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
> index 20d59eab09a1..b12c06a6f755 100644
> --- a/tools/bpf/bpftool/map.c
> +++ b/tools/bpf/bpftool/map.c
> @@ -741,15 +741,10 @@ static int do_show(int argc, char **argv)
>  	return errno == ENOENT ? 0 : -1;
>  }
>  
> -static int dump_map_elem(int fd, void *key, void *value,
> -			 struct bpf_map_info *map_info, struct btf *btf,
> -			 json_writer_t *btf_wtr, const int *cpu_ids, int cpu_cnt)
> +static void print_map_elem(void *key, void *value,
> +			   struct bpf_map_info *map_info, struct btf *btf,
> +			   json_writer_t *btf_wtr, const int *cpu_ids, int cpu_cnt)
>  {
> -	if (bpf_map_lookup_elem(fd, key, value)) {
> -		print_entry_error(map_info, key, errno);
> -		return -1;
> -	}
> -
>  	if (json_output) {
>  		print_entry_json(map_info, key, value, btf, cpu_ids, cpu_cnt);
>  	} else if (btf) {
> @@ -763,10 +758,112 @@ static int dump_map_elem(int fd, void *key, void *value,
>  	} else {
>  		print_entry_plain(map_info, key, value, cpu_ids, cpu_cnt);
>  	}
> +}
> +
> +static int dump_map_elem(int fd, void *key, void *value,
> +			 struct bpf_map_info *map_info, struct btf *btf,
> +			 json_writer_t *btf_wtr, const int *cpu_ids, int cpu_cnt)
> +{
> +	if (bpf_map_lookup_elem(fd, key, value)) {
> +		print_entry_error(map_info, key, errno);
> +		return -1;
> +	}
>  
> +	print_map_elem(key, value, map_info, btf, btf_wtr, cpu_ids, cpu_cnt);
>  	return 0;
>  }
>  
> +#define MAP_DUMP_BATCH_FALLBACK 1
> +#define MAP_DUMP_BATCH_SIZE 256U
> +#define MAP_DUMP_BATCH_MAX_BYTES (4 * 1024 * 1024)
> +
> +/* Return MAP_DUMP_BATCH_FALLBACK only before batch traversal starts. */
> +static int dump_map_batch(int fd, void *key, void *value,
> +			  struct bpf_map_info *info, struct btf *btf,
> +			  json_writer_t *wtr, unsigned int *num_elems)
> +{
> +	__u32 capacity, count, batch = 0, next_batch = 0, i;


__u32 batch: That's the correct size for hash maps, but some other map
types have different key size so we may have to allocate something of
size map->key_size instead in the future. Can you add a comment about
the size being tied to supported map types, please?


> +	void *keys = NULL, *values = NULL, *buf;
> +	bool first = true, can_fallback = true;
> +	int err;
> +
> +	/*
> +	 * Hash lookup batches must accommodate a whole bucket. Restrict the
> +	 * optimization to maps whose worst-case bucket fits the memory budget,
> +	 * so a later ENOSPC never forces a restart after printing some entries.
> +	 * Division also bounds the allocation multiplications on 32-bit hosts.
> +	 */
> +	if (info->type != BPF_MAP_TYPE_HASH || !info->max_entries ||
> +	    (__u64)info->key_size + info->value_size >
> +	    MAP_DUMP_BATCH_MAX_BYTES / info->max_entries)
> +		return MAP_DUMP_BATCH_FALLBACK;


(I think eligibility would be worth its own function, don't step into
dump_map_batch() if we're not eligible. It would also make it clearer
what are the conditions to be eligible, rather that conditions to _not_
be eligible in the current form.)

So looking at this, this means we must have:

    info->key_size + info->value_size
        <= MAP_DUMP_BATCH_MAX_BYTES / info->max_entries

... in order to make the map eligible to batch dump, in other words: the
bigger the map, the less likely it is to go through batch dump (although
batch dump precisely becomes interesting for larger maps).

I understand that MAP_DUMP_BATCH_MAX_BYTES mostly bounds the allocation
we are ready to do; could we make it a limit for the "buffer" resizing,
rather than eligibility? Or am I missing something?

Quentin
