Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794329211;
	b=3Ea1tisFQ9DF2CMSryD4VeHmF93mz+aRhCIoXYnM4JjAP03ogJJsVgvJjH+4Sgik0em5
	 +auaAQ83FDNEfprGMgnIzreQst2xKjCA90i5NNwuduUDBIFI1kPSCp9gLj15xa2Adzaok
	 nJudmp3yuPI4B1tt3TIt1lEYXetQOGUeWus0Visyhw6ycQw9ncRcTgsvCCUI7Vw8Esk1D
	 gyx0l7xJ1mhFZiPRQruK4PspDrzwUvIGTl9b4cj9IExSq/w6hB1wGxBnuGo8iPE6fjtfw
	 PRKdY3kesLCSPIRZcRH8eBggKqfmVSCuMJj1S1cN3ks3XEFkVjG3iRMFJLyLfQKvu1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794329211;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=1Fk8B7TVD4J/uM5mrWeodLE6wQUClS3Amg/LXK/C8zM=;
	b=wIIuZJdx8QNbMGsUsiFTGclxqkvncmwweDh+L1mpPLvdjI2Pf9YHSP46CJlWt8KVSbE1
	 jvFFLfu1mGi37tDmafRKWNCmvufQ4artDzJ2VuFTZcpXc4BvGjndbN6/fXZ88OnSRy8Sz
	 3XZ3+7asW/x7ON+uqs8MoDbTWfGoxOAg4BIX01LUNj5njW5JDrbaND4pSiVJSpw35oCf9
	 3nbEMyBAOW9HRpbZYgR7ygzt5qI+C1nI+r85t91Lj1WLW+fvVtYSHv5pKbjbCWQ/4Pvob
	 iispFvW6C1/OYqPRU/2p2c+THSuYcyThrRL4Wa7Dlu/6PFI+3XTGXQvzAivsEfpEvgw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hU9143BB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B7B2606A31C;
	Tue, 10 Nov 2026 16:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hU9143BB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 676E31F0089F;
	Tue, 10 Nov 2026 16:46:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794329210;
	bh=1Fk8B7TVD4J/uM5mrWeodLE6wQUClS3Amg/LXK/C8zM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=hU9143BBn3QrjzdNQwJ+hwRgnBDB6UfnfFVAzcM0rFEUMRicpoy4D1JtLgLuVC835
	 3fi9LVSAaP/FOoZnQ/6Z64ZPfyN24YnSPgUPpYZ9eHI79t+ckZb+5RjU9AdhVZM8YM
	 68nkpptSx/km8GjZe+uqVU2W70K3jRNNsjK839SmNEu+wRd+2DZrVWVdqSmLirV/ya
	 Zk18DV1PvPANHedyf6mXpm3kDxO76yBRCG1yTuevkb2XOpy9U8TgPq2bEnnuQB3s2a
	 aBwSOzi0CriraeP4QQGgN4M7WrbTo6J6C3ix8iOy4RAjsp/N4SmempqXHrxhuBOfBw
	 xrKCUtU3bnrrg==
Message-ID: <3901a136-d2e1-43eb-8284-31dae956391e@kernel.org>
Date: Tue, 10 Nov 2026 16:46:48 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v9 1/2] bpftool: Use batch lookups for map dumps
To: Tianyi Chen <hi@tychen.cc>, bpf@vger.kernel.org
Cc: andrii@kernel.org, eddyz87@gmail.com, ihor.solodrai@linux.dev,
 linux-kselftest@vger.kernel.org, shuah@kernel.org, daniel@iogearbox.net,
 ast@kernel.org, alexei.starovoitov@gmail.com
References: <cover.1793821981.git.hi@tychen.cc>
 <7a728136ad18840c94836ec1ce988f8bc2fcfb35.1793821981.git.hi@tychen.cc>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <7a728136ad18840c94836ec1ce988f8bc2fcfb35.1793821981.git.hi@tychen.cc>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 04/11/2026 19:54, Tianyi Chen wrote:
