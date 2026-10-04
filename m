Received: from mail-pj2-f42.google.com (mail-pj2-f42.google.com [74.125.227.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0883343849A
	for <bpf@vger.kernel.org>; Sun,  4 Oct 2026 13:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791121152; cv=none; b=ScAwk0xWnbVn29RoaT82HI6YuNSkrLC+rEOeygWJiGwZtnokpy5WUa1u6uMzcu0BbYwBQvE0SdQjtbOKqYYaeTb55LF1bCcz2mNsa4OYRzENteB9qGKWl+pcEOWCnKv5VbfgtRiggjcJ6xmzHljjE8x0GnyDpnMluYGI4vpxnIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791121152; c=relaxed/simple;
	bh=FF/X25W0C3cpp+Vvu1qrgGDfWnmFdT3QVDs3WPcoa34=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CW1ghhFy1Je1X9pJMjKq5wAs/m98gC2NNgzd8DIFqh1YhiCTJMSQ1BqjOVhDUQhw8mVwpi057aGKzDewVaEdOZJJJENBPjtwN5TI25t0H7hIfv4mvLZm/dltpkW1KeJbxxotnTU/fkMXRrN5ioTTzTSklTiGoJu2N9F0b9P0lpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mz1u2P1e; arc=none smtp.client-ip=74.125.227.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mz1u2P1e"
Received: by mail-pj2-f42.google.com with SMTP id 98e67ed59e1d1-396ccb65437so400917a91.3
        for <bpf@vger.kernel.org>; Sun, 04 Oct 2026 06:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791121150; x=1791725950; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5kFRCyHgUfLVqRoY1XDChIlaNKhDMgGZKYrm7E9TkXg=;
        b=mz1u2P1eFeKVYYp+KIIAR9B1NRLFeLQmNFeJlEq5FCvZU4s2bfsutdpZzGwxVNcFLU
         hASuOUxIp8LGSpj6GiDqLZMZc1SKm6y0Y0yIGddEDwvgQXizxYJfWGH2Iyd4vVQIpbxa
         G33FUhgqq2yeSjdvtcxhC90IjSIWElxiGMRVbFhdviWkgo3kFkCb/vX3zZXUVt52UC+/
         MU3jZglGYu368WHzIPUxzEWfBhVml7ehaNlcjFmC8Qu2AhOPeZsuSydrk0QqkdQ8hNUK
         9f2IxbzVee1gweRZ5kU/J7YkRZtMcD0sOlqPlnZjHc7BCk8uTwiGeAATk6Js927vzV3j
         aW6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791121150; x=1791725950;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5kFRCyHgUfLVqRoY1XDChIlaNKhDMgGZKYrm7E9TkXg=;
        b=nvAqU2XMpHWI2v6F4ihcI61fMbesE4rZvlg7pDZ+n5UhTCV8ydNa3nncPMCHENe7Px
         4aq7CmeCmdWftpGWbhb1yRIN3ts6lxhcrDDIgCNSXldX9sAwD1IqQK+Y9oHYYnCztysE
         OYtS+HThbA0x57foaBtOvtQpzj/8KT4S0KudHZvNTWskW2ica4is0iU/MvwL1CPEUgDd
         GLuR/O/lXJWD3tUXapB2p4vxGtQQm+CMJirhPuBFM1blZQxvI6xIMJUq9qkfssO8JiYx
         I7w1JviU5ekKLzIniF1rCtogyEgtaVmipGlZdBfEL16usYLQTeHRy2uoPktj5+PFneYt
         9zjA==
X-Gm-Message-State: AFq9FYIvA2IIoT9JC2B+fO3C+yx/HsM9njo0m2Fq0MA2tS2qKle11Hz9
	J0UmwZsx938reevq3Fo0HrPZ9o2FM8PRabtz7O2SVRtM4KHPaJCF7DtPIdxRYQ==
X-Gm-Gg: AYBFou0TbucEdeQpg951/vRRrUeE/b7Th3RIuwuT4qRe8TamNl6oEYiAD/X29wO2OqS
	rjrmAQVw0xHyxlumDtoyYJz+g7zlXkwCX1PWRqmXVVLQhu0WHOIBerLNSDlGHFqCYQAun+mszq6
	Hkf5unX0RKXtACxUUzKetHR+SVIXg7hJfFqzMUjNVZDEFD/HDf3c15g1dLDw6ie4N4qExgBHy2q
	0eATqaxVHXxYoXvvK2eI2YGMwet2ASD976we2WfQ5089XvzcJW+XB8G9/hU7ctC0JNSrNGz7NIu
	JyQRlI3YbcSQn7+OsutOjyKqHlLhp3GGhuASb+1Bzmj+LqAZ47YhlZtSgf0VSl29yeyPO/pvAKA
	pwlfsaRty4E22gaQe0A1czbwY+koQuEcdIsO43g6enqFcINTmOgOkAX7ZHa9M6+IZja6uDX5Nwe
	DApq28oVf2a/vO6GM+Jw5oHrJrE62fdYIpxwAnJk2pqDotT2PkODUVds5BgUCOFtpPQifzAE9ZX
	goxaLGfT+us58s=
X-Received: by 2002:a17:90a:d64b:b0:3a5:1b:34a5 with SMTP id 98e67ed59e1d1-3a6ce84450dmr6003739a91.49.1791121150131;
        Sun, 04 Oct 2026 06:39:10 -0700 (PDT)
Received: from badger ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc9f7398400sm2915173a12.25.2026.10.04.06.39.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2026 06:39:09 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v2 37/43] selftests/bpf: tests for map special cases in bpf_helper_stack_access_bytes()
Date: Sun,  4 Oct 2026 06:38:19 -0700
Message-ID: <20261004-scev-minimal-rebase-v2-37-f6254e29fdf2@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261004-scev-minimal-rebase-v2-0-f6254e29fdf2@gmail.com>
References: <20261004-scev-minimal-rebase-v2-0-f6254e29fdf2@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Tests for helper arguments whose access size or read/write effects
depend on the map:

- helper_map_output_known_size checks that for a known map access
  MEM_WRITE | MEM_UNINIT produces a must_write mark.
- helper_map_output_merged_sizes checks that when maps with different
  value sizes merge, MEM_WRITE | MEM_UNINIT produces use and may_def
  marks over the maximum value size, without a def mark.
- helper_bloom_peek_input checks that for bpf_map_peek_elem()
  on a bloom filter the buffer is treated as an input.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../selftests/bpf/progs/verifier_live_stack.c      | 76 ++++++++++++++++++++++
 1 file changed, 76 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_live_stack.c b/tools/testing/selftests/bpf/progs/verifier_live_stack.c
index 5b0fcef1f571..d93bb628f65e 100644
--- a/tools/testing/selftests/bpf/progs/verifier_live_stack.c
+++ b/tools/testing/selftests/bpf/progs/verifier_live_stack.c
@@ -3145,3 +3145,79 @@ __naked void helper_output_unknown_size(void)
 	:: __imm(bpf_get_prandom_u32), __imm(bpf_probe_read_kernel)
 	: __clobber_all);
 }
