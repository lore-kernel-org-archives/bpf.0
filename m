Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1911A405F7
	for <bpf@vger.kernel.org>; Sat, 14 Feb 2026 02:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771035057; cv=none; b=Pg6qvLy9lcWZtGzqVVyh5lY6ULi+tlN6EqsWIHGfifG8iSL2TKNXsYZMeXRYfKRN9IHOcJTQUYLJZNYhEl/0shY95rn1nr08XvHjqQmSg/PNPNAvyXqiCyy5CG3LXUQDP8j8TvI1LnLEOD6zjfF7Ll711yvzXzukoFk6LefliRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771035057; c=relaxed/simple;
	bh=LmTZrTWLRKo7HOlJMR6hqLbFPDzYXTA+o/3j6UzkXNI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OIkaF7qiRQ4qSFLyMJiBoFSEv/j9AUHRRZy7RUQ9t6RSuQ5L8/Im130ZP/uWN7+cW3JyqNELKQ8GRRcpqjqun3tZ+TyVbkrGTH61SkIiXcYuKY3Ov0vpj3pthR+yyyHlHsO0nllfvb1rwiIiw91fCoCsWbKPfwt4AEnozOrDZpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=G08Apfmu; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="G08Apfmu"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-896fb37d1f0so30162956d6.2
        for <bpf@vger.kernel.org>; Fri, 13 Feb 2026 18:10:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1771035055; x=1771639855; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wCOoV5lSX5yNFelWHr87zfjpxmVS3hhA129ONBesv+c=;
        b=G08Apfmu/0h3khApj9IqCsqVkLiqNOWqt4jxUb3UyKYDthnwWvaiw6NALu8QnltjG/
         Hdm0sfMF74v71BdT/7JVK272HqGZ1vW7zW1XyfZgK0S0idLVaOql3czJmz2sNyqHEkXD
         3YUrrE7t23MinwXIr/k48J6IkKdjW16hrbbTMXNI+x2XW2tXwx8Wc/MPkFLeVO7ngHxR
         i+CKLYycEOQDM3lvEkx1gWg0Gz2TI9k3xJd82UrtfDaIW6Fj4Inm1xDLN0CcJKYAkAse
         ZWoDyMHfjwFKq0n6vcxGUauQ2k2yErSjPHsZeEhmT7yOA59pngbLMbik/SiaXgPwa1ms
         +Lzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771035055; x=1771639855;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wCOoV5lSX5yNFelWHr87zfjpxmVS3hhA129ONBesv+c=;
        b=nQ0onMBhi25JvCTd9HPGArFD8VnatP0vIjvttfAe8phk4gVF+d718QNDh00c+lUiaQ
         OttOzAXonzkooc6MAHG6yGIPYl4HZSaPrUXut/3YU0bXpkweCcNTIAcp3NPXjP0WyDxp
         Y2NjmH4Ig1tsrm0WOKNtNyFtziHr9sN9t2G97m0RX76nMy5/yPKpMjqWbDR0Vpj6qBIT
         0gbCevdqRoj2axgRYMSDCszowg5NtW549LPE/UeuMDwMIodAsbpx/t/5j0YPa+2H8D86
         /8gZkvT77adZJp1G2wm8/6WbxD/5uzVEJBc9DxYF2MSc71afNvca6PWIFvpUDZUkIt2V
         4k1w==
X-Gm-Message-State: AOJu0YwxulMPLW/GpOaXBQZr34/DbcriZBXokRkYlizWkZuVlFpnIli1
	6oVmSk1Q+nfuzwFsPHXLoCkYLwGrEIpqjvajEQO8Vl7aREfZBJ9kW/RU24ELHZFV4Yx8O8dttbb
	tzGZJ88E=
X-Gm-Gg: AZuq6aJvZiY6TWvwNgGfd5FWE9tvcke0HlwJDE8sJTHqYAPblF16jcuq0OqJPsuetvP
	+af4I1N4lNtu9rMrwiikaRHPWHa62rG5NriCdfqu0KFtaYQOtnXRH9eHlx0FbkHeyQtFvgKLAsg
	fUwoTybqOqfqopcL31wNLwW0ABdLYy7Ju/n+epX6P5dHQ80jQgOz4QHMzh3RKGauLUajtLB02/u
	miGmgzDmk5IbZLGYdTHDVSVsIAnMowFfh2bymqAVeiaFCh2Y8L63ZfCIjKfyApPDJg0zaorKZAg
	VUgc8tV0jU7ZYo50gD3X/t51xVo/8suwI8HLPlK+fuPfGOTudmHosdFimFsqDXuOfnsoiO1zSDf
	a/rzSkvz7O8Zhea3lYQL+8+0DnETf9ocE6Ag3oGt50823soojPKePWDyewMYaWIJQaUn1Enq2D9
	Yznu3XqCE1xLeGtT1exyLckA==
X-Received: by 2002:a05:6214:c41:b0:895:c06:8cbf with SMTP id 6a1803df08f44-897404e1a5cmr24221626d6.62.1771035054854;
        Fri, 13 Feb 2026 18:10:54 -0800 (PST)
Received: from boreas.. ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8971cdc050esm94582006d6.45.2026.02.13.18.10.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Feb 2026 18:10:54 -0800 (PST)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	memxor@gmail.com,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf 0/2] libbpf: Fix perm errors for LDIMM_64_FULL_RANGE_OFF use
Date: Fri, 13 Feb 2026 21:10:11 -0500
Message-ID: <20260214021014.15670-1-emil@etsalapatis.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 728ff167910e ("libbpf: Add gating for arena globals relocation feature")
adds a feature flag for testing whether the running kernel supports LDIMM64
instructions with large direct offsets. Fix two edge cases that can
cause unexpected -EPERM errors in two ways:

1) The probe program used for the feature has type TRACEPOINT, but it's
possible the caller does not have permission to load it, even if it is
able to do so for generic BPF programs. Use the SOCKET_FILTER type
instead that requires fewer permissions. This does not affect the check
itself, which will always fail verification anyway.

2) The probe is triggered during bpf_object__collect_relos(), itself
called in bpf_object_open(), to compute the arena relocation offsets of
arena variables. However, the caller may not have permissions to load
BPF programs. This is the case in some systems with the bpftool calls made
by the BPF selftests during compilation, e.g., for skeleton generation.
Move all uses of the feature check to bpf_object_prepare() time instead.

Fixes: 728ff167910e ("libbpf: Add gating for arena globals relocation feature")
Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>

v1 -> v2: https://lore.kernel.org/bpf/20260213181752.505318-1-emil@etsalapatis.com/ 

- Adjust the hash of the original commit post-tree rebase
- Ensure close() is not called on invalid prog_fd in feature probe (Coverity)

Emil Tsalapatis (2):
  libbpf: Do not use PROG_TYPE_TRACEPOINT program for feature gating
  libbpf: Delay feature gate check until object prepare time

 tools/lib/bpf/features.c |  6 +++---
 tools/lib/bpf/libbpf.c   | 31 +++++++++++++++++++++++--------
 2 files changed, 26 insertions(+), 11 deletions(-)

-- 
2.49.0

