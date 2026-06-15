Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [52.229.168.213])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D9E43C0A0D;
	Mon, 15 Jun 2026 08:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.229.168.213
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781511013; cv=none; b=XfG70FpkvT8QatDmBnHltpF/UkXC2KxIdTRf/dM/H2bFVTCKTVentkropEPfh6L6naLWb5xhDFWgPWkOkc6IwmmeESSUYZlviF9/wPhH+UtVDfyd1mFu2hxnPIRlfi/l1ZduKobeoU6xH1jIOuowuwCWNEnFCDHs+WkFLVs1PJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781511013; c=relaxed/simple;
	bh=Gpl06jFeGhu9c8sQi0oLYiQjFt08INFxkVag1vtnZ0g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hGAzMbvK0Xm66IUf823B/0XIcbnvp2bRbOdTVxl+ld2WgEbW1LbeRop8YloLpqp/jzxDEAO0sBX3h//I1w9G8FGGXTqAYAlHunCK1azKGZaM4w56CZc/ANrnCb+qDWRyqhnTz+X32IJOl8cuKUuiKLn+JiCy3fEj4sioQ8xQi28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=kg89dtzd; arc=none smtp.client-ip=52.229.168.213
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="kg89dtzd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:Date:Subject:
	MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	References:In-Reply-To:To:Cc; bh=J4vg9EIyDPaiflYYPly+g/3DRBB54AW
	glqwMwVzIlbY=; b=kg89dtzdKxrx35vgmpLcgcc2VdVMW2P5DZ5c7ZaF52ett3b
	Z3WOV/aEmMDxOsC+wKj21obTuA+/5w+VGX5bDVTjDhPyVGOrF84UaReO4+oCR/9y
	DjE5xURom9sPfImLO0gr2jGYRB2LneuwSud/0idc6pinykDDJxyMATu5h51c=
Received: from [127.0.0.1] (unknown [101.6.30.195])
	by web4 (Coremail) with SMTP id ywQGZQC3y6BWsy9qKJVJAg--.52153S4;
	Mon, 15 Jun 2026 16:09:59 +0800 (CST)
From: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
Date: Mon, 15 Jun 2026 16:09:54 +0800
Subject: [PATCH bpf-next 2/2] selftests/bpf: Cover half-slot cleanup of
 pointer spills
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260615-f01-06-half-slot-pointer-spill-v1-2-47f1c18a8965@mails.tsinghua.edu.cn>
References: <20260615-f01-06-half-slot-pointer-spill-v1-0-47f1c18a8965@mails.tsinghua.edu.cn>
In-Reply-To: <20260615-f01-06-half-slot-pointer-spill-v1-0-47f1c18a8965@mails.tsinghua.edu.cn>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, Shuah Khan <shuah@kernel.org>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781511000; l=1489;
 i=gnq25@mails.tsinghua.edu.cn; s=20260605; h=from:subject:message-id;
 bh=Gpl06jFeGhu9c8sQi0oLYiQjFt08INFxkVag1vtnZ0g=;
 b=sPTOdh/wjqYHm4pMTjEGaSYEDO+Fn+f41hiuLCeISO5w3dLcVzWuG5Wfksu0xWMZcWp3zIwOU
 /tS/SMmMy8yAiaRsDvkb87Jk9eQZrn2KQbet8hD5XcrYTxECp3mRvW4
X-Developer-Key: i=gnq25@mails.tsinghua.edu.cn; a=ed25519;
 pk=nqQ48fAxVTDp3z/IUmqv6BB+agXPpd8tQjDOBxwlgZo=
X-CM-TRANSID:ywQGZQC3y6BWsy9qKJVJAg--.52153S4
X-Coremail-Antispam: 1UD129KBjvJXoW7uFWkJry7WFW7Jr13GryrCrg_yoW8XF1kpr
	97WasxKFZ3urn7C3W3CFWkGF1rKFn2vryF9F4SyFyUAF18tr1qqr4kKF4UJrsI9an5Xw4F
	vFySqa17uF1UJrJanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9v1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l8cAvFVAK
	0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4
	x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJr0_GcWl84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2
	z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4
	CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E74AGY7Cv6cx26r4r
	Kr1UJr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc
	8vx2IErcIFxwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCY02Av
	z4vE14v_GFyl42xK82IYc2Ij64vIr41l42xK82IY6x8ErcxFaVAv8VW8Ww4UJr1UMxC20s
	026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_
	JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14
	v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xva
	j40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JV
	W8JrUvcSsGvfC2KfnxnUUI43ZEXa7VU0Ysj5UUUUU==
X-CM-SenderInfo: xjqtjko6pdxz3vow2x5qjk3toohg3hdfq/1tbiAgYTA2ovr8QHzgABsy

Add a verifier regression test for a pointer spill whose high half is
cleaned dead while the low half remains live. Force checkpoint creation
with BPF_F_TEST_STATE_FREQ and assert the verifier log reaches the
checkpoint and the subsequent 32-bit fill before rejecting the partial fill
from a non-scalar spill.

Signed-off-by: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
---
 .../testing/selftests/bpf/progs/verifier_spill_fill.c  | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_spill_fill.c b/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
index 6bc721accbae..0174887e28f5 100644
--- a/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
+++ b/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
@@ -1359,4 +1359,22 @@ __naked void var_off_write_over_scalar_spill(void)
 	: __clobber_all);
 }
 
+SEC("socket")
+__description("partial fill from cleaned pointer spill")
+__failure
+__log_level(2)
+__msg("1: (05) goto pc+0")
+__msg("2: (61) r0 = *(u32 *)(r10 -4)")
+__msg("invalid size of register fill")
+__flag(BPF_F_TEST_STATE_FREQ)
+__naked void partial_fill_from_cleaned_pointer_spill(void)
+{
+	/* Spill R1(ctx), then force a checkpoint and half-slot cleanup. */
+	asm volatile ("*(u64 *)(r10 - 8) = r1;"
+		      "goto +0;"
+		      "r0 = *(u32 *)(r10 - 4);"
+		      "exit;"
+		      ::: __clobber_all);
+}
+
 char _license[] SEC("license") = "GPL";

-- 
2.34.1

