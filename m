Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [13.75.44.102])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 892373C7690;
	Sun, 26 Jul 2026 15:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.75.44.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785081108; cv=none; b=QxMJ4L0D0koywqw5wo4il/JhqicP7W8j5DLdjEhgcCNmet/5wAgoAI3LAfNigehjHVA6Fb6hoyW52unVYpXtsQQS4npM2Sb7pOFSa3sMspynB3XuJBBfltrhFbmmRP8mbze4HAxbyfndL5Kg1F8qQNkjiBfitZky48r8UojYJ98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785081108; c=relaxed/simple;
	bh=9vNX+mZl8rXsAKzz0bhKz3t1wt6cEHLLjouBY9rDYmc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Jbyc8VsivSmWHaK/JhY1/mCO8q1Fqsqkhbcy1jPmTUY78HvtG0onIWyfpOUh2+b6KoPhqaGD9UMQgythrocIqOSfB9jcdUihEGkq2R+5OrF7u5DoxWVXcpNRlZZvHgQSX4lP1CfCCGKKhfaXMA9XsHpboH7JhYVDUWxRTOmK2yA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=ULSLv9pW; arc=none smtp.client-ip=13.75.44.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="ULSLv9pW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:Subject:Date:
	Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	To:Cc; bh=A4mOG6vE63WZYlsn5Gnun+78WAOBmr+NvEXcl0j8fnM=; b=ULSLv9
	pWpMIXRJG8Rzpy4y3IjkIi1Kms6dnAr5dSpxbSR8sNY1NMGyGNj+y5x0DvMmoAEY
	KPgXoFiKi6l9qDRstE40kP2QolxfdklwsDSC27342sh8JMld2kUxzWhDs8i+SCpm
	7zTYD2LOw0f5gR73qDjxqEWBXxkoy/97BCVzc=
Received: from [127.0.0.1] (unknown [101.6.30.195])
	by web1 (Coremail) with SMTP id yAQGZQDXcsL_LGZqS_CgAA--.34846S2;
	Sun, 26 Jul 2026 23:51:27 +0800 (CST)
From: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
Subject: [PATCH bpf-next 0/2] bpf: Fix RHash special-field recycling
Date: Sun, 26 Jul 2026 23:51:16 +0800
Message-Id: <20260726-f01-23-rhash-cancel-bpf-next-v1-0-6e5e1131d885@mails.tsinghua.edu.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAPQsZmoC/zXMUQrCMBCE4auUfXYhWbEFryI+pOvERCSWbJVC6
 d2Nio8/M3wrGWqG0bFbqeKVLT9KC7/rSFMoV3C+tCZx0rtBhKPzLHuuKVhiDUVx53GKXLDM7CT
 0GKDeH0CNmCpiXr78if4vOv8We4436PzRadveaYYrhooAAAA=
X-Change-ID: 20260722-f01-23-rhash-cancel-bpf-next-02a6e7ec115e
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>, 
 Mykyta Yatsenko <yatsenko@meta.com>, Shuah Khan <shuah@kernel.org>, 
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785081088; l=1218;
 i=gnq25@mails.tsinghua.edu.cn; s=20260605; h=from:subject:message-id;
 bh=9vNX+mZl8rXsAKzz0bhKz3t1wt6cEHLLjouBY9rDYmc=;
 b=9WgsV4O0Znk5hz+uAKieIxWlF4CbUz42SFNWMSHYF6Zg4AAvVJBbTpEIzYvQxRXOrWEHGLo++
 obLE0f8QcP9BqXSuIIZKuzgt7uDPeM2GmZXT6GlT2sNUN643YPQ1z20
X-Developer-Key: i=gnq25@mails.tsinghua.edu.cn; a=ed25519;
 pk=nqQ48fAxVTDp3z/IUmqv6BB+agXPpd8tQjDOBxwlgZo=
X-CM-TRANSID:yAQGZQDXcsL_LGZqS_CgAA--.34846S2
X-Coremail-Antispam: 1UD129KBjvJXoW7GryrGFW5XF1UCrWUJFyUtrb_yoW8Jr15pF
	WfCasxKr18JF13GFnavF4jgr1rGFn3GF15K3W3t34Yvwn8X34kAw4SgwnaqFy3JrZ2vr4Y
	qryxXFn8Cr48CrDanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9q1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l8cAvFVAK
	0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4
	x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28E
	F7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzx
	vE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VCjz48v1sIEY20_GrWk
	Jr1UJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5c
	I20VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS14v26r4a6rW5MxkIecxE
	wVAFwVW5WwCF04k20xvY0x0EwIxGrwCF04k20xvE74AGY7Cv6cx26r4rKr1UJr1l4I8I3I
	0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWU
	GVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI
	0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0
	rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r
	4UJbIYCTnIWIevJa73UjIFyTuYvjfUOq2MUUUUU
X-CM-SenderInfo: xjqtjko6pdxz3vow2x5qjk3toohg3hdfq/1tbiAQYAA2plNzTZTAAAsd

Commit 6905f8601298 ("bpf: Allow special fields in resizable hashtab") says
that "kptr semantics under in-place updates are identical to array map."
However, RHash calls bpf_obj_free_fields() after copy_map_value(), dropping
the kptr that the copy preserves.

Use bpf_obj_cancel_fields() in the update and deferred deletion paths, as
hash and array maps do. It cancels timer, workqueue, and task-work state
while the allocator destructor releases kptrs at final reclamation.

Add a selftest that verifies a task kptr survives a BPF_EXIST update and
exercises delayed deletion.

Signed-off-by: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
---
Nuoqi Gui (2):
      bpf: Cancel RHash special fields on value recycle
      selftests/bpf: Cover RHash special-field recycle

 kernel/bpf/hashtab.c                           | 14 ++---
 tools/testing/selftests/bpf/prog_tests/rhash.c |  3 +
 tools/testing/selftests/bpf/progs/rhash.c      | 81 ++++++++++++++++++++++++++
 3 files changed, 91 insertions(+), 7 deletions(-)
---
base-commit: a23a71823352e2d792dcaae25f1ebb744acbfc0b
change-id: 20260722-f01-23-rhash-cancel-bpf-next-02a6e7ec115e

Best regards,
--  
Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>

