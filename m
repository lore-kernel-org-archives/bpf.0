Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792491166;
	b=hizaIyctX+yNO+j1PicAvjgmql2m57fPO3r3ZQx9LEz+HTMDKfLo1/f9R3qSiVQ8/Aw1
	 wV+olHL2T/zk+rR6ZQfPZIHKhdaz9QpZyMLtmZIQblVFhjQia1kDfddu5kD6tACXegZNg
	 kD9OAjnZyrSlx/3l9drXil5Ox5xnq2+W5Raurwgt6XToCzb+c3ozRygccLvesLgnZg7o8
	 UbshTwugA+fyUFh8a8YN3+/mOUluwyDbAxoEbervDDSNkDMDTMhWFg/+YjO7WfWHBmPqY
	 Lds145OatoTi6KFZywyo702OwGEl3H89V0woa843XjkOLmRDw02N9lCdOghcNHR6Hug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792491166;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=hyIt8UuqcY0wLMo+M/DJiAp4mcXijBe1VnJG7zgOR5g=;
	b=ibuw1gGWbRCQ8T3x03TBjfQsrdBQ3c6t/xetOxuKa0M9LJ6p9y0eLlKgHmzGAivECmJ8
	 P/jKqedOeFwbLaE84weKiuscQLfJCvr49js7cy+g7ilJPHG8Q1tMfwW8rYIf43SpjzMpx
	 4v5I6y6pK2ijMlusAutgeAk4g4rvyBGV2o5UsgoABuHMHgqyNRw2IeewlQO6PkfWGz0+O
	 0SH7J3vNUomxxxFhBA7Nia4XSVHoidhLn+GcuzvutxUHYuRQnL0mMi5HF0YOPWZpfJ7s8
	 lFEcLVmDiCNP2DfEffpU326bOVH3COgLGIoGle2XV2wqJbjmPZlIvkvGNyAdFEghkYw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Jj9wGdz2;
	arc=none smtp.remote-ip=209.85.167.51
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F8B5606A319
	for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 10:12:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9F8B5606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Jj9wGdz2
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5bcb6faf862so2785213e87.2
        for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 03:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792491164; x=1793095964; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=hyIt8UuqcY0wLMo+M/DJiAp4mcXijBe1VnJG7zgOR5g=;
        b=Jj9wGdz23EbV6ZqyCW2W0QgkzaZJQ+3DAqkCpZQaz4JIC9kPLT1PBBQNllkhkFxXXU
         d4dbQkyNnwaOxyJnBqVtkWkRYsbDrb7ZDxAq6KxmrBpHBSDOlP06CJBn64PtnJv1nGhF
         kWgJwKgKltl/xcIgkozffn0hqWPOpV+pGL1JpwQBT1lEqmG/waUaUHyFJ7JmHYQB1iTH
         hzANXjbxp3i57EBvlnVekpIy45L3U0jLVowcbrR4WcEdLKzGaDcxRm9mBlZ9xfjfUILP
         H6urXD75MlKhqDP0s+i3/X4t19ii8Xq/9aongrOMLVuzd1Y7V2XZo+//+yEjyhw/M0tn
         D5DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792491164; x=1793095964;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hyIt8UuqcY0wLMo+M/DJiAp4mcXijBe1VnJG7zgOR5g=;
        b=jUNCRPbJHsILsaC+yOaISni0Av237hTKqb2gFsZLMFZV0RhIjhRLp1n2//v7WFg0Vo
         xMNXzZ0wNwm987N5daw39QFwbuhMbzsswrCiIhtaaBw1+RVdJPtCia5WwWxtin+ridNe
         kYPjAk3pk3InomUoYZWm82dXBBmVnMuOIvGyQmYrn4w/xzLDvm4bCyVfEugWsMpVrFmz
         CZ6RfYWKVREv3B3IzqoQcdNBVfc++/zbuQt1mrouBrmLKJ6hrl2JxFt/WRtOu7xWoo2/
         6UIAJ13WLS5DyfMRQslZ8/xZNmSfpLmk4XA5mohXqJb0zJlZytn57+o04yuGGdVGPMsO
         i4QA==
