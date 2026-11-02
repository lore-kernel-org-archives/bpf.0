Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793623040;
	b=DetfZyg/LDs6K0IDIohi5lZlApdDnxTL+/0ohjTmLvWToPWjqveL8RN1Mcv4+A48sqgY
	 2NMJW/7Fp9cb/tGymv3aCIS3k46lhZ839wvWNA9NfvGhRrm9ntIbfuvylTQCVKj5WLdhh
	 HWhWcBObl0+zLGdOuCIKgRRRjXNjJpDPfg9r9z+ti2b+lTw+z+r3/Vc+HrdGDc97xJ77h
	 iQG/TEEX2DW4XOeN9I9YMUINqN9PokbIrwjYlZ+Yzbj+fEJClbxtw33OpG3EpIlcmktGd
	 lh5tKmGxe8gLZA/ZzVhPOjYwrYDfBxl1GCcs6YXgUAt+hrG14Xcv0gnoLoVz3WD+htQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793623040;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer;
	bh=UjBzccaJDDlTsbT7lY8oUdWUO7cHir5+ebQJXokkFqw=;
	b=AmHalKIQpkrTx+p+LcfuLLXIz6ncQpiUqlbx/T3PL2+ZJ7riVm0xlBBMpFjiesf+G2Ro
	 ZshMWRAE7lU/iVpLMA0xc47Wlbn8qUzeHPkPRXptX8MYzXW5McCJtqLUYClkPWJrnkxru
	 g/2xiN5pd8oMXwYcV+FcZfaCH3Gwk3Ot5TifHuKYPAJhy1dNVd+ti1DLVMYgM4IYTS1Tu
	 d3+DBRDc+a3yrTPtniHkygchonJs7gHDqK2JNpdLAKcldOVOswhBJ1zfJZpsi7IAgK0YS
	 xNKUGV7eFYGNSqo3aYtm0abul0dzMbEjZrapaVISO68U1XzQn9qZlJQ2BSKbRh7hIoQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pSdxvYEa;
	arc=none smtp.remote-ip=74.125.82.175
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D316606A326
	for <bpf@vger.kernel.org>; Mon,  2 Nov 2026 12:37:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9D316606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pSdxvYEa
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-3645f0f3fcdso5121974eec.0
        for <bpf@vger.kernel.org>; Mon, 02 Nov 2026 04:37:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793623039; x=1794227839; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UjBzccaJDDlTsbT7lY8oUdWUO7cHir5+ebQJXokkFqw=;
        b=pSdxvYEaXJkhqfPlsGxTuQA2m33GSpJYR2vhxJa1+ZrYumZkFLUcuwchm9jpzrSNRk
         UzkKbt37f5AeVZHpA0d15xNQJgc94ZU58Y46J3sdd8FKUO5Kk1bUzEBBdJdHu5HdXhaN
         mzPw3lO2D5zHTVHDUbdCNJnLRaGAyAl2F/7RCeuadNwmLat9snzopuhLI4IU3/t0lpAg
         yz2z35wNTZ4H8KBMop0i+viOahduXqQhtKaAfrSvNOb66VIRms7VtvYBtSe5F2rcI7+H
         XySFS0sBj6W5c4YxpowSdI9lyo5UzRZXT4V2fPBa3/8AMsQAby9x/8gWLrHvkWLL2/xn
         mrGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793623039; x=1794227839;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UjBzccaJDDlTsbT7lY8oUdWUO7cHir5+ebQJXokkFqw=;
        b=fGdGCiqXPva704/ZBtgL3B9AtOL1PdBLmeo7rWG+kKojFwr27SzfzOfFH1aaC7+koU
         WBVLcJ4DLkTzIjZs6J9dENept8aIkDs9Bl/E6FLnFaoXOMVvXM38CBwUtR9REm/+5DLc
         Iz0px2uBcmFQUK/C1UdIwJTgIAQlaOAN0MNEai/fIRJWNjIAcTcl1AIfNDK0le4fPC6U
         A/UaCSNydxCwMQhnAbn7FIZyxF36xLUoeFqjaEcwTyApn6X0zDlvMdTJ8zrZkHCTZv7m
         qPZjRcLl1pQ++5JPpXkbXOR4RzuvyyjCsxDH35S202my+UFlG/6E4v9Ei/WEQhepJz2F
         vyyg==
X-Gm-Message-State: APuU4Z9YfhAm2wJpRkjDmEuBMg+9qQbg2FKuESdueWSLtCvauX7S5tjD
	Mqf4qQp79vI4TESeDZjihmsQn/JD0k39yxof8PlVs8nwWolJURWhYM55
