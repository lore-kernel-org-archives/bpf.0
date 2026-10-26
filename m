Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793042974;
	b=auozCznE3nvioEyBlCCzqf4j4LyrnJDnwVdTiSqOhNcQ+N/2fCBWx07Nuyg7+Xmh7x6H
	 OhnBIThkqoIyj6AZeO2gbui5QUewEJPkyrCBLa/syyWR6Shze6GZYIyg+/7Hv+RBu+rMD
	 fMOQDcMRWkAcIFsQsgXA0Ni4bE68MkO6NjzxYue8CB7Sy7jYFoA0Kxi06LGq7J0KM1CNo
	 4+8RCNINnD0G4nKw7c8BSlnyTS68F5x2CPitfrVezTryiVkjsY4Q3sB3A6K76NZrLDlsP
	 ORsYrgRgTL1TVlYn/YluDEdVS1J324ryI41xeLEZbQgF56iYiclYxcXUoyqPpzSY/aw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793042974;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=PLsAYamGtns1wUJWIRBXzV2nj77n8PwlVNkWKYgFpP8=;
	b=kx5jBhghGdH38BL6BO6GXL5cNcDtadJpt5NRs/7a6mROG4Y91xBbB2iSo9vCCD7DgzYW
	 Cdfx6EoQmIqkfHIUMvuf5JHGa1VQ8m0zzMQoEW2Uwjsr1vJgkgLt5r+bKiymq34Pq4/pb
	 HHvW7TL1PGi1FbVKbZBJt+zz7xMrPYn93Wp5HqWFy97NpdrQFAAeIEk1IjgSctWblBBkf
	 s0kkAnGknDihtAuE3FrTmQCVlLbxJREvoUfs7pvvqjRik13OMzPkQPCWbCXDQXH8eDu3z
	 pjD7urjU9GHt5xDtlN5fOP7GbiYkXxVduNJmI9TbuYXtrckJQov09dlNJlgGmGFnlHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=qcSAsyGx;
	arc=none smtp.remote-ip=209.85.221.41
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE28F606A31A
	for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 19:29:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EE28F606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=qcSAsyGx
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-48e0d885929so2262022f8f.3
        for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 12:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793042972; x=1793647772; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PLsAYamGtns1wUJWIRBXzV2nj77n8PwlVNkWKYgFpP8=;
        b=qcSAsyGxZogdu09nH8QzET+JqChi7DRHD6u8/YqYgMBQnfv9tT9aRyMKdKQFVYcJUq
         O4HCBbYUTzeCXtaXLqDL3IVC7JM8aKxr1DzPowRAQeKpaICSoe2mqsQAfCHNslbGFCLX
         POG+FV5VNk1LqQtowj223a7AB6VQ9IjcH7GTEVtWFATxrQUdkPeharVHu6I8gajbf31D
         puKK++usRBIQR/hQqN2dtnqE1hKsIei/NWu+gHuDMwfwTbjTjDU+CpEjxVFZobng8wsN
         HYyEXUlbffuGRcK5/XCrlrWdZ4iFDUTo4F07n6UqAnE0koEJfTqWRv/VzXPBKXBXfNt6
         aFEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793042972; x=1793647772;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PLsAYamGtns1wUJWIRBXzV2nj77n8PwlVNkWKYgFpP8=;
        b=hYop40Wb6wxjo/6nNIvl5ZKkUbRmLyJ74fzQCF9R5HucL7AV8UPgjaBZliIbMQY5E+
         XDPyX+5zZ9/uFEsQM1Yh8tWisQ5fSU9Vd4gEff0mbEnRe5JXpO1YyrwUZbkpFI9DiRCK
         GsAUpnjFBNTivYy7woz6h7SxgqmIZoDW7J+x/BKbF3kvwz/S999chKmD64ey2sQhbUJu
         UWR3sywa5b3BI2dkwzSXZnher+F+HoIaxCDHlqLlKrwLCSXh1BAdJ1caKKKz0vf2fDrh
         koSwkQeDN+rPaH9WgsLcPaGN67lULQ3O5e7uTTOZ9f1opgDLHlV9OriwmApzUK10pjgw
         usOw==
X-Gm-Message-State: AFq9FYKFL5C7MI0HI56hyAli0WhNem6+eA6xpkBlwC5Qy420gvEsuvb6
	anyRY7NDbZqlFuga+zYzTSoAtjfas2QaFBwCknCky1NWNKTEBCSpLijr
X-Gm-Gg: AYBFou3ZPjADjACap5Pvj6c4HG2V1oRcHmn7F3PUO6OrHxlH38Knr42ExGDwcpW74cb
	Fi/Zdfl33QWLNkNVe7BHXAknZbbL97pxvyzifVPR6d1BoW8Ixk/x9Mm+UHsxA5WirXHKtOBFN8X
	zAfrUCoiozmFpFbvllPECgCPkmQ4/3NpTryRWD8E7yz/lZ/+sJ6+eMfdn8Rp6UM+JJQOAG3Hvya
	4zuRh7FLw0Az4fRtVhCedbKNAA2WIo01BHZ6fSAi+27uCk7a2XbBrn9yipArexhjvP2UIRb1auU
	cfH+9tS5JoOjgdqU0mAuHT4GwWiUmACIgRO2JxyeUIlI/LEUYZUIHXisK4cS6iV7mCj0MqV3/b9
	vVYB/sLO8EdvQrZhZYhLcSioP1A9bk/8dTBphW48srZLXkZ7F1it4gP7L8spdKxbUG64zVeu5R4
	p2VmQ5LWHt4ZKtN5trwUemX9RFFO73nfY8Jg01nlWTs2Potk49hGzwG6O4v7l9czjw/t7Aq9pYA
	/lZ493xTT8ljdtLGVFSk9p6ODora/GWk5k4bnP6Y0k/7Dh4VHd5q65q5dmjN3U7KyPYoqhNWl2A
	+eGZLpe/HjV5HxXf9g==
