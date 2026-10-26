Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793032236;
	b=lXkd+jlFWQeq03PWFxYJdbzc4tP1t3LzbmDOIjv8jUbhhEnoRk2aDlK2SCy5xnGswFDz
	 3MWKZi4tuh9f9cb+cDAWS8zCxa0i85O1yKjA7QRNEaWOFtje4sJVFIreOl/Z48eE4oclu
	 OPllq9ON87C5+p9m4zjUh+xqsbtwYRVWjvZRdFR+VYkPO0OZRp1w1d9wnEsUirMCY1xFH
	 r+bM/IptEia1NnCmBm3qoWqKe88pn+22r6pVLSTYw2pjGS2KI5S+2oqNdIlLlLaIf1DP9
	 007prCPs7uYbxzcHxY7fJdxnLvlGORshQtZ860ELOxRjL0uF1mmrg3kF5zeHZWA1KZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793032236;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=WGd8hv6dQ0jpXHntVrEKsl2n+adOY8jZkAHXTXnqh7c=;
	b=0naAnepWqR3W7iWEyd7IZpLEwt8pnxRifb4I+Wi7tx3S+G1Xq8EkbuST2YKEoqsJ129q
	 5Zqx1XTcMz+JcFTGyaP7neknEScGtkLIE5ZAYyyWX/O4wKUaMawgYCA2VEUUJBfWS+gKT
	 oCBzSCfci1x/+3Lbdqflm0aGBjnpQpVJeKt5fJpCgrbgMl9T73lP/PE7RxzpDtpg4JcVc
	 TgBQi1kdEhuh2KzjL7H/C8U0+t7F9Xa+A8pK4tKepOzthIjPV+uS3O/lKFnP3HPNcS4G8
	 5IS5n3lmxFscqRmKNk0XFdoiNNMsZjBpQYb4HXA9md4e3L29WOvLMXuoc6utvEa3qVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=OWgrT87Q;
	arc=none smtp.remote-ip=74.125.82.178
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 254E0606AA36
	for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 16:30:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 254E0606AA36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=OWgrT87Q
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-35c76e9614aso5146622eec.0
        for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 09:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793032234; x=1793637034; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WGd8hv6dQ0jpXHntVrEKsl2n+adOY8jZkAHXTXnqh7c=;
        b=OWgrT87Qj/2zyW8smzZBl773SMPrPIzcvxCXye5uBT8QFVCCjI9Rok0yb22yySWm7Z
         XxKPx1VpKgrJr1Z9ev71PvTb8vFPBIiAiIBfFBPkCyV5KkbZiZfxLW1hrjRMlIoXXzQv
         Pi2jcEap2puXyNfA+70UuljWtojYba002F5ZqLUETRQBGKklcmM2NkLVq+uvOYvQxHH1
         FK25Og2Kk078DLTMCVWxJcKUk6lVI7qlVD3UJcaeKOEYhOscCtsRqlWx2eRPix3JrhTR
         m7vjPzGwMMuwHNDEd+a41fikRJO53eLxA5tTjkQJBnY2A1xWp+M5V7bzqk69179sGXSa
         gXLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793032234; x=1793637034;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=WGd8hv6dQ0jpXHntVrEKsl2n+adOY8jZkAHXTXnqh7c=;
        b=vSNnUmd9IVht4iCuux+mCqXyjebrLtbgMzQaZlAwzTDzHcHUPcGc8PPU/KVRZ/ha57
         buaiIrF49j2DkhkseK+ftFEMchH/4Xg5MXnSG4EJv5HFsJIf7Ygi1uKc3Q5dRYeEL+Ya
         gMHQXjJ51ooiGhJ0MasqAxIhbc3HmEXZ5VKqLmy627JalySxZBVIiHafBhNXXS0U3lp4
         22IJw3HwN0OruF+krxjHSkcGKslvbqig0AAuAnenuw5bk2RBwFVnivKgA5m4BQ9w62qS
         Jc0W+nOOKkw3qK0WKz2lRxQbWXqLudw8qcFVKb1N2nq2ns/xhyCXl6+yH1xXLP0dhHRr
         ywzw==
X-Gm-Message-State: AFq9FYIeB58PP4BQj1Oyu3JRDgoPtU96fk9NuUXljCmc9R4SRNCA1YPv
	RYHGZFoKeQrPhYCxUKhSqivZiXjYOCUj8HnBKgjX2oKFBaIpq/rFfVoOkhfozVhD7mg=
