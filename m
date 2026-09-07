Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 349F236C5B2
	for <bpf@vger.kernel.org>; Mon,  7 Sep 2026 04:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788756725; cv=none; b=r7ew1PaMezSRM0yjKhww1Rf2S5PlnrgNvgw/GdhPiLeDqW4n9FOjJzQm1Z/U/0NbHlpWOlYQZj7Qm8oz0omkfiRwwNbxP16k5SD5Bi3H+BGl3fO+0OQ3xxeAkS86mXnH9bWugHivr+AUeGLr13rI+yeC6PVIO1VYR+JT6drRkts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788756725; c=relaxed/simple;
	bh=o+i201PWKQhnh0LFP97eF7E1wnhN9oEPKnfB2knTOSM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hIdiVY+Pmh+p96toi6Gw+WRsxoGLUZY/E7VRUH1hjD5Fde2xihGfftMFVo31WeMv+5c+6XL7C8OIpyUd2XKzQyLScR3kBuETNxPV1lofajG++266tiCOljpiscLYMBY+U7sR4MiUPW3FdFSKdk/fxg7bv09C8kmLZdw2vtlqOu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fjYGNuHp; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fjYGNuHp"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-cc1cc97b84bso2317043a12.1
        for <bpf@vger.kernel.org>; Sun, 06 Sep 2026 21:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788756723; x=1789361523; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lk88M/pDZxe/5FAVj+dp68PIWOvqnCOJ0AD0p9smdgE=;
        b=fjYGNuHpkPlvyaOD9PVD685AcyPxbS9VVUIIzwb303/cC5yqyTCQFtk2m3//X0GeeL
         dFmSg4HMYoYSUSAJqCpYU9ed3rACAcEyLmY/E0BFfpnY0Ztlm2W09wvqsNNhbOs2ulrU
         vKewDyPuQDr9XuDGbCqfqhU6xG9MdVoVSOW/VzrVWCps4EqO19XiUYouRvAaC1Iza3Zv
         CGnTD4T9Q/eu68huaywUBrSwIhTwZr4zsqIb+4QIQt0DTJZFTJBWLwB0lPPa8p/iruaV
         H9pzNGI4jVt0XHyRs2U9Hl5eT/fL6KO7f9snYpkz33uHZBXqXSzmXpg+RHQ+hTP0mnwA
         wutg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788756723; x=1789361523;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lk88M/pDZxe/5FAVj+dp68PIWOvqnCOJ0AD0p9smdgE=;
        b=dC5Xa+aJwGvY49llqxfQ0HQv9CDrXIxVmPqmqY/Li4Uhv93akweH70BbZma/MdlQI8
         snF1LUZzXUOXcYYycgk8uENlXWoI5cDDTQIPQgJmGgrWyNM9MA4Cy1Pm5BgAOogu2mzq
         hWxKZqvaG8wodGotlcqZgB9VzaRUXdik03sFbtk32pinxGBxQPa+9RNvMSZgifWp0CjK
         F6tZpRAb+XIMTB05LOHFAi5diqLv/uSF6KJyeyWjogf6ISBW/Oro6Ihy4J7cPSwDIPBG
         y22mINqqcy/hAK1xP/Iv9szGOxs3EeHTuoAeqDFhRmpVVdOgM35uSjZq4j/iadP2UgNp
         HvSQ==
X-Gm-Message-State: AFuF++mPK4hgkweqoldznjXK3bxsu8hcU+l6tNQWOxJrcGZgn1Mg8mnN
	67d+hXlsqMUUQWvkIKHwRPqS3u84GllkERviK/gwNTBSjCAan3MdIW8M
X-Gm-Gg: AYBFou0Txc8dz3K4zA/lnUFS6CtUQsTLu9v8eJQpn14FLrVx76VAe4kuNz+Tb0brtQT
	XUaKIt5dG7kTV9Y7lCE4rhnOiKF3NcTFLlD4DM2vmK6tWbkAuGTrZ8DsnE/zsyVzAEVDSp8iAd3
	3rC/bzA85/z2GbkL+vlyWX3McfuFiQLfx7mzkzCKqvfn83Pg8dPN2DiQ6Lu27dZveH3zvMGbJav
	YjHNz2a9n1CehxjM7nsb9fPqkGueVDBkLOAs/+YMe60zWLeS+KNNEXnF0RKdaEOCH82GJheg2sn
	gNJJYZjy8ykuaLmv4U8pjjDELb9CwAsUxcOwNTHkE6p54s3sk0VWrW5dF0ZHoLIKrCy86ll36aA
	bW8sMxzxdcVW1HZoGSPjth+MgSsnCyyzRvfcdTtolwU0ll3CH0byq1Al0kwYLIBrFKGxyHuimVo
	rYKZuGYiniIEx48LRGNDfxqEER0TEXTHeexRBWp6pG/26Vg5AxRDx9Vt7VqgLn2F9O9R6zWLE3R
	1LYSbK3vG6xOA==
X-Received: by 2002:a17:90b:33c9:b0:398:c16e:69d3 with SMTP id 98e67ed59e1d1-39b26122fbamr28838386a91.1.1788756723030;
        Sun, 06 Sep 2026 21:52:03 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14324410092sm21979675c88.14.2026.09.06.21.51.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 21:52:02 -0700 (PDT)
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
	Christophe Leroy <chleroy@kernel.org>,
	Naveen N Rao <naveen@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Shuah Khan <shuah@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>
Cc: bpf@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-kselftest@vger.kernel.org,
	sparclinux@vger.kernel.org
Subject: [PATCH v2 2/7] bpf: fix typos in comments
Date: Mon,  7 Sep 2026 10:21:30 +0530
Message-ID: <20260907045135.13317-3-hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260907045135.13317-1-hemanth.selam@gmail.com>
References: <20260907045135.13317-1-hemanth.selam@gmail.com>
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
 kernel/bpf/stream.c          | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/filter.h b/include/linux/filter.h
index 4a9bc6a848f2..0a067c2e923d 100644
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
diff --git a/kernel/bpf/stream.c b/kernel/bpf/stream.c
index be9ce98e9469..54f5be1289d2 100644
--- a/kernel/bpf/stream.c
+++ b/kernel/bpf/stream.c
@@ -24,7 +24,7 @@ static struct bpf_stream_elem *bpf_stream_elem_alloc(int len)
 	/*
 	 * Length denotes the amount of data to be written as part of stream element,
 	 * thus includes '\0' byte. We're capped by how much bpf_bprintf_buffers can
-	 * accomodate, therefore deny allocations that won't fit into them.
+	 * accommodate, therefore deny allocations that won't fit into them.
 	 */
 	if (len < 0 || len > max_len)
 		return NULL;
