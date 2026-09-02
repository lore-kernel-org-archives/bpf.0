Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CD233403F5;
	Wed,  2 Sep 2026 02:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788315988; cv=none; b=MjeHcRcpNVXhT8bs7c9MsRbsKI/8gyqok/6qAkwoB/zGqKnK4UxU8n2P1Vg0ZguUxE6kBa/fCsbgBsPcQsiDrB4bnvCdhcS2qYA8J5WQxng00h++Abq766hRHOLDqZLqTDr0k5MZfJ6ALkU+gFYkHBxhgaMkTyaCYUbALjoWkuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788315988; c=relaxed/simple;
	bh=HNu9ObHaCBJiGnVzsvKFTrJmpoC3XCqqe9WmgMRFZcg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YH19QbX1kT5lovaXCxAPvgkNBV0/ovZAa2OjgoOkuxP5G4Funi5/HBGhde+ee+C9gxyoOOuyTnRj1OB1sHmZquEX+q5OjgPpD/HH9NFRZi22OjC5NzvgYu7J78fWNsaJxamQyz9oue+mt99t9hFo+qMBUAvzMqjbZJQwSRXMWM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=H9o7OWem; arc=none smtp.client-ip=115.124.30.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="H9o7OWem"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1788315977; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=V/dlReRWmcpaJacPAy+g1eVWzWtHIWi93ITfcA0HWxA=;
	b=H9o7OWemVgfsW/cZY27+sW/xPMYrW2SFt2gqm/rnHq3VJbuWk/Jcby2RhMlXH+T3kaW/cOYKx0161Ol5U8aqp8hWyintsOTM2p0CtNFaQPQT1OIvV+HqFYsiSy/K36B/cdfcH0u+602+60YoJbMTs2PT9Rl2n2qJY8tM6bteiDw=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R261e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=cp0613@linux.alibaba.com;NM=1;PH=DS;RN=22;SR=0;TI=SMTPD_---0XAArZhl_1788315971;
Received: from DESKTOP-S9E58SO.localdomain(mailfrom:cp0613@linux.alibaba.com fp:SMTPD_---0XAArZhl_1788315971 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 02 Sep 2026 10:26:16 +0800
From: Chen Pei <cp0613@linux.alibaba.com>
To: bot+bpf-ci@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	memxor@gmail.com,
	bjorn@kernel.org,
	puranjay@kernel.org
Cc: ihor.solodrai@linux.dev,
	eddyz87@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	pulehui@huawei.com,
	pjw@kernel.org,
	palmer@dabbelt.com,
	shuah@kernel.org,
	guoren@kernel.org,
	bpf@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next] bpf, riscv: Register extable entries at probe insn call sites
Date: Wed,  2 Sep 2026 10:26:08 +0800
Message-ID: <20260902015152.16104-1-reply-cp0613@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <46b7038550e5d5ed680c36ee4e9bd96429b9bd85b600c257a254fe73b17d6e19@mail.kernel.org>
References: <20260901120013.16104-1-cp0613@linux.alibaba.com> <46b7038550e5d5ed680c36ee4e9bd96429b9bd85b600c257a254fe73b17d6e19@mail.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

> This looks like a bug fix for the fragile mode-based filtering in
> add_exception_handler(). Should this include:
>
>   Fixes: b4757714cc63 ("bpf, riscv: Add support for signed arena loads")

No Fixes tag, because the mode/class collision has never been a live
bug in any released tree. b4757714cc63 introduced both the
BPF_PROBE_MEM32SX support and the LDX class guard in the mode gate, in
the same commit, precisely to keep plain atomics (which share the 0xc0
mode value) out of the exception table. Its commit message says so
explicitly:

  "Since BPF_PROBE_MEM32SX shares its mode value (0xc0) with
   BPF_ATOMIC, the gate accepts it only for LDX class instructions so
   that plain atomic instructions do not register exception table
   entries."

For context: I noticed this fragile shared-state gate while working on
v1 of "bpf, riscv: Add support for signed arena loads", where the class
guard was added as a preventive measure. This patch now follows up with
the actual cleanup, making the registration decision explicit at each
call site so future probe modes cannot silently collide with legitimate
encodings.

Also, regarding sashiko-bot's separate concern about BPF_PROBE_ATOMIC
cmpxchg without ZACAS: that path is unreachable, as arena BPF_CMPXCHG
is already gated on ZACAS by bpf_jit_supports_insn(), and
add_exception_handler() resets its offsets after every registration,
so stale offsets cannot be consumed. A separate fix I have prepared,
"bpf, riscv: Make arena support depend on ZACAS", further rejects
arena map creation on non-ZACAS systems altogether.

Best regards,
Pei
