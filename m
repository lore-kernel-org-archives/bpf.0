Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF55D418A5B
	for <bpf@vger.kernel.org>; Sat, 12 Sep 2026 08:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789203283; cv=none; b=Bz596BjWw/0Dt7v7MEWIHVMp8XaR9q5aQ+ATxxH7r8S7fiUnWep0lqGxn9GEn/FPgSuUAWpC53apRZ/itX4hMPTm3Y2gZ4buArjZ0yt3lvCxm8UE0Ywb6NVc3N6WTbREYVlXeNZ9euWsEMucM4i6Nbhmc+jcDHLwHefbH0X/yTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789203283; c=relaxed/simple;
	bh=wqIXxPryIBD+qpnTAML1VsX5jPCUetcLu67p2mKXcRI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ybxz0iEWpOMEImNeRLKxhRjjI2TZ5L5tX7PYVl9eZ2ReeAw9vsNaJFO3NjazJ5agoK3rzCCSKepr2CjxF9l6VyZqWh0bCSWccjiwnmOdE2Vd57FaEs0PGvx9tDtfDxuoAKtfbjSxdWsczVoQf/dIz4U+sTTtpks9gsx6Qavj/So=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I2m8ETYq; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ypfk98qd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I2m8ETYq";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ypfk98qd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789203280;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pSgNGI7auaX5Wzahh0Ju110gqPyYVLHgiTEYAP31fQs=;
	b=I2m8ETYqOxJ10sZPK84ndUhc886Ak+O8woE4uzeblwMSx0nzTe2jDxtfHFJZwRh5vPLzuk
	zdIdMR2yERA4udf1dOJnpka3CUOWQHYK+bEYL9R8PQYnTOO795pVit+8liIXUyjmXdUlOt
	E4vNhBOUvFOBtmG43MkGq18V28FFN6c=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-224-w5d_SXJ6NuGkFIABiCX_MA-1; Sat, 12 Sep 2026 04:54:37 -0400
X-MC-Unique: w5d_SXJ6NuGkFIABiCX_MA-1
X-Mimecast-MFC-AGG-ID: w5d_SXJ6NuGkFIABiCX_MA_1789203276
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-49e73659ac5so1165e9.2
        for <bpf@vger.kernel.org>; Sat, 12 Sep 2026 01:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1789203276; x=1789808076; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pSgNGI7auaX5Wzahh0Ju110gqPyYVLHgiTEYAP31fQs=;
        b=Ypfk98qdtykMWiWg4IeAY9pbgAqpeJLtWxTdUxZTU6LGLn0C4ByTWfSDTZ0H2hBseF
         VoNyqhcT6aD8ZsKjsqmsgyvNwrlqbd69dEDKfN3he6r6kP8c+mkqxaCVjRm81jVQaC1k
         qhHfXfixn+b4cb2qC9X4eYrWpcW+Hb3tcz2iXeyqxfXLioOt5TXWAV8RZpMs56khzWM+
         TjjHTzspDw4E3rdpIhiyNTJHNlyHcfR6tnFLkYjs+U0VtghSAndQ24ebgqDGjXGG8uuP
         p6KUOntJBH+pLYmmjt28WdDcq8eupVO8IZmElnfibQzIVD6S+8msjaTHq5XLbneMATXa
         AsWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789203276; x=1789808076;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pSgNGI7auaX5Wzahh0Ju110gqPyYVLHgiTEYAP31fQs=;
        b=NKe3OX3AtEvwri5a+IrWOgmNO0bT365ehSeDeCakzxVTLvRAM8XGkHd3LYE6zUcSkv
         Idt6v+oCQdnyptWrji/C+ktG/or0aCjjcWqBMxhtQhd9L0VQ92Qmj8vFyo68XwD2oxVl
         pvazHpHyXjncm3ObDClg4FqnzzeMZexsGS18z1E2gbj8/R0DnKLQQoL/5VrX9qIYLt6/
         0EsfxlThtI3QqfrKAVFtQGNmckMWUC/XnFetD9OH8sqTMyzkM7ypyME9GX2du1td2TOu
         8uy1eDZyCeVHfyqM4nzER8jILkHtQkfB53DWjUsX/FilREriJPtiS5htcgNyU1RMG7gl
         xtGw==
