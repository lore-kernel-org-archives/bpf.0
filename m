Received: from mail-wr2-f11.google.com (mail-wr2-f11.google.com [74.125.225.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 205FD1B142D
	for <bpf@vger.kernel.org>; Sat,  5 Sep 2026 01:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788572860; cv=none; b=rQf7H9X/H5ftWM3/wRgONdfddhJ462BICAVpy40IMHnH0JEPMZ4iTei4YQhzU/rHDAIbTcVKZiQ1MqXKujcVTLTnXS9c51RmAIIyT4B3oigWExc4grsUx0wTku2jHuDhimNu3RAGWjnqyXDFY9pBhQ7l4d1CMxEt+o4UTSHTS2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788572860; c=relaxed/simple;
	bh=ot9vyETRDiqw+QBRLfW4UgHU6RvZUylAlqm0dLFPqM4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eJd2QLIeOdr2MAQtdD+M8rJV+tUeazUdmZ1qTWkZvcwDu6XkG2q1EoZah3dQWGsh/hkCNK6gfl6Y2+bmV68Y8VkdzR7X3mva4mJ3lieJTX8vjlKfxAYe7V4Z+0LO/uk1Le3qD4a4yHqUkUAc/NszzlBLNYjrPBcC8IQZYb0Rb0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rB2QYFlY; arc=none smtp.client-ip=74.125.225.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rB2QYFlY"
Received: by mail-wr2-f11.google.com with SMTP id ffacd0b85a97d-482e61db882so373842f8f.0
        for <bpf@vger.kernel.org>; Fri, 04 Sep 2026 18:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788572857; x=1789177657; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=hY3iCdzHVz5rRkb3Ci0lvJys3NBA7gGqxOUxLFZH3SY=;
        b=rB2QYFlYE3yp30tpqm4HNGYzED3tSBHzIG/PMRuQKwq8D4XxBkBqcbhSktSqe6SwdT
         f5ISDytUiUlf3jcmARL5+GImlXmQ7aqYZi3O/B/6m5CTV7ZhvLNCfiurSkNyaVJcfW9K
         vJ9kbjRlEliDv2gZXFUxdoJ27jpT+fbp5yrhGgrFDloSQhP2OgDO5qxWftU/YAogbi7b
         e3RJe/qHo81cQ6VHSnSSLEbFYPzxfdTCP8Q6HYUjLqs8EhvqWnnOGsY5oKs5ZyT0HU8s
         8dActlmk1K1SndLjmFsMgYYjWr5End8k65I3hHwiavrWtidCRuDz+7ZvfWl87h/b/CsW
         uNiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788572857; x=1789177657;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hY3iCdzHVz5rRkb3Ci0lvJys3NBA7gGqxOUxLFZH3SY=;
        b=keWMM50QnJT8DRGmZGNbmR/guVr/Lw3a0vnnYss5oUjpo70VXsrZsASTwnUjcwqNko
         IKsgEbQ8Hokj0be41XSqsvz3MrevQBQ6+qT8sVfvUl16o/+0XHadgkWatVc653dIk3sv
         1fk4cZ/r8XOxJUUHus6aWBg87ako8p0d7cbCbA/zGGjD+vRB6s3HLZcPhln5wuW98qY1
         7s/pFD0aHHp3aebnIUobQxbLHeHykJDOFbGU+UlpRDskzlJfQlEJ+vfmFg+dsiyEOtEF
         y3adMNvRnwQ8/EnpWjN1UnC6CbLwjpNIEE2s/NcVq6oTRHzbn7ki765zm4sWyKa36mXs
         Eb3w==
X-Gm-Message-State: AFuF++mM3+YK4+JWxUGRM8TAENBmot2013aps5ZxqqbFXIZNz7zvklQN
	znxjaagXDwG7ygMIjc3kRiQTbj03SLvMSQ2gBGgURZ+01w/bkwVtPxENmNlahDIM
X-Gm-Gg: AYBFou2ofVE/g+4EeJRUkos08hQGhmiaUPq3r4oD7GgTweYeYZssV8qLivDh6GIbwvG
	bsrCyTtvYirFoP/oKmcyxsU5ae6Wo5z5wL/6SglfDMR+sJ5ZhnSuo+swqq20uatzPn/Vhltzh0O
	KTJlr9LItgeI8Nn34XUYCdAEQNZvXaUDyStCf4f06fDfUQjM1Hs9HinxJQCQqigMBBIMEP46xvL
	4qtyXMSdJS+x8XnLiYyv5g/U380WffZhC/zzmX+914elMubO4LeBcqWvvHcWNmF4vwRPhRWTNGN
	ZMtbwOWCB5QIdUCYEHttyR3URCa+eq4AuahJ3qYhrIOg81KiZpj2ecDgL9p20t9HGmiPeMkz0LK
	j3Zh0ZrTp39I+LBWZ+UlvZ1aUmrox8mfWai3eJaHwU7IllQdPkAjauG2jOCMs7AjJYJpACaQJtF
	AT3mPvv6ZwOKiGokk2NcFZpHGFYxs380KUzBfcu2vr/0w+x/gLQXdy0KMxaRmZeVthLjZS8Agx+
	GINkDvqGRDSfHRmsYxAH2jxakMzB2OpxzzufDNp+jH4johV/mhKjduPMtyIdA0B/mt2ywCoho0S
	bOtUOdivix1zGaLyBQDp+bnMQuCeb80UwsfyMA==
X-Received: by 2002:a05:6000:4286:b0:484:416b:7590 with SMTP id ffacd0b85a97d-485872a3cfemr13132485f8f.10.1788572856982;
        Fri, 04 Sep 2026 18:47:36 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485883c81c3sm9547527f8f.26.2026.09.04.18.47.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 18:47:36 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf v1 0/2] Fix bpf_loop syzbot report
Date: Sat,  5 Sep 2026 03:47:32 +0200
Message-ID: <20260905014735.1452988-1-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=638; i=memxor@gmail.com; h=from:subject; bh=ot9vyETRDiqw+QBRLfW4UgHU6RvZUylAlqm0dLFPqM4=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWt2URanqOrvt9uUvSPspm3KdeubpXXtx2SzKTu0RRauP N1pvdeio5SFQYyLQVZMkaXk/z4m4xOVvwNtl3HDzGFlAhnCwMUpABN5tpzhn8GiXNXyN4+4+z78 eqx810x1TYZIp6PBR9b2norVOq9VJBj+526P1VNfWpn+/FrrjFxRYy4+UyFm59oH3R8LvI5c+LW dFQA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Needs Eduard's ack. Fix for the report in
https://lore.kernel.org/bpf/6a9ad24c.b5d4176b.238c3e.0001.GAE@google.com.

Kumar Kartikeya Dwivedi (2):
  bpf: Reject non-scalar bpf_loop iteration counts
  selftests/bpf: Test pointer bpf_loop iteration count rejection

 include/linux/bpf.h                             |  1 +
 kernel/bpf/bpf_iter.c                           |  2 +-
 kernel/bpf/verifier.c                           |  1 +
 .../bpf/progs/verifier_iterating_callbacks.c    | 17 +++++++++++++++++
 4 files changed, 20 insertions(+), 1 deletion(-)


base-commit: b75a000f2ac15f4778ddd6d9298d60b24ad776fa
-- 
2.53.0

