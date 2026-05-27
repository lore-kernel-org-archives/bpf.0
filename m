Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F33B8218ADD
	for <bpf@vger.kernel.org>; Wed, 27 May 2026 08:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779871646; cv=none; b=PMmBkpzlQPaQpE+HE3dt5bB3Cz1heS0Xde8dkoxKI+UXn3nM/kl03jrzU2r/JdyLy9HIVroGiZCMe8tHOT+Uctbhpu0RSxJy8m73RnBSKKd+moDzISKRUUkEhIw+KG9ZZyHWhi/T/Wo12i7DvWR0Gnxt7ikXAQY7Ky/Nakt001s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779871646; c=relaxed/simple;
	bh=+S4VYKZ9ptdmSKpoyw5zEZ0qC9zK3GWuSXvh/IZacBk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ucfQ6AB/Hm5PdiiJCbQ8/4270TH/Z4IgcrBT8XJumCJNgbxfpJK5sJ3cUXEaC8WfXxCUzTyRlpvdN7w57XE53zm/M+AkpvwziqlltlvMoKeCvVuA3qc5csIQuqJ2pvzBi/XUlEAHE8/TT6hltR3kMQ9qus1xu12+fOtm2C7J6kU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=VRjMtZnp; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="VRjMtZnp"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4904127c32cso32932965e9.2
        for <bpf@vger.kernel.org>; Wed, 27 May 2026 01:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1779871643; x=1780476443; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SvPbiO/kvHgyF1x18sRDfpJ1LTwDqRquW88o+S2pTM0=;
        b=VRjMtZnpCKOcXcOF9DTMgqBezQRg/M94etjreoP0KPFMjPt2kMWgqAUEKwNHTRLZk4
         oY64omlnIYFtPHTVkffnvv7lQLndypfYNUl0HsubOgZ61xs4tkAK8SQRTa08Qi2m6nso
         yks9j0LgvYs/4UuQJBAnrQ2pkHiWYjBKnwQyn8JkgRCIslpcxkg2WrHBf2H93O3OD7rG
         mRF5ESWiVzPTC0mh8erPuu3+P1rLE9StT5ocRa6LIaJpUy5xAA5jfSDjqjWxAQZq8Ox3
         RtHohIqiSiblGpByGNRwYkS2BP1veVP+MW5/xc3EVZJJAMzAIR9ElsG1kVeidqb4ZlZy
         Dq0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779871643; x=1780476443;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SvPbiO/kvHgyF1x18sRDfpJ1LTwDqRquW88o+S2pTM0=;
        b=CZ6T7OT1uASCXUr/OVb/JqpYj9q6nO/13CeYd+wcMt+q4m8bAuQOSpqKYTzAencIvX
         SjENJ+5GN7sgXXKsoUc7c02YCHQx0X4+PXs1fAj6xL+iJrBa8wZLEOLAbZQ36TUI8Xtt
         ISSzHx3TATaSlJtLb9xhWWxs2PEtRLcvd2tM5SNihjrKzkfvwcevl0PncvMVNekgFmZV
         z8pcxUGVHmR5q3wP1NFsN3AR0TIb0529Vc7YDfJ1QenosHLa+S5u983UIGcHVNT10zHl
         qAH0pCKU8ugznLhB0auK8p+7BWLebm4nEyRIRd2d/gHH1UwTqyr9OUcQmf4K3otJNk6o
         14eg==
X-Forwarded-Encrypted: i=1; AFNElJ9Ugs27jh1Yy8HMWjDCiHj/J8ce9hgBwNwDtx9vvcBGA4BQ1eh/HiNtvX1qfNHNOYUY6Ts=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPUA833tnzjOA0gRBO0G3nkqu4VWUgIInucb4AZtcjLiGKAFmP
	2oQgcl17xoUpCEr+GuO+KUydy+K/zSzxmMP2cPDFXCvNLW9QfJRm5g4w1ZyzECTsSbs=
X-Gm-Gg: Acq92OF59xJQ13LfMbKU6kM/Yv+dWhzzvI4p0H/A4wrwx4J3259Vvo6K9LNDM0Vp1DL
	9yzbshzHerBFn7yCVTYk+yhcOl/lM5DqQqjsHmmuKWgPMNLEn6pvBMGi9o0A6GL8rjRjdpHFeK/
	x0YOw+BJMTM7X8L77N8e+Dvsjl9OirgcD/kWIEnvEO55RfpCUFZdEa2EOG1LvBUQ+Fm0rPBU8gt
	vJoQxhYZ8wMoQ/I7/3Om08PDy5EdAVvFml0HCbO43KZPa/AwcNFkZjl/JWZhl4PUWXwbu0sIbiU
	tj9jmh6EMc+rnmETJsIVPhwa3IOOg8JAFtnmeq1xNKb4qmGRKH8lzV9iSLKRGxEYzADbNRCw6mZ
	OK/gFZwptoJCD+8uzLpdonEb7oN+nEFvmdpKDGGUHem8LagA8mLhLnzGwwFvwZDgyygrhZJ/y19
	mW1qfwbPi3Y1cu49vbVyhX16tsnDzHz+Rq8a76yfT06LGB
