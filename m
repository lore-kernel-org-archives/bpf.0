Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4731F3AA4F6
	for <bpf@vger.kernel.org>; Fri, 21 Aug 2026 21:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787348483; cv=none; b=mpj2zmv7vPhLH4Oxl4Kusr1XT1GqQg4cioVVGXQXpmc4Jhrkz3j+yXn1sqjfIphCqemA9DnadfFLpiM/r+Lu3WJ+XVM8Ohoyn+GuY3farLenCpFsQG7GgYDhp1yxSh10CxAu/BOfEpJa2RjuLIpE+qRRnE0rHPcchn5kSQD/uYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787348483; c=relaxed/simple;
	bh=Rn/H6JFeCIh2uG81ZQ2IOD7vrA1Sm4/FBgaBNrQof0c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iTyG+BIFNX1Rxsr8NL/MrbY8Kwwbp0LepZPiCNFkA4i8vMo7ZkMESO6vDHppLi0P9Ors3P34dQRQ6o+KwPjVSYa1m+zP9O33KTBMFKvwgFjVayuMt2N7a7Bnr2wj+bnpqLeK0jiaDczX/Q5eb0kVd2AT4aLoSg48DpNRSE3m9rY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=knKYZ7tf; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="knKYZ7tf"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=0Q4P/y/qSDFgl+cUHm+eRRBZugymhDYPG8I4O0q8yJ4=; b=knKYZ7tf/wAfd1sxrp4qrdm2Q7
	nXB6uI6CcbYcz8pmAg2FHsnva11R8VX0NPIqB7Bo9FkXpD7vhq/gcJvexgqP6Fuqds8IKY12VzYWW
	o3nNIYz0C5+LTmjrZnWLMy5LlmP8b9ssQ1O3i3IpOLgNyRVkTZxTCbCarOzjpP9t/EPHDeE7PeWlG
	5PeIHVWBKlJj91oTG0Ts6E2k/VlNWW8vOopXqTUF/MXfD0YQrt0Rs96PqdLjIU8lQOZr1sjpUC2jy
	vFhLhOGJui9Ba1/WoAdm/S7tAQRQk6GU+Zd7I8ShHY3gaSnEF0JLZ9bSS4rVNER9mS9y9iHayhU6k
	nl4lXqRQ==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1wxWzH-000Mqt-1E;
	Fri, 21 Aug 2026 23:41:19 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: memxor@gmail.com
Cc: brauner@kernel.org,
	kpsingh@kernel.org,
	ast@kernel.org,
	john.fastabend@gmail.com,
	a.s.protopopov@gmail.com,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next 10/11] selftests/bpf: Add tests for bpf keyring in signed loader
Date: Fri, 21 Aug 2026 23:41:10 +0200
Message-ID: <20260821214111.1120748-11-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260821214111.1120748-1-daniel@iogearbox.net>
References: <20260821214111.1120748-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28099/Fri Aug 21 08:26:38 2026)

bpf_keyring_provisioned walks the keyring through its whole lifecycle in
one boot for ease of testing. It enrolls a freshly generated key into the
bpf keyring, confirms a load is still refused with -ENOKEY while the keyring
carries no restriction, then restricts it, and only then does the same
signed BPF program load with the bpf keyring. A caller-supplied keyring is
asserted to be refused both before and after the restriction, since what
refuses it is bpf.keyring_unsealed=1 rather than the state of the keyring.

Unsealing is a boot-time decision which also refuses the session keyring
that every other subtest here signs against, so such a boot goes straight
to this test and a regular run covers the rest. Without bpf.keyring_unsealed=1
on the vmtest guest command line the subtest is not registered at all, since
a sealed keyring can never be provisioned.

