Received: from mail-oa1-f65.google.com (mail-oa1-f65.google.com [209.85.160.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12BA02857FA
	for <bpf@vger.kernel.org>; Tue, 31 Mar 2026 00:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774918341; cv=none; b=qZNcn9O8DDsNtspaqtNAM94hRGB+gS0RFswMjrlsdPSJoF8upsMIBdcpqWZDF6U3C8xhQUzT/OBJhQQ1j/06PsP5npcsZHNWxfTSD8Gj+0ioEwXOfFd0rjwpSa8oyNXGFmb/eyKnYwpLqcpBceQv2DEXQohZKpTTmaSuZeRLzVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774918341; c=relaxed/simple;
	bh=WGsXhbcDCOxX86jowP+Jo934kiLHJCr1kdCZ//0kuyQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fqOvEVl0TAV4SazW94sIHNevgqKhOqC/6wKLvJB+iQ1Y7MVEQaCoRRa6ETqj/4TvjNYclaR9Thg/9u/drAquFIpZUoSXHH/lJqdscNFHBarEHB4p9egfTP0mMiAIa96zPxWcurgk/fxqgoRlW4iT1RbEprJOFo9JgQQ3L70TnT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TC0fgm6d; arc=none smtp.client-ip=209.85.160.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TC0fgm6d"
Received: by mail-oa1-f65.google.com with SMTP id 586e51a60fabf-40ea36b56b7so4160023fac.3
        for <bpf@vger.kernel.org>; Mon, 30 Mar 2026 17:52:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774918338; x=1775523138; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lSsjObgyc7c+XXFa2kSWmFf91DtU1SQveWJj3ZYSdxY=;
        b=TC0fgm6d0tAjJfNAb3P94sIPWLefMZNo6rUrynw83blFykr5/MZ9XiTmDksbo5bcCH
         UYro7F9J67QGlptIkP7MD3mJ+Q2H+vIQbJCDCAQHmixyWeNcT68eu27Hmd+HdcEewz92
         yxeV75FoaOHgwzQmOYNhfl6tPepKfY0ABDex3hxpcsui4KE43XJpo9CNa14+fZibrDfZ
         P0QnnplMKtrm4pc+QQZT1zInGoLCnZI/GebGgvZqmgsjZzODjQqny77lrnFIufidnG6Q
         Ur8t6h17FePQRdk5ixXVyIrRgzZjb0r7wzS1w7EzVxoOBLdGTAYxenyscx04csMwn7t8
         TdBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774918338; x=1775523138;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lSsjObgyc7c+XXFa2kSWmFf91DtU1SQveWJj3ZYSdxY=;
        b=JB9DvDQchc/wOA9v1jRbV8auF+r1XbZUIFOF6U1OVdUusdFuHFgbxJC0IIG5S73bxG
         VGbBP8UFAotSXrHPAWvAaOGAN9o/pbVtsyz/W3iScLnblBu9rcHZHQYkHCEceoOSIEWs
         FREQXjW9K8yYqfn8R6D7ueUMWyUQGl06J0+zZvKCQZUvUU480a04wPMhzZJQ2iJuB5EE
         AJQ28liM81fcWOOSy5jJW7jDmJ0a+KwYwLwGTFn/kedoRmSl9PY1G6VQ6VhsxHa7rOR6
         GDv3pPAV1+Vcsn9Yo20cMER2oMWSg4jfZ+nQ1+sn/kFZsiks/OlNcSPi0wOtyQRarhD2
         OXpg==
X-Gm-Message-State: AOJu0YwReAnusRdZbdGkLEEx79Jgk3JNyCFULWUXsn5yZWgh/nYfsGrr
	Z+Phrw2fdJE3u1afuSP8zzO7tXAml0wrjJfd9YBrje3rM/5arFBBDKRYUv/EVXau
X-Gm-Gg: ATEYQzzWRREKBiff8i4Rj+hgGk2XWdz4wTqNoEr5NWN61Uwxj4JO9tbXUM0OgelppK6
	du1m5B9+yNUyyslR5gNcfPtrIVAhf7H5sjQxK3jR2YUVnGSTIYTs4sWif7qF0+6rokijeo8mA4v
	6dnL/mFNo6DqRtzk2mofcsaSz3btVQVDSDipkLI1SEn0BgR8casQaWjPdlxyEbGvEG+VX4QMQpL
	jaxKyihSRCp7USz6SKZRlOaUpjStT5RO34WiBREkOKuHgtnzh/Z9w/8uYXwDpJpCIRxkRx/9So1
	djg1dqTInf1kjjJsoysopRLRgxDYi8qSjZuE6Ex0XtaVEkjb8dVT2KFlpQgExzbmaXSr90po2Zw
	iZDriENG8iG9t8dBmmQBlwJMw/wpknD72N9HSikk1zXPlKCh50gwFJtWoCsLqTgbVFSoibPGg/W
	YR9mxEfMCpwk6AaPCxuVKIJo0VM9eBLX59Qnd23wtcnT6A
X-Received: by 2002:a05:6870:e195:b0:417:3936:1c7a with SMTP id 586e51a60fabf-41cec2c69famr8552200fac.24.1774918338358;
        Mon, 30 Mar 2026 17:52:18 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:58::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-41d04cf9ceesm6369607fac.15.2026.03.30.17.52.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 17:52:17 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf v3 0/1] Fix bpf_link grace period wait for tracepoints
Date: Tue, 31 Mar 2026 02:52:13 +0200
Message-ID: <20260331005215.2813492-1-memxor@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1150; h=from:subject; bh=WGsXhbcDCOxX86jowP+Jo934kiLHJCr1kdCZ//0kuyQ=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIfO0lJpo4O5fO6YHWO5fPWcLQ3Gs+ZspByfrHorRyNU2ks3W vHm8o5SFQYyLQVZMkaXk/z4m4xOVvwNtl3HDzGFlAhnCwMUpABN5kcjI0Fn7TpLhNxfjWf2m+Ml6tp 8KVkvbndJda2WTx6okZsnHycgwj8tz6uTvJQWL3t28axYhcNF6euUFi+O+v9I0588vuP+SCQA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

A recent change to non-faultable tracepoints switched from
preempt-disabled critical sections to SRCU-fast, which breaks
assumptions in the bpf_link_free() path. Use call_srcu() to fix the
breakage. While at it, retire rcu_trace_implies_rcu_gp() and clean up
all in-tree users.

Changelog:
----------
v2 -> v3
v2: https://lore.kernel.org/bpf/20260330143102.1265391-1-memxor@gmail.com

 * Introduce and switch to call_tracepoint_unregister_non_faultable(). (Steven)
 * Address Andrii's comment and add Acked-by. (Andrii)
 * Drop rcu_trace_implies_rcu_gp() conversion. (Alexei)

v1 -> v2
v1: https://lore.kernel.org/bpf/20260330032124.3141001-1-memxor@gmail.com

 * Add Reviewed-by tags. (Paul, Puranjay)
 * Adjust commit descriptions and comments to clarify intent. (Puranjay)

Kumar Kartikeya Dwivedi (1):
  bpf: Fix grace period wait for tracepoint bpf_link

 include/linux/bpf.h        |  4 ++++
 include/linux/tracepoint.h |  8 ++++++++
 kernel/bpf/syscall.c       | 25 +++++++++++++++++++++++--
 3 files changed, 35 insertions(+), 2 deletions(-)


base-commit: c369299895a591d96745d6492d4888259b004a9e
-- 
2.52.0

