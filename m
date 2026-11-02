Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793652358;
	b=E0cFqOxOjTJZQamiCSVQbg9LBmclTFDH7Vng6m7/JjneaiTK9CZQFEZ4KS2YfP6tR5Qq
	 YFK6ArH/Y0uW+4gnK2RiJUd0H7n6r0iYyqOrPWLjcJ4mMzkZLpdVrRSSgu5ojIzNCOpT3
	 Fhlq67Iqv0BdsQfgqtO/hcWmnftqyqV3SugvoUshVYDtapcmhwRBBUhYFUvkcKCLXUqEX
	 +j/mogNMD1rJfouKPg0TXNnSdWTGqVK8JeNKo1M2/5CfEREt9Y+z5jrwbusOwr7lAQe2o
	 RFIWXS2ILrSYdMEQQUHJm0n76I99NCycUzkIWU/SmkZjEv/9WxE8gRhfHFoGnmw/9xQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793652358;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=QkdyNHg04PdgtDZN025BsbPuS1BoVbcEcI259SLB2e0=;
	b=sAbnALV0y4x77Gz25kLe3XIeCD6p6/pgtx6yJ/R1yqs1q+ERk/fLI0RV8HtOBNvI/JST
	 ARGsP6s1DX5v0nsAItjBXCbAD/tSQEBtTkNhnJh1uQxsgLazpS2LgYgnYek05iEcJn/hB
	 C8cEtQiDm89Xr+e36itlypnMcutEQw156K5UvzvLbWYTIsd2EWsujXuFITZO0euoxq4s7
	 L0UASSxb4bADG+ijmA1JvfE2gElDSBtDDp0QDQYhi1VHAaV4q/eu3md998tsrBIrf8+/5
	 tJb2maH/rDSUbBSeHC/lZl9kjE6AVJ8OBvXs0Y25g2VTJIJVFjcr5VfyxdWg53BpVFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Bf2oltEk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A0EC606A332;
	Mon,  2 Nov 2026 20:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Bf2oltEk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 519FB1F00A18;
	Mon,  2 Nov 2026 20:45:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793652357;
	bh=QkdyNHg04PdgtDZN025BsbPuS1BoVbcEcI259SLB2e0=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=Bf2oltEkOnr79Jo6LB4R74wBRhRXNQpGwNAzG0BoDPJkqUwaMwM3NMEUNj0BmjBfg
	 g2HFPcQeyO9G8Se1plADPwPA56KT9PvuzIMOsqJPAmtWQpBBCDhM5jZMqiS+ejBTI8
	 MW69njMJ7xcqn7Pg2A5twkXGmi5GkQAV4Kls56d0WmgXMNQdQZ0nS2TKfdbHfu2fGH
	 ppL5e56v8ponxhNGin2BxXBGK2+HAJ/ORhK6OD9TybCiSwmwcNTHsXAa7W2ROyzDjh
	 K/7MYT/prlPhLJAFMMUaxnF0PYLRWOQ1k9Oghpjrxn4u2U+bpiZiib9MDZ65PAGmGN
	 j5i/nAJa2zUWw==
Content-Type: multipart/mixed; boundary="===============8048107970388410369=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <c013a7069c06d1120f89eb75e9418938b9e4e71cc81043f41f11cb06d75ca634@mail.kernel.org>
In-Reply-To: <20261102201356.5798-2-mahe.tardy@gmail.com>
References: <20261102201356.5798-2-mahe.tardy@gmail.com>
Subject: Re: [PATCH bpf-next v3 1/5] libbpf: Count entry programs for bpf_gen__init()
From: bot+bpf-ci@kernel.org
To: mahe.tardy@gmail.com,bpf@vger.kernel.org
Cc: qmo@kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,shuah@kernel.org,mahe.tardy@gmail.com,hi@tychen.cc,gyutae.bae@navercorp.com,sh_def@163.com,josef@toxicpanda.com,linux-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Mon,  2 Nov 2026 20:45:57 +0000 (UTC)

--===============8048107970388410369==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> libbpf: Count entry programs for bpf_gen__init()

TL;DR: Nit only: the comment in bpf_gen__init() in gen_loader.c still says
nr_progs includes subprogs, which is now stale after this change. Suggests
updating it.

> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c

[ ... ]

> @@ -9815,13 +9815,16 @@ static int bpf_object_load(struct bpf_object *obj, int extra_log_level, const ch
>  			if (prog_is_subprog(obj, &obj->programs[i]) &&
>  			    prog_has_callx(&obj->programs[i]))
>  				text_has_callx = true;
> -		for (i = 0; i < obj->nr_programs; i++)
> +		for (i = 0; i < obj->nr_programs; i++) {
> +			if (prog_is_subprog(obj, &obj->programs[i]))
> +				continue;
> +			nr_obj_progs++;
>  			if (obj->programs[i].load_strategy != BPF_PROG_LOAD_STRATEGY_DISABLED &&
> -			    !prog_is_subprog(obj, &obj->programs[i]) &&
>  			    (text_has_callx || prog_has_callx(&obj->programs[i])))
>  				nr_progs++;
> +		}
>  		bpf_gen__init(obj->gen_loader, obj->log_level | extra_log_level,
> -			      obj->nr_programs, obj->nr_maps, nr_func_ptr_maps * nr_progs);
> +			      nr_obj_progs, obj->nr_maps, nr_func_ptr_maps * nr_progs);

This isn't a bug, but the comment in bpf_gen__init() now looks stale:

tools/lib/bpf/gen_loader.c:bpf_gen__init() {
    ...
	/* nr_progs includes subprogs and progs that are not loaded */
	nr_progs = min(nr_progs, MAX_USED_PROGS);
    ...
}

With this change, the nr_progs argument no longer includes subprogs.  It is
the number of entry programs, which is the same count that
bpf_object__for_each_program() and the skeleton expose, and it still
includes entry programs that are not loaded.  The comment came from
259172bb6514 ("libbpf: Fix gen_loader assumption on number of programs."),
which the commit message cites.

None of the later patches in the series (276212ecac70, 28aa06d2c9ca,
c9412c70e104, 5b9c2e5eed2a) update it.  276212ecac70 ("libbpf: Track
generated loader link FDs") also sizes link_fds from this same nr_progs
value, so the comment now misdescribes a value that later code depends on.

Should the comment be changed to something like "nr_progs includes progs
that are not loaded, but not subprogs"?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/41519963115
--===============8048107970388410369==--
