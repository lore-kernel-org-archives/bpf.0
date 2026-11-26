Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=114.242.206.163
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795669997;
	b=L91LuOicNZlar+fW4/wN5OT/O7VsD6cTcoxfREgLxinx4lcYv51eIKpMVdLxzq7ebjMG
	 KCVEUpxGryjTPc6hDtyM+ssVOC9KJI7afQ/8EELTbxzAdnOgXoTjIrI0fLkXNY7FDzP2/
	 j9FgTk5Z3YHVN4S3PkBfwM4v01qQIb5emc88pRIxcPSO2xsw/X4zmrTkx6ctxl9jYvgL5
	 Uvi6JA8jOJL7upMNUawU0FTDcJEz0neus+Q7wwIClof6LeS3SFO7lJHHdp7erkZCUjzYh
	 lBsDA7g8usuLviCbUNPFwCabrXIXccgP6MHAUPib+Rs0vBZGlC596LdecbKuuexcSyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795669997;
	h=DMARC-Filter:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-CM-SenderInfo:X-Coremail-Antispam;
	bh=rs0cJn1ALORvMjFnjpUCyNknyfGFuon/QBPSnoM4eNU=;
	b=JQ2UdBpTCzvDkR1G00YU8qxr5kj58RO9EAaHAMNHehd0RN8m5lRAZYHv+Wcdzks/gYRM
	 wwl8QbuPesfassuxonAVNLn0z/7rhRv5Mjauy7Xc1GfnxrzRR0mgQKrrDaCnDcf+g8xB7
	 xbfopEpBK8joOV8gVGvKEnU4ScXH5D/hDOHx0DFST/23FPUZWFpLcnaQDZoizVZw5L2K0
	 pqpRAyEnxmDnolB5IrdaRQrePuJtPp66wqAIIKKyX5WRLXThHTGHD63ncta3+3F1kDJEq
	 ltgn543aLzGsN6unDpzimIZGL4WI+KTPv5+M+gMFRS2uis1ktRUGOqnRkO0xCE0a76g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=loongson.cn;
	spf=pass smtp.mailfrom=loongson.cn;
	arc=none smtp.remote-ip=114.242.206.163
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 821ED606A31E;
	Thu, 26 Nov 2026 05:13:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 821ED606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [123.138.236.242])
	by gateway (Coremail) with SMTP id _____8DxztDnvwdrNyUjAA--.9570S3;
	Thu, 26 Nov 2026 13:13:12 +0800 (CST)
Received: from linux.localdomain (unknown [123.138.236.242])
	by front1 (Coremail) with SMTP id qMiowJAxFs3jvwdr63k3AA--.52601S2;
	Thu, 26 Nov 2026 13:13:08 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v1 0/2] selftests/bpf: Fix uprobe_autoattach test
Date: Thu, 26 Nov 2026 13:13:05 +0800
Message-ID: <20261126051307.13170-1-yangtiezhu@loongson.cn>
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
X-CM-TRANSID:qMiowJAxFs3jvwdr63k3AA--.52601S2
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29K
	BjDU0xBIdaVrnRJUUUPjb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26c
	xKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vE
	j48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxV
	AFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44
	I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2
	jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCF04k20x
	vY0x0EwIxGrwCF54CYxVAaw2AFwI0_Jrv_JF1l4c8EcI0Ec7CjxVAaw2AFwI0_JF0_Jw1l
	4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_Jrv_JF1lx2IqxVAqx4xG67AKxV
	WUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI
	7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r
	1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI
	42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUwmhFDUUUU

Tiezhu Yang (2):
  selftests/bpf: Include bpf_misc.h in uprobe_autoattach.c
  selftests/bpf: Define FUNC_REG_ARG_CNT for LoongArch

 tools/testing/selftests/bpf/prog_tests/uprobe_autoattach.c | 1 +
 tools/testing/selftests/bpf/progs/bpf_misc.h               | 6 ++++++
 2 files changed, 7 insertions(+)

-- 
2.42.0

