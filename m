Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=131.188.11.21
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795679994;
	b=X90aDhIdBVFPiaXRVO4lTNro8EwlPC1tIK3SnjtXJfpmVQtS7z1zn+Ii+dBLE3qdLWU1
	 8utB1VXx231WCBWohwtLQiTswJoFFf1aL+/Y2CJHeEuzsbGFwyJUUXNvGPw1ZMQ3AT5GC
	 mJrZJWEmue4Khzplg7rmgISV0JzT5zHiz6D47f1YnBoUvGx6RvWtBqvRzofyopoYj6aqw
	 dcCf2rIxhoF2RXVwZTxwC7lgvBZjJljTppN/brx8ehCQlFURTqGOTCDP0zJSg/QsrQP+k
	 tazNNbVXWVHIwT++wGWc7MKTFqZHueG1wY8YIRZDDeiwJtJVt1ejTMhZ4SCl4k4g6ng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795679994;
	h=DMARC-Filter:DKIM-Signature:Received:X-Virus-Scanned:X-RRZE-Flag:
	 X-RRZE-Submit-IP:Received:From:To:Cc:Subject:In-Reply-To:References:
	 User-Agent:Date:Message-ID:MIME-Version:Content-Type;
	bh=6MTO795Cjy5PFhWQ5mYpqpe2D1fvValvdydXWdyYjUg=;
	b=FY+ugVXax0phd+O8DvCm8I9TE6o6vsCdCBGacww1V1k1yoaZsHs9zFcnscuoFHUfsG0h
	 ceV22yasJ+gREggthZ09j0fipbli0nRrENs0WCTUHvS8hdkgK3dytmtxLnsPrmE6F9tEb
	 LWb4NmBq7NOzBS0TkAcTFaWyQD5aWJYOw4g/I3JXSy1Jw4lsHoihDU2ljtsGdvfedumho
	 XJFpeC+CV6nEpfzNVV6hw1mlPAmKLqsRqruAI6ev7hLkGkuKmTU8qwjAl1NLVFrQpaY9m
	 +9Mm974azPeWT73NBagaTuIjlnvlQ4o1F8l3Erg13CjSyt80FrkuC0RbOtjzk07hJUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fau.de;
	spf=pass smtp.mailfrom=fau.de;
	dkim=pass header.d=fau.de header.i=@fau.de header.a=rsa-sha256 header.s=fau-2021 header.b=bQjTauce;
	arc=none smtp.remote-ip=131.188.11.21
Received: from mx-rz-2.rrze.uni-erlangen.de (mx-rz-2.rrze.uni-erlangen.de [131.188.11.21])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 447BD606A331
	for <bpf@vger.kernel.org>; Thu, 26 Nov 2026 07:59:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 447BD606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fau.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fau.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fau.de header.i=@fau.de header.a=rsa-sha256 header.s=fau-2021 header.b=bQjTauce
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fau.de; s=fau-2021;
	t=1795679991; bh=6MTO795Cjy5PFhWQ5mYpqpe2D1fvValvdydXWdyYjUg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From:To:CC:
	 Subject;
	b=bQjTaucew0uqmkq6aHHTNpDTfclUPG82xlQES5JcrdWfDTuVzdi9DL7MELJ4oTCac
	 G2EqR88c1WaZfRNe9WYhvbizpsXOm6O9+DwRq8J3vDi52Mg+urNkI0577jNGQlC0k1
	 HpnXV78T+leQvGySF7YWav16dtj28rUgNvAnjxGYgJNANnk+YdAsDLJxNd8TdJYSih
	 w8cTCC2jrockPgQSv9Vgw26ICX36q5uQE34uv4hJ3lOy/VWMHce/Tt1i6TFQU1MH+q
	 CwWiDtvB4NFE7zmkyKqU+qQGekurKyPtgKWu4jNGxGewPHW6vFxtom9o8hour8pGWm
	 pd0K2OBDhg6vA==
