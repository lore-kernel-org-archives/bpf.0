Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A47C535E1B2
	for <bpf@vger.kernel.org>; Thu, 11 Jun 2026 10:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781173449; cv=none; b=Rc75dMOLxrEBexsuiBl9Qwn8Ak4lHTfCumfDzVqqAgOdpXH0s3Jsfz8OOuUzjV/LufY+ZC7l7pqMnRM6vMo6L66r/foUP7Ebk9DOuIOHVvsGNeiUwc3z1hxO3RE4a9IcY3xQrC+qLPiGXLWAU0aJP7m8Ug1JcTaSXEnys4ZWgP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781173449; c=relaxed/simple;
	bh=BRIhP1c5l64GL5nzREWYnxFaIeCLqtTAcpnijT42FMU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ds3BiWHBNq0YPmSE0NA4lBkCIwh9Nf28UXo1sFfJ5mHKntSkPlibpz6dpzOyW6H0LYidxUzqGHoVB/3YP3T/0Z7ZcJoP7ejOCtiROlZdYdLjkfv/ukP3oylc5IDz0JmIk3uCx6YSwulRa2fWWA0qXd2Zk1L2BfwFne3r9rkZNH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UmBpdEBE; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UmBpdEBE"
Message-ID: <aede5a4b-7325-47fc-8947-1c8307f10665@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781173434;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CJW9SRp3N9hZK79ixkB90qcmSFzNxOBqsqkfGQa+AM4=;
	b=UmBpdEBELirtlTy1TMMuDQz/Xtov9IDXlcQLgcy/00OliRPFMmSuJ4YT5v+p4RCiYZgYUy
	JE7iPtINt1CdyrvQngLuLoA3u+PACDwwXXOPkBz3C5HaLeUIQslpjwjtVDIPFr8i5Bqk3I
	ziwH7QbZ4jFlYrMjTXkR8TAQu2TCyno=
Date: Thu, 11 Jun 2026 18:23:42 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2] bpf: Fix unaligned interpreter panic on JIT
 fallback path
Content-Language: en-US
To: Tiezhu Yang <yangtiezhu@loongson.cn>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>
Cc: Puranjay Mohan <puranjay@kernel.org>, loongarch@lists.linux.dev,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260611101216.30153-1-yangtiezhu@loongson.cn>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <20260611101216.30153-1-yangtiezhu@loongson.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 11/6/26 18:12, Tiezhu Yang wrote:
[...]
> +/* Fix up helper call offsets for inlined helpers on JIT fallback path. */
> +static void bpf_fixup_fallback_inline_helpers(struct bpf_verifier_env *env, struct bpf_prog *fp)
> +{
> +	struct bpf_insn *insn = fp->insnsi;
> +	const struct bpf_func_proto *fn;
> +	int i;
> +
> +	if (!env || !env->ops->get_func_proto)
> +		return;
> +
> +	for (i = 0; i < fp->len; i++, insn++) {
> +		if (insn->code == (BPF_JMP | BPF_CALL) && insn->src_reg == 0) {

NIT: better to use bpf_helper_call() here.

Other than that, lgtm:

Acked-by: Leon Hwang <leon.hwang@linux.dev>

> [...]
