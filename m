Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D60593016EE
	for <bpf@vger.kernel.org>; Fri, 12 Jun 2026 01:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781226926; cv=none; b=TdJjR8AKb4jeCxyklj0wLxh6/2cFJDX84BvzPNSfP1Qvz9uFNdzXxxe6vw5WfyUD8zIbB/Y3vLK6pC5CqNqzyr8I+WOJF5sHqwNC+vJM6LQ1uPxprgbj9Rqd/m33Uryry1OEF1170VhqKpKbFSAw0YWrPkaqjNUiPDq5M4EjTnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781226926; c=relaxed/simple;
	bh=kL2zAACXFiDtW1eVsU5LUmYxMNAN4kn47KN/F6+Ia+Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ol+6HGVNL7skJniPSljpsx+vsTQDdZOejym3BufJxl9cMse9anqEgEAhTEkfFmAwAexlX6O5/CGSuIye0AvfDd5wrsneBhALGN4ejcJXd+ZTR3QCPU1MkAZ5soUREVBlboOZ4/bZykowWO8HKf5eRdyRWyzDAdnZEcc3BRBJ33E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a9CrgnnW; arc=none smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a9CrgnnW"
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-138129a622dso815493c88.0
        for <bpf@vger.kernel.org>; Thu, 11 Jun 2026 18:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781226924; x=1781831724; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BkTvbWtZ0JcM+jEsuldlyWxlhk0Y5c+iS1VR0niVTtc=;
        b=a9CrgnnWbbe0+5oPJoo6evzfbyFFx4ryM95ZZONGeYnsSsqvg8TDbU7wWi2DH63v3d
         MMOU5JfVwizGyAf0P/KxJcRgzXmuz9yAy5kQy9UhqbRTDK18PuopIMoQYjNTM8zJPv3+
         DeIw/AqHgBmXfB3qxvy/2PDikFx+aYVLeW2itemKozNvUxpmceUKUMoC9Sq4bMBb7Vbm
         gKHp62rr6euMSsGF6+VCT+mWhrqmV5dN0z/vK87rxn9k4K0JcCsRiYXrW/ASiE09PNRY
         iNBGLpCLxtrQY9r+XNhw82KPY4eOz1/TVMMWS5rjtKX+iK4yTN+qRVlvPnUXmQsbDqhO
         AvPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781226924; x=1781831724;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BkTvbWtZ0JcM+jEsuldlyWxlhk0Y5c+iS1VR0niVTtc=;
        b=VHC0SweNxhmZZDzi9pzDZVhHG0wzN8ubEng3lA3h4wBs4c8CBcSAv/M9bZjewDDvAf
         Kq6inU5t9qgDLAh0XMS06goL0ckgFJ4DEKDZnYTsjpiEqDuPBrY744fvY1OPICDZ6tcz
         69p+jqfuEYv2DOs15p2aG5vBgC6ocHrFsELUKAosLN4zGemJCumyymbtszod13KoBBd9
         9NEtqHXNP7m51IPi3iIlX/d5meZnyu9UnEmVE/85jfObHBWbnrRHSlQ85V5q3/itmKVs
         DYzYGuwtJfu8UBO/l5DxDEuMCvOuqmkA5Xl25ZOVcC3z7KMiChRRLcrrtKPmkl14sH2T
         CMFw==
X-Gm-Message-State: AOJu0YyUm7G52l2v64XN4THTBSEOavVpXdxPFi3QA9ybvO8KPQ2VBt+J
	Bg8iCHCxKxLTI5PX0LszwWti6PY77/DyeTCcxk04DIp/xaKvnGn9nP/9
X-Gm-Gg: Acq92OHR3/Ny7EvLxGAgmp9G0PYw75D87qpm7qyzQztudTI/VcZ3H82GvAzrnGpDAES
	+TvEQRIFjxscfjw7OGVAxT9cfwSHNJums7aJ8S5Xaw5vE0ojZtGbGH8sP3L+kjSna5zgIxomP07
	2rd9vrgoSMo6Zqz9SM9qBbIg2FCzRxqKRbkEARaMyBI3tfqDw42pl6m7RZRfpz4VigNRLUoDQVk
	X3Z78Lds5qYAV61ETy2DC+tQrpFfboTjGT2u2x81/N0T/ROyYRzVkKWrsuhDx7CQA7GyZ2k0JhJ
	MAxa46MKAo3J/upNxujpndxla54NAPMY5NA1DvSLLLLq7wEfnHTIPAzI+P0iK90UDhHOLuiLCXs
	KVyVMcSH9VPhbXWi8qeZ+rWS8mSkVHRMQLE2F0260ZMTZzOPdc1hJKJU89a7imD5fn1SooJlWQ0
	tMw181NXLPxnxkASkMhzS12PsiuBAwDnJrLrF7/Bbt8IZELU5x1dIyAeppRyhKTj0VlyFINpa4l
	yap
X-Received: by 2002:a05:7022:1a82:b0:138:37a6:6cff with SMTP id a92af1059eb24-1384b9763fcmr312789c88.0.1781226923916;
        Thu, 11 Jun 2026 18:15:23 -0700 (PDT)
Received: from pop-os.scu.edu ([129.210.115.107])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1384b975e55sm596257c88.13.2026.06.11.18.15.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 18:15:23 -0700 (PDT)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	John Fastabend <john.fastabend@gmail.com>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	hemanthmalla@gmail.com,
	zijianzhang@bytedance.com,
	Cong Wang <xiyou.wangcong@gmail.com>,
	Cong Wang <cwang@multikernel.io>
Subject: [RFC PATCH bpf-next 4/5] bpf: allow SO_BUSY_POLL in bpf_setsockopt()
Date: Thu, 11 Jun 2026 18:14:51 -0700
Message-ID: <20260612011452.134466-5-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260612011452.134466-1-xiyou.wangcong@gmail.com>
References: <20260612011452.134466-1-xiyou.wangcong@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add SO_BUSY_POLL to the SOL_SOCKET allowlist in sol_socket_sockopt() so a
sock_ops or cgroup BPF program can enable busy polling on a socket (set
sk->sk_ll_usec) without an application setsockopt or the global
net.core.busy_read sysctl. SO_BUSY_POLL needs no CAP_NET_ADMIN in
sk_setsockopt(), so no privilege gating is added; the value is an int and
joins the existing optlen == sizeof(int) group.

This lets a BPF program opt specific flows into busy polling at the point
it has the context to decide. The TCP loopback splice path
(bpf_sock_splice_pair) uses it: the splice receiver busy-polls the ring
instead of parking, turning the latency-bound TCP_RR case into a large
win (numbers are in the splice busy-poll patch).

Assisted-by: Claude:claude-opus-4.8
Signed-off-by: Cong Wang <cwang@multikernel.io>
---
 net/core/filter.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/core/filter.c b/net/core/filter.c
index 9590877b0714..302dfaf03f39 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -5325,6 +5325,7 @@ static int sol_socket_sockopt(struct sock *sk, int optname,
 	case SO_MAX_PACING_RATE:
 	case SO_BINDTOIFINDEX:
 	case SO_TXREHASH:
+	case SO_BUSY_POLL:
 	case SK_BPF_CB_FLAGS:
 		if (*optlen != sizeof(int))
 			return -EINVAL;
-- 
2.43.0

