Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5079243CECB
	for <bpf@vger.kernel.org>; Fri, 27 Feb 2026 15:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772207184; cv=none; b=o578vwTFR6rN7klfbAkvZz4G1itiQPsI7KdySPbrpD2gKDs8DuyOi1bHa2ZottuM5h2nH8AY1+o3oAoWVUi8R+JElrJQJcfM+RWI69AlViwr5DmwJcr3D4tVcLvXraXI5HXjWZgchnp9RDkJYYKzeysw1UdxKQZfo8b5rx27H08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772207184; c=relaxed/simple;
	bh=9uVOEmQBTsY3cK8K+gt4eK3WVgik4LoJ2L3ebpergPQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ErAxmxnNQ9BsUphwedbLEg9nTQAKEE1t9AG7MFVS6zsXEKkYUChYxwkjw7p+sCh8tMhRT8srsaVVHNEYnVkoCe4u4xU1Vgrt3N2BbyS0doDJDdp0Ltp0v5VSvZ1BzALEaxOdsxlDoI/n8dQRsPEWnAX72QnIxQ4DnmxFNVjW3L4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=dsxl+Xzm; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="dsxl+Xzm"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-8cb7edbcde6so286063685a.3
        for <bpf@vger.kernel.org>; Fri, 27 Feb 2026 07:46:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1772207181; x=1772811981; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e20HPgDj0TL/qVBDQWOYy9ha/N51MvGl2x5SRPIASKQ=;
        b=dsxl+XzmjbpWVTG28JdCIFvj9GNSLfLDNe/V1gYHHLdcaw70iqW6T7x1d4ZB0o2Jiy
         fgOY2TuU0Mo3h3xn24AFfolJpu4EgddnlEpbRtu8pCyY+GD9Km6XaN9Iegkne5uSY7Th
         HJoBWwTV3Mu4peHsaNCa06rQOM2Wsj+3jDtMUk3zJ1JGd3+NLrn7xHkKT10nURQlUYAo
         8nnE/YhFUZu7Bc/SAhRQwrQagjaTWizcyxLPRVwjKYciFO9+5GTX7J740ktdMjFwia2z
         dgkWefuXmJNTha1gCI6cET2jVZ3LmibuJY6DZ8qfiYx2x3u0whZQmjNgkVTe4NtVEFj8
         yxog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772207181; x=1772811981;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=e20HPgDj0TL/qVBDQWOYy9ha/N51MvGl2x5SRPIASKQ=;
        b=N7QkHau+NyQasm1QuM7Lr6PPlXsQjANBNjsCgVyonu0LCsMBPTIp+4p/iaOZOHdVYg
         Psw2qdMvSOpZmFqL1UoKfqIkoiXDc0YwZ7hK2uOT4IU0wKBJW6UocFJv2jeNSo4HT/Yh
         ZCLQycAHHujFArUMJk6UV6MrG5jPRYI1ILACwU84oq/Nh69Uh6NtPrh89q9CJ0DvQs8P
         oJJO59BDDzEXsm6CdtjTuCoEd+PTj0wV5CrHiVEt0xV1MKAJlT1VaoYnMTnrR4oYl3oh
         krex2uR92R9XQu28cFycnHoMOv8FMbfXTdqwg2ULR7qyKHbhsAVyCJbTYSZEXUbcJnFK
         fRew==
X-Gm-Message-State: AOJu0YxvNtvtYt+r/2CJdqutR5BW6/V3ArP2s1pkUWEF1FQIijCKL2A4
	st/m5yYkIiOf8TweKMY/EYi12MlytsXetZMib/FEGzEX8/z/wXe2csvkSid/5ONR3/YsK4Bz40X
	ea8Tq+LM=
X-Gm-Gg: ATEYQzxTKbCszmf8Cz4JSuZIq1XC47SF2q7GCqL0lJLjwfmRHoXEKi/KTp9ll7rS1+1
	cS4lbirhYdNtoHxjpDYrbpQZuYnuzaCU4b4gKC3zNL3RiXnsz8yVQEmlzDN4ba6Mi0S2MobCJCl
	hikLm71WsgqSru3eY7P62b2DykBpENEFI2sr4SQJWj5JL1m/LyrghxKKAvjbmFGi/fuqk09OMC0
	4qzUc/ymO16RFpjV8fwdfDa7k7qsVMu4bLjtu69vTJulCfdQR69twITCvUrjM6EAZQFPR9glJQN
	lWHyKjGONSQzsl5SAEmfVtVGiwfXv7uH6GhiRAckubewVsp4dGSWCI3HmrlX+J9tEjVcigGa9f6
	Sb3bwtKpbBjv9bMUCQ03YghFb9L43S/v7MhdXAcDxQkxvqa6qLpK67iaLVvm5ONDUywQzF9FqSr
	/f/Hd13ArqBeDMpYsOnaiQHg==
