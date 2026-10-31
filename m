Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793483777;
	b=g/I5w0XlY24E59+7NFvpV7X6/NBvLx10KaZZEH4GE/oAbcdDBX+HGSw80mPVs/6kdwLH
	 qVIJxo3TwK6B+Q5TwKUWUpR3mKWpvJLpHOgZPuC4WeD33/CgxXbgE59JhPGHjqKr2/w9k
	 NgT5EW2nrJK2v7RCApDzpiIg7VEmLHld0Ci60LwPSGEtotYje4P+B4IZr037JlOQf8S5T
	 kttGeF7MQdInBcriOL8AIMJkQ/vjyZwEjgCdOfJGDErfwty0pgH1lw4gQxME/7tGbdknJ
	 ESeU0gYag46JKYa0xfbJnmkg7AIRRAU/UsrK84sAbrXlm5SHawUg11/2koDsWnTHmsQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793483777;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=vqSh0uZ1V0W/BdRWlLoVmtHOwoQQs1uY7VkISMDOrTg=;
	b=BLN5aCwyqFNtfWg8X8zVEMdbg0NaVKjkw4037ETKWXuWEuZUNFH6zhCOy92/0kx3jV74
	 vDYdEyD1nBVSRWUv0SzkDRmzYy6hfAU5lXIHUKQiLm4U8BbABQPSWtRDqM7Jfs7gz75s9
	 WNBYVBSh+NR8lZv1C0d3RYQeP3zirejBUu1u1FRJA3JYA+/YL3a/2t4IK4qzuZK19MUkN
	 B3KT9FYK0gd8H2oBau28dlPtGQ4K3r/PTvlTFUXYXgKU8fpDMbcFFWy2B3h5/trvCToqy
	 juVaFUPRg/GBHsmvp64+GkhdqLfWxzBQQr5AhZsLE4SNsXSRzzxeciIu9KP8rDhm1Vw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HkSY+omm;
	arc=none smtp.remote-ip=209.85.215.175
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A74606A31C
	for <bpf@vger.kernel.org>; Sat, 31 Oct 2026 21:56:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C7A74606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HkSY+omm
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-cd623dfe420so1391314a12.0
        for <bpf@vger.kernel.org>; Sat, 31 Oct 2026 14:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793483776; x=1794088576; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vqSh0uZ1V0W/BdRWlLoVmtHOwoQQs1uY7VkISMDOrTg=;
        b=HkSY+ommD6cUp1uB34YGRWbrypxZrRE13c3Jqsr345XErpqjKBm9wxonlGwClkZta9
         nUisl1dfZE46SYGQ9bFWUcU4DDVD/NQth6yt67kJ3Kxisp0qX32V2P8dydMwnvwGIVTM
         xx8Jk/6GaIDiU1YebuUycWQOhLmjmqvzBCxJIxEsxkhsuY4TbBSZVbKtBjyCfnLIRW+O
         cKGyRzAVNYD8zfL1SiSWTRVv3wZ8ms0+RofNuzUpT59eLaPmqJZHeCXtffZ8jQ9jzNFZ
         TIBVKyzGyF066Yft3JZ1sq3Eiw4mEFf/ybnmV8x+y4YMNgkjr+J4aKvX1cEBT9mJGoLN
         7ZYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793483776; x=1794088576;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vqSh0uZ1V0W/BdRWlLoVmtHOwoQQs1uY7VkISMDOrTg=;
        b=BOIb7WsOubU8RRx8TlZ8wAa4FCABLYeqTzjVQDcyhOriQo6EpTYOTZSxx2T6Tyjfan
         lZyHiXs1x0lDDgM3JbMKJsEXpTA3cjZDNp6OAJ6yLj1K4lwgSOP7SDLk7DKRSfZZ5AWM
         sX+39/IUqDKTVmUSJew49t4OYh+vXKjyuXt7nidtrsAeDR6IFZ/AHwAt1lPOodsc959u
         f71F5kE/V55chjqgkSc6L0EPNrjYcv6TVgz6HwoXkhLPcr2OLLMlK5yfaAmZrBRVaQh7
         3lfmtNqYkyjfK4UAkXFTpxcUsvp+rIyRoUDc+uF44Y/FcZykzfaLHN0tQxbjBnl7A5Kr
         j3bg==
X-Gm-Message-State: AFq9FYIf8h0pu/rV/xTXvucg40SJHoG0+y0wquzWDff8840jTEpDXpy6
	ZwuVZtUjLgZH/tewX+Cr49MHtbNxqPDeh1fwP1jwhI/m2/FSpG66YhkKaYDYyQ==
