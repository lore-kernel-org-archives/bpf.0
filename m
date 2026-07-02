Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA5742E8DEA
	for <bpf@vger.kernel.org>; Thu,  2 Jul 2026 12:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782994636; cv=none; b=RezXWirw6bDDkj3NORMKsRabnf847VhmRcrs+Gmo8Q9c/iQJezlAq2c62CdrIcPokOI34cAmhvAqte1+4yRCf4DQcqD4aCl4Dog4rt4TyZmHlGgspoZuHc+qZEyWpVz8XxqYE0UsexXU9j1yHew2EeI/6KZWM4uor1wmOeF1Y3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782994636; c=relaxed/simple;
	bh=yJRAPWNo21RnCUG4ESG0w7KE2hT1JrFP2dLUEQ9co58=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VAjTYai3hp9TOPrSiaGukk5mA74806zMs1E7zDq3lQURD3y1G3U8YKFqyVWTZfrocVz2DmIK6VVWxVrSmr65QiV64O1ZUAKIZh2bgyrnUJhJmF8oaw7Z7/Skmy/qVxJ1rlGAIdzFddFPWFARmPoKft+DxIDXE7azv+JQFp+9UjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=erGT8SnZ; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="erGT8SnZ"
Message-ID: <f61c41783f56fc259b56141e8d438a56c9dfa31b.camel@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782994622;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X/OZ//ON7orm4N2x26XRJAtujrag+hI9dhYZcyvpa9g=;
	b=erGT8SnZepaErUEWINQJbvD6sNy5wb++XQ/UXVzWWUf/yU+mrjClpSe3AcpmFvcPI5spfT
	TKs+JjskWm6VF6uPrlWhrOKalC6pHXE3OegnyOXUKW4/iUZgWIdsQcrmVsUxJXlqjNlMcp
	St0U9fSg5Wfw8v3pdXahLN+WmHglgCI=
Subject: Re: [PATCH bpf-next v6] bpf: Reject programs with inlined helpers
 if JIT is unavailable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: KaFai Wan <kafai.wan@linux.dev>
To: Tiezhu Yang <yangtiezhu@loongson.cn>, Alexei Starovoitov
 <ast@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,  Kumar Kartikeya
 Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song
 Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa
 <jolsa@kernel.org>, Emil Tsalapatis <emil@etsalapatis.com>
Cc: bpf@vger.kernel.org, loongarch@lists.linux.dev, Leon Hwang
	 <leon.hwang@linux.dev>, Puranjay Mohan <puranjay@kernel.org>, 
 =?ISO-8859-1?Q?Bj=F6rn_T=F6pel?=
	 <bjorn@kernel.org>
Date: Thu, 02 Jul 2026 20:16:51 +0800
In-Reply-To: <20260702053127.23599-1-yangtiezhu@loongson.cn>
References: <20260702053127.23599-1-yangtiezhu@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Migadu-Flow: FLOW_OUT

On Thu, 2026-07-02 at 13:31 +0800, Tiezhu Yang wrote:
> When an architecture implements bpf_jit_inlines_helper_call(), such as
> LoongArch, ARM64, PowerPC, and RISC-V, the verifier skips rewriting the
> helper call offset (insn->imm) during the bpf_do_misc_fixups() phase,
> because the helper is expected to be inlined by the JIT compiler. As a
> result, insn->imm remains as the raw helper enum ID.
>=20
> However, if JIT is disabled at runtime (net.core.bpf_jit_enable=3D0) or
> if the JIT compilation later dynamically fails (e.g., due to OOM), the
> core BPF subsystem falls back to the BPF interpreter.
>=20
> When the interpreter executes (__bpf_call_base + insn->imm) with the
> unpatched raw helper ID, it jumps into an unaligned invalid address
> space, triggering an instruction alignment fault or a memory access
> panic.
>=20
> To avoid modifying the BPF interpreter's complexity for JIT-specific
> paths, just introduce a 'jit_required' flag in struct bpf_prog. When
> a program contains helper calls that skip rewriting for JIT inlining,
> set this flag to 1. During runtime selection, if JIT compilation is
> not available, explicitly reject loading with -ENOTSUPP instead of
> falling back to the interpreter, safely preventing the kernel panic.
>=20
> Fixes: 2ddec2c80b44 ("riscv, bpf: inline bpf_get_smp_processor_id()")
> Suggested-by: Alexei Starovoitov <ast@kernel.org>
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
> v6:
> =C2=A0 - Place 'jit_required' as a standalone u8 field right before 'stat=
s'
> =C2=A0=C2=A0=C2=A0 to reuse the existing 4-byte struct hole (offset 52) b=
ased on pahole
> =C2=A0=C2=A0=C2=A0 analysis, avoiding the u16->u32 bitfield conversion in=
 v5 which=20
