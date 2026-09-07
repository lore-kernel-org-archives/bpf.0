Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E176371D01
	for <bpf@vger.kernel.org>; Mon,  7 Sep 2026 04:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788756717; cv=none; b=bu/DAL6J9d1acuXO2uQcd87wEUYBG+aR2CiUZTi/vfqxAoHh7XMyzaEnZ9aWmdKz1J/bcpg9sYnzfWXWCG87ycSB1TxTIL/cbVC8kUkwL7IKdnMpp7XDYGx0CMZ0lFGl6rCLzyf6mtBmJKi3OFg2Gc3BFJfoe9juwDl4CewJu04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788756717; c=relaxed/simple;
	bh=WGtOQOgtI5Fvi9gfpYR69VsJM+hCLeDnatkdn+Q2LKg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lv1aQ7kWHrzKChSVT3e0YccwxAJVUTG4FuHcPW5G8A1YiGSQP49Ip/LqJQH7kXShqelCmrrUA30vvqaUnTdRs55BCMkHBp654hWoeU2TV4udQ+qgVk/XcK555BjM9Qn5C1QcP+2YXAnbkuYurupJ76KV074a56ReZwstPBLk2y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nv4oxIpJ; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nv4oxIpJ"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-853e2610bb4so2713150b3a.0
        for <bpf@vger.kernel.org>; Sun, 06 Sep 2026 21:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788756714; x=1789361514; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6ZDdWvx8nd79EclYwIbserkqXBmdMeyV10TLzPxe1TU=;
        b=Nv4oxIpJPqU7YNEbfXW/xZzG+x3fDC9m/DF2QQuMVAEgxpLVHSDc48xc+kBPWgcDti
         F/T93U9NdBsOJsGBU3gpco28cLyeGbxd4kLT5KwV4c98jO3ijn0ISJeOJbw0ogQ0PxLp
         dLfOHJ1YF6vacdUlePjdlDpoRhy7vOnd/VgeiEA9W44gVQ+BbU1fIfshow7Tv16bwNHc
         tnvnsBCIhHaYrlyoGFvJYMUP591ZrF65wSLggcOrWF3flt30+ytafy8q3YCTBwDo2SBI
         uX8+S7FZ1SUSaW9hi+QZs0DiDBMGHJH15wjSy+VhAXlNiEkaX7Xwgf27uDZypajVmKgt
         XBJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788756714; x=1789361514;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6ZDdWvx8nd79EclYwIbserkqXBmdMeyV10TLzPxe1TU=;
        b=DqQGEf7jyYIPNET6VhoWrmay6hbMkHwwvAReWcCofdXFKPuENHTQoV3hUCSbDxUGgG
         fK4ZdUrpbs9rFy335QNVW+zh2cF13kA3V4FNc+KUX+Q36HVv94PPfMWpoUjapKLb/2F0
         ByGKmwxfWu0o+mTkNpf5IJUzwSs4Y5wJdMff24ibxhLaBe4qzde71B1Ezvm6Uxy8cuEV
         cHTcw4EfdOEY9sf4w5CXX82QsjeYfckdhLCb4MZl7WnKn5/Ft4AG5fZT4cbdYxBfaZyE
         sIyQRW8CboQeufoWbBSzTE+jesCGr4LM9fyuCFnwcQr9LM4wsdJ6yoOuo/SfRBJYUBR1
         Mx9w==
X-Gm-Message-State: AFuF++lhxmQ992nMRbRDv0kavX7RM9gYxVtsmmHSAQj07X02dRSBgQ6X
	Ow+DBIPsg2DB7sySsNdz5LFB+v/ce85OJBxh0PUqQq1wYrenF6/HZhf8
X-Gm-Gg: AYBFou1uY+eiGN+SAvCfjCiLLdevp1WCQfUhR5YDlBhBJX5+pr+gogp5Z1ZzjoWKPLH
	VHG0cCkC76vsAQnRyO4ndZ23YWS90FH8Dl//cfS6PInl7fLJWxOWPpysSH7EF5g2SsVJOinY1Er
	K9hw+DbpSWeYaLE7IlxP3bnVW8MrTL+j7IkpFXXQyflR9ayT3uMFfaLH8fatCtsPUkO+RHX7jfz
	wGLejdb+hZM7a63+hIz1sRLZSB9MBXkVBlOHv1Zk0Ka8WU4t20jH8/Mpd7XzakfuKpjwxlt2zme
	bj9yJC5ygxVaNTeIy+JumTykSFnQU1kEK+CZOa8UyVG/pVLdg3RcZTeK5Fph2jGHKHgWRSISGNo
	6H3PhCGznnMZHE1uKfIMmaoWsvIbMZT/nGat9MKUtN1PbyyxSaz2ZU2WzeiBu/Vm5jMnIe6RWdE
	lfug3Knz1AKHTxd+/M2G6MkOD6sBSFu0g+6HP/nPLKG0pZzOtRiJvgYEl0o46sYb2QhKMb3nluO
	orhNQjrkDTEQg==
X-Received: by 2002:a05:6a21:e082:b0:3d3:aed2:6f21 with SMTP id adf61e73a8af0-3da2160e09fmr24886058637.21.1788756714529;
        Sun, 06 Sep 2026 21:51:54 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14324410092sm21979675c88.14.2026.09.06.21.51.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 21:51:54 -0700 (PDT)
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
Subject: [PATCH v2 1/7] ARM: net: fix typo "arithmatic" in comment
Date: Mon,  7 Sep 2026 10:21:29 +0530
Message-ID: <20260907045135.13317-2-hemanth.selam@gmail.com>
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

Correct "arithmatic" to "Arithmetic", reported by scripts/checkpatch.pl
using the misspelling list in scripts/spelling.txt.  Only touches comments,
no code changes.

Assisted-by: Cursor:claude-opus-5
Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
---
 arch/arm/net/bpf_jit_32.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/net/bpf_jit_32.c b/arch/arm/net/bpf_jit_32.c
index 9ede81afbc50..b1c21c014c9c 100644
--- a/arch/arm/net/bpf_jit_32.c
+++ b/arch/arm/net/bpf_jit_32.c
@@ -1346,7 +1346,7 @@ static inline void emit_ldsx_r(const s8 dst[], const s8 src,
 	arm_bpf_put_reg64(dst, rd, ctx);
 }
 
-/* Arithmatic Operation */
+/* Arithmetic Operation */
 static inline void emit_ar_r(const u8 rd, const u8 rt, const u8 rm,
 			     const u8 rn, struct jit_ctx *ctx, u8 op,
 			     bool is_jmp64) {
