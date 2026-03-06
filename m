Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EA3A37E2F6;
	Fri,  6 Mar 2026 10:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772793486; cv=none; b=Cw92CkgP+PXCv5usbb8BcEEryHbg9EIEImshIsOM2wmnS2lsv6K7SEZeCOgx1vxJmqeeZSYk/RxW157/1JVFtiG1IV7msV09EXCAiBO1ZhDn+1XDsUY/tvBsFGj28S5EGpsfDDbM20WpPjtY6Vtfi8GmfB2VbSmrbohixK9yJYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772793486; c=relaxed/simple;
	bh=JXQcaGq9fREW7V4MaPDiovNi/xMtD05r3fDs02EK3as=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=kCKLSEDiF5zYSJKcCvMToS9oBZnws9YPfox1f0nhJ/1QfODypuIJgkdRhjFPza0XAKmi/jcLccag+ZJsdJVPYB4/KkDNgReFJGSg6DY17iIHubcynh1lLujDaMrBQSlSd4CWxnVIemn5KrZ01RJi/liDE7oyYQSVO4VF0bfQofs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pFd3z64l; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pFd3z64l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19ED1C2BCAF;
	Fri,  6 Mar 2026 10:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772793485;
	bh=JXQcaGq9fREW7V4MaPDiovNi/xMtD05r3fDs02EK3as=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=pFd3z64lmp2CrxfWzQeXzC0qVSTEF+FvEAbfwayrpT5FR+GDKRDeoRS69g/VzNV+7
	 6PfPWUrEphNMHsCEKiYqvzxwgQvyYXVgDtq70vDPmwktAF/20FBCDscJCSPdPbM3ED
	 z48R6XzU/VsPRqDvR/6XLWYElJZxFF+Dx9WC3Hqz1guRCaEMYxoymI7d8ftwU64WWD
	 UTnphwC09Q8AeCWND6BNpiB493RbrjkPS8YVEImhtyf630kjVGZKADgOzNRwhnU2uN
	 kZUA4dy5Cd8QNwnSggUR/6nU6btRahdB3XgJS0JlbIRtkmHZxlYbTpLZOfsPYJLm+b
	 wc40I58ABbKtg==
Content-Type: multipart/mixed; boundary="===============4728792340798176958=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <48167f373db21bc7817e4e69b8be017c5c0a26bc54b8dd30206dd1b0ebc3a944@mail.kernel.org>
In-Reply-To: <20260306102329.2056216-2-xukuohai@huaweicloud.com>
References: <20260306102329.2056216-2-xukuohai@huaweicloud.com>
Subject: Re: [bpf-next v6 1/5] bpf: Move constants blinding from JIT to verifier
From: bot+bpf-ci@kernel.org
To: xukuohai@huaweicloud.com,bpf@vger.kernel.org,linux-kernel@vger.kernel.org,linux-arm-kernel@lists.infradead.org
Cc: ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,yonghong.song@linux.dev,puranjay@kernel.org,a.s.protopopov@gmail.com,list+bpf@vahedi.org,linux@armlinux.org.uk,yangtiezhu@loongson.cn,hengqi.chen@gmail.com,johan.almbladh@anyfinetworks.com,paulburton@kernel.org,hbathini@linux.ibm.com,chleroy@kernel.org,naveen@kernel.org,luke.r.nels@gmail.com,xi.wang@gmail.com,bjorn@kernel.org,pulehui@huawei.com,iii@linux.ibm.com,hca@linux.ibm.com,gor@linux.ibm.com,davem@davemloft.net,udknight@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri,  6 Mar 2026 10:38:05 +0000 (UTC)

--===============4728792340798176958==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
> index adf84962d579..c5ed9d84c3ae 100644
> --- a/arch/arm64/net/bpf_jit_comp.c
> +++ b/arch/arm64/net/bpf_jit_comp.c

[ ... ]

> @@ -2201,7 +2170,6 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
>  		if (WARN_ON(bpf_jit_binary_pack_finalize(ro_header, header))) {
>  			/* ro_header has been freed */
>  			ro_header = NULL;
> -			prog = orig_prog;
>  			goto out_off;
>  		}

With the orig_prog fallback removed, if bpf_jit_binary_pack_finalize()
fails on the extra pass, prog->bpf_func and prog->jited still hold
the values set during the first pass. At that point ro_header has been
freed, so bpf_func points to freed memory.

In jit_subprogs() the second loop checks:

    old_bpf_func = func[i]->bpf_func;
    tmp = bpf_int_jit_compile(func[i]);
    if (tmp != func[i] || func[i]->bpf_func != old_bpf_func) {

Since bpf_func is unchanged, this does not detect the failure. The
program continues with jited=1 and a stale bpf_func.

The powerpc and riscv JITs handle this correctly in the same commit:

arch/riscv/net/bpf_jit_core.c:bpf_int_jit_compile():

    if (WARN_ON(bpf_jit_binary_pack_finalize(...))) {
            jit_data->ro_header = NULL;
            prog->bpf_func = NULL;
            prog->jited = 0;
            prog->jited_len = 0;
            goto out_offset;
    }

Should the arm64 path also clear bpf_func, jited, and jited_len here
to match?

> diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
> index 3bd89f55960d..3a5cc3e88424 100644
> --- a/arch/loongarch/net/bpf_jit.c
> +++ b/arch/loongarch/net/bpf_jit.c

[ ... ]

> @@ -2041,7 +2014,6 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_prog *prog)
>  		if (WARN_ON(bpf_jit_binary_pack_finalize(ro_header, header))) {
>  			/* ro_header has been freed */
>  			ro_header = NULL;
> -			prog = orig_prog;
>  			goto out_free;
>  		}

Same issue as arm64 above. The loongarch JIT also sets prog->jited and
prog->bpf_func before finalize, and the failure path does not clear
them. Would it make sense to add the same clearing here as well?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/22758822985
--===============4728792340798176958==--
