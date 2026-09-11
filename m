Received: from 69-171-232-181.mail-mxout.facebook.com (69-171-232-181.mail-mxout.facebook.com [69.171.232.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C1FB49B5A3
	for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 15:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=69.171.232.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789141839; cv=none; b=UIoaCmxSStQKAbAKQAEuZyuR8/RK/CZDhdsCMyWHDF91VD2RCey0khWamPZNts6IAC0gVHu3Tx74o64/B3rVMDrRx5IMjC9r8oj5XXQN17mN4euvzRD0XKmAmz5NthiZliFTd5NOMfM/T+dGBnTyIK4EBWgqqopxUBfF2/yQlHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789141839; c=relaxed/simple;
	bh=WlPmkMdBFTO6cgqG+6WgEtCS1neof9O2D9Ylmgb6HQ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UNcu64dGLCxt4pZnalb+6HeX4wbUeB9n3VONPSRHe7kd03JDQH7qU4uyTdTpyyiTDEQcNwg4CDsdWEOXx1jhgOMHUneyg1xh+qIC+uNaJWnBFVzWoeJeCWOIUG/PWDsWJk7OOHwRUadXtniP12Bf4+bSgsUM6dMopRE9ouHXCCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=69.171.232.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devvm16039.vll0.facebook.com (Postfix, from userid 128203)
	id 9A9EE2A18431CD; Fri, 11 Sep 2026 08:50:30 -0700 (PDT)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v3 15/15] selftests/bpf: Temporary hack to disable register mismatch in arm64
Date: Fri, 11 Sep 2026 08:50:30 -0700
Message-ID: <20260911155030.2012652-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260911154914.2004336-1-yonghong.song@linux.dev>
References: <20260911154914.2004336-1-yonghong.song@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

There are 3 kfuncs like below:
   __u64 bpf_kfunc_call_test_i128_arg_odd(__u64 a, __int128 v, __u64 b) _=
_ksym;
   __u64 bpf_kfunc_call_test_i128_arg_shift(__u64 a, __int128 v, __u64 b,=
 __u64 c,
                                            __u64 d) __ksym;
   __u64 bpf_kfunc_call_test_i128_arg_ovf(__u64 a, __int128 v, __u64 b, _=
_u64 c,
                                          __u64 d, __u64 e, __u64 f) __ks=
ym;
which requires that '__int128 v' must be 16-byte align on arm64.

Current pahole will reject BTF generation since pahole expects
'__int128 v' has start register 'x1' while arm64 abi requires 'x2'.
Hence, btf generation will fail.

This patch is a hack to disable a few related tests to satisfy CI.
The following is the fix in pahole:
  https://lore.kernel.org/bpf/20260911040955.339939-1-yonghong.song@linux=
.dev/
Once pahole patch is merged, this patch can be discarded.

Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 tools/testing/selftests/bpf/progs/aggregate_arg_kfunc.c    | 4 ++++
 tools/testing/selftests/bpf/test_kmods/bpf_testmod.c       | 4 ++++
 tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h | 2 ++
 3 files changed, 10 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/aggregate_arg_kfunc.c b/to=
ols/testing/selftests/bpf/progs/aggregate_arg_kfunc.c
index 2100f0ab1abe..59f56ab39413 100644
--- a/tools/testing/selftests/bpf/progs/aggregate_arg_kfunc.c
+++ b/tools/testing/selftests/bpf/progs/aggregate_arg_kfunc.c
@@ -50,6 +50,7 @@ int aggregate_arg_kfunc_int128(struct __sk_buff *skb)
 	return 0;
 }
=20
+#if 0
 /*
  * arm64 rounds the register number up to an even one for an argument
  * aligned to 16 bytes, so it wants this __int128 in x2 and x3.
@@ -70,6 +71,7 @@ int aggregate_arg_kfunc_int128_odd(struct __sk_buff *sk=
b)
=20
 	return 0;
 }
+#endif
=20
 #endif /* __SIZEOF_INT128__ */
