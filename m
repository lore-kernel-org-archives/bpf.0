Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792986785;
	b=Ok+fCl0diSSzHLGpIsEZdx796aIM/p+X1+KA4mgYRbzf8iyWMmcZCUoBP/bXwnf3gnFB
	 X0GsNfZdtcT4te4U6GK0Opk5C+BE6ScxOlvQfPoMCtnvh51LMlI0H68H1LVqu5a1n56SK
	 JTDVnTPRjkaOHhbnp6k0+HAzbTFG9z2YFEO35p4LDPQIQPpJ0UrXQjHt8vyo4jWV4AP/p
	 CgWplADdQPUxiU4X8EbEsJgBTIQP30i6EyldXIwr4L1nVi87+Hwzga2tjkhwr1aWNP3yO
	 ElgGGnb0WBnTfG+xAwu5AD7ZKo4nCMMDmjA8Gxr6IffNRdoo4BpkUXf7aEQIYDxBJhQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792986785;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=NsFfu/sXKFJpsDGm6iUv6pJpvpw9JPPT7rW+0ayVxwM=;
	b=WaRR1hy4M5VaIyvqRQZA/okeUelWOH+b4B+jjGaLSBGYPAif3j6oIroJksKT/eW4YxIg
	 Opm5mFWQ4Ff0a6eA7z9S8Xg7o2IoqcYD1jLaix2nzrsLF26OTFe3/kQ1u20WJQOyS7BdA
	 ZRM4xJTywAsPi3Mpbx/vWVJrKiu7D0TIoqwNNU1QcPuWJ1C1k6u2fr07tG7AXTWMrmRQ4
	 j1bLq+OU4BnRcsuqrnO3HSDyL0UPvaDWoskXdt+Wn3/ay8Gusi+8QZt7qR+LH00XNfA+E
	 aZ4hovbeIg5NOfjrdIGMMdguY7eF4/o74UHHWqEPIhnc8vaAZ+MNRIPG+A3TNnejuhw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=izwRtOQH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD70606A31B
	for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 03:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=izwRtOQH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A64FC1F01825;
	Mon, 26 Oct 2026 03:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792986784;
	bh=NsFfu/sXKFJpsDGm6iUv6pJpvpw9JPPT7rW+0ayVxwM=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=izwRtOQHz0QyWhl15StYaRbthNFXdB5Qg4SFgW4OgXm84vc4TJ6WW1RwXSgv9H8Y7
	 ha5PL2pMMByA9r7o3WvMR8VieGZ0DEJ5FWq1CjRxxsuFYZLJxBSK5burOOu+Kl4lLu
	 g3HdWqGZ8cRCqB4p0L0y6H+DSch6BB+bMR6tfI6xBZLhpBQlDqSKt7ZQoyvOA38gNO
	 3ZmjOPiek7ocxkHfAlC7Th42hppDekHnzibruzG9+8qXa+ECK2Ls7UnY/Rm/aQFWLb
	 N17M6kHlF+Cd7Ixt5mjhn+spzStyrERta+RUtvvNHxAxNM34bJG4t8B18V+PjnKULD
	 Oq/dQEbLGq87w==
Content-Type: multipart/mixed; boundary="===============9131374652357019046=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <1c138e2dd8408e916a9f8d0aa9bf54b04e5771ce11e1c012b64b9ab04bf5d494@mail.kernel.org>
In-Reply-To: <20261026025943.404450-63-alexei.starovoitov@gmail.com>
References: <20261026025943.404450-63-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf 62/81] bpf: Remove prune points, levels of state comparison and pop_stack()
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Mon, 26 Oct 2026 03:53:04 +0000 (UTC)

--===============9131374652357019046==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Remove prune points, levels of state comparison and pop_stack()

TL;DR: Cleanup nit only: with bpf_diag_event_log_save() gone,
bpf_diag_event_log_restore() is always called with 0, leaving dead branches
and a stale comment; could it become a plain reset?

> diff --git a/kernel/bpf/diagnostics.c b/kernel/bpf/diagnostics.c
> index b5204798231d..5acc11788300 100644
> --- a/kernel/bpf/diagnostics.c
> +++ b/kernel/bpf/diagnostics.c

[ ... ]

> @@ -392,13 +392,6 @@ static u32 log_pos(const struct bpf_diag_log *log, u32 idx)
>  	return pos < log->cap ? pos : pos - log->cap;
>  }
>
> -u64 bpf_diag_event_log_save(struct bpf_verifier_env *env)
> -{
> -	struct bpf_diag *diag = env->diag;
> -
> -	return diag ? log_end(&diag->log) : 0;
> -}
> -
>  void bpf_diag_event_log_restore(struct bpf_verifier_env *env, u64 log_pos)
>  {
>  	struct bpf_diag *diag = env->diag;

This isn't a bug, but now that bpf_diag_event_log_save() is gone, the only
remaining callers of bpf_diag_event_log_restore() are in verifier.c, and both
pass 0:

	bpf_diag_event_log_restore(env, 0);

With log_pos == 0, the WARN_ON_ONCE(log_pos > end_seq) clamp cannot fire, the
"if (log_pos <= log->first_seq)" test is always true, and the final
"log->cnt = log_pos - log->first_seq;" is unreachable.

The comment above that test ("A deep abandoned path may have rotated away the
shared prefix") describes the pop_stack() restore that this patch removes.

Could bpf_diag_event_log_restore() become a plain reset without the log_pos
argument, dropping the partial-restore branch and the abandoned-path comment
along with it?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/40263142572
--===============9131374652357019046==--
