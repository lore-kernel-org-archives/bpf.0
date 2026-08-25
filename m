Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A803F304BDF
	for <bpf@vger.kernel.org>; Tue, 25 Aug 2026 11:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787657326; cv=none; b=k6NhaL21j6A+4AvkkRCv2iG1QtDOQ7UAa7PlHmJiH5o9crwxFNhwhIjXIMvWbsThFV7TZOZggNuld36qUMl1qznlx/TW+uf+skATRHUUvgwsp362Ctd8y+Kx/tEXFcJqla3vTHKgw3cdo5wb2yNF4R+YQIRX1QozEQoRQ9SSrbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787657326; c=relaxed/simple;
	bh=8Q1bGR4Gvu/YMcQWaVPqwTllykDpanbu0IPTqFrKTQ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=saQhZ+FtxtAJKCdYyJmyvHOXUGEKAtv3WAme8GyDo6d7q4steenabGVnANl+oDRXpNC+Y4hLW3PlGeKNUW8r3HZH7bnzG0Ev9OBb8yMe6SoViCGkD3VfxgDw7HmUWzVKLBsfOY2GpY9u1AUUxZYtymJQzlYOzfEXE7aU7Z5ZVZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VEa0O1DY; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VEa0O1DY"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2caed617615so45344215ad.3
        for <bpf@vger.kernel.org>; Tue, 25 Aug 2026 04:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787657325; x=1788262125; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8Q1bGR4Gvu/YMcQWaVPqwTllykDpanbu0IPTqFrKTQ0=;
        b=VEa0O1DYaS3QjBQSR7QsK97dQUmJVYwhQen9AwSgcN8XZXKtQQEKQ/yTl/B4wJKSIH
         Jwxr6jEtFyhidDAWHwxP0TDPhE6/anrNvNPrcS8If/YlVHHlegr6Q6nXozs1kBwYvHTo
         Z/WSFr8OdwbL1xMa4TLHh5NhXcxaWqI1kdtcrDc/Zu7uu9R5cCCMnQsD3ZCJniZM00lj
         m7LC4GbRIEfdhWexz2RM1I0SPWYq3vIen8gcAuBnGUD/0TM5sh8sQCmXbCCn5kZL7tW5
         wMqiBh83RgjZHrwpAjstKeaZUawWKVl/KaWfff4m+h0dolvWr4tYCFEdWhLA8Yy5LeTT
         98aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787657325; x=1788262125;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8Q1bGR4Gvu/YMcQWaVPqwTllykDpanbu0IPTqFrKTQ0=;
        b=Y6/RnQnZ3g1uFHLV9072ENNW8pXauEkLBJO/Ishj9x+TXrt9+ax/emXwAJFHztOHfR
         gEbQt1b5V65nI13WguVJt2uTGxskKNGpfj/Xwql5gmmee/Y7XPSiuNCi626WSVfte0d3
         +1UF+XoppTX3CGLSr6jH9zjEHmITCASzGlDtdyu+vLYItaYnpimuCT07hwFY6jhmLwcy
         wBjwUbMqVWSHAky1DQE1UrbiVdp6EdP/81kWyQ3j7oBtjJRNZU2/COAlr8O0Im5plHmT
         Etso+fK0PiMzHCJPFkX9AF4PhH2QKXKttXoW4gZ8i80vWwKbDHFDDjQ3zieNj4QLd+yb
         9GlQ==
X-Gm-Message-State: AFuF++lnFYSih5z4lbRtQdGwEGuOU9nXXvHKyLtBaiTIGjRhYvzj/uvo
	iQdwpLgt61HdzqASz8esq6Xa33p60C+/PdTc465kTFqdugjfPtCEJUu3
X-Gm-Gg: AR+sD12IiMyE4r+0q5kcUjMA5A3SPAkAj48rZqMH+uX1aCbNU6xxgRlFs+9lwHWsXS6
	JkNT3AK/GLKQx1+f6MMo6Za16YmH4KFC9DNDvhO4wcKUoYpWyub8hDOKo4zkcCcDM3gDkK8cNt4
	+yp8Y0J5JeaDrN85VRBmgtuRfjRP0h5TRYpmS2g2HGebGrjfl6+eiE0X7U4MCghfLiI0Nb769XO
	fcZYhdtqNZnK3DJHp4yQYDm6lZTxGyHSPwAGAVnhpPlsOVyILzq7VUUCLnsbGhjpc/LTc+4IWER
	o43nLeY4ylqLMOsiPF2NcQPVfIu3apiXiWdIGqUOiJ3cUuJs8LB/3L1U3e94df3NBP4a6luHiRH
	429qOOYwPivhbEv0EBibbW9FPcO4oyaeqfWxXgoeSwh8q9B4ezSFnPP8o7GTFKxCvHjuBeAIVm8
	i4rVq6e/EWzoqJhu3+2f9FjwtMAaxqGcLlss0ZCYySZGHmrVepdWO0BK+3je5D8ICqS6kDW6nJQ
	YdskCG3os2Moxgb0tr+Q6WZGg==
X-Received: by 2002:a17:902:f70b:b0:2d6:3c2f:6a4 with SMTP id d9443c01a7336-2d670d07a21mr492208565ad.13.1787657324888;
        Tue, 25 Aug 2026 04:28:44 -0700 (PDT)
Received: from localhost.localdomain ([103.120.31.178])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327f92359c9sm36289420eec.27.2026.08.25.04.28.39
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 25 Aug 2026 04:28:44 -0700 (PDT)
From: Khawar Ahemad <ahemadkhawar123@gmail.com>
To: jiayuan.chen@linux.dev
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	emil@etsalapatis.com,
	martin.lau@linux.dev,
	yonghong.song@linux.dev,
	clm@meta.com,
	ihor.solodrai@linux.dev,
	memxor@gmail.com
Subject: Re: [PATCH bpf-next v6 4/4] selftests/bpf: Add a test for arena fault-in under memory.max
Date: Tue, 25 Aug 2026 16:58:35 +0530
Message-ID: <20260825112835.84664-1-ahemadkhawar123@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260825094955.83240-5-ahemadkhawar123@gmail.com>
References: <20260825094955.83240-5-ahemadkhawar123@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Jiayuan,

Thanks for the clarification, and that makes total sense regarding the
64KB page size (50000 * 64K = 3.05GB <= 4GB arena limit).

Apologies for stepping on your toes with the submission — I didn't mean
to create confusion or duplicate threads. I will definitely leave future
submissions to you.

Looking forward to your official posting, and I'd be happy to review and
test it whenever you send it out.

Thanks again,
Khawar Ahemad