X-Received: by 2002:a05:6000:40dc:b0:48d:f014:63ee with SMTP id ffacd0b85a97d-48e3eb99fd6mr14003619f8f.20.1793042972186;
        Mon, 26 Oct 2026 12:29:32 -0700 (PDT)
Received: from gmail.com (deskosmtp.auranext.com. [195.134.167.217])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ecd3555sm17612876f8f.42.2026.10.26.12.29.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 12:29:31 -0700 (PDT)
Date: Mon, 26 Oct 2026 20:29:28 +0100
From: Mahe Tardy <mahe.tardy@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org,
	eddyz87@gmail.com, memxor@gmail.com
Subject: Re: [PATCH bpf-next] bpf: Don't re-sort subprog_info[] for every new
 subprogram
Message-ID: <at-qGFFTBcMS0vxH@gmail.com>
References: <20261023150302.4097865-1-alexei.starovoitov@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261023150302.4097865-1-alexei.starovoitov@gmail.com>

On Fri, Oct 23, 2026 at 03:03:02PM +0000, Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> add_subprog() appends new subprog to env->subprog_info[] and calls sort()
> on the whole array, though only the last entry can be out of order.
> Move subprogs that start after the new one up by one entry instead.
> 'start' is unique, so the order of the array doesn't change. The new entry
> can land in a used slot, so initialize all of it.
> 
> add_subprog() returns the index of the new subprog instead of the last
> one. The callers check for error only.
> 
> It's a trivial prep for rust-bpf [1] that bumps BPF_MAX_SUBPROGS to 1024.
> Rust crates have more than 256 functions that are not inlined.
> 
> Time in add_subprogs() when veristat loads sched_ext schedulers from scx
> repo, 8 cpu VM, usec:
> 
>                  subprogs  before  after
>  arena_selftest       101     386     27
>  lavd_enqueue          52      96     16
>  lavd_dispatch         48      78     11
> 
> [1] https://github.com/4ast/rust-bpf
> 
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>

Reviewed-by: Mahe Tardy <mahe.tardy@gmail.com>

Looks good, why not take advantage from the sorted array! (I know it's
kinda trivial but trying to review the small patches around here.)

> ---
>  kernel/bpf/verifier.c | 29 +++++++++++++----------------
>  1 file changed, 13 insertions(+), 16 deletions(-)
> 
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 5601d2056218..676566f80d97 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -2605,12 +2605,6 @@ static struct bpf_verifier_state *push_async_cb(struct bpf_verifier_env *env,
>  	return &elem->st;
>  }
>  
> -static int cmp_subprogs(const void *a, const void *b)
> -{
> -	return ((struct bpf_subprog_info *)a)->start -
> -	       ((struct bpf_subprog_info *)b)->start;
> -}
> -
>  /* Find subprogram that contains instruction at 'off' */
>  struct bpf_subprog_info *bpf_find_containing_subprog(struct bpf_verifier_env *env, int off)
>  {
> @@ -2645,26 +2639,29 @@ int bpf_find_subprog(struct bpf_verifier_env *env, int off)
>  
>  static int add_subprog(struct bpf_verifier_env *env, int off)
>  {
> +	struct bpf_subprog_info *subprog = env->subprog_info;
>  	int insn_cnt = env->prog->len;
> -	int ret;
> +	int i;
>  
>  	if (off >= insn_cnt || off < 0) {
>  		verbose(env, "call to invalid destination\n");
>  		return -EINVAL;
>  	}
> -	ret = bpf_find_subprog(env, off);
> -	if (ret >= 0)
> -		return ret;
> +	i = bpf_find_subprog(env, off);
> +	if (i >= 0)
> +		return i;
>  	if (env->subprog_cnt >= BPF_MAX_SUBPROGS) {
>  		verbose(env, "too many subprograms\n");
>  		return -E2BIG;
>  	}
> -	/* determine subprog starts. The end is one before the next starts */
> -	env->subprog_info[env->subprog_cnt].exit_idx = U32_MAX;
> -	env->subprog_info[env->subprog_cnt++].start = off;
> -	sort(env->subprog_info, env->subprog_cnt,
> -	     sizeof(env->subprog_info[0]), cmp_subprogs, NULL);
> -	return env->subprog_cnt - 1;
> +	/*
> +	 * Determine subprog starts. The end is one before the next starts.
> +	 * The array stays sorted: subprogs that start after 'off' move up.
> +	 */
> +	for (i = env->subprog_cnt++; i > 0 && subprog[i - 1].start > off; i--)
> +		subprog[i] = subprog[i - 1];
> +	subprog[i] = (struct bpf_subprog_info){ .start = off, .exit_idx = U32_MAX };
> +	return i;
>  }
>  
>  static int bpf_find_exception_callback_insn_off(struct bpf_verifier_env *env)
> 
> base-commit: b116ac6087541d3d98031e786adbe9c733cd6df3
> -- 
> 2.55.0
