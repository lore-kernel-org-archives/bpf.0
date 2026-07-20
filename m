Received: from out203-205-221-240.mail.qq.com (out203-205-221-240.mail.qq.com [203.205.221.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 808332BE7BE;
	Mon, 20 Jul 2026 05:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784524402; cv=none; b=G89bRApjp7gyf6abINKTVelw5gTf70sopZKwP18kUkMjHpqW2GPIAVYW3Z4csVVHd7Izzr63Qjti2iaY6R8MmibRnpG3ZDayVugR6A++sIILvvUKdlC2d3wJCfQcc8yIolOX2i2q4mZhFi/C99NYOt7oFki01gmkuPTGsDhdaw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784524402; c=relaxed/simple;
	bh=FooyImD8cg8TX7dVexySo1iTXXs2Jxc7D/885lCjPzo=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E5Nbzcc6nbtSfOk4tjg8mBpFaqe59dSQTZHPIvsxIRF3kDad5/Ug04PjAt9VONrmBfnnlWRbHOcCNAM4KT1SUQKIKgzZZfUiL9B9EKKjvSPRivHQsigrpyvRvlB+1XZiCWI9eT/SHEVrdD3oLWm1hLm0ELfXziYQDY3J87hZsKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=l6KL81GY; arc=none smtp.client-ip=203.205.221.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="l6KL81GY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1784524390;
	bh=FooyImD8cg8TX7dVexySo1iTXXs2Jxc7D/885lCjPzo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=l6KL81GYD6LWX9VNGNggpr5BBsLr7uXz4fBQqqB1JPDs3kmiOArR2B+XCzVvddmLv
	 KwGp1kyO9RXiM9crcIuPqlGhyKTNB+Zy/g7Lkzfx0NxcxN8tLU74QA/FlnGptD6Ck6
	 l9mZLnpi/B5kysJovpqdiBPJjYMnTIXh3LBbD9lk=
Received: from localhost.localdomain ([180.153.160.8])
	by newxmesmtplogicsvrsza63-0.qq.com (NewEsmtp) with SMTP
	id 34724807; Mon, 20 Jul 2026 13:13:07 +0800
X-QQ-mid: xmsmtpt1784524387t2wd21vjk
Message-ID: <tencent_B8C82F954152FB6A22D315A324A2A8BA9208@qq.com>
X-QQ-XMAILINFO: OOO9dHjlsLs7oC7HEagNkQ39WJLvoetd5A4U1A7Xf6oFQBnih9TWjmbIYAW99+
	 RWKt91PvpaOo+ctqB07mevIx9Oxhuj6lRGdbx6D5xudu2ppHX/GEIfUikjWhAP5spIuPMgnGaIqG
	 3LxOXEdORUyRX4ovuhlm8X2IbfSFlRWGGvSQ/1eQzIIMDd9eRDE23RpFL5NXSNoramGAJPyvWoEi
	 ihglbD59S0DReagCqslpD1+zHkRkhCSlvzvKvhmXfCiRX0YYTS0+ivEXaGn9XcjGxPV13T73fFm7
	 PgF99iY/kb6zVow456nij8g9s2CXlZle7VKSawtdnqABJVbOTCb6yjLJn1vxswVz2B8tJJNS82Ht
	 7eOavqDodcsukB6AHb+ahzDnk+o4Bd3Uk7MHmXMgJR2PDCvN2Zi8lgucFDzifZ03tf37B8KsYv+m
	 1kCfiE6aSlDypHZoiqcx0subLsc2QqQlKUt/ClRYLRzzdno9F2U82pfLW2K5ZgmAXR8UQccGpbUc
	 4st35vSLSqD+piVT7QcLdMBkSDdVoAQftPUkqWa9sqk9eTy8ewEdosbCETsSWMRhJbmGuvayEEnW
	 Dzm0KcZlxk2NIrEvJGAizUZtHLz5rMtCy/As8aQZ1h430t5KPk9hte0rmqaQut1gT2nX6l0Ypkg2
	 Nqdffh4EaMq8sV3MiKWfKbgDt/WbVT/c4lgTLN/uxwKppmd9Cqylq4v8Wi3hdLTyx76Jw6LI6FUR
	 YGnWxNMqLgPRAOhaqAxKuowL083a+BQV3OQ83Me/0F3ngJcI3IuKWmIjkihj16u1vF8Vmx49sef5
	 /AAWSHdG03GwkbEJVCXn23vKyubW+dO8m7gp+RxZZyKps8gk0iZKa5cc1lTrVOAkLL3SxO6TgJKN
	 y8FE+VhnVbS8ywcnFGWRpppk/heIC2BWuQP9R89SckNb4aTc+Ci+ioUvEFhzkovOhfjd/hGje3CH
	 HzueuhtgMMVdm6cRJjuob8pA1r3jvonHen3uc2L22rSxOGK9hKFtSMLJY4BPffondqBUcWuTzqRB
	 cwHazOQAI0gyBfOZKzX8CRzYVH5Vh4EEazwr5xGg==
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
From: Jianlin Shi <shijianlin11@foxmail.com>
To: pulehui@huawei.com
Cc: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	memxor@gmail.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf] bpf: roll back stream capacity when allocation fails
Date: Mon, 20 Jul 2026 13:13:06 +0800
X-OQ-MSGID: <reply-pulehui-bpf-stream-capacity@local>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <734259ce-a3e6-495e-9c88-24ab23e781bd@huawei.com>
References: <tencent_E69EAE29327E25B3548A9AF3F4FA289A6806@qq.com> <734259ce-a3e6-495e-9c88-24ab23e781bd@huawei.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2026/7/20 11:40, Pu Lehui wrote:
> looks good to me, but it might be better to target bpf-next, as this
> isn't a critical issue.

Thanks for the review. Will resend as v2 targeting bpf-next.

Thanks,
Jianlin