Regular run:

  # LDLIBS=-static PKG_CONFIG='pkg-config --static' ./vmtest.sh -- ./test_progs -t signed_loader
  [...]
  #424/12  signed_loader/signature_zero_size:OK
  #424/13  signed_loader/signature_bad_keyring:OK
  #424/14  signed_loader/bpf_keyring_sealed:OK
  [...]
  #424/30  signed_loader/signed_map_by_fd_rejected:OK
  #424/31  signed_loader/signed_sparse_fd_array_rejected:OK
  #424     signed_loader:OK
  Summary: 1/31 PASSED, 0 SKIPPED, 0/0 FAILED

Unsealed run:

  # KERNEL_CMDLINE_EXTRA="bpf.keyring_unsealed=1" \
    LDLIBS=-static PKG_CONFIG='pkg-config --static' ./vmtest.sh -- ./test_progs -t signed_loader
  #424/1   signed_loader/bpf_keyring_provisioned:OK
  #424     signed_loader:OK
  Summary: 1/1 PASSED, 0 SKIPPED, 0/0 FAILED

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 .../selftests/bpf/prog_tests/signed_loader.c  | 362 +++++++++++++++++-
 1 file changed, 356 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/signed_loader.c b/tools/testing/selftests/bpf/prog_tests/signed_loader.c
index a1fa1c37815b..9d2384071a42 100644
--- a/tools/testing/selftests/bpf/prog_tests/signed_loader.c
+++ b/tools/testing/selftests/bpf/prog_tests/signed_loader.c
@@ -69,6 +69,33 @@ static int load_loader(const void *insns, __u32 insns_sz, int map_fd,
 	return fd < 0 ? -errno : fd;
 }
 
+static int load_loader_log(const void *insns, __u32 insns_sz, int map_fd,
+			   const void *sig, __u32 sig_sz, __s32 keyring_id,
+			   __u32 fd_array_cnt, char *log_buf, __u32 log_sz)
+{
+	union bpf_attr attr;
+	int fd;
+
+	memset(&attr, 0, sizeof(attr));
+	attr.prog_type = BPF_PROG_TYPE_SYSCALL;
+	attr.insns = ptr_to_u64(insns);
+	attr.insn_cnt = insns_sz / sizeof(struct bpf_insn);
+	attr.license = ptr_to_u64("Dual BSD/GPL");
+	attr.prog_flags = BPF_F_SLEEPABLE;
+	attr.fd_array = ptr_to_u64(&map_fd);
+	attr.fd_array_cnt = fd_array_cnt;
+	attr.signature = ptr_to_u64(sig);
+	attr.signature_size = sig_sz;
+	attr.keyring_id = keyring_id;
+	attr.log_level = 1;
+	attr.log_buf = ptr_to_u64(log_buf);
+	attr.log_size = log_sz;
+	memcpy(attr.prog_name, "__loader.prog", sizeof("__loader.prog"));
+	fd = syscall(__NR_bpf, BPF_PROG_LOAD, &attr,
+		     offsetofend(union bpf_attr, keyring_id));
+	return fd < 0 ? -errno : fd;
+}
+
 static int run_gen_loader(const void *insns, __u32 insns_sz,
 			  const void *data, __u32 data_sz,
 			  const void *excl, __u32 excl_sz,
@@ -170,6 +197,23 @@ static int run_setup(const char *cmd, const char *dir)
 	return -WEXITSTATUS(status);
 }
 
