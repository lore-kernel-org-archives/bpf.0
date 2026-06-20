Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [13.76.78.106])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 155D417B50A;
	Sat, 20 Jun 2026 15:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.76.78.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781970443; cv=none; b=FRJ4zPaty5H4PvmGkT3hi1ICgP2seaxnSVNyJusk8qJlsPn9dAt1ys12Z6r3mEyNGZanhPhwXc1jduWhELXnvTSnykiSskkmuE2WlmcyEJ5piihNlda1AvBh2fomVvG0Oz+Y9+fc93dPtwVfWgOWQXXIwncxk3jm+UHV4BDtZmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781970443; c=relaxed/simple;
	bh=K12xr4wUDB1F4wKo4fVxn0Vj5tqoGdoRA7R4f6ooHkU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GOly38PlzMg2YRFjTWFGFyOyLsKjKx2xKAI6eaBMlg0rRX6HsNnpcc1WK15gYC4RMIENqzk9w28GNaS33dGdY6QxYFWcNPCcjaX9jrdYJGqtjm31S9gsJNXGDuyCzBZc1hZZ/BZmj5F423u4MxAlztjbfJ/WwYIIXW2FV15wpl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=ZBk426PA; arc=none smtp.client-ip=13.76.78.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="ZBk426PA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:Date:Subject:
	MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	References:In-Reply-To:To:Cc; bh=QevgBU27+VRhY4kkqt2B7URtkL4yNsp
	G7s8rGEx9AaI=; b=ZBk426PAJ68PlstuSy05haKUiLwLicvJvsz3lpF4Qmv+UI/
	+Xh7T5qLcD/5rTLNz36mFM7KVKJteywepOMi5GcYQj18xP0MWtbIv37GIEAiHgM8
	S4UzgqMMY9CmHhgoyrrb56cvjMcNSn/++l7q8v6nHgxv7KhWFk06e4CmM/Gs=
Received: from [127.0.0.1] (unknown [101.6.30.195])
	by web2 (Coremail) with SMTP id yQQGZQCHY5v_tTZqCNRtAg--.19521S3;
	Sat, 20 Jun 2026 23:47:11 +0800 (CST)
From: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
Date: Sat, 20 Jun 2026 23:47:09 +0800
Subject: [PATCH bpf 1/2] bpf: Mark bpf_get_kmem_cache() as nullable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260620-f01-16-kmem-cache-ret-null-v1-1-c146154a2816@mails.tsinghua.edu.cn>
References: <20260620-f01-16-kmem-cache-ret-null-v1-0-c146154a2816@mails.tsinghua.edu.cn>
In-Reply-To: <20260620-f01-16-kmem-cache-ret-null-v1-0-c146154a2816@mails.tsinghua.edu.cn>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Shuah Khan <shuah@kernel.org>, bpf@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781970433; l=1371;
 i=gnq25@mails.tsinghua.edu.cn; s=20260605; h=from:subject:message-id;
 bh=K12xr4wUDB1F4wKo4fVxn0Vj5tqoGdoRA7R4f6ooHkU=;
 b=myo0bkUcHhxeqC9q7yfnZGpYWx4W//piO/4YOKNpJfUUlz+kdnnCMXj6OsFDd5vrSjPcVMpAs
 ioLcNa66YiRDgLCGfaDxucO3wCfH8iReXENzDLsmwNBPHkV3g7MqmeH
X-Developer-Key: i=gnq25@mails.tsinghua.edu.cn; a=ed25519;
 pk=nqQ48fAxVTDp3z/IUmqv6BB+agXPpd8tQjDOBxwlgZo=
X-CM-TRANSID:yQQGZQCHY5v_tTZqCNRtAg--.19521S3
X-Coremail-Antispam: 1UD129KBjvJXoW7tryxAFW7tw4Uur43Cr4DArb_yoW8Xr15pr
	4xGr10kr48W397J3ZrJr1YgryFka4vvF4xur4kA3yY9w4Yvas7Xw15tr18XF93CrWUJrs2
	vry0v34Y9w4jgFJanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l8cAvFVAK
	0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4
	x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l
	84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcx
	kEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6x8ErcxFaVAv8VW8
	Ww4UJr1UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6I
	AqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFylc2xS
	Y4AK67AK6ryrMxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY20_GrWkJr1UJwCFx2
	IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v2
	6r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67
	AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IY
	s7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr
	1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjfU4uc_DUUUU
X-CM-SenderInfo: xjqtjko6pdxz3vow2x5qjk3toohg3hdfq/1tbiAgAEA2o1wh2y4QAAsW

bpf_get_kmem_cache() returns NULL when virt_addr_valid() rejects the
address or when virt_to_slab() does not find a slab. The verifier uses
KF_RET_NULL to add PTR_MAYBE_NULL to kfunc return registers, but the
registration currently lacks that flag.

Add KF_RET_NULL so callers have to prove that the returned kmem_cache
pointer is non-NULL before dereferencing fields.

Fixes: a992d7a397912 ("mm/bpf: Add bpf_get_kmem_cache() kfunc")
Signed-off-by: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
---
 kernel/bpf/helpers.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index b5314c9fed3cf..57a6ab72ae3cc 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -4817,7 +4817,7 @@ BTF_ID_FLAGS(func, bpf_iter_bits_next, KF_ITER_NEXT | KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_iter_bits_destroy, KF_ITER_DESTROY)
 BTF_ID_FLAGS(func, bpf_copy_from_user_str, KF_SLEEPABLE)
 BTF_ID_FLAGS(func, bpf_copy_from_user_task_str, KF_SLEEPABLE)
-BTF_ID_FLAGS(func, bpf_get_kmem_cache)
+BTF_ID_FLAGS(func, bpf_get_kmem_cache, KF_RET_NULL)
 BTF_ID_FLAGS(func, bpf_iter_kmem_cache_new, KF_ITER_NEW | KF_SLEEPABLE)
 BTF_ID_FLAGS(func, bpf_iter_kmem_cache_next, KF_ITER_NEXT | KF_RET_NULL | KF_SLEEPABLE)
 BTF_ID_FLAGS(func, bpf_iter_kmem_cache_destroy, KF_ITER_DESTROY | KF_SLEEPABLE)

-- 
2.34.1

