Received: from mail-pz2-f25.google.com (mail-pz2-f25.google.com [74.125.228.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A63406804
	for <bpf@vger.kernel.org>; Wed, 30 Sep 2026 19:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790796717; cv=none; b=b60iiNFLVgBOTSKOvF7GKECbeddCgS5O/BQNXmNuJR/MK/gD7rVsAfcUiS3cTOufT3ox5qQV9NDg7AZEtaNfmdD9W9tJ8ns8mMubJ/2Ae4+J0SQHAiAAneSeHlFg1aMdmzG6H4Jk0arAxLdFLhCCHPuampvEAzAnYXgDTsfYg+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790796717; c=relaxed/simple;
	bh=++McIQjOrsk0NoohIew8405/BQUFRm6LSC8n41Wet0I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FqqjwdS5G8MRq18OtAsNoZw8YqXWGmr86IZ3GupCleIHM0f3H/phXnz6MTdIkDbYhRSVsliEeKZe5pnZughZSoNpDedXEKsY5Ejv6OVLUJTfh/H7i2j6anCPruT8W+wgt7rnd1MpfOg0XgzyAn17IaXIbkIJUN2nO2YqVU7tqNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g/6N8wSK; arc=none smtp.client-ip=74.125.228.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g/6N8wSK"
Received: by mail-pz2-f25.google.com with SMTP id 41be03b00d2f7-cc7c058617aso1321263a12.2
        for <bpf@vger.kernel.org>; Wed, 30 Sep 2026 12:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790796715; x=1791401515; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EgW9kNX7aLgTMkQDXbS+QRFIj4gH0yicr4ws18LkiEI=;
        b=g/6N8wSKMzLBUrKVjx3jMr5r3ORKa78IxHcbfq6TuUOK5o2vMA0J9COGOyBkxEG/G5
         YrqMMsNsjx2N3tDEb8925hSnubJ6pc9oa1mLtB6oGYANK6jgRYcJgJl8zR0dnLsDKfvB
         GVj8qbJg4OErA+VGGDEb9ov8eB0cnmL+p3LM1vtPSe9hDdX6jaD6tGLYfmwa1EPvLYp1
         MGsyqEGyHCacfy7Xd00OchHfoddOnYeBEcu0ntq7Qm5/zkWNdFN53W90EAFi4oN9JGM5
         ujoGzbntFlZ+1lVI41SRP2kwlQGLyy6iQ5HOwwJ7oCsE3r2l6JELIr3k5wzPVQgpg9t2
         7NOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790796715; x=1791401515;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=EgW9kNX7aLgTMkQDXbS+QRFIj4gH0yicr4ws18LkiEI=;
        b=lsg1y3tpIK5p8Ti9cx0ssfjuLP92rVSOn3p1lbwDbMWNEGDiUCVVNdNZ10M/b3gkJj
         Lx2GMbiCSQmD7Br5gx9WEJbMeeeVx7vy9DlKWdNj9gmw/k6HsbPTQ/O3ak9LuRj8vg87
         gyS7U9nZlIGec4rLfLxsCSFleYiIpF+ZjHVBiw3+tPyDFQ5hYwee7fv2gFZoaeYprHuj
         JzeaDp2IgxErxnag5D7iTJ15JIAJdq/YjN7n75f7olOPwae/nf0CfVWBD9P8YX233Ap+
         xhhySUP6VCk4SL2pF6srv1VNLpG1Bvi/5aSvEUvF9uwst9Wk7aITwa1opE0vZnY2fJcL
         U3xg==
X-Gm-Message-State: AFuF++kp1A6nSfhL/i40EuEUKl/11Jl4kWOf7If+HH4tMHBKS2bOQfJT
	DME0zPqadGjSjhuCJ+j8zD0SfJ0yfBRepVFvpojgFN+c6b3lQv6fmckg9VQrdVJu
X-Gm-Gg: AYBFou3LtciBqHLkpBv1xK4/9ewBQoUMEFw3hgXPqKFoXrwsXh5NixZeN/6r19G4zCu
	bHTXnarexrxKaS9X+XqsRM/p6H3i/Sg021+1Gwbylq9i142TnJECqHLwnhpemDhTUUe+H5VB+nD
	rzUeCloqLTAqH/af/0/CKlgXgnEFmIlCZDHBL1vMDNJvQM3tVZqU/We9+R/eior/GoNMN8ruI2a
	z30nwTw8/B34rWt4uG8oOjnueFBK9S43t56MZNJuNT456A8M3iEAkQbOAVUw6osiRL6HJnADJXN
	R24NQNvykTuuwN3wF7HWmNFjf3RAtsfuhFNTMD5y4dlfhbiL1c1G+9rHPI3qnfVxxsjNzHY9PjU
	gGx7Mpk2aVkMCdNC1MeDT7VjcC+LW4GodAxK3o/NaJkZifpzmMC9Ei4Tyb43D7IZw9+BnDnZ0fr
	qaAQub64pnfQb5UcD7trbSPQUHjYUvMArSsmIIQWouCoappOJMJ7q56Pn55QyWRjyl3Pz3YaZLq
	KY86VqoqMdAqOEhBrN5kDd6yNt+o81kaepgDvGbcL0HrRNrza7za0v0XBnY77aKuTQpf3MvvtMb
	BASoi85lmIW1jhbigrZJHFuuG/Le8aASeVzm/4lXVFzeusRoD9u1Lg==
X-Received: by 2002:a05:6a21:1fc3:b0:3dd:a196:3094 with SMTP id adf61e73a8af0-3de9ebb491amr2328847637.68.1790796715360;
        Wed, 30 Sep 2026 12:31:55 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.255])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc7e548852asm362303a12.16.2026.09.30.12.31.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 12:31:54 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 08/14] selftests/bpf: Add test for arguments without names in static functions
