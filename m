Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 847AC390223
	for <bpf@vger.kernel.org>; Tue, 23 Jun 2026 17:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782237022; cv=none; b=TsZvB0GCAnAQK90ljgxK49M8iDFsbEf3dOrLhwAgndMN19J1evB2tCnwXNkUSa1Qwd7VZuekvDbZBmYTxpKFsFr3/1ktPhmj8WceMFlBqh2y+q20WkBTqavu77ElDMjoElv09nX7dy3WvJ/YmyWNYJkG0mKVVwVGXlOZDxFHlCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782237022; c=relaxed/simple;
	bh=e6JAJyZ5twPXQaVy1tlokGPh4iOm+asZ3n9da+paOQI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WFGcWos3cMfqNqxUXA5NQgwaUq57JvYpanM/mUMkkz11vc7RjI7DCcBG9SeehE0zsRkpH1wMJcnHFBaYMkGvtC+3mpIzu/hhhqGYux1A0LzH6hzsaRH+cUaDF9bng4wmn7wgHRPe2JqqOYx57EPW0rrfEDNk1zo8GLVsEjHmeX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lbyPS67u; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lbyPS67u"
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-48d6c621a67so125738b6e.3
        for <bpf@vger.kernel.org>; Tue, 23 Jun 2026 10:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782237018; x=1782841818; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C/u4Cl41DQceXJHbU/CnAGu2qq6sXnkAlKiyHbtqa7w=;
        b=lbyPS67uawB00+YB3smXRldoufKR72/yY4BMdf0RDQSvLkLh0fiuDfSMjvAeGD44pA
         Y/89ohtGqsXsvp/hZsMzKMAK6MdY9mq9aDnubdcMRQROgxTw1VuqTN1XEoXhRd2U7bMx
         80kibxoo+RlUt9CE10o0wpAUJHQfCZFOILWAv9ADgWJQCvOsTOpFGmdrZc1FfwFXKJ+O
         HRyK8zLL4uYCMycFH7lB7E6UYsLj6qhxITdVgGjkXyEmWgHHvsTl6h+jjKU1k4jUTly+
         2CEJmR9Ri4wE8p4J7AWIL4n1krAZEg2FkhXD1UeuA6Rq3kBOcHTntRQU6djBRokQILM0
         5DuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782237018; x=1782841818;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=C/u4Cl41DQceXJHbU/CnAGu2qq6sXnkAlKiyHbtqa7w=;
        b=dF6fmy+7l5qxpdETpxo5ADDdtXTfFbHBk2kNsCIRMD0CNqNYoVrJq7VAm6Yz8rPydT
         Em58GS1g9CTsdyyzKKeU1+gzcM7lPkO9TRN40n38lTrqEpUe5FwsTIn4mPhhQRjp5NPA
         3zwoA1XLWK6PpL1xSEHz8qDZHDdOPhtrn+LJE6X7aDN6sXEgzHTxb+f8eevy0cH2t/z0
         KTROkWX/gNzzqpi2epGR2C9YMY0f5i2JZkmr5YZnVuLDArjGujgco/H1zZeK9iwoofVk
         cGnsH5Km7KdumqW+cvqx+hp2KRtPw+yFqbwXKjdevGUFehVvjS/M94aErzmFG7EkcGd1
         G5Aw==
X-Gm-Message-State: AOJu0YwO7M+EDy5c6NbGxeNhzFNd9HkFCS4UfXh2LJbdQlcPOfQIGaBO
	MMhCIa1pQUSVSwRiiy++n1+AG7kIDcZamuuAxKzIfJCEoX5FTRYTvd6KulIScA==
X-Gm-Gg: AfdE7cnlg/Qc8LPoa9rPvggnsgpTJc6sLMgCGgq2h81u5J2MasZcn5CP9lzF9OK6oXM
	QqWHKGiFF5HF8SwufQtAR2MV765Et+R7Yh9hzjVSbc4QLTJMFMrht7MEqGEghJCLyeMlGOPdVuk
	LyaDvSy+LRlqcunKQ/DL/UIgbCdTehVTdsGe2ujN5e1WhPl1WDfFlfB08pH6JKQ7yGQNN84kyAX
	sBqsAcoBosFF9VTHOTIwrmnjnbPS0YenliBgPWNRuX13cFSjbdHT1qfNDB6pb70ksUiRsDst4Fm
	1/W5reHVKd6lkx7yZsM6HatjzJcctt/7Cm9zhF8K2nFPXrn7cifAhBuN9gokctxBlt/ern12RZ0
	lzKtFebFKcIctskuo/i5vm6GHIKk1elM9G8rf2RRBYjavmBpKKSe+53SOEDutF6c4cPX9v0ADv9
	zjPxs=
X-Received: by 2002:a05:6808:c3ec:b0:489:a388:167a with SMTP id 5614622812f47-48f27f28ba4mr2505819b6e.15.1782237018339;
        Tue, 23 Jun 2026 10:50:18 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:43::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-48aec0dcd69sm7685495b6e.5.2026.06.23.10.50.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 10:50:18 -0700 (PDT)
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
Subject: [PATCH bpf-next v2 07/15] bpf: Move LSM trampoline unlink into bpf_cgroup_link_auto_detach()
Date: Tue, 23 Jun 2026 10:49:55 -0700
Message-ID: <20260623175006.3136053-8-ameryhung@gmail.com>
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

Move the LSM trampoline unlink into bpf_cgroup_link_auto_detach().
The purpose is to consolidate the auto_detach cleanup logic.

It prepares for the upcoming struct_ops cgroup attachment patch where
bpf_cgroup_link_auto_detach() will need to handle the struct_ops case
(link->map != NULL).

This is a no-op change.

Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 kernel/bpf/cgroup.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index b43f0bff184c..7abbe12e108f 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -313,6 +313,8 @@ static void bpf_cgroup_storages_link(struct bpf_cgroup_storage *storages[],
  */
 static void bpf_cgroup_link_auto_detach(struct bpf_cgroup_link *link)
 {
+	if (link->link.prog->expected_attach_type == BPF_LSM_CGROUP)
+		bpf_trampoline_unlink_cgroup_shim(link->link.prog);
 	cgroup_put(link->cgroup);
 	link->cgroup = NULL;
 }
@@ -346,11 +348,8 @@ static void cgroup_bpf_release(struct work_struct *work)
 					bpf_trampoline_unlink_cgroup_shim(pl->prog);
 				bpf_prog_put(pl->prog);
 			}
-			if (pl->link) {
-				if (pl->link->link.prog->expected_attach_type == BPF_LSM_CGROUP)
-					bpf_trampoline_unlink_cgroup_shim(pl->link->link.prog);
+			if (pl->link)
 				bpf_cgroup_link_auto_detach(pl->link);
-			}
 			kfree(pl);
 			static_branch_dec(&cgroup_bpf_enabled_key[atype]);
 		}
-- 
2.53.0-Meta

