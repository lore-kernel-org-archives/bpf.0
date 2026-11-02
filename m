Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793616453;
	b=W9bskomQL9II7jv9JSxR6kCLe2jUiAeN1+Z6tyKOv7FdPHb8RArR59QpwU6dr2WzIQrY
	 qRJJ9eygAms3UY/8qr5aFpUJXzWY+lgpdXgRLUbGvvTRQTxvgnyJt0C0brvplw90ntUAp
	 QrpaOr8JC8va6utBr893AK95E06IrNq9wQFIqfmTGeqh0mt3qRFMoOOXRrR3Aul6bkWEC
	 4QmVNYeFohKQ089/0GlKh+j3IxcIigAbi/p31Nxj0qcvpTmB1yd5yZmUOaOgxB+xvJ2y8
	 qJgz3Qxm/Ma1TFFgp9RC5zt2n++kkXz2XOMdt4L/DbwgKESX456xPC2SvFsHGxWT4hQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793616453;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=+wYgEbXatInkhlPGnHVcGcwQYZRiNvBT23gLhEtY+s8=;
	b=W4Apb3NkUqOP7IKOWtJwFsVvX2xeV0bbsbrzd/DSPxL6RjlxQR6h8Ls86FIbmxK+DiHp
	 YiT35qhLvRywN/91fJYEEzzGeEEYv3C5p9UeFrHfIQ4BZTKKEHa7aH7oyRTGKopnYB3fL
	 I6FXijJabIuNBVGu4bU/zO57NVwq22JoonKn7pOip6lS8N3nhtlilU7eGhv7MMabRgXj/
	 L7HHe1lUqpoEuaawU3LAVCjjIvxTYLSnUMLWmDAmrkB94tEFQ489jKPJVn81/bsxeSzg6
	 r5MbpcQsWp+EFEgCTTFi3CEi4khv61/EHR0VUGKlgWEaHCktlKRsGeP1Jjz/xu+p6fA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sqjGWtQ2;
	arc=none smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5662B606A32D
	for <bpf@vger.kernel.org>; Mon,  2 Nov 2026 10:47:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5662B606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sqjGWtQ2
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4afe2d546f9so11422455e9.3
        for <bpf@vger.kernel.org>; Mon, 02 Nov 2026 02:47:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793616452; x=1794221252; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=+wYgEbXatInkhlPGnHVcGcwQYZRiNvBT23gLhEtY+s8=;
        b=sqjGWtQ2vRyV8uRUrKbKazN0/I5yAXVv0XsmmtzJP2PWcgyWFv0XwS4JyAkNm7if5T
         z7+tFrnln7t+7w0TjwsmYJnYzdWcY/mMqA/tXmzfQjuxNa0aG8/11k7V5jih1qwPZwT9
         fnfQpaJ1AYrWYq7Tpuviy+oezxAHgjZgnHFVj4RQctBmluhqGP1BEbZQGqFwfhmZqKNH
         Uw+JjXtuRV9y5pG/ir0cneBBuMBfxVJOK5/1B0eByYgQ9plGzJwNDkfAqcXFhJ07Jyhr
         RKeSFOEzpZJkfOthYqigZXqihmV4FRH2ABIBvIHX6o9crUJDy/pQeQVT223PDBjAxXmq
         dMnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793616452; x=1794221252;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+wYgEbXatInkhlPGnHVcGcwQYZRiNvBT23gLhEtY+s8=;
        b=AtBKx3WTO5JUOqXmzgFFMvxZiZZZGbrgD0VbGuEpOGQjDunQ1c70ueNi/nsaj4d9dr
         zqcw/smkXPY/Y/iAxcbnCED+gjQGMBwrN1zRBKvf9rM4yKUu5uECsIRvTt91q8hksUsB
         gVaBIgkbrmY19jmbbDO4rTHQPGwvNKI+U/hjOSFQ6kD7bw9/Kgo00xkan+23Z3kSCZhx
         uaEV7zfTUB00L326Ypo166845P1liBmPftZ9d7JNncQ9A17KO/uRM46o7yYaTg9diRc4
         8+3DQSRBmV1zQ8s91uRK/qTZF4ehKnVw7mzIlM214wQPzvMyK3Kqd9/Blhp/H9ZU5xNZ
         v1IA==
X-Gm-Message-State: AFq9FYKtzJLJ+KLlhIvfbF963RDzebmvisjAdDBCihR3oDw6cLr/m25g
	CKrG8R69zVVT8B35ONiC0n7ZrIWQgGoA9lF4/HtsrYSmXHFAILp3U05Z
