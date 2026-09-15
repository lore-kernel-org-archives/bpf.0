Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BBDA4A4F03
	for <bpf@vger.kernel.org>; Tue, 15 Sep 2026 14:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789483875; cv=none; b=YxA+W07NgF8q98+1BeVajImolKBYAR9pSg9Q2JUs1JG6Kvm4mwuYNF26koDslvaqY8YS4i0ggLmZl4pRbaQniS62zkrDW22ZHWhU7j8ye55ZFVSs+/u0vqgrts25c0jK5t19sYXrOq7u79b28kVpg9UMfYJFCPWEY6UrXuvnCXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789483875; c=relaxed/simple;
	bh=4IT2KwzWfVxMfSYhvcaBFKufcenX1VP1rnwXymLuxH4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CN3U2lpNWU7nalrShmRpGpoDMoyb/TjrEBls4z4W20YjNeo2PIMg+9XQp2G/G9sNvfkb0qOSvnQ/oEG3PEqADX0vXX4Ii2tNjs923aJGVU67mav4mrogEa4vc03SFoJqHWjxXF7fqR9r/0scwiDdGJtBFBPoXNrDZC+7qAvWCYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TOiqbsAY; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TOiqbsAY"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-39b2ad83dc6so3408941a91.0
        for <bpf@vger.kernel.org>; Tue, 15 Sep 2026 07:51:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789483873; x=1790088673; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Wb3TKdq703tEhxs33o9glfZ3DKYR7T0XiEHb3yGj0U8=;
        b=TOiqbsAYHXSQxTYmYfkfH3Xy0iVSxlJcXDQHnLNl0CSoXg5+eVNmNWB8RYjuS9aLbO
         PksJy0r8Ub4vONQxA9lm8EqZLt9A8rET/Zrw6klgFm9UbC+f0wwsaHD4sVR/P7x9a/JB
         +xK+Oq3g6Tw6Bo2vamgPrS8XiQ4PvfpygCggKdZlmFeFEejiQtytIERx/3xbWoFOxREh
         dHFP0xLPJm8ZWwLW8BbH/bIslqrfXJHYE/w/UvwOtETPrssdvOnjN0cW0uxm9jAIuJ4Q
         zi+ZabPoQQxsH/RM7KSNXKEFTMXgSG9AgBSBQ/eCzlXrxN4cO+oQlj11IySHlU4apdXo
         mBtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789483873; x=1790088673;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Wb3TKdq703tEhxs33o9glfZ3DKYR7T0XiEHb3yGj0U8=;
        b=xZ3Co0cHdbAgH63QQtx60sHgmoMdZrVGRL0LErBZECEyygfQu0t0v5BscD9ulimyRm
         fONKofuo9H3OhDmKWiEcQJuyQeaMZwhPgFAzXasFo79JHBmgD9l6tatPc6hZfPmIydoP
         zuRIMaAX1+KczFeJQgJ4wxH8q5IVohoZsEByvMt/reVQFEs0xMd1gDIOZaHZ9lVbpqpc
         udZc/luWBl5+1ahNhaIHwaVraQt2UuTSwmGJd3pD/JSS1QFdCIjFvmU70+d2fGp0QKVo
         6qY0eJa8kwz5D79m9gBFBSyH4GP+YaAhYlB/nAlZczNqs7k9fr2wkONivw7gQZ1WqYSt
         MdxQ==
X-Gm-Message-State: AFuF++lR2Hui41spFg+J66uGD88upU0Jc+v+E46XGCaxeAK0Kds25X4A
	zHdWI/L9FNTDpD/R3a+B+M8U4mPb0Qk55j/9YuPT4VymUcCjVAdm8iy0
