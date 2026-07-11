Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 273BE33CEBB;
	Sat, 11 Jul 2026 10:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783765023; cv=none; b=nqumUaX+ZtW31qDO6vIfkHxlrinE84JJaxtos47K3tG62S/3+zHB6Ni1mxf0wfqDurmbfzA+2wuAQ+BbPHOxZSgji98Gg/fa9pjrCL9N5o1I40iRFOoAZUKKd9FSNqf3/WTBxRhNpEUfuVoGR9sN0umyrNwnZA6JpBDGsaRXwzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783765023; c=relaxed/simple;
	bh=Kt5hPWtkN4dT61m010hzXOpLI0gc+A1mZaKPOzaZU8w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IaTR4YhmJ7DGUf3kdUsziYF0Ob6qYxzONdY+C6u6M8IRp2UK1GHjZHRpNejyOdvJFbCfJTNkVmumwwhswIwd0SRNGt+p0/YtgEMijb3lYU5bocD8WVYv/LM7eAOBKF64d9z2wUTfs3k1yZhN1PPDVeBK7qr5T1SHZKVLSEmjd5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8BxmusbGFJqD5kCAA--.10702S3;
	Sat, 11 Jul 2026 18:16:59 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowJBxb8cZGFJqZ3EJAA--.35766S2;
	Sat, 11 Jul 2026 18:16:57 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>,
	Hengqi Chen <hengqi.chen@gmail.com>
Cc: loongarch@lists.linux.dev,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RFC 0/2] LoongArch: BPF: Optimize 32-bit zero/sign extensions
Date: Sat, 11 Jul 2026 18:16:54 +0800
Message-ID: <20260711101656.7415-1-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJBxb8cZGFJqZ3EJAA--.35766S2
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj9xXoWrKw13Gr1kZFykGFy8Cry3trc_yoWxZrX_Ca
	yxCFykGw4rZay5ZFWjgr15JFy3AFWrKa1ru3Z0qF48ur1aywn8JFs5Kw4UZa10gF4rGrZ0
	qrW7Jrn3Ar1jvosvyTuYvTs0mTUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUb7xYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267AKxVW8
	JVW8Jr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I27wAqx4
	xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2jsIE14v2
	6r4j6F4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20xvY0x0EwI
	xGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480
	Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7
	IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k2
	6cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07josjUUUUUU=

Based on 7.2-rc1 and the following series:

https://lore.kernel.org/loongarch/20260711100956.4351-1-yangtiezhu@loongson.cn/

Not tested yet, only RFC.

Eliminate frequent and redundant zero-extensions and sign-extensions,
resulting in a cleaner native instruction stream and reduced JIT image
size.

Tiezhu Yang (2):
  LoongArch: BPF: Eliminate zero-extension for memory load operations
  LoongArch: BPF: Eliminate zero/sign extensions for 32-bit operations

 arch/loongarch/net/bpf_jit.c | 378 ++++++++++++++++++++---------------
 arch/loongarch/net/bpf_jit.h |  25 +--
 2 files changed, 219 insertions(+), 184 deletions(-)

-- 
2.42.0

