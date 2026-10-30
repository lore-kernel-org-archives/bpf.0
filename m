Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793361196;
	b=OATxrwGcbID1tmtOaGghA6mj+yRInG/7TVPCsR685ihu92rcw3PXR8uz5KNNMW1SGoai
	 AJEZ2W+u52aKqTthlKVA7U+FTYqbCD7NvmvFfsKPp0isitKv76tZUHpV80Azjpd42zC1c
	 qJqhXi6SJi3xcvco8YtSCw4AJ4VBWwU9gcF9JHuzl8ZCeRbSmcxDx6AUnbfq6v1Rootgp
	 Gnoe3gsO7XMJSNS+tiRFkqC599xYGKigJfobmBT4Sd0fxoB21a8bX2d1aXSx7lJKLUAxf
	 WKm59l4fjbYIvzPO+kblvNceg0xVc2lyp/4blR7xKwW5rOCub8n7ow49FUX6iXQcCcA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793361196;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer;
	bh=7RaPea1Qjt8hsmpjEa8tMwhSJ3KypYa/1YHVOL45aDk=;
	b=bBAe45fq/PaHzZFGdtsYKvVwTIXBWTt5r1yfdMjCsmxFWKQV2E1ORgR30ygIkXqV4nOy
	 QvqpFTT9i5HrmdMr3YkKQQCjRIIfXZ76oDYw452sfujrN83i46MoeYYMVVN/QwjUlVtlg
	 gzyX8rSPWpy0DRhBbaww/WMoY01UFIjZD6DzrtLu9A/SRqH3e1MuQ/w/2exLfmCrSZ45e
	 9JTFfabq4rGhQWKDdr4kS5R2Cfq04vEqiccHqekFAVAD3HzI4ecUiyM5EYAIWtLZriy1z
	 tiKnDZtuBAxkYG9onjryhRc9rgD4oBq6zfW/opcx4ZoAvkPBcVyrNNykCz4E58tYStg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="RI/MK7K+";
	arc=none smtp.remote-ip=74.125.82.51
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB65606A335
	for <bpf@vger.kernel.org>; Fri, 30 Oct 2026 11:53:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3DB65606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RI/MK7K+
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-18cdcfc05ffso751365c88.1
        for <bpf@vger.kernel.org>; Fri, 30 Oct 2026 04:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793361195; x=1793965995; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7RaPea1Qjt8hsmpjEa8tMwhSJ3KypYa/1YHVOL45aDk=;
        b=RI/MK7K+fVA+qCXVBxa379mqnjirEnm3l6A/b7x1T1+jyHpmAO31rKMcbfZfdWrhh8
         HnVuYJ2PZ1DzLxOObEMchGIbnBAGbfl2m3WNDe8993EbxfCh4Tb6/U41B27bh+aU/Ymv
         Ah/6+7zXJixz91W05I4ZoUe9sEyBqgEDG+rmMTyKfzZqzxeWNvOixWKslgk4+jvBrujy
         R1jm1A7HWWAJc4EZpI75G696hz6fsk0FfBGV3syfi1edJ3yvGy6GBMjdGboedLE2SfOE
         in5t2prwW4yPCrb3f3yXIznOg8o3BkxZF/mS61+ZQ+zWqqKS/65LY2MutedgfdJP3iyf
         E5uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793361195; x=1793965995;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7RaPea1Qjt8hsmpjEa8tMwhSJ3KypYa/1YHVOL45aDk=;
        b=eYnUsz5OpHS148WZJ7aJ+6CgkgHgKm9tsJHy10Kh9jEJS30FtzyY9F/AOXG/AqcpzN
         pD/eo3m/n3f8iJM+Keg13YuivpdRFfzaZoMTrN/undxUjll4veKY08Dgu+ioe9nAhmSZ
         ujrZIMJRDhcwXbWxwr7iNkk3qWfcxAOEs6fuiqJ++30w7bfIqCRPDC1dmTVllo58VPxq
         mYmvW8NOqt6n1FfOLHUrrqYOJNtwUnfZz5cajWaVbgWXIZnX6ly0jBOI71sWk2qNNWT9
         tDFtoSxwJEp5ub1FuOg3w2aZNa3Ezvo9hOmGeFIoNCSLV1w03AklkuUs/bMDk/77X8Kk
         H1cg==
X-Gm-Message-State: AFq9FYJm8F1gWdpaACdGZr33hR55P1ylruEnrWLkSNtZoRxP3oVBml30
	/ixoMrdACXZUxHlkUt4uZc2O+3dN62puftabcdhxSjjPBw//5+Et27NC
