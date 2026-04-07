Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFECD37B3F9
	for <bpf@vger.kernel.org>; Tue,  7 Apr 2026 20:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775592142; cv=none; b=Sp1qsd5q99h8AXAhHYhoTogvaEsZe/rGJEZsi0bsNyjkLtnRGjnvmIG7+9oNNaCVERsiu7ytUWBSr93YBaOxyNaBtyEf47EJvvr2SBVMuSsBVYRUl/63O337LPZVqw9wMafNmitAnnItgVYUMlOTPYtgB2+uHuOW8RyHT3PhwNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775592142; c=relaxed/simple;
	bh=T970uGi8fhSxDf5ZZOo6ka09fyjrPVUW8XM/9F6ScEo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HCGwLSt+lXQuEIfLhb9I5QwTi/nonMjUmhmbNYPeHfCPPHm5pVb3IMnZTlo9kQS/m2FiOLdzrNf9PPXpjEITEHcmu/Y7+8Tur/6XHSnyGHHWWAy2d7NgxOaHPo08ookrdy5yjHgoQ3VbpIuvfdEIgARYHa7RGIjjtkaPm/Rflmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BRJNkLTe; arc=none smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BRJNkLTe"
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-6501418152cso5228887d50.0
        for <bpf@vger.kernel.org>; Tue, 07 Apr 2026 13:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775592140; x=1776196940; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BuKJbhdjkkPHzvIeZz/hT1B94AyhjIeMJIbjPCMSPwA=;
        b=BRJNkLTetmGqdXoLKweuVtjNPWuUc+HKrpHUNM786kQobwUxW0WFyj/bhwQptJhsBW
         sdvuyZ6cM0h+42DR2lEJmVy0l0zhFYmsfRJKgH4dbIFnGph2bPsn97ev72Bq36fLns/j
         WzoPgDh1gIc93lt4SmslLTpnMK2ZewisWh2YPMgr1g+jyg9J8vGlDzt6tqeYE7ObWdc5
         cohS4VLWmvswdoAO2VB21fhvaS+y3U+CQPtpVA4uyPq6/ZY6mFeAeZN634SPhYmxFGxP
         U33xLwUDdCLMCdcriiEeVonVOJbgQtkzBskdarKzAh3Zc9yLiQMqjeF62HTb2y66MQza
         na3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775592140; x=1776196940;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BuKJbhdjkkPHzvIeZz/hT1B94AyhjIeMJIbjPCMSPwA=;
        b=qw4IDwola0zZadZ2ivZBHMtBNdIbR4AdCGHg5BpSQZlFsZcJNcdAOu6YKxKFFA7W61
         IkxqQhtiOzrsYmlDALpZndnqiF2eBiR5JrxWLJiI3ZdheZUo85NWPXLuvCRP0deLCgoM
         svLUtAwusyKJCjMWIpUha4SS4sQJnUFl6Htn15jC1tN9hPIZ1Yn4+FtG4aB3AdNBogoe
         0ZzcmMrf88ZziHVNaWT+cDchsCe6SV+lwLgDTWFI9bOzLVCKTWyJ/xpx0R21Ng3CGs/o
         vCFrDD4ZJ0u2ZiDBYzbJ+NePLSCIAnKuRH7dGFoZWXEbjZ0I1u+bgreeRtlX0HXjeSSN
         qKGw==
X-Forwarded-Encrypted: i=1; AJvYcCXaHRWyDJRRUb/TR9Nd/cWJA2HUSEk0zHbF3veRGV5rieEY7CwuqoD/sekaXpp7ShonojE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyV7n4M9lEaM5i0ImHcuW9v5QzxINwvPaA6NUmyRTkCzxrcFOYQ
	YJTtATSivkItsmk7wxKZoTxpytnmvcJM2YAys3Mif3fLTXE+0SGRV878
X-Gm-Gg: AeBDieudMAGK9laq3m46/EDepeEXg6wj/VLMIKyhpyJ8H0+mGzDcRVI/x9wc2iNQ+QQ
	tXcaTzzJaMX3lDU91rAezKLOttGRraJQ7fSERthafVQCSCxUlZzk029cs3+eGkZ1lluZTM+qzDc
	XU1uI+OZNWmYm25s7TL5JV4WhEAm4xNfevwliZ24yi2zb7er8j/BxU9O5rUG+C1MT8n98WtsC80
	1kbPdPfEjPPCm0qdk38d4UtgOPNhPTAgWCngWm5MEU5thmQutd/q8UTAsOIzcdZDOyTM+fYT2Ll
	CsjJjjJjV+bLlsOCj55Co5ywgwyMf6JNm9HmgdxdPLR41+eFLemORZLmZrYzQDImIxa/Q5iXcNG
	qJLHgK4ySM/H4lLNXp0J+0jjS9Rifw8Ms4q5kl6LxxkY8fyn+5lMLD6e9Om1J4lrakIB/h2sH/R
	5GDWM9ACvCh7d4Q9m2Eah9+nqf1Vv2/zWj/TFmne2y7QYxpaH1bShC8NZJdO26GdCRuTYnBc/p
