Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795052649;
	b=FGOKeM+TwBgn20QZYEpKjlrdQvHKnblSmQ8WtT1uFIPDs3J9yTVhU5YJ2DPANzKsuOQV
	 M/4TC2AL0+dxWsL+92Jhdg+GB/s6s2m+wz1+r5OVXzGgRegiwvrDwAAXwUo1F/cvESedS
	 Hi/wtJhYr89CNBhQyyI1JEm17hCVouiAwinLECM/ckj/yflPeWrfER/dln/AXIvrcAqwZ
	 QHKQ7TFnD6nAfjPlx50Ykxkll/J01JvR6h03lDO3GGk11ZOYzxTTYHGMlnrf808dcs1HN
	 VJDSi9w3EBjyyPzG2+fjanmWdM/kcFKOYmmvMw54vV/lDSmDLgudHbcMM5fs4aVieUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795052649;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=mPgaLdPVgN+EK8/t5TKiyz/aU8rMoF0nQ5/fzMmP53M=;
	b=NQGIcSlzU7gDxU8uFHw/FjWERLidbkv0+MXQAh3K3JKzU/v3CZtusxhodg54iOxE5niq
	 2LAFKnA9U4EBjnwejN8971gu15KA/2uUu4lu/Z5TBff3jyXRcOVR7wOxXPmm9pgRVmwGM
	 055SvMWMix+rALY/H1CuV8+mZvhxSKYJnuacouMFgMv13piPrlLU2XPfqvjSnkEg9lkO9
	 giy74cTp12mGqZh5gr1Z756zXF+ZSRD+jw+mGnm7phQ+/e35U2jLfMmfJfRGK80Z1tEbu
	 3iAEmtdNvKshsyPRo753+LCqRdo1kS0Q0a77QnojsMMwN3E8yMXSwz/ItLcX/h6LT2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hPZvxG7N;
	arc=none smtp.remote-ip=209.85.214.171
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D59B606A320
	for <bpf@vger.kernel.org>; Thu, 19 Nov 2026 01:44:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7D59B606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hPZvxG7N
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2ed08b07213so8164245ad.2
        for <bpf@vger.kernel.org>; Wed, 18 Nov 2026 17:44:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795052649; x=1795657449; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mPgaLdPVgN+EK8/t5TKiyz/aU8rMoF0nQ5/fzMmP53M=;
        b=hPZvxG7Nq3ovIfuB6lp6EIMTPxK7RG+m8SuZW9NaeX4uU+jrvFCPfIbCCdjUJnBs8e
         /mntY8/SFsKTxD+mWGbM5X1/KKqUxtVc1qiGC9AA19AdM5GGS5nKCD0GhpxAo5HT3LuF
         jtqBLMTMv7Danpap0vMUuysKhTMF9kOakqUpT/Cc4CEOeFjEulCT+FOllYbeQqEYGwKP
         QUtGcGJoOMzHmHGP/HDKvqAvZiAK8IPPq4zaY9oKJxtHy4XK8H0LXa7f9AuOkVzU3Y7f
         I3HUO1qVIfGihmcPMDF4cuz5RpeonovXEMFYjS6QOmSeMfh+d0xbV/vMZcE/cmlaRTxY
         P2cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795052649; x=1795657449;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mPgaLdPVgN+EK8/t5TKiyz/aU8rMoF0nQ5/fzMmP53M=;
        b=gBtVVklLge7zK1iSvDZgxylkA9V5HKAbEAsudbl1qVFw/pUhSEDPrMKm9VsYpHsmlu
         d3mk6+RW13qM4scqQ8C2g0VW241ZxwC2ill6qTdlir0rJm7Ws2DTckpV25gSqyAX6FOU
         JQzRZ5dq08Xrg2dQkjyUKdaCT4mvU7Njp3fSBBff7tLljoLo9Ore5HgsPhCmfVCUAQML
         Sc1leUFVgdvL91W3yJe9+tT37YxrSSA5DYojAIXCsQI2a06oHnw7qyFuutdlDU2DMHH7
         64f/4ND+zU/OaD79ZnRqU902Ky3VrOStUocxe6Wrz/dR2tB6a0+4nOtSq+k7m93jBNCJ
         w+ig==
