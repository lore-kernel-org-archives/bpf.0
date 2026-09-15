Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 921F04BC01A
	for <bpf@vger.kernel.org>; Tue, 15 Sep 2026 18:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789496046; cv=none; b=BUKr79/7rCRVAXk6f03qY+wDQkRdTJYNyTyov0bJAxBYzcZdqvewtdeAjs6Bs47zkRIq45i8GIBklSzEWQGsJsuYCD3waUE+i48LWLASQRcf4NLIFDuVCbU0XGdZBnxomNnYzkgfxNiKOrNaaJoBL7mmCzFMizbwWOMzgtsuA10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789496046; c=relaxed/simple;
	bh=I7yEINnQlm9hteCHMUsZRclkkr+946xBHGFUUUIuwa8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=bpTusUicmsAFjSumnambJNp4whgW2OMS/KiC4cVvraj8iAvVt/nm8VZ9YK+BwkbqhLzi1J4jmCwd/tkMLYf5kpm8E5tXlr40l1jgJlehKSYc06aQjnY6J0GdPciugLvgvItqW+scT0DNC5/VN7Pb78jb6U4mGAH0MvLSSYrwy/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bu16XGRQ; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bu16XGRQ"
Received: by mail-pj2-f43.google.com with SMTP id 98e67ed59e1d1-396ccb1a98fso38129a91.1
        for <bpf@vger.kernel.org>; Tue, 15 Sep 2026 11:14:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789496045; x=1790100845; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=c3OYYI0Ioeun4ZyGc0ibO0E01INXFyKIB2S0MWGQA2U=;
        b=Bu16XGRQC/KBLDx+VkXAajXmIhNIE6IPidz+93BSF0tLhn/cLHnFuPAEowt/2l8/+k
         G49q46fZ+ubQeZPdQRks/GIk7rGOfF3azZGiSUngIUoa04MNrT8iJCjP+n9EzjtFlNS4
         z4KrIDJmdEeLadNvE3nG1YR5Unu5abDY8KaAG83J8dVUJC1DgBzQzKUtk2OP8A5SHgYM
         pCWpuc+57j3A3cQYiPqiYj1Qs7CFxFu9ZwCJJ2vkX9uwpcn7RPnYCVReVf+Yhjl4c3ex
         ndsQPgqvzP4qBHVggERK6qiCk5RjW0Cub0qV0kqJU66+z7jgBT1YuKAQpwgRqhQDbYV/
         JmBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789496045; x=1790100845;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=c3OYYI0Ioeun4ZyGc0ibO0E01INXFyKIB2S0MWGQA2U=;
        b=W4PDkH3WEm2DYXCrsFT2tKO4OcJOK5+RPPBbZ6rCdvew/pkszHGD4o33Cq+frylCjS
         K0J8w7v/jQhCiFUyrWhg2iA0SgOynxzeo55FrtAM7CIrM3smOH2ka6qksNIydLp+U0fj
         rPrzMFuJIUNR/uPKyLpENV+mzWYhUhzDjvULyJlz4e+8W85M3dUODdwxBVycn1YhVeM/
         +n7OZEUaIr60WPZf2N4u7baLI2WRNif208Emp2l76qksUAj7KLp+UK05u6PSgLKqIhh6
         pj3POMZi++1sr9Gm4kdLrlBfzaoUvA8Fqf/B4yVmP3y2/wAL4vr0PnFCg7msy3jTdg0R
         RQ6g==
X-Forwarded-Encrypted: i=1; AKwUvBwQhyU7UMfXLNE15unbnrtkqw7xOVffiZiJl/+xnP3IBlOrgM8TC57i7bE3cYDmFSiRXPY=@vger.kernel.org
X-Gm-Message-State: AFuF++lkqXAPGcIBIDf4nBYhJnXCZ9XBz21FMleMlET/sBSyM5etZ5n+
	wOzBQXBkYXExPsc9lbCknQ75cT+Iig+55WWJO5uxh4Z2caDW45ToeHBg
X-Gm-Gg: AYBFou1ZZbc4gawGRceuaZjE/zoXrNHj/XdM4636PxlxAvs6FJ/djCgt/BXQRcJSJqz
	uy8ZjDOrrhtFQgttyV4SsutTIaP7ppxV1AsaC/LaF+o4UD8ncCwmMfHvoo/yErzFUNQiFDEGQcC
	Eb2bHlkd/Sik+7PUigIND32gHZPlkXtKOs3rX4kMGywsH53pehJ/+2DanJ7MGht+9900h9quzQy
	b/QvTDNl5/rLarkDEEYRbZqgwrn+UnVWWj7/e6m8sHrUUMKM7r3JWW7mS0ghXhXtY2N2cfKovu9
	V54KU9DnokQrfwlMJwcWqD4hPhZsot3++rkLqEB3SonnsaE1uqfPUnJZv8XdoxytYb/8zbeeB3k
	EA2dJ6HCDsmXv5/5sDKnY5qGLEhytFZ4G+0GWcVKIk7tGmlxYf+gS8wm+OrAd5RGivEcvmBP/gn
	QCAbE0uwjRbdfbWUzNdCfJVddplxqL6VAEDXvLoOChTd6KX3sSMmAEKiFdQnFgKTM2kG3/L9GD/
	pj/
