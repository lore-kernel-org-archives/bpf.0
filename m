Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=114.242.206.163
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793607163;
	b=tCvvKxDSMTQuud/zKb2wUSzKSD2toD1kh8i5SyJkVx8ndgulIyCB88L5P2A32xPIJaNR
	 lXwAiZy5MsVEQFjmOiEyQK+cEbR73qF3Ane9C+PmSy0I7ZFEW66+IMZghaAKxX7vTIGmX
	 7HhZXwOeQkmJKKZd6i5Wggqr4nLFrxyyo+pXwPOIIsvA0NThItpi+dSs/fBFr2uQrl6Kl
	 nwv82HCW+3KQMdu0O2/YUqVyUEoWTxe8GdRBT4t4P0J6fGIrMzW40wgvo7w9Lq41As31M
	 lGUByaI2N5T4kdEoAqCawmQuBw+jxkgubehf5lceVnDnWVPbNxhGjZjU5CrycKQkWiA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793607163;
	h=DMARC-Filter:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-CM-SenderInfo:X-Coremail-Antispam;
	bh=lfKFwDwYPGzzAH7toh27uPkZ/QhEJqxG8vNmxTsRMYQ=;
	b=3rpt7AcNXO/ScsfAgfwNDXpiEWzEWvKQvDu0Q4UMsBwoZIHDCAToMn4aG/bTyMZ9rdmK
	 MLFCjNhUIslfilr5wFK0cRGuJu5KSijmT1lNK6nCxz39O2LD7iKFD5NRnyasvrJetWWRd
	 pe4UpDTkJOMfafn+GLfZDz61H2RTmMYz/1cN/57KozfeQ4LaC8c5rg/+T8R2uwIHMDpNI
	 FUMpx7FqLNJGkIbyF9Lgi3xzbZcNPde39z6CuuSIkeORazzC1HQpXEYEZSOvARRTcAQ4O
	 rU509+ira5kHbmeYWCE5PgRCqAZRbVKTYkfT4YNtpEoUKQcv1MMcGpflmYxfQ8LUpyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=loongson.cn;
	spf=pass smtp.mailfrom=loongson.cn;
	arc=none smtp.remote-ip=114.242.206.163
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1D0C60A2605;
	Mon,  2 Nov 2026 08:12:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C1D0C60A2605
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [123.138.236.242])
	by gateway (Coremail) with SMTP id _____8Ax29HxRehqRngbAA--.14414S3;
	Mon, 02 Nov 2026 16:12:33 +0800 (CST)
Received: from linux.localdomain (unknown [123.138.236.242])
	by front1 (Coremail) with SMTP id qMiowJAx3c7vRehq5cwxAA--.37701S2;
	Mon, 02 Nov 2026 16:12:32 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v1 0/2] selftests/bpf: Make some tests skipped
Date: Mon,  2 Nov 2026 16:12:28 +0800
Message-ID: <20261102081230.7063-1-yangtiezhu@loongson.cn>
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
X-CM-TRANSID:qMiowJAx3c7vRehq5cwxAA--.37701S2
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29K
	BjDU0xBIdaVrnRJUUUk2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26c
	xKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vE
	j48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxV
	AFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x02
	67AKxVW8Jr0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6x
	ACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E
	87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82
	IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC2
	0s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMI
	IF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF
	0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87
	Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUcVc_UUUUU

This version is based on bpf-next, tested on Loongson-3A5000 and
Loongson-3A6000 physical machines.

Tiezhu Yang (2):
  selftests/bpf: Handle EOPNOTSUPP gracefully in test_loader
  selftests/bpf: Handle unaligned access failure in fexit_bpf2bpf

 .../testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c  | 11 +++++++++++
 tools/testing/selftests/bpf/test_loader.c             |  4 ++++
 tools/testing/selftests/bpf/unpriv_helpers.c          |  5 +++++
 tools/testing/selftests/bpf/unpriv_helpers.h          |  1 +
 4 files changed, 21 insertions(+)

-- 
2.42.0

