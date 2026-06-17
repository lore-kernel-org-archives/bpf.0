Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [52.175.55.52])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0579F33F8C1;
	Wed, 17 Jun 2026 17:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.175.55.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781718649; cv=none; b=QbWLFASwPDBMZzcAHsRJFzXgQFtDWSfUo4a2VP4CFUggjkd2iL4AevDSvTfAO6d4fJXsEt4gJ47/Vf661bUnKHrh9kjk1AGtT+YddXoCiHDkfDgfG/SOVwjzJ3S8wQ3Ea2jJRFH3Jdn6BjPn4cwwaELmB++v3tJrR6uO07+VfwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781718649; c=relaxed/simple;
	bh=KFUS8v1ApS7LKUzOJ1hF+nwYz/jvRCtAs/XN1SeVkl8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=svSnCFjEtm5iW6kTR2+6pMYMuitcKr9JHaHdB5Wqr1TV/VpC7Lh3eK0IawdMRW81BpwU30HGUKe5OWGB5n4WvyojnYyVqZN9INf9PttfOCCOqWdE07HtTCMXNElTcR/0qv012dhEKyFDD603DnpKbOE+UevtqnH4VnUVwX6s0t4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=q6KljoSJ; arc=none smtp.client-ip=52.175.55.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="q6KljoSJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:Subject:Date:
	Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	To:Cc; bh=wPYssxUSfeUqBF4i65FL97dI1+4Cv4ljoXAUl50LvtE=; b=q6Kljo
	SJZOuCVgK72tqaJiWxg80ekXa8uOXCGGBiIISiDJo0P7bMHOzeKtL5HLKFsl2pXd
	8ksnyCeqqcQAXhrBzWzbvaZbyfIe+kfZwxvGiTttUcF8DkQdrsaGdsP6PPoG00ZT
	f0KLzSRN53DKNJM0vG299gavi4kWrd+eX0QME=
Received: from [127.0.0.1] (unknown [101.6.30.195])
	by web2 (Coremail) with SMTP id yQQGZQAH5Jtk3jJq2CFbAg--.21290S2;
	Thu, 18 Jun 2026 01:50:28 +0800 (CST)
From: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
Subject: [PATCH bpf v3 0/2] bpf: Fix stack slot index for Spectre v4 nospec
 checks
Date: Thu, 18 Jun 2026 01:50:25 +0800
Message-Id: <20260618-f01-11-stack-nospec-slot-index-v3-0-780297041721@mails.tsinghua.edu.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGHeMmoC/4WOy26DMBBFfyXyuoNsE/Poqv8RZeHHEKZNDGIMI
 or49wLNIpsqy3t1dc59CMaBkMXn4SEGnIipi2vIPw7CtzZeECisWWipC1koA41UoBRwsv4HYsc
 9euBrl4BiwBlQGeO09cFUpVgh/YANzbvgJFzfiPNfyaP7Rp829DZriVM33Pcbk9rHT2P5zjgpk
 IC5lZV00ocSv26WrpwlpnhpR5thGDMfd/GkX9HVW7Te0AHrY21yU7viP/SyLL8bJaF9SgEAAA=
 =
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781718629; l=2098;
 i=gnq25@mails.tsinghua.edu.cn; s=20260605; h=from:subject:message-id;
 bh=KFUS8v1ApS7LKUzOJ1hF+nwYz/jvRCtAs/XN1SeVkl8=;
 b=nLy1cboX9zITm5z6bfDuTtUCh1dZOTPxUyLT9BPF3IMBeVaXOno71a551m6fXKPG0GK0mcWo/
 /Z5smfyJS8ZCW8JBZL7Jg1i+dpt27To325noL8FfEafPG6DbkJNcq7O
X-Developer-Key: i=gnq25@mails.tsinghua.edu.cn; a=ed25519;
 pk=nqQ48fAxVTDp3z/IUmqv6BB+agXPpd8tQjDOBxwlgZo=
X-CM-TRANSID:yQQGZQAH5Jtk3jJq2CFbAg--.21290S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Ww4Dtw1DuFWrKw1rWF15Jwb_yoW8uF45pF
	Z2kF1Sya4UGFyxWF1Sy3W8GF95urWkGr43Xr1Iqw15Zws3CFyxWFZ2k345Zw1fAaykX3yF
	yFW3XF909ayUAFJanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9l1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l8cAvFVAK
	0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4
	x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l
	84ACjcxK6I8E87Iv6xkF7I0E14v26r4UJVWxJr1lnxkEFVAIw20F6cxK64vIFxWle2I262
	IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E74AGY7Cv6cx2
	6r4rKr1UJr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4
	CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCY
	02Avz4vE14v_GwCF04k20xvY0x0EwIxGrwCF04k20xvE74AGY7Cv6cx26r4rKr1UJr1l4I
	8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AK
	xVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcV
	AFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8I
	cIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r
	4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfU4na9DUUUU
X-CM-SenderInfo: xjqtjko6pdxz3vow2x5qjk3toohg3hdfq/1tbiAQIBA2oytN5J7QAAsX

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

Signed-off-by: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
---
Changes in v3:
- selftests/bpf: drop the stray space in the __xlated_unpriv stack-store
  expectations ("(r10 - 4)"/"(r10 - 8)" -> "(r10 -4)"/"(r10 -8)")
- Link to v2: https://lore.kernel.org/bpf/20260618-f01-11-stack-nospec-slot-index-v2-0-ede9495359b6@mails.tsinghua.edu.cn/

Changes in v2:
- drop __caps_unpriv(CAP_BPF) from the selftest
- fix selftest style
- use Fixes: 2039f26f3aca per review
- Link to v1: https://lore.kernel.org/bpf/20260617-f01-11-stack-nospec-slot-index-v1-0-e3a080b0cd7e@mails.tsinghua.edu.cn/

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

