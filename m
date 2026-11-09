Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794243304;
	b=H9H/Rr89xveuN5bPgyTO7iqaECvmx3Ve4FejKeNCTQtlBM60JGQiU0wQU+F9i7orEUAg
	 P8y60R9UkPhU5fkzg1UD/nZ3UY0wv/xS+dEdnn34Ul/mZnWXEoGmuqBPz7Yde6ZtgIOwC
	 6m4g/aQLa3sMh5ucFKRyVMwUAX+unP2uImHIrIHeQbnl7VEiwvpJqFwRSh1bZFP89RdA+
	 IvJVWjRNL4rP5Mcu5uHvMsQ7gpR9FlHX/kR/fWzmAnUjcXTOhZo0C7bxkouoHVaO/7p7I
	 N+sRTJunNSM5+HYNfsfHhsCOkNfp/iwjsWbMZj3nK5tmmupCNnJhulZIyQn5AxeFSVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794243304;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=NiYqsbiEHPYukFA61TqPRmCuyZ7fxceskxzXhkevg7c=;
	b=KGHX2LguHW0JXz0Wl5Lr1nyWCkmlg4ynjx12WzncgX/LSbcAUDtqrG9xn53nbV6+riJ1
	 Do8rOCd7sxrlndAVOOraolsV/eyW7I3V6ZIO/4Y90+vEmYXsYGWBHiK+YOlf778mF3NLF
	 awSGKTqDULHwjpBQ6a+9RzwwUiqsZeeou3ymCXvOvdyuRw3R0zYtwMzjQoXpDer04BxPL
	 rwmXuAfvaG3tqSDwGEUJoUFbmYy2dR8MVGynT+LxRJ2pMQOpVOTLygVM+QDWm09LhjjNf
	 Fx+ISZuPgxVJKgvhDe8+5OD15/nKQJ+Z9qIl4dpwkNpJJ4nKv1Lk7TVfVzCSO4jot7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kaMcoPJ3;
	arc=none smtp.remote-ip=209.85.221.52
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E2B160A2609
	for <bpf@vger.kernel.org>; Mon,  9 Nov 2026 16:55:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6E2B160A2609
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kaMcoPJ3
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-49412eb1474so742764f8f.3
        for <bpf@vger.kernel.org>; Mon, 09 Nov 2026 08:55:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794243302; x=1794848102; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NiYqsbiEHPYukFA61TqPRmCuyZ7fxceskxzXhkevg7c=;
        b=kaMcoPJ3K4GQeci9A0VDvbzj3TGlRVR0mYBeFV/Mv7qd2BQxpWKuR9L1cgIt+r/8c6
         0+iO9+zCk+iPnrzB75aB97716/tz6jUN5f7YKTps2fzF2g0ila8vOWWK6bPaX8wDBWuR
         3yD3sI0l+LVDdXSpsZwPMYEcp86YVHH4XoGPW0Zqeg+LkjmqEQPwpgO0fgmPFJqX0cyf
         AJfQeepPT6HdWkRA4erxv6QNScSGcop/aal3rCEg2H6mhAtqsvssTfUcMgwoN9fN0AoT
         D1KRf4Djg9nUSz3fDuYRq0l6KC4oe0yURx7trXi+ceFGZpuo0Ilbd2L0yVZtZeeXGcMk
         ErnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794243302; x=1794848102;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NiYqsbiEHPYukFA61TqPRmCuyZ7fxceskxzXhkevg7c=;
        b=AUk7B4l8Ms3f5iOS5EU+VUjGmcRG0Cc7lNlFegeD2lpaLGqpvWSs7vZIYYug8OW/YB
         r0cJQXIEYwlPJCoMFiIgPGysuEU+s0LdywDLJ7wAziBr0mHfQRuqMzV+pUOY/WWNg0X0
         m1aJ86oaWayRDFLekFasgF9fnn/04Ypxm9RJin3Us5i7ZO5DpbkcjWrtvOEkxIX8/oOJ
         uUaWhmCyl8KQhIrfT8YEgSgrJwaluxTPUXuZF2idg2LC3z4e3wEMKWbGIUIRjAQFlZgg
         OE7I1PC+AOdlByH0/bgi+fLx+9W1FtXggdtjM7tOL9bNbQU+Rc1zUJ9vvWfB4YcjDGwZ
         1ssw==
X-Forwarded-Encrypted: i=1; AL+hErFNNLC6W25nQf/vILTuJftLYxUL31BteC21L5ZmJvDmcZh9/44lWeFLGkxrIvfTxjhqoos=@vger.kernel.org
X-Gm-Message-State: APuU4Z+h5d935IB1IwzKwgN5Clrh7ni0UjGvTuFIdKDnbMm5QSu9BKGo
	enaeQeX2/DK2yANreIDJ4HjJAALJIuQh80xLpePrJ5dV1AW+3y4fwkIc
