Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A67633AA4F3
	for <bpf@vger.kernel.org>; Thu, 19 Mar 2026 19:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773947688; cv=none; b=O+lx2CDEZGPMza5fNPKqc2gETdwwkMrMQ9jDmd3weS5fZAfm8QtoOQULrqRerEBIlrtYcD1wFRHaICZMNQ6IjC6jOwzOwvH6XdJWpxbFxKn4QcOU32KfMPhr0pXC9b8EIPVfsmjm+cQ/ZzNqVHSU7HY31GatzqyfyKmrvvaZoh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773947688; c=relaxed/simple;
	bh=mCpD3uFjnWAzTGsd2HnYLgH884yq5Vh3bXupfcpRHRU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FTumQbcm55ErCBeUwSEWVgMtrqL3BHKQ33GMDQrR5oGwqgR+0iJ8kOEFZ08xAoa4PiR5CDrNUNKrtBMDUTg3glQ8pbejpTMphHP54vtYp7WNkrtfNFrN+Gaqb6xsRQTQa7P84bvukK0iR/gs5iYRpjy3YSoRJIoCYEb19lLb08E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gylj6wsw; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gylj6wsw"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b9825ba7e8dso111504166b.3
        for <bpf@vger.kernel.org>; Thu, 19 Mar 2026 12:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773947682; x=1774552482; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mCpD3uFjnWAzTGsd2HnYLgH884yq5Vh3bXupfcpRHRU=;
        b=Gylj6wswUhTJF59vEUknHTCJ16MnYyDzeuTkg1mkQPqJUZvgXH1Xu9Ed/KYaiHBfU0
         8mngUVTqZq5oD0tG04ZSn4f5yLoQwYvihI1y7H/8kJKzGF7/2JiqhCg9SyBFgV1a5Dzq
         XYfJTY1bNu7+lvApJSHOP1nmtSt6VAUhQ42vGYm4U2Z724MfCXQokBcmVIAPWdmz83NV
         sOFYU7rl9IlWqe6fPm3ZO0QzRLywa8iuWnwEfA2Efhsf/JbVJoPOCGWxIIKhwt3AqgXz
         6SoG2sYiRZvPyHBEk+lB34zPxgT4qe7tXGxWOomU+CTG9Kigw5P5XzQ+Xje9kJZPCCPc
         n84Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773947682; x=1774552482;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mCpD3uFjnWAzTGsd2HnYLgH884yq5Vh3bXupfcpRHRU=;
        b=CDEBRZw8l0RnCw6L/+0WaBsTAwNfP38yFBHNwZpDh8I/zDZfsk1gX7El4pb3A6dpEd
         gd2mldIs83Aa9meCU9IN6I0cVB9MdT9TFZQBjYW+wFwWRIKBLPuSmjyRU0SYjvA6DbH/
         oYbjCgUqMdHB6rWM31zeKGEtXFlQY/KGgIVmFi1KUZ+TnkRZZ8LWOFKtX5aXY4M4/6vM
         RaYrDPt+3I5AZnGsclddVUv75TDiKxz7hnPrCnqgk5Dcadj6Jp6N2twS6LPSSSqYQlos
         dX5g0dAqhBx7Iqqz23ui5773XM1mb42OWYft4cPqFUr7cM4hAACoXC68DKcELSiSszor
         Fm5A==
X-Gm-Message-State: AOJu0YwicZEJA3bSQGU9kFiAH5VZxURVFA4FWkySRzsceUbYfGhrOt4f
	o+T3v/ww/RYvFDPqGUDwmMZcA1/FA3fNGnrv/7vydGTcyETm94JIi40=
X-Gm-Gg: ATEYQzyTt9VZVa0cByAL88oTdpTw6jUTgRdbjawDYFUeEcNK5O1EwN1zbhLG+bqqrNf
	lp/XkeQ5rYdI9T803FLijCqmZ2tM2CuU2Zq04if9KwAZhQjpLvLqU/McuUHZEUmKXGsFxuLr6KT
	iffIWMT8inhiESddbvPJHfYkixetB3KBnztKLIlbovKUbmQlgLt+2dbFXXM/t4M+szh0e5sC/oN
	qHWJxj4bcVAMBjZYmwS3MhurcJKcrQ7t93RnKEXmP+gX+HlXjqhVXqpXFHUAcmKlo5pgkr16cur
	yndA5MjPzGksMBushhNmHT5wZDCD0ZB/gIL+BZwLjUVLfwP4nVoz6lR2VT/nfFCA6jWsVeqds95
	QF7Xjnrj3oYnd62h8+8m/QVMGmzHDPxtrez/Oz0zbjYGeD2BX6rHoBxDrTmCaNRPVcKIfh+EzFK
	YmIJ0qIuuPicG/pJB7ywyjuRS/I8/BPZNb+G8yecPvRkk2oUD5DqGsTBAN+hHodJxVVVz09vJJT
	RuuYcZcRuQwAYstcfTbHtpdOA==
X-Received: by 2002:a17:906:2746:b0:b96:edcd:cd04 with SMTP id a640c23a62f3a-b982f4ed3c9mr31906266b.49.1773947681467;
        Thu, 19 Mar 2026 12:14:41 -0700 (PDT)
Received: from codespaces-35910c.jmi21fcehg3unfegezsteryjgd.ax.internal.cloudapp.net ([4.180.183.243])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b97f1686b7csm506488066b.31.2026.03.19.12.14.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 12:14:41 -0700 (PDT)
From: Ibrahim Zein <zeroxjacks@gmail.com>
To: ameryhung@gmail.com
Cc: bpf@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org,
	memxor@gmail.com,
	paulmck@kernel.org,
	Ibrahim Zein <zeroxjacks@gmail.com>
Subject: Re: [PATCH bpf v1 1/1] bpf: Do not allow deleting local storage in NMI
Date: Thu, 19 Mar 2026 19:14:36 +0000
Message-ID: <20260319191436.16817-1-zeroxjacks@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260318224008.602158-1-ameryhung@gmail.com>
References: <20260318224008.602158-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 18 Mar 2026 at 22:40, Amery Hung <ameryhung@gmail.com> wrote:
>
> Currently, local storage may deadlock when deferring freeing selem or
> local storage through kfree_rcu(), call_rcu() or call_rcu_tasks_trace()
> in NMI or reentrant.

The fix looks correct. Adding the in_nmi() check in bpf_selem_unlink()
rather than in each individual helper is the right approach, as it
centralizes the protection at the single entry point used by all
bpf_xxx_storage_delete() helpers.

As Kumar noted, the commit log should mention that kfree_rcu() and
call_rcu() have always been unsafe in NMI, not just call_rcu_tasks_trace().

One question: should the return value be -EOPNOTSUPP or would -EBUSY
be more appropriate here? -EOPNOTSUPP typically means the operation
is not supported at all, while -EBUSY might better convey that the
operation cannot be performed in the current context but could succeed
otherwise.

Otherwise the patch looks good to me.

Reviewed-by: Ibrahim Zein <zeroxjacks@gmail.com>
