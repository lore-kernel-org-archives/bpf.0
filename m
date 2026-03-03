Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [4.193.249.245])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3831B31717E
	for <bpf@vger.kernel.org>; Tue,  3 Mar 2026 09:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.193.249.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772530849; cv=none; b=FRQ7uH9iv/1KOw/nuWyqt+PUuW3MjkbYEgJClFaLGnF0atL+FdY1GzRTIcS1zmxnr5dN+edIW0LeONZiCYH76JMOZMNCTX/cXScpUvYWnIXxINM5/L/lLA4UaQGBRN/svsc1TT0/oN9k7urYjsHJXD2S0/MFzYQ14mmJOfnzEMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772530849; c=relaxed/simple;
	bh=gTb15VFg+IMcMCYY/tmC5ZMskakHFvqYhs3unpZJ2As=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BOfBb85YTW/fqtThBWLoxPDMcbNW9vWfDcy6T+ccLFRQd30CSZRkSZDgV5VklWhnrpZ4FTJAq2G/A1ZFbYmqPsH7hAV6c4qiIItFjRn7pyhNaC5SGvwcxiUmR/5mKispb3EpwfaVM44nk5y/QnFALvaQ+z7rfGwf2vXwK5PHo6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=4.193.249.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.162.163.215])
	by mtasvr (Coremail) with SMTP id _____wDnEqB7rKZpjzr+AA--.813S3;
	Tue, 03 Mar 2026 17:40:12 +0800 (CST)
Received: from lutetium.tail477849.ts.net (unknown [10.162.163.215])
	by mail-app1 (Coremail) with SMTP id yy_KCgCH29Z4rKZpXz9zBg--.51669S2;
	Tue, 03 Mar 2026 17:40:08 +0800 (CST)
From: Yazhou Tang <tangyazhou@zju.edu.cn>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	tangyazhou518@outlook.com,
	shenghaoyuan0928@163.com,
	ziye@zju.edu.cn,
	glapt.pro@outlook.com
Subject: [PATCH bpf 0/2] bpf: Reset register ID for BPF_END value tracking
Date: Tue,  3 Mar 2026 17:39:54 +0800
Message-ID: <20260303093956.395076-1-tangyazhou@zju.edu.cn>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:yy_KCgCH29Z4rKZpXz9zBg--.51669S2
X-CM-SenderInfo: qssvjiasrsq6lmxovvfxof0/1tbiBhESCmmklokgbAAEsV
X-CM-DELIVERINFO: =?B?uEU2UAXKKxbFmtjJiESix3B1w3vD7IpoGYuur0o+r46DyAi5OfOO+T4vrW4FyUBIyu
	9q9NoOXOMVWQv1X34VUZuZxoO2yPWrGfze2WlOi/M2spLPahqXFtMmg47SOJPeBXT7m0TW
	P7mMZz932dOAIa8iKfq7LWSOJzdipV2q3PdcSukKAvA7w13+7fPcKyyL6or1bQ==
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29K
	BjDU0xBIdaVrnRJUUU9Eb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k26c
	xKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vE
	j48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxV
	AFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x02
	67AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI
	0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280
	aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0Y48Icx
	kI7VAKI48G6xCjnVAKz4kxM4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28IcxkI7VAKI48J
	MxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwV
	AFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv2
	0xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4
	v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AK
	xVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU8YFAJUUUUU==

From: Yazhou Tang <tangyazhou518@outlook.com>

This patchset fixes a register's scalar ID issue for BPF_END operations
reported by Guillaume Laporte. Please see commit log of 1/2 for more details.

Yazhou Tang (2):
  bpf: Reset register ID for BPF_END value tracking
  selftests/bpf: Add test for BPF_END register ID reset

 kernel/bpf/verifier.c                         |  2 ++
 .../selftests/bpf/progs/verifier_bswap.c      | 22 +++++++++++++++++++
 2 files changed, 24 insertions(+)

-- 
2.53.0

