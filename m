Received: from mail-pz2-f41.google.com (mail-pz2-f41.google.com [74.125.228.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E863D4756CC
	for <bpf@vger.kernel.org>; Fri,  2 Oct 2026 12:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790945259; cv=none; b=MtT/ogqsGY0zB2iy94+9SwKWidybj0prCtXE7HuT74i+UlG1LGDgTxYKMfihFzwEuGdB5K31nvxqE00MvB1rh+XIW6LmcmWHwl/ViBiyXCGHLgTYxYm5PeM8jkMdTGmER09skUrtj0RUzw5ty74ujYS4BBBqvm2VqmWu1dFpaN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790945259; c=relaxed/simple;
	bh=Gf7/2vaZ7gy3gqlNRf5Gm75h3S4Mx5SN9qwwTHA7LbU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i2kd2zmnAQV6wqA7pufdmC2dYW9/4u8PzT57kaEtgdTGAQo7tll0TuEVah334jCgcH3/o5RtkJausUSv10T3aYVZzbwp10UiLkRlJJn7DZRWmeIbEpAt04St0OeB9BvqBCyKLMtxyh40YYIIxEBrKdDPkBLy9P5ZMmSYFrbN3ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DY8DOqJh; arc=none smtp.client-ip=74.125.228.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DY8DOqJh"
Received: by mail-pz2-f41.google.com with SMTP id d2e1a72fcca58-86e6d007703so3745645b3a.0
        for <bpf@vger.kernel.org>; Fri, 02 Oct 2026 05:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790945257; x=1791550057; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oFYRSHPFIZkdBgfdVSy0bxvw78+dpstxclUnNlFYclg=;
        b=DY8DOqJhCjo9wHVXdSqGGwfRDo/yBtvxp8BhX8u43gvCj1Mo6EZ1HTGMQbwWLx8vjm
         x3TdpZy1spwQHbv8rq06muUb11UTfJVikn0mvx2RmqAzKlnsAIXxBjyyZp1oCVpkR+pN
         W1d99LJcvs6CA2k+uBYJKs32r0WwpMISLUppjMdSHYbVWyd12FcPBnSblETdzRdmbkvY
         CpRy1FbdT7K8iK44D7MK+JUdp5q2QRaIzPgF3+lLvoy/gFXe2OkKlxaLBBEa65ReXNAd
         U9jwClyw++enYc7QIfXgrUTa+Ei6yrwqhovT3/9b4g0u2Av6NBWzsegivCjIjQRbkQES
         cjBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790945257; x=1791550057;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=oFYRSHPFIZkdBgfdVSy0bxvw78+dpstxclUnNlFYclg=;
        b=ajOE6E78qKLTG6lT760jzI8Qe2HoxsJFu85w0vZMNoKnpXHxQ3hWckuRQl/VrapEZn
         ar3VLSybGGJDfxINfljd9WcJEuInlLm7182at6R0UzrOpyHYqXBomoYZtpwit03z3iIt
         9LgUvpoBQ8POh4ZtiMkd9vw19vT1GVOQ82UJYHX6SAOQye56gmKBJRcJ+/ekM2cvFEUK
         Hl4omtsSoWntaUxJhVP7iKMTFKkaQUy3d0PGCWzm90apiiI9RmD3nHz4b/k0LToyqdz2
         HkloJIuC30RFIBXCvsurvhsLsxI6Nd0TJfwwNzyX23wjGeK0sB7zlhP8xgYG4UYa+9am
         BlCg==
X-Gm-Message-State: AFuF++ll8CSKY9PcrYp3ARX49aLW0ufzsqV4mv7/XkcrwwnRHUPQlnHm
	9jnyN4HK3InzvsdeQvpcZFdm3Mc8HYY9b2TsBFDVqdwK/aGTvXnClapGK2NNg5s323s=
X-Gm-Gg: AYBFou2YsA3sm8qTvtiB5q1BYr6q+l7ypGUqr+yl4vqcNusP8F36d6dP+CUQFbGtb8n
	82cMGTSTOASWbZLy8UNGDPDYeNIqXOGM93gqI09nwAHvtBC2GvF4wZJfEW3sEbF5BTiFlgrX5ID
	jIne+GrixDIltkJq3mrrA8qLXW5pXD1hW/V2lhWxbPl4N4emAwLzStSV3wFBqKTIJbQFKkY6N3T
	TPro7vb4lcjgP/+5VQUK0Y/2gNGlJAlJ+Yu8WT2YWfQLxHThwA+sL7veLV5aIZ/snA6/FWdQLpi
	QLt8UgVj1S/WifsUridAGxo0pOOr3DtrxIkWS4XZo6Al+QdAtwuZfw7hXQ7UAmmoX4yGxblp4es
	G523SrYG68dddUbauMG+9Yp1ZTp+U8AWwmDnm8wnurLJSGDcwf5jB3j17p5yqJyTeDK3nvXEpgG
	Zjkv65GD5BS2VeN3q3/GtHzliTxcy5C52eb6kD4zGranJjSVMZ7yXGFC5pqrjhtdKuGmCeUwHoV
	+gmJ1z5n+sK/kvx6iXNT31uc3vIpiAme9FPBZ0yww/FFgASCM82HkTXOmzUDESdCXaNKWHgQy2z
	43ZbMSu87asnWW1TNa2AQVq5M3Pf2iLYmvRcv6uiLF0=
X-Received: by 2002:a05:6a00:3cca:b0:886:4ca4:a3e7 with SMTP id d2e1a72fcca58-88af268903emr2331452b3a.6.1790945257135;
        Fri, 02 Oct 2026 05:47:37 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.252])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-88b0cb77df7sm828302b3a.47.2026.10.02.05.47.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 05:47:36 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v2 07/15] bpf: Allow arguments without names in static functions in BTF