> Dumping a map takes two BPF syscalls per element: one to get the next
> key and one to look it up. Use BPF_MAP_LOOKUP_BATCH instead, with keys
> and values bounded to 1 MiB and per-CPU value strides accounted for.
> The output is unchanged.
> 
> For a hash map with 100,000 4-byte keys and values, a plain dump takes 5
> BPF syscalls instead of 200,005. With output to /dev/null, the median of
> 15 runs in an x86-64 KVM guest on Linux 7.3 dropped from 86 ms to 52 ms
> (JSON: 78 ms to 42 ms). Printing to a terminal dominates either way.
> 
> If a batch lookup fails, discard its output and continue with individual
> lookups after the last printed key. bpf_map_get_next_key() walks the map
> in the same order. This covers maps without batch support, and hash
> maps whose bucket lock cannot be taken, which individual lookups do not
> need.
> 
> Link: https://github.com/libbpf/bpftool/issues/63
> Suggested-by: Alexei Starovoitov <ast@kernel.org>
> Assisted-by: LLM
> Signed-off-by: Tianyi Chen <hi@tychen.cc>


Looks good to me, thanks!

Acked-by: Quentin Monnet <qmo@kernel.org>


> ---
>  tools/bpf/bpftool/map.c | 97 ++++++++++++++++++++++++++++++++++-------
>  1 file changed, 82 insertions(+), 15 deletions(-)
> 
> diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
> index 4b65edf74859b..c0bd9bf846492 100644
> --- a/tools/bpf/bpftool/map.c
> +++ b/tools/bpf/bpftool/map.c
> @@ -59,13 +59,16 @@ static int map_type_from_str(const char *type)
>  	return -1;
>  }
>  
> -static void *alloc_value(struct bpf_map_info *info)
> +static size_t map_value_size(struct bpf_map_info *info)
>  {
>  	if (map_is_per_cpu(info->type))
> -		return malloc(round_up(info->value_size, 8) *
> -			      get_possible_cpus());
> -	else
> -		return malloc(info->value_size);
> +		return (size_t)round_up(info->value_size, 8) * get_possible_cpus();
> +	return info->value_size;
> +}
> +
> +static void *alloc_value(struct bpf_map_info *info)
> +{
> +	return malloc(map_value_size(info));
>  }
>  
>  static int do_dump_btf(const struct btf_dumper *d,
> @@ -741,15 +744,10 @@ static int do_show(int argc, char **argv)
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
> @@ -763,10 +761,74 @@ static int dump_map_elem(int fd, void *key, void *value,
>  	} else {
>  		print_entry_plain(map_info, key, value, cpu_ids, cpu_cnt);
>  	}
> +}
>  
> +static int dump_map_elem(int fd, void *key, void *value,
> +			 struct bpf_map_info *map_info, struct btf *btf,
> +			 json_writer_t *btf_wtr, const int *cpu_ids, int cpu_cnt)
> +{
> +	if (bpf_map_lookup_elem(fd, key, value)) {
> +		print_entry_error(map_info, key, errno);
> +		return -1;
> +	}
> +
> +	print_map_elem(key, value, map_info, btf, btf_wtr, cpu_ids, cpu_cnt);
>  	return 0;
>  }
>  
> +#define MAP_DUMP_BATCH_BYTES (1U << 20)
> +
> +/*
> + * Print the elements returned by batched lookups, leaving the last one in
> + * @key. Return true at the end of the map. After any error, the caller
> + * continues with bpf_map_get_next_key(), which walks the map in the same order.
> + */
> +static bool dump_map_batch(int fd, void *key, void *value,
> +			   struct bpf_map_info *info, struct btf *btf,
> +			   json_writer_t *wtr, const int *cpu_ids, int cpu_cnt,
> +			   unsigned int *num_elems)
> +{
> +	size_t value_size = map_value_size(info);
> +	void *keys, *values, *batch, *in_batch = NULL;
> +	__u32 capacity, count, i;
> +	bool done = false;
> +	int err;
> +
> +	capacity = min(MAP_DUMP_BATCH_BYTES / (info->key_size + value_size),
> +		       (size_t)info->max_entries);


Nit: If you respin, dump_map_batch() might be worth a comment to tell it
assumes key_size + value_size to be non-zero. Right now we're good, we
exit early from map_dump() (before calling dump_map_batch()) if we have
no key.
