Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [207.46.229.174])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 413DB3E16B2;
	Sat, 13 Jun 2026 12:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.46.229.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781354330; cv=none; b=QSgtH0SfXpFDoWk0d8jJcyGJHFRnFSCjdjNGKspElDkL5Rk7Su+kwRDIL/NU72RvbWYT80LWKfyBcJWM0WsxQL989Bf3iyekKfDgi5pTrU8s+7qUkaSh3MrufFlSjcIPdBUIUu2ohVVrFdFll67+nBLM6zB0AlBSUm0iNmO6G18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781354330; c=relaxed/simple;
	bh=c9Mkc7qXykqZ66QWAcrUwpC2MdZb8FHvgFJEQkR8Y6c=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=KXrEJ8B/tAZa+lUqQ8pbYvj9wkbVzCxbj8kVsspshJgcPkuTrR7WjDewWBryZLC1oV4IJ6PvSUK53sgE6uDDlfgsaTiP0/Bn1TwGaTcs/NcXtf/MbLBgUJze3gzLcqW6+WGroy8tkO98mAyv6kqzda4w4eOXGx25fvgpGamp9po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=o75mae4u; arc=none smtp.client-ip=207.46.229.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="o75mae4u"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:Subject:Date:
	Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	To:Cc; bh=aJ2q4Llxb/hLXLB7o4lFzEeI3oFlDBe4yTkSNTt3O+s=; b=o75mae
	4ugROWVfGaGl2We6/qL3dH3WHj7x0vjUMlCxrY8/40/q8gKh8LlTDcq6omOT0bof
	5rXB6eclnyvCXnuhULUHu+YRWUnfI+iaW0CLnAA4TWXnwMDwmRgqbVdDCokyoOYd
	lzBE9J05PjbJGsx6BHSbnUmJO5PRY0qgWnX+Y=
Received: from [127.0.0.1] (unknown [101.6.30.195])
	by web3 (Coremail) with SMTP id ygQGZQD3RJJETy1qoxlnAg--.6726S2;
	Sat, 13 Jun 2026 20:38:28 +0800 (CST)
From: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
Subject: [PATCH bpf-next v2 0/2] bpf: Preserve untrusted memory pointer
 type on scalar add
Date: Sat, 13 Jun 2026 20:38:26 +0800
Message-Id: <20260613-f01-03-scalar-add-bpf-next-v2-v2-0-ce07bec3f72b@mails.tsinghua.edu.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEJPLWoC/zWM0QrCMAxFf2Xk2UBWZaz+iviQtalGpI5mG4Oxf
 7cq3rfDPZwNTIqKwbnZoMiipq9cwR0aCHfON0GNlcGR66hrCRO1SEe0wE8uyDHiMCbMsk64OCS
 u6/uT9+KhNsYiSddv/wJ/Ea6/x+bhIWH65GHf3321CkiLAAAA
X-Change-ID: 20260610-f01-03-scalar-add-bpf-next-v2-0aaaa88499e9
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>
Cc: Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Shuah Khan <shuah@kernel.org>, bpf@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781354309; l=2405;
 i=gnq25@mails.tsinghua.edu.cn; s=20260605; h=from:subject:message-id;
 bh=c9Mkc7qXykqZ66QWAcrUwpC2MdZb8FHvgFJEQkR8Y6c=;
 b=1yScIWW0ujuS45UNfDFvCjZW4fbXbUdIaSPV+pJThGYQ6LIetzfrgQYHfV6Xeb0hEY5DXywF8
 T7kH01fHZH6DLhHPxcrRzkxt+FjWXJNzstgSsKJK28/+W88kFGl0Zye
X-Developer-Key: i=gnq25@mails.tsinghua.edu.cn; a=ed25519;
 pk=nqQ48fAxVTDp3z/IUmqv6BB+agXPpd8tQjDOBxwlgZo=
X-CM-TRANSID:ygQGZQD3RJJETy1qoxlnAg--.6726S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Cr15Cw1DWw45GrW3XFWkJFb_yoW8KF18pF
	Z3Gr1YyrWkAF17Za43CayjvF45Kr4rKrWj9F17t34xu3W3KFy0qF17K3y5ArWrCa4DJas0
	qryYy3ZIgFW7AaDanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9v1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l8cAvFVAK
	0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4
	x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2
	z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4
	CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E74AGY7Cv6cx26r4r
	Kr1UJr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc
	8vx2IErcIFxwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCY02Av
	z4vE14v_Xr1l42xK82IYc2Ij64vIr41l42xK82IY6x8ErcxFaVAv8VW8Ww4UJr1UMxC20s
	026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_
	JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14
	v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xva
	j40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JV
	W8JrUvcSsGvfC2KfnxnUUI43ZEXa7VU0FksPUUUUU==
X-CM-SenderInfo: xjqtjko6pdxz3vow2x5qjk3toohg3hdfq/1tbiAQIRA2oshq+wtgAAs4

scalar += rdonly_untrusted_mem reaches adjust_ptr_min_max_vals() with the
pointer as the source register. The untrusted PTR_TO_MEM case returns there
without updating the scalar destination, leaving stale verifier state.

Update the destination before taking the untrusted PTR_TO_MEM early return.
ADD and pointer -= scalar keep the existing "do not track offsets" rule for
untrusted memory, while scalar -= pointer and unsupported pointer ALU
operations remain rejected instead of being accepted through the early return.

Patch 1 fixes the untrusted PTR_TO_MEM ALU early return. Patch 2 adds
verifier regression tests for scalar +=, scalar -=, and scalar ^= with
bpf_rdonly_cast(..., 0).

v1->v2:
  - Preserve the untrusted pointer state for scalar += pointer instead of
    rejecting the addition.
  - Reject scalar -= pointer and unsupported pointer ALU operations in the
    untrusted PTR_TO_MEM early return.
  - Update selftests for the new allowed-addition semantics and non-ADD ALU
    coverage.
v1: https://lore.kernel.org/bpf/20260609-f01-03-scalar-add-bpf-next-v1-0-e6212e274155@mails.tsinghua.edu.cn/

Validation:

  unpatched bpf-next 8496d9020ff3 with the new verifier cases:
    scalar_add_tracks_pointer: FAIL
      BPF_PROG_LOAD succeeded unexpectedly
    scalar_sub_ptr_not_ok: FAIL
      BPF_PROG_LOAD succeeded unexpectedly
    scalar_xor_ptr_not_ok: FAIL
      BPF_PROG_LOAD succeeded unexpectedly
    SUMMARY: FAIL

  patched bpf-next base 8496d9020ff3 + this series:
    scalar_add_tracks_pointer: PASS
      R1 bitwise operator &= on pointer prohibited
    scalar_sub_ptr_not_ok: PASS
      R1 tried to subtract pointer from scalar
    scalar_xor_ptr_not_ok: PASS
      R1 bitwise operator ^= on pointer prohibited
    SUMMARY: PASS

Signed-off-by: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
---
Nuoqi Gui (2):
      bpf: Preserve untrusted memory pointer type on scalar add
      selftests/bpf: Cover scalar add from rdonly untrusted memory

 kernel/bpf/verifier.c                              | 28 +++++++++++-
 .../selftests/bpf/progs/mem_rdonly_untrusted.c     | 52 ++++++++++++++++++++++
 2 files changed, 78 insertions(+), 2 deletions(-)
---
base-commit: 8496d9020ff37a33c2a7b2fc84350fd03ffbde78
change-id: 20260610-f01-03-scalar-add-bpf-next-v2-0aaaa88499e9

Best regards,
--  
Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>

