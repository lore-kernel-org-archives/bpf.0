Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795701211;
	b=sawOA/6M2m2d63Em0HQOJve7YSj/qQSYXM64OyN353DkUUNccHC32K58ym6LIyjpMI1E
	 JF4lU2YIpeb4D8kV00THMRZp1/f+ytg5REQXz3Sq1AiOG+sNgyHeT3TlPZuVOKVcdcxpk
	 WJLqk7TmFow7EtFbx0PktW+QE7O6aAyw/84D8laG0NZIq0/J1E2B3olaCOrieuiR0fmLm
	 NORrEggRvZfytLjtF64FrBAKmaIdJnOSJiULEex7AFbmrUFH2RJg0LVkjeA6Ig1xCgaml
	 4JrLjFTjZYrbdziX/4GphEQZInBVvTdcVtKrQhmIFQiMVt0XIPBGaLj8Q5XFoGiPqwA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795701211;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=GpVMlZ3u0XvpAxaqE01/nuC49TSpbYz/Mwr26Zge8yU=;
	b=G1be6+bTE3uy9mVGt9OPWSQWpb5Ax2MUL7G0r06NqshCXUKRNtpUOFaEs3bUGDWyp5sk
	 SD3hON2YOpVKaDaGJhke6wsLeCNE4XS9c2AsfnQE8d6ikiLAHuHsig6yl8F4j1K+YcchN
	 hpT0wc9tWxJ4BFhASufpxDANWpUEl/IPh7ZW7Edpqq/8QfR4G6nAKIhyM+ml5G4QyxGLm
	 zlxizYlZ9f5Fv8qxmR2PJAZJb3h2F1A4Vjt1gbHOW6prGmALJRigRleTxTU2E0w1y8CRz
	 ZqZ3FogtuqDdJzyRg+fXpQDBFPAUCOMu5BcOELTEAsUPXnxdTZg5Ap805RId48FwRwg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Br191Wpw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 925CE606A332
	for <bpf@vger.kernel.org>; Thu, 26 Nov 2026 13:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Br191Wpw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 308AE1F000C0;
	Thu, 26 Nov 2026 13:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795701211;
	bh=GpVMlZ3u0XvpAxaqE01/nuC49TSpbYz/Mwr26Zge8yU=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=Br191Wpw073pdzGC6rCRZeXQ5KAkxFK2eVV04kg78PH6WjvEpiUDDCjc2XyyR6Erw
	 7WTpZjp3bu0mlE8e02a/0iSTqAE0rLfTpolSiB2Alj7BJUQoce9C2jZl7md3thE8ZE
	 eCQ9JIh3eomlBtLqiH2yRk1Rlww4GOaJMQu/MB6qvePwQuzAIAUy7t1D6JjnTXstiZ
	 ELF6X8nuTjYSD7DSRlKx7A/7G8X6MtT2MOMlzuMc+FYYFjAaYO/LHIQhOGNofWfiAN
	 xFvJCPMD2UYqCOR3Aghyx7hKbAKSiwJxlLDMB517uByySb4nIGVAUA4oPrZx3wc5wb
	 Oc9MRRk0DjjpQ==
Content-Type: multipart/mixed; boundary="===============0516202342950912240=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <880a53604a529d302dd4e19a7fdb370a874a33d69f381aef858da020bb47101e@mail.kernel.org>
In-Reply-To: <20261126-bpf-relax-get-next-id-v2-1-039e92757f9c@toke.dk>
References: <20261126-bpf-relax-get-next-id-v2-1-039e92757f9c@toke.dk>
Subject: Re: [PATCH bpf-next v2 1/7] bpf: Relax BPF_*_GET_NEXT_ID permission checks to CAP_BPF and bpf_token
From: bot+bpf-ci@kernel.org
To: toke@toke.dk,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,john.fastabend@gmail.com
Cc: bpf@vger.kernel.org,toke@toke.dk,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Thu, 26 Nov 2026 13:53:29 +0000 (UTC)

--===============0516202342950912240==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Relax BPF_*_GET_NEXT_ID permission checks to CAP_BPF and bpf_token

TL;DR: Documentation nit only: the CAP_BPF comment in capability.h may now be
stale, since ID iteration needs only CAP_BPF while ID-to-fd conversion still
needs CAP_SYS_ADMIN.

> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c

[ ... ]

> +	if (!bpf_token_capable(token, CAP_BPF)) {
> +		bpf_token_put(token);
>  		return -EPERM;
> +	}
> +
> +	bpf_token_put(token);

Should include/uapi/linux/capability.h be updated along with this change?
The CAP_BPF description there still says:

 * CAP_SYS_ADMIN is required to iterate system wide loaded
 * programs, maps, links, BTFs and convert their IDs to file descriptors.

After this patch, iterating the IDs needs only CAP_BPF (or a token that
delegates the command), while bpf_prog_get_fd_by_id(),
bpf_map_get_fd_by_id() and bpf_link_get_fd_by_id() still call
capable(CAP_SYS_ADMIN).  Could that sentence be split so it says
iteration needs CAP_BPF and the ID to fd conversion needs CAP_SYS_ADMIN?

No later patch in the series touches capability.h.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/45831277005
--===============0516202342950912240==--
