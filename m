Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0882F30D3ED
	for <bpf@vger.kernel.org>; Sat,  5 Sep 2026 09:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788602225; cv=none; b=jD9BXOwDXTVno2LbEFjEs9gNQPQqUfVGrgAX5+hMhlJyZkbihrsIpIJ+7fVnnZK1ttj/A7KN43l4g7F0IPhHVaqO1KlN5HGuayFM89H2KreSIRRav6ta/1jXhsYdcojZsQ47V1kesul/dMTMmwq33j2I22bnQNrOZL+b8qanC+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788602225; c=relaxed/simple;
	bh=fM50RelpZlPxGOz1H09/Lq54iXhKsyPkRZjYqpWNmCU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=siOtmbDwEMr16HZmWq2Z5tljdJZ//O1qWj0QZghEOo2OVFbnZT1nnFftJICEMGTiu7KouWx80gDIViUrzlCnAz9mJAgI+5cykNIXg5oAi6qoX+shHgZGg3SIM8bOUXlDe0W3oEp3GAY8cqYc9hgGDdWZEN9K4FgKpjX5l0Vjja4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FeYmdCdD; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FeYmdCdD"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-49b965570d7so21599275e9.0
        for <bpf@vger.kernel.org>; Sat, 05 Sep 2026 02:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788602219; x=1789207019; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ayz/e09YuiQeSDHoY+u/lzDfVtJfvbORC9PNu8Y4WPc=;
        b=FeYmdCdDM3HycuN6kG0lAtQMnWyhzZChHRcURAZwGacmlKF57187eEakaVhFU9Uj02
         3owSNZECHgZ5GNjSbRGA1UDT+DFVPSc90AIsoxgdlw35UPtv3uhV4o9Xpp+LGjgyE80b
         RIb7LkWR5tvZATBIXU/zB/W9nqPGfrY71FJnpGeJjAN6LFMuRSuThBI6I7+GEETQukrj
         poNcR1vEVVb0SYLdJECrnTmeWpZqbvZt3YZXBwqkt7WPgxVMWHAgZdJFGWS6h9iGLDOG
         eTcWmMLWzaqY1rOJ3VOAKZK0eo80rO4OkA3bpLLhrjghN3lmA2sEWIJnNP78y8c+YuV8
         kuEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788602219; x=1789207019;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ayz/e09YuiQeSDHoY+u/lzDfVtJfvbORC9PNu8Y4WPc=;
        b=ZsneotQGFt0VFkZ+8pV/6xXIhHpNxONmtI8axqaKwSbQGU1q4wRMvGhc8UVob7bRi+
         HXGNpDlwzsVSUoYhWnsYYGM2o6GkBGQnIQbD/NIY+eAWsluzKXXYLWtC96m32mPwYWQA
         rutUNhF6P7VTeMpZRWH792z6hLPw9lksCW0WyGas28fBTFkQamodaq/5mQFSq+1sAdPD
         voCwlr9t03knfer7YY7BVrbTfcd3OFH7oHbPr4/eYbsehVTsDmYE/N+Oc0ggU3DBxMRM
         vvMn0X12JBoLtAfZl0K1J00/6XoqAIlndWKkkbPgt9rUMWE/ytmJYHvYyJdSUe6YdZF9
         Ez1Q==
X-Forwarded-Encrypted: i=1; AKwUvByLyh5t8VxRdRdApXeRIDU2c0CNS1p2zYzW40DeWyEBQ3x5oa2WgVRQH8zKjTeXW/6XKy4=@vger.kernel.org
X-Gm-Message-State: AFuF++nBq6QrAC4JpZIx7LEdA9pgmK5/IbbD9lkvuUioJ+CgxueeCRQZ
	saJg8vWwsNKmBk9o9Ug/H82ID3rwEWxD8Ds659165SZnQ/ZVaLOg698d
X-Gm-Gg: AYBFou0+sqstnuoPYyeVNcKe2Qswl+8Riob8afuWEWy0yrKWZtHh2tBXIt/AiLmk9k1
	Ij6twl/vNrKEYOWYeGt06Gj8JSw3In5ZF/WS784LSg4HLk++2SFu4/W4t0k/N/+hWe7yoJk3gQM
	ohZLXmgpd4WqseHkmsGEVw6Y2/vAM8gEeRTTz+xTtjwwHMG1pMvVkPy+LYbK8bjgyDeNHB0JHHN
	r41j4tFCzkh5TiVkOIf4nhe8b/L7+2ThhaGqaVM5MjH7EiK7ryMGM6y+wPTAGYzcda762Fo1cZf
	7Vq9h5irybDy3u99RojMl/ZAUW90Ibtna1etavjRV13N6P8TNU45Qr3nReQChSFwLKHgFeFKEP2
	EpGSBYMQzmMbrBAnVq4jpdBImy81NPm4kEbLIua55kFDyHNJRHZIuDPW2XnKCADFYlDV6QGkkpe
	Jz5nbxYRTuDOEPxsIuc/WCq87josPOtbunHgyER8m4o5JgtLVtZWdI/z02zUwuglKOyDCGZKpe3
	Dl8OYLZk1Bea+M7nMOeXp8psD2ZV3FjNzvhnYTEe56/SVnoGOmxyCuUuh3u4v++TLzET/JlyCfV
	BCDeCT18Cj2/APgmZ8vLWLDFwNxm7SFbesX6ZQyBMNw1cK8L+OG6Ghj2DKntdnE3nCe5b4Et9vh
	aZw==
X-Received: by 2002:a05:600c:548b:b0:49b:92df:87be with SMTP id 5b1f17b1804b1-49cf81f3655mr113590565e9.4.1788602219327;
        Sat, 05 Sep 2026 02:56:59 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-a4eb-3001-c06d-af27-9fa2-ea53.310.pool.telefonica.de. [2a02:3100:a4eb:3001:c06d:af27:9fa2:ea53])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49d057f4778sm32077245e9.8.2026.09.05.02.56.58
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 05 Sep 2026 02:56:58 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	bpf@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH bpf-next] bpf, docs: Fix the struct btf_var name in btf.rst
Date: Sat,  5 Sep 2026 11:56:49 +0200
Message-Id: <20260905095649.42351-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

struct btf_variable does not exist; the name is struct btf_var.

Use it.

Fixes: f063c889c945 ("bpf: add specification for BTF Var and DataSec kinds")
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 Documentation/bpf/btf.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/bpf/btf.rst b/Documentation/bpf/btf.rst
index 3f05f17990ad..004aa1058d85 100644
--- a/Documentation/bpf/btf.rst
+++ b/Documentation/bpf/btf.rst
@@ -416,7 +416,7 @@ If the function has variable arguments, the last parameter is encoded with
   * ``info.vlen``: 0
   * ``type``: the type of the variable
 
-``btf_type`` is followed by a single ``struct btf_variable`` with the
+``btf_type`` is followed by a single ``struct btf_var`` with the
 following data::
 
     struct btf_var {
-- 
2.53.0

