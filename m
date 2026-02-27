Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 582EA362123;
	Fri, 27 Feb 2026 08:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772179740; cv=none; b=f5AO61ne3V83mNY002SH+dC55GjkGLVSh7ZiCMqumN1izOW1KadgPt4O5+NVg7XQugsbsgrKcOJ+4wS7Dy99vzvFG+W8ZI6eWfTdOPeYbZLuHIFbj9sK6KRrSp4JhT4tfNY7kew4MsjcESq8wYh6EpNBziyFESaimyAOvHRCMmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772179740; c=relaxed/simple;
	bh=Ra+7uSEKUe/YRs6QG1AyLjWES679g68JqReVroqPfds=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=QcyBUuptVmuDehgAr11Jx4drhZ83zP8SbRhafDozGpSV/Toqqk8CpgD8GqsEuBhWVl6clgOPQxb8PS4hMibRi2jgu8qcmTqfVnrynymXvDhS9N72dA/6Xf6cN/tJt/tXS/nBf/CWarImtPgTX+VJyBE2Yg8cBsetTtgOCaUe1Dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=giydexke; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="giydexke"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id F01674E412D9;
	Fri, 27 Feb 2026 08:08:57 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id B07B35FE46;
	Fri, 27 Feb 2026 08:08:57 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 26219103692C2;
	Fri, 27 Feb 2026 09:08:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1772179736; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=e1qepm3/81bAP1at3d4tm6Ugpy5U7kTJ/s1FwYeo+vA=;
	b=giydexkeHEJhQjDbDIZyFv430jONfagdw6kLXa5IENzr4OhdcNm4S/IkPfe3Rkzjlnbemt
	/2R4yUsR9hRZUJZVrRruhtXcW9NYyUVCmjIOo30MhAAiS3t4E3GrIbj+08ycLJXvPrwWsW
	24VOgKGfnbYz9nlrdBreEi8lGg2qDFEW2fFsOHs3IBAWHnIiw+FONAtCq7OupZkL+K0wWu
	lQuS7zzzLt9h+Un6ePUY23jOKJ0hgZ4t79swInbqJcN3cU3LuHb8EZYvaNICj7MlmCUX9z
	BYt2ro1ImMnuVJMGJxI37awYJjTTy4F2qTwVUs/FIy+nfeJkle0Ho6SSv/NCMg==
From: =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Date: Fri, 27 Feb 2026 09:08:47 +0100
Subject: [PATCH bpf-next] selftests/bpf: drop test_bpftool.sh
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260227-bpftool_feature-v1-1-a25860fd52fb@bootlin.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2MQQqAIBAAvxJ7TnBFEvpKRJSttRAqahFEf086D
 szMA5kSU4a+eSDRxZmDr4BtA3af/UaC18qgpOqkQhRLdCWEY3I0lzOR6DSiXqw1RkuoVUzk+P6
 PA1RZeLoLjO/7AebUbMFrAAAA
X-Change-ID: 20260211-bpftool_feature-64114bcc7740
To: Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: ebpf@linuxfoundation.org, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

The test_bpftool.sh script runs a python unittest script checking
bpftool json output on different commands. As part of the ongoing effort
to get rid of any standalone test, this script should either be
converted to test_progs or removed.

As validating bpftool json output does not bring much value to the test
base (and because it would need test_progs to bring in a json parser),
remove the standalone test script.

Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>
---
This removal follows the discussion in [1]

