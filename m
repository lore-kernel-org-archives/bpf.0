Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5D2654939A
	for <bpf@vger.kernel.org>; Tue,  8 Sep 2026 14:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788877665; cv=none; b=caQo1pnupY9NuifCo22XCMVwJWieLUGWc+UDnNppQvkkBu1mK8DRa0W0Bm2uLM3KdYwGiwtTIPKQDWPpCCerlTWw2NnkgBwWTZ1HHCmu5VIJDSImrLCz/uG857SSurnEMZVIISK6Pjo+Qb5a10BMThkIDSlE9vW2rIFFKsKPWKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788877665; c=relaxed/simple;
	bh=+TM+zYeX3ygRQvHGcTEUljLUIwOHDrWNq9lU7U+08kE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=cHFdF+NmuInDNOoyc7eFaa2lKcVC9B9gDwOm4aavbvAcXMlGmW0NfT5PJ1xOQUmG+C1jQd/mgA4JL4vwGT3rK8BFEOitKJhiU2XRxLyC7xGZNdEt9FUubx/qK+Rc0bCjMzOrNkye5Ic2t+sCd911nv7JuWregkLYqsIs4IvYYTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W8qKOnm7; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W8qKOnm7"
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7ee37dc91f5so2782443a34.3
        for <bpf@vger.kernel.org>; Tue, 08 Sep 2026 07:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788877652; x=1789482452; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=a5Kv6cT/AwOHxG8+33WPtCAWS/EjeBTh4gFEfyRtB4M=;
        b=W8qKOnm75q05XMcH+6b5jjgBuRfBgSKR4a8qOcw/VqjP/ITIvk5k06HEYgtNEIeRul
         jGHfjT56yGo/pW0YnpaeUQ6R3JFmY6K9Q9/INLt5D+M0ckXvCPH4EaE5/URN7NahqyDK
         fLs/OlDH5F5joqHZ3mRufEBVMw/QJNsLnZw5TnwXdwCZIlFqCa+BsWBXB+9XEzpFd60A
         BrzLcNsSnERLKFCWXpwsZ0mm7qj6XAJ6Tvr3kfwYnaTHi53tduclukfERe3qjqzVntbp
         iltbuAMBzhduaMKYXfp3KzTTZWO3NBhC4k1IQvZo6GbZLjKCUj1Gk0B3YVlz68C/P/1U
         QFYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788877652; x=1789482452;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=a5Kv6cT/AwOHxG8+33WPtCAWS/EjeBTh4gFEfyRtB4M=;
        b=aJdzv06KlJ5qvkW/rOIaHC7rePB/5tgIiqX3yXIrkJq6AwTVfTIkhcit2Is8QNOnWO
         J/LwopCe3rWpveMQclyKVls8rXF+L7+4AjRpI/rhGgpKFI2Re7Mf3KuIlERMPLJBvvkX
         m+AtCHfHh7tjXiTDQ7pTx47/WWSNiTYwU8epUQXprb2C3zL1fIFCmFtTrqqNJYJkgTa1
         jwwp3XsRxidvH9IOQxXU9cKIiCV8ajBxVT6E3ST3CCB6VD6YBFhbI5fg9xDoA2cCqwLK
         SGbJWTyZM9MGGhuEjIqSlTM+rwAQG3NAz5+PGhQrd7MAU5UjrbbWYtPUk2OYe/SrxSTH
         UJag==
X-Gm-Message-State: AFuF++lr6Rg5sFdWhl+JGno/xdfxUgfnMogmWTpRUcELV6H4sYtRB3h/
	WrxS7dJKmSLUTOvJmuEpSEQXY+kgXPRfZjkA10kAHaF0I59towpmdHAZ
X-Gm-Gg: AYBFou2aIUVG7Z6y8ESoQSHzQZR6Tul+AbRSZhVWb7WozHwKq5hG9Ay6EEUq7CQpQJX
	AKK5ADpsL18f3byFSNkjFdiZ1RxixmyyD3TKRV2dpGfroj/LVbXn+eX6+mrp3j2vbi9WdiSQijH
	tl4PYBKuruNAtFGoB4u0QjRozHQM+TF4pg1cnJSoBD+tQxpDwANTxWLIAGoiJ/jdH688WRMnyYx
	C3BvDSB60rOsvxgLzdweaPM6iqisCCNSywjzvnBxOALiuA3KkF/nUuGRvXEcbGJL3QTT5scqvdT
	VWvuEeD3Xf506OjF53Dde2XiytvYmjOnhR9uU7hFmPsEGjqUjbPuit++k0oGwHgsTE4yYMZ/SpO
	A4ttFrqMkbz7JruCb8Sl6dfTNwDLb017nBrSkXFzORMzEJYKMaysUjvKPycNYA2f0J/bCLGFFw3
	L3aMSyWZ6y+IVfNKPR4jjCRzxoa3e5/kLZU03mKWgGfXNizNbeBg==
