Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4624D39D6FA;
	Wed,  2 Sep 2026 09:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788342768; cv=none; b=Pg57kcXngGyS1bNawiNrY9nsu4R0I3QwsQofJ+yyqwImxkOJ2uZOgEpGKKhsrNujVTQPVntTV/abyJWFTflbvm8zuH9uAyJmpDczVekjpuVvF+Bfa2HCDbzueMASpboGCUKZ/H5shfkmEZMOMZ3rBm1Ve/EmbtBe6BvJbfEu/Ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788342768; c=relaxed/simple;
	bh=4AfJ18AV6GBXUnVRHnLPSGQiIB9Q9q+xfCZ7qHgNZRg=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=NK67bZHwzjgzln1W7fi4pM0EGOfPKGwtyLpb/UkZHSCs91MZUhaGzf2wFM02RHJJOsar1rMxT0Y6zcUqDc2jvpSRVmTuDHr2jQv6LKSjO99oaWjZ3D5OsCpKGezpkbB90LngaShZgPQyI6GIpIOFriv/PCvtcvXLPTm9t9kMqyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K3r8/HWr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K3r8/HWr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECA6B1F000E9;
	Wed,  2 Sep 2026 09:52:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788342766;
	bh=/xj3Ixi1TMtvXOywwex226RRsIdVIK4kUSLfMCveMPU=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=K3r8/HWr/pKEHD3m/ZMuP/71c/Ll+9nwvrzDkFqbYnCOGuEl4dt44kobph/m2pN70
	 7rFqFvMVeKcyLBn0ZS7o0kpbrF/bf3sHN4EVu9gfVn6n7cuoEnVw49qZn9h3iZXjlJ
	 zjipszXr8gvu8XFz4Ks5/Cadv02po4qUzvizFrToLcqJRurz2j2EcqQQxruVgO58hS
	 kbOmC1Mklf4bs50dUcZlmQsHEo08wJI6c5Ru9tSIZuCAAFOy6lWydekHQrJ1icdlXA
	 TJb/d556FahXEXO13GNUtdON6GbcFOU3XaiRxyPNVAEpWHh7hMMWHZ5qjtjg+mbOVF
	 s0rUkQA4XcAGw==
Content-Type: multipart/mixed; boundary="===============8561549741085370300=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <bb0be5fe0febe96dd7a31501655a1b27bca3035b2c95a80b5f46fd0134e0ffa4@mail.kernel.org>
In-Reply-To: <20260902090220.16395-1-liujing@cmss.chinamobile.com>
References: <20260902090220.16395-1-liujing@cmss.chinamobile.com>
Subject: Re: [PATCH] bpf: cgroup: fix null-ptr-deref in __cgroup_bpf_attach
From: bot+bpf-ci@kernel.org
To: liujing@cmss.chinamobile.com,ast@kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,bpf@vger.kernel.org,linux-kernel@vger.kernel.org,liujing@cmss.chinamobile.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Wed,  2 Sep 2026 09:52:45 +0000 (UTC)

--===============8561549741085370300==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

>     bpf: cgroup: fix null-ptr-deref in __cgroup_bpf_attach
>
>     In __cgroup_bpf_attach(), the expression "prog ? : link->link.prog"
>     dereferences link before validating that link is non-NULL. If both
>     prog and link are NULL (a contract violation by the caller), this
>     causes a null pointer dereference.
>
>     Add a safe ternary fallback and a NULL check for new_prog before
>     it is used further.
>
>     Signed-off-by: Liu Jing <liujing@cmss.chinamobile.com>

This looks like a bug fix. Should this include:

  Fixes: af6eea57437a ("bpf: Implement bpf_link-based cgroup BPF program attachment")


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/33613365877
--===============8561549741085370300==--
