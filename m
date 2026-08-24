Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA5FE453A50;
	Mon, 24 Aug 2026 16:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787590613; cv=none; b=cLUBbHfoDPP9yLtU5qebEITqOtCFNc1jkpm8P8ZjURK4wMmviCAsteDiSqTgScNR5Dopi2p+TampZtfxNIcNcsZHdRAQot8JFjgeIE4I+PZduT37kXVV5sZWLme7MryOgb9tiRAE0V0F8ueZMlyV+HX74RDzecglrvewjUGMJuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787590613; c=relaxed/simple;
	bh=V2A9Axf7eE9xL6yG3yuTTEdXmEZ+WMWwbGsBsB7Lq3Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ZWwj39FeQi6ZLi2oVvxKHybYfTkVkVjaq2FIE7sq2DOtCquL80LiL7TbrSHy4GwCB6wy8F5Xo6cjgm4BXwDmdfsCDsHQZUesUjfNc9l0mz3s1Byc4vIRGkaaIqkKctuq227dGzAzwerwCgavpJ/BWnBsysf9IU/2VDLjzC1Zdy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=Vvo8cpbR; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="Vvo8cpbR"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:
	Reply-To:Content-ID:Content-Description:In-Reply-To:References;
	bh=ZJEJt/1OFWocyoYWJNDaWaIZqTVtqPtpuU0Zo1lyjtU=; b=Vvo8cpbRbyAYE8L00wPMZX1yqJ
	9XdWTZd37kxqYV7o7+O6XVBwARSseFhLdYSaaZ/UpkWPj/xK+v12Zv+auZ09gAhSd9nPqHeGTPf3i
	+iRn75M5sYUZ72wKrxICOIRinH4MU9teEtLnZYqmrBKCA4FUxRO6ZDKZ8Ak/PDVEq9X+njGjdYFiR
	Twy7X2M+Mv5gEbULDxqPZ6bE9fRCZXHoAF+TWl4FoP/FL1+lw4htbNvGBK3fxD3YVXRWzDGoOdqee
	X9n02NAMkc+StJYX4ZvIXnVkBSyrzDxqfr136PQ1yfFEZMB0r7kK4eDHvMFR/frcNxN4W2CNiZWDa
	QAB05kRQ==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wyXyX-00DoHP-1B;
	Mon, 24 Aug 2026 16:56:45 +0000
From: Breno Leitao <leitao@debian.org>
Date: Mon, 24 Aug 2026 09:54:10 -0700
Subject: [PATCH] bpf: arena: reschedule while freeing the arena pages
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260824-b4-bpf-arena-free-resched-v1-1-5c447477a64b@debian.org>
X-B4-Tracking: v=1; b=H4sIADF3jGoC/x2MwQqAIBAFfyX23IJJRPUr0UHtWXuxWCEC6d+TY
 C5zmCmUoYJMc1NIcUuWM1Xp2obC4dIOlq06WWMHM9qefeWK7BTJcVSAFTkc2BjWeGfgx6mbqPa
 XIsrzv5f1fT9uZI5UawAAAA==
X-Change-ID: 20260824-b4-bpf-arena-free-resched-e20ba0eb8919
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>, Barret Rhoden <brho@google.com>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com, 
 Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=1642; i=leitao@debian.org;
 h=from:subject:message-id; bh=V2A9Axf7eE9xL6yG3yuTTEdXmEZ+WMWwbGsBsB7Lq3Q=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqjHfJ5K/n/Y/pBhTVoT1tzqS8PjxMSdeqOKi1A
 U2cB/3SAcKJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaox3yQAKCRA1o5Of/Hh3
 baKNEACM6DG2tpGJCIDtriGaj0W47AQn+xNwc3HcIsPv/hCCUi5NqYnM3/3AiyNbz4qMSoAn2nx
 3IvebhCYlolZ/P6YUmI93AbSeppPleha+bcSUW7uqdeXX4olssF6b2jO2aDpbem9y3Tn/FCdu8M
 RHQVZgLlr/6aswv6bcLLYIxNf8F+9hMib7K58oP/+z8qMRunWcDcz7vLR2UQLbbzbLwnp3kCef3
 EEP2/R3vRs9Fsicd311VSh9TkHw5EDkE2w58aVS1MCpwpwMiaI5xl2Vrx0J8B0KtzDPpuc5xlIQ
 MDhGbo6aL7NaBWnC+HXrO5Ql7EWW6rbJi+2bmxuN1G6FBRvLQjVyBQV+AaGczHtbqMARsyTEq1D
 LaLkP8sOJFQGJrH5DgdBK1Kr5pTnJRSLspk/P2q7+xZ3uO3zOS11VpvC+rlskXngfA1QKxK5HCf
 uz1PGRSAKBorOqVL373wRQ8m/eB3eHiMiozVUy2K+cqxQO43TlDXsgZpjHfaM3D02ymtHGLROiT
 1KjwwiPYdQoPKdHnEuRdpOqMUUt/2Ie2qQkl8sp30imats+Ai+yY6pU0GTkMBvJNml0P1OUCrsn
 2zbvYj4zRuomto7FJEEXMsIZyIs9iuipGa5BfehkPEnITBzNfktrnLcFGwcC8gYOvq60iUWA6dU
 kd4nh9Tbf/TxmAg==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao

On non-preemptible kernels that is long enough to trip both the RCU
stall detector and the softlockup watchdog. Observed on production arm64
hosts at Meta:

  rcu: INFO: rcu_sched self-detected stall on CPU
  rcu:     37-....: (20999 ticks this GP) idle=3834/1/0x4000000000000000
  Workqueue: events_unbound bpf_map_free_deferred
  Call trace:
   __apply_to_page_range+0x404/0x518
   apply_to_existing_page_range+0x18/0x28
   arena_map_free+0x54/0x98
   bpf_map_free_deferred+0x70/0xf8
   process_scheduled_works+0x17c/0x400
   worker_thread+0x198/0x498
  [...]
  watchdog: BUG: soft lockup - CPU#37 stuck for 44s! [kworker/u288:15]
  Kernel panic - not syncing: softlockup: hung tasks

arena_map_free() sweeps the whole 4GiB arena address range in a single
apply_to_existing_page_range() call and drops every populated page from
the walk callback.

Give up the CPU after releasing each page, using cond_resched().

Fixes: 317460317a02 ("bpf: Introduce bpf_arena.")
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 kernel/bpf/arena.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
index 7b6847200b431..c5f6bebbb15c3 100644
--- a/kernel/bpf/arena.c
+++ b/kernel/bpf/arena.c
@@ -364,6 +364,7 @@ static int existing_page_cb(pte_t *ptep, unsigned long addr, void *data)
 	 * the freed page. So it all relies on 1.
 	 */
 	__free_page(page);
+	cond_resched();
 	return 0;
 }
 

---
base-commit: 0a0d1d55dad570724bf8c7ea83409639cfb4be9b
change-id: 20260824-b4-bpf-arena-free-resched-e20ba0eb8919

Best regards,
--  
Breno Leitao <leitao@debian.org>

