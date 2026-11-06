Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.30.100
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793964721;
	b=Mru+kNkJZbpJIpPWFwgRRH2qamMlN79fKIYqu+N4rSocDpJA2gqHHgADuxXIGMs2hBGF
	 MrNv7rFcoFpptZydg5uD8h30oLdrbWsuOMRGWxl+9XbOEGeYNytL7dd7CddxBTueASJxf
	 FdBM/VHP7OIip4M3w2DVzRuA975OjrqJfa//EeGNnZFUhkwS+mgM9eGycLLr9XRPfogZM
	 wOkVpbleflqyI7Qh7f7XAq/OmIw4ODpCC8G5quUPG63zxakXeWQmq8nfP+RAt9szNESdC
	 hha06m3HCVNhvh7QTo+GSLnFxFruU2pW4KeD6cLLS3SIjLuJQeR/rnO7f4diXJ658tg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793964721;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Yqjs9FxGFBp5OY6+L2rdafdj5iiRpqCep/7a7oEUs8A=;
	b=wSjwAb1fny3j6XKectq1+0bStZK7oJI3tCn+CQVrXOWpiaEmKhWW8RWWPE5+OlugXtVy
	 NuO1LnWbfMlKygEL/FyLQkcUSqx2EnW1X2gUTV42RD7OqhJcpbp3WOi8WA9bMigrax+wc
	 BtUY0OEASvhm3KuDOhcepgnvjiuBKN4tD9WMj9Ie+Y4KBgeawuxtoJ127UKgCwxV1WtX3
	 vkr12QDLEfng7hGSn+kb210o9egb/pmMSCIw55ddN8K5Luz0v2pZH4jInHECdOjNbUQWW
	 FvR8Tg7XBRA8Bxbp7IBGmL6r3LbGHMMByIS38Te6UnmNcEVwwAPrYJBPwgX5hnTlWBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.alibaba.com;
	spf=pass smtp.mailfrom=linux.alibaba.com;
	dkim=pass header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=vDVf485l;
	arc=none smtp.remote-ip=115.124.30.100
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 951DC606EE85;
	Fri,  6 Nov 2026 11:31:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 951DC606EE85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=vDVf485l
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1793964716; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=Yqjs9FxGFBp5OY6+L2rdafdj5iiRpqCep/7a7oEUs8A=;
	b=vDVf485lAtXpJo1Uq9cvNDTn6C5lmt/O2z0mX6sAvOF6aVX1ZXwZYysrobTW3mNAKE+eyZkcynov393sYTnG3Do0P+x+rhcuyT8NqzQ3eBXWcVzpeGPa0Gy5fE+njMfvOlQB4+R/SseG7BZjAB8IyxXNPxPkXOouykyMAx/5r2I=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=cp0613@linux.alibaba.com;NM=1;PH=DS;RN=27;SR=0;TI=SMTPD_---0XEBfxvu_1793964708;
Received: from DESKTOP-S9E58SO.localdomain(mailfrom:cp0613@linux.alibaba.com fp:SMTPD_---0XEBfxvu_1793964708 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 06 Nov 2026 19:31:54 +0800
From: Chen Pei <cp0613@linux.alibaba.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: alex@ghiti.fr,
	andrii@kernel.org,
	aou@eecs.berkeley.edu,
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
	pulehui@huawei.com,
	puranjay@kernel.org,
	rgbi3307@gmail.com,
	shuah@kernel.org,
	song@kernel.org,
	xi.wang@gmail.com,
	yonghong.song@linux.dev
Subject: Re: [PATCH v2 bpf-next 3/3] selftests/bpf: Add a runtime test for private stack and stack arguments
Date: Fri,  6 Nov 2026 19:31:42 +0800
Message-ID: <20261106113148.3157-1-cp0613@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <DMNFA3D0M816.2K02S8LB47QM4@gmail.com>
References: <20261104100411.997-1-cp0613@linux.alibaba.com> <20261104100411.997-4-cp0613@linux.alibaba.com> <DMNFA3D0M816.2K02S8LB47QM4@gmail.com>
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

Hi Alexei,

Thanks for the review and for writing out the two programs.

> bpf ci is right in the other email.

Okay, will fix it in the next version.

> Also, the test runs on riscv64 only. BPF CI runs arm64 and not riscv64.
> arm64 has the same combination and no test for it.
> The run time part has nothing specific to riscv64.
> The __jited patterns pin the frame sizes that clang picks for C code.
> zero_stack doesn't use the private stack.
> It's the only reason for serial_.
>
> Two asm progs in verifier_stack_arg.c are enough.
> BPF_PROG_TEST_RUN runs a raw_tp prog. No need to attach it.
> The test runs on x86-64, arm64 and riscv64.
> On x86-64 both frames stay on the kernel stack.

Agreed, will redo the test this way in the next version.

Best regards,
Chen
