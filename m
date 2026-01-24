Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91AB91EEA54
	for <bpf@vger.kernel.org>; Sat, 24 Jan 2026 01:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769217724; cv=none; b=t6BvDLsp7i5F6r0tSivjEU7FgzCOh3G+1B2GKUyQ1COs/UKMg98YYzBqdM5px/x62FgjtcqvuauG9gHTSB2XTnjEsUxoMSnXEz6+EOSmLYth0x3nlADRevXq2KGcmWUWhT26wxia6si+T+o+6oKiQB0+OfuR1niTM7HSP0XNLYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769217724; c=relaxed/simple;
	bh=wvQSevTks610RBfJ7oBqtsKqCB/HWm0eJW4rW75kywU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VpYZOdIxm6wajYzHfozNZxaUklSjOmVqUBkCQnls1IltgmKu+IEb+KtejrqpqhtMErryXvF4kotS9DG9EswKj+JWsvLDMeBx2H5/EcgPQ3WrNOnOtPBiiuyB7UIKqMqZXro+1gzbjaWvI/B64haTy3zbvCke0+jHFewqrCIGKjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--wusamuel.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YLYZQwrZ; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--wusamuel.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YLYZQwrZ"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-12338749ea9so3711964c88.0
        for <bpf@vger.kernel.org>; Fri, 23 Jan 2026 17:22:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769217720; x=1769822520; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=a577FNgbL0JbRd6IsOu504RokGc/26jdmHoERsXu7xE=;
        b=YLYZQwrZQdClNm0+ozko3XXQMt5QHTLB7dWO7oLhxt0v1xuuJ3CcXIKg54k0W/Qomp
         1IMBOsUl6CvRmULjpxw6yiTLZW0Zn9lGrvDwzayqa/+ZeCrum+Tr0WdhunptrrZwhayo
         gnfMxwWT1rbB40qlchCCJWgV+wN5AO8ttGME9i5xHxv3Tft5u0DpEBy7ji6Oo/eM8Yla
         k4RVwQwaz+kDUB2lp38uc9IOxpEjqzCSN1+Yq16vdPd07lqh91IG3ZnpEgHYjggqIPxs
         7WIp1zY6+RlKqwUocNhrHV5AoyjRDTu2EZMvN2b+1MMqSxMOq/sk/NChMdnqT9wNoUGc
         9NZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769217720; x=1769822520;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a577FNgbL0JbRd6IsOu504RokGc/26jdmHoERsXu7xE=;
        b=DLUQNq3h+KPF6y/QxKfbL+nbCZV+iZxnJTNHiB5HZrzXMCxw64ehLbXDGRts0ioP27
         K8sASDLr69tFGWIU74r5UvjSC5j+9q/EJO8M8X5xBRaeQ41ND8yvaNY8fZZ04kXMtTrN
         i9apjpE6IaSx3pF7eAYmFtTSry9Eyu9I85EdPsuF3oW9dYH6ieh2OM3/X8ID8UMuMLqn
         GlZyNqhQGshd4YldU88ZnLPCWOJrNaya/M3/NJNDhqPcwCSf4E5r8AL013tqV+jm/pVI
         pdBpTmofyRw0i9SdX4D5mQ2IG+vg1x3Ty3kcqJZNrNUyRP8ZnIQ3ca2uYq/sW1f8GQH+
         bZMg==
X-Forwarded-Encrypted: i=1; AJvYcCXuB47sRsvNclGE4L3cAXpkBhw+oev9ElFkTWujh96l8ZGmhkGjl8U0rUnQbTqS+N9dkZU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXCjbV3NBojbdwRPl7z/WtLptrIiGqDv7lNMxklKZaDSaJhozi
	dm0okKr1Ghc0NRyDa4FRfPqdK+8Wf7KofLNDkGuNgN35cbAk4AeaqFLJ8ThsEdVLkXqtiABQneX
	aDsspbyGJVEShyA==
X-Received: from dlbcj34.prod.google.com ([2002:a05:7022:69a2:b0:11f:3043:2c7f])
 (user=wusamuel job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7023:c081:b0:11d:fc4a:c4f7 with SMTP id a92af1059eb24-1247dba9450mr1771878c88.4.1769217720087;
 Fri, 23 Jan 2026 17:22:00 -0800 (PST)
Date: Fri, 23 Jan 2026 17:21:29 -0800
In-Reply-To: <20260124012133.2451708-1-wusamuel@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260124012133.2451708-1-wusamuel@google.com>
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260124012133.2451708-2-wusamuel@google.com>
Subject: [PATCH bpf-next v3 1/3] PM: wakeup: Handle empty list in wakeup_sources_walk
From: Samuel Wu <wusamuel@google.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: Samuel Wu <wusamuel@google.com>, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

In the case of an empty wakeup_sources list, wakeup_sources_walk_start()
will return an invalid but non-NULL address. This also affects wrappers
of the aforementioned function, like for_each_wakeup_source().

This patch updates wakeup_sources_walk_start() to return NULL in case of
an empty list.

Signed-off-by: Samuel Wu <wusamuel@google.com>
---
 drivers/base/power/wakeup.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
index 1e1a0e7eeac5..e69033d16fba 100644
--- a/drivers/base/power/wakeup.c
+++ b/drivers/base/power/wakeup.c
@@ -275,9 +275,7 @@ EXPORT_SYMBOL_GPL(wakeup_sources_read_unlock);
  */
 struct wakeup_source *wakeup_sources_walk_start(void)
 {
-	struct list_head *ws_head = &wakeup_sources;
-
-	return list_entry_rcu(ws_head->next, struct wakeup_source, entry);
+	return list_first_or_null_rcu(&wakeup_sources, struct wakeup_source, entry);
 }
 EXPORT_SYMBOL_GPL(wakeup_sources_walk_start);
 
-- 
2.52.0.457.g6b5491de43-goog