X-Gm-Gg: AYBFou16cKx3hLT8fxE+7kupVKgcxtQNbSBrv/X4qh8EbcWdBMze4XzmpRyeIA2uKif
	E/DJQIoLewK2uABUzdTZCH98MSpmeru9BDUPy1TnYoyUCD+XSEdZx2ke0ouuE4KzVSgp4IBxckg
	cXKVWOFh+jJ4Z6+EJChQqnWov/23jmM+BpnxycKiubssWLxYEh7VL4bdHz0LczVbB8aThkaltJg
	EKAhL38MLntmAQsmZ9HuBFqUSeCuSXLPGxm6fWw/kazyR2Uazcz8QK0Vtlh7y/TVw14WRMzfHni
	E4zdf+ALAwg188CihdpAV54J5iZ3FHDjechDX/KD9ORPcEBM7tKBeRlI56lGeuBHhF+iVqHk8OM
	ikbYIT0VztGGOEtu+csTougWaL+uPGUQpq/wNWf0YrnD7CWkbMxgkI1gclruZhZT2eM87GhYcNs
	jeDzvSEXgVB2q1Ed2bpICDVzAjnEuJk8ULCpKoR84xVIT46URCFVy/yXySXyIChI0y1+OIAK0sb
	iS14B2aEQOK/5/SOfcYzDj8JT57yhwgRcWop6+BsxuLyampUuKTVEGEAO/8Tyf5TxucAY6wczrw
	A9xyageudNWX/MSGTN6Q3xYoHSMuqpdKrQit7tenqisrAuOX+5QptkQZgT7tUOYP/cdsrhhgpio
	=
X-Received: by 2002:a05:7301:1530:b0:35e:da0a:75b0 with SMTP id 5a478bee46e88-369e84e94a7mr11024368eec.25.1793032233734;
        Mon, 26 Oct 2026 09:30:33 -0700 (PDT)
Received: from nixos ([2405:201:c40d:9039:f859:3f74:c064:3281])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369e8db7b23sm36119014eec.19.2026.10.26.09.30.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 09:30:32 -0700 (PDT)
From: Ayushman Rout <ayushmanrout27@gmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	Ayushman Rout <ayushmanrout27@gmail.com>,
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
	Shuah Khan <shuah@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH bpf v2 2/2] selftests/bpf: Test overlapping dynptr copies on xdp frags
Date: Mon, 26 Oct 2026 21:58:09 +0530
Message-ID: <20261026162810.12862-3-ayushmanrout27@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261026162810.12862-1-ayushmanrout27@gmail.com>
References: <20261026162810.12862-1-ayushmanrout27@gmail.com>
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

Add dynptr tests for copies within one xdp packet with frags, where the
source and the destination overlap and the destination is above the
source:

- test_dynptr_copy_xdp_overlap: both ranges cross from the linear part
  into frag0. bpf_dynptr_copy() of 1200 bytes with the destination 100
  bytes above the source.
- test_dynptr_copy_xdp_overlap_src_linear: the source is in the linear
  part and the destination crosses into frag0.
- test_dynptr_copy_xdp_overlap_dst_frag: the source crosses into frag0
  and the destination is in frag0.

The new tests set err when the data is wrong. The existing
test_dynptr_copy_xdp does not, so it can pass on corrupted data.

Without the fix to bpf_dynptr_copy(), test_dynptr_copy_xdp_overlap
fails. With it, all the new tests pass.

Signed-off-by: Ayushman Rout <ayushmanrout27@gmail.com>
---
 .../testing/selftests/bpf/prog_tests/dynptr.c |  3 +
 .../selftests/bpf/progs/dynptr_success.c      | 90 +++++++++++++++++++
 2 files changed, 93 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/dynptr.c b/tools/testing/selftests/bpf/prog_tests/dynptr.c
