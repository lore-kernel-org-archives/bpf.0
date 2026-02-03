Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 968A427BF7C
	for <bpf@vger.kernel.org>; Tue,  3 Feb 2026 21:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770154486; cv=none; b=D+W934EMQg302LccxHJAHW0YppkX3TwRkeTXkdmD4OWF/qYrqYhzxN8TEzQFcxL01AGVBTcqFqtQXmbhsK7ak1FKEaj8FGzhXQr1eTpxD0Kf7ITHmb6URja/JpRQgHbJrn9nmzheXfycg/5WWDPq7OHfcRhc421qadWdYDYIqQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770154486; c=relaxed/simple;
	bh=nHLraCaPp/DWJkDfPzpJgkWOBeUzt0taHWu6wC+aYoo=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=a/EaJ6ob5nOoKeNITk/jKTyQ+H9dwOxvWeJJ83nwYG7dGjHJZwOVflEFFsdJHranVTCd6BDn7XZVMBC/zjvygB3CiRHWErrlgSZSjLBhsI/Poiw+8r5ZP/rHnoiGQtb2vIJhE8OI1kKHUxYtdiqCqptXGuLJxV0nAHoYkeM+EB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BbDuEzG6; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BbDuEzG6"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-3545dbb7f14so93864a91.0
        for <bpf@vger.kernel.org>; Tue, 03 Feb 2026 13:34:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770154485; x=1770759285; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=V5czGcY9OU9Zag/A0NQEkj3r09Cj9JepAuXcZpWmhSk=;
        b=BbDuEzG6y0XBUa+n26qHtbF2gKNfUIwiURaNoaNdkjSJS+zQmczlKsu4AMN/Lkj43u
         Q+i0PBsTzTPDkgQd5cHkf01PnrAcEQ96/vnSpOX2BKLla0kSqOAp/p2U3e1nre3y7XLJ
         2LD66VyfxdqNfDVqw6VyX4GrgNsSqCZeY2hiLl3JC4JU+wZd75VKBO+J6yhw/nZg8Z58
         /YoZ85xf5XyesS5fcKA+6XPhUk0sKzC2mVLSQYmqqn2sCY5UPYNfRhTuelnrrBT60bib
         AJsObeyO8zbRj5D/4gulGLt5IfM+5O1wf2u+mHXJYOGEM+jwU5rFC3f8/EGI+FvGhPQg
         +OAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770154485; x=1770759285;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V5czGcY9OU9Zag/A0NQEkj3r09Cj9JepAuXcZpWmhSk=;
        b=UipMJaWdzpgP8X1eTUUAHurkLIJrrO+UHsUE9Hmr+AD9UYlm7li9nXjJeAIB0wA6me
         hdQN1rgyGuStQUozipiA+fS6X5dPo3wc/wALZra045ShIzmgVGpw/wkKqWwUm5tdxgIF
         xx+fjJqPPszdZ4BN9LYMpLTYWQ4NnCE5bQ0JPhet3ASPzz5szzFzJH3pJPnMX5Klvmf1
         AmIXBSLE/OSiMj09VJRfatbTkBLNjmg62J0/b9nDIN5sNNmR9LBYfGPnHwdZaAmy/l5n
         momWvrKaUQZgwtigizmrzQQWLF/b4rcZG0WoWrCBki4a3u65j3qvhcGsLlZxENR6uUw5
         pVwg==
X-Forwarded-Encrypted: i=1; AJvYcCWqXHW54TEmWwYKzv9JiIKzS3TYmm85l/HG3W15pvgnhN6RKPHRRTBVC5eFj3Oqq/Evhts=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtCFQAq4XcsFV1UI3vDGMWhrj8uAMvZV5yaY4LObM6/jHRxCtx
	ISfiTnYVAQRCiXCKrLp8wJvoXBMgrz/AFAAqd2BFi8tNDgzRaajKsDw/7et1Z9VruDjeBsUkJ6G
	JVyOgWg==
X-Received: from pjvg12.prod.google.com ([2002:a17:90a:db0c:b0:352:ff8b:ef26])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:3fcf:b0:34a:9d9a:3f67
 with SMTP id 98e67ed59e1d1-3548721b090mr533871a91.33.1770154484816; Tue, 03
 Feb 2026 13:34:44 -0800 (PST)
Date: Tue,  3 Feb 2026 21:30:05 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.rc2.204.g2597b5adb4-goog
Message-ID: <20260203213442.682838-1-kuniyu@google.com>
Subject: [PATCH v1 bpf-next 0/2] bpf: Misc changes around AF_UNIX.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Martin KaFai Lau <martin.lau@linux.dev>, Daniel Borkmann <daniel@iogearbox.net>
Cc: Kuniyuki Iwashima <kuniyu@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Patch 1 adapts sk_is_XXX() helpers in __cgroup_bpf_run_filter_sock_addr().
Patch 2 removes an unnecessary sk_fullsock() in bpf_skc_to_unix_sock().


Kuniyuki Iwashima (2):
  bpf: Use sk_is_inet() and sk_is_unix() in
    __cgroup_bpf_run_filter_sock_addr().
  bpf: Don't check sk_fullsock() in bpf_skc_to_unix_sock().

 kernel/bpf/cgroup.c | 6 +-----
 net/core/filter.c   | 2 +-
 2 files changed, 2 insertions(+), 6 deletions(-)

-- 
2.53.0.rc2.204.g2597b5adb4-goog

