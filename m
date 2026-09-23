Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D066D3C76BE;
	Wed, 23 Sep 2026 23:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790205637; cv=none; b=rdNg/FGDcyiJLLVmtsj3A0tMyxsxIecweclu1Vbckb7qiOT0O9gd3Whi4elFSM6XAscaSeb2WUVppf/R99Ml8fYVXHgsn+MKhUhqOkNyOavCm+LFHTlzsqGMw4cDkR1zf7eis+NmFJceLkKUf7O1Ztdqvm0p9zzIhT16C4u6zJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790205637; c=relaxed/simple;
	bh=cBk+2Fxa3j79LZ23fDUoelQE0mEN8VXPYuAas8vkES0=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=Qc+609+mJosvR3q+NKB8nT6gthZx2Wuo+Etdq9mX8v3QMhPemTtezZX5jG8KALUEn30i3PxW1MlQCDat3ht3KqYyaokPPhYfgYucrx2I30BvI8CFQj0mSfyUC2WLskyyHd/vLw1FusGwfHQh230CABEV4jz4fdqNYS80jOZe5tU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a2i8VjfZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a2i8VjfZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CA401F000FF;
	Wed, 23 Sep 2026 23:20:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790205635;
	bh=pQBC2rxaQGT0plbXuJJ2sX0XUhv5h7/Qvpn83yY8C6E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=a2i8VjfZfssDWSJL6dYOODpX+stTcYlzNU06FzdeEkfThnc/Tj+hSPmm8YiFnegTm
	 QZyvVWT7eV5ZSCB4vvaYH/nmYTcDt3qFYZQxBmu5nazIt3/Kz9VV3MfNjPcF/cMv0R
	 scXI4OqnKrPsdL3geuX83brbQ6htVjn03+R8i9TJyEgeNHDcdscwF5o27a560hdEgJ
	 OrpV6WK9W7rabPQPRhP/JvSp3gnOlxlNUx/0Mh7SbyF21cjbUYrXjsOcD3HLsnlAoW
	 8eXVejas7+QqD2vNymwyrG6LC7LZM9T1ZrlyD6dIHMiXPUllV1GGZj3AdiB9xrgT0x
	 pKHLgP6BxMPgw==
Date: Wed, 23 Sep 2026 13:20:34 -1000
Message-ID: <7d8f411e5153472c11bf158c4d948816@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Usama Arif <usama.arif@linux.dev>
Cc: arighi@nvidia.com, bpf@vger.kernel.org, bsegall@google.com,
    changwoo@igalia.com, dietmar.eggemann@arm.com, etsal@meta.com,
    juri.lelli@redhat.com, kprateek.nayak@amd.com,
    linux-kernel@vger.kernel.org, mgorman@suse.de, mingo@redhat.com,
    peterz@infradead.org, rostedt@goodmis.org, sched-ext@lists.linux.dev,
    vincent.guittot@linaro.org, void@manifault.com, vschneid@redhat.com,
    yphbchou0911@gmail.com, emil@etsalapatis.com, david.dai@linux.dev
Subject: Re: [PATCH] sched_ext: Update scx_dispatch_dequeue() comments
In-Reply-To: <20260923213418.3197834-1-usama.arif@linux.dev>
References: <20260923213418.3197834-1-usama.arif@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Hello, Usama.

On Wed, Sep 23, 2026 at 02:34:18PM -0700, Usama Arif wrote:
>  		/*
> -		 * When dispatching directly from the BPF scheduler to a local
> -		 * DSQ, the task isn't associated with any DSQ but
> -		 * @p->scx.holding_cpu may be set under the protection of
> -		 * %SCX_OPSS_DISPATCHING.
> +		 * When moving a task to a local DSQ through either direct dispatch
> +		 * or remote consumption, the task isn't associated with any DSQ but
> +		 * @p->scx.holding_cpu may be set.
>  		 */

dispatch_to_local_dsq() sets holding_cpu for ops.dispatch() inserts too,
not just direct dispatches. Can you name dispatch_to_local_dsq() instead,
here and in the description?

Clearing holding_cpu here is also how dispatch_to_local_dsq() learns that
it lost to a dequeue. The old comment on the other branch described that,
but for the wrong branch. Can you add a sentence about it here?

Can you also rewrap both comments at 80 columns? A few lines go past it.

Thanks.

--
tejun
