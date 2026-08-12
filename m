Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61ED1322B6D
	for <bpf@vger.kernel.org>; Wed, 12 Aug 2026 06:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786514762; cv=none; b=Yjgo0oou3aDidrp59dEoKN2w6dlcu8vpxj0TMNmHnZUcthmg2Xf2IJFp99TFPCotSQOk74wbB3uU0ZfTn3ycydNekH1Qp29FYqH/oFagN+lxJ5AC17ReYFRK8q++tx4SsFREkT0ltluokCwowdklZRnr1cf2T+2PdnomDGJ8sew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786514762; c=relaxed/simple;
	bh=/OGyHYiEy27ihFxfypwGxZjaS8SVArNiKX0qtOaJ6/M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g242Uxr1OBe0EBUsSK5fez4hwITpcNZyB4htXpJER88wWJP6OR4JtHx0D0KrISd2HAcxj1PsXOhLaMEwVBepwegOlH41QghTf5+3FGIZ+HYGD9AFJmQCeAmQGftmydzSCRjb6heOwlFXTGlt2j19SZuFShhqYAY0HPZYfQt+Fp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nFHZbYgi; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nFHZbYgi"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-38101f85591so1763061a91.1
        for <bpf@vger.kernel.org>; Tue, 11 Aug 2026 23:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786514761; x=1787119561; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Uu/u+XgdVM2vnLf3P+xre46c5wIQQBHvhzkrb5tnjRw=;
        b=nFHZbYgiFleydGpCWjVtehrbEAesMZg/XewFQU7AzD1GbST+2FFcB6Lk32edJbkOMa
         ZNs4Iurg01b9F52PNGgc7GbJirlf8oPYNUTyrXuizdclvReq4f20fphazYl4oOJrf/Qt
         4rrQQhQ1Z4DX19Zruik9htbTIrXzEG3LH3YwX5LYzD1R8+UJpoiQq6UuOF/AuWo+rk+P
         T0xycEqpxXrPF+DIXe74q41kEEV6U9dmMTioh+YB4lTS6MakVYzubrzzeWujdos2pfCU
         0sM+I82xQnzyGXWUEn7yLHttTUxEx1uEL0oaEbJOCZTVSCWq1G3Vnvw21Bpb4wTuOUIJ
         Ks7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786514761; x=1787119561;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Uu/u+XgdVM2vnLf3P+xre46c5wIQQBHvhzkrb5tnjRw=;
        b=r5Cyx7PUlYto8Eicn4QyRHiqDhdTJ3qF0NmzK19xOmGRP0ASRD72/mHFwGMhXibmd2
         BsxjIgsGrAcO5uMG45lE1sOy2SGf63jnh9JXPfP4zeFIvmE2sv2kwCjXze5oDClsLjIF
         cP7/WvF/616mOa3W1/A/REOd/oCYd9teLmb4301dpUcUAetcUsBvjEuFjOuJikNyC6fH
         kOWuYJ2BNC1t8ARwg7FgRT65L2LAN4GDw2XrXivTkejBBHJIbHfQRCKK4+Dliq0OcLGg
         jf3L6DMoe4moSmyDO2OGKFtt0cpU56Lbh0MC7MQzOBB0Ky5UWYrrmkcgjWmFMzBxRFdu
         nURA==
X-Gm-Message-State: AOJu0Yz5JrTtr6GNEucnrrFBCSIqC0/ltq1dTwCa17OPuRg4uFLNpG07
	0HDRrsn7BTtpGwaXAcbGkTOT1LnuiAzIuW+9TNbuCZ3lNre5j8XvOf5VTFDt3qhn
X-Gm-Gg: AR+sD12cG+n2UKfShcPZiZcvGnv7nVMz1V839VRPL3s6v4YlEca/49hBb9MmmfMp9AZ
	3zCcVaSYA7WnBnO6n8O0dqZs+UD7vtHBHcLf6dTdBmwKsp/1NesntLqaDagr7b6TNR2aJIQ8AwG
	kXmhHuiDjzqAWK8gYVj83Ir6Dm0XbSZBdyLf6epH3g8b+Xi5Xlzn0qAzFVHp+uPfK6amFYcuo8A
	8pOrzTMyqKvZYfm/pWCcZd0FTPPSXGiWjPhVH1hI/TowXS3OUQRf7TrdMBLX1XodEHDXwhGQski
	1zdUWpzp+8WjIbstw0rG+vklkqfEU73jwFmuzjTKRTa0MmZ8DXIxWc4nuuGG86ObD99YSOl10fU
	/ChAmhz9Z/99Es1xlF9qD2QhAFHhflYA2Hd8xEOD2WJFbRqhxiwH8UGLv62yeU3I6Y9ebTRjqsE
	SQBEoiXZRiL4+Dd4bDNroDZbddSIdVF5M1oD+ayQwQT4lH+yNwwAhp3UO1Ei1pfhcUoLAHzdJj1
	ep/eA==
