Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CDBA4302EA
	for <bpf@vger.kernel.org>; Thu,  9 Jul 2026 16:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783613759; cv=none; b=uJMw8LuCcQhADwjMgvQNos6y7GOl7n0GcFni+AHh3aIqV1+KeLbX17p+zXdXDIdrGEgdX2kQ/EWVxV9PDrEmoMeAThmqzh86KuNFdfWdwoixcgElw6j2gIy7MzCaSBy/fdZferPaK8qIW4rQqUE///u0I8dReL/84s7aUDemVik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783613759; c=relaxed/simple;
	bh=B23E3JEv0iBdCDP20YDLTLfSSZCnIpqfWYA32mfFn8w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Svsu4Eyx8UFcvCXRcMIvYo5EAogsDofUnVX+86G+6k6Fo2JPuMmPV0FTiA7vA1TXuUghOchny4JrJGRKd7qljif3lCJ5YZZPkyi+rrXtIp9tsI4M1K8eBfLZtqt81UjbFCdPptZ6J6HgXVBCTrLPjR6GupNuBfdOBIem8k61ewE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OVc4irld; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OVc4irld"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 794E01F000E9;
	Thu,  9 Jul 2026 16:15:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783613757;
	bh=h9n02wanB/EA4JMIMS9rO0NDcRCq40jNo/s2Z2a/LRQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OVc4irldULO2pP63hOr/O51cRiB63IcMJpgC0BUlcVll8rj2ADX7hQmxY2k32kQ4n
	 gi1/4FMAngL9InObtl9rw4GALG4P2kAbiXPnJDylTeQdmmzIIeMZiEOu314qtLzt9k
	 TUrBc271XMVQ+9r8b+DHrYjeMLHqf+89RC+HEf7Mg2Gx49VVzoWJwT10R0iz08/7NL
	 62DNfNI2682lJFNZ+mkUZhMWzS7FyVQPXA7O/Uue3+qJw3/jgMul8kqoczgR4r5WyD
	 4vDap73zZRB4tzIs/2nBFFGJrmpGGWVJoyub0sVv7fA9vHvIbpQ58NLQFkqVVR69HE
	 fbgQ3P5W/W64Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 1/2] bpf: reject rdonly/rdwr_buf_size kfunc
 arguments that exceed u32 max
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nicholas Dudar" <main.kalliope@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260709155837.1879230-2-main.kalliope@gmail.com>
References: <20260709155837.1879230-1-main.kalliope@gmail.com>
 <20260709155837.1879230-2-main.kalliope@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 16:15:56 +0000
Message-Id: <20260709161557.794E01F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] 32-bit integer overflow in `hid_bpf_get_data()` allows arbitrary o=
ut-of-bounds kernel memory access.
- [High] Explicit 0-sized requests to kfuncs result in out-of-bounds read d=
ue to verifier BTF fallback.
--

--- Patch [1]: [PATCH bpf-next v2 1/2] bpf: reject rdonly/rdwr_buf_size kfu=
nc arguments that exceed u32 max ---
commit 440bc8eb1e0c84aa93160b0ebdb9ef4731dce2ea
Author: Nicholas Dudar <main.kalliope@gmail.com>

bpf: reject rdonly/rdwr_buf_size kfunc arguments that exceed u32 max

This commit fixes a truncation issue where a 64-bit size argument was
incorrectly truncated into a 32-bit field without a bounds check. It rejects
sizes that exceed U32_MAX in check_kfunc_args() before assigning to the
PTR_TO_MEM register.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 233472a871be5..c7fabe50e4874 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -12097,6 +12097,11 @@ static int check_kfunc_args(struct bpf_verifier_=
env *env, struct bpf_kfunc_call_
>  				}
> =20
>  				meta->r0_size =3D reg->var_off.value;

[Severity: High]
This is a pre-existing issue, but how does the verifier handle an explicit
0-sized buffer request here?

If a BPF program calls hid_bpf_get_data() with rdwr_buf_size =3D 0 and
offset =3D ctx->allocated_size, the bounds check passes:

drivers/hid/bpf/hid_bpf_dispatch.c:hid_bpf_get_data()
    if (rdwr_buf_size + offset > ctx->allocated_size)
        return NULL;

The function legally returns a pointer exactly at the end of the buffer.
However, in check_kfunc_call(), the verifier seems to misinterpret an
explicit 0 size as an absent size:

kernel/bpf/verifier.c:check_kfunc_call()
    if (!meta.r0_size) {
        __u32 sz;
        if (!IS_ERR(btf_resolve_size(desc_btf, ptr_type, &sz))) {
            meta.r0_size =3D sz;
            meta.r0_rdonly =3D true;
        }
    }

Does this fall back to the BTF type size (1 byte for __u8 *) and incorrectly
grant a 1-byte read permission from the out-of-bounds pointer?

> +				if (meta->r0_size > U32_MAX) {

[Severity: High]
This is a pre-existing issue, but does allowing the size to reach U32_MAX
expose a 32-bit integer overflow in hid_bpf_get_data()?

If a BPF program calls hid_bpf_get_data() with rdwr_buf_size =3D U32_MAX and
offset =3D 1, on 32-bit architectures size_t is 32 bits. This would cause t=
he
addition to wrap around to 0:

drivers/hid/bpf/hid_bpf_dispatch.c:hid_bpf_get_data()
    if (rdwr_buf_size + offset > ctx->allocated_size)
        return NULL;

This bypasses the bounds check and returns a pointer to data + 1. Since the
verifier records the returned register's mem_size as U32_MAX, does this
allow arbitrary out-of-bounds read/write access to kernel memory?

> +					verbose(env, "%s rdonly/rdwr_buf_size exceeds u32 max\n",
> +						reg_arg_name(env, argno));
> +					return -EINVAL;
> +				}
>  				if (regno >=3D 0)
>  					ret =3D mark_chain_precision(env, regno);
>  				else

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709155837.1879=
230-1-main.kalliope@gmail.com?part=3D1