X-Received: by 2002:a05:600c:a402:b0:48f:be94:d82c with SMTP id 5b1f17b1804b1-490426d1a91mr259475015e9.19.1779871643182;
        Wed, 27 May 2026 01:47:23 -0700 (PDT)
Received: from localhost (109-81-80-71.rct.o2.cz. [109.81.80.71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4908098f315sm12090405e9.16.2026.05.27.01.47.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 01:47:22 -0700 (PDT)
Date: Wed, 27 May 2026 10:47:21 +0200
From: Michal Hocko <mhocko@suse.com>
To: Hui Zhu <hui.zhu@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	JP Kobryn <inwardvessel@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <shuah@kernel.org>, davem@davemloft.net,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>, KP Singh <kpsingh@kernel.org>,
	Tao Chen <chen.dylane@linux.dev>,
	Mykyta Yatsenko <yatsenko@meta.com>,
	Leon Hwang <leon.hwang@linux.dev>,
	Anton Protopopov <a.s.protopopov@gmail.com>,
	Amery Hung <ameryhung@gmail.com>,
	Tobias Klauser <tklauser@distanz.ch>,
	Eyal Birger <eyal.birger@gmail.com>, Rong Tao <rongtao@cestc.cn>,
	Hao Luo <haoluo@google.com>, Peter Zijlstra <peterz@infradead.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>, Kees Cook <kees@kernel.org>,
	Tejun Heo <tj@kernel.org>, Jeff Xu <jeffxu@chromium.org>,
	mkoutny@suse.com, Jan Hendrik Farr <kernel@jfarr.cc>,
	Christian Brauner <brauner@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Brian Gerst <brgerst@gmail.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Willem de Bruijn <willemb@google.com>,
	Jason Xing <kerneljasonxing@gmail.com>,
	Paul Chaignon <paul.chaignon@gmail.com>,
	Chen Ridong <chenridong@huaweicloud.com>,
	Lance Yang <lance.yang@linux.dev>,
	Jiayuan Chen <jiayuan.chen@linux.dev>, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org, cgroups@vger.kernel.org, linux-mm@kvack.org,
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
	geliang@kernel.org, baohua@kernel.org, Hui Zhu <zhuhui@kylinos.cn>
Subject: Re: [RFC PATCH bpf-next v7 00/11] mm: BPF struct_ops for dynamic
 memory protection and async reclaim
Message-ID: <ahavmbcdXDX5gNup@tiehlicka>
References: <cover.1779760876.git.zhuhui@kylinos.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1779760876.git.zhuhui@kylinos.cn>

On Tue 26-05-26 10:20:00, Hui Zhu wrote:
> From: Hui Zhu <zhuhui@kylinos.cn>
> 
> Overview:
> This series introduces BPF struct_ops support for the memory controller,
> enabling userspace BPF programs to implement custom, dynamic memory
> management policies per cgroup. The feature allows BPF programs to hook
> into the core reclaim and charge paths without requiring kernel
> modifications, providing a flexible alternative to static knobs such as
> memory.low and memory.min.
>  
> The series enables two complementary use cases.
>  
> Dynamic memory protection: static memory protection thresholds
> (memory.low, memory.min) are poor fits for workloads whose actual memory
> activity varies over time. A high-priority cgroup holding a large working
> set but temporarily idle will still suppress reclaim on its siblings,
> wasting available memory. A BPF-driven approach can observe real workload
> activity -- page faults, charge/uncharge events -- and activate or
> withdraw protection dynamically.

Why the same cannot be achieved by dynamically changing protection?

> The test results at the end of this
> letter quantify the difference: in a scenario where the high-priority
> cgroup is idle, the BPF-controlled low-priority cgroup achieves roughly
> 37x higher throughput than with static memory.low.
>  
> Asynchronous proactive reclaim: the memcg_charged and memcg_uncharged
> hooks, combined with the BPF workqueue mechanism and the new
> bpf_try_to_free_mem_cgroup_pages() kfunc, enable BPF programs to perform
> proactive background reclaim without blocking the charge path. The
> pattern works as follows: the memcg_charged callback tracks accumulated
> memory usage; when usage crosses a configurable threshold, it enqueues an
> asynchronous work item via bpf_wq_start() and returns immediately without
> throttling the charging task. The workqueue callback then invokes
> bpf_try_to_free_mem_cgroup_pages() to reclaim pages from the target
> cgroup; if usage remains elevated after reclaim, the callback re-enqueues
> itself to continue. This allows a BPF program to keep a cgroup's
> footprint below its hard limit (memory.max) entirely in the background,
> avoiding the OOM killer or direct-reclaim stalls that would otherwise
> occur.

How do you account the overall work done to the specific memcg as the
large part of the reclaim is done from WQ context?
Also when introducing a BPF hook please focus on describing why existing
interfaces fail to achieve what you need. For the async reclaim why it
is not practical or feasible to use userspace driven memory reclaim.
-- 
Michal Hocko
SUSE Labs
