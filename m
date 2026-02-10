Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 029FD303A3B;
	Tue, 10 Feb 2026 21:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770757531; cv=none; b=JQ9H+iWpi4YZrm/CgBbE/malaZEh2Z4t6hX+zRuIdXll9Y87gZY0TOHNYu4p7/9g8GD8YkWvmcgBE+VXXBBeq7GFxfEGqX05HBqZqTxOYRJc4M7nS15mi7klpY65B21pSiITfjmlCuRutpxg4QJdDhpi+W2vHZNvmo92C6RSUEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770757531; c=relaxed/simple;
	bh=nqsMeqDyha2V5IhVyoL07zcaPQjl+ZL5cDfvW4eff2s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=b4JzJMXWD45V4ER84qocxmNoz1ZQFM0UDQBLy90U4Qgyz0JTgF41RwFAyESND/Pu5M23xVhAsGD3wMlSzjCrfQKhY79LrsJeQq4I+ru0OLMiwfq4LrX94qc8W2XXnrG4EixFhfwVbxze35ETCfvgluljATssqM2K+BGo53oUQ+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ADuNhG93; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ADuNhG93"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25DDBC116C6;
	Tue, 10 Feb 2026 21:05:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770757530;
	bh=nqsMeqDyha2V5IhVyoL07zcaPQjl+ZL5cDfvW4eff2s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=ADuNhG93qnX1UMCAlhCvKko/xuwPARaQxiiVHgqAan5EmR6Der+UN8viz6wISZtyp
	 C0BYsSuhWpiNKw1jjnbvwr7is4CCN/Xnann6XcVmvuvWAz2BkHmG4Zh6TiXFvTApuC
	 OUydoUvR28sMoPf+KB+kZZnuFx85AiMlUgsBwFArc+dUG8OABfIyo1YM5ahDyAURzY
	 MYqlg9qhs2nbv5inCe+OPcA/KTwoSb/oBSSLQVMpvSM93KsQBUvJPfHK9tniJosW5f
	 dpXxSaio3TflnBxAXH4MYhlAptBWZpxR6XymTegWDYfoCgviUIL5W7irAWzL3sdYzy
	 rWhMNrgb6qeAQ==
From: Thomas Gleixner <tglx@kernel.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, akpm@linux-foundation.org,
 linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, bpf@vger.kernel.org,
 surenb@google.com, shakeel.butt@linux.dev,
 syzbot+4e70c8e0a2017b432f7a@syzkaller.appspotmail.com,
 syzbot+237b5b985b78c1da9600@syzkaller.appspotmail.com, Peter Zijlstra
 <peterz@infradead.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH] procfs: Prevent double mmput() in do_procmap_query()
In-Reply-To: <CAEf4BzZHktcrxO0_PnMer-oEsAm++R4VZKj-gCmft-mVi58P8g@mail.gmail.com>
References: <20260129215340.3742283-1-andrii@kernel.org>
 <87qzqsa1br.ffs@tglx>
 <CAEf4BzZHktcrxO0_PnMer-oEsAm++R4VZKj-gCmft-mVi58P8g@mail.gmail.com>
Date: Tue, 10 Feb 2026 22:05:27 +0100
Message-ID: <87ikc49unc.ffs@tglx>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

A recent fix moved the build ID evaluation past the mmput() of the success
path but kept the error goto unchanged, which ends up in doing another
quert_vma_teardown() and another mmput().

Change the goto so it jumps past the mmput() and only puts the file and
the buffer.

Fixes: b5cbacd7f86f ("procfs: avoid fetching build ID while holding VMA lock")
Reported-by: syzbot+237b5b985b78c1da9600@syzkaller.appspotmail.com
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Closes: https://lore.kernel.org/698aaf3c.050a0220.3b3015.0088.GAE@google.com/T/#u
---
 fs/proc/task_mmu.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -780,7 +780,7 @@ static int do_procmap_query(struct mm_st
 		} else {
 			if (karg.build_id_size < build_id_sz) {
 				err = -ENAMETOOLONG;
-				goto out;
+				goto out_file;
 			}
 			karg.build_id_size = build_id_sz;
 		}
@@ -808,6 +808,8 @@ static int do_procmap_query(struct mm_st
 out:
 	query_vma_teardown(&lock_ctx);
 	mmput(mm);
+
+out_file:
 	if (vm_file)
 		fput(vm_file);
 	kfree(name_buf);
