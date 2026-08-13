Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [13.76.78.106])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D05743B42DD;
	Thu, 13 Aug 2026 12:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.76.78.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786622482; cv=none; b=h6y3YEFUdqjKADc9FeY88cyZ3Qw8bl9OFXdI0x8GDybV1K8Nr8NASnkA7q0K2hJB6tWHlEqWzRkrl3FT/ZRKDkngYhF9991Cfx5pSnc8/GQpkwn2g8yW4RmPIEJjn+JkHA7Ei3HxaGYw5zz3AepIwk1ZWbxgAneetDQKppNiuWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786622482; c=relaxed/simple;
	bh=ijObjGeW3Fel5QLJr4lHYonxQn33GrDYR5wWkz/Qw/k=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=mumNDaPLv+q8hlILweY15cVn9dRCxmZis5iHBn6oa7rZUGVlbb+IHi03zfV8Y5mrouxvUrvnekDKgeYhCl2AgCoUgRuJ2SH1QOf368/ZDTnWGhcg6IXyZTUnSJGqKZe4yCbw1cAiKGkeAvZzkYNZrKFnGzHRTxcAKNm7e3FUGOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=j6sog8bt; arc=none smtp.client-ip=13.76.78.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="j6sog8bt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:Subject:Date:
	Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	To:Cc; bh=fXb4k+zm0KD4/L1Qma4PIF9I1u/QVZGrQVhe4b+J1nE=; b=j6sog8
	btuv8MXeRBMoU97zd5TUlGIy7GCPjL+oE3F/Q2e6hdCL+gkDgAswXsYIaG126HOI
	RjQCO2sVZh8He0/TDUSyXw1vjICAPKLNMe3FzWsvj5wniAIdmHYOWzWr/XBnOmqo
	cYW72qg/gm6tf55hQNalUWsZrzn92zrSS+HyE=
Received: from [172.17.0.4] (unknown [101.6.30.195])
	by web3 (Coremail) with SMTP id ygQGZQAn+BbosX1q_MyTAA--.65327S2;
	Thu, 13 Aug 2026 20:00:46 +0800 (CST)
From: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>
Subject: [PATCH bpf-next 0/2] bpf, x86: Normalize IA32 kfunc return values
Date: Thu, 13 Aug 2026 12:00:39 +0000
Message-Id: <20260813-bpf-next-039-ia32-kfunc-return-v1-v1-0-37495ec632b5@mails.tsinghua.edu.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOixfWoC/zWNQQqDMBAAvyJ77sImwbb2K8VDNJt2KWxloyKIf
 zcUepzDzOxQ2IQLPJodjFcp8tUK7tLA+I76YpRUGTz5K91dwGHKqLzNSKFDicHjJy86ovG8mOL
 qMLWJiG8txS5C7UzGWbbf4wl/HfrjOAFpdYG3fQAAAA==
To: Wang YanQing <udknight@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>, Thomas Gleixner <tglx@kernel.org>, 
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
 "H. Peter Anvin" <hpa@zytor.com>, Shuah Khan <shuah@kernel.org>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786622447; l=1216;
 i=chenyy23@mails.tsinghua.edu.cn; s=kernel; h=from:subject:message-id;
 bh=ijObjGeW3Fel5QLJr4lHYonxQn33GrDYR5wWkz/Qw/k=;
 b=WfVEHcJN/dGstTAmrba3+TOQ/av6FOm/WuoStONYxaa42eSzcmTylZE6UdP/JE/LXadEO+VGK
 rq40wYJuUsqDGzq2PsKE8k7qfBbq/R1wEL3N7g6cypj16LgoYneRc+b
X-Developer-Key: i=chenyy23@mails.tsinghua.edu.cn; a=ed25519;
 pk=+Q11PEDVzoU+87KHlIeNWKwv/GiutzE5094ej7opM+s=
X-CM-TRANSID:ygQGZQAn+BbosX1q_MyTAA--.65327S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Gr48GrW5uF47Wr1rJF1xGrg_yoWkuFX_Zr
	WY9r97Wr4qvFW5Ja4xGr1rWrW7Ca1UKrW5AF1Fq3W7J34jgrsxJF4kXrnFq34xWF43JrZx
	XFs3urWxG3yaqjkaLaAFLSUrUUUUbb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb-xFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wA2ocxC64kI
	II0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7
	xvwVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28E
	F7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAac4AC62xK8xCEY4vEwIxC4wAS0I0E0xvYzx
	vE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VCjz48v1sIEY20_GrWk
	Jr1UJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5c
	I20VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS14v26r4a6rW5MxkIecxE
	wVAFwVW5JwCF04k20xvY0x0EwIxGrwCF04k20xvE74AGY7Cv6cx26r4rKr1UJr1l4I8I3I
	0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWU
	GVWUWwC2zVAF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI
	0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0
	rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r
	4UJbIYCTnIWIevJa73UjIFyTuYvjfUr6wZDUUUU
X-CM-SenderInfo: xfkh05r1stqzpdlo2hxwvl0wxkxdhvlgxou0/

The IA32 JIT stores BPF registers as pairs of 32-bit scratch words. Kfunc
returns narrower than 64 bits currently update only R0.low32, so full-width
uses can observe a stale R0.high32 value.

Patch 1 uses the BTF function model to sign- or zero-extend narrow returns
into EDX:EAX and stores both halves of R0.

Patch 2 adds IA32-specific test_loader support and unsigned bool and signed
int kfunc return regression tests.

Yiyang Chen (2):
  bpf, x86: Normalize narrow kfunc returns on IA32
  selftests/bpf: Cover IA32 narrow kfunc returns

Signed-off-by: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>
---
Yiyang Chen (2):
      bpf, x86: Normalize narrow kfunc returns on IA32
      selftests/bpf: Cover IA32 narrow kfunc returns

 arch/x86/net/bpf_jit_comp32.c                      | 53 +++++++++++---
 tools/testing/selftests/bpf/prog_tests/verifier.c  |  2 +
 tools/testing/selftests/bpf/progs/bpf_misc.h       |  1 +
 .../selftests/bpf/progs/verifier_kfunc_return.c    | 84 ++++++++++++++++++++++
 tools/testing/selftests/bpf/test_loader.c          | 13 ++--
 5 files changed, 140 insertions(+), 13 deletions(-)
---
base-commit: 6f033615ef8fb2374daa7e50a8ff68616bc850d2
-- 
2.43.0

