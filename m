Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 536D63321A5
	for <bpf@vger.kernel.org>; Tue, 27 Jan 2026 09:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769504563; cv=none; b=ZNh/6BqfNLQPIwgO6WF+rDBZPX+Ig6gvOfcclo9eBZw2c/vH2RXhS2GyFE5K2qJJFxLQDR6iHA4fNxu1f8nbzsa+PeUIxcK2Gmr1h4hnkbSKigoMqvKX5eRrQSfgoOvwNLCDaGPvYSIkf5WuIfEmnAfR4L7boUyfHxRG+36j224=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769504563; c=relaxed/simple;
	bh=HRc/mHCe+udfa+m6y1EgHh/uUKCWIQftI8ihhgUIrAY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LC2pnO+CrQMVjaAZUmViGBPW0bnOab+7e2v5Wcs/+frqFzPDSa6VG6U+QA3krzVxUZNfK3REOaLjGSNkOWktQM2no9ZsMvLfw9qMF4V9F3twZu5aD5GCoGSTL/RGH/UQkwfG8cGeii8J0rh5Stg3gZjNEhImVnvGZt8YSqj7F9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=E9sF+f//; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="E9sF+f//"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-432755545fcso4014184f8f.1
        for <bpf@vger.kernel.org>; Tue, 27 Jan 2026 01:02:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1769504560; x=1770109360; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LKDWo0DZ7WSwFHUHcIcu30uUFge5ch1xyNfI86/sLVY=;
        b=E9sF+f//7/r/B88TtsBbyVEXeXNOMcUHgxf+EWaRL+NWGlNHktsn0pkJqM6MwM3718
         te4JHIdKyz1ezcQq8vadsfI3XEmtrBbwzz80LOFIwCOhKTyvc72u4zIQhY9uN1sArpXb
         cJS3nMdxujmx3qIFyMDSTbL3tA9wjuy6szqKClargh+jM74Iw9VfOrB6bdyEeX4/hd9p
         uAzednJN2D2VbnZCQsp8bwIUzuEIoW4A+Sl55+ik0OOIKbmfItrSnMwqbmcbm6mouFD0
         OjocGHsfbAczv7bsS4XWhuE+Y76shwP6+4EyDGo7FYGkXWuuPeuL3k39JvnoF7SlejY2
         3q0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769504560; x=1770109360;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LKDWo0DZ7WSwFHUHcIcu30uUFge5ch1xyNfI86/sLVY=;
        b=uEydHIuT/zRS/h/fyjp1r7nnxRTKF+cQ/v5XhVdDmmeYCKfOWmJTZxaQK0YbryMGcN
         JzYNYy7HOeCcLqsuMOOCuJEXTom9QaNPeXennuemR1zxkFsuxv2wXsHbs1YM/DBpK364
         4X5HxS83WGRsIaBeQ1VhNkV7awIoKyP/+JLaGRb9oguFtIG1NrgJztMgCEcpPU2q+JNg
         7k8SUGVFIcPqdkwB41x2mRetBzaddUrQUVXtcmFwMsxmZltbkiGG4CZt59KvM5FjF6Xm
         V5FEu1NEgzmyO2okg/ZgcS191wvttvVje0nWrMYD6bTq4GFuj6SXHzjLzAQWGHQiJV+v
         s4Mw==
X-Gm-Message-State: AOJu0YwTSMkmpxD0N7+LuDgQyn21uQbs7zObA7emIGh4hEkrMnD07w7R
	uyaVFCBDF0neXMfBDm18NURSLEHe0nvfIPZlvg6YghJpEpn6T2jwtLfjwuhjncC2wzo=
X-Gm-Gg: AZuq6aJHGIBuoDNCgkIJr3lZ2E2Z+rbUl+KASLl60WNT07/e3qW5jpcvcTKP/Xkwo09
	kAr9RigTiObYpW6NdZlTS43v14eGCyycPyMo6w43+0W5GleiHnBkkpQ6ZaTi5tH3avjBg8WPuP4
	NSNdropAY3N6LkkF/DI3mXqpjlXmz2ucg6zDn3ZMzZu6d656YUcZI5RYTFrTsASyo2yc4nIq87Q
	uIeG9/y42nhCrI5SUEHpaw+XNAYKQGxbsctj1KYvfexTfpvjKv/MAZNkZK7qAVAoPkTIq2jbO4N
	yUKx+2Cq7LGkM/3a0vIuE93u9MXBUk98/e+LTzGLdKbdmlxvd+k3bNCF8yVjKtStvb7VSj6tFWk
	PRjSHPa1pPVdq4ovPKebn6xzL4Gr6TAuUSdUlymohaGh2J8eYNp+M6de/yahKZur7Jj6Mxs4kkO
	3pIssxbXcTnFahDL63SvDraYr1
X-Received: by 2002:a05:6000:4282:b0:431:752:672b with SMTP id ffacd0b85a97d-435dd05a81amr1236447f8f.14.1769504559686;
        Tue, 27 Jan 2026 01:02:39 -0800 (PST)
Received: from localhost (109-81-26-156.rct.o2.cz. [109.81.26.156])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435b1c24ac1sm36402707f8f.14.2026.01.27.01.02.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jan 2026 01:02:39 -0800 (PST)
Date: Tue, 27 Jan 2026 10:02:38 +0100
From: Michal Hocko <mhocko@suse.com>
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Matt Bobrowski <mattbobrowski@google.com>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	JP Kobryn <inwardvessel@gmail.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, Suren Baghdasaryan <surenb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH bpf-next v3 00/17] mm: BPF OOM
Message-ID: <aXh_LpTzDhvv20uB@tiehlicka>
References: <20260127024421.494929-1-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260127024421.494929-1-roman.gushchin@linux.dev>

On Mon 26-01-26 18:44:03, Roman Gushchin wrote:
> This patchset adds an ability to customize the out of memory
> handling using bpf.
> 
> It focuses on two parts:
> 1) OOM handling policy,
> 2) PSI-based OOM invocation.
> 
> The idea to use bpf for customizing the OOM handling is not new, but
> unlike the previous proposal [1], which augmented the existing task
> ranking policy, this one tries to be as generic as possible and
> leverage the full power of the modern bpf.
> 
> It provides a generic interface which is called before the existing OOM
> killer code and allows implementing any policy, e.g. picking a victim
> task or memory cgroup or potentially even releasing memory in other
> ways, e.g. deleting tmpfs files (the last one might require some
> additional but relatively simple changes).

Are you planning to write any highlevel documentation on how to use the
existing infrastructure to implement proper/correct OOM handlers with
these generic interfaces?
-- 
Michal Hocko
SUSE Labs
