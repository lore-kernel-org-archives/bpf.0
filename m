Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795434295;
	b=Jei3MlEtq78I3g6tQGHnc42cBaeaxzbjB+gfJtQ5I6yTxz2odG/i7Gx0hg1YvD+sAlwy
	 eqHbywPOJNJ04jF4zlJmoN0bymyAORGapyssXov1hD/RPqYAfAAEMmTF7Nv5rfQ6iAODA
	 xVUmzdLm9i2+DBrP/EDyPJuiTg2ZqV8iWpU+jAsMgqf8oalMrmM/2S4bZ2kRWXl4oojAY
	 NFwkk7K/BakwFfdFwWKnPsgD9WvsEvnIL0hOZzILQHFH33gFNGS0/gh7ELGdT11btZFKh
	 8+z9lJ9mwzsaLEoORCysQsvTthBgMlupVWgpwy5XCA6k17TPhRN7Pak4vurSmlQ7mgQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795434295;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=wao1lDLNbUFd8H98o11hNOXj6BtvvuLII7zQ8aDHCoA=;
	b=gyB9BxyaQPTE9IjfSBIxobwGCZhkzhVTsG2yENfzmgznezXqI2XvohBHXpBVMGukRLnF
	 de9iLUhitwBcA7W97bGcBQyMiVbAvXiSjT7RKgeN2yCWzADCu8X5qEU0REwm+F5bd0eqD
	 lDTDamIDskUCSNZImSL5RJ5XeAwS0MD+6jqgKS7gN4tvHJFnqXAfiegvUqOzA+nsqNh0u
	 p/x7Lzakho4Xkqw8bScPAD0f0wNb2Zb0wWGFb6oTL2CCsL6uzgE75Z1aqP3Wz3c8fGcWA
	 rzFDOuPUo8JKrwSd7DNrqTfnkl9wshgXRAWezJZ0yl1bf+ZX6WvTempzfHjb9dpX1xA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=armoriq.io;
	spf=pass smtp.mailfrom=armoriq.io;
	dkim=pass header.d=armoriq-io.20260707.gappssmtp.com header.i=@armoriq-io.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b="uX/T6Jvp";
	arc=none smtp.remote-ip=74.125.82.178
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 449C4606A31F
	for <bpf@vger.kernel.org>; Mon, 23 Nov 2026 11:44:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 449C4606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=armoriq.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=armoriq.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=armoriq-io.20260707.gappssmtp.com header.i=@armoriq-io.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=uX/T6Jvp
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-380b40312e2so7721981eec.1
        for <bpf@vger.kernel.org>; Mon, 23 Nov 2026 03:44:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=armoriq-io.20260707.gappssmtp.com; s=20260707; t=1795434294; x=1796039094; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wao1lDLNbUFd8H98o11hNOXj6BtvvuLII7zQ8aDHCoA=;
        b=uX/T6Jvpgqm1tJlOq8nd1n3yBngZOJJsWljAE8ngjJ67WjO4XcppJpZfI9LcuZjO77
         QMzuIZtP23iIDtYgHN4p9h1zhO1JKDoGN4t6lsyrSG9EDI3t8GTLyjWGhV1PTfVHB+54
         CUxMOF/uoHWZ6c+JuONYE2YtLDmoxCSwGiCsTZq8ENXKvGGBaYamhtETB4BBmyA2qkRz
         p6drrH4nAoZe+ndXq4r9t4H7kpC7P/4t4v7uWGf66RqWNJtsK7aEDadnMhewlwC3KNS5
         YPnUzwofxCDqc3rgq7ybcAhFbhK0oF16fThefr54y7ipHGq+t3sdDMOYzVAaj3L2BDlS
         hzOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795434294; x=1796039094;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wao1lDLNbUFd8H98o11hNOXj6BtvvuLII7zQ8aDHCoA=;
        b=e1mvk+Ies4KC/jw2qyklHE1GfL7qvcI7w1fLwGqoqtbN9qoNESTLIiGHHrQfJgmH6q
         w9UiL2rcn55LZecFyVYZXRKqueJqXjNKCw8hIztPc0uxFMAPK/VTRa7xRU75PJR9o3Nd
         aOXzyWGbtWYa4VvX5NEmk7lXjUB9TahiCrsv8LAZcJqFK8QLJ1ewgEkVuTCw6uu9CNo7
         2vLqqzvnz/AwTfHoHe3nDs6iVRc7559exsKsap/R1gmd/AJ1N1l+m0q1nUf4RnMGJlvl
         gt6kn+bp9JW2A/gR25UYP1qzoBFlR18/zAV056DZgxYAxniPtqI9lzSAwuIJnG0QThpE
         EvTg==
