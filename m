Received: from mta0.migadu.com (out-222.mta0.migadu.com [91.218.175.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA98F4AFE3D
	for <bpf@vger.kernel.org>; Tue, 15 Sep 2026 17:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789493198; cv=none; b=ogCHsSdatTsONfvPcStgM9m9A1nIGzrFiA7juunwn8wfNbSK/51JkFIFoD6gvfJ5eJ7hcLumCugJW8WUto0ouvMjkzgQ34NTP+DRucodrsnUFhqg/eOE43u1qYcEqXhGR1Uvuf1V/iOIuKiLapjh4bR7Z3AWewFJ3C8E9dyI7Qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789493198; c=relaxed/simple;
	bh=z3VROCEjHUXLMEwm7jbMKvcs86CUi8SjcyFIWtgFK6k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L/YgExo4UIxtJmfh2PZz73nb3xwdEN1FhDuPMA+3xRrvgEuJb6Au6JsqOKjllu3mO8INW+ofcD14EbfpY3HhnUXttjYfV35/t+nVBkMjL4OQJ7J3KhaOqSx6iRXrD4XWThnX3hQAb8iNQphO47fKNu2b5hR5GWvh1OfmZDdKNSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JW0QND0X; arc=none smtp.client-ip=91.218.175.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JW0QND0X"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=z3VROCEjHUXLMEwm7jbMKvcs86CUi8SjcyFIWtgFK6k=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789493194; v=1; x=1790097994;
 b=JW0QND0XDZORdiqlrs8XDHgqK3SNSsfQgDc9QrcVkSbMVtzB/a39wX4Cyl/3tiXmYvH0L0DL
 3nsKmvYMQ3k1pbNW7RxXJI8l2PoOZ7fTkSLqnSbDdjQxX2Vhc0CysTT0qchn5H+6KoNn6ACFX6p
 zR54Gt90d9miP64b6wOdxWSo=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id ad139adac85be7d6;
	Tue, 15 Sep 2026 17:26:33 +0000
X-Mizu-Trace-ID: ad139adac85be7d6
X-Migadu-Flow: FLOW_OUT
Date: Tue, 15 Sep 2026 10:26:28 -0700
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Hui Zhu <hui.zhu@linux.dev>
Cc: Roman Gushchin <roman.gushchin@linux.dev>, 
	JP Kobryn <inwardvessel@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Shuah Khan <shuah@kernel.org>, Barry Song <baohua@kernel.org>, 
	Geliang Tang <geliang@kernel.org>, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	linux-mm@kvack.org, linux-kselftest@vger.kernel.org, Hui Zhu <zhuhui@kylinos.cn>
Subject: Re: [PATCH bpf-next v11 1/2] mm/bpf: Add bpf_proactive_reclaim kfunc
Message-ID: <aql_rkQMtlLmMstC@linux.dev>
References: <cover.1789475073.git.zhuhui@kylinos.cn>
 <ee6bcf945910babab2200f05040975492aed21b3.1789475073.git.zhuhui@kylinos.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ee6bcf945910babab2200f05040975492aed21b3.1789475073.git.zhuhui@kylinos.cn>

On Tue, Sep 15, 2026 at 08:29:35PM +0800, Hui Zhu wrote:
> From: Hui Zhu <zhuhui@kylinos.cn>
> 
> BPF programs can observe memory pressure on a cgroup, e.g. refault
> stats via bpf_mem_cgroup_page_state(), but cannot act on it:
> triggering reclaim requires writing to memory.reclaim, which BPF
> cannot do.
> 
> Add bpf_proactive_reclaim(), a sleepable kfunc performing one
> proactive reclaim pass on a memcg, like a write to memory.reclaim
> but without retrying until the target is reached, so that when and
> how hard to reclaim is BPF policy rather than hard-coded thresholds.
> The reclaim target of a single call is capped at MEMCG_CHARGE_BATCH,
> as high_work_func() does for memory.high; reclaiming more is left to
> the program, which can call the kfunc once per bpf_wq callback and
> stop at any point. It is limited to BPF_PROG_TYPE_SYSCALL, because
> other sleepable programs may run with filesystem locks held, on
> which the reclaim path could deadlock via filesystem shrinkers.
> 
> Convert MIN_SWAPPINESS, MAX_SWAPPINESS and SWAPPINESS_ANON_ONLY from
> macros to an enum so that they are emitted into BTF and usable from
> BPF programs via vmlinux.h.
> 
> Signed-off-by: Hui Zhu <zhuhui@kylinos.cn>

Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
