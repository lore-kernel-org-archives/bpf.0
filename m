Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B84B156F45
	for <bpf@vger.kernel.org>; Thu,  4 Jun 2026 14:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780584032; cv=none; b=orYbF89M3HhwFCP9MRcJgbaMcsQhPymMX/vdNqJYcMsjVpx0w6Ih/zOY75wqesd3vGCBCmR233ndZEuf/gqAKZjkbub9AB7LGvxnu9tbvnadJx3nda+lTUsACe/D+n+tv66MIE3Hs8EcWPzPqZ6V8tGHwirZt4dvvDtxiSmdL2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780584032; c=relaxed/simple;
	bh=BNAZwQZJVY9OVUoe4dSoMQ8Na1rDaA1pcoJwNW+cpgc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=glDKjULps2o4T/PFz8S7ItN7TyNE8BRnXepIXSYXYni2K9EcEdkVb9FU0L/Xdg/ZpgMYyajKFVjSefXY+m+AH9NW/rQEzWqGY0yr8qctDTs2DzwpDha1lswWXecMeRSdD8bJ9zoQodRghomvZk4r7UKGR50AqoM/+Lpi528bIK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oyg/doQr; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oyg/doQr"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-490b613a17bso8022535e9.3
        for <bpf@vger.kernel.org>; Thu, 04 Jun 2026 07:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780584029; x=1781188829; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fI2w0aqx0Zo0yYOa6RcVEd5ybeR8jkTynJbnMtMyXk8=;
        b=oyg/doQrRHZT67YT7CexGuDslI02/YXBOBFdL6lrvRsDUpccv+djRS59rhnfw7eosM
         hapamsbznZC1T3VqmSjeYJpRCH7Fc7W/H6ltl91gJb8QdG8LmMXqafWLnqq2f0QbpXe4
         9NSuEe97BiEhDu30qSRIK/IeEO/QvM3v3ADYLJEY3ePrjvErTxfGVsFEkTWWga7jPAsp
         xauJ7nNChbD8oppIsfLCv0PLid8kzy178KG6kLHnKKVcYe58JjSjoYw4hX6j+iruMw4k
         IZa7aV+3yAOMQTLD6qTufY6nSQ5SD6rlFRJH27Uh3TBxHN4qmxuhwtb7wDeu0qwxwzOZ
         968g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780584029; x=1781188829;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fI2w0aqx0Zo0yYOa6RcVEd5ybeR8jkTynJbnMtMyXk8=;
        b=aEXehl4uWsHiEXLKTC5ujImGWwUdPr8PDnJQw5Os/N2WOrZUeWNTX8W2kR9Uu2sYJW
         mRt6oHFRLy0xzBC8fVukSAxrF5EfdXU8DjV424tTOhtoqd9wyGgbiOjOv7ytISab38uW
         eEtznzIMSa/QMaLC/N1JoBVcDm7Y+7aoXrjcXyPER/GxgBFu6hyaX4o+02vRV8r8wM7G
         3w8wiH344K/Hne0guiADAQooVVqQ5wQE7cEXiX1S5YOMVwpB435zcEFL4YHxCbvaiUph
         YVAycZ0EJbT/qEdSaRY5ffsF6uKMN3VHEPMAtpmjOh4AdRynRdR/3msm2i5nHuAiXMhB
         oc5w==
X-Forwarded-Encrypted: i=1; AFNElJ9Y//l912UKRrJFt6zI6K5F98UywO8wbENRjE14OOoB/LjzrcMAnnou4U56cJLcKlyGGrI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgmY1TCpHHjIfALmyvupZbl+yTR+4x5EpnHPBR9j/KnVv3aoY8
	mvsBwghFjrSeGFwKZDdALlwoAV2ZjmNHoG1h2Xmoq1K25fdMd85y4/5l
X-Gm-Gg: Acq92OFbcFRSyopGgWzpl4xMN5IxD+mfSdyI7JnnK4k0G3rKzLgCtyeS887aTI2X9xl
	1oERl6JG+hEWQXW/9nSFB4J1TtjtmUaUKb3bkmz34wxBfxJdKPAR4W0HqQfX9ou/0FPzpVOufTg
	MSs+06CqSQsu61rre2jFOzUA3pr41ksbuoIQjJQXExkChGPRG5zbeyoyzN9kP136KaL+Kceitf8
	mJCfs8JTg4sUEKzZvKDNVk5uMMaompTmtUbPqUrtoga7mrMtTbJSyf99Qg2uXSKB1S9MH4vQXYR
	jITZwjE3aOD/QP0FZYXbnbxiXVrLts1QfpBngODTJQxu2qIAmPEj7Up5+r3JmsLTuuL40kJAHBG
	FyIDA4jDjlSfXXMSQp75uENYdZV3iTdkf+sotd17EdJSqfGpr3dXXj4OU/GgmqfGBMJ6fz57wPB
	3Q9LQkXi/5v5FzVPCNIJDimNkIWf6fC6mruOF7hqyfPOWHtxUjgYX4c6anrf4dRLWdxjXIb/8P/
	mV0AXQB8r5gY6CIBA2W8w==