X-Gm-Message-State: APuU4Z/Z/Lu/ffs/UVdiZTcBHnYWyxLTablAPsqiRpWHBmYo3uHjBnHE
	NLmWiVzzXVRQqt70U8pFQfY+kP3A8//eoYS7m4lPQjc4oo/dDGDIWEdp7c5J9tvmECqjaEI7P9H
	ki3AdcLYB
X-Gm-Gg: AZFdTZcrWKWZlBnTFpwGrL0Gj7Ajc2X2FsJp5MQV7vld7bAKNwagE+ViGIWIOf71zLz
	qtcgUX2ipYTZOe/Fc+rEAEMrp7AwGUwfwMPUk/40ETecLfD+t1X9NmGR0saDrnFOv0tbMk9OzEe
	aJ997Q7YQufMsPUhaoNwESFHytzR9IAXcF2CVzsdMtm/eQcsDLleY21Zhrm8rnIy8e1OI7BE6eN
	G62f7XWb8TdOm2pCOWV2fjerzpHf46v4c9GrDW0of2V47Rs3se3jtXqWAEuWoFhd1TnCfepphFG
	K1rgC1wltK5eG5Zt68N83AMXbQiX1YHPouUbXTiPHNofXBlkkV+5IRdj91oL27jp8glctrOKzYs
	3+elFwV/tnH4doFAObY76w2tLX8JkMomQzun3tvxGMrxliOCgZQhk241UWbejQdF8Izmv23OA3y
	vTIfP/Z9GF7JIAU980EykXTtpBAJMN74GH+zjAJsJtTyKYZXsGkNCqpzj6PCf0Z3clB3INFtj5n
	oMCI9KbyFQCDQpY0eXhFZ0q21aYI7yzU1/tSVlERGVWUtFX7S3x3krKx0On5tLDJaL0v3coELKX
	iJJgty6pzrUL2z8Vn0mz2g67+gyAp2He/SkUZVYVHqtfV0Py9hp5c1YmcRuE9s3f3j1mfJNTwUi
	rf5Hh9G3yMunn3SV587NM56bvGjLhoopRExr3AtW4vfrKXIaQPQUPkw==
X-Received: by 2002:a05:7300:f797:b0:386:95e7:848c with SMTP id 5a478bee46e88-38695e79009mr9525592eec.7.1795434294209;
        Mon, 23 Nov 2026 03:44:54 -0800 (PST)
Received: from localhost.localdomain ([2409:40f4:14e:94e0:654e:d7ff:13d2:447d])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-38566cd40c5sm41943583eec.10.2026.11.23.03.44.43
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 23 Nov 2026 03:44:53 -0800 (PST)
From: "HARIHARA SUDHAN. R" <harisudhan@armoriq.io>
To: bpf@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-security-module@vger.kernel.org
Cc: "HARIHARA SUDHAN. R" <harisudhan@armoriq.io>,
	"Liam R. Howlett" <liam@infradead.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Ben Segall <bsegall@google.com>,
	David Hildenbrand <david@kernel.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ingo Molnar <mingo@redhat.com>,
	James Morris <jmorris@namei.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Juri Lelli <juri.lelli@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Kees Cook <kees@kernel.org>,
	Ketan Bhardwaj <ketan@armoriq.io>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Mel Gorman <mgorman@suse.de>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Paul Moore <paul@paul-moore.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Valentin Schneider <vschneid@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Vlastimil Babka <vbabka@kernel.org>
Subject: [RFC PATCH v4 5/6] kernel: add KAP checks for unshare and setns
Date: Mon, 23 Nov 2026 17:13:07 +0530
Message-ID: <20261123114308.8103-6-harisudhan@armoriq.io>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261123114308.8103-1-harisudhan@armoriq.io>
References: <20261123114308.8103-1-harisudhan@armoriq.io>
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
index eb198c8df..4216a2de3 100644
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
index 3fb1595a4..d41d7f5e9 100644
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
2.43.0

