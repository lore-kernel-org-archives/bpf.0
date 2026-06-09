Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 518F6480352
	for <bpf@vger.kernel.org>; Tue,  9 Jun 2026 15:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781020000; cv=none; b=M2TZLEDAPCyVeqymV1TEnUUw0i/QNDkH12sIAJzWisx4eU/xBf5gk9luf5ShOc2nXZoDHrgF7VwF93fmLRBCveoN/8BRBNKkSUsR84y0pZv450ja2BJAxGmWk8FvkzeInz730lyGG81RKQTO/1t9rkZo8ACm/UgkMVRT6vd6UIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781020000; c=relaxed/simple;
	bh=k0fO5ESgu4fr/zWUhhg86e4qlN/XiTzeacdn4wJFM88=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rr8HT/yeq2E3kwDRf7a8pTJDaUNwn+Qn5WKcu/+5l6oXwTt3U/16H146O4tB+93fGsilWS/92qoqDN2QUdw5wfMjJbXVBLqHBY2E+a7cauNxJdYFFTlRMkiI579VsDZ41LCSClFEu6AGbF53DkktX8pddPqTMJ7UsWPMU39SHL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JQlzL97o; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JQlzL97o"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-490b4e1ade7so61881835e9.0
        for <bpf@vger.kernel.org>; Tue, 09 Jun 2026 08:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781019998; x=1781624798; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rNvvCk1T6YuJojqhtk2w77USVg3iyq9OYDqlkkwH58Q=;
        b=JQlzL97oScUerI2850ZFy5E1DU5nWtG0s3RR/JFyUye5wa+u/m0PJ4p/aWnGuyqN/S
         AwX5ZHrdXTwY5rG0YeXjqAUZPLoqB/o/mCHnPA51+U1k7YPOitoXB5VVKvK3yE+huscN
         msgW+1oynFJkCgpyMwRE2IFY/qt6vMUegEVQsRqlfmjsNPZaLxpXpmWAwWwhDUaICwzk
         0pqGs5DmRoCsp3pTbp/LP2VGGtWuhZt28qoBio5MPIoOCtyFhOR69nes3WvJ0mA36w/h
         CFvCkevjKhuTpLjq6zU8oif0WVSzJv+X9mFTaSK3i9TjZNnocnXy5FwB5eQLAgd1rM/U
         +/rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781019998; x=1781624798;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rNvvCk1T6YuJojqhtk2w77USVg3iyq9OYDqlkkwH58Q=;
        b=rKBR1XEIQOaPTYpBTWz+RiqmYlGtkHqFDtPnBKquvixQReBT/I3JPj49eDsUObmjH8
         fJJ5P6dLZ3cpU1LTPs+STU0yYrI4UfpDFW4zexDLUsmlBcSDmalYpa+CVmmSn/uRdNe7
         ugnwtHlWDH35mHetfAMcue8eOeVb8isCHkAxe2jwnAiButimylTG3dZha5VS7PFFa4pg
         5hSHHxto5xA1xN8iqRdWLsN77XWlRd+5AMiG3bi5v5x+Wiei0ySqNdc0/Nqy3sVovQWx
         gyO/RaN9sv1aQfpnRuPNEX+ufl9d+9q2M+acr5XlGR1rVcjhgB6HD1l7yqXd7+ITNNGe
         yHgA==
X-Gm-Message-State: AOJu0YyZ9Ms9QQjuCk9kE8wEYpBtJlUtQpzivQxnYrT1FPuX6CicgQCS
	Py2sqGBxW1A8MqrmV3eGlhxYpHonc31DnsSdo/YaymdQ2c8LSdCGSltk
X-Gm-Gg: Acq92OGUfoLF7I76eGFfkT/+zBOupEYy53/t5NvLcAdaZ6HYcOfoJFBjsG1BlnCvTdP
	ZZulYa5WgcsaWJFUKJgB/W4veQQQJuumjHwTCDkCB/aJIVQZVKqgu5U2ramvDQ3g0qQsnqgQIFl
	By2Qsn4kOxIzcUbnSivcx3x754cSNDMaUeGoLcQltXjVNouyN/o0AaESgzxGeaxb6qCf7U3wW5m
	Y0h/Eahfi42cJ99R2KyvDSR02EWnYwsX8CD07N90XHny7V/Atjm5aRnLcxF2LE/d39vDoVpE9gD
	ZE4JSeatTcOxlpLJtcSiHJk3ltUpq2108S8jT7IinCHlch+13uWT5af/fEA4SPeLYZpnF9OaZZA
	eJcQFsfVDwgbFnUXGn+cUyvS2EEk0AuSfiRzRQgdV6pz4JuaJXC7EqqwtzYoo4ptvXnm/LHCIpW
	ooay07XfHvbVXE9O6lDuixAzvYnFoxHa0Zhh7sd/ogB7Q=
