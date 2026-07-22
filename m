Received: from extorris.mess.org (extorris.mess.org [92.243.27.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A55E4D991D;
	Wed, 22 Jul 2026 10:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.243.27.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784715827; cv=none; b=XKCFAeIU5YkqT4qsk2+91OSQTedzHS3bTZQqM3LdnyrNS18mnc6XEJ3RN9RPwUx9shXkulafyBAyagwQSgIPpehc6yqdBdfz/69O72BT/fkXrkWbVzahQ9ZdjJ7u0Os9ldjbEqqh8kRwO2nP3M8GlgQ9A6RTzHILnT6s7a0plOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784715827; c=relaxed/simple;
	bh=KmBEI0QqBfLJsbIjc2Gk7pu9WEqMvEOx9sfqp1Aled0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q2N6NIPTkBrAk2M99y2z2UFn9x+VHJPpRr1VEVgrfHbMxw2Kg3zbufyvb2OBUTZbBjjXHXtJ+H6z7hIf0nwGcpIfK9G2o+7GuxeIyL+Be8Aa4yFLjxdutn5SFHX8/wcqzpqlAIv8NO4QMmyhKwES4yhisy31lp98XJ7oVMiks/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org; spf=pass smtp.mailfrom=mess.org; dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b=GnXEPpI7; dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b=jKsXW2Rh; arc=none smtp.client-ip=92.243.27.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mess.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="GnXEPpI7";
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="jKsXW2Rh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1784715823; bh=KmBEI0QqBfLJsbIjc2Gk7pu9WEqMvEOx9sfqp1Aled0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GnXEPpI7WojQs5xx0JMVTnSJoueJH5f7svQ5DaongSIAKXt6WfWhEi5Wp+58DJF02
	 SpLy1VObE+MZWpytPloqrej/JbVVdmz9C5VPoJfcZAqiQ4EuuVnMpejBMl/ZBhX9Je
	 N9tBo4Kj7mm8kyPsAvA7+WoWrncR75ge6L1bJAx40EOZXSk3eOFUP1ud3vXL78r15f
	 iwBPHys/H3hxiXVxYASTUMGe49utpliFrwe8uBqmoGo51O+/w4rkud8CH0FhzJ2/vm
	 XkS5IinKVYchw7pLovRWOxQLdculzA5wqxMdDKjfMsKrepYz1kA+IJP4cmPl4RCYR3
	 hKGtX2Yyeac2A==
Received: by extorris.mess.org (Postfix, from userid 1004)
	id A56F54017A; Wed, 22 Jul 2026 11:23:43 +0100 (BST)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1784715822; bh=KmBEI0QqBfLJsbIjc2Gk7pu9WEqMvEOx9sfqp1Aled0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jKsXW2Rh+L5FPEDcWhvyyWoe1MaTpBdyeIRX8/LisFuybM6EH4afPPC8JyT5P/aHE
	 ynqYd7HS94M1SVEbMRfEXo0UYcaGOb8Q/vv5UJtCIdOFqQY+W1wYnf/AfuFeEL8qPi
	 I3Z73fEgQq4iMOpnhYrG3vpjYqKE79Mbd5pLgM052OMnnrdYWOesCjX0J6C3MasY1G
	 VftVAc9Z5Bq3jwByC6eY1bKwzRsaF+Eqqv5AmHv87Qfs/7ry8tX6Yhh9clLHXeWT2s
	 /5XkiIBiexSLMziwjeVTTo3NpErfQYps5SiZq/xqcQoxc2F8zxrGRfHIhsUKTX+vm/
	 uNYTzXxo0nY+g==
Received: from maru.local (unknown [62.232.99.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by extorris.mess.org (Postfix) with ESMTPSA id 40B8F42540;
	Wed, 22 Jul 2026 11:23:42 +0100 (BST)
From: Sean Young <sean@mess.org>
To: linux-media@vger.kernel.org,
	Sean Young <sean@mess.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Patrice Chotard <patrice.chotard@foss.st.com>,
	Hans Verkuil <hverkuil+cisco@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH v3 12/13] media: rc: Fix use after free in bpf progs
Date: Wed, 22 Jul 2026 11:23:24 +0100
Message-ID: <ef00c264d0ead1324c4d61bbb3b1a4b2dc5bd4f6.1784715737.git.sean@mess.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1784715737.git.sean@mess.org>
References: <cover.1784715737.git.sean@mess.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since commit dccc0c3ddf8f ("media: rc: fix race between unregister and
urb/irq callbacks"), rcdev->raw is no longer set to NULL after device
unregister. raw->progs could point to stale data.

Fixes: dccc0c3ddf8f ("media: rc: fix race between unregister and urb/irq callbacks")
Signed-off-by: Sean Young <sean@mess.org>
---
 drivers/media/rc/bpf-lirc.c  | 18 +++++++++++++-----
 drivers/media/rc/rc-ir-raw.c | 11 +++--------
 2 files changed, 16 insertions(+), 13 deletions(-)

diff --git a/drivers/media/rc/bpf-lirc.c b/drivers/media/rc/bpf-lirc.c
index 2f7564f26445..14ab611e7445 100644
--- a/drivers/media/rc/bpf-lirc.c
+++ b/drivers/media/rc/bpf-lirc.c
@@ -148,12 +148,13 @@ static int lirc_bpf_attach(struct rc_dev *rcdev, struct bpf_prog *prog)
 	if (ret)
 		return ret;
 
-	raw = rcdev->raw;
-	if (!raw) {
+	if (!rcdev->registered) {
 		ret = -ENODEV;
 		goto unlock;
 	}
 
+	raw = rcdev->raw;
+
 	old_array = lirc_rcu_dereference(raw->progs);
 	if (old_array && bpf_prog_array_length(old_array) >= BPF_MAX_PROGS) {
 		ret = -E2BIG;
@@ -186,12 +187,13 @@ static int lirc_bpf_detach(struct rc_dev *rcdev, struct bpf_prog *prog)
 	if (ret)
 		return ret;
 
-	raw = rcdev->raw;
-	if (!raw) {
+	if (!rcdev->registered) {
 		ret = -ENODEV;
 		goto unlock;
 	}
 
+	raw = rcdev->raw;
+
 	old_array = lirc_rcu_dereference(raw->progs);
 	ret = bpf_prog_array_copy(old_array, prog, NULL, 0, &new_array);
 	/*
@@ -235,7 +237,8 @@ void lirc_bpf_free(struct rc_dev *rcdev)
 	struct bpf_prog_array_item *item;
 	struct bpf_prog_array *array;
 
-	array = lirc_rcu_dereference(rcdev->raw->progs);
+	array = rcu_replace_pointer(rcdev->raw->progs, NULL,
+				    lockdep_is_held(&ir_raw_handler_lock));
 	if (!array)
 		return;
 
@@ -316,6 +319,11 @@ int lirc_prog_query(const union bpf_attr *attr, union bpf_attr __user *uattr)
 	if (ret)
 		goto put;
 
+	if (!rcdev->registered) {
+		ret = -ENODEV;
+		goto unlock;
+	}
+
 	progs = lirc_rcu_dereference(rcdev->raw->progs);
 	cnt = progs ? bpf_prog_array_length(progs) : 0;
 
diff --git a/drivers/media/rc/rc-ir-raw.c b/drivers/media/rc/rc-ir-raw.c
index f066176c9f37..26962b500b0c 100644
--- a/drivers/media/rc/rc-ir-raw.c
+++ b/drivers/media/rc/rc-ir-raw.c
@@ -650,8 +650,11 @@ int ir_raw_event_register(struct rc_dev *dev)
 void ir_raw_event_free(struct rc_dev *dev)
 {
 	if (dev->raw) {
+		mutex_lock(&ir_raw_handler_lock);
 		if (dev->raw->thread)
 			put_task_struct(dev->raw->thread);
+		lirc_bpf_free(dev);
+		mutex_unlock(&ir_raw_handler_lock);
 		kfree(dev->raw);
 		dev->raw = NULL;
 	}
@@ -661,9 +664,6 @@ void ir_raw_event_unregister(struct rc_dev *dev)
 {
 	struct ir_raw_handler *handler;
 
-	if (!dev || !dev->raw)
-		return;
-
 	kthread_stop(dev->raw->thread);
 	timer_delete_sync(&dev->raw->edge_handle);
 
@@ -676,11 +676,6 @@ void ir_raw_event_unregister(struct rc_dev *dev)
 
 	lirc_bpf_free(dev);
 
-	/*
-	 * A user can be calling bpf(BPF_PROG_{QUERY|ATTACH|DETACH}), so
-	 * ensure that the raw member is null on unlock; this is how
-	 * "device gone" is checked.
-	 */
 	mutex_unlock(&ir_raw_handler_lock);
 }
 
-- 
2.55.0

