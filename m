Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794611324;
	b=BQ0qyg1YGC1PV5LTDUD2EiqbkY15OFaW0D1Il9f3kncYJquiBCaz1Tp50xm8rUmQeoPd
	 r4XR3VawCftqjG3xyhsNFsvGpGZaUkcCo9TfyS6XQPjnMpgLPsldo1qYIwgNjUjo1hiQZ
	 6xyDNc+SBiBxKcbFemGaGxJeSWN4/0/kFcriba3OzTHlSQ+08XOwSKJTI1Svnx2bncjlN
	 vL+M4hNSZAhuY3qo8WGbttXbmK23Q2/5IPNcIAYxqZlxCSfzWKS/B3IKSZMKUvH1rWZ0T
	 d/0y0p1WccdA6U9NXXWiAMUXedKEg/ehUyIRPJb41/8PLWaWv0aiA8oOhxumMDi2M3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794611324;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Date:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	 References:In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=J24RLR53zlPX5f5tzZyOuR6MXK+JSdJ7SqSssMORHsc=;
	b=AeWSB7b0GcdSw7//HGentjLehBsdTT02MMCpAlVMJBRxPUVmZBSNY67qI1rs94Cvpbyg
	 7tw7ZH4aziIMRwEqxEGXkJHK7dkbaVv/NXMCYB20JueJuZuF6mMPH71UuQ1gvNj2Ff46b
	 7wKAFElO6or0Zug7DidBPAsxJ7wBjvJKrojDz7EH/lWeMC+yLdLFkWD/ua65q1HZCVwNB
	 F3MAsp1QEZ93HmDeykm/ovujKrgwNhhUWnn6ciI+ChZFAFVIrwl75GhMIq5P2bn1hdOhj
	 uiq9WVShutdPAUNhnPIOg1irCUk5cmebFm2xJindd6KQSRhibDtQuYFws3x6ZlXlkMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FLo9EV9a;
	arc=none smtp.remote-ip=74.125.224.52
Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD377606A32D
	for <bpf@vger.kernel.org>; Fri, 13 Nov 2026 23:08:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CD377606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FLo9EV9a
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-67be9601f31so1590745d50.3
        for <bpf@vger.kernel.org>; Fri, 13 Nov 2026 15:08:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794611322; x=1795216122; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=J24RLR53zlPX5f5tzZyOuR6MXK+JSdJ7SqSssMORHsc=;
        b=FLo9EV9a+0GWIoRbEdJbbLK+Py3YR16pnWak7juhr3vqWiZgs74R0albViXzCW35Eu
         P7HMaEGIOrrWrudew5z3c5kOOHPcBV8A55h9ErBlJAzXMSkaiVVPqSuoE32SRTRDMBUX
         /HlyAipADWlUEJ67eC4tftYAJmTmIPWYs2h+fiqLGv2nCCrty3VoGa1dSP6QJVXtnRbO
         Jk/h/bkiwRcTqwLkrcq3LjJvnmMfJcnZ2yTzMZKyObt3gqdITHUffYOPL15egjrLSzxv
         2iwSSolPvA46cxDGtIQ7abgtyo2mGkjPmerludssg6wZt1ridxBdnKfBbtYiBHE4P05s
         f7EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794611322; x=1795216122;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=J24RLR53zlPX5f5tzZyOuR6MXK+JSdJ7SqSssMORHsc=;
        b=u7lnVIRT04HEjCADCCmINSFZPLAMkYME3yTTCTkKLMcJd3+P73ClSmc3UGHL58Ljqz
         6WaM78KxN7lFHUL08YsUQjkr1y+e0/I5NXcPVxIWdPZ6bpHS2UVX2Sbm1s4ob8Cck950
         yjLoHsvCeVGzDENzXVLVs1tSCMwKI/R+d8Z7KRvZ/TV5lGKGYOexVXb46KbDsg7v5UlO
         lHAYzBCctaGH2/o//yshvVb9nYXchhZqQfGxtTjduaK7xVwLAZSMlXro5Jvy1PmtdMmH
         KydCvN5ynTFsMX2wo+BFoWAfzpox+QQKL5Ldwkr5+iVk+0dYgnvMvL9WiaAi+mu8zaYZ
         RGsQ==
X-Gm-Message-State: APuU4Z9kle6PQiPilWoYFXCdzyLO6a8kp6m2uMItG6ZH6BFwMn0LZLwj
	kCGTQKjxcXxdcR+rHVFOcIwWjH9ryVlN4ZmlNv/Q8YTRt2jVIL+P/nez
