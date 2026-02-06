Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A503D35E521;
	Fri,  6 Feb 2026 09:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770370462; cv=none; b=hrIWEitjNFsI6jUWKb+1HllmqoIOFuFfSp4RHnbOEld6A3wlQFHJW+aU79kyfcd9An9adURzQS/pXb8+GQ1AASV9EETRIK2QQgsggNdNOGXBVGqSH+Okz8tSrbVaVF/UtI8aHIxXcF5PSm3zW3Zvmg6v16OUn5W6wCV+jfBup88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770370462; c=relaxed/simple;
	bh=JA6CmPoIRa+P+4WMETFukZkUa1BBbfwCWso9QajJInU=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=Ycc7sAY5XbtIckKMEHO2KybtnkcW7vcWCYGbVlFF95MdLP95j4AwpLDFVxClu3GKiOkO56LcUgreHLe/ts1i3w7kJt2wtpOQ/Sy3E1mUbwyBWrflQsgc677Il1FAP1LQFTo/etRaPApatGyjSeU2S+jZtU5Aea4r0ovC3yO1mvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oWt5y7lx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oWt5y7lx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E86B8C116C6;
	Fri,  6 Feb 2026 09:34:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770370462;
	bh=JA6CmPoIRa+P+4WMETFukZkUa1BBbfwCWso9QajJInU=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=oWt5y7lxTpzxI+lhH870MdxGCvkEDWjFXJ6PzFZedbbQVUfOQAeAqw5vc5Yct5K/S
	 EUUZnnTe8urFLGLPgfEUAoYFrQzmCZ3mvtl5i02Kusq9Ke9b61hV4mfS+3SaIE/9Bh
	 zEpUvj+XY4/IaQ2Yg+L7xbpPQNApKO4jzE3952BPbpeDBB03vLwEFS86UXgsMriVMx
	 eHGtkm3J1EkKLLMN18tNvPeoi4f9pNkLwi2dsjdtk45ROvQnppCcaf4Bs5XzLUKgsV
	 vwj7fHIr2Iw2QE3AyVRKiAWWkrKVAIcXo49S4UklSRYELBfyaBU5lT6jHwOIvWFy7i
	 ZgmWHg9Ci/sNg==
Content-Type: multipart/mixed; boundary="===============5088386996545532762=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <0062e81b59efb3839bd4f9a3459cc54730dbbfb9dd2f688df72d3b4669cab90e@mail.kernel.org>
In-Reply-To: <20260206090653.1336687-2-chen.dylane@linux.dev>
References: <20260206090653.1336687-2-chen.dylane@linux.dev>
Subject: Re: [PATCH bpf-next v2 2/2] bpf: Add preempt disable for bpf_get_stackid
From: bot+bpf-ci@kernel.org
To: chen.dylane@linux.dev,song@kernel.org,jolsa@kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,yonghong.song@linux.dev,john.fastabend@gmail.com,kpsingh@kernel.org,sdf@fomichev.me,haoluo@google.com
Cc: bpf@vger.kernel.org,linux-kernel@vger.kernel.org,chen.dylane@linux.dev,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri,  6 Feb 2026 09:34:21 +0000 (UTC)

--===============5088386996545532762==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/stackmap.c b/kernel/bpf/stackmap.c
> index 1b100a03ef2e..d263f851f084 100644
> --- a/kernel/bpf/stackmap.c
> +++ b/kernel/bpf/stackmap.c

[ ... ]

> @@ -280,12 +297,22 @@ static long __bpf_get_stackid(struct bpf_map *map,
>  		/* for build_id+offset, pop a bucket before slow cmp */
>  		new_bucket = (struct stack_map_bucket *)
>  			pcpu_freelist_pop(&smap->freelist);
> -		if (unlikely(!new_bucket))
> -			return -ENOMEM;
> +		if (unlikely(!new_bucket)) {
> +			ret = -ENOMEM;
> +			goto go_out;
> +		}
>  		new_bucket->nr = trace_nr;
>  		id_offs = (struct bpf_stack_build_id *)new_bucket->data;
>  		for (i = 0; i < trace_nr; i++)
>  			id_offs[i].ip = ips[i];
> +
> +		/*
> +		 * It is safe after perf callchain ips copied to bucket buffer
> +		 * to reduce the length of preempt section, we can enable preempt here.
> +		 */
> +		if (!trace_in)
> +			preempt_enable();
> +

When the stack_map_use_build_id() path falls through to insert a new entry
(neither the hash_matches early return nor the -EEXIST early return is
taken), this preempt_enable() is called here, and then the code continues
to go_out where preempt_enable() is called again.

The sequence when trace_in == NULL:

    preempt_disable()                   // entering __bpf_get_stackid
    ...
    if (!trace_in)
        preempt_enable();               // here, after copying IPs
    ...
    // fall through to insert new entry
    new_bucket->hash = hash;
    ...
    xchg(&smap->buckets[id], new_bucket);
    ...
go_out:
    if (!trace_in)
        preempt_enable();               // second enable - imbalanced

The two direct returns (return id and return -EEXIST) after the early
preempt_enable() correctly bypass go_out. However, when inserting a new
stack trace (the normal case when no exact match exists and the bucket
can be reused), the code falls through to go_out and calls preempt_enable()
a second time.

Could this cause preempt_count underflow when using BPF_F_STACK_BUILD_ID
maps with bpf_get_stackid()?

> @@ -317,31 +349,21 @@ static long __bpf_get_stackid(struct bpf_map *map,
>  	old_bucket = xchg(&smap->buckets[id], new_bucket);
>  	if (old_bucket)
>  		pcpu_freelist_push(&smap->freelist, &old_bucket->fnode);
> -	return id;
> +
> +go_out:
> +	if (!trace_in)
> +		preempt_enable();
> +	return ret;
>  }


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/21745231308

AI-authorship-score: low
AI-authorship-explanation: The commit shows typical human patterns including a control-flow bug from manual refactoring that AI would likely catch, combined with natural but slightly awkward phrasing in comments.
issues-found: 1
issue-severity-score: high
issue-severity-explanation: Preempt count underflow in the build_id path causes kernel warnings and potential system instability when inserting new stack traces.

--===============5088386996545532762==--
