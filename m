Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A6E2F7EE4
	for <bpf@vger.kernel.org>; Fri,  5 Jun 2026 21:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780695324; cv=none; b=f0iskx2StJm3AhZFwssuLnsHR40OG4hbr2viLNkpQvhi39pqkxkWhPiZgUZ55r9wYgeC8cQWFTEUIsaR7uD72SksawdDOg0b0HcYgM0bsqAArj20HW0Bu0hVhiv2OgwZ8xcRhgTRsZscBkW2Ey9MiXaC6prdY9SgxK5NEFxus/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780695324; c=relaxed/simple;
	bh=Xp67M6WX6K83Z6+zQT/0NLitMopXlLMe6lbHDN0RM5s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sLqCGQeYBddbuxhiPMm59TMGia99UApU6qy7ST1u6MWN6fLeayai20qIDq96F2FzPnzo7IPjPeZtJJPckfgX41+oLGi+tlXVFHbsVXwH7ZIyZgp6HZvEx1xKxqoliy1sK98VHYDdtYSAS4z4tYxrIMBsDTlZWB6zIxe2ll/yv6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=KXyEQ/Yq; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="KXyEQ/Yq"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=0+JrPZoZQJEDySfO9VMwUCCBFlpSZvpXhJWm1Zc4Qk8=; b=KXyEQ/YqorIm6/WhbbUprxg49z
	VYTyzvUAT2KHqeMT/PqFzxDOAdyC0dl1udYEpB6E99HRRtesaCsQ2rS62A2JWwYK5hY5M0cm1+9qJ
	QIiejH4w3krwVguXj4cN8WcbuR4apf3ELJWY/Z2EU8JyAcptJohM9ZaL7QQsfM1LFkEGBjjohJ1jX
	OATunrsd43Q8OEElBXlbq5GaXic5owMrSRbnPnqc9Vpw9DABCiWjrfwM1O8uZHgt22S2XGuCmSjph
	0FJb+SaLCdd2ziLWYFDXh5RXJHxYLyxjcl1LvihHztCdCg5zzTa4/o431zt9LEYUdn00fz1OYNGzX
	X0aE5Zcg==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1wVcCF-00026Y-1g;
	Fri, 05 Jun 2026 23:35:19 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: bpf@vger.kernel.org
Cc: kpsingh@kernel.org,
	ast@kernel.org
Subject: [PATCH bpf-next 2/2] selftests/bpf: Inspect the signature verdict exposed to BPF LSM
Date: Fri,  5 Jun 2026 23:35:18 +0200
Message-ID: <20260605213518.544262-2-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260605213518.544262-1-daniel@iogearbox.net>
References: <20260605213518.544262-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28022/Fri Jun  5 08:25:05 2026)

Add a minimal BPF LSM program on lsm/bpf_prog_load that, for loads on
the monitored thread, reads back prog->aux->sig.{verdict,keyring_type,
keyring_serial}, and a signed_loader subtest that drives the same
gen_loader loader through the hook twice: i) /unsigned/ where the LSM
must observe UNSIGNED, no keyring and serial 0; ii) /signed/ where the
very same insns signed against the session keyring must be observed as
VERIFIED with a user keyring, and the recorded keyring_serial must be
equal to the resolved session keyring serial. Loading (not running) the
loader is sufficient since the verdict is attached at load time.

  # LDLIBS=-static PKG_CONFIG='pkg-config --static' ./vmtest.sh -- ./test_progs -t signed_loader
  [    1.970530] clocksource: Switched to clocksource tsc
  #405/1   signed_loader/metadata_check_shape:OK
  #405/2   signed_loader/metadata_match:OK
  #405/3   signed_loader/metadata_sha_mismatch:OK
  #405/4   signed_loader/metadata_not_exclusive:OK
  #405/5   signed_loader/metadata_hash_not_computed:OK
  #405/6   signed_loader/signature_enforced:OK
  #405/7   signed_loader/signature_too_large:OK
  #405/8   signed_loader/signature_bad_keyring:OK
  #405/9   signed_loader/metadata_ctx_max_entries_ignored:OK
  #405/10  signed_loader/metadata_ctx_initial_value_ignored:OK
  #405/11  signed_loader/signature_authenticates_insns:OK
  #405/12  signed_loader/hash_requires_frozen:OK
  #405/13  signed_loader/no_update_after_freeze:OK
  #405/14  signed_loader/freeze_writable_mmap:OK
  #405/15  signed_loader/no_writable_mmap_frozen:OK
  #405/16  signed_loader/map_hash_matches_libbpf:OK
  #405/17  signed_loader/map_hash_multi_element:OK
  #405/18  signed_loader/map_hash_bad_size:OK
  #405/19  signed_loader/map_hash_unsupported_type:OK
  #405/20  signed_loader/lsm_signature_verdict:OK
  #405     signed_loader:OK
  Summary: 1/20 PASSED, 0 SKIPPED, 0 FAILED

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 .../selftests/bpf/prog_tests/signed_loader.c  | 122 ++++++++++++++++++
 .../bpf/progs/test_signed_loader_lsm.c        |  30 +++++
 2 files changed, 152 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/test_signed_loader_lsm.c

