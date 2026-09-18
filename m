Received: from mta0.migadu.com (out-246.mta0.migadu.com [91.218.175.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C2AC46E010
	for <bpf@vger.kernel.org>; Fri, 18 Sep 2026 17:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789754029; cv=none; b=q7uF+WL0nb+1ntuF5aUWHMpi+ZY7wAsJ0AaRxHr5fg+qfsiPVd7uOYPgds8KYi8hHGPKLKhEV+TX5vN9VOV2krNmec1oTIuGRv0Y5OVdJfG/OJp2rOTDz7YW27k6kQiZdXAYwpKb2oBNNKhqEixIyusNdTjt/UMOQHJktcue5D4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789754029; c=relaxed/simple;
	bh=qef1qfESxx2iUjqupM6SsnRWUnav4c99ce74qBOBVbQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e6m+ASXTw7Mih0BgQ4voGfKGCGFZ8leYlXBN+7p7B8pNjTFGVPRuPc9Oy9qC/8ldUhiaEp+h94IDjxpZvZKQ/QLQq/FGh0gNTqGB7TZgcOfL0VFQ8i9qUbTg37BfIwHsT4sGCIeRzS2PHI1uyN5jPjOApeCAlRttzrtv/r+Az04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=F0SXkDdH; arc=none smtp.client-ip=91.218.175.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="F0SXkDdH"
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=qef1qfESxx2iUjqupM6SsnRWUnav4c99ce74qBOBVbQ=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789754021; v=1; x=1790358821;
 b=F0SXkDdHJzR7M1rAPkRuYqPQWiYg23GAyrZPDhIs6K2ZEZC+PsmTC0JIUhyybYtAXO2UYNrM
 UV2bDvFpnIgJspy7hEMrqjcIXsjO8vP5erbnvRsQL8MN7K5cGaIl7VnJlIm1mjmwkEY9911vVZR
 erGmh8Hgg/g9vPqDna+bS8E4=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 4b40d4790eec116b;
	Fri, 18 Sep 2026 17:53:41 +0000
X-Mizu-Trace-ID: 4b40d4790eec116b
X-Migadu-Flow: FLOW_OUT
Date: Fri, 18 Sep 2026 10:53:39 -0700
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Hui Zhu <hui.zhu@linux.dev>, Roman Gushchin <roman.gushchin@linux.dev>, 
	JP Kobryn <inwardvessel@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, Daniel Borkmann <daniel@iogearbox.net>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	Jiri Olsa <jolsa@kernel.org>, Emil Tsalapatis <emil@etsalapatis.com>, 
	Shuah Khan <shuah@kernel.org>, David Hildenbrand <david@kernel.org>, 
	Barry Song <baohua@kernel.org>, Geliang Tang <geliang@kernel.org>, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, linux-mm@kvack.org, linux-kselftest@vger.kernel.org, 
	Hui Zhu <zhuhui@kylinos.cn>
Subject: Re: [PATCH bpf-next v12 2/2] selftests/bpf: Add memcg async reclaim
 test
Message-ID: <aq14epWc4EwAIEvs@linux.dev>
References: <cover.1789714023.git.zhuhui@kylinos.cn>
 <44f7fcfafd5f33072dd2b9abc31aa9bf5eacd9bb.1789714023.git.zhuhui@kylinos.cn>
 <DLIK17AFECZV.3U5UY0LYU5Y5O@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DLIK17AFECZV.3U5UY0LYU5Y5O@gmail.com>

On Fri, Sep 18, 2026 at 03:41:12PM +0000, Alexei Starovoitov wrote:
> On Fri, Sep 18, 2026 at 02:58 PM Hui Zhu <hui.zhu@linux.dev> wrote:
> > From: Hui Zhu <zhuhui@kylinos.cn>
> >
> > Exercise BPF-driven async proactive reclaim. A BPF program watches the
> > refault stats of a memory-pressured cgroup and, once they grow, reclaims
> > a second cgroup from a bpf_wq callback through bpf_proactive_reclaim().
> > Pass/fail rests on the reclaim counters. The workload timings are a
> > benchmark, not a criterion, so they are logged only under
> > TEST_MEMCG_ASYNC_RECLAIM_BENCH=1, which also runs a baseline without the
> > BPF program, recreating the cgroups in between so both runs start cold.
> 
> [...]
> 
> > Signed-off-by: Hui Zhu <zhuhui@kylinos.cn>
> > ---
> >  tools/testing/selftests/bpf/config            |   1 +
> >  .../bpf/prog_tests/memcg_async_reclaim.c      | 890 ++++++++++++++++++
> >  .../selftests/bpf/progs/memcg_async_reclaim.c | 327 +++++++
> >  3 files changed, 1218 insertions(+)
> 
> 1200 lines of selftest for a 20 line kfunc ?
> Sorry that's an overkill.

Yeah I agree. Also I understand that BPF would prefer to have very fast and
minimal selftests and selftest for a memory reclaim kfunc would not be that.

We have memory.reclaim selftests in cgroup, maybe that would be a better home.
Basically whatever we do for memory.reclaim, do the same but using this kfunc.
If you don't mind, why not let's just take the patch 1 in bpf tree for now and
we will cover the selftest in next release but in cgroup selftests.
