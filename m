Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793268033;
	b=kzGhQJRxanPeg0oVXszPoTd/UkSk/mt3OaaIQEjAGomiWCAaqgIadr2XrYWuZeBsYa2v
	 hVLgPtQYCF/SbnP3iKf7KBvXlkB0WKVvIoAH8X07w8hnOlT1+xY7sMaYVoyALpsPBBl7P
	 LXqdH/2LgjQ4A1/sPA0Sb4Agqykw5IWDG30e6d7BWp4iPVhDQpaTVPn0UuxY6Ys1ebcJh
	 W2bqB4VL90hc0I4IqZ/Kb7S3xsg+/rDfA6at7fuhZR6rJHoOXCmagZmJEAEEMk+pJfwYm
	 OKrrzmGEBDq/cN1kScl4BaUol3KsOThJ+AJR83QN9eEDEV8v/nBnf9AcPTiaCB2PN1w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793268033;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=MuAgzDOGGZNImhzWO720yvkQx63NEyn8l8tBYbjMb5U=;
	b=RTZdVdqZc+ZaXqPevsZLryBVaWycGDtCXpQM2OPekICxYzZxi6s0Vy2kQXTjt1LY3aw4
	 5iN/6BlGPhLIgwxuhT5DUVsYUD4LKnwDmr6izAn3iQa4U2M1DXeQNG9lkMKZEqdmCO5S4
	 umLqEFHY+caX2KwbQanY6Vj2lewV9o88poN5Ncb+srCqZWSEMkrVRfJOyE0p8jR3Vy34l
	 XKaCtTReZtbKVNNHr+YRcT9m5lrKnsSJ/4V/kUbCS0TWjwl78XMTFLWaL1JLGwHE2Vw1T
	 prNBVkaTDp0u/gDQ9TtCyqUZ0EVBgB6aIETMsfRnKsF7oNHeXpwjVR73BuBpn8OKXww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JAywMryx;
	arc=none smtp.remote-ip=209.85.221.49
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1B10606A333
	for <bpf@vger.kernel.org>; Thu, 29 Oct 2026 10:00:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D1B10606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JAywMryx
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-48e20ed3b9dso1482708f8f.2
        for <bpf@vger.kernel.org>; Thu, 29 Oct 2026 03:00:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793268031; x=1793872831; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=MuAgzDOGGZNImhzWO720yvkQx63NEyn8l8tBYbjMb5U=;
        b=JAywMryxHW1yaysWfWfVQAC0k1C8utwWeeeo1Tt788UbG8ftVXpmVToxy8Ui/PbSt4
         pK69YqTnf+OIdIYPJN6q+/TATtv+wPb6XUkI8stly8vXz1CrpvD99gksZmgxsCBYVYqz
         hFdsofdcvZ0c2pmoxr9P1Z9hah+VlU2mF4/rt3v7tpaUMHAMe2MZTZYJkFUr02gPdD7V
         aQ7hZVvx3k6/irktRxITFy4AwZw3x2yeJiIDDaFrgigLPDmwFNhmysyRzGCT/BTLNr5G
         51KTo/tUIZWi2XvnhbhrsfiiTQ4pHKR/2ywEvKJw8dyctfdL520Sdobp3wjnqgTZRaDz
         1m+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793268031; x=1793872831;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MuAgzDOGGZNImhzWO720yvkQx63NEyn8l8tBYbjMb5U=;
        b=d0f4BGtRxuQmqf6B40CSfCH8EEVKhr+7IB06wZ1d+y8AmcNrcbly35JmH+u6G/Npqs
         PgB53Ggaxu6WwhJpaIs0IifsoFXyWSJ69D3sMkzHPUGf3qq2hOSpSifLHpV0uMZLU6KJ
         AX2d2up8XLGvtQEei1lRiZGUV+0LrEDhvdQpSUOT4DjmfFwmooR9nF0gOzcFkKd4kh9q
         GrkJWRoUpXdyxJMW7Y8d7G3JVxQQ7Ne9zSvIJkYFaBv4qoPd7GWcXfZGgZ4weKDiWWDW
         9uD04v+qYv+uCXp+Q2hOssblWou/ACF66fYubtOPjrteHFtaiifucPuFPyrvhoqzKoOh
         v77A==
X-Gm-Message-State: AFq9FYLRs6PWCMb73war1fKubKh+YdXT0tSYL1C6GcKbFTZLebb62TzW
	OVGlgzJ2Sg0kz8S0TnKbyUzpZ7KgDB9/3d7NC+dYao08q4ZcX80WcFsnSPWQB/qg
