Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D85F135972
	for <bpf@vger.kernel.org>; Fri, 13 Feb 2026 18:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771006680; cv=none; b=XyimUIEiJLsaY1Dla3hsrQ+cJMZLffmBneYWm3UY9/iQMMlt5+UO2pu8odR87I1f/F4aD1guzW448pvX9vcZUrIbAvmU7UiBvU6a5bJvm4vcgiO1jydneSbJaajGBDR3yf9aIxJItVZXFXNjD+jdnIiZU5HmfXaCTbncYhMZlpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771006680; c=relaxed/simple;
	bh=HYoTsISfvQHjsfbKim+GiKy0GyumM8kMuXgBwGRUNb0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SPe2+zGXoLt96/nM8778+hKq5Zk+JsVUT9JpRArSAl5N3oFyqe0cNvo5XC+H5y5b2LEyP3tfxBPKrox2R+OgiZb9AGsymCfYzBM5D4eUg0/oDXlK7iszelAyHfZjUUAX0/GdncgWu73HCWM1/nkBbQMcgndpG9ipK1BVyFJFhsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=MwFCMJlZ; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="MwFCMJlZ"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-8946f12b1cfso14983696d6.0
        for <bpf@vger.kernel.org>; Fri, 13 Feb 2026 10:17:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1771006678; x=1771611478; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jFyxUjkqM6uLdzxXTYh2tUftPKxm9BV2G8D3FRYAE9I=;
        b=MwFCMJlZJ1iZY4DkF1YNJRs0jicPFMOrNt2zc0oxaeictlYAE5mAUISZAF/tzRGuf7
         aDr+V/uS97RM8Ni7N3k9zJgOfXV1QodV0YthP9nHlgNUykUNUa1VOZJ5jJh9GtYWViUx
         aQe77T7QKE4JE3AlSCDqQbVEc1pP9gx8H7nvb3OhUELEACDjzgB8zExBOvx1KVwJUYVa
         d5RO59Ft7wnyeDieAGsInzh1YcY4ubbkzOk18IzWFW7F9h9j2a/NciUc9U8Vg7MaozxW
         XqcIZ+A/kDYbJ3zvW/TVZDY4c8pWMhuGWTs6lk+lfFyzbIy2A6n4g55ntqbI+KdGnOgb
         OqsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771006678; x=1771611478;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jFyxUjkqM6uLdzxXTYh2tUftPKxm9BV2G8D3FRYAE9I=;
        b=pzAwVXSSkAz1nXp+hCiWe9RkBOvagBysHb7XZWp7heejreRupVcsDhJpxxBF3GGhJx
         3j2ED4/k5KkPWMqN38gWSqm0F1zCbQ2aB/j0zHzG+9Wtq5r06Ydpo1WnFzXOP7P6eohe
         AQICNASvRuBJmefBmEIW2CEY+JWGqVXBw7zzIiS8SrOlah4brdAH8EiShdchXkiqjLFU
         c5atY8DFjU1E7cpGSf7O/MNc+/FDC2Pt2vHq2Vf9Qy5GWMNccAEq2+Cqc27/hGSHpgPW
         BerGBzf1Du2U78wMoUsxqY8hUOXR0MAqVxJP4i0V65118W1dtKYXzQiYiNN2R8S+aWe+
         a4GA==
X-Gm-Message-State: AOJu0Yzaek3+YOhzQcrFRFJw977YtYlBFfs1ecjd/7k0I2Lop0rtOz33
	nlnrC7mhq2sThjXIZ1An19WDHDoOuR1Fb/a1hZk0ZOKw5vJ/MVSIK3aYnFtgsjFCM6fvFJBFMJF
	QRBhUhN0=
X-Gm-Gg: AZuq6aKgbS7ZOXItbNEfr9c1gpMAM9oJ9ohxmp+dEAq6b11A0Rr5GaJlHmgA64vTRC5
	+emk+fFAdFcyZ1Dont+1uTrpnd0DF3lUESD0GWN+ry2YaBdi7aoTsZ+3YuMRED9caH1GcxIw4r4
	R4T4mmkOYb2VsfbuNPA2SnzEMCsS8/Vk/ZRUPC3Wp8yXzV0jqHPAMzWLJlZeDrILzjk8f3fIwrl
	aO9AruVFzI80r9IfreMlgXhRFJ0B6ukqYGd2bqQ8DdDlt3bhhdgpftGPc4qZVt3MHGspjVDuCi+
	4ZTwh1ZbRc+h3oj2JBGO5fPPozFY95RJ5mkwX/QCo1ZYi+mEfDvy444a596Y5hI3T+X1SKD7ncl
	GMv9OhsWq6pjC4hrQSOsBAvqjbHGoBmiL1eE0EdUmLK+j/H8N7NBML6KBfEU5w04dOkE1m813k2
	F6sWm6RrK9qzIWd+2m5aN3zw==
X-Received: by 2002:ad4:5742:0:b0:896:a692:cabe with SMTP id 6a1803df08f44-897361cd337mr42112906d6.47.1771006677644;
        Fri, 13 Feb 2026 10:17:57 -0800 (PST)
Received: from boreas.. ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8971cc91eccsm67337166d6.13.2026.02.13.10.17.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Feb 2026 10:17:57 -0800 (PST)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	memxor@gmail.com,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH bpf 0/2] libbpf: Fix perm errors for LDIMM_64_FULL_RANGE_OFF use
Date: Fri, 13 Feb 2026 13:17:50 -0500
Message-ID: <20260213181752.505318-1-emil@etsalapatis.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 677755d502df ("libbpf: Add gating for arena globals relocation feature")
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

Fixes: 677755d502df ("libbpf: Add gating for arena globals relocation feature")
Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>

Emil Tsalapatis (2):
  libbpf: Do not use PROG_TYPE_TRACEPOINT program for feature gating
  libbpf: Delay feature gate check until object prepare time

 tools/lib/bpf/features.c |  4 ++--
 tools/lib/bpf/libbpf.c   | 31 +++++++++++++++++++++++--------
 2 files changed, 25 insertions(+), 10 deletions(-)

-- 
2.49.0

