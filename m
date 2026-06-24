Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [4.193.249.245])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9B0238C2A0;
	Wed, 24 Jun 2026 08:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.193.249.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782290386; cv=none; b=MXMuJmh4k2lfNA3lNAjV/qT31fiPeu8Jm2y8kPb0aXA/2rr1SHE5NILIvUMR0mFLNVnNOX5zyNZ+DJgb/RCG565QB/+TpttA19f4yk2AewGVG7rlpIqfKnPhG6fEJbHeSbLqcAgYenqNmPmuHsA+ruhyh3Fx03t/I5ulP0mPxi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782290386; c=relaxed/simple;
	bh=wd0ZR1IJDcgV5XSXasa8q5qSsz2TrWaAlTN4JRi83ns=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=jSy+V7pE2a/JY0fwf20Tvqh7AD9qUBHTSf/p2ZcR/BM5i69wXZDlrjCOuh+K+t1gc8JujszvkrIqjxg67zulQl/BOaa0TPg15iTuopAiAtmGak0H3Ed0KnUYlpimfe0Ydksr/4Jq2Fqb3POwoWsPItzqOtktta5XKclJ6407YHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=JXXFlJPX; arc=none smtp.client-ip=4.193.249.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="JXXFlJPX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:Subject:Date:
	Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	To:Cc; bh=9OEU5pgl0y7Xt1kiXJu8/Zc8TlT5M10JUk//V7iT2D0=; b=JXXFlJ
	PXnn0XvAfWDhzkOcghW3PudxgU+wPgRaF4dxp8gvLi01RB3gdkBmWEwTlodjuYgJ
	qW4EMAoXWzSW2SDV/GWVoSdYrTpibtV6YFbZk4QxJCX5AMr1qPHlZeIzGVWWEs/y
	B0sB9dFnsYkpCzYBhCDlhRaPIHqm81V508p94=
Received: from [127.0.0.1] (unknown [101.6.30.195])
	by web2 (Coremail) with SMTP id yQQGZQCXcJjFlztqpEWBAg--.48810S2;
	Wed, 24 Jun 2026 16:39:33 +0800 (CST)
From: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
Subject: [PATCH bpf 0/2] bpf: Keep fastcall stack slots for helper stack
 reads
Date: Wed, 24 Jun 2026 16:39:32 +0800
Message-Id: <20260624-f01-12-fastcall-helper-stack-read-v1-0-e0a86085ef77@mails.tsinghua.edu.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMSXO2oC/yWNyw7CIBAAf6XZs5sArRz8FeOBx65FSSUsNSZN/
 72ox5nDzAZCNZHAZdig0jtJei0d9GmAMLvlTphiZzDKWGXNhKw0aoPspAWXM86UC1WU5sITK7m
 INk4xaGZ/1iP0TqnE6fN7XMEXhttfyuofFNq3Dvt+AEHwArWKAAAA
X-Change-ID: 20260624-f01-12-fastcall-helper-stack-read-6d4dc1ffb513
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: John Fastabend <john.fastabend@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Shuah Khan <shuah@kernel.org>, 
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782290375; l=1172;
 i=gnq25@mails.tsinghua.edu.cn; s=20260605; h=from:subject:message-id;
 bh=wd0ZR1IJDcgV5XSXasa8q5qSsz2TrWaAlTN4JRi83ns=;
 b=hfTB9qgKqBSxV9OB9NXHsSATEEfFw5UyHGYY00hI4+rqC82LxdfWNYMkaiDXy3O/5qwCkkIH3
 ZhmjKfMdHW4CF2gnd2JMPsiPg7ich9v3wDr6NbCTFrrEvdddT6+yHB4
X-Developer-Key: i=gnq25@mails.tsinghua.edu.cn; a=ed25519;
 pk=nqQ48fAxVTDp3z/IUmqv6BB+agXPpd8tQjDOBxwlgZo=
X-CM-TRANSID:yQQGZQCXcJjFlztqpEWBAg--.48810S2
X-Coremail-Antispam: 1UD129KBjvdXoWrtFyxWF1xtrWrKr4fGr17ZFb_yoWkZFb_Za
	1fAFyDZw47AFsayF9FkrnakryFk3yxGrW5JasFqr9xA34jqF43WrnYyF1UGFyUGwsrtr15
	ur4qvw1xG34a9jkaLaAFLSUrUUUUbb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb-kFc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wA2ocxC64kI
	II0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7
	xvwVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2
	z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4
	CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E74AGY7Cv6cx26r4r
	Kr1UJr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc
	8vx2IErcIFxwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCY02Av
	z4vE14v_GFyl42xK82IYc2Ij64vIr41l42xK82IY6x8ErcxFaVAv8VW8Ww4UJr1UMxC20s
	026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_
	JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14
	v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xva
	j40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JV
	W8JrUvcSsGvfC2KfnxnUUI43ZEXa7VU0Ysj5UUUUU==
X-CM-SenderInfo: xjqtjko6pdxz3vow2x5qjk3toohg3hdfq/1tbiAQEIA2o7idQ5jAAFs3

Fastcall spill/fill elision is guarded by a stack contract: stack slots in
the pattern may only be accessed by the pattern itself. Direct stack loads
and stores enforce that contract, but helper and kfunc memory arguments can
read from PTR_TO_STACK through check_stack_range_initialized() without
disabling the post-verification elision.

Make helper/kfunc stack memory checks enforce the fastcall contract after
resolving the range. Add a verifier selftest for a read-only helper access
through bpf_csum_diff().

Fixes: 5b5f51bff1b66 ("bpf: no_caller_saved_registers attribute for helper calls")

Signed-off-by: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
---
Nuoqi Gui (2):
      bpf: Keep fastcall spills for helper stack reads
      selftests/bpf: Cover fastcall helper stack reads

 kernel/bpf/verifier.c                              |  4 +++
 .../selftests/bpf/progs/verifier_bpf_fastcall.c    | 32 ++++++++++++++++++++++
 2 files changed, 36 insertions(+)
---
base-commit: 76f62d237538b456354a44e796a541cde03c6e28
change-id: 20260624-f01-12-fastcall-helper-stack-read-6d4dc1ffb513

Best regards,
--  
Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>

