Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE11D1F936
	for <bpf@vger.kernel.org>; Sun,  1 Feb 2026 03:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769915754; cv=none; b=ScTGYoG09hCY2+2u9GQ9fkd4bTt8g1ENM1WzUK9k7N+ND7XAyklvM31u/IvlbPBYBgZSI5G083zacsYfEqQajEVwjNxN9+bPe9qDCFIAV43M7seiehvuQBP1aFzOR/B8O/K5/NukQRlVN70a5KVzdBFjQ7+VNF76ZnoKilOC92Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769915754; c=relaxed/simple;
	bh=SCBGLgb6nkXGnqNCEtz0u54CdEpkAPMZs0d7rO1mEFg=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=Ko/LS8AXOY/sS8TGmUl4w+H1eKgKKKomp7k1KoSK9uzgwVARFM5MgNfXhw+1aPSzlJOAPXO+IZE08B1c7CZ4pIJx7qGxX1i8/haGfQoBAp/rqi5b65F4knuvcaG82egQ8nLaqOxHDC1c5LOfq9vTFiRxeRrfNYxvB+s1YMESBPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rYnQulqU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rYnQulqU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24C89C4CEF7;
	Sun,  1 Feb 2026 03:15:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769915754;
	bh=SCBGLgb6nkXGnqNCEtz0u54CdEpkAPMZs0d7rO1mEFg=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=rYnQulqUa2tLzTmEOhDKpn7wmncMNGLG5Ia2uwnTzeeFy8yxVuJ2jdXI5uWvbE/hl
	 02tIZK27+JehIhmtuUexDX9tEmDy0ocEhWCyuh3SarqgQ/B88MWj/Htrbv2sUPitx7
	 2vqKb7miSNKeEUfrEXOpGpu8oXmOQjNPli7vRLA+buMfJYeqc3/Vyj0sLZ1GEf+cEd
	 NYoUaUzheumgfgo+t2Ik/wQsfMNDW+okZKvorGf7+iTimJ4MCzAFeSOG7Bfw5oxuzw
	 Mx9PAyi7VBwDc97PBuehZTN25ySfCeEdjBOpR/u1imnV+WZ6+y8eMzQzz5iuAMWVUL
	 Jmb6iBNGkgrAg==
Content-Type: multipart/mixed; boundary="===============4001247480762516691=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <16a6a06db16da1842bbad2a50f2cdecb6b71343c3b7b4c0e329794f8170cc890@mail.kernel.org>
In-Reply-To: <20260201025403.66625-3-alexei.starovoitov@gmail.com>
References: <20260201025403.66625-3-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH v9 bpf-next 2/9] bpf: Add verifier support for bpf_timer argument in kfuncs
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,martin.lau@kernel.org,memxor@gmail.com,mykyta.yatsenko5@gmail.com,kernel-team@fb.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sun,  1 Feb 2026 03:15:54 +0000 (UTC)

--===============4001247480762516691==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 6b62b6d57..9b1853fec 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -21294,20 +21327,6 @@ static int check_map_prog_compatibility(struct bpf_verifier_env *env,
>  		}
>  	}
>
> -	if (btf_record_has_field(map->record, BPF_TIMER)) {
> -		if (is_tracing_prog_type(prog_type)) {
> -			verbose(env, "tracing progs cannot use bpf_timer yet\n");
> -			return -EINVAL;
> -		}
> -	}
> -
> -	if (btf_record_has_field(map->record, BPF_WORKQUEUE)) {
> -		if (is_tracing_prog_type(prog_type)) {
> -			verbose(env, "tracing progs cannot use bpf_wq yet\n");
> -			return -EINVAL;
> -		}
> -	}

The commit message describes adding kfunc timer argument support, but doesn't
mention this removal of restrictions that previously prevented tracing programs
(kprobe, fentry, fexit, etc.) from using bpf_timer and bpf_wq.

This appears related to the previous commit fac023087 ("bpf: Enable bpf_timer
and bpf_wq in any context") which made the runtime changes necessary for this.
Should the commit message mention that this change also enables tracing
programs to use timers and workqueues, or would it be clearer as a separate
commit?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/21555452257

AI-authorship-score: low
AI-authorship-explanation: The code follows established kernel patterns exactly and shows familiarity with the BPF verifier codebase, consistent with human-written kernel code from a known BPF contributor.
issues-found: 1
issue-severity-score: low
issue-severity-explanation: The commit message doesn't mention the removal of tracing program restrictions for bpf_timer and bpf_wq, which is a documentation completeness issue rather than a functional bug.

--===============4001247480762516691==--
