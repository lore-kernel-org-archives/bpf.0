Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BCDF15ADB1
	for <bpf@vger.kernel.org>; Tue,  2 Apr 2024 20:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712090475; cv=none; b=Kf0kXD/VRL+bgs5RI6WZqPrjf4pF6G5RjaY3FB9jd+CnaZz1Dfp3S0pQLl6pxh2j2x7tRsTBhx2XuEIZcdfj62eLtt/3jCdhfdKjzKSMXugDYsbl1v8f3WhBmoNZWhdZcQTxwWKpXByQ7zMc180niESQXRUJkAVq3m+Xr7Scca0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712090475; c=relaxed/simple;
	bh=HWzEiqBuHaYZ2Kx2tIo/D4Y6kZ6jM/wJf3n0FgK2h7U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XDxWiczsYduBlk4nLgabQqTRPy+4zXJjarNMN39l+suF/o4Gcq1J6pbrTEa1V9Lk4OMNHARGwjbYOzzU97h901ax7GkKMWzSHySt6iEUQ/mhs1rPYARSYqzyAnvhk10qjrh557a+169yf+dul8YYgzz+PUKgprLN83PPljl1c5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=NlR0z7oH; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="NlR0z7oH"
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 41709411BC
	for <bpf@vger.kernel.org>; Tue,  2 Apr 2024 20:41:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1712090472;
	bh=CGkMB7imTwkGu5/eCOYqKNUHQM5FWRQ0y2vNVXy+Bfc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:In-Reply-To;
	b=NlR0z7oHcDPSPCV7lM6Pt53mr4A3FIBAgE+25FR/D4/13e/oo6fa4EpyE6JM9Vq5Y
	 eLOPcOJfR6Fxtjpl4CjQ1KvwoWzD4NJHxfqro3vcoBrTRJwxuIfWvzKRzf46mbZz2R
	 OSVOIwuy2dnrkVk6YCsi7t8EKONN2q04rRgW9QtvNd4KBkWg5NlFIWEyp0Hyqugsfr
	 yOyfMkdgV9CZakaxpcq9Dunq6VAUlkDIZTYV+WtxwFdVpSfheVGsODA6sVSeP/WnkX
	 STLyf1jfBBh/kVcvti4VeFM2MOLF0qda7EPkX+4bW5GcXy9OeBh4eXfpXZCeBWabSk
	 NwD3sW5FSJQ9A==
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-5681b29771fso4948687a12.1
        for <bpf@vger.kernel.org>; Tue, 02 Apr 2024 13:41:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712090471; x=1712695271;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CGkMB7imTwkGu5/eCOYqKNUHQM5FWRQ0y2vNVXy+Bfc=;
        b=eIsuKIZgZPEz8F5Te6WvaMemy/3zA67gtjTSwyJ9j2DUW2iLQtwRQPCJM0Z2mPnBeE
         1vgPSFZf+3cMZV+PP4Y9N6P81wV4hjPsrA49ka61j2FBMZqrW/TbqnSUUPuTUaeuJR0G
         fKI3EAAsamNX350PU8ERwH053D5c783HeqbV0mhPmw8DQNHhk+mT7UmHsv4O7H1bkXWc
         XGYZr4pX3F3khufKHymE2CVXysewwKCgf2yexrA5jBEt+/kXOnMfaz/aWrCXKTehobBu
         svm6ulKwSxB/L8un5MpBqMNeUXYdmKGnjqLJPbKYUwmAjRXmlEk0qSh8iN7VhqQgbj8u
         QBeQ==
X-Forwarded-Encrypted: i=1; AJvYcCVinxgdndPerKozsaPWCFMX3uVUukVxjezJsQFtmk1A3ynPwcWxZ6DSNEPV6/X0y8fALibhEAzrKoebxSb2nXr/eLnb
X-Gm-Message-State: AOJu0YwqXnxFoNOg56HvORAlKcj0fBXgBgG9w3Cpz2m90K6dxo3c4x2Z
	SR0HEYNp2NzrTKRzk9rXcq54XfObjfAV7JRaS0MuYm/16/JiTMe50oXpAXye8qfYdDYZ0I7oLaz
	SZpQkpBrkwJpQ6ydyxNh22bJtOljtFES2srq9BSKF3lzbcxbfjWx4mmmb+ohqrP0IqA==
X-Received: by 2002:a17:906:e203:b0:a46:22a3:479f with SMTP id gf3-20020a170906e20300b00a4622a3479fmr10516945ejb.21.1712090471597;
        Tue, 02 Apr 2024 13:41:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGJwazTnWb26fCC8OgOWgbFx8/0qWiEQkvDFj7yoQDRDAlOAX8koYzmXeu5UnVOTOyeF5Y39g==
X-Received: by 2002:a17:906:e203:b0:a46:22a3:479f with SMTP id gf3-20020a170906e20300b00a4622a3479fmr10516925ejb.21.1712090470909;
        Tue, 02 Apr 2024 13:41:10 -0700 (PDT)
Received: from localhost (host-95-248-169-71.retail.telecomitalia.it. [95.248.169.71])
        by smtp.gmail.com with ESMTPSA id wt9-20020a170906ee8900b00a4e76e922a3sm2145674ejb.218.2024.04.02.13.41.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 13:41:10 -0700 (PDT)
Date: Tue, 2 Apr 2024 22:41:09 +0200
From: Andrea Righi <andrea.righi@canonical.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
	David Vernet <void@manifault.com>, Tejun Heo <tj@kernel.org>,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] libbpf: Add ring__consume_max /
 ring_buffer__consume_max
Message-ID: <ZgxtZSFKddlMz3s6@gpd>
References: <20240401073159.16668-1-andrea.righi@canonical.com>
 <20240401073159.16668-3-andrea.righi@canonical.com>
 <CAEf4BzYuMxF6JDi4gG+cfikXqrOsBqiZRw8Ur4K5=YwQKAqKXg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4BzYuMxF6JDi4gG+cfikXqrOsBqiZRw8Ur4K5=YwQKAqKXg@mail.gmail.com>

On Tue, Apr 02, 2024 at 11:04:39AM -0700, Andrii Nakryiko wrote:
...
> > + * negative number if any of the callbacks return an error.
> > + */
> > +LIBBPF_API int ring__consume_max(struct ring *r, size_t max_items);
> 
> I'm bikeshedding here, of course, but I prefer `ring__consume_n` and
> max_items -> n.

I actually like "_n" more than "_max" (same with max_items -> n).

I'll change this (with all the other suggestions) and will send a new
version.

Thanks for the review!
-Andrea
