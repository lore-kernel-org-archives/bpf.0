Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793729883;
	b=nBTuptI+YJwO+DawMU4mQIcoUUmbaaJki9aCMulC8G2DsxZlaczzaD+0VMxI9XH7IXYV
	 ZsUBoOyMr/xtziUVgMWAAHbqtKDwXmREprInLrfhvHuEW/2GhqZD8PS9UJOQSw/MtRl1d
	 x+ttj73ZqUpRzIycFipkkI2MZ9DUrVRm8gHCR3FaQ6HNTePrS4hR8jHplN4tDLZihMPYt
	 XZ7yvyBqZExsXqNu4+AbFcI5s4OZ13Vol8BhITSF+W07ku8gW+KeaoUFgqwMrmmhjXDV3
	 AbcUEErc9x/HD6Wskri3mdmhLEtFCEnE4VbmnBRtFeUindca5pr1i25xSTmZfN7PIcg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793729883;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=UTXYGVplWAO8VvUr57iHtg64uySoLqOFfaNXV4F6AE0=;
	b=nmFlfysL5klqnNl/sZJk4mkDbfFEw6oNHsMLA58Yeah/y168BdEFV/w5HbCCVS0tJETc
	 gOpzX006UeSbFWnJsnZFAR/5AML+XhWG8Os/ApWqfJ8LQ9Gst1/cIG03anZJdK0IQC270
	 TmG8cYKvZOId8xvTEAJxa2BOktzYqjcT+qQ2zm8iLiLR15H+Nctlt26BMhOnXDWPwKxoU
	 ttUjp/nrnVtxzt/Ma4fEzkLMjsO1vDk5u9677uUhvsQDmhpdJ+Td+3DoYXW+uOZ8DTADj
	 /DLr2ojhlhRbcTxWEnaTN+NEPPIyn5TGjvAz7vNv3pqKezmTr1w/O9FzPUVXZ421JWA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pouAy1+o;
	arc=none smtp.remote-ip=209.85.216.53
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1204606A324
	for <bpf@vger.kernel.org>; Tue,  3 Nov 2026 18:18:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A1204606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=pouAy1+o
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3ac91ac8924so2372075a91.1
        for <bpf@vger.kernel.org>; Tue, 03 Nov 2026 10:18:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793729882; x=1794334682; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UTXYGVplWAO8VvUr57iHtg64uySoLqOFfaNXV4F6AE0=;
        b=pouAy1+ok7smtwkWcvXNMyZ+av0YOdP0F2CTGZJOdo1h+iagn9OJO5sfsRkmcddUsw
         /Z/npUVUN5GPnT/E9FigiZbxl74IB5Nuz4RC0yOOKHHfGNW6zJA8m7jbSQTn9U4irWsj
         XvNRItPUfHKulRKzdu7VGzij4llfxI7+zx9vvw2DKTps7MupL8YztsuLMMzNdSrZEzFr
         /IUbp8dxpt71AtJmpe6ZsnL443v1SzH45RkK7sWebng/CrGRt8kY2q5neiOxe+MUZpIS
         YYtsSyTn8Sz432BXUbsql1oJYhZP7lhawuqZnQYPO6fV/Da3R5YdqFW213nIgnI6zwsU
         AfzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793729882; x=1794334682;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UTXYGVplWAO8VvUr57iHtg64uySoLqOFfaNXV4F6AE0=;
        b=xSi0rPzIWVV3KHdQDu1YfGIxCVrLpkftvnZ7d7lYWYfOK99OsnT5nWg1QmwccXvOwS
         suz0sr29tUaFFw1Bmyl0hZ8fXBwR8OEKlpU8ukgzsCkSUwOYvJ1z0un2Twyk+fOBiCrg
         vDKMfN7Z7xE149aMWW8NmpFj42W7/yWyCAEEBoo/hilB/LCC2YFr4nZm35Dz3KQvEAwc
         PJQRd7m+DgQ2r0FC67HUQVQ0dp12Uuv64+SrHoLMdj+RTzyoYyal2CT+SjU0Nv/kiyQw
         S/kmBRPnO2qelbM2dDby3LtZI8ux0Xz5YSUtOJ0cGEAZHanteezG+z4TpVxlHoXgLeHH
         SsDA==
X-Forwarded-Encrypted: i=1; AKwUvByGxUl/yCPjaA3LnUr/YoMqcxP19fToZNpkAPOrpKrVvv6dLryEPS1/I/muuIydwfkMf0c=@vger.kernel.org
X-Gm-Message-State: APuU4Z9NYCyeYscth+rK5bFUGOBnVVA8Kc5UNgKwYdaidiFekEAXeEdf
	7wmONOSh/GCLm+bTtefp/xdHImOKGl06zTVu7LVD+n9EUN8qqs4QRGhO
