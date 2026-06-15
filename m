Received: from zg8tmtyylji0my4xnjeumjiw.icoremail.net (zg8tmtyylji0my4xnjeumjiw.icoremail.net [162.243.161.220])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CCCC336EF8;
	Mon, 15 Jun 2026 08:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.161.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781513853; cv=none; b=qQT0BGo0ZyFsKjoiRlN1qHgwziqYzor0iXOQTRxjaP2t61NMH3ThdauUlQ1GfgmUcVUgFXbej01JHN/FaHfIs5PMTGOUSe2BBpx1ydi32Dq+Pdem/MTpNfR5MueLMmobOc8SmksY/IUoqO5icAO+Z5cAhMgfb3bKeYNIfhJ72iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781513853; c=relaxed/simple;
	bh=y1e+Nvux4Y05P+8yrZaQFsU1IEgZjmCpx9N8Tq6Mj8A=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=NUt88OpZuhUaAz5IjvPXZTjZ/eQBx/aBLJ3IzRNmb0GDA+SBFJ8sFJZCE+njWt1xQCrNSaHjjOSRXAJtg2T/EBopLI90W7xFcWC3TbfDCGFelDxQRLkji75wNEU90bdsxDwYTyjO3orJVWC4CDiz5DuSqXxpz/KhN9eTW/P8ffc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=H1SH1SzE; arc=none smtp.client-ip=162.243.161.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="H1SH1SzE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:Subject:Date:
	Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	To:Cc; bh=gqdmvKRuruDvU1EYN3ZtEkzXReYCIkxcbVe7iApoUqY=; b=H1SH1S
	zEGgENxw49wUEzC+3pkTqGPPJ10CCSYOsRFpS9kvSeW078IScRhYy5SRIKbTJlOW
	J9Wr9CHqJuNM8Nf4Lt/gBWJ8fG1jVUSq3Ix2KA4BAVZTqs6TRNif6R2Zm8aShJeJ
	DYYDyeOiACsQ4z2O/R9OEEqrOjaKtjvq2nnTc=
Received: from [127.0.0.1] (unknown [101.6.30.195])
	by web5 (Coremail) with SMTP id zAQGZQA37r1vvi9qPuFwAg--.22668S2;
	Mon, 15 Jun 2026 16:57:21 +0800 (CST)
From: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
Subject: [PATCH bpf 0/2] bpf: Preserve rdonly_cast dynptr slice lifetime
Date: Mon, 15 Jun 2026 16:57:16 +0800
Message-Id: <20260615-f01-09-rdonly-cast-dynptr-lifetime-v1-0-2dd0a369e153@mails.tsinghua.edu.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGy+L2oC/yWNQQ6CMBAAv0L27CZdFIJ+xXgo7VbXYGm21UgIf
 7fqceYws0JmFc5walZQfkmWOVagXQPuZuOVUXxlaE3bm546DIbQHFH9HKcFnc0F/RJTUZwkcJE
 Ho2eiA3eWhv0ANZSUg7x/kzOMKcDlL/NzvLMr3zxs2wdGasKqiwAAAA==
X-Change-ID: 20260615-f01-09-rdonly-cast-dynptr-lifetime-de114e5a1838
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, Shuah Khan <shuah@kernel.org>, 
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781513842; l=2792;
 i=gnq25@mails.tsinghua.edu.cn; s=20260605; h=from:subject:message-id;
 bh=y1e+Nvux4Y05P+8yrZaQFsU1IEgZjmCpx9N8Tq6Mj8A=;
 b=hZu9XfOpTd0nz6dCOsTPDRwQXBcgI177LLwZ6tO3k49cr6/xRhyUXwkK3ZL5BaTbzq3haFPCI
 RHaV/ViZyPeA9kriUL6dd0Qyj+uhuIJlaZUc+G+PmpvtnBUtfz2029l
