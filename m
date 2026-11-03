Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793747992;
	b=vBGA0BpF8bXLWHkTYS3fSDrPkbb9y3hTWGEAhp9W+fWU7uR3+rXBQx2HT3XjZEA+W+Qz
	 ZtvqQ13Qo02fvepDS8TFOT6dPCWPCsh6jWffuXJcjf9w52f7Lugcyo3pBjk8WAUcCDx6Z
	 516PQEGlUJNuaFbLXsJlc51eBcEd885nTVsodLE2qb4rHaEsEVAoAQ5AigHEpyP9I4AQM
	 UIlcf+dU60qo0iEq2MWyNtZRwbqfk+cxUwMLdMKQJzF685f4XcDQ05IOUUwyKy9YV08dr
	 5/P74auwy+jI08+/sgv6rsNFmDpzPMYPZ2+kg0ScTnPVytkyWuQCh5GQ5eonuivNKbQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793747992;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=UfRCiMgnfNhGgqSDexVP9+GNXf63n1hqXD0AsFsElx8=;
	b=O5fB7qebPVq9fWrX+sZPXhPtyGUrgQfBoupRCjILB4m9VcDny9Vy/Hx88M3zo8Ep354R
	 GaRBSveOvUY/GwUeQS0Avf1cRFJxV9phPj4NAkuqrDQQOd/9y0ISiB+Dv55bWlgwF0z+S
	 ltzhLlSWpctWxo764hvXHevo4ezlGLJzlww1t78xhhGk7dzQtLC7ZTa8rWtQi41x3YNBf
	 x513aNWbJ6WHHa/cCSLAMZThOWuRtbr5H9yOTZ6CxNYpZyrJXEVtVy0SHH21ssS9fP7fH
	 Zsj9aYM0dFk1q22TTnkkbxNqPKUfju0upcA8W/rXsJX5eUMguaDepwUaTk09WngXwNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gOj0oxMX;
	arc=none smtp.remote-ip=209.85.215.169
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED0F606A336
	for <bpf@vger.kernel.org>; Tue,  3 Nov 2026 23:19:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0ED0F606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gOj0oxMX
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-cdb2e0062bbso56889a12.1
        for <bpf@vger.kernel.org>; Tue, 03 Nov 2026 15:19:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793747991; x=1794352791; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UfRCiMgnfNhGgqSDexVP9+GNXf63n1hqXD0AsFsElx8=;
        b=gOj0oxMXseYVIKzUp4AUvup/8uljDpyN0bCac62Tga3fa1r3Ey1NfjSFyp2HzB6JZf
         PHfJ93tlrNSwj8phDKAdDb95/6mLVeweS9axOGyhUC65U7+CoNt5YsxaG7qtAX4BRDWa
         FW9IPlFB7YrfKKgl8DKwtQEiUtlSqQULY+E6ZUEO8AxxWFrsCKgpWckivlZaVAKoZ4Zv
         icvYh6qGBjbYLzoq7JU7xOgoYqR5X4vp++hvlCGjvO8TOcx0AlRkvBwQDYQoQ/spKgI7
         /4aOYsssAQMxHBcCLKAO7LFjRXtFGdcy1+5M2rB0FyffaxqErKwpSf7bcyO2JhhwtbU6
         uH6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793747991; x=1794352791;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=UfRCiMgnfNhGgqSDexVP9+GNXf63n1hqXD0AsFsElx8=;
        b=Q9/f9imiCEam2SCxSAVtIMztK8n5GEHYJ2hsp63hVruNmYpCPqB9wne+UTp8Xq4oL6
         G0nuchos9NYMGskWbR1TBbuHNjpfFMwYcmM0AWaocglzWsYHFgkvbRxexqoqQBuKsqM2
         1t6Klm8R55UuNAxjTkFHd2gPFVOb5kCKXJzfabo5K8FTdjaNTQpPTkCwlGvn5pLak+Xa
         WzTMJAjXxpxkNyFDr8ZOTSt0YvmvvsEgwotWy5B7oI+NWR+RAnbMlr/9bhHTXZ8J+N54
         yl8hBB39SHi9CfXhs0k9DhKkodESdy67vj5hqnFdrcI83HgUsQcStJZ395dxc3ZRGdnO
         PeVg==
