Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8256A1FC8
	for <bpf@vger.kernel.org>; Thu, 12 Feb 2026 00:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770857112; cv=none; b=lGvnhWY7EVBTbuwIvuwgNEvb5ZtVWhbytQW4lXmSoOT0C1psyYaRZGFWFrYxi6xaMDyJdHpL0uu6LCUOQNhHhLm5NCLk9a+wpzDKXyeOLI62SGbYIvmDm6QM1ESBIMGAyQj2vlscTLtaFJcsRi1W5f7SZKagHaLONRs+Tcd9bEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770857112; c=relaxed/simple;
	bh=eXeqnWZ0k+2nyr+t7ZCLan+IpgpSOsdNJM0/Y4i8BCA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ZBcb4O2mCeHj21wpKHIjSBPgVNGXpfK13ZMJQWFHU1iqdzRTmoScLywDBC2fFw2xeL2xE8EzSulD1s1FrxjcecPsey81puM6ytNwo6BbbH1kvxr+EJcMVfo41KyWokUMrbJj029NO1487IF2O/R+ebAm4+UlnRAxWb7/upwhIDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=momXJEa8; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="momXJEa8"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4806f3fc50bso68092085e9.0
        for <bpf@vger.kernel.org>; Wed, 11 Feb 2026 16:45:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770857110; x=1771461910; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eV15FDZ+cY9/HE9U8iKPRfzMgANnUWZy2XHg0+hQKNk=;
        b=momXJEa8aWq3r5TjMEybZTBAGSS/ClT+CJDDwrf5O5AZKr4WMgeeslmMEa9LyHsJ0y
         FYrUcpYjMj1b3OmFiWlETfQ/SgPomvBU4vjHDtpfNP8MMtpyVYTtI3s21Mw0O/w1qDu4
         vSga7jNx3GFB0tOV1Yx5j63pO3XasI2iHhuH+N5KND888ZPX6qtOAfrbCZA7PvAjC5Gq
         Y2JOoF2keGqWHF0r05fu6QhL8hjMCvxGsuwg8sqMDB+V8Mhsj6we2bgCfNV9iz8f3aO+
         fA4TCV8mnMpobOMFTUA71gaGK2gFlm4xheU6KqN5C6wwNclXh6lZHpRDWClZIuf4/HIt
         FNEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770857110; x=1771461910;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eV15FDZ+cY9/HE9U8iKPRfzMgANnUWZy2XHg0+hQKNk=;
        b=Vf28kh98XP7/t7JfpIU5OxWOz9hWD131FHcA12DOpCZc0GPEIBQZoser4MvGgSOm6B
         X90PiyqLTynL/z7cgZoUAyfnG3oEjHQsALS32Xu0XCZ+/+CnGRCUC4tTIeFG/DSqe7lX
         q2s9JgIwqrJYjltKwPPqbdCiaOsM0ZOnI1/rRkKMCanuzWv2mydZvD8Lt/iDwQLvi8JC
         JgQ4MO58xocU45TZPlwo07KQ46qengru/7V5p5j+X+JqDg49Aw69fagH4R0khA6xiyYL
         ZbxmSlK2G/moMYXtF/lrpYfjn4xlTlWgvIgf0ZBLzJqmZ3h1ApmYVpADARna40+51bs0
         RlNQ==
X-Gm-Message-State: AOJu0YyogZ/vvFs25WSgtTSyj5irTPh9BuYUG4RxwctFFNHH77TN8a9N
	Hd1+zIOELIPMu2lDuDL9YP3nw0d8uaVcDkXt5DvlerSW8oCPPDm357ZBO7ttaQ==
X-Gm-Gg: AZuq6aLV4Pd4K+A+cT0jNgs6ptcVhLgl/5OhrznveB1ubLKxfwb7EUXYLNX24mBlwJK
	rlz2/y5LP5A3VOWYB7fxqOwn1i217M/2zkA1R9zysmp5Ie495asPVEgx8U52/cv07hDwaY13OfR
	H77yVswaRW4d/sINL3KPH8SWNYzNf0gCtqagP2jfbpJI+SMt6M8E/Uj8xMATAscfLk0iDkYVifl
	GiuhVK7AC4vyOAfz4w/BdR0sD1REpatGbRcX2sfXhOBt1IfWhwvTTKew3wHnJRSzCX+dfJXExvq
	+ROKKuogiGFKZY0cyDKyfXiG+cMEoY4KYd2XGCUrLD61xbYRRSRswMnOcT/T+Ina6uRoonp5G7O
	Qgb5ys9tY+UorX0I2J3iR0bk5QXEDRMvCEwxDw+0nKli3cB62D+hMNU0UWTRVEIkNkl3COXv58u
	WzITtW0UkNzYnPd0IopAZmGWTvO7VWcDobdJSx
