Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C63445AD3
	for <bpf@vger.kernel.org>; Mon,  7 Sep 2026 13:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788786433; cv=none; b=FugUirMwUobsVXwDeKNEsIj55X0wf0cxxZ4qvg67snUgQaXvFRzn+AUlYu5egUN0YZ09OyMJpZyg5tr8qfYXTXKzmca41HcQdwa0wyexaN9TF7caBWLd4r7M6L9wnh2e8+lyZHTosoi8177tsDBheeG+K4Cng+V+unap0/XrfN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788786433; c=relaxed/simple;
	bh=Qv7I/lvvms82Javmu3Qn4HLZRiBz/qbZQStkMGxkn8w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pDpVG9BvYshcMOVPNtaQ5Ih3MvqKfN15LtmJPasf6/gd/BMrm0hIC9pDacVPm+mVik5Ogwe7IoA5YiACT4FCXmYly0mIIiJHQ19HNxI+G5DTrOHFNL8MmeUQYkNpdsGhmbGop9rqgJMVTo4Ej5eHXD9j218SA4ttZ5F9HzYDeFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WcfgUz58; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WcfgUz58"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2d715f4a587so49481965ad.2
        for <bpf@vger.kernel.org>; Mon, 07 Sep 2026 06:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788786423; x=1789391223; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6VpUJtRIrgP7Z0MplUt6dRio1tuWvg+b+028E1QMqao=;
        b=WcfgUz58lDT3OGDTKbd01Lbn16Wjyj1XLaavuR2q+KniiOMCgaeTb57SE6i/2Cnjsi
         2uR7Op2ZBzI2L3TTpTOLjjiBlZV2+d3+SAX+zvleZLXZAKp+VWAsJDKBX9TLxhduKCbg
         Km7dcBfeETeBTtW13gqaqjlEAuDRIzN1gVqSLe7QIIAKNweWbKGyFDOV/qTpe5U3HezM
         WjXwTB8y2kju4kgq/62YjjypV9sJ2OivEY39EkoZJImDcotu7o4Skm29KT8czCkina1K
         1gsmB3prmxk6GgIlmq5Lh8QcFNF8vStCWSn27Pa1egFz1H4YO7MFtmuyMwPrMZ/9/Oca
         L1Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788786423; x=1789391223;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6VpUJtRIrgP7Z0MplUt6dRio1tuWvg+b+028E1QMqao=;
        b=Ebayd+3PPekDU5QW1lugTpCJi7WjviAUMGBlTVDKnMnOZ6mukYpzsc18VxcaeBPiui
         VFb+0PNjZX2XMKnd+TLuR3CiR082vfg2CT5ezsTUHoW0w5bs1XNctHWyzDEFFOkzTh0B
         dROxy98SMcuqKWpNdXuOvXc+RjB6021KVbn5dYieP2edm4xkWC9JTwKcAAU95+Hppnb/
         9HwKQLy7Fosqovm7zCXMWNWa93n+ifFAUSqpKhajrvseLq73zdeKO7CjJtRWLCfzHSgA
         mf11CJeelA7+3xL/dyHyEevBhwQM0FKdiv05V1vqnh4a1s/ERXVTxEOk7i8gp+iCBou7
         12PQ==
X-Gm-Message-State: AFuF++mk8jifu85sswCcajqO/DqJ7Ifr8eXVhX0J73TMwOGRdFTp6sv1
	DwBMMTlWlnny+6Xe4ykDlETID1gkNppQ7ZhgVJ+gcCEGPa254WakWZs=
X-Gm-Gg: AYBFou1VlQdinIDAG1cDuuqEBK44159YkoZI+U6iNPSfMvwzS9EbpYO/GJuARhMvirS
	t+FoBjKW1JPfIVavge7PMH8ERjk1Mzc8lJyq1KPDyrwYna03MxHkaiP2KxWMOpKqWxLaY8gi9Ml
	Gh6txngK8+fWQaOQE1XNyZhtfgsQERa4o+JQW9VwPm0qtLoCV7ffwMc3fO/65cJQCOvlEa1ehKe
	VPf/ZELgNi44dflXzzG0HQjmNIWAueyzb6/LnvOZdlYCluelWJi1E14U0MmTJ7qKm241iy3YQtH
	l3FFdkxMOzApqZo4WBx0Tb5OkSknzWJoFpw+qxBOw1JMcJs27C703lK9pTXkddqp+Jt3jSPIaCg
	/xnmP3w4aXPrA4H2WZ3MLe8w5iLKS15ruya7Avh+ibI/yRL0B1iw7bN86dWw4TVAVae/ytYQ+MP
	6uWUl0bzDJ3c0wTiOic906j2AyvIT3E3KJGfA3OmTjdacuTNdTmZPDGOBMOYELJ8qjI/r+BQHTD
	zaD8KIljrff5OZN
X-Received: by 2002:a17:902:c40e:b0:2d0:cc92:f7ae with SMTP id d9443c01a7336-2db125ce071mr306527215ad.3.1788786422799;
        Mon, 07 Sep 2026 06:07:02 -0700 (PDT)
Received: from ydg-Zenbook-14-UM3406GA ([2001:2d8:6467:d689:c773:5f09:906c:a72b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2db149c3b80sm45614325ad.63.2026.09.07.06.07.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 06:07:02 -0700 (PDT)
From: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org,
	Xu Kuohai <xukuohai@huaweicloud.com>,
	donggeunyoo.kernel@gmail.com
Subject: Re: [PATCH bpf v2 2/2] selftests/bpf: cover the exception callback using its own BPF stack
Date: Mon,  7 Sep 2026 22:06:58 +0900
Message-ID: <20260907130658.612004-1-donggeunyoo.kernel@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260907054700.738DF1F00A3A@smtp.kernel.org>
References: <20260907054235.473103-3-donggeunyoo.kernel@gmail.com> <20260907054700.738DF1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, Sep 07, 2026 at 05:46:59AM +0000, sashiko-bot@kernel.org wrote:
> [Severity: Low]
> Could we update this comment block in exception_cb_stack() to follow the
> preferred BPF multi-line comment style?
>
> The BPF subsystem guidelines require the opening '/*' to be on its own line
> for multi-line comments:

Correct, fixed in v3.

  https://lore.kernel.org/bpf/20260907130624.611942-3-donggeunyoo.kernel@gmail.com/