X-Forwarded-Encrypted: i=1; AL+hErG3XE1Q8iITFdtQvFo6WyeDcr5xC5FabuMrOvzIouuEhEROU7wIn0srXgnjnkBV8VWSWf4=@vger.kernel.org
X-Gm-Message-State: APuU4Z/0vdfV2Ui4WOpGMaTQj7L/1OMDfms5M+Lq2EQXSFf9eKUS8vZg
	5d4ci6yrCpNSC+sFHLESRQ9gysAGALkANiLt14lhCy8E+3j0TO4XiaH5
X-Gm-Gg: AZFdTZeNAdNFdrfqnmf8zgnbFVxQhynZIXtzow1xBOLyowTB6F3/vKWaHYfQ380fzsP
	X0nqanOemy9wSoNtAxLQ8Nvqpggu/4xUIDw7sTpqQbRMlc5d+UFq2BICu+omv3oilgu0BM2ESFd
	16es+JTDOAxZukLhdNankYOhTpQaWwkRCqZ1L8c23olVgLlMybpUejJOXftUXTTBfo9TmlCc3kV
	1olcPpsOWOSJ9mAmDdkqCz05g0DrxqPwI8QIJYL7ZgVDJmItbukl3KPUcZC6NnmCuZGKAMQBEwy
	vk5kchhf8I+m2IBdS1CvsXRC4lit6E90nkFpxDqo87IjxmuxpvyhTgTlrQ1LSERxFtdCyc9PBKQ
	dCO51m+byCJjdTx98lGBuYmKurpkzH8EX8uxDkgU4P/yIMm2ymM4U+Pi6/O8nfBtTfuow5heh/f
	LgtL/JP51YNryHy1BRVJUKUKpcCo2V/TrrLeGFtAWcw86DwKuwoDvQ4YkdAnIITKWo61/H9shxI
	bsZT/IDS4vFAiP7GHvuHjllDrn7Knj0bIIj/Iio8AMXNQ8weS1bTd2+KxTzBGksipz0ZFgD1OEC
	6puav+mIaZRR0jI+ucpYKQA5Y4Ggp9Fn4BnYqSbnzOQ1aFAKaAyWAv+HQNsftFKCSNXf7dNE0zn
	ZB9gc7WtX+x/Iiv9lqTnPjahtkRqSvqJCAg==
X-Received: by 2002:a17:903:ac8:b0:2ef:efaa:17ae with SMTP id d9443c01a7336-2eff7575092mr37768725ad.71.1795052648514;
        Wed, 18 Nov 2026 17:44:08 -0800 (PST)
Received: from localhost ([153.61.198.246])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f0114fd607sm10146885ad.73.2026.11.18.17.44.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Nov 2026 17:44:08 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Thu, 19 Nov 2026 01:44:07 +0000
Message-Id: <DMYT224YKW0Z.2NAT6FTR68NQE@gmail.com>
Cc: <daniel@iogearbox.net>, <andrii@kernel.org>, <eddyz87@gmail.com>,
 <memxor@gmail.com>, <martin.lau@linux.dev>, <song@kernel.org>,
 <yonghong.song@linux.dev>, <jolsa@kernel.org>, <emil@etsalapatis.com>,
 <ihor.solodrai@linux.dev>, <nathan@kernel.org>, <ndesaulniers@google.com>,
 <morbo@google.com>, <justinstitt@google.com>, <a.s.protopopov@gmail.com>,
 <bpf@vger.kernel.org>
Subject: Re: [PATCH bpf-next] resolve_btfids: Match the arm64 NOP opcode for
 LLVM 24 in text_mc
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Alan Maguire" <almagui@kernel.org>
In-Reply-To: <20261118194030.4103149-1-almagui@kernel.org>
References: <20261118194030.4103149-1-almagui@kernel.org>
Content-Transfer-Encoding: 8bit
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Wed, Nov 18, 2026 at 11:40 AM Alan Maguire <almagui@kernel.org> wrote:
>  		if (it == by_name.end()) {
> +			if (pattern->optional)
> +				continue;
>  			error() << "no opcode " << pattern->opcode << "\n";
>  			ok = false;

Thanks for the quick fix. Applied.

But should we go further and skip unknown names? Like:

diff --git a/tools/bpf/resolve_btfids/text_mc.cpp b/tools/bpf/resolve_btfids/text_mc.cpp
index 57f45a4..bfe9824 100644
--- a/tools/bpf/resolve_btfids/text_mc.cpp
+++ b/tools/bpf/resolve_btfids/text_mc.cpp
@@ -165,10 +165,9 @@ bool read_regs()
 	return ok;
 }
 
