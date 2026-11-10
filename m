Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794342258;
	b=PdefovThw+8QpctYraBHlic8KpDIEFOwi5UxhRFxCV2TcX88q7bl7Ynsv4OvgiIeGYzx
	 GyHS5e6XlG3oJK+lk9q/Lu+/KmygDIqEgGAYl0K7GsJI0FYLKwgjg+OhQYd9S8+wi24mn
	 BZK5RsE3hNYPPjynCTkYE5CzpPOVrSWbw/46006o7gj3wT8FdAcoXlak3PkQXKLEhR6qh
	 JbnfSU9y9MBHPOzHGVAcr9Fx+VY8N7TAcp0edKh26DhSmxoK/RZCaxZnNKRc71aZqWtvK
	 0i1Pbmtzv7PKNKB0JlOt5KYBT5Rttis1tC6mafxOh6PsKjc1nbWs4zuTx79zulxZ5DA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794342258;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=U4CgF1MujLyKKs4MDsPCH+PRIQeRT4qSq6PrwqdYMBE=;
	b=vPpeH8rWpHq82xznLBmwNmgN07oMfafQ8/LaWNWYu6LB+ZMh0EvjaKo9BRTSfVK0QO46
	 gQNJFx4Zs1m+xXtFgl9JgQUkS50WmUNt3XRZs9bS5A21QoqNxc4RLMycRye+T0LEczCcs
	 SXeZcj66tL/PoSpMqr2dgMrLFbAdQZdRUS3Wmh+6hQfo8WY1k6m5VbUdnNheAuAulQHxx
	 aIJR9/8KzFq2zTLjPROVGuTSEBhHt1PrYHCVD3hHVbOEUa33liS+s/95WdOVRQ1FI3eMI
	 iK+xbCwaPDS9k1/6p5yXp1fJE4yAQF+/X33qBbA9gJawOo9LOooJXTu7h5Ib+xcrKeQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=armoriq.io;
	spf=pass smtp.mailfrom=armoriq.io;
	dkim=pass header.d=armoriq-io.20260707.gappssmtp.com header.i=@armoriq-io.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=H4hDUkdU;
	arc=none smtp.remote-ip=74.125.82.172
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57621606A8B9
	for <bpf@vger.kernel.org>; Tue, 10 Nov 2026 20:24:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 57621606A8B9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=armoriq.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=armoriq.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=armoriq-io.20260707.gappssmtp.com header.i=@armoriq-io.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=H4hDUkdU
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-33fb4680717so1837756eec.1
        for <bpf@vger.kernel.org>; Tue, 10 Nov 2026 12:24:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=armoriq-io.20260707.gappssmtp.com; s=20260707; t=1794342257; x=1794947057; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=U4CgF1MujLyKKs4MDsPCH+PRIQeRT4qSq6PrwqdYMBE=;
        b=H4hDUkdUIfu1aeYFa/L+wCqKQAJ0W4KsVOg5CzXESlt1fRutvTVtYX6HvPZVIukiIO
         9ZQslFrDJ/ij82d33lbDyU4lm3hmMo6nIxPv+EklBZBOgqEKd6WpxDDNonBK91F4NWqm
         yJmBkHqDm30KDaioG4f9vYO/ei5iwzPZrlK4OEbR1x825UVqbEO5q8dS6FPQDq4qTtAO
         EOmQzGzoF64BZh8t+lpu071QWr/0F4T5s/8zAAKXsT16PiV/fwwbfXRy/WpLSVfSw3Nk
         RTAJtZNQNuRHb40nWwdtrJO/D8Fw2pGjTRmWlT3X/bRkbsBFLpqJf++BrNFyFVsupyOs
         SIoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794342257; x=1794947057;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=U4CgF1MujLyKKs4MDsPCH+PRIQeRT4qSq6PrwqdYMBE=;
        b=vw9zBBXY6ZLhVsnbN2UAfrWSqBW5qiNwE6nNkUhkDl7YHokF5LoovKrbBh3GLrICbW
         KlbDfOb+UTCha/US8HC/evY9LdrrjAAinskCUrcXMH//cHeF8+AUHz7nReNaBo/4z9N9
         a3E2oxP5Ayy10i1p2H4AV5wV1ovq4bQwEdG4iFYV0D96vCc8SJOlPYGHa8oRlkWbvsXu
         nCJbBZVHgXYJ7aNaBmlsMRHZe3U/FoBM+5iXTwLo+8esmhP+zxHs5FFNmT7/L93k2FGe
         qXFVEx/HPvwCD1Lt3UY/1+WUfIFLdtEOtknsBjp7hDMZP5vQ91rsXxWtf2CxbSrhG8gF
         rtBw==
X-Forwarded-Encrypted: i=1; AL+hErEkErAzirYf45J5H6ynKlB1tYeO34hsKhg4ijW02hwTzz12NAL8C9vzJezRLiSiPV0NFa4=@vger.kernel.org
X-Gm-Message-State: APuU4Z98uIRcpCTXaSnMaidvw9Dy8dCaz9jtHHvfh/123LHzn1H54ZgA
	3h33blNwlx85DOgg+f6OKxufbZggb2cz9yQK/t3fvuOasSSIQTXq9ox7C9GLvJaJ2EWj
