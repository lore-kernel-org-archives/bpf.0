Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 313342D73A0
	for <bpf@vger.kernel.org>; Thu, 18 Jun 2026 09:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781776722; cv=none; b=SO40KnuMzua5utJMlCD5NTnRvzyOa4++xd94kXuV0kx2AGQgz/miU9Y+72uqWprBmssKPsm4uivjCOVkdq+Yr5mMUd5vkx7EDt7d/lEIMbx39XZcffbvAx2Dkdajw3CNUNzbNulWMpZzYgwo1IDj2RTId17BImEgj1QwG2wAHrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781776722; c=relaxed/simple;
	bh=IwcW9D8EVGwonbJsnujnZwT9HqYS2qimfSaEFYeqVH8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=axt6qzvsh9xRpNgEXFZlQmzHZAD+3N1Fp4I2oITg7NoxPx5q+ZvV/vBzb1GdRHCe1fPoz5L0KzXw/yaSS2f50pinqFwwIEOa3x0PZLFmCuB5XYnAVvnMdVw/Fe3hkqnp41xsVeg97iIoszcNOFE0HExqxObn7nM6LLBSxVGuyYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=DORGn3WL; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="DORGn3WL"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-68bd9fce347so1174876a12.2
        for <bpf@vger.kernel.org>; Thu, 18 Jun 2026 02:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1781776719; x=1782381519; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:user-agent
         :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IwcW9D8EVGwonbJsnujnZwT9HqYS2qimfSaEFYeqVH8=;
        b=DORGn3WLqDe3zPphxTEr9sMVXEJR4TcDjf9NBJjM+FbzHVuPcmNIpUU+vatpt9gzQK
         DfOrzrJF4ZtqOTYBHTwV/VA+UQLo8gwaiDnsqp0J07wDcJuSoGzq2DDP7n5khO3oLdBx
         nfeZw5O9EsX+uqYElb3mbYdn2C7yxNX0NR+d0GrBQNUGSBZ0O9ihbylxZW5AuR8lfHPV
         +fV6mvDCRKh17txP4l+KLXBDZJHEGiK85Q6w0Z1NBYlKotjsF6w3JZDFkwPx8nC51HI/
         5kRTZKQgdBERN3P7tUQgCEUZrL7dNhcIr1MaOq6QQr+OYWUHXjNXQIKWgVyRqmV90s/k
         P9BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781776719; x=1782381519;
        h=content-transfer-encoding:mime-version:message-id:date:user-agent
         :references:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IwcW9D8EVGwonbJsnujnZwT9HqYS2qimfSaEFYeqVH8=;
        b=slUz/yrlqjYFkB0vXaDqJJkb+lon54LEVv7qGKVeADYCgFjGCq1WLWHzmn7/V+6G78
         O/0PLqMs4mnWqYqnOKQUn+8qjIM1Er4OhIJilEDz2CmdnpxjTysxlv9ikxvYvzQMCH+M
         bMhKqSr+CvFCkfo2bdwOmxT99RHgWQs7EsKYAR1PTQm1nALk1DccRIaxse8skUPbIz4/
         +2iNFnDKZsJq/ubyLDraZlF6DTmeuf5POZM3TaexdxgQ7+SKXRIAEh1GSKFZh3vnQmi4
         syqm9QTRraoIwjTlwmmkbA6miOPrQExzTNXX88KRDOilU4yWxdKwxMpAKps9zjDQFUGh
         dIyw==
X-Gm-Message-State: AOJu0Yx9sN+FTe1dTOsRw8K4Stppa9mkogczAF0c5ds2ZIsgxz8NnIsX
	zmY+DolLKm7hS1TjeFD9NS3k2JLjZGKRftM/TXbCilGLq+FHjsJpwAQfOnMd4bRZGWKuFz6Y/vz
	bPde0
X-Gm-Gg: AfdE7ck9WXxgI38mmicF4RcjFnvV6ClcxllL8endTcV7MzAkVJ2INSePbinY1ZNQTxh
	yED/r9rOJKswBEycUZo2PpkxOYyj/7BxnYEOAQQ2mG61otDqZjIXI4Vrmk1wYIo1vXlkYgR7YR5
	RbcWlDEIfkyVPkRZ4giRuGggOQaQWdU9at0pkLnQHqm1ZMJKRyH8JegUo/uMVpkuwrbfnMBdrY3
	TklL8TGo3lTwinCIGvltcoAuxrZymdsPgJxbtKGCJxRvBi5OZjvY3xfQUzRBLx9ufIlnpKCxLoA
	qTM18RyW6407q65TEIrhVG+ETJCE2pyKzXCvpTKLmOuWrkCu18GbgDpneTKXR/lZ/hFZL2dpK6Q
	5eqx8VG5vti+6vrJPhPK5m7bdHYSLq0ZgPkmSMxQDG/umjWenV/KySJqMIFxt0vz6u78x2dlkzg
	SEpIQRfYDGcWl17b8=
X-Received: by 2002:a05:6402:28c3:b0:691:6fca:c1af with SMTP id 4fb4d7f45d1cf-695ed873519mr610890a12.25.1781776718949;
        Thu, 18 Jun 2026 02:58:38 -0700 (PDT)
Received: from cloudflare.com ([104.28.21.182])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6937919b4c4sm7399972a12.6.2026.06.18.02.58.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 02:58:38 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: =?utf-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Cc: bpf@vger.kernel.org,  Daniel Borkmann <daniel@iogearbox.net>,  Alexei
 Starovoitov <ast@kernel.org>
Subject: Re: [PATCH] bpf: Fix BPF_PROG_ASSOC_STRUCT_OPS last field check
In-Reply-To: <20260618040934.4113938-1-tweek@google.com> (=?utf-8?Q?=22Thi?=
 =?utf-8?Q?=C3=A9baud?=
	Weksteen"'s message of "Thu, 18 Jun 2026 14:09:33 +1000")
References: <20260618040934.4113938-1-tweek@google.com>
User-Agent: mu4e 1.14.1; emacs 30.2
Date: Thu, 18 Jun 2026 11:58:37 +0200
Message-ID: <871pe4b25u.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 18, 2026 at 02:09 PM +10, Thi=C3=A9baud Weksteen wrote:
> When struct prog_assoc_struct_ops was added,
> BPF_PROG_ASSOC_STRUCT_OPS_LAST_FIELD referenced prog_fd instead of the
> actual last field, flags.
>
> Fixes: b5709f6d26d6 ("bpf: Support associating BPF program with struct_op=
s")
> Signed-off-by: Thi=C3=A9baud Weksteen <tweek@google.com>
> ---

You need to indicate which tree the patch should go to [1].
bpf tree in this case since this is a fix.

Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>

[1] https://docs.kernel.org/bpf/bpf_devel_QA.html#q-how-do-i-indicate-which=
-tree-bpf-vs-bpf-next-my-patch-should-be-applied-to
