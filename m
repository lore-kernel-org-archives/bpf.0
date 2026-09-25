Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 124A24CE668;
	Fri, 25 Sep 2026 19:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790364291; cv=none; b=a9FcPloOUhBqlpH+JTSTK8soHo3bOsxIOM8qs+AJ03qal7KTys9utreNVOcYsJcKRmXL4El4skeZ/vmCDq21DkughNjO1BpAMuuEp6SKgVDtFo6mHXcRRrCl2MBmZd5bawK05j0TSVovbx7TRspzK6pHFgmdChTFdEdU9FmSup4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790364291; c=relaxed/simple;
	bh=I2enzlvGYXQe6kyfRBqy5/8Z3Rnu2AyLzzPjOKipDm0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bguhto/EUZGq7BCRHx/tVYLAw/iDu35Lqkj76WmEDJGaCkmSKhtxJmEmy6VBgeuZIineBhnJLqjVvDIby2t2LVoh+G+ot4b5/l5AqFjTObYPIJBnvyD4i1lxAxjKpe9WfErqqAoIAEsPOkBS7VY0G0LIA544xz4ur0ER2cy45QU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iwIpgarw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iwIpgarw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A9D91F00898;
	Fri, 25 Sep 2026 19:24:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790364288;
	bh=gL7KYzC6TKjrTTfyTNoqbbOm0pMEBvmjbknZne8m4es=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=iwIpgarwOLx9qK2A4Zkreez4K6HOXklUndPxV1MUhBh3YBxzKPFyRbdl67fQtOo68
	 YprHdW6nh3tsY9PKvzU5gblrnQE0pcQCvmBvesa91zuBUCJh5WMKZ4ALC9WKwwZSjl
	 1ktSZBy26q4YuHJHe4E5QDtHiFcmBxNa9BzNUltyK5alWf+WL128Ui/p/O/7Ckl8aC
	 T8VIvth6gl3Q9idkuIO9mkMg6BVI2J88+7vTnWzphiFcU9N4mZsILCzBRWVHXG0Hky
	 6+9WNGEt8GkTZ76XB182wgEvXKoaSjP6v8+8+FIYoljUVx19s4cAOs7xY+X6Qrke/b
	 imL5wT59DDl7Q==
Message-ID: <661699fb-456c-4e68-85df-94cb829b2204@kernel.org>
Date: Fri, 25 Sep 2026 20:24:44 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 1/2] bpftool: Fail map dump for maps that
 can't be iterated
To: Maxim Skokov <skokovmaksimevg@gmail.com>, bpf@vger.kernel.org,
 Tianyi Chen <hi@tychen.cc>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com,
 ihor.solodrai@linux.dev, kuba@kernel.org, shuah@kernel.org,
 linux-kselftest@vger.kernel.org
References: <20260925162031.27259-1-skokovmaksimevg@gmail.com>
 <20260925162031.27259-2-skokovmaksimevg@gmail.com>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <20260925162031.27259-2-skokovmaksimevg@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

2026-09-25 19:20 UTC+0300 ~ Maxim Skokov <skokovmaksimevg@gmail.com>
> "bpftool map dump" walks the map with bpf_map_get_next_key() and treats
> ENOENT as the end of the map. Map types that can't be iterated fail that
> call on the very first key: local storage and ringbuf with ENOTSUPP,
> bloom filter and arena with EOPNOTSUPP, queue and stack with EINVAL.
> bpftool then ends the walk without a word and prints what it prints for
> an empty map, "[]" with BTF or "Found 0 elements" without, and only the
> exit status tells that the map was not read. On a socket storage map
> that holds storage for a socket:
> 
>   # bpftool map dump pinned /sys/fs/bpf/sk_storage
>   []
> 
> Ask for the first key before printing anything, and when that fails with
> anything but ENOENT, fail with the map type and the error instead of a
> dump:
> 
>   # bpftool map dump pinned /sys/fs/bpf/sk_storage
>   Error: can't dump sk_storage map: Unknown error 524
>   # bpftool -j map dump pinned /sys/fs/bpf/sk_storage
>   {"error":"can't dump sk_storage map: Unknown error 524"}
> 
> An error later in the walk is now reported too, as "bpftool map getnext"
> reports it, and the element count is printed only after a complete walk.
> 
> Assisted-by: LLM
> Signed-off-by: Maxim Skokov <skokovmaksimevg@gmail.com>
> ---
>  tools/bpf/bpftool/map.c | 26 ++++++++++++++++++++++++--
>  1 file changed, 24 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
> index 20d59eab09..626882f207 100644
> --- a/tools/bpf/bpftool/map.c
> +++ b/tools/bpf/bpftool/map.c
> @@ -856,6 +856,25 @@ map_dump(int fd, struct bpf_map_info *info, json_writer_t *wtr,
>  		}
>  	}
>  
> +	/*
> +	 * Map types that can't be iterated fail on the very first key. Say so
> +	 * before printing anything, so that the output isn't an empty dump.
> +	 */


Or simply:

  /* Fail early to avoid an empty dump if map type cannot be iterated */

But that's a minor nit, the patch looks good to me, thank you!

Acked-by: Quentin Monnet <qmo@kernel.org>

Looks like you need to address Sashiko's findings on patch 2, though.


> +	if (bpf_map_get_next_key(fd, NULL, key) && errno != ENOENT) {
> +		const char *map_type_str;
> +		int saved_errno = errno;
> +
> +		map_type_str = libbpf_bpf_map_type_str(info->type);
> +		if (map_type_str)
> +			p_err("can't dump %s map: %s", map_type_str,
> +			      strerror(saved_errno));
> +		else
> +			p_err("can't dump map of type %u: %s", info->type,
> +			      strerror(saved_errno));
> +		err = -1;
> +		goto exit_free;
> +	}


Tianyi, note that this conflicts with your series ("bpftool: Add
recursive map dumping"), one of you will have to rebase.


> +
>  	if (wtr) {
>  		err = get_map_kv_btf(info, &btf);
>  		if (err) {
> @@ -883,8 +902,11 @@ map_dump(int fd, struct bpf_map_info *info, json_writer_t *wtr,
>  	while (true) {
>  		err = bpf_map_get_next_key(fd, prev_key, key);
>  		if (err) {
> -			if (errno == ENOENT)
> +			if (errno == ENOENT) {
>  				err = 0;
> +				break;
> +			}
> +			p_err("can't get next key: %s", strerror(errno));
>  			break;
>  		}
>  		if (!dump_map_elem(fd, key, value, info, btf, wtr,
> @@ -897,7 +919,7 @@ map_dump(int fd, struct bpf_map_info *info, json_writer_t *wtr,
>  		jsonw_end_array(wtr);	/* elements */
>  		if (show_header)
>  			jsonw_end_object(wtr);	/* map object */
> -	} else {
> +	} else if (!err) {
>  		printf("Found %u element%s\n", num_elems,
>  		       num_elems != 1 ? "s" : "");
>  	}

