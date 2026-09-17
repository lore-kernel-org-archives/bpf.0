Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E41714A3410;
	Thu, 17 Sep 2026 21:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789680851; cv=none; b=T18WXsYSVrcfgvA3pabiUswfOYr2RB7HrPoH4cfCq4ib4Y6dEpiLeqhc+sAXHyIH82xqbEm/cbtEop6yg0JX37ZrT44IsRiJ9UCmUR+bZc691E2yEgWw+w58XNKvfR561llnpzZ9EFzwJJQobgaFi5wNicyxMAkrRhTKkuWI3lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789680851; c=relaxed/simple;
	bh=k/WFQ3izEnFf43Qr4G8hTdWv4tQPawH15Q/i08870dw=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=Er3iBz/S+7YXgwFbuOZBfGNy5/yRZrx1CaEkXYHETk13vtkCceII+G5KuptwxSR5DqQHWwuXPPD+aE+Gjxhrnz54LJAwCxLknHgHCVeJBekFQUtHjlxNKM6yGF79fdoiOOIdrgUUY3Wrql4Qr2hoATkrKUE2D7O8Eo0C5/emdRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K8JNH0e+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K8JNH0e+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8392D1F00898;
	Thu, 17 Sep 2026 21:34:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789680849;
	bh=oGC4JNezDM8h0rEdR/+NiZVG2UcomK88jC0LQvyiwAA=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=K8JNH0e+IEF6aODg+xVJNIoktwsUurn+epSYzR2hr3q93e5NuS8qhdGz4E1OY7RPH
	 Krbl51d8EDnU18YFyvM5BYL2SJ8ssedIQqUXBu+tH/RRFHVCF2kXOgmNfJL+DupYg5
	 fsZ09b/M3DL6Wd8krGP8bqG1Nst0aiukXC7tABOC2QDU/B+/HMon20dQVRdRhUmmHm
	 HTZesETGq21OSsFkIFOZZWhWV0wT4FBoiTpPBQ0JA7fn2TE/W9YqER5ZdHh62+ok4I
	 zWKWZCRW8ao/SkolonVzp6xv174t+aNVHamp5GSeOAExkOBJyGbDBf9YVDL4ySFXiW
	 +2ITk1cK6zIIQ==
Content-Type: multipart/mixed; boundary="===============1818403298972275107=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <ec00a1c9972f8bf493c2bb4b9d817d88169eaf23a870bc087a50ad110a11b469@mail.kernel.org>
In-Reply-To: <20260917200542.3689605-3-ameryhung@gmail.com>
References: <20260917200542.3689605-3-ameryhung@gmail.com>
Subject: Re: [PATCH bpf-next v4 02/15] bpf: Make struct_ops tasks_rcu grace period optional
From: bot+bpf-ci@kernel.org
To: ameryhung@gmail.com,bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,alexei.starovoitov@gmail.com,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,memxor@gmail.com,martin.lau@kernel.org,shakeel.butt@linux.dev,roman.gushchin@linux.dev,kuniyu@google.com,kerneljasonxing@gmail.com,ameryhung@gmail.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Thu, 17 Sep 2026 21:34:08 +0000 (UTC)

--===============1818403298972275107==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/net/ipv4/bpf_tcp_ca.c b/net/ipv4/bpf_tcp_ca.c
> index 791e15063237c..e224ecafbd699 100644
> --- a/net/ipv4/bpf_tcp_ca.c
> +++ b/net/ipv4/bpf_tcp_ca.c
> @@ -339,6 +339,22 @@ static struct bpf_struct_ops bpf_tcp_congestion_ops = {
>  	.validate = bpf_tcp_ca_validate,
>  	.name = "tcp_congestion_ops",
>  	.cfi_stubs = &__bpf_ops_tcp_congestion_ops,
> +	/* The struct_ops's function may switch to another struct_ops.
> +	 *
> +	 * For example, bpf_tcp_cc_x->init() may switch to
> +	 * another tcp_cc_y by calling
> +	 * setsockopt(TCP_CONGESTION, "tcp_cc_y").
> +	 * During the switch,  bpf_struct_ops_put(tcp_cc_x) is called
> +	 * and its refcount may reach 0 which then free its
> +	 * trampoline image while tcp_cc_x is still running.
> +	 *
> +	 * A vanilla rcu gp is to wait for all bpf-tcp-cc prog
> +	 * to finish. bpf-tcp-cc prog is non sleepable.
> +	 * A rcu_tasks gp is to wait for the last few insn
> +	 * in the tramopline image to finish before releasing
> +	 * the trampoline image.
> +	 */
> +	.free_after_tasks_rcu_gp = true,
>  	.owner = THIS_MODULE,
>  };

This isn't a bug, but now that this comment lives next to
.free_after_tasks_rcu_gp rather than next to the synchronize_rcu_mult()
call, would it help to say where the vanilla rcu gp it mentions actually
comes from? The comment talks about both grace periods, but in this new
location it only annotates the tasks RCU flag. A reader might wonder
where bpf_tcp_congestion_ops gets its vanilla grace period (it comes
from bpf_map_put()'s call_rcu() via map->free_after_rcu_gp).


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/35271288839
--===============1818403298972275107==--
