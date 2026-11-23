Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795409869;
	b=OORp9l/sxI/KAV6yNfsfv2HKXMfquvjkunSHCS0+CLCO0++UpZtU5i+w6cx6ye3JCXKc
	 aT7nHp6770UCVTUqt6NLfUv7O+jeCUwxWV7hK7UdSShYu99E+cC5vFtR9l/7xcvC7Ixi2
	 xoBXz+7cGk6MYSrnsUjzOj4HGuXvQnxS63U6QL9Z3s5QrfeG2QAJpA2TqzfzRIVz/ig+t
	 bTucEwbxRkAiQHTvngZdAA+jH6QUcBXN6mM8pzJhtKfdJQtDf1qyMYviaRShzLUtt5zGU
	 VlgBGIz55P5M1W+j9PibfdcAIp4UNm68SCdLR35m77NWnM+RTjH1KdymFQkmDN/lOEg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795409869;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=M1ogYisayK/yxmuo72t/sVdbTsG2vWA7R4e91rM/8ts=;
	b=dIM7PwK1dGxK6VQzvvtPihS9qizpPnL5AUnJmFS9DaXYwvBzMRmeeuz0sor3x/5xBbJH
	 4G++TGNQEcMZA0tSuSFONZABsYQqEncNRpQorEZ3Yiq3CCq+4qk2z9pP8n06B6Z55sH1w
	 vLUv+SEQkiLPX34BdqF0/nmKLww0db+OfBF+MpUSJm7m0x/BtoetPdgnKLYUglUhOJG8N
	 ah8nXRoG+OT8R9TnuVD9JBpUBJc132yFjEUmRS3NuuiE/5gJdc+/a5ZPuhjIwRn8D9ctq
	 Xwt3YaTaHVUslSEOifJr7IHmvyKMUUIuhXoQjuRAlJyjulffYq5wpM/QiFzr4NKXZNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--tweek.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="WGE87fb/";
	arc=none smtp.remote-ip=74.125.82.69
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74D3F606A320
	for <bpf@vger.kernel.org>; Mon, 23 Nov 2026 04:57:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 74D3F606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tweek.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=WGE87fb/
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-16bc6f3fdb1so1788886c88.0
        for <bpf@vger.kernel.org>; Sun, 22 Nov 2026 20:57:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795409868; x=1796014668; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=M1ogYisayK/yxmuo72t/sVdbTsG2vWA7R4e91rM/8ts=;
        b=WGE87fb/HYX7KY3xOT8g91dyOLRPNbt47aVq7HHWwHmG1bRdT3N+EJcqJSSRWLpm9K
         IxrgNjzq6giF4ffKrOrIAUpUpVoLlqbpHpy6AhCpFV/ZRPr1VjmlrSmcPHYmzXFnf+qX
         mLgYZm7ckZqhNJzKXNB/jBmLewQeLUQNZUFZ3zpIo3xgmIMvrbxS4aOvWQgaeAaAP4PK
         qwJ5tdmmQPQu7R+nfv+LRUmURN7NPhFFlw2wsPdrY4J6phfv36Q2Ih5CrlO7zFriwtMQ
         DFToaGEWKVzS/0xuHFTAEY43M+gJwk8yRZGkEk1vwfgTV/0UzETvtXpx/YorjabrIXkj
         n16Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795409868; x=1796014668;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=M1ogYisayK/yxmuo72t/sVdbTsG2vWA7R4e91rM/8ts=;
        b=GjLy7RdHoNwl4IgkoHcUruYDYN8b5NrPIOBsKzYhlsBuabWjNMP4GrkFP+tWBEYCjx
         wa0vduOqIfnb0oZZByErYUnscSeah+MiQi/+dAiCsx5tZN0UID0EHxj0Vj8P/Dn9b9kZ
         xyDzfTou5oCy7A5Kn8FjXRMy9hsm6Fybl75cE72d06YXVIIdSmVldkQA8PXfGxL2p5+s
         Z7REqUO6GJ+BxjBluKGJkpzVMjEPBsFjkQ5DQqtcwgfoTpg6tmmfj72Tj6TT02qZG2Zq
         uW6RLq94m+n1vT46mu36LWPJfSUxdsBSyLmXFwf3Uv5vrb9qWc4FGMN8pyZnyg+O2mKJ
         vNKw==
