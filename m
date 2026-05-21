Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29ABA32B136;
	Thu, 21 May 2026 13:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779369971; cv=none; b=j1LUER196LW8+Qz1W8O4b3ttABJUx87enapfZo3Ez9fXyI8bOSQmizEa28gRVGAPbttB+qyfnfNQb5rLy66lEZMZ0hvR+wOri3MfGufYxsqhhi0DmY4ULwvhEZIfaB4TOxepGyvkfFJVSYGmxIyaa4i6vQZG00J10r1JefdYzh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779369971; c=relaxed/simple;
	bh=boWHHDNZrzUt9/YvRFT/htO+rg96jFT3QLLH7stV8rA=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=LJPPHxbGp2Dp9t52K+/UGJzNGzSEuxStKtasMd0gUDe3GPlly6upezjHSR/vcHw0cWr0Kj/UsyHDudvm7hHmCF2S3JD3fxoKUDT8S2BJ2717jhSDYSAeG6vAUyuA4Rf7JfWSiBdheJLyKIdaK0kD2Aeq+YriNsqBfkFBTtlu22Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hgvp3Whs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hgvp3Whs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ECB61F00A3B;
	Thu, 21 May 2026 13:26:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779369969;
	bh=OrSTfPrupUXd4HlQE+e05hsT65BiURAkoptdwWKbr1Q=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=hgvp3Whsrb06bkicRClq2+hZ2PejetG4ur+dmEfBxTKAYj/ftVLg+ojjIKVT5QFDT
	 DOI2/xgSMhfeAq8lJjZt+zdoUt5HiGWcSZcWtJfbyZANC3Gw1MmrmfxPK19XDhQnbo
	 GiYCsaFn+QRMeGDRaUpz9DGzeuusod/LiJ0B9i1BeWHMLGAdG/uKpbw+7zyrmuxItb
	 7All4Ka8K09pTiGYAaeBdH6K8XVgQ8IGY09jHQwJRSok/MhrKYdb7Etdf9j+LXSalI
	 V1oqihslaqCydNhDePFwXOCEitjTkOkD4hTojlb4bQoFvWNC6Q64uyzzXsWDD+FT75
	 2+/wUVwMJTNug==
Content-Type: multipart/mixed; boundary="===============5276235093912153004=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <8861cc7af8e0dfff2674ca4ae6381ea2d82c242dec115774e8e11048bde358c4@mail.kernel.org>
In-Reply-To: <20260521124411.31133-3-jolsa@kernel.org>
References: <20260521124411.31133-3-jolsa@kernel.org>
Subject: Re: [PATCHv3 02/12] uprobes/x86: Remove struct uprobe_trampoline object
From: bot+bpf-ci@kernel.org
To: jolsa@kernel.org,oleg@redhat.com,peterz@infradead.org,mingo@kernel.org,mhiramat@kernel.org,andrii@kernel.org
Cc: bpf@vger.kernel.org,linux-trace-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu, 21 May 2026 13:26:09 +0000 (UTC)

--===============5276235093912153004==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> commit 35d93b034b144060a547b507cfb4268692c328c2
> Author: Jiri Olsa <jolsa@kernel.org>
> Date:   Thu May 21 14:44:01 2026 +0200
>
>     uprobes/x86: Remove struct uprobe_trampoline object
>
>     Removing struct uprobe_trampoline object and it's tracking code,
>     because it's not needed. We can do same thing directly on top of
>     struct vm_area_struct objects.
>
>     This makes the code simpler and allows easy propagation of the
>     trampoline vma object into child process in following change.
>
>     Note the original code called destroy_uprobe_trampoline if the
>     optimiation failed, but it only freed the struct uprobe_trampoline
>     object, not the vma.
>
>     Signed-off-by: Jiri Olsa <jolsa@kernel.org>

This looks like a bug fix for a VMA resource leak. The commit message
notes that when uprobe optimization failed, the original code only freed
the struct uprobe_trampoline object but leaked the VMA created by
_install_special_mapping. Should this include:

  Fixes: ba2bfc97b462 ("uprobes/x86: Add support to optimize uprobes")


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/26227520868
--===============5276235093912153004==--
