Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B820833121C
	for <bpf@vger.kernel.org>; Mon,  9 Mar 2026 15:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773068458; cv=none; b=HDPgq5R8cTUArrSteEH0jtqW3GBN4+Pvf4cfWxV5J8StJrFtDX8MNRGCI+RRks9r4l5LfzYpVC0B71kOQNuaXoGonE749IIgajqilPYsyaJxR7La2mIwbk1yndyS3w6MlvxfGSEwRZWxO7fB1+ILgrtxPHTZF6nrqaOCy05UVN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773068458; c=relaxed/simple;
	bh=F3ujtuI8oi0dmg2LEg0gpPv/xj90uC+9iN3YKwWa9UI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:From:To:
	 References:In-Reply-To; b=nB/B4ON2sqyy1eSA7NhEH8yg929iJ5BhfHeHRCGKjD6Ktmzjy4b9l367jQ0THHnD5jNNszxEnKYNa8tv7t90zSv9GErOrd7PtEB1PNpaD9ZL1UymnaqZ8jXS1WwJXHBtfPV20WkQpsx11J9KydnBgcL9EQIVR4RLvM6b2O56kcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=cjWIjVqr; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="cjWIjVqr"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 4095A4E425DC;
	Mon,  9 Mar 2026 15:00:55 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id F3B575FFB8;
	Mon,  9 Mar 2026 15:00:54 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6A5A9103695C1;
	Mon,  9 Mar 2026 16:00:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1773068451; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=F3ujtuI8oi0dmg2LEg0gpPv/xj90uC+9iN3YKwWa9UI=;
	b=cjWIjVqrshunpRqRYpQ9ALsqcgVYHgzv6XgOh0jAeqD3ifD67dzTsndCsD29AeYItQ87jV
	tyAKpUxk/xmtT3ZxLdFAQdv/pQt6XIZ5o1wa5cAS0E6XhhztXWvYVNPRJtceOQ7bRea+a/
	j6SbHs+YlZwe73Rak2rVKRAuBhFsnDGpFvr+VJhVdbopdUL7EwNQyHjhEK1+L3LrDlVnb/
	YUmv5kaxKEEcIIEuc0iJQcrMQQyW3wkepFJCwxFxLmYH8hl3SAYSUiAe5/E2OWlf1gZVjP
	i03GdkadEiC+gWnUGebMUH8aM3ss+UR9Iw7tpYl4J6q482OyvypHaiqkU9oW4w==
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 09 Mar 2026 16:00:40 +0100
Message-Id: <DGYCB0V4LO08.ZQP15NRFMGKA@bootlin.com>
Subject: Re: [bpf-next v8 0/5] emit ENDBR/BTI instructions for indirect jump
 targets
Cc: "Alexei Starovoitov" <ast@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Andrii Nakryiko" <andrii@kernel.org>, "Martin
 KaFai Lau" <martin.lau@linux.dev>, "Eduard Zingerman" <eddyz87@gmail.com>,
 "Yonghong Song" <yonghong.song@linux.dev>, "Puranjay Mohan"
 <puranjay@kernel.org>, "Anton Protopopov" <a.s.protopopov@gmail.com>,
 "Shahab Vahedi" <list+bpf@vahedi.org>, "Russell King"
 <linux@armlinux.org.uk>, "Tiezhu Yang" <yangtiezhu@loongson.cn>, "Hengqi
 Chen" <hengqi.chen@gmail.com>, "Johan Almbladh"
 <johan.almbladh@anyfinetworks.com>, "Paul Burton" <paulburton@kernel.org>,
 "Hari Bathini" <hbathini@linux.ibm.com>, "Christophe Leroy"
 <chleroy@kernel.org>, "Naveen N Rao" <naveen@kernel.org>, "Luke Nelson"
 <luke.r.nels@gmail.com>, "Xi Wang" <xi.wang@gmail.com>,
 =?utf-8?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn@kernel.org>, "Pu Lehui"
 <pulehui@huawei.com>, "Ilya Leoshkevich" <iii@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "David
 S . Miller" <davem@davemloft.net>, "Wang YanQing" <udknight@gmail.com>
From: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
To: "Xu Kuohai" <xukuohai@huaweicloud.com>, <bpf@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260309140044.2652538-1-xukuohai@huaweicloud.com>
In-Reply-To: <20260309140044.2652538-1-xukuohai@huaweicloud.com>
X-Last-TLS-Session-Version: TLSv1.3

Hi Xu,

On Mon Mar 9, 2026 at 3:00 PM CET, Xu Kuohai wrote:
> On architectures with CFI protection enabled that require landing pad
> instructions at indirect jump targets, such as x86 with CET/IBT eanbled
> and arm64 with BTI enabled, kernel panics when an indirect jump lands on
> a target witout landing pad. Therefore, the JIT must emit landing pad
> instructions for indirect jump targets.
>
> The verifier already recognizes which instructions are indirect jump
> targets during the verification phase. So we can stores this information
> in env->insn_aux_data and pass it to the JIT as new parameter, so the JIT
> knows which instructions are indirect jump targets.
>
> During JIT, constants blinding is performed. It rewrites the private copy
> of instructions for the JITed program, but it does not adjust the global
> env->insn_aux_data array. As a result, after constants blinding, the
> instruction indexes used by JIT may no longer match the indexes in
> env->insn_aux_data, so the JIT can not lookup env->insn_aux_data directly=
.
>
> To avoid this mistach, and considering that all existing arch-specific JI=
Ts
> already implement constants blinding with largely duplicated code, move
> constants blinding from JIT to generic code, before copying instructions
> for each subprog.

Could you please add me in CC for any future revision ?

Thanks,

Alexis

--=20
Alexis Lothor=C3=A9, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