X-Gm-Gg: AYBFou22MLxqlBhjZ+9Mtnq9lIvvNbTjEN4mFAa/qq5dufvLGiwc22a65FYtkhyxOxw
	YcLc7oNtn1rIYhiT/ew9oBIPQVS1/r2i1frnusgVruLg3oH51lbsEex/KFkCuU/OBidIz7B2fc3
	zlXz5mySw79Ai9Bilgrzv1PPaLEyTSGRrJdLm6WSQ49cWYOuXHBnI9dhCShvWrLu4DxwM4oGmU7
	CgifZd8nUEVGncvf7JhIlZVONGZG6gasEU/cHwMel78jPZF8YY5jueuAjZMHNqv42I3a9NcHYNz
	SlkqRif+HAhBUCE4dF3hmiwsnhKXT1WbINg0sRvFj7D+1CFQs7qaWFkGRuw3eN9WnKRMeXaXi8b
	NgtjLCgjX4tU7EbDSBcz4jbI37DpIUnWTzvndwNUI85npATaRUwVpM1OzMn73rdGmECPSfomtFp
	6x0JLhnbrQ3xxLP2pI5QuAtJXwTLb1cNb4f5YJ7Roxdp9HGU13nxQTt/VDGVwB3UjGi7t5zF8Vz
	ZVejOTVL6dqjeSNnVYQTxgEezEWeAvTg480aAbYIQqcuk18VbwAeFq5CvmlpmgJwPrKdVE6zl5v
	4iQ1ShzLdgLGYbGkERMQ027Tghk/TkL6wZx6p4iXy5P6
X-Received: by 2002:a05:600c:c09b:b0:4b0:c1ae:829 with SMTP id 5b1f17b1804b1-4b0c1ae0ad5mr54814305e9.30.1793616451558;
        Mon, 02 Nov 2026 02:47:31 -0800 (PST)
Received: from dell-desktop ([2a02:587:4b42:1400:8199:c552:2b9e:c33])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4abf6c7852esm248939695e9.11.2026.11.02.02.47.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 02:47:30 -0800 (PST)
From: Anastasios Papagiannis <tasos.papagiannnis@gmail.com>
To: brauner@kernel.org
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	viro@zeniv.linux.org.uk,
	jack@suse.cz,
	tasos.papagiannnis@gmail.com
Subject: [PATCH vfs-7.5.bpf v2 0/3] bpf: Add bpf_path_getattr()
Date: Mon,  2 Nov 2026 12:46:52 +0200
Message-ID: <20261102104655.70901-1-tasos.papagiannnis@gmail.com>
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
stat() and related system calls. BPF LSM programs need matching inode and
device numbers to look up those entries. Reading inode fields directly can
give different values on overlayfs and miss filesystem-specific getattr
behavior.

bpf_real_data_inode() resolves the inode hosting a file's data, whose
identity and metadata can differ from those reported by stat() and related
system calls on overlayfs. It does not invoke the filesystem's getattr
operation.

This series adds bpf_path_getattr() for sleepable LSM programs. It takes a
trusted path and calls vfs_getattr_nosec() to avoid calling back into
security_inode_getattr().

The kfunc returns struct kstat. Inode and device identity follow the
filesystem's getattr operation.

Selftests compare basic fields with statx() on tmpfs and on overlayfs
before and after copy-up, accounting for device encoding, and exercise
verifier restrictions. The series also updates the relevant documentation.

Changes in v2:
- Use a thin vfs_getattr_nosec() wrapper returning struct kstat. (Alexei)
- Remove struct bpf_file_stat. (Alexei)
- Update the documentation and tests.
- Rebase onto vfs-7.5.bpf for merging through the VFS tree. (Daniel)

v1:
https://lore.kernel.org/bpf/20261029095952.44833-1-tasos.papagiannnis@gmail.com/

Anastasios Papagiannis (3):
  bpf: Add bpf_path_getattr()
  docs/bpf: Document bpf_path_getattr()
  selftests/bpf: Test bpf_path_getattr()

 Documentation/bpf/fs_kfuncs.rst               |  13 ++
 fs/bpf_fs_kfuncs.c                            |  38 +++-
 .../selftests/bpf/prog_tests/path_getattr.c   | 162 ++++++++++++++++++
 .../selftests/bpf/progs/path_getattr.c        |  42 +++++
 .../bpf/progs/verifier_path_getattr.c         |  57 ++++++
 5 files changed, 311 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/path_getattr.c
 create mode 100644 tools/testing/selftests/bpf/progs/path_getattr.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_path_getattr.c


base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
-- 
2.56.0

