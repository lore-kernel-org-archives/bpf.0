Received: from zg8tmja2lje4os4yms4ymjma.icoremail.net (zg8tmja2lje4os4yms4ymjma.icoremail.net [206.189.21.223])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 057AB4ADDB1;
	Wed, 17 Jun 2026 16:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.189.21.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781714772; cv=none; b=p931k0Fm/uKUY5OExiZi0aF6gW1X6bU/jZKxGU5UZEBHT5CneAXpvk9TZX3JsEi+mZpDEiIUI3FEkMwLU6L2yBHUZasSaAVim+vG4ld8s9bN1TUL+VNPhgDQWMxS5oqSnSqb4kWmoVDJXFxHjbidFVblrhCD2RN5vfXdPBl062g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781714772; c=relaxed/simple;
	bh=VP48m+HF8GWGxqAIuK+5MU8Hq/Pi3J+1HQAHi/NBmqU=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=FXyaAC1vjkYtk0mUGENWFoDgIGHUqZ4MQkhrg+Hao66dp9dCcazmatpa5HzwyyIkM7ZFjzBGuPcWSAj5B4mVOebUAajZ5HL/GHQzTel4VLdxRHa5XrhQxIMROQas+x3V59BbO+qtYQ8Q38hw76ltIW2hZiWmXL8KUgGN2i2YKPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=OC35BhTJ; arc=none smtp.client-ip=206.189.21.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="OC35BhTJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:Subject:Date:
	Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	To:Cc; bh=Dludpoi7Cr5Ga4xsK6D1yZT28P4mKgAJAsM0zOOGxQk=; b=OC35Bh
	TJ+xbhDfn+RdXZyYVkVYkOqlYHCF/WQGSN7D4mKwKd9+BGW10j1QweAwxSyt7l3D
	/NnQgVtteHmxL7kFzgdwOu2dcdbNMcPSpBFtbMCEX4zFtFWyzoyA32leaWstYtgk
	QA0MeX89bsMDTc0tfXUIkvwdnGrtlV++iY7mY=
Received: from [127.0.0.1] (unknown [101.6.30.195])
	by web5 (Coremail) with SMTP id zAQGZQA38cA1zzJqb498Ag--.43034S2;
	Thu, 18 Jun 2026 00:45:41 +0800 (CST)
From: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
Subject: [PATCH bpf v2 0/2] bpf: Fix stack slot index for Spectre v4 nospec
 checks
Date: Thu, 18 Jun 2026 00:45:42 +0800
Message-Id: <20260618-f01-11-stack-nospec-slot-index-v2-0-ede9495359b6@mails.tsinghua.edu.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADbPMmoC/4WOzQ6CMBCEX8Xs2SUthp948j0Mh9IusIqFsIVgC
 O8uoHePM5l83ywgNDAJXE8LDDSxcOe3EJ9PYBvja0J2W4ZYxalKdYKV0qg1SjD2ib6TnixK2wV
 k72hG0klSxsa6JM9gg/QDVTwfgjuUfQXFt5SxfJANO3qfNSyhG97HjUkf458x+2ecNCqki1G5K
 pV1Gd1ehluJgrCvm9FE5MbIeijWdf0AJisKSu8AAAA=
X-Change-ID: 20260615-f01-11-stack-nospec-slot-index-e155b2acd587
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: John Fastabend <john.fastabend@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Luis Gerhorst <luis.gerhorst@fau.de>, Shuah Khan <shuah@kernel.org>, 
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>, 
 Jiayuan Chen <jiayuan.chen@linux.dev>, 
 Emil Tsalapatis <emil@etsalapatis.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781714744; l=1801;
 i=gnq25@mails.tsinghua.edu.cn; s=20260605; h=from:subject:message-id;
 bh=VP48m+HF8GWGxqAIuK+5MU8Hq/Pi3J+1HQAHi/NBmqU=;
 b=Sgraxzp9IVh6gy24UxvMenGz4n322WPw+qRE1JhR51x/qFvCpFiFSmmDHmBPHoVn7yP+qx8Pt
 yNbTcut8h93AwRQE71Emb0P8e7aFxHIwt7dQ447Cc3L9IU+WPBcC1DJ
X-Developer-Key: i=gnq25@mails.tsinghua.edu.cn; a=ed25519;
 pk=nqQ48fAxVTDp3z/IUmqv6BB+agXPpd8tQjDOBxwlgZo=
X-CM-TRANSID:zAQGZQA38cA1zzJqb498Ag--.43034S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Ww4Dtw1DuFWrKw1rWF15Jwb_yoW8Aw4Upa
	yvkF1Sy34DGFyxuF1ay3W8KFyrWrykGr47Xr1aqw1UZa1rGFyxWFZ29a4UAw1fAas5XayF
	vFW3Xr90kayUAFJanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBC1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l8cAvFVAK
	0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4
	x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l
	84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWxJr1lnxkEFVAIw20F6cxK64vIFxWle2I262
	IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E74AGY7Cv6cx2
	6r4rKr1UJr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4
	CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCY
	02Avz4vE14v_JwCF04k20xvY0x0EwIxGrwCF04k20xvE74AGY7Cv6cx26r4rKr1UJr1l4I
	8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_Jrv_JF1lx2IqxVAqx4xG67AKxVWU
	JVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7V
	AKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42
	IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfU2L05UUUUU
X-CM-SenderInfo: xjqtjko6pdxz3vow2x5qjk3toohg3hdfq/1tbiAQYBA2oytN45-AADsx

check_stack_write_fixed_off() uses one byte-indexing scheme when checking
whether a fixed-offset stack write needs Spectre v4 sanitization, and another
scheme when recording the write into slot_type[].

For sub-8-byte writes this can make the sanitization check look at bytes that
are not overwritten by the write. A zeroed lower half-slot followed by a write
to the upper half-slot can therefore miss the nospec barrier for the second
write.

Use the same stack-byte index for the sanitization check and the slot update,
and add a focused verifier selftest that expects both half-slot writes to emit
nospec through the unprivileged loader lane.

Bounded impact: this fixes verifier/JIT Spectre v4 mitigation emission for a
fixed-offset stack-write corner case. No architectural verifier memory-safety
bypass, exploit chain, CVE, embargo, or security escalation is claimed.

Fixes: 2039f26f3aca ("bpf: Fix leakage due to insufficient speculative store bypass mitigation")

v1->v2:
  - drop __caps_unpriv(CAP_BPF) from the selftest
  - fix selftest style
  - use Fixes: 2039f26f3aca per review

v1: https://lore.kernel.org/bpf/20260617-f01-11-stack-nospec-slot-index-v1-0-e3a080b0cd7e@mails.tsinghua.edu.cn/

Signed-off-by: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
---
Nuoqi Gui (2):
      bpf: Fix stack slot index in nospec checks
      selftests/bpf: Cover stack nospec slot indexing

 kernel/bpf/verifier.c                              |  3 ++-
 .../testing/selftests/bpf/progs/verifier_unpriv.c  | 22 ++++++++++++++++++++++
 2 files changed, 24 insertions(+), 1 deletion(-)
---
base-commit: e4287bf34f97a88c7d9322f5bde828724c073a6b
change-id: 20260615-f01-11-stack-nospec-slot-index-e155b2acd587

Best regards,
--  
Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>

