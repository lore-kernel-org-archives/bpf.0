Received: from 66-220-144-178.mail-mxout.facebook.com (66-220-144-178.mail-mxout.facebook.com [66.220.144.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 484BF3644A6
	for <bpf@vger.kernel.org>; Sun, 12 Apr 2026 04:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.144.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775969944; cv=none; b=ttWfvqjTOrUfym35+uuwTk3oCySVapHWzemyc+VOt+cQLMaKDcoKcZo+88OPBbuGb8c16/1pCQULYHFG/37II/9WI/e7s76r0euA211aXqXHncQSnahGBwNJIOVKW2Ih+mzKnlBX79dCNDYx4m0MIvjLwqXsvfzv5CKCAVNp5i8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775969944; c=relaxed/simple;
	bh=kCl3jFiZOLIHDv9lsU5NvoHlVxpv9cpGkj2JMr6vv30=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U304tcS2uJEJ7McRdQRFou5/f9YVsXKCk+tlhpJXIHjLZtnGk3JXHZ2LX2MfQAHCq5SrF4l2/fN9T78i2WpBEfigT5v6csQe0fEzQlaop6MYDhmG3RF+PuCvJxVumqLY3csydgxg+us9/D+Q+rib74lhVYZ+qsiHDcyt67wFPhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.144.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 3EE673B0219E3; Sat, 11 Apr 2026 21:58:52 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"Jose E . Marchesi" <jose.marchesi@oracle.com>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>
Subject: [PATCH bpf-next v4 05/18] bpf: Change some regno type from u32 to int type
Date: Sat, 11 Apr 2026 21:58:52 -0700
Message-ID: <20260412045852.255760-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260412045826.254200-1-yonghong.song@linux.dev>
References: <20260412045826.254200-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

For stack arguments, regno is not really useful for it. Since it
is a stack argument, we can use argument number to indicate it is
a stack argument. We do not want to have two arguments, regno and argno,
in the parameter list. The particular context is for kfunc which
may have more than 5 parameters. bpf-to-bpf call could also have
more than 5 parameters, but stack arguments (beyond 5) are handled
separately so they won't encounter the stack parameter issue.

So for callee's called directly or indirectly by check_kfunc_args(),
some of regno arguments need to be an integer type. The following
is an example:
  check_kfunc_args
    process_dynptr_func
      check_mem_access(..., regno, ...)
         <=3D=3D=3D regno to be negative to represent an argno
  do_check_insn
    check_load_mem
      check_mem_access(..., regno, ...)
         <=3D=3D=3D regno to be non-negative to represent an regno

Next patch will show the formula how to present a regno
for either a regno or argno.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 kernel/bpf/verifier.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index cddd39ebb40b..54296d818d35 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5988,7 +5988,7 @@ static int __check_mem_access(struct bpf_verifier_e=
nv *env, struct bpf_reg_state
 }
=20
 /* check read/write into a memory region with possible variable offset *=
/
-static int check_mem_region_access(struct bpf_verifier_env *env, struct =
bpf_reg_state *reg, u32 regno,
+static int check_mem_region_access(struct bpf_verifier_env *env, struct =
bpf_reg_state *reg, int regno,
 				   int off, int size, u32 mem_size,
 				   bool zero_size_allowed)
 {
@@ -6330,7 +6330,7 @@ static u32 map_mem_size(const struct bpf_map *map)
 }
=20
 /* check read/write into a map element with possible variable offset */
-static int check_map_access(struct bpf_verifier_env *env, struct bpf_reg=
_state *reg, u32 regno,
+static int check_map_access(struct bpf_verifier_env *env, struct bpf_reg=
_state *reg, int regno,
 			    int off, int size, bool zero_size_allowed,
 			    enum bpf_access_src src)
 {
@@ -6437,7 +6437,7 @@ static bool may_access_direct_pkt_data(struct bpf_v=
erifier_env *env,
 	}
 }
=20
-static int check_packet_access(struct bpf_verifier_env *env, struct bpf_=
reg_state *reg, u32 regno, int off,
+static int check_packet_access(struct bpf_verifier_env *env, struct bpf_=
reg_state *reg, int regno, int off,
 			       int size, bool zero_size_allowed)
 {
 	int err;
@@ -6502,7 +6502,7 @@ static int __check_ctx_access(struct bpf_verifier_e=
nv *env, int insn_idx, int of
 	return -EACCES;
 }
=20
-static int check_ctx_access(struct bpf_verifier_env *env, int insn_idx, =
struct bpf_reg_state *reg, u32 regno,
+static int check_ctx_access(struct bpf_verifier_env *env, int insn_idx, =
struct bpf_reg_state *reg, int regno,
 			    int off, int access_size, enum bpf_access_type t,
 			    struct bpf_insn_access_aux *info)
 {
@@ -6541,7 +6541,7 @@ static int check_flow_keys_access(struct bpf_verifi=
er_env *env, int off,
 }
=20
 static int check_sock_access(struct bpf_verifier_env *env, int insn_idx,
-			     struct bpf_reg_state *reg, u32 regno, int off, int size,
+			     struct bpf_reg_state *reg, int regno, int off, int size,
 			     enum bpf_access_type t)
 {
 	struct bpf_insn_access_aux info =3D {};
@@ -7859,7 +7859,7 @@ static void add_scalar_to_reg(struct bpf_reg_state =
*dst_reg, s64 val)
  * if t=3D=3Dwrite && value_regno=3D=3D-1, some unknown value is stored =
into memory
  * if t=3D=3Dread && value_regno=3D=3D-1, don't care what we read from m=
emory
  */
-static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, =
struct bpf_reg_state *reg, u32 regno,
+static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, =
struct bpf_reg_state *reg, int regno,
 			    int off, int bpf_size, enum bpf_access_type t,
 			    int value_regno, bool strict_alignment_once, bool is_ldsx)
 {
@@ -8592,7 +8592,7 @@ static int check_helper_mem_access(struct bpf_verif=
ier_env *env, struct bpf_reg_
  */
 static int check_mem_size_reg(struct bpf_verifier_env *env,
 			      struct bpf_reg_state *mem_reg,
-			      struct bpf_reg_state *size_reg, u32 mem_regno,
+			      struct bpf_reg_state *size_reg, int mem_regno,
 			      enum bpf_access_type access_type,
 			      bool zero_size_allowed,
 			      struct bpf_call_arg_meta *meta)
@@ -8643,7 +8643,7 @@ static int check_mem_size_reg(struct bpf_verifier_e=
nv *env,
 }
=20
 static int check_mem_reg(struct bpf_verifier_env *env, struct bpf_reg_st=
ate *reg,
-			 u32 regno, u32 mem_size)
+			 int regno, u32 mem_size)
 {
 	bool may_be_null =3D type_may_be_null(reg->type);
 	struct bpf_reg_state saved_reg;
@@ -9905,7 +9905,7 @@ static enum bpf_dynptr_type dynptr_get_type(struct =
bpf_verifier_env *env,
 }
=20
 static int check_reg_const_str(struct bpf_verifier_env *env,
-			       struct bpf_reg_state *reg, u32 regno)
+			       struct bpf_reg_state *reg, int regno)
 {
 	struct bpf_map *map =3D reg->map_ptr;
 	int err;
--=20
2.52.0