-bool read_opcodes()
+void read_opcodes()
 {
 	std::unordered_map<std::string_view, Opcode *> by_name;
-	bool ok = true;
 
 	d.opcodes.resize(d.MII->getNumOpcodes());
 	by_name.reserve(d.opcodes.size());
@@ -194,10 +193,9 @@ bool read_opcodes()
 	for (const mc_pattern *pattern = mc_arch.patterns; pattern->opcode; pattern++) {
 		auto it = by_name.find(pattern->opcode);
 
-		if (it == by_name.end()) {
-			error() << "no opcode " << pattern->opcode << "\n";
-			ok = false;
-		} else if (pattern->kind == TEXT_RETURN) {
+		if (it == by_name.end())
+			continue;
+		if (pattern->kind == TEXT_RETURN) {
 			it->second->is_return = true;
 		} else if (pattern->kind != TEXT_OTHER) {
 			it->second->patterns.push_back(pattern);
@@ -208,7 +206,6 @@ bool read_opcodes()
 				it->second->nop = pattern;
 		}
 	}
-	return ok;
 }
 
 const Reg &reg_of(const MCInst &inst, const Opcode &o, u8 nr, bool def)
@@ -422,12 +419,16 @@ bool run_tests()
 extern "C" const struct text_arch *text_arch_init(unsigned int machine)
 {
 	static text_arch arch = mc_arch.arch;
+	bool ok;
 
 	if (machine != mc_arch.machine) {
 		errs() << "text_mc: built for " << mc_arch.triple << ", not for ELF machine " << machine << "\n";
 		return nullptr;
 	}
-	if (!create() || !read_regs() || !read_opcodes() || !run_tests()) {
+	ok = create() && read_regs();
+	if (ok)
+		read_opcodes();
+	if (!ok || !run_tests()) {
 		error() << "the table of the arch does not fit it. Set LLVM_CONFIG to the "
 			   "llvm-config of another LLVM, or switch CONFIG_BPF_FMODRET_SCAN off\n";
 		return nullptr;
diff --git a/tools/bpf/resolve_btfids/text_mc.h b/tools/bpf/resolve_btfids/text_mc.h
index f2add1f..914a00a 100644
--- a/tools/bpf/resolve_btfids/text_mc.h
+++ b/tools/bpf/resolve_btfids/text_mc.h
@@ -13,8 +13,9 @@
  * It does not say what an instruction computes: the selection patterns are not
  * a part of it. And the headers with the enums of a target are not installed.
  * So opcodes and registers are given by name, as MCInstrInfo::getName() and
- * MCRegisterInfo::getName() return them, and looked up once. A name which this
- * LLVM does not have is an error.
+ * MCRegisterInfo::getName() return them, and looked up once. A register which
+ * this LLVM does not have is an error. A pattern for an opcode which it does
+ * not have is left out: each pattern has a test, which fails if it is missed.
  */
 
 /* A condition on the operands of an MCInst, like an MCInstPredicate of TableGen */
diff --git a/tools/bpf/resolve_btfids/text_mc_arm64.c b/tools/bpf/resolve_btfids/text_mc_arm64.c
index 5d2fa8a..31ca6e0 100644
--- a/tools/bpf/resolve_btfids/text_mc_arm64.c
+++ b/tools/bpf/resolve_btfids/text_mc_arm64.c
@@ -25,6 +25,7 @@ static const struct mc_pattern arm64_patterns[] = {
 	/* HINT: nop, bti, yield, wfe ... */
 	{ "HINT", TEXT_OTHER }, { "AUTIASP", TEXT_OTHER }, { "PRFMui", TEXT_OTHER },
 	{ "HINT", TEXT_OTHER, .nop = true, .predicates = { IMM(0, 0) } },	/* nop */
+	{ "NOP", TEXT_OTHER, .nop = true },	/* nop since llvm-project PR 170968 */
 	{ "DMB", TEXT_OTHER }, { "MRS", TEXT_OTHER }, { "MSR", TEXT_OTHER },
 	{ "STLRB", TEXT_OTHER }, { "STLRW", TEXT_OTHER },
 	WX("LDXR", "", TEXT_OTHER), WX("STXR", "", TEXT_OTHER), WX("STLXR", "", TEXT_OTHER),

