Received: from mail-pj2-f10.google.com (mail-pj2-f10.google.com [74.125.227.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D2C43D9046
	for <bpf@vger.kernel.org>; Sun, 23 Aug 2026 14:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787495585; cv=none; b=M6d4pWNL8LuwHtPr+AGrqKNjRJhT2m0TB0FXpbgn7zsWLI0U/omjiWlIXRytmBj9pnoBkElj3YZnX/ueFGSxp+4RRCcHoZczVucBXsU3D0byqO5ZmXIRxcQg7Drvq3kFRU55qhb7V+pGEg0ODsd4vnGNGgjuSLQ7ZYYZfQQ5q5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787495585; c=relaxed/simple;
	bh=BSqfu0vw/3q62qHFnlH6cBl4gI5VMo7Cpgj2Dx1Qf0c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VjX3Hz2XGClHZSqsIeUtjrFqUbibw84sBxiAg/tlbiWeUGZHvShPIf4ON1YH8F8DI15rR+hujEdY6ZpNOMantqjmaNpwUQRewsbaVHabzV/cgCHWER+Upj9eAp8FRQvAVjsMa4MPkoXG7fED7ItcoVvDn/LekdwqTNwaEfl5g+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.227.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj2-f10.google.com with SMTP id 98e67ed59e1d1-38dc4f9462cso866548a91.0
        for <bpf@vger.kernel.org>; Sun, 23 Aug 2026 07:33:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787495577; x=1788100377;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BSqfu0vw/3q62qHFnlH6cBl4gI5VMo7Cpgj2Dx1Qf0c=;
        b=TLshmoxB6b05lViobR2Ti9H2OseDiQoM9ISkOa2B8Vn6j8n1KLItCbIi4NKpBpCwUr
         Q7P4hduUWbKriAJyYZnccivGLyb/I9b4u6YT0TuaaNvX3BfvPTayu4V6lYIllOfH7j4K
         5xwUIaqISS/gbYTbizWhtVwu+O/UsfoM+ImTPfYp3YEBT/y4ttQALwETzSvXjlU1LDN+
         fAA3wBqeQW28t8Ap3OVEE7Lvl1Ia/Bke5ZxcfZy0LH6ArjGepw0Yv64AySSfaKXQ3U1/
         uvAFSJuEfC0c3M170pDCbbK7Ul7e+jywk4upL1IeLyYn4huCHBeyArAvuwjYraNLL0o+
         Q38g==
X-Gm-Message-State: AFuF++lmFDYhgin5BBGrOmbYsdxiejLkGANus1CIOMIAG4s7yRvX0siz
	8U/LmDjtnUe/YcJNZkkSAMLCVmmLUcyMBZjZZYwkZbYmE2+pktuYfx/8vPqlk1SZXnvVNemj
X-Gm-Gg: AR+sD119zraC5Wy9iTE0n6HEPExtVMfXwM7oLAi3NlWprnzGr3a73DZvYMARtP8Ssix
	ZFVG2BiI53SC/7suDvajaSIuhIqcoHdW7ybbdKIqIPQHclSPNQcTX5tY4vKMwYg4zoG1vigEQPo
	WmU5AWxzPE7dx4qBNW2C/RD4tRlgFVNGt6RA/ddiDR8hmOnoEsoBMeGZJ8HNfdF27CXbv5GKSq9
	t9SKialazmigrAHK8EQahAXBhwGzP3oDJnZ+xvv+BdQ4Kupb4uISKlHid2Apg/KO5OmDgfoGX8O
	kEWAJgwmpo7Cmu2pLEeAiw6dIGE8NtOiWQt5joSCw4rslmzWQFY8CDlLAw7PB9TWaCwlcP00i50
	Oa8/v1UuZxNdoK/EY+VceHKeh6v9IchhDX39D1+bOeQDbw2FEnHbnS09DAd+xqv3JSiIierG9v9
	hS6XWPBFfPcPnLMChGQQBq0J4klMenDW/NLFZCr3BybndgsveXKGHhxEydrroC5l23Fz3fMG1yc
	zsXkOQ=
X-Received: by 2002:a17:90b:5886:b0:395:4de4:92c7 with SMTP id 98e67ed59e1d1-395dee7d5f6mr22666217a91.3.1787495576954;
        Sun, 23 Aug 2026 07:32:56 -0700 (PDT)
Received: from localhost.localdomain ([180.153.160.8])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-395e42d6139sm6223422a91.0.2026.08.23.07.32.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Aug 2026 07:32:56 -0700 (PDT)
From: Jianlin Shi <shijianlin11@foxmail.com>
To: bpf@vger.kernel.org
Cc: memxor@gmail.com
Subject: Re: [PATCH bpf-next v3 2/5] bpf: fix stream capacity leak in staging path
Date: Sun, 23 Aug 2026 22:32:51 +0800
Message-ID: <20260823143251.1173587-1-shijianlin11@foxmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <30e41d6a6f8c19fee31fb09839d9b896b590df1f585ea6976d0c77f3d065383e@mail.kernel.org>
References: <30e41d6a6f8c19fee31fb09839d9b896b590df1f585ea6976d0c77f3d065383e@mail.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sat, Aug 15, 2026 at 09:02 UTC, bot+bpf-ci wrote:
> does the new comment above vscnprintf() add anything, or could one of the
> two be dropped?

Not a bug. v4 drops the redundant vscnprintf() comment and keeps the
existing "Exclude NULL byte during push." comment.

Thanks,
Jianlin
