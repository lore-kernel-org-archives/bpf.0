Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54A31377AAD
	for <bpf@vger.kernel.org>; Wed, 14 Oct 2026 17:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791999077; cv=none; b=sUGkkoZnanXfJerjJPMUFk+TndpY2w/ENUIExPSu8lDs8aQmuWI0fc0iXH1NpDjWuIzNKZy6ZOONjCAQENmL78qtpLxT1rkp4rt2Bsxq2RjxgoRA+zK7D2lL5/KZA/w2IVbbH41JmpAwm+5oucc+EaoluinbmQ0NEu2iSpaLIJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791999077; c=relaxed/simple;
	bh=2nReP7Ey7TqL85Yf66HBNNAtFReJw4FMUGltsEflGtM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xmt84lhQOqlUA7qijc1umfmCRIWD9ofrUkHfROGNFVEr3/sDyhfzSMhVPYL0vKof/OENrk95l8i+nPYLrN9hQHIxgqx+bHEeTu2bxpApK/OTeAqek67DB9BkHO9ZG4b9Q0KusAHNUOGzT9+IlS17FJ/3p+tGfbIFA1rC6x9MzhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KYkq7KSV; arc=none smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KYkq7KSV"
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-67489c8202cso760246d50.3
        for <bpf@vger.kernel.org>; Wed, 14 Oct 2026 10:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791999074; x=1792603874; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=62V2Z70B6CLIwBg4NtT2/FfP8BJKiwlD78O4Q7/TdpY=;
        b=KYkq7KSVISOkQ03EqbAZqNHhOt6ULmIY5aazTbLxUa63cgseTNd6i7snhtWerv+9Qo
         JjizQgOe8QpvzNwxQRYioDU757L0XK6v8Ay87B+L8X4RuFZw5BS9SNygceKjdaGs+NIG
         u/ZW2/skZvNBZMK+tVYm7TLHgNS5bV33yAfsxgV1RZYudrUZE+4thfrw1D9N10Bzhsb6
         VfTZ60imbqJcfwQQxB7QB3UZeX+ddCbxpmdqdCvNVHqkhwKpgyncvffr7GvTn8gF9lqu
         vDMJTswrKcjT2Tvg6IFpkJ6O1AKkt++aA5fx5Iyb9onSODuXpT6vii+LvFk2HlDHkgtN
         XgUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791999074; x=1792603874;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=62V2Z70B6CLIwBg4NtT2/FfP8BJKiwlD78O4Q7/TdpY=;
        b=2xmtppLuCK+sdIJFyH9dOSOg9p52Iof7wzHaIMG4hZpMCQUU+kGtRwyDGG8f3Ikj1N
         FNnFxyJs4GNvLV98VCMbeItjJHU7JcCmUHf4Y5fYFTCOsbfZo6n+weMj8N+FvmBk4hMb
         vyes/YYI2xMFtR9mL/5aL4MwmDJpIXYkRynw4l+2Of6k6EDBBtfJvVnrI1BK6/+BrsAY
         nEXH8A5JkVuXMFppmT9RUIWmA7hvvVbAf/3RF0KC3x/c85g+OA2p6EyyJCX9VXJ48a7z
         J1CDLyVu9TF/SVuhVyLMJEx0TtDXfmkHZds8VVbHU7JAykjtEy0z87BXPtCGCFS5Nm3U
         968Q==
X-Gm-Message-State: AFq9FYJBPX6O9mV3BR5zAzJMxAsa5orxGzj57PqnVhcPCdDxvEOoQF7k
	/cacX/xub2owTThpjnxWf3c7RVh05QsyT5tTRX9Q3kY9xOCO5WgwztgZIkECvg==
