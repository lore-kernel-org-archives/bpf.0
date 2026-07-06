Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D77713B7B93
	for <bpf@vger.kernel.org>; Mon,  6 Jul 2026 17:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783358375; cv=none; b=HLja50w4yRX/ruuFlCxLBukSWVi3R6+YJneHU92qQsx9Vmrp31AKGdtza91GDNRNcMR2HSCxenwnztcKXn57v/Ek0wCOJxN45e9q6LHPEVBkD9WMt5r9dgKN5f7O9C+JCXk9cWBUyyCeZQ6OpB3Sm/TanvfqesC6OYG/kuQ3yss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783358375; c=relaxed/simple;
	bh=GOAtJKCzwiblZs1VJ+WSQarZsvZ3QcT8bQEfgh6ksYk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LGy1e+fbR2AWvPDiaYatWWXmurTB0K/kH7fIuwKZOKlc69qywC7I4R1axCXyGRKQ3sqf/TSDSk47PR7CU06j/oX4MG7s/X/i7LvGMeT0wBlNh4DW8+psldH+fJJIUaKrvUgiFcN2DVWHaRvzsw0rNIN7XNtXkSDf/5RckJO3fh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UfWR7/kH; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UfWR7/kH"
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-6a19a5691bbso2307568eaf.3
        for <bpf@vger.kernel.org>; Mon, 06 Jul 2026 10:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783358373; x=1783963173; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GBIsMFu08y+xjMRxdkuwbm8NAaYbn72hr3Au+U5gJ8I=;
        b=UfWR7/kHtlXsEZw9RHfqUVxe6hEHBsDlRFbGWY9IoA8aFMlk6EMp5LSl5GqGaGcc8R
         Eiz74vTxbRKZ0v+tbry6hgtvHP/PQpI5ejEVMyWKj1ErmD/lUjixfAB3oqrwEvHsbQBX
         CAguJWx4YvH1Yj1C8GnRitC5dTzXAqUe6GG59/ZPkkmwxrv+j1pE5EHI4t3wwn23+rgZ
         33SqrUj9+6ej6yuWpu9oqhJn3BDTKuwOK2MFEWxbCGBmhXOOcNAfD/rUG/VJgVHJcC3N
         GB2bjYjLHQSYeAh6eN+v1OoPUEfepMN/ZdEkCLqovzxqow4XNMfIUdkGjrECdKWEFvD4
         j5eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783358373; x=1783963173;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GBIsMFu08y+xjMRxdkuwbm8NAaYbn72hr3Au+U5gJ8I=;
        b=DnDHEr8HeW7VqUVFCZ/uhYEKlacaeIUbYy5sQh0JU32Pu3LYKHxfDtnFXa1WXL90zz
         cxl+730KaaG2VF8prXdxyE1fh4oxZTKY56nPG44SiWi6OVoSkSwTQAVctySoN0Oe6HTc
         mL4PYPPHxjmPUGCWsLZiSTRSgTLMhhNJnnstwNACdOfp5Z41Jmf9yv8BLIlk2W5RpU3z
         qY8J6bim6dxl+/mtWmJrZfvANvO7HXr9cgCF7MAM8smYFFEaE1APw7JB9sTF0nFp3AUy
         MJ8lCkNLEzRdA7r6JLvwSom07wxJ6GIh6gyLgT7aZc0nLLr6nrOXyDP+b6W1KWly0+En
         qGmg==
X-Gm-Message-State: AOJu0Yz94uFzQqm7lx7xCCbo50YBYLp942lKqPAJuzPKbAi24kVkzg22
	2WIEkEWXykGbqO9B0Be1fsc7eZC274cr3KofvPAM09RHLXH4M9QbEkoiNgvyYw==
X-Gm-Gg: AfdE7cmZG5H4bg0exy6jJzXCt03EpduZvuhDvTXJAUS9cotplas8pjbi4HtWUGVCnea
	qsGlGZjBsWh3JLZin4+SkgshToN1I6NpBzVJ21WLYx3lR1cYRp5cCM7rPo4MBT2x9alxiQcXmDF
	+xLexZul3+WpcwXw61CKDI/LFyh0qPOzK0tKNGNn8wDLHvjWbIBrXTGPqf4GnnNt47pVrNUwAKJ
	3RN+EI3gJwxxyuMk/7hBwzoJuxCFxtElmNJI4vCQHGHz9YfuwIQB5FPxsxj51YJ99O3G1O+wq0a
	q8z3yH5pp03PDjof+SqOwg8dBKyeVRCwCYUOKm5oPLDHI9yfIwfrKW3kcBZ9BrrkeU7LYUpan1a
	IqPWOVbJ2C7HdK2UgzchPBS5H7tKbuyEMnDFlqyDQl+1nU+U6wu4+HycVUJYQzKh5lGd+wvZAqz
	8+2g==
X-Received: by 2002:a05:6820:4d06:b0:6a1:50ec:440b with SMTP id 006d021491bc7-6a3556e9ac2mr897770eaf.72.1783358372570;
        Mon, 06 Jul 2026 10:19:32 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:6::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6a310375f72sm9721786eaf.10.2026.07.06.10.19.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 10:19:31 -0700 (PDT)
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
Subject: [PATCH bpf-next v3 05/15] bpf: Replace prog_list_prog() check with direct pl->prog and pl->link check
Date: Mon,  6 Jul 2026 10:19:07 -0700
Message-ID: <20260706171918.317102-6-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260706171918.317102-1-ameryhung@gmail.com>
References: <20260706171918.317102-1-ameryhung@gmail.com>
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
2.52.0