X-Forwarded-Encrypted: i=1; AL+hErHJ7daHMtqe5BW6ztf5MKBV9CP2cSLZfigui/VQpiHHM1kqXGbMXftByZTgcAd5xwX5QEE=@vger.kernel.org
X-Gm-Message-State: APuU4Z95AJvwlLWtNSO1iZMVC3vlUSVt4UwNwPAQJj4GcyoCRF9DJ4Rt
	JEp27k3Wb3kpn1KupLfnoktCFOK5HKo6zgDAzE5ycDlBQau2qHchtL0/DiiGiPRvJWsLN6DZg85
	ciQ==
X-Received: from dlbts19-n1.prod.google.com ([2002:a05:7022:b053:10b0:1a3:1342:a32d])
 (user=tweek job=prod-delivery.src-stubby-dispatcher) by 2002:a05:701b:2508:b0:1b2:3497:5998
 with SMTP id a92af1059eb24-1b5568f03abmr9773066c88.36.1795409868143; Sun, 22
 Nov 2026 20:57:48 -0800 (PST)
Date: Mon, 23 Nov 2026 15:57:30 +1100
In-Reply-To: <20261123045730.1960346-1-tweek@google.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261123045730.1960346-1-tweek@google.com>
X-Mailer: git-send-email 2.56.1.750.gf70dc682cf-goog
Message-ID: <20261123045730.1960346-3-tweek@google.com>
Subject: [PATCH bpf 2/2] selftests/bpf: Verify gen_loader skips BPF token preparation
From: "=?UTF-8?q?Thi=C3=A9baud=20Weksteen?=" <tweek@google.com>
To: Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Shuah Khan <shuah@kernel.org>
Cc: "=?UTF-8?q?Thi=C3=A9baud=20Weksteen?=" <tweek@google.com>, bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	Sid Nayyar <sidnayyar@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Add a token/obj_gen_loader_no_token subtest that mounts a delegated
bpffs over /sys/fs/bpf in an isolated mount namespace and verifies that
bpf_object__gen_loader() does not acquire a BPF token when:
 - /sys/fs/bpf has implicit token delegation enabled,
 - opts.bpf_token_path points to a delegated bpffs, or
 - LIBBPF_BPF_TOKEN_PATH points to a nonexistent path.

Signed-off-by: Thi=C3=A9baud Weksteen <tweek@google.com>
---
 .../testing/selftests/bpf/prog_tests/token.c  | 82 +++++++++++++++++++
 1 file changed, 82 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/token.c b/tools/testing=
/selftests/bpf/prog_tests/token.c
index f2f5d36ae00a..2aeb814ea376 100644
--- a/tools/testing/selftests/bpf/prog_tests/token.c
+++ b/tools/testing/selftests/bpf/prog_tests/token.c
@@ -1051,6 +1051,79 @@ static int userns_obj_priv_implicit_token_envvar(int=
 mnt_fd, struct token_lsm *l
 	return -EINVAL;
 }