X-Gm-Gg: AYBFou3N8g7fX266tEpc6ocsNBJYFFwTIu3aChS6n6m3PaNDhnuwgJbr5m/YvXEWcAV
	ZnMFeeDWkkIofwNNISrX2ZiZJhyrV7rYecg0sbAGYtDFoUc1V4ZQ6VHWbGCn274HqiMvhuUwOcf
	pbC/4X6e/cjcIdxAFMNYqh45hSLjI7fkoxJF0R1dS3UQoekAMQCQgqwxPikwJenThZYKYCBBkuY
	5S/GermtZ6Trc6EyWdXDc156Pfn2IfUgH76VLib+lEBYLvQC22v/UN90tt958BvSKZ2BFFM2pAN
	xS/WzJqGtmrba5UZCYPdrkhZ5LFs10ORolJnKzom1wSU1RJj0ARs3+G7W1s0sI3MP4C338fkqpz
	Ijnh2l/ABHFGvlC16nsTuU8subtv9c3U5W+iDWvwGRfqm8Pj4tAuCnXyZD2A6HibbNp9TdGrRh9
	XteNzlIrAV/wVXtwZQhRzUXLJr6tBp9LrFdu01SX6Tt3mB2Ivo2OMMoCznqYpcwWUuxPLbL/vFD
	c/l/u0eZLdosFlqs7pKAopCRTpRSyqwTvKIIBZmoU+cuR4lpmmL0oS1Hw60j+lYNiCUnBycx7Ei
	hlULpBcoKX1q4sgWeHtb0J0x
X-Received: by 2002:a17:90b:1641:b0:39d:e54c:8643 with SMTP id 98e67ed59e1d1-39debfc9d8fmr14421860a91.11.1789483872685;
        Tue, 15 Sep 2026 07:51:12 -0700 (PDT)
Received: from archlinux ([2401:4900:8839:cf63:4168:b902:b940:3120])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39dfdcb6a7fsm5960026a91.3.2026.09.15.07.51.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 07:51:12 -0700 (PDT)
From: Madhav Khosla <madhav.khoslaa@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Stanislav Fomichev <sdf@fomichev.me>,
	=?UTF-8?q?Alexis=20Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
	Madhav Khosla <madhav.khoslaa@gmail.com>
Subject: [PATCH bpf] selftests/bpf: Fix csum_partial() dropping trailing byte on odd length
Date: Tue, 15 Sep 2026 20:20:54 +0530
Message-ID: <20260915145054.164857-1-madhav.khoslaa@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

csum_partial() computes num_u16 = len >> 1 and only sums that many
16-bit words, so the last byte of an odd-length buffer never gets
added to the checksum. RFC 1071 says it should be padded with a zero
byte and summed as one more word, not dropped.

This backs build_ip_csum(), build_udp_v4_csum() and
build_udp_v6_csum(), used by flow_dissector_classification.c and
xdp_metadata.c to hand-build packets. No current caller builds an
odd-length payload, so nothing fails today, but a future one would
get a silently wrong checksum.

Verified against a reference implementation for even/odd/boundary
lengths, and ran flow_dissector_classification and xdp_metadata under
vmtest.sh; both pass.

Fixes: f4504af68575 ("selftests/bpf: move ip checksum helper to network helpers")
Signed-off-by: Madhav Khosla <madhav.khoslaa@gmail.com>
---
 tools/testing/selftests/bpf/network_helpers.h | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/network_helpers.h b/tools/testing/selftests/bpf/network_helpers.h
index 75133119c04a..f6d28a2de788 100644
--- a/tools/testing/selftests/bpf/network_helpers.h
+++ b/tools/testing/selftests/bpf/network_helpers.h
@@ -129,12 +129,22 @@ static __u16 csum_fold(__u32 csum)
 
 static __wsum csum_partial(const void *buf, int len, __wsum sum)
 {
-	__u16 *p = (__u16 *)buf;
+	const __u8 *p = buf;
 	int num_u16 = len >> 1;
 	int i;
 
 	for (i = 0; i < num_u16; i++)
-		sum += p[i];
+		sum += ((const __u16 *)p)[i];
+
+	/* RFC 1071: an odd-length buffer's trailing byte is paired with
+	 * a zero pad byte to form the final 16-bit word.
+	 */
+	if (len & 1) {
+		__u16 tail = 0;
+
+		__builtin_memcpy(&tail, p + len - 1, 1);
+		sum += tail;
+	}
 
 	return sum;
 }
-- 
2.55.0