X-Developer-Key: i=gnq25@mails.tsinghua.edu.cn; a=ed25519;
 pk=nqQ48fAxVTDp3z/IUmqv6BB+agXPpd8tQjDOBxwlgZo=
X-CM-TRANSID:zAQGZQA37r1vvi9qPuFwAg--.22668S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAw1rJr1DAw13tw13uryUJrb_yoW5Wr17pa
	1FgFWYg34kJ3W7Ca9xAa12gFyF9rs5WF13Gr9rtryUZFn8WryFvrWUKa4jqF9Iya4kCr4F
	qw4qgas8CFWxZFJanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l8cAvFVAK
	0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4
	x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l
	84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2vYz4IE04k24VAvwVAKI4IrM2AIxVAIcx
	kEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6x8ErcxFaVAv8VW8
	Ww4UJr1UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6I
	AqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFylc2xS
	Y4AK67AK6r43MxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY20_GrWkJr1UJwCFx2
	IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v2
	6r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67
	AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IY
	s7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr
	1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjfUxv38DUUUU
X-CM-SenderInfo: xjqtjko6pdxz3vow2x5qjk3toohg3hdfq/1tbiAQYTA2ovr0If+QAAsZ

bpf_rdonly_cast() is an identity operation at runtime, but the verifier
currently assigns the result fresh return-state metadata. When the source
pointer comes from bpf_dynptr_slice(), that drops the relationship needed
to invalidate the alias when the dynptr is released.

Preserve the dynptr-slice lifetime metadata across bpf_rdonly_cast(), and
add verifier selftests covering cases where a dynptr slice is cast and then
read after the dynptr is released or after the originating dynptr stack slot is
overwritten while a clone still holds the reference. Also cover the valid clone
case where the cast alias is derived from the clone and remains usable after
the original dynptr is overwritten.

This fixes regressions introduced by 66e3a13e7c2c ("bpf: Add
bpf_dynptr_slice and bpf_dynptr_slice_rdwr") and a35b9af4ec2c ("bpf: Add a
kfunc for generic type cast").

Impact is bounded to verifier lifetime tracking for CAP-required BPF
programs. The evidence confirms stale read acceptance after dynptr release,
including a typed field-read shape, but does not demonstrate unprivileged
reachability, cross-context disclosure, controlled reuse, arbitrary kernel
read, write-capable aliasing, privilege escalation, crash, or KASAN/UAF
signal. No CVE, embargo, or security escalation is claimed.

Validation:
- The new dynptr_fail.c subtests exercise the verifier's dynptr-slice
  lifetime invariant across bpf_rdonly_cast(): a cast alias of a
  bpf_dynptr_slice() result must be invalidated when the dynptr is released or
  its stack slot overwritten, while a cast alias derived from a surviving clone
  must stay usable.
- Unpatched bpf at 76f62d237538: test_progs -t dynptr FAILs as expected,
  because the four __failure subtests
  (dynptr_rdonly_cast_{,typed_}slice_after_{release,overwrite}) are wrongly
  accepted - the stale read survives dynptr release.
- Patched with this series: test_progs -t dynptr PASSes, because those four
  casts are now rejected with "invalid mem access 'scalar'" and the two
  __success clone subtests remain accepted (all six dynptr_rdonly_cast_*
  subtests OK, rc 0).

Signed-off-by: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
---
Nuoqi Gui (2):
      bpf: Preserve dynptr slice lifetime across rdonly_cast
      selftests/bpf: Cover rdonly_cast dynptr slice lifetime

 include/linux/bpf_verifier.h                    |   5 +
 kernel/bpf/verifier.c                           |  36 ++++--
 tools/testing/selftests/bpf/progs/dynptr_fail.c | 160 ++++++++++++++++++++++++
 3 files changed, 193 insertions(+), 8 deletions(-)
---
base-commit: 76f62d237538b456354a44e796a541cde03c6e28
change-id: 20260615-f01-09-rdonly-cast-dynptr-lifetime-de114e5a1838

Best regards,
--  
Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>

