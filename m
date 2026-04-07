Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC9C379EEA
	for <bpf@vger.kernel.org>; Tue,  7 Apr 2026 20:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775592133; cv=none; b=AtzQD6y6ZRAItd3P5MwvSf2Mu3pAqRm3NrMHbPK+dyospt6/L2ryyrKjJ//ZC0Gd8/0cts7hjrehu70lYwYtwJinSuqHj95By/eMxpJf9vMx8H16ArC7xNfbJ7EJ/ubMId+QP2bb5NuWwD7KrgRnUvTNvEQOMqz4DAqPY8XqLhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775592133; c=relaxed/simple;
	bh=Dee8MfAKMe0QwuIpc5y6Dzt4zMQop/ntPF4kvvPkRss=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nMTMGlkLkD9APvWLbq0GKoIWGKZLtPz8SnZzkCDyPi7vjFg3aaHT6fg06SAjLTcQLzTRJ3iLsAU43Qv1gYVFNFyWFq1ZqAPzulHEb4Ck5wDDAvKwp3EneJXuapK6g2iX8rrN2YPZYNpEcMN0xdvjtFgn+d6FW2/Jp0UFAiPNCpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rMgpsQPK; arc=none smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rMgpsQPK"
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-64d5a7926cfso5249753d50.2
        for <bpf@vger.kernel.org>; Tue, 07 Apr 2026 13:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775592131; x=1776196931; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0UmxJY/q2Oo334eKqLugdqqv8hk8/P18b8cE3ViJmCY=;
        b=rMgpsQPKjnw8VCy0QAoXC16jjtyWekFYxg/0jOjufBd83tVs67UzEFeiox+TWuoZkj
         tEnX6R4juW7Q87o07wMiUHdW+DddTdNepYTccxqyTfV0cpfPOooAKFOj+XexEPo7atz8
         TQkc4pmFg/70qTQ4V3nKfTpVLYyz6gL+pV3xhMvjj0AKYTUS8jCiGpr9BhwPaIcQaMX7
         Wlv9FG+S9dg0ml8fUOca7xHERILcR0tXMUaAu+ArUj7QHTNpG+Nq1B26LLG5JoOwN37j
         Ci1agYGVQAnw6W7uF3TmVrsLaOBYv7crTAoZcG03P42t88GFV6/heJA3K9AAFPo/16mC
         6u1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775592131; x=1776196931;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0UmxJY/q2Oo334eKqLugdqqv8hk8/P18b8cE3ViJmCY=;
        b=LLX+YW475fqI8dm4zSdvG2sbIrAOnXWduWZHDactk9BHyJepSBUgOGtPFEZ3IHqmvk
         tHN2IBccOJheZtUPpPjj1ClfMYHpDDXg7oQhDxHVqe8EinZyxmYXFz2iANyrS1xF2HPp
         cjcYeZf8QUkIqqhhsJ1axZqS7Ow0maRwZk16+gDg0DEK8xJJuqd64oXCne/nEj3fdq52
         jahVgQvGoa6NWCEqm1pjQvVH03TDhp9YTZM9X3ZOgcieze7PFt6ey7Z9cBUTONW7ale1
         +CazWDOqOaoAhGqf+jNH/kSUOWq/jvCbj9Z+7gG7pGciDIAFH8LEPwp4NMj5cCoPWcZQ
         H2zQ==
X-Forwarded-Encrypted: i=1; AJvYcCVV2gkPSRLqin/PgbYLPaDvcmEFSeFcD3+uOedLUEyd4Kz4tBhczQk1bySBOV6PlPKZgRk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwY0B46fmrBXkce0Vx8LtlUfvhHIk1bu7iT1dSrOX26rIS1BdWn
	Z2gYPCbwV5Tz2+ed4Gxu1wqsC1FLdAVPuWSLwI5RcXqboRPUw+38gyW/
