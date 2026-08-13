Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA01C4457A3
	for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 21:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786655805; cv=none; b=REkOMkW3pvmyIbX07sLCvR13LXPlq7c8l/9PFkxrUXZBs7WGtp54HadGXlMJzUUWtPt7bjDRrFghLA03NiVT/K4bPids4M1sUdjB88bb+Vx6KWkMTvQM7e8PtRKzbCu9Aug2nf/S6UZ3p3RfzzqM7LYnB2VHGgomRwz0hzIseLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786655805; c=relaxed/simple;
	bh=YI6nSUoGi0iWVXo8QuXc1GyKW5TZx4UEiyEf8E+2JhQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RAINiDxvqbnv62SOXREbDL7AQsdYKgZ3pKNk14ZFuw56BVuON1eJaYAFWO6RijD0E/p3YQsTs2NUug6vjB6AQmH0l6x+E9ZhWAdn6ZJJfkbjR0VkBqmf5ZaJ9Np+BHRiCnkUkH+PRMx16WNYiQUY2AIP3MQFgguqm4ADx2TAjIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pAf5cS2B; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pAf5cS2B"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-38e42560ebcso297130a91.1
        for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 14:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786655789; x=1787260589; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FMLot0g5Zyb+UKRiaCOHwz95HCsQzvZPkHit+OYwsqU=;
        b=pAf5cS2Bp8KYI30RHzN68OqHlIOojFRrqnGyqRMtlTUABZeTiZhTRtfmR6ZZbwQS7N
         EgUm6xNZPsNUwMMVHwSUMZ8jL1c8UxIUFfP0OgBnGTavbrhBokDeUE6Q1gRhr+tNascj
         4b1jbTNm3h33c9hmZ4NU5AQAK4dT+6aFnv2Zz34BYfFArqH08sED6acF/5v2bIC3c1XI
         LneuJXOR2T2ljAhJTNu37s7WPrcWQEWvquxi3nZWMch4Ko2XtxpZGONvun526c/y0yXZ
         rpBjXXfSSGDOHY2zAt86LCsEno1yVnMiGxOO7Dx9CDiY8KQrEg/Bt1Lg9gFDHmX4w2tN
         TNBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786655789; x=1787260589;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=FMLot0g5Zyb+UKRiaCOHwz95HCsQzvZPkHit+OYwsqU=;
        b=LRcJaqbfmWdy2YZT0C4dERicWSk4C6V9CsUFRPwNAbg5QYTfGRJlyVh5TLSxjvgVBc
         E3W67obvHG7anN9v18Vb4UfvgqVPFhRE+Nrjtrjw66n3XtffSXzQK72SDR+/qCpCN4Ny
         fQEgUNUFnmQTcRQVFmGo5QkntfTmKwgxgBjmsHpJNaTToIBSKsykMXSgBvLEK1gJis7K
         OzFVkEH3hjErH5yPlDa3yE/R1pcI/uC02/ltZrsST+54sqTQCr8YFv7u14MFl7Rk4ceA
         p+fV9FWzimElh+rGi3EyFswsyMJ1Dd7jeMeyUAm8tzZTp0RVL2qpNumb6uz4gmXWS3U9
         vrwQ==
X-Gm-Message-State: AOJu0Yw9Gexu/zmiIREqMBuMeaKM8iX0bDpmSIo3v6krA/LjUWAnZvJl
	vm8dsAo1I/CH9wuEz1Jh4UZPiK1Xt6p78Sy95sboB7GgzQNUxCVnuO8juIY63A==
X-Gm-Gg: AR+sD126A1sPp0VJARp+z9FdLMXUFDdVLZbWwdQ0FgfRK83WmXfaukvQlSnZxqD9epX
	n44nuWwXGR1RV4wkKoYEvpZZ/LbYhXQX4HfBFpZZ2UKdVPJZGB2K38KCFfEaIVExQNZQpbNhnDr
	4ZjPZrZFAFTgG/MWWUKPAVeaEgJSVrApAgc/aYN0+lc1bE5otiO18ZKHIXo3mgOYwxvLz68UhJs
	3ib1iEddq5tEntmqWzPnUEWzlHde4+RpCWOvCS6WJ1xy1LV5dWIZNOUfmq+Tu9pfbVd3WSTnCI3
	ed1Cs2FhttWE/xxVhZFCbF620fflbi/mOEraxd12B7UyfKQCeJSGKE0VfoKbb10C4JmJITKCAVa
	Pn/QJc+JMntgCtZGEZHRiFi7vuOp5H9SAxs3Ki5qEztl+cUbMVSS2/TWKQt97uNKs37HDzp9fkK
	D9vQWi/namQmkOnZMLa+NVOZK47ZpWgCP855xd2RGNIps3upFTz23Tub2JQPZdQ+twv6qD3lh6E
	zbguc2Q/fyQ0qc9
X-Received: by 2002:a17:90b:3d45:b0:37f:fd1f:d30f with SMTP id 98e67ed59e1d1-3933b9157eemr889344a91.12.1786655788490;
        Thu, 13 Aug 2026 14:16:28 -0700 (PDT)
Received: from patterson.cs.ubc.ca (patterson.cs.ubc.ca. [198.162.52.65])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3933a03e288sm853985a91.17.2026.08.13.14.16.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 14:16:28 -0700 (PDT)
From: Ning Ding <dingning04@gmail.com>
To: bpf@vger.kernel.org
Cc: memxor@gmail.com,
	greg@kroah.com,
	dingning04@gmail.com,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Dave Marchevsky <davemarchevsky@fb.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v4 1/4] bpf: Keep refcount_acquire nullable for borrowed RCU kptrs
Date: Thu, 13 Aug 2026 14:15:23 -0700
Message-ID: <20260813211533.290256-2-dingning04@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260813211533.290256-1-dingning04@gmail.com>
References: <20260813211533.290256-1-dingning04@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The verifier can mistake an RCU-loaded map kptr for an owned reference and
assume bpf_refcount_acquire() cannot return NULL. The kfunc uses
refcount_inc_not_zero(), so it can return NULL after the last reference is
dropped. Passing that unchecked result to bpf_obj_drop() can crash the
kernel.

Only treat the argument as owned when the verifier tracks an acquired
reference for it. Borrowed pointers remain nullable, while owned pointers
keep the existing behavior.

Fixes: 1b12171533a9 ("bpf: Mark direct ld of stashed bpf_{rb,list}_node as non-owning ref")
Assisted-by: Codex:gpt-5.5
Assisted-by: ChatGPT:GPT-5.6-Thinking
Signed-off-by: Ning Ding <dingning04@gmail.com>
---
 kernel/bpf/verifier.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 6ac1afced20b..bc021c8c8fbf 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -12482,7 +12482,7 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_call_arg_me
 					reg_arg_name(env, argno));
 				return -EINVAL;
 			}
-			if (!type_is_non_owning_ref(reg->type))
+			if (!type_is_non_owning_ref(reg->type) && reg_is_referenced(env, reg))
 				meta->arg_owning_ref = true;
 
 			rec = reg_btf_record(reg);
-- 
2.43.0