X-Gm-Gg: AYBFou1EzpKL3+ZLYpopOty2qc3UYg5u7zxvX0jB8wFau+QxwStXCojIBRfi0MxVlZf
	xq8198fajuTMr8btFdAhZYcDnDnt1KpR7e77KjUZaUdfe/2s1zdJ1cyvVrrwID/2+WlgOyQxdyX
	J+upJ5vyvO7ivCcZ1HXbcsFJD0wYC/NhEWjE9xBwVt0sWgNi0eHRcdczkTkvPTh8kraoB3RCdnV
	tZ9CB3FkQBWhrFUMfY+XRFGySJvDXlVlZsz1EYuEU7B2FtArrztG49/aig9dHagQVTcT9mFsb+5
	TTzwdODZN07l7lHlKYvCyLAnAlHXsv0+dAk39O4Xjeu+SZ3VB6fwqnV1VTNi22iaRDB6XXyoUGq
	btYZyAGVT8/M7EF4YiLleDh+w0eI56h2a0XqNk3JQ6g73fD+b9sFqGdZVUK1i02HC5uGj1iZ6TS
	8gqgBRwjQ9gUPWeccFLcHHUXeAKZl2fIo4BH0OdD8J7FD5ShN5pnVOJ971kZJJtMz/VyeuXE5F
X-Received: by 2002:a05:690e:4391:b0:66f:c1be:a647 with SMTP id 956f58d0204a3-679362ba30emr4631293d50.57.1791999073646;
        Wed, 14 Oct 2026 10:31:13 -0700 (PDT)
Received: from zenbox ([2600:1700:18fb:6011:8784:7d62:1705:ef5f])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67986a66262sm1277803d50.11.2026.10.14.10.31.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 10:31:13 -0700 (PDT)
From: Justin Suess <utilityemal77@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org,
	Justin Suess <utilityemal77@gmail.com>
Subject: [PATCH bpf-next v1 3/4] bpf: Bind trusted fields to their parent's reference
Date: Wed, 14 Oct 2026 13:30:38 -0400
Message-ID: <20261014173039.3666415-4-utilityemal77@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261014173039.3666415-1-utilityemal77@gmail.com>
References: <20261014173039.3666415-1-utilityemal77@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A field in the __safe_trusted or __safe_trusted_or_null set walked out
of a referenced parent yields PTR_TRUSTED with nothing tying it to the
reference that keeps it alive. Releasing the parent invalidates the
parent's own register but not the walked field, which stays fully
trusted after the object may already be freed:

	file = bpf_get_task_exe_file(task);	/* acquired */
	inode = file->f_inode;			/* __safe_trusted */
	bpf_put_file(file);			/* inode stays trusted */

Set the walked field's parent_id to the parent's reference id, or to
the parent's own parent_id so a chain of derived fields stays bound to
the original reference. release_reference() already invalidates every
register whose parent_id matches, recursively, and regsafe() already
maps parent_id through check_ids(), so no other verifier changes are
needed. An RCU-protected parent keeps bounding its fields to the RCU
critical section through MEM_RCU instead.

Fixes: 6fcd486b3a0a ("bpf: Refactor RCU enforcement in the verifier.")
Signed-off-by: Justin Suess <utilityemal77@gmail.com>
---
 kernel/bpf/verifier.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 20ca8591a0fe..8c39ec2ff408 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -6562,6 +6562,7 @@ static int check_ptr_to_btf_access(struct bpf_verifier_env *env,
 	const char *tname = btf_name_by_offset(reg->btf, t->name_off);
 	const char *field_name = NULL;
 	enum bpf_type_flag flag = 0;
+	u32 parent_id = 0;
 	u32 btf_id = 0;
 	s64 min_off;
 	int ret;
@@ -6716,6 +6717,11 @@ static int check_ptr_to_btf_access(struct bpf_verifier_env *env,
 			 */
 			flag = PTR_UNTRUSTED;
 		}
+
+		/* A trusted field is pinned by whatever pins its parent. */
+		if (flag & PTR_TRUSTED)
+			parent_id = reg_is_referenced(env, reg) ? reg->id :
+								  reg->parent_id;
 	} else {
 		/* Old compat. Deprecated */
 		clear_trusted_flags(&flag);
@@ -6725,6 +6731,7 @@ static int check_ptr_to_btf_access(struct bpf_verifier_env *env,
 		ret = mark_btf_ld_reg(env, regs, value_regno, ret, reg->btf, btf_id, flag);
 		if (ret < 0)
 			return ret;
+		regs[value_regno].parent_id = parent_id;
 	}
 
 	return 0;
-- 
2.55.0