Received: from mx-rz-smart.rrze.uni-erlangen.de (mx-rz-smart.rrze.uni-erlangen.de [IPv6:2001:638:a000:1025::1e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-rz-2.rrze.uni-erlangen.de (Postfix) with ESMTPS id 4jZpqW2C7FzPlfJ;
	Thu, 26 Nov 2026 08:59:51 +0100 (CET)
X-Virus-Scanned: amavisd-new at boeck2.rrze.uni-erlangen.de (RRZE)
X-RRZE-Flag: Not-Spam
X-RRZE-Submit-IP: 2001:620:618:5b8:2:80b3:0:59e
Received: from localhost (unknown [IPv6:2001:620:618:5b8:2:80b3:0:59e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: U2FsdGVkX18ieHgVZde7aKektxo4E+86qqDWIfKlEP8=)
	by smtp-auth.uni-erlangen.de (Postfix) with ESMTPSA id 4jZpqS2VtSzPkTR;
	Thu, 26 Nov 2026 08:59:48 +0100 (CET)
From: Luis Gerhorst <luis.gerhorst@fau.de>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org,  daniel@iogearbox.net,  andrii@kernel.org,
  eddyz87@gmail.com,  memxor@gmail.com
Subject: Re: [PATCH bpf v2 4/4] bpf: Emit nospec after calls and atomics
 that write to the stack
In-Reply-To: <20261126033816.4124847-5-alexei.starovoitov@gmail.com>
References: <20261126033816.4124847-1-alexei.starovoitov@gmail.com>
	<20261126033816.4124847-5-alexei.starovoitov@gmail.com>
User-Agent: mu4e 1.12.12; emacs 31.1
Date: Thu, 26 Nov 2026 08:59:46 +0100
Message-ID: <87fqwo3tvx.fsf@fau.de>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:

> From: Alexei Starovoitov <ast@kernel.org>
>
> check_stack_write_fixed_off() sets nospec_result for BPF_ATOMIC insns
> and for calls of helpers and kfuncs too. do_check() ends a speculative
> path there, but bpf_convert_ctx_accesses() emits the nospec only after
> BPF_MEM stores.
>
> Later passes rewrite a call and need its aux data. Put the nospec in
> front of the next insn.
>
> Fixes: d6f1c85f2253 ("bpf: Fall back to nospec for Spectre v1")
> Fixes: 880442305a39 ("bpf: Introduce load-acquire and store-release instructions")
> Suggested-by: Luis Gerhorst <luis.gerhorst@fau.de>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---
>  kernel/bpf/fixups.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
> index 9d5f2774bf8f..8c3a17a05a4e 100644
> --- a/kernel/bpf/fixups.c
> +++ b/kernel/bpf/fixups.c
> @@ -911,6 +911,7 @@ int bpf_convert_ctx_accesses(struct bpf_verifier_env *env)
>  	const int insn_cnt = env->prog->len;
>  	struct bpf_insn *epilogue_buf = env->epilogue_buf;
>  	struct bpf_insn *insn_buf = env->insn_buf;
> +	bool nospec, nospec_next = false;
>  	struct bpf_insn *insn;
>  	u32 target_size, size_default, off;
>  	struct bpf_prog *new_prog;
> @@ -994,8 +995,13 @@ int bpf_convert_ctx_accesses(struct bpf_verifier_env *env)
>  		enum bpf_reg_type ptr_type;
>  		u8 mode;
>  
> -		if (env->insn_aux_data[i + delta].nospec) {
> -			WARN_ON_ONCE(env->insn_aux_data[i + delta].alu_state);
> +		/* A call or an atomic gets its nospec in front of the next insn */
> +		nospec = env->insn_aux_data[i + delta].nospec;
> +		WARN_ON_ONCE(nospec && env->insn_aux_data[i + delta].alu_state);
> +		nospec |= nospec_next;
> +		nospec_next = env->insn_aux_data[i + delta].nospec_result;
> +
> +		if (nospec) {
>  			struct bpf_insn *patch = insn_buf;
>  
>  			*patch++ = BPF_ST_NOSPEC();
> @@ -1102,6 +1108,7 @@ int bpf_convert_ctx_accesses(struct bpf_verifier_env *env)
>  			delta    += cnt - 1;
>  			env->prog = new_prog;
>  			insn      = new_prog->insnsi + i + delta;
> +			nospec_next = false;
>  			continue;
>  		}

This looks much better than my proposal, thank you!

The bot appears to not have realized that nospec_result is mostly a
rename of sanitize_stack_spill.

Acked-by: Luis Gerhorst <luis.gerhorst@fau.de>
