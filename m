Received: from 69-171-232-181.mail-mxout.facebook.com (69-171-232-181.mail-mxout.facebook.com [69.171.232.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB3135C190
	for <bpf@vger.kernel.org>; Fri, 28 Aug 2026 17:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787936749; cv=none; b=RuM7uqR9cWUpseMhFf6T/NeJMOoTWeYnSQs5o6ygleySPoWZBntMQ13oSnVIVUgJjzjHrHmeK9/V9jsTaxWleWirivBwosytpOKYJCVNy/b6B1OHTExE6lhLYzwTxph8Q5iHek9Nc/XpHSyX/UlsqYhQCJ8/+/3lH8Q5G+oVsvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787936749; c=relaxed/simple;
	bh=z3+S8AHTHvafiJCNyUTT6RSyhRdT4fC3GhyC1nr2N8A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l+6urZHLJYQbUfvYWSM82ZAqlLXHolnAH3v4Yni0eeCvPD44aZOGIlJpCST3CAFqCR2ZINo2kJQZBjQXK3JB3505JHxOXezhBD9YQ5aUcyzBA26QPAHKJRxQ/9ytnKuSFHVDnrF204MPUupoISI44l2STc+NhAskSrfHeaHYXtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id E2AA0271D5A548; Fri, 28 Aug 2026 10:05:34 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH] selftests/bpf: Bound the offset accumulator in __tld_fetch_key()
Date: Fri, 28 Aug 2026 10:05:34 -0700
Message-ID: <20260828170534.1011183-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The LLVM commit c7f4a76da024 [1]
  "[InstCombine] fold ((x - 1) | (2^k - 1)) + 1 to (x + (2^k - 1)) & -(2^=
k)"
caused test_task_local_data.bpf.o to fail verification:

  The sequence of 8193 jumps is too complex.
  processed 188770 insns (limit 1000000) max_states_per_insn 34
  total_states 8238 peak_states 12330 mark_read 0

TLD_ROUND_UP(x, 8) expands to ((((x) - 1) | 7) + 1), exactly the pattern
that [1] rewrites, so the accumulation in __tld_fetch_key()

	off +=3D TLD_ROUND_UP(metadata[i].size, 8);

is now compiled as (x + 7) & -8 instead of ((x - 1) | 7) + 1. Both are
correct, but they leave the verifier in very different states. Note that
'off' is marked as precise.

Without [1], "size - 1" wraps at zero (size is a __u16), so
the verifier loses all bounds on the increment:

  211: (69) r1 =3D *(u16 *)(r1 +62)  ; R1=3Dscalar(...,umax32=3D0xffff,va=
r_off=3D(0x0; 0xffff))
  212: (04) w1 +=3D -1               ; R1=3Dscalar(smin=3D0,smax=3Dumax=3D=
0xffffffff,smin32=3D-1,smax32=3D0xfffe,var_off=3D(0x0; 0xffffffff))
  213: (44) w1 |=3D 7                ; R1=3Dscalar(smin=3Dumin=3Dumin32=3D=
7,smax=3Dumax=3D0xffffffff,var_off=3D(0x7; 0xfffffff8))
  214: (0c) w6 +=3D w1               ; R6=3Dscalar(smin=3Dumin=3Dumin32=3D=
7,smax=3Dumax=3D0xffffffff,var_off=3D(0x7; 0xfffffff8))
  215: (04) w6 +=3D 1                ; R6=3Dscalar(smin=3D0,smax=3Dumax=3D=
umax32=3D0xfffffff8,var_off=3D(0x0; 0xfffffff8))

Note that 'w6' will be used in the next iteration. In the next iteration
after insn 215, the R6 range will be the same as previous iteration.
The iterator loop converges at depth 2.

With [1] the increment stays precisely bounded at [0, 0x10006]:

  211: (69) r9 =3D *(u16 *)(r1 +62)  ; R9=3Dscalar(...,umax32=3D0xffff,va=
r_off=3D(0x0; 0xffff))
  212: (04) w9 +=3D 7                ; R9=3Dscalar(...,umax32=3D0x10006,v=
ar_off=3D(0x0; 0x1ffff))
  213: (54) w9 &=3D 131064           ; R9=3Dscalar(...,umax32=3D0x10006,v=
ar_off=3D(0x0; 0x1fff8))
  214: (0c) w9 +=3D w6               ; R9=3Dscalar(...,umax32=3D0x10006,v=
ar_off=3D(0x0; 0x1fff8))
  215: (bf) r1 =3D r10
  216: (07) r1 +=3D -8
  217: (85) call bpf_iter_num_next
  218: (bc) w6 =3D w9

In the next iteration, we will have
  211: (69) r9 =3D *(u16 *)(r1 +62)       ; R9=3Dscalar(...,umax32=3D0xff=
ff,var_off=3D(0x0; 0xffff))
  212: (04) w9 +=3D 7                     ; R9=3Dscalar(...,umax32=3D0x10=
006,var_off=3D(0x0; 0x1ffff))
  213: (54) w9 &=3D 131064                ; R9=3Dscalar(...,umax32=3D0x10=
006,var_off=3D(0x0; 0x1fff8))
  214: (0c) w9 +=3D w6                    ; R9=3Dscalar(...,umax32=3D0x20=
00c,var_off=3D(0x0; 0x3fff8))
  ...