diff --git a/tools/testing/selftests/bpf/prog_tests/signed_loader.c b/tools/testing/selftests/bpf/prog_tests/signed_loader.c
index dcfdd2d96b05..5fc417e31fc6 100644
--- a/tools/testing/selftests/bpf/prog_tests/signed_loader.c
+++ b/tools/testing/selftests/bpf/prog_tests/signed_loader.c
@@ -17,9 +17,23 @@
 #include "test_signed_loader.skel.h"
 #include "test_signed_loader_map.skel.h"
 #include "test_signed_loader_data.skel.h"
+#include "test_signed_loader_lsm.skel.h"
 
 #define SIG_MATCH_INSNS 33 /* excl (5) + 4 * sha-dword (7) */
 
+enum {
+	BPF_SIG_UNSIGNED = 0,
+	BPF_SIG_VERIFIED,
+};
+
+enum {
+	BPF_SIG_KEYRING_NONE = 0,
+	BPF_SIG_KEYRING_BUILTIN,
+	BPF_SIG_KEYRING_SECONDARY,
+	BPF_SIG_KEYRING_PLATFORM,
+	BPF_SIG_KEYRING_USER,
+};
+
 static int load_loader(const void *insns, __u32 insns_sz, int map_fd,
 		       const void *sig, __u32 sig_sz, __s32 keyring_id)
 {
@@ -970,6 +984,112 @@ static void map_hash_unsupported_type(void)
 	close(fd);
 }
 