X-Received: by 2002:a05:600c:620e:b0:46e:4b79:551 with SMTP id 5b1f17b1804b1-48365716a24mr12956995e9.31.1770857109692;
        Wed, 11 Feb 2026 16:45:09 -0800 (PST)
Received: from localhost ([2a01:4b00:bd1f:f500:e85d:a828:282d:d5c7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4835dd0e15bsm61649655e9.13.2026.02.11.16.45.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Feb 2026 16:45:09 -0800 (PST)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Subject: [PATCH bpf-next 0/2] libbpf: Add bpf_prog_clone for individual
 program loading
Date: Thu, 12 Feb 2026 00:44:35 +0000
Message-Id: <20260212-veristat_prepare-v1-0-c351023fb0db@meta.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2MSwqAMAwFryJZW6j1i1cRkVijZlNLW4og3t3gc
 h7z5oFIgSnCWDwQKHPkywlUZQH2RHeQ4k0YjDadNrpTWfyYMC0+kMdAChvUTTX0tW1rkJvsO99
 /coLV78rRnWB+3w8v6Q8abAAAAA==
X-Change-ID: 20260206-veristat_prepare-a4a041873c53
To: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, 
 eddyz87@gmail.com, ameryhung@gmail.com, puranjay@kernel.org
Cc: Mykyta Yatsenko <yatsenko@meta.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1770857108; l=1771;
 i=yatsenko@meta.com; s=20251031; h=from:subject:message-id;
 bh=eXeqnWZ0k+2nyr+t7ZCLan+IpgpSOsdNJM0/Y4i8BCA=;
 b=Yzsf298PMJmB5Qq5sSJwrk+7z3+BEacDbnJ15x5zlPFk0wuF3qmJwjoZYArZem0jNDTcoi9nb
 9rlH54sgdUyBmXxUKoAuTpV3p6wnZtZtjVGgzl33h+lZzCwUnXpDzxB
X-Developer-Key: i=yatsenko@meta.com; a=ed25519;
 pk=TFoLStOoH/++W4HJHRgNr8zj8vPFB1W+/QECPcQygzo=

This series adds bpf_prog_clone() to libbpf and converts veristat to
use it, replacing the costly per-program object re-opening pattern.

veristat needs to load each BPF program in isolation to collect
per-program verification statistics. Previously it achieved this by
opening a fresh bpf_object for every program, disabling autoload on all
but the target, and loading the whole object. For object files with many
programs this meant repeating ELF parsing and BTF processing N times.

Patch 1 introduces bpf_prog_clone(), which loads a single program from
a prepared object into the kernel and returns an fd owned by the caller.
It resolves BTF attach targets, fills in func/line info, fd_array, and
other load parameters from the prepared object automatically, while
letting callers override any field via bpf_prog_load_opts.

Patch 2 converts veristat to prepare the object once and clone each
program individually, eliminating redundant work.

This change allows veristat load successfully objects in selftests
folder that fail on the released version, for example
verifier_unpriv.bpf.o

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
Mykyta Yatsenko (2):
      libbpf: Introduce bpf_prog_clone()
      selftests/bpf: Use bpf_prog_clone() in veristat

 tools/lib/bpf/libbpf.c                 | 139 +++++++++++++++++++++++++++++++++
 tools/lib/bpf/libbpf.h                 |  18 +++++
 tools/lib/bpf/libbpf.map               |   1 +
 tools/testing/selftests/bpf/veristat.c | 104 +++++++++++-------------
 4 files changed, 202 insertions(+), 60 deletions(-)
---
base-commit: 1ace9bac1ad2bc6a0a70baaa16d22b7e783e88c5
change-id: 20260206-veristat_prepare-a4a041873c53

Best regards,
-- 
Mykyta Yatsenko <yatsenko@meta.com>

