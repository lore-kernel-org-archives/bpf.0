Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D022362130;
	Tue, 24 Feb 2026 07:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771918599; cv=none; b=VOAd78ukQFRfgZc3Si+Pe11dpO3wuTIl+dMjbc3F91XAHLYptbHzFX4S+vrHnZjMVS6OelGcr/xRgeBn3fPzT1OidRE9PuPbGqUL2MIez+HBC0MNYQLm/OYZtK47UeGsp/7Yw6jLU2mY2gG9JeW2g4aom4Y0eZ5ETsEGQyJ4hRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771918599; c=relaxed/simple;
	bh=8baXd13LnBPFoL+ptkiSSrqHYmtb/XQigtMi8989nd4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eGRyVSToOHoUvABJpCZZpyVkgSUMEY7A3E/kJm0q10oUVrcIRevUf3I01GeqOR8jSVskTTQ+AbFlXAsz16jJOEKA/N0bp3l/qHC3zhDP+U8w7Lu9gMqXiNTAuwkrIBKUIo/ZrLhr1qk8fqYle1GV22Q2eVgyt+t5wRKeDR78xlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8BxcfC1VJ1p0KcUAA--.63862S3;
	Tue, 24 Feb 2026 15:35:17 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowJDxD8O0VJ1p9kxKAA--.9173S2;
	Tue, 24 Feb 2026 15:35:16 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>,
	Hengqi Chen <hengqi.chen@gmail.com>
Cc: loongarch@lists.linux.dev,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/3] LoongArch: BPF: Support more features for trampoline
Date: Tue, 24 Feb 2026 15:35:12 +0800
Message-ID: <20260224073515.1273-1-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJDxD8O0VJ1p9kxKAA--.9173S2
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29K
	BjDU0xBIdaVrnRJUUUkYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26c
	xKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vE
	j48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxV
	AFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44
	I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2
	jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20x
	vY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I
	3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIx
	AIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAI
	cVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2js
	IEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1CPfJUUUUU==

This series is based on Linux 7.0-rc1, tested on Loongson-3A6000,
the main aim is to support small struct arguments and 12 function
arguments for LoongArch BPF trampoline.

Tiezhu Yang (3):
  LoongArch: BPF: Open code and remove invoke_bpf_mod_ret()
  LoongArch: BPF: Support small struct arguments for trampoline
  LoongArch: BPF: support 12 function arguments for trampoline

 arch/loongarch/net/bpf_jit.c | 109 +++++++++++++++++++++++------------
 1 file changed, 71 insertions(+), 38 deletions(-)

-- 
2.42.0

