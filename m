Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C8B13C9C4;
	Mon, 20 Jul 2026 13:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784553843; cv=none; b=LQ4Sdtbaqiq3Lhj37trVcEPCHrGOlU9IBK4mCrNodY/EAEVWAPrOkfyIcY1FC4eyKKai0yBfqDUdcgkBHviAjY1nfXo4VJljvtMuIjIlFaMqdosHICco1OewaOgcv9+hUNRDn1uMznRFvZy+34cg73/kML1z+zRfOtnPGPkdrHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784553843; c=relaxed/simple;
	bh=NX7o9MEnwBb1ZdXMh5zfcmhcQEOlSll9tKEHjzqLS7A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Z8w4403wUeBgIEwv18kuoIavm4sR/PEDUG347oD5+Q8zR7Wki7wO5qujEJ4vDPM3wTOLpGBkZsTz+qkfHKUIcy5i1xDIVVSm/vvOBZKqYsvXVM5bbTFluuPOYlqQZYcsNVM27WFa7n6fxOV4ffrSdyMknL93hfS2pIdTMpV0u54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=WDJ4beNA; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="WDJ4beNA"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:
	Reply-To:Content-ID:Content-Description:In-Reply-To:References;
	bh=BkKV/CXdplTRXv3/Z7GA3DMv5lr0BziwgRfgXCsS3o0=; b=WDJ4beNAvQwsduVlfMQF4N9GDi
	iKsoAJ3xMPMWfpHtmsQ8qx3G7zxvvj0NaLK5gb7wdiGXoq6y4XMf8mMtMhZmzqgdc7Baqh2mzN4BP
	j4W655BXOjsSosmYNE4tmdhcjNPOQDjpliQLwQSEOxTlkmApNZvltu2gnm63lHeWZNJRNUP1C9HtV
	kIXr52sbeDSHR+YYmfBN9qif2TgR/64Lg8G0ptl3gTx4sc8n1gRWAqch3sek2GAOWOir+DBEqyI3J
	e7cHxgz+G42ZnviTZD2/sTNWh6VWJ7FkCXjAPfA2jgUqgt4OS/H0ljpmjqesK5BkFMyNfOGeEVaYr
	Un63osog==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wlnyL-001Svl-18;
	Mon, 20 Jul 2026 13:23:53 +0000
From: Breno Leitao <leitao@debian.org>
Date: Mon, 20 Jul 2026 06:23:45 -0700
Subject: [PATCH] mm/kmemleak: report RCU-tasks quiescent states during the
 scan
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260720-kmemleak_rcu_task-v1-1-5b460ade777d@debian.org>
X-B4-Tracking: v=1; b=H4sIAGAhXmoC/x3MUQqDMBAFwKss7zuBJBbFXKWIRLPVJWolaUUQ7
 17oHGAuFM7CBZ4uZD6kyHuDJ6sI4xy2ibVEeIIzrjaNMzqtvC4cUp/Hb/8JJek6VhystUP7aKA
 Ie+aXnP/z2d33DwD+DUZjAAAA
X-Change-ID: 20260720-kmemleak_rcu_task-6d3ea111b947
To: Catalin Marinas <catalin.marinas@arm.com>, 
 Andrew Morton <akpm@linux-foundation.org>
Cc: paulmck@kernel.org, puranjay@kernel.org, linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, kernel-team@meta.com, 
 Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.16-dev-d5d98
X-Developer-Signature: v=1; a=openpgp-sha256; l=3492; i=leitao@debian.org;
 h=from:subject:message-id; bh=NX7o9MEnwBb1ZdXMh5zfcmhcQEOlSll9tKEHjzqLS7A=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqXiFlo5lGAhVSbkXtGZupsBhc+o/hOqPdZnkIJ
 +B/Z5gA54KJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCal4hZQAKCRA1o5Of/Hh3
 bUQSD/9c06m08PmDxKH4FhQFDUkA5k2PwriF3G4BpAD116tKr6TOrp/Qx7fSEKsCc0+71yP195B
 yMtmuOi5wSWW0JXrMGxljEckTDoo4Y6rL6lefCgbdl6d4nH5ssLbShttd4PjwUFL2vFOyRl90wH
 1whJab+QbHm+bkvaoPbUIwoxD8twoTnXWOf8nJP6V6D8Q3A1qqjDRXA6eiI0+zg3fbICZjcN/xV
 xtlsHoqBNXhqxSsZqyBJME8eadY5OqhS0g9KoqBqWozC8vwQHD8AY0Z9sxc046141YaenpfyZCT
 9gjJxuxARdo/NG6IftpcZ0ZyJcCTA7GDmoPMtUAnskHtCh5Y2kgNlfDrtG7sAYzdxeO6I54c8dE
 XB0ZwdVVEUUnPY3V+IetXbCuEvqxqbTtqpcJMyT59Quqd9u67ol5ATyLYZqgTL4yp92zFL6aUHe
 3pn92M7KraNZ8Lbvnn+JMjC5caRw3mQed0/tBBTYqfmLpvPWlbrhxiDiH7DKRFqaMpzIhEIOg2b
 qyOVCqqVE00W0RKNAUhmRiWjDrMU9bHu3M+TXqVdnSI8RXf4SGC8ymk6Wwrpn623GPPKAsxIkcw
 Sd7lOgNErLvTBcukyL0rYO1FT06lH/AqqMcy/MBtvrIeP4LxlYd3jZoY0mHB7HHVfAEVmFtJZnP
 qrAhTeTp89a0wXA==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao

