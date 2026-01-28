Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A74730E852
	for <bpf@vger.kernel.org>; Wed, 28 Jan 2026 11:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769599188; cv=none; b=E08615fLRPVpv5coAyrYdT/SOHk+w9Ug4sQym6LH+mx7tcD1NxcJJQieSllMJm1vB0bB1+f5eLeQixSaD4+kSMq5CbtMKFJIXNQNpTFUcNLBugo+vLjnViiyzTBf/ewkGwtPn3i999cyCnYa8GFMhR/T/QY87MSy4u+Lcli6XgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769599188; c=relaxed/simple;
	bh=SBJs5VbM42Boeb9oqQft+UhTPTKk5TFdgYFFVoRflU8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=khXlniVklh3zxIWJsOH0mkp1QYO4WV5jpmQWOKlVZ4DpPM27d0RV+onSXMg39ZgbkbZCmn0m0JIFeuJDM4ZUnNkYCuSZmhSt5PXbJEYWxsUejw5zD/xzFMmJiEoQWnq3/uhC/8+pq+sxcyn4CpUjv4K+Go3dMKmIFEEgVLwcw6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=CITYm0Zc; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="CITYm0Zc"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4801c2fae63so52170445e9.2
        for <bpf@vger.kernel.org>; Wed, 28 Jan 2026 03:19:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1769599184; x=1770203984; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sE6tlLY2cerxXtkLllgRGINAxWflpeXsllvs5CeFxl4=;
        b=CITYm0ZcRKOm/UIdP1L5+BFioXil/tfZmQtBLQb+75hI1PMarl1Be1Vhw+Bh7dIqdG
         9tMe3vfbyZ8JZOjEaZXkrP9Djii/8hpXaQHROGp07U2JFBKzUiOz6EKd6mzDWrYnE5/V
         sVjp4XdhhUsa5eNy5fEdGBxX24bLWHggDW5OCQeVwGO40LEqaJNRv8Ktf+Ft4q0XEffT
         B415EhM6xWR0wM+UeAAms1zYIAPvYxPgaPGYhIvm6jQ5tAx5MCfoZOGHqAYh8lHFwq7/
         dZAq2R2upOLUm1yOgaMXfVaLsWndoY1yrKvyvqIaVEbGgm9jytrp3Z9yFhFHgiueA3a7
         EWBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769599184; x=1770203984;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sE6tlLY2cerxXtkLllgRGINAxWflpeXsllvs5CeFxl4=;
        b=rWySs1NB9b9rCOWk8aQKO7L+sQeIrb+zlpuhMZcf1abDOekiqIvIl6YCksiDKXcD9+
         uqN4l2Ri4plMWSPP0zDMKm9VtJ/P9sIMEVJy3lE70bkZKx5arWUjrOUzCm7giQZUM+vR
         xRkE6b1raqQCCPV/QQsIq474IPsa4LU7tUauR+pF7U+ML4XqHSOiZPZ4afk8JLl5pC0q
         FZmroSGtdrG7SHlbZ36BNBJq+ygShTtmtPR1+YcnQt69A/V8+J0yer9SvRTdwFDtOz6R
         8d2fA4NKgNdgy99sIoHU88OpcAE3lsLrNkiHtuWihzskRo2NeLBAsdAXhNVXThUWbtEA
         1Fpg==
X-Gm-Message-State: AOJu0YxSjS/le4G5CQqIsQXIy6m3o2cvl5verroryl6eye2i54fP7ydu
	Xmf6iGkFwOO0ZaJVD/miCIVNfqrHRa4Lpu7UCnPcq489AlsRRYesOZ2RITFAFVi+1lBOKNya+0p
	tfEej
X-Gm-Gg: AZuq6aJYDNVnow5dEme1pIMWgErb774dENZgE8SgHt+G2A2PXzn882h9ipyYZPfCjbA
	Nj43GDDbTi7xJoS2ZBo2yAMXTngmaj1+L4kMPvmlziZgf4wEElizYyEhPDMcUmee8RC2HWLcCHk
	otN/YqmqiPd2FkK8ojucjKMQ4e07+zV1y4q8h0JPpnuM1nGunsEOodgDNBgdSjbXYxjjnUb1jbb
	y1Zs6wCvdIlpuLvOpgDBbkmlPQdzHMhqPo54oPRxZzMQf/zwLaGmjAi06rDznHUZxHWVX0wTYrI
	1IvDjGyBszX/U97V8vstw08GuAWUiVvmPniMHJPYVlriAaAvNKbFLjDSG4VqtfL/nYZanmQKpSu
	z9juARKu3DuU/PaQnU5I7pwxazxn1RCbUUak2LgT/gELxCOB0F1KwnssFZwj26mN040JQNfuuWp
	kmvqWPzc6hn1f4qQHeSmhxQIwg
X-Received: by 2002:a05:600c:8b63:b0:480:4be7:4f53 with SMTP id 5b1f17b1804b1-48069c5fad8mr72206785e9.31.1769599183682;
        Wed, 28 Jan 2026 03:19:43 -0800 (PST)
Received: from localhost (109-81-26-156.rct.o2.cz. [109.81.26.156])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4806ce4c515sm55723105e9.11.2026.01.28.03.19.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 03:19:43 -0800 (PST)
Date: Wed, 28 Jan 2026 12:19:42 +0100
From: Michal Hocko <mhocko@suse.com>
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Matt Bobrowski <mattbobrowski@google.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	JP Kobryn <inwardvessel@gmail.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, Suren Baghdasaryan <surenb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH bpf-next v3 07/17] mm: introduce BPF OOM struct ops
Message-ID: <aXnwzpeaggySKRzd@tiehlicka>
References: <20260127024421.494929-1-roman.gushchin@linux.dev>
 <20260127024421.494929-8-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260127024421.494929-8-roman.gushchin@linux.dev>

Once additional point I forgot to mention previously

On Mon 26-01-26 18:44:10, Roman Gushchin wrote:
> @@ -1168,6 +1180,13 @@ bool out_of_memory(struct oom_control *oc)
>  		return true;
>  	}
>  
> +	/*
> +	 * Let bpf handle the OOM first. If it was able to free up some memory,
> +	 * bail out. Otherwise fall back to the kernel OOM killer.
> +	 */
> +	if (bpf_handle_oom(oc))
> +		return true;
> +
>  	select_bad_process(oc);
>  	/* Found nothing?!?! */
>  	if (!oc->chosen) {

Should this check for is_sysrq_oom and always use the in kernel OOM
handling for Sysrq triggered ooms as a failsafe measure?
-- 
Michal Hocko
SUSE Labs
