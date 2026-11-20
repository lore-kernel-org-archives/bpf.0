Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795210141;
	b=qJBTZLig9OVNdp7jQpsF+fF7WdtjWoYih2xOXDj+tmoM7iQkSd2h0bvjHFvUhom5KLLw
	 4U1+kNvxsVCQUaBton/ug2dYLG6V2VFPa4K0oGH+pwwGw5ANfbLydDNozFbktWRib10PS
	 f/Suow2WSh2Ar2TVT4n0S90N6Xumy1G+aU//h0h/DbpFxLIPsF91F1u6PibhDbHgHTgfV
	 uoGR6XJVXENghmq3KWa4m8/Jjm0QSJOmzxF+OR7kYAyEDPexEA6EKL+cmGuOugKmRaNEY
	 BXaawIDIl1M6B3fgamHMq4qdkmzXowBACFFo9iQsab7tniGPuAuZ6PxRqezSLGEDyLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795210141;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=ZsmF8WU/Gwr4/vVYmkK05fbLVhuQFnUoXp89BYYrbJ4=;
	b=pN3GBgZq2CQGb26/x0+/TTBnFcYRaw75fHBzP6c5juJz3Gxu9RZ7F+5Km4i7dpLUm0VV
	 Ngm9hxXeenJrLcFuhwyar06Y7Bo2UP8S9479UBsfZFffCm4VlSJFgoKR0Xhf4zVOwKDy4
	 4OEDC17BFVCJGC1IdcwZI9pHlVMFoAwpYI+A/Kfvf0udShQTpyQcIU6eZyoVee+/9wgzX
	 +R10AvBRxI+kk3GoCEgYTvJHSHYp/GG0RDHRIgMwuHsr3+eULdcgjZiM5uhmtZ1QdLcat
	 NmzWkBRVVpcUbErVBOK5SYTmTAd0kk1JzrVQsEmY+RXQRUq2DTFcj5aUpS8CPbiClng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mWl94lhc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD8E3606A690
	for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 21:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mWl94lhc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFAC11F000C4;
	Fri, 20 Nov 2026 21:28:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795210141;
	bh=ZsmF8WU/Gwr4/vVYmkK05fbLVhuQFnUoXp89BYYrbJ4=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=mWl94lhck1C6E9XSkWqvNej9L7SX6W9GqemOvQUNzzgQ6NLIApgUU1XGqFW2GJ4Fv
	 ONps979e5+GlYuc2s7d90DDPWQ7wW33yxbmwlJvqSGWBn7y9I7e7Fi6Ofhve5d95i6
	 zoFDW/IyIKiPFClv8MQtw8IfYNQ+w7SqwA+CxNgMz3hDjGBB7LBWtpA6+wgCpYw0Wk
	 uRNYooczuPuQgYvKEH3K2yzP9T4oKCVlfPEt4rR8lctLJAfxvL3NH8RDOTrz6wdhtH
	 ocT+k8Ubg8iXiZKjuJ9aiA+PJe/JkJyaVD4ybnmTUmjD7JN5ONtAe83PK+P59SYHAY
	 zeri5uphlTBtg==
Content-Type: multipart/mixed; boundary="===============7297571471699603009=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <7ea7b1f2dc46b22f1926eb91c8fdffedf98ac2372ca4f67917be08976b5ea8a9@mail.kernel.org>
In-Reply-To: <20261120204959.614908-50-alexei.starovoitov@gmail.com>
References: <20261120204959.614908-50-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf-next v2 49/49] bpf, docs: Rewrite verifier.rst
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri, 20 Nov 2026 21:28:59 +0000 (UTC)

--===============7297571471699603009==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf, docs: Rewrite verifier.rst

TL;DR: Docs nit in verifier.rst: the "what stops it" column for loops omits
iterators, which the review says also end a loop without a trip count or
may_goto, so it may mislead readers.

> diff --git a/Documentation/bpf/verifier.rst b/Documentation/bpf/verifier.rst
> --- a/Documentation/bpf/verifier.rst
> +++ b/Documentation/bpf/verifier.rst

[ ... ]

> +Calls that go around
> +--------------------
> +
> +The calls of a callback and recursive calls go around like the body of a loop.
> +They use the same code: join, widen, peel.
> +
> +==================  ============================  ==============================
> +kind                header                        what stops it
> +==================  ============================  ==============================
> +loop                the target of the back edge   trip count or ``may_goto``
> +callback            the call of the helper        the helper
> +recursion           the start of the function     a check at run time
> +==================  ============================  ==============================

Is the "what stops it" entry for loop complete?  An iterator loop also
stops without a trip count or may_goto.  In kernel/bpf/flow.c,
flow_is_bound() treats the iterator's next insn like may_goto:

    if (bpf_is_may_goto_insn(insn)) { ... }
    if (!bpf_insn_is_iter_next(env, insn))
            return false;

and flow_loop_is_bounded() uses that to accept a bpf_for()/bpf_iter_* loop
with no trip count and no added may_goto.

This same document lists the iterator as its own case in the table in "The
loop must end" ("each trip takes from an iterator / an iterator has an
end"), and says "An iterator is assumed to stop its loop." in "A pass
assumes what stops a loop".

A reader comparing loops with callbacks and recursion here would conclude
that an iterator loop needs a trip count or gets may_goto.  Would something
like "trip count, iterator or ``may_goto``" fit in the 30 character column?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/44817467639
--===============7297571471699603009==--
