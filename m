Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [4.193.249.245])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACD233C454E;
	Mon, 20 Jul 2026 16:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.193.249.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784565792; cv=none; b=qP+0OVgOnDeJCpM7APyQYCx10Ls29xOy2BqNcPC14yTItQkKA+x8oxmKRefCF6Gx2q7LdqM/Rf5MGQ1lo5CEPyLMDd/lfFwaX9/oPRP9NPRBhAqqQ8uS9fFeEwZWQG7giTNHb2qGSZ/I2Oy6GW2t1Fjx2G8HKmhmShawmaHmTig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784565792; c=relaxed/simple;
	bh=Pf9FKFiD+3sCvJQkhMXUXOFjABalyHpc5Z6NhqtEixQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Rgv+54KSG+H0fj8t0AE6+doGU0OP3I+D3SuO0gdKyaZqUYvu/6nOUirF1F0TW51oWFuec913E4dzyG/HtSr28yAfcHo2kwf9WwyW8N/4pvSYqUlbAxpMz59hZ3sMaVofqag6ks5cnlwI3ptpP0ev5tbCtMwrVBgdIRJPa9bFrcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=KOTgRVBh; arc=none smtp.client-ip=4.193.249.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="KOTgRVBh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:
	Date:Message-Id:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=BV3iMZqr+wyDnIuGY0yLA7i+Yxkbu7DsXn
	7fEjaWcPw=; b=KOTgRVBhduD+2w3iRv6vOs8bekz3kND/4cKzQCmn78LM/zsUWF
	f83xSnrZIm2J+3TlcSpeJak5a2Jeoi0jk+FvtbJO6kQjj05qYLqxN6Sa55p7J5dm
	EZRLkY5iSKf+2n7CELaual0L8cMhygNu/Ct9AbMK5dYPy4Asdyofo7Rs0=
Received: from c9a6c405b3f2.. (unknown [202.112.238.121])
	by web2 (Coremail) with SMTP id yQQGZQDX1bcGUF5q2kYhAA--.51004S3;
	Tue, 21 Jul 2026 00:42:52 +0800 (CST)
From: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>,
	John Fastabend <john.fastabend@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next 1/2] bpf: Preserve stack frame number for commuted arithmetic
Date: Mon, 20 Jul 2026 16:37:44 +0000
Message-Id: <fee8d44c3c792e29b8898951a68c8313d9d2da53.1784563939.git.chenyy23@mails.tsinghua.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1784563939.git.chenyy23@mails.tsinghua.edu.cn>
References: <cover.1784563939.git.chenyy23@mails.tsinghua.edu.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:yQQGZQDX1bcGUF5q2kYhAA--.51004S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Kr1xWw1xtw43Jr18CF4kJFb_yoW8Ar13pr
	Z3K3s3tw4kKa429wnFvFn7AFZ0kan7J34fCr1UA34Iy3WDJ34YqrWrKFy5JFWSkF4kJa40
	vr1j93yav3Z8Z3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUQK14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
	x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1l84
	ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UM2vY
	z4IE04k24VAvwVAKI4IrM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c
	02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE
	4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4
	IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS14v26r1q6r43MxkIecxEwVAFwVWUMxAI
	w28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr
	4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxG
	rwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJw
	CI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2
	z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7sREyv33UUUUU==
X-CM-SenderInfo: xfkh05r1stqzpdlo2hxwvl0wxkxdhvlgxou0/

When scalar += pointer is handled in adjust_ptr_min_max_vals(), the
destination register inherits the pointer type and id from the source
pointer. For PTR_TO_STACK, the inherited pointer state also has to carry
the stack frame number.

Without the frame number copy, a stack pointer derived inside a callee
through scalar += fp can be recorded as pointing to frame 0. Stack reads
and writes through that register can then update or consult the caller
frame while the actual instruction uses the callee frame.

Copy the frame number when PTR_TO_STACK state is inherited by the
commuted arithmetic form.

Signed-off-by: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>
---
 kernel/bpf/verifier.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 52be0a118cce0..58017141d52b7 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -13796,11 +13796,14 @@ static int adjust_ptr_min_max_vals(struct bpf_verifier_env *env,
 		return -EACCES;
 	}
 
-	/* In case of 'scalar += pointer', dst_reg inherits pointer type and id.
-	 * The id may be overwritten later if we create a new variable offset.
+	/* In case of 'scalar += pointer', dst_reg inherits pointer type, id,
+	 * and for stack pointers also the frame number. The id may be overwritten
+	 * later if we create a new variable offset.
 	 */
 	dst_reg->type = ptr_reg->type;
 	dst_reg->id = ptr_reg->id;
+	if (base_type(ptr_reg->type) == PTR_TO_STACK)
+		dst_reg->frameno = ptr_reg->frameno;
 
 	if (!check_reg_sane_offset_scalar(env, off_reg, ptr_reg->type) ||
 	    !check_reg_sane_offset_ptr(env, ptr_reg, ptr_reg->type))
-- 
2.34.1