X-Gm-Message-State: AFq9FYJg4XHlsF++NNhWtYCGkWVxZCrXHsXrZf4d8rN+hwXh/7BBZEgL
	oRVlk077ID0LPrHIDA4wY8m2fYPW0rSMCEtZd+qcEvZoSdbV5E08AhoDuAHd5aYcq58=
X-Gm-Gg: AYBFou0GlStjag8uFhlyqtMZcyQ3BLk+CJZySr0B/kFDYM4VNsQNBOfXU2Okytshv2W
	tpUbJky94qyQ2k/iSYKmqvGTQhcibUYDsXXdjSNC/VTC8b480lhX+mu0GIOOK+XOHUdUJd31P9f
	intYjjN+dhvPkwGXmiVTn3QSxRbzxo2pcXZ7rEn/h/+3abHkoVg2BC32xSQhLKTsvzKm8bexlQG
	SdqH6q4ADO8c6BFWOakwr9wk+vxCiZU0puOk42VpXJK93rse5IyZWrmK4CBMpjgSgTnKPPF9E80
	87SQRoNshcjHgpRyB5s208qv7nL0DtUJ+7+O1GLOD6xhfYPzClwQR6xr3wP9DAQNphAnl+YXaah
	/VhrOLwRQEVIrRM2004ScLud95Yubd2SfoL864rX3y/FZPZAg60Lkp/PKoYTHr53qAZnfdRVChd
	6tUD39YRoRPhq3frMqB7Iaax/qhhWNLW8R2cIGvHKotm4KgB20vDS0eRrDVVYfR+LyI/o5MA9Oi
	S6vtGCO+ASKDfjMToYDqDokY6dKioGg5HLdMywcywngMO/QTcI=
X-Received: by 2002:a05:6512:158f:b0:5ba:356b:5a85 with SMTP id 2adb3069b0e04-5be50a74de4mr3285157e87.43.1792491163375;
        Tue, 20 Oct 2026 03:12:43 -0700 (PDT)
Received: from localhost.localdomain (95-24-167-79.broadband.corbina.ru. [95.24.167.79])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5be4a64433csm2509649e87.82.2026.10.20.03.12.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 03:12:43 -0700 (PDT)
From: Maxim Skokov <skokovmaksimevg@gmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	yonghong.song@linux.dev,
	Maxim Skokov <skokovmaksimevg@gmail.com>
Subject: [PATCH bpf-next] bpf: Cast helper IDs to the helper type in bpf_helper_defs.h
Date: Tue, 20 Oct 2026 13:12:15 +0300
Message-ID: <20261020101229.111074-1-skokovmaksimevg@gmail.com>
X-Mailer: git-send-email 2.47.3
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

bpf_helper_defs.h defines each helper as a function pointer initialized
with a void pointer:

  static long (* const bpf_map_update_elem)(...) = (void *) 2;

Converting void * to a function pointer is a GNU extension in C (gcc
-pedantic: "ISO C forbids initialization between function pointer and
'void *'") and an error in C++, so BPF programs written in C++ can't
include bpf_helpers.h.

Cast to the type of the pointer being defined instead. The name is in
scope in its own initializer, so this works in C and C++:

  static long (* const bpf_map_update_elem)(...) =
	(__typeof__(bpf_map_update_elem)) 2;

The generated code doesn't change.

Assisted-by: LLM
Signed-off-by: Maxim Skokov <skokovmaksimevg@gmail.com>
---
Tested: the generated header compiles with clang for the bpf target as
C, gnu++20 and c++17, and with gcc as C; with gcc -pedantic the 211
function pointer warnings are gone. All 1082 selftests BPF programs
build to byte-identical objects with the old and the new header.

 scripts/bpf_doc.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/bpf_doc.py b/scripts/bpf_doc.py
index 15d113a1bc1d1..6c18aa09389d8 100755
--- a/scripts/bpf_doc.py
+++ b/scripts/bpf_doc.py
@@ -908,7 +908,7 @@ class PrinterHelpersHeader(Printer):
             comma = ', '
             print(one_arg, end='')
 
-        print(') = (void *) %d;' % helper.enum_val)
+        print(') = (__typeof__(%s)) %d;' % (proto['name'], helper.enum_val))
         print('')
 
 
-- 
2.47.3

