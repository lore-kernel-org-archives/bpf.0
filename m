Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83BBA395ADE;
	Tue, 23 Jun 2026 18:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782238419; cv=none; b=sfuWdVBIlhqje4FQLcDFJgEEXj36mfmVM5JLBxYnefOKlkFfJf4xx2keviRzZG5HNQdUEbzb23BOC9r99WM5x9SMtmSQjBGU7dsZ02manwCkwPCN8iG9lthiIpvf+oKoP+fx9A68j2UDxX03vYuISKSkMYV0Hhyy/R6XPbgGHt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782238419; c=relaxed/simple;
	bh=2BYU39LdGXzbenZgXp/y0l1HaIUy+XRfN9J4cOzJJkE=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=eBBnn2tWgF0clIqEPfSGwbO2HLoClF6Fd5OdsEN8a0zBWD4HjyDYytXeHSHCJ7383XRjxdRaK+E4QcbK+ovK8yUSbpLUAfsIUcI+YmExpnFmJOiHjp3m7oVpOaxI8kYOS/Q6e8Y1uGYXH6Cnd5VvnSWbN9QEOS+xR4dKArRje6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nkFCth7c; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nkFCth7c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C89721F000E9;
	Tue, 23 Jun 2026 18:13:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782238418;
	bh=2BYU39LdGXzbenZgXp/y0l1HaIUy+XRfN9J4cOzJJkE=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=nkFCth7c+aqnmLnj6u5OA9T3Id184hzHteyLNSWFRBKEIWEKnwVgWEwMAyKSM4RJN
	 m9IBYIdceGQzEp0fNWx0P9jeGEo6TGxg10J8u62ecb42m0B04ira5BPdT/3ArP9/kA
	 UUhctaugfEF75meeM+dgSxb5Fus1xB9vQ/XezZVnRMC7jhTchenf8IEofcHVL7+tZS
	 g97EscZHJoUAInlBm7h3X5fwRSZ9MTbnQyNrgW1Ur6RTnZQzLUB0l0ewAO3AktuUr/
	 wP8jwpbGZ+GkhBg73OgTyk2+FJuFj7G2SX6RWO4P7NG9ee99kzRnQDDI6dU2UzvidD
	 PUCQZki7i+w7Q==
Content-Type: multipart/mixed; boundary="===============1340697840049190165=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <a3c35deadc171002028e32736cb695c35656e9adaa353bd6268316f66a5f7bec@mail.kernel.org>
In-Reply-To: <20260622-vmscape-bhb-v12-11-76cbda0ae3e5@linux.intel.com>
References: <20260622-vmscape-bhb-v12-11-76cbda0ae3e5@linux.intel.com>
Subject: Re: [PATCH v12 11/12] x86/vmscape: Resolve conflict between attack-vectors and vmscape=force
From: bot+bpf-ci@kernel.org
To: pawan.kumar.gupta@linux.intel.com,x86@kernel.org,jon@nutanix.com,nik.borisov@suse.com,hpa@zytor.com,jpoimboe@kernel.org,david.kaplan@amd.com,seanjc@google.com,bp@alien8.de,dave.hansen@linux.intel.com,peterz@infradead.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,kpsingh@kernel.org,jolsa@kernel.org,davem@davemloft.net,david.laight.linux@gmail.com,luto@kernel.org,tglx@kernel.org,mingo@redhat.com,dsahern@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,song@kernel.org,yonghong.song@linux.dev,john.fastabend@gmail.com,sdf@fomichev.me,haoluo@google.com,pbonzini@redhat.com,corbet@lwn.net,jbaron@akamai.com,aliceryhl@google.com,rostedt@goodmis.org,ardb@kernel.org,skhan@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,kvm@vger.kernel.org,asit.k.mallick@intel.com,tao1.zhang@intel.com,bpf@vger.kernel.org,netdev@vger.kernel.org,linux-doc@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue, 23 Jun 2026 18:13:37 +0000 (UTC)

--===============1340697840049190165==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> x86/vmscape: Resolve conflict between attack-vectors and vmscape=force
>
> vmscape=force option currently defaults to AUTO mitigation. This lets
> attack-vector controls to override the vmscape mitigation. Preventing the
> user from being able to force VMSCAPE mitigation.
>
> When vmscape mitigation is forced, allow it be deployed irrespective of
> attack vectors. Introduce VMSCAPE_MITIGATION_ON that wins over
> attack-vector controls.
>
> Tested-by: Jon Kohler <jon@nutanix.com>
> Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
> Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>

This appears to fix a behavioral bug where vmscape=force mapped to
VMSCAPE_MITIGATION_AUTO, which is gated by should_mitigate_vuln(), so
attack-vector controls could override a user-forced mitigation.

Should this carry a Fixes: tag?

The force -> VMSCAPE_MITIGATION_AUTO mapping that allowed the override
predates this series. The earlier refactor 68d94c61c09a ("x86/vmscape:
Move mitigation selection to a switch()") only moved the logic into a
switch() and did not introduce the conflict, so it does not look like the
right Fixes: target. A precise commit to point at could not be confirmed
from this tree.

---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/28046221590
--===============1340697840049190165==--
