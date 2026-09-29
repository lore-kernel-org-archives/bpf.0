Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E49C380FDD
	for <bpf@vger.kernel.org>; Tue, 29 Sep 2026 08:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790669791; cv=none; b=V0UYwKPxjEGmy+XFxK8+Lqmws8cLElwDs8FQPiQjuB/HpYFA5Kmpfebua3xBPgoqKj6uH+vx6eXSCGW+3VLF1x+pHyiIBcrx6BQ0+J12t8OkNkIENs0u7jQcIMCjYgZZb7nAshKlF4jTbQJ16uWzxzaj9r6bmgZSozRL88oL1sI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790669791; c=relaxed/simple;
	bh=Sz1JmCKBZu7fltXb2NbvPIDp3GGnx7GfjB0icQIxMP4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EyPRpC9DKCX2WSDsGix4ZYpgigJuqPClrXScLOKcPcTBGDTYIyam3OnetW1RpgIwfTfMU3A7NVQxCHL0j7MKknAQyAkpZTsqaj/SUk1CjhKgjstwI9NnKLTMH9krJcYAj6PntrQ9ZckVOvAYbibI6MmLKQSfYEuWpcbZ8CFbhgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y8rcy+m6; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y8rcy+m6"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49ffbd83a92so21406845e9.0
        for <bpf@vger.kernel.org>; Tue, 29 Sep 2026 01:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790669788; x=1791274588; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DneU6OYsM/0OepyIfW6Zz603NV6AMxXwLJIXPeol2ys=;
        b=Y8rcy+m652p0mlgwK7oPpdOWivZQ2H6f+qakgFL1LKSn+jsQXBkM8kbsxCJr6ikgCQ
         sjq28b0++Hhszwkr7JMMycq3oIGsLVAY9+TilfzGoDcZlNhqROpLuABymg7EHr3qVuvT
         QWQM/wFi/0ncEOkgRzf0YvF91NIwsU7Xt69RcPWVx8Q+3O1L7SG/UJfesalkc+JHrSC3
         oQvSB/FW+ZDdJ2cjIapKv2JbGr4DmHC9B6RxWjSAfWECccXo6grEVAQ0URpc2iLlFoOI
         VEbF6l6RsKpMFBBnam0r1wUOu9yT+EIzMBVY44j9Vmt+G24/LxWq4VtHKkd8k+ojroIb
         57eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790669788; x=1791274588;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DneU6OYsM/0OepyIfW6Zz603NV6AMxXwLJIXPeol2ys=;
        b=vL23qKcrwsKBulXCkyF+wpGEsHMj18SyNDexn3PNTuAN4abuqvng1XhgrVNvsAFPCH
         aBfm3TMTE1zM7EBTFpptzlpiaPRNigp1o4GwyoJV08N2wLrnwOk61uSEhBeqQQlFCeC9
         c3Qkp4cqMAHFBvkbwKhbssB1O0xAdrewjIdNfEW/Zbr5Y9KY8ih/kD+sAk7mvdnTcQHX
         ocFnWpWQaZNFV9Wfrxwpt127C8bcs5ei3nY3WAsbg5iPOhWgDqkAg6hX99e2cJWn/qji
         PnPYnCu9qe5fqJloltRSkMoCS6DhqdOQK79oK/6dmIIF4tj1sEwO7i3UnH6qzbJ/n9TV
         Qjqw==
X-Forwarded-Encrypted: i=1; AKwUvBwjJu6pTtC7ptJTEwB6p4PFRIp35UXSDSUSoY7LjkT7kBZ2pxjV/AuxaB2/4P1wAhIPJYs=@vger.kernel.org
X-Gm-Message-State: AFuF++n6Ly5leg+RQl3nt6FyAZR0nyIHWq15eukGojWtjFYNTy/XLAWU
	tPi9tu31slxRRko0y0AkiEm5Oc1zcDlEm0rIVT/L+nwVEv/YQtodTt/W
