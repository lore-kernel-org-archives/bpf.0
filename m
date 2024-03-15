Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE7B86FA9
	for <bpf@vger.kernel.org>; Fri, 15 Mar 2024 02:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710470103; cv=none; b=XLs5/ttwmlV9VkeW2pJYkX31SYw0kZYNeUS50zziHjTt8Y85DAScnnFjD0uqkq52TtTxgxmYERJ4o/u43t5RamJ+E20Y4KwYeHbty7AzzGeRk68kyx+5osV+qEXZt1l/LBvxf8q3rDpsWmYAmgBVGHhdDnsxldDM+K1Gyi1Te1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710470103; c=relaxed/simple;
	bh=/aerGIWM+Mj1QhBCegdJRQ+Pe0yd0Ml+erYG5bXVf7I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YerxBx9hSfYX6GOPUWdaG9cTFwp9vi/ja55JkF29MHdW70IrlMED1N12dkS9dbuOmsxocHv0JBo45eyNmtmBhObmwZoCVhSve74Awjtl9nuWJ8Lwan/txL/G+PV8z3+6Otejt+PhLkwYx48FSdGG7ZIjx1/kKNIZlFSPGuKQ7oI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S3dRCXl3; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S3dRCXl3"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6e6eb891db9so1172666b3a.3
        for <bpf@vger.kernel.org>; Thu, 14 Mar 2024 19:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710470100; x=1711074900; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6Nv0QILCEp/r4+hg6ISvuLea8mkviMD+/0Hdv133Qq0=;
        b=S3dRCXl3LRdIPYdojbgcZpWKqWqFK6RHpVSAjl6EZNuzmtCq/uNSIcaScI6SW6xylx
         Uz+IJgnQtJn/zEjW7dMRgFyFz51WVKaJIkuNrG9bMGcmejGJJzPdcxdAvAfc43O6hW0O
         dhNywk82B25J6jHLyYR0H2mlZOvauYaUmC9SFgKPJL96k4Cv95xDEheS9LpM+yiOaXVx
         UqZ6DkVzKa/JtSNK3jR513ykde9KC3/fJjulK676u79U4PlV0MmY5jO3y5wX6u6/7p6x
         O9QFr0LnCpVIu+fOrip4BIYvwfWIycD3pvJU/hF80DMLYoNQRlKcbfcHryTQRxyC+lF9
         Lmgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710470100; x=1711074900;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6Nv0QILCEp/r4+hg6ISvuLea8mkviMD+/0Hdv133Qq0=;
        b=S6SiY3kevwZZ9yQAnhE5fEv2wXsir1hPGxOfGfCCz+IfUFvCZSYNwRQN1wdaTMaO8m
         7LiiDbCj1JymhFEbWLlIbY7ntp7HUmzRBe1SaE2VBT6w/h0xvm9sAdPNZcQrTHmPzNZ/
         kCrTx+wFCraGmrz2X2GPRUQnlAaWQ/VqQkevxfzwunr4NTJlEXQ5kWlsRSI60yFnZo6w
         cA/Yfcd3x7pxlobc2WbMoKo5kmTDkKDjJ5qJ9vq6Sez+v3i84BOvbdBfcbIC5nanutDM
         TFKSEI68NrmT8i0ueuUGMknOHfVOVmanmk9FWf+9jcswCNwbDFO5FdwVlDv2LdqkY4jr
         L+PA==
X-Gm-Message-State: AOJu0Yxinj2ohDw/1lsuQniRJnhHQ/jdt4BR70kfJFYTeYlkrSaRgMjp
	o0bGhGB4NIqsllbuzkOYAt4jfwzLNwM6EycZ4w4N4JzB2ImQ+YB6cN0kvraMNQi8okx0
X-Google-Smtp-Source: AGHT+IHwOHG+XwMTbfJBOyzPAEY4yHOFLupjzwjG880fZVKp8LZSlxjakxb8PmxFD+IZcwnDO0aiDw==
X-Received: by 2002:a05:6a00:3a12:b0:6e6:bfb6:371 with SMTP id fj18-20020a056a003a1200b006e6bfb60371mr3835263pfb.34.1710470100252;
        Thu, 14 Mar 2024 19:35:00 -0700 (PDT)
Received: from Laptop-X1.redhat.com ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id i9-20020a056a00004900b006e6cc93381esm2143395pfk.125.2024.03.14.19.34.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Mar 2024 19:34:59 -0700 (PDT)
From: Hangbin Liu <liuhangbin@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
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
	Quentin Monnet <quentin@isovalent.com>,
	Alejandro Colomar <alx.manpages@gmail.com>,
	Hangbin Liu <liuhangbin@gmail.com>,
	Michael Hofmann <mhofmann@redhat.com>
Subject: [PATCH bpf] bpf_doc: use silent mode when exec make cmd
Date: Fri, 15 Mar 2024 10:34:43 +0800
Message-ID: <20240315023443.2364442-1-liuhangbin@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When getting kernel version via make, the result may be polluted by other
output, like directory change info. e.g.
$ export MAKEFLAGS="-w"
$ make kernelversion
make: Entering directory '/home/net'
6.8.0
make: Leaving directory '/home/net'

This will distort the reStructuredText output and make latter rst2man
failed like:
bpf-helpers.rst:20: (WARNING/2) Field list ends without a blank line; unexpected unindent.

Using silent mode would help. e.g.
$ make -s --no-print-directory kernelversion
6.8.0

Fixes: fd0a38f9c37d ("scripts/bpf: Set version attribute for bpf-helpers(7) man page")
Signed-off-by: Michael Hofmann <mhofmann@redhat.com>
Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
---
 scripts/bpf_doc.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/bpf_doc.py b/scripts/bpf_doc.py
index 4606944984ee..c55878bddfdd 100755
--- a/scripts/bpf_doc.py
+++ b/scripts/bpf_doc.py
@@ -414,8 +414,8 @@ class PrinterRST(Printer):
             version = version.stdout.decode().rstrip()
         except:
             try:
-                version = subprocess.run(['make', 'kernelversion'], cwd=linuxRoot,
-                                         capture_output=True, check=True)
+                version = subprocess.run(['make', '-s', '--no-print-directory', 'kernelversion'],
+                                         cwd=linuxRoot, capture_output=True, check=True)
                 version = version.stdout.decode().rstrip()
             except:
                 return 'Linux'
-- 
2.43.0