> =C2=A0=C2=A0=C2=A0 unintentionally changed the layout/alignment of subseq=
uent fields.
>=20
> v5:
> =C2=A0 - Drop the fallback interpreter fixups as per maintainer's feedbac=
k.
> =C2=A0 - Introduce 'jit_required' member in struct bpf_prog to flag progr=
ams
> =C2=A0=C2=A0=C2=A0 that strictly rely on JIT.
> =C2=A0 - Reject loading with -ENOTSUPP in __bpf_prog_select_runtime() if =
JIT
> =C2=A0=C2=A0=C2=A0 fails or is disabled for these programs.
> =C2=A0 - Upgrade 'jited' bitfield group type from u16 to u32 in struct bp=
f_prog
> =C2=A0=C2=A0=C2=A0 to prevent 17-bit overflow warning.
>=20
> =C2=A0include/linux/bpf.h | 1 +
> =C2=A0kernel/bpf/core.c=C2=A0=C2=A0 | 2 +-
> =C2=A0kernel/bpf/fixups.c | 4 +++-
> =C2=A03 files changed, 5 insertions(+), 2 deletions(-)
>=20
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index ba09795e0bfd..f5c283af3cf7 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -1889,6 +1889,7 @@ struct bpf_prog {
> =C2=A0		u8 digest[SHA256_DIGEST_SIZE];
> =C2=A0		u8 tag[BPF_TAG_SIZE];
> =C2=A0	};
> +	u8			jit_required;	/* program strictly requires JIT compiler */

maybe 1 bit is enough. I'm not sure the layout matters, if not we can put b=
ehind sleepable:1.

> =C2=A0	struct bpf_prog_stats __percpu *stats;
> =C2=A0	u8 __percpu		*active;	/* u8[BPF_NR_CONTEXTS] for recursion protect=
ion
> */
> =C2=A0	unsigned int		(*bpf_func)(const void *ctx,
> diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> index 649cce41e13f..a55754bcc593 100644
> --- a/kernel/bpf/core.c
> +++ b/kernel/bpf/core.c
> @@ -2639,7 +2639,7 @@ struct bpf_prog *__bpf_prog_select_runtime(struct b=
pf_verifier_env *env,
> struct
> =C2=A0
> =C2=A0		fp =3D bpf_prog_jit_compile(env, fp);
> =C2=A0		bpf_prog_jit_attempt_done(fp);
> -		if (!fp->jited && jit_needed) {
> +		if (!fp->jited && (jit_needed || fp->jit_required)) {

You ignore Alexei's feedback. Should be =20

--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -2619,8 +2619,7 @@ struct bpf_prog *__bpf_prog_select_runtime(struct bpf=
_verifier_env *env,
struct
 	if (fp->bpf_func)
 		goto finalize;
=20
-	if (IS_ENABLED(CONFIG_BPF_JIT_ALWAYS_ON) ||
-	    bpf_prog_has_kfunc_call(fp))
+	if (IS_ENABLED(CONFIG_BPF_JIT_ALWAYS_ON) || fp->jit_required)
 		jit_needed =3D true;

so we can set fp->jit_required when need, without change the rest.

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 25aea4271cd0..3b2fb0163db7 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2712,6 +2712,7 @@ int bpf_add_kfunc_call(struct bpf_verifier_env *env, =
u32 func_id, u16 offset)
 		if (!tab)
 			return -ENOMEM;
 		prog_aux->kfunc_tab =3D tab;
+		env->prog->jit_required =3D true;
 	}

So the patch#1 is a refactor, some sort of this, I'm not sure it's right.

> =C2=A0			*err =3D -ENOTSUPP;
> =C2=A0			return fp;
> =C2=A0		}
> diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
> index 12a8a4eb757f..94e0457a0aa3 100644
> --- a/kernel/bpf/fixups.c
> +++ b/kernel/bpf/fixups.c
> @@ -1841,8 +1841,10 @@ int bpf_do_misc_fixups(struct bpf_verifier_env *en=
v)
> =C2=A0		}
> =C2=A0
> =C2=A0		/* Skip inlining the helper call if the JIT does it. */
> -		if (bpf_jit_inlines_helper_call(insn->imm))
> +		if (bpf_jit_inlines_helper_call(insn->imm)) {
> +			prog->jit_required =3D 1;

This's the patch#2.

> =C2=A0			goto next_insn;
> +		}
> =C2=A0
> =C2=A0		if (insn->imm =3D=3D BPF_FUNC_get_route_realm)
> =C2=A0			prog->dst_needed =3D 1;

and the rest.

--=20
Thanks,
KaFai
