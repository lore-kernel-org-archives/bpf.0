Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1204354F9C
	for <bpf@vger.kernel.org>; Mon, 18 Mar 2024 16:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710780745; cv=none; b=qdX4qVj52+oW49a/mMIJzeKynABckLfIIjpzB2+bR5atc0VeaXov28ULkqqVxXvI8vJN9aX7yMgf1a66yZ5qyRWZiwJBT1eI+cC6gHiOcyvJzTPGDRF1OyCWiqAlYQ3vbLTzbptUDZk1dq2rkxfq6yZZhDaK/j3Brh+Gi1BJnyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710780745; c=relaxed/simple;
	bh=4MKKObN+QZLmpADBDsLo35UGZJZSTkcMmdglf5HQHEc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dq2jbnaaPPyLRpFLYylscYFXmciVgO/0ZiA2cPFxyAlZ/9i302BCOgPzOY1c0URxnbgFva5UNq3OWdY9YR2mA6lurX26MTPPCJLDPL5nmvC27nzsoDC42GpbrU8SJH60thGe40hAf2cbpbRTEhzuAzci0q/OcsEiVD06xLpw/JQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sdf.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HMiaBRUN; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sdf.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HMiaBRUN"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc6b26783b4so4563733276.0
        for <bpf@vger.kernel.org>; Mon, 18 Mar 2024 09:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710780743; x=1711385543; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=z6oC4/UfrqqhlN2ad8fLsd1opVxrnNh05czD7jtxeg8=;
        b=HMiaBRUN2nx1cd/5733fMB9698Ry2lV9qtxg+r9J2uoYIK+btaSnMfW+eWb43bGawn
         56FO+d5FZwfJO5dShyrcYOfPRFQNVMVuYo9Vyoe+MQ8R9vU4n3j5DCrPUzhPSGdR0fKc
         rSUaKbjvY5Z07lCj78ULNkQoNnvvjlR+chTmR3UctXL3cXlRWlLEMqDJZWsTFO4E3qGN
         BCUlBwXT1V4n6yAqv+zQWZSLSsTH7Dxg2V20IiOIuOLO4GYdak3tDGyUVx5mn+wdEoXE
         L7xYj/kdBjxyAdzHZdubsUTlzjSBhmRsPbhsrFk2UmLDymZu1eKGDH3jGZwn2bIjC3iX
         eHwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710780743; x=1711385543;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z6oC4/UfrqqhlN2ad8fLsd1opVxrnNh05czD7jtxeg8=;
        b=vmZUlaLok/H0O7uHwK4R854eWV/2xNjfbEeDjVMQKAA8tVAnsrVatIBUIH5SAKLfbR
         VFkcu+oWjL5yXOfnS0GVR+VGE7mCqWeonMKyM+b+3WyDPkoWSA6HERienFTo3K++1IX+
         WhS0rNpIPlSmNULP3FDMvYOm9pMXxOzstXZSRwRw6jUchm7Pjqhr/8DfCbwcVLD8SEsP
         ZkzdgnQxhrt7CfMtNB8OGFSyTPmSuNrVisEA+5yQHlNVZlnpmakjwSB8bc6+2U5/DFgh
         dR9dxYXSCSvx/4/wPHizq3jQmC6q8fiI/1GO7lXnmYgnAJerGGMKN1M/TskHC+zGXnKv
         iM9A==
X-Gm-Message-State: AOJu0Yx8OSTGJVQGhx38ew3P3IscicqX1F95o/Wm6Lhrdl5QzCVjgOdM
	TMJHaffFtdy28TptqZN5loGj75pfDswxV6D+F2nqxCaX6Auj3eAeSCPrbmHtGnD+7Q==
X-Google-Smtp-Source: AGHT+IFwtgRLh+lulVILDQ2/kd3DMW6sId/sUd5zrH4j2mpdHUbzWXnDOIg+pvw0ZwuWDDljjPfWn/I=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a05:6902:2201:b0:dc7:3189:4e75 with SMTP id
 dm1-20020a056902220100b00dc731894e75mr698804ybb.3.1710780743058; Mon, 18 Mar
 2024 09:52:23 -0700 (PDT)
Date: Mon, 18 Mar 2024 09:52:21 -0700
In-Reply-To: <20240316122359.1073787-1-xukuohai@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240316122359.1073787-1-xukuohai@huaweicloud.com>
Message-ID: <ZfhxRZR9ejNt8mgN@google.com>
Subject: Re: [PATCH bpf-next 0/5] Fix kernel panic caused by bpf lsm return value
From: Stanislav Fomichev <sdf@google.com>
To: Xu Kuohai <xukuohai@huaweicloud.com>
Cc: bpf@vger.kernel.org, linux-security-module@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Florent Revest <revest@chromium.org>, Brendan Jackman <jackmanb@chromium.org>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E . Hallyn" <serge@hallyn.com>, Khadija Kamran <kamrankhadijadj@gmail.com>, 
	Casey Schaufler <casey@schaufler-ca.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	Kees Cook <keescook@chromium.org>, John Johansen <john.johansen@canonical.com>, 
	Lukas Bulwahn <lukas.bulwahn@gmail.com>, Roberto Sassu <roberto.sassu@huawei.com>, 
	Shung-Hsi Yu <shung-hsi.yu@suse.com>
Content-Type: text/plain; charset="utf-8"

On 03/16, Xu Kuohai wrote:
> From: Xu Kuohai <xukuohai@huawei.com>
> 
> A bpf prog returning positive number attached to file_alloc_security hook
> will make kernel panic.

I'll leave it up to KP. I remember there was a similar patch series in
the past, but I have no state on why it was not accepted..