=20
+static int verify_gen_loader_no_token(const struct bpf_object_open_opts *o=
pts)
+{
+	LIBBPF_OPTS(gen_loader_opts, gen_opts);
+	struct priv_prog *skel;
+	int err;
+
+	skel =3D priv_prog__open_opts(opts);
+	if (!ASSERT_OK_PTR(skel, "gen_loader_open"))
+		return -EINVAL;
+
+	err =3D bpf_object__gen_loader(skel->obj, &gen_opts);
+	if (!ASSERT_OK(err, "gen_loader_init"))
+		goto out;
+
+	err =3D bpf_object__load(skel->obj);
+	if (!ASSERT_OK(err, "gen_loader_load"))
+		goto out;
+
+	if (!ASSERT_EQ(bpf_object__token_fd(skel->obj), -1, "gen_loader_token_fd"=
) ||
+	    !ASSERT_OK_PTR(gen_opts.insns, "gen_loader_insns") ||
+	    !ASSERT_GT(gen_opts.insns_sz, 0, "gen_loader_insns_sz") ||
+	    !ASSERT_OK_PTR(gen_opts.data, "gen_loader_data") ||
+	    !ASSERT_GT(gen_opts.data_sz, 0, "gen_loader_data_sz"))
+		err =3D -EINVAL;
+
+out:
+	priv_prog__destroy(skel);
+	return err;
+}
+
+static int userns_obj_gen_loader_no_token(int mnt_fd, struct token_lsm *ls=
m_skel)
+{
+	LIBBPF_OPTS(bpf_object_open_opts, opts);
+	struct priv_prog *skel;
+	char buf[256];
+	int err;
+
+	/* Mount delegated BPF FS over /sys/fs/bpf and confirm normal load uses i=
t. */
+	err =3D sys_move_mount(mnt_fd, "", AT_FDCWD, "/sys/fs/bpf", MOVE_MOUNT_F_=
EMPTY_PATH);
+	if (!ASSERT_OK(err, "move_mount_bpffs"))
+		return -EINVAL;
+
+	skel =3D priv_prog__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "normal_implicit_token_load"))
+		return -EINVAL;
+	if (!ASSERT_OK_FD(bpf_object__token_fd(skel->obj), "normal_load_token_fd"=
)) {
+		priv_prog__destroy(skel);
+		return -EINVAL;
+	}
+	priv_prog__destroy(skel);
+
+	/* Implicit /sys/fs/bpf token must not be created during gen_loader. */
+	if (verify_gen_loader_no_token(NULL))
+		return -EINVAL;
+
+	/* Explicit bpf_token_path must also be ignored during gen_loader. */
+	snprintf(buf, sizeof(buf), "/proc/self/fd/%d", mnt_fd);
+	opts.bpf_token_path =3D buf;
+	if (verify_gen_loader_no_token(&opts))
+		return -EINVAL;
+
+	/* Invalid LIBBPF_BPF_TOKEN_PATH must not fail offline gen_loader. */
+	err =3D setenv(TOKEN_ENVVAR, "/nonexistent/bpffs", 1 /*overwrite*/);
+	if (!ASSERT_OK(err, "setenv_invalid_token_path"))
+		return -EINVAL;
+	err =3D verify_gen_loader_no_token(NULL);
+	unsetenv(TOKEN_ENVVAR);
+	if (err)
+		return -EINVAL;
+
+	return 0;
+}
+
 static bool kallsyms_has_bpf_func(struct ksyms *ksyms, const char *func_na=
me)
 {
 	char name[256];
@@ -1243,6 +1316,15 @@ void serial_test_token(void)
=20
 		subtest_userns(&opts, userns_obj_priv_implicit_token_envvar);
 	}
+	if (test__start_subtest("obj_gen_loader_no_token")) {
+		struct bpffs_opts opts =3D {
+			.cmds =3D bit(BPF_BTF_LOAD) | bit(BPF_PROG_LOAD),
+			.progs =3D bit(BPF_PROG_TYPE_XDP),
+			.attachs =3D ~0ULL,
+		};
+
+		subtest_userns(&opts, userns_obj_gen_loader_no_token);
+	}
 	if (test__start_subtest("bpf_token_info")) {
 		struct bpffs_opts opts =3D {
 			.cmds =3D bit(BPF_MAP_CREATE),
--=20
2.56.1.750.gf70dc682cf-goog