X-Gm-Message-State: APuU4Z8kzMEauRz1l5ax8PCTW6sDY9abMRt2fVVx+dZ+zg9uIkCA6I9G
	dCPMjW8ViNRe3+dAhJ2EeYThq7c5Mv1SOc1AQQBCIqO4R6GpuqUZWQhw990Kpg==
X-Gm-Gg: AYBFou0AX8sr9xiCU3rDESbsVl6vmjGKRNVRRIm3b04LBWMDFHdT6Huy2kv+LCPWvGF
	xlkmQH9dEXoJWTxGWNj7hEBpMoez/CUkgk4CKo4Y0ocSYaJCvOsZHMPWQYLxRyPBZ6rtbd7rgAs
	rk9rczN2Y1E3aOEXtwZxQ8Va+vO/mToB5Dbomrs6jC+GMAo+FKYjmC2sMDre/3iOGxvHfgc8oBy
	vu2HY22QTEKq27mi0gqSu+sl3jkxreD1h2UPucpT4SzJZR3zkqDdcdMRVeganOrkynd1Z7JhcoG
	7QunnXntjbD0pyvYr6fUHotoiVjZ4UFuSXhAG2zghjMDmxzCNREPfObl8ABHMOIvQ5WZ1Y766y8
	ih1K947t1bj8jEVQRarsXIR+7ygMpjC1aUzxD0UVN3Vgki+YS9WCxJBC+H27nj6rT29kRs0+/rv
	MkExaZRbKO7C1a9QyD9+0/1tg9alX/0LSGE4igZhyNoeqORTu3k21o5E3MwM0K6ikhFj86/Q42R
	uUPwm7QllXunHDJFg0LcwDdAjQ/KFZyls+4Cjrq7LDTkvXd0sltmmRlpSCFiYtFp6I0uj/si4u7
	TG9bldsZZcLU/5gmL78Fj6X1Y1I3BoSd5ij4J5K/Q8rfoES4wdoZcGajioDtnclq3CW9wARozTK
	77WJn49jeE5ULdcZf8i3Bdov9ZyFViHdbEQ1Vxpke/eShuEZUAJrYcXdhuZjiIA8/1hy8vYiHFw
	==
X-Received: by 2002:a17:90a:d2ce:b0:3ab:884b:659e with SMTP id 98e67ed59e1d1-3ae896f825bmr11911918a91.9.1793747991304;
        Tue, 03 Nov 2026 15:19:51 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.254])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0969eeacdsm287773a91.4.2026.11.03.15.19.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 15:19:50 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 3/3] selftests/bpf: Test a load from a tagged user address
Date: Tue,  3 Nov 2026 23:19:31 +0000
Message-ID: <20261103231931.89739-4-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261103231931.89739-1-alexei.starovoitov@gmail.com>
References: <20261103231931.89739-1-alexei.starovoitov@gmail.com>
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

arm64 ignores the top byte of a user address. Check that a BPF_PROBE_MEM
load from a mapped user address with a tag in the top byte reads zero.

Use a syscall prog. It runs in process context with page faults enabled,
so the fault handler doesn't fix up the load before it looks at the
address.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 .../selftests/bpf/progs/mem_rdonly_untrusted.c   | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/mem_rdonly_untrusted.c b/tools/testing/selftests/bpf/progs/mem_rdonly_untrusted.c
index 23019023511a..b5cf85e2a19a 100644
--- a/tools/testing/selftests/bpf/progs/mem_rdonly_untrusted.c
+++ b/tools/testing/selftests/bpf/progs/mem_rdonly_untrusted.c
@@ -51,6 +51,22 @@ int ldx_is_ok_bad_addr(void *ctx)
 	return p[0x7fff];
 }
 
+SEC("syscall")
+__success
+__retval(0)
+int ldx_is_ok_tagged_user_addr(void *ctx)
+{
+	struct task_struct *task = bpf_get_current_task_btf();
+	char *p;
+
+	if (!bpf_core_enum_value_exists(enum bpf_features, BPF_FEAT_RDONLY_CAST_TO_VOID))
+		return 42;
+
+	/* arm64 ignores the top byte of a user address */
+	p = bpf_rdonly_cast((void *)(task->mm->arg_start | 1ul << 60), 0);
+	return *p;
+}
+
 SEC("socket")
 __success
 __retval(1)
-- 
2.55.0

