Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE97330B01;
	Mon,  8 Jun 2026 11:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780916846; cv=none; b=UNxP/iqE8B5Sqjh3dZcdm58z5C1vBqQsClDANZMpJtMTWRdXDN2KHuqXwqh5BDuICk3xh5U8wbGvMl9sfcRCpGJ/7YKNZ3xY62xkYBIgxUSbBmSxzUOuLFgEV/HXM2WxtBIRLM2qTydNjQUBYqdcZWHJFU3f9YJznm8in5CUPUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780916846; c=relaxed/simple;
	bh=2JzKXlLht8WwgD9yj++BEeDa/5KquAwShMwatn079Sk=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=Dt/t6A/jTmu2yJ7TdihEVaL8XlMvMbdtAnn2BOUlD/JOProxOnczwH49/VVhQDjHHZ+5AKVGRG+o0wu5Fy9iaQWJyfY2IyXz5tLkqUWnS2vQ6WNJZWIQtgFKiJyH0sX177Y/OwMKNdbFNP+Auamfw1lQOTBHfRmTEUJcCxQ/Xwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dBGw3Is5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dBGw3Is5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6DDF1F00893;
	Mon,  8 Jun 2026 11:07:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780916845;
	bh=2DGoeXcKtLbg8rt5fjSfRzNCiiWHdVOnkxCtyWVtAWE=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=dBGw3Is5BX7BXtGU/7LE9uNpg3swoL/O2uGE+JKd/+asUTVp/Jhow+7hcFbENNdX/
	 jon2fTS5YE84HBSpw/zxlusbMkafOLcIVIBH/kqwaoaqw7PTA4IYdW9iXDVhvptGZ5
	 WWx61pWy7ltOyf5/pc/5eXOlBEmMF/o9varkQqKBEMhSKfPXPInb3sIcLdMgTNTYEa
	 nWpC3ihgX6RUPxQTVHBKOJg4lDXgnit7O0jpngcDg9sYgWhydkBmufHf34JykOBtn6
	 E42On7goVmXTzQ2Xf5aQGIZAXh6hYOtNXLV5/946K20VdCaanqHyhcSNWDMXBlR0z1
	 CjYhzSzrCkCmA==
Content-Type: multipart/mixed; boundary="===============0807563568734763837=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <9f3df2278bfa3db163dc38d388bb060c9459f1c5eab5f42ffd67969d23e5b99f@mail.kernel.org>
In-Reply-To: <20260608103516.20643-3-yangtiezhu@loongson.cn>
References: <20260608103516.20643-3-yangtiezhu@loongson.cn>
Subject: Re: [PATCH v1 2/3] LoongArch: BPF: Inline bpf_get_current_task{_btf}() helpers
From: bot+bpf-ci@kernel.org
To: yangtiezhu@loongson.cn,chenhuacai@kernel.org,hengqi.chen@gmail.com
Cc: loongarch@lists.linux.dev,bpf@vger.kernel.org,linux-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon,  8 Jun 2026 11:07:24 +0000 (UTC)

--===============0807563568734763837==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
> index 058ffbbaad85..7967de9395ec 100644
> --- a/arch/loongarch/net/bpf_jit.c
> +++ b/arch/loongarch/net/bpf_jit.c
> @@ -1147,6 +1147,13 @@ static int build_insn(const struct bpf_insn *insn, struct jit_ctx *ctx, bool ext
>
>  	/* function call */
>  	case BPF_JMP | BPF_CALL:
> +		/* Implement helper call to bpf_get_current_task/_btf() inline */
> +		if (insn->src_reg == 0 && (insn->imm == BPF_FUNC_get_current_task ||
> +					   insn->imm == BPF_FUNC_get_current_task_btf)) {
> +			move_reg(ctx, regmap[BPF_REG_0], LOONGARCH_GPR_TP);
> +			break;
> +		}
> +

sashiko-bot raised a concern in v1 about the dependency on patch 1/3:
On 32-bit LoongArch builds, does __switch_to() add TASK_STRUCT_OFFSET
to the task pointer and store the biased pointer directly into $tp
without unbiasing it?

This patch directly reads $tp to get the task_struct pointer. If the
preceding patch (1/3) leaves a biased pointer in $tp on 32-bit builds,
wouldn't this inlined bpf_get_current_task() return an incorrect pointer
offset by TASK_STRUCT_OFFSET (2000 bytes)?

The concern originated from this review:
https://lore.kernel.org/all/20260608105329.610981F00893@smtp.kernel.org/

The original comment asked:

> Does this leave a biased task_struct pointer in the $tp register on
> 32-bit builds?
>
> Since the current macro is now directly mapped to $tp in
> arch/loongarch/include/asm/current.h:
>
> register struct task_struct *current_thread_pointer __asm__("$tp");
> #define current get_current()
>
> If a1 (next) has TASK_STRUCT_OFFSET added to it to bypass assembly
> immediate offset limitations on 32-bit builds, this move instruction
> places that biased pointer into $tp without unbiasing it before
> returning.
>
> When __switch_to() returns to C code, wouldn't evaluating the current
> macro dereference a pointer shifted by TASK_STRUCT_OFFSET (2000 bytes
> on 32-bit) and cause immediate memory corruption or kernel panics
> during context switch?

This comment does not appear to have been addressed.

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/27132522999
--===============0807563568734763837==--
