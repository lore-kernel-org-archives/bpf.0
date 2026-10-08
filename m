Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 984AA3AFAE0
	for <bpf@vger.kernel.org>; Thu,  8 Oct 2026 17:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791479340; cv=none; b=Oal7dw8m20Z8MDaRqRpx2M1ndfuNnuAgabMl4YYuyPfI03H4A4p3CKWyKbrpmgkxHWgZzWfxZt5UwppN69U9DytSlMuaYlm0sG80qPjVYvTc3C9zR0DU+zD+KIQxWp9YYsL2b66jkZzwuVdArOi7AuGJqU7iwjU/QZlv+kqb/EE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791479340; c=relaxed/simple;
	bh=uzc5djF85E//odOYdOjPt2GittKhdyE9SqtN99W2ky4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=grcFZZ7EUqktgztb3Q3s/QOfXiPEFbot/wYvPOCyVM7QdsM1NrVeVtIR/HxRJHKWygV+mb/k0R6Ycl13hJiioQrA2NGjIuib18lH4JcLDrt1E0wtNFPmeECNxNV6b8+pxSQKU1dkoZMV6LIaaBg2wqaKaEGd182OWI/k9lq3938=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OqFU6Tj4; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OqFU6Tj4"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4a16c1608faso11553075e9.0
        for <bpf@vger.kernel.org>; Thu, 08 Oct 2026 10:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791479337; x=1792084137; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+ZzFC0Gnqf5rubheTFydiqJ9yK61ie2+Ek+jk+ivkUU=;
        b=OqFU6Tj4844RAtOXRiQZFhIuhvFiFgK+WcpGkkPJyrbx8Cgw84W0UgzxhguYVnxfIg
         Y9pAuO3Vbf3B4rdD40W5eXr2Btytke94hePBtgLAOc1pg48/HAnYZljSGaptcQXhz2L+
         c5k3lWu3e4JSJrlCjmvaEGM6Pdzp5QXOHuXu4JRnfz3c/N2TgFATwup5SZ1xhULaZAmJ
         3awzf0lH3rjHYYnxShE6NXamrzWb0amqE5zCxhmep1qxRb+mdgILKwH7X9RyaPgjWN94
         /tPS3VEJQwtKr6NvrSkkmnW8l9DojPDsYoRjbFkVgtGx9uoQCQ/xpepXD/av0IZ4LEq0
         x5ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791479337; x=1792084137;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+ZzFC0Gnqf5rubheTFydiqJ9yK61ie2+Ek+jk+ivkUU=;
        b=Y91I9Xv8Aw4YYYZs0GYjY7FZqnUxzAxxpSN21OXFnp33CdolhN9y6P4pxMqZVA3YWT
         e4t8LGiuheQX92cBf8ssYoLTTD5t6sLDXzEQzBZ8RE88arr4yPVjlnQqqBkhlurbCnNc
         nnsixC108dM2+JhUl96Z74eOzMPE0Q/y9J6ZnhdqgPIw0crC1vGt8fqBOkfSdF8obDHa
         9grS9YHDPuM8TBFYE4d86b3wmQkmxzJvXt9PZB2aY8q7Wv1rOW6GkKydZwLX7h3EB9vO
         fumrMmL0MV1ORCJo3H0pR5VzkMYUeDagLsuNxj9cUxO+tmKWpwMvZxE0MuDbkDdCMqOD
         Xg9g==
X-Forwarded-Encrypted: i=1; AKwUvByQRLe1BY1kpdeNDL/UQjuGMfmfecQbIlDBioLPA8Y990EGbHXG3G6VfhzeSbLp2aLakuk=@vger.kernel.org
X-Gm-Message-State: AFuF++nHNOBH6n3y1ls1/poJJ/W/1pSit2v5rsy/seWko5B0dvD3hCsw
	tst2F0zBDyuu6lm5PQXEgRkZEs3UKZ09o0g4ap3gmK6RkGAAROMvi765
