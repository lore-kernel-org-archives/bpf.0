Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795160920;
	b=I01dCG9hQuroZMpT1AHQt3qpKl6tq1mxwu3CiZK89jHo3XMWE98hGRy27UT++TKnCDfr
	 V57/tPvtBMjLR53QvdPt14jPZvVMt+iVyM1godJ4VE4sOoM2CuBhdBCQc2/R9nmY/Czn4
	 iR8jUEVemXmh2Hu1Uo7bMjlm1A/Tw8or/Fwua+K6WUtPeGRNhYfQjhSu6qQNDvoNU8rdJ
	 zQT9/4WGmrC/gBeHpaWpJw+qg09PE13qDj5oU+8vb/tSJHlG1zicKNzpxpZ+VD0BV/AoB
	 l0r+xLRKn+42Ce5JKx9VeRblTJtTrdLEWWkfWauVFI9e3P+6fdNdL5MMgY07Tnym/bQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795160920;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=26GfF3noLt+c1GCODiacohGXDUU746k0ilScMlYmAuo=;
	b=1HMT63IdIVRH8vOdJgk0b1l+CsQDH+kx3dpwt988HyDfle1PJyikbBfOa2dP06K/Ew0K
	 +yUp0BeHPd7b0IOTiBdBbyv/bvev7c/ACBvjXzYVdlLRZ5DoE+9q/6RY2QrYrLpZhN9aL
	 ji1Mo9vvg/HcIjRYWr5YBAXrSfqXsaxKyQLsxhzGu74FAJ3/pN65G+cSmT9V1RqKUnd90
	 fKUqKKcut/90iwXs3Drct0XF66iGUR2lziHwNLRGy34sQ6+rudTPI6pqe15B3I30WpdZ2
	 K6onZKDstOB2MYIbxhmigr5S9Ghr9sAsXvmpqRj8lN45GYxJCjsn8wJgs8Ckmf1YW9A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OGQgu5fJ;
	arc=none smtp.remote-ip=209.85.214.180
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CEBD606A336
	for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 07:48:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2CEBD606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OGQgu5fJ
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2f0458cc9easo2802615ad.3
        for <bpf@vger.kernel.org>; Thu, 19 Nov 2026 23:48:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795160919; x=1795765719; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=26GfF3noLt+c1GCODiacohGXDUU746k0ilScMlYmAuo=;
        b=OGQgu5fJat6WuvhHsh3jrXQ2xuMSuCSdBOlOItpSLCC7fP9/zCed8Kp3iGFpIbyn2G
         A9Cbkgk+tJOneDi/45ImmiJFKjAlOp7ZeQmt2V1w9s6u6ec4Z7hvDVlfCJ9MA4Bxkdt3
         kdknxRtGtMa/ck4JXrQMKPHTRgXC0IOI4M0mopX7ASnwdBCFPD0sjp1NjsV/Kf9WHZzx
         tD744fegoOrvFtS3y1udWmUOtcCQmE7+iUx/VDrWpmn2qvGRwFJ8kFYDZ6RsXZxJMlRB
         XxGiXkTSOSoEJXN120VxH7p1kNoHfzkTAcu8BqMOPxOf22zMAMUg+PLE3HDuKqpwX5sT
         M5/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795160919; x=1795765719;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=26GfF3noLt+c1GCODiacohGXDUU746k0ilScMlYmAuo=;
        b=Ky/1fUX3wSYjn7w3+oC1Rur8rFD81L97p1SuAsk9ffAIpznXKVWr/lkZMhKqP6iQMO
         wv8/3lCA9GniCb4gIxcS27zpCELoBqM3S/V6NA6zUyj01BEdCLdmt3aOBwK/HphRZml3
         YrjDg3mOaLw4NKzi55A9J63vz6qVmr7KudBve9HRojp9JLNs4Je+cgIM+cLow74x4qko
         JqQPx51IIMUUiRHTLH/caFKMol/CyyCo7N4BWW5QmIBlgXUPsq5vEaWnguR2eqRMGK6g
         qGqnWu0y2JLJ9d6ec/W1cn4JIDFQdhT2Vrbs605G9yaAQ2CMyZWtODMu6+JQFGzIIBrY
         rlUA==
X-Gm-Message-State: APuU4Z+9XPwacIXQOCUEXqpxHBKWn7y2+Xu0BWuH86+8nvUBIqIrCvIR
	uawPEuURvcxF4epppmF39ip6dr4rHbJZ5aN1IIeyOOG+KzsGspz+POFbq6Mikg==