index 4396560365e8..cbb2cc9969be 100644
--- a/tools/testing/selftests/bpf/prog_tests/dynptr.c
+++ b/tools/testing/selftests/bpf/prog_tests/dynptr.c
@@ -22,6 +22,9 @@ static struct {
 	{"test_dynptr_data", SETUP_SYSCALL_SLEEP},
 	{"test_dynptr_copy", SETUP_SYSCALL_SLEEP},
 	{"test_dynptr_copy_xdp", SETUP_XDP_PROG},
+	{"test_dynptr_copy_xdp_overlap", SETUP_XDP_PROG},
+	{"test_dynptr_copy_xdp_overlap_src_linear", SETUP_XDP_PROG},
+	{"test_dynptr_copy_xdp_overlap_dst_frag", SETUP_XDP_PROG},
 	{"test_dynptr_memset_zero", SETUP_SYSCALL_SLEEP},
 	{"test_dynptr_memset_notzero", SETUP_SYSCALL_SLEEP},
 	{"test_dynptr_memset_zero_offset", SETUP_SYSCALL_SLEEP},
diff --git a/tools/testing/selftests/bpf/progs/dynptr_success.c b/tools/testing/selftests/bpf/progs/dynptr_success.c
index b668ebd61fc7..56be4eafc270 100644
--- a/tools/testing/selftests/bpf/progs/dynptr_success.c
+++ b/tools/testing/selftests/bpf/progs/dynptr_success.c
@@ -759,6 +759,96 @@ int test_dynptr_copy_xdp(struct xdp_md *xdp)
 	return XDP_DROP;
 }
 
+static __always_inline int fill_xdp(struct bpf_dynptr *ptr, __u32 start, __u32 n)
+{
+	__u8 b;
+	int i;
+
+	bpf_for(i, 0, n) {
+		b = (start + i) % 251;
+		if (bpf_dynptr_write(ptr, start + i, &b, 1, 0))
+			return 1;
+	}
+	return 0;
+}
+
+static __always_inline int check_xdp(struct bpf_dynptr *ptr, __u32 at, __u32 n, __u32 from)
+{
+	__u8 b;
+	int i;
+
+	bpf_for(i, 0, n) {
+		if (bpf_dynptr_read(&b, 1, ptr, at + i, 0))
+			return 1;
+		if (b != (__u8)((from + i) % 251))
+			return 1;
+	}
+	return 0;
+}
+
+SEC("?xdp")
+int test_dynptr_copy_xdp_overlap(struct xdp_md *xdp)
+{
+	void *data_end = (void *)(long)xdp->data_end;
+	void *data = (void *)(long)xdp->data;
+	__u32 off = data_end - data - 1000;
+	struct bpf_dynptr ptr;
+
+	bpf_dynptr_from_xdp(xdp, 0, &ptr);
+	if (fill_xdp(&ptr, off, 1300)) {
+		err = 1;
+		return XDP_DROP;
+	}
+	err = bpf_dynptr_copy(&ptr, off + 100, &ptr, off, 1200);
+	if (err)
+		return XDP_DROP;
+	if (check_xdp(&ptr, off + 100, 1200, off))
+		err = 2;
+	return XDP_DROP;
+}
+
+SEC("?xdp")
+int test_dynptr_copy_xdp_overlap_src_linear(struct xdp_md *xdp)
+{
+	void *data_end = (void *)(long)xdp->data_end;
+	void *data = (void *)(long)xdp->data;
+	__u32 lin = data_end - data;
+	struct bpf_dynptr ptr;
+
+	bpf_dynptr_from_xdp(xdp, 0, &ptr);
+	if (fill_xdp(&ptr, lin - 64, 118)) {
+		err = 1;
+		return XDP_DROP;
+	}
+	err = bpf_dynptr_copy(&ptr, lin - 10, &ptr, lin - 64, 64);
+	if (err)
+		return XDP_DROP;
+	if (check_xdp(&ptr, lin - 10, 64, lin - 64))
+		err = 2;
+	return XDP_DROP;
+}
+
+SEC("?xdp")
+int test_dynptr_copy_xdp_overlap_dst_frag(struct xdp_md *xdp)
+{
+	void *data_end = (void *)(long)xdp->data_end;
+	void *data = (void *)(long)xdp->data;
+	__u32 lin = data_end - data;
+	struct bpf_dynptr ptr;
+
+	bpf_dynptr_from_xdp(xdp, 0, &ptr);
+	if (fill_xdp(&ptr, lin - 10, 84)) {
+		err = 1;
+		return XDP_DROP;
+	}
+	err = bpf_dynptr_copy(&ptr, lin + 10, &ptr, lin - 10, 64);
+	if (err)
+		return XDP_DROP;
+	if (check_xdp(&ptr, lin + 10, 64, lin - 10))
+		err = 2;
+	return XDP_DROP;
+}
+
 char memset_zero_data[] = "data to be zeroed";
 
 SEC("?tp/syscalls/sys_enter_nanosleep")
-- 
2.54.0

