Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F74B38757C
	for <bpf@vger.kernel.org>; Sat,  7 Mar 2026 06:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772865894; cv=none; b=iWSCnl37ARiKoIkO1/Roz/ptrCG5vqvtqDwW4X60q2xL6OXD4F6xbsFlOvMD7+4/OYFKj4rteXHWQqR+ZudeJmfPKSVkzm8yUCFjNP1yqrTwr08TB+GjNehzOIhuJ0hc+iOebAoXWNfbJYX8WY047O1GJUYWXMRHQhDFjaqIeu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772865894; c=relaxed/simple;
	bh=KHD6ujHLbb4Hg9pj7XHPUSRlHVBVaOw9dccm0+vGtKM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AObSug5U9CRAeKCYo3FCj96Z+Kf7TflOJM0xyWP0kEFMelCwmFCf4iXBh2iW7m3bJ9U2Fhh4rhVbNGFFDL60D1pShEk9MyN/9rvhdry/REnHhhyAeAsApXgea9OsXItkTHmWRXupqQW9YxJut1i/Tkyu0TpLx8vm74mp8oyqPwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=chDbUc/n; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="chDbUc/n"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2ad21f437eeso71566505ad.0
        for <bpf@vger.kernel.org>; Fri, 06 Mar 2026 22:44:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772865892; x=1773470692; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aHYg6MzrYh/5hr4XsEQrWa2Q0VlX4ynIFdBuYa9PVdg=;
        b=chDbUc/n/5QSHL7unrNoMsjbUWGtdH4+bvzGnCJle8N0tQtMBhz0iScFdsnYds5EAI
         BAKtywtvywHbnMrT47decXUV1jg/FjyK7FX1RIeYDMCkcF39YYTuSlnSXl/YJiK2Xkd9
         Surhz0R6j4iftDY+El1I+19avidpDW81LItlYGvWRM0IGinrU4SWiGQMZbq7C9WiO4JX
         8pEF+/WuDDG6ymtnPU8OKfOhzlOIBHJdUYzu4N1j5j44qZe3Ohg6gfRTWReza+CsW2eJ
         CIxbrVJv2UoboT49QIyBYQqlxRcGzxE1C224vx6DjZaxqQecY0gs99t55KkNFPCffUK8
         5kkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772865892; x=1773470692;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aHYg6MzrYh/5hr4XsEQrWa2Q0VlX4ynIFdBuYa9PVdg=;
        b=aWOU4RrORkcn3RxlGwngjro8dWWX3edHjqNLKi8vRkeiwyD5hrUSz/ga3avrgnhycJ
         RzQaUA5JcHblKu0W2HkZ5cp75Ogw3zhkmhsSkGmuSaQo08l7ZKre8wh1UI5uye8XyRZK
         Z0eZo+qvKRrWSMltsTO5pOcIf3vPAJXn36Gdfel9yV/3Zzvq/VKitwdUuMUU6u1jqgcC
         xEZK64Yk5PpPqdEagV4iICu4Rgldau6Js/NtLdIVD4/thAR3+/bgjU6Bo9q1OFdfK9MX
         993onc+Nv9RG+q1mfJoCUfM9k1AoSh6GbOLCB/EhSBV+41kXN+nwl73L4r7hS9mtq4Ja
         fhCg==
X-Gm-Message-State: AOJu0YzMs7XSfT6OgZUfL+9Wg0ZoErO9WLZH1ld0wyIEsHnDLKHjfKTY
	JwbWXwqOBCeZGXOzWWo5/2vs5UGUmFU1GUUG7+5B+mjQsybyzOpvV+OPQBnxaw==
X-Gm-Gg: ATEYQzzFSV9Q1E3DreTnDUJ0f88qSObAfMZjDXeqhsSHqMaf7Ih8FyotgjcAVq5ijgd
	dwkvtpHs4GpF3arZQOZnr5fVzUqenGh+rbNkac3IFRdKDSLdM+sS4FV3AH65NXC9SXPzkWz3KlE
	WRnsqAtrUSah7BqFxJfnPluyZKBw2nTHbAf6h0Dh7/BT2ag4PisBPTOOb/bPNiFhT0HFL2cFNzv
	ieU/J9onqKyM5QhmRvoYB83Il5SOh1qPu7Tww35bF0k9sJ0sVZSbj0NDVZrOICF9wiXqhjg1OTe
	EaIQouyE6/NoK0u4fJnPpjTP8SUyYyRDNxJSg7CCyP4gLV7dRZmafMUDrZ48QtikwXlN5VdmZdl
	2fG9mlIrK68fCZXY2ZDKHhGTMWN80zQvxpcwfqUCGfaWKhZEfbG5FcraUf2igV9vegJeaChyfVn
	s0XqWo/pQfreOaYXH3TlAiIwY=
X-Received: by 2002:a17:902:e808:b0:2ae:478f:2ef with SMTP id d9443c01a7336-2ae82a7b56amr44917185ad.28.1772865892573;
        Fri, 06 Mar 2026 22:44:52 -0800 (PST)
Received: from localhost ([2a03:2880:ff:e::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae83f74e7bsm39861445ad.46.2026.03.06.22.44.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 22:44:52 -0800 (PST)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	memxor@gmail.com,
	martin.lau@kernel.org,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [RFC PATCH bpf-next v2 11/11] selftests/bpf: Test using file dynptr after the reference on file is dropped
Date: Fri,  6 Mar 2026 22:44:39 -0800
Message-ID: <20260307064439.3247440-12-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260307064439.3247440-1-ameryhung@gmail.com>
References: <20260307064439.3247440-1-ameryhung@gmail.com>
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
2.47.3

