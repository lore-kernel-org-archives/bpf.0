Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C2F92EEE83
	for <bpf@vger.kernel.org>; Fri,  3 Jul 2026 16:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783095030; cv=pass; b=RYvFU/hOxjbTZ7IgSJH1F/PjP0USpKiF6gftgjGGkhxBlBdKKKJ/9ClwmzSRpBlzeh8Nhavw5Um66jKUkIcYLycpDSvFhBaQin4BwRZYVOO4wqxoKQkmcOxxTmxy1shb7869gdsZlN+5vOy/eenDYnbozpSVHkvrL3ans6OvhOY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783095030; c=relaxed/simple;
	bh=xT/W1+CiZkDKLa+FnudJAe36lqY2hX16tIX2AHkVVoA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=H+FlnYMqdG5xvrB6Mx/UaklEJIO2ft5oPsxIweqq/URyhrNpznuhULdNcr18+mZNuLOQ55jkYoQ0bYDBHyHGIAdIzGaUG53/KS33ifgRfB3o+Vy66h6R2qBnnbLmgOx3Qct4VSX4ZQFtNslLZqoM3QYdRp3Q0TJAfR+8+6T7qkI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=coralogix.com; spf=pass smtp.mailfrom=coralogix.com; dkim=pass (2048-bit key) header.d=coralogix.com header.i=@coralogix.com header.b=OGPXOgjn; arc=pass smtp.client-ip=209.85.221.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=coralogix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=coralogix.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=coralogix.com header.i=@coralogix.com header.b="OGPXOgjn"
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-5bd745cf7c7so198387e0c.3
        for <bpf@vger.kernel.org>; Fri, 03 Jul 2026 09:10:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783095028; cv=none;
        d=google.com; s=arc-20260327;
        b=TBSb2BdorjPAGY35P5CGw24Hu8ucG0Kiug36WHmql60H3IpGDSU1V7oN8wZuD+XbK8
         TTnoLSI+DZr6rvMy5NnB+kDJtQPBF4GuJtdywmiNWtDPURDzK0TliD8VtXgh/Q6POD/D
         ZiQrx0Mv+NgFSBu974IIJjrFamVOQa3FJ5M2EzLDNmjiGJxnVQD0ZuPLAlB9AQUuNWkg
         kJRlcn0PHjXWZF+tjo2WQ706TEEDM0aeI+O5MkBUVr72Ley84qAsHuJF4k/T8HseuA9Y
         XynnpxhXuHH4Vx+jUw/KfwILNet489za/JXifnxaP56PAT8Hf+O0l3OEccj1JyarB7bE
         EdGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=gm26QgpnvRtdkKGeFLWfs6QgocR5OAy7gnfY6eH1ivM=;
        fh=qp7E4f5n0u6cegU9kZtEgcrF+sB11K4/mgAjvmRT6S8=;
        b=YRFeqjLcjYjHy5j42ApC2BZPl5JZgTwo8WqV8xs0pr7FQg+pzEPhMKqzf+uN1qJpn9
         P3ZG6vJsxFamux4z7UPEypX+TeZnUXVD4mmKPGueLPjRNVCCPxGgitytwkGdI/dkBonZ
         HpZNPOCeoc7+H6yI9Xif2w2dcqT5Y9L2QR44NPzg8ZjOX6tqDD3JWx3x2Xpi1FFc6An7
         FkwtIDGfToVsKiprzFGOJ6MNBbUUt7d5riXcSGu5ZoI3XZuxO8eJJgkiFQyy0MVVFAC4
         EH3hJb35HaRWq7x1aNKaeH3Zdc7MMkzhGlR05DtOcwf3brdGwgrQmPrKS1RzdzkyTL2p
         FH7Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=coralogix.com; s=google; t=1783095028; x=1783699828; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gm26QgpnvRtdkKGeFLWfs6QgocR5OAy7gnfY6eH1ivM=;
        b=OGPXOgjn1pf5lz6XfYUA6oJtbp+WaHDf/ry2adx3Wd/NQL21ZXABVNY3kcqFqWE+l3
         V3oeAONwSqw0yvynZLdbHjU25A89/4NS7vTgwjL39/J0FGHvO8NgbY7NL8XtpnX4jgVG
         MEC6v+uEo2Vw42nxgE6bkYCCUiMv5s+vi2KMHZPpR5m/adnkbFmyLvmW4QClk6YgAJys
         SWivxiSYsQcKWrEWP2jvuj413WImJ93cRq6H5coB4gHJHg8HZ1/nefqkaCLHpaHy3xTN
         FoTGpCmOBNQ1OL0c9CUMM9BgHd8N5eGE6nGGyMeX8kCwv9v7uce1/BIf4DklDfz8FATU
         ayTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783095028; x=1783699828;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gm26QgpnvRtdkKGeFLWfs6QgocR5OAy7gnfY6eH1ivM=;
        b=lyYWuQCJSQmHHyy/jxFS6CCjM7SLCb28hkX9ymbG7m5LihicNSZ6FSxavMOfJkvTni
         TKzwzHwAy+AYAcaiQcB/EK8xJIXzMMjMNxCVGHxz8653Cy0iL2XBVEqOOm1BBbPwBitK
         Ve0DFYqiv2+zx4LjhpTw9xGc3NK/1vMiKsL7SHMpM+l0XBaio+keknf8DZkgxLMElaGU
         SMvlESnvkhH4bvR5TYO/qVQmGv8ulUFrW0YTIy6P+gAuU2BD7tV8sgjJo6BB8keLTmuI
         zUk9QDq/lJJ6QkfJolhHfLmE3vthknGv+pYy+OwPJZFZadaISeBkr2o0HnhiT2L6Jbdx
         p2Nw==