=20
@@ -152,6 +154,7 @@ int aggregate_arg_kfunc_split8(struct __sk_buff *skb)
=20
 #ifdef __SIZEOF_INT128__
=20
+#if 0
 /*
  * The same hole, with enough arguments after the __int128 that the shif=
t
  * reaches the registers the BPF convention counts as stack slots: arm64
@@ -193,6 +196,7 @@ int aggregate_arg_kfunc_int128_ovf(struct __sk_buff *=
skb)
=20
 	return 0;
 }
+#endif
=20
 /*
  * Both conventions pad the stack to align this __int128, and the BPF
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c b/tools=
/testing/selftests/bpf/test_kmods/bpf_testmod.c
index baccee6fdad4..c367442ce086 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod.c
@@ -1039,6 +1039,7 @@ __bpf_kfunc u64 bpf_kfunc_call_test_i128_arg(u64 a,=
 u64 b, __int128 v)
 	return a + b + (u64)((unsigned __int128)v >> 64) + (u64)v;
 }
=20
+#if 0
 __bpf_kfunc u64 bpf_kfunc_call_test_i128_arg_odd(u64 a, __int128 v, u64 =
b)
 {
 	return a + b + (u64)((unsigned __int128)v >> 64) + (u64)v;
@@ -1056,6 +1057,7 @@ __bpf_kfunc u64 bpf_kfunc_call_test_i128_arg_ovf(u6=
4 a, __int128 v, u64 b, u64 c
 	return a + b + c + d + e + f +
 	       (u64)((unsigned __int128)v >> 64) + (u64)v;
 }
+#endif
=20
 __bpf_kfunc u64 bpf_kfunc_call_test_i128_arg_pad(u64 a, u64 b, u64 c, u6=
4 d, u64 e,
 						 u64 f, u64 g, __int128 v)
@@ -1735,9 +1737,11 @@ BTF_ID_FLAGS(func, bpf_kfunc_call_test_ret_deep)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test_ret_ii)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test_pair_arg)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test_i128_arg)
+#if 0
 BTF_ID_FLAGS(func, bpf_kfunc_call_test_i128_arg_odd)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test_i128_arg_shift)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test_i128_arg_ovf)
+#endif
 BTF_ID_FLAGS(func, bpf_kfunc_call_test_i128_arg_pad)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test_pair_arg_nofit)
 BTF_ID_FLAGS(func, bpf_kfunc_call_test_pair_arg_tail)
diff --git a/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h b=
/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
index 195ec37d5bbc..0f098045856e 100644
--- a/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
+++ b/tools/testing/selftests/bpf/test_kmods/bpf_testmod_kfunc.h
@@ -234,11 +234,13 @@ struct prog_test_ret_ii bpf_kfunc_call_test_ret_ii(=
int a, int b) __ksym;
 __u64 bpf_kfunc_call_test_pair_arg(__u64 a, struct prog_test_pair_arg s,=
 __u64 b) __ksym;
 #ifdef __SIZEOF_INT128__
 __u64 bpf_kfunc_call_test_i128_arg(__u64 a, __u64 b, __int128 v) __ksym;
+#if 0
 __u64 bpf_kfunc_call_test_i128_arg_odd(__u64 a, __int128 v, __u64 b) __k=
sym;
 __u64 bpf_kfunc_call_test_i128_arg_shift(__u64 a, __int128 v, __u64 b, _=
_u64 c,
 					 __u64 d) __ksym;
 __u64 bpf_kfunc_call_test_i128_arg_ovf(__u64 a, __int128 v, __u64 b, __u=
64 c,
 				       __u64 d, __u64 e, __u64 f) __ksym;
+#endif
 __u64 bpf_kfunc_call_test_i128_arg_pad(__u64 a, __u64 b, __u64 c, __u64 =
d, __u64 e,
 				       __u64 f, __u64 g, __int128 v) __ksym;
 #endif
--=20
2.52.0

