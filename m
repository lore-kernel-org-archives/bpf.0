Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 284744E80D0;
	Mon, 28 Sep 2026 15:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790609146; cv=none; b=cT38C/ksI5Ah38AGZuqwMSLByk15MUEfU5xdwlS3b1u/T8CSdG/5CYYw9DEAqWpkYOZb6iUO2XKMKM25lRxq/DhmV6KKvu+VBTb2cJUTEuPh99i0hlon/TIHFXlbva7qhj/vXEQOyUykaLWBlVh9wgsuPgEu/DpzxML/y3zwTyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790609146; c=relaxed/simple;
	bh=JqaKyQ4PISf3x372mLSD1ToN9s3CINjScfypD0deAZI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DWdNQ5M/1mSwa5VPRZqpp5nI4oyA14v5p/XU4T336juGMs1YwvS5nCtVJ5Tn8zBCdPo8qXRu1Z+bDZ5cBtHBKUdu5HaLth8PFINe3KC5CVVAIGU9C2r80hwrXQVtcGhZ9OlTjRCdcu45qayWWEOM32jQb15rkm4wxpso5Ur+Y3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GiYkjjK3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GiYkjjK3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B7DA1F00899;
	Mon, 28 Sep 2026 15:25:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790609144;
	bh=Lzxlok9wSv7gUQfItovFqkmbzZNh5SMmRsgelv8XGgA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=GiYkjjK3f5L+ZXPCmqXsPT6XdTdmoa9CopVT1Mpeg+evKCQOOiBynE+6+hjupg7vI
	 hga5aoYuAGB8V7jrd4DB5X2oMW1qF4KRqfyumQ7quHVRflSl7yajf0+CS/OjZ0mTiI
	 Yvlcq1wFrh/KTmmiZFpGxS1EntkaMwfcmbZ0/mQNa+1ouA2axJ68roWqOswPAUsJqn
	 tVkQ0bKZqb42rXsn6bj+Dc/rzbuCLp+NojW7tVOfV4RkWrQovFA4L6iQkLUKki8/qP
	 /qMffDnnKVzvTJuOdoOm4fIv2hMkR1qsH23Hb+rFu2eREV9RVcpbYIwRBNkxD1bgQK
	 h9fwiQC+KaYDw==
Message-ID: <3acbe829-06f0-4df4-b57c-a8c7b802ec96@kernel.org>
Date: Mon, 28 Sep 2026 16:25:42 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v9 1/2] bpftool: Add recursive map dumping
To: Tianyi Chen <hi@tychen.cc>, bpf@vger.kernel.org
Cc: andrii@kernel.org, eddyz87@gmail.com, ihor.solodrai@linux.dev,
 linux-kselftest@vger.kernel.org, skokovmaksimevg@gmail.com
References: <20260926014208.24773-1-hi@tychen.cc>
 <20260926014208.24773-2-hi@tychen.cc>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <20260926014208.24773-2-hi@tychen.cc>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

2026-09-26 10:42 UTC+0900 ~ Tianyi Chen <hi@tychen.cc>
> Dumping a map-of-maps currently shows inner map IDs without their
> contents. Add a recursive keyword to map dump to include referenced
> inner maps, leaving the default output unchanged. Show selected maps
> followed by distinct inner maps, preserving plain and BTF formatting
> and using an array of map objects for JSON output.
> 
> Holding every discovered inner-map FD open would make descriptor use
> grow with the number of maps and could exhaust RLIMIT_NOFILE. Keep the
> selected map FDs open, queue distinct inner map IDs, and open, dump and
> close each queued map in turn. This needs only one additional map FD.
> The tradeoff is deferred ID resolution: concurrently removed inner
> maps can disappear before they are opened, so the dump is not atomic.
> 
> Report failure when an inner map cannot be opened, retain per-entry
> lookup errors, and close JSON containers before returning.
> 
> Link: https://github.com/libbpf/bpftool/issues/58
> Assisted-by: LLM
> Signed-off-by: Tianyi Chen <hi@tychen.cc>

> diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
> index 626882f2079e..015910a493db 100644
> --- a/tools/bpf/bpftool/map.c
> +++ b/tools/bpf/bpftool/map.c

> @@ -971,30 +1066,61 @@ static int do_dump(int argc, char **argv)
>  		}
>  	}
>  
> -	if (wtr && nb_fds > 1)
> +	if (wtr && (nb_fds > 1 || recursive_dump))
>  		jsonw_start_array(wtr);	/* root array */
>  	for (i = 0; i < nb_fds; i++) {
> +		memset(&info, 0, sizeof(info));
> +		len = sizeof(info);


Good catch, reading bpf-ci's review the other day I didn't realise there
were other locations in the file where we omitted to reset "info", which
means we may print wrong BTF info when dumping the maps, that's a bug.

I can see three other locations (do_show(), do_show_subset(),
maps_have_btf()) where we call bpf_map_get_info_by_fd() in loops without
resetting "info". We'll need to fix these, but this should be a
different patch or series. You're welcome to go at it if you want, I'll
send a patch otherwise, just let me know. I would maybe move this
memset() (the hunk above) to that dedicated patch.

This patch looks good to me otherwise:

Acked-by: Quentin Monnet <qmo@kernel.org>

You still have a conflict with Maxim's series on patch 2 though, both of
you picked the same test file name. Maybe use
bpftool_map_dump_recursive.c instead?

Thanks,
Quentin
