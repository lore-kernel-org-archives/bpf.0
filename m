Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B922495537;
	Tue,  9 Jun 2026 15:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781018919; cv=none; b=gGymeWumkpixc1OyH+tOYPmkWH95jJP4fMPy5icbZnuKb8ahxkz994guYBRPZg9MrVDiFdLjF+i4hiTa18fF/lxGSxyuQIDF/1CjGyQiiTMhuetDZBP+rjWOeG4dCNbYLOaBAkS0X1XfCzcBKf/aeYiTbpzqDSHczqsY/w76fy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781018919; c=relaxed/simple;
	bh=r4dOWXNNvuf8DRRHkfZL18gR3qJn+6PnEAP2O5Cul5c=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=DFkyHd6603FVgXMWvUEM1bU55GwobPayEppR0AaYmDWNguKuS4k4HjgQZScXNODN+vXfMtxBwAquiugu9B9Dqs4/gLs7gvaAXqYzZBEF4tOIGo1UPcM7mz4ASIgrgotqc2OqOO6t9QZbnWgHswzZCy6UtY1RjOkgNJagGV+KnLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V6Oifqkw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V6Oifqkw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81C2A1F00893;
	Tue,  9 Jun 2026 15:28:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781018918;
	bh=ddZOQzePBcTzXM9ICrRTTs2ZyCVDUIbNbEGt5eqAoS4=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=V6OifqkwVk9RRfnI7MU2ApO1r7mIZR82RtRZIAJKtlAnalcqOehXYmKpYH7p199ls
	 +EwcDmEp8hh0T2xCdzRE2Aaw3pGyEvGP0BpRzxi73M6XbSXrilziITpfN8ZpZaOugB
	 jr+/SAuLUVcjQGPe22qiE3Y4JGylcYLwdQD0u+SUD+xeF3knb/DuJlcFpbQfo2oITL
	 kkyhNs3t3+14S7coKP8A4VGBVpWo2KuijITJ2HJcSM4DUYFCMo8EKNU6Aif5hyKXBU
	 C6bnrOaVoIlQ1blgWZ8JMg3NtrGoP2PmP8lYmDwAXJRsBYBokN4RtVISsgkRKIPMhG
	 olDDVNUxkeAnA==
Content-Type: multipart/mixed; boundary="===============3917869089422927326=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <02594c1325f00e261f97f6f75a742a93cfdfc2272afa2a7ac98eba07e4ca4684@mail.kernel.org>
In-Reply-To: <20260609-f01-03-scalar-add-bpf-next-v1-1-e6212e274155@mails.tsinghua.edu.cn>
References: <20260609-f01-03-scalar-add-bpf-next-v1-1-e6212e274155@mails.tsinghua.edu.cn>
Subject: Re: [PATCH bpf-next 1/2] bpf: Reject scalar addition from untrusted memory
From: bot+bpf-ci@kernel.org
To: gnq25@mails.tsinghua.edu.cn,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org
Cc: eddyz87@gmail.com,memxor@gmail.com,john.fastabend@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,shuah@kernel.org,bpf@vger.kernel.org,linux-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,gnq25@mails.tsinghua.edu.cn,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue,  9 Jun 2026 15:28:37 +0000 (UTC)

--===============3917869089422927326==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index ed7ba0e6a9ce..514322aca6ed 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -14758,6 +14758,14 @@ static int adjust_reg_min_max_vals(struct bpf_verifier_env *env,
>  				 * This is legal, but we have to reverse our
>  				 * src/dest handling in computing the range
>  				 */
> +				if (opcode == BPF_ADD &&
> +				    base_type(src_reg->type) == PTR_TO_MEM &&
> +				    (src_reg->type & PTR_UNTRUSTED)) {
> +					verbose(env, "R%d tried to add from %s to scalar\n",
> +						insn->dst_reg,
> +						reg_type_str(env, src_reg->type));
> +					return -EACCES;
> +				}

The patch only prevents scalar += untrusted_ptr (BPF_ADD) but fails to
reject other ALU operations like BPF_SUB, BPF_XOR, and BPF_MUL. This
allows attackers to trivially bypass the new check by using operations
like scalar -= untrusted_ptr or scalar ^= untrusted_ptr.

When an attacker uses these alternative operations, the code will:

1. Bypass the new BPF_ADD check added by this patch
2. Call adjust_ptr_min_max_vals() with the untrusted pointer
3. Hit the early return for untrusted PTR_TO_MEM in
   adjust_ptr_min_max_vals()
4. Return success without updating the scalar's verifier state

This creates the same verifier state desynchronization vulnerability that
the patch was meant to fix. The scalar register's tracked bounds remain
stale while its actual runtime value has been manipulated by the pointer
value.

Can this verifier state desynchronization be leveraged to achieve
out-of-bounds access?

This concern was raised by sashiko-bot@kernel.org in the v1 review:
https://lore.kernel.org/bpf/20260609151019.678141F00893@smtp.kernel.org/

The author has not responded to this concern.

>  				err = mark_chain_precision(env, insn->dst_reg);
>  				if (err)
>  					return err;


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/27215521040
--===============3917869089422927326==--
