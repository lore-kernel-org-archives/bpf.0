Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 918FE23D2A4
	for <bpf@vger.kernel.org>; Fri, 17 Jul 2026 19:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784315782; cv=none; b=dwhsAfI2xfWFAeJVCgX9Se/EiGkK9rVDl3/TaFuBZy6+Zjs9qr2s03dvx05bNmOmPOQ2PMsxFXx5PuKqM3/7YJHYnEy7TAml48+P58BPfOuM8zGD59JSN33J6MYXr4fY49hYrG3fdC/MF2/pJBw3UBnkJb63UFtKZwLl27UeNKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784315782; c=relaxed/simple;
	bh=OjsKQxPaKOd9JwlE1wjgr5sGDOi6KRhH52BkW7eGPr0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=C3wpCTbfzMYssyfGsUsDQIPqSl0xs1JfsJmAee8mT8X5x8gSA7fC0wCHLXIdTCfZjiQK7J7uTAOA1N4edlEM2VJ/Gh0LKwW3XWxVF3IvZdBgZ6EGiAh5tQqzUaL0cZK0xI6FD8Q0Oz4puXWtoHszW1pYDkQ3t+EWDi6VAEuQWwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aNl/woUv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aNl/woUv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D7DC1F000E9;
	Fri, 17 Jul 2026 19:16:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784315781;
	bh=UdVzGWlY1y5F26b+AyiFm9mp5yuzKfT60GRakGnzYWc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aNl/woUvGvQ6AC/R0fdFJcntH14B04u/YsaYRIfMM64nGDRZe2r2riaw14nls+3dR
	 ciXqByDJ//YqKwfg8pd59Iz9fN8nscHAL06ndV7yFCjW0UdskftucVFtoHlvNoaaq9
	 33erFoDKenW+4MFmNc8A1AfJwjnulGi+36Nk3R89Cx9wCrpgXfnRqG6aIe8kKQCuDc
	 +l/aosT/h2NHqVzyKDpQ1owUr1mTJhSk8cj+wurvuGKRo2lD+VyUdIoKfYGpDqdsNJ
	 aWRlKzXegE/3npaMDvlcWyCkJhqF45CVRZ2dPUPJjFBlYvV8nt3N2pQPZc0Szr45uv
	 GkZ9DuAWlKSLg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 1/2] bpf, parisc: Add support for BPF_SDIV and
 BPF_SMOD in the parisc64 JIT
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nicholas Dudar" <main.kalliope@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260717190544.257306-2-main.kalliope@gmail.com>
References: <20260717190544.257306-1-main.kalliope@gmail.com>
 <20260717190544.257306-2-main.kalliope@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Jul 2026 19:16:20 +0000
Message-Id: <20260717191621.0D7DC1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The patch implements BPF_SDIV and BPF_SMOD for the 64-bit PA-RISC =
JIT but omits the 32-bit JIT, causing signed divisions to be silently misco=
mpiled as unsigned.
--

--- Patch [1]: [PATCH bpf-next 1/2] bpf, parisc: Add support for BPF_SDIV a=
nd BPF_SMOD in the parisc64 JIT ---
commit 5e5d75e62e2afee7aac7d5510ab28785201de9f5
Author: Nicholas Dudar <main.kalliope@gmail.com>

bpf, parisc: Add support for BPF_SDIV and BPF_SMOD in the parisc64 JIT

This commit adds support for signed division and modulo (BPF_SDIV and
BPF_SMOD) to the 64-bit PA-RISC BPF JIT. It passes the signedness check
down to the emission functions and introduces signed libgcc helper
wrappers.

> bpf, parisc: Add support for BPF_SDIV and BPF_SMOD in the parisc64 JIT

[Severity: High]
This is a pre-existing issue, but does the 32-bit PA-RISC JIT still
miscompile signed divisions as unsigned?

While this patch correctly implements BPF_SDIV and BPF_SMOD for the 64-bit
JIT, arch/parisc/net/bpf_jit_comp32.c appears to still unconditionally
accept these instructions without checking if insn->off =3D=3D 1.

In arch/parisc/net/bpf_jit_comp32.c:bpf_jit_emit_insn():

    case BPF_ALU | BPF_DIV | BPF_X:
    case BPF_ALU | BPF_DIV | BPF_K:
    case BPF_ALU | BPF_MOD | BPF_X:
    case BPF_ALU | BPF_MOD | BPF_K:
        /* ... */
        emit_alu_r32(dst, src, ctx, BPF_OP(code));

And then in emit_alu_r32():

    case BPF_DIV:
        emit_call_millicode($$divU, lo(rd), lo(rs), op, ctx);
        break;
    case BPF_MOD:
        emit_call_millicode($$remU, lo(rd), lo(rs), op, ctx);
        break;

Because the JIT silently compiles signed division as unsigned ($$divU),
and the eBPF verifier calculates memory bounds assuming a signed result,
could this verifier-JIT desynchronization be exploited to bypass bounds
checks?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260717190544.2573=
06-1-main.kalliope@gmail.com?part=3D1
