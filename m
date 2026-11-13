Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794549149;
	b=qBpxNd2YaQ5qbNywZ4BMtR98OmTHaWnA041oilqUisUc+7972SD8bgqwitQzd6sX/NaB
	 M3IbAdFN3Y8VNfFE+LPMeuEXwbQWFEPzjkSQ3sZ0DVqaQBNdc1slNoZy72qsSU7vU9lRc
	 wG2Gz+Rbf3/N0mvrPXnq/xxBDaN5vVK6Y43I2C6H1bMexsjFipcTMKTpGODMQn8DVrOZb
	 Hoj3dPgb2j1tk/ETV/hGT6lueMa2wHbU6yqz/8byQPXV3cLYPQzp8QxV4Nm2LF7Bdbfq6
	 Pf8IXyWTO6Dft6RbAsyHzyP38qEvTeRZ0n1DLky75W7gr+sh9/JkfdNMdKFr7s7wFmg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794549149;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=XiP6kbOnk5aGoSfWSCeMBHb+xlwoQH67hWzA8o7H21w=;
	b=rqvf9RB+JlfMysOLlkqpY0GtZx91ogMxlqGlWoUTBuBhG45oxjp58uy99+P8A8maccwf
	 ZZCOBVr2qh5WjErkOQ4+yogCZQ9lAmfGm8DTQ57yh9zQif5iaSyQS+n8y0tEvuEVxU/4U
	 s2IgeiMZ8pxA0w+qCXKmFC6EByg+OCU3Ror9XHkjl/A5NBJ8dGKfPvePZFU3ZngZQ5JIH
	 4GzKDUVbstBnhurx3K7vMR8yefQ+Et5oPYnR3DJujE/N1AOsP1CR+pzwWrxtYRY3oD4Pc
	 lz5eoRFjqtLsYxT5Y/eF3CvQSdzrTCMJkSJP+MbPH/dpWhBU/TJOw8AaHP01aI8q5RQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZOsqxGno;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9883606A321
	for <bpf@vger.kernel.org>; Fri, 13 Nov 2026 05:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZOsqxGno
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 245AC1F000C4;
	Fri, 13 Nov 2026 05:52:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794549149;
	bh=XiP6kbOnk5aGoSfWSCeMBHb+xlwoQH67hWzA8o7H21w=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=ZOsqxGnodo7Q6XpFGUWt8nv+JdVO1QsFLr23JQVMXoTl8KIMpUgm+ZwXYGYbmQfNv
	 Zmi5IBRJMAuoncZBZQr7tRKoJ+v5I2Yak+VhTf4mL7Rt7oPgcX8+x5Q0dOuAZGNSiP
	 qYzuLCDPtQXc1/ItGUomG0xk1O/GBS6siQ4wCq08vkqvztyXiOPNi1q8C3Cukt6NYu
	 wD1zmd6oKgsuxiFoOm3gNjO7LiNE+TGX7t19HsVGlsFQKYLpQ6hrbYATTTGjf+E3Tu
	 Vv2iDlpVQen+rT54DeDNmtwiqImJtl5UnHTBCkYUip7JQPw7cOpivMl4TUtDsSQORe
	 oxXDBjc4y8Vew==
Content-Type: multipart/mixed; boundary="===============7604913813621578243=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <552ca9c7597417c92823f305ed9e41c67c2621674e3b568ffa085ae2e2c28aa5@mail.kernel.org>
In-Reply-To: <20261113050901.1399091-9-alexei.starovoitov@gmail.com>
References: <20261113050901.1399091-9-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH v2 bpf-next 08/13] resolve_btfids: Don't list an error that follows work on an argument
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,a.s.protopopov@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri, 13 Nov 2026 05:52:28 +0000 (UTC)

--===============7604913813621578243==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> resolve_btfids: Don't list an error that follows work on an argument

TL;DR: Possible wrong register mapping in resolve_btfids when a struct or
union parameter takes multiple registers (or none): later pointer args may be
misidentified, so an error may be wrongly dropped from or kept in the fmod_ret
list.

> diff --git a/tools/bpf/resolve_btfids/fmodret_scan.c b/tools/bpf/resolve_btfids/fmodret_scan.c
> --- a/tools/bpf/resolve_btfids/fmodret_scan.c
> +++ b/tools/bpf/resolve_btfids/fmodret_scan.c

[ ... ]

> +void scan_set_proto(struct scan *s, const struct image_func *f, unsigned int pointers, bool effect)
> +{
> +	struct callee *callee = callee_at(s, f->addr);
> +	unsigned int i;
> +
> +	callee->effect = effect;
> +	callee->pointers = 0;
> +	for (i = 0; i < s->flow.arch->nr_args; i++)
> +		if (pointers & BIT(i))
> +			callee->pointers |= BIT(s->flow.arch->args[i]);
> +}

Does this mapping hold when a parameter takes more than one register?  Here
BTF parameter i is mapped straight to arch->args[i], and set_protos() builds
the mask the same way, without regard to parameter size:

	for (i = 0; i < btf_vlen(t) && i < 32; i++) {
		int type = btf__resolve_type(btf, btf_params(t)[i].type);

		if (type > 0 && btf_is_ptr(btf__type_by_id(btf, type)))
			pointers |= 1U << i;
	}

On x86-64 and arm64 a struct or union of 9 to 16 bytes passed by value takes
two argument registers, and on x86-64 a larger struct takes none.  Every
later parameter then sits in a different register than the one assumed.

For example, in kernel/bpf/btf.c:

	int btf_new_fd(const union bpf_attr *attr, bpfptr_t uattr,
		       struct bpf_log_attr *attr_log)

bpfptr_t is the 16-byte sockptr_t, so attr is in %rdi, uattr in
%rsi:%rdx and attr_log in %rcx (x0, x1:x2 and x3 on arm64).  set_protos()
produces BIT(0) | BIT(2), which becomes %rdi | %rdx.  In scan_func(),
flow.args then treats %rdx (uattr.is_kernel) as a pointer argument and never
tracks %rcx (attr_log).  map_create_alloc() and groups_to_user() are shifted
the same way.

The callee side has the same problem: for a void callee with such a
signature, insn->pointers names the wrong register.

An effect on a later pointer argument would be missed, so the error stays in
the list, and a register holding non-pointer data can be taken as a based
pointer, which could drop an error by mistake.  The commit message lists
what the tool does not see, and this case is not on the list.

Would advancing the register index by the size of each parameter,
(btf__resolve_size() + 7) / 8, work here?  Alternatively, could a prototype
with a struct or union parameter be given up on (cleared)?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/43372129532
--===============7604913813621578243==--
