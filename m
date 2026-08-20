Received: from outboundhk.mxmail.xiaomi.com (outboundhk.mxmail.xiaomi.com [207.226.244.123])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EE523B71D8;
	Thu, 20 Aug 2026 09:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.226.244.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787217781; cv=none; b=KYqtCbVngnmLhDjOmp3xsTEw5RTekuVbST6SXo37ftlFqn+p3c2z3/Trx+Z5n/Ayv+pzqI/O2UNZqGJhsRIt0OehXjktegQXuLdRpWv3fS90Dry2Vx4MGXMRMEHgrgdoBwDWxrlyyECHFTMAWhh5qCn0D5L29W1NcHzRTeBvQt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787217781; c=relaxed/simple;
	bh=YgeiKNWxrt8vLulAhRNAlJ+qJklgunD14aUXK0+MBy4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pITRPplekZpUeE8095O5oxcBRuZ/g2gThnGGgVK1JTzqo9OGiqWFnHhvY1FwD5krc+KftiRCvwT7bQvMOUEsUtaWEHia4qs2qQevx3kCL7wwo1O//x4bD8f2hmPOplj+yl2VqWdpYd3vS0O6eCzZirJM4c800DD89OFDY3SEJWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=xiaomi.com; spf=pass smtp.mailfrom=xiaomi.com; arc=none smtp.client-ip=207.226.244.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=xiaomi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaomi.com
X-CSE-ConnectionGUID: aDCvJATcTjCAUTLNBBP4ow==
X-CSE-MsgGUID: FXGvEa4wRd6blKwUVn7ayA==
X-IronPort-AV: E=Sophos;i="6.25,232,1779120000"; 
   d="scan'208";a="186227224"
From: meishaoming <meishaoming@xiaomi.com>
To: <ast@kernel.org>
CC: meishaoming <meishaoming@xiaomi.com>, <daniel@iogearbox.net>,
	<andrii@kernel.org>, <memxor@gmail.com>, <martin.lau@linux.dev>,
	<eddyz87@gmail.com>, <song@kernel.org>, <yonghong.song@linux.dev>,
	<jolsa@kernel.org>, <emil@etsalapatis.com>, <bpf@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v2 bpf] bpf: array: reject max_entries > INT_MAX to prevent signed-iterator overflow
Date: Thu, 20 Aug 2026 17:22:46 +0800
Message-ID: <20260820092246.61338-1-meishaoming@xiaomi.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260820084643.35489-1-meishaoming@xiaomi.com>
References: <20260820084643.35489-1-meishaoming@xiaomi.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: BJ-MBX15.mioffice.cn (10.237.8.135) To BJ-MBX03.mioffice.cn
 (10.237.8.123)

BPF_MAP_TYPE_PROG_ARRAY (and other array maps) take max_entries as a u32
from userspace via bpf(BPF_MAP_CREATE), but array_map_alloc_check() only
guards value_size > INT_MAX and leaves max_entries unchecked.

When the map is later freed, fd_array_map_free() iterates the ptrs[] array
with a signed int loop variable:

    for (i =3D 0; i < array->map.max_entries; i++)
        BUG_ON(array->ptrs[i] !=3D NULL);

On arm64 (and any LP64 arch) int is 32-bit signed, while max_entries is
u32. With max_entries having bit 31 set (e.g. 0xFF00000A, observed from a
syzkaller run), the loop runs past i =3D 0x7FFFFFFF: i++ wraps to 0x8000000=
0,
which as a signed int is negative. The address computation for
&array->ptrs[i] sign-extends the 32-bit index (sxtw on arm64) into a
64-bit negative offset:

    array + sxtw(0x80000000) * 8 + offsetof(bpf_array, ptrs)
  =3D array + 0xFFFFFFFC00000000 + 0x108
  -> wraps to an unmapped address, level-1 translation fault, panic

This is reachable today because the existing overflow backstop in
array_map_alloc() lives inside the `if (!bypass_spec_v1)` block. Since
commit 2c78ee898d8f ("bpf: Implement CAP_BPF") renamed the old
`if (unpriv)` guard to `if (!bypass_spec_v1)`, the semantics inverted:
a root caller with CAP_PERFMON (or mitigations=3Doff) takes the bypass
path and skips the -E2BIG check entirely, so the raw attr->max_entries
is stored into map->max_entries unchanged and the ~32 GB vmalloc
(overcommit) region is handed out. The earlier unprivileged-path fix
for max_entries overflow was carried along into the bypass block, so
it does not cover the root path described here.

