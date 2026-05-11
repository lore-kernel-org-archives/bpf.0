Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A31AB37BE87
	for <bpf@vger.kernel.org>; Mon, 11 May 2026 12:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778501436; cv=none; b=N55wIph4z9f8GpdlFCVZckU2Lkc6OTV7zI3wNu8Nf6xccWB03dLAjBzUGXPhmsKxsxBxq6IFICwKeU8KdL3QYbqshmxL5gPO7zgCs7yvf2amTwAe31zlYy6E5mxarGQhDLZ5D+ZHWyq/HgRrvGsZe+Zdqtx8fOLzGxjOfjb2/MM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778501436; c=relaxed/simple;
	bh=0wrarbMRDUbdwBEeOHsYgAFvKs3k/7gMMCjvHrGHYSM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=CXyTov2LLecdPf40SdiypiYDMU99OmzzrqoCMNmMeWi5+YKxaTCLZDyGrYTbObqR93euZq/IsKQKrZk3ypv249q4LmZU6D/NfV/uPhP4hSgm1XF+6Tk178tiA10WYyx/v80Dc5jIHgSALj6B4ymcCa8MGKAaP3tipWH9hMoUoVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=dI/PWa+i; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="dI/PWa+i"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-67cd93d8affso5172701a12.2
        for <bpf@vger.kernel.org>; Mon, 11 May 2026 05:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1778501433; x=1779106233; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3eLhIDY9V0OBlizIXHPhz9K2mw9WlB2YhNjneNtrUmU=;
        b=dI/PWa+iYl4+ZRnUWkLQEsRuQHj1TYerTOKx6ut6JsEfzzV/okNKOynuYRPUESIWi4
         BGGuyQKuttIH2lhgEq3JR50m7OUtmPnwybqfdBiscCsLOZptnNKO0w0Ro86uSpTLyv94
         6gVMn+iDnmmCXU9hlgc4QuCkXEDL7bHS+S/W70qc0AXLAwROZ59I1SAucFDxDams7tEV
         IMUsu6DXMnjuVFx+0PC/3pJWrEqjRLRbwiltN5aRbz8MmVaSukPC25dFl0MgLooIi0Rn
         j7b2Y3X7DM38Hl7TtLLi4EFn58sA0ELyEbI5s1k+aPI9/WpJu5n6d0uePX+FU8KmJN/T
         Hqsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778501433; x=1779106233;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3eLhIDY9V0OBlizIXHPhz9K2mw9WlB2YhNjneNtrUmU=;
        b=FpiU2MerIUNsqtjHleOCKVBIY5c3ok+jhBodUIaeqb0e/3cCAAU4yRKPKeay4jWOnJ
         m7YFFlC1UNkroOfC9ssw8otneXU/ejkRSF1dcUixH12KaLMXbRmho8D80nfFMtnOQNuO
         8Z+BuxEyyDOuCJyCrAL19dnU/Ib7p3QqQMdfNNNJm6a/gl4gY+iPQTxvsv2rgvXeJsGe
         qtf31ZYr3NIcngTKLyFlVwzBsSLoF/30CB2sPvLJWmKNUxr8x0/XQuu4QnqRkH1bwvDN
         Iypl4k6C3xvUrwzqwRalr22MPSYoEY8WPuFLC5xoGdBOOnsYCHWZPSObWkMIvwDU3Ps5
         Ymxg==
X-Gm-Message-State: AOJu0Yxs0BOZjQ539IcTIawz4DPK1ofPp12VtpSZbkDdXKHvkhRwt2k7
	kJ6O8vimLdUn3g/Nh6r1So2LRQKwvpFRnBElu7UvQvWz8MtT1QDqP085h4D4RU466yD/fKgqOtt
	q8obNbVY=
X-Gm-Gg: Acq92OGbkDrfpxPSbfb9UUThNJUuab6l+xbXrRezpTn43JpmT6MO9FicSTTvrBIzwPs
	Wo5Se86UOMzX+UJC7/Ie/o3js/sJGZ+xhcOHDx7nKeYMfMNvngMHzPfD5RyYOY/oH/OKsnINvJi
	lsO4VfU94epjLPBPgt8UBvcehQe2rkQkaOejHWnoe6IVhA4N2jKlTIIOwdAISR9ukGdl0uPAzJs
	HAUpmYtlfB/ay8kS+VW8oY1PZ2/I2RwDDqZoBMDQ46pxUmMXUIHnYGm/790qdHufEh+xqyNRl9i
	wweg2Ts4E9laM099iPyLA57fVs4ECuUaSAk7i+xJoiAm6FbsDWMi/f1XVUUmEI9CPOTo+WXO00h
	6g3o9xRVz84aYUhFZVmHKs7RKPWE0XMzeLLmxl/54OWuWVGUn2EY3T6Vvk8xkBX998hXXiP+aEb
	W1F5TrdzBY9cGKb11jiDXtzaLX7/wE4JbwHJEVuVhfFMGvlXceDgQzTzS7buc7k0f7Pknxiw==
X-Received: by 2002:a17:907:1c0f:b0:bcf:f777:7f5b with SMTP id a640c23a62f3a-bcff7778bd5mr201805466b.27.1778501432625;
        Mon, 11 May 2026 05:10:32 -0700 (PDT)
Received: from cloudflare.com (79.184.84.124.ipv4.supernova.orange.pl. [79.184.84.124])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bcc5f0b9decsm334130666b.9.2026.05.11.05.10.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 05:10:32 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Mon, 11 May 2026 14:10:22 +0200
Subject: [PATCH bpf] bpf: Add Jiayuan Chen to sockmap maintainers
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260511-sockmap-ktls-fix-1-v1-1-96ff8c1906e4@cloudflare.com>
X-B4-Tracking: v=1; b=H4sIAC3HAWoC/x2M2wpAQBBAf0XzbMqOEL8iD3YNJrdtR1Ly7zaPp
 9M5DygHYYUmeSDwJSrHHsGkCbi53ydGGSIDZVRmhTGoh1u23uNyroqj3Giw4tKSpYJyV0MMfeA
 o/mkL1o/Qve8HPLPpDWkAAAA=
X-Change-ID: 20260511-sockmap-ktls-fix-1-7e6b2b2523c9
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, 
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Jiayuan Chen <jiayuan.chen@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>
X-Mailer: b4 0.14.3

Nominate Jiayuan Chen for the sockmap co-maintainer. Jiayuan has been a
regular contributor and reviewer for the sockmap and networking code.

Since we are now down to just two maintainers, and John has to split his
time between BPF core, BPF networking, and sockmap, having three
maintainers again will help with the review load.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index b2040011a386..dfc621ff629d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4861,6 +4861,7 @@ F:	kernel/bpf/*iter.c
 BPF [L7 FRAMEWORK] (sockmap)
 M:	John Fastabend <john.fastabend@gmail.com>
 M:	Jakub Sitnicki <jakub@cloudflare.com>
+M:	Jiayuan Chen <jiayuan.chen@linux.dev>
 L:	netdev@vger.kernel.org
 L:	bpf@vger.kernel.org
 S:	Maintained