X-Gm-Gg: AYBFou0kQUJtkKwQtukgTuKCulZ7JHiByIlAtBUFifRfLUKX/xUHeW8JaKpYA/mNtZ8
	Nfmjg7mENzMv9aBHeEIEy4GZudw4j1p7xdW8YdcGFzqouyuPWKdsIe5qu8uJCVOOWkXEGFFUemz
	2S5WcRmdAH/Aq2ZIETxk8XSOJfRL0MDXjhzPOTI3RRiFQQzwFsMBAXNp0WMs0+LCO4f26B7FDrV
	DbUaJUwaSpvvF5/5jL/w1++sfsASimqgBr9S2yO5hgKLWb2ZJQgwC/2cQSbv41Qf+oSt+9hxPsg
	gNNtNt5f5KeOcV5hmQZr/r9WJYCKhSx4gjWf2UQYxFtI95ScyBz18OB2s2G0jsPOTpQEOk1KMPw
	6xhU0HvirBhmzxk9u8yBJJpFyd73Hq6+dEx+VNRUxJ2QdXXhAV+fq2JlQySCmrdOmBRTbVwaGtC
	Mq/YUoqIHt09V6nUtjLw7rvYav+Gb7epNNYR5E+ppF7xDWWJ+mifWCAjd/ZeC+DrKKKlfJ7QNRY
	mmhpt2XSuHi+ly6fPRO9dLP556wx0x/vcuACE+Xc9/FXQ==
X-Received: by 2002:a05:600c:4755:b0:4a1:8963:b865 with SMTP id 5b1f17b1804b1-4a18963b9aemr17251305e9.1.1791479336435;
        Thu, 08 Oct 2026 10:08:56 -0700 (PDT)
Received: from ubuntu (ip-86-49-251-138.bb.vodafone.cz. [86.49.251.138])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1843cb261sm84563085e9.3.2026.10.08.10.08.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 10:08:53 -0700 (PDT)
Sender: Alban Crequy <muadda@gmail.com>
From: Alban Crequy <alban.crequy@gmail.com>
X-Google-Original-From: Alban Crequy <albancrequy@microsoft.com>
To: Sasha Levin <sashal@kernel.org>
Cc: Alban Crequy <albancrequy@microsoft.com>,
	gregkh@linuxfoundation.org,
	stable@vger.kernel.org,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Peter Jung <admin@ptr1337.dev>
Subject: Re: [PATCH 7.1.y] Revert "tracing: perf: Fix stale head for perf syscall tracing"
Date: Thu,  8 Oct 2026 17:08:31 +0000
Message-ID: <20261008170831.49376-1-albancrequy@microsoft.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260817150000.2@kernel.org>
References: <20260816133101.83109-1-admin@ptr1337.dev> <20260817150000.2@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Sasha, Peter,

Another data point: Ubuntu picked up the same backport in its 7.0 kernel (7.0.0-38-generic), and it breaks Inspektor Gadget and bpftrace in the same way. A BPF program on sys_enter_execve or sys_enter_openat only runs on CPU 0; sys_exit_* and sys_enter_close keep working on all CPUs. Reproducer:

  bpftrace -e 'tracepoint:syscalls:sys_enter_openat /comm == "cat"/ { @[cpu] = count(); }' &
  for c in $(seq 0 7); do taskset -c $c cat /etc/hostname >/dev/null; done

Only @[0] shows up.

I also tested v7.1.13 under QEMU with 4 CPUs, using a small cilium/ebpf test that counts per-CPU hits of a tracepoint program while running 10 syscalls pinned to each CPU:

  v7.1.13:          sys_enter_openat [10 0 0 0], sys_enter_close [10 10 10 10], sys_exit_openat [10 10 10 10]
  v7.1.13 + revert: sys_enter_openat [10 10 10 10], sys_enter_close [10 10 10 10], sys_exit_openat [10 10 10 10]

The revert looks right to me for 7.1.y, and for any other stable branch without 57918341dd19.

Tested-by: Alban Crequy <albancrequy@microsoft.com>

Alban
