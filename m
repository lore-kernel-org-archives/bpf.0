Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46BDD37D124;
	Fri, 26 Jun 2026 21:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782508492; cv=none; b=QlNfiVmE4OE/N/yGtRr2MpMeNlJE2PPNqt/NWn9xztoCoXW/UKbWuVbzQPEvPKtioM3qQiKGwMO3E7UQFDZ/zJfyuLTFIrVl9G8tcPEgDYhMuOpxXQfBPN9T15arU66Q8zSmFIzjony8cOeSNlJqH404MODd3JyD7I38HdDfNDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782508492; c=relaxed/simple;
	bh=eg52iwAq7d9bopUm/H/1bFhrLyhHwFFRH6aGL8XZYHI=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=sjKFBEsKEZ1JCoiCDwXGYY4S6rvoofKiiFqUor3XL+UgmtLYaIeYQ5ZP/TjQNVDUWjwTQVFhGVjzExVCaMU0Jx3xIlrIFVETbCsV30oMooj4c+zIeEGi7V3k6zVAryYX19pSORUkaO22TfM6TkA6yD896dpvV2B42Ka5/y4UBok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oJhyeRc4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oJhyeRc4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 804B61F000E9;
	Fri, 26 Jun 2026 21:14:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782508491;
	bh=lbXYKsCuCUgf0KVI/EIkHjtTOP4QQd0BPQJ4Ova8GN0=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=oJhyeRc4Lx869y39oZDLx+tylyZrZ7x1Wfm4rIrbH1/MEPHYgQ7j+LemeaI/ZVoRB
	 +eeLoXyukK5xRF4ySo1uoLtEJWZndIS1Ku1iUceg+7wR80PzY00J0FJ4jtIKfoBC/F
	 m72kVTTO6SM8BFvvNLOVW3hkKKqjIiZn8IyAuRYVMOLb5CN4pVqe42DGwWgwwyQ+X5
	 e3d88OvH+P+ftBM1+ysIpmsAt4D9tFtwD1dFDoS2MKT/skskDdG0x25wOVMV2wsjdd
	 3p4wGknD8comUWBz9AhL2czwBQv0+CW9BJKQrvpu2YwjKS58PGcxP3sT0n4sr2n/rA
	 XPo4E4sGeuWCg==
Content-Type: multipart/mixed; boundary="===============5848927899764250450=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <2503796768ba9b066c1ff1591c1a2d91c30a30af45823d5739b0ed251b2472ee@mail.kernel.org>
In-Reply-To: <20260626-sockmap-lookup-udp-leak-v2-3-7e7e201c951a@rbox.co>
References: <20260626-sockmap-lookup-udp-leak-v2-3-7e7e201c951a@rbox.co>
Subject: Re: [PATCH bpf v2 3/4] selftests/bpf: Adapt sockmap update error handling
From: bot+bpf-ci@kernel.org
To: mhal@rbox.co,edumazet@google.com,kuniyu@google.com,pabeni@redhat.com,willemb@google.com,john.fastabend@gmail.com,jakub@cloudflare.com,jiayuan.chen@linux.dev,davem@davemloft.net,kuba@kernel.org,horms@kernel.org,ast@kernel.org,cong.wang@bytedance.com,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,shuah@kernel.org
Cc: netdev@vger.kernel.org,bpf@vger.kernel.org,linux-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,mhal@rbox.co,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri, 26 Jun 2026 21:14:50 +0000 (UTC)

--===============5848927899764250450==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

>     selftests/bpf: Adapt sockmap update error handling
>
>     Update sockmap_listen to accommodate the recent change in sockmap that
>     rejects unbound UDP sockets.
>
>     TCP: Reject unbound and bound (unless established or listening).
>     UDP: Accept only bound sockets.
>
>     Signed-off-by: Michal Luczaj <mhal@rbox.co>

This adjusts the test expectations that commit 0c48eefae712 ("sock_map:
Lift socket state restriction for datagram sockets") had introduced, the
per-sotype branching in test_insert_opened() along with the matching
changes in test_insert_bound() and test_ops().

The companion kernel fix 77a34848a723 ("bpf, sockmap: Reject unhashed UDP
sockets on sockmap update") already carries:

  Fixes: 0c48eefae712 ("sock_map: Lift socket state restriction for datagram sockets")

Should this selftest commit carry the same Fixes: tag?

  Fixes: 0c48eefae712 ("sock_map: Lift socket state restriction for datagram sockets")


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/28264556257
--===============5848927899764250450==--