X-Gm-Gg: AYBFou1Wlz+V80CY0riAllLnZb1HZurUdxR+aorztJ/VPTRMDDB7Pdbl1y6KxoK0gsc
	5pqNF2oA8Ig/CfQySGT7sOufHAPKxUrQm+vMmokNvF0YLxDuLaf5gUtmpw1tBH/XBdOm41o7IUz
	/HwbFE3ZJvcNPtV+f1tdvGH9XNiE+c3Yh1QwWGREXKrMjMsWBsrNfF2ZtCBrErPCpeHEOagmD96
	Tuuzy2DmrAESuRNPWQmvm4LpQzshK4Y118ZzLb0Lb29jT7usj5cjsPtsPsiUd3WBrkeAmnVL/wS
	TXiXV8xSdwPmnnexPHBVE5ObTp5wXs0TKx0Qt49cQuwPrH9ZzXui83yDCvck2NoXWLI/+FR3NhW
	AJbhF5+MbX0zPYalGTZNxNJ7y8YLXnXy5lbjp913cTxnO3T7a8f4o8JtSodN5zfONa1YASg6n10
	caqbRoHAh0koixBvjLIKVkKrj4/tOPT1ginF6GtGDYKui3U0ktr/o/RwUk8Ot2NqPuHrp9QhD+b
	pgeLvSmTyBFdK7EviBx9+ergyv7ojdWcPNoi3aB72v9KcT6SXYnJYwH4mD9crtHsxWzLdVxyAkV
	YlTqgy8/GuVc5BoUR21YzjcsBf0JMiNCyjG61XtCpMpdV9U=
X-Received: by 2002:a05:6000:1849:b0:48e:bf0:352 with SMTP id ffacd0b85a97d-4982c2d03a2mr129328f8f.5.1794243302412;
        Mon, 09 Nov 2026 08:55:02 -0800 (PST)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4959783fd04sm11392369f8f.47.2026.11.09.08.55.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 08:55:01 -0800 (PST)
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Alan Maguire <almagui@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Quentin Monnet <qmo@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	KP Singh <kpsingh@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Sasha Levin <sashal@kernel.org>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Anton Protopopov <a.s.protopopov@gmail.com>
Subject: [PATCH v2 bpf-next 12/18] bpf: Follow integer casts in bpf_scan_ir
Date: Mon,  9 Nov 2026 17:05:32 +0000
Message-ID: <20261109170550.141443-13-a.s.protopopov@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261109170550.141443-1-a.s.protopopov@gmail.com>
References: <20261109170550.141443-1-a.s.protopopov@gmail.com>
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

Follow sign extensions and truncations between integers of at least 32
bits in the block of the return. They keep an error, for example an int
error which a function returns as long.

Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
---
 scripts/llvm-plugins/bpf_scan_ir.cpp | 28 +++++++++++++++++++++++++---
 1 file changed, 25 insertions(+), 3 deletions(-)

diff --git a/scripts/llvm-plugins/bpf_scan_ir.cpp b/scripts/llvm-plugins/bpf_scan_ir.cpp
index 81de8f941568..a3c6336662fc 100644
--- a/scripts/llvm-plugins/bpf_scan_ir.cpp
+++ b/scripts/llvm-plugins/bpf_scan_ir.cpp
@@ -82,17 +82,39 @@ static bool errnoConstant(const Value *V, int64_t &N)
 	return N >= -MaxErrno && N < 0;
 }
 
+/* A sign extension or a truncation between integers of at least 32 bits */
+static bool preservesErrnoCast(const CastInst *Cast)
+{
+	Type *Src = Cast->getSrcTy(), *Dst = Cast->getDestTy();
+
+	if (Src->isIntegerTy() && Dst->isIntegerTy())
+		return (Cast->getOpcode() == Instruction::SExt ||
+			Cast->getOpcode() == Instruction::Trunc) &&
+		       Src->getIntegerBitWidth() >= 32 && Dst->getIntegerBitWidth() >= 32;
+	return false;
+}
+
 /*
  * Add the errors which V, the value returned in RET, is known to be on the
- * edges to RET from CLEANBBS to VALUES. V may be a PHI in RET. A PHI in an
- * earlier block is not followed: a later branch may split its values between
- * clean and dirty paths.
+ * edges to RET from CLEANBBS to VALUES. Follow the casts in RET which keep the
+ * error to a PHI in RET. A PHI in an earlier block is not followed: a later
+ * branch may split its values between clean and dirty paths.
  */
 static void collectErrnos(Value *V, BasicBlock *Ret, LazyValueInfo &LVI,
 			  const SmallPtrSetImpl<BasicBlock *> &CleanBBs, ReturnValues &Values)
 {
 	int64_t N;
 
+	while (auto *Cast = dyn_cast<CastInst>(V)) {
+		if (Cast->getParent() != Ret || !preservesErrnoCast(Cast))
+			return;
+		if (singleErrnoAtUse(Cast->getOperandUse(0), LVI, N)) {
+			Values.push_back(N);
+			return;
+		}
+		V = Cast->getOperand(0);
+	}
+
 	auto *Phi = dyn_cast<PHINode>(V);
 
 	if (!Phi || Phi->getParent() != Ret)
-- 
2.43.0

