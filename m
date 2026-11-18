Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795032779;
	b=mippht+suE2BYt5sN+3U8GwDX+tHnHVmqIEPTB+84lsb0Mzk/vWURhBR6a4oPhbiVcKm
	 hyAdAUS4CEy/wCQobbtXEcQoqCEt1U61kikedfS/yHpSSIZ4bk5nnh6KHqqpiksEoimjk
	 KTqvq4exTeSG5QSog3ZmVAsFa5Qbe6eAxyJryZ4qhJKAvDTjeclzlPzmRbJpGIKMCcTkn
	 lTgGfMGZiP7jUhonaFW4vbmqbg4oT2VYKpeB665sIRO7kA4V60bRVyrrhg+XuJEzNQpT4
	 OWwR8kFge56T/r0iWDsy/KzLMSO742Cr2ZSrEb4efrMF0CnmKsQ0/nC+NWnSkMh5QJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795032779;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=P7mkAQpHuetk/0hrfUw4N2hwe5baOQQ/RtJ9lGd9NOc=;
	b=G7T87cJOgRYT5Mfnk9C8WzYp2y7sqobxREFEkKu7QAU8QXh+RyhdDi8IqlZgqIyxXKmC
	 +cwCA5mr9gPQ+MHbXzmLsxqKjH85hB+dTQTR4wmMYlLWcySvasqbvVZ6Pf/zBEI28pHJP
	 bVs5zLLVBpm6dMFOEOXA93ZrCe2v0bgw2k8O2zDkREX3e93bmWqzoea6zdEekh7Gtspgl
	 60vf4fUKbzd2+4EtfPpM5ANZcgqGnPz2MvDkWd5hqyVs6edOrG8yZ+7XfULssX3Q4HBFF
	 OztuEd/vcY1U8SLxmi/goz/zXKCI5qwLWRFY7ShBi58UWt8dHOaLHIRKWI2acOT4sPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="dT/60ry7";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D633606A320
	for <bpf@vger.kernel.org>; Wed, 18 Nov 2026 20:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dT/60ry7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 301B51F000C4;
	Wed, 18 Nov 2026 20:12:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795032779;
	bh=P7mkAQpHuetk/0hrfUw4N2hwe5baOQQ/RtJ9lGd9NOc=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=dT/60ry7/Xs/BCaZn9g9aSUmLURf9ypgMuPQ0cjkvxTqW/pt/AeXUNwcXvcU97mm+
	 E04pApb5Bmm53YJZt4Dqev3rxp+eKHkRmgsu+tit3ZwGiOM5YFnOXyISTUofGvEMAV
	 49AyW1//dUVjfqkiyY0U9OzjRT5RXMV1eRwl65JfWYdexl8OYyL1Dv4D9qwza+N1Z6
	 +Y+8VTIo/kGpMy2GP+GwUl/dPMi4eWUBX6NJl8oBW++zwwL2ftbmeL/dZBOD4L6H2W
	 hwE57MnHYUU2amJ9rRV1LzZovyyEwYoyCTpEy0b8iwRBoW1JdnC5ffuDvP8Ntw86/o
	 r6jmV7L61nFhA==
Content-Type: multipart/mixed; boundary="===============0572589711793074370=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <509401dcddc2c2da367d77b259de72e69506b76c7b62e6fc88eacb4f4fe37ec1@mail.kernel.org>
In-Reply-To: <20261118194030.4103149-1-almagui@kernel.org>
References: <20261118194030.4103149-1-almagui@kernel.org>
Subject: Re: [PATCH bpf-next] resolve_btfids: Match the arm64 NOP opcode for LLVM 24 in text_mc
From: bot+bpf-ci@kernel.org
To: almagui@kernel.org,ast@kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,nathan@kernel.org,ndesaulniers@google.com,morbo@google.com,justinstitt@google.com,a.s.protopopov@gmail.com,bpf@vger.kernel.org,almagui@kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Wed, 18 Nov 2026 20:12:57 +0000 (UTC)

--===============0572589711793074370==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> resolve_btfids: Match the arm64 NOP opcode for LLVM 24 in text_mc

TL;DR: Commit message and code comment may name the wrong LLVM version: LLVM
22 and 23 seem to decode arm64 nop as NOP too, so "LLVM 24" should likely read
"LLVM 22 and later".

> resolve_btfids: Match the arm64 NOP opcode for LLVM 24 in text_mc
>
> PR #170968, "[AArch64] Treat NOP as a separate instruction" [1]
> gave NOP its own instruction definition; LLVM 24 decodes
> "1f 20 03 d5" as the opcode NOP. Earlier releases decode it
> as HINT #0, which is what the arm64 table looks for.

Is this boundary accurate?  That LLVM change was merged to trunk when it
was 22.0.0git, and the release/22.x AArch64InstrInfo.td already has:

    def NOP : SystemNoOperands<0b000, "hint\t#0">;
    def : InstAlias<"nop", (NOP)>;

So it looks like the released LLVM 22 and 23 decode nop as NOP as well,
and only LLVM 17 to 21 decode it as HINT #0.  An arm64 build with
CONFIG_BPF_FMODRET_SCAN=y would then fail with LLVM 22 and 23 in the same
way as with 24.0.0git.

Could the subject and body say "LLVM 22 and later" instead of LLVM 24?

> diff --git a/tools/bpf/resolve_btfids/text_mc_arm64.c b/tools/bpf/resolve_btfids/text_mc_arm64.c
> --- a/tools/bpf/resolve_btfids/text_mc_arm64.c
> +++ b/tools/bpf/resolve_btfids/text_mc_arm64.c

[ ... ]

> @@ -25,6 +25,8 @@ static const struct mc_pattern arm64_patterns[] = {
>  	/* HINT: nop, bti, yield, wfe ... */
>  	{ "HINT", TEXT_OTHER }, { "AUTIASP", TEXT_OTHER }, { "PRFMui", TEXT_OTHER },
>  	{ "HINT", TEXT_OTHER, .nop = true, .predicates = { IMM(0, 0) } },	/* nop */
> +	/* LLVM 24 decodes nop as NOP, not as HINT #0 */

This isn't a bug, but the same version boundary applies to this comment.
Should it say LLVM 22 and later rather than LLVM 24?

> +	{ "NOP", TEXT_OTHER, .nop = true, .optional = true },
>  	{ "DMB", TEXT_OTHER }, { "MRS", TEXT_OTHER }, { "MSR", TEXT_OTHER },


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/44386217738
--===============0572589711793074370==--
