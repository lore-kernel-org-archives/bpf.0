Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794415609;
	b=y5D7nqA/dsNWAp7QrTNVevB/3oCrClE+59xS4TIR4JxhuCw24REN2m6DSZ46WosqXGjq
	 NtyXTMRfq7IRh89PIk75gYowxbNP9P8CPiyuaAPqp/s8FqsrwbdJuwi+j+bebTSHpXS+u
	 lLiTAk5pJDuP4cI/0q4XlODwzKy01lRFOVOq9kSGJ4QVfbSA97vtxeG0M9zz/v7W1NECA
	 DHOmDG+3vfEZ3TqwepItKdPbfymca2kIjm0sHST22cXWeRkDHdd4WxDosOVqDCX5NXIMv
	 PtOrWShWeSFS12YThAhSzHxVXzRgMIub6RpWmHCuBIWykoOSLmfbdVtv9ZLt33J6P9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794415609;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=+NBoOXcaos3ErxZvdIIKho9Gh/ViSTW2Pnfs6yLB/Sg=;
	b=NlsOHSueM7QrwXTzi6++mMAyPSikCWjpW43+6Qx7GSZxrKhIcb3mWiTlvWTd4NA/Ul+h
	 TnhkfQ1TvARDEp1wwBgtjzNpYXnHVfxRzWckJ4+kFGM+oMOZc0tRQ4SdBQpKLVUmnXgqb
	 ksXB7UE5RYyLDgUje0QPI79I91uKUQtenub5Ci9k2HytORA5JIEaFUEJspo30asB4U40E
	 6HShhu3Dg0pw3BAtmdOBBckTqcMKkBW8sxNm2H0HBznjJwZ2FIeopGYqe8DUOc9FOa/7d
	 RqfGyHM3OByiZJaI1IKlY7csUBkIh+6upjyP8hg6Wi0Cf6pni83FEXF630/qlqaBh7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QiFNmJdP;
	arc=none smtp.remote-ip=209.85.210.177
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4759D606A31C
	for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 16:46:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4759D606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QiFNmJdP
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-8b5efadd183so5786b3a.1
        for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 08:46:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794415608; x=1795020408; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+NBoOXcaos3ErxZvdIIKho9Gh/ViSTW2Pnfs6yLB/Sg=;
        b=QiFNmJdP972NVJJSqhzdxxbnnhQoKdLUu6vJzIUtiV6wnbyxX3zmzobWiKu+j3VLbg
         LbBLr7/NLejK4cQm9FdlyDn43k+e9fFzw8gcC3foYF7ZZ7uwtc3AngPj52rensSfsH7a
         LniQB53tNzot5w/eEXMV/HmH+ypiRrxncylr8G4xFBmGPpgAEUgYJLBFWjZdaj2+BRtS
         AZDy/yF7dCCGggA1DKxLfvE4xXEdYGzN4CGTmhtiA++U6zm7999CIXt+OII255LFbaNh
         Wsq47oM21ZJYFo/ONt+/fGTfBSYND62tvuCfmFtkU8w5LkhrCNRLOzBncksEld3SvXFc
         +ikQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794415608; x=1795020408;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+NBoOXcaos3ErxZvdIIKho9Gh/ViSTW2Pnfs6yLB/Sg=;
        b=lBMrVBN+RYbR9QJgyyFysZTMo8M+6JuVCQ+8WOZoPgJZ+F7KcyUXyOWqOWMddFBNFZ
         mFWaISf1V3E6/NIpU6VaQy8SU90IY2Fz+YYZxX1fmQ/RxXls2JncJvfYXYUzti4AuW90
         99+krL7ZoxqrSEWQ9GCLydwFThyR4nQYQmZ/Y3R+/kmZ1uKmgMskaHhOR7/ttg5PIXVf
         EfxoIECwYPtmqlBhYY/BnIJMOiMAKwdjrDDaRW1qbcTgQtKnvi1+Hr4Q4g57FrrYGMFa
         XeUym5zLQXb0xJ4HG7Vjhcqy5tESfHCKXha00VnpeRKDf4akOogHV+Oshh61n84akDZU
         Dydg==
X-Gm-Message-State: APuU4Z9myd0YqynHXl6ymgEN8xODDDLM8gtgm+L/V083jqiIRnRJymUA
	6MRqwwKkojP+XTHWwVwfCTGY8FFxLjKWZJ546UZCPtviuvRWYzmKbAi2rSTrsQ==