X-Received: by 2002:a05:620a:192a:b0:8ca:3175:cc72 with SMTP id af79cd13be357-8cbc8e55353mr391092585a.15.1772207181011;
        Fri, 27 Feb 2026 07:46:21 -0800 (PST)
Received: from boreas.. ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cbbf652bb6sm544180385a.4.2026.02.27.07.46.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 07:46:20 -0800 (PST)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: andrii@kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	martin.lau@kernel.org,
	memxor@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf-next v5 2/5] bpf: Extract program_returns_void() for clarity
Date: Fri, 27 Feb 2026 10:46:13 -0500
Message-ID: <20260227154616.6846-3-emil@etsalapatis.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260227154616.6846-1-emil@etsalapatis.com>
References: <20260227154616.6846-1-emil@etsalapatis.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eduard Zingerman <eddyz87@gmail.com>

The check_return_code function has explicit checks on whether
a program type can return void. Factor this logic out to reuse
it later for both main progs and subprogs.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 kernel/bpf/verifier.c | 64 ++++++++++++++++++++++++-------------------
 1 file changed, 36 insertions(+), 28 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 6cf2270c343c..9b49f1a6e8dc 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -17949,6 +17949,28 @@ static bool return_retval_range(struct bpf_verifier_env *env, struct bpf_retval_
 	return true;
 }
 
+static bool program_returns_void(struct bpf_verifier_env *env)
+{
+	const struct bpf_prog *prog = env->prog;
+	enum bpf_prog_type prog_type = resolve_prog_type(prog);
+
+	switch (prog_type) {
+	case BPF_PROG_TYPE_LSM:
+		/* See return_retval_range, for BPF_LSM_CGROUP can be 0 or 0-1 depending on hook. */
+		if (prog->expected_attach_type != BPF_LSM_CGROUP &&
+		    !prog->aux->attach_func_proto->type)
+			return true;
+		break;
+	case BPF_PROG_TYPE_STRUCT_OPS:
+		if (!prog->aux->attach_func_proto->type)
+			return true;
+		break;
+	default:
+		break;
+	}
+	return false;
+}
+
 static int check_return_code(struct bpf_verifier_env *env, int regno, const char *reg_name)
 {
 	const char *exit_ctx = "At program exit";
@@ -17965,35 +17987,21 @@ static int check_return_code(struct bpf_verifier_env *env, int regno, const char
 
 	/* LSM and struct_ops func-ptr's return type could be "void" */
 	if (!is_subprog || frame->in_exception_callback_fn) {
-		switch (prog_type) {
-		case BPF_PROG_TYPE_LSM:
-			if (prog->expected_attach_type == BPF_LSM_CGROUP)
-				/* See return_retval_range, can be 0 or 0-1 depending on hook. */
-				break;
-			if (!prog->aux->attach_func_proto->type)
-				return 0;
-			break;
-		case BPF_PROG_TYPE_STRUCT_OPS:
-			if (!prog->aux->attach_func_proto->type)
-				return 0;
-
-			if (frame->in_exception_callback_fn)
-				break;
+		if (program_returns_void(env))
+			return 0;
+	}
 
-			/* Allow a struct_ops program to return a referenced kptr if it
-			 * matches the operator's return type and is in its unmodified
-			 * form. A scalar zero (i.e., a null pointer) is also allowed.
-			 */
-			reg_type = reg->btf ? btf_type_by_id(reg->btf, reg->btf_id) : NULL;
-			ret_type = btf_type_resolve_ptr(prog->aux->attach_btf,
-							prog->aux->attach_func_proto->type,
-							NULL);
-			if (ret_type && ret_type == reg_type && reg->ref_obj_id)
-				return __check_ptr_off_reg(env, reg, regno, false);
-			break;
-		default:
-			break;
-		}
+	if (!is_subprog && prog_type == BPF_PROG_TYPE_STRUCT_OPS) {
+		/* Allow a struct_ops program to return a referenced kptr if it
+		 * matches the operator's return type and is in its unmodified
+		 * form. A scalar zero (i.e., a null pointer) is also allowed.
+		 */
+		reg_type = reg->btf ? btf_type_by_id(reg->btf, reg->btf_id) : NULL;
+		ret_type = btf_type_resolve_ptr(prog->aux->attach_btf,
+						prog->aux->attach_func_proto->type,
+						NULL);
+		if (ret_type && ret_type == reg_type && reg->ref_obj_id)
+			return __check_ptr_off_reg(env, reg, regno, false);
 	}
 
 	/* eBPF calling convention is such that R0 is used
-- 
2.49.0