X-Gm-Message-State: AOJu0Ywhs+OEKErTm+VYoyRxtnB2CliAG9Tt4QppR8ZHeh0CjIOUNl0O
	pCEo2F5A70lS8fVd9rziJoC27TN/UoGel5ixDxXEUluDzAaCH3GvszTVUyd26pDxMDxwrw5Fl65
	xQ0UBSM2D1q2inQsiiFHiF3uVw+7U9M1Tm3HNQR7AjU3UBxkVIcukCKDVa2Hb
X-Gm-Gg: AfdE7cnaWuanubAlan+V1Iw3LFToS64wXrmxRj8/Azyrxd14zcg8CM+/mW2LrcrI1Ee
	BpcyCCVfsD0ynJtBj/bLMVCSBsEmsWZaSrNnZN1fAthqhPSxy6C8ylKjc9ZPSfNmkEFepDofDow
	L/W+R908PwRZPox8QBMQi/azgAs8UqIpO44k3bCtsnSFZOPZE10ZjXRVF9wPO9ihhTZHqWsM4YH
	CkljYmtJVx5udyZ8k4qEqlv80nXrTtrz8EFB5GrtU2+//Fsn28mpgOrfgfpMvjB5LACUEzbVw==
X-Received: by 2002:a05:6122:4892:b0:5a4:ac74:f5ba with SMTP id
 71dfb90a1353d-5be1025e3ccmr107911e0c.11.1783095028060; Fri, 03 Jul 2026
 09:10:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Mattia Meleleo <mattia.meleleo@coralogix.com>
Date: Fri, 3 Jul 2026 18:10:16 +0200
X-Gm-Features: AVVi8CeAWA_f68Kki9hfUbY5C4CtuCmcJbPuxzmZ-mdiwT2SUSQ6DXPA9ual2KM
Message-ID: <CAOvpEWN6xgFx4GWFnnWLGCB+_1auDcAZPYPSv1PDu3UfXkcriw@mail.gmail.com>
Subject: bpf, sockmap: FIONREAD returns 0 for TCP sockets in a sockmap without
 a verdict program
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org, 
	"john.fastabend@gmail.com" <john.fastabend@gmail.com>, "jakub@cloudflare.com" <jakub@cloudflare.com>, jiayuan.chen@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hi,

in OpenTelemetry eBPF instrumentation we use a sockhash to track
outgoing TCP sockets for trace context propagation. Sockets are added
from a sock_ops program, and the map only has an sk_msg program
attached on the egress side - there is no ingress verdict program.

Since commit 929e30f93125 ("bpf, sockmap: Fix FIONREAD for sockmap"),
ioctl(FIONREAD) returns 0 for these sockets even though read() returns
data. tcp_bpf_ioctl() answers from psock->msg_tot_len, which only
accounts for bytes in ingress_msg. Without a verdict program, data
never lands there: it stays in sk_receive_queue and is read through
the tcp_bpf_recvmsg() fallback, so FIONREAD always reports 0.

The commit message explains that sk_receive_queue is intentionally not
counted because a verdict program may redirect or drop its contents.
Without a verdict program, however, all of that data is readable, and
applications that use FIONREAD to size their reads (nginx, Java, .NET)
hang or truncate transfers once their sockets are in the map.

Observed on mainline and on 6.12.75+, 6.6.128+, 6.18.14+.

Reproducer: https://github.com/mmat11/fionread-repro

  pre-insert     FIONREAD=4096 (expect 4096) OK
  in-sockhash    FIONREAD=0 (expect 4096) BROKEN
  post-delete    FIONREAD=4096 (expect 4096) OK

Is this intended for psocks without a verdict program? If not, would
falling back to tcp_inq() (plus msg_tot_len) in that case be an
acceptable fix? Happy to send a patch and test it.

Thanks,
Mattia
