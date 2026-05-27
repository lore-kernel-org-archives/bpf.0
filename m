Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B2733F39CA
	for <bpf@vger.kernel.org>; Wed, 27 May 2026 10:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779878808; cv=none; b=LwSVajUB6k5HddQRKnp2ioYEwi5UfBa3/FOm9LPSLT7yc/0X7xLnAuwrfNv7nltHx8L4TG5Gng6FBNb+EY2X/A/B5UY8l34qzzxls3iy/IqSti1dqiRXcsLTEcquukO3axQpvmy+mS79mHRfC0JtOwtjT6Lq+M65KB7AxQf2O6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779878808; c=relaxed/simple;
	bh=osV54YqDKMAqYLeNjLluRy43g+a4qFnra9hiufgmy34=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HhXpzzcrjnurXfE7Sc6QmHeM5jX1H2MLwVLthd1283s/TdcmOOOL0T4qdyzqaFpr0UkwN8nOkgPQfUBnPowoJkLiZtC+HkppZijRgO1UjXYFnvIXnVddvS3k122eY4ALt0OnceJJhUo2nZhKmeon8kjZKoZ4XZAyhSXOfJaGp2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=RS13JRPe; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="RS13JRPe"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-687ed9aabb3so11332121a12.1
        for <bpf@vger.kernel.org>; Wed, 27 May 2026 03:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1779878805; x=1780483605; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=osV54YqDKMAqYLeNjLluRy43g+a4qFnra9hiufgmy34=;
        b=RS13JRPeaIxXK35VOd+U6mR84YFK7cckyHdZwjn5SsXcLMmPXpUr8YTH/7GA0H5aok
         H00tJKVfhKXsXo3y/EFLVN1KXhT+t5aye8C8DMW+S/HuJgwoYLSQ75bWCPeSxusnIYJ5
         UvDvps4yEYI3U1F51FCg5xqsOXj9mT6oA1on7eKus4dPeDtz935CVTM+1kxkHNaa8zyQ
         nYGswarxw2jT0pnGWcN+3+HC70F8In2wdhsTZg0ZCbY248vcnySu7G+jUzWZun/yp9jS
         5YMr1Mz0MtGszQ8gaKl3yPQpA0aKKTAAcAySXQQ7lGuIiIX/Z4sE0dD9b3rkpt2e8DW+
         pOOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779878805; x=1780483605;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=osV54YqDKMAqYLeNjLluRy43g+a4qFnra9hiufgmy34=;
        b=cNuu7UaI5jWadLskqWTX9fVVBVVajnbFHceIGnTDZiKtYtRGA+pozcE+n2gCHtzWHp
         yjbzmWI0Ju8JqFhemeQ4byLa9p0n/I0tOzRHJ8XQP6oI8A5uo4TX1I/FLh3HZ01RPS8L
         sPouMyY2AaE/1s57rCna9KV0j3+CtVM57Oh3KRoYDjZPN/SIh83T6LDucHad0Dc/YURY
         8r/aTVXLRtiFMV09m5xeYVhflITFM4ALoi29wTEra0ZYUy690hZuWWtYe9aHkb1Da7BW
         BT6NhSvbERER50hILpJ0Wp+/liJcvzgxU9S6ZhFIKeJD7PH0yVb5LedqCCPRgrqfVvlj
         hAAQ==
X-Forwarded-Encrypted: i=1; AFNElJ+p7tLNA78QTpN4pE5laSwIfolmZlacLfUlKbqUciE9oai/Q6D261l4C6gnqZvWokyXz+U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpYpJlU0x+pXy5OupYHNQ1XPv4j4Wd+XRHFMwtH0BxZ5SAbguT
	147K3UpG5wFyAfmqdlE/vweI3Su0Bhrc/6hRtFu4fm5EtyLp3cyOvOR1OVpshbF4b44=
X-Gm-Gg: Acq92OHINvP2W1y8hRhow7SYMDuinlPVV2HijUXJy3IroVJDpQpeSyS5wB1Qy1J1U+J
	zzCzeoIWl4VbhJ3RLVU3g13vLRy5liADA8Ih5PlyK70aOcnB82fFSEtkeNPviDXN/g546lo9E67
	qrCvR8Jdi1Gy+qfsbeS3oT3/r+Eg7QenETQrk4sb6PE9aROUpkmw9wwAVKe5R/SAqea7YdwC1RM
	9EESYxPTVBaNSvZTfs51tFAu9BWiYzSncl9KHzusjSXKbVb3BrJbiJYyTOdaFnuUmMvHaMVkQlr
	zv1P5Km60CNOzlI4UoFsVB/FpDeJdOkiWs0noxkIYh9lFJkmQdEgouIdnyTxtYQ/W7nUxaFPKBL
	O4mkmytfxEJ3N4jyOLzyTAhAZ7rUh5nBhi2GVV4vEAGLn24Ex1RSLEbaVYJTI8/xL7Eig/b2Wi5
	tGUgnbsIQiOXpH5YsAy9oVDJyiVg==
X-Received: by 2002:a17:906:9c9:b0:bcb:d9c7:c6f with SMTP id a640c23a62f3a-bdd22a454a7mr962061766b.7.1779878805241;
        Wed, 27 May 2026 03:46:45 -0700 (PDT)
Received: from cloudflare.com ([104.28.21.182])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bddc6acc42csm589091966b.63.2026.05.27.03.46.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 03:46:44 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Jiri Olsa <jolsa@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>,  Peter Zijlstra <peterz@infradead.org>,
  Ingo Molnar <mingo@kernel.org>,  Masami Hiramatsu <mhiramat@kernel.org>,
  Andrii Nakryiko <andrii@kernel.org>,  bpf@vger.kernel.org,
  linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCHv4 10/13] selftests/bpf: Change uprobe/usdt trigger bench
 code to use nop10
In-Reply-To: <20260526205840.173790-11-jolsa@kernel.org> (Jiri Olsa's message
	of "Tue, 26 May 2026 22:58:37 +0200")
References: <20260526205840.173790-1-jolsa@kernel.org>
	<20260526205840.173790-11-jolsa@kernel.org>
Date: Wed, 27 May 2026 12:46:43 +0200
Message-ID: <87y0h55dv0.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, May 26, 2026 at 10:58 PM +02, Jiri Olsa wrote:
> Changing uprobe/usdt trigger bench code to use nop10 instead
> of nop5. Also changing run_bench_uprobes.sh to use nop10 triggers.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---

Reviewed-by: Jakub Sitnicki <jakub@cloudflare.com>
