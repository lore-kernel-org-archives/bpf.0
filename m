Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A22331EAE
	for <bpf@vger.kernel.org>; Fri,  9 Oct 2026 02:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791511484; cv=none; b=fcilThlHnihcc7LZYWpwfZ9nFuXn72S3PQT3bLPakgRQKdINxOG6nYKz7IeOc+yLR/zBoUnnCxdbmZH1fPBViKpPwT2yYbKj6YNHVZLKrLDGuzTLfk5jf0e2Jill8PNfKlNcpkG1E6Gng331N2ged0sGE/PBfUUWi74oME3+JVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791511484; c=relaxed/simple;
	bh=fZK2iYpb3NiS2SLGLXmNJuWJVBr5yPWVV3XycV8Z2xc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=UF4RqnATAooQkzPvspWezxL66hybRpETIZEgo03gfUHxR2T2JX7r2P2lC/WDah59/9kTluwH8oePgx9v4ofcHQBmJCLJR+8EjhbB/WMmcChXDXfMAcpYvfBj7SQj0xc2+Bra26XYxcuoYE1yDt18dWpElHdxSm85bY5k+ha5HIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iV1qZnla; arc=none smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iV1qZnla"
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-141395927feso6066423c88.0
        for <bpf@vger.kernel.org>; Thu, 08 Oct 2026 19:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791511483; x=1792116283; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=rUnebLJfLajmU4biDRGffXGALZ2NDVISxanjJ9k8qQ0=;
        b=iV1qZnlaxlzjJ3RKDX+bTjST5/JQWUjruk2uYGIgfhj4b+mSexMeoBxIJQ1j2vNwsU
         uWdh4eDbvsskBr39Vfg/81OV8x6YiLH6pmC+f0/Igvdjhzt2VUDveZebfcgKEf7tvuqo
         we8Ao9AU7OEyJ+SsnmQAlKrN7/zs52tgruDPPUCIWvjj+p4NXmGRnxxw/kfePmufVGqb
         7hP8lkyPqBBlb0VtfG8AfQ5xAX42XipZjl41ch2zpKrfNowND4X58cM4oXIhE+DacIK5
         SSRwMOeUbr2PBDZyvP0hXc+7WgUwJ1jJVc4P2VsL2k4s5PntLgxFIoCwllVV4j3OlSP4
         rYIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791511483; x=1792116283;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=rUnebLJfLajmU4biDRGffXGALZ2NDVISxanjJ9k8qQ0=;
        b=km4g0/uFo+xOzKSj7H0Qq7HM0eQMWP0OXMMU4ZVYF4Gy/jVW3BW8ZYoFfVG4HFNRNv
         kuuevv/Fg1N4j6iOW4L7VBl7IktpSCJNJ9cU79NhAfyXLSNWnmlmm2PhUTUuoJQv7aw8
         Upqtm1uWKKqGvE1s7plPJRc2Qx4x6EPaj3GlvIZQDSlRLWifOXn/tq+8bnQH9jMmSPkB
         nUE0qmW4BflLHgqJTmSbVLYgyhyXrtUJ+z/4FPx/kA5oF1XuCZx6zpTLao0DyN2HTl8W
         fOiPAslae+ZX4ADekLA0ulymcpqR0Cph7wc/rBNlnn9/a7/FQVQ72FNTvs1wXlGZ7t6t
         UTvw==
X-Gm-Message-State: AFuF++nUmijY2H2745Tk9Gw40kfb7vSTANauwljUDt/Ed/+x9TkEiout
	hZsp3PBXanjhtgb3uOdrdKEP4eQEfZixY2+INZWPo1suZPISQnAfYSMg
