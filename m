Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.30.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793964531;
	b=qKJQhUmGQh/IWzbLU2ug4T423UNKRP4WdJmyUzbMDlnv4O7N60D8jiyZjR4y6HEe3R47
	 c2RfLYHbMgDXbJivrY92y2WruVMTOZkLdDMFXFFV0dPtI06hhbojOZnwEzQdB4FhxwCYg
	 FcF8EoSBV1LoFxbNgGvqw87t2z67iNqdUstQfhBf1Mmaiwi43Gjf0Vpm0SezIeyT9SNoK
	 gYVWO2qTut2jc87EVKFYuvG4zJnlHpKfvx298EEMK39rklsTyyaSh4gL8F+ZUc4dlYDbq
	 /q0E+btAuWxccVRDrTUZoR8cB+qqCt3bVDckgBJCD3Ns8Iu0hTBEz7f/ylgk3guFKiQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793964531;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=x4bVUhjHWKbLWf39GdnghFqz7Ddc3DEd75LdHRnTlSo=;
	b=hU0sqoYP3DDY4J/+FRAn6gcHwuY6BFobAiOv1lhg4dYTvie3AdrENRWTarXorMk0CLSK
	 OAPShSlTmc0h+nb4T3wpIA4l1xQEkJL5bf4HQIYGM8afQmgUsMfoEXPLVgegbv5USL32H
	 G+zTJts2euiFXAiA+QFRkkUUzqkU2BOSNdsjixNqIu1iFIzd6n19iB+BgaJZ3PpfLtK10
	 lD09uxWrklc+9ezZ7uHPIJ556PtwFvtNjqkJ3hlBWvx07qOlWcYtfS9L9pIn9KoVhuwCc
	 PUuOXtw3b4LBS9PWjTrxvB/Da8nZwaMPyHCriD2DNexWEMaXCXKdcyNb/cMIRxzg/1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.alibaba.com;
	spf=pass smtp.mailfrom=linux.alibaba.com;
	arc=none smtp.remote-ip=115.124.30.101
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6DE3606D81E;
	Fri,  6 Nov 2026 11:28:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C6DE3606D81E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1793964520; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=x4bVUhjHWKbLWf39GdnghFqz7Ddc3DEd75LdHRnTlSo=;
	b=yevr9HYCCHSkHhvjH2vgfykb87vm2x4amggXnyuCc5Ox4PJNqc3EOCk1fxSyNaLbQp7xfSRLVhluety8FTN/5jkFVpFA5YUKqH4QON/NUcknEDuUcI0M28kil+60qGzAxhPZr8CT3dBSiytywlEr42HyI0imnl1++4igjTLx8dc=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045098064;MF=cp0613@linux.alibaba.com;NM=1;PH=DS;RN=27;SR=0;TI=SMTPD_---0XEBfx5X_1793964514;
Received: from DESKTOP-S9E58SO.localdomain(mailfrom:cp0613@linux.alibaba.com fp:SMTPD_---0XEBfx5X_1793964514 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 06 Nov 2026 19:28:38 +0800
From: Chen Pei <cp0613@linux.alibaba.com>
To: Pu Lehui <pulehui@huawei.com>
Cc: alex@ghiti.fr,
	andrii@kernel.org,
	aou@eecs.berkeley.edu,
	ast@kernel.org,
	bjorn@kernel.org,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	emil@etsalapatis.com,
	guoren@kernel.org,
	ihor.solodrai@linux.dev,
	jolsa@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	luke.r.nels@gmail.com,
	martin.lau@linux.dev,
	memxor@gmail.com,
	palmer@dabbelt.com,
	pjw@kernel.org,
	puranjay@kernel.org,
	rgbi3307@gmail.com,
	shuah@kernel.org,
	song@kernel.org,
	xi.wang@gmail.com,
	yonghong.song@linux.dev
Subject: Re: [PATCH v2 bpf-next 1/3] riscv: bpf: Add BPF private stack support
Date: Fri,  6 Nov 2026 19:28:31 +0800
Message-ID: <20261106112834.3118-1-cp0613@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <ad060270-6e32-4dcf-9830-6d2ffbfc0783@huawei.com>
References: <20261104100411.997-1-cp0613@linux.alibaba.com> <20261104100411.997-2-cp0613@linux.alibaba.com> <ad060270-6e32-4dcf-9830-6d2ffbfc0783@huawei.com>
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

Hi Lehui,

Thanks for the review.

> a nit, let move it with the PRIV_STACK_GUARD_SZ macro.

Will fix it in the next version.

Best regards,
Chen
