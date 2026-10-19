Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B548360C13B
	for <bpf@vger.kernel.org>; Mon, 19 Oct 2026 14:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792418613; cv=none; b=mvMplckQj2vXKXmx1+c2lB7qDuavTfuQVr9NQVsZQrxFwRGd4mtwhdTcAB7OlzokiYxbndRMeY+hYlWsnJC3pkWDAikYqDTAoUqQ4I1SSr1RcTw6zb/r+hrGKY49RWs50i4Y6xCX651mvT7VXvW1Q6hjMXw36UMloXnOqXw/VgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792418613; c=relaxed/simple;
	bh=YflVpWDK8tSdledzT6LNbD4t20J8zkttQurtnaot3SI=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=fntdVURGBBUzqwsTJXXFj51rOEr9wbfNgpohxQuP6lZ1n41OVFWDsnKkO64fLMB7xsrBs9hB9+ypD+b4kF6CyU6Tm5TmJwnN1S+T7tcq+TFL0ct4Em9IlGO+rwVEqBHTaKlLros5j5mMAt34GDWWQ4LLU9QzOloTa+Rmr3uuFbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YQwAazXb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YQwAazXb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5951D1F000C7;
	Mon, 19 Oct 2026 14:03:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792418611;
	bh=VRuNihv1fwK9+ks2mFju/MdoAQKFd8O+6/4sAaqKrtQ=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=YQwAazXbrvxf8RhPOuXGvV1ZP/a7mralJdCLteZyuzRHPYHERz2mGLsYM0+DIpgmi
	 m32IzommQwJ4tQxbbGLdLwhBhoFERGV3kv36lcEz/qNOKWlN8dl2lmJEsLOGtH7pVE
	 vWAJ71p2tNp0aYOaT6NILGdsVrlIfmbx5km5JwDH0Qw75YJ02jJXrX+5FcxoZ9cf2N
	 y5T/2mU8Gmf1HkAkbaPJnBeAA9CsCg5Wh56vmt/NiybYMm2NlPDBgtW7K5nr99bR0t
	 f4+lNHOdwAhW/CnarZaTS8Ka4S+3lQOqT+oNO2TkK+5UGafgOaqUAio3aWoFO5PDqm
	 tbY/9GwaU9hbQ==
Content-Type: multipart/mixed; boundary="===============3451011291447147400=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <4f0962bdc1a2018f57dda4af69616cafa57f4c4925c0a1eca40c519f44debad6@mail.kernel.org>
In-Reply-To: <20261019132203.3034698-10-memxor@gmail.com>
References: <20261019132203.3034698-10-memxor@gmail.com>
Subject: Re: [PATCH bpf-next v5 09/16] selftests/bpf: Test __arena pointer members
From: bot+bpf-ci@kernel.org
To: memxor@gmail.com,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,emil@etsalapatis.com,ihor.solodrai@linux.dev,tj@kernel.org,kkd@meta.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Mon, 19 Oct 2026 14:03:31 +0000 (UTC)

--===============3451011291447147400==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> selftests/bpf: Test __arena pointer members

TL;DR: Nit only, in the selftests: the hand-encoded .8byte load-acquire
literal (also in the xchg fail test) could use the __imm_insn()/BPF_ATOMIC_OP
helpers, as other selftests do.

> diff --git a/tools/testing/selftests/bpf/progs/struct_ops_arena_member.c b/tools/testing/selftests/bpf/progs/struct_ops_arena_member.c
> new file mode 100644
> index 000000000000..a2218cd81619
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/struct_ops_arena_member.c
> @@ -0,0 +1,109 @@

[ ... ]

> +	*ptr += 1;
> +	/* an acquire load of the member yields the same arena pointer */
> +	asm volatile("r1 = %[args];\n"
> +		     ".8byte 0x00000100000010db;\n"	/* r0 = load_acquire((u64 *)(r1 + 0)) */
> +		     "%[acq] = r0;"
> +		     : [acq]"=r"(acq)
> +		     : [args]"r"(args)
> +		     : "r0", "r1");

this isn't a bug, but could the load-acquire insn be built with __imm_insn()
instead of the hand-encoded ".8byte 0x00000100000010db" literal?

verifier_load_acquire.c and arena_atomics.c emit the same insn with:

    __imm_insn(load_acquire_insn,
               BPF_ATOMIC_OP(BPF_DW, BPF_LOAD_ACQ, BPF_REG_0, BPF_REG_1, 0))

from bpf_misc.h.  That form names the opcode, size and registers, and the
compiler computes the encoding, so it does not hard-code little-endian byte
order.

A similar literal (0x000000e1000001db) is used in
struct_ops_arena_member_fail__xchg.c as well.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/39261628996
--===============3451011291447147400==--