Reject max_entries > INT_MAX in array_map_alloc_check(), the common entry
point shared by all callers including the bypass path. This mirrors the
existing value_size > INT_MAX guard a few lines above. The cut half of the
u32 range (0x80000000..0xFFFFFFFF) cannot back a usable map today:
  - a prog_array at the lower bound already needs ~16 GB of contiguous
    virtual memory (and ~32 GB for the 0xFF00000A value seen in the field),
    which either fails allocation or drives the system into OOM/softlockup
    long before becoming a working map;
  - legitimate prog_array usage is bounded by MAX_TAIL_CALL_CNT =3D 33 and
    typical array maps are orders of magnitude below INT_MAX.

No valid BPF use case is affected; the change converts a deferred
whole-system BUG_ON panic (or OOM/softlockup) into an accurate -E2BIG at
creation time.

Fixes: 2c78ee898d8f ("bpf: Implement CAP_BPF")
Signed-off-by: meishaoming <meishaoming@xiaomi.com>
---
Changes in v2:
  - Rebase onto the bpf tree (base a13307e97d5c) so Patchwork CI can
    apply it cleanly; no code change.
---
 kernel/bpf/arraymap.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
index 248b4818178c..868bc9f66cdb 100644
--- a/kernel/bpf/arraymap.c
+++ b/kernel/bpf/arraymap.c
@@ -74,6 +74,9 @@ int array_map_alloc_check(union bpf_attr *attr)
        /* avoid overflow on round_up(map->value_size) */
        if (attr->value_size > INT_MAX)
                return -E2BIG;
+       /* avoid signed int iterator overflow in fd_array_map_free() */
+       if (attr->max_entries > INT_MAX)
+               return -E2BIG;
        /* percpu map value size is bound by PCPU_MIN_UNIT_SIZE */
        if (percpu && round_up(attr->value_size, 8) > PCPU_MIN_UNIT_SIZE)
                return -E2BIG;

base-commit: a13307e97d5c54b65720bb71fa379960ded1e51a
--
2.50.1 (Apple Git-155)

#/******=B1=BE=D3=CA=BC=FE=BC=B0=C6=E4=B8=BD=BC=FE=BA=AC=D3=D0=D0=A1=C3=D7=
=B9=AB=CB=BE=B5=C4=B1=A3=C3=DC=D0=C5=CF=A2=A3=AC=BD=F6=CF=DE=D3=DA=B7=A2=CB=
=CD=B8=F8=C9=CF=C3=E6=B5=D8=D6=B7=D6=D0=C1=D0=B3=F6=B5=C4=B8=F6=C8=CB=BB=F2=
=C8=BA=D7=E9=A1=A3=BD=FB=D6=B9=C8=CE=BA=CE=C6=E4=CB=FB=C8=CB=D2=D4=C8=CE=BA=
=CE=D0=CE=CA=BD=CA=B9=D3=C3=A3=A8=B0=FC=C0=A8=B5=AB=B2=BB=CF=DE=D3=DA=C8=AB=
=B2=BF=BB=F2=B2=BF=B7=D6=B5=D8=D0=B9=C2=B6=A1=A2=B8=B4=D6=C6=A1=A2=BB=F2=C9=
=A2=B7=A2=A3=A9=B1=BE=D3=CA=BC=FE=D6=D0=B5=C4=D0=C5=CF=A2=A1=A3=C8=E7=B9=FB=
=C4=FA=B4=ED=CA=D5=C1=CB=B1=BE=D3=CA=BC=FE=A3=AC=C7=EB=C4=FA=C1=A2=BC=B4=B5=
=E7=BB=B0=BB=F2=D3=CA=BC=FE=CD=A8=D6=AA=B7=A2=BC=FE=C8=CB=B2=A2=C9=BE=B3=FD=
=B1=BE=D3=CA=BC=FE=A3=A1 This e-mail and its attachments contain confidenti=
al information from XIAOMI, which is intended only for the person or entity=
 whose address is listed above. Any use of the information contained herein=
 in any way (including, but not limited to, total or partial disclosure, re=
production, or dissemination) by persons other than the intended recipient(=
s) is prohibited. If you receive this e-mail in error, please notify the se=
nder by phone or email immediately and delete it!******/#