X-Received: by 2002:a05:6820:218:b0:6b7:46e9:9703 with SMTP id 006d021491bc7-6b746e9a293mr14206611eaf.51.1788877651736;
        Tue, 08 Sep 2026 07:27:31 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:7::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7fc68d5ae2bsm8456663a34.3.2026.09.08.07.27.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 07:27:31 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Subject: [PATCH bpf-next v3 0/3] bpftool: Improve perf counter reporting
Date: Tue, 08 Sep 2026 07:27:09 -0700
Message-Id: <20260908-bpftool_cyles_per_run-v3-0-60e86f325c35@meta.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAD0boGoC/4XNSwqDMBRA0a2ENzYln2qqo+6jFDHxpQZsIokNi
 rj3gpN2Ujq+cO4GCaPDBA3ZIGJ2yQUPDZEFATN0/oHU9dAQEExU7CIU1ZOdQxhbs46Y2gljG1+
 e1pJXtTVaMq2gIDBFtG453BvoyVKPywz3gsDg0hziegwzP/ofO3PKqVK90tZIw6ry+sS5O5nwP
 MAsPkjNxC9EUE61KXt+7npmsP5C9n1/A/CaQMAIAQAA
X-Change-ID: 20260827-bpftool_cyles_per_run-93169fcb30b7
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kernel-team@meta.com, eddyz87@gmail.com, 
 memxor@gmail.com, qmo@kernel.org, linux-perf-users@vger.kernel.org, 
 acme@kernel.org, namhyung@kernel.org
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788877648; l=1346;
 i=yatsenko@meta.com; s=20260324; h=from:subject:message-id;
 bh=+TM+zYeX3ygRQvHGcTEUljLUIwOHDrWNq9lU7U+08kE=;
 b=zxP6ytb5ElqNaFXIzMX7miGvIJ4epfwVee8pWS84746ePATW5qUF2/Ob0FFeehhmW/VtT108b
 2I9ZfcIpWPcC7jxcP3+ZqfEaAq38JkEgVhSSPhmU6LufvCFmUDGe0EN
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=1zCUBXUa66KmzfjNsG8YNlMj2ckPdqBPvFq2ww3/YaA=

Track valid snapshots that have a zero counter value. Scale each per-CPU
counter before aggregation. Report cycles per included program run.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
Changes in v3:
- Keep the JSON value field raw. Add value_scaled and run_cnt_valid.
- Use the same CPU set for all metrics.
- Move snapshot state tracking to a separate patch.
- Link to v2: https://patch.msgid.link/20260902-bpftool_cyles_per_run-v2-1-bc5d14ad0ce9@meta.com

Changes in v2:
- Scale all counters.
- Use an enum for metric indexes.
- Link to v1: https://patch.msgid.link/20260827-bpftool_cyles_per_run-v1-1-77d7bfc3c065@meta.com

---
Mykyta Yatsenko (3):
      bpftool: Track perf counter snapshot state
      perf bpf_counter: Track valid BPF counter snapshots
      bpftool: Scale counters and report cycles per run

 tools/bpf/bpftool/Documentation/bpftool-prog.rst |  13 +-
 tools/bpf/bpftool/prog.c                         | 159 +++++++++++++++++------
 tools/bpf/bpftool/skeleton/profiler.bpf.c        |  25 ++--
 tools/perf/util/bpf_skel/bpf_prog_profiler.bpf.c |  26 ++--
 4 files changed, 168 insertions(+), 55 deletions(-)
---
base-commit: 3fa3128887a4df6057c543aae7c5c7fd2ed41f12
change-id: 20260827-bpftool_cyles_per_run-93169fcb30b7

Best regards,
--  
Mykyta Yatsenko <yatsenko@meta.com>