X-Gm-Gg: AYBFou2Zc/JiKstFI0/z0Za83K4NnuGdmLbTBlwCoAivcbmotW9Ttz9sEo8FpqiNsr8
	ZUJNb5bcK0/E89RaXhfC8qWbt+VTFi0ynEN5bxBzm6pGSDG4tA8tjnsfsHwgdHzsRqNihN2Dz6c
	2/xe/kdokeo2GfS8TiQIEyvFYp2UmLZ8JX23BucJpuJaS1rCd6yc+tyHcmt6XfEeUu8+331/XXP
	HP6xHmu3w/Q68VVG6a46mDwYarqPwDZPAjwiAjVYAQX8xWz05jy5F3EMXAQuhdPPIofuevci0Vc
	DhiOJqLFnvxJ97j1+l2EjRw0KQSkr3A70Jplzk4Gwd4mW/3ivn+nZj2xRNfLIDg8T1quTWRvbp5
	+xwOf6p1u4pcPw5lcm4NjTutpx/Nfl/Nf1kPTHu8ztbeJM8lgdgsQSC7bE3s5Acw+HIpBmoKsPD
	VH4w79EkpuZQkrqCohHirccU/jRN4YzJ0AOdePBbF0aVof8dyvqyCNlzNVdhFCiSszlRQ=
X-Received: by 2002:a05:701b:2803:b0:16a:b995:dc7c with SMTP id a92af1059eb24-16ab995dd20mr231638c88.21.1791511482503;
        Thu, 08 Oct 2026 19:04:42 -0700 (PDT)
Received: from [127.0.1.1] ([23.254.208.9])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-16996eac537sm1970743c88.1.2026.10.08.19.04.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 19:04:42 -0700 (PDT)
From: Qiliang Yuan <odys.yuan@gmail.com>
Subject: [PATCH bpf-next v2 0/2] selftests/bpf: Fix the bpffs handling of
 cgroup_hierarchical_stats
Date: Fri, 09 Oct 2026 10:04:36 +0800
Message-Id: <20261009-selftests-bpf-cgroup-stats-bpffs-v2-0-f93a111da992@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALRLyGoC/42NTQ6DIBSEr2LeujSAaH9WvUfjQuChJCqGR42N8
 e6l9gJdfjOZ+TYgjB4J7sUGERdPPkwZ5KkA07dTh8zbzCC5rAXnV0Y4uISUiOnZMdPF8JoZpfY
 XOGKqKpXVUllRGcg3c0Tn10PxhO9mwjVBk5veUwrxfbgXcfT/axbBOLvU+tbWVmgs1aMbWz+cT
 Rih2ff9A8YzPzHaAAAA
To: Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, Shuah Khan <shuah@kernel.org>, 
 Yosry Ahmed <yosry@kernel.org>, Hao Luo <haoluo@google.com>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Qiliang Yuan <odys.yuan@gmail.com>
X-Mailer: b4 0.13.0

cgroup_hierarchical_stats mounts a bpffs on /sys/fs/bpf to pin its
iterators, then moves into a private mount namespace to set up its
cgroups, and unmounts the bpffs in the end if it mounted it itself.

The bpffs lands in the mount namespace shared with the tests running
in parallel, on top of the one already there, and hides what they pin,
which makes bpftool_maps_access and bpftool_metadata fail now and then.
The unmount can't remove it from there, and it checks the other way
around whether the test mounted a bpffs anyway.

Patch 1 mounts the bpffs in the private mount namespace, patch 2 makes
the cleanup unmount the bpffs that the test mounted.

Signed-off-by: Qiliang Yuan <odys.yuan@gmail.com>
---
V1 -> V2:
- Mount the bpffs in the private mount namespace instead of skipping the
  mount when /sys/fs/bpf is a bpffs already (Yosry, CI bot)
- Put that patch first, so that the unmount fix applies to a bpffs it can
  actually unmount
- Pick up Reviewed-by from Yosry on the unmount fix

v1: https://lore.kernel.org/r/20261008-selftests-bpf-cgroup-stats-bpffs-v1-0-76b9a6d1be34@gmail.com

---
Qiliang Yuan (2):
      selftests/bpf: Keep the bpffs of cgroup_hierarchical_stats private
      selftests/bpf: Unmount the bpffs that cgroup_hierarchical_stats mounted

 tools/testing/selftests/bpf/prog_tests/cgroup_hierarchical_stats.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)
---
base-commit: e1d84a37cba984388988d2f1ddc84561413f0db2
change-id: 20261008-selftests-bpf-cgroup-stats-bpffs-4534db24d15c

Best regards,
-- 
Qiliang Yuan <odys.yuan@gmail.com>

