Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51CA32E041D
	for <bpf@vger.kernel.org>; Tue, 27 Jan 2026 09:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769506726; cv=none; b=SDARrNZAMLMtsVUGgUfH3llZPFkKpWKElLUY0Eun/XSDnWLXbF8H5IE9LHw2gk6oDfPNEczDb0zMnGYtCLgq9Q1r7GSNbqZraF0HS+P0o15SU0Jt7ghWOoUFze2kBbfBbA8ttYqSSU32f27j4kXW6CArEAMG7vMYjzgCsepko7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769506726; c=relaxed/simple;
	bh=oiwcFdu2zYwpL2H7+BlsXyxxw9Ni/IkaX9iWBUzBBmE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JPXSHQgC6cGxGMDU/TuXJWOxgA8qtRuggxmsdDs5Ys94SorPoIX09B4+1pSkuQhzMOa9Jhho7cncg0VqZkx+IqIi+wuESVM4hFvFOqK/mybD6jCSqd96PeqCj9DyBM12WqP/jPyLYRzJTK0CIo5gQOQ2xK41A2+Lz0Uy03n10JA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=KP5rOJra; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="KP5rOJra"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-4359228b7c6so3505016f8f.2
        for <bpf@vger.kernel.org>; Tue, 27 Jan 2026 01:38:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1769506724; x=1770111524; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=P7RNZvCglNdawEXsv8dR65PtThO1YYQ8625navj597w=;
        b=KP5rOJra9QKM0QXWSXTZo4hvyBUqVpB9ZZsYDQ/V/PX/X/mA5ACIPawiMwK0P9aSh+
         VNZ958/COxMyJYgyDnvWqlosrm4mVIGQZAk+4zADY0s56QpobtmbIRoim/1IOjbUaGZ2
         ntzs8FUxHyVg9iVl7365h5qFwfH1AbkiQ4twB44+VX2NOn5Xv3JPad8MKJaSJAZFqpGo
         xaV/zP2yHumVCZagnFMGIa2EtgpEChrQKWUF387LvE7oMsA7xAWkWcejqoJf344jsjOg
         w8KZpyt1jmMloiX3vnwpGz+8q34aCkhAya8HpSE0lXj05A6AYO5gap968XquOrsAR9jX
         IXIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769506724; x=1770111524;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P7RNZvCglNdawEXsv8dR65PtThO1YYQ8625navj597w=;
        b=GasZgCVCxKZAvYrIYhVnCXvl0VqBAbgIOAJqkFSZEwt9aX041LYA5YfUBYOO6b8ctU
         FZRHSJdtwYVWjewVzV37egRzyI9cwVPo+LYg7JSKXu9rNpLW9PrOwq4PjcR7n53ifWWm
         V1Pe08vtob3TWNjMwS5R6xZBcr7DcRyxdvKSQT//PR6dBWnW/MeJjViOajdDw2xmDc3B
         IhQQy8cKasHlY4lUDXEgTNElmmD75NpO/4d8dCZZV6hm8caRFRDrwXkC0MNsCrhTmq8l
         kPLtV4+858YzGj+0euhc5c1P8hL93cYVXcCkyClcMHTViukBwNdHJN19U+ad+nph4zyt
         iHTg==
X-Gm-Message-State: AOJu0YxtWIHnWFE0GSh5y0MuUoSMPnGKr0RF2nT8IPd3gLG0gGowVIqV
	XVmVteWJZZOs9FD9tfrrHyrlRHWBvb0OTvveJhJNYkj3P5x+y3M5GHASb9v3E9sgsJTrWzYRAzG
	UJzjU
X-Gm-Gg: AZuq6aJje8EDQR9svbkn2rj5fU1x/QAsDe4K/Z0wEdqVZ3XSsjcDbppBq2TUJGouGDd
	Z1W7Hof4TyKKb8GN3mqpOKDI/B23hLq8iO0hddNweSWhGHAANKzrabtfeKE29jo8NrBxGq7sxkM
	MK3/CT0qTbDGR1o8u11l7mKVNwvL4NOW6r68RgyyxaQNYytsx0UeHuKXDwePiXNNN9yGLwC8G+6
	9EPVfGTvRXwsrK1zn1dl+DpIfeChRb+XC6KTMn5TTT30fm1S5roWvbz7F5E2+dbOcUs70D+hPnz
	KUMM4uLn/+zbqKIfX0SHVlK7YieoNPIiztyyQh5E7Q42LPmpNRaoSn9gbjRzm+6nKPakT5BLqu2
	ognkPstG0F22ZtyLOvoEypLuTi8QYEOJd/kNJrr4xgSjbJxikAG7e3X+fjPq5JJ8qroej0h67O5
	984Opq64EQ63EHPEAHb+kBQQ5G
X-Received: by 2002:a05:6000:26c7:b0:435:a135:7772 with SMTP id ffacd0b85a97d-435dd029989mr1577820f8f.4.1769506723593;
        Tue, 27 Jan 2026 01:38:43 -0800 (PST)
Received: from localhost (109-81-26-156.rct.o2.cz. [109.81.26.156])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435b1c246ecsm37781344f8f.10.2026.01.27.01.38.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jan 2026 01:38:43 -0800 (PST)
Date: Tue, 27 Jan 2026 10:38:42 +0100
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
Message-ID: <aXiHok-3SKqLncCf@tiehlicka>
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

On Mon 26-01-26 18:44:10, Roman Gushchin wrote:
> Introduce a bpf struct ops for implementing custom OOM handling
> policies.
> 
> It's possible to load one bpf_oom_ops for the system and one
> bpf_oom_ops for every memory cgroup. In case of a memcg OOM, the
> cgroup tree is traversed from the OOM'ing memcg up to the root and
> corresponding BPF OOM handlers are executed until some memory is
> freed. If no memory is freed, the kernel OOM killer is invoked.
> 
> The struct ops provides the bpf_handle_out_of_memory() callback,
> which expected to return 1 if it was able to free some memory and 0
> otherwise. If 1 is returned, the kernel also checks the bpf_memory_freed
> field of the oom_control structure, which is expected to be set by
> kfuncs suitable for releasing memory (which will be introduced later
> in the patch series). If both are set, OOM is considered handled,
> otherwise the next OOM handler in the chain is executed: e.g. BPF OOM
> attached to the parent cgroup or the kernel OOM killer.

I still find this dual reporting a bit confusing. I can see your
intention in having a pre-defined "releasers" of the memory to trust BPF
handlers more but they do have access to oc->bpf_memory_freed so they
can manipulate it. Therefore an additional level of protection is rather
weak. 

It is also not really clear to me how this works while there is OOM
victim on the way out. (i.e. tsk_is_oom_victim() -> abort case). This
will result in no killing therefore no bpf_memory_freed, right? Handler
itself should consider its work done. How exactly is this handled.

Also is there any way to handle the oom by increasing the memcg limit?
I do not see a callback for that.
-- 
Michal Hocko
SUSE Labs