X-Gm-Gg: AZFdTZeb4EFKp+RwOyeoXPHxSfFRM01ThlvQCFa7BbCFsHWfdKrU3+vJSvXjUGCYwJE
	T2DOluH9Dyxzo5otPB72i6cOJaIZCE1LVxv4B2y44PmG9FP8m5S0tZzf0UQ29GFU2DfkLzOs32e
	kqQX+6mF3iFkgIFVMRLnPKvTxEWLjUAfiWkq+R5wDNdGGDFDFrlUDqX0uNK5sdMoyZZiLg+yVKZ
	S0cLrKZ6/xbYLxV1uy4+H7J6VTIuDX2Uw8caapqO8WiTmw0j/hs7OirkiMwX2yy61VTKBMmag4h
	Yq9X1sGn2RoQFTzjrjfjr/A8BPZQ1mLLWOo2zdN/wjNGYUN34/b1vPxd1R5MHNBuHYOkyVvbmEj
	nKCM1htHDdNwZhQ6wzai845agODeNDp5+Z7/4ounKfa+TUv0Bo5CqwQwJxB4NTBpnDkikCC2jEq
	TiWWr4Rn3agzyL4JH8E/EQUSiBaNluhx0nxDXnkbXlMRgRmeO2va3d7kYdEdtSl2On7XQJ87Rsh
	Bg2/yRwyFa22PLgba4sTTIfB2DVexNH1wMIZcgvFsBiblknCfIJ+bUfcQsxQoR9Tp1GdNfc0Dmx
	MS1JXMHcm5aQz6JcS+xG5bFQp58eQ/wOx8otkd6PP0il7zf3mvNvQNLsd6oGKXx3mnBdYk6RJKr
	RxR5HZU0D2Zk9B01ZMTBezkK+rZ0PWqt9JxS3HWhjRWuwyCwI1ZlnVT/PlK9hgmN/YKHNJHpTtQ
	==
X-Received: by 2002:a17:903:19cb:b0:2ed:2c40:6273 with SMTP id d9443c01a7336-2f03f1c08c5mr25024715ad.40.1795160919389;
        Thu, 19 Nov 2026 23:48:39 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.246])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f03f0c2ad2sm10524225ad.16.2026.11.19.23.48.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 23:48:39 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 42/49] bpf: Allow a range of offsets for a constant string
Date: Fri, 20 Nov 2026 07:42:14 +0000
Message-ID: <20261120074430.2704488-43-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261120074430.2704488-1-alexei.starovoitov@gmail.com>
References: <20261120074430.2704488-1-alexei.starovoitov@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

clang merges two calls that differ only in a string. The join of the
two pointers has a range. "is not a constant address" costs one more
pass.

The map is read-only. If a zero is at the largest offset or after it,
it ends all strings that start before it:

  .rodata   a % d 0 b c d 0
            ^       ^     ^
            umin    umax  ends both

Allow the range. There are two exceptions:
- bpf_snprintf(): the verifier checks the format,
- no bypass_spec_v1: the cpu can speculate past the test of the offset.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/verifier.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 9aa6b331768..c19eed8a6e0 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -9573,7 +9573,8 @@ static int check_arg_const_str(struct bpf_verifier_env *env,
 		return -EACCES;
 	}
 
-	if (!tnum_is_const(reg->var_off)) {
+	/* the cpu can speculate past the test of a variable offset */
+	if (!tnum_is_const(reg->var_off) && !env->bypass_spec_v1) {
 		verbose(env, "%s is not a constant address'\n", reg_arg_name(env, argno));
 		return -EACCES;
 	}
@@ -9583,13 +9584,12 @@ static int check_arg_const_str(struct bpf_verifier_env *env,
 		return -EACCES;
 	}
 
-	err = check_map_access(env, reg, argno, 0,
-			       map->value_size - reg->var_off.value, false,
-			       ACCESS_HELPER);
+	err = check_map_access(env, reg, argno, 0, 1, false, ACCESS_HELPER);
 	if (err)
 		return err;
 
-	map_off = reg->var_off.value;
+	/* the zero of the last string ends all strings that start before it */
+	map_off = reg_umax(reg);
 	err = map->ops->map_direct_value_addr(map, &map_addr, map_off);
 	if (err) {
 		verbose(env, "direct value access on string failed\n");
@@ -9602,7 +9602,8 @@ static int check_arg_const_str(struct bpf_verifier_env *env,
 		return -EINVAL;
 	}
 	/* the bytes of a pointer to a function are not known until the program is jitted */
-	if (bpf_map_range_func_ptrs(env, map, map_off, strlen(str_ptr + map_off) + 1, &cnt)) {
+	map_off += strlen(str_ptr + map_off) + 1;
+	if (bpf_map_range_func_ptrs(env, map, reg_umin(reg), map_off - reg_umin(reg), &cnt)) {
 		verbose(env, "string overlaps with a pointer to a function\n");
 		return -EACCES;
 	}
@@ -12761,9 +12762,12 @@ static int check_bpf_snprintf_call(struct bpf_verifier_env *env,
 		return -EINVAL;
 	num_args = data_len_reg->var_off.value / 8;
 
-	/* fmt being ARG_PTR_TO_CONST_STR guarantees that var_off is const
-	 * and map_direct_value_addr is set.
-	 */
+	if (!tnum_is_const(fmt_reg->var_off)) {
+		verbose(env, "R3 is not a constant address\n");
+		return -EACCES;
+	}
+
+	/* fmt being ARG_PTR_TO_CONST_STR guarantees that map_direct_value_addr is set */
 	fmt_map_off = fmt_reg->var_off.value;
 	err = fmt_map->ops->map_direct_value_addr(fmt_map, &fmt_addr,
 						  fmt_map_off);
-- 
2.55.0

