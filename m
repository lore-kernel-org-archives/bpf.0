Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793622753;
	b=dYmlXF0gg1pczlwPx8J2fcOjE5pm6v2yHmV8mc9LEP8/BwqutdYSkh8GHi3w2wJg+K+8
	 lIXy4fAi90+NFBBXX0krc+HgSn0197/60i8XIBiON/nZ7x89FkPeEkjzS/3wMIq2zp1tb
	 HSvWXXF3xldPJdeKZ7IFeQM7N8rOZ5Q/ToVuFXEPAeTzSO92o0W49JW2iJKmerDjntaWd
	 tThC+kcMhSmpVsd4cofaHLt1igZ9xSVyvcXq3pzQFPl3HGKMxtSK1Wh5Re5XMU/MIuW+V
	 VESaU0p92h166HctlVV7HJqucH0O87IWyuQ/f1S6JMxYxkjjEtYtvhP3gW1UX2+My5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793622753;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer;
	bh=X7HK95+Ejz25JT6Hfe+wCQgxilDD6LrZVyreaMFx54o=;
	b=VZ8mrp4HdtLIunuYvgbUAifcwtAggyxDVtigzJFK+mpZoTq3URViLGnuOM45M5ZJH0TL
	 lKVNju1MdrPIOZJDLcZ5+Gl8pgN8Up7TbOo2nz1C797RK0ke3n8abEBCRny1yxp87HXn7
	 +8Ua5PwzvAGfEHSPH/IH/vCVkQkMp+VigWf02faq4y2LV1uem+MbpmbV/dDaRrEy98U30
	 E5Gz/v1jaonKQADlG8TCAipoXLMoeYMcvDe8KV75USZL1zkMA9rLEc+ypbVQYdtbgkUZk
	 UsrMGlv3EIQqUl7TVN5AKAuoedYLUT7nsYR0dTcsNry/DjHGTHD/tN/n/bNsnIRDq1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="c/E9KdFk";
	arc=none smtp.remote-ip=74.125.82.52
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 334C4606A33A
	for <bpf@vger.kernel.org>; Mon,  2 Nov 2026 12:32:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 334C4606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=c/E9KdFk
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-1ae18eb9ad0so2671132c88.1
        for <bpf@vger.kernel.org>; Mon, 02 Nov 2026 04:32:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793622751; x=1794227551; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=X7HK95+Ejz25JT6Hfe+wCQgxilDD6LrZVyreaMFx54o=;
        b=c/E9KdFkkQYlPtAuldaJu88tZq1+LgL4K4loOdTzgo6lVjbL+9mjVIc/qHzxkWJmRM
         qO+GfXKnyZ28hwG0cDofLMGssranDxNP1faLTCAkQntDWGo6CCnLJSQ1hiJJtd2acTaI
         7WhzNsMj0IcHIcXkWG2Q6eDQFSM19xV6hajtlIiyqi9yLlX9ITyY5KJkXLI6fejGkNT+
         Mk2aQPaiD7U1FOWlRH6PfG7ZsH+wOs5hx1XLUdX6MOcw80i9iaCuWKPDA+0yCwg6h/65
         sAwBROTPU3h7mARWRVou+4/iROk3ji+SS3WfmRw3ZwYyY7n+54qkjs6UQFdOCMXKyzLk
         J+6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793622751; x=1794227551;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=X7HK95+Ejz25JT6Hfe+wCQgxilDD6LrZVyreaMFx54o=;
        b=kT1QvqHk2D5lMS9OQ7PDazCuiByj1d3IBMIOo5UDHNvMrFBRowTIsPbvC26t7Es06Y
         FkSlJpNaM3SqHM+BURGq33t1RM39YyQL3+ESpMZ7hUPuUu8USavCrjyJY5yDYCFIGh9+
         lqtrQ2QTvlnD/DMasgvz9XHtYusOOLdszIcOl5BayEUPLQiLRzNM5BS5s0LbDi6UdHMW
         ptjOm/aEJ0A/M2mwZoldlO23nRVdtMhvtu3GRTSTU37JTGLXrrNbTsAmS9N3WTPYIQ1J
         EkFR+PfZq0+TB2oey6qcnArD3Eh9ZwAcuRyuKiyOGfdhaeNPlSrRmQEG1Q4xSpbgeeCZ
         lvOQ==
