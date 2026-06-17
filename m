Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [4.193.249.245])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BA71481AA4;
	Wed, 17 Jun 2026 15:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.193.249.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781709651; cv=none; b=stiFTwyQsAwQgjd/EPORipCytryBl0EdYSk5u3oHO99koIx7p4fhZyu1h0mOugb0VzDhIxhvOkik4MooMllKLVkMewhyMze5g0R7Z3yse31vDrJriwg9dnnaLDiLtLw14XXs/vToboWxcbEOQQ4GMb9/uOM6skKOnkjC4NVq+s8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781709651; c=relaxed/simple;
	bh=bymG2Fo8Eo2lYLiyorukaWnmoHkPOjWIVRPwmtpsXuc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=VA1MmBiLtWp0L+MaNfrx0RkKZNr2HPyB5OIlokMK39P2YhGBddrCS0EeA2dkr21MyEAGcaUVODuN4hLiWCQvcLYtWxnyMha4YwcvdHoW+119FVBSoxgwdu7rwvaXQLm8Hf/oBfN9QjMwhw8ckeFip67k8oWPFrhYyfoCNswQ48w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=fx5iSRNt; arc=none smtp.client-ip=4.193.249.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="fx5iSRNt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:Subject:Date:
	Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	In-Reply-To:References:To:Cc; bh=BFZYs3SXwPXa43+U76H8n8oRjgtgDEL
	Kth53FpkSmGQ=; b=fx5iSRNt8JCYyX/Gk/4TbnQVmW3oGU5pZgFUdhO87gjqhfY
	iPxk9Em1mL163dTj3UXoF+86EcLuODtZKgPjL62JDGlxpTJhRhqcxzx7EkWrFM9w
	C4jHmDLNw4t+8k/6oCj/ASV644JhuPbjZHETKb8XeKsWDKL8WshbV7aiLbMc=
Received: from [127.0.0.1] (unknown [101.6.30.195])
	by web2 (Coremail) with SMTP id yQQGZQCXcJg6uzJqVHJaAg--.59129S2;
	Wed, 17 Jun 2026 23:20:27 +0800 (CST)
From: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
Subject: [PATCH bpf-next v2 0/2] bpf: Preserve pointer spill metadata
 during half-slot cleanup
Date: Wed, 17 Jun 2026 23:20:19 +0800
Message-Id: <20260617-f01-06-half-slot-pointer-spill-v2-0-42b9cdc3cf64@mails.tsinghua.edu.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADO7MmoC/4WOTQ6CMBCFr0Jm7RBKFNCV9zAsSpnCmFpIpxCM4
 e4iunf58n6+9wKhwCRwSV4QaGbhwW8iPyRgeu07Qm43DXmWF1mhSrSZwqzAXjuL4oaI48A+UkA
 Z2TnUR10pIt3kpoFtZAxkedkBN2hGi56WCPXXkam5k4mf/U+2Z4lDeO5fZrU3ftjTP+y8uXgsr
 TKq0tW5OF0fmp2kUdh3/aRTaqfUeKjXdX0De0rTHvQAAAA=
X-Change-ID: 20260617-f01-06-half-slot-pointer-spill-a4a81eeab2cb
In-Reply-To: <20260615-f01-06-half-slot-pointer-spill-v1-0-47f1c18a8965@mails.tsinghua.edu.cn>
References: <20260615-f01-06-half-slot-pointer-spill-v1-0-47f1c18a8965@mails.tsinghua.edu.cn>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781709629; l=1866;
 i=gnq25@mails.tsinghua.edu.cn; s=20260605; h=from:subject:message-id;
 bh=bymG2Fo8Eo2lYLiyorukaWnmoHkPOjWIVRPwmtpsXuc=;
 b=UhrAeFhHj3CZr404+EwBhdi8XH4MhFQYS1Xg1IZlYU7uwKjWUp8ZGKg9jZH5PXsymVuDWnwmQ
 mNzbADlGrk/CGLN2KrmHZWoljzhufMJl96aL9W/3EA551IJrZbmEZdv
X-Developer-Key: i=gnq25@mails.tsinghua.edu.cn; a=ed25519;
 pk=nqQ48fAxVTDp3z/IUmqv6BB+agXPpd8tQjDOBxwlgZo=
X-CM-TRANSID:yQQGZQCXcJg6uzJqVHJaAg--.59129S2
X-Coremail-Antispam: 1UD129KBjvJXoW7AF17XrWfCF1UCry3ur15Jwb_yoW8CryUpF
	ySg3ZagwsrGF1IkF13Aa18KFy5CFn2k34jgF13try7Z34Yqw1UZF4kK3y3Zan09a4kJw4r
	Kr4rXwn5uFn8ArJanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9v1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l8cAvFVAK
	0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4
	x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2
	z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4
	CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E74AGY7Cv6cx26r4r
	Kr1UJr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc
	8vx2IErcIFxwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCY02Av
	z4vE14v_XrWl42xK82IYc2Ij64vIr41l42xK82IY6x8ErcxFaVAv8VW8Ww4UJr1UMxC20s
	026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_
	JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14
	v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xva
	j40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JV
	W8JrUvcSsGvfC2KfnxnUUI43ZEXa7VU8EAp5UUUUU==
X-CM-SenderInfo: xjqtjko6pdxz3vow2x5qjk3toohg3hdfq/1tbiAQEBA2oyQ831mAAFs8

__clean_func_state() cleans stack liveness in 4-byte halves. When the high
half of a spilled register slot is dead but the low half remains live, it can
currently degrade the low half of any STACK_SPILL to raw stack bytes and clear
the saved spilled_ptr metadata.

That is safe for scalar spills, but not for non-scalar pointer spills. A later
partial 32-bit fill from the remaining live half can otherwise avoid the normal
non-scalar spill rejection.

Keep pointer spill provenance intact for that half-live case and add a verifier
regression test for the reported shape.

Validation:

- A raw `bpf(BPF_PROG_LOAD)` reproducer exercises the half-slot cleanup case by
  spilling `r1` as a pointer, executing `goto +0`, and then doing a 32-bit fill
  from `fp-4`.
- Unpatched `bpf-next` at 7bfb93e3475be9de894f1cecd3a727d3e1649b03:
  selftest FAIL as expected because the verifier accepts the partial
  pointer-spill fill.
- Patched with this series: PASS because the verifier rejects the same load at
  `r0 = *(u32 *)(r10 -4)` with `invalid size of register fill`.

v1->v2:
  - Correct the Fixes tag to be23266b4a08 ("bpf: 4-byte precise
    clean_verifier_state")

Link to v1: https://patch.msgid.link/20260615-f01-06-half-slot-pointer-spill-v1-0-47f1c18a8965@mails.tsinghua.edu.cn

---
Nuoqi Gui (2):
      bpf: Preserve pointer spill metadata during half-slot cleanup
      selftests/bpf: Cover half-slot cleanup of pointer spills

 kernel/bpf/states.c                                    | 13 +++++++------
 .../testing/selftests/bpf/progs/verifier_spill_fill.c  | 18 ++++++++++++++++++
 2 files changed, 25 insertions(+), 6 deletions(-)
---
base-commit: 7bfb93e3475be9de894f1cecd3a727d3e1649b03
change-id: 20260617-f01-06-half-slot-pointer-spill-a4a81eeab2cb

Best regards,
--  
Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>