Date: Wed, 30 Sep 2026 19:31:21 +0000
Message-ID: <20260930193127.2181684-9-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260930193127.2181684-1-alexei.starovoitov@gmail.com>
References: <20260930193127.2181684-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

Check that BTF with a static function that has an argument without a name
is loaded.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 tools/testing/selftests/bpf/prog_tests/btf.c | 24 ++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/btf.c b/tools/testing/selftests/bpf/prog_tests/btf.c
index 21fdeeb23405..751cb14c1949 100644
--- a/tools/testing/selftests/bpf/prog_tests/btf.c
+++ b/tools/testing/selftests/bpf/prog_tests/btf.c
@@ -2819,6 +2819,30 @@ static struct btf_raw_test raw_tests[] = {
 	.err_str = "Invalid arg#2",
 },
 
+{
+	.descr = "func (Some arg of static func has no name)",
+	.raw_types = {
+		BTF_TYPE_INT_ENC(0, BTF_INT_SIGNED, 0, 32, 4),	/* [1] */
+		BTF_TYPE_INT_ENC(0, 0, 0, 32, 4),		/* [2] */
+		/* void (*)(int a, unsigned int) */
+		BTF_FUNC_PROTO_ENC(0, 2),			/* [3] */
+			BTF_FUNC_PROTO_ARG_ENC(NAME_TBD, 1),
+			BTF_FUNC_PROTO_ARG_ENC(0, 2),
+		/* static void func(int a, unsigned int) */
+		BTF_FUNC_ENC(NAME_TBD, 3),			/* [4] */
+		BTF_END_RAW,
+	},
+	.str_sec = "\0a\0func",
+	.str_sec_size = sizeof("\0a\0func"),
+	.map_type = BPF_MAP_TYPE_ARRAY,
+	.map_name = "func_type_check_btf",
+	.key_size = sizeof(int),
+	.value_size = sizeof(int),
+	.key_type_id = 1,
+	.value_type_id = 1,
+	.max_entries = 4,
+},
+
 {
 	.descr = "func (Non zero vlen)",
 	.raw_types = {
-- 
2.55.0