X-Gm-Gg: AYBFou2pX2MGbmUqPZDWwrdyop6PNTV6m3Npu8+9tTwoA+Hwj+J7uBTkRHSqBlKHVzT
	Xp+60MFMzKnW4kbZtNf5QrrC3EhCxxa3hjLyIW6WDziIBYskekATWKhKGveHiiITmlmsb66LR2c
	1y+yKh8xN8CYvVg4LyiDMBD590ECsDe1KIk7/gEFrGm4lZFxt0/xyPBvhIuEsAJyq9jXjB8frRR
	SQJ0XGee1Jza4/6qxtuGFULsjpw/7m6bhBGCEksQ6sAe/yusVU3BbmWU9/oVAtgOgq660c+eIj/
	F6+tl074Cke3tt/38+dCpmEW+JmUxHQkuhxbA5TTQ8J+geAwDhdb22v4ylBRXh5KMLBMoDdxd3h
	aE88uhIy7mnAfN3l3YLhaKJQ5q9K1tBxJImmohxWLdilX05YDdW+KFOzeo1lHoI/+O6s43TyG3e
	iUvRVoJ6o3rv/vA4wnIB5aJhwzS1JSGPFJBLHK7gkRDcAKsI2qjo+d3MAXhBrv8QgGa7SpNGknz
	H964lltAahhLhg44iYU6JaP86SR8sm4FximqPpCv/mI7JQLBnjPHTudBa49q65+VYJIxU5ucdeW
	KmglBpnhyUYbFmfN5YjSeS3zBBVIESbmtT2Dhetlp9p3eaxV61uEzf3J6I0j+V5l/mFPizLwWyk
	66qH9exNN/n8KNP49FIKkA3DP42OVTwXfbtg9QLfp+f3JmxOfiNXaKg==
X-Received: by 2002:a05:7300:b282:b0:368:2548:c08b with SMTP id 5a478bee46e88-37685896be0mr560200eec.21.1794342257246;
        Tue, 10 Nov 2026 12:24:17 -0800 (PST)
Received: from localhost.localdomain ([2409:40f4:147:2742:6545:702a:2431:7dca])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37520cfe29fsm10076615eec.21.2026.11.10.12.24.06
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 10 Nov 2026 12:24:16 -0800 (PST)
From: "HARIHARA SUDHAN. R" <harisudhan@armoriq.io>
To: linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	Paul Moore <paul@paul-moore.com>,
	Kees Cook <kees@kernel.org>,
	James Morris <jmorris@namei.org>,
	"Serge E . Hallyn" <serge@hallyn.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Randy Dunlap <rdunlap@infradead.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	"Liam R . Howlett" <liam@infradead.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	David Hildenbrand <david@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	Mel Gorman <mgorman@suse.de>,
	Suren Baghdasaryan <surenb@google.com>,
	Ben Segall <bsegall@google.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Ketan Bhardwaj <ketan@armoriq.io>,
	bpf@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-mm@kvack.org,
	"HARIHARA SUDHAN . R" <harisudhan@armoriq.io>
Subject: [RFC PATCH v3 5/6] kernel: add KAP checks for unshare and setns
Date: Wed, 11 Nov 2026 01:52:45 +0530
Message-ID: <20261110202246.274-6-harisudhan@armoriq.io>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110202246.274-1-harisudhan@armoriq.io>
References: <20261110202246.274-1-harisudhan@armoriq.io>
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

Check unshare and setns against the bound task's authority. Neither
has an LSM hook, so they call KAP directly. Every namespace type is
checked, and setns checks the type of the namespace it is given.

Unbound tasks are not checked.

Assisted-by: Claude
Co-developed-by: Ketan Bhardwaj <ketan@armoriq.io>
Signed-off-by: Ketan Bhardwaj <ketan@armoriq.io>
Signed-off-by: HARIHARA SUDHAN. R <harisudhan@armoriq.io>
---
 kernel/fork.c    | 4 ++++
 kernel/nsproxy.c | 5 +++++
 2 files changed, 9 insertions(+)

diff --git a/kernel/fork.c b/kernel/fork.c
index eb198c8..4216a2d 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -52,6 +52,7 @@
 #include <linux/cpu.h>
 #include <linux/cgroup.h>
 #include <linux/security.h>
+#include <linux/kap.h>
 #include <linux/hugetlb.h>
 #include <linux/seccomp.h>
 #include <linux/swap.h>
@@ -3276,6 +3277,9 @@ int ksys_unshare(unsigned long unshare_flags)
 			 current->fs != current->real_fs);
 
 	err = check_unshare_flags(unshare_flags);
+	if (err)
+		goto bad_unshare_out;
+	err = kap_check_namespace_flags(unshare_flags, "unshare");
 	if (err)
 		goto bad_unshare_out;
 	/*
diff --git a/kernel/nsproxy.c b/kernel/nsproxy.c
index 3fb1595..d41d7f5 100644
--- a/kernel/nsproxy.c
+++ b/kernel/nsproxy.c
@@ -25,6 +25,7 @@
 #include <linux/proc_ns.h>
 #include <linux/file.h>
 #include <linux/syscalls.h>
+#include <linux/kap.h>
 #include <linux/cgroup.h>
 #include <linux/perf_event.h>
 #include <linux/nstree.h>
@@ -589,6 +590,10 @@ SYSCALL_DEFINE2(setns, int, fd, int, flags)
 	if (err)
 		goto out;
 
+	err = kap_check_namespace_flags(flags, "setns");
+	if (err)
+		goto out;
+
 	err = prepare_nsset(flags, &nsset);
 	if (err)
 		goto out;
-- 
2.53.0

