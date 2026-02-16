Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B44EE313E34
	for <bpf@vger.kernel.org>; Mon, 16 Feb 2026 15:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771254370; cv=none; b=qO6GpbzLKgetJbgamI1PIwTK0Rj6VFwfc6YXlK9rVSMMpi5BF+6fcs7fmkWeiE1nkdY17b96ZKLxdAZhcHaK7DJO2TWXVaucjVBEb/8z97qwV2vBsnF5KcXH5lkvEosPOPKijJagGbbANP6SRSmoyW0uQv8PPAMUOPCFOpl58DI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771254370; c=relaxed/simple;
	bh=vR+QAy7ow7IUpEgJolTV+0NwGmXjYUXcNxGeHlD4+bY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=uajedk34CDY7PijYVo9kWyzpr72vs6dnJo504H8lexyY55vejB/PkA20YtKj6G7nnLeYgcwKw4JYSvRMiDGKxfyD9kXdqcZaoJMQYK8LbJY8wpu6Lp+4GJv7D0ijL8a0i/8EEC50H4G6HfvoGMKJ1oWcVx59SxhbyV9CuWRFSg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PeYC6NMn; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PeYC6NMn"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-824484dba4dso2960215b3a.0
        for <bpf@vger.kernel.org>; Mon, 16 Feb 2026 07:06:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771254369; x=1771859169; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=A6uX9Uhp5KRzO30Ht+YfFjNfPHQX7eMbhvwH7Wme3Gw=;
        b=PeYC6NMng7hwREe+mXzuhL299CBpZLX72afhw2eZrPHMplOi1C1L7uQUKisFeCSqgE
         /fmwCVS8H7to3Au2o7vra4IXxorsm1qIMi8aCIY61AkNR7OK69SIm2JYfkX1hs44oTQp
         i+Ue8trpUPUnjfWvRBQS0KgwJaJuxKiZ2b7SG72MNy1lq7u5lDB1wGMJ2U7/JMVuG0eR
         GiM2yYISNV9vSTwFkx8x4w29w47D8wmLmQCokdEjnJKZiq13EOD71FenO86T2btlxdGV
         yFOJJSd1Saq3nad73Vf1LuYOJZE6drkA7SEz0S6cBDi/PUJaaG72R8XaLjavfLtCOGSh
         s8BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771254369; x=1771859169;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A6uX9Uhp5KRzO30Ht+YfFjNfPHQX7eMbhvwH7Wme3Gw=;
        b=lMfBIq8N/HUxxEp7xRzZwk+RnBMuZ1JzmzLxerXAS0dc7gaB2b6WztHyy1NsAYuelY
         hk+a0LFgnfYNM7bLo7R0oHy1dJwWDadLriLt9NELKLA9CC83AO8nBh0T/a4P7mI6XhTT
         frhanLDmRqcRTY2tcx6pZdGDeuyRvxR3Wxlv2fcDgEkRyHyaYqG3lUg8zvA/xH6TpqXX
         lBpwLk0DfuJtG+QeAeZetkVjXvz/qFsHoT5b90VlXxZL7VjQcj87vDtKnHRhp/owrmHP
         H8AVYKqOm7VtqqYHE9/LrLnkDN4ployicrVd7IqmdA08WnVPxsLk+GyWy7kVoYU2jqTN
         KCGA==
X-Gm-Message-State: AOJu0YzSGJf26gw0o9rCoQnkpm+T0vDpQttY/Xr2QYmX6Goe9BAYeGgG
	xKP3nDYc9nB2belotWJguO9wL/p1SBehnTE2uJM25Me9CPV+Bi0qSFo/Cc3jkKbl
X-Gm-Gg: AZuq6aJpHjCa7aBUtedsDVI+dG1kS0IM6YLH+yp0+aoTJ2/ezKg+iClfgIff9Klma66
	kGwP6Qci7wy3gZuQObmcIis87bYJBVv/1pEH0gJuelcXCNIisIv+q4cZZ9ZuIBOPqFB4KZGrzt6
	OhWoypiQjmuiT3JKPf0JEB308ftw3PJdSqsnoZk5IH09ZDpEgDndVcLhv38HQ7bfvVwjUnTgrdu
	634dI9x0MUxcMWHkBvai7D0hPGOsX6pHI99xn620Jlfs21slBJqfXcJaW7Ota4mKkXDxpyXVBHI
	Pj6735ZkBOpjc3VO3yPzlnF6CNwel6rSbdl8VOsGNAP/hC4vueD4FiFfxClIzh9n64AxDCGIlhc
	Y8scHwYuatBHFgoIkaM3FsV5EVfLcpux+vtmi7uqhr6PvNX9zLy++/Gtssg3hVPC6ktH++Xdc6q
	vJ1y8VBhazRAN8KYciCHaz6MVin/1zo0pyLkyd20a1075FsscXgYq8XJaitOZC9Hdiu1Uz/TqYS
	m0Q2uc2M3wPi4wj5G0=
X-Received: by 2002:a05:6a21:600b:b0:35e:fce6:46e7 with SMTP id adf61e73a8af0-3946c6f4be8mr10229646637.5.1771254368847;
        Mon, 16 Feb 2026 07:06:08 -0800 (PST)
Received: from localhost.localdomain ([49.207.200.48])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-356a86f7217sm6697952a91.5.2026.02.16.07.06.04
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 16 Feb 2026 07:06:08 -0800 (PST)
From: Anand Kumar Shaw <anandkrshawheritage@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	kuba@kernel.org,
	davem@davemloft.net,
	sdf@fomichev.me,
	andrii@kernel.org,
	martin.lau@linux.dev,
	Anand Kumar Shaw <anandkrshawheritage@gmail.com>
Subject: [PATCH] bpf: cpumap: add missing XDP_ABORTED handling in xdp prog runner
Date: Mon, 16 Feb 2026 20:36:01 +0530
Message-Id: <20260216150601.9454-1-anandkrshawheritage@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

cpu_map_bpf_prog_run_xdp() does not handle XDP_ABORTED, causing it
to fall through to the default case which calls
bpf_warn_invalid_xdp_action(). XDP_ABORTED is a valid action that
signals an exception in the BPF program — it should fire
trace_xdp_exception() and drop the frame without a spurious warning.

The SKB path in the same file (cpu_map_bpf_prog_run_skb) and devmap's
dev_map_bpf_prog_run() both handle XDP_ABORTED correctly. Add the
missing case to match.

Signed-off-by: Anand Kumar Shaw <anandkrshawheritage@gmail.com>
---
 kernel/bpf/cpumap.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/bpf/cpumap.c b/kernel/bpf/cpumap.c
index 04171fbc3..b1fe83eeb 100644
--- a/kernel/bpf/cpumap.c
+++ b/kernel/bpf/cpumap.c
@@ -223,6 +223,9 @@ static int cpu_map_bpf_prog_run_xdp(struct bpf_cpu_map_entry *rcpu,
 		default:
 			bpf_warn_invalid_xdp_action(NULL, rcpu->prog, act);
 			fallthrough;
+		case XDP_ABORTED:
+			trace_xdp_exception(xdpf->dev_rx, rcpu->prog, act);
+			fallthrough;
 		case XDP_DROP:
 			xdp_return_frame(xdpf);
 			stats->drop++;
-- 
2.39.5 (Apple Git-154)