[1] https://lore.kernel.org/bpf/DGOTPHTTR5ZE.Q7ALRR86ZZ6N@bootlin.com/
---
 tools/testing/selftests/bpf/Makefile        |   4 +-
 tools/testing/selftests/bpf/test_bpftool.py | 174 ----------------------------
 tools/testing/selftests/bpf/test_bpftool.sh |  11 --
 3 files changed, 1 insertion(+), 188 deletions(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index c6bf4dfb1495..c3e1116b146e 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -107,14 +107,12 @@ TEST_PROGS := test_kmod.sh \
 	test_lirc_mode2.sh \
 	test_xdping.sh \
 	test_bpftool_build.sh \
-	test_bpftool.sh \
 	test_doc_build.sh \
 	test_xsk.sh \
 	test_xdp_features.sh
 
 TEST_PROGS_EXTENDED := \
-	ima_setup.sh verify_sig_setup.sh \
-	test_bpftool.py
+	ima_setup.sh verify_sig_setup.sh
 
 TEST_KMODS := bpf_testmod.ko bpf_test_no_cfi.ko bpf_test_modorder_x.ko \
 	bpf_test_modorder_y.ko bpf_test_rqspinlock.ko
diff --git a/tools/testing/selftests/bpf/test_bpftool.py b/tools/testing/selftests/bpf/test_bpftool.py
deleted file mode 100644
index 1c2408ee1f5d..000000000000
--- a/tools/testing/selftests/bpf/test_bpftool.py
+++ /dev/null
@@ -1,174 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0
-# Copyright (c) 2020 SUSE LLC.
-
-import collections
-import functools
-import json
-import os
-import socket
-import subprocess
-import unittest
-
-
-# Add the source tree of bpftool and /usr/local/sbin to PATH
-cur_dir = os.path.dirname(os.path.realpath(__file__))
-bpftool_dir = os.path.abspath(os.path.join(cur_dir, "..", "..", "..", "..",
-                                           "tools", "bpf", "bpftool"))
-os.environ["PATH"] = bpftool_dir + ":/usr/local/sbin:" + os.environ["PATH"]
-
-
-class IfaceNotFoundError(Exception):
-    pass
-
-
-class UnprivilegedUserError(Exception):
-    pass
-
-
-def _bpftool(args, json=True):
-    _args = ["bpftool"]
-    if json:
-        _args.append("-j")
-    _args.extend(args)
-
-    return subprocess.check_output(_args)
-
-
-def bpftool(args):
-    return _bpftool(args, json=False).decode("utf-8")
-
-
-def bpftool_json(args):
-    res = _bpftool(args)
-    return json.loads(res)
-
-
-def get_default_iface():
-    for iface in socket.if_nameindex():
-        if iface[1] != "lo":
-            return iface[1]
-    raise IfaceNotFoundError("Could not find any network interface to probe")
-
-
-def default_iface(f):
-    @functools.wraps(f)
-    def wrapper(*args, **kwargs):
-        iface = get_default_iface()
-        return f(*args, iface, **kwargs)
-    return wrapper
-
-DMESG_EMITTING_HELPERS = [
-        "bpf_probe_write_user",
-        "bpf_trace_printk",
-        "bpf_trace_vprintk",
-    ]
-
-class TestBpftool(unittest.TestCase):
-    @classmethod
-    def setUpClass(cls):
-        if os.getuid() != 0:
-            raise UnprivilegedUserError(
-                "This test suite needs root privileges")
-
-    @default_iface
-    def test_feature_dev_json(self, iface):
-        unexpected_helpers = DMESG_EMITTING_HELPERS
-        expected_keys = [
-            "syscall_config",
-            "program_types",
-            "map_types",
-            "helpers",
-            "misc",
-        ]
-
-        res = bpftool_json(["feature", "probe", "dev", iface])
-        # Check if the result has all expected keys.
-        self.assertCountEqual(res.keys(), expected_keys)
-        # Check if unexpected helpers are not included in helpers probes
-        # result.
-        for helpers in res["helpers"].values():
-            for unexpected_helper in unexpected_helpers:
-                self.assertNotIn(unexpected_helper, helpers)
-
-    def test_feature_kernel(self):
-        test_cases = [
-            bpftool_json(["feature", "probe", "kernel"]),
-            bpftool_json(["feature", "probe"]),
-            bpftool_json(["feature"]),
-        ]
-        unexpected_helpers = DMESG_EMITTING_HELPERS
-        expected_keys = [
-            "syscall_config",
-            "system_config",
-            "program_types",
-            "map_types",
-            "helpers",
-            "misc",
-        ]
-
-        for tc in test_cases:
-            # Check if the result has all expected keys.
-            self.assertCountEqual(tc.keys(), expected_keys)
-            # Check if unexpected helpers are not included in helpers probes
-            # result.
-            for helpers in tc["helpers"].values():
-                for unexpected_helper in unexpected_helpers:
-                    self.assertNotIn(unexpected_helper, helpers)
-
-    def test_feature_kernel_full(self):
-        test_cases = [
-            bpftool_json(["feature", "probe", "kernel", "full"]),
-            bpftool_json(["feature", "probe", "full"]),
-        ]
-        expected_helpers = DMESG_EMITTING_HELPERS
-
-        for tc in test_cases:
-            # Check if expected helpers are included at least once in any
-            # helpers list for any program type. Unfortunately we cannot assume
-            # that they will be included in all program types or a specific
-            # subset of programs. It depends on the kernel version and
-            # configuration.
-            found_helpers = False
-
-            for helpers in tc["helpers"].values():
-                if all(expected_helper in helpers
-                       for expected_helper in expected_helpers):
-                    found_helpers = True
-                    break
-
-            self.assertTrue(found_helpers)
-
-    def test_feature_kernel_full_vs_not_full(self):
-        full_res = bpftool_json(["feature", "probe", "full"])
-        not_full_res = bpftool_json(["feature", "probe"])
-        not_full_set = set()
-        full_set = set()
-
-        for helpers in full_res["helpers"].values():
-            for helper in helpers:
-                full_set.add(helper)
-
-        for helpers in not_full_res["helpers"].values():
-            for helper in helpers:
-                not_full_set.add(helper)
-
-        self.assertCountEqual(full_set - not_full_set,
-                              set(DMESG_EMITTING_HELPERS))
-        self.assertCountEqual(not_full_set - full_set, set())
-
-    def test_feature_macros(self):
-        expected_patterns = [
-            r"/\*\*\* System call availability \*\*\*/",
-            r"#define HAVE_BPF_SYSCALL",
-            r"/\*\*\* eBPF program types \*\*\*/",
-            r"#define HAVE.*PROG_TYPE",
-            r"/\*\*\* eBPF map types \*\*\*/",
-            r"#define HAVE.*MAP_TYPE",
-            r"/\*\*\* eBPF helper functions \*\*\*/",
-            r"#define HAVE.*HELPER",
-            r"/\*\*\* eBPF misc features \*\*\*/",
-        ]
-
-        res = bpftool(["feature", "probe", "macros"])
-        for pattern in expected_patterns:
-            self.assertRegex(res, pattern)
diff --git a/tools/testing/selftests/bpf/test_bpftool.sh b/tools/testing/selftests/bpf/test_bpftool.sh
deleted file mode 100755
index 718f59692ccb..000000000000
--- a/tools/testing/selftests/bpf/test_bpftool.sh
+++ /dev/null
@@ -1,11 +0,0 @@
-#!/bin/bash
-# SPDX-License-Identifier: GPL-2.0
-# Copyright (c) 2020 SUSE LLC.
-
-# 'make -C tools/testing/selftests/bpf install' will install to SCRIPT_DIR
-SCRIPT_DIR=$(dirname $(realpath $0))
-
-# 'make -C tools/testing/selftests/bpf' will install to BPFTOOL_INSTALL_PATH
-BPFTOOL_INSTALL_PATH="$SCRIPT_DIR"/tools/sbin
-export PATH=$SCRIPT_DIR:$BPFTOOL_INSTALL_PATH:$PATH
-python3 -m unittest -v test_bpftool.TestBpftool

---
base-commit: 2294d0a45832f16cc20e9c1431165b4e0eb69bcb
change-id: 20260211-bpftool_feature-64114bcc7740

Best regards,
-- 
Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>

