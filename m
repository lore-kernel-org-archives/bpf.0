Received: from zg8tmtyylji0my4xnjeumjiw.icoremail.net (zg8tmtyylji0my4xnjeumjiw.icoremail.net [162.243.161.220])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBD3D3AA4F9;
	Tue,  9 Jun 2026 14:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.161.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781016254; cv=none; b=Lr4+n98MIExO6ndJIEnGC4rsEAPz4RAOqaXVRCVyQoF5rjAe1zV1oTWHM4uS18IbcsBffhYePuFNMX7/zgEvpUdfbbKoyiWz7LHzstUaWRF0wzugCSyBUTEFTDH9Lwe8PG+weyZfIRtWeleBicwwaexYP4tz3J/GhjVrWF0S/j0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781016254; c=relaxed/simple;
	bh=IR5cctYcStsZCXOmsOnGPmiohwoYq7qJnSSiuHcUSw0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kug3NlYUW0Rgszp7IU7OXi5Loo2HZeRi0Lmw+Z2myD6QFoyGQXuDxoSnCDk/FMbXmXjndWN8hme1DSkPDE1LgRXeUEFk1oopTutn5ElR924mb1HgvxzgdF2T8Gl8ErqtLiDDH+WIoLNnxbHiW1Lvm2vTjVCOG5UqjTn4oQfyBNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=O5ElzVW1; arc=none smtp.client-ip=162.243.161.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="O5ElzVW1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:Date:Subject:
	MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	References:In-Reply-To:To:Cc; bh=rJk+jd4l80IL/6+9q7W2zxRmZb0iu5J
	K/VkexvL3Bq8=; b=O5ElzVW1noSCL82qfMNUIs1XR4gDyenTyNtUYmRMqvNTYK4
	9VarOY6OsCKQf4Y36ylVbAWXmLBhnhBWupGpXzncDbTWMa0Es+kFDIR4Hq9R5DoD
	RZJhLWE13CIv+YQvZzk5JPnPLQrwjE2i9s+YaMP3gwB5uDjnl2D21bxLxAI0=
Received: from [127.0.0.1] (unknown [101.6.30.195])
	by web4 (Coremail) with SMTP id ywQGZQDn+6CpJihq+OUeAg--.58007S4;
	Tue, 09 Jun 2026 22:43:54 +0800 (CST)
From: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
Date: Tue, 09 Jun 2026 22:43:51 +0800
Subject: [PATCH bpf-next 2/2] selftests/bpf: Cover writable BTF field
 global subprog args
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-f01-04-btf-writable-arg-v1-2-f449cd970669@mails.tsinghua.edu.cn>
References: <20260609-f01-04-btf-writable-arg-v1-0-f449cd970669@mails.tsinghua.edu.cn>
In-Reply-To: <20260609-f01-04-btf-writable-arg-v1-0-f449cd970669@mails.tsinghua.edu.cn>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Yonghong Song <yonghong.song@linux.dev>, Shuah Khan <shuah@kernel.org>, 
 linux-kselftest@vger.kernel.org, Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781016235; l=1435;
 i=gnq25@mails.tsinghua.edu.cn; s=20260605; h=from:subject:message-id;
 bh=IR5cctYcStsZCXOmsOnGPmiohwoYq7qJnSSiuHcUSw0=;
 b=Q7iI4gv7unjLmld1GFt7Qy6rmRHi/GA9riul6ue7Tmhk5yVbiqlMotUd/oD23pax3uY+nABfn
 jUsb8WK2qUqAbp3vSiyJmXtJZBQ83/YTRkLB3NXOs7LIkjSsWYUKeso
X-Developer-Key: i=gnq25@mails.tsinghua.edu.cn; a=ed25519;
 pk=nqQ48fAxVTDp3z/IUmqv6BB+agXPpd8tQjDOBxwlgZo=
X-CM-TRANSID:ywQGZQDn+6CpJihq+OUeAg--.58007S4
X-Coremail-Antispam: 1UD129KBjvJXoW7AFyrury3CF18Cr47Zr43Wrg_yoW8XrWUpF
	s7C3sIkr4fKa1Ig3y3AF4j9F4YqFnYy3yUAw1xZry3Ar1kJFn7Xrn7K3yYqry3Cr95KwnY
	vr9FqFZxWa18J3DanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPv1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l8cAvFVAK
	0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4
	x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l
	84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2kKe7AKxVWUXVWUAwAac4AC62xK8xCEY4
	vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
	7VCjz48v1sIEY20_GrWkJr1UJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr4
	1lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r1q6r43MxkIecxEwVAFwVW5XwCF04k20xvY0x0EwIxGrwCF04k20xvE74AGY7Cv6c
	x26r4rKr1UJr1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_Jrv_JF1lx2Iq
	xVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r
	1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY
	6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67
	AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuY
	vjfUxNtxDUUUU
X-CM-SenderInfo: xjqtjko6pdxz3vow2x5qjk3toohg3hdfq/1tbiAQINA2ony4GcWwAFsI

Add a verifier test for passing a BTF-backed task_struct field pointer to a
global subprogram argument typed as writable memory.

The direct field store is already rejected.
The global subprogram path should be rejected too.
The callee must not lose the BTF pointer's read-only provenance.
It must not validate the argument as ordinary writable memory.

Signed-off-by: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
---
 .../selftests/bpf/progs/verifier_global_ptr_args.c    | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_global_ptr_args.c b/tools/testing/selftests/bpf/progs/verifier_global_ptr_args.c
index ea273e152209..0bdeb7bc4687 100644
--- a/tools/testing/selftests/bpf/progs/verifier_global_ptr_args.c
+++ b/tools/testing/selftests/bpf/progs/verifier_global_ptr_args.c
@@ -287,6 +287,25 @@ int trusted_to_untrusted_mem(void *ctx)
 	return subprog_void_untrusted(bpf_get_current_task_btf());
 }
 
+__weak int subprog_write_mem_arg(int *p)
+{
+	if (!p)
+		return 0;
+
+	*p = 42;
+	return 0;
+}
+
+SEC("?tp_btf/task_newtask")
+__failure
+__msg("only read is supported")
+int trusted_btf_field_to_writable_mem(void *ctx)
+{
+	struct task_struct *task = bpf_get_current_task_btf();
+
+	return subprog_write_mem_arg(&task->prio);
+}
+
 SEC("tp_btf/sys_enter")
 __success
 int anything_to_untrusted_mem(void *ctx)

-- 
2.34.1

