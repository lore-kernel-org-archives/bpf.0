Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792667884;
	b=VYwrowQlKW2z+pR54+qAzFRmr1IcTjDSMXwh+GIHPOHCulx0QBa5fI2cHX+fMe8VRxFs
	 NvmiR1WVF66+Ah8YVMgj/clnIKrIcz8h+4DRk5ZM9tlA2EnUJEvrA63jrOBjHK2EPV16v
	 Bx/pSNqCXHzfyYmaES3XkcG0UyTX34d0sMpFvwNk7XAb9fu1R284ga03wZcHJ+IxOgJdI
	 mjNx7smX4cnYngHfHngiSVXrA36GPH5vG5di75OziiA0mjD/IeEXZmiQa/wkUObWBR3JU
	 DJaN+Wf0h3KHYwWGnWf6zqa+iH3sSc11DseOoxClVdC1lpO0vhdwMxKWKbE1pIUniDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792667884;
	h=Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:References:
	 Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=JclM6m6UJd9X/eOzEM/yHtyN8srcsiT4FYG2M3UATeQ=;
	b=lUwmvWKzA1Pa5hLJxidSdOvO5Bvww/kQdbPd7L0fqS8Q+elnKo3hhj/W2vECP0gwR1m/
	 AAxdZoMhkAtwYnolhU6groIYmye4JxmmG1u5G96EPEcKWept54VFIqctbgdt8B+/80hMz
	 oss63PH8utr5lwMMTwUCyWmwNXXUoli0OqcU04fwIcx2dOUwNt725S0fP7vldOrWPyrZA
	 gcEK4vDNg6f8YErEuaJsgp8rxu30YkOocco/l8+MNrmTXay/ApWMaYqSUIzbVm8hG+Kj5
	 aXakHtwBxRLdjSyI58yklfyAVDdMN4d5jGJySXQh9qyipAIGKk935T8uJOzrqh+27aw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d4fJGOkx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F949606A319;
	Thu, 22 Oct 2026 11:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d4fJGOkx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C43D21F000C1;
	Thu, 22 Oct 2026 11:18:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792667883;
	bh=JclM6m6UJd9X/eOzEM/yHtyN8srcsiT4FYG2M3UATeQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=d4fJGOkxHdDVT8ZFMZ7Z04p+Ls2YAslbqzV3fpCgkx/tvjSu6/DEUeajUjK1NiKAC
	 fd2XELg/Htc6LuXgCztTcSRwA23afViNqzg3m4zWXg9LHknn7UeeZ4UQUm+FNRIGlD
	 cfFeuwaRaFWM4ksecwZpmCiF4oGxY5GKEgR5diRkTHQ4mDJz5CO0EHmQ1URUwj03BG
	 O8Qpgd3e0o1cigcVjxBlqpCYc4qxKLVLv7KjwTqhAjibmLhujitUoJMNIMOjP37Yji
	 ulhuU6fdxZBJPq80wItLkGsphSKy91we2VoD37Eyqqf0uHHHJRxUkyjYIcyxpDYT/m
	 SOCfT9gy/6v0w==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: tangyazhou@zju.edu.cn, bpf@vger.kernel.org, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya
 Dwivedi <memxor@gmail.com>, David Vernet <void@manifault.com>,
 bpf@ietf.org
Cc: John Fastabend <john.fastabend@gmail.com>, Martin KaFai Lau
 <martin.lau@linux.dev>, Song Liu <song@kernel.org>, Yonghong Song
 <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, Emil Tsalapatis
 <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, Quentin
 Monnet <qmo@kernel.org>, Puranjay Mohan <puranjay@kernel.org>, Xu Kuohai
 <xukuohai@huaweicloud.com>, Pu Lehui <pulehui@huawei.com>, Catalin Marinas
 <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, linux-arm-kernel@lists.infradead.org,
 linux-riscv@lists.infradead.org, Shahab Vahedi <list+bpf@vahedi.org>,
 Russell King <linux@armlinux.org.uk>, Tiezhu Yang
 <yangtiezhu@loongson.cn>, Hengqi Chen <hengqi.chen@gmail.com>, Johan
 Almbladh <johan.almbladh@anyfinetworks.com>, Paul Burton
 <paulburton@kernel.org>, "James E.J. Bottomley"
 <James.Bottomley@HansenPartnership.com>, Helge Deller <deller@gmx.de>,
 Hari Bathini <hbathini@linux.ibm.com>, "Christophe Leroy (CS GROUP)"
 <chleroy@kernel.org>, Naveen N Rao <naveen@kernel.org>, Luke Nelson
 <luke.r.nels@gmail.com>, Xi Wang <xi.wang@gmail.com>, Ilya Leoshkevich
 <iii@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik
 <gor@linux.ibm.com>, "David S. Miller" <davem@davemloft.net>, Wang YanQing
 <udknight@gmail.com>, Jakub Kicinski <kuba@kernel.org>, Jonathan Corbet
 <corbet@lwn.net>, linux-doc@vger.kernel.org, Yazhou Tang
 <tangyazhou518@outlook.com>, Tianci Cao <ziye@zju.edu.cn>, Shenghao Yuan
 <shenghaoyuan0928@163.com>
Subject: Re: [PATCH bpf-next v2 4/8] bpf, riscv: JIT UHMUL and SHMUL on RV64
In-Reply-To: <20261021-bpf-hmul-v2-4-88e260099f7d@outlook.com>
References: <20261021-bpf-hmul-v2-0-88e260099f7d@outlook.com>
 <20261021-bpf-hmul-v2-4-88e260099f7d@outlook.com>
Date: Thu, 22 Oct 2026 13:18:00 +0200
Message-ID: <874iee6l1z.fsf@all.your.base.are.belong.to.us>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

tangyazhou@zju.edu.cn writes:

> From: Yazhou Tang <tangyazhou518@outlook.com>
>
> On RV64, the RISC-V M extension provides MULHU and MULH instructions that
> return the high 64 bits of an unsigned or signed 64-bit multiplication,
> respectively.
>
> Add the missing MULH encoder and use MULHU and MULH to lower the UHMUL and
> SHMUL BPF_MUL variants for both register and immediate sources. Keep the
> existing low-half and ALU32 multiplication lowering unchanged.
>
> Suggested-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
> Signed-off-by: Yazhou Tang <tangyazhou518@outlook.com>
> Co-developed-by: Tianci Cao <ziye@zju.edu.cn>
> Signed-off-by: Tianci Cao <ziye@zju.edu.cn>
> Co-developed-by: Shenghao Yuan <shenghaoyuan0928@163.com>
> Signed-off-by: Shenghao Yuan <shenghaoyuan0928@163.com>

Acked-by: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>
