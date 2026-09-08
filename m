Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B593374E74
	for <bpf@vger.kernel.org>; Tue,  8 Sep 2026 05:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788846563; cv=none; b=tAKVdLrYD37O4LbF4GyN2i6ebfhHv01gqPK4meN0bU3fTo7eD/ATSDk47UYdAxN2MTXm7NcKy/kXuSjMj/aHHCiE7rPEDQ0hlpYpycIM8usgHC7wqh9GsnziL+j8DXGPzqHKPVo/EgRe2DyJlHt1/S8YPgeoU1qYkjLLneKbsUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788846563; c=relaxed/simple;
	bh=2mvaxqGopCRhkYAdDaBFx3PErCGUyuXy5ePpn4QaSbw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I3R2oZE+B7SPkSZlSBL3RgGpUQUOvPVw+OwATJnSEp+9UYoVjcPAYn9rhHNkSM7A5T50Cw9HgwgRFn8eMd5xGqJMY6VQbV1FCeXG74p9oM1B/O73nB8RnwFK8jHTemXhJXDD6HKWXRmj/D2anQPpFeA7U6SHTQxCMdIZHIWoL9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bQPplZog; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bQPplZog"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-cc1b838f9b6so4564674a12.3
        for <bpf@vger.kernel.org>; Mon, 07 Sep 2026 22:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788846562; x=1789451362; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bC1WWh/xuFVa+YUjJaTnVEkwteG3jK4MlszJkiclU94=;
        b=bQPplZogJaNm8UQYmqF/MtB5XSlev9/jaDUxPqmDSrwMDSV4orETekXkJQlyWCDTdk
         tAl7PRNN3VYdlnd8IkCCAeN2gnaqJ5VLKnRhtTXLPJSxIdCxkRo398a8J/ny+vrSRRJk
         xclYDB00pAjZIJ8PC2qb1iku0uNJc8KoF/ZM3jfrImmVdVBPclrhuEh8hW+xCrPH7f0I
         Cs9tvsuLNyhfizCipunMgaKe1t8Fed1wBsg73kjRYHHeJU54LcC883I1lAbsIpjdwCOR
         jnj7P1BgdSDTgP5YX9vIRtcNW31C8WPEo3nx2pGKPhLf2iqUCKwsV8hPLDdtCeWjsLWK
         T+Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788846562; x=1789451362;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bC1WWh/xuFVa+YUjJaTnVEkwteG3jK4MlszJkiclU94=;
        b=jUit9bWUrege6macpE+OxSozZIDJi7c+00R1MZEgVbA4ujLP5mg15L1aXAzGi0Q+71
         7Kmsjq+3eodHi9sROFaEugD6N8edbZ+HUkJ0aTrILYGQksL2YWcIbgk3aoiJBsjhLyWu
         iDrWxth26fWL8E+gzoZ1rxGd4ZbEd3Ekc7UZ0DiIwOAZevamoQ44qztJ8S0CXxlTOrtX
         k9Xfnx/NOS789QxKPHL50TB8k8UvNguoXDIfVLgzzMPhx/5QBBLdhfx7EiTKfjLxN/Ih
         u87lmMao2fS75cs4k1hpVjcS9yq8/Vcpt0dhS3d9meZY1l5s+PYf3T116FdsQIhROzo3
         cg0g==
X-Gm-Message-State: AFuF++llYGPOHw9bFrSxau7TKj2mj6e/GkMjwcEGiHAGIgYxMfCLvY0y
	ZnPCuA7fUtf2hDrJya1Gr04Np0ZDi1oXAYeSCjy1VY5XZcZ/D7/h0W2V
X-Gm-Gg: AYBFou2YwmFesqjz4iERfPqi8ACsm7HMt+3r06QXvO/hg5s5m+yvsB+HNAJzbmp5Pa2
	Vs6QxPX6Wy6JDpTVCOYJBMtrfm9BxD6SgBWgt9VADjMPYcgHzCd9606Q3UsVdYEGuxQw1hXa8KW
	xZXoDCP4tODYBWVQMmK4nw0JTv76tc+iPUT2A+tVkGQznTEfEniiKfxvNbxthiW0ADUNXTS9Bps
	AMLGVo3pStiP3DXzg9SzqwlcHMRUXwulApWIHEtzVWYO2fvpPRrTsKLaWHkwu/TOsdqq9Yg7Lq5
	zhWDPI+G6TNO6/yDCJbjCW1zTjbjvGQ7uXlWwu9PRsN3BIZpMptd/mdKzx38wlg6sbW6uwky/ko
	MCICXEUskSLbd3OKpNz3t+XFl31iTjm2qGSAoZlN45Hwv5kwX3iBHz9aO/3YV8JjeryhOuLV4wW
	+A3uVx5XlyZjJDVdpwNfoq6GF0y6gBGnwzNox9iP+3cfxAaZR0CSqbEtPs8AGqTnL69UgRYdzKs
	vmBpCrSoWL0LxZqE7P1Hfxb
X-Received: by 2002:a05:6a20:4393:b0:3d3:af66:9f61 with SMTP id adf61e73a8af0-3da3a16b389mr43628321637.27.1788846561929;
        Mon, 07 Sep 2026 22:49:21 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-334fbd5e6f6sm25690109eec.23.2026.09.07.22.49.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 22:49:21 -0700 (PDT)
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
Subject: [PATCH bpf-next v4 2/7] bpf: fix typos in comments
Date: Tue,  8 Sep 2026 11:18:48 +0530
Message-ID: <20260908054853.13820-3-hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260908054853.13820-1-hemanth.selam@gmail.com>
References: <20260908054853.13820-1-hemanth.selam@gmail.com>
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

