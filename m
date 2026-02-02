Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9FB71F94F
	for <bpf@vger.kernel.org>; Mon,  2 Feb 2026 05:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770010796; cv=none; b=mFweOSGNMjigplDiAE3Iq3VaqDPgxs0MMJhTKLQPiB9X4+wLhan3qb0XmY+E8P0a95fONxbneH5tQLfU1ZkyxihkD4+j1nGzBsKcJmxNlBNyW+xx+iw5D/scFGLbhMeEm2Aymez5sBPfhWKvbtv8KfETQWdutnZifc1ZQbjRqPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770010796; c=relaxed/simple;
	bh=cXdg5YoGsJVjjvtwqrLiUIW+CK4LXMS0mPg91TTgNsw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SfLMFB63jABZnjIk2d1x7G6dTbAgWf9UYkfpaZaiWCurhWRK6BB/gvM/lDwM0+0NtSohmwqQKbTUCYYRKw28HSyMZCIprq39KNdgGSqm/y9k/SxTDfCKt6+cAHTlz43EQLe5dBC9nXdW6bVSBSIQW4xP+MF9sK7zYGwCMn8E51s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tQmu5Ifm; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tQmu5Ifm"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b8845cb580bso658462566b.3
        for <bpf@vger.kernel.org>; Sun, 01 Feb 2026 21:39:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770010793; x=1770615593; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oQHxYYh/oaSmYIKd15e37VDf14jUNP+IN3jHPHFgtg4=;
        b=tQmu5Ifm34sayGchBEo+KFQTDvp7mUzbMKz/Y0+Bgwk66scgAJPdvrS1uCBLQ+soG3
         jUHSk37X33KL8mREqSfvCJ78Ixi/8xaiIzFxFYIE37mKCZawzfYV5gI7OEyz+4RVGrRS
         KPnhA3UP/1UB8gxvisZwGFoW1t7vpJz/mI+IiYyF6xvSzu0fHg4UWUSn7/QJ5Z+J/eqk
         MrkxjL3kzYgWZHRdUtatDpV/uw+gbkGxBr1JBYuegyEP94Hy+i3REfkUSQlELBSujAVc
         pFZpc4O7oy38Ic3/KUoJAEyogEh1BDirfNX8Jd4kYzaFYqzrvk0ejBQcYhpNf5V9CNKx
         frYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770010793; x=1770615593;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oQHxYYh/oaSmYIKd15e37VDf14jUNP+IN3jHPHFgtg4=;
        b=dkbxM9puXnBThMIWpg1dXxZR/i8KP9y7qWkgH/yDrxFOG+I9RjwcjVpPsMjkqANygI
         bZCpdKI0QufokI0qLCUxLczwINgMD5WtevtPvHCxybK4Yvp23g3jwZu/hIEWOycu4Czs
         ukem2LnewJMY0DQdKgBSAkTboOgrZPk1PXvD5RWfX5f54MO2iDBEKIIf5ubNLrip6LX8
         JUCsAfjp871alNHkS8qsKN0v9hmabns3GZqCPlCTNdpov0k9J8nD46ABCBKEQa55Z/oW
         AJDy1HcZ6yhE+6LozRbUQs+NlmQVKnUFbPSSKSL68WGulMqubB1M3zbbWLvlhIG8hOPE
         n8ng==
X-Gm-Message-State: AOJu0YwQesla9R0RC5r+7VnGiXcZ15XXJoTHNIxIVXT4wBYbGw+Se5vY
	lKBBM2Jjo06dtDuZVPf940rrLdQEmE+QiECx8zAdq3hmCjdaqQZoDnN1l6bX4M4XLQ==
X-Gm-Gg: AZuq6aJWcA9BReTzMmAAXItqWxGtkvPJBYk5WP3HtDqFoS8eF4XcfvikLU8PK5cll/z
	ak4QsO8McyM3crNWpTJenUB+eVhrSiScHIBm+mUj/OULSfygVf0UNUvpqLWz4gfBUiCXpbFu9LI
	7115Zc8aBUpHMo3zYi9Z3eVfX948ED+JlrpZJ5hIVNKtDnjoNfc0aE5m5fJHwzuCRgTtrRu8sg3
	WN42iutERskImnnrmDotuPZNtBv/Kg4Ch169DQ57NK99lbMGPW+OwXYKlYikKKvpiae45lKGgY1
	FAGsJtmpNy6w6DtKxNh3u4CykB/e9wKBVDvgWJ9CCIFkfXxPwwFXryYENcB+utU/hoabrbtIXb1
	iSExj5UiEJzQKnOqYnUagZggTmhfYKYG+uYBcvwg8KaoMbUDfT7X5FCxvrHfID8UXxWTEtAfgPQ
	MsWN/7OrDrjO4qvoKHYnS2Pv98JkZ3OJG5eeZ94bWMelR0xOrf0Mw=
X-Received: by 2002:a17:907:846:b0:b7d:1cbb:5deb with SMTP id a640c23a62f3a-b8dff5bfd66mr624231366b.27.1770010793134;
        Sun, 01 Feb 2026 21:39:53 -0800 (PST)
Received: from google.com (93.50.90.34.bc.googleusercontent.com. [34.90.50.93])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-658b4691d0asm7521455a12.18.2026.02.01.21.39.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Feb 2026 21:39:52 -0800 (PST)
Date: Mon, 2 Feb 2026 05:39:48 +0000
From: Matt Bobrowski <mattbobrowski@google.com>
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: bpf@vger.kernel.org, Michal Hocko <mhocko@suse.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	JP Kobryn <inwardvessel@gmail.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, Suren Baghdasaryan <surenb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH bpf-next v3 10/17] mm: introduce bpf_task_is_oom_victim()
 kfunc
Message-ID: <aYA4pH_nIBZ-ZhLL@google.com>
References: <20260127024421.494929-1-roman.gushchin@linux.dev>
 <20260127024421.494929-11-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260127024421.494929-11-roman.gushchin@linux.dev>

On Mon, Jan 26, 2026 at 06:44:13PM -0800, Roman Gushchin wrote:
> Export tsk_is_oom_victim() helper as a BPF kfunc.
> It's very useful to avoid redundant oom kills.
> 
> Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
> Suggested-by: Michal Hocko <mhocko@suse.com>
> ---
>  mm/oom_kill.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/mm/oom_kill.c b/mm/oom_kill.c
> index 8f63a370b8f5..53f9f9674658 100644
> --- a/mm/oom_kill.c
> +++ b/mm/oom_kill.c
> @@ -1381,10 +1381,24 @@ __bpf_kfunc int bpf_out_of_memory(struct mem_cgroup *memcg__nullable,
>  	return ret;
>  }
>  
> +/**
> + * bpf_task_is_oom_victim - Check if the task has been marked as an OOM victim
> + * @task: task to check
> + *
> + * Returns true if the task has been previously selected by the OOM killer
> + * to be killed. It's expected that the task will be destroyed soon and some
> + * memory will be freed, so maybe no additional actions required.
> + */
> +__bpf_kfunc bool bpf_task_is_oom_victim(struct task_struct *task)
> +{
> +	return tsk_is_oom_victim(task);
> +}

Why not just do a direct memory read (i.e., task->signal->oom_mm)
within the BPF program? I'm not quite convinced that a BPF kfunc
wrapper for something like tsk_is_oom_victim() is warranted as you can
literally achieve the same semantics without one.