X-Received: by 2002:a17:90b:554e:b0:39d:f823:ecff with SMTP id 98e67ed59e1d1-39df823ed94mr13397486a91.11.1789496044736;
        Tue, 15 Sep 2026 11:14:04 -0700 (PDT)
Received: from [127.0.1.1] ([186.235.217.201])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33bf5a6a166sm716073eec.10.2026.09.15.11.14.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 11:14:04 -0700 (PDT)
From: Luis Vieira <luisflavieira@gmail.com>
Date: Tue, 15 Sep 2026 15:13:35 -0300
Subject: [PATCH bpf-next v2] libbpf: Fix program log buffer size validation
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260915-libbpf-log-buf-fix-v2-1-2feca3fa4842@gmail.com>
X-B4-Tracking: v=1; b=H4sIAM6KqWoC/22NTQ6CMBCFr0Jm7RhaQMWV9zAsSunAJEBJiwRDe
 ndr49Ll+/veAd44Nh7u2QHObOzZzlHIUwZ6UHNvkLuoQebykteiwJHbdiEcbY/ti5B4x7KmKi9
 uWqmqgzhcnIl2gj7hW57NvkITk4H9at07vW0i5T9w+Q+8CRRIVS21ItL6Kh79pHg8aztBE0L4A
 Hehh/e+AAAA
X-Change-ID: 20260913-libbpf-log-buf-fix-49f5038caa5d
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Luis Vieira <luisflavieira@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789496040; l=2198;
 i=luisflavieira@gmail.com; s=20260913; h=from:subject:message-id;
 bh=I7yEINnQlm9hteCHMUsZRclkkr+946xBHGFUUUIuwa8=;
 b=DZbEYo5ANBcLM8/O1rfc7whiDbVTKuWqFmhwD4+XnfQBeE6x3gpsz26Z1+W1XFptHNtf8icl6
 dHSfvpZaE6bCRj0KQ7+NGC3udWPo6JZzTcvd13czXOyAzzL54ZGs3fG
X-Developer-Key: i=luisflavieira@gmail.com; a=ed25519;
 pk=98MeC/NdrC6ah7zYpPnkWiQIoyj62iUP/rNuV3esCW4=

bpf_program__set_log_buf() checks the existing prog->log_size instead
of the incoming log_size argument when enforcing the UINT_MAX limit.
As a result, an oversized value can be accepted.

The setter also accepts a non-NULL log_buf with a zero log_size, while
bpf_prog_load() rejects mismatched log buffer and size values.

Validate the log buffer and size pair consistently with bpf_prog_load(),
and check the supplied log_size against UINT_MAX.

Signed-off-by: Luis Vieira <luisflavieira@gmail.com>
---
Changes in v2:
- Target bpf-next instead of bpf and drop the Fixes tag.
- Drop the regression selftest.
- Validate log_buf and log_size consistently with bpf_prog_load().
- Link to v1: https://patch.msgid.link/20260914-libbpf-log-buf-fix-v1-1-f592caffcc71@gmail.com

To: Andrii Nakryiko <andrii@kernel.org>
To: Eduard Zingerman <eddyz87@gmail.com>
To: Ihor Solodrai <ihor.solodrai@linux.dev>
To: Alexei Starovoitov <ast@kernel.org>
To: Daniel Borkmann <daniel@iogearbox.net>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: Martin KaFai Lau <martin.lau@linux.dev>
To: Song Liu <song@kernel.org>
To: Yonghong Song <yonghong.song@linux.dev>
To: Jiri Olsa <jolsa@kernel.org>
To: Emil Tsalapatis <emil@etsalapatis.com>
Cc: bpf@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 tools/lib/bpf/libbpf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 613afae26519..f7a0517d8fa8 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -9966,9 +9966,9 @@ const char *bpf_program__log_buf(const struct bpf_program *prog, size_t *log_siz
 
 int bpf_program__set_log_buf(struct bpf_program *prog, char *log_buf, size_t log_size)
 {
-	if (log_size && !log_buf)
+	if (!!log_buf != !!log_size)
 		return libbpf_err(-EINVAL);
-	if (prog->log_size > UINT_MAX)
+	if (log_size > UINT_MAX)
 		return libbpf_err(-EINVAL);
 	if (prog->obj->state >= OBJ_LOADED)
 		return libbpf_err(-EBUSY);

---
base-commit: 5ef40d69b38a93bc9951dadb1a15c85c597e1a40
change-id: 20260913-libbpf-log-buf-fix-49f5038caa5d

Best regards,
--  
Luis Vieira <luisflavieira@gmail.com>

