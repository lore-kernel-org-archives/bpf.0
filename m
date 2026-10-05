Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [52.187.6.220])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E97024C14E7;
	Mon,  5 Oct 2026 15:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.187.6.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791213226; cv=none; b=L0BJNReoJGcMOZ/N+ke9uvgcaRDV3Vot6lhxAv+d1+mVV7xgerCJuBdop9+WpEj92vUUKOQYMm7jfD+DVu0DkBg4RcvUR226p3RKnqX7AEbWxQmBEv4kIL488nFUsT49F+7Tw8zWAbaUjXk+jmWYBD58dYNXW82GubbzlSVcPBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791213226; c=relaxed/simple;
	bh=pJU3lerMSTkvker9UBB12y7U1kf54n1WOEYuByMKDFM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=h3cRhwBXIpZT+MQZEc9ytUCyXkrGS/e+TfodGpNRfUdpk8BpuqA0PwlRdHIaopdfsARwfOKnpMe47pDMHqLQKSmDtlCORNuF+GgLSiF+S9myXTdMMRIsF1/QUQwsj2QmTOhS4wYw1WJ1gNHbkM7an1qHh3iOTSJDKTBjSVtufzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=ash3kpwS; arc=none smtp.client-ip=52.187.6.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="ash3kpwS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:Subject:Date:
	Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	To:Cc; bh=KP7y2p56D8Q78sfri8PMDPkRWq4kUYZWd1Yi9EI/0Kk=; b=ash3kp
	wSp6ebX9fZR6zfLdirIGJZMIhYmuamo1ktRE46Y0etjFSQ3WfZcxi2R0BexfQBlA
	INKK1T4bzSB046hS966QMj7YkX0JqOw0+QDJKIk6YdEYOfOIlimyv1H/lhyklk2I
	zOhk50GxjYBHFT8y6CZEIOw6K4YKyLiXTISsQ=
Received: from [172.17.0.2] (unknown [101.6.30.195])
	by web4 (Coremail) with SMTP id ywQGZQCHSAZ6vsNq8u+4AA--.39659S2;
	Mon, 05 Oct 2026 23:13:05 +0800 (CST)
From: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>
Subject: [PATCH bpf 0/2] bpf: Require referenced or trusted pointer for
 __arg_trusted arg
Date: Mon, 05 Oct 2026 15:12:56 +0000
Message-Id: <20261005-a3-arg-trusted-v4-v1-0-50ee0268fd39@mails.tsinghua.edu.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHi+w2oC/x3MQQ5AMBBA0as0szZJ0QquIhalg9kg0xKJ9O4ay
 7f4/4VAwhSgVy8I3Rz42DPKQsG8uX0lZJ8Nla6aUmuLrkYnK0a5QiSPt8HOW9+Z1pKdHOTuFFr
 4+Z8DTOcCY0ofl+yFB2gAAAA=
To: Eduard Zingerman <eddyz87@gmail.com>, 
 Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov <ast@kernel.org>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Yonghong Song <yonghong.song@linux.dev>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>, Shuah Khan <shuah@kernel.org>, 
 Jiri Olsa <jolsa@kernel.org>, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, John Fastabend <john.fastabend@gmail.com>, 
 Emil Tsalapatis <emil@etsalapatis.com>, bpf@vger.kernel.org, 
 Song Liu <song@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791213186; l=1492;
 i=chenyy23@mails.tsinghua.edu.cn; s=kernel; h=from:subject:message-id;
 bh=pJU3lerMSTkvker9UBB12y7U1kf54n1WOEYuByMKDFM=;
 b=p+W2l2x4ve+LvoodoT89Ej+eRS9RQflsbz2vd4tFsT0MZnM+/F/Nj5b+KNj8mYqhfhEIiz5lf
 CRwFlTmmw1/APscQKve866GtDbQu78haHffOCth7XuwXY6Z8w4BUdAr
X-Developer-Key: i=chenyy23@mails.tsinghua.edu.cn; a=ed25519;
 pk=+Q11PEDVzoU+87KHlIeNWKwv/GiutzE5094ej7opM+s=
X-CM-TRANSID:ywQGZQCHSAZ6vsNq8u+4AA--.39659S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uw18JFW7CFyDKF18WFWDCFg_yoW8Xr43pF
	48Krn0gF4kCFsFy3s3tF4Ivry3Zrs5Aay5Cr1xJayfCFs8WrWxJrWYkFWDX3WYkr95G34Y
	vF909w1Fga4DC3DanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUB0b7Iv0xC_KF4lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
	cIk0rVWrJVCq3wA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjx
	v20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwA2z4x0Y4vE
	x4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAaw2AFwI0_Jr
	v_JF1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
	F2IEw4CE5I8CrVC2j2WlYx0E74AGY7Cv6cx26r4rKr1UJr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS14v26r4a
	6rW5MxkIecxEwVAFwVW5WwCF04k20xvY0x0EwIxGrwCF04k20xvE74AGY7Cv6cx26r4rKr
	1UJr1l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
	jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2I
	x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK
	8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I
	0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUcPl1DUUUU
X-CM-SenderInfo: xfkh05r1stqzpdlo2hxwvl0wxkxdhvlgxou0/

A global subprogram parameter tagged __arg_trusted is specified to accept
only the PTR_TRUSTED flavor of PTR_TO_BTF_ID, but the call-site check also
accepts a bare PTR_TO_BTF_ID and an MEM_RCU one.

check_reg_type() resolves the accepted types from the base argument type
alone without consulting arg_type's PTR_TRUSTED bit, and the trusted/RCU
enforcement in check_func_arg() is gated on is_kfunc(meta) so it never runs
for a subprogram call. A caller can therefore pass a pointer that is not
trusted and the callee is verified as holding PTR_TRUSTED, which makes the
dereference a raw load instead of a BPF_PROBE_MEM probe and lets the callee
pass the pointer on to a kfunc that would have rejected it at the original
call site.

Reject a PTR_TO_BTF_ID that is neither referenced nor trusted when the
argument is marked PTR_TRUSTED. A referenced register is accepted, as in
is_trusted_reg(). PTR_MAYBE_NULL is not counted as unsafe when __arg_nullable
declares it, so trusted-and-nullable arguments keep working. The kfunc path
is unchanged.

Yiyang Chen (2):
      bpf: Require referenced or trusted pointer for __arg_trusted arg
      selftests/bpf: Cover non-trusted pointer to __arg_trusted subprog arg

 kernel/bpf/verifier.c                              | 21 ++++++++++++
 .../selftests/bpf/progs/verifier_global_ptr_args.c | 40 ++++++++++++++++++++++
 2 files changed, 61 insertions(+)

base-commit: d82cbceca49252bb0cd695326af8206c734e2744

--
2.34.0