X-Gm-Gg: AYBFou30t9+87xA6wrea60RJ5KZ/rCBg/eqKgRYTQDuvPByOZotsLOhkW6bkU4WQ16Q
	7sTonMy5+gSISAXj6jrFhH+v/a15TZkGD27wWkDYYLwzk+Q0314K3u99iIdBHHcLmmIVl2UaMpE
	FyFlawj1uxk9YNRLPtFdFCQDcjV5yMmAxxz40XmYIVlTm9/+I80Bdb5qvZAku2Lj22kNhfXuqra
	xvH1ZOAWuUKZcq9pMfdMlsgzzbO9c7cyhdhuUT0ydDxRvW6E0/oPopEU2WsYhElUf4nURh/DGCB
	rH5FXiKGW+mPIJANv5G1b0RmRP/5Qw46kFDn4Ny4bG20MHJ7RRf+oxEVBPdBxFc5kB6dL2HPaNi
	RoigQlwhbspaxE+3WTLPPhbx6XttvQpgy9BYklmPawnTbigVV6IGcprN85H9NBk7JC3BmLLM22h
	TO0qkbZdCmkrf/byYSYdWAOJF9bFiqA8CpoKNIvLg6OfBsiKeeO0+WoALnSjGilSchUhdxw4f45
	WFbFwxELjPvKj3VdyaGIxvbJysRcS8TFcwTcWjptahLrkzMKCimWhFzTVfgppAGk3trcYKbhZ7R
	hhTsq5rqySjOCOAw+N1wZSAQgpZs6HPLXAVCfvoRdUo=
X-Received: by 2002:a05:6000:29d7:b0:48e:6264:c373 with SMTP id ffacd0b85a97d-48e6264c7f1mr4314548f8f.14.1793268030946;
        Thu, 29 Oct 2026 03:00:30 -0700 (PDT)
Received: from dell-desktop ([2a02:587:4b42:1400:8199:c552:2b9e:c33])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ebc3c5bsm34025569f8f.9.2026.10.29.03.00.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 03:00:29 -0700 (PDT)
From: Anastasios Papagiannis <tasos.papagiannnis@gmail.com>
To: bpf@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	tasos.papagiannnis@gmail.com
Subject: [PATCH bpf-next 0/3] bpf: Add bpf_path_getattr()
Date: Thu, 29 Oct 2026 11:59:49 +0200
Message-ID: <20261029095952.44833-1-tasos.papagiannnis@gmail.com>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Userspace code can populate BPF maps using file identities obtained from
statx(). BPF LSM programs need a way to generate those inode and device
numbers to look up for those entries. Reading inode fields directly can
give different values on overlayfs and misses filesystem-specific getattr
behavior.

bpf_real_data_inode() resolves the inode hosting a file's data, whose
identity and metadata can differ from those reported by statx() on 
overlayfs. It does not invoke the filesystem's getattr operation or
provide mount information.

This series adds bpf_path_getattr() for sleepable LSM programs. It takes a
trusted path and calls vfs_getattr_nosec() to avoiding calling back into
security_inode_getattr().

The kfunc returns a 64-byte bpf_file_stat. We avoid using struct kstat
directly as this is an internal structure and this can lead to changing
the user API. Inode and device identity follow the filesystem's getattr
operation, and the device number uses stat(2) encoding. Mount IDs,
mount-root attributes and ownership translation follow statx(), including
mount idmapping and translation into the current task's user namespace.

Selftests compare the result with statx() on tmpfs and on overlayfs before
and after copy-up, and exercise verifier restrictions. The series also
updates the relevant documentation.

Anastasios Papagiannis (3):
  bpf: Add bpf_path_getattr()
  docs/bpf: Document bpf_path_getattr()
  selftests/bpf: Test bpf_path_getattr()

 Documentation/bpf/fs_kfuncs.rst               |  13 ++
 fs/bpf_fs_kfuncs.c                            | 108 +++++++++-
 .../selftests/bpf/prog_tests/path_getattr.c   | 185 ++++++++++++++++++
 .../selftests/bpf/progs/path_getattr.c        |  25 +++
 .../bpf/progs/verifier_path_getattr.c         |  57 ++++++
 5 files changed, 387 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/path_getattr.c
 create mode 100644 tools/testing/selftests/bpf/progs/path_getattr.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_path_getattr.c


base-commit: d80373a8e70d3193151232c3062abbbe367ff5ad
-- 
2.56.0

