Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B80223536B
	for <bpf@vger.kernel.org>; Mon,  2 Feb 2026 04:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770008226; cv=none; b=aVA4MNuOhxp2eurO743u5yC8rw22Hi9zkfQ+z8w9ii3JRnbhcLihg74TOXvzvRV1Z5WKxo5dCWhr3ScsvVaNkL988lGWXVL1QnpxzQ1ajZArNbjix0n8gy6MTegZyvgK5EaAWnwCy+tTxwzJdNSbRoMjyBSamHaniBwKhIBhqFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770008226; c=relaxed/simple;
	bh=BOP0HYX51tXnhGhaVCjDBS8AsbFAbinui7UFcEZgdKI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LfndM9VtKikSfdJanlMYLkp2+8ZVZpIxPtn429u7k0zGyrMVoMRwFyRWG0jOIAdLmp+EErGxK8W23cEdutP0sWHuR7hjwL8EJssXEGvnYBgPEUOlXB97GlJoUYiO8oE4JRz58sWiFpfbXx5XmdjZdn00VCgM9yTvZmMmWA5Txhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eJHP30Vc; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eJHP30Vc"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6505d141d02so5451736a12.3
        for <bpf@vger.kernel.org>; Sun, 01 Feb 2026 20:57:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770008222; x=1770613022; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wPRgTQwJ4jsKG4M4C4YQuYvDcSDNXuHtRvocKp3Ffdk=;
        b=eJHP30VcMGHDSXjoAyJfagBMphp+wBSoPw/0oEl2jLt5leU6bp+sKEDV8uGwDCqH3Q
         TYUk1QTC9iEGlZpnnB+hElMxGggQMxDHMxsv6mHVHTFZKgi8TkJ/JoiHU1XvFJBzeMXi
         js5mmwBxlTU5KXG6CuT4IZVp+WBZzABdm8HAYIql+GCiqOIFAZ7qjQZV2Pg9irdqYBrA
         tosP0JOpkI6OhmYEwYpqZNJVtzFb1+at6amsqlKYpyupsZO9kkeqxaz6Duspe2JXZgs4
         XuR0zRm+61jLwwaAn1rFi/sRSXQvWNykJXn8SB1cMfL2jY56OkwqU4leHiJqopMNYIGq
         Cung==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770008222; x=1770613022;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wPRgTQwJ4jsKG4M4C4YQuYvDcSDNXuHtRvocKp3Ffdk=;
        b=w04R+aAqACMAlRQLnmQEpe4xk/XnRgIxTydKbT2zCUDA6LGx35Or3Vwc0nwbtiuz5L
         d5S5fXPf2YDO3XrgaMniwihNtKopnd5Lpfo8P+oRGkcwYQiOK5lwmoLWYbg2qkYdKxdK
         lak8oP5d9iRWAmDxRBj7dklVhb5Y6mKCNmn2QHrhE2RGqVH+XJkyOFei7nbUqHDWXjsq
         WMHwiFTpII4A8cw0bhgxM13GkQ760+9U72Akey6in1m9CcyKoyMzrvuAAs63We5qoUMz
         NB0TIicEijjuHq3/wlMsUJEJuc8R0nggl1GzKBzF5zQDXheA3uT/Fq4jvNpqThOdFESM
         5HsA==
X-Gm-Message-State: AOJu0Yw79z2BqyDclIaYsZHOA8GFHWbgYShXq4RdPKiVWnOyeCTIPtyE
	84782WBPz8kUVo+OKRTiBe7UpwxyzxtpDBkhFk+vMQXfoLrt6fg58BbOAWgzId4myg==
X-Gm-Gg: AZuq6aJ0VDXTZJFZcTaEwrioYM+fXfCHGEC95DqsEcn9yC4XklDXYUJ1Yc5w5nw3PBv
	PatJB4D6d9rfB4KdtAG0koto0oG3onV6kc5FOOKQXRLGNYgrp9zuZqjA+5uwDXiCKbRs2tLNy34
	yfgjV7sXP89AiNx842fydskxZkx1Ockmerma8dbbOxXeiQNsUX/Mk9vFdU9u3PgiXawrR6wXljX
	GPw6XgnIzBE5pTbQM+cAB0RhcKkw0h3FXdNr2YQMQYei1W2xwhxE5DpyGN3TunTwGyqzELP6Zqz
	htXCPJytyUmnqv0ka1MNkxHqGWJcv8ggpV+hatuSRJXXDbK5TXkvTISqz9xiPC4raDKxN4DBMsa
	JvOZ3Ebg6dF24FEaIVDYv/K55PAKSghiM4CnOzTrDNjJrLJ6HLSGXPlFu5PXjRKeTUwvjtgefrL
	zlsF/zxeMPqYzbe1S6liTXVuKFr8ZtvuCviR07/beI1P/mCXQlrYA=
X-Received: by 2002:a17:907:1b20:b0:b86:f558:ecad with SMTP id a640c23a62f3a-b8dff5260f2mr573103666b.7.1770008221605;
        Sun, 01 Feb 2026 20:57:01 -0800 (PST)
Received: from google.com (93.50.90.34.bc.googleusercontent.com. [34.90.50.93])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8dbf2e0868sm802341666b.58.2026.02.01.20.57.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Feb 2026 20:57:00 -0800 (PST)
Date: Mon, 2 Feb 2026 04:56:57 +0000
From: Matt Bobrowski <mattbobrowski@google.com>
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: bpf@vger.kernel.org, Michal Hocko <mhocko@suse.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	JP Kobryn <inwardvessel@gmail.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, Suren Baghdasaryan <surenb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Subject: Re: [PATCH bpf-next v3 05/17] bpf: mark struct oom_control's memcg
 field as TRUSTED_OR_NULL
Message-ID: <aYAumaqJ_MwJ3Tkk@google.com>
References: <20260127024421.494929-1-roman.gushchin@linux.dev>
 <20260127024421.494929-6-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260127024421.494929-6-roman.gushchin@linux.dev>

On Mon, Jan 26, 2026 at 06:44:08PM -0800, Roman Gushchin wrote:
> Struct oom_control is used to describe the OOM context.
> It's memcg field defines the scope of OOM: it's NULL for global
> OOMs and a valid memcg pointer for memcg-scoped OOMs.
> Teach bpf verifier to recognize it as trusted or NULL pointer.
> It will provide the bpf OOM handler a trusted memcg pointer,
> which for example is required for iterating the memcg's subtree.

This is fine. Feel free to add:

Acked-by: Matt Bobrowski <mattbobrowski@google.com>

> Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
> Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>  kernel/bpf/verifier.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index c2f2650db9fd..cca36edb460d 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -7242,6 +7242,10 @@ BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct vm_area_struct) {
>  	struct file *vm_file;
>  };
>  
> +BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct oom_control) {
> +	struct mem_cgroup *memcg;
> +};
> +
>  static bool type_is_rcu(struct bpf_verifier_env *env,
>  			struct bpf_reg_state *reg,
>  			const char *field_name, u32 btf_id)
> @@ -7284,6 +7288,7 @@ static bool type_is_trusted_or_null(struct bpf_verifier_env *env,
>  	BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct socket));
>  	BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct dentry));
>  	BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct vm_area_struct));
> +	BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct oom_control));
>  
>  	return btf_nested_type_is_trusted(&env->log, reg, field_name, btf_id,
>  					  "__safe_trusted_or_null");
> -- 
> 2.52.0
> 
