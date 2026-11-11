Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794384083;
	b=DgKpSQ1/uN47L0oj1n8g5FvVFo8S14dDv11wEyX184N9McBgapYMeer58rRPs7nSZxtJ
	 1j347UW3IaS/Q8bhI/1gn9iN8/Thf5CDxWKh0amTb0g+UqFSh0Vkp7o/U1Cc29SNDSgZO
	 ivlIlDcOT4teDkTAaUre+bt5THig1G6hfnkSfZTYuu3KaR4H6VIFkvsATJClP5ZCzmdl2
	 qEp7w4KB0TmJWaAgsVAaunMU+r1UZ2CHpCWEJS5KFKSo4KZ4zRCxiey3josEwv/HTRUj2
	 eIChEogFVKHgllNoA6HR13bDOt+e3AWd+8GRNvtqpcq/rfsbUPIJsq54Pb584vZ2Sbg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794384083;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=auUioKB9iDxCNGJRzVwktkzZSlbRGmUGRm1khRaq5NA=;
	b=RRlEMJfp1+Fuio0z6bzZyceii0hQBl9Ny7gLDAdcrUPoPsdq80EqubnwbnmqRDMVejEz
	 rjblmdzGXs6JtBdfPFCLSreem0Ty7krAk7HwSgOWDOHW6h/PV6HcOK5QqZRakBMMpj7QP
	 Jy5w2/xfQIkRJ55J6mKxF0bO0ZlLUGXcdkRauiYiUVcJ+179ygU7usVU2QAavFnZoY7ix
	 5UIUh2Ya3r5o/i+XEioZE5JIZvhMcKrovM/uNxVHUuBDq2aqiusuwTQNIPHARV1qMQfyJ
	 nYDwinn8qEw/fFnYK6hzkzGTjMXNcofKQUugegM2iB8yxvsv9ueZzxNjqVVDT6zTHRQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RBJ1GW3Z;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76575606A31C;
	Wed, 11 Nov 2026 08:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RBJ1GW3Z
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EACD31F00A05;
	Wed, 11 Nov 2026 08:01:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794384083;
	bh=auUioKB9iDxCNGJRzVwktkzZSlbRGmUGRm1khRaq5NA=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=RBJ1GW3Z0bSR+qUg9Pw4kt8EbNcp81Q+TJuPaB6fro9CJMVs0nEpE2u1FsQ1gsE/9
	 kEeGyq8zos9VrOUilQHnrRL9J/gbLG7FDdKW7s4fnkTjtv6i/1m/r1FeUdWmMzRYBU
	 gh12JIJd6s+KKgAGEq9Z5TGjdIxF0qv4EvafFwGJsdeAOYGf+E+lXbLpYe0M3ZLODL
	 tuvk5Aaj+p6krN9tjFv9hAfaM6Ll5kpLE/1aDHenrMfyF7xeRCNGv4rfg3cLT5BhJ5
	 iBvDsHdVdvRRlwisdN4HH5RLK1UHN3ZrUwBnKHOkLNoTBoyNVT/XrcBZGKeoJp0K+Y
	 t3VskGvUeDc1w==
Content-Type: multipart/mixed; boundary="===============6009813406233217659=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <08e4851ff6c0fec6c90ae269b9edafedafdc5ed0462802fe1c1dae6aef465696@mail.kernel.org>
In-Reply-To: <20261110164046.454431-2-a.s.protopopov@gmail.com>
References: <20261110164046.454431-2-a.s.protopopov@gmail.com>
Subject: Re: [PATCH v3 bpf-next 01/18] bpf: Add BTF ID sets for fmod_ret targets
From: bot+bpf-ci@kernel.org
To: a.s.protopopov@gmail.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,almagui@kernel.org,john.fastabend@gmail.com,qmo@kernel.org,brauner@kernel.org,kpsingh@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,sashal@kernel.org,bpf@vger.kernel.org,linux-kernel@vger.kernel.org
Cc: a.s.protopopov@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Wed, 11 Nov 2026 08:01:21 +0000 (UTC)

--===============6009813406233217659==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Add BTF ID sets for fmod_ret targets

TL;DR: Comment nit only: the BTF_SET8_FMODRET comment (also in tools/include)
says the set governs fentry/fexit attachment, but non-sleepable fentry/fexit
never consult it. It could mislead readers.

> diff --git a/include/linux/btf_ids.h b/include/linux/btf_ids.h
> --- a/include/linux/btf_ids.h
> +++ b/include/linux/btf_ids.h

[ ... ]

> @@ -13,6 +13,12 @@ struct btf_id_set {
>  /* This flag implies BTF_SET8 holds kfunc(s) */
>  #define BTF_SET8_KFUNCS		(1 << 0)
>  
> +/*
> + * This flag implies BTF_SET8 holds functions which BPF fmod_ret, fentry and
> + * fexit programs may attach to. Per-function flags: KF_SLEEPABLE only.
> + */
> +#define BTF_SET8_FMODRET	(1 << 1)
> +

This isn't a bug, but does this comment describe the set accurately?  It
says the set holds functions that fmod_ret, fentry and fexit programs may
attach to, which reads as if the set controls fentry/fexit attachment.

The set is only read through btf_kfunc_is_modify_return(), which has two
callers.  bpf_check_attach_target() uses it for non-sleepable
BPF_MODIFY_RETURN only:

    } else if (prog->expected_attach_type == BPF_MODIFY_RETURN) {
        ...
        if (btf_kfunc_is_modify_return(btf, btf_id, prog) ||
            !check_attach_modify_return(addr, tname))
            ret = 0;

and btf_id_allow_sleepable() uses it for sleepable programs only, and
requires KF_SLEEPABLE:

    u32 *flags = btf_kfunc_is_modify_return(btf, btf_id, prog);
    if (flags && (*flags & KF_SLEEPABLE))
        return 0;

Non-sleepable fentry and fexit programs never look at the set.  This
remains true through the end of the series (6dc8474f6891 has the same two
callers).

The commit message ("the functions BPF fmod_ret programs may attach to ...
KF_SLEEPABLE marks targets sleepable programs may attach to") and the
resolve_btfids header comment ("the targets of BPF fmod_ret programs")
describe it differently.  Someone could read this comment and add a
function to a BTF_FMODRET set to make fentry/fexit attach work, which would
also allow fmod_ret programs to override its return value.

Could the wording be along the lines of "the set holds fmod_ret targets,
and KF_SLEEPABLE additionally lets sleepable fentry, fexit and fmod_ret
programs attach"?  The identical comment in tools/include/linux/btf_ids.h
has the same problem.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/42981885558
--===============6009813406233217659==--
