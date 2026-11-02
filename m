Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=114.242.206.163
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793604503;
	b=l5dSn/rLh6CDryXEi+YlKcXJhrIQZE22+U6wAM56iP9NCVT8E4od1hDHySvD1ualoreQ
	 /v5A7fCJhSgcOrrrvo4+qtVwpDaBAAa9FrsEAMgq+V+C1Pu2Rh60AvkL3MglC47c8XRgN
	 oXzOzj5rsHz/XugEGh0x8hoErTvPXwhWfz5JTrC8LDmCCivuUwpgS59n+9000/XD81iLa
	 K3Q8/BNVysJc7Yt88O0HONwEGYbXuIOGJx0/nRMNZjM0xz4rl2dshO7t4/PukrgN4Hm6N
	 Lfh98UUD9jXrahbzvWO7LFBNfiOtYJBtoLkn/rAKITUGO6LB1MpawGzkSe7yQZTXq1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793604503;
	h=DMARC-Filter:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-CM-SenderInfo:X-Coremail-Antispam;
	bh=bobNxfIwvIBykoCvR0qTk/ABDf5Bc3XpVhyaIsly4zg=;
	b=QdyuFQLv6dRzMrC92B9DA+hhAv9Ic+nbmQI+XuQ9KPeuM5gjL78qKTDKf3cMbPmYYlq1
	 H6cl1TfzhhC1fvUDzmtQ9JDNi/tCMDIqNpXJMCKfNVoPLiWcLKI6A8WYzH/NWJFRmgO9S
	 pSMs6J8O38qEwMoQPoiwK4khiLpaAuxktuTO360QQFHQUqshrGcqWdtcNqWyipoNP2gae
	 x+jv+ghWRgy/fh45sgaj1FHypE0ocVRlK/k4DVdObWpx4oNyLoAHywFDmgAu2J8JxP9TK
	 x90x0RxyF4x+s8ArKeDGsbuN6B3Rx/EmOIgD0ybRn2dDbPOzxFKp6I5/Qv3jTIiPf2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=loongson.cn;
	spf=pass smtp.mailfrom=loongson.cn;
	arc=none smtp.remote-ip=114.242.206.163
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EF83606A324;
	Mon,  2 Nov 2026 07:28:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1EF83606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [123.138.236.242])
	by gateway (Coremail) with SMTP id _____8AxS_CNO+hqVXQbAA--.14040S3;
	Mon, 02 Nov 2026 15:28:13 +0800 (CST)
Received: from linux.localdomain (unknown [123.138.236.242])
	by front1 (Coremail) with SMTP id qMiowJAx2c2KO+hqSsoxAA--.37951S2;
	Mon, 02 Nov 2026 15:28:11 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>,
	Hengqi Chen <hengqi.chen@gmail.com>
Cc: loongarch@lists.linux.dev,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 0/2] LoongArch: BPF: Fix arena and trampoline
Date: Mon,  2 Nov 2026 15:28:06 +0800
Message-ID: <20261102072808.23080-1-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
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
X-CM-TRANSID:qMiowJAx2c2KO+hqSsoxAA--.37951S2
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29K
	BjDU0xBIdaVrnRJUUUkYb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26c
	xKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vE
	j48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxV
	AFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44
	I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2
	jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20x
	vY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I
	3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIx
	AIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAI
	cVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2js
	IEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU8xuctUUUUU==

This version is based on 7.4-rc1, tested on Loongson-3A5000 and
Loongson-3A6000 physical machines.

Tiezhu Yang (2):
  LoongArch: BPF: Make arena support depend on SCQ extension
  LoongArch: BPF: Use beqz and bnez instructions for trampoline

 arch/loongarch/include/asm/inst.h | 21 +++++++++++++++++++++
 arch/loongarch/kernel/inst.c      | 28 ++++++++++++++++++++++++++++
 arch/loongarch/net/bpf_jit.c      | 15 ++++++++++++---
 3 files changed, 61 insertions(+), 3 deletions(-)

-- 
2.42.0