X-Gm-Gg: AYBFou2LSIAZlR9ofRwz/4pKTujFfg8rezhZ9VjTer1Gl4Thr4H57sc3BTiJGE0Wil4
	EiXoe9uyfm0rZWLU0UO7GqhIBCbteRLCdpM9ypYElbk8C5+2NbO/DbeJzGBFPECInWFHbCC9lzo
	/DPaCRxeM2Q1Mf9XTs4fBUYjI+4zyZ8g7j/u7XD23JZUPkLWV6SpXfSSiZzF2GMcONSNGUFE2PI
	XPE5h+9g03Yyw/KtRGgd/Fi7HaOngBJbSSEBdVksrJ4+gN2YfA+I8wBDif+0KAzSGD07UZc/uGW
	5Awa+V+06DS4l+20OCqEmFZgYoKmsAbfcXEsXMST8j3CgkTvziSZRdVUTXD1DddJ0JoV7XwcBie
	WNV0m8Z/6nmehbseEcpUNsvsgGZjRNFCUti3vZF/Q7iZvLw3ez6W9RJCvNXli32HT0DjJnoSvJY
	ko/hsWcWoZp0DUC24VEhYl5PSOLYeCROKTRywnDCxGo50AyRua60fouNtQSZxpKtlSRr+U8JDPR
	5GRxFKJXauzyj8A1Q92NkCu8rTu/7Pk6TqGRttZyhE5qsXeP7z/DnBEcslBQgJSqp4YfhMbuvWj
	7F40mARChuSBvDDCiaaVTVyH
X-Received: by 2002:a05:693c:638e:20b0:366:703c:5ef8 with SMTP id 5a478bee46e88-36a423935f0mr16041785eec.7.1793623038614;
        Mon, 02 Nov 2026 04:37:18 -0800 (PST)
Received: from [127.0.1.1] ([23.254.208.9])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a428c17bdsm36326095eec.6.2026.11.02.04.37.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 04:37:18 -0800 (PST)
From: Qiliang Yuan <odys.yuan@gmail.com>
Date: Mon, 02 Nov 2026 07:37:02 -0500
Subject: [PATCH bpf-next 2/5] bpf: Keep the barrier of a nospec insn when
 removing nops
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
Message-Id: <20261102-bpf-blind-nops-fixes-v1-2-844300e42cdb@gmail.com>
References: <20261102-bpf-blind-nops-fixes-v1-0-844300e42cdb@gmail.com>
In-Reply-To: <20261102-bpf-blind-nops-fixes-v1-0-844300e42cdb@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>, 
 Luis Gerhorst <luis.gerhorst@fau.de>, 
 Henriette Herzog <henriette.herzog@rub.de>, 
 Anton Protopopov <a.s.protopopov@gmail.com>, 
 Xu Kuohai <xukuohai@huawei.com>, Hengqi Chen <hengqi.chen@gmail.com>, 
 Shuah Khan <shuah@kernel.org>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Qiliang Yuan <odys.yuan@gmail.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.13.0

When an insn is unsafe on a mispredicted path, the verifier marks it
nospec, and bpf_convert_ctx_accesses() puts a barrier in front of it.
The verifier doesn't check the mispredicted path beyond the insn.

bpf_opt_remove_nops() runs before that and doesn't look at the mark. A
conditional jump can be nospec, then become a 'goto' over dead code,
and then a nop. The pass removes it, and the barrier goes with it. Here
the jump behind 'r1 = 0' compared r1 = r10 on the mispredicted path, for
a prog loaded with CAP_BPF and without CAP_PERFMON:

  0: call unknown
  1: r0 &= 255
  2: r1 = 0
  3: r0 = 0
  4: exit

Don't take a nospec insn for a nop.

Fixes: d6f1c85f2253 ("bpf: Fall back to nospec for Spectre v1")
Cc: stable@vger.kernel.org # 6.17+
Reported-by: Alexei Starovoitov <ast@kernel.org>
Closes: https://lore.kernel.org/bpf/DMKHZS5B5CNO.186F6YH1T6YU4@gmail.com/
Signed-off-by: Qiliang Yuan <odys.yuan@gmail.com>
---
For stable: before the patch list, opt_remove_nops() in verifier.c
removes 'ja 0' and 'may_goto +0'. Skip an insn whose aux data has nospec
there.
---
 kernel/bpf/fixups.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
index ead78713e04f4..0cc758749be9b 100644
--- a/kernel/bpf/fixups.c
+++ b/kernel/bpf/fixups.c
@@ -699,7 +699,8 @@ static bool insn_is_nop(struct bpf_verifier_env *env, int i, int next)
 {
 	struct bpf_insn insn = env->prog->insnsi[i];
 
-	if (env->insn_aux_data[i].indirect_target)
+	/* keep a nospec insn, the barrier in front of it must stay */
+	if (env->insn_aux_data[i].indirect_target || env->insn_aux_data[i].nospec)
 		return false;
 	if (insn.off < 0 || i + 1 + insn.off > next)
 		return false;

-- 
2.43.0

