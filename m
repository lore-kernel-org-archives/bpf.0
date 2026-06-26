Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D16E42E738B
	for <bpf@vger.kernel.org>; Fri, 26 Jun 2026 02:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782439291; cv=none; b=s49rsaqnocTXs5oalB5K1pVXQNtQFV9ngP+H+xGquKLxccocsUqIQJQTCZvrGQsVe8Y1Xsnw+SnHpk3qrb5Pm/25jif5rZK2eBG//mzYm8J+zzs9Sk92uraxCUQIPY7LIJJpNo5rKxILMcDstPrnKUgOjaXcjzyWOyIYs8C2MXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782439291; c=relaxed/simple;
	bh=wrVmTU1ZigHznKyclXmJnFLi+sZJMfGWdaYZFc6uWKo=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=R66a1IzItwwX//wHCVUZ5SWrcklaM1sHSooog1/NByCIrK9ldf30QQ/PE9+BC/HjK7IUqJGEtfAeGBJ50RlsyvfxMcMO57yibk8kvlordIYN+Z9ZN+SEXyDYRfxlAR3BGjzZd3hUugqLs39MpTKiH3G7yVnjR2LMlmS5mRu/6hY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mu94uNPC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mu94uNPC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42DCC1F000E9;
	Fri, 26 Jun 2026 02:01:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782439288;
	bh=DYz30RIYLEwfXD+78BC76XJjAdDthDAq7sQhKJ4PlzU=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=mu94uNPC1ld3l+ju4c6uPIItBTEo1Uw8svKe3QcSjQFMuGxwUx2Y8S3JxIjdxF13X
	 chK2mAz7Y4v+Y2BybW2HESSNBxubkApxtfD1w6s2O6NgFlOvWallNbHVrjxm7Pfb7j
	 2w7agDfeomJS8T19CsZK5ai8PPjjUYGMYsMvmAZnumWQOROtfziKfyEo3VUsFagDnH
	 tKRpthbgIeWOwY+67ic6tbGnfDI60JEcRpnmc0/KJofzupj/LsDO78QSW2eCDQ1LaF
	 gRxEVUxYz1LCOYEi4/whylmfsbn3QpW6QGk9AAe6G+jazviVqeqWOblEeUr78I7ui5
	 6ej1JjwksWByg==
Content-Type: multipart/mixed; boundary="===============6849824879648211741=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <a43615e61c986ef26c7094db7419f689a8692364f286fb6c6d22968ed7a89574@mail.kernel.org>
In-Reply-To: <20260624204946.2901178-1-andrii@kernel.org>
References: <20260624204946.2901178-1-andrii@kernel.org>
Subject: Re: [PATCH bpf-next] libbpf: fix -Wformat warnings from format/argument type mismatches
From: bot+bpf-ci@kernel.org
To: andrii@kernel.org,bpf@vger.kernel.org
Cc: andrii@kernel.org,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri, 26 Jun 2026 02:01:28 +0000 (UTC)

--===============6849824879648211741==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/lib/bpf/relo_core.c b/tools/lib/bpf/relo_core.c
> index 0ccc8f548cba..8652c9b53720 100644
> --- a/tools/lib/bpf/relo_core.c
> +++ b/tools/lib/bpf/relo_core.c

[ ... ]

> @@ -1159,7 +1159,7 @@ int bpf_core_patch_insn(const char *prog_name, struct bpf_insn *insn,
>  	default:
>  		pr_warn("prog '%s': relo #%d: trying to relocate unrecognized insn #%d, code:0x%x, src:0x%x, dst:0x%x, off:0x%x, imm:0x%x\n",
>  			prog_name, relo_idx, insn_idx, insn->code,
> -			insn->src_reg, insn->dst_reg, insn->off, insn->imm);
> +			(unsigned)insn->src_reg, (unsigned)insn->dst_reg, (unsigned)insn->off, (unsigned)insn->imm);

This isn't a bug, but src_reg, dst_reg, off and imm each picked up an
(unsigned) cast for their %x conversions here, while insn->code, also
printed with %x just above, was left as-is.

insn->code is a __u8 like src_reg and dst_reg, so it promotes to int and
hits the same %x/int mismatch the casts address for the others.  Was
leaving code uncast intentional, or should it get the (unsigned) cast too
for consistency within this statement?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/28211699373
--===============6849824879648211741==--