X-Received: by 2002:a05:600c:6288:b0:488:aa33:dcbd with SMTP id 5b1f17b1804b1-490b5fdb17amr136963255e9.26.1780584028536;
        Thu, 04 Jun 2026 07:40:28 -0700 (PDT)
Received: from ?IPV6:2a02:8109:a307:d900:9c30:fc5f:5bdd:2e3f? ([2a02:8109:a307:d900:9c30:fc5f:5bdd:2e3f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490be1f69bcsm57131815e9.8.2026.06.04.07.40.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jun 2026 07:40:28 -0700 (PDT)
Message-ID: <a1561e36-08dc-4ad1-848b-88974f529d10@gmail.com>
Date: Thu, 4 Jun 2026 15:40:26 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 3/3] libbpf: fix feature probe failures for
 implicit BPF tokens
To: chenyuan_fl@163.com
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org,
 chenyuan@kylinos.cn, daniel@iogearbox.net, eddyz87@gmail.com,
 linux-kselftest@vger.kernel.org, shuah@kernel.org
References: <20260529031604.888137-1-chenyuan_fl@163.com>
 <20260604031033.806727-1-chenyuan_fl@163.com>
 <20260604031033.806727-4-chenyuan_fl@163.com>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <20260604031033.806727-4-chenyuan_fl@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/4/26 4:10 AM, chenyuan_fl@163.com wrote:
> From: Yuan Chen <chenyuan@kylinos.cn>
> 
> probe_fd() converts BPF syscall failures to return value 0,
> which feat_supported() interprets as 'feature absent' (ret==0),
> even when the probe failed due to a BPF token's restricted
> program/map type mask.
> 
> In a user namespace with an implicit BPF token, the sequence is:
>   1. bpf_object_open() -> no feat_cache yet -> global cache used
>   2. bpf_object_prepare_token() -> creates token, sets feat_cache->token_fd
>   3. bpf_object__create_maps() -> feat_supported() runs probe
>      -> bpf_prog_load(SOCKET_FILTER) with token -> -EPERM
>      -> probe_fd(-EPERM) -> returns 0
>      -> feat_supported sees ret==0 -> FEAT_MISSING
>      -> internal maps (global data) skipped -> verifier EINVAL
> 
> Fix by making probe_fd() return the negative error on failure
> instead of 0, so feat_supported() enters the ret<0 path.
> 
> Additionally add a token_fd rescue in feat_supported() for the
> ret<0 case: when a BPF token is present, a failed feature probe
> is treated as 'feature supported' because token creation itself
> proves the kernel BPF subsystem works.  Real BPF issues will
> be caught during actual program/map loading.
> 
> Signed-off-by: Yuan Chen <chenyuan@kylinos.cn>
> ---

It looks wrong to say that any feature is supported just because there is
token_fd present. In patch 1 we only checked that BPF is available, so
it was ok skipping probing. This one looks a bit more risky.
Is the reason this code fails because of BPF_PROG_TYPE_SOCKET_FILTER not enabled
in the token? I suggest fetch the first supported program type from the token and
pass it down to bpf_prog_load().

>  tools/lib/bpf/features.c | 23 +++++++++++++++++++++--
>  1 file changed, 21 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/lib/bpf/features.c b/tools/lib/bpf/features.c
> index b7e388f99d0b..f934452e52f0 100644
> --- a/tools/lib/bpf/features.c
> +++ b/tools/lib/bpf/features.c
> @@ -16,7 +16,14 @@ int probe_fd(int fd)
>  {
>  	if (fd >= 0)
>  		close(fd);
> -	return fd >= 0;
> +	/* Return 1 on success, negative error on failure, so
> +	 * feat_supported() can distinguish probe errors from
> +	 * genuine feature absence.  When a BPF token is present,
> +	 * a negative return triggers the rescue path that marks
> +	 * the feature as SUPPORTED (token creation itself proves
> +	 * the kernel BPF subsystem works).
> +	 */
> +	return fd >= 0 ? 1 : fd;
>  }
>  
>  static int probe_kern_prog_name(int token_fd)
> @@ -725,9 +732,21 @@ bool feat_supported(struct kern_feature_cache *cache, enum kern_feature_id feat_
>  		} else if (ret == 0) {
>  			WRITE_ONCE(cache->res[feat_id], FEAT_MISSING);
>  		} else {
> +			/*
> +			 * A BPF token may restrict which program/map types
> +			 * are permitted, causing the probe to fail even
> +			 * though the kernel supports the feature.  When a
> +			 * token is present the probe is best-effort: BPF
> +			 * token creation itself proves the kernel has a
> +			 * working BPF subsystem.  Real BPF issues will be
> +			 * caught during actual program/map loading.
> +			 */
> +			if (cache->token_fd)
> +				WRITE_ONCE(cache->res[feat_id], FEAT_SUPPORTED);
> +			else
> +				WRITE_ONCE(cache->res[feat_id], FEAT_MISSING);
>  			pr_warn("Detection of kernel %s support failed: %s\n",
>  				feat->desc, errstr(ret));
> -			WRITE_ONCE(cache->res[feat_id], FEAT_MISSING);
>  		}
>  	}
>  