so 'off' umax grows by 0x10006 on every iteration and the loop-head
state never repeats:

  218: (bc) w6 =3D w9  ; R6=3Dscalar(...,umax32=3D0x10006,var_off=3D(0x0;=
 0x1fff8))
  218: (bc) w6 =3D w9  ; R6=3Dscalar(...,umax32=3D0x2000c,var_off=3D(0x0;=
 0x3fff8))
  218: (bc) w6 =3D w9  ; R6=3Dscalar(...,umax32=3D0x30012,var_off=3D(0x0;=
 0x3fff8))
  ...
  218: (bc) w6 =3D w9  ; R6=3Dscalar(...,umax32=3D0xff95fd6,var_off=3D(0x=
0; 0xffffff8))

That last one is iterator depth 4090. Saturating umax would take ~65531
iterations; the verifier gives up long before that.

Note the loop does not diverge from the start. widen_imprecise_scalars()
blows 'off' up to an unbounded scalar while it is still imprecise, and th=
at
alone converges the first three passes through the loop at depth 4.
Once mark_chain_precision() reaches the loop body, maybe_widen_reg() star=
ts
skipping the register, and no widening ever happens again. In the failing
log widening fires exactly 6 times out of 4098 arrivals at the iter_next(=
)
checkpoint, all of them before the umax starts accumulating.

With [1] and this fix, here is one full trip through the loop body,
entered with 'off' (R6) already clamped by the previous iteration:

  208: frame1: R6=3Dscalar(...,umax32=3D4088,var_off=3D(0x0; 0xff8))
  208: (67) r7 <<=3D 6                ; R7=3Dscalar(...,umax32=3D3968,var=
_off=3D(0x0; 0xfc0))
  209: (bf) r1 =3D r9                 ; R1=3Dmem(id=3D54,sz=3D4036,imm=3D=
4)
  210: (0f) r1 +=3D r7
  211: (69) r1 =3D *(u16 *)(r1 +62)   ; R1=3Dscalar(...,umax32=3D0xffff,v=
ar_off=3D(0x0; 0xffff))
  212: (04) w1 +=3D 7                 ; R1=3Dscalar(...,umax32=3D0x10006,=
var_off=3D(0x0; 0x1ffff))
  213: (54) w1 &=3D 131064            ; R1=3Dscalar(...,umax32=3D0x10006,=
var_off=3D(0x0; 0x1fff8))
  214: (0c) w1 +=3D w6                ; R1=3Dscalar(...,umax32=3D0x10ffe,=
var_off=3D(0x0; 0x1fff8))
                                      R6=3Dscalar(...,umax32=3D4088,var_o=
ff=3D(0x0; 0xff8))
  215: (bc) w6 =3D w1                 ; R6=3Dscalar(...,umax32=3D0x10ffe,=
var_off=3D(0x0; 0x1fff8))
  216: (26) if w1 > 0xff8 goto pc+1 ; R6=3Dscalar(...,umax32=3D4088,var_o=
ff=3D(0x0; 0xff8))
  217: (05) goto pc-27

This makes the loop body a fixpoint. 'off' (w6) enters at 208 as [0, 4088=
] with
var_off=3D(0x0; 0xff8); the increment computed at 212/213 is [0, 0x10006]=
, so
214/215 leave it at [0, 0x10ffe]; then 216 truncates it straight back to
[0, 4088]/(0x0; 0xff8), and only then is the back edge at 217 taken.
Convergence no longer depends on the widening window above. Verification =
converges
at iterator depth 3.

  [1] https://github.com/llvm/llvm-project/pull/216436

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 tools/testing/selftests/bpf/progs/task_local_data.bpf.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/task_local_data.bpf.h b/to=
ols/testing/selftests/bpf/progs/task_local_data.bpf.h
index 0df8a12fd61e..a31a399870be 100644
--- a/tools/testing/selftests/bpf/progs/task_local_data.bpf.h
+++ b/tools/testing/selftests/bpf/progs/task_local_data.bpf.h
@@ -61,6 +61,7 @@
 #define TLD_ROUND_UP(x, y) ((((x) - 1) | TLD_ROUND_MASK(x, y)) + 1)
=20
 #define TLD_MAX_DATA_CNT (__PAGE_SIZE / sizeof(struct tld_metadata) - 1)
+#define TLD_DATA_SIZE (__PAGE_SIZE - sizeof(__u64))
=20
 #ifndef TLD_NAME_LEN
 #define TLD_NAME_LEN 62
@@ -189,6 +190,8 @@ static int __tld_fetch_key(struct tld_object *tld_obj=
, const char *name, int i_s
 			return start + off;
=20
 		off +=3D TLD_ROUND_UP(metadata[i].size, 8);
+		if (off > TLD_DATA_SIZE)
+			break;
 	}
=20
 	return -cnt;
--=20
2.53.0-Meta

