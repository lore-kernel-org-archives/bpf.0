Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C3CA456DE2
	for <bpf@vger.kernel.org>; Mon,  7 Sep 2026 12:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788782476; cv=none; b=MPRowxM8CGtZorR+Or8pE4FsFvI4GR7aRZrHp3iZ/BWUruzn/LTkvnsaOLfXJuaPM6DxinoO79ym4/JFPiQ3KRJVx5UTQQ0LT7f3mNmXtpSraPEHRGNgtVtWkjY21jItXCmHg8kTxN/17ewM7tgFaBkMw/AzCTdbWu0LC5T+MGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788782476; c=relaxed/simple;
	bh=2mvaxqGopCRhkYAdDaBFx3PErCGUyuXy5ePpn4QaSbw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rgpoz3bjHDxNn8xtMiEyyHAwOdLh/BLB2JMn1aIMF355coLN0hDeQDrjfrW5fErAZ53CWfB4F7evuPTomvwf0FnIR2b1H8xvV6rJQTmWJPJDQyQlRxtfWRBwibkLZNDMssG2mnF59cyxrLZ5/UPK358uWBf+Sueq+WXFj69sfi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mOvI+cE8; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mOvI+cE8"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-39647184c73so4036187a91.1
        for <bpf@vger.kernel.org>; Mon, 07 Sep 2026 05:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788782474; x=1789387274; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bC1WWh/xuFVa+YUjJaTnVEkwteG3jK4MlszJkiclU94=;
        b=mOvI+cE8vfQEGFDbnaWVcoxUA+qU/LsF0vRjVeUkl/bbiqqdp/hMSJ/o34CUyryMGN
         r9hn0NX8w0vTNjNYWp44O+/oWz2yjK9/2ZJAu1mftI22FHrnR57aAVNt3AK2oz9HD5Zw
         5sEJA1cMpJPkUQ+dOAudUVvQgcXUFLWIYkmWVtzxGHPr6+tWmk+ykRlCJ7efJYdGzRzH
         tTEvlsLh34Kh45hEToHiqj8Uey/k2N412CWLCVau+oizS7kRB2d+TBQIAhqSBC6EyMbG
         2hL7skf6LSdvGMihSzydYR5+dGEFDOQmFIQ9h/LyWm86qLKKWlzNnwE3H2wD7mEPopb0
         j7Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788782474; x=1789387274;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bC1WWh/xuFVa+YUjJaTnVEkwteG3jK4MlszJkiclU94=;
        b=VtWF5qvEvnYGsIEPsvkZA7XvhcvNJTvcL9kin6iBOv5wH/XzdYZItZYwQvSSkNNlTQ
         SiWgwM7i5AZnKi0J+H9iB4uEjsPJWw4CHIeUpt2Sq1+A5nY7Ot9zzxE9E43kCnxjGoSc
         z09N0PY5iyInfou88Hv1f6vIo40UvrIkI2mCZBvXpM4UlO1hWOGuGjUadyS2m64QWDu9
         He1nXHp6+0pzr15FNs2rTCbvRORsCr3GGxKGs9mg2ybL/xV6z+bYQPnTB7+xrdYED8xq
         gAYxF2YmEbbl7lQJEKcLqOBe3Sr0loH0ILT/aQlG/8SDKMvtcOYid04HqiJiVgYjyCvU
         t4Ig==
X-Gm-Message-State: AFuF++nztqZ/Q5vEDjUrm/6EvHsUxt50/7vejT1QROe17nzh0o/lCwu5
	7jjR0eq5ClOSozonFNSf166gMY+ikILw4niKgvDSRmOjrrDTEAa52yrP
