Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=114.242.206.163
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793607160;
	b=TSi0tNhUrWGoH4kpGxpkXI2+PxbN6NrS1azS3liaasePmTTvrJ/ha6T15zTXDdByyU+Z
	 AK2kIARCvo308+QA4eCVn/4kF8rNZlrIaK/9NmpEVyJ9+Ok3rHw0k49GszykHjgrFA1TW
	 QIOXPbsmWRUg/FbAXFHATCvniN22sApjqBpeWoWwtzpC2UQ5uItyvAC5wk6rRd3LFTqUT
	 jg0p8MqsPtOvj1NQ5+qJAgxZKMQ/+nASCVnHC75ELPX/JnB82F3nN9v40Ll8JrSX++nu9
	 basz4HEmfgWgmUSGN4zBZcoK2evy+FyBDdUNpggTxf7g5Wm2gDL/7dO/Ep4niNoRWQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793607160;
	h=DMARC-Filter:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-CM-SenderInfo:
	 X-Coremail-Antispam;
	bh=rgA3jQowehsD4IDuk6EokEntcsXv8fWxLKITDX8CbVQ=;
	b=EckocJhaPLREmVcC/U0Tb1nyvDXJ17iwjA8cAq11BBCBD1Xp7KUQCZW5NH7VxzMEYZpP
	 ALNr7q2ngYNv4bj0kfSbpK5sPO30EGm9REAJt9a5w8ZakVATMnrGkQiBkk/Fo8ws2X3g/
	 6YJkiLvRncnKbTbHHfSyqUBaGj6RMODUb0S1TvDRHUPz400ZOg6zsT8YOjKKeAqfVLCzs
	 YcGr8j1o9NkwudwO6GfJ3yAQFlqCeUh2bTfzBRt1pm4v4F8xAQpsCq2j6EXIzGzuansqW
	 MgNvm3KSuGqAAApAJB7kS6Fvk5twx1tdltLTvPkSXM9wWhSK1zSIMsEzMLRBMgoYjuw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=loongson.cn;
	spf=pass smtp.mailfrom=loongson.cn;
	arc=none smtp.remote-ip=114.242.206.163
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB80B606A32E;
	Mon,  2 Nov 2026 08:12:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BB80B606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [123.138.236.242])
	by gateway (Coremail) with SMTP id _____8DxD9PyRehqTngbAA--.13991S3;
	Mon, 02 Nov 2026 16:12:34 +0800 (CST)
Received: from linux.localdomain (unknown [123.138.236.242])
	by front1 (Coremail) with SMTP id qMiowJAx3c7vRehq5cwxAA--.37701S3;
	Mon, 02 Nov 2026 16:12:33 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v1 1/2] selftests/bpf: Handle EOPNOTSUPP gracefully in test_loader
Date: Mon,  2 Nov 2026 16:12:29 +0800
Message-ID: <20261102081230.7063-2-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20261102081230.7063-1-yangtiezhu@loongson.cn>
References: <20261102081230.7063-1-yangtiezhu@loongson.cn>
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
X-CM-TRANSID:qMiowJAx3c7vRehq5cwxAA--.37701S3
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoW7KFW3Aw4DXr1rtr4xJFy7Jwc_yoW8ury7pa
	92gF4jkrZ2q3WS9a1UXa1DGFWFyF4kGFy3Kr1rWrs5Ars8JFn3tr1fta4agFn5GFZ3Z3Wr
	uasFyF4rZF17JFcCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9Fb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r126r13M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	tVWrXwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7V
	AKI48JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v2
	6r1Y6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17
	CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4UMIIF
	0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIx
	AIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2
	KfnxnUUI43ZEXa7IU8XyCJUUUUU==

When loading a BPF skeleton program via test_loader, certain test cases
such as jit_insns/cast_to_user may fail if the underlying hardware lacks
specific execution extensions required by newer features like BPF Arena.

Now that arch-specific JIT backends can dynamically report these missing
hardware extensions by returning -EOPNOTSUPP during object loading, the
user-space testing should handle this gracefully rather than treating it
as a generic loading failure.

Check the errno of bpf_object__load() to evaluate whether a load failure
originates from an unsupported platform capability (errno == EOPNOTSUPP).
If true, cleanly detour execution via test__skip() and branch to cleanup.
This allows test_progs to mark the test status as SKIPPED rather than
logging a false-alarm failure if the feature is not supported.

Before:
  $ sudo ./test_progs -a jit_insns/cast_to_user
  ...
  libbpf: map 'arena': failed to create: -EOPNOTSUPP
  run_subtest:FAIL:unexpected_load_failure unexpected error: -95 (errno 95)
  ...
  #193/2   jit_insns/cast_to_user:FAIL
  #193     jit_insns:FAIL
  Summary: 0/0 PASSED, 0 SKIPPED, 1/1 FAILED

After:
  $ sudo ./test_progs -a jit_insns/cast_to_user
  #193/2   jit_insns/cast_to_user:SKIP
  #193     jit_insns:OK (SKIP: 1/33)
  Summary: 1/0 PASSED, 1 SKIPPED, 0/0 FAILED

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 tools/testing/selftests/bpf/test_loader.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/bpf/test_loader.c b/tools/testing/selftests/bpf/test_loader.c
index d24e4fedae46..021818afbd3b 100644
--- a/tools/testing/selftests/bpf/test_loader.c
+++ b/tools/testing/selftests/bpf/test_loader.c
@@ -1474,6 +1474,10 @@ void run_subtest(struct test_loader *tester,
 			goto tobj_cleanup;
 		}
 	} else {
+		if (err < 0 && errno == EOPNOTSUPP) {
+			test__skip();
+			goto tobj_cleanup;
+		}
 		if (!ASSERT_OK(err, "unexpected_load_failure")) {
 			emit_verifier_log(tester->log_buf, true /*force*/);
 			goto tobj_cleanup;
-- 
2.42.0

