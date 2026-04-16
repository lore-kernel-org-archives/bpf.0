Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C36C52DEA6E
	for <bpf@vger.kernel.org>; Thu, 16 Apr 2026 22:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776377791; cv=none; b=uTJO0j1ujp6WRyLv9cEQfsaIJ+Ve7ewCiCj+tTB9WVtHgsxkNzp7i27DwnYpLV+5USMWbOo1QlT6iYWR5V0SgdBW2ZlLuX2zGqfQ381spzkK1utRUXlCEwNeD5XgzABJobaMaM5lVDa4YT4ZCEn5z1iA00ME3TQLzOTw8xY7O9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776377791; c=relaxed/simple;
	bh=hzVWauLZri7wQAx35mCcwgfkvHfMbH0b/GBNtVgnK94=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PoPX0CNKULZj3RlkRO+ZS6l/WQhXx5eqmDafWj/IRXi7maW51342MkzDO/A0NpxQaZme71kLBpw1Ywd8TpQVi8YKjjJrHpUAsmyX+23+0aX5rpkOCK2NWSp9O5tzoG1Uu6Tijz2TH47NH03zlHMLY5u33oRoEe0+a80AC5WP2Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rfKVC0dN; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rfKVC0dN"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4888375f735so322695e9.3
        for <bpf@vger.kernel.org>; Thu, 16 Apr 2026 15:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776377788; x=1776982588; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LJ6nCSobDok6Wl4PJhiNgWjX0izjH5Pk61ivcyKTJTU=;
        b=rfKVC0dN/Ds+IFqNonYoyqbOfvFov1f0sTaGFR+kNibzNAzYYYhNOvRiHBP1FXin/S
         WutjJBvOENUTQq70xY3Uwd5tpkzq3CHgBVNcYUo5bpWcrFhdSXZ05wHsD1GacEsqZHqM
         PgnBxVV0IlMwIKqM/XnctjHGLUbxjy1jQ4K3Y8Sr6K5Q3veIaP/Os+LR/lU4mQzCd//8
         WqYb5NMqJmL/YKO/ws9wffOpE10elRdboc2uGhtvScrVSY8+Ns4h6uA6/AM4xlOV5Tcp
         S+aYIUVvH1yY2JSdYTHzs6ZVYQj859eeQoxuM5dsfQomu9usotqKoMAc+waAKIlE5Q54
         hd/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776377788; x=1776982588;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LJ6nCSobDok6Wl4PJhiNgWjX0izjH5Pk61ivcyKTJTU=;
        b=SINj7M0Lwn6s2lSQjWnVeU/BymAslnrOCukM7f0gcxZcwuzJoZcE3W1ccaguC7sc8G
         BhAHEZa29VU8zl6tr8ySLdsh3pUIHFhMbaBkcKXdo2m6blJG4nXqdWYlcyPJ9gAtqYtn
         ZxD/DRoJC1Yy5C7gGdcgQV+I2sUayneCH90x3yoS+UK4O1Mvbj/AvnHD9pzm5KGd6Nwv
         2ZU4dGH0nS4WeDTJensUy0ekfmIM9kGUIXujmbeoKg2AmfTM6ukmOZeyoX9SR2cjrn4m
         1PV5AWV2c9MisfXZuIPExoAA/WIfQG1scks9HywlYC5yoRGXe1x3Endk4XKlmoW4Eh3B
         rAIg==
X-Gm-Message-State: AOJu0YyK9SHIQuHwORhvS5OZrVdtmXFD6C4WO/gIuAhdn+X+97kS4XT1
	wdbn3FZHn8WcUkU8YFv+Qhvwr5MQe2DBGIHA2YT3SMWrTu56Czta61Je