Date: Fri,  2 Oct 2026 12:47:06 +0000
Message-ID: <20261002124714.180012-8-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261002124714.180012-1-alexei.starovoitov@gmail.com>
References: <20261002124714.180012-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

Some static functions in BTF of a Rust program have arguments without
names:

  [71] FUNC_PROTO '(anon)' ret_type_id=0 vlen=1
          '(anon)' type_id=72
  [81] FUNC 'unwrap_failed' type_id=71 linkage=static

and the kernel rejects such BTF with "Invalid arg#1". It's 5 of 25
static functions in scx_cosmos and 6 of 24 in scx_simple.

The verifier looks at types of the arguments. The names are printed only,
as "(anon)" when there is none. Allow such static FUNC. Global functions
are checked as before.

The test "func (Some arg has no name)" in prog_tests/btf.c has a static
function. Make it global to keep the check.

Acked-by: Alan Maguire <alan.maguire@oracle.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/btf.c                             | 4 ++++
 tools/testing/selftests/bpf/prog_tests/btf.c | 5 +++--
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index d27af5d8e495..c9d4b709380c 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -5752,6 +5752,10 @@ static int btf_func_check(struct btf_verifier_env *env,
 		return -EINVAL;
 	}
 
+	/* Rust leaves out names of some arguments of static functions */
+	if (btf_func_linkage(t) == BTF_FUNC_STATIC)
+		return 0;
+
 	args = (const struct btf_param *)(proto_type + 1);
 	nr_args = btf_type_vlen(proto_type);
 	for (i = 0; i < nr_args; i++) {
diff --git a/tools/testing/selftests/bpf/prog_tests/btf.c b/tools/testing/selftests/bpf/prog_tests/btf.c
index 207341f4bd99..21fdeeb23405 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf.c
@@ -2793,7 +2793,7 @@ static struct btf_raw_test raw_tests[] = {
 },
 
 {
-	.descr = "func (Some arg has no name)",
+	.descr = "func (Some arg of global func has no name)",
 	.raw_types = {
 		BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),	/* [1] */
 		BTF_TYPE_INT_ENC(0, 0, 0, 32, 4),		/* [2] */
@@ -2802,7 +2802,8 @@ static struct btf_raw_test raw_tests[] = {
 			BTF_FUNC_PROTO_ARG_ENC(NAME_TBD, 1),
 			BTF_FUNC_PROTO_ARG_ENC(0, 2),
 		/* void func(int a, unsigned int) */
-		BTF_FUNC_ENC(NAME_TBD, 3),			/* [4] */
+		BTF_TYPE_ENC(NAME_TBD,				/* [4] */
+			     BTF_INFO_ENC(BTF_KIND_FUNC, 0, BTF_FUNC_GLOBAL), 3),
 		BTF_END_RAW,
 	},
 	.str_sec = "\0a\0func",
-- 
2.55.0