X-Gm-Gg: AYBFou2FzGYxLSE0CTVQgH+OBZ06Y8Jf8oQYLjr4WoeLfIUu1MV7mkFDjIB9A/WawQq
	XVCz0+lxOAPfDbfjm0TOXAxURPAEU/B/Nf7ZlQnVWUr2x3f02PtFV/H7EUrGDGAm8RiLPwFpYqZ
	aBUntTkw13j0SuJoPn4sFXTcvCpAZqDOHhwx4dYPA7ftjm27zHdjA89fgiIdoh/eH8O4smTaeAL
	cwp3QdZMoHL1XgKi1/Z5uf5YO/h8ohnVtoG04INHEXpNYDKPBcXFeHQ9/301hRry+dRvHkJIkQW
	04qzYipI+0jCLWSVEtTQ7iucs3eA8tDqNxx9YIX0azH3a3qwL9sQ5hl6um5mRDU1ID9knF75Sf3
	2EqMXqTtqwNkaTIGvmppd9H0g0C2IQ3wKgqp88AUQK1tzRkH0M6d73w3PpHo7w9qCc/jrQp2vZB
	+cjVQe9BypGLQBO3flVr5FgMY/wfZIVD2fI2LW4PBXxekQEVxB/9YMNFCRu8WEk2c+2oq0ktxl6
	GhgsJcTw9uw8l3YeEQh3YRV9tC0w+wfYiC72DVcYU/VeSFpxf26HfBe02vZe5CQxJGqe+L6EA1b
	+W+3bmsldOtH8a1QNTuxqJAVDEJMEDcMal3Dqnl1yK9YAF6yiGKLEKAmRWbboiSpaHGnFlAJ4Hz
	BzsTNqwoI35TZz35mrOuh42fe+GhMsQJ6VHZb9Dhu1T1+SoGxUr/wsZqey13P+//fG7wrhvB2fg
	==
X-Received: by 2002:a05:6a00:4612:b0:8a0:550f:bb43 with SMTP id d2e1a72fcca58-8ba98b4c716mr4820507b3a.34.1794415608345;
        Wed, 11 Nov 2026 08:46:48 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.252])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8baaae3da61sm2271369b3a.35.2026.11.11.08.46.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 08:46:47 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next v3 08/29] bpf: Mark the attr argument of bpf_sys_bpf() as MEM_WRITE
Date: Wed, 11 Nov 2026 16:45:31 +0000
Message-ID: <20261111164557.2659679-9-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261111164557.2659679-1-alexei.starovoitov@gmail.com>
References: <20261111164557.2659679-1-alexei.starovoitov@gmail.com>
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

A fix of the declaration of a helper. This series needs it: scalar
evolution keeps the expression of a stack slot across a call unless
bpf_may_write_mask() of the call has the slot, and liveness.c computes that
mask from the argument types of the helper.

  union bpf_attr attr = { .btf = .., .btf_size = .., .btf_log_level = 1 };

  bpf_sys_bpf(BPF_BTF_LOAD, &attr, sizeof(attr));

BPF_BTF_LOAD and BPF_PROG_LOAD store log_true_size into the attr of the
caller. When BPF_PROG_LOAD rejects func_info, line_info or core_relo
records that are larger than it knows, it stores the record size that it
expects. For the helper the attr is a kernel pointer, so
copy_to_bpfptr_offset() writes to the memory of the program.

arg2_type in struct bpf_func_proto bpf_sys_bpf_proto is
ARG_PTR_TO_MEM | MEM_RDONLY. So the verifier keeps what it knows about an
attr on the stack across the call: a slot that held 0 is taken for 0 after
it. bpf_may_write_mask() of the call does not have the slots of the attr.
And an attr in a map that the program cannot write to is accepted.

Say MEM_WRITE. An attr in read-only memory, such as
a 'static const union bpf_attr' in .rodata, is refused now:
"write into map forbidden".

Fixes: 37cce22dbd51 ("bpf: verifier: Refactor helper access type tracking")
Fixes: 216e3cd2f28d ("bpf: Add MEM_RDONLY for helper args that are pointers to rdonly mem.")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/syscall.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 9004f2673ccf..04a3b3c80c74 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -6692,7 +6692,7 @@ static const struct bpf_func_proto bpf_sys_bpf_proto = {
 	.might_sleep	= true,
 	.ret_type	= RET_INTEGER,
 	.arg1_type	= ARG_ANYTHING,
-	.arg2_type	= ARG_PTR_TO_MEM | MEM_RDONLY,
+	.arg2_type	= ARG_PTR_TO_MEM | MEM_WRITE,
 	.arg3_type	= ARG_MEM_SIZE,
 };
 
-- 
2.55.0

