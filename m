Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A375E39099A
	for <bpf@vger.kernel.org>; Tue, 23 Jun 2026 17:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782237019; cv=none; b=mr9tZH9x/4AzVDD1a8+8048QonwCjjDIgxz7nA3egfYyN6/Q8XewM0x6NFtrghEX20jkdT8ze0X1Ir4YQpXqWD51PWVu6Tlx3R+5TGkX3WVHdgAbSDmDHrlHCGtfVKtIFT7kjcLNHUvihNyumrVn917X+0zNHrv66nZeWvSemhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782237019; c=relaxed/simple;
	bh=vPK7Vn/omoySwDXOlGbKupOxZsD6+JDynojrGEu2s/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fsnDCJPZMc9uplC8rVQFZVmP7G3I1knYUfUxLk5sPI+vNXcPgQtsefiVVpKBewuWV8PMHAQ0tFQgWoL0kx9xBWn0wO0uYuvQn30/IppQBj3JoubcDS2Ps9A6tA2D/r25UEBoJE7CB7IWeHJAQ5jaB3qrfk/qA3w6yjIeO50ZWJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aIDnmo7I; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aIDnmo7I"
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-486d0e175e9so136124b6e.3
        for <bpf@vger.kernel.org>; Tue, 23 Jun 2026 10:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782237016; x=1782841816; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aJ8JjxxRbRZTB/xdTCcikhmUU/ER5vgkd+n59LPEpXE=;
        b=aIDnmo7IEhgQZ7DieB+wMJ3/kSJOprmRvPklW0Bot1KhcicPa/Z44YFVsWcltqxxNh
         X8N+Tc5tzemlSW5fadzal6jGcvDUfGnozlwJsV20JMuTcmD7PQ1TxrsVaLcB/MFDbEbB
         DIvUzP1xR8kdDJRncW/qVjFY5fV2GhTH939ZTbrBp7OF6MTEq4CbhVQEekNAXl8fbMOn
         ZA4/wcW0Fzds2+7kdhG25djg/Cw4tUdTTJad+lF2Pc3LnwjvUA7gCBwpALvDWKZBy42H
         tYosXncHiTouo2EXcBLVVm98Gh8omPZx1jgM48MMIS7fnNVHWlJiwquI8TMV8u2hFO9k
         3aPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782237016; x=1782841816;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aJ8JjxxRbRZTB/xdTCcikhmUU/ER5vgkd+n59LPEpXE=;
        b=rj2+YwAuP8b4kDNfXGONGqAv0aHAGEXldWscAaCdQexn0ztU5PQZmY7s0S6xYA5WTp
         nT86LBWxNXzvdbk5D+DvpNhS+9A384KfgfB5aDD7CLeb/GkeLF/gk+7upuHY9w9tAkgK
         RzrIBeUsHU8rt4227+kcxdUefpEaO4HiGm8uv+UvoopI6AqKFEcLGsNcyWEtb5Gycbld
         VfJlfE9ojb0eeigeYgXCG/fg1AU9xiVNJFNZzTbxdTGtwJ7MOn9xYpC+KlRlpcj++YT6
         ESIDtPY/yLME+tS6n+V/qWHY9ffpwtXnxvgI8tZ+ZNwb83g8GPtHDcZan2qEcx3PNSr9
         sE2w==
X-Gm-Message-State: AOJu0YyyC/QqlLgeNoZl+HExYrlXJ8ELBN4Y8JOctLuJ3/huBxJc8qLK
	gIgJ40su+7caP9AWxkqUv2yDN9JeyUWia8L6oXwZo86dOFxLzjk/ClDxe+1vGw==
X-Gm-Gg: AfdE7cmw9TAqFGUOuA4Re1VcXRwNErqu9fKl68bhkKSGaOFU+pzhoI+VAJblW57q5Tk
	uiyfnUqhD30zfJLXSCeLmIn/5pD/VCyuUDopZTrHoM+3L/e0Eln+uDQj/tqlMzrpXk21RCe+yCX
	/0hpamgPwO0aIegc20W4Jz3DGcnz8SSOmzWiZq5BEg72on+7SHilrl7s2UwkRNlu0FyNFGIyUGI
	0Kca5FEug8iy3cE8tVzVM/tPweJ7CthPfO0gD8+uzMfqVPxBAvLW5OD5cjKArmH2T6A7LddZ+Oq
	0oXgPvda9Qcbm5cuIyfj1arflUC/LjGhjoQasukX/mpyO8D4tjfMEmXuX2rb2okGJLhk+wKNRU4
	Y4PzaPiEc8TUla25Yw5aKxx0POx3JSTrZvCMxvtpmoyRGMMdLy787dg8ApwqKXNRWJT3jzAZCPT
	vpWw==
X-Received: by 2002:a05:6808:14cb:b0:47b:c2a2:1c79 with SMTP id 5614622812f47-4896aa06ea3mr15642770b6e.1.1782237015659;
        Tue, 23 Jun 2026 10:50:15 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:6::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-48aedf23f7bsm7180537b6e.11.2026.06.23.10.50.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 10:50:15 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@kernel.org,
	shakeel.butt@linux.dev,
	roman.gushchin@linux.dev,
	kuniyu@google.com,
	kerneljasonxing@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 05/15] bpf: Replace prog_list_prog() check with direct pl->prog and pl->link check
Date: Tue, 23 Jun 2026 10:49:53 -0700
Message-ID: <20260623175006.3136053-6-ameryhung@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260623175006.3136053-1-ameryhung@gmail.com>
References: <20260623175006.3136053-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Martin KaFai Lau <martin.lau@kernel.org>

prog_list_length() and compute_effective_progs() use !prog_list_prog(pl)
to skip a 'detaching' pl.

When pl->link is not NULL, prog_list_prog(pl) returns
the pl->link->link.prog. This does not work for the upcoming struct_ops
patch where pl->link is not NULL but pl->link->link.prog is NULL,
because a struct_ops map is attached to the cgroup instead of a BPF prog.

To prepare for the upcoming struct_ops patch, this patch
replaces the prog_list_prog() test with the
"!pl->prog && !pl->link". In __cgroup_bpf_detach(),
both pl->prog and pl->link are set to NULL, so testing
"!pl->prog && !pl->link" is the same test to tell
if a pl is being detached. This change should be a no-op.

Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 kernel/bpf/cgroup.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index b64f6757096c..b100c04cb9c8 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -408,7 +408,7 @@ static u32 prog_list_length(struct hlist_head *head, int *preorder_cnt)
 	u32 cnt = 0;
 
 	hlist_for_each_entry(pl, head, node) {
-		if (!prog_list_prog(pl))
+		if (!pl->prog && !pl->link)
 			continue;
 		if (preorder_cnt && (pl->flags & BPF_F_PREORDER))
 			(*preorder_cnt)++;
@@ -482,7 +482,7 @@ static int compute_effective_progs(struct cgroup *cgrp,
 
 		init_bstart = bstart;
 		hlist_for_each_entry(pl, &p->bpf.progs[atype], node) {
-			if (!prog_list_prog(pl))
+			if (!pl->prog && !pl->link)
 				continue;
 
 			if (pl->flags & BPF_F_PREORDER) {
-- 
2.53.0-Meta