X-Gm-Gg: AYBFou3hGoyq3ZkYhegmHWanjmJtJvJG3xnHX8+UipK9ntiKaBD1H0/JhUz08HKMYyw
	P6w4jv1HqMjnktfKoipfUqMR/2LpTJPgWcJEluE38ejbuh2MTFlKbenuCSIKPrREjpWxpYGkGYv
	x8ZuvDCwsaMAdF4SaImtT7sf3VXXItUHO3l+Cekr2pK473MATTzUlOGEt3R/v5ilqyMS2vxddp1
	/DPX9VR080pUkuRZCGb3OGEu8IGCt00h3qeXXFR1hNHa8Kb+0hI42x2iYItUY/aNJYxQe4yHDdS
	yt7lpOufevbG7rl7aoSIOr1TIk5Cq0LUFWPFDALCoWiW09nBhG6Jj2wkSpa8kXrCIboffL2uqaZ
	EZHA3K4CYWMQZ9T39zvNd85tJFM0Qg+qtq1AsIqGjQKgKPduQrTag7jfciXjKyG0I5je2ZiD5sx
	zBou30nZmA44LjoLrsYJI5vXpuBu48UpeBT7cAadGDB7T/iUtklcjBdExBbv0KujAKCeXegfV43
	a2k5Jx5K8uuCxat20Mmus68RDUFtS/hn1OA2Cvuou98siHlX3h6shFD74/eI6NsISkCk234uNsZ
	fpABKIseygHFmLEBIfeH0xWNJ124buAlfUNNK3oP3TWj/00IcplPHJLnEdswkGTm4PcD9EWcLSY
	izU4bu+23o32D3ADB3jvakkFXGYyMHrg+UJMpSXrH6YxCquLL/MrDWTk=
X-Received: by 2002:a17:90b:3d4e:b0:3ad:1841:6f8b with SMTP id 98e67ed59e1d1-3ae8981e41fmr10183965a91.37.1793729881831;
        Tue, 03 Nov 2026 10:18:01 -0800 (PST)
Received: from localhost ([153.61.198.255])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b07c7e087csm5445702a91.4.2026.11.03.10.18.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2026 10:18:01 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Tue, 03 Nov 2026 18:18:00 +0000
Message-Id: <DMLS6BDLXMCV.1C0EN486O4XLV@gmail.com>
Cc: "Jamal Hadi Salim" <jhs@mojatatu.com>, "Jiri Pirko" <jiri@resnulli.us>,
 "Martin KaFai Lau" <martin.lau@kernel.org>,
 =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
 <netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] bpf: net_sched: reject bpf_throw() in qdisc teardown
 callbacks
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "shaos" <shawnq1@163.com>, "Amery Hung" <amery.hung@bytedance.com>
In-Reply-To: <6AEA1AAD.2E7977.08739@m16.mail.163.com>
References: <6AEA1AAD.2E7977.08739@m16.mail.163.com>
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

On Tue, Nov 03, 2026 at 09:32 AM shaos <shawnq1@163.com> wrote:
> A BPF qdisc's generated reset/destroy epilogue cancels its watchdog
> timer.  bpf_throw() unwinds directly to the exception callback and
> skips that epilogue.

That's a bug in the verifier. bpf_qdisc.c is the wrong place to fix it.
gen_epilogue() is a contract: the epilogue runs before the prog returns.
bpf_convert_ctx_accesses() puts the epilogue in place of BPF_EXIT
in the main prog only. The exception callback is a subprog.
So bpf_throw() breaks the contract for every gen_epilogue() user,
bpf_testmod included. Fix it there.
Then bpf_qdisc.c doesn't need to know about bpf_throw: no BTF id,
no QDISC_OPS_KF_TEARDOWN, no forward declaration.

Like:

diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
index ead7871..5363e88 100644
--- a/kernel/bpf/fixups.c
+++ b/kernel/bpf/fixups.c
@@ -909,6 +909,11 @@ int bpf_convert_ctx_accesses(struct bpf_verifier_env *env)
 			verifier_bug(env, "epilogue is too long");
 			return -EFAULT;
 		} else if (epilogue_cnt) {
+			/* bpf_throw() leaves via the exception callback */
+			if (env->seen_exception) {
+				verbose(env, "bpf_throw would skip the epilogue of the program\n");
+				return -EINVAL;
+			}
 			/* Save the ARG_PTR_TO_CTX for the epilogue to use */
 			subprogs[0].stack_depth += 8;
 			insn_buf[0] = BPF_STX_MEM(BPF_DW, BPF_REG_FP, BPF_REG_1,


> Fixes: 7a2dafda950b ("bpf: net_sched: Add a qdisc watchdog timer")

With the fix in the verifier it's
Fixes: 169c31761c8d ("bpf: Add gen_epilogue to bpf_verifier_ops")

Pls add a selftest as patch 2. bpf_testmod_st_ops has gen_epilogue().
A test_epilogue prog that calls bpf_throw(), with __failure and __msg(),
is enough. See progs/epilogue_exit.c.

Pls target bpf-next and cc ameryhung@gmail.com on respin.

pw-bot: cr
