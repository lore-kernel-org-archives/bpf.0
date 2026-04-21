Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D3E43A6F15
	for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 22:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776809430; cv=none; b=cXw2Ur04x5RQuPyWPVpxAC+oJd5LWAffKbZxrGpZc2mj/eJlxTe5Sn3twUtt3w59/pTUulOInue5OxQX+N57H8QlSJpRU3k+Woyx5XEVEGqjRzP9WAJ179793jpW7FoWWJmrYU6Aiy5t8Q5OeDPV2isDZbtlOtt6MdrzUt3kMo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776809430; c=relaxed/simple;
	bh=qgyW8WY0XnATsZRNwyTPQb4+G+CpRs5HnNycoGTypIU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G10uVG/rjipD9D6eJU63iHJCX6fFA11VpyBtiQaKCZHsPAWYUmrR5a/AvzbJWK9bXnGy4WqgXVyto2D5Wh4ebSDdDxEV3S8lUZF2bysMToyZti2nOC0YEW99Pxs4nVLa5R+gC5tWN8Te3zLrOtBG+4lTwfQWi5erW2NUqPl9dws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jLZ2B8CO; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jLZ2B8CO"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-35d94f4ee36so2879742a91.3
        for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 15:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776809428; x=1777414228; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jLYhdfRJ97sDAX8UXbcRXQEaC5RqfPxWPylGwBsbNL4=;
        b=jLZ2B8COMLlEIzPQ6C7nLJGbaj4CUgF/GoO8A+dDx2FVNz2txo/2HVMMfFBFP3diJb
         ++tcDStgUKIjj4kCoMMD/JaIjao6f6ESyeHabpz/vCrRdpzOy1jfy4nFcrpTBz/dVqo2
         nu/LDvvKxoJK6PXyr1fVvPVTkeOJcEdUT6I6Sgou/cSOjmiHNtSxXlmGTjBexBuwisMT
         fIr0BeE22ygz/3OTK1zwumKNaoKM6OLXNb6KqhBU2q1l+PwfA4yM1o3KtYqhy4rMkGff
         08emXkvE82tTQhC6MX4MBKCsKz57mltGl4dDPMyOxsYSV7Qw3mC+yS4/JNb814UDHIam
         wsYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776809428; x=1777414228;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jLYhdfRJ97sDAX8UXbcRXQEaC5RqfPxWPylGwBsbNL4=;
        b=p8TiUKi+IcPLLU+MOXPLtWXRPnVwFaKRAyCArQRlc+oIZM49DO2LZhNUglVDtgxOLy
         G5oDYgOvFbjfk2rQJHaOZ4MLMErz+9EU+YrzwVQtBnN9D1LCLbAom7M1LbdoGxnIXSBJ
         o5hofG1O6R/3X/PCgD9ErgMamTVSuq/wLeT+Ckzx8BIoVp7kLdZmbcErd7brluqHsmE5
         kj4YJtQOEElD6QNm8z4s/myjUnOKSNhEAiulaIm34nyDl7Me56L/JWynr+rZvfcoF5+C
         Az7aPvmu1SF/G3GJ/FkedY1sD01hxCTYPwp2nztem7H3Wd3YGIKa9VCwqo+A1RFxOlc4
         1PyQ==
X-Gm-Message-State: AOJu0YzEJAr0XP4XmrPYE5CehVAAHiVPIkYRU46vSIv8rpKDZBI1WBFY
	VA/F8ktsqqRzFB7C/G4bmCtRdD2IGTjy9Daen73C0Sdgqeo8NAk+vZRBFgZAOg==