X-Gm-Gg: AeBDiesueU7RjHL3jBhbw5CWs2HSRuciEI6w4ZUlgUQl9M2WXWZN0lguhKk6e5HyfD7
	J/O27A932sabFtjo++4qS4/fD3Q9r7+pkqf7FQQkP4j0u8mZF8FqmddfS/zp7fVRbRzqVM8PfBd
	B54SeatfLokHBS8gSVC18CqDncxpUj3iCSqtvGEbPhQHvFRlL9cbHqpscCHfQjS/fPunxWHpw7N
	kBbG4xONo6rwZag5+75niFR3dwishnm7EYFQYTUASt/zkruNSSjRxBwrWrSVeezAQPZIxQFnVvB
	Fmx1Eb33A8z1YwbDxHJ1fw22/1cV9tohx/aU6uJf7wu8hOzScDMewnJ9lgzD4VMMX+MmFFC1csp
	Y7waoYpZ3XzZRqPR6C2UjhaSXctkqo0BzQV97s/ZTp+Oj1aq451300OvdNV4YxKiKkg85CRvd51
	cx93VPHbxXlBvfVdUFq8nqWY92LP3gOjTuY+puIg5XCl2ux4EeowXlud3l3tgxk1Ede9TAGpYYf
	wmIOvtSrmSJnEyDbqHCt4VhbiYiKv1XqRwCIGzS8iz3grocD0pTMMmEotypzRDqiEH+9zc4G9DP
	Ku0Tj9GM9TaxGcGiDFohlXPSEVU/2KRlVDa0qqaAk1hfrYJl8u+MBw==
X-Received: by 2002:a05:600c:4451:b0:488:9e54:94c8 with SMTP id 5b1f17b1804b1-488fb7a1a74mr3805545e9.31.1776377788031;
        Thu, 16 Apr 2026 15:16:28 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e0092ca608f43e4326a.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:92ca:608f:43e4:326a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fb7a0589sm2177175e9.19.2026.04.16.15.16.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 15:16:27 -0700 (PDT)
Date: Fri, 17 Apr 2026 00:16:25 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
	daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com,
	eddyz87@gmail.com, memxor@gmail.com,
	Mykyta Yatsenko <yatsenko@meta.com>,
	Hiker Cl <clhiker365@gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: Fix NULL deref in map_kptr_match_type
 for scalar regs
Message-ID: <aeFfuZ4SGFJ1xS5B@mail.gmail.com>
References: <20260416-kptr_crash-v1-0-5589356584b4@meta.com>
 <20260416-kptr_crash-v1-1-5589356584b4@meta.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260416-kptr_crash-v1-1-5589356584b4@meta.com>

On Thu, Apr 16, 2026 at 11:08:07AM -0700, Mykyta Yatsenko wrote:
> From: Mykyta Yatsenko <yatsenko@meta.com>
> 
> Commit ab6c637ad027 ("bpf: Fix a bpf_kptr_xchg() issue with local
> kptr") refactored map_kptr_match_type() to branch on btf_is_kernel()
> before checking base_type(). A scalar register stored into a kptr
> slot has no btf, so the btf_is_kernel(reg->btf) call dereferences
> NULL.
> 
> Move the base_type() != PTR_TO_BTF_ID guard before any reg->btf
> access.
> 
> Fixes: ab6c637ad027 ("bpf: Fix a bpf_kptr_xchg() issue with local kptr")
> Reported-by: Hiker Cl <clhiker365@gmail.com>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=221372
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>

I believe this should be sent to bpf, not bpf-next (though it currently
applies cleanly to both). With that:

Acked-by: Paul Chaignon <paul.chaignon@gmail.com>

> ---
>  kernel/bpf/verifier.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 9e4980128151..a4f3f367988c 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -4544,6 +4544,9 @@ static int map_kptr_match_type(struct bpf_verifier_env *env,
>  	int perm_flags;
>  	const char *reg_name = "";
>  
> +	if (base_type(reg->type) != PTR_TO_BTF_ID)
> +		goto bad_type;
> +
>  	if (btf_is_kernel(reg->btf)) {
>  		perm_flags = PTR_MAYBE_NULL | PTR_TRUSTED | MEM_RCU;
>  
> @@ -4556,7 +4559,7 @@ static int map_kptr_match_type(struct bpf_verifier_env *env,
>  			perm_flags |= MEM_PERCPU;
>  	}
>  
> -	if (base_type(reg->type) != PTR_TO_BTF_ID || (type_flag(reg->type) & ~perm_flags))
> +	if (type_flag(reg->type) & ~perm_flags)
>  		goto bad_type;
>  
>  	/* We need to verify reg->type and reg->btf, before accessing reg->btf */
> 
> -- 
> 2.52.0
> 
> 
