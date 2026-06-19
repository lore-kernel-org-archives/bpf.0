Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [52.229.168.213])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3AF03BC69C;
	Fri, 19 Jun 2026 16:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.229.168.213
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781885089; cv=none; b=H5yi6ZV5z7u0bEI538zCbDzGl8nTAZxq3vF7zWVjjTgkW6rnlnPXXbsSX07zB/OZtVgFcrf/8EaWIdnMcrB8G1Vph0xbwC3nLxQTU4eUjr4CNw9RMqXlmijgfSXU2WILrtuOoVz3bcxiMitrlRFQj88V/zhv3nfIcFxtcSrDxgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781885089; c=relaxed/simple;
	bh=LIkUbbJRL7ljuIGsElXvukV42cE32V3Jp1gy7KWaa2U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Db5pHRT080vVHOqkIzXNRnz7klfM569VlBK7rT71e8BLuzshW3qvy7RF1OE6kUGVfEqnq3QjHpRgsd6zUm3RlBWYoAHwm1DBh0WhTCdQOSci4eknrlVYxWLWsfztKrLKjb1QEDq9sAZ2NcvdPq5Nm9pf4Jbex1TG8AkE/39nJoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=ZPR+/vUI; arc=none smtp.client-ip=52.229.168.213
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="ZPR+/vUI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:Date:Subject:
	MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	References:In-Reply-To:To:Cc; bh=uVy8dTWPpQpvVAjrQQgfAgneG25neUc
	KPCsXPi3IARo=; b=ZPR+/vUICL8V4I8TNsxkg9Atk+x/EkWxk3bG04h9ojYi7hJ
	S0MJd8GXaxCWJE0+fag2Ur/rhBmmWngtFmREyUcN3ScwEoPnpobCGiS5GsCMXHaJ
	KLylBQqtFfkmv7yoz9c2+9pae8s6V7H9gAoKsjE2qtL6Znq8RFx1TnGUvtko=
Received: from [127.0.0.1] (unknown [101.6.30.195])
	by web3 (Coremail) with SMTP id ygQGZQCn8o+RaDVqIeaPAg--.58650S3;
	Sat, 20 Jun 2026 00:04:33 +0800 (CST)
From: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
Date: Sat, 20 Jun 2026 00:04:27 +0800
Subject: [PATCH bpf-next 1/2] bpf: Require CAP_BPF for pseudo-BTF ksym
 loads
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260620-f01-13-pseudo-btf-id-cap-bpf-v1-1-f950f69fe60c@mails.tsinghua.edu.cn>
References: <20260620-f01-13-pseudo-btf-id-cap-bpf-v1-0-f950f69fe60c@mails.tsinghua.edu.cn>
In-Reply-To: <20260620-f01-13-pseudo-btf-id-cap-bpf-v1-0-f950f69fe60c@mails.tsinghua.edu.cn>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, Hao Luo <haoluo@google.com>
Cc: John Fastabend <john.fastabend@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Shuah Khan <shuah@kernel.org>, 
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781885075; l=1123;
 i=gnq25@mails.tsinghua.edu.cn; s=20260605; h=from:subject:message-id;
 bh=LIkUbbJRL7ljuIGsElXvukV42cE32V3Jp1gy7KWaa2U=;
 b=jvuYMBbdazb+7oLhL8LWKsIifqOElig0O0SM+8QlG5Jv8ltAwdrO3DuSJAmXX+nu6rFd5XB4h
 pbBqlB2osYiCMADFL/AFRikDJCGEx0C2g641YM3po4SPiFNsZ1sUYC8
X-Developer-Key: i=gnq25@mails.tsinghua.edu.cn; a=ed25519;
 pk=nqQ48fAxVTDp3z/IUmqv6BB+agXPpd8tQjDOBxwlgZo=
X-CM-TRANSID:ygQGZQCn8o+RaDVqIeaPAg--.58650S3
X-Coremail-Antispam: 1UD129KBjvdXoW7XFy5WrWDWrW8Cw4kJr1kXwb_yoWkWFb_Jr
	4ku3ZxWwsrtFySg3W7CryxZryFkr4vkFy0yw47GrZrG3sYgF13Zrs2qF1rXFZrXr4DtrZr
	Aw13Wr9rXry3ujkaLaAFLSUrUUUU0b8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbgkFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wA2ocxC64kI
	II0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7
	xvwVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2
	z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UM2kKe7AKxVWUAVWUtwAac4AC62xK8xCEY4
	vEwIxC4wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
	7VCjz48v1sIEY20_GrWkJr1UJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr4
	1lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS
	14v26r4a6rW5MxkIecxEwVAFwVWUMxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY2
	0_GrWkJr1UJwCFx2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C267AKxVWUXVWUAwC20s02
	6c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GF
	v_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvE
	c7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67
	AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuY
	vjfU0Q6JUUUUU
X-CM-SenderInfo: xjqtjko6pdxz3vow2x5qjk3toohg3hdfq/1tbiAgADA2o0cJz6FQAAsf

BPF_PSEUDO_BTF_ID is resolved before the main verifier pass. The resolver
looks up the referenced kernel symbol through kallsyms and rewrites the
ldimm64 immediate to the concrete address that later becomes verifier
state.

Require CAP_BPF before doing that materialization. This keeps typed ksym
address resolution on the privileged side and prevents loaders without
CAP_BPF from receiving a verifier log that contains the resolved address.

Fixes: 4976b718c3551 ("bpf: Introduce pseudo_btf_id")
Signed-off-by: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
---
 kernel/bpf/verifier.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index ed7ba0e6a9ce..dbf5df995fc2 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -17639,6 +17639,11 @@ static int check_pseudo_btf_id(struct bpf_verifier_env *env,
 	int btf_fd;
 	int err;
 
+	if (!env->bpf_capable) {
+		verbose(env, "BPF_PSEUDO_BTF_ID loads require CAP_BPF\n");
+		return -EACCES;
+	}
+
 	btf_fd = insn[1].imm;
 	if (btf_fd) {
 		btf = btf_get_by_fd(btf_fd);

-- 
2.34.1