+static int setup_meta_map(const struct gen_loader_fixture *f)
+{
+	LIBBPF_OPTS(bpf_map_create_opts, mopts,
+		    .excl_prog_hash = f->excl,
+		    .excl_prog_hash_size = sizeof(f->excl));
+	__u32 key = 0;
+	int fd;
+
+	fd = bpf_map_create(BPF_MAP_TYPE_ARRAY, "__loader.map", 4,
+			    f->data_sz, 1, &mopts);
+	if (fd < 0)
+		return -errno;
+	if (bpf_map_update_elem(fd, &key, f->blob, 0) || bpf_map_freeze(fd)) {
+		close(fd);
+		return -errno;
+	}
+	return fd;
+}
+
+static void lsm_signature_verdict(void)
+{
+	char dir_tmpl[] = "/tmp/signed_loader_lsmXXXXXX", *dir = NULL;
+	struct test_signed_loader_lsm *lsm = NULL;
+	int map_fd = -1, prog_fd = -1;
+	bool have_fixture = false;
+	struct gen_loader_fixture f;
+	__u32 sig_sz = 8192;
+	__s32 ses_serial;
+	__u8 sig[8192];
+
+	lsm = test_signed_loader_lsm__open_and_load();
+	if (!ASSERT_OK_PTR(lsm, "lsm_skel_load"))
+		return;
+	lsm->bss->monitored_tid = sys_gettid();
+	if (!ASSERT_OK(test_signed_loader_lsm__attach(lsm), "lsm_attach"))
+		goto out;
+
+	have_fixture = true;
+	if (gen_loader_fixture_init(&f) != 0)
+		goto out;
+
+	map_fd = setup_meta_map(&f);
+	if (!ASSERT_OK_FD(map_fd, "meta_map_unsigned"))
+		goto out;
+	lsm->bss->seen = 0;
+	prog_fd = load_loader(f.gopts.insns, f.gopts.insns_sz, map_fd, NULL, 0, 0);
+	close(map_fd);
+	map_fd = -1;
+	if (!ASSERT_OK_FD(prog_fd, "unsigned loader load"))
+		goto out;
+	close(prog_fd);
+	prog_fd = -1;
+	if (!ASSERT_NEQ(lsm->bss->seen, 0, "bpf LSM in the active LSM set"))
+		goto out;
+	ASSERT_EQ(lsm->bss->seen, 1, "unsigned: one observed load");
+	ASSERT_EQ(lsm->bss->sig_verdict, BPF_SIG_UNSIGNED, "unsigned verdict");
+	ASSERT_EQ(lsm->bss->sig_keyring_type, BPF_SIG_KEYRING_NONE, "unsigned keyring type");
+	ASSERT_EQ(lsm->bss->sig_keyring_serial, 0, "unsigned: no keyring serial");
+
+	syscall(__NR_request_key, "keyring", "_uid.0", NULL,
+		KEY_SPEC_SESSION_KEYRING);
+	dir = mkdtemp(dir_tmpl);
+	if (!ASSERT_OK_PTR(dir, "mkdtemp"))
+		goto out;
+	if (!ASSERT_OK(run_setup("setup", dir), "verify_sig_setup")) {
+		rmdir(dir);
+		dir = NULL;
+		goto out;
+	}
+	if (!ASSERT_OK(sign_buf(dir, f.gopts.insns, f.gopts.insns_sz, sig,
+				&sig_sz), "sign-file"))
+		goto out;
+
+	map_fd = setup_meta_map(&f);
+	if (!ASSERT_OK_FD(map_fd, "meta_map_signed"))
+		goto out;
+	lsm->bss->seen = 0;
+	prog_fd = load_loader(f.gopts.insns, f.gopts.insns_sz, map_fd, sig,
+			      sig_sz, KEY_SPEC_SESSION_KEYRING);
+	close(map_fd);
+	map_fd = -1;
+	if (!ASSERT_OK_FD(prog_fd, "signed loader load"))
+		goto out;
+	close(prog_fd);
+	prog_fd = -1;
+
+	ses_serial = syscall(__NR_keyctl, KEYCTL_GET_KEYRING_ID,
+			     KEY_SPEC_SESSION_KEYRING, 0);
+	ASSERT_EQ(lsm->bss->seen, 1, "signed: one observed load");
+	ASSERT_EQ(lsm->bss->sig_verdict, BPF_SIG_VERIFIED, "signed verdict");
+	ASSERT_EQ(lsm->bss->sig_keyring_type, BPF_SIG_KEYRING_USER, "signed keyring type");
+	ASSERT_GT(ses_serial, 0, "session keyring serial resolved");
+	ASSERT_EQ(lsm->bss->sig_keyring_serial, ses_serial,
+		  "signed: validated against session keyring");
+out:
+	if (map_fd >= 0)
+		close(map_fd);
+	if (prog_fd >= 0)
+		close(prog_fd);
+	if (have_fixture)
+		gen_loader_fixture_fini(&f);
+	if (dir)
+		run_setup("cleanup", dir);
+	test_signed_loader_lsm__destroy(lsm);
+}
+
 void test_signed_loader(void)
 {
 	if (test__start_subtest("metadata_check_shape"))
@@ -1010,4 +1130,6 @@ void test_signed_loader(void)
 		map_hash_bad_size();
 	if (test__start_subtest("map_hash_unsupported_type"))
 		map_hash_unsupported_type();
+	if (test__start_subtest("lsm_signature_verdict"))
+		lsm_signature_verdict();
 }
diff --git a/tools/testing/selftests/bpf/progs/test_signed_loader_lsm.c b/tools/testing/selftests/bpf/progs/test_signed_loader_lsm.c
new file mode 100644
index 000000000000..575a9b7910c8
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/test_signed_loader_lsm.c
@@ -0,0 +1,30 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+char _license[] SEC("license") = "GPL";
+
+__u32 monitored_tid;
+
+int sig_keyring_serial;
+int sig_keyring_type;
+int sig_verdict;
+int seen;
+
+SEC("lsm/bpf_prog_load")
+int BPF_PROG(inspect_prog_load, struct bpf_prog *prog, union bpf_attr *attr,
+	     struct bpf_token *token, bool kernel)
+{
+	__u32 tid = bpf_get_current_pid_tgid() & 0xffffffff;
+
+	if (!monitored_tid || tid != monitored_tid)
+		return 0;
+
+	seen++;
+	sig_keyring_serial = prog->aux->sig.keyring_serial;
+	sig_keyring_type = prog->aux->sig.keyring_type;
+	sig_verdict = prog->aux->sig.verdict;
+	return 0;
+}
-- 
2.43.0

