Received: from mail-wm2-f6.google.com (mail-wm2-f6.google.com [74.125.225.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF56435F5E1
	for <bpf@vger.kernel.org>; Sat,  5 Sep 2026 03:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788579623; cv=none; b=DtlwFoxuEVp3dh9lustCGKqsLH75gC6JjsXsWQ/sJ79sb6sGTStiL94VzUPWnWRcnPeL+e1YmxMtvT2ksQCSxikGMwGv2L3IMF776Msu5RzTx3lTvx7aSeHdYd5EtmNaJOByqT66dcrSDFJ1SGyxoQ9PKZrDC7xwmGf/EM9prv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788579623; c=relaxed/simple;
	bh=eS9UE8PgrE1YN7kYdfPPd8Krdz6ljk8SjBVOUZSm+uU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lRAmU19TmBImhwvWefwN86Gmaw9ivdPfCiKopPAZ9XvbQ29UVbnjB3buDfKBiCm5kqLAcDllUnU9a3Ezy1DjOlTqEyqyVfpORBL2Qwz/X69BzwiS0z3n1qAq7G+7+71knitBeFi4I7UDqb0u9xuy7hKwntjdYP3dYdOiugIMat4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sogdu8Pu; arc=none smtp.client-ip=74.125.225.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sogdu8Pu"
Received: by mail-wm2-f6.google.com with SMTP id 5b1f17b1804b1-499aaf0a723so5727575e9.1
        for <bpf@vger.kernel.org>; Fri, 04 Sep 2026 20:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788579620; x=1789184420; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=aBGj6KB+KgClHbTeKr/wn04J0jKnYOhV1cHvWKFuB64=;
        b=sogdu8PuN7BOAfI0CWOtT1KfpsyhJ4H/AWAC0tiqsFlBYyiajtN/Jb/AyGxGgs7E42
         +j4PGKOz00Zxjrkms7ejFNGrXRlsYVhPKut6SOFJXK5qxnq06OvlGFzcBdu8kHvMguTX
         0wfVS7HmK81U+2uES+uI+5npAJ0KTDO251QLznRK0vhXsLib3yWNTsShPZNGUT+ay8SK
         0hcqt2R7qLsO/OrmDCM9cPfv9itJLCbXAlRI2c9WsWy22vFoJdA4TuQfsJZ5+YvH/D3g
         1d8w+2e+56lAE7z11safevDt5ZEanKQFkbIhn5Up1Ezp6mXwILz+rtMTcOm7X41cIQZ5
         dksQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788579620; x=1789184420;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aBGj6KB+KgClHbTeKr/wn04J0jKnYOhV1cHvWKFuB64=;
        b=IAUi1hMgW7UmZsv5Ad3NjcaaBcpIwZA/ShuKCFuQPzEzZHFCbRERk3/Mo9UED2OCBB
         jjLk7FL5lRRB8jln7nsilGhS6ksEvmjBrhAwlcvXrnlRHFMWTziUjmtaS2dTQoKv2dzV
         laGG3waCfdeMBbHpXcNW708bGAIZ1D1AM3zayBMInwAsMQXv7dvKbGMB9maa31yMJ8F6
         bbtpRN4rFr2NlKUzeijMSFAvDb6gDJGerBv92bL+GA8m97WySqHpqiDoXj4n3YXqfetP
         SNocXX+evkwOEcdfqmEmz4GA/PRmtRgG45fg9ke6np4obdDbqmY07vlEFTvQn/yMc7Bp
         sb6Q==
X-Gm-Message-State: AFuF++mDfHHp8kzGzqO2Mu46E3KCnAMkRQ13Rq7IofpwwWwcS0vVr0pY
	pHqG7+FXdgHoMUpUTKQHxx+UAzYCBE2pSqT3aFaUrw0y1uMXzbkwX+Y2a/qRbEHO
X-Gm-Gg: AYBFou27lSG7N47nPxUQ0+mcQW5jJ8PrCiK0WAymIeRIJEr/6rZFuF66gWwUKUBLrx2
	5KsWXXbrwqTR03dQUz81VPveXcYOBezRULQcIuIh8lgqnPoyDOof8ranWhslVaOLvjD2NtjdsGD
	MBAopGUpp2VEWv9aOyalOJinaqdGl9LYDjklxvs6wHfqUov6IJxVJjUiSasKD+yAddoSYIPSwK7
	dsilv+ITFFfPAY5pNgTjEpY4VGCiIY5rS8xs9YvB0kdQL7rpiy9tYbZ928TmM7qb9NPSwIfJtTF
	BJVfvHwoK9xDaZNafTlT7HWbUR8I88GHUbRNR5JvR8lvFQ8WMRM2X1vYVoZ26lt5MSXDWcDJfC9
	huycE9CisN+X/v2ca0UhHEzR/ddybf/bqZzeyl2a6EjMu+fsMOSjnhU1avVgNoR86hdZC6IvgUK
	npB1Z4EbaQGtW+7+ugzYIsdi7fIK75mTW6Gw+0s7foCdxf8o7viRUv/5lOEBmwacP/zfM7pcGDD
	ciuyBRHrKTovUBZqCNF6adNa9ONLWoRS5MdOoeh332qtU1eBN+mSe4c0123tOgL+lFTUuiPxncO
	ebkd4WYtymQRclpkOcljRD98rhU=
X-Received: by 2002:a05:600c:4e94:b0:498:943:ccc0 with SMTP id 5b1f17b1804b1-49cf81e368emr144400975e9.6.1788579619779;
        Fri, 04 Sep 2026 20:40:19 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cf7703cc7sm118384975e9.4.2026.09.04.20.40.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 20:40:19 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Nicholas Carlini <npc@anthropic.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 0/2] Fix global subprog verification context
Date: Sat,  5 Sep 2026 05:40:14 +0200
Message-ID: <20260905034018.2095649-1-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=906; i=memxor@gmail.com; h=from:subject; bh=eS9UE8PgrE1YN7kYdfPPd8Krdz6ljk8SjBVOUZSm+uU=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWt230eHB/uDd7162fDk+pYjZ09zKKxJKnqaOHNt2wqHJ Wv6Dnz81lHKwiDGxSArpshS8n8fk/GJyt+Btsu4YeawMoEMYeDiFICJfFBh+M3unnbII0dHxEW6 NOqcYsReHba9FksYVgveDWTXDJqROpXhr6TL98CC+ETz7weyz1YcDpIojZwgtZxxqfbrjz1LOVf eZgIA
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Global subprogs can be invoked in both sleepable and non-sleepable
contexts, but are verified based on context assumptions for the program
type as a whole and not the precise context in which they are invoked.
Nicholas identified that this can cause verifier's safety assumptions to
be violated. Implement a fix by performing verification twice but only
if different contexts are exercised, and add selftests to ensure coverage.

Kumar Kartikeya Dwivedi (2):
  bpf: Verify global subprogs in each sleepability context
  selftests/bpf: Test global subprog callback contexts

 include/linux/bpf.h                           |   5 +-
 kernel/bpf/verifier.c                         |  76 ++++++----
 .../bpf/progs/verifier_async_cb_context.c     | 131 ++++++++++++++++++
 3 files changed, 180 insertions(+), 32 deletions(-)


base-commit: 3ccdb07813829ba9487273e75d1cb238cfa774c1
-- 
2.53.0

