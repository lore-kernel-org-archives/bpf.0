Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF3462D7DC8;
	Thu, 21 May 2026 12:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779368203; cv=none; b=bsyh9gJ7J3UDci2S8oSpF5OIb2v/vkQbVcQy073VNQbL059h3rRZplbPUkNwuomv0+q+CI23mv9oRC7KMx+ScBUAC16kicaj+Zg6oEreEGuUjnEgp49zmTtQNlAxJhU0qJCgiAlX6sfmqCBeQn/+DK72Lez9U0d8/tYQTS34r7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779368203; c=relaxed/simple;
	bh=SfEIYi1KNd0mYCLFdUSyMK8PWWSCU93Vq0dwmFVtvC8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=eGDB/cCm8xAI1A9kCuaxNrePHDmYB9NbJmT9vVa94ZZETubZGFtUbLyYkB6p+fwaKvFg6cFlIKCWeW4dbJoua1g+BG78xTNxLcijFMEPKjlvPoIowWqGoCBsjuk1DatNnJF+Kzc73RiA2XS4Lcml40EWSRwKoIWxXYxGji/kEZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8AxFekFAQ9qp_4LAA--.29036S3;
	Thu, 21 May 2026 20:56:37 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowJCx+8EFAQ9qPBuLAA--.2485S2;
	Thu, 21 May 2026 20:56:37 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: loongarch@lists.linux.dev,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v1 0/2] selftests/bpf: Add some tests for LoongArch
Date: Thu, 21 May 2026 20:56:34 +0800
Message-ID: <20260521125636.26744-1-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJCx+8EFAQ9qPBuLAA--.2485S2
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29K
	BjDU0xBIdaVrnRJUUUk2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26c
	xKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r106r15M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vE
	j48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxV
	AFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x02
	67AKxVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6x
	ACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E
	87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82
	IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC2
	0s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1Y6r17MIIYrxkI7VAKI48JMI
	IF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF
	0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87
	Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUcyxRUUUUU

This series is based on the latest bpf-next tree.

Tiezhu Yang (2):
  selftests/bpf: Support get_preempt_count() for LoongArch
  selftests/bpf: Add __arch_loongarch to limit test cases

 .../testing/selftests/bpf/bpf_experimental.h  | 23 +++++++++++++++++++
 tools/testing/selftests/bpf/progs/bpf_misc.h  |  1 +
 tools/testing/selftests/bpf/test_loader.c     |  5 ++++
 3 files changed, 29 insertions(+)

-- 
2.42.0