X-Received: by 2002:a53:ad4c:0:b0:650:211f:1d4 with SMTP id 956f58d0204a3-6504886c5c4mr11830030d50.47.1775592139804;
        Tue, 07 Apr 2026 13:02:19 -0700 (PDT)
Received: from zenbox.prizrak.me ([2600:1700:18fb:6011:92f8:8594:e84e:1d9a])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6503a828f3csm8354078d50.3.2026.04.07.13.02.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 13:02:19 -0700 (PDT)
From: Justin Suess <utilityemal77@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	kpsingh@kernel.org,
	paul@paul-moore.com,
	mic@digikod.net,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	kees@kernel.org
Cc: gnoack@google.com,
	jack@suse.cz,
	jmorris@namei.org,
	serge@hallyn.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	martin.lau@linux.dev,
	m@maowtm.org,
	eddyz87@gmail.com,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	skhan@linuxfoundation.org,
	bpf@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	Justin Suess <utilityemal77@gmail.com>
Subject: [RFC PATCH 05/20] landlock: Make ruleset deferred free RCU safe
Date: Tue,  7 Apr 2026 16:01:27 -0400
Message-ID: <20260407200157.3874806-6-utilityemal77@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260407200157.3874806-1-utilityemal77@gmail.com>
References: <20260407200157.3874806-1-utilityemal77@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use INIT_RCU_WORK in the landlock deferred free function, ensuring that
deferred ruleset freeing is also RCU safe.

This is important for future consumers who may free a Landlock ruleset
under RCU in subsequent patches.

Signed-off-by: Justin Suess <utilityemal77@gmail.com>
---
 security/landlock/ruleset.c | 9 +++++----
 security/landlock/ruleset.h | 6 +++---
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/security/landlock/ruleset.c b/security/landlock/ruleset.c
index 4f0305796165..5845cdc58d0d 100644
--- a/security/landlock/ruleset.c
+++ b/security/landlock/ruleset.c
@@ -699,16 +699,17 @@ static void free_ruleset_work(struct work_struct *const work)
 {
 	struct landlock_ruleset *ruleset;
 
-	ruleset = container_of(work, struct landlock_ruleset, work_free);
+	ruleset = container_of(to_rcu_work(work), struct landlock_ruleset,
+			       work_free);
 	free_ruleset(ruleset);
 }
 
-/* Only called by hook_cred_free(). */
+/* Called by deferred ruleset owners that cannot free from their context. */
 void landlock_put_ruleset_deferred(struct landlock_ruleset *const ruleset)
 {
 	if (ruleset && refcount_dec_and_test(&ruleset->usage)) {
-		INIT_WORK(&ruleset->work_free, free_ruleset_work);
-		schedule_work(&ruleset->work_free);
+		INIT_RCU_WORK(&ruleset->work_free, free_ruleset_work);
+		queue_rcu_work(system_wq, &ruleset->work_free);
 	}
 }
 
diff --git a/security/landlock/ruleset.h b/security/landlock/ruleset.h
index 0facc5cb6555..fbbd1b73476e 100644
--- a/security/landlock/ruleset.h
+++ b/security/landlock/ruleset.h
@@ -146,13 +146,13 @@ struct landlock_ruleset {
 	struct landlock_hierarchy *hierarchy;
 	union {
 		/**
-		 * @work_free: Enables to free a ruleset within a lockless
-		 * section.  This is only used by
+		 * @work_free: Enables to free a ruleset after an RCU grace
+		 * period from a sleepable context.  This is only used by
 		 * landlock_put_ruleset_deferred() when @usage reaches zero.
 		 * The fields @lock, @usage, @num_rules, @num_layers and
 		 * @access_masks are then unused.
 		 */
-		struct work_struct work_free;
+		struct rcu_work work_free;
 		struct {
 			/**
 			 * @lock: Protects against concurrent modifications of
-- 
2.53.0