X-Gm-Gg: AeBDieuQ12w6Uv0imxP4d3tn8ty3tEgqT0izS+h6ANBCrScqozPb6VfR9BaWwiopsg4
	GvQcqN8NCvuinpaVKcIJCTsimSSiDY/WH9y7eZpNe4OqCL8PJXdQP9Rl62pLhkqtUBw35K0eS8v
	Pc8BUdYy4rfMVqkd0+v5NQ0q8wA9K0cc8XMkU3u3w8j+gO+Mpv40MxdzEZLmEHWZQC/cYanAG9T
	W7o1l4dfd8JdQ0GdpJiecLEay0pe720rL87Q6Tq2cT1rMCM1PSOO/U5YmcgWxi8sPCckzFzIphc
	h3hww6wu1UipEEU8PypUdwSSQYJkvrewh/idNC/VvNKmQA+yRlrCLVE/W9VF1wTc4kIT5JCxtdm
	B5UTvbeDEL9FtpDtZctA4b8YpyWopoawu5Ax7YBv5uXo2JJyfmnyemZFJHVc2BQuZovxcZs6skt
	pDRj1bIz2rxZ8KeJSmFUUbzSv4SA51/ad/I94uinMcZZKTPF72Or0gfMEQhoPakrpMbyTCRO16
X-Received: by 2002:a05:690e:4390:b0:650:3ddb:822c with SMTP id 956f58d0204a3-650486954ebmr13732325d50.6.1775592130617;
        Tue, 07 Apr 2026 13:02:10 -0700 (PDT)
Received: from zenbox.prizrak.me ([2600:1700:18fb:6011:92f8:8594:e84e:1d9a])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6503a828f3csm8354078d50.3.2026.04.07.13.02.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 13:02:10 -0700 (PDT)
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
Subject: [RFC PATCH 02/20] execve: Add set_nnp_on_point_of_no_return
Date: Tue,  7 Apr 2026 16:01:24 -0400
Message-ID: <20260407200157.3874806-3-utilityemal77@gmail.com>
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

Allow LSM hooks to set a new bitfield in the binprm, ensuring
that the next execution will run with task_set_no_new_privs by executing
task_set_no_new_privs only past the point of no return.

This differs semantically from task_set_no_new_privs, which is not safe
to set from bprm_creds_for_exec/creds_from_file because a failed
execution will result in no_new_privs being set on the original task.
The setting of this flag from the LSM hook will not alter the current
task's no_new_privs field until after the point of no return, so if we
have a failed execution in execve there will be no side effect.

Setting this field will not result in any change to the escalation or
LSM checks for the current execution transition, only for subsequent
ones.

Signed-off-by: Justin Suess <utilityemal77@gmail.com>
---
 fs/exec.c               | 8 ++++++++
 include/linux/binfmts.h | 7 ++++++-
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/fs/exec.c b/fs/exec.c
index 9ea3a775d51e..6ab700af57d9 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1111,6 +1111,14 @@ int begin_new_exec(struct linux_binprm * bprm)
 	 */
 	bprm->point_of_no_return = true;
 
+	/*
+	 * If requested that we set NO_NEW_PRIVS on the task, do so now that we're
+	 * committed to exec. We set it here in case it wasn't safe to set it
+	 * before the point of no return.
+	 */
+	if (bprm->set_nnp_on_point_of_no_return)
+		task_set_no_new_privs(current);
+
 	/* Make this the only thread in the thread group */
 	retval = de_thread(me);
 	if (retval)
diff --git a/include/linux/binfmts.h b/include/linux/binfmts.h
index 65abd5ab8836..9e420b055c4a 100644
--- a/include/linux/binfmts.h
+++ b/include/linux/binfmts.h
@@ -49,7 +49,12 @@ struct linux_binprm {
 		 * Set by user space to check executability according to the
 		 * caller's environment.
 		 */
-		is_check:1;
+		is_check:1,
+		/*
+		 * Set when a NNP should be applied to the new program's
+		 * credentials during exec past the point of no return.
+		 */
+		set_nnp_on_point_of_no_return:1;
 	struct file *executable; /* Executable to pass to the interpreter */
 	struct file *interpreter;
 	struct file *file;
-- 
2.53.0

