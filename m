Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A43B752F79
	for <bpf@vger.kernel.org>; Mon, 18 Mar 2024 16:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710778037; cv=none; b=a9WtMG0kPYPm1nni5v4Q8ZOogDyC7PVNvcmgbsVBBuXL/bylsC4jnEfJXno+1JVIhSPiZ0Pwp/3mDELzeiMGSC+p4Hd9L32lhqK/w91JjO/traGz7Al/MispjaSG+u6V+0IYS4n1WZvHmdi6SY81EnTja8+/TL4uXQM/d3WBV5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710778037; c=relaxed/simple;
	bh=5PXmXrICF6GrxaIO5e63Q2oLbzQ0JOSVAmmok0aNVlk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SK5oOHW+sRN8JCaLy67U6lPfwoOsAFa3LMSJ51xEO7/trIwXSnit2CM8BlRN/MxAAf3zUTES25xNoQNekJGyFnwu0PgDaL0XPK9/idyY83OxgLUp6siGHk/uD9SYj8wqKoFpyIBPJ7XuaOrbuL6oZDfioG2P8zRbO5sB5k+xPBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sdf.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OPMBfRAf; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sdf.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OPMBfRAf"
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dcc4563611cso6323318276.3
        for <bpf@vger.kernel.org>; Mon, 18 Mar 2024 09:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710778035; x=1711382835; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=BRMBKkFLpx5UEPxApBmIvNsw7kmzwH3SFmSAn82Rk90=;
        b=OPMBfRAfTDzTP/74uNhVXmO+gTEpKu7gbzJ5Sb5V+BQlqjvDmHP75aMYXGYpfxUqRg
         7Vo0pnr73pB1E3PJ4b/KwoUeZlkGFYoimtt/WgavjE4oxTi3IuK2ttCq5F2Z2tz2Px8Y
         EGwMfHmlv9JFlPX4xFLXQzk8IX3RjsP/ZNgs19mRCyItI50rxvv2cIri3oN9dIkSjQZm
         dQjTtnVfPEGz4B0RnmJGP4UzOqPsIIhzidHZN/8m+LJbATYyelLuB9XeLlpd248TOFo7
         t3m5bF96seueMF+2AF1+abFHD2UJoJny23BDwfE6GxWPknAyfR0nkyYsHSxQSd3JVlxc
         0GZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710778035; x=1711382835;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BRMBKkFLpx5UEPxApBmIvNsw7kmzwH3SFmSAn82Rk90=;
        b=Jb8aV8iS4bBjQVI9/umZyVlRa2KK9pj3rfqXHjRqEIeViia7qsqp0oAMIHVwrG8lIM
         V3TvICn9vTwsoczEdD7/eXVRbfrQ7HVpDVmPjR10dlMALEF4HcphhVxUAUMMtuYQfN0T
         cHwCpjj1bCKVqPyyi8bVmc9OXu9f1Y6lN+S50+Syn2v+mnlBYDoIP5Jq+GsyxNcoSCmH
         FyvzKaM/9iKPqn0msZh9XmXvV6uvDgGwh5CFUUhthJVeoBUd/l6/cPd6kG/upF0rq09o
         YtkQcpVkfYh+D/1bFDjCohK3UIk+QLZgDjKLcQ7IICDtl2LvCOeOsI1JOXh5dhsXNx4T
         3TFw==
X-Forwarded-Encrypted: i=1; AJvYcCVwcdFWsPvKMqo1cSOxqnp1imoICCHTj5a+UJSwuhpLqu+LmcySf5MLTzNPGyNOqd/gwSGiGtW4S1LH4ZtYy9Oxq7e6
X-Gm-Message-State: AOJu0Yy0aBkSXWz0GPsIdSMthUKl8eyoXR9QvUhnMFRo9t6wFvqzGPTE
	JvpL3bsKMPybW+h2ELZZJjRAjOULASG/1HVFuocn+wk0b7C3xSAXDMXMX5OephV35g==
X-Google-Smtp-Source: AGHT+IH5LNfmfR88tF1ClH5Z2TED8izBfSAYp4ik0sspQZmPUIP4mgDyRQxQVlVvUfOwjAEa/ngdslk=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a05:6902:1004:b0:dc7:5aad:8965 with SMTP id
 w4-20020a056902100400b00dc75aad8965mr3240384ybt.0.1710778034738; Mon, 18 Mar
 2024 09:07:14 -0700 (PDT)
Date: Mon, 18 Mar 2024 09:07:13 -0700
In-Reply-To: <20240316162241.628855-1-josef@netflix.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240316162241.628855-1-josef@netflix.com>
Message-ID: <ZfhmsVTIe-khu9uP@google.com>
Subject: Re: [PATCH V2 bpf-next 1/2] bpf: add bpf_task_get_cgroup kfunc
From: Stanislav Fomichev <sdf@google.com>
To: Jose Fernandez <josef@netflix.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, Tycho Andersen <tycho@tycho.pizza>
Content-Type: text/plain; charset="utf-8"

On 03/16, Jose Fernandez wrote:
> This patch enhances the BPF helpers by adding a kfunc to retrieve the
> cgroup v2 of a task, addressing a previous limitation where only
> bpf_task_get_cgroup1 was available for cgroup v1. The new kfunc is
> particularly useful for scenarios where obtaining the cgroup ID of a
> task other than the "current" one is necessary, which the existing
> bpf_get_current_cgroup_id helper cannot accommodate. A specific use
> case at Netflix involved the sched_switch tracepoint, where we had to
> get the cgroup IDs of both the prev and next tasks.
> 
> The bpf_task_get_cgroup kfunc acquires and returns a reference to a
> task's default cgroup, ensuring thread-safe access by correctly
> implementing RCU read locking and unlocking. It leverages the existing
> cgroup.h helper, and cgroup_tryget to safely acquire a reference to it.
> 
> Signed-off-by: Jose Fernandez <josef@netflix.com>
> Reviewed-by: Tycho Andersen <tycho@tycho.pizza>

Acked-by: Stanislav Fomichev <sdf@google.com>