X-Gm-Gg: AYBFou1qSDHXULVk2UywRsDG0SPxY/ROYVHFF/L5lEo8/HxafCbnje8+NesIdyLUPnm
	gojL9gSapHyYN8cHZi/6jGsCnBhvuKC7rHCSWMAfRMiyFzWaxNyDEGqITH6DC3xFXjnYIppT2yq
	bc6T+6Yf8O16bso9I/jeGsqXHuQL+xOtF5a4cSUbtfNXw9+CRNMU6YgDUJXikumFScRDiEKYvGd
	DosgALd4egMOYHDKefWdQoZs5g8yptfjWnpSBn1/bsGmgCMBE6dOQ8mFdlUXvRFjkyQbpufoyug
	hRuPFWkHHvqipaAnmEf7LETtGTDws8gNbd1ir9iR9xlzu+uNnaQG82fTh85AYHzrOJfieJ0DzNh
	T7qVRD9z6LctEZ6aMk7UIh6nXsvffTHbhiYf5k1VzZX4tLXp5mxI7bsdN8a6bMboInSrtWpe734
	wR9ZnilTlZNYOVdC6t++KyQrP+bZUuPavReQssv77S4kDT0E/0svwB/qPmLEh2wBuMgxYLxXryf
	In4x5Nyb0KNy2p09wPxMvCB
X-Received: by 2002:a17:90b:5745:b0:396:669c:b5f6 with SMTP id 98e67ed59e1d1-39b0803accdmr31092584a91.12.1788782473281;
        Mon, 07 Sep 2026 05:01:13 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339885ca07sm31244462eec.1.2026.09.07.05.01.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 05:01:11 -0700 (PDT)
From: Hemanth Selam <hemanth.selam@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Russell King <linux@armlinux.org.uk>,
	Puranjay Mohan <puranjay@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Hari Bathini <hbathini@linux.ibm.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Naveen N Rao <naveen@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Shuah Khan <shuah@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>
Cc: bpf@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kselftest@vger.kernel.org,
	sparclinux@vger.kernel.org
Subject: [PATCH bpf-next v3 2/7] bpf: fix typos in comments
Date: Mon,  7 Sep 2026 17:30:38 +0530
Message-ID: <20260907120043.36894-3-hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260907120043.36894-1-hemanth.selam@gmail.com>
References: <20260907120043.36894-1-hemanth.selam@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix typos in comments, reported by scripts/checkpatch.pl using the
misspelling list in scripts/spelling.txt.  Only touches comments, no code
changes.

Assisted-by: Cursor:claude-opus-5
Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
---
 include/linux/filter.h       | 4 ++--
 kernel/bpf/reuseport_array.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/filter.h b/include/linux/filter.h
index 00ad8b63aa47..4eff6e601b05 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -147,7 +147,7 @@ struct ctl_table_header;
 #define BPF_ALU32_IMM(OP, DST, IMM)				\
 	BPF_ALU32_IMM_OFF(OP, DST, IMM, 0)
 
-/* Endianess conversion, cpu_to_{l,b}e(), {l,b}e_to_cpu() */
+/* Endianness conversion, cpu_to_{l,b}e(), {l,b}e_to_cpu() */
 
 #define BPF_ENDIAN(TYPE, DST, LEN)				\
 	((struct bpf_insn) {					\
@@ -1029,7 +1029,7 @@ static inline u8 *bpf_skb_cb(const struct sk_buff *skb)
 	 *
 	 * In some socket filter cases, the cb unfortunately needs to be
 	 * saved/restored so that protocol specific skb->cb[] data won't
-	 * be lost. In any case, due to unpriviledged eBPF programs
+	 * be lost. In any case, due to unprivileged eBPF programs
 	 * attached to sockets, we need to clear the bpf_skb_cb() area
 	 * to not leak previous contents to user space.
 	 */
diff --git a/kernel/bpf/reuseport_array.c b/kernel/bpf/reuseport_array.c
index 49b8e5a0c6b4..4de08abfd94e 100644
--- a/kernel/bpf/reuseport_array.c
+++ b/kernel/bpf/reuseport_array.c
@@ -207,7 +207,7 @@ reuseport_array_update_check(const struct reuseport_array *array,
 		return -ENOTSUPP;
 
 	/*
-	 * sk must be hashed (i.e. listening in the TCP case or binded
+	 * sk must be hashed (i.e. listening in the TCP case or bound
 	 * in the UDP case) and
 	 * it must also be a SO_REUSEPORT sk (i.e. reuse cannot be NULL).
 	 *
-- 
2.48.1