X-Gm-Gg: AYBFou3EV+mZv4S/uLnDAGt5filsAYb4OKO2WQAOktQIU7J/+AoEYyYsiKLUSQgf9nc
	m4UJHjUxUvqGsZVlCiWN0FNzd7g493zLA3mi7SehbQvCKK4x6ZzwGnUCWqLGFPo6ymVh4FDwhbv
	qK6GuC2xY0nl6cbM5LmKJe2mKp/Y4LhHKgWmiJkBupOqwTHjLwb1cWxBAp2gw0TIQ0cxVLtJam+
	MOAl4wklaPZ5aZidmUmnXn2BdVeK+pkUiMRCLR31XwRxFGpAn0QUv2uIqFgbR/8m8omAKopv0/U
	2rXvZU5t9JY5PJmNtVx1JaJmAK3b5HvbSf847oJ+5Qm/dd8D4XSmXHt3sP8Zs6OdigShCAbNEki
	Z8Ea2D9VuYf9b+v1vyNNotbt/CrEv2zvIabKthOW7+gXj244PDysLEAjQtbpSD3IGqS8owyWs6Q
	yiszLaxYQ5xMPKv9z0KdBz1VTlE/6juFAi2syDtLOH+5AEjk3tCHWlqCgeK/d5u4H4O5lzJUK0e
	M7YXVFlk0DBCV7Tmt9ckPbsPo0NMMSRw4IuwoJQK8pF2REkyMki7Vb8aO77v+NKr311Af4N0L9l
	QEgWczXpOH0fc8F1JYQqBcqF
X-Received: by 2002:a05:701b:4549:20b0:14a:51c8:ea06 with SMTP id a92af1059eb24-1ac5d69f695mr2698743c88.29.1793361195245;
        Fri, 30 Oct 2026 04:53:15 -0700 (PDT)
Received: from [127.0.1.1] ([23.254.208.9])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1ac1abcd6f1sm6437304c88.20.2026.10.30.04.53.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 04:53:14 -0700 (PDT)
From: Qiliang Yuan <odys.yuan@gmail.com>
Date: Fri, 30 Oct 2026 07:51:58 -0400
Subject: [PATCH bpf-next v2 13/22] bpf: Allow inserting in front of a
 queued patch
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261030-bpf-verifier-patch-batch-v2-13-55cd43439f7c@gmail.com>
References: <20261030-bpf-verifier-patch-batch-v2-0-55cd43439f7c@gmail.com>
In-Reply-To: <20261030-bpf-verifier-patch-batch-v2-0-55cd43439f7c@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>, Shuah Khan <shuah@kernel.org>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Qiliang Yuan <odys.yuan@gmail.com>
X-Mailer: b4 0.13.0

bpf_convert_ctx_accesses() inserts the store of the context pointer
for the epilogue in front of the first instruction, and then the
prologue in front of it as well.

bpf_patch_list_insert() only takes an instruction that has no patch
queued yet, so the second insertion is refused.

Put insns inserted in front of a queued patch in front of all of it,
and move the patch down behind them the same way as a single
instruction.

Signed-off-by: Qiliang Yuan <odys.yuan@gmail.com>
---
 kernel/bpf/core.c   | 27 +++++++++++++++------------
 kernel/bpf/fixups.c |  2 +-
 2 files changed, 16 insertions(+), 13 deletions(-)

diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 6e356e16613b3..0447e3b4cfa48 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -746,24 +746,27 @@ int __bpf_patch_list_del(struct bpf_patch_list *pl, const struct bpf_prog *prog,
  * Queue 'insns[0..cnt)' to go in front of insn 'off'. Jumps to 'off',
  * instruction arrays and poke descriptors still name the insn at 'off', while
  * subprogs, line info, function pointers and calls that start at 'off' start
- * at the first inserted insn.
+ * at the first inserted insn. Inserting in front of a queued patch puts the
+ * insns in front of it.
  */
 int __bpf_patch_list_insert(struct bpf_patch_list *pl, const struct bpf_prog *prog,
 			    u32 off, const struct bpf_insn *insns, u32 cnt)
 {
-	struct bpf_insn_patch *p;
+	struct bpf_insn_patch *p = pl->cnt ? &pl->patches[pl->cnt - 1] : NULL;
 	int err;
 
-	err = patch_list_reserve_patch(pl) ?: patch_list_reserve_insns(pl, 1);
-	if (err)
-		return err;
-	p = &pl->patches[pl->cnt++];
-	p->off = off;
-	p->len = 1;
-	p->target = 0;
-	p->start = pl->insn_cnt;
-	p->orig = prog->insnsi[off];
-	pl->insns[pl->insn_cnt++] = p->orig;
+	if (!p || off != p->off) {
+		err = patch_list_reserve_patch(pl) ?: patch_list_reserve_insns(pl, 1);
+		if (err)
+			return err;
+		p = &pl->patches[pl->cnt++];
+		p->off = off;
+		p->len = 1;
+		p->target = 0;
+		p->start = pl->insn_cnt;
+		p->orig = prog->insnsi[off];
+		pl->insns[pl->insn_cnt++] = p->orig;
+	}
 
 	err = patch_list_reserve_insns(pl, cnt);
 	if (err)
diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
index bb4fd75a70624..6d99de1be2581 100644
--- a/kernel/bpf/fixups.c
+++ b/kernel/bpf/fixups.c
@@ -429,7 +429,7 @@ int bpf_patch_list_insert(struct bpf_verifier_env *env, u32 off,
 		return -EINTR;
 
 	if (verifier_bug_if(!cnt || off >= env->prog->len ||
-			    (p && off <= p->off),
+			    (p && (off < p->off || (off == p->off && !p->len))),
 			    env, "insns inserted at %u out of order", off))
 		return -EFAULT;
 

-- 
2.43.0

