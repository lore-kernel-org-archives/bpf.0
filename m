Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 248F2386
	for <bpf@vger.kernel.org>; Fri, 29 Mar 2024 15:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711726199; cv=none; b=eAyjvd136dG+orwdfLPaewHCFOA1xafcs+PSgd2iWtTmVOYRqvNa4HJz+Qc2preWKWrrVY+viVrDSoXUCOUvrGyl7/me+Cl68IhTasiJDzl2HCwKAlL5WFWxLldz3M1p/shEvVp1kg2nJNph5ZIAsKXXNOJSrdpeoR77xsoOGdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711726199; c=relaxed/simple;
	bh=H/eGfiCoPpDQTvPeEIon83ZcTYLiotzPPecPoDgU+tQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Rz5UZ7yYnJIHdTNBJqH3O8T/VFvwQ8ba3F0fUe5ay5QwxuZfxEU/lyBveRfeUTFTPMbFgaq3mW0GxBjyrDdm+Qdg1QtwrrTnG8COfhxeY/FxoTSFOOeX13VtMQQk+m5u927EPJmV28stfTAMlmXJDV/qDZHHYDT0E44C8ZMLBdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=Z8Ryn5eB; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="Z8Ryn5eB"
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3c393b5f0e3so1004604b6e.1
        for <bpf@vger.kernel.org>; Fri, 29 Mar 2024 08:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1711726195; x=1712330995; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tzNSZ6G1qWiFUQSQyVJPr7JWiuaZBzmUWG+3hwZo+Pk=;
        b=Z8Ryn5eBpINZnhhRqMNTW8m7RO9oWGQNSP67gljQ7JlSO9/I1XFtfQAcu5GZMTurAn
         sGjP7FdWof1blfj1SVJxBbWkIz8NuxAbFkd5VK++NmrGbhIXRsG4rktUfAfxSL/uH0p2
         aK0rWRvrI5PEslQtp4aAz8C0TH5fDUUvq0p8XobcVaIZhWRtbEaImMWGVEmvcRjws662
         tuaY2tPj0TwX47aCw/5UCrmvDZqG2wMK7KPqV15zp7hxsccD8YKiOvkCBir4BWxBT4+1
         IooQmabP8aITSTmOTYNp6N2/5r1vAvX43TP5KjnPTX/D71KBZ1+X4rJfq8mbqh27x3tB
         BZwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711726195; x=1712330995;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tzNSZ6G1qWiFUQSQyVJPr7JWiuaZBzmUWG+3hwZo+Pk=;
        b=jSMrZ/6wX30bVFOtczKuVtSe57WpC3x8kvBJP78AUElhsTuafk1SMAMiU7MXUXWdLG
         vt6/FhphjgDJ6qS0r3oNJxXz4x9oBeUD/PwXiZlhIwlK0cX2CLyVLtDIL2I1LrlF3Wh/
         VM20QT/5BckQD23Ig4xqP00kU2gPqzpWqTpLaXZVzXF8dVKkDFKNYMU2abgbAE6T3he8
         W8sUscApnoV9K3w994JhN25Jjti9JnZxKMxY/wRmur6BYcu2AbzjfUmLEmLP4VCAEH68
         IpG2tzA8tL+74sSI/XmPvf76IwjRtsTIwG++apFuh0GBDZ0h0HCkN4MwC3ed3VWB+pmn
         Rysg==
X-Gm-Message-State: AOJu0YzXhHUVUPI1tms3Rj/cGOdUan7kVj7EO45Ypr9GOpUwTUD0bHfN
	hcjeBVsvPc2lBha6Cf1hMONDWOujjLnfcA30IXSuhwugRaE7cYhnpPYjficuhVoluiyPKMwB/a/
	r
X-Google-Smtp-Source: AGHT+IFR2fMOFIk1UfXLrPnEC1CztADEvHc1ABiWkLvqjwKnCTR2YYBFRmBwhz7IIBv/kRjlDulqlg==
X-Received: by 2002:a05:6808:11cf:b0:3c3:84c5:173e with SMTP id p15-20020a05680811cf00b003c384c5173emr2529550oiv.50.1711726195157;
        Fri, 29 Mar 2024 08:29:55 -0700 (PDT)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id cr4-20020a056808368400b003c1e577140asm602225oib.25.2024.03.29.08.29.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 08:29:54 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
To: bpf@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH] bpf: fix typo in uapi doc comments
Date: Fri, 29 Mar 2024 10:28:46 -0500
Message-ID: <20240329152900.398260-2-dlechner@baylibre.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In a few places in the bpf uapi headers, EOPNOTSUPP is missing a "P" in
the doc comments. This adds the missing "P".

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 include/uapi/linux/bpf.h       | 4 ++--
 tools/include/uapi/linux/bpf.h | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 3c42b9f1bada..f83a4de0ac30 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -5020,7 +5020,7 @@ union bpf_attr {
  *		bytes will be copied to *dst*
  *	Return
  *		The **hash_algo** is returned on success,
- *		**-EOPNOTSUP** if IMA is disabled or **-EINVAL** if
+ *		**-EOPNOTSUPP** if IMA is disabled or **-EINVAL** if
  *		invalid arguments are passed.
  *
  * struct socket *bpf_sock_from_file(struct file *file)
@@ -5506,7 +5506,7 @@ union bpf_attr {
  *		bytes will be copied to *dst*
  *	Return
  *		The **hash_algo** is returned on success,
- *		**-EOPNOTSUP** if the hash calculation failed or **-EINVAL** if
+ *		**-EOPNOTSUPP** if the hash calculation failed or **-EINVAL** if
  *		invalid arguments are passed.
  *
  * void *bpf_kptr_xchg(void *map_value, void *ptr)
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 3c42b9f1bada..f83a4de0ac30 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -5020,7 +5020,7 @@ union bpf_attr {
  *		bytes will be copied to *dst*
  *	Return
  *		The **hash_algo** is returned on success,
- *		**-EOPNOTSUP** if IMA is disabled or **-EINVAL** if
+ *		**-EOPNOTSUPP** if IMA is disabled or **-EINVAL** if
  *		invalid arguments are passed.
  *
  * struct socket *bpf_sock_from_file(struct file *file)
@@ -5506,7 +5506,7 @@ union bpf_attr {
  *		bytes will be copied to *dst*
  *	Return
  *		The **hash_algo** is returned on success,
- *		**-EOPNOTSUP** if the hash calculation failed or **-EINVAL** if
+ *		**-EOPNOTSUPP** if the hash calculation failed or **-EINVAL** if
  *		invalid arguments are passed.
  *
  * void *bpf_kptr_xchg(void *map_value, void *ptr)
-- 
2.43.2