X-Forwarded-Encrypted: i=1; AKwUvBybeiK1uMsBVZbUlJCR/BZ1Xe/5FWmyb+DpOKIpACqCQoKM90Xj5POwxCWgZ2GpnY2gYyQ=@vger.kernel.org
X-Gm-Message-State: AFuF++mnTphUH6iBLJD3WuhTeYNY7davrU9Bw0KEvpHVLMt30YB8R6j6
	5tzpiySBwikGgzai9QTwWgrTripujahgXjvAQKN6esHpumYsI+zk8zAd30gCspheLHOWLW5Wm2Y
	KFcNYCojMZuvkO7GMpBkw6zFHo3UAnd9xt4eYdcjWygoUBaX2u8nvbA==
X-Gm-Gg: AYBFou0X52LKk0mZzynixZB4FAFhIynr2qfjRkyedtdxpB9b9dGma2d6oM0Rh+vmVxY
	CjWx24BLwpwPqPhoMElqkE6JpRYvxy4492nPG2iE4rA26jyKI9Wb+kd/LO6LlHvGD4jR4UHvFKu
	08uBTLVi01h/9j9nOoOqZH4yIyS5OC99I7fRfxx7kWwYK7qcUYFxX2DDpX9pLZ6C45HPoqJUobY
	MwGgvMzUfCZWAfasp+zaminkUX/7bFcSrYFaLfOwHXw61vsnrATpjIe++26ti3cH2XWCqM8CgK5
	duAIzOxKioIpb3og8eFGr/AK5lQepk03SJxCXNvVdl376cVXOctJlDWzsNg9wtugZfKBHvrIy+R
	UThbb+j7qpm9j1Of3S5eiVoCJ
X-Received: by 2002:a05:600c:5248:b0:49e:645e:2616 with SMTP id 5b1f17b1804b1-49e6caad0b1mr16986365e9.5.1789203276488;
        Sat, 12 Sep 2026 01:54:36 -0700 (PDT)
X-Received: by 2002:a05:600c:5248:b0:49e:645e:2616 with SMTP id 5b1f17b1804b1-49e6caad0b1mr16986165e9.5.1789203276197;
        Sat, 12 Sep 2026 01:54:36 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e60adaeefsm138948755e9.12.2026.09.12.01.54.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Sep 2026 01:54:35 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 12DEA9B9ABD; Sat, 12 Sep 2026 10:54:35 +0200 (CEST)
From: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Quentin Monnet <qmo@kernel.org>
Cc: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next v3 4/4] bpftool: Adopt bpf_program__add_flags() helper
Date: Sat, 12 Sep 2026 10:41:03 +0200
Message-ID: <20260912084109.432834-4-toke@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260912084109.432834-1-toke@redhat.com>
References: <20260912084109.432834-1-toke@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Adopt the newly added bpf_program__add_flags() helper to
non-destructively add the BPF_F_XDP_DEV_BOUND_ONLY flag to XDP programs.

Acked-by: Quentin Monnet <qmo@kernel.org>
Acked-by: Ihor Solodrai <ihor.solodrai@linux.dev>
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 tools/bpf/bpftool/prog.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
index 8c2f9255b36d..6ab911e82155 100644
--- a/tools/bpf/bpftool/prog.c
+++ b/tools/bpf/bpftool/prog.c
@@ -1769,7 +1769,7 @@ static int load_with_options(int argc, char **argv, bool first_prog_only)
 		}
 
 		if (prog_type == BPF_PROG_TYPE_XDP && xdpmeta_ifindex) {
-			bpf_program__set_flags(pos, bpf_program__flags(pos) | BPF_F_XDP_DEV_BOUND_ONLY);
+			bpf_program__add_flags(pos, BPF_F_XDP_DEV_BOUND_ONLY);
 			bpf_program__set_ifindex(pos, xdpmeta_ifindex);
 		} else {
 			bpf_program__set_ifindex(pos, offload_ifindex);
-- 
2.55.0

