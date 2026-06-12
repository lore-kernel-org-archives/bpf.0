Received: from zg8tmja5ljk3lje4mi4ymjia.icoremail.net (zg8tmja5ljk3lje4mi4ymjia.icoremail.net [209.97.182.222])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36B4B37F739
	for <bpf@vger.kernel.org>; Fri, 12 Jun 2026 09:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.97.182.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781257142; cv=none; b=UdwcS9bDYSin8/Im2XhPTG1yuoo93rBPYuf2Eg/9uEB7bGixjqZUl1ecVuqoBMQ8TibParisBOPbSFeJLIar4VxMEF+YvOO88J7SMvXT9mmnMBRbJ6GyFu3OOtUQIfiXT8+CWPEao4xWftH0WGuairzorB20PyQn3GiiZ4CdMJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781257142; c=relaxed/simple;
	bh=jzO4d+Ibl55JZdcd1s/wj0H5/bc2tmaNvrWzyx6qcEk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eMqOGhNuPmlg++yEd7VeirqHilxJLnihJvBxGc8CK51DVYlXqCnWoafTDDqmGMTqqRDgt9/dbXDsTzRZn+M9wHSX4W2XTiqy8jW9BLQ7sbZlVK3YbgGLeFp2m7ZssR4Z2OztHY6iFIYb3TgE1Kft6Bf+wtwzenMxc1AQHrs1taI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=209.97.182.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.162.57.97])
	by mtasvr (Coremail) with SMTP id _____wB3nkWj0ytqf6yBAg--.13733S3;
	Fri, 12 Jun 2026 17:38:44 +0800 (CST)
Received: from localhost.localdomain (unknown [10.162.57.97])
	by mail-app1 (Coremail) with SMTP id yy_KCgBX7Kaj0ytqD4joAQ--.2374S2;
	Fri, 12 Jun 2026 17:38:43 +0800 (CST)
From: Tianci Cao <ziye@zju.edu.cn>
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
	ziye@zju.edu.cn
Subject: [PATCH bpf-next 0/2] bpf: support shift operations with non-const source operand
Date: Fri, 12 Jun 2026 17:38:07 +0800
Message-ID: <20260612093818.18609-1-ziye@zju.edu.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:yy_KCgBX7Kaj0ytqD4joAQ--.2374S2
X-CM-SenderInfo: qtstiiaquyiko62m3hxhgxhubq/
X-CM-DELIVERINFO: =?B?3tctAgXKKxbFmtjJiESix3B1w3tzYfmPt4q7bPP17nv9Zvsme7sPvU0377+RBBKdO8
	083rnS2Yx6ydJM+hN30hkgAlkkFigb2UT72GWwZGYa1IwHEG4RJZulZOIsWhhrR3NobHgf
	hMxKr50wkZfz63w5YpHN5RPxYw6l01w8CbPzC/8w
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29K
	BjDU0xBIdaVrnRJUUU9Eb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26c
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
	xVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU801v3UUUUU==

Add support for BPF shift operations (BPF_LSH, BPF_RSH, BPF_ARSH)
when the source operand is not a constant but is bounded.

Tianci Cao (2):
  bpf: support shift operations with non-const src operand
  selftests/bpf: Add tests for non-const src shift

 kernel/bpf/verifier.c                         | 100 ++++++++++++----
 .../selftests/bpf/progs/verifier_bounds.c     | 108 ++++++++++++++++++
 2 files changed, 184 insertions(+), 24 deletions(-)

-- 
2.43.0