+static void genkey_dir_fini(const char *dir)
+{
+	static const char * const files[] = {
+		"signing_key.der", "signing_key.pem", "x509.genkey",
+	};
+	char path[PATH_MAX];
+	size_t i;
+
+	if (!dir)
+		return;
+	for (i = 0; i < ARRAY_SIZE(files); i++) {
+		snprintf(path, sizeof(path), "%s/%s", dir, files[i]);
+		unlink(path);
+	}
+	rmdir(dir);
+}
+
 static int sign_buf_digest(const char *dir, const void *buf, __u32 len,
 			   void *sig, __u32 *sig_sz, const char *digest)
 {
@@ -186,6 +230,7 @@ static int sign_buf_digest(const char *dir, const void *buf, __u32 len,
 	fd = mkstemp(data_tmpl);
 	if (fd < 0)
 		return -errno;
+	snprintf(sigpath, sizeof(sigpath), "%s.p7s", data_tmpl);
 	if (write(fd, buf, len) != (ssize_t)len) {
 		close(fd);
 		ret = -EIO;
@@ -210,30 +255,28 @@ static int sign_buf_digest(const char *dir, const void *buf, __u32 len,
 		goto out;
 	}
 
-	snprintf(sigpath, sizeof(sigpath), "%s.p7s", data_tmpl);
 	if (stat(sigpath, &st) < 0) {
 		ret = -errno;
 		goto out;
 	}
 	if (st.st_size > (off_t)*sig_sz) {
 		ret = -E2BIG;
-		goto out_sig;
+		goto out;
 	}
 	fd = open(sigpath, O_RDONLY);
 	if (fd < 0) {
 		ret = -errno;
-		goto out_sig;
+		goto out;
 	}
 	if (read(fd, sig, st.st_size) != st.st_size) {
 		close(fd);
 		ret = -EIO;
-		goto out_sig;
+		goto out;
 	}
 	close(fd);
 	*sig_sz = st.st_size;
-out_sig:
-	unlink(sigpath);
 out:
+	unlink(sigpath);
 	unlink(data_tmpl);
 	return ret;
 }
@@ -643,6 +686,68 @@ static void signature_bad_keyring(void)
 	gen_loader_fixture_fini(&f);
 }
 
+static bool keyring_unsealed_boot(void)
+{
+	char val = 0;
+	int fd;
+
+	fd = open("/sys/module/bpf/parameters/keyring_unsealed", O_RDONLY);
+	if (fd < 0)
+		return false;
+	if (read(fd, &val, 1) != 1)
+		val = 0;
+	close(fd);
+	return val == 'Y' || val == '1';
+}
+
+static int bpf_keyring_lookup(int *nr_keys)
+{
+	char line[512], type[32], desc[64];
+	int serial = -ENOENT;
+	FILE *f;
+
+	f = fopen("/proc/keys", "r");
+	if (!f)
+		return -errno;
+
+	while (fgets(line, sizeof(line), f)) {
+		unsigned int hex;
+		char *sum;
+
+		if (sscanf(line, "%x %*s %*s %*s %*s %*s %*s %31s %63s",
+			   &hex, type, desc) != 3)
+			continue;
+		if (strcmp(type, "keyring") || strcmp(desc, ".bpf:"))
+			continue;
+
+		serial = (int)hex;
+		if (nr_keys) {
+			sum = strstr(line, ".bpf: ");
+			*nr_keys = (sum && !strncmp(sum + 6, "empty", 5)) ?
+				   0 : atoi(sum + 6);
+		}
+		break;
+	}
+	fclose(f);
+	return serial;
+}
+
+static long keyctl_ret(int cmd, unsigned long arg2, unsigned long arg3)
+{
+	long ret = syscall(__NR_keyctl, cmd, arg2, arg3);
+
+	return ret < 0 ? -errno : ret;
+}
+
+/*
+ * What the bpf keyring still needs once it is provisioned: KEY_POS_SEARCH for
+ * the in-kernel search during verification, and the user view/read bits so it
+ * stays visible in /proc/keys. Write, search and setattr are what every path
+ * that removes a key goes through, so dropping them is what makes the enrolled
+ * set final.
+ */
+#define BPF_KEYRING_PERM_LOCKED	0x08030000
+
 static void bpf_keyring_sealed(void)
 {
 	static const __u8 junk[64] = {};
@@ -665,6 +770,246 @@ static void bpf_keyring_sealed(void)
 	gen_loader_fixture_fini(&f);
 }
 
+/*
+ * This needs bpf.keyring_unsealed=1 on the guest kernel command line, which
+ * vmtest.sh can pass via KERNEL_CMDLINE_EXTRA. There is no way to unseal the
+ * keyring from here, so without it the test skips. It also only works once
+ * per boot, as restricting a keyring cannot be undone.
+ */
+static void bpf_keyring_provisioned(void)
+{
+	char dir_tmpl[] = "/tmp/bpfkeyringXXXXXX";
+	char bad_tmpl[] = "/tmp/bpfkeyringbadXXXXXX";
+	int map_fd = -1, prog_fd = -1, serial, err;
+	__u8 *sig = NULL, *bad = NULL, *buf = NULL;
+	int nr_keys = 0, der_fd = -1;
+	struct gen_loader_fixture f;
+	__u32 sig_sz = 8192, bad_sz;
+	bool have_fixture = false;
+	char *dir, *bad_dir = NULL;
+	char log_buf[1024] = {};
+	char path[PATH_MAX];
+	__u8 der[4096];
+	ssize_t der_sz;
+
+	serial = bpf_keyring_lookup(&nr_keys);
+	if (serial < 0) {
+		printf("%s:SKIP:no bpf keyring (needs CONFIG_KEYS)\n", __func__);
+		test__skip();
+		return;
+	}
+	if (nr_keys != 0) {
+		printf("%s:SKIP:the bpf keyring has already been provisioned\n",
+		       __func__);
+		test__skip();
+		return;
+	}
+
+	dir = mkdtemp(dir_tmpl);
+	if (!ASSERT_OK_PTR(dir, "mkdtemp"))
+		return;
+	if (!ASSERT_OK(run_setup("genkey", dir), "verify_sig_setup genkey"))
+		goto rmdir;
+
+	snprintf(path, sizeof(path), "%s/signing_key.der", dir);
+	der_fd = open(path, O_RDONLY);
+	if (!ASSERT_OK_FD(der_fd, "open signing_key.der"))
+		goto rmdir;
+	der_sz = read(der_fd, der, sizeof(der));
+	close(der_fd);
+	if (!ASSERT_GT(der_sz, 0, "read signing_key.der"))
+		goto rmdir;
+
+	err = syscall(__NR_add_key, "asymmetric", "", der, (size_t)der_sz,
+		      serial);
+	if (err < 0 && errno == EPERM) {
+		printf("%s:SKIP:the bpf keyring is sealed, need bpf.keyring_unsealed=1\n",
+		       __func__);
+		test__skip();
+		goto rmdir;
+	}
+	if (!ASSERT_GE(err, 0, "add the signing key to the bpf keyring"))
+		goto rmdir;
+
+	/*
+	 * Still inert at this point: the keyring is non-empty but carries no
+	 * restriction, so it is not handed out yet.
+	 */
+	sig = malloc(sig_sz);
+	if (!ASSERT_OK_PTR(sig, "sig buf"))
+		goto out;
+	have_fixture = true;
+	if (gen_loader_fixture_init(&f) != 0)
+		goto out;
+
+	buf = malloc((size_t)f.gopts.insns_sz + f.data_sz);
+	if (!ASSERT_OK_PTR(buf, "signbuf"))
+		goto out;
+	memcpy(buf, f.gopts.insns, f.gopts.insns_sz);
+	memcpy(buf + f.gopts.insns_sz, f.blob, f.data_sz);
+	if (!ASSERT_OK(sign_buf(dir, buf, f.gopts.insns_sz + f.data_sz, sig,
+				&sig_sz), "sign insns||metadata"))
+		goto out;
+
+	map_fd = setup_meta_map(&f);
+	if (!ASSERT_OK_FD(map_fd, "meta_map_unrestricted"))
+		goto out;
+	prog_fd = load_loader(f.gopts.insns, f.gopts.insns_sz, map_fd, sig,
+			      sig_sz, BPF_KEYRING_BPF, 1);
+	close(map_fd);
+	map_fd = -1;
+	ASSERT_EQ(prog_fd, -ENOKEY, "unrestricted keyring still not consulted");
+	if (prog_fd >= 0)
+		close(prog_fd);
+	prog_fd = -1;
+
+	/*
+	 * Enforcement follows the boot flag rather than the keyring's state, so
+	 * a caller-supplied keyring is already refused here, while nothing has
+	 * been provisioned yet.
+	 */
+	map_fd = setup_meta_map(&f);
+	if (!ASSERT_OK_FD(map_fd, "meta_map_session_unprovisioned"))
+		goto out;
+	prog_fd = load_loader(f.gopts.insns, f.gopts.insns_sz, map_fd, sig,
+			      sig_sz, KEY_SPEC_SESSION_KEYRING, 1);
+	close(map_fd);
+	map_fd = -1;
+	ASSERT_EQ(prog_fd, -EPERM, "caller-supplied keyring refused before provisioning");
+	if (prog_fd >= 0)
+		close(prog_fd);
+	prog_fd = -1;
+
+	/* Restricting it is what turns it on. */
+	if (!ASSERT_OK(syscall(__NR_keyctl, KEYCTL_RESTRICT_KEYRING, serial,
+			       NULL, NULL), "restrict bpf keyring"))
+		goto out;
+
+	map_fd = setup_meta_map(&f);
+	if (!ASSERT_OK_FD(map_fd, "meta_map_restricted"))
+		goto out;
+	prog_fd = load_loader(f.gopts.insns, f.gopts.insns_sz, map_fd, sig,
+			      sig_sz, BPF_KEYRING_BPF, 1);
+	close(map_fd);
+	map_fd = -1;
+	if (!ASSERT_OK_FD(prog_fd, "load signed by a key in the .bpf keyring"))
+		goto out;
+	close(prog_fd);
+	prog_fd = -1;
+
+	bad_dir = mkdtemp(bad_tmpl);
+	if (!ASSERT_OK_PTR(bad_dir, "mkdtemp unenrolled"))
+		goto out;
+	if (!ASSERT_OK(run_setup("genkey", bad_dir), "verify_sig_setup genkey unenrolled"))
+		goto out;
+	bad_sz = 8192;
+	bad = malloc(bad_sz);
+	if (!ASSERT_OK_PTR(bad, "bad sig buf"))
+		goto out;
+	if (!ASSERT_OK(sign_buf(bad_dir, buf, f.gopts.insns_sz + f.data_sz, bad,
+				&bad_sz), "sign with an unenrolled key"))
+		goto out;
+
+	map_fd = setup_meta_map(&f);
+	if (!ASSERT_OK_FD(map_fd, "meta_map_unenrolled"))
+		goto out;
+	prog_fd = load_loader_log(f.gopts.insns, f.gopts.insns_sz, map_fd, bad,
+				  bad_sz, BPF_KEYRING_BPF, 1, log_buf,
+				  sizeof(log_buf));
+	close(map_fd);
+	map_fd = -1;
+	ASSERT_EQ(prog_fd, -ENOKEY, "key outside the bpf keyring refused");
+	ASSERT_HAS_SUBSTR(log_buf, "signature verification failed",
+			  "the bpf keyring was consulted");
+	if (prog_fd >= 0)
+		close(prog_fd);
+	prog_fd = -1;
+
+	f.blob[0] ^= 0xff;
+	map_fd = setup_meta_map(&f);
+	f.blob[0] ^= 0xff;
+	if (!ASSERT_OK_FD(map_fd, "meta_map_tampered"))
+		goto out;
+	prog_fd = load_loader(f.gopts.insns, f.gopts.insns_sz, map_fd, sig,
+			      sig_sz, BPF_KEYRING_BPF, 1);
+	close(map_fd);
+	map_fd = -1;
+	ASSERT_EQ(prog_fd, -EKEYREJECTED, "tampered metadata refused");
+	if (prog_fd >= 0)
+		close(prog_fd);
+	prog_fd = -1;
+
+	map_fd = setup_meta_map(&f);
+	if (!ASSERT_OK_FD(map_fd, "meta_map_session"))
+		goto out;
+	prog_fd = load_loader(f.gopts.insns, f.gopts.insns_sz, map_fd, sig,
+			      sig_sz, KEY_SPEC_SESSION_KEYRING, 1);
+	close(map_fd);
+	map_fd = -1;
+	ASSERT_EQ(prog_fd, -EPERM, "caller-supplied keyring refused once .bpf is in use");
+	if (prog_fd >= 0)
+		close(prog_fd);
+	prog_fd = -1;
+
+	/*
+	 * The restriction bounds what can be added and not what can be taken
+	 * away, so the keyring is still writable here. Probe it with a key that
+	 * is not a member: the permission check on the keyring is what is under
+	 * test, and -ENOENT means it passed and only the removal itself did not
+	 * find anything.
+	 */
+	err = keyctl_ret(KEYCTL_UNLINK, KEY_SPEC_SESSION_KEYRING, serial);
+	ASSERT_EQ(err, -ENOENT, "keyring writable while the user bits are there");
+
+	/* Dropping the bits it no longer needs is what makes the set final. */
+	err = keyctl_ret(KEYCTL_SETPERM, serial, BPF_KEYRING_PERM_LOCKED);
+	if (!ASSERT_OK(err, "drop the user bits on the bpf keyring"))
+		goto out;
+
+	/* Verification runs on KEY_POS_SEARCH, so a load is unaffected. */
+	map_fd = setup_meta_map(&f);
+	if (!ASSERT_OK_FD(map_fd, "meta_map_locked"))
+		goto out;
+	prog_fd = load_loader(f.gopts.insns, f.gopts.insns_sz, map_fd, sig,
+			      sig_sz, BPF_KEYRING_BPF, 1);
+	close(map_fd);
+	map_fd = -1;
+	ASSERT_OK_FD(prog_fd, "load still verified against the locked keyring");
+	if (prog_fd >= 0)
+		close(prog_fd);
+	prog_fd = -1;
+
+	err = keyctl_ret(KEYCTL_UNLINK, KEY_SPEC_SESSION_KEYRING, serial);
+	ASSERT_EQ(err, -EACCES, "unlink refused");
+	err = keyctl_ret(KEYCTL_CLEAR, serial, 0);
+	ASSERT_EQ(err, -EACCES, "clear refused");
+	err = keyctl_ret(KEYCTL_REVOKE, serial, 0);
+	ASSERT_EQ(err, -EACCES, "revoke refused");
+	err = keyctl_ret(KEYCTL_INVALIDATE, serial, 0);
+	ASSERT_EQ(err, -EACCES, "invalidate refused");
+	err = keyctl_ret(KEYCTL_SET_TIMEOUT, serial, 1);
+	ASSERT_EQ(err, -EACCES, "timeout refused");
+	err = keyctl_ret(KEYCTL_SETPERM, serial, 0x082f0000);
+	ASSERT_EQ(err, -EACCES, "the bits cannot be granted back");
+
+	/* Nothing above got through: the keyring still holds its one key. */
+	ASSERT_EQ(bpf_keyring_lookup(&nr_keys), serial, "keyring still there");
+	ASSERT_EQ(nr_keys, 1, "the enrolled key survived");
+out:
+	if (prog_fd >= 0)
+		close(prog_fd);
+	if (map_fd >= 0)
+		close(map_fd);
+	if (have_fixture)
+		gen_loader_fixture_fini(&f);
+	genkey_dir_fini(bad_dir);
+	free(buf);
+	free(bad);
+	free(sig);
+rmdir:
+	genkey_dir_fini(dir);
+}
+
 /*
  * A signed loader must ignore ctx-supplied map dimensions: the host cannot
  * resize a signed program's maps via the loader ctx. Drive a one-map program
@@ -1899,6 +2244,11 @@ static void signed_module_kfunc_rejected(void)
 
 void test_signed_loader(void)
 {
+	if (keyring_unsealed_boot()) {
+		if (test__start_subtest("bpf_keyring_provisioned"))
+			bpf_keyring_provisioned();
+		return;
+	}
 	if (test__start_subtest("loadtime_no_map"))
 		loadtime_no_map();
 	if (test__start_subtest("loadtime_with_map"))
-- 
2.43.0

