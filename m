Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D5C2381B07;
	Wed,  4 Mar 2026 07:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772610882; cv=none; b=aG8ZymkR+dYYjh4NrAlXaMkFJLvQHTHa6MAbmtkc1Sh/2NbH9mEFuelmN5h/S427M7yO/OptAd3Gt6hpufaJ0IUqvfiKe7AFBloKXcE8E2Mg2Lr0BktCk+xKSZJ8tVtMfW7Yvo6Z8+iStLVQA97P4xfUL67m6/g45lHjOENFQT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772610882; c=relaxed/simple;
	bh=QitYUOa5hzFGpdv5n4wqmr5lh5JEpHpUcevnVR00OEI=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=KtPq6Pi5EemhmO7OebZ9O2Q1kG+CyU1c74KjAWNLAquBoY82w/kobm2O1r1vHAjcvjls8YYWaR88Bxk26DCNrPJG+IxblJXiYUMYi4HQfFCYYtzCr6z9UurnVNET4H2F8F8Nwu0qQTj7Mb3kC5SgJGkCIa+CWbedK5w3C2M5OhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gXUPZJpz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gXUPZJpz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5F01C19423;
	Wed,  4 Mar 2026 07:54:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772610881;
	bh=QitYUOa5hzFGpdv5n4wqmr5lh5JEpHpUcevnVR00OEI=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=gXUPZJpzSJNftDFZ8qi6wKfmoDHUcaTy/Bu0laVkqliIFYn9OChJEXi2koMT5Kgws
	 Z1qHseQeEWrRSVAgbdFpIjsqanT9uxq0nt283eN9Zie5WABAl+um/K0bxMp9yuheMb
	 eZJpn5DOx9eG9HlLcGPq1KakiwFVglLJKSfi6Cd2e/R5vRZS7XoyVo/hEgLAQ+ES7d
	 RUUoW5frUdwjmbY+PKb/HWTyD6FEPjGQ3VHMbTMDdruOQpRlCTcotdBAYGxSIDUmAB
	 l6Y0TolK9m1B5hq41OhY8plYfAf4rYAA5+G811Xx7oWLgWhuoWZkck1YrCUL+bXWhp
	 2uQOO1wX3aQcg==
Content-Type: multipart/mixed; boundary="===============7477303576377298078=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <1c92317f67a41ca1ea84e2cd52cd276f8e3c63be7b128b42564bbef4b427e4a6@mail.kernel.org>
In-Reply-To: <20260304070927.178464-1-wangqing7171@gmail.com>
References: <20260304070927.178464-1-wangqing7171@gmail.com>
Subject: Re: [PATCH] bpf: Fix use-after-free in __bpf_trace_run()
From: bot+bpf-ci@kernel.org
To: wangqing7171@gmail.com,ast@kernel.org,daniel@iogearbox.net,john.fastabend@gmail.com,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com,jolsa@kernel.org
Cc: bpf@vger.kernel.org,linux-kernel@vger.kernel.org,wangqing7171@gmail.com,syzbot+b4c5ad098c821bf8d8bc@syzkaller.appspotmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed,  4 Mar 2026 07:54:41 +0000 (UTC)

--===============7477303576377298078==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> Fix by calling tracepoint_synchronize_unregister() to ensure tp_probes
> is freed before allowing the link to be freed.

tracepoint_synchronize_unregister() calls synchronize_rcu_tasks_trace()
and synchronize_srcu(&tracepoint_srcu), which wait for in-flight
readers to complete. They do not ensure that call_srcu() or
call_rcu_tasks_trace() callbacks (the ones that actually kfree
tp_probes in rcu_free_old_probes()) have been invoked -- that
would require srcu_barrier()/rcu_barrier().

The fix is correct because after tracepoint_synchronize_unregister()
returns, no tracepoint callback can still be executing with a reference
to the link through the old tp_probes array. Would it be more precise
to say the synchronization ensures all in-flight tracepoint callbacks
have completed, rather than that tp_probes is freed?

> The link(struct bpf_raw_tp_link) was freed when link->link.prog.

This sentence is difficult to parse. Perhaps something like "The
link (struct bpf_raw_tp_link) was freed before accessing
link->link.prog"?

> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 274039e36465..b179e96ebf2b 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -3783,6 +3783,12 @@ static void bpf_raw_tp_link_release(struct bpf_link *link)
>
>  	bpf_probe_unregister(raw_tp->btp, raw_tp);
>  	bpf_put_raw_tracepoint(raw_tp->btp);
> +
> +	/*
> +	 * Ensure tp_probes is freed before the link. This prevents
> +	 * use-after-free in __bpf_trace_run() when a tracepoint fires.
> +	 */

Same observation as above about the commit message. The comment says
"Ensure tp_probes is freed before the link" but
tracepoint_synchronize_unregister() ensures all in-flight tracepoint
callbacks have completed, not that the tp_probes freeing callback
has run. The UAF prevention comes from readers finishing, not from
a freeing order.

Something like "Wait for all in-flight tracepoint callbacks to
complete so the link is no longer reachable through tp_probes" would
more accurately describe the guarantee.

> +	tracepoint_synchronize_unregister();
>  }


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/22659523367
--===============7477303576377298078==--