X-Received: by 2002:a17:90b:6cd:b0:390:b3c5:e2c9 with SMTP id 98e67ed59e1d1-39302bce9e4mr1036270a91.17.1786514760538;
        Tue, 11 Aug 2026 23:06:00 -0700 (PDT)
Received: from badger ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-392f88d1e8csm2314520a91.5.2026.08.11.23.05.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 23:06:00 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v2 3/3] selftests/bpf: guarantee zero termination for veristat test buffers
Date: Tue, 11 Aug 2026 23:05:44 -0700
Message-ID: <20260811-veristat-filter-fix-v2-3-6c234c4cd6ef@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260811-veristat-filter-fix-v2-0-6c234c4cd6ef@gmail.com>
References: <20260811-veristat-filter-fix-v2-0-6c234c4cd6ef@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

In veristat tests replace direct read() calls with calls to
read_output() utility function, which:
- guarantees that the input buffer is zero terminated;
- asserts that read operation succeeded.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/testing/selftests/bpf/prog_tests/test_veristat.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/test_veristat.c b/tools/testing/selftests/bpf/prog_tests/test_veristat.c
index 4cd41080eed3..11f3de2b66ad 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_veristat.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_veristat.c
@@ -82,7 +82,7 @@ static void test_set_global_vars_succeeds(void)
 	    " -G \"struct11 [ 7 ] [ 5 ] .struct2[0][1].u.mat[3][0] = 175\" " \
 	    " -vl2 > %s", fix->veristat, fix->tmpfile);
 
-	read(fix->fd, fix->output, fix->sz);
+	read_output(fix);
 	__CHECK_STR("=0xf000000000000001 ", "var_s64 = 0xf000000000000001");
 	__CHECK_STR("=0xfedcba9876543210 ", "var_u64 = 0xfedcba9876543210");
 	__CHECK_STR("=0x80000000 ", "var_s32 = -0x80000000");
@@ -124,7 +124,7 @@ static void test_set_global_vars_from_file_succeeds(void)
 	syncfs(fd);
 	SYS(out, "%s set_global_vars.bpf.o -G \"@%s\" -vl2 > %s",
 	    fix->veristat, input_file, fix->tmpfile);
-	read(fix->fd, fix->output, fix->sz);
+	read_output(fix);
 	__CHECK_STR("=0x8000 ", "var_s16 = -32768");
 	__CHECK_STR("=0xecec ", "var_u16 = 60652");
 
@@ -142,7 +142,7 @@ static void test_set_global_vars_out_of_range(void)
 		 "%s set_global_vars.bpf.o -G \"var_s32 = 2147483648\" -vl2 2> %s",
 		 fix->veristat, fix->tmpfile);
 
-	read(fix->fd, fix->output, fix->sz);
+	read_output(fix);
 	__CHECK_STR("is out of range [-2147483648; 2147483647]", "out of range");
 
 out:
@@ -157,7 +157,7 @@ static void test_unsupported_ptr_array_type(void)
 		 "%s set_global_vars.bpf.o -G \"ptr_arr[0] = 0\" -vl2 2> %s",
 		 fix->veristat, fix->tmpfile);
 
-	read(fix->fd, fix->output, fix->sz);
+	read_output(fix);
 	__CHECK_STR("Can't set ptr_arr[0]. Only ints and enums are supported", "ptr_arr");
 
 out:
@@ -172,7 +172,7 @@ static void test_array_out_of_bounds(void)
 		 "%s set_global_vars.bpf.o -G \"arr[99] = 0\" -vl2 2> %s",
 		 fix->veristat, fix->tmpfile);
 
-	read(fix->fd, fix->output, fix->sz);
+	read_output(fix);
 	__CHECK_STR("Array index 99 is out of bounds", "arr[99]");
 
 out:
@@ -187,7 +187,7 @@ static void test_array_index_not_found(void)
 		 "%s set_global_vars.bpf.o -G \"arr[EG2] = 0\" -vl2 2> %s",
 		 fix->veristat, fix->tmpfile);
 
-	read(fix->fd, fix->output, fix->sz);
+	read_output(fix);
 	__CHECK_STR("Can't resolve enum value EG2", "arr[EG2]");
 
 out:

-- 
2.53.0
