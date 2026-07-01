Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E474A139F;
	Wed,  1 Jul 2026 18:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782930391; cv=none; b=usRUEQ59Nt66xcdIZZ0wPXvNprfNZvooT/rTzdMtL2jmjUghF6ZfP6cE6xB5bsKbamq51FUKrfVIYIQFMsoi3o/3dYRfVNf/BjZXMBbxsITxjQrZY+TkeuEr2zIA75572/73ScozGBhbtJ+jgncR6kThwqhRoWibSZcS9xqYLq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782930391; c=relaxed/simple;
	bh=OQUrReie53Vn2Gih0HTfDGjKSSQjohLSc3GaTBVZ1kc=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=si/wyoQllx+2wds6zC3RuP4vYYCfIvB4NX4VIH4SQQ2ZmdVzVVlSKVFQWHVZBzl6xR5YCu3b11gMdmaORg/IGqa44lMYmP8XG+mRN6Dyve6ejLjU/lWkm55yFVJ3XNlvq15HVb2EezcnpuNsNEK3ZIO3Mh2GtYnNp76GB58LGY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PpaeXtq/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PpaeXtq/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D41E81F000E9;
	Wed,  1 Jul 2026 18:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782930390;
	bh=OQUrReie53Vn2Gih0HTfDGjKSSQjohLSc3GaTBVZ1kc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=PpaeXtq/0w6RjxlntWTAI3+TGu1Aa8s9f9QxVfvoKGET/DcCF381xz2iXsxk7nsMh
	 6W7psTAd/p8F8tnfOvi3+MI15CuJ2l4wl2IomrJBTljNUfQzuQSCp2+QVPzIoi+I2O
	 4vB0UKXp6LZwO6Sm4T7vtqYuJpYsBSvPzNubvcBEreJeeC9/dS7D7JHTiPORBrbQDa
	 5UXh2DSGR8hmnm1ioT3tNK7UJN7PghML0fzz+Dtc1+5VhynVSACD2+ggxPzAn/goYi
	 440M22Z5X8o/m+BEu8Zma7al/J1mpkb5+OgZk1pmR0TirIF0iqdI0aNbgUlm2WAppP
	 Rv76ZHBOYR9yg==
Date: Wed, 01 Jul 2026 08:26:29 -1000
Message-ID: <b5bb205febbb5d2220bd668d2fef5abe@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: "zhidao su (Xiaomi)" <soolaugust@gmail.com>
Cc: David Vernet <void@manifault.com>,
 Andrea Righi <arighi@nvidia.com>,
 Changwoo Min <changwoo@igalia.com>,
 Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>,
 Valentin Schneider <vschneid@redhat.com>,
 K Prateek Nayak <kprateek.nayak@amd.com>,
 Shuah Khan <shuah@kernel.org>,
 Joel Fernandes <joelagnelf@nvidia.com>,
 Christian Loehle <christian.loehle@arm.com>,
 zhidao su <suzhidao@xiaomi.com>,
 Cheng-Yang Chou <yphbchou0911@gmail.com>,
 Zhao Mengmeng <zhaomengmeng@kylinos.cn>,
 Emil Tsalapatis <emil@etsalapatis.com>,
 linux-kernel@vger.kernel.org,
 sched-ext@lists.linux.dev,
 linux-kselftest@vger.kernel.org,
 bpf@vger.kernel.org
Subject: Re: [PATCH] sched_ext: Reject task setter kfuncs outside SCX contexts
In-Reply-To: <20260701091954.384565-1-soolaugust@gmail.com>
References: <20260701091954.384565-1-soolaugust@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Hello, zhidao.

On Wed, Jul 01, 2026 at 05:19:54PM +0800, zhidao su (Xiaomi) wrote:
> As a result, a non-SCX tracing program can load after calling the task
> setter wrappers, reaching the mutator kfuncs outside an SCX scheduler
> context.

This is intended. A scheduler is conceptually the struct_ops plus the
accompanying BPF programs identified by the associated struct_ops, and these
operations are explicitly allowed for all of them. scx_prog_sched() and
scx_task_on_sched() confine each to tasks owned by its own scheduler, so this
isn't an escape from SCX context and there's nothing to reject.

Thanks.

--
tejun
