Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58728393DE9;
	Fri,  5 Jun 2026 19:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780687650; cv=none; b=X2ChQl1P6cyeo2uGVtfMYTXQ1sqONiFxwRx/nzao2bXeqnOmJlvgdXfcw8oEu3s1IqS/EwsGs4ybt3hdSc5czMs3b5RP3xepYsMJE0LHT0aZlHRBxE3I728JLfsg9ddIaquVtcvkgqoIPDEFm1S9InF4YSnXHdYOmpEOkqMZcMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780687650; c=relaxed/simple;
	bh=NTlFa0ZTDuLPGDyrvIsXhCFtDpS08vadvIKAA3QWzKg=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=hhUufTbhgzR0uJMFOnpwI3hGm8rCUadw2zwmr1FzDV48z1rtS8EWOf9ikRYn+aSJXBu7VGZWa9rsjnoLBu9UZcn6xSoBY8XWLTL5w7shx6CHGRscYouHIhtIuL47a6M94O2Wj5nzcr5Vik04DeIEdwRVY5omeX9TOESrv7+2alE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nJdmh5ys; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nJdmh5ys"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B64201F00893;
	Fri,  5 Jun 2026 19:27:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780687649;
	bh=ptsXi5pbgQZESQUrTb11xEwKFOrOQPMhqTgzZwUpRNo=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=nJdmh5ys6pgTj2CQkbIxRe50qwvmJ4Qv0sotzA+jo6kUyDZVoRqo56ymn8nbdI7ue
	 AAJvCJVHj70nMeGdoV1b2kTr3F/2W9GSwJ7kq++jC4MpwcRIgDzKrf8FQh0CoB0Gtq
	 CNd9sxE95xL3kZ3GytYcYWQC2UF9k339uaR2qELOxjeX+YKiPrTgIxXxcVpIiRwqBC
	 8nLOOftwTEJvVAKt8p0tb0U/+o2IWo04eb7Z4XEwga6g62LxA8Uz8RDlFjbZcz/bd+
	 8I64Rvfv8vFtGbILCD2dEWGEyvsXTjvu/CJWCwMMcWucT6+PQ9AHkgzLRwBlUmp9mT
	 0V1WXFUhJ/eeQ==
Content-Type: multipart/mixed; boundary="===============5669308334960504351=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <5bc665c5db9a7007304ff3a428a05712c818dd9909feefa9cf72c1b30909ee66@mail.kernel.org>
In-Reply-To: <20260605183551.969144-4-ameryhung@gmail.com>
References: <20260605183551.969144-4-ameryhung@gmail.com>
Subject: Re: [PATCH bpf-next v2 3/5] bpf: Compare parent_id in refsafe() for REF_TYPE_PTR
From: bot+bpf-ci@kernel.org
To: ameryhung@gmail.com,bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,alexei.starovoitov@gmail.com,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,memxor@gmail.com,martin.lau@kernel.org,mykyta.yatsenko5@gmail.com,ameryhung@gmail.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri,  5 Jun 2026 19:27:28 +0000 (UTC)

--===============5669308334960504351==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/states.c b/kernel/bpf/states.c
> index 5945956a7573..06d9ae24f006 100644
> --- a/kernel/bpf/states.c
> +++ b/kernel/bpf/states.c
> @@ -890,6 +890,9 @@ static bool refsafe(struct bpf_verifier_state *old, struct bpf_verifier_state *c
>  			return false;
>  		switch (old->refs[i].type) {
>  		case REF_TYPE_PTR:
> +			if (!check_ids(old->refs[i].parent_id, cur->refs[i].parent_id, idmap))
> +				return false;
> +			break;
>  		case REF_TYPE_IRQ:
>  			break;
>  		case REF_TYPE_LOCK:

This change now feeds parent_id values through check_ids() in addition to
register and stack slot ids.

In the v1 discussion, Eduard Zingerman noted that since not all ids
correspond to register or stack slots anymore, the WARN_ON_ONCE(1) in
check_ids() on idmap exhaustion should be removed:

kernel/bpf/states.c:check_ids() {
	...
	/* Reached the end of known mappings; haven't seen this id before */
	if (idmap->cnt < BPF_ID_MAP_SIZE) {
		map[idmap->cnt].old = old_id;
		map[idmap->cnt].cur = cur_id;
		idmap->cnt++;
		return true;
	}

	/* We ran out of idmap slots, which should be impossible */
	WARN_ON_ONCE(1);
	return false;
}

The concern raised by the CI and Sashiko bots was that a BPF program
leaking many references could exhaust BPF_ID_MAP_SIZE and trigger this
warning, which under panic_on_warn becomes a denial of service. Returning
false on exhaustion was agreed to be acceptable; only the warning was
questioned.

The reply on the thread acknowledged this ("Ack. I will drop
WARN_ON_ONCE(1)."), but the WARN_ON_ONCE(1) is still present in this commit.

Was the WARN_ON_ONCE(1) removal intended for a separate patch in the
series, or should it be folded in here?

Reference:
https://lore.kernel.org/bpf/6d86c2fae9be63eb110ebd5b3fc19bc4cf1de2dc.camel@gmail.com/


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/27034008594
--===============5669308334960504351==--