+
+struct {
+	__uint(type, BPF_MAP_TYPE_QUEUE);
+	__uint(max_entries, 1);
+	__type(value, __u64);
+} queue_8b SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_QUEUE);
+	__uint(max_entries, 1);
+	__type(value, __u64[2]);
+} queue_16b SEC(".maps");
+
+struct {
+	__uint(type, BPF_MAP_TYPE_BLOOM_FILTER);
+	__uint(max_entries, 16);
+	__type(value, __u64);
+} bloom_8b SEC(".maps");
+
+SEC("socket")
+__success __log_level(2)
+__msg("call bpf_map_pop_elem{{.*}}; def: fp0-16")
+__naked void helper_map_output_known_size(void)
+{
+	asm volatile (
+	"r1 = %[queue_8b] ll;"
+	"r2 = r10;"
+	"r2 += -16;"
+	"call %[bpf_map_pop_elem];"
+	"r0 = 0;"
+	"exit;"
+	:: __imm_addr(queue_8b), __imm(bpf_map_pop_elem)
+	: __clobber_all);
+}
+
+/* The maximum map value size is not a guaranteed output extent. */
+SEC("socket")
+__success __log_level(2)
+__msg("call bpf_map_pop_elem{{.*}}; use: fp0-16 fp0-24 may_def: fp0-16 fp0-24{{$}}")
+__naked void helper_map_output_merged_sizes(void)
+{
+	asm volatile (
+	"*(u64 *)(r10 - 16) = 0;"
+	"*(u64 *)(r10 - 24) = 0;"
+	"call %[bpf_get_prandom_u32];"
+	"r1 = %[queue_8b] ll;"
+	"if r0 == 0 goto 1f;"
+	"r1 = %[queue_16b] ll;"
+"1:"
+	"r2 = r10;"
+	"r2 += -24;"
+	"call %[bpf_map_pop_elem];"
+	"r0 = 0;"
+	"exit;"
+	:: __imm_addr(queue_8b), __imm_addr(queue_16b),
+	   __imm(bpf_get_prandom_u32), __imm(bpf_map_pop_elem)
+	: __clobber_all);
+}
+
+/* Bloom-filter peek treats buffer as an input despite the helper's output annotation. */
+SEC("socket")
+__success __log_level(2)
+__msg("call bpf_map_peek_elem{{.*}}; use: fp0-8{{$}}")
+__naked void helper_bloom_peek_input(void)
+{
+	asm volatile (
+	"*(u64 *)(r10 - 8) = 0;"
+	"r1 = %[bloom_8b] ll;"
+	"r2 = r10;"
+	"r2 += -8;"
+	"call %[bpf_map_peek_elem];"
+	"r0 = 0;"
+	"exit;"
+	:: __imm_addr(bloom_8b), __imm(bpf_map_peek_elem)
+	: __clobber_all);
+}

-- 
2.53.0