X-Gm-Message-State: AFq9FYKZ3FMOZp1W/WJd4dmPpljpvulBV1G4dU3Yc2Bm2Ry/Ut8K0Ehn
	nXo92QdJ2JdLnyrnPA1aOqwg50AVbKwM1LNsmL70ExPtHzBYPfjabXkp
X-Gm-Gg: AYBFou34rQADGa0aht5XrE/5lC5Tcz0xpvEa/GLGL3H7RE06yu9sFvAkCm4UPUtnAHc
	Fv9qSv1FKnhAE9xcYzlePI6maIbTUBvYIaReuzGrzWE+7+YIpA+ez92oOfMiNf0zJZn77C8vh1/
	ZasDF7uiuDtAqiIQq6XIuioOcg6h8JgRxsJ2f9hO2GHHi9tzeWWbJLNRDe1NBvE9zE+938P6Jeg
	Zl2YLdKoXFe36kKu92o6JxW/cSPKLh6WxmEO+YcSpB6+SWr5vz2Q0fKP7x70bqtzatrr0cghtwR
	110TtKpn8WTiIR7sRb4pWQDXQHn+YjNBE7oEW8wnl8invgTq3iKedyMQzE6zADtWztCFrzGalXc
	pyBZ+OY2QHq7VzX2P44NNFdLD88xOr+ubevhkdvQkdiFiMlwSbukfCfzcovr22wx2OPUCe9lDr7
	Rqsq4uyISwR8WhaMLClF6GqhEeV3Aw31TYFfZGLLLMvX9D/ayXn0x22ctSzp9BiL5j/ePHNPqbE
	Ca6dtJNvY6+uqbc69kwpUtj8rndCkcCnXrla/I1LbQx1qHR0sMTxLFGZ/+yNcdIgDHZ6ejLIPQe
	sFxuHRD63Mdi5Mt+FIWvi12qff3c9qVz3T1ju1b6SHiv680=
X-Received: by 2002:a05:7022:fc05:b0:184:992:c9ec with SMTP id a92af1059eb24-1ac5fd06166mr10389427c88.38.1793622751151;
        Mon, 02 Nov 2026 04:32:31 -0800 (PST)
Received: from [127.0.1.1] ([23.254.208.9])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b2360d2066sm4950951c88.11.2026.11.02.04.32.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 04:32:30 -0800 (PST)
From: Qiliang Yuan <odys.yuan@gmail.com>
Date: Mon, 02 Nov 2026 07:32:13 -0500
Subject: [PATCH bpf-next 3/4] selftests/bpf: Match the insn number of the
 out-of-range message
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261102-bpf-patch-list-followups-v1-3-ddc8ccf40f43@gmail.com>
References: <20261102-bpf-patch-list-followups-v1-0-ddc8ccf40f43@gmail.com>
In-Reply-To: <20261102-bpf-patch-list-followups-v1-0-ddc8ccf40f43@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>, Shuah Khan <shuah@kernel.org>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Qiliang Yuan <odys.yuan@gmail.com>
X-Mailer: b4 0.13.0

"patch list: jump pushed out of range by patches" expects the load to
fail with "insn %d cannot be patched due to 16-bit range".

It matches only the fixed part of the message. Which insn the message
names is what the patch list decides: the jump that got out of range,
not the insn that a patch replaced.

Match the whole message, with insn 2, the jump over the divisions.

Fixes: 67d4d0b73c29 ("selftests/bpf: Test jumps around patched instructions")
Reported-by: Alexei Starovoitov <ast@kernel.org>
Closes: https://lore.kernel.org/bpf/DMKHZS5B5CNO.186F6YH1T6YU4@gmail.com/
Signed-off-by: Qiliang Yuan <odys.yuan@gmail.com>
---
 tools/testing/selftests/bpf/progs/verifier_patch_list.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/progs/verifier_patch_list.c b/tools/testing/selftests/bpf/progs/verifier_patch_list.c
index 3ba99cf16e96b..045081936d73d 100644
--- a/tools/testing/selftests/bpf/progs/verifier_patch_list.c
+++ b/tools/testing/selftests/bpf/progs/verifier_patch_list.c
@@ -128,7 +128,7 @@ __naked void patch_list_may_goto(void)
  */
 SEC("raw_tp")
 __description("patch list: jump pushed out of range by patches")
-__failure __msg("cannot be patched due to 16-bit range")
+__failure __msg("insn 2 cannot be patched due to 16-bit range")
 __naked void patch_list_jump_out_of_range(void)
 {
 	asm volatile ("					\

-- 
2.43.0