X-Received: by 2002:a05:600c:34cb:b0:490:4b89:5361 with SMTP id 5b1f17b1804b1-490c25afa03mr334657215e9.7.1781019997414;
        Tue, 09 Jun 2026 08:46:37 -0700 (PDT)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc3fd502sm490484645e9.11.2026.06.09.08.46.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 08:46:36 -0700 (PDT)
Date: Tue, 9 Jun 2026 15:56:23 +0000
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>, Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next 1/2] bpf: Fix gotox target validation against CFG
Message-ID: <aig3p8QFlWv1sFqV@mail.gmail.com>
References: <20260609-f01-02-gotox-bpf-next-v1-0-b441d63a1559@mails.tsinghua.edu.cn>
 <20260609-f01-02-gotox-bpf-next-v1-1-b441d63a1559@mails.tsinghua.edu.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260609-f01-02-gotox-bpf-next-v1-1-b441d63a1559@mails.tsinghua.edu.cn>

On 26/06/09 11:03PM, Nuoqi Gui wrote:
> CFG construction records the modeled gotox target set in
> insn_aux_data->jt. It includes INSN_ARRAY maps based on whether the map
> target is in the current subprog. check_indirect_jump() later validates and
> follows the current PTR_TO_INSN register's actual INSN_ARRAY map. The
> verifier does not check that targets copied from that map match the targets
> that CFG construction modeled for this gotox instruction.
> 
> This lets one gotox instruction observe two different INSN_ARRAY maps. CFG
> can select a map whose target is in the current subprog. Another path to
> the same gotox can carry a PTR_TO_INSN value from a map whose target points
> at a different subprog. The verifier then accepts an edge absent from the
> CFG.
> 
> On x86, gotox becomes a raw indirect jump in the JIT image. Accepting a
> target not modeled by CFG can enter another subprog without a matching BPF
> call frame and crash when executed. Validation observed a GPF in
> bpf_test_run().
> 
> Fix this by requiring every target copied from the actual PTR_TO_INSN map
> to be present in the CFG jump table built for the current gotox
> instruction.
> Reject the program before pushing verifier states for any unmodeled target.
> 
> Fixes: 493d9e0d6083 ("bpf, x86: add support for indirect jumps")
> Signed-off-by: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
> ---
>  kernel/bpf/verifier.c | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
> 
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index ed7ba0e6a9ce..25fa90e731e3 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -17124,6 +17124,23 @@ static int indirect_jump_min_max_index(struct bpf_verifier_env *env,
>  	return 0;
>  }
>  
> +static bool is_cfg_indirect_jump_target(struct bpf_verifier_env *env,
> +					u32 target)
> +{
> +	struct bpf_iarray *jt = env->insn_aux_data[env->insn_idx].jt;
> +	int i;
> +
> +	if (!jt)
> +		return false;
> +
> +	for (i = 0; i < jt->cnt; i++) {
> +		if (jt->items[i] == target)
> +			return true;
> +	}
> +
> +	return false;
> +}
> +
>  /* gotox *dst_reg */
>  static int check_indirect_jump(struct bpf_verifier_env *env, struct bpf_insn *insn)
>  {
> @@ -17171,6 +17188,15 @@ static int check_indirect_jump(struct bpf_verifier_env *env, struct bpf_insn *in
>  		return -EINVAL;
>  	}
>  
> +	for (i = 0; i < n; i++) {
> +		if (!is_cfg_indirect_jump_target(env, env->gotox_tmp_buf->items[i])) {
> +			verbose(env,
> +				"gotox target %u from map id=%d is not in the CFG jump table\n",
> +				env->gotox_tmp_buf->items[i], map->id);
> +			return -EINVAL;
> +		}
> +	}

Thanks for reporting the bug.

As for the fix, would it make more sense to either record maps in
check_cfg or to re-check subfunc boundaries here?

>  	for (i = 0; i < n - 1; i++) {
>  		mark_indirect_target(env, env->gotox_tmp_buf->items[i]);
>  		other_branch = push_stack(env, env->gotox_tmp_buf->items[i],
> 
> -- 
> 2.34.1
> 
