Received: from mail-ed2-f32.google.com (mail-ed2-f32.google.com [74.125.228.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFBE044CAE4
	for <bpf@vger.kernel.org>; Fri,  2 Oct 2026 12:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.96
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790945248; cv=none; b=WumP5cmt1p604Z3bb+pDb5GqzAu3H52hFBCbIwFB/gZraP9pOvATxKEGWTyzbLr4f+oaAmDHt1Tf75ZsG/GPz+xjOFALRZw402/JdYGPdxorKMyjmEXSPeZKvP59nvNt2Vb5wJkHSZsOKXnVwRpJCZFgY81cqJYruM4YV58Yyt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790945248; c=relaxed/simple;
	bh=4Jz56/laT433P4anh/93rQteerAAdqQQpM12fT6LsNs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=q020mJS/kIOUACeD1S4zhNMxyeMZ5VherRSWbtYyeCVtkCiQyB5APMtH7HCu+Yv9qDuAmBD4KxiHTNysSgFcjZoXLNxUWLrG6L2b0TQXzVBH9ZqLoGY4igby1JkB+0jjSd/+rQhtUzk1bqL3YRky6Ug7FkpNZwKUG47NvTWo6lI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=SXYYgXgZ; arc=none smtp.client-ip=74.125.228.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="SXYYgXgZ"
Received: by mail-ed2-f32.google.com with SMTP id 4fb4d7f45d1cf-6acbdf627ccso5146243a12.2
        for <bpf@vger.kernel.org>; Fri, 02 Oct 2026 05:47:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1790945245; x=1791550045; darn=vger.kernel.org;
        h=content-type:mime-version:message-id:date:user-agent:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=4Jz56/laT433P4anh/93rQteerAAdqQQpM12fT6LsNs=;
        b=SXYYgXgZECpp2wEM2gWOg8sX39egbNDCv0pBYGhKknAzmfznT5H73nDyGm6bhtYTNQ
         HYKH4YoQhRKhxOY/HmPbIxPy+CpVSsnymj3ARAwtyRUDvPo8kiQr8f5iKqJMkmtzno5b
         cuHtRn/PG1j3PEQIqymgfnkyOEYioSNt/pM4FxusHeSnaduKupj2f76qtWE6mBXAIRZ9
         6AX2wdUHkC8alaeeAzMlaY5BySdLwvdEiUH230vsBMN5LOaW085Z5FuC3xb/+xqCG3ez
         7ZxRZofAjuJ1Tle9C3Gjqx1CPcS7zbZ7JfbRarqA0ZXnUS0FkErvJL2tom29pIfszmbB
         1KdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790945245; x=1791550045;
        h=content-type:mime-version:message-id:date:user-agent:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=4Jz56/laT433P4anh/93rQteerAAdqQQpM12fT6LsNs=;
        b=dYJABey4OodIqUz2CTqJ9DxvcIK9mP/XMPfPmFI+6fIp8CU+mgheagB9OnirTTqDYx
         0QfK2QMJM0fUORQyr+Le29x2GW6ABAaxBY2rXrVrqRm2qgcQ4c1jzM6KHaiReL/ZmPXF
         sFpVxW3PL+5e8vk9xPVPc1EKRCStigN19V5H4zioJ3+KPzqme25yXWYXcHOkHFpkCY57
         s6WYcQXtUy28mpDDtmsUqtxsXZAgoqzprt74LRnsORDgma+KnI/QAULjzdJNjHI6CpS0
         2+++TDoStRVzCKDaFrlmqCr8mHasIiFeFDLmUe+n7OS7qHd2x8NRhFUMhDDv8tSYd7OT
         FpsA==
X-Forwarded-Encrypted: i=1; AKwUvBzh97Cr8d3o25IY1HJ79eoR4u0H7pL0jY94OMklXn4PHExp8zgByeD75/G+QiPkLF/zV80=@vger.kernel.org
X-Gm-Message-State: AFq9FYKvITVwbGPtNu3TP1Van5MyhH/81JChSGTuskZhxVfjXnbkQt1A
	3KeycD1zJN3vBa9K1/jMCRMtHDlFwviAOSud7gn/gyE09Aftgtua36y/Nx5eBXT5/rY=
X-Gm-Gg: AYBFou1DXlPnmIxD81vP1RU70Y/7i52bYShRO+2sy9q+X/O9jVgWsSUd9eeZ3fJ7RSw
	VITd/BqwXGtfUXySVE8rGh92iRPDj5YJ9TI5/7t+roLDIl5LwDmQ8fNzc9WksmW+A3paNrWvpDk
	orrwr9F5hMk0v4kNpQH9+jBL0pYv5b9DDJfRAumzYxPRYCMShsFLvslBJ683cwc9E9M17jd5a5Y
	lWwRmZ3qCf6oKJcSbxv4Pm0bW5GOGj5V91lnfGC0790ZS+CMwbuHWCuL4LIsYt5/mB/VEkxaDY9
	f5rhlZ2/reg3AUxqspnVxmFyyyPbKAwBVR+fUK2FS7T2zcElI4JBbGrsKM6JCzJdfq3xvpMHMq6
	0Z4OBPp2UTCh+u5pTIgBdCtszFa9niVi3UPRUA+1xm2s8lYMMBZg7MrCyrw/WqK+QLSEPavF/58
	EzDR3gFhB5eS0WHY3O0RQnzuZ2ZBF9nvRihjQsBIGNO5P2rH/giEeLDGgu6Qxi/E0LDOGkG5HR
X-Received: by 2002:a05:6402:4559:b0:6ac:7868:b690 with SMTP id 4fb4d7f45d1cf-6af9e2db806mr1359841a12.8.1790945245011;
        Fri, 02 Oct 2026 05:47:25 -0700 (PDT)
Received: from cloudflare.com ([104.28.21.182])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6af9dac29b8sm856349a12.36.2026.10.02.05.47.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 05:47:23 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org,  Alexei Starovoitov <ast@kernel.org>,  Kuniyuki
 Iwashima <kuniyu@google.com>,  Paolo Abeni <pabeni@redhat.com>,  Stanislav
 Fomichev <sdf@fomichev.me>,  bpf@vger.kernel.org,
  kernel-team@cloudflare.com,  Daniel Borkmann <daniel@iogearbox.net>,
  John Fastabend <john.fastabend@gmail.com>,  Andrii Nakryiko
 <andrii@kernel.org>,  Eduard Zingerman <eddyz87@gmail.com>,  Kumar
 Kartikeya Dwivedi <memxor@gmail.com>,  Martin KaFai Lau
 <martin.lau@linux.dev>,  Song Liu <song@kernel.org>,  Yonghong Song
 <yonghong.song@linux.dev>,  Jiri Olsa <jolsa@kernel.org>,  Emil Tsalapatis
 <emil@etsalapatis.com>,  "David S. Miller" <davem@davemloft.net>,  Eric
 Dumazet <edumazet@google.com>,  Simon Horman <horms@kernel.org>,  Jesper
 Dangaard Brouer <hawk@kernel.org>,  Willem de Bruijn
 <willemdebruijn.kernel@gmail.com>
Subject: Re: [PATCH net-next 00/15] Gated tracepoints for skb lifecycle
 (free+clone)
In-Reply-To: <20261001184551.314c7a0e@kernel.org> (Jakub Kicinski's message of
	"Thu, 1 Oct 2026 18:45:51 -0700")
References: <20260928-bpf-meta-gated-tracepoints-v1-0-844dbf3e1edf@cloudflare.com>
	<20261001184551.314c7a0e@kernel.org>
User-Agent: mu4e 1.14.1; emacs 30.2
Date: Fri, 02 Oct 2026 14:47:22 +0200
Message-ID: <87cxtsl15x.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Oct 01, 2026 at 06:45 PM -07, Jakub Kicinski wrote:
> On Mon, 28 Sep 2026 13:40:17 +0200 Jakub Sitnicki wrote:
>> Subject: [PATCH net-next 00/15] Gated tracepoints for skb lifecycle (free+clone)
>
> is this expected not to build on top of net-next?

No, it should build cleanly. Base was 42a9fb3382fc ("Merge
git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net") [1].

But you can ignore v1. I will be rebasing & respinning it to address
your feedback [2]. Likely during Plumbers.

Cover letter also needs an update since benchmarks got fixed [3].

[1] https://github.com/jsitnicki/linux/commits/sent/20260924-bpf-meta-gated-tracepoints-4a731fd0ef64-v1
[2] https://lore.kernel.org/all/20260925132004.171b751e@kernel.org/
[3] http://msgid.link/87ik3kl1lr.fsf@cloudflare.com