X-Gm-Gg: AeBDiesV7iea57n8MxLe7CUinRLxtImaJWL6xy/iq8q9aUDRDGyek5wf9X3Em5owrBO
	0LmbV7vQ78pEehpeGG/7xrgtBPFe5pc9jwKsYBl5d5tJC0fUTnnppnOP2KgSbaYqMtG3YPOhPbU
	6qx43usHRiSM5AaBfVZhicrC+nbpHTlEatP9PGLUgvFx0hgIQmyzCQcErTUtGp0jBeXelpFSqJu
	H04IcRSQDLF+TsQyznWLPWUarO3VAZAVeuIuruZYAVHZqowsEag2pRixzvqRcg/TKkgwblD4gn8
	dml+K8q7Qlnbf3yPJ8OWiZ8JlnYeneX6r5NKwXBjdlO9E+Z7P+XG6wlz1DKxHcuyPOm7R3EVPAt
	kgKryXm2sCYIOZD/i4qF/3wSgevL4+h8j2qAlnDxLDCmZEn5oiBlILs3dbbmT5Jaa8/cn5jdNAz
	qDwBZF/0uAlCWPOt4o/ubR2+Gh
X-Received: by 2002:a17:90b:528c:b0:359:f2e1:5906 with SMTP id 98e67ed59e1d1-361403bdcb1mr19409754a91.4.1776809427817;
        Tue, 21 Apr 2026 15:10:27 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:48::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-361417748aesm14497885a91.0.2026.04.21.15.10.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 15:10:27 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@kernel.org,
	mykyta.yatsenko5@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v3 9/9] selftests/bpf: Test using file dynptr after the reference on file is dropped
Date: Tue, 21 Apr 2026 15:10:16 -0700
Message-ID: <20260421221016.2967924-10-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260421221016.2967924-1-ameryhung@gmail.com>
References: <20260421221016.2967924-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

File dynptr and slice should be invalidated when the parent file's
reference is dropped in the program. Without the verifier tracking
dyntpr's parent referenced object, the dynptr would continute to be
incorrectly used even if the underlying file is being tear down or gone.

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 .../selftests/bpf/progs/file_reader_fail.c    | 60 +++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/file_reader_fail.c b/tools/testing/selftests/bpf/progs/file_reader_fail.c
index 32fe28ed2439..a7102737abfe 100644
--- a/tools/testing/selftests/bpf/progs/file_reader_fail.c
+++ b/tools/testing/selftests/bpf/progs/file_reader_fail.c
@@ -50,3 +50,63 @@ int xdp_no_dynptr_type(struct xdp_md *xdp)
 	bpf_dynptr_file_discard(&dynptr);
 	return 0;
 }
+
+SEC("lsm/file_open")
+__failure
+__msg("Expected an initialized dynptr as arg #2")
+int use_file_dynptr_after_put_file(void *ctx)
+{
+	struct task_struct *task = bpf_get_current_task_btf();
+	struct file *file = bpf_get_task_exe_file(task);
+	struct bpf_dynptr dynptr;
+	char buf[64];
+
+	if (!file)
+		return 0;
+
+	if (bpf_dynptr_from_file(file, 0, &dynptr))
+		goto out;
+
+	bpf_put_file(file);
+
+	/* this should fail - dynptr is invalid after file ref is dropped */
+	bpf_dynptr_read(buf, sizeof(buf), &dynptr, 0, 0);
+	return 0;
+
+out:
+	bpf_dynptr_file_discard(&dynptr);
+	bpf_put_file(file);
+	return 0;
+}
+
+SEC("lsm/file_open")
+__failure
+__msg("invalid mem access 'scalar'")
+int use_file_dynptr_slice_after_put_file(void *ctx)
+{
+	struct task_struct *task = bpf_get_current_task_btf();
+	struct file *file = bpf_get_task_exe_file(task);
+	struct bpf_dynptr dynptr;
+	char *data;
+
+	if (!file)
+		return 0;
+
+	if (bpf_dynptr_from_file(file, 0, &dynptr))
+		goto out;
+
+	data = bpf_dynptr_data(&dynptr, 0, 1);
+	if (!data)
+		goto out;
+
+	bpf_put_file(file);
+
+	/* this should fail - data slice is invalid after file ref is dropped */
+	*data = 'x';
+	return 0;
+
+out:
+	bpf_dynptr_file_discard(&dynptr);
+	bpf_put_file(file);
+	return 0;
+}
-- 
2.52.0

