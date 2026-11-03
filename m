Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793732248;
	b=386HQMjfRmC/zlK20AsVGlMiPc5qdlS/qwJL2uTzGIkBWB87u+mnHRaB+uQZ7nRCj4xD
	 zPrXNqhU1r+zvnpZZL65nTxtcFxTBTPbGbpsLF8G7ulwzVsjhz39cUx+StdQFvvXSSuEZ
	 ZBfIZ+nG29f7gyKptdkypqN+rOL+rfwmlFOnQljyJDsv406W+xFzcMeA/PegDvp7ZVuLs
	 5B5/YAQMlJ3xgybNCzdcrjbzhCAdzZsPLppfW/N1aQHqlGaUAQCC6HwmscMwkVAvjLjgc
	 y463P5EAD1v78fnZU5zXqlXAp7E3l4QYT4dAt91Omc2N05O7KhTTuWmKWY6x5hrciZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793732248;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=nPL/HHow+XbEwmcyq88DWxF7CGJ43yDoyFa2spd4mwc=;
	b=dZx1rQj3nUmwJ4inweVIEX4cUiVVoYqPPdd2Kabu1rrJzcKmpXnd0B86pIMCG1fzRzlN
	 CkpxykW+YFICGBGX++YSQ3MSrt6+/0f7Btc/xLV+g/5Zq1DCpWyJGQJ7VA+N9Mpoambwf
	 j51j/CNbzv9XGa5tNO7T5GMoXVaxsgkFLck7Sgw+ImjQQ3q/TkP9Dt7nqEBavErdb2qm6
	 D4T/GFLADgBnRewnreXa9ZxxgnWclQoTWPLHad+z3XwEjb6yAngEAP4o/7/NDujeb+e1q
	 4uSjeR8pqgJo/rQmFEZlh3p5KzAXnSerH9mK52sY4q+e1C0GmOWVu+nzzRnTcSjdftA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="HZH4gE/O";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 049BA606A324;
	Tue,  3 Nov 2026 18:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HZH4gE/O
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1986E1F00919;
	Tue,  3 Nov 2026 18:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793732247;
	bh=nPL/HHow+XbEwmcyq88DWxF7CGJ43yDoyFa2spd4mwc=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=HZH4gE/OsGeU9N50QJIyULBLdqV1Nn2A+jfiYpFuTHgJWa//+Vp6X4LnuaabGZTkO
	 iQ6lTtQXWbxVeAGK4J7WRzbO6Ux6DRIaCdMLVkHzGzLS8PeVGD/ftnfR8462fUZI7z
	 uASFtgoITJkS8YUfaxK3cpijX55N6mT2PEWK4WW699vQhbEY9D+W90ZTx5zmG0Kzq7
	 hfca3/mawy2Zt/Mxt6KNNCXsAwJka0LKuEUylJjw3nEQ9uSkZG01tTGgNx7iabBUuA
	 kn4vyx4DIwHqI6hTlA0MeBeIlcl+RiQIQIedhpCq8lQkGg2psOIWY/rVymVkcgcvZk
	 JDtw/4ZWlaCGQ==
Content-Type: multipart/mixed; boundary="===============0701282565522060909=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <a649383646b7d5a6867f5eabfbfe36d281225a44c592e8c0c1c5b3976fce9087@mail.kernel.org>
In-Reply-To: <20261103181816.254686-5-vineet.gupta@linux.dev>
References: <20261103181816.254686-5-vineet.gupta@linux.dev>
Subject: Re: [PATCH bpf-next v4 4/8] selftests/bpf: spell the addr_space_cast address spaces in decimal
From: bot+bpf-ci@kernel.org
To: vineet.gupta@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,john.fastabend@gmail.com,shuah@kernel.org,linux-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,jose.marchesi@oracle.com,david.faust@oss.qualcomm.com,vineet.gupta@linux.dev,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Tue,  3 Nov 2026 18:57:27 +0000 (UTC)

--===============0701282565522060909==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> selftests/bpf: spell the addr_space_cast address spaces in decimal

TL;DR: Commit message only: the last sentence about GCC and "capable binutils"
is unclear, since the edited code is still behind
__BPF_FEATURE_ADDR_SPACE_CAST. Suggests saying it prepares for the later
guard-dropping patch.

>     selftests/bpf: spell the addr_space_cast address spaces in decimal
>
>     The inline asm in the arena tests writes the two address spaces of
>     addr_space_cast() in hex which trips up a GNU assembler bug:
>
>       progs/jit_insns_arena.c:49: Error: unrecognized instruction `r7 =addr_space_cast(r7,0x0,0x1)'
>       progs/jit_insns_arena.c:49: Error: expected ',', got 'x'
>
>     This has been fixed and landed binutils commit 835aee81fa93 ("bpf: accept
>     any spelling of the addr_space_cast address spaces"), but will only land
>     in the 2.47 release, so add the workarounds for now.
>     A GCC that defines __BPF_FEATURE_ADDR_SPACE_CAST would be paired with
>     a capable binutils.
>
>     No functional change.
>
>     Signed-off-by: Vineet Gupta <vineet.gupta@linux.dev>

This isn't a bug, but the last sentence of the changelog is unclear:

  "A GCC that defines __BPF_FEATURE_ADDR_SPACE_CAST would be paired with
  a capable binutils."

Every addr_space_cast() edited in this patch sits inside an
#if defined(__BPF_FEATURE_ADDR_SPACE_CAST) block (jit_insns_arena.c,
verifier_arena.c, verifier_hmul_arena.c, and the guards in fetch_r0(),
uaf(), load_acquire() and store_release() in arena_atomics.c).

Read literally, that means none of the edited code can reach the buggy
assembler at this point.  The gas failure quoted for jit_insns_arena.c
only becomes reachable once the later commit 05738ae8e1ca ("selftests/bpf:
drop the arena guards and tag the tests that need arena") removes those
guards.

Since every addr_space_cast changed here is still behind
__BPF_FEATURE_ADDR_SPACE_CAST, which bpf-gcc does not define yet, could
the changelog say this prepares for the following patch that drops those
guards, and say what "capable binutils" means here (one that knows the
addr_space_cast mnemonic, or one that also accepts the hex spelling)?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/41694978246
--===============0701282565522060909==--