kmemleak_scan() can run for ages on large debug kernels. It was
causing some soft-lockups which I got fixed with commit
3175fcfec8b16baeb ("mm/kmemleak: avoid soft lockup when scanning task
stacks") with our beloved cond_resched().

I've got the fix above deployed in the Meta fleet, and now I am seeing:

  INFO: rcu_tasks detected stalls on tasks:
    task:kmemleak state:R ... nvcsw: 274/274 holdout: 1 idle_cpu: -1/3
     scan_block
     scan_gray_list
     kmemleak_scan

and, worse, blocks the callers waiting on that grace period. Here a BPF
struct_ops map free, which waits via synchronize_rcu_mult(call_rcu,
call_rcu_tasks), is stuck long enough to also trip the hung task check:

  INFO: task kworker/...:bpf_map_free_deferred blocked for 122 seconds
     __wait_rcu_gp
     bpf_struct_ops_map_free

Then I've learned that cond_resched() is not an RCU-tasks quiescent
state, so, we need to use stronger primitives.

Use cond_resched_tasks_rcu_qs() at the scan reschedule points so the scan
reports an RCU-tasks quiescent state as it proceeds.

Inspired by commit b96285e10aad ("tracing: Have osnoise_main() add a
quiescent state for task rcu").

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 mm/kmemleak.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/mm/kmemleak.c b/mm/kmemleak.c
index 85f18b17e79c4..f63dfacee7ca1 100644
--- a/mm/kmemleak.c
+++ b/mm/kmemleak.c
@@ -1586,7 +1586,7 @@ static int scan_large_block(void *start, void *end)
 		if (scan_block(start, next, NULL))
 			return 1;
 		start = next;
-		cond_resched();
+		cond_resched_tasks_rcu_qs();
 	}
 
 	return 0;
@@ -1623,7 +1623,7 @@ static void scan_object(struct kmemleak_object *object)
 			scan_block(start, end, object);
 
 			raw_spin_unlock_irqrestore(&object->lock, flags);
-			cond_resched();
+			cond_resched_tasks_rcu_qs();
 			raw_spin_lock_irqsave(&object->lock, flags);
 			if (!(object->flags & OBJECT_ALLOCATED))
 				break;
@@ -1645,7 +1645,7 @@ static void scan_object(struct kmemleak_object *object)
 				break;
 
 			raw_spin_unlock_irqrestore(&object->lock, flags);
-			cond_resched();
+			cond_resched_tasks_rcu_qs();
 			raw_spin_lock_irqsave(&object->lock, flags);
 		} while (object->flags & OBJECT_ALLOCATED);
 	} else {
@@ -1673,7 +1673,7 @@ static void scan_gray_list(void)
 	 */
 	object = list_entry(gray_list.next, typeof(*object), gray_list);
 	while (&object->gray_list != &gray_list) {
-		cond_resched();
+		cond_resched_tasks_rcu_qs();
 
 		/* may add new objects to the list */
 		if (!scan_should_stop())
@@ -1708,7 +1708,7 @@ static void kmemleak_cond_resched(struct kmemleak_object *object)
 	raw_spin_unlock_irq(&kmemleak_lock);
 
 	rcu_read_unlock();
-	cond_resched();
+	cond_resched_tasks_rcu_qs();
 	rcu_read_lock();
 
 	raw_spin_lock_irq(&kmemleak_lock);
@@ -1753,7 +1753,7 @@ static void kmemleak_scan_task_stacks(void)
 			}
 			put_task_struct(p);
 		}
-		cond_resched();
+		cond_resched_tasks_rcu_qs();
 	} while (pid && !stop);
 }
 
@@ -1935,7 +1935,7 @@ static int __kmemleak_scan(bool full)
 			struct page *page = pfn_to_online_page(pfn);
 
 			if (!(pfn & 63))
-				cond_resched();
+				cond_resched_tasks_rcu_qs();
 
 			if (!page)
 				continue;

---
base-commit: 0718283ab28bc3907e10b61a6b4be6fefa1cbb2f
change-id: 20260720-kmemleak_rcu_task-6d3ea111b947

Best regards,
--  
Breno Leitao <leitao@debian.org>

