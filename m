Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB58262FD0;
	Wed,  1 Jul 2026 16:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782924565; cv=none; b=JJcWI5uloHmdBku6oNUUi5x2KxRlBpiTChqwM/lxakbFcCsZbmd845mpl6/AQTSfpJciUw8Hb+RtXG13ch6IClrKfhK5nDKQY4iOjcjqCf1vN6yHi2pQ2ASR9HTYaQsobG4WuT+GGYGE0HdPcuZ3NdCaYNggIcdPY890/riGIlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782924565; c=relaxed/simple;
	bh=USEPYHB8LwBiHckQmNbw5YP32KSNTBalZeLwPbG4KWM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V4YsRCtTKjY4fCkWRSPWSEHoSwmLak1BUZmInC9cP2H8epv3CRS+YmMmJCKxrGnS0xEp7LaFkzJDVGdKlKqDJzbhwfLEdsmdUuQQVau96k1amlikFzMktTD9VMVaItUhhoTb40lfGPiSrtYDyrWSecJ/IHOiGI5uxzOhRu3qxJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eSW3YN2P; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eSW3YN2P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B88C51F000E9;
	Wed,  1 Jul 2026 16:49:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782924564;
	bh=LeUbiEYr/eWPX+TzArV2IAHL5tIiQ6N/e8d/0mq4lT0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=eSW3YN2P8PoI0Ft+AQ9aDBwt3pFpXhVKLJ7cDB6tvjV4Ral6qUfMSpTmFV0LDoHy4
	 ZWyp4dOTKROQl96Sc43XI3+DDFaOBmyZH3KSxqTxuU94C/SeboE92nu8VBUnAo+LjP
	 2dTAWKvJ1SSsy+0dPOhQZcTY//R5FVOCS5J8hr0or5HmQD65sfIsJHpG6/eqVm6v+I
	 uXT5b1r6CuiLn2A7zaRZABUyiRHmPeEyRls4MZXn2OD+h+ccJ9Yqr36gNzbPOhJhqM
	 v7BPKKqMHQ+n5PwXBxntWSRVtC6HHH+2wmM4K/veEIhLuAVwyXxoQNF7k1ysEoKlJv
	 V7jW0I6eLtS6Q==
Message-ID: <a4e4adfe-4b2e-49c4-a708-89276514f930@kernel.org>
Date: Wed, 1 Jul 2026 17:49:20 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v8 5/9] bpftool: Generate skeleton for global
 percpu data
To: Leon Hwang <leon.hwang@linux.dev>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 Jiri Olsa <jolsa@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, kernel-patches-bot@fb.com
References: <20260629152406.52582-1-leon.hwang@linux.dev>
 <20260629152406.52582-6-leon.hwang@linux.dev>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <20260629152406.52582-6-leon.hwang@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

2026-06-29 23:24 UTC+0800 ~ Leon Hwang <leon.hwang@linux.dev>
> Enhance bpftool to generate skeletons that properly handle global percpu
> variables. The generated skeleton now includes a dedicated structure for
> percpu data, allowing users to initialize and access percpu variables more
> efficiently.
> 
> For global percpu variables, the skeleton now includes a nested
> structure, e.g.:
> 
> struct test_global_percpu_data {
> 	struct bpf_object_skeleton *skeleton;
> 	struct bpf_object *obj;
> 	struct {
> 		struct bpf_map *percpu;
> 	} maps;
> 	// ...
> 	struct test_global_percpu_data__percpu {
> 		int data;
> 		char run;
> 		struct {
> 			char set;
> 			int i;
> 			int nums[7];
> 		} struct_data;
> 		int nums[7];
> 	} *percpu;
> 
> 	// ...
> };
> 
>   * The "struct test_global_percpu_data__percpu *percpu" points to
>     initialized data, which is actually "maps.percpu->mmaped".
>   * Before loading the skeleton, updating the
>     "struct test_global_percpu_data__percpu *percpu" modifies the initial
>     value of the corresponding global percpu variables.
>   * After loading the skeleton, "maps.percpu->mmaped" has been marked as
>     read-only in libbpf. If users want to update the global percpu
>     variables, they have to update the "maps.percpu" map instead.
>   * For lightweight skeleton, "lskel->percpu" will be protected by
>     "mprotect(p, sz, PROT_READ)".
>   * For subskeleton, those variables of global percpu data will be
>     skipped.
> 
> Assisted-by: Codex:gpt-5.5-xhigh
> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> ---
>  tools/bpf/bpftool/gen.c       | 49 +++++++++++++++++++++++++++++++----
>  tools/lib/bpf/skel_internal.h | 24 +++++++++++++++--
>  2 files changed, 66 insertions(+), 7 deletions(-)
> 
> diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
> index 6ae7262ebe0c..2e60296358db 100644
> --- a/tools/bpf/bpftool/gen.c
> +++ b/tools/bpf/bpftool/gen.c
> @@ -92,7 +92,7 @@ static void get_header_guard(char *guard, const char *obj_name, const char *suff
>  
>  static bool get_map_ident(const struct bpf_map *map, char *buf, size_t buf_sz)
>  {
> -	static const char *sfxs[] = { ".data", ".rodata", ".bss", ".kconfig" };
> +	static const char *sfxs[] = { ".data", ".rodata", ".bss", ".percpu", ".kconfig" };
>  	const char *name = bpf_map__name(map);
>  	int i, n;
>  
> @@ -117,7 +117,7 @@ static bool get_map_ident(const struct bpf_map *map, char *buf, size_t buf_sz)
>  
>  static bool get_datasec_ident(const char *sec_name, char *buf, size_t buf_sz)
>  {
> -	static const char *pfxs[] = { ".data", ".rodata", ".bss", ".kconfig" };
> +	static const char *pfxs[] = { ".data", ".rodata", ".bss", ".percpu", ".kconfig" };
>  	int i, n;
>  
>  	/* recognize hard coded LLVM section name */
> @@ -254,6 +254,20 @@ static const struct btf_type *find_type_for_map(struct btf *btf, const char *map
>  	return NULL;
>  }
>  
> +static bool bpf_map_is_skel_data(const struct bpf_map *map)
> +{
> +	if (!bpf_map__is_internal(map))
> +		return false;
> +
> +	if (bpf_map__map_flags(map) & BPF_F_MMAPABLE)
> +		return true;
> +
> +	if (bpf_map__type(map) == BPF_MAP_TYPE_PERCPU_ARRAY)
> +		return true;
> +
> +	return false;
> +}
> +
>  static bool is_mmapable_map(const struct bpf_map *map, char *buf, size_t sz)
>  {
>  	size_t tmp_sz;
> @@ -263,7 +277,7 @@ static bool is_mmapable_map(const struct bpf_map *map, char *buf, size_t sz)
>  		return true;
>  	}
>  
> -	if (!bpf_map__is_internal(map) || !(bpf_map__map_flags(map) & BPF_F_MMAPABLE))
> +	if (!bpf_map_is_skel_data(map))
>  		return false;
>  
>  	if (!get_map_ident(map, buf, sz))


Thanks! The bpftool patch looks good, with one reservation: after this
patch, I believe "is_mmapable_map(map, ...)" will return true if map is
a percpu map, although percpu maps aren't mmap-able, so we should
probably update the name of that function to avoid any confusion?

Quentin