X-Gm-Gg: AYBFou2RVAsq8moG3rJq5DmzHi20Y5EPbHJ77VKlBbQUkW3FsOjqTluD8LoMHaystwz
	lLUDRdesCb/Ft22q/eUZpozyXAnkrxfSCqLdeybO6eUYJPk1VbbFl8KKN6PRCgQM0AKvq7GcDXc
	LORc41jVE++1RK9KMibI4AwuFUAD+zCirFKa1cDlnlVjTsrpJscta2GP3ZSN+N6/oymDiLgnPXn
	rx3toddigRmribh1vhb2d/wIOAhXUohcoh+J5muAwoBhRtk0g/W7JAZEEk8m4/PDXrtUHnXOh1I
	95B7IFfx2eEu66sEIwDo2vsqttgCXPjLHg9eVU75zCJ1ZuLARJCJEWkaofI2L75XE3jsxsDFzez
	4v+s2uun/Cg4P/uuMz1yX+VQ/PpqgPlfv41bNFGZMsBeTaY5ZeeYB7hGX+PKuRTx31F9o2SqXCI
	JlRpZ1b93s6e7/aQR0X1Nh50lyuFMoRBq+IJWWGKFhz9Npv+zhxSd7DHwfOVF1rQCCKwKV4tXg8
	opmBh/0aNWhFviC0A4G91DuDR38xtPRiOBxU78GdtgEBrxINlmf0tSLlqsXCgrJccwGT8Bit3uD
	BbFGeUYyoFBisSjHS4x0ghz2/d5WPYiajjM9clzAFkilWPtcvpyL3gMWRX3EWtaW/0eCq7Cdg+h
	ENMdtUSRIbGk0/yc61uVci/BAEzDgTxtN2Q0v3df8r6hCLTNfLWl7k8CVTGtLf2MyJxJidvOVgv
	k6YMEy0kAyyMZ/Pl9JH/U=
X-Received: by 2002:a05:6a21:62c3:b0:3e2:6f90:b544 with SMTP id adf61e73a8af0-3e9288224c3mr5582604637.0.1793483775986;
        Sat, 31 Oct 2026 14:56:15 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.246])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8aada6bfdbesm888237b3a.42.2026.10.31.14.56.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 14:56:15 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf v2 5/9] s390/bpf: Support internal-only MOV instruction to resolve per-CPU addrs
Date: Sat, 31 Oct 2026 21:55:39 +0000
Message-ID: <20261031215543.682284-6-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261031215543.682284-1-alexei.starovoitov@gmail.com>
References: <20261031215543.682284-1-alexei.starovoitov@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

The verifier emits BPF_MOV64_PERCPU_REG to turn the address of a per-cpu
variable into the address of the copy of this cpu. s390 keeps the per-cpu
offset of the cpu in the lowcore. Add it to the register with one insn, the
way the JIT reads cpu_nr and current_task for the helpers that it inlines.

With bpf_jit_supports_percpu_insn() the verifier inlines the lookup in
per-cpu array and per-cpu hash maps, and resolves the address of a value in
a per-cpu array. Patch 7 needs the insn for may_goto.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 arch/s390/net/bpf_jit_comp.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/s390/net/bpf_jit_comp.c b/arch/s390/net/bpf_jit_comp.c
index 56ec49894dda..ec32e10be24b 100644
--- a/arch/s390/net/bpf_jit_comp.c
+++ b/arch/s390/net/bpf_jit_comp.c
@@ -1005,6 +1005,17 @@ static noinline int bpf_jit_insn(struct bpf_jit *jit, struct bpf_prog *fp,
 					(jit->prg - patch_brc) >> 1;
 			break;
 		}
+		if (insn_is_mov_percpu_addr(insn)) {
+			const u64 *percpu_offset = &get_lowcore()->percpu_offset;
+
+			if (dst_reg != src_reg)
+				/* lgr %dst,%src */
+				EMIT4(0xb9040000, dst_reg, src_reg);
+			/* ag %dst,percpu_offset */
+			EMIT6_DISP_LH(0xe3000000, 0x0008, dst_reg, REG_0, REG_0,
+				      (unsigned long)percpu_offset);
+			break;
+		}
 		switch (insn->off) {
 		case 0: /* DST = SRC */
 			/* lgr %dst,%src */
@@ -3116,6 +3127,11 @@ bool bpf_jit_supports_timed_may_goto(void)
 	return true;
 }
 
+bool bpf_jit_supports_percpu_insn(void)
+{
+	return true;
+}
+
 bool bpf_jit_inlines_helper_call(s32 imm)
 {
 	switch (imm) {
-- 
2.55.0