X-Gm-Gg: AYBFou3NhYi+0/PiK/g1q50v1Z3p/hiFI+DwhPgFqy+2sA+220KKT4QSpmIHhGNLiEE
	/I6kjBSs6D7xFqDyOrNudVAvhzJFqBCsP1RfwNeVvZz7AhrQ2XOCQ2LEy0X2aPttWma8tsqulZ6
	clcaz0It88T3OPg0gkRKEjd3zQK3K/0cWXFG2xCtxAaRQnGnmjm3VMBv734vZRFbE8kVbV/ZUh+
	GESvH07K+o0fsTpyOntQATDaDQVLO3JRGrX461iOhU2ihqlvjMxrJYh82I6+6pYf/lrpTZ+1BWg
	X7hiuyFiSUDqOuTsR3o0/de2P1OJA9fSqRkhwiQ7f5srbbmyq19cqfzFjboXemS5qLZeWlBLKQV
	ltbFoGRx2EGZWf/JW3R6C77ZOR6wAVPe4zTb53c6xVgjWlkTRClRPqX/oEK1YkJCJfdWclxOszA
	4HGTuJKP5Q0hveatI2IfbfQZLUYF9OHdodNwLpiAwcGHbc3lPPXZKo5evfjCtifrLNkAO2V6MR3
	E0Q6x+HrKvLtz4CtF+eyAglX05lHAOHoPEdwpyrRtGN2P6fMIHgF2fi4tk9kNAMgN0ryXXAAzU4
	9WPCZo3sqr/LILz9XkU=
X-Received: by 2002:a53:d247:0:b0:675:d561:1eca with SMTP id 956f58d0204a3-67d896e9320mr1555771d50.72.1794611322308;
        Fri, 13 Nov 2026 15:08:42 -0800 (PST)
Received: from localhost ([2a03:2880:30ff:5::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67d8a629a2dsm3378034d50.21.2026.11.13.15.08.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 15:08:41 -0800 (PST)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Date: Fri, 13 Nov 2026 15:08:24 -0800
Subject: [PATCH RFC bpf-next 01/13] bpf: Free unpublished local storage
 with kfree_nolock()
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
Message-Id: <20261113-sls_f1-v1-1-1b9492bd3f97@meta.com>
References: <20261113-sls_f1-v1-0-1b9492bd3f97@meta.com>
In-Reply-To: <20261113-sls_f1-v1-0-1b9492bd3f97@meta.com>
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kernel-team@meta.com, eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794611317; l=2691;
 i=yatsenko@meta.com; s=20260324; h=from:subject:message-id;
 bh=x7XFB2uSqCSLnN2T6J6S0To4SeK+7aYkkdeErraTbSc=;
 b=/av1d+YUYxqhRBOAVbNnypRPcIKgnVmvXYxGxksBhFj4CwXOa/Q9+PujvK5kOSwksUd27DAiA
 pCuF18PqChZAAOs8leLUFk1RNMl2uz6ub9+e3t/lz7OYsY7VsGC9p5D
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=1zCUBXUa66KmzfjNsG8YNlMj2ckPdqBPvFq2ww3/YaA=

From: Mykyta Yatsenko <yatsenko@meta.com>

A tracing program can create local storage in NMI. When the create
fails, the new storage and selem are freed with kfree_rcu(), which is
not safe in NMI. Nobody has seen them yet, so free them at once with
kfree_nolock(), which works in any context for kmalloc_nolock() memory.

This fix needs commit bd897919e4dc ("bpf: Link the first element after
its storage is published"). Before that commit, an iterator can find the
first selem before the storage is published, so an immediate free is not
safe.

Fixes: f484f4a3e058 ("bpf: Replace bpf memory allocator with kmalloc_nolock() in local storage")
Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 kernel/bpf/bpf_local_storage.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
index b12fcec47ffa..3abfe7034df8 100644
--- a/kernel/bpf/bpf_local_storage.c
+++ b/kernel/bpf/bpf_local_storage.c
@@ -158,6 +158,18 @@ void bpf_selem_free(struct bpf_local_storage_elem *selem,
 	call_rcu_tasks_trace(&selem->rcu, bpf_selem_free_trace_rcu);
 }
 
+/*
+ * selem was never published: no reader can see it, and this works in NMI.
+ * Only the syscall update puts special fields (uptrs) in a new selem, and it
+ * never runs in NMI, so freeing them here is safe too.
+ */
+static void bpf_selem_free_unpublished(struct bpf_local_storage_elem *selem,
+				       struct bpf_local_storage_map *smap)
+{
+	bpf_obj_free_fields(smap->map.record, SDATA(selem)->data);
+	kfree_nolock(selem);
+}
+
 static void bpf_selem_free_list(struct hlist_head *list, bool reuse_now)
 {
 	struct bpf_local_storage_elem *selem;
@@ -562,7 +574,8 @@ int bpf_local_storage_alloc(void *owner,
 	return 0;
 
 uncharge:
-	bpf_local_storage_free(storage, true);
+	/* storage was never published: no reader can see it */
+	kfree_nolock(storage);
 	mem_uncharge(smap, owner, sizeof(*storage));
 	return err;
 }
@@ -605,7 +618,7 @@ bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap,
 
 		err = bpf_local_storage_alloc(owner, smap, selem);
 		if (err) {
-			bpf_selem_free(selem, true);
+			bpf_selem_free_unpublished(selem, smap);
 			mem_uncharge(smap, owner, smap->elem_size);
 			return ERR_PTR(err);
 		}
@@ -692,7 +705,7 @@ bpf_local_storage_update(void *owner, struct bpf_local_storage_map *smap,
 	bpf_selem_free_list(&old_selem_free_list, false);
 	if (alloc_selem) {
 		mem_uncharge(smap, owner, smap->elem_size);
-		bpf_selem_free(alloc_selem, true);
+		bpf_selem_free_unpublished(alloc_selem, smap);
 	}
 	return err ? ERR_PTR(err) : SDATA(selem);
 }

-- 
2.53.1-Meta