X-Gm-Gg: AYBFou2aY9YOtOGixJbpYJjqbyPYl74xR2ISON2g0I4VcMTykI/MrjTrRNxT+t7vNhN
	EIuD74f+8CASnvUN4ncmW3RtZMcnZy+TsDq1geskUiFlchtXZ/BhSZv43m8fyo+qxUJHAn1j1gT
	kc0c1tEo8BuYagJeZZfGIeuzcIzTIduJ+NyF5AWO/V23PX2AQbOroVXRp8Z1dx6Oovk8XRDhg08
	xS4jpU9003ujxoAgEGUIsDV4lCyP3zyllioiMR9oBonjUZl9LYJ5fJjPR+cpxXX446wFgj7rtag
	fgMT7fXRpZ0QwLi6IudCWg2/LXCxv2bPmZqEQIAPyZCijo0FSur07CZLl8GeXpVSogzDYSLFv6z
	UcYIi00CCx2tP0V7ekoVhJe0MBg/VZy/jmEw9UlHW73bpOH8pVbKL1A2gZGge/pqDkFdSDoNzkg
	b3oEkswBgv3XjAwPt4LQf1djrW9ScqmtcXSD8ulVHKXYZyAat8jwwC1yuBDLhDWnjP+erWKzDx6
	d4d8SM=
X-Received: by 2002:a05:600c:310b:b0:49f:bd3c:bc18 with SMTP id 5b1f17b1804b1-49fe66f4c72mr267527685e9.19.1790669788138;
        Tue, 29 Sep 2026 01:16:28 -0700 (PDT)
Received: from metepc ([46.197.185.71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a00d453badsm38333395e9.2.2026.09.29.01.16.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 01:16:27 -0700 (PDT)
From: =?UTF-8?q?=C3=96mer=20Mete=20Kaya?= <omermetekaya0@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net
Cc: andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	ihor.solodrai@linux.dev,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?=C3=96mer=20Mete=20Kaya?= <omermetekaya0@gmail.com>,
	syzbot+fd7e415d891073b83e1f@syzkaller.appspotmail.com
Subject: [PATCH bpf v2] bpf: Fix missing migration protection in __rhtab_map_lookup_and_delete_batch()
Date: Tue, 29 Sep 2026 11:10:34 +0300
Message-ID: <20260929081609.557899-1-omermetekaya0@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

bpf_mem_cache_free_rcu() uses this_cpu_ptr() which requires migration
to be disabled. All callers of rhtab_delete_elem() disable migration
except __rhtab_map_lookup_and_delete_batch(), which calls it under
rcu_read_lock() only.

On CONFIG_PREEMPT_RCU, rcu_read_lock() does not disable preemption or
migration, so the task can migrate between CPUs during the delete loop,
causing this_cpu_ptr() to trigger:

  BUG: using smp_processor_id() in preemptible [00000000] code

Fix by wrapping the delete loop in migrate_disable()/migrate_enable()
in __rhtab_map_lookup_and_delete_batch(), matching the migration
protection that the other callers already provide.

Fixes: 818e00848227 ("bpf: Implement iteration ops for resizable hashtab")
Reported-by: syzbot+fd7e415d891073b83e1f@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=fd7e415d891073b83e1f
Suggested-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Ömer Mete Kaya <omermetekaya0@gmail.com>
---
Changes in v2:
  - Fix root cause in __rhtab_map_lookup_and_delete_batch() with
    migrate_disable()/migrate_enable() instead of stretching
    bpf_disable_instrumentation() in rhtab_delete_elem().
  - Fix Fixes: tag to 818e00848227.
  - Fix commit message: migration disabled, not preemption.

Tested with syzkaller:
  - Before the fix: the reported warning was reproduced reliably.
  - After the fix: the warning was no longer reproducible.

 kernel/bpf/hashtab.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index f744a42bb813..2bb9ac7fc73e 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -3369,8 +3369,10 @@ static int __rhtab_map_lookup_and_delete_batch(struct bpf_map *map,
 	}

 	if (do_delete) {
+		migrate_disable();
 		for (i = 0; i < total; i++)
 			rhtab_delete_elem(rhtab, del_elems[i], NULL, 0);
+		migrate_enable();
 	}

 	rcu_read_unlock();
--
2.55.0

